Scriptname AFT:TweakSettlersScript extends Quest

; TODO:
;  - Don't set the settlement attack timer when importing using AFT. Leave window open for users who 
;    dont want to deal with attacks. 

RefCollectionAlias Property pSettlers Auto Const
WorkshopParentScript Property WorkshopParent Auto Const
Keyword Property WorkshopLinkSandbox Auto Const
Keyword Property WorkshopLinkCenter Auto Const
Keyword Property WorkshopLinkHome Auto Const
Keyword	Property WorkshopKeyword Auto Const
Keyword Property AO_Type_WorkshopResourceObject Auto Const

Location Property SanctuaryHillsLocation Auto Const

Faction	Property FarmerGenericDialogue Auto Const    ;*
Faction	Property FarmerGenericChild Auto Const       ;*
Faction Property CurrentCompanionFaction Auto Const
Faction Property WorkshopNPCFaction Auto Const
Faction Property WorkshopDialogueFaction Auto Const
Faction	Property GenericNPCFaction Auto Const
Faction	Property REFarmerFaction Auto Const
Faction	Property TweakSettlerFaction Auto Const

ActorValue Property TweakSettlerMultiResourceId Auto Const
ActorValue Property TweakSettlerIsWorker    Auto Const
ActorValue Property TweakSettlerIsGuard     Auto Const
ActorValue Property TweakSettlerIsScavenger Auto Const
ActorValue Property TweakSettlerMultiResourceProduction Auto Const
ActorValue Property TweakSettlerActivationCount Auto Const
ActorValue Property TweakSettlerWork24Hours Auto Const
Keyword	   Property TweakSettlerBrahmin Auto Const
Quest	   Property BoS302 Auto Const

GlobalVariable Property pTweakMutexCompanions	Auto Const

ObjectReference Property CaitPostCombatMarker01			Auto Const ; 0x000C73E9
ObjectReference Property CodsworthKitchenMarker			Auto Const ; 0x00023CBC
ObjectReference Property COMCurieIntroMarker			Auto Const ; 0x00239ED3
ObjectReference Property BoS101PlayerStartMarker		Auto Const ; 0x00193F92
ObjectReference Property BoS201DanseMessHallMarker		Auto Const ; 0x000AA1B9	
ObjectReference Property DeaconHomeMarker				Auto Const ; 0x00050987
ObjectReference Property RedRocketCenterMarker			Auto Const ; 0x0004BE79
ObjectReference Property MS04HancockEndMarker			Auto Const ; 0x0012937E
ObjectReference Property COMMacCreadyStartMarker		Auto Const ; 0x00115EA2
ObjectReference Property MS07NickOfficeMarker			Auto Const ; 0x00054344
ObjectReference Property MQ201BPiperTravelMarker02		Auto Const ; 0x001558A8
ObjectReference Property SanctuaryLocationCenterMarker	Auto Const ; 0x0004BE7A
ObjectReference Property MS10SafetyMarker				Auto Const ; 0x000F15CD
ObjectReference Property InstSceneAlaneJustin1JustinMarker Auto Const ; 0x000C9D59

ObjectReference[] InActiveSettlers

int NO_WORKSHOPID       = 9001 const
int NO_MULTIRESOURCEID  = 9003 const

import WorkshopDataScript

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakSettlersScript"
	debug.OpenUserLog(logName) 
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Event OnInit()
	InActiveSettlers = new ObjectReference[0]
	RegisterForCustomEvent(FollowersScript.GetScript(), "CompanionChange")
	RegisterForCustomEvent(WorkshopParent, "WorkshopEnterMenu")
EndEvent

Event OnQuestInit()
EndEvent

; Returns false if an anchor is needed because location is not Workshop or unowned
; I'm leaving out ownership checks for now. 
bool Function MakeSettler(Actor npc, Location settlement=None, bool PromptForHome=true, Location prevHome=None)

	Trace("MakeSettler npc [" + npc + "] settlement [" + settlement + "] PromptForHome [" + PromptForHome + "]")

	; if !WorkshopParent.PlayerOwnsAWorkshop
	;	return false
	; endif

	if settlement
		PromptForHome = false
	endif
	
	WorkshopNPCScript WNS  				 = npc as WorkshopNPCScript
	int workshopID         				 = LocationToWorkShopID(settlement)
	Location selection     				 = settlement
	int previousWorkshopID 				= -1
	
	; If already a WNS, not much to do....
	if (WNS && WNS.WorkshopParent)
		Trace("  WNS detected")
		
		if PromptForHome
			Trace("  PromptForHome detected")
			prevHome = None ; force compare to use Workshop IDs
			previousWorkshopID = WNS.GetWorkshopID()
			if (workshopID < 0)
				selection = SanctuaryHillsLocation
			endif
			if npc.GetActorBase().IsUnique()
				selection = WorkshopParent.AddActorToWorkshopPlayerChoice(npc) ; May return NONE if player hits cancel
			else
				selection = WorkshopParent.AddPermanentActorToWorkshopPlayerChoice(npc) ; May return NONE if player hits cancel
			endif
			if selection
				workshopID = LocationToWorkShopID(selection)
			else
				if (workshopID > -1)
					selection = settlement
				endIf
			endif
		endif
		
		if (workshopID < 0)
			Trace("Prompt is false and no valid Workshop location provided. Bailing.")
			return false		
		endif
		
		Trace("workshopID for Location [" + settlement + "] is [" + workshopID + "]")
		Trace("previousWorkshopID is [" + previousWorkshopID + "]")
		
		if (previousWorkshopID > -1)
			if (previousWorkshopID == workshopID)
				Trace("Prervious Worksop assignment [" + previousWorkshopID + "] is same as new workshop [" + workshopID + "]. Bailing")
				return true
			endif
		elseif prevHome && (prevHome == settlement)
			Trace("Prervious Home assignment [" + prevHome + "] is same as new Home [" + settlement + "]. Bailing")
			return true
		endif
		
		WorkshopScript workshopRef = WorkshopParent.GetWorkshop(workshopID)	
		if !workshopRef
			; One Last Sanity Check
			Trace("Prompt is false and no valid Workshop could be found. Using Sanctuary Hills")
			workshopRef = LocationToWorkShop(SanctuaryHillsLocation)
			workshopID  = WorkshopParent.GetWorkshopID(workshopRef)
		endIf 
		
		if !workshopRef
			Trace("Assertion Failure. Sanctuary Hills not found as workshop")
			return false
		endif

		; if !workshopRef.OwnedByPlayer
		;	Trace("Can not assign to this location as Settlement.")
		;	return false
		; endif
		
		if (previousWorkshopID > -1 || prevHome)
			WorkshopParent.RemoveActorFromWorkshopPUBLIC(WNS)
		endIf

		if npc.GetActorBase().IsUnique()
			WorkshopParent.AddPermanentActorToWorkshopPUBLIC(npc, workshopID)
		else
			WorkshopParent.AddActorToWorkshopPUBLIC(WNS, workshopRef)
		endIf
		return true
	endIf
	
		
	if PromptForHome
		previousWorkshopID = TweakGetWorkshopID(npc)
		prevHome = None ; force compare to use Workshop IDs
		CompanionActorScript CAS = npc as CompanionActorScript
		if (workshopID < 0)
			selection = SanctuaryHillsLocation
		endif
		if npc.GetActorBase().IsUnique()
			Trace("npc is Unique")
			if (CAS && CAS.AllowDismissToSettlements && (CAS.AllowDismissToSettlements.GetValue() > 0) && CAS.DismissCompanionSettlementKeywordList)
				selection = npc.OpenWorkshopSettlementMenuEx(akActionKW=WorkshopParent.WorkshopAssignHomePermanentActor, aLocToHighlight=selection, akIncludeKeywordList=CAS.DismissCompanionSettlementKeywordList)
			else
				selection = npc.OpenWorkshopSettlementMenuEx(akActionKW=WorkshopParent.WorkshopAssignHomePermanentActor, aLocToHighlight=selection, akExcludeKeywordList=WorkshopParent.WorkshopSettlementMenuExcludeList)
			endif
		else
			Trace("npc is not Unique")
			if (CAS && CAS.AllowDismissToSettlements && (CAS.AllowDismissToSettlements.GetValue() > 0) && CAS.DismissCompanionSettlementKeywordList)
				selection = npc.OpenWorkshopSettlementMenuEx(akActionKW=WorkshopParent.WorkshopAssignHome, aLocToHighlight=selection, akIncludeKeywordList=CAS.DismissCompanionSettlementKeywordList)
			else
				selection = npc.OpenWorkshopSettlementMenuEx(akActionKW=WorkshopParent.WorkshopAssignHome, aLocToHighlight=selection, akExcludeKeywordList=WorkshopParent.WorkshopSettlementMenuExcludeList)
			endif
		endif
		if selection
			workshopID = LocationToWorkShopID(selection)
			Trace("selection[" + selection + "] workshopID [" + workshopID + "]")
		else
			Trace("No selection. workshopID [" + workshopID + "]")
			if (workshopID > -1)
				Trace("Using original/default location [" + settlement + "] workshopID [" + workshopID + "]")
				selection = settlement
			endif
		endif
	endif
	
	if workshopID < 0
		Trace("No valid Workshop location provided. Bailing.")
		return false
	endif
	
	if npc.IsInFaction(TweakSettlerFaction)
		if (previousWorkshopID > -1)
			if (previousWorkshopID == workshopID)
				Trace("Worksop assignment is same as current workshop. Bailing")
				return false
			endif
		elseif prevHome && (prevHome == settlement)
			Trace("Prervious Home assignment [" + prevHome + "] is same as new Home [" + settlement + "]. Bailing")
			return true
		endif
	endIf
	
	WorkshopScript workshopRef = WorkshopParent.GetWorkshop(workshopID)	
	if !workshopRef
		; One Last Sanity Check
		Trace("Prompt is false and no valid Workshop could be found. Using Sanctuary Hills")
		workshopRef = LocationToWorkShop(SanctuaryHillsLocation)
	endIf
	
	if !workshopRef
		Trace("Assertion Failure. Sanctuary Hills not found as workshop")
		return false
	endif
	
	return MakeSettlerHelper(npc, workshopRef)
	
EndFunction

bool Function MakeSettlerHelper(Actor npc, WorkshopScript workshopRef)
	
	Trace("Adding [" + npc + "] to Settlers Collection")
	if npc.IsInFaction(TweakSettlerFaction)
		Trace("Assertion Failure. NPC is already a TweakSettler")	
		return false
	endif
	if !workshopRef
		Trace("Assertion Failure. workshopRef is NONE")	
		return false
	endif
		
	pSettlers.AddRef(npc)
	
	; Use 9000 as place holder value to indicate no settlement.
	npc.SetValue(WorkshopParent.workshopIDActorValue, NO_WORKSHOPID)
	npc.SetValue(TweakSettlerMultiResourceId,         NO_MULTIRESOURCEID)
	npc.SetValue(TweakSettlerWork24Hours,             0.0)
	
	Actor myBrahmin = NONE
	ObjectReference oBrahmin = npc.GetLinkedRef(TweakSettlerBrahmin)
	if oBrahmin
		myBrahmin = oBrahmin as Actor
	endif
	if myBrahmin
		WorkshopParent.CaravanBrahminAliases.RemoveRef(myBrahmin)
		myBrahmin.SetLinkedRef(NONE, WorkshopParent.WorkshopLinkFollow)
		myBrahmin.Delete()				
	endif
	npc.SetLinkedRef(NONE, TweakSettlerBrahmin)
	
	if npc.IsChild()
		Trace("npc is Child")
		npc.AddToFaction(FarmerGenericChild)
	else
		Trace("npc is not Child")
		npc.AddToFaction(FarmerGenericDialogue)
	endif
	
	; Handled by Factions Attached to ReferenceAlias
	
	; if !npc.IsInFaction(WorkshopNPCFaction)
	;	npc.AddToFaction(WorkshopNPCFaction)
	; endIf
	; if !npc.IsInFaction(WorkshopDialogueFaction)
	;	npc.AddToFaction(WorkshopDialogueFaction)
	; endIf
	; if !npc.IsInFaction(GenericNPCFaction)
	;	npc.AddToFaction(GenericNPCFaction)
	; endIf
	; if !npc.IsInFaction(REFarmerFaction)
	;	npc.AddToFaction(REFarmerFaction)
	; endIf
	if !npc.IsInFaction(TweakSettlerFaction)
		npc.AddToFaction(TweakSettlerFaction)
	endIf
	
	; if I have a linked work object, set my ownership to it
	if npc.GetLinkedRef(WorkshopParent.WorkshopLinkWork)
		WorkshopObjectScript workobject = ((npc.GetLinkedRef(WorkshopParent.WorkshopLinkWork)) as WorkshopObjectScript)
		TweakAssignActor(workobject, npc)
	endif
	
	TweakSetCommandable(npc,  true)
	TweakSetAllowCaravan(npc, true)
	TweakSetAllowMove(npc,    true)			
		
	npc.SetLinkedRef(workshopRef, WorkshopLinkHome)
	npc.AddToFaction(WorkshopParent.REIgnoreForCleanup)
	npc.RemoveFromFaction(WorkshopParent.REDialogueRescued)
	
	TweakAddActorToWorkshop(npc, workshopRef)
	
	; X IDEA 1 : Official Population may be fine, but can't increase because of player charisma limit. 
	; X IDEA 2 : May need to broadcaste the WorkshopAddActor event... 
	; X IDEA 3 : Adding WorkshopNPC may fix population
	; IDEA 4 : Adding npc tp PermantActorAliases may fix population
	
	; add to alias collection for existing actors - gives them packages to stay at new "home"
	; if actorToAssign.IsUnique()
	; WorkshopParent.PermanentActorAliases.AddRef(actorToAssign)
	; endif
	
	; send custom event for this actor
	Var[] kargs = new Var[2]
	kargs[0] = npc
	kargs[1] = TweakGetWorkshopID(npc)
	WorkshopParent.SendCustomEvent("WorkshopAddActor", kargs)		
	
	if npc.IsInFaction(CurrentCompanionFaction)
		DisableSettlerAI(npc)
	endif
	npc.EvaluatePackage()
	return true
	
