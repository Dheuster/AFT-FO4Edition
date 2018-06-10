Scriptname AFT:TweakScanNCBtoCScript extends Quest

; import AFT

Quest Property TweakScrapScanMaster Auto Const
FormList Property TweakNonConstructed_BtoC Auto Const

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
	string logName = "TweakScanNCBtoCScript"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Event OnInit()
	initialize_ResultArray()
	initialize_ComponentData()
	
	; PASTE python generated component data without form ids in initialize_ComponentData
	; Uncomment out this loop. Start up game and load mod. Then quit and copy code
	; WITH form ids from log file back into the initialize_ComponentData method
	; below. Recomment this loop. Walla...
	
		
	; string code = "\n"
	; int i = 0
	; while i < 100
		; code += "    ComponentLookup[" + i + "].formid = " + TweakNonConstructed_BtoC.GetAt(i).GetFormID() + "\n"
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
	results = center.FindAllReferencesOfType(TweakNonConstructed_BtoC, radius)			
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
	ComponentLookup = new ComponentData[128]
	int i = 0
	while (i < ComponentLookup.length)
		ComponentLookup[i] = new ComponentData
		i += 1
	endWhile
EndFunction

Function initialize_ComponentData()

    ; Array co-insides with FORMLIST. This was generated using Python.
	if (ComponentLookup.length > 0)
		ComponentLookup.Clear()
	endif
	allocate_ComponentData()
	
    ComponentLookup[0].formid = 215613
    ComponentLookup[0].mask = 528
    ComponentLookup[0].counts = 129
    ComponentLookup[0].name = "BathroomSinkBroken01"
    ComponentLookup[1].formid = 215614
    ComponentLookup[1].mask = 528
    ComponentLookup[1].counts = 129
    ComponentLookup[1].name = "BathroomSinkBroken02"
    ComponentLookup[2].formid = 527863
    ComponentLookup[2].mask = 1
    ComponentLookup[2].counts = 5
    ComponentLookup[2].name = "BathroomStallDoorStatic02"
    ComponentLookup[3].formid = 215616
    ComponentLookup[3].mask = 528
    ComponentLookup[3].counts = 257
    ComponentLookup[3].name = "BathroomToiletBroken02"
    ComponentLookup[4].formid = 215617
    ComponentLookup[4].mask = 528
    ComponentLookup[4].counts = 257
    ComponentLookup[4].name = "BathroomToiletBroken03"
    ComponentLookup[5].formid = 215611
    ComponentLookup[5].mask = 528
    ComponentLookup[5].counts = 257
    ComponentLookup[5].name = "BathroomUrinalBroken01"
    ComponentLookup[6].formid = 730127
    ComponentLookup[6].mask = 2
    ComponentLookup[6].counts = 4
    ComponentLookup[6].name = "BeachFence_Broken01"
    ComponentLookup[7].formid = 730133
    ComponentLookup[7].mask = 2
    ComponentLookup[7].counts = 4
    ComponentLookup[7].name = "BeachFence_Broken02"
    ComponentLookup[8].formid = 730143
    ComponentLookup[8].mask = 2
    ComponentLookup[8].counts = 4
    ComponentLookup[8].name = "BeachFence_Broken03"
    ComponentLookup[9].formid = 730105
    ComponentLookup[9].mask = 2
    ComponentLookup[9].counts = 4
    ComponentLookup[9].name = "BeachFence_BrokenEnd_Left01"
    ComponentLookup[10].formid = 730109
    ComponentLookup[10].mask = 2
    ComponentLookup[10].counts = 4
    ComponentLookup[10].name = "BeachFence_BrokenEnd_Right01"
    ComponentLookup[11].formid = 730108
    ComponentLookup[11].mask = 2
    ComponentLookup[11].counts = 4
    ComponentLookup[11].name = "BeachFence_Corner01"
    ComponentLookup[12].formid = 730135
    ComponentLookup[12].mask = 2
    ComponentLookup[12].counts = 4
    ComponentLookup[12].name = "BeachFence_Gate01"
    ComponentLookup[13].formid = 730120
    ComponentLookup[13].mask = 2
    ComponentLookup[13].counts = 4
    ComponentLookup[13].name = "BeachFence_Lean01"
    ComponentLookup[14].formid = 730129
    ComponentLookup[14].mask = 2
    ComponentLookup[14].counts = 4
    ComponentLookup[14].name = "BeachFence_Lean02"
    ComponentLookup[15].formid = 730106
    ComponentLookup[15].mask = 2
    ComponentLookup[15].counts = 4
    ComponentLookup[15].name = "BeachFence_Long01"
    ComponentLookup[16].formid = 730107
    ComponentLookup[16].mask = 2
    ComponentLookup[16].counts = 4
    ComponentLookup[16].name = "BeachFence_Long02"
    ComponentLookup[17].formid = 730131
    ComponentLookup[17].mask = 2
    ComponentLookup[17].counts = 4
    ComponentLookup[17].name = "BeachFence_Post01"
    ComponentLookup[18].formid = 196007
    ComponentLookup[18].mask = 2
    ComponentLookup[18].counts = 20
    ComponentLookup[18].name = "BedBroken01"
    ComponentLookup[19].formid = 1761785
    ComponentLookup[19].mask = 2
    ComponentLookup[19].counts = 1
    ComponentLookup[19].name = "Beercrate_Moveable"
    ComponentLookup[20].formid = 121132
    ComponentLookup[20].mask = 2
    ComponentLookup[20].counts = 4
    ComponentLookup[20].name = "BldWoodPDoor01"
    ComponentLookup[21].formid = 140643
    ComponentLookup[21].mask = 2
    ComponentLookup[21].counts = 4
    ComponentLookup[21].name = "BldWoodPDoor02"
    ComponentLookup[22].formid = 221533
    ComponentLookup[22].mask = 2
    ComponentLookup[22].counts = 4
    ComponentLookup[22].name = "BldWoodPDoorBroke01"
    ComponentLookup[23].formid = 221532
    ComponentLookup[23].mask = 2
    ComponentLookup[23].counts = 4
    ComponentLookup[23].name = "BldWoodPDoorBroke02"
    ComponentLookup[24].formid = 123604
    ComponentLookup[24].mask = 2
    ComponentLookup[24].counts = 4
    ComponentLookup[24].name = "BldWoodPDoorStatic01"
    ComponentLookup[25].formid = 123603
    ComponentLookup[25].mask = 2
    ComponentLookup[25].counts = 4
    ComponentLookup[25].name = "BldWoodPDoorStatic02"
    ComponentLookup[26].formid = 1150156
    ComponentLookup[26].mask = 4
    ComponentLookup[26].counts = 4
    ComponentLookup[26].name = "BoatFishing01_PartsTire01"
    ComponentLookup[27].formid = 340574
    ComponentLookup[27].mask = 2
    ComponentLookup[27].counts = 8
    ComponentLookup[27].name = "BranchPile01"
    ComponentLookup[28].formid = 234473
    ComponentLookup[28].mask = 2
    ComponentLookup[28].counts = 30
    ComponentLookup[28].name = "BranchPile02"
    ComponentLookup[29].formid = 411517
    ComponentLookup[29].mask = 2
    ComponentLookup[29].counts = 8
    ComponentLookup[29].name = "BranchPile03"
    ComponentLookup[30].formid = 333475
    ComponentLookup[30].mask = 2
    ComponentLookup[30].counts = 8
    ComponentLookup[30].name = "BranchPileBark01"
    ComponentLookup[31].formid = 340570
    ComponentLookup[31].mask = 2
    ComponentLookup[31].counts = 8
    ComponentLookup[31].name = "BranchPileBark02"
    ComponentLookup[32].formid = 216917
    ComponentLookup[32].mask = 2
    ComponentLookup[32].counts = 8
    ComponentLookup[32].name = "BranchPileStump01"
    ComponentLookup[33].formid = 103792
    ComponentLookup[33].mask = 2
    ComponentLookup[33].counts = 8
    ComponentLookup[33].name = "BranchPileStumpRocks01"
    ComponentLookup[34].formid = 103794
    ComponentLookup[34].mask = 2
    ComponentLookup[34].counts = 8
    ComponentLookup[34].name = "BranchPileStumpVines01"
    ComponentLookup[35].formid = 415109
    ComponentLookup[35].mask = 2048
    ComponentLookup[35].counts = 4
    ComponentLookup[35].name = "CampFireMed01_Off_Blocks"
    ComponentLookup[36].formid = 415106
    ComponentLookup[36].mask = 2048
    ComponentLookup[36].counts = 4
    ComponentLookup[36].name = "CampFireMed01_Off_Blocks_NoSkirt"
    ComponentLookup[37].formid = 1781171
    ComponentLookup[37].mask = 1
    ComponentLookup[37].counts = 15
    ComponentLookup[37].name = "CarCoupe01"
    ComponentLookup[38].formid = 1788269
    ComponentLookup[38].mask = 1
    ComponentLookup[38].counts = 10
    ComponentLookup[38].name = "CarCoupe01_Static"
    ComponentLookup[39].formid = 1781172
    ComponentLookup[39].mask = 1
    ComponentLookup[39].counts = 15
    ComponentLookup[39].name = "CarCoupe02"
    ComponentLookup[40].formid = 1788270
    ComponentLookup[40].mask = 1
    ComponentLookup[40].counts = 10
    ComponentLookup[40].name = "CarCoupe02_Static"
    ComponentLookup[41].formid = 1781173
    ComponentLookup[41].mask = 1
    ComponentLookup[41].counts = 15
    ComponentLookup[41].name = "CarCoupe03"
    ComponentLookup[42].formid = 1788271
    ComponentLookup[42].mask = 1
    ComponentLookup[42].counts = 10
    ComponentLookup[42].name = "CarCoupe03_Static"
    ComponentLookup[43].formid = 1781174
    ComponentLookup[43].mask = 1
    ComponentLookup[43].counts = 15
    ComponentLookup[43].name = "CarCoupe04"
    ComponentLookup[44].formid = 1788272
    ComponentLookup[44].mask = 1
    ComponentLookup[44].counts = 10
    ComponentLookup[44].name = "CarCoupe04_Static"
    ComponentLookup[45].formid = 1781175
    ComponentLookup[45].mask = 1
    ComponentLookup[45].counts = 15
    ComponentLookup[45].name = "CarCoupe05"
    ComponentLookup[46].formid = 1788273
    ComponentLookup[46].mask = 1
    ComponentLookup[46].counts = 10
    ComponentLookup[46].name = "CarCoupe05_Static"
    ComponentLookup[47].formid = 1781176
    ComponentLookup[47].mask = 1
    ComponentLookup[47].counts = 15
    ComponentLookup[47].name = "CarCoupe06"
    ComponentLookup[48].formid = 1781177
    ComponentLookup[48].mask = 1
    ComponentLookup[48].counts = 15
    ComponentLookup[48].name = "CarCoupe07"
    ComponentLookup[49].formid = 1781178
    ComponentLookup[49].mask = 1
    ComponentLookup[49].counts = 15
    ComponentLookup[49].name = "CarCoupe08"
    ComponentLookup[50].formid = 1781179
    ComponentLookup[50].mask = 1
    ComponentLookup[50].counts = 15
    ComponentLookup[50].name = "CarCoupe09"
    ComponentLookup[51].formid = 1781180
    ComponentLookup[51].mask = 1
    ComponentLookup[51].counts = 15
    ComponentLookup[51].name = "CarCoupe10"
    ComponentLookup[52].formid = 1781181
    ComponentLookup[52].mask = 1
    ComponentLookup[52].counts = 15
    ComponentLookup[52].name = "CarCoupe11"
    ComponentLookup[53].formid = 2218923
    ComponentLookup[53].mask = 1
    ComponentLookup[53].counts = 10
    ComponentLookup[53].name = "CarCoupe_Postwar_Cheap01"
    ComponentLookup[54].formid = 2218924
    ComponentLookup[54].mask = 1
    ComponentLookup[54].counts = 10
    ComponentLookup[54].name = "CarCoupe_Postwar_Cheap02"
    ComponentLookup[55].formid = 2218925
    ComponentLookup[55].mask = 1
    ComponentLookup[55].counts = 10
    ComponentLookup[55].name = "CarCoupe_Postwar_Cheap03"
    ComponentLookup[56].formid = 2218926
    ComponentLookup[56].mask = 1
    ComponentLookup[56].counts = 10
    ComponentLookup[56].name = "CarCoupe_Postwar_Cheap04"
    ComponentLookup[57].formid = 2218927
    ComponentLookup[57].mask = 1
    ComponentLookup[57].counts = 10
    ComponentLookup[57].name = "CarCoupe_Postwar_Cheap05"
    ComponentLookup[58].formid = 1818565
    ComponentLookup[58].mask = 1
    ComponentLookup[58].counts = 10
    ComponentLookup[58].name = "CarFrame03Static"
    ComponentLookup[59].formid = 1818566
    ComponentLookup[59].mask = 1
    ComponentLookup[59].counts = 10
    ComponentLookup[59].name = "CarFrame04Static"
    ComponentLookup[60].formid = 1818567
    ComponentLookup[60].mask = 1
    ComponentLookup[60].counts = 10
    ComponentLookup[60].name = "CarFrame05Static"
    ComponentLookup[61].formid = 1730050
    ComponentLookup[61].mask = 1
    ComponentLookup[61].counts = 15
    ComponentLookup[61].name = "CarFusionFlea01"
    ComponentLookup[62].formid = 1608992
    ComponentLookup[62].mask = 1
    ComponentLookup[62].counts = 15
    ComponentLookup[62].name = "CarMini01"
    ComponentLookup[63].formid = 347312
    ComponentLookup[63].mask = 1
    ComponentLookup[63].counts = 10
    ComponentLookup[63].name = "CarMini01Static"
    ComponentLookup[64].formid = 1656372
    ComponentLookup[64].mask = 1
    ComponentLookup[64].counts = 15
    ComponentLookup[64].name = "CarSedan01"
    ComponentLookup[65].formid = 1656376
    ComponentLookup[65].mask = 1
    ComponentLookup[65].counts = 15
    ComponentLookup[65].name = "CarSedan02"
    ComponentLookup[66].formid = 1656377
    ComponentLookup[66].mask = 1
    ComponentLookup[66].counts = 15
    ComponentLookup[66].name = "CarSedan03"
    ComponentLookup[67].formid = 1656373
    ComponentLookup[67].mask = 1
    ComponentLookup[67].counts = 15
    ComponentLookup[67].name = "CarSedan04"
    ComponentLookup[68].formid = 1656378
    ComponentLookup[68].mask = 1
    ComponentLookup[68].counts = 15
    ComponentLookup[68].name = "CarSedan05"
    ComponentLookup[69].formid = 1656379
    ComponentLookup[69].mask = 1
    ComponentLookup[69].counts = 15
    ComponentLookup[69].name = "CarSedan06"
    ComponentLookup[70].formid = 1656374
    ComponentLookup[70].mask = 1
    ComponentLookup[70].counts = 15
    ComponentLookup[70].name = "CarSedan07"
    ComponentLookup[71].formid = 1656380
    ComponentLookup[71].mask = 1
    ComponentLookup[71].counts = 15
    ComponentLookup[71].name = "CarSedan08"
    ComponentLookup[72].formid = 1656381
    ComponentLookup[72].mask = 1
    ComponentLookup[72].counts = 15
    ComponentLookup[72].name = "CarSedan09"
    ComponentLookup[73].formid = 1656375
    ComponentLookup[73].mask = 1
    ComponentLookup[73].counts = 15
    ComponentLookup[73].name = "CarSedan10"
    ComponentLookup[74].formid = 1656382
    ComponentLookup[74].mask = 1
    ComponentLookup[74].counts = 15
    ComponentLookup[74].name = "CarSedan11"
    ComponentLookup[75].formid = 1716299
    ComponentLookup[75].mask = 1
    ComponentLookup[75].counts = 15
    ComponentLookup[75].name = "CarSportsCar01"
    ComponentLookup[76].formid = 1716300
    ComponentLookup[76].mask = 1
    ComponentLookup[76].counts = 15
    ComponentLookup[76].name = "CarSportsCar02"
    ComponentLookup[77].formid = 1716301
    ComponentLookup[77].mask = 1
    ComponentLookup[77].counts = 15
    ComponentLookup[77].name = "CarSportsCar03"
    ComponentLookup[78].formid = 1716302
    ComponentLookup[78].mask = 1
    ComponentLookup[78].counts = 15
    ComponentLookup[78].name = "CarSportsCar04"
    ComponentLookup[79].formid = 1716303
    ComponentLookup[79].mask = 1
    ComponentLookup[79].counts = 15
    ComponentLookup[79].name = "CarSportsCar05"
    ComponentLookup[80].formid = 1716304
    ComponentLookup[80].mask = 1
    ComponentLookup[80].counts = 15
    ComponentLookup[80].name = "CarSportsCar06"
    ComponentLookup[81].formid = 1716305
    ComponentLookup[81].mask = 1
    ComponentLookup[81].counts = 15
    ComponentLookup[81].name = "CarSportsCar07"
    ComponentLookup[82].formid = 1716306
    ComponentLookup[82].mask = 1
    ComponentLookup[82].counts = 15
    ComponentLookup[82].name = "CarSportsCar08"
    ComponentLookup[83].formid = 1716307
    ComponentLookup[83].mask = 1
    ComponentLookup[83].counts = 15
    ComponentLookup[83].name = "CarSportsCar09"
    ComponentLookup[84].formid = 1716308
    ComponentLookup[84].mask = 1
    ComponentLookup[84].counts = 15
    ComponentLookup[84].name = "CarSportsCar10"
    ComponentLookup[85].formid = 1716309
    ComponentLookup[85].mask = 1
    ComponentLookup[85].counts = 15
    ComponentLookup[85].name = "CarSportsCar11"
    ComponentLookup[86].formid = 1804966
    ComponentLookup[86].mask = 1
    ComponentLookup[86].counts = 15
    ComponentLookup[86].name = "CarStationWagon01"
    ComponentLookup[87].formid = 1804967
    ComponentLookup[87].mask = 1
    ComponentLookup[87].counts = 15
    ComponentLookup[87].name = "CarStationWagon02"
    ComponentLookup[88].formid = 1804968
    ComponentLookup[88].mask = 1
    ComponentLookup[88].counts = 15
    ComponentLookup[88].name = "CarStationWagon03"
    ComponentLookup[89].formid = 1804969
    ComponentLookup[89].mask = 1
    ComponentLookup[89].counts = 15
    ComponentLookup[89].name = "CarStationWagon04"
    ComponentLookup[90].formid = 1804970
    ComponentLookup[90].mask = 1
    ComponentLookup[90].counts = 15
    ComponentLookup[90].name = "CarStationWagon05"
    ComponentLookup[91].formid = 1804971
    ComponentLookup[91].mask = 1
    ComponentLookup[91].counts = 15
    ComponentLookup[91].name = "CarStationWagon06"
    ComponentLookup[92].formid = 1804972
    ComponentLookup[92].mask = 1
    ComponentLookup[92].counts = 15
    ComponentLookup[92].name = "CarStationWagon07"
    ComponentLookup[93].formid = 1804973
    ComponentLookup[93].mask = 1
    ComponentLookup[93].counts = 15
    ComponentLookup[93].name = "CarStationWagon08"
    ComponentLookup[94].formid = 1804974
    ComponentLookup[94].mask = 1
    ComponentLookup[94].counts = 15
    ComponentLookup[94].name = "CarStationWagon09"
    ComponentLookup[95].formid = 1804975
    ComponentLookup[95].mask = 1
    ComponentLookup[95].counts = 15
    ComponentLookup[95].name = "CarStationWagon10"
    ComponentLookup[96].formid = 1804976
    ComponentLookup[96].mask = 1
    ComponentLookup[96].counts = 15
    ComponentLookup[96].name = "CarStationWagon11"
    ComponentLookup[97].formid = 1428615
    ComponentLookup[97].mask = 8
    ComponentLookup[97].counts = 1
    ComponentLookup[97].name = "CarpetRectangle01"
    ComponentLookup[98].formid = 1428616
    ComponentLookup[98].mask = 8
    ComponentLookup[98].counts = 1
    ComponentLookup[98].name = "CarpetRectangle02"	
    ComponentLookup[99].formid = 1428703
    ComponentLookup[99].mask = 8
    ComponentLookup[99].counts = 1
    ComponentLookup[99].name = "CarpetSquare01"
    ComponentLookup[100].formid = 0x000F15C8
    ComponentLookup[100].mask = 1
    ComponentLookup[100].counts = 2
    ComponentLookup[100].name = "CapsuleExtStairsFree01"
    ComponentLookup[101].formid = 0x000521ED
    ComponentLookup[101].mask = 1
    ComponentLookup[101].counts = 5
    ComponentLookup[101].name = "CapsuleExtWall01"
    ComponentLookup[102].formid = 0x000521F5
    ComponentLookup[102].mask = 1
    ComponentLookup[102].counts = 3
    ComponentLookup[102].name = "CapsuleExtWallEnd01"
    ComponentLookup[103].formid = 0x000203D3
    ComponentLookup[103].mask = 1
    ComponentLookup[103].counts = 3
    ComponentLookup[103].name = "CapsuleExtWallEndFan01"
    ComponentLookup[104].formid = 0x000521DF
    ComponentLookup[104].mask = 1
    ComponentLookup[104].counts = 5
    ComponentLookup[104].name = "CapsuleExtWallExSmL01"
    ComponentLookup[105].formid = 0x0010796A
    ComponentLookup[105].mask = 1
    ComponentLookup[105].counts = 4
    ComponentLookup[105].name = "CapsuleExtWallExSmL01a"
    ComponentLookup[106].formid = 0x0001346C
    ComponentLookup[106].mask = 1
    ComponentLookup[106].counts = 2
    ComponentLookup[106].name = "CapsuleExtWallExSmLDoor01"
    ComponentLookup[107].formid = 0x00013469
    ComponentLookup[107].mask = 1
    ComponentLookup[107].counts = 5
    ComponentLookup[107].name = "CapsuleExtWallExSmR01"
    ComponentLookup[108].formid = 0x0010796C
    ComponentLookup[108].mask = 1
    ComponentLookup[108].counts = 5
    ComponentLookup[108].name = "CapsuleExtWallExSmR01a"
    ComponentLookup[109].formid = 0x0001346D
    ComponentLookup[109].mask = 1
    ComponentLookup[109].counts = 2
    ComponentLookup[109].name = "CapsuleExtWallExSmRDoor01"
    ComponentLookup[110].formid = 0x0001327F
    ComponentLookup[110].mask = 1
    ComponentLookup[110].counts = 5
    ComponentLookup[110].name = "CapsuleExtWallWin01"
    ComponentLookup[111].formid = 0x0010796E
    ComponentLookup[111].mask = 1
    ComponentLookup[111].counts = 5
    ComponentLookup[111].name = "CapsuleExtWallWin01a"
    ComponentLookup[112].formid = 0x00013280
    ComponentLookup[112].mask = 1
    ComponentLookup[112].counts = 2
    ComponentLookup[112].name = "CapsuleIntPartitionCurved01"
    ComponentLookup[113].formid = 0x00013464
    ComponentLookup[113].mask = 1
    ComponentLookup[113].counts = 2
    ComponentLookup[113].name = "CapsuleIntPartitionFlat01"
    ComponentLookup[114].formid = 0x000521E5
    ComponentLookup[114].mask = 1
    ComponentLookup[114].counts = 2
    ComponentLookup[114].name = "CapsuleIntWallExSmDbl01"
    ComponentLookup[115].formid = 0x000521E0
    ComponentLookup[115].mask = 1
    ComponentLookup[115].counts = 4
    ComponentLookup[115].name = "CapsuleIntWallExSmL01"
    ComponentLookup[116].formid = 0x000521F3
    ComponentLookup[116].mask = 1
    ComponentLookup[116].counts = 4
    ComponentLookup[116].name = "CapsuleIntWallExSmLCap01"
    ComponentLookup[117].formid = 0x0001346E
    ComponentLookup[117].mask = 1
    ComponentLookup[117].counts = 2
    ComponentLookup[117].name = "CapsuleIntWallExSmLDoor01"
    ComponentLookup[118].formid = 0x000521E6
    ComponentLookup[118].mask = 1
    ComponentLookup[118].counts = 4
    ComponentLookup[118].name = "CapsuleIntWallExSmR01"
    ComponentLookup[119].formid = 0x000521F4
    ComponentLookup[119].mask = 1
    ComponentLookup[119].counts = 4
    ComponentLookup[119].name = "CapsuleIntWallExSmRCap01"
    ComponentLookup[120].formid = 0x0001346F
    ComponentLookup[120].mask = 1
    ComponentLookup[120].counts = 2
    ComponentLookup[120].name = "CapsuleIntWallExSmRDoor01"
    ComponentLookup[121].formid = 0x0004D23F
    ComponentLookup[121].mask = 1
    ComponentLookup[121].counts = 12
    ComponentLookup[121].name = "CapsuleMain01"
    ComponentLookup[122].formid = 0x000203E3
    ComponentLookup[122].mask = 1
    ComponentLookup[122].counts = 8
    ComponentLookup[122].name = "CapsuleMain4Way01"
    ComponentLookup[123].formid = 0x0002947C
    ComponentLookup[123].mask = 1
    ComponentLookup[123].counts = 12
    ComponentLookup[123].name = "CapsuleMainNoSup01"
    ComponentLookup[124].formid = 0x00013467
    ComponentLookup[124].mask = 1
    ComponentLookup[124].counts = 12
    ComponentLookup[124].name = "CapsuleMainSunRoof01"
    ComponentLookup[125].formid = 0x0010796F
    ComponentLookup[125].mask = 1
    ComponentLookup[125].counts = 12
    ComponentLookup[125].name = "CapsuleMainSunRoof01a"
    ComponentLookup[126].formid = 0x00013468
    ComponentLookup[126].mask = 1
    ComponentLookup[126].counts = 12
    ComponentLookup[126].name = "CapsuleMainSunRoof02"
    ComponentLookup[127].formid = 0x0010796D
    ComponentLookup[127].mask = 1
    ComponentLookup[127].counts = 12
    ComponentLookup[127].name = "CapsuleMainSunRoof02a"
	
