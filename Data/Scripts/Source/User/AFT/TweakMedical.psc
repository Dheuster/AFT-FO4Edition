Scriptname AFT:TweakMedical extends ReferenceAlias

Group Injected

	ReferenceAlias Property pInjured Auto Const
	ReferenceAlias Property pInfoNPC Auto Const
	
	Faction	Property pTweakEssentialFaction		Auto Const ; 0101BB23
	Faction	Property pTweakPosedFaction			Auto Const 
	Faction	Property pTweakFollowerFaction		Auto Const 
	Faction	Property pTweakMedicFaction			Auto Const
	Faction	Property pTweakMedicSpecialFaction	Auto Const
	Faction	Property pTweakNamesFaction			Auto Const
	Faction Property TweakManagedOutfit 		Auto Const
	Faction Property pCurrentCompanionFaction	Auto Const
	
	Quest Property TweakDLC01					Auto Const
	Quest Property TweakDLC03					Auto Const
	Quest Property TweakDLC04					Auto Const
	
	Keyword Property ActorTypeNPC				Auto Const ; Includes humans, ghouls and children
	Keyword Property ActorTypeSynth				Auto Const ; Includes synths and Valentine
	Keyword Property ActorTypeRobot				Auto Const
	Keyword Property ActorTypeSuperMutant		Auto Const
	Keyword Property ActorTypeHuman				Auto Const
	Keyword Property pArmorTypePower			Auto Const
	Keyword Property TweakActorTypeManaged		Auto Const
	Keyword Property CAT_Event_CompanionCrippled_Leg_Topic Auto Const
	Keyword Property CAT_Event_HealCompanion_Topic         Auto Const
	keyword Property playerCanStimpak 			auto const	
	
					
	Potion Property Stimpak 					Auto Const
	Potion Property RadAway 					Auto Const

	; Idles
	Idle Property IdleLockPickingLowHeight 		Auto Const ; 0x000F5A33
	Idle Property p3rdPUseStimpakOnSelfOnGround Auto Const ; 0x00246159
	Idle Property p3rdPFireChargeHold 			Auto Const ; 0x0011A18A
	Idle Property pPA3rdPUseStimpakOnTarget 	Auto Const
	Idle Property p3rdPUseStimpakOnTarget 		Auto Const
	Idle Property pRaiderEssentialEnd			Auto Const
	Idle Property pPowerArmorBleedoutStop		Auto Const
	Idle Property pInitializeWeaponInstant      Auto Const
	Idle Property pInitializeMTGraphInstant		Auto Const
	
	Sound Property NPCHumanStimpakNPCB 			Auto Const
	
	Weapon Property PipeSyringer 				Auto Const ; 0x0014D09E
	Weapon Property TweakPipeSyringer 			Auto Const
	
	ActorValue Property LeftAttackCondition 	Auto Const
	ActorValue Property LeftMobilityCondition	Auto Const
	ActorValue Property PerceptionCondition		Auto Const
	ActorValue Property RightAttackCondition	Auto Const
	ActorValue Property RightMobilityCondition	Auto Const
	ActorValue Property EnduranceCondition		Auto Const
	ActorValue Property Rads					Auto Const
	ActorValue Property Health					Auto Const
	ActorValue Property pFollowerState			Auto Const
	ActorValue Property pTweakInPowerArmor		Auto Const
	ActorValue Property TweakMedCount			Auto Const
	ActorValue Property HC_IsCompanionInNeedOfHealing Auto Const
	ActorValue Property Paralysis				Auto Const

	Spell Property CureAddictions				Auto Const
	
	Package Property pCommandMode_Travel		Auto Const
	
	ActorBase Property CompanionCurie			Auto Const
	ActorBase Property CompanionPiper			Auto Const
	ActorBase Property CompanionStrong			Auto Const
	
	Form Property InvisibleGeneric01			Auto Const
	
	; Hardcore Support
	Hardcore:HC_ManagerScript Property HC_Manager Auto Const
	
	GlobalVariable Property TweakAllowHealSelf	Auto Const
	GlobalVariable Property TweakAllowHealOther	Auto Const	
	GlobalVariable Property HC_Rule_CompanionNoHeal const auto
	
	Message	Property	TweakRescueHealedMsg	Auto Const
	Message	Property	TweakRescueFixedMsg		Auto Const
	Message	Property	TweakRescueMsgSpecial	Auto Const
	
