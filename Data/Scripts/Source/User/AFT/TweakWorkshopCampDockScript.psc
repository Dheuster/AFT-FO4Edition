Scriptname AFT:TweakWorkshopCampDockScript extends ObjectReference Const

WorkshopParentScript Property WorkshopParent auto const mandatory
Keyword Property TweakCampDock auto const

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakWorkshopCampDockScript"
	; string logName = "TweakSettings"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Event OnInit()
	Trace("OnInit Called")
	WorkshopScript workshopRef = GetLinkedRef(WorkshopParent.WorkshopItemKeyword) as WorkshopScript
	if workshopRef
		Trace("Workshop Found")
		ObjectReference pTweakPreviousDock = workshopRef.GetLinkedRef(TweakCampDock)
		if (pTweakPreviousDock)
			Trace("Previous Dock Found. Deleting")
			pTweakPreviousDock.Disable()
			pTweakPreviousDock.Delete()
		else
			Trace("No Previous Dock Found.")
		endif		
		SetPersistLoc( GetCurrentLocation() )
		Trace("Setting TweakCampDock to self [" + self + "]")
		workshopRef.SetLinkedRef(self, TweakCampDock)
	else	
		Trace("Workshop Not Found")
	endif
EndEvent

Event OnWorkshopObjectMoved(ObjectReference akReference)
	Trace("OnWorkshopObjectMoved [" + akReference + "]")
	WorkshopScript workshopRef = GetLinkedRef(WorkshopParent.WorkshopItemKeyword) as WorkshopScript
	if workshopRef
		Trace("Workshop Found")
		ObjectReference pCurrentDock = workshopRef.GetLinkedRef(TweakCampDock)
		if (pCurrentDock)
			Trace("TweakCampDoc Found. Moving")
			pCurrentDock.MoveTo(self)
		else
			Trace("TweakCampDoc Not Found.")
		endif
	else
		Trace("Workshop Not Found")		
	endif
EndEvent

Event OnWorkshopObjectDestroyed(ObjectReference akActionRef)
	Trace("OnWorkshopObjectDestroyed [" + akActionRef + "]")
	WorkshopScript workshopRef = GetLinkedRef(WorkshopParent.WorkshopItemKeyword) as WorkshopScript
	if workshopRef
		Trace("Workshop Found")
		ObjectReference pCurrentDock = workshopRef.GetLinkedRef(TweakCampDock)
		if (pCurrentDock)
			Trace("TweakCampDoc Found. Deleting")
			pCurrentDock.Disable()
			pCurrentDock.Delete()
			workshopRef.SetLinkedRef(None, TweakCampDock)
		else
			Trace("TweakCampDoc Not Found.")			
		endif
	else
		Trace("Workshop Not Found")	
	endif
EndEvent
