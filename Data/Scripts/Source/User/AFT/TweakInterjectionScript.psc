Scriptname AFT:TweakInterjectionScript extends Quest
{Causes active companions to speak lines when phases of certain scenes are reached}

; Rather than trying to micromanage all the onENd events to clean up (and possibly miss stuff)
; We use a broader approach. When the game loads, TweakInjectionQuestScript calls UnRegisterInterjections()
; to unregister everything and then RegisterInterjections() to re-evaluate game state and register stuff.
; So basically registration cleanup occures when someone loads a save game.
 
struct InterjectionInfo

	Quest ParentQuest = None
	{ Quest parent of scene (can't register for phases until parent is running) }

	Int   StartStage = 0
	{ If this scene is done (and ExpirationStage is not) then Register. }
	
	Int   ExpirationStage = 0
	{ If set and stage is done, do not re-register  }

	Scene ParentScene = None
	{ The scene that we want to interject upon. }

	Int EndPhase = -1
	{ Optional int value of Phase to PAUSE when it ENDS. This SHOULD have a value unless BeginPhase has a value. }
	
	Int Choice1ID = -1
	{ Optional int based TopicInfo ID. These can be found by looking at the Player Dialogue Action and get the IDs from the topic lists.  Leave blank/-1 if comment does not depend on Player response. }

	Int Choice2ID = -1
	{ Optional int based TopicInfo ID }

	Int Choice3ID = -1
	{ Optional int based TopicInfo ID }

	Int Choice4ID = -1
	{ Optional int based TopicInfo ID }
	
	Int Topic1ID = -1
	{ Required int based default Topic ID. Normally requires FO4Edit to figure this out. }

	Int Topic2ID = -1
	{ Optional int based alt Topic ID }

	Int Topic3ID = -1 
	{ Optional int based alt Topic ID }

	Int Topic4ID = -1 
	{ Optional int based alt Topic ID }

	Int Spouse1ID = -1
	{ Required int based default Topic ID. Normally requires FO4Edit to figure this out. }

	Int Spouse2ID = -1
	{ Optional int based alt Topic ID }

	Int Spouse3ID = -1 
	{ Optional int based alt Topic ID }

	Int Spouse4ID = -1 
	{ Optional int based alt Topic ID }
	
	ActorBase FinalCameraTarget = None
	{ Optional Scene Actor to return camera to. Must be unique. Center Speaker Camera option is ignored unless this is filled in.}

	Int ParentSceneID = 0
	{ Optional Int based scene ID }

	Int BeginPhase = -1
	{ Optional int value of Phase to PAUSE when it BEGINS. }
	
endStruct

struct InterjectionPersist
	Scene _theScene    = None  	
	Bool  _registered  = false 
	Bool  _processed   = false 
endStruct

Group Setup

	Quest Property EpisodeQuest = None Auto const 
	{ Optional Major Quest Episode that determines when Settings are loaded. IE: BoS301, BoS302, BoS303 }

	Int Property EpisodeQuestStage = 0 Auto const 
	{ Optional Major Quest Episode that determines when Settings are loaded. IE: BoS301, BoS302, BoS303 }
	
	String Property ExternalFile Auto const
	{ Name of esp/esm of ID's > 0x00ffffff }

	InterjectionInfo[] property Settings Auto Const
	
	String property LogName = "TweakInjectionScript" Auto Const

	
endGroup

; Local Private Storage
InterjectionPersist[] Persisted
Bool Registered = false
Bool RegisteredEpisode = false
float prevAllowLoiter = 2.0

Group AutoFill
	Quest Property pTweakFollower						Auto Const
	GlobalVariable Property pTweakAllowLoiter			Auto Const
	GlobalVariable Property pTweakInterjectCenter		Auto Const
	GlobalVariable Property pTweakInterjectSubtitles	Auto Const
	ActorBase Property TweakCompanionNate				Auto Const
	ActorBase Property TweakCompanionNora				Auto Const
	SoundCategorySnapShot Property TweakCSInterjection	Auto Const
	GlobalVariable Property pTweakIgnoreAffinity		Auto Const	
endGroup

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	debug.OpenUserLog(LogName)
	RETURN debug.TraceUser(LogName, asTextToPrint, aiSeverity)
EndFunction

; Called from TweakInterjectionQuestScript
; cqf TweakInterjections "AFT:TweakDiamondInterjections.RegisterInterjections"
Function RegisterInterjections()

	Trace("RegisterInterjections() called")
	RegisteredEpisode = false
	Registered = false

	if Persisted && Persisted.Length > 0
		Persisted.Clear()
	endif

	int p = 0
	int plen = Settings.length
	Persisted = new InterjectionPersist[plen]
	while (p < plen)
		Persisted[p] = new InterjectionPersist
		p += 1
	endwhile
	
	if !EpisodeQuest.IsRunning()
		if 0 == EpisodeQuest.GetCurrentStageID()
			Trace("  Registering for remote event [" + EpisodeQuest + "] -> OnQuestInit")			
			RegisterForRemoteEvent(EpisodeQuest,"OnQuestInit")
			return
		else
			Trace("  Episode Quest [" + EpisodeQuest + "] Already completed (No Delay).")
		endif
	elseif EpisodeQuestStage > 0
		RegisteredEpisode = true
		if !EpisodeQuest.GetStageDone(EpisodeQuestStage)
			Trace("  Registering for remote event [" + EpisodeQuest + "] -> OnStageSet")			
			RegisterForRemoteEvent(EpisodeQuest,"OnStageSet")
			return
		else
			Trace("  Quest [" + EpisodeQuest + "] Stage [" + EpisodeQuestStage + "] Already completed (No Delay).")
		endif
	else
		Trace("  Quest [" + EpisodeQuest + "] Stage [0] Already completed (No Delay).")
	endif
		
	; If we get here, The Episode Gate (register delay) has already passed....
	RegisterInterjectionInfo()
	
EndFunction

Function RegisterInterjectionInfo()
	Trace("RegisterInterjectionInfo Called. Episode Quest [" + EpisodeQuest + "] Episode Stage = [" + EpisodeQuestStage + "]")
	RegisteredEpisode = true
	Registered = true

	int i = 0
	int numquests = Settings.length
	while i < numquests
		RegisterInterjectionInfoHelper(i)	
		i += 1
	endwhile
		
EndFunction

; One of fout outcomes:
; - We register for an OnQuestInit event if the parent quest hasn't ran yet
; - We register for an OnStageSet event if the parent quest is running but hasn't reaches the StartStage yet
; - We register the scenes if we are within the window (StartStage <= CurrentStage <= ExprationStage)
; - We skip the index because we are outside the window, the quest has finished or something is missing
Function RegisterInterjectionInfoHelper(int infoindex)
	Trace("RegisterInterjectionInfoHelper Called")
	InterjectionInfo info    = Settings[infoindex]
	if (!info.ParentQuest)
		Trace("  Bailing. No Quest Information")
		Persisted[infoindex]._processed = true
		return
	endif
	
	if (!info.ParentScene && 0 == info.ParentSceneID)
		Trace("  Bailing. No Scene Information")
		Persisted[infoindex]._processed = true
		return
	endif

	if !info.ParentQuest.IsRunning()
		if 0 == info.ParentQuest.GetCurrentStageID()
			Trace("  Registering for remote event [" + info.ParentQuest + "] -> OnQuestInit")			
			RegisterForRemoteEvent(info.ParentQuest,"OnQuestInit")
		else
			Trace("  Quest [" + info.ParentQuest + "]. Already completed. Skipping Registration")
			Persisted[infoindex]._processed = true
		endif
	elseif (0 == info.StartStage)
	
		; Start Game Enabled Quests are a bit different. We default to register them unless 
		; they have an expiration. Also note the use of GetStageDone instead of GetCurrentStageID()
		; GetCurrentStageID returns the highest number where as GetStageDone is specific.
		
		if (0 == info.ExpirationStage)
			Trace("  Register Start Game Enabled Quest Scenes [" + info.ParentQuest + "]")			
			RegisterScenes(info.ParentQuest, 0)
		elseif (!info.ParentQuest.GetStageDone(info.ExpirationStage))
			Trace("  Register Start Game Enabled Quest Scenes [" + info.ParentQuest + "]")
			RegisterScenes(info.ParentQuest, 0)
		else
			Trace("  Skipping Start Game Enabled Quest Scenes [" + info.ParentQuest + "] End Quest complete: [" + info.ExpirationStage + "]")
			Persisted[infoindex]._processed = true
		endif
		
	else ; info.StartStage > 0

		; Non-Start Game Enabled Quests default to not being registered unless a non-zero window is
		; defined and the CURRENT (highest) stage is within the window. 
	
		if !info.ParentQuest.GetStageDone(info.StartStage)
			Trace("  Registering for remote event [" + info.ParentQuest + "] -> OnStageSet")			
			RegisterForRemoteEvent(info.ParentQuest,"OnStageSet")
		elseif (0 == info.ExpirationStage)
			Trace("  Quest [" + info.ParentQuest + "] Stage [" + info.ParentQuest.GetCurrentStageID() + "] outside window [" + info.StartStage +"] => [" + info.StartStage + "]. Skipping")
			Persisted[infoindex]._processed = true
		elseif (info.ParentQuest.GetCurrentStageID() <= info.ExpirationStage)
			Trace("  Registering Scenes for Quest [" + info.ParentQuest + "]. Within Window [" + info.StartStage +"] => [" + info.ExpirationStage + "]")
			RegisterScenes(info.ParentQuest, info.StartStage)
		else
			Trace("  Quest [" + info.ParentQuest + "] Stage [" + info.ParentQuest.GetCurrentStageID() + "] outside window [" + info.StartStage +"] => [" + info.ExpirationStage + "]. Skipping")
			Persisted[infoindex]._processed = true
		endif
	endif
	
EndFunction

Function RegisterScenes(Quest auiQuest, int auiStageID)

	InterjectionInfo info	
	InterjectionPersist persist
	int lastindex    = (Settings.length - 1)
	int lookupparent = Settings.FindStruct("ParentQuest",auiQuest)
		
	while (lookupparent != -1)
		info = Settings[lookupparent]
		persist = Persisted[lookupparent]
		if info.StartStage == auiStageID && !persist._registered && !persist._processed
			Scene theScene = info.ParentScene
			if !theScene
				; Try using the Scene ID if supplied as a backup....
				if info.ParentSceneID > 0x00ffffff
					theScene = Game.GetFormFromFile(info.ParentSceneID,ExternalFile) as Scene
				else
					theScene = Game.GetForm(info.ParentSceneID) as Scene
				endIf
			endif
			
			if theScene
				Trace("  Registering for remote event [" + theScene + "] -> OnBegin")			
				Persisted[lookupparent]._theScene = theScene
				RegisterForRemoteEvent(theScene, "OnBegin")
				Persisted[lookupparent]._registered = true
			else
				Trace("  Error: Scene [" + info.ParentSceneID + "] not found for [" + info.ParentQuest+ "] stage [" + info.StartStage + "]")
				Persisted[lookupparent]._processed = true
			endif
			
		endif
		
		if lookupparent != lastindex
			lookupparent = Settings.FindStruct("ParentQuest", auiQuest, lookupparent + 1)
		else
			lookupparent = -1
		endif
		
	endwhile
	
Endfunction

Event Quest.OnQuestInit(Quest auiQuest)
	Trace("Quest.OnQuestInit Called : auiQuest [" + auiQuest + "]")

	UnregisterForRemoteEvent(auiQuest, "OnQuestInit")

	; NOTE: This is OnQuestInit (Not OnStageSet), so stage will always
	; be 0 when this is called. HOwever, the Episode quest may also 
	; be a parent quest. In situations where the episode is stage 0
	; AND the parent quest uses stage 0, we would want to go ahead
	; and register the parent quests scenes. RegisterInterjectionInfo()
	; was updated to detect that special case...

	if !RegisteredEpisode
		if (auiQuest == EpisodeQuest)
			RegisteredEpisode = true
			Trace("  Registering EpisodeQuest [" + EpisodeQuest + "]")
			if (EpisodeQuestStage < 1) 				
				RegisterInterjectionInfo()
			else
				RegisterForRemoteEvent(EpisodeQuest,"OnStageSet")
			endif
			return
		endif
	endif
	
	; Does it equal any of the ParentQuests?
	int lookupparent = Settings.FindStruct("ParentQuest",auiQuest)
	if (lookupparent > -1)
		InterjectionInfo info = Settings[lookupparent]
		Trace("  Registering for remote event [" + info.ParentQuest + "] -> OnStageSet")
		RegisterForRemoteEvent(info.ParentQuest,"OnStageSet")		
	endif
EndEvent

Event Quest.OnStageSet(Quest auiQuest, int auiStageID, int auiItemID)

	Trace("Quest.OnStageSet Called : Stage : [" + auiStageID + "] of [" + auiQuest + "]")
	
	if !Registered
		if (auiQuest == EpisodeQuest)
			if (auiStageID == EpisodeQuestStage)
				Trace("  Registering Episode Stage [" + EpisodeQuestStage + "]")
				RegisterInterjectionInfo()
			else
				RegisterForRemoteEvent(EpisodeQuest, "OnStageSet")		
			endIf
			Trace("  Returning (EpisodeQuest")
			return
		endIf
	endif
	
	RegisterScenes(auiQuest, auiStageID)
			
EndEvent

Event Scene.OnBegin(Scene auiScene)

	Trace("Scene.OnBegin: Called [" + auiScene + "]")
	
	UnregisterForRemoteEvent(auiScene, "OnBegin")
	
	if (-1 != Persisted.FindStruct("_theScene", auiScene))
		Trace("  Registering Events [" + auiScene + "]-> OnEnd")
		RegisterForRemoteEvent(auiScene, "OnEnd")
		
		AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
		if (!pTweakFollowerScript)
			Trace("  Error: Unable to cast TweakFollower to TweakFollowerScript. Bailing")
			return			
		endif
		
		ReferenceAlias[] companions = pTweakFollowerScript.GetAllTweakFollowers(excludeWaiting=true, excludeDog=true, excludeNonCore=true)
		int numcompanions = companions.length

		if 0 == numcompanions
			Trace("  No companions. Skipping interjection hook.")
			return
		endif

		if 1 == numcompanions
			if !IsSpouse(companions[0].GetActorReference())
				Trace("  Only 1 companion (and they are not your spouse) Skipping interjection hook.")
				return
			else
				Trace("  Only 1 companion, but it is spouse. Allowing interjection")
			endif
		endif
		
		Trace("  Registering Events [" + auiScene + "]-> OnPhaseBegin, OnPhaseEnd")
		RegisterForRemoteEvent(auiScene, "OnPhaseBegin")
		RegisterForRemoteEvent(auiScene, "OnPhaseEnd")
		
		if 2.0 == prevAllowLoiter
			prevAllowLoiter = pTweakAllowLoiter.GetValue()
			pTweakAllowLoiter.SetValue(0.0)
		endif

		; Move COmpanions Behind Player....
						
		Actor pc = Game.GetPlayer()
		Actor npc = companions[0].GetActorRef()
		npc.EvaluatePackage()
		
		float startingOffset=180.0
		float npcPlaceAngle = startingOffset
		float ax = npc.GetAngleX()
		float ay = npc.GetAngleY()
		float[] posdata=TraceCircle(pc, 125, npcPlaceAngle)		
				
		npc.SetPosition(posdata[0],posdata[1],posdata[2])
		npc.SetAngle(ax,ay, npc.GetAngleZ() + npc.GetHeadingAngle(pc))
				
		int j = 1
		float offset = 22
				
		while (j != numcompanions)
			npc = companions[j].GetActorRef()		
			npc.EvaluatePackage()
			npcPlaceAngle = (startingOffset - offset)
			ax = npc.GetAngleX()
			ay = npc.GetAngleY()										
			posdata=TraceCircle(pc, 125, npcPlaceAngle)
			npc.SetPosition(posdata[0],posdata[1],posdata[2])
			npc.SetAngle(ax,ay, npc.GetAngleZ() + npc.GetHeadingAngle(pc))
					
			j += 1
			if (j != numcompanions)
				npc = companions[j].GetActorRef()
				npc.EvaluatePackage()
				npcPlaceAngle = (offset - startingOffset)
				ax = npc.GetAngleX()
				ay = npc.GetAngleY()							
				posdata=TraceCircle(pc, 125, npcPlaceAngle)		
				npc.SetPosition(posdata[0],posdata[1],posdata[2]) 
				npc.SetAngle(ax,ay, npc.GetAngleZ() + npc.GetHeadingAngle(pc))
				
				j += 1
			endif
			offset += 22
		endWhile		
		
	else
		Trace("  Warning: Scene Not Recognized. Ignoring")	
	endif
	
EndEvent

Bool Function IsSpouse(Actor npc)
	Actorbase base = npc.GetActorBase() 
	if (TweakCompanionNate == base)
		return true
	endIf
	if (TweakCompanionNora == base)
		return true
	endIf
	return false
EndFunction

Event Scene.OnPhaseBegin(Scene auiScene, int auiPhaseIndex) 
	Trace("Scene.OnPhaseBegin: Scene [" + auiScene + "] Index [" + auiPhaseIndex + "]")
	int lookupindex = Persisted.FindStruct("_theScene", auiScene)
	
	if (-1 == lookupindex)
		Trace("  Warning: Scene [" + auiScene + "] Not Recognized") 
		return
	endIf
	
	int lastindex    = (Settings.length - 1)
	int maxcheck     = 10
	while (lookupindex != -1 && Settings[lookupindex].BeginPhase != auiPhaseIndex && maxcheck > 0)
		if (lastindex == lookupindex)
			lookupindex = -1
		else
			lookupindex = Persisted.FindStruct("_theScene", auiScene, lookupindex + 1)
		endif
		maxcheck -= 1 ; safety...
	endwhile
			
	if (-1 != lookupindex)
		Trace("  Scene [" + auiScene + "] Phase [" + auiPhaseIndex + "] Recognized")
		Persisted[lookupindex]._processed = true
		HandleCommentary(Settings[lookupindex])
	endIf
	
EndEvent

Event Scene.OnPhaseEnd(Scene auiScene, int auiPhaseIndex) 
	Trace("Scene.OnPhaseEnd: Scene [" + auiScene + "] Index [" + auiPhaseIndex + "]")
	int lookupindex = Persisted.FindStruct("_theScene", auiScene)
	
	if (-1 == lookupindex)
		Trace("  Warning: Scene [" + auiScene + "] Not Recognized")
		return
	endIf
	
	int lastindex    = (Settings.length - 1)
	int maxcheck     = 10
	while (lookupindex != -1 && Settings[lookupindex].EndPhase != auiPhaseIndex && maxcheck > 0)
		if (lastindex == lookupindex)
			lookupindex = -1
		else
			lookupindex = Persisted.FindStruct("_theScene", auiScene, lookupindex + 1)
		endif
		maxcheck -= 1 ; safety...
	endwhile
			
	if (-1 != lookupindex)
		Trace("  Scene [" + auiScene + "] Phase [" + auiPhaseIndex + "] Recognized")
		Persisted[lookupindex]._processed = true
		HandleCommentary(Settings[lookupindex])
	endIf
	
EndEvent

Event Scene.OnEnd(Scene auiScene)

	Trace("Scene.OnEnd: Called [" + auiScene + "]")
	
	; We are not picky about unregistering. Dont want to leave
	; any stray registrations
	
	Trace("  UnRegistering Events [" + auiScene + "]-> OnBegin, OnPhaseBegin, OnPhaseEnd, OnEnd")
	
	if 2.0 != prevAllowLoiter
		pTweakAllowLoiter.SetValue(prevAllowLoiter)
		prevAllowLoiter = 2.0
	endif
	
	UnregisterForRemoteEvent(auiScene, "OnBegin")
	UnregisterForRemoteEvent(auiScene, "OnEnd")
	UnregisterForRemoteEvent(auiScene, "OnPhaseBegin")
	UnregisterForRemoteEvent(auiScene, "OnPhaseEnd")
	Game.StopDialogueCamera() 
	
EndEvent

Function HandleCommentary(InterjectionInfo info)
		
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if !pTweakFollowerScript
		Trace("  Error: Unable to cast TweakFollower to TweakFollowerScript. Bailing")
		return
	endIf

	Topic ptopic1 = None
	Topic stopic1 = None
	if info.Topic1ID > -1
		if info.Topic1ID > 0x00FFFFFF
			ptopic1 = Game.GetFormFromFile(info.Topic1ID, ExternalFile) as Topic
			if !ptopic1
				Trace("  Warning: Default MOD Topic unavailable. Bailing")
				return
			endIf			
		elseif info.Topic1ID > 0
			ptopic1 = Game.GetForm(info.Topic1ID) as Topic
			if !ptopic1
				Trace("  Warning: Default VANILLA Topic unavailable. Bailing")
				return
			endIf			
		endif
		if info.Spouse1ID > 0x00FFFFFF
			stopic1 = Game.GetFormFromFile(info.Spouse1ID, ExternalFile) as Topic
			if !stopic1
				Trace("  Warning: Default Spouse MOD Topic unavailable")
			endIf			
		elseif info.Spouse1ID > 0
			stopic1 = Game.GetForm(info.Spouse1ID) as Topic
			if !stopic1
				Trace("  Warning: Default VANILLA Spouse Topic unavailable.")
			endIf			
		endif
	endIf

	; Who is with us?
	
	ReferenceAlias[] companions = pTweakFollowerScript.GetAllTweakFollowers(excludeWaiting=true, excludeDog=true, excludeNonCore=true)
	int numcompanions = companions.length

	if 0 == numcompanions
		Trace("  No companions. Skipping interjection hook.")
		return
	endif

	if 1 == numcompanions
		if !IsSpouse(companions[0].GetActorReference())
			Trace("  Only 1 companion (and they are not your spouse) Skipping interjection hook.")
			return
		else
			Trace("  Only 1 companion, but it is spouse. Allowing interjection")
		endif
	endif
		
	; Which companion is currently being used by the scene? (if any)
	
	int i = 0
	int inscene = -1
	if (2.0 == prevAllowLoiter)
		prevAllowLoiter = pTweakAllowLoiter.GetValue()
	endif
	pTweakAllowLoiter.SetValue(0.0)
	
	while (i < numcompanions && -1 == inscene)
		if companions[i].GetActorReference().IsInScene()
			inscene = i
		endif
		i += 1
	endwhile	
	
	if -1 != inscene && IsSpouse(companions[inscene].GetActorReference())
		; NOTES: If the companion in slot 1 is the spouse, we will still
		; need to have her speak her line....
		inscene = -1
	endif
	
	; Determine choice/response (when applicable)
	Topic theTopic
	Topic spouseTopic
	
	if info.Choice1ID > -1
		; If there is even 1 choice, theTopic is None (bail) unless we have a match....
		theTopic = None
		spouseTopic = None
		TopicInfo pchoice1 = None
		if info.Choice1ID > 0x00FFFFFF
			pchoice1 = Game.GetFormFromFile(info.Choice1ID, ExternalFile) as TopicInfo
		else
			pchoice1 = Game.GetForm(info.Choice1ID) as TopicInfo
		endif
		if pchoice1
			if pchoice1.HasBeenSaid() && 0 != info.Topic1ID
				Trace("  TopicInfo 1 selected")
				theTopic = ptopic1
				spouseTopic = stopic1
			else
				TopicInfo pchoice2 = None
				if info.Choice2ID > -1
					if info.Choice2ID > 0x00FFFFFF
						pchoice2 = Game.GetFormFromFile(info.Choice2ID, ExternalFile) as TopicInfo
					else
						pchoice2 = Game.GetForm(info.Choice2ID) as TopicInfo
					endif
				endIf
				if pchoice2 && pchoice2.HasBeenSaid() && 0 != info.Topic2ID
					Trace("  TopicInfo 2 selected")
					Topic ptopic2 = None
					Topic stopic2 = None
					if info.Topic2ID > -1
						if info.Topic2ID > 0x00FFFFFF
							ptopic2 = Game.GetFormFromFile(info.Topic2ID, ExternalFile) as Topic
							stopic2 = Game.GetFormFromFile(info.Spouse2ID, ExternalFile) as Topic
						elseif info.Topic2ID > 0
							ptopic2 = Game.GetForm(info.Topic2ID) as Topic
							ptopic2 = Game.GetForm(info.Spouse2ID) as Topic
						endif
					endIf
					theTopic    = ptopic2
					spouseTopic = stopic2
				else
					TopicInfo pchoice3 = None
					if info.Choice3ID > -1
						if info.Choice3ID > 0x00FFFFFF
							pchoice3 = Game.GetFormFromFile(info.Choice3ID, ExternalFile) as TopicInfo
						else
							pchoice3 = Game.GetForm(info.Choice3ID) as TopicInfo
						endif
					endIf
					if pchoice3 && pchoice3.HasBeenSaid() && 0 != info.Topic3ID
						Trace("  TopicInfo 3 selected")
						Topic ptopic3 = None
						Topic stopic3 = None
						if info.Topic3ID > -1
							if info.Topic3ID > 0x00FFFFFF
								ptopic3 = Game.GetFormFromFile(info.Topic3ID, ExternalFile) as Topic
								stopic3 = Game.GetFormFromFile(info.Spouse3ID, ExternalFile) as Topic
							else
								ptopic3 = Game.GetForm(info.Topic3ID) as Topic
								stopic3 = Game.GetForm(info.Spouse3ID) as Topic
							endif
						endIf
						theTopic    = ptopic3
						spouseTopic = stopic3
					else
						TopicInfo pchoice4 = None
						if info.Choice4ID > -1
							if info.Choice4ID > 0x00FFFFFF
								pchoice4 = Game.GetFormFromFile(info.Choice4ID, ExternalFile) as TopicInfo
							else
								pchoice4 = Game.GetForm(info.Choice4ID) as TopicInfo
							endif
						endIf
						if pchoice4 && pchoice4.HasBeenSaid() && 0 != info.Topic4ID
							Trace("  TopicInfo 4 selected")
							Topic ptopic4 = None
							Topic stopic4 = None
							if info.Topic4ID > -1
								if info.Topic4ID > 0x00FFFFFF
									ptopic4 = Game.GetFormFromFile(info.Topic4ID, ExternalFile) as Topic
									stopic4 = Game.GetFormFromFile(info.Spouse4ID, ExternalFile) as Topic
								else
									ptopic4 = Game.GetForm(info.Topic4ID) as Topic
									stopic4 = Game.GetForm(info.Spouse4ID) as Topic
								endif
							endIf
							theTopic    = ptopic4
							spouseTopic = stopic4
						else
							Trace("  No match for TopicInfo Choice (or zero)")
						endif				
					endIf				
				endif
			endif
		endIf
	else
		theTopic    = ptopic1
		spouseTopic = stopic1
	endif
	
	if !theTopic
		return
	endif

	; The point of no "return"... someone is going to speak....
	pTweakIgnoreAffinity.SetValue(1.0)
	
	; Activate custom soundscape (try to increase volume of all NPCs during scene)
	Trace("Activating TweakCSInterjection [" + TweakCSInterjection + "]")
	TweakCSInterjection.Push()
	
	Actor pCenterCameraTarget = None
	if info.FinalCameraTarget && info.FinalCameraTarget.IsUnique() && (pTweakInterjectCenter.GetValue() == 1.0)
		pCenterCameraTarget = info.FinalCameraTarget.GetUniqueActor()
	endif

	bool allowSubtitles = (1.0 == pTweakInterjectSubtitles.GetValue())
	
	if pCenterCameraTarget
		Utility.wait(0.1)
		Game.StopDialogueCamera()
		
		if (allowSubtitles)		
			Trace("  SetInsideMemoryHUDMode : True")
			Game.SetInsideMemoryHUDMode(true)
			Utility.wait(0.1)
			Trace("  SetInsideMemoryHUDMode : True")
			info.ParentScene.Pause(true)
			Utility.wait(0.1)
		endif
	endif
	
	Actor pc = Game.GetPlayer()
	i = 0
	while (i < numcompanions)
		if i != inscene
			Trace("  Having Companion [" + i + "] Speak Topic [" + theTopic + "]")
			Actor akSpeakerRef = companions[i].GetActorReference()
			ObjectReference akTargetCondition = pc as ObjectReference
			
			if IsSpouse(akSpeakerRef) && spouseTopic
				akSpeakerRef.Say(spouseTopic, akSpeakerRef, true, akTargetCondition)
			else
				akSpeakerRef.Say(theTopic, akSpeakerRef, true, akTargetCondition)
			endif
			
			if pCenterCameraTarget
				Game.StartDialogueCameraOrCenterOnTarget(akSpeakerRef)
			endif			
			Utility.wait(1.0)
			
			if akSpeakerRef.IsTalking()
				int maxwait = 13
				while (akSpeakerRef.IsTalking() && maxwait > 0)
					Utility.wait(0.5)
					maxwait -= 1
				endwhile
				Trace("  Companion [" + i + "] Finished (after waiting)")
			else
				Trace("  Companion [" + i + "] Finished")
			endif
		endif
		i += 1
	endwhile
	
	; Deactivate custom soundscape
	Trace("Deactivating TweakCSInterjection [" + TweakCSInterjection + "]")
	TweakCSInterjection.Remove()
	
	Utility.Wait(0.1)

	if pCenterCameraTarget
		if (allowSubtitles)		
			info.ParentScene.Pause(false)
			Game.SetInsideMemoryHUDMode(false)
			Trace("  SetInsideMemoryHUDMode : False")
			Trace("  UnPausing Scene")
		endif		
		Game.StartDialogueCameraOrCenterOnTarget(pCenterCameraTarget)
	endif
	
	pTweakIgnoreAffinity.SetValue(0.0)
		
EndFunction


Function UnRegisterInterjections()
	Trace("UnRegisterInterjections Called")
	RegisteredEpisode = false
	Registered = false

	if EpisodeQuest
		UnRegisterForRemoteEvent(EpisodeQuest,"OnQuestInit")
		UnRegisterForRemoteEvent(EpisodeQuest,"OnStageSet")
	endif

	int i = 0
	int numquests = Settings.length
	while i < numquests
		UnRegisterInterjectionInfoHelper(i)
		Persisted[i]._theScene = None
		i += 1
	endwhile
	
	Persisted.Clear()
	
EndFunction

Function UnRegisterInterjectionInfoHelper(int infoindex)

	Trace("UnRegisterInterjectionInfoHelper Called")	
	InterjectionInfo info = Settings[infoindex]
	
	if (!info.ParentQuest)
		Trace("  No Parent Quest : bailing")	
		return
	endif
	
	if (!info.ParentScene && 0 == info.ParentSceneID)
		Trace("  No Parent Scene : bailing")	
		return
	endif

	UnRegisterForRemoteEvent(info.ParentQuest,"OnQuestInit")
	UnRegisterForRemoteEvent(info.ParentQuest,"OnStageSet")
	InterjectionPersist persist = Persisted[infoindex]
	
	if persist._theScene
		UnRegisterForRemoteEvent(persist._theScene, "OnBegin")
		UnRegisterForRemoteEvent(persist._theScene, "OnPhaseBegin")
		UnRegisterForRemoteEvent(persist._theScene, "OnPhaseEnd")
		UnRegisterForRemoteEvent(persist._theScene, "OnEnd")
	endif
	
EndFunction


;==============================
; Utility
;==============================

; AngleOffset:
;  -90     = Players left. 
;   90     = Players right, 
; 180/-180 = behind player
Float[] Function TraceCircle(ObjectReference n, Float radius = 500.0, Float angleOffset = 0.0)
	
    float azimuth = ConvertToSinCosCompatibleAngle(n.GetAngleZ(), angleOffset)

    Float xoffset = radius * Math.cos(azimuth)
    Float yoffset = radius * Math.sin(azimuth)

    Float[] r = new Float[3]
    r[0] =  (n.GetPositionX() + xoffset)
    r[1] =  (n.GetPositionY() + yoffset)
    r[2] =   n.GetPositionZ()
    return r

endFunction

Float Function ConvertToSinCosCompatibleAngle(Float original, Float angleOffset = 0.0)

	; See TweakFollowerScript for explanation
	return Enforce360Bounds(450 - original + angleOffset)	
	
EndFunction

Float Function Enforce360Bounds(float a)
    if (a < 0) 
        a = a + 360
    endif
    if (a > 360)
        a = a - 360
    endif 
	return a
EndFunction 

