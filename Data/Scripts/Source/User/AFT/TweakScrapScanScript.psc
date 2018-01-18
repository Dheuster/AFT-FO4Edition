Scriptname AFT:TweakScrapScanScript extends Quest

; Dont use import. It only works when .pex files are local. Once you package them up into an 
; release/final archive, the scripts wont be found and everything will break...
; import AFT

Quest Property pTweakScanConstructed_BtoN    Auto Const
Quest Property pTweakScanConstructed_NtoW    Auto Const
Quest Property pTweakScanConstructed_Wtow    Auto Const
Quest Property pTweakScanConstructedwtoy     Auto Const
Quest Property pTweakScanConstructed_Turrets Auto Const
Quest Property pTweakScanConstructed_Walls   Auto Const
Quest Property pTweakScanConstructed_Fences  Auto Const
Quest Property pTweakScanConstructed_Floors  Auto Const
Quest Property pTweakScanConstructed_Cont    Auto Const
Quest Property pTweakScanConstructed_Benches Auto Const
Quest Property pTweakScanConstructed_Shops   Auto Const
Quest Property pTweakScanConstructed_Food	 Auto Const

Quest Property pTweakScanNonConstructed_Cont Auto Const
Quest Property pTweakScanNonConstructed_BtoC Auto Const
Quest Property pTweakScanNonConstructed_CtoF Auto Const
Quest Property pTweakScanNonConstructed_FtoO Auto Const
Quest Property pTweakScanNonConstructed_OtoP Auto Const
Quest Property pTweakScanNonConstructed_PtoS Auto Const
Quest Property pTweakScanNonConstructed_StoS Auto Const
Quest Property pTweakScanNonConstructed_StoT Auto Const
Quest Property pTweakScanNonConstructed_TtoV Auto Const
Quest Property pTweakScanNonConstructed_Vtow Auto Const

Quest Property pTweakScanNonConstructed_Trees Auto Const
Quest Property pTweakScanNonConstructed_Food  Auto Const
Quest Property pTweakScanNonConstructed_Extra Auto Const

Keyword Property LocTypeWorkshopSettlement    Auto Const
Keyword Property WorkshopLinkCenter           Auto Const

; GlobalVariable   Property pTweakOptionsScanCheckCont  Auto

GlobalVariable   Property pTweakScrapAll                Auto Const

GlobalVariable   Property pTweakOptionsScanNC           Auto Const
GlobalVariable	 Property pTweakOptionsScanNC_ExFood	Auto Const
GlobalVariable   Property pTweakOptionsScanNC_ExLiving  Auto Const
GlobalVariable   Property pTweakOptionsScanC            Auto Const
GlobalVariable   Property pTweakOptionsScanC_ExTurrets  Auto Const
GlobalVariable   Property pTweakOptionsScanC_ExBenches  Auto Const
GlobalVariable   Property pTweakOptionsScanC_ExShops    Auto Const
GlobalVariable   Property pTweakOptionsScanC_ExFences   Auto Const
GlobalVariable   Property pTweakOptionsScanC_ExFood		Auto Const
GlobalVariable   Property pTweakOptionsScanC_ExWalls    Auto Const
GlobalVariable   Property pTweakOptionsScanC_ExFloors   Auto Const
GlobalVariable	 Property pTweakOptionsScanNC_ExMisc		Auto Const
GlobalVariable   Property pTweakOptionsScanC_IncTheRest		Auto Const

GlobalVariable   Property pTweakOptionsScanNC_IncTheRest	Auto Const
GlobalVariable   Property pTweakOptionsScanC_ExCont			Auto Const
GlobalVariable   Property pTweakOptionsScanNC_ExCont		Auto Const

; GlobalVariable   Property pTweakOptionsScanJunk         Auto Const
; GlobalVariable   Property pTweakOptionsScanJunk_ExVal   Auto

FormList         Property pTweakScrapComponents Auto Const

GlobalVariable   Property pTweakScanThreadsDone Auto Const
GlobalVariable[] Property ResultArray Auto
 

GlobalVariable   Property pTweakSettlementSnap          Auto Const
Message			 Property pTweakProgress				Auto Const
Message			 Property pTweakSnapshotComplete  		Auto Const
Message			 Property pTweakSnapshotTimeout			Auto Const
Message			 Property pTweakSnapshotNotSettlement	Auto Const
Message 		 Property pTweakScanCompleteMsg         Auto Const
Message			 Property pTweakScanTimeoutMsg			Auto Const

Quest			 Property pWorkshopParent 				Auto Const
String[]	     Property WorkshopName					Auto

Location		 Property TheCastleLocation				Auto Const

; Scan is asynchronous. This temporary property is used to remember the 
; the receiver of results between two methods that fire within a second
; of each other. Property is almost immediatly reset to NONE. 
;
; Consider redoing method to use CallNoWait() instead of Timer to fork. 

ObjectReference  Property ScrapReceiver Auto

; LOCAL SCOPE

int	expected
string requirements
String[] buildoutput
int buildindex
int buildcount
int buildType
int buildtotal

Struct SettlementData
   int    locid
   string name
   ; bs = bounding sphere
   float  bs_x
   float  bs_y
   float  bs_z
   float  bs_radius
EndStruct

SettlementData[] Property SettlementLookup Auto


bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakScrapScanScript"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Event OnInit()
	expected = 0
	initialize_ResultArray()
	initialize_SettlementData()
	buildoutput  = new string[0]
	buildindex = 0
	buildcount = 0
	buildtotal = 0
	requirements = ""
	buildType = 0
EndEvent

Function Scan(ObjectReference receiver, bool snapshot = false, int stype = 0)
	Trace("Scan Called: snapshot[" + snapshot + "] stype [" + stype + "]")
	pTweakScrapAll.SetValue(0)
	ScrapReceiver = receiver
	if snapshot
		pTweakSettlementSnap.SetValue(1.0)
		buildType = stype
	else
		pTweakSettlementSnap.SetValue(0.0)
	endif
	startTimer(0.0)
EndFunction

Function ScrapAll()
	; We dont want this function to return until it is done...
	Trace("ScrapAll Called")
	pTweakScrapAll.SetValue(1)
	pTweakSettlementSnap.SetValue(0.0)
	
	WorkshopParentScript WorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
	if WorkshopParent
		Location currentLocation = Game.GetPlayer().GetCurrentLocation()
		WorkshopScript WorkshopRef = WorkshopParent.GetWorkshopFromLocation(currentLocation)
		if (WorkshopRef)
			ObjectReference[] WorkshopActors = WorkshopParent.GetWorkshopActors(workshopRef)						
			int i = 0
			int NumActors = WorkshopActors.length					
			Trace("Unassigning [" + NumActors + "] Settlers...")
			if currentLocation != TheCastleLocation			
				while (i < NumActors)
					WorkshopParent.UnassignActor(WorkshopActors[i] as WorkshopNPCScript)
					i += 1
				endwhile
			else
				ActorBase MinutemenRadioAnnouncer = Game.GetForm(0x000AA78E) as ActorBase
				Actor mma_instance = None
				if MinutemenRadioAnnouncer
					mma_instance = MinutemenRadioAnnouncer.GetUniqueActor()
				endif
				if mma_instance
					Trace("Excluding MinutemenRadioAnnouncer")
					while (i < NumActors)
						if (mma_instance != WorkshopActors[i])
							WorkshopParent.UnassignActor(WorkshopActors[i] as WorkshopNPCScript)
						endif
						i += 1
					endwhile
				
				else
					Trace("Skipping Unassign Settlers. Castle Detected but Radio Announcer could not be found")
				endif				
			endif
		endif
	endif
	
	StartTimer(3.0, 1)
	ScanHelper()
EndFunction

Event OnTimer(int aiTimerID)
	if (0 == aiTimerID)
		Trace("Timer Fired. Calling ScanHelper")
		StartTimer(1.5, 1)
		ScanHelper()
	elseif (1 == aiTimerID)
		int current = pTweakScanThreadsDone.GetValueInt()
		Trace("Progress Fired: current [" + current + "]")
		if (current > 0)
			int remaining = (expected - current)
			pTweakProgress.Show(remaining, expected) 
			StartTimer(3.0, 1)
		endif			
	endif
EndEvent


