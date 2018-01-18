Scriptname AFT:TweakScanCWallsScript extends Quest

; import AFT

Quest Property TweakScrapScanMaster Auto Const
FormList Property TweakConstructed_Walls Auto Const

GlobalVariable   Property pTweakSettlementSnap Auto Const

GlobalVariable   Property pTweakScanThreadsDone Auto
GlobalVariable[] Property ResultArray Auto
GlobalVariable   Property pTweakScrapAll Auto Const

Struct ComponentData
	int formid    = 0
	int mask    = 0
	int counts  = 0
	string name = ""
EndStruct

ComponentData[] Property ComponentLookup Auto

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakScanCWallsScript"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Event OnInit()
	initialize_ResultArray()
	allocate_ComponentData()
	initialize_ComponentData()
		
	; PASTE python generated component data without form ids in initialize_ComponentData
	; Uncomment out this loop. Start up game and load mod. Then quit and copy code
	; WITH form ids from log file back into the initialize_ComponentData method
	; below. Recomment this loop. Walla...
	
	
	; string code = "\n"
	; int i = 0
	; while i < 96
		; code += "    ComponentLookup[" + i + "].formid = " + TweakConstructed_Walls.GetAt(i).GetFormID() + "\n"
		; code += "    ComponentLookup[" + i + "].mask = " + ComponentLookup[i].mask + "\n"
		; code += "    ComponentLookup[" + i + "].counts = " + ComponentLookup[i].counts + "\n"
		; code += "    ComponentLookup[" + i + "].name = \"" + ComponentLookup[i].name + "\"\n"
		; i += 1
	; endWhile
	; Trace(code)
	
EndEvent

ObjectReference center
float radius

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
	Trace("ScanHelper Called")
	
	ObjectReference[] results
	ObjectReference result
	ComponentData lookupResult
	
	Trace("Scanning...")
	results = center.FindAllReferencesOfType(TweakConstructed_Walls, radius)			
	int numresults = results.length
	
	Trace("Scanning Complete: [" + numresults + "] objects found")
	center = None	
	if (0 == numresults)
		pTweakScanThreadsDone.mod(-1.0)
		return
	endif
	
	; Tracking:
	int lookupsuccess     = 0
	int lookupindex       = 0
	int[] scrapdata = new int[31]	
	int i = 0
	while (i < 31)
		scrapdata[i] = 0
		i += 1
	endwhile
	
	ComponentData lookup
	
	; mask   : There are 31 component types. So we use a 32bit bitmask 
	;          to identify up to 5 components. (Max of 5)
	;          This bits correspond to the index of the formlist TweakScrapComponents.
	;          The formlist is optimized so that the most frequent components appear
	;          first. This helps minimize the number of mod operations we have to 
	;          perform to isolate the last bit. 
	int mask
	
	; counts : We store five 6 bit numbers (max value = 64) using the first 30
	;          bits of the 32 bit int. These correspond to the elements
	;          found in the mask from first to last...  
	int counts
	
	Form rbase	
	int bit
	int offset
	int rid
	int count
	bool keepgoing = true
	
	bool snapshot = (1.0 == pTweakSettlementSnap.GetValue())
	bool scrapall = (1.0 == pTweakScrapAll.Getvalue())
	Var[] params = new Var[10]
	AFT:TweakScrapScanScript ScrapScanMaster = TweakScrapScanMaster as AFT:TweakScrapScanScript
	
	i = 0
	while (i != numresults && keepgoing)
		result = results[i]
		if scrapall
			result.SetPosition(0,0,10)
			result.Disable()
			result.Delete()
		elseif (!result.IsDisabled())
			rbase = result.GetBaseObject()
			rid   = rbase.GetFormID()
			lookupindex = ComponentLookup.FindStruct("formid",rid)
			if (lookupindex > -1)
				lookup = ComponentLookup[lookupindex]
		
				lookupsuccess += 1
				if snapshot
			
					params[0] = lookup.name
					params[1] = rid
					params[2] = result.GetPositionX()
					params[3] = result.GetPositionY()
					params[4] = result.GetPositionZ()
					params[5] = result.GetAngleX()
					params[6] = result.GetAngleY()
					params[7] = result.GetAngleZ()
					params[8] = result.GetScale()
					params[9] = -1
					Trace("Adding Components [" + lookup.name + "] to scrapdata")
					ScrapScanMaster.CallFunctionNoWait("TweakBuildInfo", params)
				
				else			
					result.SetPosition(0,0,10)
					result.Disable()
					result.Delete()
					Trace("Adding Scrap [" + lookup.name + "] to scrapdata")
				endif
			
				mask   = lookup.mask
				counts = lookup.counts
				bit    = 0
				offset = 0
				count  = 0

				while (mask > 0 && offset < 31)
					bit  = mask % 2                     ; isolate least significant bit
					mask = ((mask / 2) as Int)          ; shift right 1
					if (bit == 1)
						count = counts % 64             ; isolate last 6 bits
						counts = ((counts / 64) as Int) ; shift right 6 (64 = 2^6)
						scrapdata[offset] += count
					endif
					offset += 1
				endWhile
			endif
		endif	

		i += 1
		if (0 == (i % 30))
			keepgoing = (pTweakScanThreadsDone.GetValue() > 0.0)
		endif
	endwhile
	if (0 == lookupsuccess)
		pTweakScanThreadsDone.mod(-1.0)
		return
	endif
	pTweakScanObjectsFound.mod(lookupsuccess)
	
	i = 0
	while (i < 31)
		if scrapdata[i] != 0
			Trace("Adding [" + scrapdata[i] + "] to ResultArray [" + i + "]")
			ResultArray[i].mod(scrapdata[i])
		endif
		i += 1
	endwhile
	
	pTweakScanThreadsDone.mod(-1.0)
		
