; TODO: 
; - pSanctuaryHillsWorld <- Correct value
; - pVault111Location    <- Correct value
; - Confirm pTweakDLC01, etc.. .are properly injected...

Scriptname AFT:TweakMonitorPlayerScript extends Quest

; NOTES: ANY ATTEMPT to edit the players inventory on a startgame enabled quest will break New Games
; (Infinite intro video or black screen). You CAN NOT mess with the players inventory until after
; they have the pipboy... That is why all the quest stage checks
;
; The easiest thing to do is check if MQ102.GetCurrentStageID() < 10. If it is 10 or more, you
; are good. If it is less than 10, you can remotely register for the OnStageSet event so your
; script gets informed when the player exits the vault. However, ALT start mods like StartMe up 
; may skip that quest entirely. The next best thing is to check for PipBoy, but then there are
; mods like PipPad that replace the Pipboy. You could check for the Common Wealth, but What if they
; install your mod while in a DLC area. 

Quest		Property pFollowers				Auto Const
Quest		Property pTweakFollower			Auto Const
Quest		Property pTweakNames			Auto Const
Quest		Property pTweakPipBoy			Auto Const
Quest		Property pTweakVisualChoice		Auto Const
Quest		Property pTweakSettlementLoader	Auto Const
Quest		Property pTweakDLC01			Auto Const
Quest		Property pTweakDLC03			Auto Const
Quest		Property pTweakDLC04			Auto Const
Quest		Property pTweakCOMSpouse    	Auto Const
Quest		Property pTweakInterjections	Auto Const

Bool		Property IsInDialogue			Auto
Bool		Property RelayEvent				Auto
Bool		Property Initialized			Auto
Bool		Property SentFirstLoaded		Auto
float		Property version				Auto
Armor		Property pPipboy				Auto Const
Quest		Property pMQ102					Auto Const

keyword		Property isPowerArmorFrame			Auto Const
Keyword		Property pLinkPowerArmor			Auto Const
Keyword		Property FurnitureTypePowerArmor	Auto Const
Message		Property pTweakFullReset			Auto Const

GlobalVariable	Property TweakDebugMode				Auto Const
WorldSpace		Property pCommonWealth				Auto Const
WorldSpace		Property pSanctuaryHillsWorld		Auto Const
Location        Property pVault111Location			Auto Const
Location		Property pPrewarVault111Location	Auto Const
Location		Property pMQ203Location				Auto Const

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
	version					= 1.0
	Initialized				= false
	IsInDialogue			= false
	SentFirstLoaded			= false
	RelayEvent				= true ; Set this to false if Uninstalled
	allowdraw				= true
	allowsneak				= true
	currentSwimmingState	= false
	desiredSwimmingState	= false
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
	Trace("OnQuestInit() Received")
	
	Actor player = Game.GetPlayer()
	RegisterForRemoteEvent(player,"OnPlayerLoadGame")           ; Startup...
	if !Initialized
		InitializationCheck()
	endif
	
EndEvent

Event Actor.OnPlayerLoadGame(Actor akSender)
	Trace("OnPlayerLoadGame Receieved")
	RelayEvent  = true		
	if (!Initialized)
		InitializationCheck()
		return
	endif
	StartTimer(4,NO_LG_FLOOD_INIT)	
EndEvent


Function InitializationCheck()
	Trace("InitializationCheck Receieved")
	; Assume Initialized is false
	bool timetoinit = false
	
	; The trump condition:
	if (pMQ102.GetCurrentStageID() > 9)
		timetoinit = true
	endif	
	
	if (!timetoinit)
		Actor player = Game.GetPlayer()

		; timetoinit override for ALT START MODS:
		;
		;  1 Not in Preware prologue worldspace
		;  2 Not within interior area of Vault111
		;  3 Player has inventory available
	
		if (player.GetWorldSpace() != pSanctuaryHillsWorld)
		
			Location currentLocation = player.GetCurrentLocation()
			trace("GetWorldSpace = [" + player.GetWorldSpace() + "] Location = [" + currentLocation + "]")
			
			; There are no less than 3 Vault 111's....
			; 1) The clean vault from the games intro (pPrewarVault111Location : 0x000CA853)
			; 2) The Kellog scene Cryo room specifically for the shooting event and the memory lounger. (pMQ203Location : 0x000D41A4)
			; 3) The post-prologue version you can revisit with companions : (0x0001F3FE)
		
			if (pPrewarVault111Location != currentLocation)
				if (pMQ203Location != currentLocation)
					if !(pVault111Location == currentLocation && player.IsInInterior())
						trace("IsInInterior = [" + player.IsInInterior() + "]")
						if player.GetItemCount() != 0
							trace("Player has [" + player.GetItemCount() + "] inventory items")	
							timetoinit = true
						else
							trace("Player has no inventory")						
						endif
					else
						trace("inVault111 (pVault111Location)")
					endif
				else
					trace("inVault111 (pMQ203Location)")
				endif
			else
				trace("inVault111 (pPrewarVault111Location)")
			endif
		else
			trace("isSanctuaryHillsWorld")
		endif	
	endif
	
	if timetoinit
		Utility.wait(10)
		InitializeAft()
		return
	endif
	
	; If the trump condition fails, we still need to register for 
	; some events so we can initialize as soon as the conditions 
	; above are met:
		
	RegisterForRemoteEvent(Game.GetPlayer(),"OnLocationChange")
	RegisterForRemoteEvent(pMQ102,"OnStageSet")
	
EndFunction