Function ScanHelper()
	Trace("ScanHelper Called")

	Actor pc = Game.GetPlayer()
	Location playerloc = pc.GetCurrentLocation()
	bool inSettlement = playerloc.HasKeyword(LocTypeWorkshopSettlement)
	
	if (!inSettlement)
		Trace("Not in settlement.")
		pTweakSnapshotNotSettlement.Show()
		pTweakSettlementSnap.SetValue(0.0)
		return		
	endif
	
	WorkshopParentScript WorkshopParent = pWorkshopParent as WorkshopParentScript
	WorkshopScript 		 WorkshopRef    = None
	if WorkshopParent
		WorkshopRef    = WorkshopParent.GetWorkshopFromLocation(playerloc)
	endif
		
	if (!WorkshopRef)
		Trace("Unexpected Error : LocTypeWorkshopSettlement found, but no Workshop")
		return
	endif
	
	ObjectReference center
	float radius
	bool  cleanup_center = false
	
	string wsname
	int    lid = WorkshopRef.GetCurrentLocation().GetFormID()
	int    lookupindex = SettlementLookup.FindStruct("locid",lid)
	
	if (lookupindex > -1)
		Trace("Lookup of [" + lid + "] Succeeded!")
		wsname = SettlementLookup[lookupindex].name
		radius = SettlementLookup[lookupindex].bs_radius
		center = WorkshopRef.PlaceAtMe(Game.GetForm(0x00024571))
		center.SetPosition(SettlementLookup[lookupindex].bs_x, SettlementLookup[lookupindex].bs_y, SettlementLookup[lookupindex].bs_z)
		Utility.wait(0.5)		
		cleanup_center = true
	else
		Trace("Lookup of [" + lid + "] Failed. Using Default.")
		wsname = "Settlement"
		center = WorkshopRef.GetLinkedRef(WorkshopLinkCenter)
		if (!center)
			center = WorkshopRef
		endif
		radius = 8000.0
	endif
	
	Trace("LocationRefID = [" + lid + "] Settlement name [" + wsname + "] radius [" + radius + "]")
	
	float ss_beds    = 0
	float ss_water   = 0
	float ss_safety  = 0
	float ss_power   = 0
	float ss_food    = 0
		
	bool snapshot     = (pTweakSettlementSnap.GetValue() == 1.0)
	if snapshot
		Trace("snapshot is true")
		debug.OpenUserLog(wsname)
		buildoutput.clear()
		buildoutput = new string[1]
		buildindex = 0
		buildcount = 0
		buildtotal = 0
		buildoutput[buildindex] = ""
		requirements = ""
		ss_beds    = WorkshopParent.GetRating(WorkshopRef, WorkshopParent.WorkshopRatingBeds)
		ss_water   = WorkshopParent.GetRating(WorkshopRef, WorkshopParent.WorkshopRatingWater) 
		ss_safety  = WorkshopParent.GetRating(WorkshopRef, WorkshopParent.WorkshopRatingSafety)
		ss_power   = WorkshopParent.GetRating(WorkshopRef, WorkshopParent.WorkshopRatingPower)
		ss_food    = WorkshopParent.GetRating(WorkshopRef, WorkshopParent.WorkshopRatingFood)
	endif
	
	int i = 0
	while i < ResultArray.length
	  ResultArray[i].SetValue(0.0)
	  i += 1
	endWhile
	pTweakScanObjectsFound.SetValue(0.0)
	Trace("Results Reset")

	bool scrapAll = (pTweakScrapAll.GetValue() == 1.0)
	if (scrapAll)
		Trace("scrapAll is true")
	endif
	
	bool unassignsettlers = false
	
	; Calculate Expected....
	expected = 0
	if (pTweakOptionsScanC.GetValue() == 1.0 || snapshot || scrapAll)
		unassignsettlers = true
		AFT:TweakScanCB2NScript  pScanCB2N = (pTweakScanConstructed_BtoN as AFT:TweakScanCB2NScript)
		if pScanCB2N
			expected += 1
		else
			Trace("Cast to AFT:TweakScanCB2NScript Failed")
		endif
		AFT:TweakScanCN2WScript  pScanCN2W = (pTweakScanConstructed_NtoW as AFT:TweakScanCN2WScript)
		if pScanCN2W
			expected += 1
		else
			Trace("Cast to AFT:TweakScanCN2WScript Failed")
		endif
		AFT:TweakScanCW2wScript  pScanCW2w = (pTweakScanConstructed_Wtow as AFT:TweakScanCW2wScript)
		if pScanCW2w
			expected += 1
		else
			Trace("Cast to AFT:TweakScanCW2wScript Failed")
		endif		
        AFT:TweakScanCw2yScript  pScanCw2y = (pTweakScanConstructedwtoy  as AFT:TweakScanCw2yScript)
		if pScanCw2y
			expected += 1
		else
			Trace("Cast to AFT:TweakScanCw2yScript Failed")
		endif
		AFT:TweakScanCContScript pScanCont = (pTweakScanConstructed_Cont as AFT:TweakScanCContScript)		
		if pScanCont
			expected += 1
		else
			Trace("Cast to AFT:TweakScanCContScript Failed")
		endif
		AFT:TweakScanCTurretsScript pTurrets = (pTweakScanConstructed_Turrets as AFT:TweakScanCTurretsScript)
		if pTurrets
			expected += 1
		else
			Trace("Cast to AFT:TweakScanCTurretsScript Failed")
		endif
		AFT:TweakScanCFencesScript pFences = (pTweakScanConstructed_Fences as AFT:TweakScanCFencesScript)
		if pFences
			expected += 1	
		else
			Trace("Cast to AFT:TweakScanCFencesScript Failed")
		endif
		AFT:TweakScanCWallsScript pWalls = (pTweakScanConstructed_Walls as AFT:TweakScanCWallsScript)
		if pWalls
			expected += 1
		else
			Trace("Cast to AFT:TweakScanCWallsScript Failed")
		endif
		AFT:TweakScanCFloorsScript pFloors = (pTweakScanConstructed_Floors as AFT:TweakScanCFloorsScript)
		if pFloors
			expected += 1	
		else
			Trace("Cast to AFT:TweakScanCFloorsScript Failed")
		endif
		AFT:TweakScanCBenchesScript pBenches = (pTweakScanConstructed_Benches as AFT:TweakScanCBenchesScript)
		if pBenches
			expected += 1
		else
			Trace("Cast to AFT:TweakScanCBenchesScript Failed")
		endif
		AFT:TweakScanCShopsScript pShops = (pTweakScanConstructed_Shops as AFT:TweakScanCShopsScript)
		if pShops
			unassignsettlers = true
			expected += 1	
		else
			Trace("Cast to AFT:TweakScanCShopsScript Failed")
		endif
		AFT:TweakScanCFoodScript pCFood = (pTweakScanConstructed_Food as AFT:TweakScanCFoodScript)
		if pCFood
			unassignsettlers = true
			expected += 1	
		else
			Trace("Cast to AFT:TweakScanCFoodScript Failed")
		endif
	else
		if (pTweakOptionsScanC_ExTurrets.GetValue() == 0.0)
			AFT:TweakScanCTurretsScript pTurrets = (pTweakScanConstructed_Turrets as AFT:TweakScanCTurretsScript)
			if pTurrets
				expected += 1
			else
				Trace("Cast to AFT:TweakScanCTurretsScript Failed")
			endif
		endif
		if (pTweakOptionsScanC_ExFences.GetValue() == 0.0)
			AFT:TweakScanCFencesScript pFences = (pTweakScanConstructed_Fences as AFT:TweakScanCFencesScript)
			if pFences
				expected += 1	
			else
				Trace("Cast to AFT:TweakScanCFencesScript Failed")
			endif
		endif
		if (pTweakOptionsScanC_ExWalls.GetValue() == 0.0)
			AFT:TweakScanCWallsScript pWalls = (pTweakScanConstructed_Walls as AFT:TweakScanCWallsScript)
			if pWalls
				expected += 1
			else
				Trace("Cast to AFT:TweakScanCWallsScript Failed")
			endif
		endif
		if (pTweakOptionsScanC_ExFloors.GetValue() == 0.0)
			AFT:TweakScanCFloorsScript pFloors = (pTweakScanConstructed_Floors as AFT:TweakScanCFloorsScript)
			if pFloors
				expected += 1	
			else
				Trace("Cast to AFT:TweakScanCFloorsScript Failed")
			endif
		endif		
		if (pTweakOptionsScanC_ExBenches.GetValue() == 0.0)
			AFT:TweakScanCBenchesScript pBenches = (pTweakScanConstructed_Benches as AFT:TweakScanCBenchesScript)
			if pBenches
				unassignsettlers = true
				expected += 1
			else
				Trace("Cast to AFT:TweakScanCBenchesScript Failed")
			endif
		endif
		if (pTweakOptionsScanC_ExShops.GetValue() == 0.0)
			AFT:TweakScanCShopsScript pShops = (pTweakScanConstructed_Shops as AFT:TweakScanCShopsScript)
			if pShops
				unassignsettlers = true
				expected += 1	
			else
				Trace("Cast to AFT:TweakScanCShopsScript Failed")
			endif
		endif
		if (pTweakOptionsScanC_ExCont.GetValue() == 0.0)
			AFT:TweakScanCContScript pScanCont = (pTweakScanConstructed_Cont as AFT:TweakScanCContScript)		
			if pScanCont
				unassignsettlers = true
				expected += 1
			else
				Trace("Cast to AFT:TweakScanCContScript Failed")
			endif
		endif
		if (pTweakOptionsScanC_ExFood.GetValue() == 0.0)
			AFT:TweakScanCFoodScript pCFood = (pTweakScanConstructed_Food as AFT:TweakScanCFoodScript)
			if pCFood
				unassignsettlers = true
				expected += 1	
			else
				Trace("Cast to AFT:TweakScanCFoodScript Failed")
			endif
		endif
		if (pTweakOptionsScanC_IncTheRest.GetValue() == 1.0)
			AFT:TweakScanCB2NScript  pScanCB2N = (pTweakScanConstructed_BtoN as AFT:TweakScanCB2NScript)
			if pScanCB2N
				unassignsettlers = true
				expected += 1
			else
				Trace("Cast to AFT:TweakScanCB2NScript Failed")
			endif
			AFT:TweakScanCN2WScript  pScanCN2W = (pTweakScanConstructed_NtoW as AFT:TweakScanCN2WScript)
			if pScanCN2W
				unassignsettlers = true
				expected += 1
			else
				Trace("Cast to AFT:TweakScanCN2WScript Failed")
			endif
			AFT:TweakScanCW2wScript  pScanCW2w = (pTweakScanConstructed_Wtow as AFT:TweakScanCW2wScript)
			if pScanCW2w
				unassignsettlers = true
				expected += 1
			else
				Trace("Cast to AFT:TweakScanCW2wScript Failed")
			endif		
			AFT:TweakScanCw2yScript  pScanCw2y = (pTweakScanConstructedwtoy  as AFT:TweakScanCw2yScript)
			if pScanCw2y
				unassignsettlers = true
				expected += 1
			else
				Trace("Cast to AFT:TweakScanCw2yScript Failed")
			endif		
		endif

	endif
	if (pTweakOptionsScanNC.GetValue() == 1.0 || snapshot || scrapAll)
		AFT:TweakScanNCBtoCScript pScanNCB2C  = (pTweakScanNonConstructed_BtoC as AFT:TweakScanNCBtoCScript)
		if pScanNCB2C
			expected += 1
		else
			Trace("Cast to AFT:TweakScanNCBtoCScript Failed")
		endif
		AFT:TweakScanNCCtoFScript pScanNCC2F  = (pTweakScanNonConstructed_CtoF as AFT:TweakScanNCCtoFScript)
		if pScanNCC2F
			expected += 1
		else
			Trace("Cast to AFT:TweakScanNCCtoFScript Failed")
		endif
		AFT:TweakScanNCFtoOScript pScanNCF2O  = (pTweakScanNonConstructed_FtoO as AFT:TweakScanNCFtoOScript)
		if pScanNCF2O
			expected += 1
		else
			Trace("Cast to AFT:TweakScanNCFtoOScript Failed")
		endif
		AFT:TweakScanNCOtoPScript pScanNCO2P  = (pTweakScanNonConstructed_OtoP as AFT:TweakScanNCOtoPScript)
		if pScanNCO2P
			expected += 1
		else
			Trace("Cast to AFT:TweakScanNCOtoPScript Failed")
		endif
		AFT:TweakScanNCPtoSScript pScanNCP2S  = (pTweakScanNonConstructed_PtoS as AFT:TweakScanNCPtoSScript)
		if pScanNCP2S
			expected += 1
		else
			Trace("Cast to AFT:TweakScanNCPtoSScript Failed")
		endif
		AFT:TweakScanNCStoSScript pScanNCS2S  = (pTweakScanNonConstructed_StoS as AFT:TweakScanNCStoSScript)
		if pScanNCS2S
			expected += 1
		else
			Trace("Cast to AFT:TweakScanNCStoSScript Failed")
		endif
		AFT:TweakScanNCStoTScript pScanNCS2T  = (pTweakScanNonConstructed_StoT as AFT:TweakScanNCStoTScript)
		if pScanNCS2T
			expected += 1
		else
			Trace("Cast to AFT:TweakScanNCStoTScript Failed")
		endif
		AFT:TweakScanNCTtoVScript pScanNCT2V  = (pTweakScanNonConstructed_TtoV as AFT:TweakScanNCTtoVScript)
		if pScanNCT2V
			expected += 1
		else
			Trace("Cast to AFT:TweakScanNCTtoVScript Failed")
		endif
		AFT:TweakScanNCVtowScript pScanNCV2w  = (pTweakScanNonConstructed_Vtow as AFT:TweakScanNCVtowScript)
		if pScanNCV2w
			expected += 1
		else
			Trace("Cast to AFT:TweakScanNCVtowScript Failed")
		endif
		
		AFT:TweakScanNCContScript pScanNCCont = (pTweakScanNonConstructed_Cont as AFT:TweakScanNCContScript)
		if pScanNCCont
			expected += 1
		else
			Trace("Cast to AFT:TweakScanNCContScript Failed")
		endif
		AFT:TweakScanNCTreesScript pScanTrees = (pTweakScanNonConstructed_Trees as AFT:TweakScanNCTreesScript)
		if pScanTrees
			expected += 1	
		else
			Trace("Cast to AFT:TweakScanNCTreesScript Failed")
		endif
		AFT:TweakScanNCFoodScript pScanFood = (pTweakScanNonConstructed_Food as AFT:TweakScanNCFoodScript)
		if pScanFood
			unassignsettlers = true
			expected += 1	
		else
			Trace("Cast to AFT:TweakScanNCFoodScript Failed")
		endif
		AFT:TweakScanNCExtraScript pScanExtra = (pTweakScanNonConstructed_Extra as AFT:TweakScanNCExtraScript)
		if pScanExtra
			expected += 1
		else
			Trace("Cast to AFT:TweakScanNCExtraScript Failed")
		endif
	else
		if (pTweakOptionsScanNC_ExCont.GetValue() == 0.0)
			AFT:TweakScanNCContScript pScanNCCont = (pTweakScanNonConstructed_Cont as AFT:TweakScanNCContScript)
			if pScanNCCont
				expected += 1
			else
				Trace("Cast to AFT:TweakScanNCContScript Failed")
			endif
		endif
		if (pTweakOptionsScanNC_ExLiving.GetValue() == 0.0)
			AFT:TweakScanNCTreesScript pScanTrees = (pTweakScanNonConstructed_Trees as AFT:TweakScanNCTreesScript)
			if pScanTrees
				expected += 1	
			else
				Trace("Cast to AFT:TweakScanNCTreesScript Failed")
			endif
		endif
		if (pTweakOptionsScanNC_ExFood.GetValue() == 0.0)
			AFT:TweakScanNCFoodScript pScanFood = (pTweakScanNonConstructed_Food as AFT:TweakScanNCFoodScript)
			if pScanFood
				unassignsettlers = true
				expected += 1	
			else
				Trace("Cast to AFT:TweakScanNCFoodScript Failed")
			endif
		endif
		if (pTweakOptionsScanNC_ExMisc.GetValue() == 0.0)
			AFT:TweakScanNCExtraScript pScanExtra = (pTweakScanNonConstructed_Extra as AFT:TweakScanNCExtraScript)
			if pScanExtra
				expected += 1	
			else
				Trace("Cast to AFT:TweakScanNCExtraScript Failed")
			endif
		endif
		if (pTweakOptionsScanNC_IncTheRest.GetValue() == 1.0)
			AFT:TweakScanNCBtoCScript pScanNCB2C  = (pTweakScanNonConstructed_BtoC as AFT:TweakScanNCBtoCScript)
			if pScanNCB2C
				expected += 1
			else
				Trace("Cast to AFT:TweakScanNCBtoCScript Failed")
			endif
			AFT:TweakScanNCCtoFScript pScanNCC2F  = (pTweakScanNonConstructed_CtoF as AFT:TweakScanNCCtoFScript)
			if pScanNCC2F
				expected += 1
			else
				Trace("Cast to AFT:TweakScanNCCtoFScript Failed")
			endif
			AFT:TweakScanNCFtoOScript pScanNCF2O  = (pTweakScanNonConstructed_FtoO as AFT:TweakScanNCFtoOScript)
			if pScanNCF2O
				expected += 1
			else
				Trace("Cast to AFT:TweakScanNCFtoOScript Failed")
			endif
			AFT:TweakScanNCOtoPScript pScanNCO2P  = (pTweakScanNonConstructed_OtoP as AFT:TweakScanNCOtoPScript)
			if pScanNCO2P
				expected += 1
			else
				Trace("Cast to AFT:TweakScanNCOtoPScript Failed")
			endif
			AFT:TweakScanNCPtoSScript pScanNCP2S  = (pTweakScanNonConstructed_PtoS as AFT:TweakScanNCPtoSScript)
			if pScanNCP2S
				expected += 1
			else
				Trace("Cast to AFT:TweakScanNCPtoSScript Failed")
			endif
			AFT:TweakScanNCStoSScript pScanNCS2S  = (pTweakScanNonConstructed_StoS as AFT:TweakScanNCStoSScript)
			if pScanNCS2S
				expected += 1
			else
				Trace("Cast to AFT:TweakScanNCStoSScript Failed")
			endif
			AFT:TweakScanNCStoTScript pScanNCS2T  = (pTweakScanNonConstructed_StoT as AFT:TweakScanNCStoTScript)
			if pScanNCS2T
				expected += 1
			else
				Trace("Cast to AFT:TweakScanNCStoTScript Failed")
			endif
			AFT:TweakScanNCTtoVScript pScanNCT2V  = (pTweakScanNonConstructed_TtoV as AFT:TweakScanNCTtoVScript)
			if pScanNCT2V
				expected += 1
			else
				Trace("Cast to AFT:TweakScanNCTtoVScript Failed")
			endif
			AFT:TweakScanNCVtowScript pScanNCV2w  = (pTweakScanNonConstructed_Vtow as AFT:TweakScanNCVtowScript)
			if pScanNCV2w
				expected += 1
			else
				Trace("Cast to AFT:TweakScanNCVtowScript Failed")
			endif
		endif	
	endif		
		
	if (unassignsettlers && !scrapAll && !snapshot)
		ObjectReference[] WorkshopActors = WorkshopParent.GetWorkshopActors(workshopRef)						
		int wa = 0
		int NumActors = WorkshopActors.length				
		Trace("Unassigning [" + NumActors + "] Settlers...")
		
		if playerloc != TheCastleLocation			
			while (wa < NumActors)
				WorkshopParent.UnassignActor(WorkshopActors[wa] as WorkshopNPCScript)
				wa += 1
			endwhile
		else
			ActorBase MinutemenRadioAnnouncer = Game.GetForm(0x000AA78E) as ActorBase
			Actor mma_instance = None
			if MinutemenRadioAnnouncer
				mma_instance = MinutemenRadioAnnouncer.GetUniqueActor()
			endif
			if mma_instance
				Trace("Excluding MinutemenRadioAnnouncer")
				while (wa < NumActors)
					if (mma_instance != WorkshopActors[wa])
						WorkshopParent.UnassignActor(WorkshopActors[wa] as WorkshopNPCScript)
					endif
					wa += 1
				endwhile
			else
				Trace("Skipping Unassign Settlers. Castle Detected but Radio Announcer could not be found")
			endif				
		endif		
	endif

	Trace("expected [" + expected + "]")
	; Enable Threads (Non-Zero Value)
	pTweakScanThreadsDone.SetValue(expected)
	
	; Kick off Constructed threads...
	if (pTweakOptionsScanC.GetValue() == 1.0 || snapshot || scrapAll)
		
		; Give Walls and Floors a head start....
		AFT:TweakScanCWallsScript pWalls = (pTweakScanConstructed_Walls as AFT:TweakScanCWallsScript)
		if pWalls
			Trace("Calling pWalls.Scan()")
			pWalls.Scan(center, radius) ; Asynchronous
			if snapshot
				Utility.wait(1.0)
			endif
		endif

		AFT:TweakScanCFloorsScript pFloors = (pTweakScanConstructed_Floors as AFT:TweakScanCFloorsScript)
		if pFloors
			Trace("Calling pFloors.Scan()")
			pFloors.Scan(center, radius) ; Asynchronous
			if snapshot
				Utility.wait(1.0)
			endif
		endif
				
		AFT:TweakScanCB2NScript     pScanCB2N = (pTweakScanConstructed_BtoN    as AFT:TweakScanCB2NScript)
		AFT:TweakScanCN2WScript     pScanCN2W = (pTweakScanConstructed_NtoW    as AFT:TweakScanCN2WScript)
		AFT:TweakScanCW2wScript     pScanCW2w = (pTweakScanConstructed_Wtow    as AFT:TweakScanCW2wScript)
        AFT:TweakScanCw2yScript     pScanCw2y = (pTweakScanConstructedwtoy     as AFT:TweakScanCw2yScript)
		AFT:TweakScanCTurretsScript pTurrets  = (pTweakScanConstructed_Turrets as AFT:TweakScanCTurretsScript)
		AFT:TweakScanCFencesScript  pFences   = (pTweakScanConstructed_Fences  as AFT:TweakScanCFencesScript)
		AFT:TweakScanCBenchesScript pBenches  = (pTweakScanConstructed_Benches as AFT:TweakScanCBenchesScript)
		AFT:TweakScanCShopsScript   pShops    = (pTweakScanConstructed_Shops   as AFT:TweakScanCShopsScript)
		AFT:TweakScanCContScript    pScanCont = (pTweakScanConstructed_Cont    as AFT:TweakScanCContScript)
		AFT:TweakScanCFoodScript    pCFood    = (pTweakScanConstructed_Food    as AFT:TweakScanCFoodScript)
		
		if pScanCB2N
			Trace("Calling pScanCB2N.Scan()")
			pScanCB2N.Scan(center, radius) ; Asynchronous
		endif
		if pScanCN2W
			Trace("Calling pScanCN2W.Scan()")
			pScanCN2W.Scan(center, radius) ; Asynchronous
		endif
		if pScanCW2w
			Trace("Callingp pScanCW2w.Scan()")
			pScanCW2w.Scan(center, radius) ; Asynchronous
		endif
		if pScanCw2y
			Trace("Callingp pScanCw2y.Scan()")
			pScanCw2y.Scan(center, radius) ; Asynchronous
		endif
		if pTurrets
			Trace("Calling pTurrets.Scan()")
			pTurrets.Scan(center, radius) ; Asynchronous
		endif
		if pFences
			Trace("Calling pFences.Scan()")
			pFences.Scan(center, radius) ; Asynchronous
		endif
		if pBenches
			Trace("Calling pBenches.Scan()")
			pBenches.Scan(center, radius) ; Asynchronous
		endif
		if pShops
			Trace("Calling pShops.Scan()")
			pShops.Scan(center, radius) ; Asynchronous
		endif
		if pScanCont
			Trace("Calling pScanCont.Scan()")
			pScanCont.Scan(center, radius) ; Asynchronous
		endif
		if pCFood
			Trace("Calling pCFood.Scan()")
			pCFood.Scan(center, radius) ; Asynchronous
		endif		
	else
		
		; Give Walls and Floors a head start....
		if (pTweakOptionsScanC_ExWalls.GetValue() == 0.0)
			AFT:TweakScanCWallsScript pWalls = (pTweakScanConstructed_Walls as AFT:TweakScanCWallsScript)
			if pWalls
				Trace("Calling pWalls.Scan()")
				pWalls.Scan(center, radius) ; Asynchronous
				if snapshot
					Utility.wait(1.0)
				endif
			endif
		endif

		if (pTweakOptionsScanC_ExFloors.GetValue() == 0.0)
			AFT:TweakScanCFloorsScript pFloors = (pTweakScanConstructed_Floors as AFT:TweakScanCFloorsScript)
			if pFloors
				Trace("Calling pFloors.Scan()")
				pFloors.Scan(center, radius) ; Asynchronous
				if snapshot
					Utility.wait(1.0)
				endif
			endif
		endif				
		
		if (pTweakOptionsScanC_ExTurrets.GetValue() == 0.0)
			AFT:TweakScanCTurretsScript pTurrets = (pTweakScanConstructed_Turrets as AFT:TweakScanCTurretsScript)
			if pTurrets
				Trace("Calling pTurrets.Scan()")
				pTurrets.Scan(center, radius) ; Asynchronous
			endif
		endif
	
		if (pTweakOptionsScanC_ExFences.GetValue() == 0.0)
			AFT:TweakScanCFencesScript pFences = (pTweakScanConstructed_Fences as AFT:TweakScanCFencesScript)
			if pFences
				Trace("Calling pFences.Scan()")
				pFences.Scan(center, radius) ; Asynchronous
			endif
		endif
		
		if (pTweakOptionsScanC_ExBenches.GetValue() == 0.0)
			AFT:TweakScanCBenchesScript pBenches = (pTweakScanConstructed_Benches as AFT:TweakScanCBenchesScript)
			if pBenches
				Trace("Calling pBenches.Scan()")
				pBenches.Scan(center, radius) ; Asynchronous
			endif
		endif		

		if (pTweakOptionsScanC_ExShops.GetValue() == 0.0)
			AFT:TweakScanCShopsScript pShops = (pTweakScanConstructed_Shops as AFT:TweakScanCShopsScript)
			if pShops
				Trace("Calling pShops.Scan()")
				pShops.Scan(center, radius) ; Asynchronous
			endif
		endif		
		if (pTweakOptionsScanC_ExCont.GetValue() == 0.0)
			AFT:TweakScanCContScript pScanCont = (pTweakScanConstructed_Cont as AFT:TweakScanCContScript)		
			if pScanCont
				Trace("Calling pScanCont.Scan()")
				pScanCont.Scan(center, radius) ; Asynchronous
			else
				Trace("Cast to AFT:TweakScanCContScript Failed")
			endif
		endif
		if (pTweakOptionsScanC_ExFood.GetValue() == 0.0)
			AFT:TweakScanCFoodScript pCFood = (pTweakScanConstructed_Food as AFT:TweakScanCFoodScript)
			if pCFood
				Trace("Calling pCFood.Scan()")
				pCFood.Scan(center, radius) ; Asynchronous
			else
				Trace("Cast to AFT:TweakScanCFoodScript Failed")
			endif
		endif
		if (pTweakOptionsScanC_IncTheRest.GetValue() == 1.0)		
				
			AFT:TweakScanCB2NScript  pScanCB2N = (pTweakScanConstructed_BtoN as AFT:TweakScanCB2NScript)
			AFT:TweakScanCN2WScript  pScanCN2W = (pTweakScanConstructed_NtoW as AFT:TweakScanCN2WScript)
			AFT:TweakScanCW2wScript  pScanCW2w = (pTweakScanConstructed_Wtow as AFT:TweakScanCW2wScript)
			AFT:TweakScanCw2yScript  pScanCw2y = (pTweakScanConstructedwtoy  as AFT:TweakScanCw2yScript)
			
			if pScanCB2N
				Trace("Calling pScanCB2N.Scan()")
				pScanCB2N.Scan(center, radius) ; Asynchronous
			endif
			if pScanCN2W
				Trace("Calling pScanCN2W.Scan()")
				pScanCN2W.Scan(center, radius) ; Asynchronous
			endif
			if pScanCW2w
				Trace("Callingp pScanCW2w.Scan()")
				pScanCW2w.Scan(center, radius) ; Asynchronous
			endif
			if pScanCw2y
				Trace("Callingp pScanCw2y.Scan()")
				pScanCw2y.Scan(center, radius) ; Asynchronous
			endif
		endif		
	endif

	if (pTweakOptionsScanNC.GetValue() == 1.0 || snapshot || scrapAll)
	
		AFT:TweakScanNCBtoCScript  pScanNCB2C  = (pTweakScanNonConstructed_BtoC  as AFT:TweakScanNCBtoCScript)
		AFT:TweakScanNCCtoFScript  pScanNCC2F  = (pTweakScanNonConstructed_CtoF  as AFT:TweakScanNCCtoFScript)
		AFT:TweakScanNCFtoOScript  pScanNCF2O  = (pTweakScanNonConstructed_FtoO  as AFT:TweakScanNCFtoOScript)
		AFT:TweakScanNCOtoPScript  pScanNCO2P  = (pTweakScanNonConstructed_OtoP  as AFT:TweakScanNCOtoPScript)
		AFT:TweakScanNCPtoSScript  pScanNCP2S  = (pTweakScanNonConstructed_PtoS  as AFT:TweakScanNCPtoSScript)
		AFT:TweakScanNCStoSScript  pScanNCS2S  = (pTweakScanNonConstructed_StoS  as AFT:TweakScanNCStoSScript)
		AFT:TweakScanNCStoTScript  pScanNCS2T  = (pTweakScanNonConstructed_StoT  as AFT:TweakScanNCStoTScript)
		AFT:TweakScanNCTtoVScript  pScanNCT2V  = (pTweakScanNonConstructed_TtoV  as AFT:TweakScanNCTtoVScript)
		AFT:TweakScanNCVtowScript  pScanNCV2w  = (pTweakScanNonConstructed_Vtow  as AFT:TweakScanNCVtowScript)
		AFT:TweakScanNCTreesScript pScanTrees  = (pTweakScanNonConstructed_Trees as AFT:TweakScanNCTreesScript)
		AFT:TweakScanNCFoodScript  pScanFood   = (pTweakScanNonConstructed_Food  as AFT:TweakScanNCFoodScript)
		AFT:TweakScanNCContScript  pScanNCCont = (pTweakScanNonConstructed_Cont  as AFT:TweakScanNCContScript)
		AFT:TweakScanNCExtraScript pScanExtra  = (pTweakScanNonConstructed_Extra as AFT:TweakScanNCExtraScript)
						
		if pScanNCB2C
			Trace("Calling pScanNCB2C.Scan()")
			pScanNCB2C.Scan(center, radius) ; Asynchronous
		endif
		if pScanNCC2F
			Trace("Calling pScanNCC2F.Scan()")
			pScanNCC2F.Scan(center, radius) ; Asynchronous
		endif
		if pScanNCF2O
			Trace("Calling pScanNCF2O.Scan()")
			pScanNCF2O.Scan(center, radius) ; Asynchronous
		endif
		
		if pScanNCO2P
			Trace("Calling pScanNCO2P.Scan()")
			pScanNCO2P.Scan(center, radius) ; Asynchronous
		endif
		
		if pScanNCP2S
			Trace("Calling pScanNCP2S.Scan()")
			pScanNCP2S.Scan(center, radius) ; Asynchronous
		endif
		if pScanNCS2S
			Trace("Calling pScanNCS2S.Scan()")
			pScanNCS2S.Scan(center, radius) ; Asynchronous
		endif
		if pScanNCS2T
			Trace("Calling pScanNCS2T.Scan()")
			pScanNCS2T.Scan(center, radius) ; Asynchronous
		endif
		if pScanNCT2V
			Trace("Calling pScanNCT2V.Scan()")
			pScanNCT2V.Scan(center, radius) ; Asynchronous
		endif
		if pScanNCV2w
			Trace("Calling pScanNCV2w.Scan()")
			pScanNCV2w.Scan(center, radius) ; Asynchronous
		endif
		if pScanNCCont
			Trace("Calling pScanNCCont.Scan()")
			pScanNCCont.Scan(center, radius) ; Asynchronous
		endif
		if pScanTrees
			Trace("Calling pScanTrees.Scan()")
			pScanTrees.Scan(center, radius) ; Asynchronous
		endif
		if pScanFood
			Trace("Calling pScanFood.Scan()")
			pScanFood.Scan(center, radius) ; Asynchronous			
		else
			Trace("Cast to AFT:TweakScanNCFoodScript Failed")
		endif
		if pScanExtra
			Trace("Calling pScanExtra.Scan()")
			pScanExtra.Scan(center, radius) ; Asynchronous
		else
			Trace("Cast to AFT:TweakScanNCExtraScript Failed")
		endif
	else
	
		if (pTweakOptionsScanNC_ExCont.GetValue() == 0.0)
			AFT:TweakScanNCContScript pScanNCCont = (pTweakScanNonConstructed_Cont as AFT:TweakScanNCContScript)
			if pScanNCCont
				Trace("Calling pScanNCCont.Scan()")
				pScanNCCont.Scan(center, radius) ; Asynchronous
			else
				Trace("Cast to AFT:TweakScanNCContScript Failed")
			endif
		endif
		if (pTweakOptionsScanNC_ExLiving.GetValue() == 0.0)
			AFT:TweakScanNCTreesScript pScanTrees = (pTweakScanNonConstructed_Trees as AFT:TweakScanNCTreesScript)
			if pScanTrees
				Trace("Calling pScanTrees.Scan()")
				pScanTrees.Scan(center, radius) ; Asynchronous
			else
				Trace("Cast to AFT:TweakScanNCTreesScript Failed")
			endif
		endif
		if (pTweakOptionsScanNC_ExFood.GetValue() == 0.0)
			AFT:TweakScanNCFoodScript pScanFood = (pTweakScanNonConstructed_Food as AFT:TweakScanNCFoodScript)
			if pScanFood
				Trace("Calling pScanFood.Scan()")
				pScanFood.Scan(center, radius) ; Asynchronous			
			else
				Trace("Cast to AFT:TweakScanNCFoodScript Failed")
			endif
		endif
		if (pTweakOptionsScanNC_ExMisc.GetValue() == 0.0)
			AFT:TweakScanNCExtraScript pScanExtra = (pTweakScanNonConstructed_Extra as AFT:TweakScanNCExtraScript)
			if pScanExtra
				Trace("Calling pScanExtra.Scan()")
				pScanExtra.Scan(center, radius) ; Asynchronous
			else
				Trace("Cast to AFT:TweakScanNCExtraScript Failed")
			endif
		endif
		if (pTweakOptionsScanNC_IncTheRest.GetValue() == 1.0)
		
			AFT:TweakScanNCBtoCScript  pScanNCB2C  = (pTweakScanNonConstructed_BtoC  as AFT:TweakScanNCBtoCScript)
			AFT:TweakScanNCCtoFScript  pScanNCC2F  = (pTweakScanNonConstructed_CtoF  as AFT:TweakScanNCCtoFScript)
			AFT:TweakScanNCFtoOScript  pScanNCF2O  = (pTweakScanNonConstructed_FtoO  as AFT:TweakScanNCFtoOScript)
			AFT:TweakScanNCOtoPScript  pScanNCO2P  = (pTweakScanNonConstructed_OtoP  as AFT:TweakScanNCOtoPScript)
			AFT:TweakScanNCPtoSScript  pScanNCP2S  = (pTweakScanNonConstructed_PtoS  as AFT:TweakScanNCPtoSScript)
			AFT:TweakScanNCStoSScript  pScanNCS2S  = (pTweakScanNonConstructed_StoS  as AFT:TweakScanNCStoSScript)
			AFT:TweakScanNCStoTScript  pScanNCS2T  = (pTweakScanNonConstructed_StoT  as AFT:TweakScanNCStoTScript)
			AFT:TweakScanNCTtoVScript  pScanNCT2V  = (pTweakScanNonConstructed_TtoV  as AFT:TweakScanNCTtoVScript)
			AFT:TweakScanNCVtowScript  pScanNCV2w  = (pTweakScanNonConstructed_Vtow  as AFT:TweakScanNCVtowScript)
			
			if pScanNCB2C
				Trace("Calling pScanNCB2C.Scan()")
				pScanNCB2C.Scan(center, radius) ; Asynchronous
			endif
			if pScanNCC2F
				Trace("Calling pScanNCC2F.Scan()")
				pScanNCC2F.Scan(center, radius) ; Asynchronous
			endif
			if pScanNCF2O
				Trace("Calling pScanNCF2O.Scan()")
				pScanNCF2O.Scan(center, radius) ; Asynchronous
			endif
			if pScanNCO2P
				Trace("Calling pScanNCO2P.Scan()")
				pScanNCO2P.Scan(center, radius) ; Asynchronous
			endif
			if pScanNCP2S
				Trace("Calling pScanNCP2S.Scan()")
				pScanNCP2S.Scan(center, radius) ; Asynchronous
			endif
			if pScanNCS2S
				Trace("Calling pScanNCS2S.Scan()")
				pScanNCS2S.Scan(center, radius) ; Asynchronous
			endif
			if pScanNCS2T
				Trace("Calling pScanNCS2T.Scan()")
				pScanNCS2T.Scan(center, radius) ; Asynchronous
			endif
			if pScanNCT2V
				Trace("Calling pScanNCT2V.Scan()")
				pScanNCT2V.Scan(center, radius) ; Asynchronous
			endif
			if pScanNCV2w
				Trace("Calling pScanNCV2w.Scan()")
				pScanNCV2w.Scan(center, radius) ; Asynchronous
			endif
		endif
	endif

	
    int timeout
	if snapshot || scrapAll
		timeout = 300
	else
		timeout = 60
	endif
	
    while (timeout > 0)
		int done = pTweakScanThreadsDone.GetValueInt()
		Trace("[" + done + "] of [" + expected + "] threads still running")
        if (0 ==  done)
            timeout = -1
        Else
            timeout -= 1
            Utility.Wait(1.0)
        EndIf
    endWhile

	pTweakScanThreadsDone.SetValue(0)
	
	if (0 == timeout)
		Trace("Scan Finished (max time reached)")
        Utility.Wait(1.1)		
	else
		Trace("Scan Finished")
	endif
	
	int totalscrap  = 0
	
	; TODO : Since we have all the values, we will probably want to popup a message with whatever we have...
	if (!scrapAll)
		i = 0
		int scrapamount = 0
	
		while (i < 31)
			scrapamount = ResultArray[i].GetValueInt()
			if scrapamount != 0
				totalscrap += scrapamount
				if snapshot
					int base = pTweakScrapComponents.GetAt(i).GetFormID()
					requirements += "\t; requires [" + scrapamount + "] of [" + tohex(base) +"] (" + base + ")\n"
				else
					Trace("Giving [" + scrapamount + "] of Component [" + i + "]")
					ScrapReceiver.AddItem(pTweakScrapComponents.GetAt(i), scrapamount)
				endif
			endif
			i += 1
		endwhile
	endif
	
	ScrapReceiver = None
	
	if cleanup_center
		center.disable()
		center.delete()
	endif
	
	int totalobjectsfound = pTweakScanObjectsFound.GetValueInt()
	if snapshot		
		if (totalobjectsfound != buildtotal )
			Trace("WARNING: Checksum error [" + totalobjectsfound + "] != [" + buildtotal + "]")
			debug.TraceUser(wsname, "; WARNING: Checksum error [" + totalobjectsfound + "] != [" + buildtotal + "]\n", 0)
		endif
		string code = ""
		if (0 == buildType) ; Batch
			code += "=== BEGIN BATCH === \n"
			code += requirements
			requirements = ""
			code += "player.APS TweakBuilderScript\n"
			code += "player.cf \"TweakBuilderScript.init\" " + lid + " 0\n"
			code += "player.cf \"TweakBuilderScript.buildstart\" " + totalobjectsfound + "\n"
			code += buildoutput[0]
			buildoutput[0]  = ""
			if (buildindex > 0)
				int bi = 0
				while bi < buildindex
					bi += 1
					debug.TraceUser(wsname, code, 0)	
					code  = "; buildpart " + bi + "\n"
					code += buildoutput[bi]
					buildoutput[bi] = ""
				endwhile
			endif
			debug.TraceUser(wsname, code, 0)
			debug.TraceUser(wsname, "=== END SCRIPT ===", 0)
			code = ""
		else
			code += "=== BEGIN SCRIPT === \n"
			code += "Function BuildFull(TweakBuilderScript tbs, int clearFirst = 1, int requireNoFood = 1)\n"
			code += requirements
			requirements = ""
			code += "\tif !tbs\n"
			code += "\t\treturn\n"
			code += "\tendif\n"
			code += "\ttbs.init(" + lid + ", requireNoFood) ; " + wsname + "\n"
			code += "\tif 0 != clearFirst\n"
			code += "\t\ttbs.clearsettlement(" + lid + ")\n"
			code += "\tendif\n"
			code += "\ttbs.buildstart(" + totalobjectsfound + ")\n"
			code += buildoutput[0]
			buildoutput[0]  = ""
			if (buildindex > 0)
				int bi = 0
				while bi < buildindex
					bi += 1
					code  += "\tbuildpart" + bi + "(tbs)\nEndFunction\n\n"
					debug.TraceUser(wsname, code, 0)	
					code  = "\nFunction buildpart" + bi + "(TweakBuilderScript tbs)\n"
					code += buildoutput[bi]
					buildoutput[bi] = ""
				endwhile
			endif
			code  += "EndFunction\n"
			debug.TraceUser(wsname, code, 0)
			debug.TraceUser(wsname, "=== END SCRIPT ===", 0)
			code = ""
		endif
				
	elseif !scrapAll && (0 != totalobjectsfound) && (inSettlement)
		; Update Workshop limits...
		int currentTriangles = WorkshopRef.GetValue(WorkshopParent.WorkshopCurrentTriangles) as Int
		int currentDraws = WorkshopRef.GetValue(WorkshopParent.WorkshopCurrentDraws) as Int
		if currentTriangles < WorkshopRef.CurrentTriangles
			currentTriangles = WorkshopRef.CurrentTriangles
		endif
		if currentDraws < WorkshopRef.CurrentDraws
			currentDraws = WorkshopRef.CurrentDraws
		endif
		Trace("Workshop Before : Trangles [" + currentTriangles + "] Draws [" + currentDraws + "]")

		currentTriangles = currentTriangles - (totalobjectsfound * 2000)
		if (currentTriangles < 0)
			currentTriangles = 0
		endif
		WorkshopRef.CurrentTriangles=currentTriangles
		WorkshopRef.SetValue(WorkshopParent.WorkshopCurrentTriangles, currentTriangles)				
		currentDraws = currentDraws - (2 * totalobjectsfound)
		if (currentDraws < 0)
			currentDraws = 0
		endif
		WorkshopRef.currentDraws=currentDraws
		WorkshopRef.SetValue(WorkshopParent.WorkshopCurrentDraws, currentDraws)
		Trace("Workshop After : Trangles [" + currentTriangles + "] Draws [" + currentDraws + "]")
	endif
	
	if (-1 == timeout)
		if snapshot
			pTweakSnapshotComplete.Show()
		elseif !scrapAll
			pTweakScanCompleteMsg.Show(totalscrap)
		endif
	else
		if snapshot
			pTweakSnapshotTimeout.Show()
		elseif !scrapAll
			pTweakScanTimeoutMsg.Show(totalscrap)
		endif		
	endif
	
	Utility.wait(0.1)
		
