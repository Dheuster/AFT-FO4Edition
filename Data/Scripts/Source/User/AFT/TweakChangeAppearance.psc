Scriptname AFT:TweakChangeAppearance extends Quest

; Skulpt Support:
Keyword Property AnimFaceArchetypePlayer Auto Const
Furniture Property pNPCSinkFacegenMarker     Auto Const
Scene Property pTweakSculptScene Auto Const ; SCRAP

ReferenceAlias Property pSculptTarget Auto
ReferenceAlias Property pSculptMirror Auto
ReferenceAlias Property pInvisibleGuy Auto

; Bool var_SkeletonResetDone

; Parts Support
Race Property pTweakInvisibleRace Auto Const
Race Property pSynthGen2RaceValentine Auto Const
Quest Property pTweakVisualChoice Auto Const
GlobalVariable Property pTweakVCUpText Auto;    0 = None 1 = Toggle 2 = Add    3 = Choose
GlobalVariable Property pTweakVCDownText Auto;  0 = None 1 = Done   2 = Remove 3 = Alt
GlobalVariable Property pTweakVCLeftText Auto;  0 = None 1 = Done   2 = Prev 
GlobalVariable Property pTweakVCRightText Auto; 0 = None 1 = Done   2 = Next 
Message Property pTweakUpdating Auto Const
Message Property pTweakOptionOf Auto Const
Message Property pTweakOptionChosen Auto Const
Message Property pTweakOptionRestored Auto Const
Message Property pTweakReloadRequired Auto Const
FormList Property pTweakEyeParts Auto Const
FormList Property pTweakEyeChildParts Auto Const
FormList Property pTweakHeadParts Auto Const
FormList Property pTweakHairParts Auto Const
FormList Property pTweakBeardParts Auto Const
FormList Property pTweakPoseObjects Auto Const
FormList Property pTweakFaceArchtypes Auto Const
FormList Property pTweakFaceArchtypesMsgs Auto Const
FormList Property pTweakBodyArchtypes Auto Const
FormList Property pTweakBodyArchtypesMsgs Auto Const
FormList Property pTweakPoseMsgs Auto Const
Idle Property pInitializeMTGraphInstant Auto Const

GlobalVariable Property pTweakMovePosedActive Auto Const

Faction  Property pTweakPosedFaction      Auto Const
Faction  Property pTweakIgnoredFaction    Auto Const
Keyword  Property pArmorTypePower         Auto Const
Keyword  Property pTweakPoseTarget        Auto Const
Keyword	 Property pTeammateReadyWeapon_DO Auto Const
Faction  Property pTweakReadyWeaponFaction Auto Const

; New Body Support
FormList       Property pTweakNewBodyData       Auto Const
FormList       Property pTweakActorValuesToSave Auto Const
ActorBase      Property pTweakInvisibleGuy      Auto Const
ActorValue     Property pTweakScale             Auto Const

float[] restore_global_values
float[] restore_actor_values
Actor[] body_dummies

; Local
int      parts_index
int      parts_choice
float    original_distance
FormList PartsList ; Pointer
TweakAppearance parts_storage
VoiceType original_vt

int FLOOD_PROTECTION_POSES = 995 const
int FLOOD_PROTECTION_POSTURES = 996 const
int FLOOD_PROTECTION_EXPRESSIONS = 997 const
int FLOOD_PROTECTION_PARTS = 998 const
int FLOOD_PROTECTION_BODYS = 999 const

Message Property pTweakSculptInitMsg		Auto Const
Message Property pTweakSculptProgress30		Auto Const
Message Property pTweakSculptProgress60		Auto Const
Message Property pTweakSculptProgress100	Auto Const

Keyword Property pActorTypeGhoul		 Auto Const
Keyword Property pActorTypeHuman		 Auto Const
Keyword Property pActorTypeSynth		 Auto Const
Keyword Property pActorTypeSuperMutant	 Auto Const
Outfit  Property pTweakNoOutfit			 Auto Const
Spell   Property MQ203PlayerInvisibility Auto Const

int prePosedRank
bool wasReadyWeapon = true
bool wasManaged     = false

; Pose Support
Struct PoseData
	Form      pose
	float     replay_delay	
EndStruct

PoseData[] Property Poses Auto

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakChangeAppearance"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Event OnQuestInit()
	Trace("OnQuestInit()")
	pSculptTarget.Clear()
	PartsList = None
	; You have to initialize Arrays or Add() wont work. IE: The default object is None
	restore_global_values = new float[0]
	restore_actor_values  = new float[0]
	body_dummies          = new Actor[0]
	Poses                 = new PoseData[36]
	int i = 0
	while i < 36
		Poses[i] = new PoseData
		i += 1
	endWhile
	PopulatePoses()	
	Trace("OnQuestInit() Finished")	
EndEvent

Function OnGameLoaded(Bool firstTime=False)
	Trace("OnGameLoaded()")
	pSculptTarget.Clear()
	PartsList = None
	body_dummies.Clear()
	Trace("OnGameLoaded() Finished")	
EndFunction

Event OnTimer(int aiTimerID)

	if (FLOOD_PROTECTION_POSES == aiTimerID)
		if parts_index < pTweakPoseMsgs.GetSize()
			Message msg = pTweakPoseMsgs.GetAt(parts_index) As Message
			if msg
				msg.Show()
				return
			else
				Trace("TweakPoseMsgs[" + parts_index + "] did not cast to Message!")
			endif			
		else
			Trace("parts_index (" + parts_index + ") < TweakPoseMsgs.GetSize() (" + pTweakPoseMsgs.GetSize() + ")")
		endif
		
		; pTweakOptionOf => "Option [25] of [50]"
		pTweakOptionOf.Show((parts_index + 1), Poses.length)
		return
	endif

	if (FLOOD_PROTECTION_PARTS == aiTimerID)
		; pTweakOptionOf => "Option [25] of [50]"
		pTweakOptionOf.Show((parts_index + 1),(PartsList.GetSize()))
		return
	endif
	if (FLOOD_PROTECTION_EXPRESSIONS == aiTimerID)
		if parts_index < pTweakFaceArchtypesMsgs.GetSize()
			Message msg = pTweakFaceArchtypesMsgs.GetAt(parts_index) As Message
			if msg
				msg.Show()
				return
			else
				Trace("TweakFaceArchtypesMsgs[" + parts_index + "] did not cast to Message!")
			endif			
		else
			Trace("parts_index (" + parts_index + ") < TweakFaceArchtypesMsgs.GetSize() (" + pTweakFaceArchtypesMsgs.GetSize() + ")")
		endif
		
		; pTweakOptionOf => "Option [25] of [50]"
		pTweakOptionOf.Show((parts_index + 1),(PartsList.GetSize()))
		return
	endif
	if (FLOOD_PROTECTION_POSTURES == aiTimerID)
		if parts_index < pTweakBodyArchtypesMsgs.GetSize()
			Message msg = pTweakBodyArchtypesMsgs.GetAt(parts_index) As Message
			if msg
				msg.Show()
				return
			else
				Trace("TweakBodyArchtypesMsgs[" + parts_index + "] did not cast to Message!")
			endif			
		else
			Trace("parts_index (" + parts_index + ") < TweakBodyArchtypesMsgs.GetSize() (" + pTweakBodyArchtypesMsgs.GetSize() + ")")
		endif
		
		; pTweakOptionOf => "Option [25] of [50]"
		pTweakOptionOf.Show((parts_index + 1),(PartsList.GetSize()))
		return
	endif
	if (FLOOD_PROTECTION_BODYS == aiTimerID)
		int curr  = parts_index - 1 - restore_global_values.Length
		int total = PartsList.GetSize() - 2 - restore_global_values.Length
		; pTweakOptionOf => "Option [25] of [50]"
		pTweakOptionOf.Show(curr,total)
		return
	endif
	
EndEvent

; CallBack Interface PROTOTYPE for TweakVisualChoiceScript
Function OnChoiceBegin()
		Trace("OnChoiceBegin() : None State")
EndFunction
Function OnChooseUp()
		Trace("OnChooseUp() : None State")
EndFunction
Function OnChooseDown()
		Trace("OnChooseDown() : None State")
EndFunction
Function OnChooseLeft()
		Trace("OnChooseLeft() : None State")
EndFunction
Function OnChooseRight()
		Trace("OnChooseRight() : None State")
EndFunction
Function OnChoiceEnd()
		Trace("OnChoiceEnd() : None State")
EndFunction

; Event ObjectReference.Onload(ObjectReference akObject)
		; Trace("OnLoad() : None State")	
; EndEvent

Function MovePosed(TweakAppearance pTweakAppearance)
	Trace("MovePosed() Called")
	Actor npc = (pTweakAppearance as ReferenceAlias).GetActorRef()
	if (!npc)
		Trace("Cast of TweakAppearance to Actor Failed. Aborting...")
		return
	endif
	TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
	if (!pTweakVCScript)
		Trace("Unable to cast TweakVisualChoiceScript")
		return
	endif
	
	parts_storage = pTweakAppearance
	; In this conext, parts_choice is used to track toggle state. Always starts in state 0
	parts_choice = 0
	
	; In this context, parts_index is used to track scene state. Always starts in state 1
	parts_index  = 1
	
	; Use to detect if this is running externally for emergency shut down..
	pTweakMovePosedActive.SetValue(1.0)
	original_distance = Game.GetPlayer().GetDistance(npc)
	
	pTweakVCUpText.SetValue(1)    ; Toggle
	pTweakVCLeftText.SetValue(1)  ; < Rotate ; 3 = < Lean
	pTweakVCRightText.SetValue(1) ; Rotate > ; 3 = Lean >
	pTweakVCDownText.SetValue(1)  ; Done 
	Trace("Activating StartChoice()")
	self.GotoState("ShowMovePosed")
	
	pTweakVCScript.StartChoice(npc, self, 0)

EndFunction

Function ChangePosture(TweakAppearance pTweakAppearance)

	Trace("ChangePosture() Called")
	
	Actor npc = (pTweakAppearance as ReferenceAlias).GetActorRef()
	if (!npc)
		Trace("Cast of TweakAppearance to Actor Failed. Aborting...")
		return
	endif

	; The following is checked by TweakPipBoy before relaying the Pose Event:
	; assert pTweakVisualChoice.IsRunning()
    ; assert !npc.IsInFaction(pTweakPosedFaction)
	; assert !npc.WornHasKeyword(pArmorTypePower)
	; assert !npc.IsInCombat()
    ; assert !npc.IsInScene()
	
	TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
	if (!pTweakVCScript)
		Trace("Unable to cast TweakVisualChoiceScript")
		return
	endif
	
	parts_storage = pTweakAppearance
	parts_choice  = parts_storage.CurrentArchtypeId
	parts_choice = -1
	parts_index   = 0
	if (parts_choice > -1)
		parts_index   = parts_choice
	endif
	
	; 1 = Wait + HeadTurn
	; 2 = Wait
	; 3 = Use/Sit LinkedRef object TweakPoseTarget
	; 4 = Use IdleMarker object TweakPoseTarget
	
	prePosedRank = npc.GetFactionRank(pTweakPosedFaction)
	npc.SetFactionRank(pTweakPosedFaction,2)
	npc.EvaluatePackage()
		
	PartsList = pTweakBodyArchtypes
		
	pTweakVCUpText.SetValue(3)    ; Choose
	pTweakVCDownText.SetValue(1)  ; Done 
	pTweakVCLeftText.SetValue(2)  ; Prev
	pTweakVCRightText.SetValue(2) ; Next
	Trace("Activating StartChoice()")
	self.GotoState("ShowPostures")

	pTweakVCScript.StartChoice(npc, self, 150, 20)
	
EndFunction

Function ChangeExpression(TweakAppearance pTweakAppearance)

	Trace("ChangeExpression() Called")
	
	Actor npc = (pTweakAppearance as ReferenceAlias).GetActorRef()
	if (!npc)
		Trace("Cast of TweakAppearance to Actor Failed. Aborting...")
		return
	endif

	; The following is checked by TweakPipBoy before relaying the Pose Event:
	; assert pTweakVisualChoice.IsRunning()
	; assert !npc.WornHasKeyword(pArmorTypePower)
	; assert !npc.IsInCombat()
    ; assert !npc.IsInScene()
	
	TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
	if (!pTweakVCScript)
		Trace("Unable to cast TweakVisualChoiceScript")
		return
	endif
	
	parts_storage = pTweakAppearance
	parts_choice  = parts_storage.CurrentFaceArchtypeId
	parts_choice = -1
	parts_index   = 0
	if (parts_choice > -1)
		parts_index   = parts_choice
	endif
	
	; 1 = Wait + HeadTurn
	; 2 = Wait
	; 3 = Use/Sit LinkedRef object TweakPoseTarget
	; 4 = Use IdleMarker object TweakPoseTarget
	
	prePosedRank = npc.GetFactionRank(pTweakPosedFaction)
	Trace("PrePosedRank = [" + prePosedRank + "]")
	npc.SetFactionRank(pTweakPosedFaction,1)
	npc.EvaluatePackage()
		
	PartsList = pTweakFaceArchtypes
		
	pTweakVCUpText.SetValue(3)    ; Choose
	pTweakVCDownText.SetValue(1)  ; Done 
	pTweakVCLeftText.SetValue(2)  ; Prev
	pTweakVCRightText.SetValue(2) ; Next
	Trace("Activating StartChoice()")
	self.GotoState("ShowExpressions")

	if (prePosedRank > -1)
		pTweakVCScript.StartChoice(npc, self, 0)
	else
		pTweakVCScript.StartChoice(npc, self, 70, 20)
	endif
	
EndFunction

Function Pose(TweakAppearance pTweakAppearance, int forceID = -1)

	Trace("Pose() Called")
	
	Actor npc = (pTweakAppearance as ReferenceAlias).GetActorRef()
	if (!npc)
		Trace("Cast of TweakAppearance to Actor Failed. Aborting...")
		return
	endif

	if ( forceID > -1  &&  forceID < Poses.length )		
		pTweakAppearance.CurrentPoseId = forceID
		PoseData pd = Poses[forceID]		
		pTweakAppearance.StartPose(forceID, pd.pose, pd.replay_delay)
		return
	endif
	
	; The following is checked by TweakPipBoy before relaying the Pose Event:
	; assert pTweakVisualChoice.IsRunning()
	; assert !npc.WornHasKeyword(pArmorTypePower)
	; assert !npc.IsInCombat()
    ; assert !npc.IsInScene()
		
	parts_storage = pTweakAppearance
	parts_choice = parts_storage.CurrentPoseId
	parts_index   = 0
	if (parts_choice > -1)
		parts_index   = parts_choice
	endif

	; 2 = Wait
	prePosedRank = npc.GetFactionRank(pTweakPosedFaction)
	npc.SetFactionRank(pTweakPosedFaction,2)
	npc.EvaluatePackage()
					
	TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
	if (!pTweakVCScript)
		Trace("Unable to cast TweakVisualChoiceScript")
		return
	endif
	
	pTweakVCUpText.SetValue(3)    ; Choose
	pTweakVCDownText.SetValue(1)  ; Done 
	pTweakVCLeftText.SetValue(2)  ; Prev
	pTweakVCRightText.SetValue(2) ; Next
	Trace("Activating StartChoice()")
	self.GotoState("ShowPoses")
	
	if (prePosedRank > -1)
		pTweakVCScript.StartChoice(npc, self, 0)
	else
		pTweakVCScript.StartChoice(npc, self, 150, 50)
	endif
	
