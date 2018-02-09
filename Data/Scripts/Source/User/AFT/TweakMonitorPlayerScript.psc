Scriptname AFT:TweakMonitorPlayerScript extends Quest

; NOTES: ANY ATTEMPT to edit the players inventory on a startgame enabled quest will break New Games
; (Infinite intro video or black screen). You CAN NOT mess with the players inventory until after
; they have the pipboy... That is why all the quest stage checks
;
; The easiest thing to do is check if MQ102.GetCurrentStageID() < 10. If it is 10 or more, you
; are good. If it is less than 10, you can remotely register for the OnStageSet event so your
; script gets informed when the player exits the vault. 

; Dont use import. It only works when .pex files are local. Once you package them up into an 
; release/final archive, the scripts wont be found and everything will break...
; import AFT

Quest			Property pFollowers     	Auto Const
Quest			Property pTweakFollower		Auto Const
Quest			Property pTweakNames		Auto Const
Quest			Property pTweakPipBoy		Auto Const
Quest			Property pTweakVisualChoice	Auto Const
Quest			Property pTweakSettlementLoader	Auto Const
Quest			Property pTweakDLC01		Auto Const
Quest			Property pTweakDLC03		Auto Const
Quest			Property pTweakDLC04		Auto Const

Bool			Property IsInDialogue		Auto
Bool			Property RelayEvent			Auto
Bool			Property Initialized		Auto
Bool			Property SentFirstLoaded	Auto
float			Property version			Auto

Quest    		Property pMQ102             Auto Const
keyword Property isPowerArmorFrame Auto Const
Keyword Property pLinkPowerArmor         Auto Const
Keyword Property FurnitureTypePowerArmor Auto Const
GlobalVariable Property TweakDebugMode Auto Const
Message	Property pTweakFullReset	Auto Const

int  maxwait    = 30
bool allowdraw  = true
bool allowsneak = true
bool ridingvertibird = false
bool currentSwimmingState = false
bool desiredSwimmingState = false

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakMonitorPlayerScript"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Function UpdateTweakDebugMode() debugOnly
	TweakDebugMode.SetValue(1.0)
EndFunction

; Do things here you only want to do once.
Event OnInit()
	version                  = 1.0
	Initialized				 = false
	IsInDialogue             = false
	SentFirstLoaded			 = false
	RelayEvent               = true ; Set this to false if Uninstalled
	allowdraw				 = true
	allowsneak               = true
	currentSwimmingState     = false
	desiredSwimmingState     = false
endEvent

; BUGS: I'm not sure why, but we get 2 weapondraw events everytime the
; player draws. Maybe we are getting one for each hand? I dont know..
; Point it, this causes bugs. When you call some methods 2 times 
; in a row by different threads, it causes the method to short circuit. 
; So.. we add flood protection. Generally the events need to be around 2
; seconds apart, so when a weapondraw event occures, we will not
; accept enother until 3 seconds has passed OR a weapon sheathe 
; event is received. 

Event OnQuestInit()
	Trace("OnQuestInit() Receieved")
	
	Actor player = Game.GetPlayer()
	RegisterForRemoteEvent(player,"OnPlayerLoadGame")           ; Startup...
	if (pMQ102.GetCurrentStageID() < 10)
		If pMQ102.IsRunning()
			Trace("Registering For pMQ102.OnStageSet")
			RegisterForRemoteEvent(pMQ102,"OnStageSet")
		else
			Trace("Registering For pMQ102.OnQuestInit")
			RegisterForRemoteEvent(pMQ102, "OnQuestInit") 
		endif
	else
		InitializeAft()
	endif
EndEvent

Event Quest.OnQuestInit(Quest rQuest)
	Trace("Quest.OnQuestInit [" + rQuest + "]")
	if (rQuest == pMQ102)
		Trace("Registering For OnStageSet")
		UnRegisterForRemoteEvent(pMQ102, "OnQuestInit")
		RegisterForRemoteEvent(pMQ102,"OnStageSet")
	endif
endEvent

Event Quest.OnStageSet(Quest pMQ102, int auiStageID, int auiItemID)

	; Scenario : Would only be called post-startup if the player
	;            started a new game or loaded a save game made before
	;            emerging from Vaule 111... and then emerged during
	;            gameplay. 

	Trace("Quest.OnStageSet() Receieved [" + auiStageID + "]")
	if auiStageID < 10
		Trace("Ignored")
		return
	endif
	UnregisterForRemoteEvent(pMQ102,"OnStageSet")
	
	; Give the world time to come into view
	Utility.wait(10)
	InitializeAft()
EndEvent