EndFunction


Function TweakBuildInfo(string name, int base, float posx, float posy, float posz, float anglex, float angley, float anglez, float scale = 1.0, int extra = -1)

	; BUG: Release level compiles (Which are required for console releases) can't deal with some small floating point values. 
	;      Known issues occure from -0.000010 -> -0.000001 and at the value -0.000020. Fortunately, we dont have these issues
    ;      when values are positive. So we can check for them by doing a polarity switch.
	
	if (posx < 0)
		float checkv = (posx * -1)
		if checkv <= 0.000010 && checkv >= 0.000001
			if checkv < 0.000006
				posx = -0.000000
			else
				posx = -0.000011			
			endif
		elseif (0.000020 == checkv)
			posx = -0.000021
		endif
	endif
	if (posy < 0)
		float checkv = (posy * -1)
		if checkv <= 0.000010 && checkv >= 0.000001
			if checkv < 0.000006
				posy = -0.000000
			else
				posy = -0.000011			
			endif
		elseif (0.000020 == checkv)
			posy = -0.000021
		endif
	endif
	if (posz < 0)
		float checkv = (posz * -1)
		if checkv <= 0.000010 && checkv >= 0.000001
			if checkv < 0.000006
				posz = -0.000000
			else
				posz = -0.000011			
			endif
		elseif (0.000020 == checkv)
			posz = -0.000021
		endif
	endif
	if (anglex < 0)
		float checkv = (anglex * -1)
		if checkv <= 0.000010 && checkv >= 0.000001
			if checkv < 0.000006
				anglex = -0.000000
			else
				anglex = -0.000011			
			endif
		elseif (0.000020 == checkv)
			anglex = -0.000021
		endif
	endif
	if (angley < 0 && angley > -0.000011)
		float checkv = (angley * -1)
		if checkv <= 0.000010 && checkv >= 0.000001
			if checkv < 0.000006
				angley = -0.000000
			else
				angley = -0.000011			
			endif
		elseif (0.000020 == checkv)
			angley = -0.000021
		endif
	endif
	if (anglez < 0 && anglez > -0.000011)
		float checkv = (anglez * -1)
		if checkv <= 0.000010 && checkv >= 0.000001
			if checkv < 0.000006
				anglez = -0.000000
			else
				anglez = -0.000011			
			endif
		elseif (0.000020 == checkv)
			anglez = -0.000021
		endif
	endif
	if (0 == buildType) ; Batch
		string line = "; " + name + "\n"
		line += "player.cf \"TweakBuilderScript.build\" " + base + " "
		line += posx + " "
		line += posy + " "
		line += posz + " "
		line += anglex + " "		
		line += angley + " "
		line += anglez + " "
		line += scale  + " "
		line += extra  + "\n"
		buildoutput[buildindex] += line
		buildcount += 1
		buildtotal += 1
		if (768 == buildcount)
			buildoutput.add("")
			buildcount = 0
			buildindex += 1
		endif
	else ; Papyrus
		string line = "\ttbs.rbuild(" + base + ","
		line += posx + ","
		line += posy + ","
		line += posz + ","
		line += anglex + ","
		line += angley + ","
		line += anglez
		if !(scale == 1.0 && extra == -1)
			line += "," + scale
			if (extra != -1)
				line += "," + extra
			endif
		endif
		line += ")\n"
		buildoutput[buildindex] += line
		buildcount += 1
		buildtotal += 1
		if (768 == buildcount)
			buildoutput.add("")
			buildindex += 1
			buildcount = 0
		endif
	endif
