ScriptName AFT:TweakGatherLooseScript extends Quest

FormList Property lootItemsUnique Auto Const
FormList Property CA_JunkItems Auto Const
FormList Property TweakConstructed_Cont Auto Const
FormList Property TweakNonConstructed_Cont Auto Const
FormList Property TweakGatherLooseContainers Auto Const
FormList Property TweakDedupe1Items Auto Const
FormList Property TweakDedupe2Items Auto Const
FormList Property TweakDedupe3Items Auto Const
FormList Property TweakDedupe4Items Auto Const
FormList Property TweakGatherLoose Auto Const
FormList Property TweakDedupeStackable Auto Const
Container Property Arena_Wager_Container Auto Const
Keyword Property ActorTypeTurret Auto Const
Quest Property pFollowers Auto Const
ActorBase Property Player Auto Const
Message Property TweakGatherFeedback Auto Const

ObjectReference[] ownedContainers
int[] ownedCounts
float nextSearchingMsg
ObjectReference[] ownedResults
int lockedCount
int ownedCount
int gatheredCount

; TODO: Need to add some more containers:
; - CashRegister
; - AmmoBox
bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakGatherLooseScript"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Function GatherLooseItems(ObjectReference targetContainer)
	Trace("GatherLooseItems()")
		
	if (!targetContainer)
		AFT:TweakDFScript pTweakDFScript = pFollowers as AFT:TweakDFScript
		if (pTweakDFScript)
			targetContainer = pTweakDFScript.pDogmeatCompanion.GetActorReference() as ObjectReference
			if (!targetContainer)
				targetContainer = pTweakDFScript.pCompanion.GetActorReference() as ObjectReference
			endIf
		endIf
		if (!targetContainer)
			targetContainer = Game.GetPlayer() as ObjectReference
		endIf
	endIf
	
	ownedContainers.clear()
	ownedResults.clear()
	ownedCounts.clear()
	
	gatheredCount = 0
	ownedCount = 0
	lockedCount = 0
	
	ObjectReference theContainer = targetContainer.placeAtMe(Arena_Wager_Container, 1, False, False, True)
	If (!theContainer)
		Trace("Unable to Spawn Container")
		return 
	EndIf
	theContainer.SetPosition(targetContainer.GetPositionX(), targetContainer.GetPositionY(), targetContainer.GetPositionZ() - 200)

	AFT:TweakGatherShowSearch searchMsgHandler = (self as Quest) as  AFT:TweakGatherShowSearch
	searchMsgHandler.ShowSearching()

	AddInventoryEventFilter(None)
	RegisterForRemoteEvent(theContainer, "OnItemAdded")
	
	ScanContainersForItems(TweakConstructed_Cont, "TweakConstructed_Cont", theContainer)
	ScanContainersForItems(TweakNonConstructed_Cont, "TweakNonConstructed_Cont", theContainer)
	ScanContainersForItems(TweakGatherLooseContainers, "TweakGatherLooseContainers", theContainer)
	
	ScanDeadActorsForItems(theContainer)
	
	ScanForLooseItems(TweakDedupe1Items,    "TweakDedupe1Items",       targetContainer)
	ScanForLooseItems(TweakDedupe2Items,    "TweakDedupe2Items",       targetContainer)
	ScanForLooseItems(TweakDedupe3Items,    "TweakDedupe3Items",       targetContainer)
	ScanForLooseItems(TweakDedupe4Items,    "TweakDedupe4Items",       targetContainer)
	ScanForLooseItems(TweakDedupeStackable, "TweakDedupeStackable",    targetContainer)
	ScanForLooseItems(TweakGatherLoose,     "TweakGatherLoose",        targetContainer)
	ScanForLooseItems(CA_JunkItems,         "CA_JunkItems",            targetContainer)
	ScanForLooseItems(lootItemsUnique,      "lootItemsUnique",         targetContainer)
	
	Trace("Waiting for events to process...")
	
	; Wait up to 6 seconds for AddItem Queues to finish procesing. 	
	int waitforevents = gatheredCount - 1
	int maxwait = 30
	while (maxwait > 0 && waitforevents < gatheredCount)
		waitforevents = gatheredCount
		Utility.WaitMenuMode(0.2)
		maxwait -= 1
	endWhile
	
	if (0 == maxwait)
		Trace("Warning : Event Processing Timed Out. Proceeding anyway...")
	else
		Trace("Event Processing Complete")
	endIf
	
	int ownedContainerLen = ownedContainers.length
	If (ownedContainerLen > 0)
		Trace("Owned Items Detected [" + ownedContainerLen as string + "]. Restoring")
		int i = 0
		while (i < ownedContainerLen)
			if (ownedContainers[i])
				theContainer.RemoveItem(ownedResults[i], ownedCounts[i], True, ownedContainers[i])
			endIf
			i += 1
		endWhile
	endIf
	
	theContainer.RemoveAllItems(targetContainer, False)
	Utility.WaitMenuMode(0.1)
	
	; Wait up to 6 seconds for intermediate container to transfer items to target Container
	maxwait = 30
	while (maxwait > 0 && theContainer.GetItemCount(None) > 0)
		Utility.WaitMenuMode(0.2)
		maxwait -= 1
	endWhile
	if (0 == maxwait)
		Trace("Warning : Not all loot removed from theContainer")
		Utility.WaitMenuMode(0.3)
		theContainer.Disable(False)
	else
		theContainer.Disable(False)
		theContainer.Delete()
	endIf
	theContainer = None
	
	ownedContainers.clear()
	ownedResults.clear()
	ownedCounts.clear()
	
	RemoveAllInventoryEventFilters()
	searchMsgHandler.StopShowSearching()	
	TweakGatherFeedback.Show(gatheredCount, ownedCount, lockedCount)
	