Event Actor.OnPlayerLoadGame(Actor akSender)
	Trace("OnPlayerLoadGame Receieved")
	
	; This gets called when loading a save game, whether
	; the game was previously modded or not. (Does not
	; get called when starting a new game). The only
	; way Initialized would be false is if the save was
	; made before emerging from Vault 111.
	;
	; Edge case : Auto Save happens when emerging
	; from vault 111. So if loading Autodave, InitializeAft
	; might be false but pMQ102's stage would be >= 10. 
	; We check for edge case and immediatly initialize if
	; detected...
	
	Actor player = Game.GetPlayer()
	UnRegisterForRemoteEvent(player,"OnPlayerLoadGame")
	RegisterForRemoteEvent(player,"OnPlayerLoadGame")
	
	if (!Initialized)
		UnRegisterForRemoteEvent(pMQ102,"OnStageSet")
		if (pMQ102.GetCurrentStageID() < 10)
			RegisterForRemoteEvent(pMQ102,"OnStageSet")
			return
		endif
		InitializeAft()
		return
	endif
	
	StartTimer(4,NO_LG_FLOOD_INIT)	
EndEvent

Function InitializeAft()

	; This is called one time. Either when the player emerges
	; from Vault 111 OR when the mod is initialized (if the
	; quest stages indicate they are already well into the game). 
	
	Trace("InitializeAft()")
	if Initialized
		return
	endif
	Initialized = true

	Actor player = Game.GetPlayer()
	
	RegisterForRemoteEvent(player,"OnLocationChange")           ; Maintenance scripts...
	RegisterForRemoteEvent(player,"OnLoad")                     ; Maintenance scripts...
	RegisterForRemoteEvent(player,"OnSit")                      ; PA Tracking and Eventing Support
	
	
	RegisterForRemoteEvent(player,"OnCripple")                  ; Possible use to trigger Custom Combat Actions
	RegisterForRemoteEvent(player,"OnItemEquipped")             ; Detect PowerArmor State
	RegisterForRemoteEvent(player,"OnItemUnequipped")           ; Detect PowerArmor State
	RegisterForRemoteEvent(player,"OnPlayerEnterVertibird")     ; Hide all but 1 companion	
		

		
	; RegisterForRemoteEvent(player,"OnItemAdded")                ; Quest detection?
	; RegisterForRemoteEvent(player,"OnCombatStateChanged")       ; Possible custom Combat AI (Dont attack until Player does...)
	; RegisterForRemoteEvent(player,"OnPlayerFireWeapon")       ; Possible custom Combat AI (Dont attack until Player does...)
	; RegisterForRemoteEvent(player,"OnPlayerUseWorkBench")     ; ???		
	; RegisterForHitEvent(player)                               ; ???
	; RegisterForRemoteEvent(player,"OnHit")                    ; ???
	; RegisterForRemoteEvent(player,"OnPlayerFallLongDistance") ; ???
	; RegisterForRemoteEvent(player,"OnPlayerHealTeammate")     ; ??? 
	; RegisterForRemoteEvent(player,"OnPlayerSwimming")         ; ???
	; RegisterForRadiationDamageEvent(player)                   ; ???
	; RegisterForRemoteEvent(player,"OnRadiationDamage")        ; ???		
    ; RegisterForRemoteEvent(player,"OnPlayerModArmorWeapon")
	; RegisterForPlayerSleep()                                  ; ???
    ; RegisterForRemoteEvent(player,"OnPlayerSleepStart")       ; ???	
    ; RegisterForRemoteEvent(player,"OnPlayerSleepStop")        ; ???
	; RegisterForMagicEffectApplyEvent(Player, CasterFilter = none, EffectFilter = none)
	; RegisterForRemoteEvent(player,"OnMagicEffectApply")       ; Possibly Enter Shelter?
	; RegisterForPlayerTeleport()                               ; Possibly disable AFT for certain areas?
	; RegisterForRemoteEvent(player,"OnPlayerTeleport")         ; Possibly disable AFT for certain areas?
	; RegisterForTrackedStatsEvent("Main Quests Completed", 1)
	; RegisterForTrackedStatsEvent("Locations Discovered",  1)
	
	
	Quest PowerArmorRecallQuest = Game.GetForm(0x00187605) as Quest
	if PowerArmorRecallQuest
		Trace("PowerArmorRecallQuest Found")	
		ReferenceAlias PowerArmorRef = PowerArmorRecallQuest.GetAlias(1) as ReferenceAlias
		if PowerArmorRef
			Trace("PowerArmorRecallQuest.PowerArmorRef Found")	
			ObjectReference lastPowerArmorUsed = PowerArmorRef.GetReference()
			if (lastPowerArmorUsed)
				Trace("Setting up Tweak PA tracking...")
				ObjectReference PA = lastPowerArmorUsed.GetLinkedRef(pLinkPowerArmor)
				if (None != PA)
					Trace("Unexpected : lastPowerArmorUsed.GetLinkedRef(pLinkPowerArmor) = [" + PA + "]")
				endif
				ObjectReference opc = (player as ObjectReference)
				opc.SetLinkedRef(lastPowerArmorUsed,pLinkPowerArmor)
				lastPowerArmorUsed.SetLinkedRef(opc,pLinkPowerArmor)
			else
				Trace("lastPowerArmorUsed is empty...")	
			endif
		else
			Trace("PowerArmorRecallQuest.PowerArmorRef did not cast")	
		endif		
	else
		Trace("PowerArmorRecallQuest did not cast")	
	endif
	
	allowdraw  = true
	allowsneak = true
	
	; Pretend we got OnGameLoadEvent since it doesn't fire when quest first loads.
	StartTimer(4,NO_LG_FLOOD_INIT)