EndFunction

String Function tohex(int value)
	string ret = ""
	int remainder   = 0
	while (value > 15)
		remainder  = value % 16
		value = ((value / 16) as Int)
		if (remainder < 10)
			ret = remainder + ret
		elseif (10 == remainder)
			ret = "A" + ret
		elseif (11 == remainder)
			ret = "B" + ret
		elseif (12 == remainder)
			ret = "C" + ret
		elseif (13 == remainder)
			ret = "D" + ret
		elseif (14 == remainder)
			ret = "E" + ret
		elseif (15 == remainder)
			ret = "F" + ret
		endif
	endWhile							
	if (value < 10)
		ret = value + ret
	elseif (10 == value)
		ret = "A" + ret
	elseif (11 == value)
		ret = "B" + ret
	elseif (12 == value)
		ret = "C" + ret
	elseif (13 == value)
		ret = "D" + ret
	elseif (14 == value)
		ret = "E" + ret
	elseif (15 == value)
		ret = "F" + ret
	endif
	return ret
endFunction

Function initialize_ResultArray()
	ResultArray = new GlobalVariable[31]
	ResultArray[0]  = pTweakScanSteelFound
	ResultArray[1]  = pTweakScanWoodFound
	ResultArray[2]  = pTweakScanRubberFound
	ResultArray[3]  = pTweakScanClothFound
	ResultArray[4]  = pTweakScanPlasticFound
	ResultArray[5]  = pTweakScanCopperFound
	ResultArray[6]  = pTweakScanScrewsFound
	ResultArray[7]  = pTweakScanGlassFound
	ResultArray[8]  = pTweakScanAluminumFound
	ResultArray[9]  = pTweakScanCeramicFound
	ResultArray[10] = pTweakScanCircuitryFound
	ResultArray[11] = pTweakScanConcreteFound
	ResultArray[12] = pTweakScanGearsFound
	ResultArray[13] = pTweakScanOilFound
	ResultArray[14] = pTweakScanAdhesiveFound
	ResultArray[15] = pTweakScanSpringsFound
	ResultArray[16] = pTweakScanNuclearMaterialFound
	ResultArray[17] = pTweakScanFertilizerFound
	ResultArray[18] = pTweakScanFiberOpticsFound
	ResultArray[19] = pTweakScanFiberglassFound
	ResultArray[20] = pTweakScanBoneFound
	ResultArray[21] = pTweakScanAcidFound
	ResultArray[22] = pTweakScanAsbestosFound
	ResultArray[23] = pTweakScanCrystalFound
	ResultArray[24] = pTweakScanLeadFound
	ResultArray[25] = pTweakScanLeatherFound
	ResultArray[26] = pTweakScanAntiBallisticFiberFound
	ResultArray[27] = pTweakScanAntisepticFound
	ResultArray[28] = pTweakScanCorkFound
	ResultArray[29] = pTweakScanSilverFound
	ResultArray[30] = pTweakScanGoldFound	