EndGroup

Group LocalPersisted
	Bool	Property InBleedOut					Auto
	Bool    Property combatInProgress			Auto
	Bool    Property combatFollower				Auto hidden
	; Topic   Property BleedoutShout				Auto
EndGroup

; Hidden
String KnockoutFramework = "Knockout Framework.esm" const

; Constants
int TIMEOUT_STAGE_ONE		  = 997 const
int TIMEOUT_STAGE_TWO		  = 996 const
Actor medic = None

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakMedical" + self.GetActorRef().GetFactionRank(pTweakNamesFaction)
	; string logName = "TweakSettings"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Event OnInit()
	InBleedOut       = false
	combatInProgress = false
	combatFollower   = false
EndEvent

Function initialize()
	Actor npc = self.GetActorRef()
	Trace("initialize()  [" + npc.GetActorBase() + "]")
	medic = None
EndFunction

Function EventOnGameLoad()
	Trace("EventOnGameLoad() v2")
	Actor npc = self.GetActorRef()
	if npc
		CleanUp()
	endif
EndFunction

Function UnManage()
	Trace("UnManage() Called.")
	CleanUp()	
EndFunction

; Called by TweakSettings: OnCombatPeriodic
Function OnCombatBegin()
	Trace("OnCombatBegin()")
	combatInProgress=true
	if self.GetActorReference().IsInFaction(pCurrentCompanionFaction)
		combatFollower = true
	else
		combatFollower = false
	endif	
EndFunction

; Called by TweakSettings: OnCombatPeriodic
Function OnCombatPeriodic()
	Trace("OnCombatPeriodic()")
	if combatInProgress
		EvalCombatChecks()
	endif
EndFunction

; Called by TweakSettings: OnCombatEnd
Function OnCombatEnd()
	Trace("OnCombatEnd()")
	combatInProgress = false
	EvalCombatChecks()
	; ConfirmNoAutoDismiss()
EndFunction

Function ConfirmNoAutoDismiss()

	; In an ideal world, this would recover followers like Gage, but timing may not 
	; work out (Gage may go hostile before combat kicks off) and it could result 
	; in an infinite loop, with protection code kicking out followers who turn 
	; on the player and this re-importing them. 
	
	Actor npc = self.GetActorReference()
	if combatFollower && !npc.IsInFaction(pCurrentCompanionFaction)
		Trace("Follower Dismissed during combat. Attempting to fix")
		Quest Followers = Game.GetForm(0x000289E4) as Quest
		if Followers
			FollowersScript pFollowersScript = (Followers as FollowersScript)
			if pFollowersScript
				Var[] params = new Var[4]
				params[0] = npc
				params[1] = true
				params[2] = true
				params[3] = false
				Trace("Calling Async Function FollowersScript.SetCompanion()")
				pFollowersScript.CallFunctionNoWait("SetCompanion",params)
			else
				Trace("Followers Quest failed to caste to FollowersScript. Bailing")
			endif
		else
			Trace("Followers Quest failed to resolve. Bailing")
		endif
	endif
EndFunction
	
	
; Called from TweakInventoryScript during combat at 20 sec intervals while combat is running. 
; Only called on members of the CurrentCompanionFaction
Function EvalCombatChecks()
	Trace("EvalCombatChecks...")
	Actor npc = self.GetActorRef()
	
	; KnockOut Support
	if !npc.IsDead() && (npc.IsBleedingOut() || npc.IsUnconscious()	|| (npc.GetValue(Paralysis) == 1))
		Trace("NPC is Bleeding Out, Unconsious or Paralyzed at end of Combat (Final Check).")
		OnEnterBleedout()
	endif		
EndFunction