EndFunction

int NO_ANIM_DRAW_FLOOD		 = 999 const
int NO_ANIM_SHEATH_FLOOD	 = 998 const
; int NO_ANIM_SNEAKENTER_FLOOD = 997 const
int NO_ANIM_SNEAKEXIT_FLOOD	 = 996 const
int NO_LG_FLOOD_INIT		 = 995 const
int NO_LG_FLOOD_CONT		 = 994 const
int ALLOW_DRAW_TIMER         = 993 const
int ALLOW_SNEAK_TIMER        = 991 const
int MONITOR_FLIGHT           = 990 const
int EVALUATE_SWIMMING        = 989 const

Event OnTimer(int aiTimerID)

	CancelTimer(aiTimerID)
	
	if (ALLOW_DRAW_TIMER == aiTimerID)
		allowdraw = true
		return
	endif
	
	if (ALLOW_SNEAK_TIMER == aiTimerID)
		allowsneak = true
		return
	endif
	
	if (EVALUATE_SWIMMING == aiTimerID)
		Trace("EVALUATE_SWIMMING: desiredSwimmingState[" + desiredSwimmingState + "] currentSwimmingState [" + currentSwimmingState + "]")
		if desiredSwimmingState != currentSwimmingState
			; Change occured
			currentSwimmingState = desiredSwimmingState
			AFT:TweakFollowerScript pTweakFollowerScript = pTweakFollower As AFT:TweakFollowerScript
			if (pTweakFollowerScript)
				if currentSwimmingState
					Trace("Calling OnPlayerStartSwim")
					pTweakFollowerScript.CallFunctionNoWait("OnPlayerStartSwim", new Var[0])
				else
					Trace("Calling OnPlayerStopSwim")
					pTweakFollowerScript.CallFunctionNoWait("OnPlayerStopSwim", new Var[0])
				endIf
			else
				Trace("Unable to Call TweakFollowerScript.OnGameLoaded()")
			endIf
		endIf
		return
	endIf
	
	; aiTimerID == 1 set by OnPlayerLoadGame()
	if (NO_LG_FLOOD_INIT == aiTimerID || NO_LG_FLOOD_CONT == aiTimerID)
			
		if (!RelayEvent)
			return
		endif
				
		; Check running States before kicking off OnGameLoaded() events...
		if (NO_LG_FLOOD_INIT == aiTimerID)
			maxwait = 30
		endif
		
		if (maxwait > 0)
			maxwait -= 3
			if (!pFollowers.IsRunning())
				Trace("Waiting for Followers Quest to Start")
				StartTimer(3,NO_LG_FLOOD_CONT)
				return
			endif
			if (!pTweakNames.IsRunning())
				Trace("Waiting for TweakNames Quest to Start")
				StartTimer(3,NO_LG_FLOOD_CONT)
				return
			endif
			if (!pTweakFollower.IsRunning())
				Trace("Waiting for TweakFollowers Quest to Start")
				StartTimer(3,NO_LG_FLOOD_CONT)
				return
			endif
			if (!pTweakPipBoy.IsRunning())
				Trace("Waiting for TweakPipBoy Quest to Start")
				StartTimer(3,NO_LG_FLOOD_CONT)
				return
			endif
		endif
		OnGameLoaded() ; <========== 
		return
	endif
	
	if (NO_ANIM_DRAW_FLOOD == aiTimerID)
		RequestDrawAnimationEvent()
		return
	endif
	
	if (NO_ANIM_SHEATH_FLOOD == aiTimerID)
		RequestSheathAnimationEvent()
		return
	endif

	; if (NO_ANIM_SNEAKENTER_FLOOD == aiTimerID)
	;	RequestSneakEnterAnimationEvent()
	;	return
	; endif

	if (NO_ANIM_SNEAKEXIT_FLOOD == aiTimerID)
		RequestSneakExitAnimationEvent()
		return
	endif

	if (MONITOR_FLIGHT == aiTimerID)
		if Game.GetPlayer().IsOnMount()
			StartTimer(5,MONITOR_FLIGHT)
		else
			PlayerExitedVertibird()
		endif
		return
	endif
	; Check for Dialogue Target...
	; StartTimer(3,0)
	