EndFunction


Function UnMakeSettler(Actor npc, bool removeFromCollection=true)

	Trace("UnMakeSettler(" + npc + ")")

	WorkshopNPCScript    WNS     = npc as WorkshopNPCScript
	if (WNS)
		Trace("  WNS detected")
		WorkshopParent.RemoveActorFromWorkshopPUBLIC(WNS)
		return
	endIf
	
	if (pSettlers.Find(npc) < 0)
		if (InActiveSettlers.Find(npc) < 0)
			Trace("  npc not found. Aborting")
			return
		endif
	endif
	
	TweakUnassignActor(npc, true)

	TweakSetCommandable(npc,  false)
	TweakSetAllowCaravan(npc, false)
	TweakSetAllowMove(npc,    false)
	
	npc.SetValue(WorkshopParent.workshopIDActorValue, NO_WORKSHOPID)
	npc.SetValue(TweakSettlerMultiResourceId, NO_MULTIRESOURCEID)
	npc.SetValue(TweakSettlerWork24Hours,0)		
	
	Actor myBrahmin = NONE
	ObjectReference oBrahmin = npc.GetLinkedRef(TweakSettlerBrahmin)
	if oBrahmin
		myBrahmin = oBrahmin as Actor
	endif
	if myBrahmin
		WorkshopParent.CaravanBrahminAliases.RemoveRef(myBrahmin)
		myBrahmin.SetLinkedRef(NONE, WorkshopParent.WorkshopLinkFollow)
		myBrahmin.Delete()				
	endif
	npc.SetLinkedRef(NONE, TweakSettlerBrahmin)
	
	; Handled By Factions Attached to ReferenceAlias	
	; if npc.IsInFaction(WorkshopNPCFaction)
	;	npc.RemoveFromFaction(WorkshopNPCFaction)
	; endIf
	; if npc.IsInFaction(WorkshopDialogueFaction)
	;	npc.RemoveFromFaction(WorkshopDialogueFaction)
	; endIf
	; if npc.IsInFaction(GenericNPCFaction)
	;	npc.RemoveFromFaction(GenericNPCFaction)
	; endIf
	; if npc.IsInFaction(REFarmerFaction)
	;	npc.RemoveFromFaction(REFarmerFaction)
	; endIf
	
	
	if npc.IsChild()
		npc.RemoveFromFaction(FarmerGenericChild)
	else
		npc.RemoveFromFaction(FarmerGenericDialogue)
	endif
		
	
	npc.SetLinkedRef(NONE,WorkshopLinkHome)	
	
	if npc.IsInFaction(TweakSettlerFaction)
		npc.RemoveFromFaction(TweakSettlerFaction)
	endIf
	
	if removeFromCollection
		if (pSettlers.Find(npc) > -1)
			pSettlers.RemoveRef(npc)
		endIf
		int index = InActiveSettlers.find(npc)
		if (index > -1)
			InActiveSettlers.Remove(index)
		endif
		npc.EvaluatePackage()
	endif
	
EndFunction

Function DisableSettlerAI(Actor npc)
	Trace("DisableSettlerAI [" + npc + "]")
	if npc.IsInFaction(TweakSettlerFaction)
		if (InActiveSettlers.Find(npc) < 0)
			InActiveSettlers.Add(npc)
		endif
		pSettlers.RemoveRef(npc)
		TweakSetCommandable(npc,  false)
		TweakSetAllowCaravan(npc, false)
		TweakSetAllowMove(npc,    false)
		if npc.IsChild()
			npc.RemoveFromFaction(FarmerGenericChild)
		else
			npc.RemoveFromFaction(FarmerGenericDialogue)
		endif		
		npc.EvaluatePackage()
	endif
	
EndFunction

Function EnableSettlerAI(Actor npc)
	Trace("EnableSettlerAI [" + npc + "]")
	if npc.IsInFaction(TweakSettlerFaction)
		if (pSettlers.Find(npc) < 0)
			pSettlers.AddRef(npc)
		endif
		int index = InActiveSettlers.Find(npc)
		if (index > -1)
			InActiveSettlers.Remove(index)
		endif
		TweakSetCommandable(npc,  true)
		TweakSetAllowCaravan(npc, true)
		TweakSetAllowMove(npc,    true)
		if npc.IsChild()
			npc.AddToFaction(FarmerGenericChild)
		else
			npc.AddToFaction(FarmerGenericDialogue)
		endif				
		npc.EvaluatePackage()
	endif
EndFunction


; Relayed by Quest TweakMonitorPlayer
Function OnGameLoaded(bool firstTime=false)
	trace("OnGameLoaded() Called. FirstTime = [" + firstTime + "]")	
	UnRegisterForCustomEvent(FollowersScript.GetScript(), "CompanionChange")
	UnRegisterForCustomEvent(WorkshopParent, "WorkshopEnterMenu")
	
	
	RegisterForCustomEvent(FollowersScript.GetScript(), "CompanionChange")
	RegisterForCustomEvent(WorkshopParent, "WorkshopEnterMenu")
	
EndFunction

; Relayed by Quest TweakMonitorPlayer
Function AftReset()

	Trace("============= AftReset() ================")
	int numSettlers = pSettlers.GetCount()
	int numInActive = InActiveSettlers.Length
	if (0 == numSettlers)
		if (0 == numInActive)		
			return
		endif
	endIf
	int i = 0
	while (i < numSettlers)
		Actor settler = pSettlers.GetAt(i) as Actor
		if settler
			UnMakeSettler(settler, false)
		endif
		i += 1
	endWhile
	pSettlers.RemoveAll()
	i = 0
	while (i < numInActive)
		Actor settler = InActiveSettlers[i] as Actor
		if settler
			UnMakeSettler(settler, false)
		endif
		i += 1
	endWhile
	InActiveSettlers.Clear()
	
	UnRegisterForCustomEvent(FollowersScript.GetScript(), "CompanionChange")
	UnRegisterForCustomEvent(WorkshopParent, "WorkshopEnterMenu")
	
EndFunction

int Function GetInstKickOutCount(Faction exclude)
	int count = 0
	
	Faction InstituteFaction = Game.GetForm(0x0005E558) as Faction
	
	; Scan Managed Map and look for RailRoad Faction members.
	; When kicked out it is normally because you took the 
	; eliminate RR quest, which means we need everyone unmanaged
	; so you can kill them...
	
	int numSettlers = pSettlers.GetCount()
	int numInActive = InActiveSettlers.Length
	
	if (0 == numSettlers)
		if (0 == numInActive)
			return 0
		endif
	endIf

	int i = 0
	while (i < numSettlers)
		Actor settler = pSettlers.GetAt(i) as Actor
		if settler.IsInFaction(InstituteFaction) && !settler.IsInFaction(exclude)
			count += 1
		endif
		i += 1
	endWhile
	
	i = 0
	while (i < numInActive)
		Actor settler = InActiveSettlers[i]  as Actor
		if settler.IsInFaction(InstituteFaction) && !settler.IsInFaction(exclude)
			count += 1
		endif
		i += 1
	endWhile	
	return count
	
EndFunction

; Relayed From TweakFollower Quest (Script)
Function HandleInstKickOut()

	Faction InstituteFaction = Game.GetForm(0x0005E558) as Faction
	ActorBase CompanionX688 = Game.GetForm(0x000BBEE6) as ActorBase
	Actor X688 = CompanionX688.GetUniqueActor()
	if !X688.IsDead()
		if X688.IsInFaction(TweakSettlerFaction)
			; Prevent X6-88 from turning on Player/Programming
			Faction HasBeenCompanion = Game.GetForm(0x000A1B85) as Faction
			Faction SynthFaction     = Game.GetForm(0x00083B31) as Faction
		
			X688.RemoveFromFaction(InstituteFaction)
			X688.RemoveFromFaction(SynthFaction)
		
			; Need to put him in a faction that will protect the player
			X688.AddToFaction(HasBeenCompanion)
		endif
	endIf
	
	; Intentionally omit InActiveSettlers
	int numSettlers = pSettlers.GetCount()
	if (0 == numSettlers)
		return
	endIf
	int i = 0
	while (i < numSettlers)
		Actor settler = pSettlers.GetAt(i) as Actor
		if settler.IsInFaction(InstituteFaction)
			UnMakeSettler(settler)
		endif
		i += 1
	endWhile

		
EndFunction

int Function GetBosKickOutCount(Faction exclude)
	int count = 0
	
	Faction BrotherhoodofSteelFaction = Game.GetForm(0x0005DE41) as Faction
	Faction BoS100FightFaction = Game.GetForm(0x001B513D) as Faction
	
	int numSettlers = pSettlers.GetCount()
	int numInActive = InActiveSettlers.Length
	
	if (0 == numSettlers)
		if (0 == numInActive)
			return 0
		endif
	endIf

	int i = 0
	while (i < numSettlers)
		Actor settler = pSettlers.GetAt(i) as Actor
		if settler.IsInFaction(BrotherhoodofSteelFaction) || settler.IsInFaction(BoS100FightFaction)
			if !settler.IsInFaction(exclude)
				count += 1
			endif
		endif
		i += 1
	endWhile
	
	i = 0
	while (i < numInActive)
		Actor settler = InActiveSettlers[i]  as Actor
		if settler.IsInFaction(BrotherhoodofSteelFaction) || settler.IsInFaction(BoS100FightFaction)
			if !settler.IsInFaction(exclude)
				count += 1
			endif
		endif
		i += 1
	endWhile
	
	return count
	
EndFunction