; Events are just specially types Functions, but at the end of the day, you can still invoke them just like
; functions...
Event OnEnterBleedout()
	Trace("OnEnterBleedout")
	
	Actor npc = self.GetActorRef()

	if !(npc.IsBleedingOut() || npc.IsUnconscious() || npc.GetValue(Paralysis) == 1.0)
		Trace("Event was not for us")
		return
	endIf
	
	; This shouldn't happen, but other mods like Knockout Framework may allow
	; essential NPCs to still get "knocked out". IE: Unconscious. So we remove
	; the essential early bail checks...
	;if npc.IsInFaction(pTweakEssentialFaction)
	;	Trace("NPC is essential. Skipping")
	;	return
	; endif	

	bool allowHealSelf  = (1.0 == TweakAllowHealSelf.GetValue())
	bool allowHealOther = (1.0 == TweakAllowHealOther.GetValue())
	if !(allowHealSelf || allowHealOther)
		Trace("Companion Healing Disabled. Skipping")
		return
	endif
	
	; We set this TweakMedCount to mark the state:
	; 0 = Processing Bleedout, but not yet deemed safe for assignment to Medical Manager
	; 1 = In Bleedout, failed race condition, so safe for Medical Manager assignment
	; 2 = In Bleedout, current Medical Manager
	npc.SetValue(TweakMedCount, 0.0)

	medic = None
	Potion requiredPotion = None
	Race  npRace = npc.GetRace()
	
	
	AFT:TweakDLC01Script pTweakDLC01 =  (TweakDLC01 as AFT:TweakDLC01Script)	
	if pTweakDLC01 && pTweakDLC01.Installed && npc.HasKeyword(pTweakDLC01.DLC01PlayerCanRepairKit)
		requiredPotion = pTweakDLC01.DLC01RepairKit ; 0x01004F12
	endif
	if !npRace.HasKeyWord(ActorTypeRobot)
		requiredPotion = Stimpak
	endif		
	if !requiredPotion
		requiredPotion = Stimpak
	endif

	Trace("Required : [" + requiredPotion + "]")

	if (allowHealSelf)
		if npc.GetItemCount(requiredPotion) > 0
			Trace("NPC has required. Self Healing....")
			npc.playIdle(p3rdPUseStimpakOnSelfOnGround)
			int SoundID = -1
			if Stimpak == requiredPotion
				SoundID = NPCHumanStimpakNPCB.Play(npc)
			else
				SoundID = pTweakDLC01.DLC01NPCHumanRobotRepairKitB.Play(npc)
			endif
			Utility.wait(2.0)
			if (-1 != SoundID)
				Sound.StopInstance(SoundID)
				SoundID = -1
			endif			
			
			npc.RemoveItem(requiredPotion)			
			HealAll(npc)
			TweakEndBleedOut(npc)
		
			; No need to call handle next as we healed ourself 
			; (No management of pInjured Alias required)
			
			return
		else
			Trace("NPC does not have required item.")
		endIf
	else
		Trace("Self Healing Disabled")
	endif
	
	if !allowHealOther
		Trace("Team Healing Disabled")		
		return
	endif
	
	; We need to be rescued.
	;
	; There can be only 1... so we use ForceRefIfEmpty to resolve
	; race conditions. If we "win", then we will be in the alias. 
	pInjured.ForceRefIfEmpty(npc)
	if npc != pInjured.GetActorReference()
		npc.SetValue(TweakMedCount, 1.0)
		Trace("NPC lost race. Waiting For next event....")
		return
	endif
	
	npc.SetValue(TweakMedCount, 2.0)
	Trace("NPC won race.")
	
	; We are now the medical manager (won by the race above). As such, 
	; we have a resposibility to clear the alias when we are 
	; healed or give up. We must also "pass the torch" on to others
	; who failed to get help while we were being helped. The method 
	; HandleNext() deals with cleanup and torch passing. All Exit
	; paths must eventually call it!
	
	npc.SetNoBleedoutRecovery(true)
	
	if (npc as CompanionActorScript)
		; Bleedout Topic. Non-CAS NPCs won't have anything to say. 
		npc.Say((Game.GetForm(0x000F450D) as Topic), npc, false, Game.GetPlayer())
	else
		npc.SayCustom(CAT_Event_CompanionCrippled_Leg_Topic)
	endif
	
	; Step one : Search for nearby Managed NPCs:
	; As a point of reference, the large floor tiles are length/width 256. 1536 is approx
    ; the width of the Player House. 	
	
	ObjectReference[] candidates = npc.FindAllReferencesWithKeyword(TweakActorTypeManaged, 2048)
	if 0 == candidates.Length
		Trace("No nearby NPCs with keyword TweakActorTypeManaged")
		HandleNext()
		return
	endif

	int candidatesLen = candidates.Length
	Trace("Found [" + candidatesLen + "] nearby NPCs with keyword TweakActorTypeManaged")
	
	float ComWait = 2.0000
	
	; Need Best Candidate with requiredPotion
	; Use a number of conditions to choose wisely:
	; - Not busy is best
	; - When all are busy, closer is better
	; - PipeSyringer handler only consider if all are busy or handler + other are both not busy. 
	
	Actor alternate   = None
	Actor test        = None
	Actor testNotBusy = None
	
	float closestSquaredDistance   = 5000 * 5000
	float closestNotBusyDistance   = closestSquaredDistance
	Race  teRace   = None
	int i = 0
	while (i < candidatesLen)
		test = candidates[i] as Actor
		if (test != npc)		
			if (!test.IsDead() && !test.IsBleedingOut() && !test.IsUnconscious() && (test.GetValue(Paralysis) != 1) && !test.IsInFaction(pTweakPosedFaction) && !test.IsDoingFavor() && test.GetCurrentPackage() != pCommandMode_Travel && test.GetValue(pFollowerState) != ComWait) 
				if (test.GetActorBase() == CompanionCurie && Stimpak == requiredPotion)				
					Trace("Candidate [" + i + "] is Curie and Stimpak is required Potion.")
					if (requiredPotion == Stimpak) && (test.GetItemCount(PipeSyringer) > 0)
						alternate = test
					endif
					if (NONE == test.GetCombatTarget())
						if SquaredDistanceWithin(test,npc,closestNotBusyDistance)
							Trace("Candidate [" + i + "] is not busy and closer than previous. <- New Best Non-Busy")
							testNotBusy = test
							closestNotBusyDistance = GetSquaredDistance(testNotBusy,npc)
						else
							Trace("Candidate [" + i + "] is not closer than previous Non-Busy. Ignoring")
						endif
					elseif SquaredDistanceWithin(test,npc,closestSquaredDistance)
						Trace("Candidate [" + i + "] is closer than previous. <- New Best")
						medic    = test
						closestSquaredDistance = GetSquaredDistance(test,npc)
					else
						Trace("Candidate [" + i + "] is not closer than previous. Ignoring")
					endif
					
				elseif (test.GetItemCount(requiredPotion) > 0)
					Trace("Candidate [" + i + "] has requiredPotion")								
					teRace = test.GetRace()
					if (teRace.HasKeyword(ActorTypeNPC) || teRace.HasKeyword(ActorTypeSynth) || teRace.HasKeyword(ActorTypeRobot) || teRace.HasKeyword(ActorTypeSuperMutant))
						Trace("Candidate [" + i + "] Passed Race Tests")								
						if (requiredPotion == Stimpak) && !alternate && (test.GetItemCount(PipeSyringer) > 0)
							alternate = test
						endif
						if (NONE == test.GetCombatTarget())
							if SquaredDistanceWithin(test,npc,closestNotBusyDistance)
								Trace("Candidate [" + i + "] is not busy and closer than previous. <- New Best Non-Busy")
								testNotBusy = test
								closestNotBusyDistance = GetSquaredDistance(testNotBusy,npc)
							else
								Trace("Candidate [" + i + "] is not closer than previous Non-Busy. Ignoring")
							endif
						elseif SquaredDistanceWithin(test,npc,closestSquaredDistance)
							Trace("Candidate [" + i + "] is closer than previous. <- New Best")
							medic    = test
							closestSquaredDistance = GetSquaredDistance(test,npc)
						else
							Trace("Candidate [" + i + "] is not closer than previous. Ignoring")
						endif					
					else
						Trace("Candidate [" + i + "] failed Race tests")								
					endif
				else
					Trace("Candidate [" + i + "] does not have the required potion")								
				endif
			else
				Trace("Candidate [" + i + "] (" + test + ") is Dead, bleedingout, Posed or in Command Mode")
			endif
		else
			Trace("Candidate [" + i + "] is self")
		endif
		i += 1
	endWhile
	
	if !medic && !testNotBusy
		Trace("No valid candidates found. Bailing")								
		HandleNext()
		return
	endIf
	
	if testNotBusy
		; Only consider alternate if they are also not busy...
		if (alternate && (alternate.GetCombatTarget()))
			alternate = NONE
		endIf
		medic = testNotBusy
	endIf
	
	if (medic == alternate) || (alternate && Utility.RandomInt(1,100) < 50)
		HandleSpecial(alternate)
		return
	endif
	
	; Add Faction Membership to medic that will cause them to run over to this NPC. A few things:
	; - We need a distance handler to "finish" once they get close enough. 
	; - We need to register some events to deal with failure:
	;   - Maybe they are marked mortal and die along the way...
	;   - Maybe they go into bleedout themselves. 
	;   - Maybe they get stuck on something and can't reach us. 
	;   - Maybe the player hotkeys COMMAND_MODE  
	; 
	; So: 
	; 1) Register OnDeath, OnEnterBleedout and OnCommandModeGiveCommand handlers for our would be rescuer.
	;    If any of these fire at anytime, call handleNext() (update to cancel all timers/distance events)
	; 2) Register a Distance Handler that will stop the travel AI once they are within range and finish up the events
	;    (heal/ idle/ and removal of item if they still have it). 
	; 3) Register a 2 stage timeout. First stage teleports them nearby to a safe location. If second timeout is readhed, 
	;    bail.
	
	Trace("Registering for Events")	
	RegisterForRemoteEvent(medic, "OnDeath")
	RegisterForRemoteEvent(medic, "OnEnterBleedout")
	RegisterForRemoteEvent(medic, "OnCommandModeGiveCommand")
	RegisterForDistanceLessThanEvent(medic,npc, 75)
	Trace("Starting Timers")
	StartTimer(10.0, TIMEOUT_STAGE_ONE)
	StartTimer(16.0, TIMEOUT_STAGE_TWO)
	Trace("Applying AI")
	medic.AddToFaction(pTweakMedicFaction)
	medic.EvaluatePackage()