EndEvent

Function OnGameLoaded()

	Trace("OnGameLoad()")
	RelayEvent  = true
	
	bool firstcall = false
	if !SentFirstLoaded
		firstcall = true
		SentFirstLoaded = true
	endif
	
	Actor player = Game.GetPlayer()
	; Registering for this event cancels the animation registrations...

	UnRegisterForRemoteEvent(player,"OnEnterSneaking")
	RegisterForRemoteEvent(player,"OnEnterSneaking") ; Hide all but 1 companion	
	
	AFT:TweakDLC01Script pTweakDLC01Script = (pTweakDLC01 as AFT:TweakDLC01Script)
	if (pTweakDLC01Script)
		Trace("Calling AFT:pTweakDLC01Script.OnGameLoaded()")
		pTweakDLC01Script.OnGameLoaded(firstcall)
	else
		Trace("Unable to Call AFT:pTweakDLC01Script.OnGameLoaded()")
	endif

	AFT:TweakDLC03Script pTweakDLC03Script = (pTweakDLC03 as AFT:TweakDLC03Script)
	if (pTweakDLC03Script)
		Trace("Calling AFT:pTweakDLC03Script.OnGameLoaded()")
		pTweakDLC03Script.OnGameLoaded(firstcall)
	else
		Trace("Unable to Call AFT:pTweakDLC03Script.OnGameLoaded()")
	endif

	AFT:TweakDLC04Script pTweakDLC04Script = (pTweakDLC04 as AFT:TweakDLC04Script)
	if (pTweakDLC04Script)
		Trace("Calling AFT:pTweakDLC04Script.OnGameLoaded()")
		pTweakDLC04Script.OnGameLoaded(firstcall)
	else
		Trace("Unable to Call AFT:pTweakDLC04Script.OnGameLoaded()")
	endif
	
	; NOTE : All OnGameLoaded() Methods assume the game is passed MQ102:Stage9 (Fortunately a Tracked Stat happens
	; to increment as it completes, so we dont have to be too quest specific here...
		
	AFT:TweakDFScript pTweakDFScript = (pFollowers as AFT:TweakDFScript)
	if (pTweakDFScript)
		Trace("Calling AFT:TweakDFScript.OnGameLoaded()")
		pTweakDFScript.OnGameLoaded(firstcall)
	else
		Trace("Unable to Call AFT:TweakDFScript.OnGameLoaded()")
	endif

	FollowersScript pFollowersScript = (pFollowers as FollowersScript)
	if (pFollowersScript)
		; Trace("AFT:TweakMonitorPlayer : Calling FollowersScript.OnGameLoaded()")
		pFollowersScript.OnGameLoaded(firstcall)
	else
		Trace("Unable to Call FollowersScript.OnGameLoaded()")
	endif

	; TweakNamesScript.OnGameLoaded() doesn't do anything right now, but it may 
	; in the future and it is important for the main import loop.
	
	AFT:TweakNamesScript pTweakNamesScript = (pTweakNames as AFT:TweakNamesScript)
	if (pTweakNamesScript)
		; Trace("AFT:TweakMonitorPlayer : Calling TweakNamesScript.OnGameLoaded()")
		pTweakNamesScript.OnGameLoaded(firstcall)
	else
		Trace("Unable to Call TweakNamesScript.OnGameLoaded()")
	endif
	
	; TweakFollowerScript will kick off the import of existing followers process
	; if we are loading the first time. For the import functions to work, we
	; need TweakDFScript, FollowersScript and TweakNamesScript setup.
	; ready. Other scripts that support functionality like TweakPipBoyScript and 
	; TweakScrapScanMasterScript can wait. 
	
	AFT:TweakFollowerScript pTweakFollowerScript = pTweakFollower As AFT:TweakFollowerScript
	if (pTweakFollowerScript)
		; Trace("AFT:TweakMonitorPlayer : Calling TweakFollowerScript.OnGameLoaded()")
		pTweakFollowerScript.OnGameLoaded(firstcall)
	else
		Trace("Unable to Call TweakFollowerScript.OnGameLoaded()")
	endif

	AFT:TweakPipBoyScript pTweakPipBoyScript = pTweakPipBoy As AFT:TweakPipBoyScript
	if (pTweakPipBoyScript)
		; Trace("AFT:TweakMonitorPlayer : Calling TweakPipBoyScript.OnGameLoaded()")
		pTweakPipBoyScript.OnGameLoaded(firstcall)
	else
		Trace("Unable to Call TweakPipBoyScript.OnGameLoaded()")
	endif
	
	AFT:TweakVisualChoiceScript pTweakVisualChoiceScript = pTweakVisualChoice As AFT:TweakVisualChoiceScript
	if (pTweakVisualChoiceScript)
		; Trace("AFT:TweakMonitorPlayer : Calling TweakPipBoyScript.OnGameLoaded()")
		pTweakVisualChoiceScript.OnGameLoaded(firstcall)
	else
		Trace("Unable to Call TweakPipBoyScript.OnGameLoaded()")
	endif
	
	AFT:TweakChangeAppearance pTweakChangeAppearance = pTweakFollower As AFT:TweakChangeAppearance
	if (pTweakChangeAppearance)
		; Trace("AFT:TweakMonitorPlayer : Calling TweakPipBoyScript.OnGameLoaded()")
		pTweakChangeAppearance.OnGameLoaded(firstcall)
	else
		Trace("Unable to Call pTweakChangeAppearance.OnGameLoaded()")
	endif
		
	allowdraw  = true
	StartTimer(4.0,NO_ANIM_DRAW_FLOOD)
	StartTimer(4.0,NO_ANIM_SHEATH_FLOOD)

	allowsneak = true
	; StartTimer(4.0,NO_ANIM_SNEAKENTER_FLOOD)
	StartTimer(4.0,NO_ANIM_SNEAKEXIT_FLOOD)
	
	; Use This global to enable/disable certain menu options...
	TweakDebugMode.SetValue(0.0)
	UpdateTweakDebugMode()

	; Check for dialogue...
	; StartTimer(3,0)
		
	Trace("OnGameLoad() Finished")
	
EndFunction

; Function RequestSneakEnterAnimationEvent()
	; Trace("RequestSneakEnterAnimationEvent()")
	; Actor pc = Game.GetPlayer()
	; UnregisterForAnimationEvent(pc, "sneakStateEnter")
	; Utility.wait(0.5)
	; Bool succ = RegisterForAnimationEvent(pc, "sneakStateEnter")
	; if !succ
		; StartTimer(4.0,NO_ANIM_SNEAKENTER_FLOOD)
	; EndIf
; EndFunction

Function RequestSneakExitAnimationEvent()
	Trace("RequestSneakEnterAnimationEvent()")
	Actor pc = Game.GetPlayer()
	UnregisterForAnimationEvent(pc, "sneakStateExit")
	Utility.wait(0.5)
	Bool succ = RegisterForAnimationEvent(pc, "sneakStateExit")
	if !succ
		StartTimer(4.0,NO_ANIM_SNEAKEXIT_FLOOD)
	EndIf
EndFunction

Function RequestDrawAnimationEvent()

	Trace("RequestDrawAnimationEvent()")
	Actor pc = Game.GetPlayer()
	UnregisterForAnimationEvent(pc, "weaponDraw")
	Utility.wait(0.5)
	Bool succ = RegisterForAnimationEvent(pc, "weaponDraw")
	if !succ
		StartTimer(4.0,NO_ANIM_DRAW_FLOOD)
	EndIf

EndFunction

Function RequestSheathAnimationEvent()

	Trace("RequestSheathAnimationEvent()")
	Actor pc = Game.GetPlayer()
	UnregisterForAnimationEvent(pc, "weaponSheathe")
	Utility.wait(0.5)
	Bool succ = RegisterForAnimationEvent(pc, "weaponSheathe")
	if !succ
		StartTimer(4.0,NO_ANIM_SHEATH_FLOOD)
	EndIf

EndFunction

; Called From OnTimer Checks (Eventually?)
; Function OnDialogueBegin(ObjectReference ActorRef)
; 	AFT:TweakDFScript pTweakDFScript = ((pFollowers As Quest) as AFT:TweakDFScript)
; 	if pTweakDFScript
; 		pTweakDFScript.OnDialogueBegin(ActorRef)
; 	endif
; EndFunction

; Called From OnTimer Checks (Eventually?)
; Function OnDialogueEnd(ObjectReference ActorRef = None)
;	AFT:TweakDFScript pTweakDFScript = ((pFollowers As Quest) as AFT:TweakDFScript)
;	if pTweakDFScript
;		pTweakDFScript.OnDialogueEnd(ActorRef)
;	endif
; EndFunction

Function AftReset()
	RelayEvent  = false
	
	Trace("============= AftReset() ================")

	CancelTimer(NO_ANIM_DRAW_FLOOD)
	CancelTimer(NO_ANIM_SHEATH_FLOOD)
	; CancelTimer(NO_ANIM_SNEAKENTER_FLOOD)
	CancelTimer(NO_ANIM_SNEAKEXIT_FLOOD)
	CancelTimer(NO_LG_FLOOD_INIT)
	CancelTimer(NO_LG_FLOOD_CONT)
	CancelTimer(ALLOW_DRAW_TIMER)
	CancelTimer(ALLOW_SNEAK_TIMER)

	; Shelter Script relies on TweakFollowerScript methods for PowerArmor locating
	AFT:TweakShelterScript pTweakShelterScript = pTweakFollower As AFT:TweakShelterScript
	if (pTweakShelterScript)
		pTweakShelterScript.AftReset()
	endif
	
	; TweakFollowerScript makes use of FollowerScript methods, which rely on DFScript methods...
	AFT:TweakFollowerScript pTweakFollowerScript = pTweakFollower As AFT:TweakFollowerScript
	if (pTweakFollowerScript)
		pTweakFollowerScript.AftReset()
	endif
	
	; While some methods will relay to TweakFollower, AftReset does not call any TweakFollowerScript
	; methods
	AFT:TweakDFScript pTweakDFScript = (pFollowers as AFT:TweakDFScript)
	if (pTweakDFScript)
		pTweakDFScript.AftReset()
	endif
	
	; While some methods will relay to TweakDFScript, AftReset does not call any TweakDFScript
	; methods
	FollowersScript pFollowersScript = (pFollowers as FollowersScript)
	if (pFollowersScript)
		pFollowersScript.AftReset()
	endif
	
	AFT:TweakPipBoyScript pTweakPipBoyScript = pTweakPipBoy As AFT:TweakPipBoyScript
	if (pTweakPipBoyScript)
		pTweakPipBoyScript.AftReset()
		; PipBoyScript will also call TweakInterjections.UnregisterInterjections()
	endif
	
	TweakRegisterPrefabScript pRegisterPrefabs = pTweakSettlementLoader As TweakRegisterPrefabScript
	if pRegisterPrefabs
		pRegisterPrefabs.Cleanup()
	endif
	
	Actor player = Game.GetPlayer()	                          
	UnRegisterForRemoteEvent(player,"OnLocationChange")       
	UnRegisterForRemoteEvent(player,"OnLoad")                 
	UnRegisterForRemoteEvent(player,"OnSit")                  
	UnRegisterForRemoteEvent(player,"OnCripple")              
	UnRegisterForRemoteEvent(player,"OnItemEquipped")         
	UnRegisterForRemoteEvent(player,"OnItemUnequipped")       
	UnRegisterForRemoteEvent(player,"OnPlayerEnterVertibird") 
	UnregisterForAnimationEvent(player, "weaponDraw")
	UnregisterForAnimationEvent(player, "weaponSheathe")
	UnregisterForAnimationEvent(player, "sneakStateEnter")
	UnregisterForAnimationEvent(player, "sneakStateExit")

	Initialized				 = false
	IsInDialogue             = false
	SentFirstLoaded			 = false
	allowdraw				 = true
	allowsneak               = true
	
	pTweakFullReset.show()
endFunction

; Relayed by Perk TweakPlayerSwimMonitorPerk
Function OnPlayerStartSwim()
	; Give it 3 seconds leniency in case it was an accident.
	CancelTimer(EVALUATE_SWIMMING)
	if (!currentSwimmingState)
		desiredSwimmingState = true
		StartTimer(3.0,EVALUATE_SWIMMING)
	endif
EndFunction

; Relayed by Perk TweakPlayerSwimMonitorPerk
Function OnPlayerStopSwim()
	; Give it 5 seconds leniency to account for change time.
	CancelTimer(EVALUATE_SWIMMING)
	if (currentSwimmingState)
		desiredSwimmingState = false
		StartTimer(5.0,EVALUATE_SWIMMING)
	endif
EndFunction


; ====================================
; Monitored Player Events:
; ====================================
; Event OnTrackedStatsEvent(string asStat, int aiStatValue)

	; if ("Main Quests Completed" == asStat)
		; Trace("Receieved Event for Main Quests Completed : [" + aiStatValue + "]")
		; RegisterForTrackedStatsEvent("Main Quests Completed", aiStatValue + 1)
	; endif
	
	;; This could be useful if actor values current companions were incremented
	;; each time this fired. It would be a way to track progress and time spent
	;; with NPC...
	
	; if ("Locations Discovered" == asStat)
		; Trace("Receieved Event for Locations Discovered : [" + aiStatValue + "]")
		;; The old way of tracking when Player left Vault.... 
		;; if (1 == aiStatValue)
		;;   OnGameLoaded()
		;; endif
		; Trace("Current Location [" + Game.GetPlayer().GetCurrentLocation() + "]")		
		; RegisterForTrackedStatsEvent("Locations Discovered", aiStatValue + 1)
	; endif
; EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	; Trace("Animation Event [" + asEventName + "]")
	
	if (akSource != Game.GetPlayer())
		return
	endif

	if ("weaponDraw" == asEventName)
		if (allowdraw)
			allowdraw = false
			StartTimer(3,ALLOW_DRAW_TIMER)
			AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower as AFT:TweakFollowerScript)
			if pTweakFollowerScript && !ridingvertibird
				Var[] params = new Var[0]
				pTweakFollowerScript.CallFunctionNoWait("EventPlayerWeaponDraw",params)
				; pTweakFollowerScript.EventPlayerWeaponDraw()
			endif
		endif
	elseif ("weaponSheathe" == asEventName)
		CancelTimer(ALLOW_DRAW_TIMER)
		allowdraw = true
		AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower as AFT:TweakFollowerScript)
		if pTweakFollowerScript && !ridingvertibird
			Var[] params = new Var[0]
			pTweakFollowerScript.CallFunctionNoWait("EventPlayerWeaponSheath",params)
			; pTweakFollowerScript.EventPlayerWeaponSheath()
		endif
	; elseif ("sneakStateEnter" == asEventName)
		; if (allowsneak)
			; allowsneak = false
			; StartTimer(3,ALLOW_SNEAK_TIMER)
			
			; AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower as AFT:TweakFollowerScript)
			; if pTweakFollowerScript
				; Var[] params = new Var[0]
				; pTweakFollowerScript.CallFunctionNoWait("EventPlayerSneakStart",params)
				;; pTweakFollowerScript.EventPlayerSneakStart()
			; endif
			
		; endif
	elseif ("sneakStateExit" == asEventName)
		Trace("Animation Event [" + asEventName + "]")
		CancelTimer(ALLOW_SNEAK_TIMER)
		allowsneak = true
		AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower as AFT:TweakFollowerScript)
		if pTweakFollowerScript
			Var[] params = new Var[0]
			pTweakFollowerScript.CallFunctionNoWait("EventPlayerSneakExit",params)
			;pTweakFollowerScript.EventPlayerSneakExit()
		endif
	endif
