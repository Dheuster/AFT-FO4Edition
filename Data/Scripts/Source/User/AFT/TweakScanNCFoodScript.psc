Scriptname AFT:TweakScanNCFoodScript extends Quest

; FOOD items are special as they produce no scrap, but we still remove/record them
; for settlement build reasons. May also look into ways of moving them to workspace
; as you can't actually scrap or delete food resources in the game (this may cause bugs)

; import AFT

Quest			Property TweakScrapScanMaster		Auto Const
FormList		Property TweakNonConstructed_Food	Auto Const
GlobalVariable	Property pTweakSettlementSnap		Auto Const
GlobalVariable	Property pTweakScanThreadsDone		Auto Const
GlobalVariable	Property pTweakScrapAll				Auto Const
GlobalVariable	Property pTweakScanObjectsFound		Auto Const

; Local Variables...
ObjectReference center
float 			radius

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakScanNCFoodScript"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Function Scan(ObjectReference p_center, float p_radius)
	Trace("Scan Called, Starting Timer")
	center = p_center
	radius = p_radius 
	startTimer(0.0) ; Basically this is the same thing as FORK....
EndFunction

Event OnTimer(int aiTimerID)
	Trace("Timer Fired. Calling ScanHelper")
	ScanHelper()
EndEvent

Function ScanHelper()
	Trace("ScanHelper Called. Scanning...")
	
	ObjectReference[] results = center.FindAllReferencesOfType(TweakNonConstructed_Food, radius)			
	int numresults = results.length
	
	Trace("Scanning Complete: [" + numresults + "] objects found")
	center = None	
	if (0 == numresults)
		pTweakScanThreadsDone.mod(-1.0)
		return
	endif
	
	ObjectReference 	 result
	AFT:TweakScrapScanScript ScrapScanMaster = TweakScrapScanMaster as AFT:TweakScrapScanScript
	
	Form	rbase	
	int		rid
	bool	keepgoing = true
	int		lookupsuccess = 0	
	bool	snapshot = (1.0 == pTweakSettlementSnap.GetValue())
	bool	scrapall = (1.0 == pTweakScrapAll.Getvalue())
	Var[]	params = new Var[10]

	int	i = 0
	while (i != numresults && keepgoing)
		result = results[i]
		if scrapall
			result.SetPosition(0,0,0)
			result.Disable()
			result.Delete()
		elseif (!result.IsDisabled())
			lookupsuccess += 1
			rbase = result.GetBaseObject()
			rid   = rbase.GetFormID()
			if snapshot		
				params[0] = "Food"
				params[1] = rid
				params[2] = result.GetPositionX()
				params[3] = result.GetPositionY()
				params[4] = result.GetPositionZ()
				params[5] = result.GetAngleX()
				params[6] = result.GetAngleY()
				params[7] = result.GetAngleZ()
				params[8] = result.GetScale()
				params[9] = -1
				Trace("Adding Components [Food] to scrapdata")
				ScrapScanMaster.CallFunctionNoWait("TweakBuildInfo", params)			
			else			
				result.SetPosition(0,0,0)
				result.Disable()
				result.Delete()
				Trace("Adding Scrap [Food] to scrapdata")
			endif			
		endif	
	
		i += 1
		
		if (0 == (i % 30))
			keepgoing = (pTweakScanThreadsDone.GetValue() > 0.0)
		endif
		
	endwhile
	
	if (0 != lookupsuccess)
		pTweakScanObjectsFound.mod(lookupsuccess)
	endif
	
	pTweakScanThreadsDone.mod(-1.0)
	
EndFunction