EndEvent

Event OnDistanceLessThan(ObjectReference pMedic, ObjectReference npc, float afDistance)
	Trace("OnDistanceLessThan() Called.")
	UnregisterForDistanceEvents(pMedic, npc)
	SaveMe(pMedic as Actor)
EndEvent

Function SaveMe(Actor pMedic)
	Trace("SaveMe() Called")

	CancelTimer(TIMEOUT_STAGE_ONE)
	CancelTimer(TIMEOUT_STAGE_TWO)
	
	if pMedic
		Actor npc = self.GetActorRef()	
		Race npRace = npc.getRace()	
		
		Potion requiredPotion = None	
		AFT:TweakDLC01Script pTweakDLC01 =  (TweakDLC01 as AFT:TweakDLC01Script)	
		if pTweakDLC01 && pTweakDLC01.Installed && npc.HasKeyword(pTweakDLC01.DLC01PlayerCanRepairKit)
			requiredPotion = pTweakDLC01.DLC01RepairKit
		endif
		if !npRace.HasKeyWord(ActorTypeRobot)
			requiredPotion = Stimpak
		endif		
		if !requiredPotion
			requiredPotion = Stimpak
		endif

				
		; Make pMedic play animation. 
		bool stopIdle = false
		if requiredPotion == Stimpak
			if (1.0 == medic.GetValue(pTweakInPowerArmor) || medic.WornHasKeyword(pArmorTypePower))
				Trace("PowerArmor Detected")
				if !pMedic.playIdleWithTarget(pPA3rdPUseStimpakOnTarget, npc )
					pMedic.playIdle(IdleLockPickingLowHeight)
					stopIdle = true
				endif
												
			else
				if !pMedic.playIdleWithTarget(p3rdPUseStimpakOnTarget, npc )
					pMedic.playIdle(IdleLockPickingLowHeight)
					stopIdle = true
				endif				
			endif
			
			pInfoNPC.ForceRefTo(medic)
			TweakRescueHealedMsg.Show()
			pInfoNPC.Clear()
			
		else
			pMedic.playIdle(IdleLockPickingLowHeight)
			stopIdle = true
			Sound NPCHumanRobotRepair  =  pTweakDLC01.DLC01NPCHumanRobotRepairKitB
			int NPCHumanRobotRepairSnd = NPCHumanRobotRepair.Play(npc)
			Utility.wait(2.0)
			if (-1 != NPCHumanRobotRepairSnd)
				Sound.StopInstance(NPCHumanRobotRepairSnd)
				NPCHumanRobotRepairSnd = -1
			endif
			
			pInfoNPC.ForceRefTo(medic)
			TweakRescueFixedMsg.Show()
			pInfoNPC.Clear()
			
		endif
			
		; Finish
		pMedic.RemoveItem(requiredPotion)
		pMedic.RemoveFromFaction(pTweakMedicFaction)
		
		HealAll(npc)

		if stopIdle
			pMedic.PlayIdle(pInitializeWeaponInstant)
		endif
		
		TweakEndBleedOut(npc)
		
		; Speak Thank You
		;   Notes : Piper mentions  "Blue",  So skip Piper
		;           Strong mentions "Human". So only speak if medic is human
		
		if (npRace.HasKeyword(ActorTypeNPC) || npRace.HasKeyword(ActorTypeSynth) || npRace.HasKeyword(ActorTypeRobot) || npRace.HasKeyword(ActorTypeSuperMutant))
			ActorBase npcBase = npc.GetActorBase()
			if npcBase != CompanionPiper
				if npcBase == CompanionStrong
					if (medic.GetRace().HasKeyword(ActorTypeHuman))
						npc.SayCustom(CAT_Event_HealCompanion_Topic)
					endif
				else
					npc.SayCustom(CAT_Event_HealCompanion_Topic)
				endif
			endif
		endif		
	endif
	
	HandleNext()