EndFunction

Function ScanContainersForItems(FormList containers, string name, ObjectReference target)
	Trace("ScanContainersForItems [" + name + "]...")
	
	ObjectReference[] results = None
	ObjectReference result = None
	Actor pc = Game.GetPlayer()	
	ObjectReference center = pc as ObjectReference
	
	Trace("Scanning [" + name + "]...")
	results = center.FindAllReferencesOfType(containers, 1600)
	int numresults = results.length
	Trace("Scan [" + name + "] Complete: [" + numresults + "] container objects found", 0)
	
	int i = 0
	ObjectReference containedin = None
	bool moveit = True
	
	if (None == target)
		target = center
	endIf
	
	while (i < numresults)
		moveit = True
		result = results[i]
		if (result)
			Trace("Found Container [" + result + "] IsLocked [" + result.IsLocked() + "] Lock Level [" + result.GetLockLevel() + "]")
			if (result.IsLocked())
				Trace("Rejected: Container is Locked [" + result.GetLockLevel() + "]")
				moveit = False
				lockedCount += 1
			elseIf (0 == result.GetItemCount(None))
				Trace("Rejected: Container is Empty")
				moveit = False
			else
				Actor owner = result.GetActorRefOwner()
				ActorBase ownerBase = result.GetActorOwner()
				if (owner)
					if (owner.GetFactionReaction(pc) > 1)
						Trace("Accepted: Container Owner is Ally to player")
					else
						Trace("Rejected: Container owned By Another Actor")
						moveit = False
					endIf
				elseif (ownerBase)
					if (ownerBase == Player)
						Trace("Accepted: Container owner is Player")
					else
						Trace("Rejected: Container owned By another Actor Base")
						moveit = False
					endIf
				else
					Faction ownerFaction = result.GetFactionOwner()
					if (ownerFaction)
						if (pc.IsInFaction(ownerFaction))
							Trace("Accepted: Player member of container owning Faction")
						elseIf (ownerFaction.GetFactionReaction(pc) > 1)
							Trace("Accepted: Container Faction is Ally to player")
						else
							Trace("Rejected: Container Faction isn't associated with Player")
							moveit = False
						endIf
					endIf
				endIf
				if (!moveit)
					ownedCount += 1
				endIf
			endIf
			if (moveit)
				result.RemoveAllItems(target, True)
			endIf
		endIf
		i += 1
	endWhile
endFunction

Function ScanDeadActorsForItems(ObjectReference target)
	Trace("ScanActorsForItems [" + target as string + "]...")
	
	FormList TweakActorTypes = Game.GetFormFromFile(0x01025B3B, "AmazingFollowerTweaks.esp") as FormList
	Actor pc = Game.GetPlayer()
	
	if (None == target)
		target = pc as ObjectReference
	endIf
	
	ObjectReference[] nearby = None
	Actor npc = None
	int nsize = 0
	int j = 0
	
	bool moveit = False
	ObjectReference opc = pc as ObjectReference
	int numTypes = TweakActorTypes.GetSize()
	int i = 0
	
	while (i < numTypes)
		nearby = pc.FindAllReferencesWithKeyword(TweakActorTypes.GetAt(i), 1600)
		if (0 != nearby.length)
			nsize = nearby.length
			Trace("Found [" + nsize + "] [" + TweakActorTypes.GetAt(i) + "] nearby ", 0)
			j = 0
			while (j < nsize)
				npc = nearby[j] as Actor
				if (npc as bool && npc.IsDead() && 0 != npc.GetItemCount(None))
					Trace("Dead actor [" + npc + "] within 1600 of player with items. Looting")
					npc.RemoveAllItems(target, False)
				else
					Trace("Rejected: Actor is Alive or Has No Items")
				endIf
				j += 1
			endWhile
		endIf
		i += 1
	endWhile
	
	; Handle Turrets
	nearby = pc.FindAllReferencesWithKeyword(ActorTypeTurret, 1600)
	if (0 != nearby.length)
		nsize = nearby.length
		Trace("Found [" + nsize + "] [ActorTypeTurret] nearby ")
		j = 0
		while (j < nsize)
			npc = nearby[j] as Actor
			if (npc && npc.IsDead() && 0 != npc.GetItemCount(None))
				Trace("Broken Turret [" + npc + "] within 1600 of player with items. Looting")
				npc.RemoveAllItems(target, True)
			else
				Trace("Rejected: Turret is Active or Has No Items")
			endIf
			j += 1
		endWhile
	endIf