EndFunction

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

Function allocate_ComponentData()
	ComponentLookup = new ComponentData[96]
	int i = 0
	while (i < ComponentLookup.length)
		ComponentLookup[i] = new ComponentData
		i += 1
	endWhile
EndFunction

Function initialize_ComponentData()

    ; Array co-insides with FORMLIST. This was generated using Python.
	
    ComponentLookup[0].formid = 1699778
    ComponentLookup[0].mask = 3
    ComponentLookup[0].counts = 195
    ComponentLookup[0].name = "PaintedWoodDoorA01"
    ComponentLookup[1].formid = 1699784
    ComponentLookup[1].mask = 3
    ComponentLookup[1].counts = 195
    ComponentLookup[1].name = "PaintedWoodDoorB01"
    ComponentLookup[2].formid = 1699785
    ComponentLookup[2].mask = 3
    ComponentLookup[2].counts = 195
    ComponentLookup[2].name = "PaintedWoodDoorC01"
    ComponentLookup[3].formid = 1699786
    ComponentLookup[3].mask = 3
    ComponentLookup[3].counts = 195
    ComponentLookup[3].name = "PaintedWoodDoorD01"
    ComponentLookup[4].formid = 1699779
    ComponentLookup[4].mask = 3
    ComponentLookup[4].counts = 195
    ComponentLookup[4].name = "PaintedWoodDoorWinA01"
    ComponentLookup[5].formid = 1699788
    ComponentLookup[5].mask = 3
    ComponentLookup[5].counts = 195
    ComponentLookup[5].name = "PaintedWoodDoorWinB01"
    ComponentLookup[6].formid = 1699787
    ComponentLookup[6].mask = 3
    ComponentLookup[6].counts = 195
    ComponentLookup[6].name = "PaintedWoodDoorWinC01"
    ComponentLookup[7].formid = 1699789
    ComponentLookup[7].mask = 3
    ComponentLookup[7].counts = 195
    ComponentLookup[7].name = "PaintedWoodDoorWinD01"
    ComponentLookup[8].formid = 1740996
    ComponentLookup[8].mask = 3
    ComponentLookup[8].counts = 644
    ComponentLookup[8].name = "WorkshopGuardPostFurniture"
    ComponentLookup[9].formid = 103136
    ComponentLookup[9].mask = 3
    ComponentLookup[9].counts = 774
    ComponentLookup[9].name = "WorkshopGuardTowerFurniture"
    ComponentLookup[10].formid = 2399897
    ComponentLookup[10].mask = 3
    ComponentLookup[10].counts = 195
    ComponentLookup[10].name = "workshop_BldWoodPDoor01"
    ComponentLookup[11].formid = 2399898
    ComponentLookup[11].mask = 3
    ComponentLookup[11].counts = 195
    ComponentLookup[11].name = "workshop_BldWoodPDoor02"
    ComponentLookup[12].formid = 2399905
    ComponentLookup[12].mask = 3
    ComponentLookup[12].counts = 130
    ComponentLookup[12].name = "workshop_BldWoodPDoorBroke01"
    ComponentLookup[13].formid = 2399903
    ComponentLookup[13].mask = 3
    ComponentLookup[13].counts = 130
    ComponentLookup[13].name = "workshop_BldWoodPDoorBroke02"
    ComponentLookup[14].formid = 2399901
    ComponentLookup[14].mask = 1
    ComponentLookup[14].counts = 3
    ComponentLookup[14].name = "workshop_IndMetalDoor01"
    ComponentLookup[15].formid = 1793813
    ComponentLookup[15].mask = 3
    ComponentLookup[15].counts = 655
    ComponentLookup[15].name = "workshop_JunkWallGate01"
    ComponentLookup[16].formid = 2399896
    ComponentLookup[16].mask = 1
    ComponentLookup[16].counts = 3
    ComponentLookup[16].name = "workshop_MetalMeshDoorSm01"
    ComponentLookup[17].formid = 920447
    ComponentLookup[17].mask = 3
    ComponentLookup[17].counts = 193
    ComponentLookup[17].name = "workshop_ShackBalconyFloor01"
    ComponentLookup[18].formid = 920448
    ComponentLookup[18].mask = 3
    ComponentLookup[18].counts = 193
    ComponentLookup[18].name = "workshop_ShackBalconyFloor02"
    ComponentLookup[19].formid = 920449
    ComponentLookup[19].mask = 3
    ComponentLookup[19].counts = 193
    ComponentLookup[19].name = "workshop_ShackBalconyFloor03"
    ComponentLookup[20].formid = 920450
    ComponentLookup[20].mask = 3
    ComponentLookup[20].counts = 193
    ComponentLookup[20].name = "workshop_ShackBalconyFloor04"
    ComponentLookup[21].formid = 920451
    ComponentLookup[21].mask = 3
    ComponentLookup[21].counts = 193
    ComponentLookup[21].name = "workshop_ShackBalconyFloor05"
    ComponentLookup[22].formid = 920452
    ComponentLookup[22].mask = 3
    ComponentLookup[22].counts = 129
    ComponentLookup[22].name = "workshop_ShackBalconyRailing01"
    ComponentLookup[23].formid = 920453
    ComponentLookup[23].mask = 3
    ComponentLookup[23].counts = 129
    ComponentLookup[23].name = "workshop_ShackBalconyRailing02"
    ComponentLookup[24].formid = 920454
    ComponentLookup[24].mask = 3
    ComponentLookup[24].counts = 129
    ComponentLookup[24].name = "workshop_ShackBalconyRailing03"
    ComponentLookup[25].formid = 920455
    ComponentLookup[25].mask = 3
    ComponentLookup[25].counts = 129
    ComponentLookup[25].name = "workshop_ShackBalconyRailing04"
    ComponentLookup[26].formid = 2164236
    ComponentLookup[26].mask = 3
    ComponentLookup[26].counts = 129
    ComponentLookup[26].name = "workshop_ShackBalconyRailingDbl01"
    ComponentLookup[27].formid = 920496
    ComponentLookup[27].mask = 3
    ComponentLookup[27].counts = 195
    ComponentLookup[27].name = "workshop_ShackDoor01"
    ComponentLookup[28].formid = 2039499
    ComponentLookup[28].mask = 3
    ComponentLookup[28].counts = 524
    ComponentLookup[28].name = "workshop_ShackMetalPrefab3Way01"
    ComponentLookup[29].formid = 2056706
    ComponentLookup[29].mask = 3
    ComponentLookup[29].counts = 266
    ComponentLookup[29].name = "workshop_ShackMetalPrefab3Way02"
    ComponentLookup[30].formid = 2070422
    ComponentLookup[30].mask = 3
    ComponentLookup[30].counts = 1320
    ComponentLookup[30].name = "workshop_ShackMetalPrefabCompleteLg01"
    ComponentLookup[31].formid = 2070468
    ComponentLookup[31].mask = 3
    ComponentLookup[31].counts = 1310
    ComponentLookup[31].name = "workshop_ShackMetalPrefabCompleteSm01"
    ComponentLookup[32].formid = 2070463
    ComponentLookup[32].mask = 3
    ComponentLookup[32].counts = 1310
    ComponentLookup[32].name = "workshop_ShackMetalPrefabCompleteSm02"
    ComponentLookup[33].formid = 2389342
    ComponentLookup[33].mask = 3
    ComponentLookup[33].counts = 266
    ComponentLookup[33].name = "workshop_ShackMetalPrefabCornerSm01"
    ComponentLookup[34].formid = 2391905
    ComponentLookup[34].mask = 3
    ComponentLookup[34].counts = 266
    ComponentLookup[34].name = "workshop_ShackMetalPrefabDoorway01"
    ComponentLookup[35].formid = 2039500
    ComponentLookup[35].mask = 3
    ComponentLookup[35].counts = 266
    ComponentLookup[35].name = "workshop_ShackMetalPrefabHallway01"
    ComponentLookup[36].formid = 2056703
    ComponentLookup[36].mask = 3
    ComponentLookup[36].counts = 266
    ComponentLookup[36].name = "workshop_ShackMetalPrefabHallwayEnd01"
    ComponentLookup[37].formid = 2039501
    ComponentLookup[37].mask = 3
    ComponentLookup[37].counts = 266
    ComponentLookup[37].name = "workshop_ShackMetalPrefabMid01"
    ComponentLookup[38].formid = 2039502
    ComponentLookup[38].mask = 3
    ComponentLookup[38].counts = 266
    ComponentLookup[38].name = "workshop_ShackMetalPrefabMid02"
    ComponentLookup[39].formid = 2039503
    ComponentLookup[39].mask = 3
    ComponentLookup[39].counts = 266
    ComponentLookup[39].name = "workshop_ShackMetalPrefabMid03"
    ComponentLookup[40].formid = 1044978
    ComponentLookup[40].mask = 1
    ComponentLookup[40].counts = 10
    ComponentLookup[40].name = "workshop_ShackMetalWallFlat01"
    ComponentLookup[41].formid = 1044979
    ComponentLookup[41].mask = 1
    ComponentLookup[41].counts = 10
    ComponentLookup[41].name = "workshop_ShackMetalWallFlat02"
    ComponentLookup[42].formid = 1044980
    ComponentLookup[42].mask = 3
    ComponentLookup[42].counts = 202
    ComponentLookup[42].name = "workshop_ShackMetalWallOuter01A"
    ComponentLookup[43].formid = 1044981
    ComponentLookup[43].mask = 3
    ComponentLookup[43].counts = 202
    ComponentLookup[43].name = "workshop_ShackMetalWallOuter02A"
    ComponentLookup[44].formid = 1044982
    ComponentLookup[44].mask = 3
    ComponentLookup[44].counts = 202
    ComponentLookup[44].name = "workshop_ShackMetalWallOuter03A"
    ComponentLookup[45].formid = 1044983
    ComponentLookup[45].mask = 3
    ComponentLookup[45].counts = 202
    ComponentLookup[45].name = "workshop_ShackMetalWallOuter04A"
    ComponentLookup[46].formid = 1044984
    ComponentLookup[46].mask = 1
    ComponentLookup[46].counts = 10
    ComponentLookup[46].name = "workshop_ShackMetalWallOuterCap01A"
    ComponentLookup[47].formid = 1044985
    ComponentLookup[47].mask = 3
    ComponentLookup[47].counts = 202
    ComponentLookup[47].name = "workshop_ShackMetalWallOuterCap01Door01"
    ComponentLookup[48].formid = 1044986
    ComponentLookup[48].mask = 1
    ComponentLookup[48].counts = 10
    ComponentLookup[48].name = "workshop_ShackMetalWallOuterCap02A"
    ComponentLookup[49].formid = 1044987
    ComponentLookup[49].mask = 1
    ComponentLookup[49].counts = 10
    ComponentLookup[49].name = "workshop_ShackMetalWallOuterCap04A"
    ComponentLookup[50].formid = 1910919
    ComponentLookup[50].mask = 3
    ComponentLookup[50].counts = 202
    ComponentLookup[50].name = "workshop_ShackMetalWallOuterCap04ADoor01"
    ComponentLookup[51].formid = 2039504
    ComponentLookup[51].mask = 3
    ComponentLookup[51].counts = 136
    ComponentLookup[51].name = "workshop_ShackMetalWallOuterCrnIn01"
    ComponentLookup[52].formid = 1044988
    ComponentLookup[52].mask = 3
    ComponentLookup[52].counts = 136
    ComponentLookup[52].name = "workshop_ShackMetalWallOuterCrnInCap01A"
    ComponentLookup[53].formid = 1044989
    ComponentLookup[53].mask = 3
    ComponentLookup[53].counts = 136
    ComponentLookup[53].name = "workshop_ShackMetalWallOuterCrnOut01A"
    ComponentLookup[54].formid = 1044990
    ComponentLookup[54].mask = 3
    ComponentLookup[54].counts = 136
    ComponentLookup[54].name = "workshop_ShackMetalWallOuterCrnOut01B"
    ComponentLookup[55].formid = 1044991
    ComponentLookup[55].mask = 3
    ComponentLookup[55].counts = 136
    ComponentLookup[55].name = "workshop_ShackMetalWallOuterCrnOut02A"
    ComponentLookup[56].formid = 1044992
    ComponentLookup[56].mask = 3
    ComponentLookup[56].counts = 136
    ComponentLookup[56].name = "workshop_ShackMetalWallOuterCrnOut04A"
    ComponentLookup[57].formid = 1620373
    ComponentLookup[57].mask = 3
    ComponentLookup[57].counts = 1034
    ComponentLookup[57].name = "workshop_ShackPrefab3Way01"
    ComponentLookup[58].formid = 2185455
    ComponentLookup[58].mask = 3
    ComponentLookup[58].counts = 778
    ComponentLookup[58].name = "workshop_ShackPrefab3Way02"
    ComponentLookup[59].formid = 1620374
    ComponentLookup[59].mask = 3
    ComponentLookup[59].counts = 2580
    ComponentLookup[59].name = "workshop_ShackPrefabCompleteLg01"
    ComponentLookup[60].formid = 1310487
    ComponentLookup[60].mask = 3
    ComponentLookup[60].counts = 1940
    ComponentLookup[60].name = "workshop_ShackPrefabCompleteSm01"
    ComponentLookup[61].formid = 1620375
    ComponentLookup[61].mask = 3
    ComponentLookup[61].counts = 1295
    ComponentLookup[61].name = "workshop_ShackPrefabCornerLg01"
    ComponentLookup[62].formid = 1620376
    ComponentLookup[62].mask = 3
    ComponentLookup[62].counts = 972
    ComponentLookup[62].name = "workshop_ShackPrefabCornerSm01"
    ComponentLookup[63].formid = 1286213
    ComponentLookup[63].mask = 3
    ComponentLookup[63].counts = 778
    ComponentLookup[63].name = "workshop_ShackPrefabHallway01"
    ComponentLookup[64].formid = 1286225
    ComponentLookup[64].mask = 3
    ComponentLookup[64].counts = 906
    ComponentLookup[64].name = "workshop_ShackPrefabHallwayEnd01"
    ComponentLookup[65].formid = 920468
    ComponentLookup[65].mask = 3
    ComponentLookup[65].counts = 514
    ComponentLookup[65].name = "workshop_ShackWallFlat01"
    ComponentLookup[66].formid = 920469
    ComponentLookup[66].mask = 3
    ComponentLookup[66].counts = 514
    ComponentLookup[66].name = "workshop_ShackWallFlat02"
    ComponentLookup[67].formid = 920470
    ComponentLookup[67].mask = 3
    ComponentLookup[67].counts = 196
    ComponentLookup[67].name = "workshop_ShackWallFlat03"
    ComponentLookup[68].formid = 920471
    ComponentLookup[68].mask = 3
    ComponentLookup[68].counts = 514
    ComponentLookup[68].name = "workshop_ShackWallFlat04"
    ComponentLookup[69].formid = 920472
    ComponentLookup[69].mask = 3
    ComponentLookup[69].counts = 257
    ComponentLookup[69].name = "workshop_ShackWallFlatEnd01"
    ComponentLookup[70].formid = 920473
    ComponentLookup[70].mask = 3
    ComponentLookup[70].counts = 257
    ComponentLookup[70].name = "workshop_ShackWallFlatEnd02"
    ComponentLookup[71].formid = 920474
    ComponentLookup[71].mask = 3
    ComponentLookup[71].counts = 517
    ComponentLookup[71].name = "workshop_ShackWallOuter01A"
    ComponentLookup[72].formid = 920475
    ComponentLookup[72].mask = 3
    ComponentLookup[72].counts = 517
    ComponentLookup[72].name = "workshop_ShackWallOuter01B"
    ComponentLookup[73].formid = 920476
    ComponentLookup[73].mask = 3
    ComponentLookup[73].counts = 517
    ComponentLookup[73].name = "workshop_ShackWallOuter02"
    ComponentLookup[74].formid = 920477
    ComponentLookup[74].mask = 3
    ComponentLookup[74].counts = 324
    ComponentLookup[74].name = "workshop_ShackWallOuter03"
    ComponentLookup[75].formid = 920478
    ComponentLookup[75].mask = 11
    ComponentLookup[75].counts = 8452
    ComponentLookup[75].name = "workshop_ShackWallOuter03B"
    ComponentLookup[76].formid = 920479
    ComponentLookup[76].mask = 3
    ComponentLookup[76].counts = 329
    ComponentLookup[76].name = "workshop_ShackWallOuter04A"
    ComponentLookup[77].formid = 920480
    ComponentLookup[77].mask = 3
    ComponentLookup[77].counts = 329
    ComponentLookup[77].name = "workshop_ShackWallOuter04B"
    ComponentLookup[78].formid = 920481
    ComponentLookup[78].mask = 3
    ComponentLookup[78].counts = 329
    ComponentLookup[78].name = "workshop_ShackWallOuter04C"
    ComponentLookup[79].formid = 920482
    ComponentLookup[79].mask = 3
    ComponentLookup[79].counts = 517
    ComponentLookup[79].name = "workshop_ShackWallOuter05A"
    ComponentLookup[80].formid = 920483
    ComponentLookup[80].mask = 3
    ComponentLookup[80].counts = 517
    ComponentLookup[80].name = "workshop_ShackWallOuter05B"
    ComponentLookup[81].formid = 920484
    ComponentLookup[81].mask = 3
    ComponentLookup[81].counts = 265
    ComponentLookup[81].name = "workshop_ShackWallOuterCap01A"
    ComponentLookup[82].formid = 920485
    ComponentLookup[82].mask = 3
    ComponentLookup[82].counts = 265
    ComponentLookup[82].name = "workshop_ShackWallOuterCap01B"
    ComponentLookup[83].formid = 920503
    ComponentLookup[83].mask = 3
    ComponentLookup[83].counts = 323
    ComponentLookup[83].name = "workshop_ShackWallOuterCap01Door01"
    ComponentLookup[84].formid = 920486
    ComponentLookup[84].mask = 3
    ComponentLookup[84].counts = 265
    ComponentLookup[84].name = "workshop_ShackWallOuterCap03"
    ComponentLookup[85].formid = 920505
    ComponentLookup[85].mask = 3
    ComponentLookup[85].counts = 776
    ComponentLookup[85].name = "workshop_ShackWallOuterCrnInCap01"
    ComponentLookup[86].formid = 920487
    ComponentLookup[86].mask = 3
    ComponentLookup[86].counts = 644
    ComponentLookup[86].name = "workshop_ShackWallOuterCrnOut01A"
    ComponentLookup[87].formid = 920488
    ComponentLookup[87].mask = 3
    ComponentLookup[87].counts = 644
    ComponentLookup[87].name = "workshop_ShackWallOuterCrnOut01B"
    ComponentLookup[88].formid = 920489
    ComponentLookup[88].mask = 3
    ComponentLookup[88].counts = 451
    ComponentLookup[88].name = "workshop_ShackWallOuterCrnOut01C"
    ComponentLookup[89].formid = 920490
    ComponentLookup[89].mask = 3
    ComponentLookup[89].counts = 387
    ComponentLookup[89].name = "workshop_ShackWallOuterCrnOut01D"
    ComponentLookup[90].formid = 920491
    ComponentLookup[90].mask = 3
    ComponentLookup[90].counts = 328
    ComponentLookup[90].name = "workshop_ShackWallOuterCrnOut02"
    ComponentLookup[91].formid = 920492
    ComponentLookup[91].mask = 3
    ComponentLookup[91].counts = 644
    ComponentLookup[91].name = "workshop_ShackWallOuterCrnOut03A"
    ComponentLookup[92].formid = 920493
    ComponentLookup[92].mask = 3
    ComponentLookup[92].counts = 451
    ComponentLookup[92].name = "workshop_ShackWallOuterCrnOut03B"
    ComponentLookup[93].formid = 920494
    ComponentLookup[93].mask = 3
    ComponentLookup[93].counts = 451
    ComponentLookup[93].name = "workshop_ShackWallOuterCrnOut03C"
    ComponentLookup[94].formid = 2399907
    ComponentLookup[94].mask = 1
    ComponentLookup[94].counts = 3
    ComponentLookup[94].name = "workshop_SteamTMetalDoor01"
    ComponentLookup[95].formid = 2399909
    ComponentLookup[95].mask = 1
    ComponentLookup[95].counts = 3
    ComponentLookup[95].name = "workshop_UtilMetalDoor01"
		