EndFunction


; OLD IMPL : Binary search against sorted list (OnInit), however
; found that Array.FindStruct performed just as fast, at least 
; up to 100 elements. 

;ComponentData Function GetComponents(Form item)
;
;	int formid = item.GetFormID()
;	int left  = 0
;	int right = 99  ; ComponentLookup.length
;	int mid
;	
;	while (left < right)
;		mid = left + (((right - left)/2) as Int)
;		if (formid < ComponentLookup[mid].formid)
;			right = mid
;		elseif (formid == ComponentLookup[mid].formid)
;			return ComponentLookup[mid]
;		else
;			left = mid + 1
;		endif
;	endwhile
;	
;	; if (formid == ComponentLookup[left].formid)
;	; 	return ComponentLookup[left]
;	; endif
;	
;	return ComponentLookup[left]
;	
;EndFunction

; Insert Sort with header offset if the front is already sorted ( Usefull if you use the new ARRAY.Add()
; method. You dont have to resort the whole list from scratch... )

;Function BinSort(ComponentData[] data, int start = 0)
;
;	Trace("BinSort()")
;
;	int len = data.length
;	if (0 == start)
;		start = 1
;	endif
;	if (start > len)
;		return
;	endif
;	int mid
;	while (start < len)
;		ComponentData pivot = data[start];
;		int left  = 0;
;		int right = start;
;		while (left < right)
;			mid = left + (((right - left)/2) as Int)
;			if (pivot.formid < data[mid].formid)
;				right = mid
;			else
;				left = mid + 1
;			endif
;		endwhile
;		
;		; BinSort([1,4,6,7,2],4):
;		;
;		; [1,4,6,7,2]
;		;    ^     ^
;		;    |     |-- start
;		;    |--------left
;		
;		right = start
;		while right > left
;			data[right] = data[right - 1]
;			right -= 1
;		endwhile
;		data[right] = pivot
;		start += 1
;	endWhile
;
;endFunction

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
GlobalVariable Property pTweakScanObjectsFound Auto Const