EndFunction

Function HandleSpecial(Actor pMedic)
	Trace("HandleSpecial")								
	Actor npc = self.GetActorRef()

	pMedic.AddItem(TweakPipeSyringer)
	Trace("Activating Special Medic AI")
		
	; Wierd things happen with clothes if NPC is not marked teammate
	; when item change events occur (and they have no default outfit)
	bool unsetplayerteeammate = false
	if !pMedic.IsPlayerTeammate()
		pMedic.SetPlayerTeammate(true)
		unsetplayerteeammate = true
	endif
	
	pMedic.AddToFaction(pTweakMedicSpecialFaction)
	pMedic.EvaluatePackage()

	; Give them up to 5 seconds to turn and establish LOS with injured. 
	int i = 5
	while (i > 0 && !pMedic.HasDetectionLOS(npc))
		Utility.wait(1.0)
		i -= 1
	endWhile
	
	if (0 == i)		
		Trace("Medic LOS Timeout. Bailing")
		if unsetplayerteeammate
			pMedic.SetPlayerTeammate(false)
		endIf		
		HandleNext()
		return
	endif
	
	Trace("Medic has LOS with Injured")
	
	; Play Sound Effect
	int SndID = NPCHumanStimpakNPCB.Play(pMedic)
	Utility.wait(2.0)

	if (-1 != SndID)
		Sound.StopInstance(SndID)
		SndID = -1
	endif

	pInfoNPC.ForceRefTo(medic)
	TweakRescueMsgSpecial.Show()
	pInfoNPC.Clear()	
	
	pMedic.RemoveFromFaction(pTweakMedicSpecialFaction)
	pMedic.EvaluatePackage()
	
	Utility.wait(1.0)	
		
	if unsetplayerteeammate
		pMedic.SetPlayerTeammate(false)
	endIf

	pMedic.UnEquipItem(TweakPipeSyringer)
	Utility.wait(0.5)
	pMedic.RemoveItem(TweakPipeSyringer,99)
	pMedic.RemoveItem(Stimpak)
	
	HealAll(npc)
	
	pMedic.PlayIdle(pInitializeWeaponInstant)

	TweakEndBleedOut(npc)

	
	HandleNext()	