EndFunction

GlobalVariable Property pTweakScanAcidFound Auto Const
GlobalVariable Property pTweakScanAdhesiveFound Auto Const
GlobalVariable Property pTweakScanRubberFound Auto Const
GlobalVariable Property pTweakScanScrewsFound Auto Const
GlobalVariable Property pTweakScanAluminumFound Auto Const
GlobalVariable Property pTweakScanAntiBallisticFiberFound Auto Const
GlobalVariable Property pTweakScanAntisepticFound Auto Const
GlobalVariable Property pTweakScanAsbestosFound Auto Const
GlobalVariable Property pTweakScanBoneFound Auto Const
GlobalVariable Property pTweakScanCeramicFound Auto Const
GlobalVariable Property pTweakScanCircuitryFound Auto Const
GlobalVariable Property pTweakScanClothFound Auto Const
GlobalVariable Property pTweakScanConcreteFound Auto Const
GlobalVariable Property pTweakScanCopperFound Auto Const
GlobalVariable Property pTweakScanCorkFound Auto Const
GlobalVariable Property pTweakScanCrystalFound Auto Const
GlobalVariable Property pTweakScanFertilizerFound Auto Const
GlobalVariable Property pTweakScanFiberglassFound Auto Const
GlobalVariable Property pTweakScanFiberOpticsFound Auto Const
GlobalVariable Property pTweakScanSteelFound Auto Const
GlobalVariable Property pTweakScanSilverFound Auto Const
GlobalVariable Property pTweakScanGearsFound Auto Const
GlobalVariable Property pTweakScanGlassFound Auto Const
GlobalVariable Property pTweakScanGoldFound Auto Const
GlobalVariable Property pTweakScanSpringsFound Auto Const
GlobalVariable Property pTweakScanLeadFound Auto Const
GlobalVariable Property pTweakScanLeatherFound Auto Const
GlobalVariable Property pTweakScanWoodFound Auto Const
GlobalVariable Property pTweakScanPlasticFound Auto Const
GlobalVariable Property pTweakScanNuclearMaterialFound Auto Const
GlobalVariable Property pTweakScanOilFound Auto Const
GlobalVariable Property pTweakScanObjectsFound Auto Const