EndFunction

Function Sculpt(TweakAppearance pTweakAppearance, int uiMenu=1)

	Trace("Sculpt() Called. uiMode = [" + uiMenu + "]")
	
	Actor npc = (pTweakAppearance as ReferenceAlias).GetActorRef()
	if (!npc)
		Trace("Cast of TweakAppearance to Actor Failed. Aborting...")
		return
	endif
		
	; NPC that wishes to be sculpted, must posses one of these
	; two keywords:
	;
	; How did I figure this out? : NPCSinkFacegenMarker lists 
	; keywords associated with it. One of them is AnimFurnSinkFacegen
	; If you look at the Race "HumanRaceSubGraphData", in the 
	; last tab it connects furniture with keywords that help
	; figure out compatiblity. AnimFurnSinkFacegen requires
	; one of the two keywords below:
	
	Keyword PlayerKeyword = Game.GetForm(0x00099306) as Keyword
	Keyword female        = Game.GetForm(0x00084486) as Keyword
	bool added_female        = false
	bool added_playerkeyword = false
	Actor pc = Game.GetPlayer()	

	if pc.HasKeyWord(female) && !npc.HasKeyword(female)
		npc.AddKeyword(female)
		added_female = true
	elseif pc.HasKeyWord(PlayerKeyword) && !npc.HasKeyword(PlayerKeyword)
		npc.AddKeyword(PlayerKeyword)
		added_playerkeyword = true
	endif
	
	; The following is checked by TweakPipBoy before relaying the Pose Event:
	; assert pTweakVisualChoice.IsRunning()
    ; assert !npc.IsInFaction(pTweakPosedFaction)
	; assert !npc.WornHasKeyword(pArmorTypePower)
	; assert !npc.IsInCombat()
    ; assert !npc.IsInScene()
		
	pTweakSculptInitMsg.Show()	
	parts_storage = pTweakAppearance

	; 1 = Wait + HeadTurn
	; 2 = Wait
	; 3 = Use/Sit LinkedRef object TweakPoseTarget
	; 4 = Use IdleMarker object TweakPoseTarget
	
	prePosedRank = npc.GetFactionRank(pTweakPosedFaction)
	; Tried 1 and they looked off to side...
	
	npc.SetFactionRank(pTweakPosedFaction,2)
	npc.EvaluatePackage()
	
	npc.SetAvoidPlayer(true)
	Utility.wait(0.1)
		
	; Teleport NPC behind the player to ensure they wont collide with the mirror
	; and to prevent clothes blinking...
	
	Trace("Moving NPC beind Player")
    float[] posdata = TraceCircle(pc,-100,0)
	npc.SetAngle(0.0,0.0,  Enforce360Bounds(pc.GetAngleZ()))	
	npc.SetPosition(posdata[0],posdata[1],posdata[2])
	
	; Make them invisible just in case the player looks around. 
	npc.AddSpell(MQ203PlayerInvisibility, abVerbose=False)
	
	; Get pSculptTarget (For retrieval)
	int maxwait= 5 
	while (None != pSculptTarget.GetActorRef() && maxwait > 0)
		Trace("Waiting for Sculpt Target to clear")
		Utility.wait(1.0)
		maxwait -= 1
	endwhile
	if (None != pSculptTarget.GetActorRef())
		Trace("Warning : Reassigning non-empty alias pSculptTarget. This may break other threads...")		
	endif

	pSculptTarget.ForceRefTo(npc)
	
	Trace("Removing gear for sculpt")
	wasManaged = false
	
	; 1.20: Sculpt should not automatically kick off Inventory Management
    ; - On Sculpt:
    ;   if first sculpt:
    ;     - if managed, restoreOutfit after race switch
    ;     - if not managed, unequipall
    ;   When sculpt ends (first or not)
    ;     - if managed, restoreOutfit
    ;     - if not managed, place in road leathers.	
	
	
	AFT:TweakInventoryControl pTweakInventoryControl = (pTweakAppearance as ReferenceAlias) as AFT:TweakInventoryControl
	if (pTweakInventoryControl)
		if npc.HasKeyword(pActorTypeGhoul) || npc.HasKeyword(pActorTypeHuman) || npc.HasKeyword(pActorTypeSynth) || npc.HasKeyword(pActorTypeSuperMutant)
			if npc.GetRace() == pSynthGen2RaceValentine
				Trace("OnChoiceBegin(): Nick Valentine detected")
				TweakFollowerScript pTweakFollowerScript = (self as Quest) as TweakFollowerScript
				if pTweakFollowerScript
					pTweakFollowerScript.AddNickItems()
				endif
			endif
			
			; This will fail if they are not already managed....
			pTweakInventoryControl.SetTweakOutfit(5, true) ;  5 == OUTFIT_SNAPSHOT
			Utility.wait(0.3)

			; If it is OK to leave them clothed, then you can pass in true and the UNEQUIP will be
			; ignored unless they are managed. Most appearance commands (except expression and posture)
			; will strip them down. Keep in mind, it will be restored once they are managed.
			
			wasManaged = pTweakInventoryControl.IsManaged()
			
			pTweakInventoryControl.UnEquipAllGear()
			Utility.wait(0.1)			
		endif		
	else
		Trace("OnChoiceBegin(): TweakInventoryControl cast failed")
		npc.UnEquipAll()
		Utility.wait(0.1)
	endif
	
	; If the player has a weapon out, make sure the NPC doesn't care:
	wasReadyWeapon = npc.IsInFaction(pTweakReadyWeaponFaction)
	if (wasReadyWeapon)
		npc.RemoveFromFaction(pTweakReadyWeaponFaction)
		npc.RemoveKeyword(pTeammateReadyWeapon_DO)
	endif
	
	ObjectReference akFurn = npc.PlaceAtMe(pNPCSinkFacegenMarker)
	pSculptMirror.ForceRefTo(akFurn)
	
	;; In order to edit the face, you need to load a special skeleton into the Companion
	;; Note : Skeleton can't load once they start using the mirror. So dont force that just yet..	
	;; Note : Leveled actors constantly check and re-enforce their appearance.
	;; Note : Usage/Activation of the mirror is necessary to make the game target the changes
	;;        against the NPC. If the NPC doesn't use/activate the mirror (even briefly), the
	;;        game will apply the changes to the player. 
	
	Trace("Sculpt : Registering for FirstPersonInitialized (To get skeleton reset event) and LooksMenu Open/Close")
	
	; The animation events used for the chargen will never fire. If you look at the Race HumanSubGraph and the
	; Animations tab, you will see that this Animation/Event requires the Furniture to have a keyword and the
	; NPC to have the keyword "Player". Since the NPC doesn't have the Player keyword, the animation events will 
	; never execute/fire against this actor. (Might if we added Player to the NPC, but I am affraid of breaking 
	; things). Luckily, the skeleton still loads. You just have to wait for it the old fashion way with a sleep 
	; and a guess.  
	
	npc.SetHasCharGenSkeleton()
	
	Utility.wait(2) ; 2.5
	pTweakSculptProgress30.show()
	Utility.wait(2) ; 2.5
	pTweakSculptProgress60.show()
	Utility.wait(2) ; 2
	pTweakSculptProgress100.show()
	
	npc.ChangeAnimFaceArchetype(None)
	RegisterForRemoteEvent(akFurn,"OnExitFurniture")
	
	; Move mirror in front of the player. AngleOffset 
	; is 26 because the mirror spawns facing the players right. And when you
    ; rotate it, it doesn't line up with the Player. 
	
    posdata = TraceCircle(pc, radius=50, angleOffset=26)
	akFurn.SetAngle(0.0,0.0, Enforce360Bounds(pc.GetAngleZ() - 180))
	akFurn.SetPosition(posdata[0],posdata[1],(posdata[2]))	
	Utility.wait(0.2)
	
	; They may or may not stop using the mirror. It doesn't really
	; matter. All that matters is that they activate it BEFORE
	; we call ShowRaceMenu...
	
	Trace("Sculpt : Calling SnapIntoInteration")
	npc.RemoveSpell(MQ203PlayerInvisibility)
	npc.SnapIntoInteraction(akFurn)
	Utility.wait(0.2)
	
	Trace("Saving incase they mess things up or we crash...")
	Game.RequestAutoSave()	
	
	TweakVisualChoiceScript pTweakVCScript = None
	if (pTweakVisualChoice.IsRunning())
		pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
	else
		Trace("TweakVisualChoice Not Running....")
	endif	
	if (!pTweakVCScript || uiMenu != 1)
		Trace("TweakVisualChoice Cast error or uiMenu != 1 (" + uiMenu + ")")
		Game.ShowRaceMenu(akMenuTarget = npc, uiMode = uiMenu)
		return
	endif
	
	; This allows the User to place themself in a good location before
	; starting the RaceMenu (since they can't move once it gets underway)
	
	parts_choice = 0	
	pTweakVCUpText.SetValue(2)    ; Sculpt
	pTweakVCDownText.SetValue(3)  ; Cancel 
	pTweakVCLeftText.SetValue(1)  ; Rotate
	pTweakVCRightText.SetValue(1) ; Rotate						
	Trace("Activating StartChoice()")
	self.GotoState("ShowSculpt")

	; Special radius 0 means, dont move them...
	pTweakVCScript.StartChoice(npc, self, 0)
	
	; See Callbacks below in the ShowSculpt State for continuation of code...
	if added_female
		npc.RemoveKeyword(female)
	elseif added_playerkeyword
		npc.RemoveKeyword(PlayerKeyword)
	endif
	
EndFunction

Actor LeveledNPCSrc = None

; Experimental
Function SculptLeveled(TweakAppearance pTweakAppearance, int uiMenu=1)

	Trace("SculptLeveled() Called. uiMode = [" + uiMenu + "]")
	Actor npc = (pTweakAppearance as ReferenceAlias).GetActorRef()
	ActorBase npcbase = npc.GetActorBase()
	if (npcbase == Game.GetForm(0x00027686) as ActorBase) ; Curie
		int cid = pTweakAppearance.CurrentBodyId
		if -1 == cid
			npcbase = Game.GetForm(0x001647C6) as ActorBase
		else
			FormList BodyOptions = None
			int i = 0
			int BodyDataSize = pTweakNewBodyData.GetSize()
			while (i != BodyDataSize && !BodyOptions)
				FormList BodyData = pTweakNewBodyData.GetAt(i) As FormList
				if (BodyData.GetSize() > 0 && (BodyData.GetAt(0) as ActorBase) == npcbase)
					Trace("TweakNewBodyData[" + i + "] has ActorBase!")
					BodyOptions = BodyData
				endif
				i += 1
			endwhile
			
			if (BodyOptions)			
				npcbase = BodyOptions.GetAt(cid) as ActorBase				
			else
				Trace("ActorBase for NPC not found in TweakNewBodyData")
				npcbase = Game.GetForm(0x001647C6) as ActorBase
			endif		
		endif
	else
		Sculpt(pTweakAppearance, uiMenu)
		return
	endif
	
	; The following is checked by TweakPipBoy before relaying the Pose Event:
	; assert pTweakVisualChoice.IsRunning()
    ; assert !npc.IsInFaction(pTweakPosedFaction)
	; assert !npc.WornHasKeyword(pArmorTypePower)
	; assert !npc.IsInCombat()
    ; assert !npc.IsInScene()
		
	pTweakSculptInitMsg.Show()	
	parts_storage = pTweakAppearance

	; 1 = Wait + HeadTurn
	; 2 = Wait
	; 3 = Use/Sit LinkedRef object TweakPoseTarget
	; 4 = Use IdleMarker object TweakPoseTarget
	
	prePosedRank = npc.GetFactionRank(pTweakPosedFaction)
	
	npc.SetFactionRank(pTweakPosedFaction,2)
	npc.EvaluatePackage()
	npc.SetAvoidPlayer(true)
	Utility.wait(0.1)
		
	; Teleport NPC behind the player to ensure they wont collide with the mirror
	; and to prevent clothes blinking...
	Actor pc = Game.GetPlayer()	
	
	Trace("SculptLeveled: Moving NPC beind Player")
    float[] posdata = TraceCircle(pc,-100,0)
	npc.SetAngle(0.0,0.0,  Enforce360Bounds(pc.GetAngleZ()))	
	npc.SetPosition(posdata[0],posdata[1],posdata[2])
	Utility.wait(0.2)
	
	; Make them invisible just in case the player looks around. 
	npc.AddSpell(MQ203PlayerInvisibility, abVerbose=False)
	LeveledNPCSrc = npc

	; NOW SPAWN THE LEVELED ACTOR
	Actor realNPC = npcbase.GetUniqueActor()
	Trace("SculptLeveled: npcbase [" + npcbase + "]")
	if (!realNPC)
		Trace("SculptLeveled: Spawning NPC Base")
		realNPC = npc.placeAtMe(npcbase) as Actor
	else
		Trace("SculptLeveled: NPC Base exists. Moving to npc")
		realNPC.MoveToIfUnloaded(npc)
	endif
	if realNPC.IsDisabled()
		Trace("SculptLeveled: Enabling NPC Base")
		realNPC.Enable()
	else
		Trace("SculptLeveled: NPC Base not disabled")
	endif

	realNPC.AddSpell(MQ203PlayerInvisibility, abVerbose=False)
	Utility.wait(0.1)
	realNPC.SetUnconscious()
	realNPC.SetFactionRank(pTweakPosedFaction,2)
	realNPC.SetAvoidPlayer(true)
	
	TweakFollowerScript pTweakFollowerScript = (self as Quest) as TweakFollowerScript
	if pTweakFollowerScript
		pTweakFollowerScript.ImportFollower(realNPC,true)
		realNPC.EvaluatePackage()
		realNPC.SetAngle(0.0,0.0,  Enforce360Bounds(pc.GetAngleZ()))	
		realNPC.SetPosition(posdata[0],posdata[1],posdata[2])
	endif
	
	; If the player has a weapon out, make sure the NPC doesn't care:
	wasReadyWeapon = realNPC.HasKeyword(pTeammateReadyWeapon_DO)
	if (wasReadyWeapon)
		realNPC.RemoveKeyword(pTeammateReadyWeapon_DO)
	endif
	
	realNPC.SetUnconscious(false)
	Utility.wait(0.2)
	
	; NPC that wishes to be sculpted, must posses one of these
	; two keywords:
	Keyword PlayerKeyword = Game.GetForm(0x00099306) as Keyword
	Keyword female        = Game.GetForm(0x00084486) as Keyword
	
	; How did I figure this out? : NPCSinkFacegenMarker lists 
	; keywords associated with it. One of them is AnimFurnSinkFacegen
	; If you look at the Race "HumanRaceSubGraphData", in the 
	; last tab it connects furniture with keywords that help
	; figure out compatiblity. AnimFurnSinkFacegen requires
	; one of the two keywords below:
	
	bool added_female        = false
	bool added_playerkeyword = false

	if pc.HasKeyWord(female) && !realNPC.HasKeyword(female)
		Trace("SculptLeveled: Adding female keyword")
		realNPC.AddKeyword(female)
		added_female = true
	elseif pc.HasKeyWord(PlayerKeyword) && !realNPC.HasKeyword(PlayerKeyword)
		Trace("SculptLeveled: Adding PlayerKeyword")
		realNPC.AddKeyword(PlayerKeyword)
		added_playerkeyword = true
	endif

	; Get pSculptTarget (For retrieval)
	int maxwait= 5 
	while (None != pSculptTarget.GetActorRef() && maxwait > 0)
		Trace("SculptLeveled: Waiting for Sculpt Target to clear")
		Utility.wait(1.0)
		maxwait -= 1
	endwhile
	if (None != pSculptTarget.GetActorRef())
		Trace("SculptLeveled: Warning : Reassigning non-empty alias pSculptTarget. This may break other threads...")		
	endif

	pSculptTarget.ForceRefTo(realNPC)
		
	Trace("SculptLeveled: Removing gear for sculpt")
	wasManaged = false
	realNPC.UnEquipAll()
	Utility.wait(0.1)
		
	ObjectReference akFurn = npc.PlaceAtMe(pNPCSinkFacegenMarker)
	pSculptMirror.ForceRefTo(akFurn)
	
	;; In order to edit the face, you need to load a special skeleton into the Companion
	;; Note : Skeleton can't load once they start using the mirror. So dont force that just yet..	
	;; Note : Leveled actors constantly check and re-enforce their appearance.
	;; Note : Usage/Activation of the mirror is necessary to make the game target the changes
	;;        against the NPC. If the NPC doesn't use/activate the mirror (even briefly), the
	;;        game will apply the changes to the player. 
	
	Trace("SculptLeveled: Registering for FirstPersonInitialized (To get skeleton reset event) and LooksMenu Open/Close")
	
	; The animation events used for the chargen will never fire. If you look at the Race HumanSubGraph and the
	; Animations tab, you will see that this Animation/Event requires the Furniture to have a keyword and the
	; NPC to have the keyword "Player". Since the NPC doesn't have the Player keyword, the animation events will 
	; never execute/fire against this actor. (Might if we added Player to the NPC, but I am affraid of breaking 
	; things). Luckily, the skeleton still loads. You just have to wait for it the old fashion way with a sleep 
	; and a guess.  
	
	realNPC.SetHasCharGenSkeleton()
	
	Utility.wait(2) ; 2.5
	pTweakSculptProgress30.show()
	Utility.wait(2) ; 2.5
	pTweakSculptProgress60.show()
	Utility.wait(2) ; 2
	pTweakSculptProgress100.show()
	
	realNPC.ChangeAnimFaceArchetype(None)
	RegisterForRemoteEvent(akFurn,"OnExitFurniture")
	
	; Move mirror in front of the player. AngleOffset 
	; is 26 because the mirror spawns facing the players right. And when you
    ; rotate it, it doesn't line up with the Player. 
	
    posdata = TraceCircle(pc, radius=50, angleOffset=26)
	akFurn.SetAngle(0.0,0.0, Enforce360Bounds(pc.GetAngleZ() - 180))
	akFurn.SetPosition(posdata[0],posdata[1],(posdata[2]))	
	Utility.wait(0.2)
	
	; They may or may not stop using the mirror. It doesn't really
	; matter. All that matters is that they activate it BEFORE
	; we call ShowRaceMenu...
	
	
	Trace("SculptLeveled: Calling SnapIntoInteration")
	realNPC.RemoveSpell(MQ203PlayerInvisibility)
	realNPC.SnapIntoInteraction(akFurn)
	Utility.wait(0.2)
	
	Trace("SculptLeveled: Saving incase they mess things up or we crash...")
	Game.RequestAutoSave()	
	
	TweakVisualChoiceScript pTweakVCScript = None
	if (pTweakVisualChoice.IsRunning())
		pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
	else
		Trace("SculptLeveled: TweakVisualChoice Not Running....")
	endif	
	if (!pTweakVCScript || uiMenu != 1)
		Trace("SculptLeveled: TweakVisualChoice Cast error or uiMenu != 1 (" + uiMenu + ")")
		Game.ShowRaceMenu(akMenuTarget = realNPC, uiMode = uiMenu)
		return
	endif
	
	; This allows the User to place themself in a good location before
	; starting the RaceMenu (since they can't move once it gets underway)
	
	parts_choice = 0	
	pTweakVCUpText.SetValue(2)    ; Sculpt
	pTweakVCDownText.SetValue(3)  ; Cancel 
	pTweakVCLeftText.SetValue(1)  ; Rotate
	pTweakVCRightText.SetValue(1) ; Rotate						
	Trace("SculptLeveled: Activating StartChoice()")
	self.GotoState("ShowSculpt")

	; Special radius 0 means, dont move them...
	pTweakVCScript.StartChoice(realNPC, self, 0)
	
	; See Callbacks below in the ShowSculpt State for continuation of code...
	if added_female
		realNPC.RemoveKeyword(female)
	elseif added_playerkeyword
		realNPC.RemoveKeyword(PlayerKeyword)
	endif
	
EndFunction

; This will fire when we delete the Mirror, whether they activate sculpt menu or not...
Event ObjectReference.OnExitFurniture(ObjectReference akFurn, ObjectReference akActionRef)
	Trace("OnExitFurniture")
	UnregisterForRemoteEvent(akFurn,"OnExitFurniture")
	Actor pc = Game.GetPlayer()
    float[] posdata = TraceCircle(pc, radius=72, angleOffset=0)
	akActionRef.SetAngle(0.0,0.0, Enforce360Bounds(pc.GetAngleZ() - 180))
	akActionRef.SetPosition(posdata[0],posdata[1],(posdata[2]))
EndEvent

; Do stuff like cleanup when they close the Menu...
Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	if (asMenuName == "LooksMenu")
		If abOpening == False
			Trace("OnMenuOpenCloseEvent : LooksMenu closed. Registering for FirstPersonInitialized (To get skeleton reset)")
			
			; Scene keys off existance of Mirror. Delete quickly to free up actor from scene.
			ObjectReference akFurn = pSculptMirror.GetReference()
			pSculptMirror.Clear()
			if akFurn
				akFurn.Delete()
			endif
			
			UnRegisterForMenuOpenCloseEvent("LooksMenu")
			Actor npc = pSculptTarget.GetActorReference()
			if (!npc)
				Trace("pSculptTarget Empty. Aborting...")
				return
			endif
			
			; RegisterForAnimationEvent(npc, "FirstPersonInitialized")
			
			;make sure the CharGen skeleton has been removed
			npc.SetHasCharGenSkeleton(False)
			
			; make sure actor face is back to archetype
			npc.ChangeAnimFaceArchetype(AnimFaceArchetypePlayer)

			;wait until the player graph has been fully re-initialized from the chargenskeleton set
			;failsafe the wait to last 5 seconds, if we haven't gotten the animation event by then, move forward

			; NOTE : Commented out as it seems to never fire and just causes a delay...
			;        We just have to trust that it eventually unloads.
			
			; int var_SkeletonResetFailsafeCount = 0
			; While (var_SkeletonResetDone == False) && (var_SkeletonResetFailsafeCount < 5)
				; Trace("Waiting for var_SkeletonResetDone")
				; Utility.Wait(1.0)
				; var_SkeletonResetFailsafeCount += 1
			; EndWhile
			
			; Restore the outfit (if management was enabled)
			
			if (LeveledNPCSrc)
			
				; LeveledNPCSrc = original
				; npc = leveled spawn for editing...
				
				pSculptTarget.Clear()
				if (wasReadyWeapon)
					npc.AddKeyword(pTeammateReadyWeapon_DO)
				endif
				
				LeveledNPCSrc.SetAvoidPlayer(false)
				npc.SetAvoidPlayer(false)
								
				; TODO : Disable npc and move LeveledNPCSrc to 
				;        npc, remove spell effect
				float posx = npc.GetPositionX()
				float posy = npc.GetPositionY()
				float posz = npc.GetPositionZ()
				
				; Don't disable the BASE ACTOR or it causes the real actor to disappear.
				npc.RemoveFromFaction(pTweakPosedFaction)
				TweakFollowerScript pTweakFollowerScript = (self as Quest) as TweakFollowerScript
				if pTweakFollowerScript
					pTweakFollowerScript.UnManageFollower(npc)
				else
					Trace("Error : Unable to cast to TweakFollowerScript. Killing NPC to force cleanup")
					npc.Kill()
					Utility.wait(0.1)
				endif
				
				npc.Disable()
				
				LeveledNPCSrc.SetPosition(posx, posy, posz)
				LeveledNPCSrc.SetAngle(0.0, 0.0,  Enforce360Bounds(Game.GetPlayer().GetAngleZ() - 180))				
				LeveledNPCSrc.RemoveSpell(MQ203PlayerInvisibility)
				LeveledNPCSrc.RemoveFromFaction(pTweakPosedFaction)
				LeveledNPCSrc = NONE
				
				pTweakReloadRequired.Show()
			else
			
				if npc.HasKeyword(pActorTypeGhoul) || npc.HasKeyword(pActorTypeHuman) || npc.HasKeyword(pActorTypeSynth) || npc.HasKeyword(pActorTypeSuperMutant)
					AFT:TweakInventoryControl pTweakInventoryControl = (parts_storage as ReferenceAlias) as AFT:TweakInventoryControl
					if (pTweakInventoryControl)
						Trace("Attempting to Restoring/Clear Snapshot Outfit")
						pTweakInventoryControl.ClearTweakOutfit(5)
						Utility.wait(0.1)
						checkWasManaged(npc)
					else
						Trace("Cast of pSculptTarget to TweakInventoryControl Failed.")			
					endif
				endif

				pSculptTarget.Clear()
			
				if (wasReadyWeapon)
					Trace("Restoring keyword TeammateReadyWeapon_DO")
					npc.AddKeyword(pTeammateReadyWeapon_DO)
					npc.AddToFaction(pTweakReadyWeaponFaction)
				endif
				npc.SetAvoidPlayer(false)
				npc.RemoveFromFaction(pTweakPosedFaction)
			endif
			
			parts_storage = None

			; UnRegisterForAnimationEvent(npc, "initiateStart")
			; var_SkeletonResetDone=False
			
		EndIf
	EndIf	
EndEvent

Function NewBody(TweakAppearance pTweakAppearance)

	Trace("NewBody() Called")
	
	Actor npc = (pTweakAppearance as ReferenceAlias).GetActorRef()
	if (!npc)
		Trace("Cast of TweakAppearance to Actor Failed. Aborting...")
		return
	endif
	
	; The following is checked by TweakPipBoy before relaying the Pose Event:
	; assert pTweakVisualChoice.IsRunning()
    ; assert !npc.IsInFaction(pTweakPosedFaction)
	; assert !npc.WornHasKeyword(pArmorTypePower)
	; assert !npc.IsInCombat()
    ; assert !npc.IsInScene()
	
	TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
	if (!pTweakVCScript)
		Trace("Unable to cast TweakVisualChoiceScript")
		return
	endif
	
	; Remember the script/NPC for later...
	parts_storage    = pTweakAppearance

	; 1 = Wait + HeadTurn
	; 2 = Wait
	; 3 = Use/Sit LinkedRef object TweakPoseTarget
	; 4 = Use IdleMarker object TweakPoseTarget
	
	prePosedRank = npc.GetFactionRank(pTweakPosedFaction)
	npc.SetFactionRank(pTweakPosedFaction,1)
	npc.EvaluatePackage()
	Utility.wait(0.1)
	
	npc.SetAvoidPlayer(true)
	; npc.EnableAI(false,true)
		
	; Teleport NPC behind the player to ensure they wont collide with the mirror
	; and to prevent clothes blinking...
	
	Trace("Moving NPC behind Player")
	Actor pc = Game.GetPlayer()	
    float[] posdata = TraceCircle(pc,-120,0)
	npc.SetPosition(posdata[0],posdata[1],posdata[2])
	npc.SetAngle(0.0, 0.0,  Enforce360Bounds(pc.GetAngleZ()))	

	wasManaged = false
	; Take SnapShot:
	AFT:TweakInventoryControl pTweakInventoryControl = (pTweakAppearance as ReferenceAlias) as AFT:TweakInventoryControl
	if (pTweakInventoryControl)
		if npc.HasKeyword(pActorTypeGhoul) || npc.HasKeyword(pActorTypeHuman) || npc.HasKeyword(pActorTypeSynth) || npc.HasKeyword(pActorTypeSuperMutant)
			if npc.GetRace() == pSynthGen2RaceValentine
				Trace("OnChoiceBegin(): Nick Valentine detected")
				TweakFollowerScript pTweakFollowerScript = (self as Quest) as TweakFollowerScript
				if pTweakFollowerScript
					pTweakFollowerScript.AddNickItems()
				endif
			endif
			
			Trace("Taking Outfit Snapshot.")
			pTweakInventoryControl.SetTweakOutfit(5, true) ;  5 == OUTFIT_SNAPSHOT
			Utility.wait(0.3)

			; If it is OK to leave them clothed, then you can pass in true and the UNEQUIP will be
			; ignored unless they are managed. Most appearance commands (except expression and posture)
			; will strip them down. Keep in mind, it will be restored once they are managed.
			wasManaged = pTweakInventoryControl.IsManaged()
			pTweakInventoryControl.UnEquipAllGear()
			Utility.wait(0.1)			
		else
			Trace("Skipping Outfit Snapshot. Unsupported NPC (Not human, ghoul, synth or supermutant)")
		endif		
	endif	
	
	; If the player has a weapon out, make sure the NPC doesn't care:
	wasReadyWeapon = npc.IsInFaction(pTweakReadyWeaponFaction)
	if (wasReadyWeapon)
		npc.RemoveFromFaction(pTweakReadyWeaponFaction)
		npc.RemoveKeyword(pTeammateReadyWeapon_DO)
	endif
	
	; Get/Create Mr. Invisible ... 	
	Actor invguy = pInvisibleGuy.GetActorReference()
	if !invguy	
		invguy = pTweakInvisibleGuy.GetUniqueActor()
		if !invguy
			invguy = npc.PlaceActorAtMe(pTweakInvisibleGuy) as Actor
		endif
		if (invguy)
			pInvisibleGuy.ForceRefTo(invguy)
		endif		
	endif
	if (invguy)
		; Movement functions will not work unless he is enabled (including AI)
		if invguy.IsDisabled()
			invguy.Enable()
		endif
		if !invguy.IsAIEnabled()
			invguy.EnableAI(true)
		endif
		if invguy.IsUnconscious()
			invguy.SetUnconscious(false)
		endif
	endif
	
	posdata = TraceCircleOffsets(pc,-200,0)
	invguy.MoveToIfUnloaded(pc,posdata[0],posdata[1],posdata[2])
	invguy.AllowPCDialogue(true)
	
	posdata = TraceCircle(pc,25,0)	
	invguy.SetPosition(posdata[0],posdata[1],posdata[2])
	invguy.SetAngle(0,0,invguy.GetAngleZ() + invguy.GetHeadingAngle(pc))
	
	; TweakNewBodyData FormList Entry Structure:
	; index 0    : ActorBase of Actor with Template poiting to LeveledActor that inherits Traits
	; index 1    : Root LeveledActor Template that index 0 uses for options. Each entry should be another Leveled Actor
	; index 2..N : GlobalVariables which will be set to 100 to prevent the original Leveled Actors from being chosen during Reset operations.	
	; index N..K : ActorBases of NPCs to offer as options. Note: Each option should have the same VoiceType as the original Actor
	
	PartsList = None
	ActorBase npcbase = npc.GetActorBase()
	int i = 0
	int BodyDataSize = pTweakNewBodyData.GetSize()
	Trace("TweakNewBodyData.GetSize() = [" + BodyDataSize + "]")
	while (i != BodyDataSize && !PartsList)
		Trace("Checking TweakNewBodyData[" + i + "]")
		FormList BodyData = pTweakNewBodyData.GetAt(i) As FormList
		if (BodyData.GetSize() > 0 && (BodyData.GetAt(0) as ActorBase) == npcbase)
			Trace("TweakNewBodyData[" + i + "] has ActorBase!")
			PartsList = BodyData
		endif
		i += 1
	endwhile
	if (!PartsList)
		Trace("ActorBase for NPC not found in TweakNewBodyData")
		pInvisibleGuy.Clear()
		invguy.Disable()
		npc.RemoveFromFaction(pTweakPosedFaction)
		posdata = TraceCircle(pc, 60,0)
		npc.SetPosition(posdata[0],posdata[1],posdata[2])		
		npc.SetAngle(0.0,0.0,  npc.GetAngleZ() + npc.GetHeadingAngle(pc))	
		return
	endif
			
	; We need to remember the original values of the globals as we will
	; need to restore them after the choice is made (Globals may inheritanly
	; maintain additional quest state outside the leveled actor list choice..)
	; We dont actually have to do this now, but we need to pre-scan the data
	; anyway to see where the boundary is, so might as well store them off.
	
	restore_global_values.clear()
	BodyDataSize = PartsList.GetSize()
	Trace("BodyDataSize.GetSize() = [" + BodyDataSize + "]")
	i = 2
	GlobalVariable gv = pTweakVCUpText
	while (i < BodyDataSize && gv)
		gv = PartsList.GetAt(i) As GlobalVariable
		if (gv)
			restore_global_values.Add(gv.GetValue())
			Trace("Setting gv [" + gv + "] to 100")
			gv.SetValue(100)
			if (100.0 == gv.GetValue())
				Trace("Confirmed")
			else
				Trace("GlobalVariable change attempt failed")
			endif			
		endif
		i += 1
	endwhile

	; Calling Actor.reset() also removes/resets all actor values. We have to
	; store important ones  off here because once the NPC is DISABLED, calls to GetValue()
	; will return 0.0, no matter what the real actor value is. (This is probably a 
	; bug in Papyrus). Anyway, we avoid it by storing the values upfront.
	
	restore_actor_values.clear()
	int ActorValueListSize = pTweakActorValuesToSave.GetSize()
	Trace("ActorValueListSize = [" + ActorValueListSize + "]")
	i = 0
	ActorValue av = pTweakScale
	float avf = npc.GetValue(pTweakScale)
	Trace("Noting av [" + av + "] [" + avf + "]")	
	while (i < ActorValueListSize)
		av = pTweakActorValuesToSave.GetAt(i) As ActorValue
		if (av)
			avf = npc.GetValue(av)
			Trace("Storing av [" + av + "] [" + avf + "]")
			restore_actor_values.Add(avf)
		else
			Trace("TweakActorValuesToSave[" + i + "] did not cast to ActorValue. Skipping")
			restore_actor_values.Add(0.0)
		endif
		i += 1
	endwhile
	
	; Needed for restoration:
	original_vt = npc.GetVoiceType()
	
	; Setup Visual Choice Menu...
	pTweakVCUpText.SetValue(3)    ; Choose
	pTweakVCDownText.SetValue(1)  ; Done 
	pTweakVCLeftText.SetValue(2)  ; Prev
	pTweakVCRightText.SetValue(2) ; Next
	
	; Finally Activate the Chooser by setting the state. Chooser can deduce 
	; how many actor options there are by the size of the restore_global_values array.
		
	Trace("restore_global_values.Length = [" + restore_global_values.Length + "]")
	parts_index  = restore_global_values.Length + 2
	parts_choice = parts_storage.CurrentBodyId
	
	if (parts_choice > -1)
		parts_index = parts_choice
	endif

	Trace("parts_choice = [" + parts_choice + "]")
	Trace("parts_index  = [" + parts_index + "]")
		
	body_dummies = new Actor[BodyDataSize - 2 - restore_global_values.Length]
	i = 0
	int body_dummies_len = body_dummies.Length
	while (i < body_dummies_len)
		Trace("Initializing body_dummies[" + i + "] to None")
		body_dummies[i] = None
		i += 1
	endWhile
	
	int maxwait= 5 
	while (None != pSculptTarget.GetActorRef() && maxwait > 0)
		Trace("Waiting for Sculpt Target to clear")
		Utility.wait(1.0)
		maxwait -= 1
	endwhile	

	; Tp retrieve the NPC and Scene access if need be...
	pSculptTarget.ForceRefTo(npc)
		
	Trace("Activating StartChoice()")
	self.GotoState("ShowBodies")
	
	invguy.AllowPCDialogue(true)
	pTweakVCScript.StartChoice(invguy, self, 0)
	; Note the "self" paramater. The chooser will call back events on this script.
	; handler will depend on the STATE. Hence the call to ShowBodies above...
EndFunction

Function EyeParts(TweakAppearance pTweakAppearance)
	Trace("EyeParts() Called")

	Actor npc = (pTweakAppearance as ReferenceAlias).GetActorRef()
	if (!npc)
		Trace("Cast of TweakAppearance to Actor Failed. Aborting...")
		return
	endif
	
	; The following is checked by TweakPipBoy before relaying the Pose Event:
	; assert pTweakVisualChoice.IsRunning()
    ; assert !npc.IsInFaction(pTweakPosedFaction)
	; assert !npc.WornHasKeyword(pArmorTypePower)
	; assert !npc.IsInCombat()
    ; assert !npc.IsInScene()
		
	TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
	if (!pTweakVCScript)
		Trace("Unable to cast TweakVisualChoiceScript")
		return
	endif
	
	; 1 = Wait + HeadTurn
	; 2 = Wait
	; 3 = Use/Sit LinkedRef object TweakPoseTarget
	; 4 = Use IdleMarker object TweakPoseTarget
	
	prePosedRank = npc.GetFactionRank(pTweakPosedFaction)
	npc.SetFactionRank(pTweakPosedFaction,1)
	npc.EvaluatePackage()
	
	parts_storage = pTweakAppearance	

	; Head ID (TweakHeadParts)
	;0: Human Female
	;1: Ghoul Female
	;2: Synth Gen 1
	;3: SynthGen 2
	;4: Child Female
	;5: Child Ghoul
	;6: Child Male
	;7: Human Male
	;8: Ghoul Male	
	
	PartsList = pTweakEyeParts
	int chid = pTweakAppearance.CurrentHeadId
	if (4 ==chid || 5 == chid || 6 == chid)
		Trace("Current Head ID is [" + chid + "]. Setting Eye Parts to Child")
		PartsList = pTweakEyeChildParts
	else
		Trace("Current Head ID is [" + chid + "]. Using default eye parts")
	endif
	
	; Todo : Is it possible to increase FOV for zoom? I suspect the only
	; hope is via a scene dialogue camera. This would need its own state/handler
	; if it is possible... May not be necessary if SetGhost works like I hope it does...
	
	SetupAndRunShowParts(parts_storage.CurrentEyesId)
	
EndFunction

Function HeadParts(TweakAppearance pTweakAppearance)
	Trace("HeadParts() Called")
	Actor npc = (pTweakAppearance as ReferenceAlias).GetActorRef()
	if (!npc)
		Trace("Cast of TweakAppearance to Actor Failed. Aborting...")
		return
	endif

	; The following is checked by TweakPipBoy before relaying the Pose Event:
	; assert pTweakVisualChoice.IsRunning()
    ; assert !npc.IsInFaction(pTweakPosedFaction)
	; assert !npc.WornHasKeyword(pArmorTypePower)
	; assert !npc.IsInCombat()
    ; assert !npc.IsInScene()
	
	TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
	if (!pTweakVCScript)
		Trace("Unable to cast TweakVisualChoiceScript")
		return
	endif
	
	; 1 = Wait + HeadTurn
	; 2 = Wait
	; 3 = Use/Sit LinkedRef object TweakPoseTarget
	; 4 = Use IdleMarker object TweakPoseTarget
	
	prePosedRank = npc.GetFactionRank(pTweakPosedFaction)
	npc.SetFactionRank(pTweakPosedFaction,1)
	npc.EvaluatePackage()
	
	parts_storage = pTweakAppearance
	
	PartsList = pTweakHeadParts
	
	SetupAndRunShowParts(parts_storage.CurrentHeadId)
	
EndFunction

Function HairParts(TweakAppearance pTweakAppearance)
	Trace("HairParts() Called")
	Actor npc = (pTweakAppearance as ReferenceAlias).GetActorRef()
	if (!npc)
		Trace("Cast of TweakAppearance to Actor Failed. Aborting...")
		return
	endif

	; The following is checked by TweakPipBoy before relaying the Pose Event:
	; assert pTweakVisualChoice.IsRunning()
    ; assert !npc.IsInFaction(pTweakPosedFaction)
	; assert !npc.WornHasKeyword(pArmorTypePower)
	; assert !npc.IsInCombat()
    ; assert !npc.IsInScene()

	TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
	if (!pTweakVCScript)
		Trace("Unable to cast TweakVisualChoiceScript")
		return
	endif
	
	; 1 = Wait + HeadTurn
	; 2 = Wait
	; 3 = Use/Sit LinkedRef object TweakPoseTarget
	; 4 = Use IdleMarker object TweakPoseTarget
	
	prePosedRank = npc.GetFactionRank(pTweakPosedFaction)
	npc.SetFactionRank(pTweakPosedFaction,1)
	npc.EvaluatePackage()
	
	parts_storage = pTweakAppearance
	
	PartsList = pTweakHairParts
	
	SetupAndRunShowParts(parts_storage.CurrentHairId)
	
EndFunction

Function BeardParts(TweakAppearance pTweakAppearance)
	Trace("BeardParts() Called")
	Actor npc = (pTweakAppearance as ReferenceAlias).GetActorRef()
	if (!npc)
		Trace("Cast of TweakAppearance to Actor Failed. Aborting...")
		return
	endif
	
	; The following is checked by TweakPipBoy before relaying the Pose Event:
	; assert pTweakVisualChoice.IsRunning()
    ; assert !npc.IsInFaction(pTweakPosedFaction)
	; assert !npc.WornHasKeyword(pArmorTypePower)
	; assert !npc.IsInCombat()
    ; assert !npc.IsInScene()

	TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
	if (!pTweakVCScript)
		Trace("Unable to cast TweakVisualChoiceScript")
		return
	endif
	
	; 1 = Wait + HeadTurn
	; 2 = Wait
	; 3 = Use/Sit LinkedRef object TweakPoseTarget
	; 4 = Use IdleMarker object TweakPoseTarget
	
	prePosedRank = npc.GetFactionRank(pTweakPosedFaction)
	npc.SetFactionRank(pTweakPosedFaction,1)
	npc.EvaluatePackage()
	
	parts_storage = pTweakAppearance		
		
	PartsList = pTweakBeardParts
	
	SetupAndRunShowParts(parts_storage.CurrentBeardId)
	
EndFunction

Bool Function UnlockAppearance(Actor npc)

	Trace("UnlockAppearance() Called")

	; When we change races, it unlocks the ability to edit the NPC.
	; But SetRace() is a No-Op when you pass in the current race. So we
	; have to "blink" to the custom invisible race briefly and then back. 
	; This allows the Appearance to be changed...
	
	if (npc.WornHasKeyword(pArmorTypePower))
		return false
	endif
	
	Race pOriginalRace    = npc.GetRace()
	if (!pOriginalRace)
		Trace("Unable to identify Race. Aborting...")		
		return false
	endif
	Trace("Attempting to Change Race to Invisible")
	npc.SetRace(pTweakInvisibleRace)
	
	int maxwait = 6
	while (npc.GetRace() != pTweakInvisibleRace && maxwait > 0)
		Trace("Waiting for Race Change")
		Utility.waitmenumode(0.2)
		maxwait -= 1
	endwhile
	Trace("Complete. Attempting to Change Race to Back to Original")
	npc.SetRace(pOriginalRace)
	maxwait = 6
	while (npc.GetRace() != pOriginalRace && maxwait > 0)
		Trace("Waiting for Race Change Back")
		Utility.waitmenumode(0.2)
		maxwait -= 1
	endwhile
	Bool ret = (npc.GetRace() == pOriginalRace)
	Trace("Unlock Complete. Returning [" + ret + "]")
	return (ret)

EndFunction

; NOTES: When you call setheadpart, it causes the model to reload 
;        which in turn calls the OnLoad() event, which is
;        monitored by scripts like TweakSettings and TweakInventory.
;        So despite being naked, TweakInventory will keep trying to
;        put their clothes back on. 
Function SetupAndRunShowParts(int current_choice = -1)
	Trace("SetupAndRunShowParts()")

	Actor npc = parts_storage.GetActorReference()	
	TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
	if (!pTweakVCScript)
		Trace("Unable to cast TweakVisualChoiceScript")
		return
	endif
	
	Trace("current_choice = [" + current_choice + "]")
	Trace("parts_choice   = [" + parts_choice  + "]")
	Trace("parts_index    = [" + parts_index + "]")
	
	if (current_choice > -1)
		parts_choice = current_choice
		parts_index  = current_choice
	else
		parts_choice = -1
		parts_index  = 0
	endif
	
	pTweakVCUpText.SetValue(3)    ; Choose
	pTweakVCDownText.SetValue(1)  ; Done 
	pTweakVCLeftText.SetValue(2)  ; Prev
	pTweakVCRightText.SetValue(2) ; Next	

	wasManaged = true
	; Take SnapShot:
	AFT:TweakInventoryControl pTweakInventoryControl = (parts_storage as ReferenceAlias) as AFT:TweakInventoryControl
	if (pTweakInventoryControl)
		if npc.HasKeyword(pActorTypeGhoul) || npc.HasKeyword(pActorTypeHuman) || npc.HasKeyword(pActorTypeSynth) || npc.HasKeyword(pActorTypeSuperMutant)
			if npc.GetRace() == pSynthGen2RaceValentine
				Trace("OnChoiceBegin(): Nick Valentine detected")
				TweakFollowerScript pTweakFollowerScript = (self as Quest) as TweakFollowerScript
				if pTweakFollowerScript
					pTweakFollowerScript.AddNickItems()
				endif
			endif
			
			pTweakInventoryControl.SetTweakOutfit(5, true) ;  5 == OUTFIT_SNAPSHOT
			Utility.wait(0.3)

			; If it is OK to leave them clothed, then you can pass in true and the UNEQUIP will be
			; ignored unless they are managed. Most appearance commands (except expression and posture)
			; will strip them down. Keep in mind, it will be restored once they are managed.
			;
			; In this case, they may hit cancel and not choose any of the models, so we 
			; simply do nothing if they are not managed...
			wasManaged = pTweakInventoryControl.IsManaged()
			pTweakInventoryControl.UnEquipAllGear()
			Utility.wait(0.1)
		endif
		pTweakInventoryControl.processLoadEvents = false
	else
		Trace("SetupAndRunShowParts(): parts_storage cast to TweakInventoryControl Failed")
	endif
	
	; If pc has weapon drawn, make sure NPC doesn't care...
	wasReadyWeapon = npc.IsInFaction(pTweakReadyWeaponFaction)
	if (wasReadyWeapon)
		Trace("NPC is set to sync Weapon. Removing keyword and Faction membership")
		npc.RemoveFromFaction(pTweakReadyWeaponFaction)
		npc.RemoveKeyword(pTeammateReadyWeapon_DO)
	else
		Trace("NPC is NOT set to sync Weapon")
	endif
	
	Trace("Activating StartChoice()")
	self.GotoState("ShowParts")
	if (prePosedRank > -1)
		pTweakVCScript.StartChoice(npc,self, 0)
	else
		pTweakVCScript.StartChoice(npc,self, 30, 30)
	endif	
	
EndFunction

Function HandleBodyDisplay(bool aDisable = false)
		
	Trace("HandleBodyDisplay()")
	int bd_index = parts_index - 2 - restore_global_values.Length
	Actor body = body_dummies[bd_index]
	if aDisable
		if body
			body.RemoveFromFaction(pTweakIgnoredFaction)
			body.Disable()
		endif
		int maxwait = 5
		while ((body.IsEnabled() || body.Is3DLoaded()) && maxwait > 0)
			Trace("Waiting for Disbale to finish")
			maxwait -= 1
			Utility.wait(1.0)
		endwhile
		return
	endif

	Actor pc = Game.GetPlayer()	
	
	if !body	
		ActorBase baseBody = PartsList.GetAt(parts_index) as ActorBase
		if !baseBody
			Trace("HandleBodyDisplay - PartsList[" + parts_index + "] did not cast to ActorBase")
			return
		endif		
		Actor spawnloc = pSculptTarget.GetActorReference()
		if !spawnloc
			spawnloc = (parts_storage as ReferenceAlias).GetActorRef() 
		endif
		if (spawnloc)
			body = spawnloc.PlaceAtMe(baseBody) As Actor
		else
			body = pc.PlaceAtMe(baseBody) As Actor
		endif
		
		if (!body)
			Trace("Actor creation failure.")
			return
		endif
		
		pSculptTarget.ForceRefTo(body)
		body.EvaluatePackage()
		float[] posdata = TraceCircle(pc,90,0)
		body.SetPosition(posdata[0],posdata[1],posdata[2])
		body.SetAngle(0.0,0.0,  body.GetAngleZ() + body.GetHeadingAngle(pc))
		body.AllowPCDialogue(false)
		; Prevent user from activating body dummy once they make choice... 
		body.AddToFaction(pTweakIgnoredFaction)
		body_dummies[bd_index] = body
	elseif (!body.IsEnabled())
		pSculptTarget.ForceRefTo(body)
		body.Enable()
		body.EvaluatePackage()
		float[] posdata = TraceCircle(pc,90,0)
		body.SetPosition(posdata[0],posdata[1],posdata[2])
		body.SetAngle(0.0,0.0, body.GetAngleZ() + body.GetHeadingAngle(pc))
	endif
	
	StartTimer(2,FLOOD_PROTECTION_BODYS) ; Event Flood Protection
	
EndFunction

Function HandlePartDisplay(bool removeit=false)
	Trace("HandlePartDisplay(" + removeit + ")")
	
	Actor npc       = parts_storage.GetActorReference()
	Form theForm    = PartsList.GetAt(parts_index)
	FormList pieces = theForm as FormList
	
	if pieces
		int numpieces = pieces.GetSize()
		int i = 0
		Trace("Composite HeadPart. Updating [" + numpieces + "] HeadParts.")
		while (i != numpieces)
			HeadPart pp = pieces.GetAt(i) as HeadPart	
			if (pp)
				npc.ChangeHeadPart(apHeadPart=pp, abRemovePart=removeit, abRemoveExtraParts=removeit)
			else
				Trace("PartsList[" + parts_index + "][" + i + "] did not cast to HeadPart")
			endif
			i += 1
		endWhile
		StartTimer(2,FLOOD_PROTECTION_PARTS) ; Event Flood Protection
		return
	endif
		
	HeadPart hp = theForm as HeadPart		
	if (!hp)
		Trace("PartsList[" + parts_index + "] did not cast to FormList or HeadPart")
		return
	endif
		
	npc.ChangeHeadPart(apHeadPart=hp, abRemovePart=removeit, abRemoveExtraParts=removeit)
	
	StartTimer(2,FLOOD_PROTECTION_PARTS) ; Event Flood Protection
	
EndFunction


Function checkWasManaged(Actor npc)
	if !wasManaged
		if npc.GetRace() == pSynthGen2RaceValentine
			Armor TweakNickValentineCoat	= Game.GetFormFromFile(0x0103E7D1,"AmazingFollowerTweaks.esp") as Armor
			npc.EquipItem(TweakNickValentineCoat)
		elseif npc.HasKeyword(pActorTypeGhoul) || npc.HasKeyword(pActorTypeHuman) || npc.HasKeyword(pActorTypeSynth)
			Armor Armor_Raider_Underarmor = Game.GetForm(0x000AF0E2) as Armor
			npc.EquipItem(Armor_Raider_Underarmor)			
		elseif npc.HasKeyword(pActorTypeSuperMutant)
			Armor SupermutantArmor1_Arms = Game.GetForm(0x001B3A03) as Armor
			Armor SupermutantArmor1_Lower = Game.GetForm(0x001B3A05) as Armor
			npc.EquipItem(SupermutantArmor1_Arms)			
			npc.EquipItem(SupermutantArmor1_Lower)						
		endif
	endif
EndFunction

State ShowParts

	Function OnChoiceBegin()
		Trace("OnChoiceBegin(): ShowParts")

		Actor npc = parts_storage.GetActorReference()
		if (None == npc)
			Trace("parts_storage not set. Aborting")
			TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
			if (pTweakVCScript)
				pTweakVCScript.EndChoice()
			endif
			return
		endif	
		
		Actor pc = Game.GetPlayer()		
						
		int maxindex = PartsList.GetSize() - 1
		if (parts_choice > maxindex)
			Trace("current part choice out of range. Resetting")
			parts_choice = -1
			parts_index  = 0
		endif			
		
		HandlePartDisplay()
		
	EndFunction

	Function OnChooseUp() ; add
		parts_choice = parts_index
		; pTweakOptionChosen => "Option [25] Chosen"
		pTweakOptionChosen.Show((parts_choice + 1))
	EndFunction

	Function OnChooseDown()
		TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
		if (pTweakVCScript)
			pTweakVCScript.EndChoice()
		endif
	EndFunction
	
	Function OnChooseLeft() ; prev
		HandlePartDisplay(true)
		parts_index -= 1
		if (parts_index < 0)
			parts_index = (PartsList.GetSize() - 1)
		endif
		HandlePartDisplay()		
	EndFunction

	Function OnChooseRight() ; next
		HandlePartDisplay(true)
		parts_index += 1
		if (parts_index == PartsList.GetSize())
			parts_index = 0
		endif
		HandlePartDisplay()
	EndFunction

	Function OnChoiceEnd()
	
		; Unless they "Chose" something, dont store it...
		if (parts_choice > -1)
			if (parts_index != parts_choice)
				HandlePartDisplay(true)
				parts_index = parts_choice
				HandlePartDisplay()
				pTweakOptionRestored.Show((parts_choice + 1))				
			endif
			if PartsList == pTweakEyeParts
				parts_storage.CurrentEyesId = parts_choice
				parts_storage.CurrentEyesForm = pTweakEyeParts.GetAt(parts_choice)					
			elseif PartsList == pTweakEyeChildParts
				parts_storage.CurrentEyesId = parts_choice
				parts_storage.CurrentEyesForm = pTweakEyeChildParts.GetAt(parts_choice)					
			elseif PartsList == pTweakHairParts
				parts_storage.CurrentHairId = parts_choice
				parts_storage.CurrentHairForm = pTweakHairParts.GetAt(parts_choice)					
			elseif PartsList == pTweakBeardParts
				parts_storage.CurrentBeardId = parts_choice
				parts_storage.CurrentBeardForm = pTweakBeardParts.GetAt(parts_choice)					
			elseif PartsList == pTweakHeadParts
				parts_storage.CurrentHeadId = parts_choice
				parts_storage.CurrentHeadForm = pTweakHeadParts.GetAt(parts_choice)
				parts_storage.CurrentBeardId = 36
				parts_storage.CurrentBeardForm = pTweakBeardParts.GetAt(36)					
				if (0 == parts_choice)      ; TweakHumanSetupFemale
					parts_storage.CurrentEyesId    = 14
					parts_storage.CurrentEyesForm  = pTweakEyeParts.GetAt(14)					
					parts_storage.CurrentHairId    = 0
					parts_storage.CurrentHairForm  = pTweakHairParts.GetAt(0)					
				elseif (1 == parts_choice)  ; TweakGhoulSetupFemale
					parts_storage.CurrentEyesId    = 21
					parts_storage.CurrentEyesForm  = pTweakEyeParts.GetAt(21)
					parts_storage.CurrentHairId    = 0
					parts_storage.CurrentHairForm  = pTweakHairParts.GetAt(0)					
				elseif (2 == parts_choice)  ; TweakSynthGen1Setup
					parts_storage.CurrentEyesId    = 54
					parts_storage.CurrentEyesForm  = pTweakEyeParts.GetAt(54)
					parts_storage.CurrentHairId    = 75
					parts_storage.CurrentHairForm  = pTweakHairParts.GetAt(75)					
				elseif (3 == parts_choice)  ; TweakSynthGen2Setup
					parts_storage.CurrentEyesId    = 54
					parts_storage.CurrentEyesForm  = pTweakEyeParts.GetAt(54)
					parts_storage.CurrentHairId    = 75
					parts_storage.CurrentHairForm  = pTweakHairParts.GetAt(75)					
				elseif (4 == parts_choice)  ; TweakChildFemaleSetup
					parts_storage.CurrentEyesId    = 1
					parts_storage.CurrentEyesForm  = pTweakEyeChildParts.GetAt(1)
					parts_storage.CurrentHairId    = 37
					parts_storage.CurrentHairForm  = pTweakHairParts.GetAt(37)					
				elseif (5 == parts_choice)  ; TweakChildGhoulSetup
					parts_storage.CurrentEyesId    = 5
					parts_storage.CurrentEyesForm  = pTweakEyeChildParts.GetAt(5)
					parts_storage.CurrentHairId    = 38
					parts_storage.CurrentHairForm  = pTweakHairParts.GetAt(38)					
				elseif (6 == parts_choice)  ; TweakChildMaleSetup
					parts_storage.CurrentEyesId    = 11
					parts_storage.CurrentEyesForm  = pTweakEyeChildParts.GetAt(11)
					parts_storage.CurrentHairId    = 39
					parts_storage.CurrentHairForm  = pTweakHairParts.GetAt(39)
				elseif (7 == parts_choice)  ; TweakHumanSetupMale
					parts_storage.CurrentEyesId    = 42
					parts_storage.CurrentEyesForm  = pTweakEyeParts.GetAt(42)
					parts_storage.CurrentHairId    = 41
					parts_storage.CurrentHairForm  = pTweakHairParts.GetAt(41)					
				elseif (8 == parts_choice)  ; TweakGhoulSetupMale
					parts_storage.CurrentEyesId    = 49
					parts_storage.CurrentEyesForm  = pTweakEyeParts.GetAt(49)
					parts_storage.CurrentHairId    = 41
					parts_storage.CurrentHairForm  = pTweakHairParts.GetAt(41)					
				endif					
			endif
		endif
		
		Actor npc = parts_storage.GetActorReference()
		if (prePosedRank > -1)
			npc.SetFactionRank(pTweakPosedFaction, prePosedRank)
		else
			npc.RemoveFromFaction(pTweakPosedFaction)
		endif

		if (wasReadyWeapon)
			Trace("Restoring keyword TeammateReadyWeapon_DO")
			npc.AddKeyword(pTeammateReadyWeapon_DO)
			npc.AddToFaction(pTweakReadyWeaponFaction)
		endif
		
		; Restore the outfit (if management was enabled)
		if npc.HasKeyword(pActorTypeGhoul) || npc.HasKeyword(pActorTypeHuman) || npc.HasKeyword(pActorTypeSynth) || npc.HasKeyword(pActorTypeSuperMutant)
			AFT:TweakInventoryControl pTweakInventoryControl = (parts_storage as ReferenceAlias) as AFT:TweakInventoryControl
			if (pTweakInventoryControl)
				pTweakInventoryControl.processLoadEvents = true

				Trace("Attempting to Restoring/Clear Snapshot Outfit")
				pTweakInventoryControl.ClearTweakOutfit(5)
				Utility.wait(0.1)
				checkWasManaged(npc)
				
			else
				Trace("Cast of parts_storage to ReferenceAlias to TweakInventoryControl Failed.")			
			endif
		endif
		
		parts_storage = None
		self.GotoState("None")
	EndFunction
	
EndState

State ShowExpressions

	Function OnChoiceBegin()
		Trace("OnChoiceBegin(): ShowExpressions")

		Actor npc = parts_storage.GetActorReference()
		if (None == npc)
			Trace("parts_storage not set. Aborting")
			TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
			if (pTweakVCScript)
				pTweakVCScript.EndChoice()
			endif
			return
		endif	
		
		Actor pc = Game.GetPlayer()		
		
		int maxindex = PartsList.GetSize() - 1
		if (parts_choice > maxindex)
			Trace("current part choice out of range. Resetting")
			parts_choice = -1
			parts_index  = 0
		endif

		Keyword fa = PartsList.GetAt(parts_index) as Keyword
		if (fa)
			npc.ChangeAnimFaceArchetype(fa)
			StartTimer(0.1,FLOOD_PROTECTION_EXPRESSIONS) ; Event Flood Protection
		else
			Trace("TweakFaceArchtypes[" + parts_index + "] did not cast to keyword")
		endif
				
	EndFunction

	Function OnChooseUp() ; add
		Trace("OnChooseUp(): Expressions")
		parts_choice = parts_index
		; pTweakOptionChosen => "Option [25] Chosen"
		pTweakOptionChosen.Show((parts_choice + 1))
	EndFunction

	Function OnChooseDown()
		Trace("OnChooseDown(): Expressions")
		TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
		if (pTweakVCScript)
			pTweakVCScript.EndChoice()
		endif
	EndFunction
	
	Function OnChooseLeft() ; prev
		Trace("OnChooseLeft(): Expressions")
		parts_index -= 1
		if (parts_index < 0)
			parts_index = (PartsList.GetSize() - 1)
		endif
		
		Actor npc = parts_storage.GetActorReference()
		Keyword fa = PartsList.GetAt(parts_index) as Keyword
		if (fa)
			npc.ChangeAnimFaceArchetype(fa)
			StartTimer(1.0,FLOOD_PROTECTION_EXPRESSIONS) ; Event Flood Protection
		else
			Trace("TweakFaceArchtypes[" + parts_index + "] did not cast to keyword")
		endif
	EndFunction

	Function OnChooseRight() ; next
		Trace("OnChooseRight(): Expressions")
		parts_index += 1
		if (parts_index == PartsList.GetSize())
			parts_index = 0
		endif
		
		Actor npc = parts_storage.GetActorReference()
		Keyword fa = PartsList.GetAt(parts_index) as Keyword
		if (fa)
		
			; This is only temporary and will only last until something else 
			; requests an expression. If an expression is defined on the Actor
			; record, it will ultimately revert back to that in time...
			
			npc.ChangeAnimFaceArchetype(fa)
			StartTimer(1.0,FLOOD_PROTECTION_EXPRESSIONS) ; Event Flood Protection
		else
			Trace("TweakFaceArchtypes[" + parts_index + "] did not cast to keyword")
		endif
	EndFunction

	Function OnChoiceEnd()
		Trace("OnChoiceEnd(): Expressions")
		
		; Unless they "Chose" something, dont store it...
		Actor npc = parts_storage.GetActorReference()
		if (parts_choice > -1)
			if (parts_index != parts_choice)
				parts_index = parts_choice
				pTweakOptionRestored.Show((parts_choice + 1))				
			endif
			Keyword fa = PartsList.GetAt(parts_index) as Keyword
			if (fa)
			
				; To make the change permanent, we have to add the ArcheType
				; to the Actor record (and esnure there are no competing archetype)
				
				if (parts_storage.CurrentFaceArchtype)
					npc.RemoveKeyword(parts_storage.CurrentFaceArchtype)
				endif
				parts_storage.CurrentFaceArchtypeId = parts_choice
				parts_storage.CurrentFaceArchtype   = fa
				npc.AddKeyword(fa)
				npc.ChangeAnimFaceArchetype(fa)
			else
				Trace("TweakFaceArchtypes[" + parts_index + "] did not cast to keyword")
			endif
		else
			npc.ClearExpressionOverride()
		endif
		if (prePosedRank > -1)
			Trace("Setting TweakPosedFaction Rank to [" + prePosedRank + "]")
			npc.SetFactionRank(pTweakPosedFaction, prePosedRank)
			npc.EvaluatePackage()
		else
			npc.RemoveFromFaction(pTweakPosedFaction)
		endif
		parts_storage = None
		self.GotoState("None")
		
	EndFunction
	
EndState

State ShowPostures

	Function OnChoiceBegin()
		Trace("OnChoiceBegin(): ShowPostures")

		Actor npc = parts_storage.GetActorReference()
		if (None == npc)
			Trace("parts_storage not set. Aborting")
			TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
			if (pTweakVCScript)
				pTweakVCScript.EndChoice()
			endif
			return
		endif	
		
		Actor pc = Game.GetPlayer()		
		
		int maxindex = PartsList.GetSize() - 1
		if (parts_choice > maxindex)
			Trace("current part choice out of range. Resetting")
			parts_choice = -1
			parts_index  = 0
		endif

		Keyword fa = PartsList.GetAt(parts_index) as Keyword
		if (fa)
			npc.ChangeAnimArchetype(fa)
			StartTimer(0.1,FLOOD_PROTECTION_POSTURES) ; Event Flood Protection
		else
			Trace("TweakBodyArchtypes[" + parts_index + "] did not cast to keyword")
		endif
				
	EndFunction

	Function OnChooseUp() ; add
		Trace("OnChooseUp(): ShowPostures")
		parts_choice = parts_index
		; pTweakOptionChosen => "Option [25] Chosen"
		pTweakOptionChosen.Show((parts_choice + 1))
	EndFunction

	Function OnChooseDown()
		Trace("OnChooseDown(): ShowPostures")
		TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
		if (pTweakVCScript)
			pTweakVCScript.EndChoice()
		endif
	EndFunction
	
	Function OnChooseLeft() ; prev
		Trace("OnChooseLeft(): ShowPostures")
		parts_index -= 1
		if (parts_index < 0)
			parts_index = (PartsList.GetSize() - 1)
		endif
		
		Actor npc = parts_storage.GetActorReference()
		Keyword fa = PartsList.GetAt(parts_index) as Keyword
		if (fa)
			npc.ChangeAnimArchetype(fa)
			StartTimer(1.0,FLOOD_PROTECTION_POSTURES) ; Event Flood Protection
		else
			Trace("TweakBodyArchtypes[" + parts_index + "] did not cast to keyword")
		endif
	EndFunction

	Function OnChooseRight() ; next
		Trace("OnChooseRight(): ShowPostures")
		parts_index += 1
		if (parts_index == PartsList.GetSize())
			parts_index = 0
		endif
		
		Actor npc = parts_storage.GetActorReference()
		Keyword fa = PartsList.GetAt(parts_index) as Keyword
		if (fa)		
			npc.ChangeAnimArchetype(fa)
			StartTimer(1.0,FLOOD_PROTECTION_POSTURES) ; Event Flood Protection
		else
			Trace("TweakBodyArchtypes[" + parts_index + "] did not cast to keyword")
		endif
	EndFunction

	Function OnChoiceEnd()
		Trace("OnChoiceEnd(): ShowPostures")
		
		; Unless they "Chose" something, dont store it...
		Actor npc = parts_storage.GetActorReference()
		if (parts_choice > -1)
			if (parts_index != parts_choice)
				parts_index = parts_choice
				pTweakOptionRestored.Show((parts_choice + 1))				
			endif
			Keyword fa = PartsList.GetAt(parts_index) as Keyword
			if (fa)
			
				; To make the change permanent, we have to add the ArcheType
				; to the Actor record (and esnure there are no competing archetype)
				
				if (parts_storage.CurrentArchtype)
					npc.RemoveKeyword(parts_storage.CurrentArchtype)
				endif
				parts_storage.CurrentArchtypeId = parts_choice
				parts_storage.CurrentArchtype   = fa
				npc.AddKeyword(fa)
				npc.ChangeAnimArchetype(fa)
			else
				Trace("TweakBodyArchtypes[" + parts_index + "] did not cast to keyword")
			endif
		else
			npc.ChangeAnimArchetype()
		endif
		if (prePosedRank > -1)
			npc.SetFactionRank(pTweakPosedFaction, prePosedRank)
		else
			npc.RemoveFromFaction(pTweakPosedFaction)
		endif		
		parts_storage = None
		self.GotoState("None")
		
	EndFunction
	
EndState

State ShowBodies

	Function OnChoiceBegin()
		Trace("OnChoiceBegin()")
		
		Actor npc = parts_storage.GetActorReference()
		if (None == npc)
			Trace("parts_storage not set. Aborting")
			TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
			if (pTweakVCScript)
				pTweakVCScript.EndChoice()
			endif
			return
		endif	
		
		Actor pc = Game.GetPlayer()		
						
		int maxindex = PartsList.GetSize() - 1
		if (parts_choice > maxindex)
			Trace("current part choice out of range. Resetting")
			parts_choice = -1
			parts_index  = restore_global_values.Length + 2
		endif			

		; NOTES: If we disable the NPC, their gear gets flagged for removal. 
		;        The game doesn't remove it immediatly, but will within say
		;        5 seconds. Technically, anytime you disable/enable an actor
		;        and perform an action that causes the script to yield its 
		;        thread, you risk losing all their gear. Sometimes you get 
		;        lucky. 
		;
		;        We avoid this by making them invisible and setting them 
		;        unconsious. This protects the gear from being cleaned up.
        ;        Unconsious keeps them from talking. 
		
		npc.AddSpell(MQ203PlayerInvisibility, abVerbose=False)
		npc.SetUnconscious(true)
		HandleBodyDisplay()

	EndFunction

	Function OnChooseUp() ; add
		Trace("OnChooseUp()")
		parts_choice = parts_index
		; pTweakOptionChosen => "Option [25] Chosen"
		pTweakOptionChosen.Show((parts_choice + 1))
	EndFunction

	Function OnChooseDown()
		Trace("OnChooseDown()")
		TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
		if (pTweakVCScript)
			pTweakVCScript.EndChoice()
		endif
	EndFunction
	
	Function OnChooseLeft() ; prev
		Trace("OnChooseLeft()")
		HandleBodyDisplay(true)
		int minindex = restore_global_values.Length + 2
		parts_index -= 1
		if (parts_index < minindex)
			parts_index = (PartsList.GetSize() - 1)
		endif		
		HandleBodyDisplay()		
	EndFunction

	Function OnChooseRight() ; next
		Trace("OnChooseRight()")
		HandleBodyDisplay(true)
		parts_index += 1
		if (parts_index == PartsList.GetSize())
			parts_index = restore_global_values.Length + 2
		endif		
		HandleBodyDisplay()
	EndFunction

	Function OnChoiceEnd()	
		Trace("OnChoiceEnd")
		pTweakUpdating.show()
		
		int invID = -1
		
		Actor pc            = Game.GetPlayer()
		Actor npc           = (parts_storage as ReferenceAlias).GetActorRef()
		Actor invguy        = pInvisibleGuy.GetActorReference()
		Actor gearcontainer = pSculptTarget.GetActorReference()
		
		if invguy
			Trace("Disabling InvisibleGuy")
			pInvisibleGuy.Clear()
			invguy.Disable()		
		endif
		if (npc)
			npc.RemoveSpell(MQ203PlayerInvisibility)
			npc.SetUnconscious(false)
			
			if (wasReadyWeapon)
				Trace("Restoring keyword TeammateReadyWeapon_DO")
				npc.AddKeyword(pTeammateReadyWeapon_DO)
				npc.AddToFaction(pTweakReadyWeaponFaction)
			endif
									
			; Did the Body Change?
			parts_index = parts_choice
			int bd_index = parts_index - 2 - restore_global_values.Length
			if (parts_choice != parts_storage.CurrentBodyId)
				Trace("Loading Choice [" + parts_choice + "]")
				
				; We expect PARTS LIST[1] to identify the associated NPC's LeveledActor:
				LeveledActor leveledActorRoot = PartsList.GetAt(1) as LeveledActor
				if leveledActorRoot
				
					; We expect PARTS LIST[2..n] to identify ActorBases to use as options
					; Confirm the selected entry is a valid ActorBase:
					ActorBase baseBody = PartsList.GetAt(parts_index) As ActorBase
					if (baseBody)
					
						; Time to transfer any gear we want to save to the gearcontainer:
						Utility.wait(0.2)
						Trace("Storing Items...")
						Trace("NPC ITEMCOUNT [" + npc.GetItemCount() + "]")
						Trace("GEARCONTAINER ITEMCOUNT [" + gearcontainer.GetItemCount() + "]")
						
						npc.RemoveAllItems(gearcontainer,true)
						Utility.wait(0.5)
						Trace("(after) NPC ITEMCOUNT [" + npc.GetItemCount() + "]")
						Trace("(after) GEARCONTAINER ITEMCOUNT [" + gearcontainer.GetItemCount() + "]")
						
						
						Trace("Clearing LeveledActor List of previous changes...")
						; Clears previous body settings (if existed...)
						; NOTE: This also clears inventory and actor values.
						leveledActorRoot.Revert() 
							
						Trace("Adding Chosen ActorBase to end of List")
						leveledActorRoot.AddForm(baseBody, 1) ; MUST BE LEVEL 1! (same as all other choices).
												
						Trace("Enabling/Reseting/Loading NPC")
						; To detect the change completion, we need a snapshot of the current instance handle:
						int before = npc.GetLeveledActorBase().GetFormID() ; It will look like 0xFF123456
						
						npc.Reset()
						Utility.wait(0.3)
						npc = (parts_storage as ReferenceAlias).GetActorRef()
						int waitmax = 4
						while (waitmax > 0 && npc.GetLeveledActorBase().GetFormID() == before)
							Trace("Waiting For Reset to Complete")
							Utility.wait(1.0)
							waitmax -= 1
						endwhile
						
						; NOTE: As of October 2016, Reset() began respawning the NPC in their 
						; original location (Which is often nowhere near the player). So we
						; Need to issue a MoveTo command before checking for 3D. Used MoveTo
						; over SetPosition as it works between worldspaces such
						; as the commonwealth and Diamond City.
						
						float[] offsetdata = TraceCircleOffsets(pc, -120, 0)
						npc.MoveTo(pc, offsetdata[0], offsetdata[1], offsetdata[2])
						 
						Trace("Waiting For npc.Is3DLoaded()")							
						waitmax = 10
						while (waitmax > 0 && !npc.Is3DLoaded())
							Trace("Waiting For npc.Is3DLoaded()")
							Utility.wait(1.0)
							waitmax -= 1
						endwhile
							
						if (!npc.Is3DLoaded())
							; TODO: Pop up Warning?
							Trace("3D did not load following Reset. Most likely some sort of incompatibility. Rollowing Back...")
								
							leveledActorRoot.Revert()
								
							; Restore Globals...
							int BodyDataSize = PartsList.GetSize()
							int i = 2
							int r = 0
							float gvf
							GlobalVariable gv = pTweakVCUpText
							while (i < BodyDataSize && gv)
								gv = PartsList.GetAt(i) As GlobalVariable
								if (gv)
									gvf = restore_global_values[r]
									Trace("Restoring GlobalValue [" + gv + "] [" + gvf + "]")
									gv.SetValue(gvf)
									r += 1
								endif
								i += 1			
							endwhile
								
							npc.Reset()
							Utility.wait(0.3)
							
							npc = (parts_storage as ReferenceAlias).GetActorRef()
							offsetdata = TraceCircleOffsets(pc, -120, 0)
							npc.MoveTo(pc, offsetdata[0], offsetdata[1], offsetdata[2])
						 
							waitmax = 5
							while (waitmax > 0 && !npc.Is3DLoaded())
								Trace("Waiting For npc.Is3DLoaded()")
								Utility.wait(1.0)
								waitmax -= 1
							endwhile
							
						endif
						
						; Transfer Inventory from gearcontainer back to NPC		
						Trace("Restoring Gear")
						
						Trace("NPC ITEMCOUNT [" + npc.GetItemCount() + "]")
						Trace("GEARCONTAINER ITEMCOUNT [" + gearcontainer.GetItemCount() + "]")
						gearcontainer.RemoveAllItems(npc,true)
						Utility.wait(0.5)
						Trace("(after) NPC ITEMCOUNT [" + npc.GetItemCount() + "]")
						Trace("(after) GEARCONTAINER ITEMCOUNT [" + gearcontainer.GetItemCount() + "]")
						
						; (Disable the Body Dummy )
						HandleBodyDisplay(true)
						
						AFT:TweakInventoryControl pTweakInventoryControl = (parts_storage as ReferenceAlias) as AFT:TweakInventoryControl
						if (pTweakInventoryControl)
							; Special Case : Revert will restore the original OUTFIT. Normally, we would just remove it, but now we only
							; remove it if the NPC is managed. Fortunately, the FollowEvent checks this case and removes it for is if it
							; is safe:
							pTweakInventoryControl.EventFollowingPlayer()
							if npc.HasKeyword(pActorTypeGhoul) || npc.HasKeyword(pActorTypeHuman) || npc.HasKeyword(pActorTypeSynth) || npc.HasKeyword(pActorTypeSuperMutant)
								Trace("Attempting to Restoring/Clear Snapshot Outfit")
								pTweakInventoryControl.ClearTweakOutfit(5)
								Utility.wait(0.1)
								checkWasManaged(npc)
							endif
						else
							Trace("Cast of parts_storage to ReferenceAlias to TweakInventoryControl Failed.")			
						endif
						
						; Link NPC to pSculptTarget to enforce pSculptTarget's AI
						pSculptTarget.ForceRefTo(npc)

						; Restore Actor Values....
						int ActorValueListSize = pTweakActorValuesToSave.GetSize()
						int i = 0
						ActorValue av
						float avf
						while (i < ActorValueListSize)
							av = pTweakActorValuesToSave.GetAt(i) As ActorValue
							if (av)
								avf = restore_actor_values[i]
								npc.SetValue(av,avf)
								Trace("Setting av [" + av + "] [" + avf + "]")
							else
								Trace("TweakActorValuesToSave[" + i + "] did not cast to ActorValue. Skipping")
							endif
							i += 1
						endwhile
						; Reset the Scale
						npc.SetValue(pTweakScale, 1.0)
						; Reset the VoiceType (Unless it is curie...)
						if (npc.GetActorBase() != Game.GetForm(0x00027686) as ActorBase)
							npc.SetOverrideVoiceType(original_vt)
						endif
						original_vt = None
					else
						Trace("OnChoiceEnd : PartsList[" + parts_index + "] did not cast to ActorBase. Aborting....")
					endif
				else
					Trace("OnChoiceEnd : PartsList[1] did not cast to LeveledActor. Aborting....")
				endif
				
			else
				Trace("OnChoiceEnd : Choice has not changed...")
			endif
			
			float[] posdata = TraceCircle(pc,100,0)
			npc.SetPosition(posdata[0],posdata[1],posdata[2])
			npc.SetAngle(0.0,0.0,  npc.GetAngleZ() + npc.GetHeadingAngle(pc))										
			npc.RemoveFromFaction(pTweakPosedFaction)
			npc.RemoveFromFaction(pTweakIgnoredFaction)
		else
			Trace("OnChoiceEnd : Unable to Find NPC to re-enable (Sorry)")
		endif
		
		pSculptTarget.Clear()				
		HandleBodyDisplay(true)
				
		; Restore Globals:
		int BodyDataSize = PartsList.GetSize()
		int i = 2
		int r = 0
		float gvf
		GlobalVariable gv = pTweakVCUpText
		while (i < BodyDataSize && gv)
			gv = PartsList.GetAt(i) As GlobalVariable
			if (gv)
				gvf = restore_global_values[r]
				Trace("Restoring GlobalValue [" + gv + "] [" + gvf + "]")
				gv.SetValue(gvf)
				r += 1
			endif
			i += 1			
		endwhile
	
		if (parts_storage)
			parts_storage.CurrentBodyId = parts_choice
		endif

		; Clean up body dummies...
		i = 0
		int body_dummies_len = body_dummies.Length
		while (i < body_dummies_len)
			if (body_dummies[i])
				body_dummies[i].RemoveFromFaction(pTweakIgnoredFaction)
				body_dummies[i].Delete()
			endif
			i += 1
		endwhile
		body_dummies.Clear()
		parts_storage = None

		self.GotoState("None")
		
	EndFunction
		
EndState

State ShowSculpt

	Function OnChoiceBegin()
		Trace("OnChoiceBegin(): ShowSculpt")

		Actor npc = pSculptTarget.GetActorReference()
		if (None == npc)
			Trace("pSculptTarget not set. Aborting")
			return
		endif	
		
	EndFunction

	Function OnChooseUp() ; Sculpt
		Trace("OnChooseUp(): ShowSculpt")
		parts_choice = 1
		TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
		if (pTweakVCScript)
			pTweakVCScript.EndChoice()
		endif
	EndFunction

	Function OnChooseDown()
		Trace("OnChooseDown(): ShowSculpt")
		TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
		if (pTweakVCScript)
			pTweakVCScript.EndChoice()
		endif
	EndFunction
	
	Function OnChooseLeft() ; rotate
		Trace("OnChooseLeft(): ShowSculpt")
		Actor npc = pSculptTarget.GetActorReference()
		if npc
			npc.TranslateTo(npc.GetPositionX(), npc.GetPositionY(), npc.GetPositionZ(), 0.0, 0.0, Enforce360Bounds(npc.GetAngleZ() - 30), 100.0, 200.0)
			Utility.Wait(1.0)			
			; ObjectReference akFurn = pSculptMirror.GetReference()
			; posdata = TraceCircle(akFurn, 30, -90)
			; akFurn.SetPosition(posdata[0], posdata[1], posdata[2])
			; akFurn.SetAngle(0.0,0.0, Enforce360Bounds(akFurn.GetAngleZ() - 25))
		else
			Trace("OnChooseLeft(): No Mirror could be located")
		endif
	EndFunction

	Function OnChooseRight() ; rotate
		Trace("OnChooseRight(): ShowSculpt")
		Actor npc = pSculptTarget.GetActorReference()
		if npc			
			npc.TranslateTo(npc.GetPositionX(), npc.GetPositionY(), npc.GetPositionZ(), 0.0, 0.0, Enforce360Bounds(npc.GetAngleZ() + 30), 100.0, 200.0)
			Utility.Wait(1.0)
			; ObjectReference akFurn = pSculptMirror.GetReference()
			; posdata = TraceCircle(akFurn, 30, 90)
			; akFurn.SetPosition(posdata[0], posdata[1], posdata[2])
			; akFurn.SetAngle(0.0,0.0, Enforce360Bounds(akFurn.GetAngleZ() + 25))
		else
			Trace("OnChooseLeft(): No Mirror could be located")
		endif
	EndFunction

	Function OnChoiceEnd()	
		Trace("OnChoiceEnd(): ShowSculpt")
		Actor npc = pSculptTarget.GetActorReference()
		if (1 == parts_choice)
			if npc
				RegisterForMenuOpenCloseEvent("LooksMenu")
				Game.ShowRaceMenu(akMenuTarget = npc, uiMode = 1)
			else
				Trace("OnChoiceEnd : pSculptTarget Empty. Aborting...")
			endif
		else
			; This is Cancel
			if LeveledNPCSrc
				Trace("OnChoiceEnd : LeveledNPCSrc RemoveFromFaction(pTweakPosedFaction)")
				LeveledNPCSrc.SetAvoidPlayer(false)
				LeveledNPCSrc.RemoveFromFaction(pTweakPosedFaction)
				LeveledNPCSrc.RemoveSpell(MQ203PlayerInvisibility)
				LeveledNPCSrc = NONE
			endif
			
			if npc
				npc.SetAvoidPlayer(false)
				pSculptTarget.Clear()
				npc.SetHasCharGenSkeleton(False)
				npc.ChangeAnimFaceArchetype(AnimFaceArchetypePlayer)
				npc.RemoveFromFaction(pTweakPosedFaction)
			else
				Trace("OnChoiceEnd : pSculptTarget Empty. Aborting...")
			endif
			ObjectReference akFurn = pSculptMirror.GetReference()
			if akFurn
				pSculptMirror.Clear()
				akFurn.Delete()
			else
				Trace("OnChoiceEnd : pSculptMirror Empty.")
			endif
		endif
		; Do NOT set parts_storage to NONE here. Let it get 
		; cleaned up in ExitFurniture Callback (So we can
		; restore outfit)
		; parts_storage = None		
		self.GotoState("None")
	EndFunction
	
EndState

State ShowMovePosed

	Function OnChoiceBegin()
		Trace("OnChoiceBegin(): ShowMovePosed")		

		; Unlike other viewers, the ShowMovePosed viewer requires the user to hit 
		; DONE to end the viewer. This is because SCENES anchor when activated and
		; enforce a limited range. So when the player is moving an NPC, every 300
		; units or so, the scene will automatically end.  To support prolonged
		; movements, we auto-renew the scene when this happens (if parts_index is
		; not 0, we restart the scene... )
		
		; parts_index tracks scene state.
		; 1 = first time startup
		; 2 = renew
		; 0 = done...

		if 1 == parts_index
			Actor npc = parts_storage.GetActorReference()
			if (None == npc)
				Trace("parts_storage not set. Aborting")
				TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
				if (pTweakVCScript)
					parts_index = 0
					pTweakVCScript.EndChoice()
				endif
				return
			endif	
		
			; parts_choice tracks toggle state. 
			parts_choice = 0
		
			parts_storage.KeepOffsetFromPlayer()
			npc.SetAlpha(0.75)
		
			; If they are posed this should already be true. If we allow this
			; for other (non-posed uses), then we will need to check and possibly
			; set MotionType to true. Otherwise you get "jitters" when they move...		
			; npc.SetMotionType(npc.Motion_Keyframed)
			
		endif
		
	EndFunction

	Function OnChooseUp() ; Toggle Lean/Rotate
		Trace("OnChooseUp(): ShowMovePosed")
		if 0 == parts_choice
			if (parts_storage.CurrentPose is Furniture)
				Trace("parts_choice was 0, setting to 1")
				parts_choice = 1
				pTweakVCLeftText.SetValue(5)  ; 5 = Raise Up
				pTweakVCRightText.SetValue(5) ; 5 = Lower Down
			else
				Trace("parts_choice was 0, setting to 2 (Pose is not furniture based)")
				parts_choice = 2
				pTweakVCLeftText.SetValue(3)  ; 3 = < Lean
				pTweakVCRightText.SetValue(3) ; 3 = Lean >
			endif			
		elseif 1 == parts_choice
			Trace("parts_choice was 1, setting to 2")
			parts_choice = 2
			pTweakVCLeftText.SetValue(3)  ; 3 = < Lean
			pTweakVCRightText.SetValue(3) ; 3 = Lean >		
		else
			Trace("parts_choice was [" + parts_choice + "], setting to 0")
			parts_choice = 0
			pTweakVCLeftText.SetValue(1)  ; 1 = < Rotate
			pTweakVCRightText.SetValue(1) ; 1 = Rotate >			
		endif
	EndFunction

	Function OnChooseDown()
		Trace("OnChooseDown(): ShowMovePosed")
		parts_index = 0
		pTweakMovePosedActive.SetValue(0.0)	; External "Safety" incase can't access dialogue during pose.
		TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
		if (pTweakVCScript)
			pTweakVCScript.EndChoice()
		endif
	EndFunction
	
	Function OnChooseLeft() ; rotate/lean/raise/lower
		Trace("OnChooseLeft(): ShowMovePosed")		
		Actor npc = parts_storage.GetActorReference()
		if (1 == parts_choice)
			float desired_elevation = npc.GetPositionZ() + 6
			Trace("Raising Z position +6 units to : [" + desired_elevation + "]")
			parts_storage.TranslatePosedTo(npc.GetPositionX(),npc.GetPositionY(),desired_elevation, npc.GetAngleX(), npc.GetAngleY(),  npc.GetAngleZ(), 150.0, 200.0)
		elseif (2 == parts_choice)
			float desired_xangle = npc.GetAngleX() - 6
			Trace("Rotating X-axis -6 degrees to : [" + desired_xangle + "]")
			parts_storage.TranslatePosedTo(npc.GetPositionX(),npc.GetPositionY(),npc.GetPositionZ(), desired_xangle , npc.GetAngleY(), npc.GetAngleZ(), 150.0, 200.0)
		elseif (0 == parts_choice)
			float desired_zangle = Enforce360Bounds(npc.GetAngleZ() + 10)
			Trace("Rotating Z-axis +10 degrees to : [" + desired_zangle + "]")
			parts_storage.TranslatePosedTo(npc.GetPositionX(),npc.GetPositionY(),npc.GetPositionZ(), npc.GetAngleX(), npc.GetAngleY(), desired_zangle , 150.0, 200.0)
		endif
		
	EndFunction

	Function OnChooseRight() ; rotate/lean/raise/lower
		Trace("OnChooseRight(): ShowMovePosed")		
		Actor npc = parts_storage.GetActorReference()
		if (1 == parts_choice)
			float desired_elevation = npc.GetPositionZ() - 6
			Trace("Lowering Z position -6 units to : [" + desired_elevation + "]")
			parts_storage.TranslatePosedTo(npc.GetPositionX(),npc.GetPositionY(),desired_elevation, npc.GetAngleX(), npc.GetAngleY(),  npc.GetAngleZ(), 150.0, 200.0)
		elseif (2 == parts_choice)
			float desired_xangle = npc.GetAngleX() + 6
			Trace("Rotating X-axis +6 degrees to : [" + desired_xangle + "]")
			parts_storage.TranslatePosedTo(npc.GetPositionX(),npc.GetPositionY(),npc.GetPositionZ(), desired_xangle , npc.GetAngleY(), npc.GetAngleZ(), 150.0, 200.0)
		elseif (0 == parts_choice)
			float desired_zangle = Enforce360Bounds(npc.GetAngleZ() - 10)
			Trace("Rotating Z-axis -10 degrees to : [" + desired_zangle + "]")
			parts_storage.TranslatePosedTo(npc.GetPositionX(),npc.GetPositionY(),npc.GetPositionZ(), npc.GetAngleX(), npc.GetAngleY(), desired_zangle , 150.0, 200.0)
		endif
				
	EndFunction

	Function OnChoiceEnd()
		Trace("OnChoiceEnd(): ShowMovePosed")
		
		Actor npc = parts_storage.GetActorReference()
		if (0 != parts_index)
			TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
			if (pTweakVCScript)
				pTweakVCScript.StartChoice(npc, self, original_distance, original_distance)
				return
			endif
		endif
		
		; npc.SetMotionType(npc.Motion_Dynamic)
		npc.SetAlpha(1)
		
		; TODO : If not dismissed, Kick off timer to watch distance between PC and NPC 
		; so we can release when player gets 300 away from NPC. If they dismiss before
		; then, the NPC will remain posed. 
		
		parts_storage.ClearKeepPlayerOffset()
		parts_storage = None
		self.GotoState("None")
	EndFunction
	
EndState

State ShowPoses

	Function OnChoiceBegin()
		Trace("OnChoiceBegin(): ShowPoses")		
		int maxindex = Poses.Length - 1
		if (parts_choice > maxindex)
			Trace("current pose choice out of range. Resetting")
			parts_choice = -1
			parts_index  = 0
		endif			
		Trace("parts_choice [" + parts_choice + "] parts_index [" + parts_index + "]")

		PoseData pd = Poses[parts_index]
		StartTimer(0.1,FLOOD_PROTECTION_POSES) ; Event Flood Protection		
		parts_storage.StartPose(parts_index, pd.pose, pd.replay_delay)

	EndFunction

	Function OnChooseUp() ; Sculpt
		Trace("OnChooseUp(): ShowPoses")
		parts_choice = parts_index
		; pTweakOptionChosen => "Option [25] Chosen"
		pTweakOptionChosen.Show((parts_choice + 1))
	EndFunction

	Function OnChooseDown()
		Trace("OnChooseDown(): ShowPoses")
		TweakVisualChoiceScript pTweakVCScript = pTweakVisualChoice as TweakVisualChoiceScript
		if (pTweakVCScript)
			pTweakVCScript.EndChoice()
		endif
	EndFunction
	
	Function OnChooseLeft() ; rotate
		Trace("OnChooseLeft(): ShowPoses")
		
		parts_index -= 1
		if (parts_index < 0)
			parts_index = (Poses.Length - 1)
		endif
		
		PoseData pd = Poses[parts_index]
		StartTimer(1.25,FLOOD_PROTECTION_POSES) ; Event Flood Protection		
		parts_storage.StartPose(parts_index, pd.pose, pd.replay_delay)
		
	EndFunction

	Function OnChooseRight() ; rotate
		Trace("OnChooseRight(): ShowPoses")
		
		parts_index += 1
		if (parts_index == Poses.Length)
			parts_index = 0
		endif

		PoseData pd = Poses[parts_index]
		StartTimer(1.25,FLOOD_PROTECTION_POSES) ; Event Flood Protection		
		parts_storage.StartPose(parts_index, pd.pose, pd.replay_delay)
				
	EndFunction

	Function OnChoiceEnd()
		
		Actor npc = parts_storage.GetActorReference()
		; Unless they "Chose" something, dont play/replay it...
		if (parts_choice > -1)
			if (parts_index != parts_choice)
				parts_index = parts_choice
				pTweakOptionRestored.Show((parts_choice + 1))				
			endif
			PoseData pd = Poses[parts_index]
			parts_storage.StartPose(parts_index, pd.pose, pd.replay_delay)		
			parts_storage.CurrentPoseId = parts_choice ; Not needed, but to be consistent			
		else
			parts_storage.StopPosing(true) ; Removes them from the TweakPosedFaction
			; npc.SetMotionType(npc.Motion_Dynamic)
		endif
		
		; TweakAppearance knows if the NPC is a current follower. If so, it watches the
		; distance between the player and the NPC and auto-stops the pose if the player
		; gets more than 500 units away. (Most NPCs are about 100 units tall). 
		
		parts_storage = None
		Trace("OnChoiceEnd(): ShowPoses")
		self.GotoState("None")
	EndFunction
	
EndState

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

; AngleOffset:
;  -90     = Players left. 
;   90     = Players right, 
; 180/-180 = behind player
Float[] Function TraceCircleOffsets(ObjectReference n, Float radius = 500.0, Float angleOffset = 0.0)
    float azimuth = ConvertToSinCosCompatibleAngle(n.GetAngleZ(), angleOffset)	
    Float[] r = new Float[3]
    r[0] =  radius * Math.cos(azimuth) ; X Offset
    r[1] =  radius * Math.sin(azimuth) ; Y Offset
    r[2] =  0 ; Z Offset
    return r
EndFunction

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

; Idles that dont loop eventually end, freeing up the NPC to move against
; Furniture free up when the furniture is deleted
; Idles that LOOP are dangerous as they will never end and will hold
; the NPC hostage. 
Function PopulatePoses()

	; Add Idles:

	; Mannequin 1
	Poses[0].pose         = Game.GetForm(0x001ABE65) ; as Furn SynthStandingMannequin; 
	Poses[0].replay_delay = 0.0

	; Defeated
	Poses[1].pose         = Game.GetForm(0x001CC203) ; as Furniture ; NPCKneelSit
	Poses[1].replay_delay = 0.0

	; Relaxed
	Poses[2].pose         = Game.GetForm(0x000224F7) ; as Furniture ; FloorSitRadioListenMarker
	Poses[2].replay_delay = 0.0

	; Asleep 1
	Poses[3].pose         = Game.GetFormFromFile(0x01020EF8,"AmazingFollowerTweaks.esp") ; as Furniture ; TweakFurnSleep
	Poses[3].replay_delay = 0.0
	
	; Usher Left
	Poses[4].pose         = Game.GetForm(0x00161C2B) ; as Furniture ; NPCUsherMarker
	Poses[4].replay_delay = 0.0

	; Usher Right
	Poses[5].pose         = Game.GetForm(0x001A5168) ; as Furniture ; NPCUsherMarkerMirrored
	Poses[5].replay_delay = 0.0
	
	; Sit Seductive
	Poses[6].pose         = Game.GetFormFromFile(0x01021E2B,"AmazingFollowerTweaks.esp") ; as Furniture ; TweakFurnLayBack
	Poses[6].replay_delay = 0.0

	; Sit Seductive w/chair
	Poses[7].pose         = Game.GetForm(0x00108F58) ; as Furniture ; MQ202IrmaSit01
	Poses[7].replay_delay = 0.0
	
	; Pushups
	Poses[8].pose         = Game.GetForm(0x001AC040) ; as Furniture ; NPCPushUps
	Poses[8].replay_delay = 0.0

	; Asleep 2
	Poses[9].pose         = Game.GetForm(0x001ABE62) ; as Furniture ; SynthLayingOnBack
	Poses[9].replay_delay = 0.0

	; Alone
	Poses[10].pose         = Game.GetForm(0x0005A47A) ; as Furniture ; NPCInvGroundSadSit
	Poses[10].replay_delay = 0.0

	; Under Arrest
	Poses[11].pose         = Game.GetForm(0x0012367E) ; as Furniture ; NPCRefugeeMaleA
	Poses[11].replay_delay = 0.0

	; Worship
	Poses[12].pose         = Game.GetForm(0x002469C6) ; as Furniture ; NPCKneelPrayingSit
	Poses[12].replay_delay = 0.0

	; Hostage
	Poses[13].pose         = Game.GetForm(0x00046CAE) ; as Furniture ; NPCHeldHostageKneelHandsUp
	Poses[13].replay_delay = 0.0
	
	; Extraction
	Poses[14].pose         = Game.GetFormFromFile(0x01021E2D,"AmazingFollowerTweaks.esp") ; as Furniture ; TweakFurnExtraction
	Poses[14].replay_delay = 18.0

	; Extraction w/Chair
	Poses[15].pose         = Game.GetForm(0x001E618A) ; as Furniture ; ExtractorChair01
	Poses[15].replay_delay = 18.0
	
	; Thinking
	Poses[16].pose         = Game.GetForm(0x001E81AC) ; as Idle ; IdleThinking
	Poses[16].replay_delay = 7.8

	; Mannequin 2
	Poses[17].pose         = Game.GetForm(0x000673BC) ; as Idle ; Pose_to_PoseB
	Poses[17].replay_delay = 0.0

	; Salute
	Poses[18].pose         = Game.GetForm(0x001793E7) ; as Idle ; Salute
	Poses[18].replay_delay = 5.8

	; Needle Prep
	Poses[19].pose         = Game.GetForm(0x00164331) ; as Idle ; IdlePreppingNeedle
	Poses[19].replay_delay = 7.7

	; Cower
	Poses[20].pose         = Game.GetForm(0x0020AC3C) ; as Idle ; CowerLooping
	Poses[20].replay_delay = 0.0

	; Fidget Low
	Poses[21].pose         = Game.GetForm(0x000F5A33) ; as Idle ; IdleLockPickingLowHeight
	Poses[21].replay_delay = 0.0

	; BOS Salute
	Poses[22].pose         = Game.GetForm(0x0019E2C8) ; as Idle ; BOS_Salute
	Poses[22].replay_delay = 4.9

	; Synth Shutdown
	Poses[23].pose         = Game.GetForm(0x0018AFA0) ; as Idle ; IdleSynthShutdown
	Poses[23].replay_delay = 0.0
	
	; Woozy
	Poses[24].pose         = Game.GetForm(0x00188B3D) ; as Furniture ; COMCAITQuestWoozy
	Poses[24].replay_delay = 0.0
	
	; Reclamation
	Poses[25].pose         = Game.GetFormFromFile(0x01021E2C,"AmazingFollowerTweaks.esp") ; as Furniture ; TweakFurnReclamation
	Poses[25].replay_delay = 0.0
	
	; Reclamation w/Chair
	Poses[26].pose         = Game.GetForm(0x000DF458) ; as Furniture ; NPCInstituteReclamationChair01
	Poses[26].replay_delay = 0.0
	
	; Work
	Poses[27].pose         = Game.GetForm(0x000CA064) ; as Furniture ; NPCWeedInvA
	Poses[27].replay_delay = 0.0
	
	; Sobbing (Female Only)
	Poses[28].pose         = Game.GetForm(0x00123678) ;  as Furniture ; NPCRefugeeFemaleA
	Poses[28].replay_delay = 0.0

	; Paranoid (Female Only)
	Poses[29].pose         = Game.GetForm(0x0012367A) ; as Furniture ; NPCRefugeeFemaleB
	Poses[29].replay_delay = 0.0

	; Prisoner 1
	Poses[30].pose         = Game.GetForm(0x001833EB) ; as Furniture ; BoS302KneelMarker
	Poses[30].replay_delay = 0.0
	
	; Prisoner 2
	Poses[31].pose         = Game.GetForm(0x000D9C37) ; as Furniture ; NPCPrisonerFloorSit
	Poses[31].replay_delay = 0.0

	; Inspect
	Poses[32].pose         = Game.GetForm(0x000DEDD6) ; as Furniture ; NPCInspectWounded
	Poses[32].replay_delay = 0.0
	
	; Off
	Poses[33].pose         = Game.GetForm(0x001ABE67) ; as Furniture ; SynthStandingPoweredDown
	Poses[33].replay_delay = 0.0

	; Wounded
	Poses[34].pose         = Game.GetForm(0x000DEDD4) ; as Furniture ; NPCWoundedSit
	Poses[34].replay_delay = 0.0

	; Dance
	Poses[35].pose         = Game.GetFormFromFile(0x010225C9,"AmazingFollowerTweaks.esp") ; as Furniture ; TweakFurnDance
	Poses[35].replay_delay = 121.0

	; Scrap : CoupleHolding...
	; Poses[35].pose         = Game.GetForm(0x0019EDD7)
	; Poses[35].replay_delay = 40.0
	
	
	; Add custom poses from external mods... : Note, we detect the type (idle, furniture), but there is 
	; no way to convey timing info. (Though about a companion formlist of globals, but that is just really ugly). 
	; So we default to restart after two minutes. It doesn't hurt to replay a looping idle, but a non-looping idle 
	; that doesn't replay sucks... NOTE: I never could get IDLEMARKERS to work... Don't know what I'm doing wrong...
	
	int i = 0
	int sizePoseObjects = pTweakPoseObjects.GetSize()
	PoseData pd_ptr
	while i < sizePoseObjects
		pd_ptr = new PoseData
		pd_ptr.pose = pTweakPoseObjects.GetAt(i)
		pd_ptr.replay_delay = 120.0
		Poses.Add(pd_ptr)
		i += 1
	endwhile
	
EndFunction

; PAIdleArray.Add(pPA_BosSalute)
; PAIdleArray.Add(pIdlePowerless)
; PAIdleArray.Add(pPA_SelfCheck)

; Paired?
Idle Property p3rdPUseStimpakOnTarget Auto Const
Idle Property pCoupleHoldingFull Auto Const
Idle Property pPA1stPUseStimpakOnTarget Auto Const
Idle Property pPA3rdPUseStimpakOnTarget Auto Const
Idle Property pForce_Equip_3rdP_Melee Auto Const

; Problem Eyewear:
; npc.UnEquipItem((Game.GetForm(0x00125891) as Armor),false,true)
; npc.UnEquipItem((Game.GetForm(0x0004A520) as Armor),false,true)
; npc.UnEquipItem((Game.GetForm(0x001C4BE8) as Armor),false,true)
; npc.UnEquipItem((Game.GetForm(0x000FD9AA) as Armor),false,true)
; npc.UnEquipItem((Game.GetForm(0x001738AA) as Armor),false,true)
; npc.UnEquipItem((Game.GetForm(0x000E628A) as Armor),false,true)
; npc.UnEquipItem((Game.GetForm(0x001B5B26) as Armor),false,true)
; npc.UnEquipItem((Game.GetForm(0x000787D9) as Armor),false,true)
; npc.UnEquipItem((Game.GetForm(0x000A81B0) as Armor),false,true)
; npc.UnEquipItem((Game.GetForm(0x000787DA) as Armor),false,true)
