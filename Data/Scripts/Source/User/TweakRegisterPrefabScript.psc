Scriptname TweakRegisterPrefabScript extends Quest

; To Force Registrtation, From console type:
;
; cqf TweakSettlementLoader "TweakRegisterPrefabScript.Cleanup"
; cqf TweakSettlementLoader "TweakRegisterPrefabScript.RegisterPrefabs"

Struct PrefabData
    Furniture PrefabFurniture
    { Populate with Furniture Objects that Have TweakPrefabOption and TweakBuilder Scripts attached }	
	
	Location  PrefabLocation
	{ Set this value with Core Game Settlement. Choose the Location of the settlement. }

	int  MaskedPrefabLocation
	{ Set this value for DLC Settlements. See readme for valid values. }
EndStruct

PrefabData[] Property Prefabs Auto Const

int Property PreviousSize  = 0 Auto hidden

int NO_LOAD_FLOOD = 200 const

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	debug.OpenUserLog("TweakRegisterPrefabScript")
	RETURN debug.TraceUser("TweakRegisterPrefabScript", asTextToPrint, aiSeverity)
EndFunction

Event OnQuestInit()
	Actor player = Game.GetPlayer()
	RegisterForRemoteEvent(player,"OnPlayerLoadGame")	
	; Give WorkshopParent Quest time start up on a New Game....
	StartTimer(4.0, NO_LOAD_FLOOD)
EndEVent

Event Actor.OnPlayerLoadGame(Actor akSender)
	Actor player = Game.GetPlayer()
	UnRegisterForRemoteEvent(player,"OnPlayerLoadGame")
	RegisterForRemoteEvent(player,"OnPlayerLoadGame")
	StartTimer(0.1, NO_LOAD_FLOOD)
EndEvent

Event OnTimer(int timerID)
	CancelTimer(timerID)
	if (NO_LOAD_FLOOD == timerID)
		RegisterPrefabs()
		return             
	endif
EndEvent