EndFunction

Function TweakEndBleedOut(Actor npc)
	Trace("TweakEndBleedOut()")
	npc.SetNoBleedoutRecovery(false)
	npc.StopCombat()
	
	Utility.wait(1.0)

	npc.SetPosition(npc.GetPositionX(),npc.GetPositionY(),npc.GetPositionZ())
	npc.SetAngle(0.0,0.0,npc.GetAngleZ())
	
	Race npRace = npc.getRace()	
	if npRace.HasKeyword(ActorTypeNPC) || npRace.HasKeyword(ActorTypeSynth)
		Trace("NPC is Humanoid (Could fit in PA)")
			
		
		if (1.0 == npc.GetValue(pTweakInPowerArmor) || npc.WornHasKeyword(pArmorTypePower))
			Trace("PowerArmor Detected")
			if npc.PlayIdle( pPowerArmorBleedoutStop )
				Utility.wait(1.0)
			endif
		else
			Trace("No PowerArmor Detected")
			if npc.PlayIdle( pRaiderEssentialEnd )
				Utility.wait(2.3)
			endif
		endif
		npc.PlayIdle(pInitializeWeaponInstant)
	elseif (npRace.HasKeyword(ActorTypeSuperMutant))
		Trace("SuperMutant")
		Utility.wait(3.0)
		npc.PlayIdle(pInitializeWeaponInstant)
	else
		Trace("None Humanoid")
		Utility.wait(3.0)
		npc.PlayIdle(pInitializeMTGraphInstant)
	endif
	if (1.0 == HC_Rule_CompanionNoHeal.GetValue())
		npc.SetNoBleedoutRecovery(true)
	endif
