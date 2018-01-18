Scriptname AFT:TweakScanNCTtoVScript extends Quest

; import AFT

Quest Property TweakScrapScanMaster Auto Const
FormList Property TweakNonConstructed_TtoV Auto Const

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
	string logName = "TweakScanNCTtoVScript"
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
	; while i < 100
		; code += "    ComponentLookup[" + i + "].formid = " + TweakNonConstructed_TtoV.GetAt(i).GetFormID() + "\n"
		; code += "    ComponentLookup[" + i + "].mask = "   + ComponentLookup[i].mask + "\n"
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
	results = center.FindAllReferencesOfType(TweakNonConstructed_TtoV, radius)			
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
	ComponentLookup = new ComponentData[100]
	int i = 0
	while (i < ComponentLookup.length)
		ComponentLookup[i] = new ComponentData
		i += 1
	endWhile
EndFunction

Function initialize_ComponentData()

    ; Array co-insides with FORMLIST. This was generated using Python.
	
    ComponentLookup[0].formid = 1185101
    ComponentLookup[0].mask = 2
    ComponentLookup[0].counts = 12
    ComponentLookup[0].name = "TreeBlastedForestBurntStump01"
    ComponentLookup[1].formid = 1185102
    ComponentLookup[1].mask = 2
    ComponentLookup[1].counts = 12
    ComponentLookup[1].name = "TreeBlastedForestBurntStump02"
    ComponentLookup[2].formid = 1185106
    ComponentLookup[2].mask = 2
    ComponentLookup[2].counts = 12
    ComponentLookup[2].name = "TreeBlastedForestBurntStump03"
    ComponentLookup[3].formid = 1185105
    ComponentLookup[3].mask = 2
    ComponentLookup[3].counts = 12
    ComponentLookup[3].name = "TreeBlastedForestBurntUpright01"
    ComponentLookup[4].formid = 1185103
    ComponentLookup[4].mask = 2
    ComponentLookup[4].counts = 12
    ComponentLookup[4].name = "TreeBlastedForestBurntUpright03"
    ComponentLookup[5].formid = 1193646
    ComponentLookup[5].mask = 2
    ComponentLookup[5].counts = 12
    ComponentLookup[5].name = "TreeBlastedForestDestroyedFallen01"
    ComponentLookup[6].formid = 1193647
    ComponentLookup[6].mask = 2
    ComponentLookup[6].counts = 12
    ComponentLookup[6].name = "TreeBlastedForestDestroyedFallen02"
    ComponentLookup[7].formid = 1193648
    ComponentLookup[7].mask = 2
    ComponentLookup[7].counts = 12
    ComponentLookup[7].name = "TreeBlastedForestDestroyedFallen03"
    ComponentLookup[8].formid = 1193649
    ComponentLookup[8].mask = 2
    ComponentLookup[8].counts = 12
    ComponentLookup[8].name = "TreeBlastedForestDestroyedStump01"
    ComponentLookup[9].formid = 1193650
    ComponentLookup[9].mask = 2
    ComponentLookup[9].counts = 12
    ComponentLookup[9].name = "TreeBlastedForestDestroyedStump02"
    ComponentLookup[10].formid = 1193651
    ComponentLookup[10].mask = 2
    ComponentLookup[10].counts = 12
    ComponentLookup[10].name = "TreeBlastedForestDestroyedStump03"
    ComponentLookup[11].formid = 1193652
    ComponentLookup[11].mask = 2
    ComponentLookup[11].counts = 12
    ComponentLookup[11].name = "TreeBlastedForestDestroyedUpright01"
    ComponentLookup[12].formid = 1193653
    ComponentLookup[12].mask = 2
    ComponentLookup[12].counts = 12
    ComponentLookup[12].name = "TreeBlastedForestDestroyedUpright02"
    ComponentLookup[13].formid = 1193654
    ComponentLookup[13].mask = 2
    ComponentLookup[13].counts = 12
    ComponentLookup[13].name = "TreeBlastedForestDestroyedUpright03"
    ComponentLookup[14].formid = 457268
    ComponentLookup[14].mask = 2
    ComponentLookup[14].counts = 12
    ComponentLookup[14].name = "TreeBlastedM01"
    ComponentLookup[15].formid = 463843
    ComponentLookup[15].mask = 2
    ComponentLookup[15].counts = 12
    ComponentLookup[15].name = "TreeBlastedM02"
    ComponentLookup[16].formid = 463842
    ComponentLookup[16].mask = 2
    ComponentLookup[16].counts = 12
    ComponentLookup[16].name = "TreeBlastedM03"
    ComponentLookup[17].formid = 463841
    ComponentLookup[17].mask = 2
    ComponentLookup[17].counts = 12
    ComponentLookup[17].name = "TreeBlastedM04"
    ComponentLookup[18].formid = 290404
    ComponentLookup[18].mask = 2
    ComponentLookup[18].counts = 30
    ComponentLookup[18].name = "TreeClusterDead01"
    ComponentLookup[19].formid = 385548
    ComponentLookup[19].mask = 2
    ComponentLookup[19].counts = 30
    ComponentLookup[19].name = "TreeClusterDead02"
    ComponentLookup[20].formid = 385549
    ComponentLookup[20].mask = 2
    ComponentLookup[20].counts = 30
    ComponentLookup[20].name = "TreeClusterDead03"
    ComponentLookup[21].formid = 385550
    ComponentLookup[21].mask = 2
    ComponentLookup[21].counts = 30
    ComponentLookup[21].name = "TreeClusterDead04"
    ComponentLookup[22].formid = 1371146
    ComponentLookup[22].mask = 2
    ComponentLookup[22].counts = 30
    ComponentLookup[22].name = "TreeClusterDestroyedFallen01"
    ComponentLookup[23].formid = 1371147
    ComponentLookup[23].mask = 2
    ComponentLookup[23].counts = 30
    ComponentLookup[23].name = "TreeClusterDestroyedFallen02"
    ComponentLookup[24].formid = 1371148
    ComponentLookup[24].mask = 2
    ComponentLookup[24].counts = 30
    ComponentLookup[24].name = "TreeClusterDestroyedFallen03"
    ComponentLookup[25].formid = 1373895
    ComponentLookup[25].mask = 2
    ComponentLookup[25].counts = 30
    ComponentLookup[25].name = "TreeClusterGSFallen01"
    ComponentLookup[26].formid = 1373897
    ComponentLookup[26].mask = 2
    ComponentLookup[26].counts = 30
    ComponentLookup[26].name = "TreeClusterGSFallen02"
    ComponentLookup[27].formid = 1373898
    ComponentLookup[27].mask = 2
    ComponentLookup[27].counts = 30
    ComponentLookup[27].name = "TreeClusterGSFallen03"
    ComponentLookup[28].formid = 182191
    ComponentLookup[28].mask = 2
    ComponentLookup[28].counts = 20
    ComponentLookup[28].name = "TreeClusterVines01"
    ComponentLookup[29].formid = 712367
    ComponentLookup[29].mask = 2
    ComponentLookup[29].counts = 8
    ComponentLookup[29].name = "TreeDriftwood01"
    ComponentLookup[30].formid = 717022
    ComponentLookup[30].mask = 2
    ComponentLookup[30].counts = 8
    ComponentLookup[30].name = "TreeDriftwood02"
    ComponentLookup[31].formid = 717008
    ComponentLookup[31].mask = 2
    ComponentLookup[31].counts = 12
    ComponentLookup[31].name = "TreeDriftwoodLog01"
    ComponentLookup[32].formid = 712387
    ComponentLookup[32].mask = 2
    ComponentLookup[32].counts = 12
    ComponentLookup[32].name = "TreeDriftwoodLog02"
    ComponentLookup[33].formid = 717019
    ComponentLookup[33].mask = 2
    ComponentLookup[33].counts = 12
    ComponentLookup[33].name = "TreeDriftwoodLog03"
    ComponentLookup[34].formid = 712374
    ComponentLookup[34].mask = 2
    ComponentLookup[34].counts = 8
    ComponentLookup[34].name = "TreeDriftwoodStump01"
    ComponentLookup[35].formid = 712376
    ComponentLookup[35].mask = 2
    ComponentLookup[35].counts = 8
    ComponentLookup[35].name = "TreeDriftwoodStump02"
    ComponentLookup[36].formid = 712378
    ComponentLookup[36].mask = 2
    ComponentLookup[36].counts = 8
    ComponentLookup[36].name = "TreeDriftwoodStump03"
    ComponentLookup[37].formid = 712380
    ComponentLookup[37].mask = 2
    ComponentLookup[37].counts = 8
    ComponentLookup[37].name = "TreeDriftwoodStump04"
    ComponentLookup[38].formid = 1099372
    ComponentLookup[38].mask = 2
    ComponentLookup[38].counts = 20
    ComponentLookup[38].name = "TreeFallenSMarsh01"
    ComponentLookup[39].formid = 1097695
    ComponentLookup[39].mask = 2
    ComponentLookup[39].counts = 20
    ComponentLookup[39].name = "TreeFallenSMarsh04"
    ComponentLookup[40].formid = 996812
    ComponentLookup[40].mask = 2
    ComponentLookup[40].counts = 12
    ComponentLookup[40].name = "TreeGS01"
    ComponentLookup[41].formid = 1001361
    ComponentLookup[41].mask = 2
    ComponentLookup[41].counts = 12
    ComponentLookup[41].name = "TreeGS02"
    ComponentLookup[42].formid = 182195
    ComponentLookup[42].mask = 2
    ComponentLookup[42].counts = 30
    ComponentLookup[42].name = "TreeLeanDead01"
    ComponentLookup[43].formid = 290401
    ComponentLookup[43].mask = 2
    ComponentLookup[43].counts = 30
    ComponentLookup[43].name = "TreeLeanDead02"
    ComponentLookup[44].formid = 290402
    ComponentLookup[44].mask = 2
    ComponentLookup[44].counts = 30
    ComponentLookup[44].name = "TreeLeanDead03"
    ComponentLookup[45].formid = 290403
    ComponentLookup[45].mask = 2
    ComponentLookup[45].counts = 30
    ComponentLookup[45].name = "TreeLeanDead04"
    ComponentLookup[46].formid = 290405
    ComponentLookup[46].mask = 2
    ComponentLookup[46].counts = 30
    ComponentLookup[46].name = "TreeLeanDead05"
    ComponentLookup[47].formid = 290415
    ComponentLookup[47].mask = 2
    ComponentLookup[47].counts = 30
    ComponentLookup[47].name = "TreeLeanDead06"
    ComponentLookup[48].formid = 161669
    ComponentLookup[48].mask = 2
    ComponentLookup[48].counts = 30
    ComponentLookup[48].name = "TreeLeanScrub03"
    ComponentLookup[49].formid = 203272
    ComponentLookup[49].mask = 2
    ComponentLookup[49].counts = 30
    ComponentLookup[49].name = "TreeLeanScrub04"
    ComponentLookup[50].formid = 203274
    ComponentLookup[50].mask = 2
    ComponentLookup[50].counts = 30
    ComponentLookup[50].name = "TreeLeanScrub05"
    ComponentLookup[51].formid = 203277
    ComponentLookup[51].mask = 2
    ComponentLookup[51].counts = 30
    ComponentLookup[51].name = "TreeLeanScrub06"
    ComponentLookup[52].formid = 203278
    ComponentLookup[52].mask = 2
    ComponentLookup[52].counts = 30
    ComponentLookup[52].name = "TreeLeanScrub07"
    ComponentLookup[53].formid = 170419
    ComponentLookup[53].mask = 2
    ComponentLookup[53].counts = 12
    ComponentLookup[53].name = "TreeLog01"
    ComponentLookup[54].formid = 173600
    ComponentLookup[54].mask = 2
    ComponentLookup[54].counts = 12
    ComponentLookup[54].name = "TreeLog02"
    ComponentLookup[55].formid = 992579
    ComponentLookup[55].mask = 2
    ComponentLookup[55].counts = 12
    ComponentLookup[55].name = "TreeLogGS01"
    ComponentLookup[56].formid = 993548
    ComponentLookup[56].mask = 2
    ComponentLookup[56].counts = 12
    ComponentLookup[56].name = "TreeLogGS02"
    ComponentLookup[57].formid = 993551
    ComponentLookup[57].mask = 2
    ComponentLookup[57].counts = 12
    ComponentLookup[57].name = "TreeLogGS03"
    ComponentLookup[58].formid = 996808
    ComponentLookup[58].mask = 2
    ComponentLookup[58].counts = 12
    ComponentLookup[58].name = "TreeLogGS04"
    ComponentLookup[59].formid = 996810
    ComponentLookup[59].mask = 2
    ComponentLookup[59].counts = 12
    ComponentLookup[59].name = "TreeLogGS05"
    ComponentLookup[60].formid = 1001359
    ComponentLookup[60].mask = 2
    ComponentLookup[60].counts = 12
    ComponentLookup[60].name = "TreeLogGS06"
    ComponentLookup[61].formid = 254161
    ComponentLookup[61].mask = 2
    ComponentLookup[61].counts = 20
    ComponentLookup[61].name = "TreeMapleForest7"
    ComponentLookup[62].formid = 685062
    ComponentLookup[62].mask = 2
    ComponentLookup[62].counts = 12
    ComponentLookup[62].name = "TreeMapleblasted02LichenFX"
    ComponentLookup[63].formid = 340403
    ComponentLookup[63].mask = 2
    ComponentLookup[63].counts = 12
    ComponentLookup[63].name = "TreeMapleblasted05"
    ComponentLookup[64].formid = 254095
    ComponentLookup[64].mask = 2
    ComponentLookup[64].counts = 12
    ComponentLookup[64].name = "TreeMapleblasted07"
    ComponentLookup[65].formid = 1085826
    ComponentLookup[65].mask = 2
    ComponentLookup[65].counts = 20
    ComponentLookup[65].name = "TreeSMarsh01"
    ComponentLookup[66].formid = 1085837
    ComponentLookup[66].mask = 2
    ComponentLookup[66].counts = 20
    ComponentLookup[66].name = "TreeSMarsh02"
    ComponentLookup[67].formid = 1090240
    ComponentLookup[67].mask = 2
    ComponentLookup[67].counts = 20
    ComponentLookup[67].name = "TreeSMarsh03"
    ComponentLookup[68].formid = 1112697
    ComponentLookup[68].mask = 2
    ComponentLookup[68].counts = 20
    ComponentLookup[68].name = "TreeSMarsh04"
    ComponentLookup[69].formid = 1115091
    ComponentLookup[69].mask = 2
    ComponentLookup[69].counts = 20
    ComponentLookup[69].name = "TreeSMarsh05"
    ComponentLookup[70].formid = 205924
    ComponentLookup[70].mask = 2
    ComponentLookup[70].counts = 8
    ComponentLookup[70].name = "TreeStump01"
    ComponentLookup[71].formid = 207158
    ComponentLookup[71].mask = 2
    ComponentLookup[71].counts = 8
    ComponentLookup[71].name = "TreeStump02"
    ComponentLookup[72].formid = 212820
    ComponentLookup[72].mask = 2
    ComponentLookup[72].counts = 8
    ComponentLookup[72].name = "TreeStump03"
    ComponentLookup[73].formid = 284184
    ComponentLookup[73].mask = 2
    ComponentLookup[73].counts = 8
    ComponentLookup[73].name = "TreeStump04"
    ComponentLookup[74].formid = 992577
    ComponentLookup[74].mask = 2
    ComponentLookup[74].counts = 8
    ComponentLookup[74].name = "TreeStumpGS01"
    ComponentLookup[75].formid = 1077181
    ComponentLookup[75].mask = 2
    ComponentLookup[75].counts = 8
    ComponentLookup[75].name = "TreeStumpSMarsh01"
    ComponentLookup[76].formid = 1085824
    ComponentLookup[76].mask = 2
    ComponentLookup[76].counts = 8
    ComponentLookup[76].name = "TreeStumpSMarsh02"
    ComponentLookup[77].formid = 1085828
    ComponentLookup[77].mask = 2
    ComponentLookup[77].counts = 8
    ComponentLookup[77].name = "TreeStumpSMarsh03"
    ComponentLookup[78].formid = 685060
    ComponentLookup[78].mask = 2
    ComponentLookup[78].counts = 12
    ComponentLookup[78].name = "TreeblastedM04LichenFX"
    ComponentLookup[79].formid = 178395
    ComponentLookup[79].mask = 2
    ComponentLookup[79].counts = 12
    ComponentLookup[79].name = "TreefallenBranch01"
    ComponentLookup[80].formid = 340578
    ComponentLookup[80].mask = 2
    ComponentLookup[80].counts = 12
    ComponentLookup[80].name = "TreefallenBranch02"
    ComponentLookup[81].formid = 689279
    ComponentLookup[81].mask = 1
    ComponentLookup[81].counts = 15
    ComponentLookup[81].name = "Truck01Blue"
    ComponentLookup[82].formid = 689285
    ComponentLookup[82].mask = 1
    ComponentLookup[82].counts = 15
    ComponentLookup[82].name = "Truck01Green"
    ComponentLookup[83].formid = 689282
    ComponentLookup[83].mask = 1
    ComponentLookup[83].counts = 15
    ComponentLookup[83].name = "Truck01Red"
    ComponentLookup[84].formid = 653639
    ComponentLookup[84].mask = 1
    ComponentLookup[84].counts = 15
    ComponentLookup[84].name = "Truck01White"
    ComponentLookup[85].formid = 689280
    ComponentLookup[85].mask = 1
    ComponentLookup[85].counts = 15
    ComponentLookup[85].name = "Truck02Blue"
    ComponentLookup[86].formid = 689286
    ComponentLookup[86].mask = 1
    ComponentLookup[86].counts = 15
    ComponentLookup[86].name = "Truck02Green"
    ComponentLookup[87].formid = 689283
    ComponentLookup[87].mask = 1
    ComponentLookup[87].counts = 15
    ComponentLookup[87].name = "Truck02Red"
    ComponentLookup[88].formid = 689277
    ComponentLookup[88].mask = 1
    ComponentLookup[88].counts = 15
    ComponentLookup[88].name = "Truck02White"
    ComponentLookup[89].formid = 689281
    ComponentLookup[89].mask = 1
    ComponentLookup[89].counts = 15
    ComponentLookup[89].name = "Truck03Blue"
    ComponentLookup[90].formid = 689287
    ComponentLookup[90].mask = 1
    ComponentLookup[90].counts = 15
    ComponentLookup[90].name = "Truck03Green"
    ComponentLookup[91].formid = 689284
    ComponentLookup[91].mask = 1
    ComponentLookup[91].counts = 15
    ComponentLookup[91].name = "Truck03Red"
    ComponentLookup[92].formid = 689278
    ComponentLookup[92].mask = 1
    ComponentLookup[92].counts = 15
    ComponentLookup[92].name = "Truck03White"
    ComponentLookup[93].formid = 1196522
    ComponentLookup[93].mask = 1
    ComponentLookup[93].counts = 10
    ComponentLookup[93].name = "TruckHulkStatic"
    ComponentLookup[94].formid = 638667
    ComponentLookup[94].mask = 17
    ComponentLookup[94].counts = 130
    ComponentLookup[94].name = "UtilitySink"
    ComponentLookup[95].formid = 528647
    ComponentLookup[95].mask = 1
    ComponentLookup[95].counts = 15
    ComponentLookup[95].name = "VaultTecVan01"
    ComponentLookup[96].formid = 407672
    ComponentLookup[96].mask = 1
    ComponentLookup[96].counts = 10
    ComponentLookup[96].name = "VaultTecVan01HulkStatic"
    ComponentLookup[97].formid = 532940
    ComponentLookup[97].mask = 1
    ComponentLookup[97].counts = 15
    ComponentLookup[97].name = "VaultTecVan02"
    ComponentLookup[98].formid = 2115603
    ComponentLookup[98].mask = 1
    ComponentLookup[98].counts = 15
    ComponentLookup[98].name = "VaultTecVan02Blue"
    ComponentLookup[99].formid = 532782
    ComponentLookup[99].mask = 1
    ComponentLookup[99].counts = 10
    ComponentLookup[99].name = "VaultTecVanBare01"
		
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