endEvent

; God help us if we need to do polling....
Event Actor.OnEnterSneaking(Actor sneaker)
 	Trace("OnEnterSneaking")	
	if (allowsneak)
		allowsneak = false
		StartTimer(3,ALLOW_SNEAK_TIMER)
			
		AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower as AFT:TweakFollowerScript)
		if pTweakFollowerScript
			Var[] params = new Var[0]
			pTweakFollowerScript.CallFunctionNoWait("EventPlayerSneakStart",params)
			;pTweakFollowerScript.EventPlayerSneakStart()
		endif		
	endif
EndEvent

Event Actor.OnPlayerEnterVertibird(Actor player, ObjectReference akVertibird)
	ridingvertibird = true
 	Trace("OnPlayerEnterVertibird")	
	StartTimer(5.0,MONITOR_FLIGHT)
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower as AFT:TweakFollowerScript)
	if pTweakFollowerScript
		Var[] params = new Var[0]
		pTweakFollowerScript.CallFunctionNoWait("EventPlayerEnterVertibird",params)
	endif		
EndEvent

; Called from timer (polling) check
Function PlayerExitedVertibird()
	ridingvertibird = false
 	Trace("PlayerExitedVertibird")	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower as AFT:TweakFollowerScript)
	if pTweakFollowerScript
		Var[] params = new Var[0]
		pTweakFollowerScript.CallFunctionNoWait("EventPlayerExitedVertibird",params)
	endif	