Function RegisterPrefabs()

	if (PreviousSize == Prefabs.length)
		return
	endif
	
	PreviousSize = 0
	
    Keyword TweakPrefabs = Game.GetFormFromFile(0x0100EF7B,"AmazingFollowerTweaks.esp") as Keyword
	if !TweakPrefabs
		trace("Unable to Retreive TweakPrefabs Keyword")
		return	
	endif
	WorkshopParentScript WorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
	if !WorkshopParent
		trace("Cast to WorkshopParentScript Failed")
		return
	endif
	if !WorkshopParent.IsRunning()
		trace("WorkshopParent Not Running")
		return
	endif
	
	int i = 0
	int Prefabs_length = Prefabs.length
	
	Furniture			PrefabFurn		= None
    Location			PrefabLoc		= None
	int  				MaskedPrefabLoc = 0
	RefCollectionAlias	PrefabRegistry	= None
	
	Quest TweakSettlmentLoader = Game.GetFormFromFile(0x0105F22F,"AmazingFollowerTweaks.esp") as Quest
	if TweakSettlmentLoader
		PrefabRegistry = TweakSettlmentLoader.GetAlias(0) as RefCollectionAlias
	endif
		
	while ( i < Prefabs_length)
		MaskedPrefabLoc = Prefabs[i].MaskedPrefabLocation
		if ((MaskedPrefabLoc < 0) && (MaskedPrefabLoc > -0x05000000))
			if (MaskedPrefabLoc < -0x03FFFFFF)
				; -0x04??????			
				PrefabLoc = Game.GetFormFromFile(((-1 * MaskedPrefabLoc) - 0x04000000), "DLCNukaWorld.esm") as Location
				if !PrefabLoc
					trace("Lookup Failure for [" + MaskedPrefabLoc + " abs(+ 0x04000000)]")
					PrefabLoc  = Prefabs[i].PrefabLocation
				endif
			elseif (MaskedPrefabLoc < -0x02FFFFFF)
				; -0x03??????
				PrefabLoc = Game.GetFormFromFile(((-1 * MaskedPrefabLoc) - 0x03000000), "DLCCoast.esm") as Location
				if !PrefabLoc
					trace("Lookup Failure for [" + MaskedPrefabLoc + " abs(+ 0x03000000)]")
					PrefabLoc  = Prefabs[i].PrefabLocation
				endif
			elseif (MaskedPrefabLoc > -0x02000000)
				; -0x01??????
				PrefabLoc = Game.GetFormFromFile(((-1 * MaskedPrefabLoc) - 0x01000000), "DLCRobot.esm") as Location
				if !PrefabLoc
					trace("Lookup Failure for [" + PrefabLoc + " abs(+ 0x01000000)]")
					PrefabLoc  = Prefabs[i].PrefabLocation
				endif
			else
				; -0x02??????
				trace("DLC location Unsupported: [" + MaskedPrefabLoc + " abs(+ 0x02000000)]")
				PrefabLoc  = Prefabs[i].PrefabLocation
			endif						
		else
			PrefabLoc  = Prefabs[i].PrefabLocation
		endif
		PrefabFurn = Prefabs[i].PrefabFurniture
		if (PrefabLoc && PrefabFurn)
			WorkshopScript WorkshopRef = WorkshopParent.GetWorkshopFromLocation(PrefabLoc)
			if WorkshopRef			
				; Confirm Prefab isn't already Registered
				bool NotRegistered = true
				
				ObjectReference[] local_prefabs = WorkshopRef.GetRefsLinkedToMe(TweakPrefabs)
				int j = 0
				int local_prefabs_length = local_prefabs.length
				
				while j < local_prefabs_length && NotRegistered
					if PrefabFurn == local_prefabs[j].GetBaseObject()
						NotRegistered = false
					endif
					j += 1
				endWhile
				
				if NotRegistered
				
					;        to track all these ObjectReferences.
					
					ObjectReference PrefabRef = WorkshopRef.placeatme(PrefabFurn, 1, true)
					if PrefabRef
						PrefabRef.SetPersistLoc(PrefabLoc)
						PrefabRef.SetLinkedRef(WorkshopRef, TweakPrefabs)
						
						; PrefabRegistry : Maintained mostly for Cleanup when being uninstalled
						if PrefabRegistry
							PrefabRegistry.AddRef(PrefabRef)
						endif
						trace("Prefab[" + i + "] Registered for Workshop [" + WorkshopRef + "]")
					else
						trace("Unable to instantiate Prefab[" + i + "] for Workshop [" + WorkshopRef + "]")
					endif
				else
					trace("Prefabs[" + i + "] Already Registered at Location [" + PrefabLoc + "]")
				endif
			else
				trace("Prefabs[" + i + "] Workshop not Registered at Location [" + PrefabLoc + "]")
			endif				
		else
			trace("Prefabs[" + i + "] Did not define a Location. Skipping.")
		endif
		i += 1
	endwhile
	
	PreviousSize = Prefabs_length
	
EndFunction

Function Cleanup()
	PreviousSize = 0
	Quest TweakSettlmentLoader = Game.GetFormFromFile(0x0105F22F,"AmazingFollowerTweaks.esp") as Quest
	if !TweakSettlmentLoader
		trace("Unable to Retreive TweakSettlmentLoader")
		return	
	endif
	if (self as Quest) != TweakSettlmentLoader
		trace("There can be only 1!")
		return
	endif
    Keyword TweakPrefabs = Game.GetFormFromFile(0x0100EF7B,"AmazingFollowerTweaks.esp") as Keyword
	if !TweakPrefabs
		trace("Unable to Retreive TweakPrefabs Keyword")
	endif
	RefCollectionAlias PrefabRegistry = TweakSettlmentLoader.GetAlias(0) as RefCollectionAlias
	if PrefabRegistry
		int numregistered = PrefabRegistry.GetCount()
		if numregistered > 0
			int i = numregistered - 1
			while i > -1
				ObjectReference prefab = PrefabRegistry.GetAt(i)
				if TweakPrefabs
					prefab.SetLinkedRef(None,TweakPrefabs)
				endif
				prefab.Disable()
				prefab.delete()
				i -= 1
			endwhile
			PrefabRegistry.RemoveAll()
		endif
	endif
EndFunction