; Relayed From TweakFollower Quest (Script)
Function HandleBoSKickOut()

	ActorBase BoSPaladinDanse = Game.GetForm(0x00027683) as ActorBase
	ActorBase BoSScribeHaylen = Game.GetForm(0x0005DE3F) as ActorBase

	Actor Danse = BoSPaladinDanse.GetUniqueActor()
	Actor Haylen = BoSScribeHaylen.GetUniqueActor()
	
	Faction BrotherhoodofSteelFaction = Game.GetForm(0x0005DE41) as Faction
	Faction BoS100FightFaction = Game.GetForm(0x001B513D) as Faction
	Faction HasBeenCompanion = Game.GetForm(0x000A1B85) as Faction
	
	ActorValue pAssistance = Game.GetForm(0x000002C1) as ActorValue 
		
	if !Danse.IsDead()
		if BoS302.GetStageDone(20) == 1
			if Danse.IsInFaction(TweakSettlerFaction)
				; 20 is where you are tasked with executing Danse. Thing is, many users
				; may decide to betray the BOS at that point. And since Danse has been
				; marked for execution, it doesn't make sense for him to side with the 
				; BOS if you get kicked out after this point. 
				; 
				; Important to note is the !ISDEAD pre-condition. Most outcomes involve
				; Danse getting killed. So if he is still alive, you can assume you either
				; haven't reached the decision point or things went well (stage 160). Point
				; here is stage doesn't matter. Danse is alive. That is all that matters.

				if Danse.IsInFaction(BrotherhoodofSteelFaction)
					Danse.RemoveFromFaction(BrotherhoodofSteelFaction)
				endif
				Faction BoS302DanseFaction = Game.GetForm(0x0003A5F3) as Faction 
				if !Danse.IsInFaction(BoS302DanseFaction)
					Danse.AddToFaction(BoS302DanseFaction)
				endif

				; Haylen would only side with you if Danse is alive...
				if Haylen && !Haylen.IsDead() && Haylen.IsInFaction(TweakSettlerFaction)
					Haylen.RemoveFromFaction(BrotherhoodofSteelFaction)
					Haylen.RemoveFromFaction(BoS100FightFaction)				
					; Need to put her in a faction that will protect the player
					Haylen.AddToFaction(HasBeenCompanion)
					Haylen.SetValue(pAssistance, 0)
					Haylen.SetEssential(False)
					Haylen.GetActorBase().SetEssential(false)
					Haylen.SetProtected(True)				
					Haylen.SetGhost(False)
				endif
			endif
		else
			if Danse.IsInFaction(TweakSettlerFaction)
				Danse.SetValue(pAssistance, 1)
				Danse.SetEssential(False)
				Danse.GetActorBase().SetEssential(false)
				Danse.SetProtected(False)				
				Danse.SetGhost(False)
				UnMakeSettler(Danse)
				WorkshopNPCScript wns = Danse as WorkshopNPCScript
				if wns
					WorkshopParent.UnAssignActor(Danse as WorkshopNPCScript, true)
				endif				
			endif
			
			if Haylen && !Haylen.IsDead() && Haylen.IsInFaction(TweakSettlerFaction)
				UnMakeSettler(Haylen)
				Haylen.SetEssential(false)
				Haylen.GetActorBase().SetEssential(false)
				Haylen.SetProtected(false)
				Haylen.SetGhost(false)
			endif
			
		endif		
	else
		if Haylen && !Haylen.IsDead() && Haylen.IsInFaction(TweakSettlerFaction)
			UnMakeSettler(Haylen)
			Haylen.SetEssential(false)
			Haylen.GetActorBase().SetEssential(false)
			Haylen.SetProtected(false)
			Haylen.SetGhost(false)
		endif
	endif
	
	; Intentionally Omit InActiveSettlers
	int numSettlers = pSettlers.GetCount()
	if (0 == numSettlers)
		return
	endIf
	int i = 0
	while (i < numSettlers)
		Actor settler = pSettlers.GetAt(i) as Actor
		if settler.IsInFaction(BrotherhoodofSteelFaction) || settler.IsInFaction(BoS100FightFaction)
			UnMakeSettler(settler)
		endif
		i += 1
	endWhile
	
	
EndFunction

int Function GetRRKickOutCount(Faction exclude)
	int count = 0
	
	Faction RailRoadFaction       = Game.GetForm(0x000994F6) as Faction
	
	; Scan Managed Map and look for RailRoad Faction members.
	; When kicked out it is normally because you took the 
	; eliminate RR quest, which means we need everyone unmanaged
	; so you can kill them...
	
	int numSettlers = pSettlers.GetCount()
	int numInActive = InActiveSettlers.Length
	
	if (0 == numSettlers)
		if (0 == numInActive)
			return 0
		endif
	endIf

	int i = 0
	while (i < numSettlers)
		Actor settler = pSettlers.GetAt(i) as Actor
		if settler.IsInFaction(RailRoadFaction) && !settler.IsInFaction(exclude)
			count += 1
		endif
		i += 1
	endWhile
	
	i = 0
	while (i < numInActive)
		Actor settler = InActiveSettlers[i]  as Actor
		if settler.IsInFaction(RailRoadFaction) && !settler.IsInFaction(exclude)
			count += 1
		endif
		i += 1
	endWhile
	
	return count
	
EndFunction


; Relayed From TweakFollower Quest (Script)
Function HandleRRKickOut()

	Faction RailRoadFaction = Game.GetForm(0x000994F6) as Faction
	ActorBase CompanionDeacon = Game.GetForm(0x00045AC9) as ActorBase
	Actor Deacon = CompanionDeacon.GetUniqueActor()
	
	if !Deacon.IsDead() && Deacon.IsInFaction(TweakSettlerFaction)
		UnMakeSettler(Deacon)
		; Unmanage will often restore their original values. So we need to make them mortal
		Deacon.SetEssential(false)
		Deacon.GetActorBase().SetEssential(false)
		Deacon.GetActorBase().SetProtected(false)
		Deacon.SetGhost(false)
	endIf
	
	; Scan Managed Map and look for RailRoad Faction members.
	; When kicked out it is normally because you took the 
	; eliminate RR quest, which means we need everyone unmanaged
	; so you can kill them...
	
	int numSettlers = pSettlers.GetCount()
	int numInActive = InActiveSettlers.Length
	
	if (0 == numSettlers)
		if (0 == numInActive)
			return
		endif
	endIf
	int i = 0
	while (i < numSettlers)
		Actor settler = pSettlers.GetAt(i) as Actor
		if settler.IsInFaction(RailRoadFaction)
			UnMakeSettler(settler)
			settler.SetEssential(false)
			settler.GetActorBase().SetEssential(false)
			settler.GetActorBase().SetProtected(false)
			settler.SetGhost(false)			
		endif
		i += 1
	endWhile
	i = 0
	while (i < numInActive)
		Actor settler = InActiveSettlers[i]  as Actor
		if settler.IsInFaction(RailRoadFaction)
			UnMakeSettler(settler)
			settler.SetEssential(false)
			settler.GetActorBase().SetEssential(false)
			settler.GetActorBase().SetProtected(false)
			settler.SetGhost(false)			
		endif
		i += 1
	endWhile	
endFunction

; =========================================================================
; Re-written Functions:
; =========================================================================
; 
;   The following methods were re-written to provide settler functionality
;   on or for NPCs that do not have the WorkshopNPCScript Attached. Not
;   sure why Bethesda didn't do something like this in the first place 
;   instead of extending ACTOR. Maybe the RefAliasCollection has 
;   an undocumented limit? This implementation should scale to as many
;   NPCs as a RefAliasCollection will handle. However, the events redirect
;   to this script, so there is an event bottleneck that may cause 
;   lag as the number of settlers simultaneious loaded in memory grows. 
;   Hopefull, settlement limits should prevent that from being an issue.
;
; =========================================================================

; ---------------------------------------------------------
; WorkshopNPC Functions
; ---------------------------------------------------------

int function TweakGetWorkshopID(Actor npc)
	int workshopId = npc.GetValue(WorkshopParent.workshopIDActorValue) as int
	if workshopId > 127
		return -1
	endif
	return workshopId
endFunction

function TweakSetWorkshopID(Actor npc, int newWorkshopID)
	Trace("TweakSetWorkshopID npc [" + npc + "] newWorkshopID [" + newWorkshopID + "]")
	if (-1 == newWorkshopID)
		npc.SetValue(WorkshopParent.workshopIDActorValue, NO_WORKSHOPID)
	else
		npc.SetValue(WorkshopParent.workshopIDActorValue, newWorkshopID)
	endif	
endFunction

function TweakUpdatePlayerOwnership(Actor npc, WorkshopScript workshopRef = NONE)
	Trace("TweakUpdatePlayerOwnership npc [" + npc + "] workshopRef [" + workshopRef + "]")
	if workshopRef == NONE
		workshopRef = WorkshopParent.GetWorkshop(TweakGetWorkshopID(npc))
	endif
	if workshopRef
		npc.SetValue(WorkshopParent.WorkshopPlayerOwnership, workshopRef.OwnedByPlayer as int)
	endif
endFunction

int function TweakGetCaravanDestinationID(Actor npc)
	return npc.GetValue(WorkshopParent.WorkshopCaravanDestination) as int   
endFunction

bool function TweakIsWounded(Actor npc)
	return npc.GetValue(WorkshopParent.WorkshopActorWounded) as bool
endFunction

function TweakSetWounded(Actor npc, bool bIsWounded)
	npc.SetValue(WorkshopParent.WorkshopActorWounded, bIsWounded as int)
	int foundIndex = WorkshopParent.CaravanActorAliases.Find(npc)
	if foundIndex > -1
		TweakTurnOnCaravanActor(npc, (bIsWounded == false))
	endif
endFunction

function TweakSetWorker(Actor npc, bool isWorker)
	Trace("TweakSetWorker npc [" + npc + "] isWorker [" + isWorker + "]")
	float fIsWorker = isWorker as float
	npc.SetValue(TweakSettlerIsWorker, fIsWorker)
	if (0.0 == fIsWorker)
		npc.SetValue(TweakSettlerIsGuard, 0.0)
		npc.SetValue(TweakSettlerIsScavenger, 0.0)
	endif
endFunction

function TweakSetScavenger(Actor npc, bool isScavenger)
	Trace("TweakSetScavenger npc [" + npc + "] isScavenger [" + isScavenger + "]")
	float fisScavenger = isScavenger as float
	npc.SetValue(TweakSettlerIsScavenger, fisScavenger)
endFunction

function TweakSetSynth(Actor npc, bool isSynth)
	Trace("TweakSetScavenger npc [" + npc + "] isSynth [" + isSynth + "]")
	float fIsSynth = isSynth as float
	npc.SetValue(WorkshopParent.WorkshopRatings[WorkshopParent.WorkshopRatingPopulationSynths].resourceValue, (isSynth == true) as float)
	if npc.IsCreated() && TweakGetWorkshopID(npc) > -1
		WorkshopScript workshopRef = WorkshopParent.GetWorkshop(TweakGetWorkshopID(npc))
		if workshopRef.myLocation
			if isSynth
				npc.SetLocRefType(workshopRef.myLocation, WorkshopParent.WorkshopSynthRefType)
			else
				npc.SetLocRefType(workshopRef.myLocation, WorkshopParent.Boss)
			endif
			npc.ClearFromOldLocations()
		endif
	endif
endFunction