EndFunction

Event Actor.OnSit(Actor player, ObjectReference akFurniture)
	Trace("OnSit")
	if akFurniture.HasKeyword(FurnitureTypePowerArmor)
		Trace("PA Detected [" + akFurniture + "]")
		Actor pc = Game.GetPlayer()
		ObjectReference opc = (pc as ObjectReference)
		ObjectReference oldPA = opc.GetLinkedRef(pLinkPowerArmor)
		ObjectReference PAPrevUser = akFurniture.GetLinkedRef(pLinkPowerArmor)
		
		; Cleanup links if there is a change in assignment...
		if (oldPA && oldPA != akFurniture && opc == oldPA.GetLinkedRef(pLinkPowerArmor))
			; Unassign link to Self on Previous PA (since we are no longer the user)
			oldPA.SetLinkedRef(None, pLinkPowerArmor)
		endif
		if (PAPrevUser && PAPrevUser != opc && akFurniture == PAPrevUser.GetLinkedRef(pLinkPowerArmor))
			; Unassign link to PA on previous PA's user since we are now using it...
			PAPrevUser.SetLinkedRef(None, pLinkPowerArmor)
		endif
		
		; Enforce assignment to Player
		opc.SetLinkedRef(akFurniture,pLinkPowerArmor)
		akFurniture.SetLinkedRef(opc,pLinkPowerArmor)

		AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower as AFT:TweakFollowerScript)
		if pTweakFollowerScript
			pTweakFollowerScript.EventPlayerEnterPA()
		endif

	endif	