EndFunction

Event OnTimer(int aiTimerID)
	CancelTimer(aiTimerID)
	if (TIMEOUT_STAGE_ONE == aiTimerID)
		Trace("Operation is slow. Helping with teleport")
		if medic
			ObjectReference spawnMarker = medic.PlaceAtMe(InvisibleGeneric01)		
			Actor npc = self.GetActorRef()
			float[] pos = TraceCircle(npc, 90)
			spawnMarker.SetPosition(pos[0],pos[1],pos[2])
			spawnMarker.MoveToNearestNavmeshLocation()
			medic.SetPosition(spawnMarker.GetPositionX(), spawnMarker.GetPositionY(), spawnMarker.GetPositionZ())
			medic.SetAngle(0.0,0.0, medic.GetAngleZ() + medic.GetHeadingAngle(npc))
			spawnMarker.disable()
			spawnMarker.delete()
		else
			Trace("Assertion Failure. No medic.")
		endif
	elseif (TIMEOUT_STAGE_TWO == aiTimerID)
		Trace("Operation Timed Out. Calling HandleNext")
		HandleNext()	
	endif
EndEvent

		
Event Actor.OnDeath(Actor pMedic, Actor dontCare)
	trace("Medic OnDeath")
	Actor npc = self.GetActorRef()
	UnRegisterForRemoteEvent(pMedic, "OnDeath")
	HandleNext()	
EndEvent

Event Actor.OnEnterBleedout(Actor pMedic)
	trace("Medic OnEnterBleedout")
	UnRegisterForRemoteEvent(pMedic, "OnEnterBleedout")
	HandleNext()
EndEvent

Event Actor.OnCommandModeGiveCommand(Actor pMedic, int aeCommandType, ObjectReference akTarget)
	Trace("Medic OnCommandModeGiveCommand")
	UnRegisterForRemoteEvent(pMedic, "OnCommandModeGiveCommand")
	HandleNext()
EndEvent

Function HandleNext()
	Trace("HandleNext")
	CleanUp()	
		
	Trace("Searching for candidate...")

	Actor npc = self.GetActorRef()	
	ObjectReference[] candidates = npc.FindAllReferencesWithKeyword(TweakActorTypeManaged, 3500)
	Actor candidate = None	
	int candidatesLen = candidates.Length
	int i = 0
	while (i < candidatesLen)
		candidate = candidates[i] as Actor
		if (candidate.IsBleedingOut() || candidate.IsUnconscious() || (candidate.GetValue(Paralysis) == 1.0))&& (1.0 == candidate.GetValue(TweakMedCount))
			Trace("Calling OnEnterBleedout on Candidate [" + candidate + "]")
			
			; I'm not sure if doing it this way releases the thread, so I decided to go through
			; candidate.OnEnterBleedout()
			candidate.CallFunctionNoWait("OnEnterBleedout", new Var[0])
			
			; TweakFollowerScript pTweakFollowerScript = (GetOwningQuest() as TweakFollowerScript)
			; if pTweakFollowerScript
			;	pTweakFollowerScript.RelayMedicalOnBleedOut(candidate)
			; endif
			return
		endif
		i += 1
	endWhile	
	Trace("No eligable candidates (InBleedout) Found")
EndFunction