Event Quest.OnStageSet(Quest pMQ102, int auiStageID, int auiItemID)

	Trace("Quest.OnStageSet() Receieved [" + auiStageID + "]")	
	if auiStageID < 10
		Trace("Ignored")
		return
	endif
	if (!Initialized)
		InitializationCheck()
	else
		UnRegisterForRemoteEvent(pMQ102,"OnStageSet")		
	endif
	
EndEvent

Event Actor.OnLocationChange(Actor player, Location akOldLoc, Location akNewLoc)

	Trace("Actor.OnLocationChange() Receieved old [" + akOldLoc + "] new [" + akNewLoc + "]")	
	if !Initialized
		InitializationCheck()
		return
	endif
	
	StartTimer(4.0,NO_ANIM_DRAW_FLOOD)
	StartTimer(4.0,NO_ANIM_SHEATH_FLOOD)
	
endEvent

Function InitializeAft()

	; This is called one time. See InitializationCheck() above for conditions.
	
	Trace("InitializeAft()")
	Initialized = true

	Actor player = Game.GetPlayer()
	
	UnRegisterForRemoteEvent(pMQ102,"OnStageSet")
	UnRegisterForRemoteEvent(player,"OnLocationChange")
	
	RegisterForRemoteEvent(player,"OnLocationChange")           ; Maintenance scripts...
	RegisterForRemoteEvent(player,"OnLoad")                     ; Maintenance scripts...
	RegisterForRemoteEvent(player,"OnSit")                      ; PA Tracking and Eventing Support
	
	
	RegisterForRemoteEvent(player,"OnCripple")                  ; Possible use to trigger Custom Combat Actions
	RegisterForRemoteEvent(player,"OnItemEquipped")             ; Detect PowerArmor State
	RegisterForRemoteEvent(player,"OnItemUnequipped")           ; Detect PowerArmor State
	RegisterForRemoteEvent(player,"OnPlayerEnterVertibird")     ; Hide all but 1 companion	
	
	; RegisterForPlayerSleep()                                  ; ???
	; RegisterForRemoteEvent(player,"OnPlayerSleepStart")       ; ???	
	; RegisterForRemoteEvent(player,"OnPlayerSleepStop")        ; ???
	
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

int NO_ANIM_DRAW_FLOOD		= 999 const
int NO_ANIM_SHEATH_FLOOD	= 998 const
int NO_ANIM_SNEAKEXIT_FLOOD	= 996 const
int NO_LG_FLOOD_INIT		= 995 const
int NO_LG_FLOOD_CONT		= 994 const
int ALLOW_DRAW_TIMER		= 993 const
int ALLOW_SNEAK_TIMER		= 991 const
int MONITOR_FLIGHT			= 990 const
int EVALUATE_SWIMMING		= 989 const

Event OnTimer(int aiTimerID)

	CancelTimer(aiTimerID)
	
	if (!RelayEvent)
		return
	endif
		
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
				Trace("Unable to Call TweakFollowerScript.OnPlayerStartSwim()")
			endIf
		endIf
		return
	endIf
	
	; aiTimerID == 1 set by OnPlayerLoadGame()
	if (NO_LG_FLOOD_INIT == aiTimerID || NO_LG_FLOOD_CONT == aiTimerID)
			
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
		OnGameLoaded()
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
	
EndEvent

Function OnGameLoaded()

	Trace("OnGameLoad()")
	
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
		Trace("Unable to Call pTweakVisualChoiceScript.OnGameLoaded()")
	endif
	
	AFT:TweakChangeAppearance pTweakChangeAppearance = pTweakFollower As AFT:TweakChangeAppearance
	if (pTweakChangeAppearance)
		; Trace("AFT:TweakMonitorPlayer : Calling TweakPipBoyScript.OnGameLoaded()")
		pTweakChangeAppearance.OnGameLoaded(firstcall)
	else
		Trace("Unable to Call pTweakChangeAppearance.OnGameLoaded()")
	endif
	
	AFT:TweakCOMSpouseScript pTweakSpouse = pTweakCOMSpouse As AFT:TweakCOMSpouseScript	
	if (pTweakSpouse)
		; Trace("AFT:TweakMonitorPlayer : Calling TweakPipBoyScript.OnGameLoaded()")
		pTweakSpouse.OnGameLoaded(firstcall)
	else
		Trace("Unable to Call pTweakSpouse.OnGameLoaded()")
	endif

	AFT:TweakInterjectionQuestScript pTweakInterjectionQuestScript = pTweakInterjections as AFT:TweakInterjectionQuestScript
	if pTweakInterjectionQuestScript
		pTweakInterjectionQuestScript.OnGameLoaded(firstCall)
	else
		Trace("Unable to Call pTweakInterjectionQuestScript.OnGameLoaded()")	
	endif
	
	allowdraw  = true
	StartTimer(4.0,NO_ANIM_DRAW_FLOOD)
	StartTimer(4.0,NO_ANIM_SHEATH_FLOOD)

	allowsneak = true
	StartTimer(4.0,NO_ANIM_SNEAKEXIT_FLOOD)
	
	; Use This global to enable/disable certain menu options...
	TweakDebugMode.SetValue(0.0)
	UpdateTweakDebugMode()

	Trace("OnGameLoad() Finished")
	
EndFunction

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

Function AftReset()
	RelayEvent  = false
	
	Trace("============= AftReset() ================")

	CancelTimer(NO_ANIM_DRAW_FLOOD)
	CancelTimer(NO_ANIM_SHEATH_FLOOD)
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

	Initialized				= false
	IsInDialogue			= false
	SentFirstLoaded		= false
	allowdraw					= true
	allowsneak				= true
	
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