endEvent

Event Actor.OnLocationChange(Actor player, Location akOldLoc, Location akNewLoc)
	StartTimer(4.0,NO_ANIM_DRAW_FLOOD)
	StartTimer(4.0,NO_ANIM_SHEATH_FLOOD)
endEvent

Event ObjectReference.OnLoad(ObjectReference akRef)
	Trace("OnLoad")
	StartTimer(4.0,NO_ANIM_DRAW_FLOOD)
	StartTimer(4.0,NO_ANIM_SHEATH_FLOOD)
endEvent

Event Actor.OnCripple(Actor player, ActorValue akActorValue, bool abCrippled)
	; Trace("OnCripple : " + akActorValue+ ", " + abCrippled)
EndEvent

Event Actor.OnItemEquipped(Actor player, Form akBaseObject, ObjectReference akReference)
	if akBaseObject.HasKeyword(isPowerArmorFrame)
		Trace("OnItemEquipped - Entered Powerarmor!")
	endif
EndEvent

Event Actor.OnItemUnequipped(Actor player, Form akBaseObject, ObjectReference akReference)
	if akBaseObject.HasKeyword(isPowerArmorFrame)
		Trace("OnItemUnequipped - Exiteded Powerarmor!")
		AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower as AFT:TweakFollowerScript)
		if pTweakFollowerScript
			pTweakFollowerScript.EventPlayerExitPA()
		endif		
	endif