EndFunction

Function initialize_SettlementData()


	; Data pulled from WOrldObjects/Static/Workshop/*Border (Used NifScope to 
	; extract boundary offset information) People tend to put walls and turrets
	; on the borders. A sphere may not include these items if they go too high,
	; which is why we add a minimum buffer of 450 to all radiuses to ensure 
	; those on-the-border turrents are included in clearing operations. 
	
	allocate_SettlementLookup(39)
	
    SettlementLookup[0].name       = "AbernathyFarm"
    SettlementLookup[0].locid      =  0x0006B4D0
	;                                 actual   +  bs offset
    SettlementLookup[0].bs_x       = -75925.09 +  0.00
    SettlementLookup[0].bs_y       =  67161.65 +  0.00
    SettlementLookup[0].bs_z       =  7282.35  +  114.79
	;                                 ~w/25    +  extra
    SettlementLookup[0].bs_radius  =  4550     +  450

    SettlementLookup[1].name       = "BunkerHill"
    SettlementLookup[1].locid      =  0x000456FA
    SettlementLookup[1].bs_x       =  18301.65 + -245.36
    SettlementLookup[1].bs_y       =  14802.51 +  292.64
    SettlementLookup[1].bs_z       =  1476.76  + -120.42
    SettlementLookup[1].bs_radius  =  2550     +  450
    SettlementLookup[2].name       = "BostonAirport"
    SettlementLookup[2].locid      =  0x00084AB0
    SettlementLookup[2].bs_x       =  45600.90 +  7.09
    SettlementLookup[2].bs_y       = -3358.50  +  7.05
    SettlementLookup[2].bs_z       =  1038.65  + -376.93
    SettlementLookup[2].bs_radius  =  2100     +  500
    SettlementLookup[3].name       = "CoastalCottage"
    SettlementLookup[3].locid      =  0x00176926
    SettlementLookup[3].bs_x       =  69703.32 + -167.82
    SettlementLookup[3].bs_y       =  89460.95 +  134.80
    SettlementLookup[3].bs_z       =  2063.95  + -403.80
    SettlementLookup[3].bs_radius  =  2925     +  500
    SettlementLookup[4].name       = "CountyCrossing"
    SettlementLookup[4].locid      =  0x0009B1C3
    SettlementLookup[4].bs_x       =  39720.04 +  0.0
    SettlementLookup[4].bs_y       =  30367.39 +  0.0
    SettlementLookup[4].bs_z       =  1020.74  + -13.06
    SettlementLookup[4].bs_radius  =  2925     +  500
    SettlementLookup[5].name       = "Covenant"
    SettlementLookup[5].locid      =  0x000397DC
    SettlementLookup[5].bs_x       = -5561.32  + -34.51
    SettlementLookup[5].bs_y       =  47844.31 + -530.11
    SettlementLookup[5].bs_z       =  1351.23  + -51.30
    SettlementLookup[5].bs_radius  =  2300     +  700
    SettlementLookup[6].name       = "CroupManor"
    SettlementLookup[6].locid      =  0x0003C0FE
    SettlementLookup[6].bs_x       =  91239.84 + -199.03
    SettlementLookup[6].bs_y       =  37076.71 +  203.86
    SettlementLookup[6].bs_z       =  1124.15  + -211.34
    SettlementLookup[6].bs_radius  =  2750     +  500
    SettlementLookup[7].name       = "EgretToursMarina"
    SettlementLookup[7].locid      =  0x00021A7F
    SettlementLookup[7].bs_x       = -31127.07 +  0.0
    SettlementLookup[7].bs_y       = -63244.24 +  0.0
    SettlementLookup[7].bs_z       =  1530.10  + -72.37
    SettlementLookup[7].bs_radius  =  3650     +  550
    SettlementLookup[8].name       = "FinchFarm"
    SettlementLookup[8].locid      =  0x0002648A
    SettlementLookup[8].bs_x       =  55178.58 +  720.07
    SettlementLookup[8].bs_y       =  47507.77 +  4.04
    SettlementLookup[8].bs_z       =  818.06   + -143.40
    SettlementLookup[8].bs_radius  =  3100     +  500
    SettlementLookup[9].name       = "Graygarden"
    SettlementLookup[9].locid      =  0x000482CF
    SettlementLookup[9].bs_x       = -47196.31 +  0.0
    SettlementLookup[9].bs_y       =  16710.69 +  0.0
    SettlementLookup[9].bs_z       =  2276.02  +  170.00
    SettlementLookup[9].bs_radius  =  3075     +  525
    SettlementLookup[10].name       = "GreentopNursery"
    SettlementLookup[10].locid      =  0x0009B1C5
    SettlementLookup[10].bs_x       =  29806.02 +  0.0
    SettlementLookup[10].bs_y       =  68381.34 +  0.0
    SettlementLookup[10].bs_z       =  2186.48  + -25.40
    SettlementLookup[10].bs_radius  =  2875     +  525
    SettlementLookup[11].name       = "HangmansAlley" ; WorkshopBorderRaiderCampe01
    SettlementLookup[11].locid      =  0x001B8C53
    SettlementLookup[11].bs_x       = -21045.01 +  295.06
    SettlementLookup[11].bs_y       = -17820.88 +  627.81
    SettlementLookup[11].bs_z       =  1037.43  + -88.65
    SettlementLookup[11].bs_radius  =  1800     +  1200
    SettlementLookup[12].name       = "JamaicaPlain"
    SettlementLookup[12].locid      =  0x00050C08
    SettlementLookup[12].bs_x       =  8982.95  + 355.34
    SettlementLookup[12].bs_y       = -65928.20 + 121.67
    SettlementLookup[12].bs_z       =  884.61   + -217.25
    SettlementLookup[12].bs_radius  =  2350     + 450
    SettlementLookup[13].name       = "KingsportLighthouse"
    SettlementLookup[13].locid      =  0x0005A5E4
    SettlementLookup[13].bs_x       =  90228.82 + -155.43
    SettlementLookup[13].bs_y       =  59768.60 +  0.0
    SettlementLookup[13].bs_z       =  1457.91  + -838.25
    SettlementLookup[13].bs_radius  =  3675     +  825
    SettlementLookup[14].name       = "Murkwater"
    SettlementLookup[14].locid      =  0x00178E7A
    SettlementLookup[14].bs_x       =  5367.31  +  0.0
    SettlementLookup[14].bs_y       = -95858.57 +  0.0
    SettlementLookup[14].bs_z       =  1021.31  + -286.76
    SettlementLookup[14].bs_radius  =  2525     +  475
    SettlementLookup[15].name       = "NordhagenBeach"
    SettlementLookup[15].locid      =  0x0009B1B5
    SettlementLookup[15].bs_x       =  63270.19 +  49.75
    SettlementLookup[15].bs_y       =  2784.48  +  98.69
    SettlementLookup[15].bs_z       =  919.68   + -482.77
    SettlementLookup[15].bs_radius  =  3750     +  450
    SettlementLookup[16].name       = "OberlandStation"
    SettlementLookup[16].locid      =  0x0009B1C2
    SettlementLookup[16].bs_x       = -45602.65 +  0.0
    SettlementLookup[16].bs_y       = -4920.34  +  0.0
    SettlementLookup[16].bs_z       =  1917.83  + -248.46
    SettlementLookup[16].bs_radius  =  2375     +  625
    SettlementLookup[17].name       = "OutpostZimonja"
    SettlementLookup[17].locid      =  0x00055402
    SettlementLookup[17].bs_x       = -10411.79  +  137.77
    SettlementLookup[17].bs_y       =  100233.07 +  359.19
    SettlementLookup[17].bs_z       =  4282.42   + -126.13
    SettlementLookup[17].bs_radius  =  2275      +  1225
    SettlementLookup[18].name       = "RedRocket"
    SettlementLookup[18].locid      =  0x00024FAB
    SettlementLookup[18].bs_x       = -69413.91 + -265.78
    SettlementLookup[18].bs_y       =  80086.03 + -64.21
    SettlementLookup[18].bs_z       =  7137.28  +  313.93
    SettlementLookup[18].bs_radius  =  3375     +  825
    SettlementLookup[19].name       = "SanctuaryHills"
    SettlementLookup[19].locid      =  0x0001F228
    SettlementLookup[19].bs_x       = -79589.77 +  1116.17
    SettlementLookup[19].bs_y       =  87346.63 +  699.78
    SettlementLookup[19].bs_z       =  6505.80  +  1177.33
    SettlementLookup[19].bs_radius  =  7125     +  475
    SettlementLookup[20].name       = "SomervillePlace" ; WorkshopBorderFarm05
    SettlementLookup[20].locid      =  0x0009B1C4
    SettlementLookup[20].bs_x       = -35637.21 +  0.0
    SettlementLookup[20].bs_y       = -91817.27 +  0.0
    SettlementLookup[20].bs_z       =  2568.79  + -179.98
    SettlementLookup[20].bs_radius  =  4150     +  450
    SettlementLookup[21].name       = "SpectacleIsland"
    SettlementLookup[21].locid      =  0x0008281C
    SettlementLookup[21].bs_x       =  74174.77 +  0.0
    SettlementLookup[21].bs_y       = -64354.18 +  221.10
    SettlementLookup[21].bs_z       =  972.24   + -522.24
    SettlementLookup[21].bs_radius  =  12600    +  450
    SettlementLookup[22].name       = "StarlightDriveIn"
    SettlementLookup[22].locid      =  0x00024F96
    SettlementLookup[22].bs_x       = -39262.64 + -455.84
    SettlementLookup[22].bs_y       =  58725.77 + -393.67
    SettlementLookup[22].bs_z       =  4077.29  +  147.28
    SettlementLookup[22].bs_radius  =  4125     +  1875 
    SettlementLookup[23].name       = "SunshineTidings"
    SettlementLookup[23].locid      =  0x00024FAD
    SettlementLookup[23].bs_x       = -86102.80 + -656.22
    SettlementLookup[23].bs_y       =  39353.30 + -463.50
    SettlementLookup[23].bs_z       =  6919.46  + -172.91
    SettlementLookup[23].bs_radius  =  4475     +  1525
    SettlementLookup[24].name       = "TaffingtonBoathouse"
    SettlementLookup[24].locid      =  0x00056CBA
    SettlementLookup[24].bs_x       =  5609.88  +  0.0
    SettlementLookup[24].bs_y       =  45357.62 +  0.0
    SettlementLookup[24].bs_z       =  406.04   +  13.29
    SettlementLookup[24].bs_radius  =  2675     +  825
    SettlementLookup[25].name       = "TenpinesBluff"
    SettlementLookup[25].locid      =  0x0009B1B4
    SettlementLookup[25].bs_x       = -22882.73 +  152.43
    SettlementLookup[25].bs_y       =  90897.73 + -1016.00
    SettlementLookup[25].bs_z       =  6305.41  + -113.11
    SettlementLookup[25].bs_radius  =  2675     +  825
    SettlementLookup[26].name       = "TheCastle"
    SettlementLookup[26].locid      =  0x00066EBA
    SettlementLookup[26].bs_x       =  48228.76 +  0.0
    SettlementLookup[26].bs_y       = -45893.25 + -29.70
    SettlementLookup[26].bs_z       =  854.17   + -551.68
    SettlementLookup[26].bs_radius  =  5250     +  650
    SettlementLookup[27].name       = "TheSlog"
    SettlementLookup[27].locid      =  0x0006260D
    SettlementLookup[27].bs_x       =  52650.89 +  0.0
    SettlementLookup[27].bs_y       =  70176.56 +  0.0
    SettlementLookup[27].bs_z       =  1233.90  +  201.78
    SettlementLookup[27].bs_radius  =  3250     +  550
    SettlementLookup[28].name       = "WarwickHomestead"
    SettlementLookup[28].locid      =  0x0006260C
    SettlementLookup[28].bs_x       =  57582.9961 + -629.93
    SettlementLookup[28].bs_y       = -75944.0859 +  1379.24
    SettlementLookup[28].bs_z       =  676.9836   + -225.75
    SettlementLookup[28].bs_radius  =  3875       +  625
	
EndFunction

Function allocate_SettlementLookup(int len)

	; When you have an array of structs, you must still 
	; allocate each individual struct....
	
	SettlementLookup = new SettlementData[len]
	int i = 0
	while (i < len)
		SettlementLookup[i] = new SettlementData
		i += 1
	endWhile
EndFunction

GlobalVariable Property pTweakScanAcidFound Auto
GlobalVariable Property pTweakScanAdhesiveFound Auto
GlobalVariable Property pTweakScanRubberFound Auto
GlobalVariable Property pTweakScanScrewsFound Auto
GlobalVariable Property pTweakScanAluminumFound Auto
GlobalVariable Property pTweakScanAntiBallisticFiberFound Auto
GlobalVariable Property pTweakScanAntisepticFound Auto
GlobalVariable Property pTweakScanAsbestosFound Auto
GlobalVariable Property pTweakScanBoneFound Auto
GlobalVariable Property pTweakScanCeramicFound Auto
GlobalVariable Property pTweakScanCircuitryFound Auto
GlobalVariable Property pTweakScanClothFound Auto
GlobalVariable Property pTweakScanConcreteFound Auto
GlobalVariable Property pTweakScanCopperFound Auto
GlobalVariable Property pTweakScanCorkFound Auto
GlobalVariable Property pTweakScanCrystalFound Auto
GlobalVariable Property pTweakScanFertilizerFound Auto
GlobalVariable Property pTweakScanFiberglassFound Auto
GlobalVariable Property pTweakScanFiberOpticsFound Auto
GlobalVariable Property pTweakScanSteelFound Auto
GlobalVariable Property pTweakScanSilverFound Auto
GlobalVariable Property pTweakScanGearsFound Auto
GlobalVariable Property pTweakScanGlassFound Auto
GlobalVariable Property pTweakScanGoldFound Auto
GlobalVariable Property pTweakScanSpringsFound Auto
GlobalVariable Property pTweakScanLeadFound Auto
GlobalVariable Property pTweakScanLeatherFound Auto
GlobalVariable Property pTweakScanWoodFound Auto
GlobalVariable Property pTweakScanPlasticFound Auto
GlobalVariable Property pTweakScanNuclearMaterialFound Auto
GlobalVariable Property pTweakScanOilFound Auto
GlobalVariable Property pTweakScanObjectsFound Auto
