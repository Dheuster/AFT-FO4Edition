Scriptname TweakPrefabOption extends ObjectReference

Group Setup
	
	Terminal Property PrefabTerminal auto const
    { The Terminal that shows the name and author of the Prefab (Should be based on TweakPrefabTerminalTemplate) }

	Quest Property PrefabQuest auto const
	{ The Quest that hosts the BuildScript (A script with BuildFull(TweakBuilderScript tbs) and BuildWallOnly(TweakBuilderScript tbs)}

	String Property PrefabLoadScript auto const
	{ The Name of the script attached to the Quest that defines the methods BuildFull(TweakBuilderScript tbs) and BuildWallOnly(TweakBuilderScript tbs) }
	
	Bool Property PrefabHasFullOption = true auto const
	{ Whether this prefab includes a Full Settlement Option }
	
	Bool Property PrefabHasWallOnlyOption = false auto const
	{ Whether this wall includes a Wall Only Option }

	String Property LogName = "TweakPrefabOption" auto const
	
EndGroup

Group Optional

	Int Property PrefabFullPrice = 0 auto const 
	{ The Price of the Full Settlement Option (if enabled) }

	Int Property PrefabWallPrice = 0 auto const
	{ The Price of the Wall Option (if enabled) }

	Bool Property ClearSettlementBeforeFullOption = True auto const 
	{ Whether the settlement should be Cleared }

	Bool Property ClearSettlementBeforeWallOption = False auto const 
	{ Whether the settlement should be Cleared }

EndGroup

Group Auto_Fill_All

	GlobalVariable Property pTweakSettlementCost		Auto Const
	GlobalVariable Property pTweakDisablePrefabSafety	Auto Const
	Message   Property pTweakRemoveFoodMsg				Auto Const
	Message	  Property pTweakLoadSettlementMenu			Auto Const
	Message	  Property pWorkshopUnownedMessage			Auto Const
	Message   Property pTweakSettlementCostPrompt		Auto Const
	Message   Property pTweakLoadReloadFull				Auto Const
	Message   Property pTweakInsufficientFunds			Auto Const
	Message   Property pTweakPrefabRisks				Auto Const
	
EndGroup

Bool 	  Property pPurchasedWall				Auto hidden
Bool 	  Property pPurchasedFull				Auto hidden

Event OnInit()
	pPurchasedWall = false
	pPurchasedFull = false
EndEvent

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	debug.OpenUserLog(LogName)
	RETURN debug.TraceUser(LogName, asTextToPrint, aiSeverity)
EndFunction

Function Load(int option = 0)

	Trace("Load [" + option + "] Called")
	pTweakDisablePrefabSafety.SetValue(0)
	
	Actor pc = Game.GetPlayer()	
	WorkshopScript WorkshopRef = None
	
	WorkshopParentScript WorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
	if WorkshopParent
		Trace("Found Workshop Parent")
		WorkshopRef = WorkshopParent.GetWorkshopFromLocation(pc.GetCurrentLocation())
	else
		Trace("No Workshop for current location")					
	endif
	
	if WorkshopRef
		Trace("Found WorkshopRef Parent")
		if !WorkshopRef.OwnedByPlayer
			pWorkshopUnownedMessage.Show()
			return
		endif
	else
		Trace("No WorkshopRef found (for current Location)")
	endif		
	
    if 0 == option
		if (0 != PrefabWallPrice)
			pTweakSettlementCost.SetValueInt(PrefabWallPrice)
			int ask = pTweakSettlementCostPrompt.Show(PrefabWallPrice)
			if 0 != ask
				return
			endif
		endif
		
		if pc.GetGoldAmount() >= PrefabWallPrice
			Trace("Player has (at least) [" + PrefabWallPrice + "] Caps" )
		
			if ClearSettlementBeforeWallOption && WorkshopRef
				ObjectReference[] FoodObjects = WorkshopParent.GetResourceObjects(WorkshopRef, WorkshopParent.WorkshopResourceAVs[WorkshopParent.WorkshopRatingFood].resourceValue, 2)
				int foodlen = FoodObjects.length
				if 0 != foodlen
					Trace("Food Sources [" + foodlen + "]")
					int foodlennobrahmin = foodlen
					; Exclude Brahmin:
					int f = 0
					while (f < foodlen)
						if (FoodObjects[f].GetBaseObject() as Actor) 
							foodlennobrahmin -= 1
						endif
						f += 1
					endwhile
					if 0 != foodlennobrahmin
						Trace("Food Sources (minus Brahmin) [" + foodlennobrahmin + "]")
						int trouble = pTweakPrefabRisks.Show()
						if 2 != trouble
							Trace("Declined Risk")
							return
						endif
						Trace("Setting TweakDisablePrefabSafety to true")
						pTweakDisablePrefabSafety.SetValue(1.0)
					else
						Trace("Food Sources (minus Brahmin) [0]")
					endif
				endif
			else
				Trace("ClearSettlementBeforeWallOption is false")			
			endif
			
			Game.RemovePlayerCaps(PrefabWallPrice)

			Trace("PrefabQuest      = [" + PrefabQuest      + "]")
			Trace("PrefabLoadScript = [" + PrefabLoadScript + "]")			

			ScriptObject BuildScript = PrefabQuest.CastAs(PrefabLoadScript)
			if BuildScript
				Trace("PrefabQuest.CastAs(PrefabLoadScript) Succeeded")
				
				; Expected:
				; Function BuildWallOnly(TweakBuilderScript tbs, int clearFirst = 0,  int requireNoFood = 0)
				; When using Inter-mod communication, you MUST provide all values, even ones with defaults. 
				
				Var[] params = new Var[3]
				TweakBuilderScript p0 = (self as ObjectReference) as TweakBuilderScript
				if ClearSettlementBeforeWallOption
					params[1] = 1
					params[2] = 1
				else
					params[1] = 0
					params[2] = 0
				endif
				
				if (p0)
					params[0] = p0
					Trace("Calling Function BuildWallOnly()")
					BuildScript.CallFunctionNoWait("BuildWallOnly", params)
					pPurchasedWall = true					
				else
					Trace("Cast of Self to TweakBuilderScript Failed")
				endif
			else
				Trace("PrefabQuest.CastAs(PrefabLoadScript) Failed")
			endif			
		else
			pTweakInsufficientFunds.Show()
		endif
		
	elseif 1 == option
	
		if pPurchasedFull
			; int ask = pTweakLoadReloadFull.Show()
			; if 0 != ask
				; return
			; endif
			; else
			int ask = pTweakLoadSettlementMenu.Show()
			if 0 != ask
				return
			endif
		endif
		
		int cost_adjusted = PrefabFullPrice		
		if pPurchasedWall
			cost_adjusted -= PrefabWallPrice
		endif
		if 0 != cost_adjusted
			pTweakSettlementCost.SetValueInt(cost_adjusted)
			int ask = pTweakSettlementCostPrompt.Show(cost_adjusted)
			if 0 != ask
				return
			endif
		endif
		if pc.GetGoldAmount() >= cost_adjusted
			Trace("Player has (at least) [" + cost_adjusted + "] Caps" )
			if ClearSettlementBeforeFullOption && WorkshopRef
				Trace("ClearSettlementBeforeFullOption is True")
				ObjectReference[] FoodObjects = WorkshopParent.GetResourceObjects(WorkshopRef, WorkshopParent.WorkshopResourceAVs[WorkshopParent.WorkshopRatingFood].resourceValue, 2)
				int foodlen = FoodObjects.length
				if 0 != foodlen
					Trace("Food Sources [" + foodlen + "]")
					int foodlennobrahmin = foodlen
					; Exclude Brahmin:
					int f = 0
					while (f < foodlen)
						if (FoodObjects[f].GetBaseObject() as Actor) 
							foodlennobrahmin -= 1
						endif
						f += 1
					endwhile
					if 0 != foodlennobrahmin
						Trace("Food Sources (minus Brahmin) [" + foodlennobrahmin + "]")
						int trouble = pTweakPrefabRisks.Show()
						if 2 != trouble
							Trace("Declined Risk")
							return
						endif
						Trace("Setting TweakDisablePrefabSafety to true")
						pTweakDisablePrefabSafety.SetValue(1.0)
					else
						Trace("Food Sources (minus Brahmin) [0]")
					endif
				endif
            else
				Trace("ClearSettlementBeforeFullOption is false (Or we are not in a regular settlement). Skipping Food Check")
			endif
		
			Game.RemovePlayerCaps(cost_adjusted)
			ScriptObject BuildScript = PrefabQuest.CastAs(PrefabLoadScript)
			if BuildScript
			
				; Expected:
				; Function BuildFull(TweakBuilderScript tbs, int clearFirst = 1,  int requireNoFood = 1)
				; When using Inter-mod communication, you MUST provide all values, even ones with defaults. 
				
				Var[] params = new Var[3]
				TweakBuilderScript p0 = (self as ObjectReference) as TweakBuilderScript
				int                p1 = 1
				int                p2 = 1
				if ClearSettlementBeforeFullOption
					params[1] = 1
					params[2] = 1
				else
					params[1] = 0
					params[2] = 0
				endif
				
				if (p0)
					params[0] = p0
					Trace("Calling Function BuildFull()")
					BuildScript.CallFunctionNoWait("BuildFull", params)
					pPurchasedFull = true
					pPurchasedWall = true
				else
					Trace("Cast of Self to TweakBuilderScript Failed")
				endif
			else
				Trace("PrefabQuest.CastAs(PrefabLoadScript) Failed")
			endif			
		else
			pTweakInsufficientFunds.Show()
		endif
	else
		Trace("Unrecognized Option")
	endif		
EndFunction


TweakBuilderScript Function GetTweakBuilderScript()
	Actor pc = Game.GetPlayer()	
	WorkshopParentScript WorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
	if WorkshopParent
		WorkshopScript WorkshopRef = WorkshopParent.GetWorkshopFromLocation(pc.GetCurrentLocation())
		if WorkshopRef
			if !WorkshopRef.OwnedByPlayer
				pWorkshopUnownedMessage.Show()
				return None
			endif
		endif
	endif
	return (self as ObjectReference) as TweakBuilderScript
EndFunction