EndEvent

; Event ScriptObject.OnPlayerSleepStart(ScriptObject akSenderRef, float afSleepStartTime, float afDesiredSleepEndTime, ObjectReference akBed)
	;; RegisterForPlayerSleep() ; Before we can use OnSleepStart we must register.
	; Trace("OnPlayerSleepStart")
; EndEvent

; Event ScriptObject.OnPlayerSleepStop(ScriptObject akSenderRef, bool abInterrupted, ObjectReference akBed)
	;; RegisterForPlayerSleep() ; Before we can use OnSleepStart we must register.
	; if abInterrupted
	    ; Trace("OnPlayerSleepStop (Interrupted)")
	; else
	    ; Trace("OnPlayerSleepStop")
	; endIf
; endEvent	


; Event ScriptObject.OnHit(ScriptObject akSenderRef, ObjectReference akTarget, ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked, string apMaterial)
	;; RegisterForHitEvent(playerRef)  - Must be registered to use
	; Trace("OnHit")
	;; Does not renew. Must be re-registered.
; EndEvent

; Event Actor.OnCombatStateChanged(Actor player, Actor akTarget, int aeCombatState)
;	Trace("OnCombatStateChanged")
; endEvent

; Event Actor.OnPlayerFireWeapon(Actor player, Form akBaseObject)
;	Trace("OnPlayerFireWeapon")
; EndEvent

; Event Actor.OnPlayerFallLongDistance(Actor player, float afDamage)
	; Trace("OnPlayerFallLongDistance")
; EndEvent

; Event Actor.OnPlayerHealTeammate(Actor player, Actor akTeammate)
	; Trace("OnPlayerHealTeammate")
; EndEvent


; Event ObjectReference.OnItemAdded(ObjectReference akSenderRef, Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	; Trace("OnItemAdded BASE [" + akBaseItem + "] Count [" + aiItemCount + "] OBJ [" + akItemReference + "] SRC [" + akSourceContainer + "]")
; EndEvent

; Event Actor.OnPlayerUseWorkBench(Actor player, ObjectReference akWorkBench)
; 	Trace("OnPlayerUseWorkBench")
; EndEvent

; Event Actor.OnPlayerSwimming(Actor player)
; 	Trace("OnPlayerSwimming")
; EndEvent

; Event ScriptObject.OnRadiationDamage(ScriptObject akSenderRef, ObjectReference akTarget, bool abIngested)
	;; Script Event. Needs to be re-registered after fire?
	;; RegisterForRadiationDamageEvent(PlayerRef)
	; Trace("OnRadiationDamage")
; EndEvent

; Event Actor.OnPlayerModArmorWeapon(Actor player, Form akBaseObject, ObjectMod akModBaseObject)
	; Trace("OnPlayerModArmorWeapon")
; EndEvent


; Event ScriptObject.OnMagicEffectApply(ScriptObject akSenderRef, ObjectReference akTarget, ObjectReference akCaster, MagicEffect akEffect)
	;; RegisterForMagicEffectApplyEvent(PlayerRef, akCasterFilter = none, akEffectFilter = CA_AddictionEffect)
	;; You must re-register with each event or it will not renew....
	; Trace("OnMagicEffectApply")
; EndEvent

; Event ScriptObject.OnPlayerTeleport(ScriptObject skSenderRef)
	;; RegisterForPlayerTeleport() ; Before we can use OnPlayerTeleport we must register.
	;Trace("OnPlayerTeleport()")
; endEvent	