function TweakSetMultiResource(Actor npc, ActorValue resourceValue)
	Trace("TweakSetMultiResource npc [" + npc + "] resourceValue [" + resourceValue + "]")
	if NONE == resourceValue
		npc.SetValue(TweakSettlerMultiResourceId, NO_MULTIRESOURCEID)
		return
	endif
	
	; Find index in WorkshopParent.WorkshopRatings (struct. ActorValue child = "resourceValue")
	; Defaults:
	;   0 = food - base production
	;   1 = happiness (town's happiness rating)
	;   2 = population
	;   3 = safety
	;   4 = water
	;   5 = power
	;   6 = beds
	;   7 = bonus happiness (output from town, used when calculating actual Happiness rating)
	;   8 = unassigned population (people not assigned to a specific job)
	;   9 = radio (for now just 1/0 - maybe later it will be "strength" of station or something)
	;   10 = current damage (current % damage from raider attacks)
	;   11 = max damage (max % damage from last attack)
	;   12 = days since last attack (it will be 0 if just attacked)
	;   13 = current damage to food - resource points that are damaged
	;   14 = current damage to water - resource points that are damaged
	;   15 = current damage to safety - resource points that are damaged
	;   16 = current damage to power - resource points that are damaged
	;   17 = extra damage to population - number of wounded people. NOTE: total damage = base population value - current population value + extra population damage
	;   18 = quest-related happiness modifier
	;   19 = food - actual production
	;   20 = happiness target - where is happiness headed
	;   21 = artillery
	;   22 = current damage to artillery - resource points that are damaged
	;   23 = last attacking faction ID (see Followers.GetEncDefinition() for list of factions)
	;   24 = robot population (so, number of humans = population - robot population)
	;   25 = base income from vendors
	;   26= brahmin population - used for food use plus increasing food production
	;   27 = MISSING food - amount needed for 0 unhappiness from food
	;   28 = MISSING water - amount needed for 0 unhappiness from water
	;   29 = MISSING beds - amount needed for 0 unhappiness from beds
	;   30 = scavenging - general
	;   31 = scavenging - building materials
	;   32 = scavenging - machine parts
	;   33 = scavenging - rare items
	;   34 = caravan - greater than 0 means on caravan route
	;   35 = food type - carrot - so that production can match crops
	;   36 = food type - corn - so that production can match crops
	;   37 = food type - gourd - so that production can match crops
	;   38 = food type - melon - so that production can match crops
	;   39 = food type - mutfruit - so that production can match crops
	;   40 = food type - razorgrain - so that production can match crops
	;   41 = food type - tarberry - so that production can match crops
	;   42 = food type - tato - so that production can match crops
	;   43 = synth population (meaning hostile Institute agents): > 0 means there's a hidden synth at the settlement
	;   44 = MISSING safety - amount needed for minimum risk of attack
	
	int index = WorkshopParent.WorkshopRatings.FindStruct("resourceValue", resourceValue)
	if index > -1
		trace("  lookup found at [" + index + "]")
		npc.SetValue(TweakSettlerMultiResourceId, index)		
		if resourceValue == WorkshopParent.WorkshopRatings[WorkshopParent.WorkshopRatingSafety].resourceValue
			Trace("  Resource Type : WorkshopRatingSafety. Setting npc as Guard")	
			TweakSetGuard(npc, true)
		else
			Trace("  Resource Type : Not WorkshopRatingSafety. Setting Guard to false")
			TweakSetGuard(npc, false)
		endif
	else
		Trace("  Resource [" + resourceValue + "] Not found in WorkshopParent.WorkshopRatings")
		npc.SetValue(TweakSettlerMultiResourceId, NO_MULTIRESOURCEID)
	endif
	
endFunction

function TweakAddMultiResourceProduction(Actor npc, float newProduction)
	float multiResourceProduction = npc.GetValue(TweakSettlerMultiResourceProduction)
	multiResourceProduction += newProduction
	npc.SetValue(TweakSettlerMultiResourceProduction, multiResourceProduction)
endFunction

function TweakSetAsBoss(Actor npc, Location newLocation)
	; TweakSettlers dont support CustomBossLocRefType
	npc.SetLocRefType(newLocation, WorkshopParent.Boss)
	npc.ClearFromOldLocations() ; 101931: make sure location data is correct
endFunction

; WorkshopNPC Event Handlers

; Relayed By TweakWorkshopNPCScript attached to Settlers RefCollectionAlias
Function TweakOnActivate(ObjectReference oNPC, ObjectReference akActionRef)

	; TODO: Could we not put them into an alias on activation and start a scene
	; allowing access to a custom dialogue?
	
	Trace("TweakOnActivate oNPC [" + oNPC + "] akActionRef [" + akActionRef + "]")
	Actor npc = oNPC as Actor
	if !npc
		return
	endif
	if WorkshopParent.GetWorkshop(TweakGetWorkshopID(npc)).OwnedByPlayer
		if npc.IsDoingFavor() && akActionRef == oNPC && npc.HasKeyword(WorkshopParent.WorkshopAllowCommand)
			int iSelfActivationCount = npc.GetValue(TweakSettlerActivationCount) as int
			iSelfActivationCount += 1
			npc.SetValue(TweakSettlerActivationCount, iSelfActivationCount)
			Trace("  iSelfActivationCount [" + iSelfActivationCount + "]")
			if iSelfActivationCount > 1
				; toggle favor state
				npc.setDoingFavor(false, true)
			endif
		endif
	endif
EndFunction

; Relayed By TweakWorkshopNPCScript attached to Settlers RefCollectionAlias
Function TweakOnCommandModeGiveCommand(ObjectReference oNPC, int aeCommandType, ObjectReference akTarget)
	Trace("TweakOnCommandModeGiveCommand oNPC [" + oNPC + "] aeCommandType [" + aeCommandType + "] akTarget [" + akTarget + "]")
	Actor npc = oNPC as Actor
	if !npc
		return
	endif
	WorkshopObjectScript workObject = akTarget as WorkshopObjectScript
	if workObject && aeCommandType == 10 ; workshop assign command
		TweakActivatedByWorkshopActor(npc, workObject)
	endif
endFunction

; Relayed By TweakWorkshopNPCScript attached to Settlers RefCollectionAlias
Function TweakOnEnterBleedout(ObjectReference oNPC)
	Actor npc = oNPC as Actor
	if !npc
		return
	endif
	if !TweakIsWounded(npc)
		TweakWoundActor(npc)
	endif
EndFunction

; Relayed By TweakWorkshopNPCScript attached to Settlers RefCollectionAlias
Function TweakOnCombatStateChanged(ObjectReference oNPC, Actor akTarget, int aeCombatState)
	Trace("TweakOnCombatStateChanged oNPC [" + oNPC + "] akTarget [" + akTarget + "] aeCombatState [" + aeCombatState + "]")
	Actor npc = oNPC as Actor
	if !npc
		return
	endif
	if aeCombatState == 0 && TweakIsWounded(npc)
		TweakWoundActor(npc, false)
	endif
EndFunction

; Relayed By TweakWorkshopNPCScript attached to Settlers RefCollectionAlias
Function TweakOnDeath(ObjectReference oNPC, Actor akKiller)
	Trace("TweakOnDeath oNPC [" + oNPC + "] akKiller [" + akKiller + "]")
	Actor npc = oNPC as Actor
	if !npc
		return
	endif
    
	; remove me from the workshop
	TweakHandleActorDeath(npc, akKiller)
EndFunction

; Relayed By TweakWorkshopNPCScript attached to Settlers RefCollectionAlias
Function TweakOnLoad(ObjectReference oNPC)
	Trace("TweakOnLoad oNPC [" + oNPC + "]")
	Actor npc = oNPC as Actor
	if !npc
		return
	endif
	
	TweakSetCommandable(npc, true)
	TweakSetAllowCaravan(npc, true)
	TweakSetAllowMove(npc, true)

	; TODO: Check if value is 1.0 and if so, randomly 
	; leave some assigned... 
	
	npc.SetValue(WorkshopParent.WorkshopActorAssigned, 0)
	npc.EvaluatePackage()
	
	; WOUNDED STATE: removing visible wounded state for now
	if npc.IsDead()
		Trace("  NPC is DEAD!")
	elseif TweakIsWounded(npc)
		TweakWoundActor(npc, false)
	endif

	; check if I should create caravan brahmin
	TweakCaravanActorBrahminCheck(npc)
EndFunction

Event WorkshopParentScript.WorkshopEnterMenu(WorkshopParentScript akSender, Var[] akArgs)
		WorkshopScript workshopRef = akArgs[1] as WorkshopScript
		Trace("WorkshopEnterMenu [" + workshopRef + "]")
		if workshopRef
			; Recalculate Resources "fixes" the population count (since WorkshopParent.GetWorkshopActors() ignores AFT Settlers). 
			; So we fix it here when they activate Workshop Mode
			int extra = TweakGetWorkshopActorCount(workshopRef)
			if (extra > 0)
				Trace("Adjusting actual population by [" + extra + "]")
				WorkshopParent.ModifyResourceData(WorkshopParent.WorkshopRatings[WorkshopParent.WorkshopRatingPopulation].resourceValue, workshopRef, extra)
			endIf
		endIf			
EndEvent	

ObjectReference[] Function TweakGetWorkshopActors(WorkshopScript workshopRef, ObjectReference[] startingList = None)
	if !startingList
		startingList = new ObjectReference[0]
	endIf
	int numSettlers = pSettlers.GetCount()
	int numInActive = InActiveSettlers.Length
	if (0 == numSettlers)
		if (0 == numInActive)
			return startingList
		endif
	endIf
	
	int workshopID = workshopRef.GetWorkshopID()
	int count = 0
	int i = 0
	
	while (i < numSettlers)
		Actor settler = pSettlers.GetAt(i) as Actor
		if TweakGetWorkshopID(settler) == workshopID
			startingList.Add(settler)
		endif
		i += 1
	endWhile
	i = 0
	while (i < numInActive)
		Actor settler = InActiveSettlers[i] as Actor
		if TweakGetWorkshopID(settler) == workshopID
			startingList.Add(settler)
		endif
		i += 1
	endWhile	
	return startingList
EndFunction

int Function TweakGetWorkshopActorCount(WorkshopScript workshopRef)
	int numSettlers = pSettlers.GetCount()
	int numInActive = InActiveSettlers.Length
	if (0 == numSettlers)
		if (0 == numInActive)
			return 0
		endif
	endIf
	
	int workshopID = workshopRef.GetWorkshopID()
	int count = 0
	int i = 0
	
	while (i < numSettlers)
		Actor settler = pSettlers.GetAt(i) as Actor
		if TweakGetWorkshopID(settler) == workshopID
			count += 1
		endif
		i += 1
	endWhile
	i = 0
	while (i < numInActive)
		Actor settler = InActiveSettlers[i] as Actor
		if TweakGetWorkshopID(settler) == workshopID
			count += 1
		endif
		i += 1
	endWhile	
	return count
endFunction

Event FollowersScript.CompanionChange(FollowersScript akSender, Var[] akArgs)

	Actor EventActor     = akArgs[0] as Actor
	Bool  IsNowCompanion = akArgs[1] as bool

	Trace("FollowersScript.CompanionChange EventActor [" + EventActor + "] IsNowCompanion [" + IsNowCompanion + "]")
	
	if EventActor.IsInFaction(TweakSettlerFaction)
		Trace("AFT Settler Detected")
		if (IsNowCompanion)
			DisableSettlerAI(EventActor)
		else
			EnableSettlerAI(EventActor)
		endIf
	else
		Trace("Not AFT Settler. Ignoring")
	endif
	
EndEvent

Function TweakOnWorkshopNPCTransfer(ObjectReference oNPC, Location akNewWorkshopLocation, Keyword akActionKW)
	Trace("TweakOnWorkshopNPCTransfer oNPC [" + oNPC + "] akNewWorkshopLocation [" + akNewWorkshopLocation + "] akActionKW [" + akActionKW + "]")

	Actor npc = oNPC as Actor
	if !npc
		return
	endif

	if akActionKW == WorkshopParent.WorkshopAssignCaravan
		TweakAssignCaravanActorPUBLIC(npc, akNewWorkshopLocation)
	else
		WorkshopScript newWorkshop = LocationToWorkShop(akNewWorkshopLocation)
		if newWorkshop
			if akActionKW == WorkshopParent.WorkshopAssignHome
				TweakAddActorToWorkshopPUBLIC(npc, newWorkshop)
			elseif akActionKW == WorkshopParent.WorkshopAssignHomePermanentActor
				TweakAddPermanentActorToWorkshopPUBLIC(npc, newWorkshop.GetWorkshopID())
			endif
		endif
	endif
EndFunction

function TweakSetCommandable(Actor npc, bool bFlag)
	Trace("TweakSetCommandable npc [" + npc + "] bFlag [" + bFlag + "]")
	if bFlag
		;;debug.trace(self + " adding keyword " + WorkshopParent.WorkshopAllowCommand)
		npc.AddKeyword(WorkshopParent.WorkshopAllowCommand)
	else
		npc.RemoveKeyword(WorkshopParent.WorkshopAllowCommand)
	endif
endFunction

function TweakSetAllowCaravan(Actor npc, bool bFlag)
	Trace("TweakSetAllowCaravan npc [" + npc + "] bFlag [" + bFlag + "]")
	if bFlag
		npc.AddKeyword(WorkshopParent.WorkshopAllowCaravan)
	else
		npc.RemoveKeyword(WorkshopParent.WorkshopAllowCaravan)
	endif
endFunction

function TweakSetAllowMove(Actor npc, bool bFlag)
	Trace("TweakSetAllowMove npc [" + npc + "] bFlag [" + bFlag + "]")
	; always save new state in "saved" variable
	if bFlag
		npc.AddKeyword(WorkshopParent.WorkshopAllowMove)
	else
		npc.RemoveKeyword(WorkshopParent.WorkshopAllowMove)
	endif
endFunction

; ---------------------------------------------------------
; WorkshopParent Utility
; ---------------------------------------------------------

function TweakHandleActorDeath(Actor deadActor, Actor akKiller)
	Trace("TweakHandleActorDeath deadActor [" + deadActor + "] akKiller [" + akKiller + "]")

	WorkshopScript workshopRef = WorkshopParent.GetWorkshop(TweakGetWorkshopID(deadActor))
	TweakUnassignActor(deadActor, true)
	
	; AFT Settlers do not affect settlement happiness
	; WorkshopParent.ModifyHappinessModifier(workshopRef, actorDeathHappinessModifier)
	
endFunction

function TweakTurnOnCaravanActor(Actor caravanActor, bool bTurnOn, bool bBrahminCheck = true)
	Trace("TweakTurnOnCaravanActor caravanActor [" + caravanActor + "] bTurnOn [" + bTurnOn + "] bBrahminCheck [" + bBrahminCheck + "]")
	; find linked locations
	WorkshopScript workshopStart = WorkshopParent.GetWorkshop(TweakGetWorkshopID(caravanActor))

	Location startLocation = workshopStart.myLocation
	Location endLocation = WorkshopParent.GetWorkshop(TweakGetCaravanDestinationID(caravanActor)).myLocation

	if bTurnOn
		startLocation.AddLinkedLocation(endLocation, WorkshopParent.WorkshopCaravanKeyword)
	else
		startLocation.RemoveLinkedLocation(endLocation, WorkshopParent.WorkshopCaravanKeyword)
	endif

	if bBrahminCheck
		TweakCaravanActorBrahminCheck(caravanActor, bTurnOn)
	endif
endFunction

function TweakWoundActor(Actor woundedActor, bool bWoundMe = true)
	Trace("TweakWoundActor woundedActor [" + woundedActor + "] bWoundMe [" + bWoundMe + "]")

	WorkshopScript workshopRef = WorkshopParent.GetWorkshop(TweakGetWorkshopID(woundedActor))
	TweakSetWounded(woundedActor, bWoundMe)

	int damageValue = 1
	if !bWoundMe
		damageValue = -1
	endif

	if bWoundMe == false && workshopRef.GetValue(WorkshopParent.WorkshopRatings[WorkshopParent.WorkshopRatingDamagePopulation].resourceValue) > 0
		WorkshopParent.ModifyResourceData(WorkshopParent.WorkshopRatings[WorkshopParent.WorkshopRatingDamagePopulation].resourceValue, workshopRef, damageValue)
	endif

	TweakUpdateActorsWorkObjects(woundedActor, workshopRef, true)

endFunction

function TweakUpdateActorsWorkObjects(Actor theActor, WorkshopScript workshopRef = NONE, bool bRecalculateResources = false)
	Trace("TweakUpdateActorsWorkObjects theActor [" + theActor + "] workshopRef [" + workshopRef + "] bRecalculateResources [" + bRecalculateResources + "]")
	
	if workshopRef == NONE
		workshopRef = WorkshopParent.GetWorkshop(TweakGetWorkshopID(theActor))
	endif

	int i = 0
	ObjectReference[] ResourceObjects = workshopRef.GetWorkshopOwnedObjects(theActor)
	while i < ResourceObjects.Length
		WorkshopObjectScript theObject = ResourceObjects[i] as WorkshopObjectScript
		if theObject
			WorkshopParent.UpdateWorkshopRatingsForResourceObject(theObject, workshopRef, bRecalculateResources = bRecalculateResources)
		endif
		i += 1
	endWhile
endFunction


function TweakAssignActorToObjectPublic(Actor assignedActor, WorkshopObjectScript assignedObject, bool bResetMode = false, bool bAddActorCheck = true)
	Trace("TweakAssignActorToObjectPublic assignedActor [" + assignedActor + "] assignedObject [" + assignedObject + "] bResetMode [" + bResetMode + "] bAddActorCheck [" + bAddActorCheck + "]")
	bool gotlock = GetSpinLock(pTweakMutexCompanions,30, "TweakAssignActorToObjectPublic") 
	TweakAssignActorToObject(assignedActor, assignedObject, bResetMode = bResetMode)
	ReleaseSpinLock(pTweakMutexCompanions, gotlock, "TweakAssignActorToObjectPublic")
endFunction

function TweakAddActorToWorkshopPUBLIC(Actor assignedActor, WorkshopScript workshopRef, bool bResetMode = false)
	Trace("TweakAddActorToWorkshopPUBLIC assignedActor [" + assignedActor + "] workshopRef [" + workshopRef + "] bResetMode [" + bResetMode + "]")
	bool gotlock = GetSpinLock(pTweakMutexCompanions,30, "TweakAddActorToWorkshopPUBLIC") 
	TweakAddActorToWorkshop(assignedActor, workshopRef, bResetMode)
	ReleaseSpinLock(pTweakMutexCompanions, gotlock, "TweakAddActorToWorkshopPUBLIC")
endFunction


function TweakAssignCaravanActorPUBLIC(Actor assignedActor, Location destinationLocation)
	Trace("TweakAssignCaravanActorPUBLIC assignedActor [" + assignedActor + "] destinationLocation [" + destinationLocation + "]")
	bool gotlock = GetSpinLock(pTweakMutexCompanions,30, "TweakAssignCaravanActorPUBLIC") 
	WorkshopScript workshopDestination = LocationToWorkShop(destinationLocation)

	WorkshopScript workshopStart = WorkshopParent.GetWorkshop(TweakGetWorkshopID(assignedActor))
	TweakUnassignActor(assignedActor)

	int caravanIndex = WorkshopParent.CaravanActorAliases.Find(assignedActor)
	if caravanIndex < 0
		WorkshopParent.CaravanActorAliases.AddRef(assignedActor)
		if assignedActor.GetActorBase().IsUnique() == false && assignedActor.GetValue(WorkshopParent.WorkshopProhibitRename) == 0
			WorkshopParent.CaravanActorRenameAliases.AddRef(assignedActor)
		endif
	else
		Location oldDestination = WorkshopParent.GetWorkshop(TweakGetCaravanDestinationID(assignedActor)).myLocation
		workshopStart.myLocation.RemoveLinkedLocation(oldDestination, WorkshopParent.WorkshopCaravanKeyword)
	endif
	
	int destinationID = workshopDestination.GetWorkshopID()

	assignedActor.SetValue(WorkshopParent.WorkshopCaravanDestination, destinationID)

	if assignedActor.IsCreated()
		assignedActor.SetLocRefType(workshopStart.myLocation, WorkshopParent.WorkshopCaravanRefType)
	endif

	assignedActor.SetLinkedRef(workshopStart.GetLinkedRef(WorkshopParent.WorkshopLinkCenter), WorkshopParent.WorkshopLinkCaravanStart)
	assignedActor.SetLinkedRef(workshopDestination.GetLinkedRef(WorkshopParent.WorkshopLinkCenter), WorkshopParent.WorkshopLinkCaravanEnd)

	workshopStart.myLocation.AddLinkedLocation(workshopDestination.myLocation, WorkshopParent.WorkshopCaravanKeyword)

	; 1.6: send custom event for this actor
	Var[] kargs = new Var[2]
	kargs[0] = assignedActor
	kargs[1] = workshopStart
	Trace("Sending WorkshopActorCaravanAssign event")
	WorkshopParent.SendCustomEvent("WorkshopActorCaravanAssign", kargs)

	Game.IncrementStat("Supply Lines Created")

	ReleaseSpinLock(pTweakMutexCompanions, gotlock, "TweakAssignCaravanActorPUBLIC")
endFunction

function TweakAddPermanentActorToWorkshopPUBLIC(Actor actorToAssign = NONE, int newWorkshopID = -1, bool bAutoAssign = true)
	Trace("TweakAddPermanentActorToWorkshopPUBLIC actorToAssign [" + actorToAssign + "] newWorkshopID [" + newWorkshopID + "] bAutoAssign [" + bAutoAssign + "]")
	if actorToAssign == NONE
		actorToAssign = WorkshopParent.WorkshopRecruit.GetActorRef()
	endif

	WorkshopScript newWorkshop = None
	
	if newWorkshopID < 0
		CompanionActorScript CAS = actorToAssign as CompanionActorScript
		Location selection = SanctuaryHillsLocation
		if actorToAssign.GetActorBase().IsUnique()
			Trace("npc is Unique")
			if (CAS && CAS.AllowDismissToSettlements && (CAS.AllowDismissToSettlements.GetValue() > 0) && CAS.DismissCompanionSettlementKeywordList)
				selection = actorToAssign.OpenWorkshopSettlementMenuEx(akActionKW=WorkshopParent.WorkshopAssignHomePermanentActor, aLocToHighlight=selection, akIncludeKeywordList=CAS.DismissCompanionSettlementKeywordList)
			else
				selection = actorToAssign.OpenWorkshopSettlementMenuEx(akActionKW=WorkshopParent.WorkshopAssignHomePermanentActor, aLocToHighlight=selection, akExcludeKeywordList=WorkshopParent.WorkshopSettlementMenuExcludeList)
			endif
		else
			Trace("npc is not Unique")
			if (CAS && CAS.AllowDismissToSettlements && (CAS.AllowDismissToSettlements.GetValue() > 0) && CAS.DismissCompanionSettlementKeywordList)
				selection = actorToAssign.OpenWorkshopSettlementMenuEx(akActionKW=WorkshopParent.WorkshopAssignHome, aLocToHighlight=selection, akIncludeKeywordList=CAS.DismissCompanionSettlementKeywordList)
			else
				selection = actorToAssign.OpenWorkshopSettlementMenuEx(akActionKW=WorkshopParent.WorkshopAssignHome, aLocToHighlight=selection, akExcludeKeywordList=WorkshopParent.WorkshopSettlementMenuExcludeList)
			endif
		endif
		if selection
			newWorkshopID = LocationToWorkShopID(selection)
			Trace("selection[" + selection + "] newWorkshopID [" + newWorkshopID + "]")
		else
			Trace("No selection. Using Default")
			newWorkshopID = LocationToWorkShopID(SanctuaryHillsLocation)
		endif	
	endif
	
	newWorkshop = WorkshopParent.GetWorkshop(newWorkshopID)
	bool gotlock = GetSpinLock(pTweakMutexCompanions,30, "TweakAddPermanentActorToWorkshopPUBLIC") 

	actorToAssign.AddToFaction(WorkshopParent.REIgnoreForCleanup)
	actorToAssign.RemoveFromFaction(WorkshopParent.REDialogueRescued)

	; make Boss loc ref type for this location
	if actorToAssign.IsCreated()
		; TweakSetAsBoss(actorToAssign, newWorkshop.myLocation)
		if newWorkshop
			actorToAssign.SetPersistLoc(newWorkshop.GetCurrentLocation())
		endif
		actorToAssign.ClearFromOldLocations()
	endif
	; add to alias collection for existing actors - gives them packages to stay at new "home"
	WorkshopParent.PermanentActorAliases.AddRef(actorToAssign)
	; add to the workshop
	TweakAddActorToWorkshop(actorToAssign, newWorkshop)

	if bAutoAssign
		; TODO
		Trace("  SKIPPED : TryToAutoAssignActor")		
		; 	TryToAutoAssignActor(newWorkshop, actorToAssign)
	endif

	; send custom event for this actor
	Var[] kargs = new Var[2]
	kargs[0] = actorToAssign
	kargs[1] = newWorkshopID
	WorkshopParent.SendCustomEvent("WorkshopAddActor", kargs)		

	; unlock editing
	ReleaseSpinLock(pTweakMutexCompanions, gotlock, "TweakAddPermanentActorToWorkshopPUBLIC")

endFunction

function TweakAssignActorToObject(Actor assignedActor, WorkshopObjectScript assignedObject, bool bResetMode = false, bool bAddActorCheck = true)
	Trace("TweakAssignActorToObject assignedActor [" + assignedActor + "] assignedObject [" + assignedObject + "] bResetMode [" + bResetMode + "] bAddActorCheck [" + bAddActorCheck + "]")
	
	WorkshopScript workshopRef = NONE
	if assignedObject.workshopID > -1
		workshopRef = WorkshopParent.GetWorkshop(assignedObject.workshopID)
	endif
	if workshopRef == NONE
		return
	endif

	; make sure I'm added to this workshop. In AFT, this also is used to indiecate secondary adds (multiresource) to avoid huge recursive loops.
	if bAddActorCheck
		TweakAddActorToWorkshop(assignedActor, workshopRef, bResetMode)
	endif

	; get object's current owner
	Actor previousOwner = TweakGetAssignedActor(assignedObject)

	; is this a bed or work object?
	if assignedObject.IsBed()
		Trace("  assignedObject.IsBed()")
		ObjectReference[] WorkshopBeds = WorkshopParent.GetBeds(workshopRef)
		int i = 0
		while i < WorkshopBeds.Length
			WorkshopObjectScript theBed = WorkshopBeds[i] as WorkshopObjectScript
			if theBed && theBed.GetActorRefOwner() == assignedActor
				Trace("  found owned bed. Unassigning")
				TweakAssignActor(theBed, None)
			endif
			i += 1
		endWhile

		; mark assigned object as assigned to this actor
		TweakAssignActor(assignedObject, assignedActor)
	elseif assignedObject.HasKeyword(WorkshopParent.WorkshopWorkObject)
		Trace("  assignedObject.HasKeyword(WorkshopWorkObject)")

		; TweakSettlers are never "new" settlers
		; assignedActor.bNewSettler = false

		; is object already assigned to this actor?
		bool bAlreadyAssigned = (previousOwner == assignedActor)
		; unassign actor from whatever he was doing
		actorValue multiResourceValue = TweakGetMultiResource(assignedActor)
		
		bool bShouldUnassign = true
		
		if (multiResourceValue && assignedObject.HasResourceValue(multiResourceValue))
			Trace("  same multi resource")
			int resourceIndex = WorkshopParent.GetResourceIndex(multiResourceValue)
			; same multi resource - may not need to unassign if actor has enough unused resource points left
			float totalProduction = assignedActor.GetValue(TweakSettlerMultiResourceProduction) + assignedObject.GetResourceRating(multiResourceValue)
			int maxProductionPerNPC = WorkshopParent.WorkshopRatings[resourceIndex].maxProductionPerNPC
			Trace("  totalProduction [" + totalProduction + "] maxProductionPerNPC [" + maxProductionPerNPC + "]")
			if totalProduction <= maxProductionPerNPC
				bShouldUnassign = false
			endif
		elseif bAlreadyAssigned
			bShouldUnassign = false
		endif

		if bShouldUnassign
			TweakUnassignActor(assignedActor, bSendUnassignEvent = !bAlreadyAssigned)
		endif

		; unassign current owner, if any (and different from new owner)
		if previousOwner && previousOwner != assignedActor
			TweakUnassignActorFromObject(previousOwner, assignedObject)
		endif

		; mark assigned object as assigned to this actor
		TweakAssignActor(assignedObject, assignedActor)

		; flag actor as a worker
		TweakSetWorker(assignedActor, true)

		; 1.5 - new 24-hour work flag
		if assignedObject.bWork24Hours
			Trace("  assignedObject.bWork24Hours")
			assignedActor.SetValue(TweakSettlerWork24Hours, 1.0) 
		endif

		; if assigned object has scavenge rating, flag worker as scavenger (for packages)
		if assignedObject.HasResourceValue(WorkshopParent.WorkshopRatings[WorkshopParent.WorkshopRatingScavengeGeneral].resourceValue)
			Trace("  assignedObject.HasResourceValue(WorkshopRatingScavengeGeneral)")
			TweakSetScavenger(assignedActor, true)
		endif

		; add vendor faction if any
		if assignedObject.VendorType > -1
			Trace("  assignedObject.VendorType > -1")
			TweakSetVendorData(workshopRef, assignedActor, assignedObject)
		endif

		; update workshop ratings for new assignment
		WorkshopParent.UpdateWorkshopRatingsForResourceObject(assignedObject, workshopRef)

		; remove "unassigned" resource value
		assignedActor.SetValue(WorkshopParent.WorkshopRatings[WorkshopParent.WorkshopRatingPopulationUnassigned].resourceValue, 0)

		; to save time, in reset mode we ignore this and do it at the end
		if !bResetMode
			; reset unassigned population count
			WorkshopParent.SetUnassignedPopulationRating(workshopRef)
		endif

		; special cases:
		; is this a multi-resource object?
		if assignedObject.HasMultiResource()
			Trace("  assignedObject.HasMultiResource()")
			multiResourceValue = assignedObject.GetMultiResourceValue()
			; flag actor with this keyword
			TweakSetMultiResource(assignedActor, multiResourceValue)
			TweakAddMultiResourceProduction(assignedActor, assignedObject.GetResourceRating(multiResourceValue))
			if !bResetMode
			
				; WorkshopParent.TryToAssignResourceType(workshopRef, multiResourceValue)				
				
				; AFT does this differently. First, the method above fails because it only considers
				; Actors that cast to WorkshopNPCScript. Second, it tries to assign everyone
				; with that resource (say food) to as many resources as the workshop allows. 
				;
				; We instead focus on the single actor and search for resources NEAR the original 
				; resource. It doesn't make sense for an actor to have food assignments all over
				; the settlement. 
\
				float npcProduction   = assignedActor.GetValue(TweakSettlerMultiResourceProduction)
				int maxProductionPerNPC = WorkshopParent.WorkshopRatings[WorkshopParent.GetResourceIndex(multiResourceValue)].maxProductionPerNPC
				
				if npcProduction < maxProductionPerNPC
					Trace("  Searching for nearby objects")
					ObjectReference[] nearbyObjects =  assignedObject.FindAllReferencesWithKeyword(AO_Type_WorkshopResourceObject, 350)
					int numObjects = nearbyObjects.Length
					Trace("  numObjects [" + numObjects + "] of type AO_Type_WorkshopResourceObject [" + AO_Type_WorkshopResourceObject + "]")
					int no_i = 0
					while (no_i < numObjects)
						trace(" Object[" + no_i + "] = [" + nearbyObjects[no_i] + "]")
						no_i += 1
					endwhile
					
					no_i = 0
					while (no_i < numObjects && npcProduction < maxProductionPerNPC)
						WorkshopObjectScript wos = (nearbyObjects[no_i] as WorkshopObjectScript)
						if wos && !wos.GetActorRefOwner()
							if wos.HasResourceValue(multiResourceValue)
								; make sure it wont push us over the limit:
								if ((npcProduction + wos.GetResourceRating(multiResourceValue)) <= maxProductionPerNPC)
									Trace("  Object [" + wos + "] available. Assigning")
									; Flags are important. It prevents things from going nuclear.
									TweakAssignActorToObject(assignedActor, wos, true, false)
									npcProduction = assignedActor.GetValue(TweakSettlerMultiResourceProduction)
								else
									Trace("  [" + multiResourceValue + "] object [" + wos + "] skipped (would push us over limit)")
								endif
							else
								trace("  Object [" + wos + "] does not have resource [" + multiResourceValue + "]")							
							endif
						else
							trace("  Object [" + wos + "] already has owner")
						endif
						no_i += 1
					endWhile
				endif
				
			endif
		endif

		; reset ai to get him to notice the new markers
		assignedActor.EvaluatePackage()
		
		; send custom event for this object
		; don't send event in reset mode, or if already assigned to this actor
		if bAlreadyAssigned == false && !bResetMode
			Var[] kargs = new Var[2]
			kargs[0] = assignedObject
			kargs[1] = workshopRef
			Trace(" 	sending WorkshopActorAssignedToWork event")
			WorkshopParent.SendCustomEvent("WorkshopActorAssignedToWork", kargs)		
		endif
	endif
endFunction

function TweakUnassignActor(Actor theActor, bool bRemoveFromWorkshop = false, bool bSendUnassignEvent = true)
	Trace("TweakUnassignActor theActor [" + theActor + "] bRemoveFromWorkshop [" + bRemoveFromWorkshop + "] bSendUnassignEvent [" + bSendUnassignEvent + "]")

	WorkshopScript workshopRef = WorkshopParent.GetWorkshop(TweakGetWorkshopID(theActor))

	; am I currently assigned to something?
	int foundIndex = -1

	; caravan?
	foundIndex = WorkshopParent.CaravanActorAliases.Find(theActor)
	if foundIndex > -1
		Trace("Member of CaravanActorAliases. Removing")
		; remove me from the caravan alias collection
		WorkshopParent.CaravanActorAliases.RemoveRef(theActor)
		WorkshopParent.CaravanActorRenameAliases.RemoveRef(theActor)

		Location startLocation = workshopRef.myLocation
		Location endLocation = WorkshopParent.GetWorkshop(TweakGetCaravanDestinationID(theActor)).myLocation
		; unlink locations
		startLocation.RemoveLinkedLocation(endLocation, WorkshopParent.WorkshopCaravanKeyword)

		; set back to Boss
		if theActor.IsCreated()
			; Patch 1.4: allow custom loc ref type on workshop NPC
			; TweakSetAsBoss(theActor, startLocation)
			theActor.ClearFromOldLocations()
		endif

		; update workshop rating - increment unassigned actors total
		theActor.SetValue(WorkshopParent.WorkshopRatings[WorkshopParent.WorkshopRatingPopulationUnassigned].resourceValue, 1)

		; clear caravan brahmin
		TweakCaravanActorBrahminCheck(theActor)

		; 1.6: send custom event for this actor
		Var[] kargs = new Var[2]
		kargs[0] = theActor
		kargs[1] = workshopRef
		WorkshopParent.SendCustomEvent("WorkshopActorCaravanUnassign", kargs)
	else
		Trace("Not Member of CaravanActorAliases.")		
	endif

	; work object?
	int workshopID = TweakGetWorkshopID(theActor)
	if workshopID == workshopRef.GetWorkshopID()
		; unassign ownership of all work objects
		Trace("Searching for OwnedObjects")
		ObjectReference[] ResourceObjects = workshopRef.GetWorkshopOwnedObjects(theActor)
		Trace("GetWorkshopOwnedObjects returned [" + ResourceObjects.Length + "] objects")
		int i = 0
		while i < ResourceObjects.Length
			WorkshopObjectScript theObject = ResourceObjects[i] as WorkshopObjectScript
			if theObject.RequiresActor()
				TweakUnassignObject(theObject)
				if bSendUnassignEvent
					; send custom event for this object
					Var[] kargs = new Var[2]
					kargs[0] = theObject
					kargs[1] = workshopRef
					Trace(" 	sending WorkshopActorUnassigned event")
					WorkshopParent.SendCustomEvent("WorkshopActorUnassigned", kargs)
				endif
			endif
			i += 1
		endWhile

		; clear actor work flags
		TweakSetMultiResource(theActor, NONE)
		TweakSetWorker(theActor, false)
	else
		Trace("theActor workshopID [" + workshopID + "] != workshopRef.GetWorkshopID() [" + workshopRef.GetWorkshopID() + "]")
	endif

	if bRemoveFromWorkshop
		Trace("bRemoveFromWorkshop [True]. Removing")		
	
		; clear workshop linked ref
		theActor.SetLinkedRef(NONE, WorkshopParent.WorkshopItemKeyword)

		; clear applied alias data
		WorkshopParent.WorkshopActorApply.RemoveFromRef(theActor)

		; remove from permanent actor collection alias
		WorkshopParent.PermanentActorAliases.RemoveRef(theActor)
		
		; remove ownership flag to prevent trading
		theActor.SetValue(WorkshopParent.WorkshopPlayerOwnership, 0)	

		; PATCH - remove workshop ID as well
		TweakSetWorkshopID(theActor, -1)

		; update population rating on workshop's location
		if workshopRef.RecalculateWorkshopResources() == false
			; decrement population manually if couldn't recalc
			WorkshopParent.ModifyResourceData(WorkshopParent.WorkshopRatings[WorkshopParent.WorkshopRatingPopulation].resourceValue, workshopRef, -1)
		endif
	endif

endFunction

function TweakUnassignObject(WorkshopObjectScript theObject, bool bRemoveObject = false)
	Trace("TweakUnassignObject theObject [" + theObject + "] bRemoveObject [" + bRemoveObject + "]")

	WorkshopScript workshopRef = WorkshopParent.GetWorkshop(theObject.workshopID)

	; get my owner (if any)
	Actor assignedActor = TweakGetAssignedActor(theObject)
	
	if assignedActor
		; clear my ownership
		theObject.AssignActor(none)

		; 1.5 - new 24-hour work flag
		if theObject.bWork24Hours
			Trace("  theObject.bWork24Hours")
			assignedActor.SetValue(TweakSettlerWork24Hours,0.0)
		endif

		; clear link if it exists
		if theObject.AssignedActorLinkKeyword
			Trace("  theObject.AssignedActorLinkKeyword [" + theObject.AssignedActorLinkKeyword + "]")		
			assignedActor.SetLinkedRef(NONE, theObject.AssignedActorLinkKeyword)
		endif

		;  clear vendor faction from actor
		if theObject.VendorType > -1
			Trace("  theObject.VendorType > -1")		
			TweakSetVendorData(workshopRef, assignedActor, theObject, false)
		endif

		; is does my owner own anything else?
		ObjectReference[] ResourceObjects = workshopRef.GetWorkshopOwnedObjects(assignedActor)
		int i = 0
		bool ownedObject = false
		while i < ResourceObjects.Length && ownedObject == false
			WorkshopObjectScript resourceObject = ResourceObjects[i] as WorkshopObjectScript
			if resourceObject && resourceObject.IsBed() == 0
				; exit loop
				ownedObject = true
			endif
			i += 1
		endWhile

		if ownedObject == false
			; this was the only thing I owned - add owner back to unassigned actor list
			assignedActor.SetValue(WorkshopParent.WorkshopRatings[WorkshopParent.WorkshopRatingPopulationUnassigned].resourceValue, 1)
			TweakSetMultiResource(assignedActor, NONE)
			TweakSetWorker(assignedActor, false)
		endif
	endif

	if assignedActor || bRemoveObject
		; update ratings
		Trace("  WorkshopParent.UpdateWorkshopRatingsForResourceObject()")
		WorkshopParent.UpdateWorkshopRatingsForResourceObject(theObject, workshopRef, bRemoveObject)
	endif

endFunction

function TweakUnassignActorFromObject(Actor theActor, WorkshopObjectScript theObject, bool bSendUnassignEvent = true)

	Trace("TweakUnassignActorFromObject theActor [" + theActor + "] theObject [" + theObject + "] bSendUnassignEvent [" + bSendUnassignEvent + "]")

	WorkshopScript workshopRef = WorkshopParent.GetWorkshop(TweakGetWorkshopID(theActor))

	if theObject.GetActorRefOwner() == theActor
		TweakUnassignObject(theObject)
		if bSendUnassignEvent
			; send custom event for this object
			Var[] kargs = new Var[2]
			kargs[0] = theObject
			kargs[1] = workshopRef
			Trace(" 	sending WorkshopActorUnassigned event")
			WorkshopParent.SendCustomEvent("WorkshopActorUnassigned", kargs)
		endif

		ObjectReference[] WorkshopActors = TweakGetWorkshopActors(workshopRef, WorkshopParent.GetWorkshopActors(workshopRef))
		int foundIndex = WorkshopActors.Find(theActor)
		if foundIndex > -1
			ObjectReference[] ResourceObjects = workshopRef.GetWorkshopOwnedObjects(theActor)
			if ResourceObjects.Length == 0
				TweakSetMultiResource(theActor, NONE)
				TweakSetWorker(theActor, false)
			endif
		endif
	endif
endFunction

function TweakSetVendorData(WorkshopScript workshopRef, Actor assignedActor, WorkshopObjectScript assignedObject, bool bSetData = true)
	Trace("TweakSetVendorData workshopRef [" + workshopRef + "] assignedActor [" + assignedActor + "] assignedObject [" + assignedObject + "] bSetData [" + bSetData + "]")

	if assignedObject.VendorType > -1
		WorkshopVendorType vendorData = WorkshopParent.WorkshopVendorTypes[assignedObject.VendorType]
		if vendorData
			if bSetData
				assignedActor.AddToFaction(vendorData.VendorFaction)
				if vendorData.keywordToAdd01
					assignedActor.AddKeyword(vendorData.keywordToAdd01)
				endif
			else
				assignedActor.RemoveFromFaction(vendorData.VendorFaction)
				if vendorData.keywordToAdd01
					assignedActor.RemoveKeyword(vendorData.keywordToAdd01)
				endif
			endif

			; -- assign vendor chests
			ObjectReference[] vendorContainers = workshopRef.GetVendorContainersByType(assignedObject.VendorType)
			int i = 0
			while i <= assignedObject.vendorLevel
				if bSetData
					assignedActor.SetLinkedRef(vendorContainers[i], WorkshopParent.VendorContainerKeywords.GetAt(i) as Keyword)
				else
					assignedActor.SetLinkedRef(NONE, WorkshopParent.VendorContainerKeywords.GetAt(i) as Keyword)
				endif
				i += 1
			endWhile

			; special vendor data
			if !bSetData
				; always clear for safety
				assignedActor.SetLinkedRef(NONE, WorkshopParent.VendorContainerKeywords.GetAt(WorkshopParent.VendorTopLevel+1) as Keyword)
				assignedActor.SetLinkedRef(NONE, WorkshopParent.VendorContainerKeywords.GetAt(WorkshopParent.VendorTopLevel+2) as Keyword)
			endif
		endif
	endif
endFunction

function TweakAddActorToWorkshop(Actor assignedActor, WorkshopScript workshopRef, bool bResetMode = false, ObjectReference[] WorkshopActors = NONE)

	Trace("TweakAddActorToWorkshop assignedActor [" + assignedActor + "] workshopRef [" + workshopRef + "] bResetMode [" + bResetMode + "] WorkshopActors [" + WorkshopActors + "]")
	bool bResetHappiness = false

	; if already in the list, do nothing
	if WorkshopActors == NONE
		WorkshopActors = TweakGetWorkshopActors(workshopRef, WorkshopParent.GetWorkshopActors(workshopRef))
	endif

	bool bAlreadyAssigned = false
	int oldWorkshopID = TweakGetWorkshopID(assignedActor)
	if WorkshopActors.Find(assignedActor) > -1
		if oldWorkshopID == workshopRef.GetWorkshopID()
			Trace("  Target already assigned to workshopRef");
			bAlreadyAssigned = true
		else
			Trace("  Target Workshop is different than NPC's current workshop");
		endif
	else
		Trace("  assignedActor [" + assignedActor + "] not found in WorkshopActors");
	endif

	if oldWorkshopID > -1 && oldWorkshopID != workshopRef.GetWorkshopID()
		Trace("  unassigning Actor");
		TweakUnassignActor(assignedActor, false)
	endif

	int totalPopulation = 0
	if !bAlreadyAssigned
		Trace("  Assigning Actor to new workshop");
		TweakSetWorkshopID(assignedActor, workshopRef.GetWorkshopID())
		if workshopRef.SettlementOwnershipFaction && workshopRef.UseOwnershipFaction ;  && !assignedActor.IsInFaction(WorkshopParent.Followers.CurrentCompanionFaction)
			assignedActor.SetCrimeFaction(workshopRef.SettlementOwnershipFaction)
		endif

		; add linked ref so workshop knows about me
		assignedActor.SetLinkedRef(workshopRef, WorkshopParent.WorkshopItemKeyword)

		WorkshopParent.AssignHomeMarkerToActor(assignedActor, workshopRef)
				
		ObjectReference linkHome = assignedActor.GetLinkedRef(WorkshopLinkHome)
		if linkHome
			Trace("  WorkshopLinkHome [" + linkHome + "]")
		elseif workshopRef
			Trace("  WorkshopLinkHome was None. Assigning [" + workshopRef + "]")
			assignedActor.SetLinkedRef(workshopRef,WorkshopLinkHome)
		else
			Trace("  WorkshopLinkHome was None and workshopRef was none. Using Fallback [" + CodsworthKitchenMarker + "]")
			assignedActor.SetLinkedRef(CodsworthKitchenMarker,WorkshopLinkHome)
		endif

		; "stamp" alias data so they keep it even after being in alias - allows them to initialize to correct package even if Reset hasn't finished running
		WorkshopParent.ApplyWorkshopAliasData(assignedActor)

		TweakUpdatePlayerOwnership(assignedActor, workshopRef)
		
		; 98730: Recalc workshop ratings on old workshop (if there is one) now that actor is linked to new workshop
		if oldWorkshopID > -1 && oldWorkshopID != workshopRef.GetWorkshopID()
			WorkshopScript oldWorkshopRef = WorkshopParent.GetWorkshop(oldWorkshopID)		
			if oldWorkshopRef
				oldWorkshopRef.RecalculateWorkshopResources()
			endif 
		endif

		totalPopulation = workshopRef.GetBaseValue(WorkshopParent.WorkshopRatings[WorkshopParent.WorkshopRatingPopulation].resourceValue) as int
		float currentHappiness = workshopRef.GetValue(WorkshopParent.WorkshopRatings[WorkshopParent.WorkshopRatingHappiness].resourceValue)
		Trace("Target Workshop currentHappiness [" + currentHappiness + "]")
		if 0 == totalPopulation
			WorkshopParent.SetResourceData(WorkshopParent.WorkshopRatings[WorkshopParent.WorkshopRatingHappinessModifier].resourceValue, workshopRef, 0)
			if bResetMode
				Trace("ResetMode is True. Setting Happiness to 50")
				WorkshopParent.SetResourceData(WorkshopParent.WorkshopRatings[WorkshopParent.WorkshopRatingHappiness].resourceValue, workshopRef, 50.0)
				WorkshopParent.SetResourceData(WorkshopParent.WorkshopRatings[WorkshopParent.WorkshopRatingHappinessTarget].resourceValue, workshopRef, 50.0)
			else
				bResetHappiness = true
				Trace("ResetMode is False. Setting Happiness to 50")
			endif
			
			; Dont start attacks because of AFT Settlers. If they never put up a beacon, there
			; should never be an attack. 
			
			; WorkshopParent.SetResourceData(WorkshopParent.WorkshopRatings[WorkshopParent.WorkshopRatingLastAttackDaysSince].resourceValue, workshopRef, 99)
			
		endif
		
		; Mark the Actor as Unassigned to anything....
		assignedActor.SetValue(WorkshopParent.WorkshopRatings[WorkshopParent.WorkshopRatingPopulationUnassigned].resourceValue, 1)

		WorkshopParent.UpdateVendorFlagsAll(workshopRef)

		if assignedActor.IsCreated()
			; TweakSetAsBoss(assignedActor, workshopRef.myLocation)
			assignedActor.SetPersistLoc(workshopRef.myLocation)
			assignedActor.ClearFromOldLocations()
		endif

		Trace("Target Workshop Population [" + totalPopulation + "]")
	endif

	
	if bResetMode
		assignedActor.SetValue(TweakSettlerMultiResourceProduction, 0.0)
	endif

	if workshopRef.PlayerHasVisited && !bAlreadyAssigned
		TweakSetWorker(assignedActor, false)
	endif

	if !bResetMode
		TweakTryToAssignBedToActor(workshopRef, assignedActor)
	endif

	; While we can temporarily increase the population of the workshop
	; by manually increasing WorkshopRatingPopulation, the issue is when the player
	; activates WorkShop Mode, it recalculates the population. AFT Settlers lack the
	; boolean flag bCountsForPopulation, which the built in workshop system seems
	; to confirm/check for. So we can assign NPCs to settlements, but they will never 
	; count towards the settlements population. 
	
	; workshopRef.RecalculateWorkshopResources()
	
	if !workshopRef.RecalculateWorkshopResources()
		Trace("RecalculateWorkshopResources Failed. Attempting Manual Update...")
		if !bAlreadyAssigned
			WorkshopParent.ModifyResourceData(WorkshopParent.WorkshopRatings[WorkshopParent.WorkshopRatingPopulation].resourceValue, workshopRef, 1)
		endif
	 else
		Trace("RecalculateWorkshopResources Called")
		if !bAlreadyAssigned
			int newPopulation = workshopRef.GetBaseValue(WorkshopParent.WorkshopRatings[WorkshopParent.WorkshopRatingPopulation].resourceValue) as int
			if (totalPopulation == newPopulation)
				Trace("RecalculateWorkshopResources Did not increase population. Attempting to increase Manually")
				WorkshopParent.ModifyResourceData(WorkshopParent.WorkshopRatings[WorkshopParent.WorkshopRatingPopulation].resourceValue, workshopRef, 1)
			endif
		endif
	endif

	if !bResetMode && bResetHappiness
		WorkshopParent.ResetHappiness(workshopRef)
	endif
	
	assignedActor.EvaluatePackage()
	Trace("  Package [" + assignedActor.GetCurrentPackage() + "]")
	
endFunction

function TweakTryToAssignBedToActor(WorkshopScript workshopRef, Actor theActor)
	Trace("TweakTryToAssignBedToActor workshopRef [" + workshopRef + "] theActor [" + theActor + "]")

	if theActor
		if TweakActorOwnsBed(workshopRef, theActor) == false
			Trace("  bed not found. Searching for bed to assign NPC.")
			ObjectReference[] beds = WorkshopParent.GetBeds(workshopRef)
			int i = 0
			while i < beds.Length
				WorkshopObjectScript bedToAssign = beds[i] as WorkshopObjectScript
				if bedToAssign && bedToAssign.IsActorAssigned() == false
					; assign actor to bed
					Trace("  available bed found. Assigning..")
					TweakAssignActor(bedToAssign, theActor)
					; break out of loop
					i = beds.Length
				endif
				i += 1
			endWhile
		endif
	endif
endFunction

bool Function TweakActorOwnsBed(WorkshopScript workshopRef, Actor actorRef)
	Trace("TweakActorOwnsBed workshopRef [" + workshopRef + "] actorRef [" + actorRef + "]")
	ObjectReference[] beds = WorkshopParent.GetBeds(workshopRef)
	int i = 0
	while i < beds.Length
		WorkshopObjectScript theBed = beds[i] as WorkshopObjectScript
		; if bed has faction owner, count that if I'm in that faction
		if TweakIsFactionOwner(theBed, actorRef) || (theBed.IsActorAssigned() && TweakGetAssignedActor(theBed) == actorRef)
			return true
		endif
		i += 1
	endWhile
	return false
endFunction

; ---------------------------------------------------------
; WorkshopObject Utility
; ---------------------------------------------------------

Actor function TweakGetAssignedActor(WorkshopObjectScript workObject)
	Trace("TweakGetAssignedActor workObject [" + workObject + "]")
	Actor assignedActor = workObject.GetActorRefOwner()
	if !assignedActor
		; check for base actor ownership
		ActorBase baseActor = workObject.GetActorOwner()
;		;WorkshopParent.wsTrace(" baseActor=" + baseActor)
		if baseActor && baseActor.IsUnique()
			; if this has Actor ownership, use GetUniqueActor when available to get the actor ref
			assignedActor = baseActor.GetUniqueActor()
		endif
	endif
;	;WorkshopParent.wsTrace(" GetAssignedActor: " + assignedActor)
	return assignedActor
endFunction

function TweakActivatedByWorkshopActor(Actor npc, WorkshopObjectScript workObject)
	Trace("TweakActivatedByWorkshopActor npc [" + npc + "] workObject [" + workObject + "]")
	if npc && npc.IsDoingFavor() && npc.IsInFaction(WorkshopParent.Followers.CurrentCompanionFaction) == false
		if workObject.bAllowPlayerAssignment
			; turn off favor state
			npc.setDoingFavor(false, false) ; going back to using normal command mode for now
			; unregister for distance event
			npc.UnregisterForDistanceEvents(npc, WorkshopParent.GetWorkshop(TweakGetWorkshopID(npc)))
			; assign this NPC to me if this is a work object
			if workObject.RequiresActor() || workObject.IsBed()
				npc.SayCustom(WorkshopParent.WorkshopParentAssignConfirmTopicType)
				TweakAssignActorToObjectPUBLIC(npc, workObject)
				WorkshopParent.WorkshopResourceAssignedMessage.Show()
				
				; This will cause them to use the assigned object (Food). 
				; Unlike the original which used a timer to stop after 2 min, 
				; we just let it go until the next OnLoad event. 
				
				npc.SetValue(WorkshopParent.WorkshopActorAssigned, 1)
								
				; if food/water/safety are missing, run check if this is that kind of object
				if workObject.IsBed() == false
					WorkshopScript workshopRef = WorkshopParent.GetWorkshop(TweakGetWorkshopID(npc))
					workshopRef.RecalculateResources()
				endif

			endif
			npc.EvaluatePackage()
			Trace("  package [" + npc.GetCurrentPackage() + "]")
		else
			WorkshopParent.WorkshopResourceNoAssignmentMessage.Show()
		endif
	endif

endFunction

bool function TweakIsFactionOwner(WorkshopObjectScript workObject, Actor theActor)
	Faction theFaction = workObject.GetFactionOwner()
	return ( theFaction && theActor.IsInFaction(theFaction) )
endFunction


; ---------------------------------------------------------
; Workshop Utility
; ---------------------------------------------------------

function TweakAssignActor(WorkshopObjectScript workobject, Actor newActor)
	Trace("TweakAssignActor workobject [" + workobject + "] newActor [" + newActor + "]")
	if newActor

		; The WorkshopObject script has an ObjectReference[] array that maintains
		; the MARKERs for the animations associated with the various work objects. 
		; But it is private and we can't access it. 
	
		; Kludge : AssignActorOwnership is almost identical to AssignActor and even 
		; updates the ObjectReference[] array. However, it bails if the object is already 
		; owned. (And technically it is meant for a different context). We simply reset 
		; owenership of the object and call AssignActorOwnership instead. This allows
		; us to work around the Marker access issue (So NPCs will animate on their
		; assigned work objects). 
		
		workobject.SetActorRefOwner(none)
		workobject.AssignActorOwnership(newActor)
		
	else
		workobject.AssignActorOwnership(None)
	
	endif
endFunction

function TweakCaravanActorBrahminCheck(Actor actorToCheck, bool bShouldHaveBrahmin = true)
	Trace("TweakCaravanActorBrahminCheck actorToCheck [" + actorToCheck + "] bShouldHaveBrahmin [" + bShouldHaveBrahmin + "]")

	Actor myBrahmin = NONE
	ObjectReference oBrahmin = actorToCheck.GetLinkedRef(TweakSettlerBrahmin) as Actor
	if oBrahmin
		myBrahmin = oBrahmin as Actor
	endif
	
	; is my brahmin dead?
	if myBrahmin && myBrahmin.IsDead()
		; clear
		WorkshopParent.CaravanBrahminAliases.RemoveRef(myBrahmin)
		myBrahmin.SetLinkedRef(NONE, WorkshopParent.WorkshopLinkFollow)
		actorToCheck.SetLinkedRef(NONE, TweakSettlerBrahmin)
	endif

	; should I have a brahmin?
	if WorkshopParent.CaravanActorAliases.Find(actorToCheck) > -1 && bShouldHaveBrahmin && TweakIsWounded(actorToCheck) == false
		; if I don't have a brahmin, make me a new one
		if myBrahmin == NONE && TweakIsWounded(actorToCheck) == false
			myBrahmin = actorToCheck.placeAtMe(WorkshopParent.CaravanBrahmin) as Actor
			myBrahmin.SetActorRefOwner(actorToCheck)
			WorkshopParent.CaravanBrahminAliases.AddRef(myBrahmin)
			actorToCheck.SetLinkedRef(myBrahmin, TweakSettlerBrahmin)
			myBrahmin.SetLinkedRef(actorToCheck, WorkshopParent.WorkshopLinkFollow)
		endif
	else
		; clear and delete brahmin
		if myBrahmin
			; clear this and mark brahmin for deletion
			WorkshopParent.CaravanBrahminAliases.RemoveRef(myBrahmin)
			myBrahmin.SetLinkedRef(NONE, WorkshopParent.WorkshopLinkFollow)
			actorToCheck.SetLinkedRef(NONE, TweakSettlerBrahmin)
			myBrahmin.Delete()
		endif
	endif
endFunction

; =================================================================================
; General (Local) Utility
; =================================================================================

function TweakSetGuard(Actor npc, bool bIsGuard)
	float fisGuard = bIsGuard as float
	npc.SetValue(TweakSettlerIsGuard, fisGuard)
endFunction

ActorValue function TweakGetMultiResource(Actor npc)
	int MyMultiResourceID = npc.GetValue(TweakSettlerMultiResourceId) as int
	if (NO_MULTIRESOURCEID == MyMultiResourceID)
		trace("  returning [NONE] (id = NO_MULTIRESOURCEID)")
		return NONE
	endif
	ActorValue result = WorkshopParent.WorkshopRatings[MyMultiResourceID].resourceValue
	trace("  returning [" + result + "]")
	return result
endFunction

; Similar to GetWorkshop but returns Location instead of Workshop
Location Function WorkShopIDToLocation(int id)
	WorkshopParentScript pWorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
	if (id > -1 && id < pWorkshopParent.Workshops.Length)
		WorkshopScript workshopRef = pWorkshopParent.GetWorkshop(id)
		if workshopRef
			return workshopRef.GetCurrentLocation()
		endIf
	endif
	return None
endFunction

; Similar to GetWorkshopID, but takes location instead of Workshop
int Function LocationToWorkShopID(Location loc)
	Trace("LocationToWorkShopID [" + loc + "]")
	if loc
		WorkshopScript workshopRef = LocationToWorkShop(loc)
		if workshopRef
			Trace("Workshop [" + workshopRef + "] returned for Location [" + loc + "]")
			Trace("Workshop.myLocation [" + workshopRef.myLocation + "]")
			WorkshopParentScript pWorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
			int workshopId = pWorkshopParent.GetWorkshopID(workshopRef)	
			Trace("WorkshopParent.GetWorkshopID() returned [" + workshopId + "]")
			Trace("WorkShopIDToLocation(" + workshopId + ") == [" + WorkShopIDToLocation(workshopId) + "]")
			return 	workshopId
		else
			Trace("LocationToWorkShop returned None!")
		endIf
	else
		Trace("Location is None!")
	endif
	return -1	
EndFunction

; Replacement for GetWorkshopFromLocation (with checks)
WorkshopScript Function LocationToWorkShop(Location loc)

	if loc	
		WorkshopParentScript pWorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
		if pWorkshopParent
			; They have a fast WorkshopLocation lookup on the parent, but I don't trust it. 
			Location ws                          = None
			RefCollectionAlias   wscollection    = pWorkshopParent.WorkshopsCollection
	
			int index = 0
			int wslen = wscollection.GetCount()
			while (index < wslen && loc != ws)
				WorkshopScript workshopRef = wscollection.GetAt(index) as WorkshopScript
				if workshopRef
					ws = workshopRef.GetCurrentLocation()
					if loc == ws
						return workshopRef
					endif
				endif
				index += 1
			endwhile
		endif
	endif
	
	return None
EndFunction

Location Function WorkShopToLocation(WorkshopScript workshopRef)
	if workshopRef
		return workshopRef.GetCurrentLocation()
	endif
	return NONE
EndFunction

; searchOnFailure is normally true when using "Current" location as home.
ObjectReference Function LocationToWorkShopMarker(Location loc, bool searchOnFailure = false)
	ObjectReference marker = None
		
	Location ws                          = None
	WorkshopParentScript pWorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
	RefCollectionAlias   wscollection     = pWorkshopParent.WorkshopsCollection
	
	int index = 0
	int wslen = wscollection.GetCount()
	while (index < wslen && loc != ws)
		WorkshopScript workshopRef = wscollection.GetAt(index) as WorkshopScript
		if workshopRef
			ws = workshopRef.GetCurrentLocation()
			if loc == ws
				marker = workshopRef.GetLinkedRef(WorkshopLinkSandbox)			
				if marker == NONE
					marker = workshopRef.GetLinkedRef(WorkshopLinkCenter)
				endif
				if marker == NONE
					marker = workshopRef as ObjectReference
				endIf
				return marker
			endif
		endif
		index += 1
	endwhile
	
	if searchOnFailure
	
		; This allows us to "See" nearby workbenches installed by mods that may not have been 
		; registered with the Settlement System using WorkshopParent.ReinitializeLocationsPUBLIC()
		; It still has to caste to workshopscript to count.
		
		ObjectReference[] candidates =  Game.GetPlayer().FindAllReferencesWithKeyword(WorkshopKeyword, 4000)
		int cilen = candidates.Length
		if (cilen > 0)
			int ci = 0
			WorkshopScript workshopRef = None
			while (ci < cilen)
				workshopRef = candidates[ci] as WorkshopScript
				if workshopRef
					marker = workshopRef.GetLinkedRef(WorkshopLinkSandbox)			
					if marker == NONE
						marker = workshopRef.GetLinkedRef(WorkshopLinkCenter)
					endif
					if marker == NONE
						marker = workshopRef as ObjectReference
					endIf
					return marker
				endif
				ci += 1
			endwhile
		endif		
	endif
	
	return marker
EndFunction

; For when you dont care
ObjectReference Function LocationToMarker(Location loc)
	ObjectReference marker = LocationToWorkShopMarker(loc)
	if marker
		return marker
	endIf
	return LocationToCachedMarker(loc)
EndFunction

ObjectReference Function LocationToCachedMarker(Location loc)
	ObjectReference marker = None
	int locid  = (loc.GetFormID() as int)
	if (0x0001905B == locid)     ; CombatZoneLocation
		marker = CaitPostCombatMarker01
	elseif (0x0001F229 == locid) ; SanctuaryHillsPlayerHouseLocation
		marker = CodsworthKitchenMarker
	elseif (0x0002BE8D == locid) ; Vault81Location
		marker = COMCurieIntroMarker
	elseif (0x0001FA4A == locid) ; CambridgePDLocation
		marker = BoS101PlayerStartMarker
	elseif (0x000482C2 == locid) ; RailroadHQLocation
		marker = DeaconHomeMarker
	elseif (0x00024FAB == locid) ; RedRocketTruckStopLocation
		marker = RedRocketCenterMarker
	elseif (0x0002260F == locid) ; GoodneighborOldStateHouseLocation
		marker = MS04HancockEndMarker
	elseif (0x0002267F == locid) ; GoodneighborTheThirdRailLocation
		marker = COMMacCreadyStartMarker
	elseif (0x00003979 == locid) ; DiamondCityValentinesLocation
		marker = MS07NickOfficeMarker
	elseif (0x00003962 == locid) ; DiamondCityPublickOccurrencesLocation
		marker = MQ201BPiperTravelMarker02
	elseif (0x0001F228 == locid) ; SanctuaryHillsLocation
		marker = SanctuaryLocationCenterMarker
	elseif (0x0001DAF7 == locid) ; TrinityTowerLocation
		marker = MS10SafetyMarker
	elseif (0x001BBC22 == locid) ; InstituteSRBLocation
		marker = InstSceneAlaneJustin1JustinMarker
	endif
	return marker
EndFunction

; See AFT:TweakDFScript for docs...
bool Function GetSpinLock(GlobalVariable mutex, int attempts = 0, string sourcehint = "")
	if (1.0 == mutex.mod(1))
		trace("Giving SpinLock to [" + sourcehint + "]")
		return true
	endif
	while (attempts != 0)
		Utility.wait(0.1)
		if (0.0 == mutex.GetValue() && 1.0 == mutex.mod(1))
			trace("Giving SpinLock to [" + sourcehint + "] (" + attempts + " attempts left)")
			return true
		endif
		attempts -= 1
	endwhile
	trace("[" + sourcehint + "] Failed to get SpinLock")
	return false
endFunction

Function ReleaseSpinLock(GlobalVariable mutex, bool gotLock = true, string sourcehint = "")
	if gotLock
		trace("[" + sourcehint + "] Releasing SpinLock")
		mutex.SetValue(0.0)
	else
		trace("Ignoring Spinlock Release Request from [" + sourcehint + "]")		
	endif
endFunction