Function CleanUp()
	Trace("CleanUp")
	Actor npc = self.GetActorRef()
	npc.SetValue(TweakMedCount, 0.0) ; intentional. Dont want "hot potatoe" handed back to us.
	if (0.0 == HC_Rule_CompanionNoHeal.GetValue())
		npc.SetNoBleedoutRecovery(false)
	endif
	CancelTimer(TIMEOUT_STAGE_ONE)
	CancelTimer(TIMEOUT_STAGE_TWO)
	
	if medic
		Trace("Cleaning up medic.")		
		UnregisterForDistanceEvents(medic, npc)
		UnRegisterForRemoteEvent(medic, "OnDeath")
		UnRegisterForRemoteEvent(medic, "OnEnterBleedout")
		UnRegisterForRemoteEvent(medic, "OnCommandModeGiveCommand")
		if medic.IsInFaction(pTweakMedicFaction)
			medic.RemoveFromFaction(pTweakMedicFaction)
			if !medic.IsBleedingOut() && !medic.IsDead() && !medic.IsUnconscious() && (medic.GetValue(Paralysis) != 1.0)
				medic.EvaluatePackage()
			endif
		elseif medic.IsInFaction(pTweakMedicSpecialFaction)
			medic.RemoveFromFaction(pTweakMedicSpecialFaction)
			medic.EvaluatePackage()		
		endif
		medic = None
	endif
	
	if (npc == pInjured.GetActorRef())
		pInjured.Clear()	
	endif

EndFunction


Function HealAll(Actor myPatient)
	Trace("HealAll()")

	if myPatient.IsUnconscious()
		myPatient.SetUnconscious(False)
		if 1 == myPatient.GetValue(Paralysis)
			myPatient.SetValue(Paralysis, 0)
			if (Game.IsPluginInstalled(KnockoutFramework))	
				Keyword KFKnockedOutKeyword    = Game.GetFormFromFile(7893, KnockoutFramework) as Keyword ; 0x01001ED5
				if KFKnockedOutKeyword
					if myPatient.Haskeyword(KFKnockedOutKeyword)
						myPatient.RemoveKeyword(KFKnockedOutKeyword)
					endif
				endif
			endif
		endif
	endif
	
	int RadsToHeal = (mypatient.GetValue(Rads) as int)
	mypatient.RestoreValue(Rads, RadsToHeal)
	myPatient.RestoreValue(Health, 9999)
	myPatient.RestoreValue(LeftAttackCondition, 9999)
	myPatient.RestoreValue(LeftMobilityCondition, 9999)
	myPatient.RestoreValue(PerceptionCondition, 9999)
	myPatient.RestoreValue(RightAttackCondition, 9999)
	myPatient.RestoreValue(RightMobilityCondition, 99999)
	myPatient.RestoreValue(EnduranceCondition, 9999)
	
	;for new survival - curing diseases
	if myPatient == Game.GetPlayer()
		HC_Manager.ClearDisease()
	else
		myPatient.SetValue(HC_IsCompanionInNeedOfHealing, 0)
	endif
	CureAddictions.Cast(myPatient, myPatient)
	myPatient.SetCanDoCommand(False)
	myPatient.SetGhost(False)
	
EndFunction

; ==========================================================================
; Common Local Utility
; ==========================================================================

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

; SQUARE ROOT is expensive. Most people dont actually want to KNOW the distance. They
; simply want equality or range checks, which you can do without the square root. No
; square root means you can also early bail on otherwise expensive calls.
Bool Function SquaredDistanceWithin(ObjectReference a, ObjectReference b, float squaredRadius)
	float factor = a.GetPositionX() - b.GetPositionX()
	float total  = (factor * factor)
	; Early bail if we can. 
	if (total > squaredRadius)
		return false
	endif
	factor = a.GetPositionY() - b.GetPositionY()
	total += (factor * factor)
	; Early bail if we can. 
	if (total > squaredRadius)
		return false
	endif
	factor = a.GetPositionZ() - b.GetPositionZ()
	total += (factor * factor)
	return (squaredRadius > total)
EndFunction

float Function GetSquaredDistance(ObjectReference a, ObjectReference b)
	float factor = a.GetPositionX() - b.GetPositionX()
	float total  = (factor * factor)
	factor = a.GetPositionY() - b.GetPositionY()
	total += (factor * factor)
	return total
EndFunction

Float Function Enforce360Bounds(float a)
    if (a < 0) 
        a = a + 360
    endif
    if (a >= 360)
        a = a - 360
    endif 
	return a
EndFunction	