EndFunction

Function ScanForLooseItems(FormList list, string name, ObjectReference target)
	Trace("ScanForLooseItems [" + name + "]")
	
	if (list == None)
		Trace(name + " is None")
		return 
	endIf
	
	ObjectReference[] results = None
	ObjectReference result = None
	Actor pc = Game.GetPlayer()
	ObjectReference center = pc as ObjectReference
	
	if (None == target)
		target = center
	endIf
	
	results = center.FindAllReferencesOfType(list, 1600)
	
	int numresults = results.length
	if (numresults < 1)
		return 
	endIf
	Trace("Found [" + numresults + "] objects found")
	
	int i = 0
	ObjectReference containedin = None
	bool moveit = True
	while (i < numresults)
		moveit = True
		result = results[i]
		if result.IsEnabled()
			Actor owner = result.GetActorRefOwner()
			ActorBase ownerBase = result.GetActorOwner()
			if (owner)
				if (owner.GetFactionReaction(pc) > 1)
					Trace("Accepted: Loose item owner is Ally to player")
				else
					Trace("Rejected: Loose item owned By Another Actor")
					moveit = False
				endIf
			elseif (ownerBase)
				if (ownerBase == Player)
					Trace("Accepted: Loose item owned by Player")
				else
					Trace("Rejected: Loose item owned By another Actor Base")
					moveit = False
				endIf
			else
				Faction ownerFaction = result.GetFactionOwner()
				if (ownerFaction)
					if (pc.IsInFaction(ownerFaction))
						Trace("Accepted: Player member of container owning Faction")
					elseIf (ownerFaction.GetFactionReaction(pc) > 1)
						Trace("Accepted: Container Faction is Ally to player")
					else
						Trace("Rejected: Loose item not associated with Player Faction")
						moveit = false
					endIf
				endIf
			endIf
			if (moveit)
				if (result.IsQuestItem())
					Trace("Rejected : Is Quest Item")
					moveit = False
				endIf
			else
				ownedCount += 1
			endIf
			if (moveit)
				containedin = result.GetContainer()
				if (containedin)
					if (center == containedin)
						Trace("Rejected: Container is Player")
						moveit = False
					elseIf (containedin && !(containedin as Actor).IsDead())
						Trace("Rejected: Container is Actor [" + (containedin as Actor) + "]")
						moveit = False
					elseIf (containedin.IsLocked())
						Trace("Rejected: Container is Locked [" + containedin.GetLockLevel() + "]")
						lockedCount += 1
						moveit = False
					endIf
				endIf
			endIf
			if (moveit)
				gatheredCount += 1
				target.AddItem(result, 1, True)
				; result.Disable()
			endIf
		endif
		i += 1
	endWhile
endFunction

Event ObjectReference.OnItemAdded(ObjectReference theContainer, Form akBaseItem, int aiItemCount, ObjectReference result, ObjectReference akSourceContainer)
	bool moveit = False
	if (result)
		Actor pc = Game.GetPlayer()
		Actor owner = result.GetActorRefOwner()
		if (owner)
			if (owner.GetFactionReaction(pc) > 1)
				Trace("OnItemAdded - Accepted: Item owner is Ally to player")
				moveit = True
			else
				Trace("OnItemAdded - Rejected: Item owned By Another Actor")
			endIf
		else
			ActorBase ownerBase = result.GetActorOwner()
			if (ownerBase)
				if (ownerBase == Player)
					Trace("OnItemAdded - Accepted: Item owned by Player")
					moveit = True
				else
					Trace("OnItemAdded - Rejected: Loose item owned By another Actor Base")
				endIf
			endIf
		endIf
		if (!moveit)
			Faction ownerFaction = result.GetFactionOwner()
			if (ownerFaction)
				if (pc.IsInFaction(ownerFaction))
					Trace("OnItemAdded - Accepted: Player member of item owning Faction")
					moveit = True
				elseIf (ownerFaction.GetFactionReaction(pc) > 1)
					Trace("OnItemAdded - Accepted: Item Faction is Ally to player")
					moveit = True
				endIf
			endIf
		endIf
		if (!moveit)
			ownedCount += 1
			ownedContainers.add(akSourceContainer, 1)
			ownedResults.add(result, 1)
			ownedCounts.add(aiItemCount, 1)
			return 
		endIf
		if (result.IsQuestItem())
			Trace("OnItemAdded - Redirected: Is Quest Item")
			theContainer.RemoveItem(akBaseItem, aiItemCount, False, pc)
			gatheredCount += aiItemCount
			return 
		endIf
	endIf
	if (lootItemsUnique.HasForm(akBaseItem))
		Trace("OnItemAdded - Redirected: Is Unique Item")
		theContainer.RemoveItem(akBaseItem, aiItemCount, False, Game.GetPlayer())
	endIf
	gatheredCount += aiItemCount
endEvent
