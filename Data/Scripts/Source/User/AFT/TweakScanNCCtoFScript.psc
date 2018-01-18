Scriptname AFT:TweakScanNCCtoFScript extends Quest

; import AFT

Quest Property TweakScrapScanMaster Auto Const
FormList Property TweakNonConstructed_CtoF Auto Const

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
	string logName = "TweakScanNCCtoFScript"
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
		; code += "    ComponentLookup[" + i + "].formid = " + TweakNonConstructed_CtoF.GetAt(i).GetFormID() + "\n"
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
	results = center.FindAllReferencesOfType(TweakNonConstructed_CtoF, radius)			
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
	
    ComponentLookup[0].formid = 1428623
    ComponentLookup[0].mask = 8
    ComponentLookup[0].counts = 1
    ComponentLookup[0].name = "CarpetSquare02"
    ComponentLookup[1].formid = 315912
    ComponentLookup[1].mask = 9349
    ComponentLookup[1].counts = 17842311
    ComponentLookup[1].name = "CartDiagnosticGarage01"
    ComponentLookup[2].formid = 315911
    ComponentLookup[2].mask = 1
    ComponentLookup[2].counts = 5
    ComponentLookup[2].name = "CartWheeledGarage01"
    ComponentLookup[3].formid = 7677
    ComponentLookup[3].mask = 2048
    ComponentLookup[3].counts = 2
    ComponentLookup[3].name = "CinderBlockSingle01"
    ComponentLookup[4].formid = 7678
    ComponentLookup[4].mask = 2048
    ComponentLookup[4].counts = 2
    ComponentLookup[4].name = "CinderBlockSingle02"
    ComponentLookup[5].formid = 7679
    ComponentLookup[5].mask = 2048
    ComponentLookup[5].counts = 2
    ComponentLookup[5].name = "CinderBlockSingle03"
    ComponentLookup[6].formid = 7680
    ComponentLookup[6].mask = 2048
    ComponentLookup[6].counts = 2
    ComponentLookup[6].name = "CinderBlockSquare01"
    ComponentLookup[7].formid = 7681
    ComponentLookup[7].mask = 2048
    ComponentLookup[7].counts = 2
    ComponentLookup[7].name = "CinderBlockSquare02"
    ComponentLookup[8].formid = 14812
    ComponentLookup[8].mask = 2050
    ComponentLookup[8].counts = 388
    ComponentLookup[8].name = "CinderBlockStairs01"
    ComponentLookup[9].formid = 14816
    ComponentLookup[9].mask = 2050
    ComponentLookup[9].counts = 388
    ComponentLookup[9].name = "CinderBlockStairs02"
    ComponentLookup[10].formid = 7689
    ComponentLookup[10].mask = 2048
    ComponentLookup[10].counts = 6
    ComponentLookup[10].name = "CinderBlocks01"
    ComponentLookup[11].formid = 7690
    ComponentLookup[11].mask = 2048
    ComponentLookup[11].counts = 6
    ComponentLookup[11].name = "CinderBlocks02"
    ComponentLookup[12].formid = 7691
    ComponentLookup[12].mask = 2048
    ComponentLookup[12].counts = 6
    ComponentLookup[12].name = "CinderBlocks03"
    ComponentLookup[13].formid = 7692
    ComponentLookup[13].mask = 2048
    ComponentLookup[13].counts = 6
    ComponentLookup[13].name = "CinderBlocks04"
    ComponentLookup[14].formid = 7693
    ComponentLookup[14].mask = 2048
    ComponentLookup[14].counts = 4
    ComponentLookup[14].name = "CinderBlocks05"
    ComponentLookup[15].formid = 7694
    ComponentLookup[15].mask = 2048
    ComponentLookup[15].counts = 4
    ComponentLookup[15].name = "CinderBlocks06"
    ComponentLookup[16].formid = 7674
    ComponentLookup[16].mask = 2048
    ComponentLookup[16].counts = 4
    ComponentLookup[16].name = "CinderBlocks07"
    ComponentLookup[17].formid = 7675
    ComponentLookup[17].mask = 2048
    ComponentLookup[17].counts = 4
    ComponentLookup[17].name = "CinderBlocks08"
    ComponentLookup[18].formid = 7676
    ComponentLookup[18].mask = 2048
    ComponentLookup[18].counts = 2
    ComponentLookup[18].name = "CinderBlocks09"
    ComponentLookup[19].formid = 969736
    ComponentLookup[19].mask = 4
    ComponentLookup[19].counts = 4
    ComponentLookup[19].name = "CoastMossTire01"
    ComponentLookup[20].formid = 135661
    ComponentLookup[20].mask = 133
    ComponentLookup[20].counts = 8522
    ComponentLookup[20].name = "ColonialLamppost01"
    ComponentLookup[21].formid = 149574
    ComponentLookup[21].mask = 3
    ComponentLookup[21].counts = 130
    ComponentLookup[21].name = "ConstructionBarrier01"
    ComponentLookup[22].formid = 1010682
    ComponentLookup[22].mask = 3
    ComponentLookup[22].counts = 130
    ComponentLookup[22].name = "ConstructionBarrier01Dest"
    ComponentLookup[23].formid = 149576
    ComponentLookup[23].mask = 3
    ComponentLookup[23].counts = 130
    ComponentLookup[23].name = "ConstructionBarrier02"
    ComponentLookup[24].formid = 1009514
    ComponentLookup[24].mask = 3
    ComponentLookup[24].counts = 130
    ComponentLookup[24].name = "ConstructionBarrier02Dest"
    ComponentLookup[25].formid = 447303
    ComponentLookup[25].mask = 3
    ComponentLookup[25].counts = 132
    ComponentLookup[25].name = "DeerFence_Broken01"
    ComponentLookup[26].formid = 447304
    ComponentLookup[26].mask = 3
    ComponentLookup[26].counts = 132
    ComponentLookup[26].name = "DeerFence_Broken02"
    ComponentLookup[27].formid = 730136
    ComponentLookup[27].mask = 3
    ComponentLookup[27].counts = 132
    ComponentLookup[27].name = "DeerFence_Broken03"
    ComponentLookup[28].formid = 389986
    ComponentLookup[28].mask = 3
    ComponentLookup[28].counts = 132
    ComponentLookup[28].name = "DeerFence_BrokenEnd_Left01"
    ComponentLookup[29].formid = 389983
    ComponentLookup[29].mask = 3
    ComponentLookup[29].counts = 132
    ComponentLookup[29].name = "DeerFence_BrokenEnd_Right01"
    ComponentLookup[30].formid = 447301
    ComponentLookup[30].mask = 3
    ComponentLookup[30].counts = 132
    ComponentLookup[30].name = "DeerFence_Gate01"
    ComponentLookup[31].formid = 385259
    ComponentLookup[31].mask = 2
    ComponentLookup[31].counts = 2
    ComponentLookup[31].name = "DeerFence_Post03"
    ComponentLookup[32].formid = 385261
    ComponentLookup[32].mask = 2
    ComponentLookup[32].counts = 2
    ComponentLookup[32].name = "DeerFence_Post04"
    ComponentLookup[33].formid = 385266
    ComponentLookup[33].mask = 2
    ComponentLookup[33].counts = 2
    ComponentLookup[33].name = "DeerFence_Post05"
    ComponentLookup[34].formid = 447315
    ComponentLookup[34].mask = 1
    ComponentLookup[34].counts = 4
    ComponentLookup[34].name = "DeerFence_Roll01"
    ComponentLookup[35].formid = 1588483
    ComponentLookup[35].mask = 1
    ComponentLookup[35].counts = 4
    ComponentLookup[35].name = "DriveInSpeaker"
    ComponentLookup[36].formid = 292413
    ComponentLookup[36].mask = 21
    ComponentLookup[36].counts = 8258
    ComponentLookup[36].name = "Empty_NukaColaMachineBroken"
    ComponentLookup[37].formid = 351449
    ComponentLookup[37].mask = 21
    ComponentLookup[37].counts = 8258
    ComponentLookup[37].name = "Empty_NukaColaMachineBroken01"
    ComponentLookup[38].formid = 294779
    ComponentLookup[38].mask = 1
    ComponentLookup[38].counts = 6
    ComponentLookup[38].name = "EngineCarDestructible01"
    ComponentLookup[39].formid = 185735
    ComponentLookup[39].mask = 1
    ComponentLookup[39].counts = 4
    ComponentLookup[39].name = "ExtRubble_HiTec_Debris01"
    ComponentLookup[40].formid = 1267600
    ComponentLookup[40].mask = 1
    ComponentLookup[40].counts = 2
    ComponentLookup[40].name = "ExtRubble_HiTec_Debris03"
    ComponentLookup[41].formid = 1267595
    ComponentLookup[41].mask = 1
    ComponentLookup[41].counts = 2
    ComponentLookup[41].name = "ExtRubble_HiTec_Debris04"
    ComponentLookup[42].formid = 1267597
    ComponentLookup[42].mask = 1
    ComponentLookup[42].counts = 2
    ComponentLookup[42].name = "ExtRubble_HiTec_Debris06"
    ComponentLookup[43].formid = 652331
    ComponentLookup[43].mask = 2
    ComponentLookup[43].counts = 20
    ComponentLookup[43].name = "FancyBureauEmpty01"
    ComponentLookup[44].formid = 654935
    ComponentLookup[44].mask = 2
    ComponentLookup[44].counts = 20
    ComponentLookup[44].name = "FancyCurioEmpty01"
    ComponentLookup[45].formid = 1684834
    ComponentLookup[45].mask = 2
    ComponentLookup[45].counts = 20
    ComponentLookup[45].name = "FederalistBookcase01Debris01"
    ComponentLookup[46].formid = 1684836
    ComponentLookup[46].mask = 2
    ComponentLookup[46].counts = 20
    ComponentLookup[46].name = "FederalistBookcase01Debris02"
    ComponentLookup[47].formid = 1684838
    ComponentLookup[47].mask = 2
    ComponentLookup[47].counts = 20
    ComponentLookup[47].name = "FederalistBookcase01Debris03"
    ComponentLookup[48].formid = 1684843
    ComponentLookup[48].mask = 2
    ComponentLookup[48].counts = 20
    ComponentLookup[48].name = "FederalistBookcaseShort01Debris01"
    ComponentLookup[49].formid = 1684849
    ComponentLookup[49].mask = 2
    ComponentLookup[49].counts = 20
    ComponentLookup[49].name = "FederalistBookcaseShort01Debris02"
    ComponentLookup[50].formid = 1512958
    ComponentLookup[50].mask = 2
    ComponentLookup[50].counts = 20
    ComponentLookup[50].name = "FederalistBookcaseShort_Broken"
    ComponentLookup[51].formid = 1684851
    ComponentLookup[51].mask = 2
    ComponentLookup[51].counts = 20
    ComponentLookup[51].name = "FederalistBookcaseShort_BrokenDebris01"
    ComponentLookup[52].formid = 1684853
    ComponentLookup[52].mask = 2
    ComponentLookup[52].counts = 20
    ComponentLookup[52].name = "FederalistBookcaseStack01Debris01"
    ComponentLookup[53].formid = 1684855
    ComponentLookup[53].mask = 2
    ComponentLookup[53].counts = 20
    ComponentLookup[53].name = "FederalistBookcaseStack01Debris02"
    ComponentLookup[54].formid = 1684857
    ComponentLookup[54].mask = 2
    ComponentLookup[54].counts = 20
    ComponentLookup[54].name = "FederalistBookcaseStack01Debris03"
    ComponentLookup[55].formid = 1512957
    ComponentLookup[55].mask = 2
    ComponentLookup[55].counts = 20
    ComponentLookup[55].name = "FederalistBookcaseStack_Broken01"
    ComponentLookup[56].formid = 1684859
    ComponentLookup[56].mask = 2
    ComponentLookup[56].counts = 20
    ComponentLookup[56].name = "FederalistBookcaseStack_Broken01Debris01"
    ComponentLookup[57].formid = 1512950
    ComponentLookup[57].mask = 2
    ComponentLookup[57].counts = 20
    ComponentLookup[57].name = "FederalistBookcase_Broken01"
    ComponentLookup[58].formid = 1684840
    ComponentLookup[58].mask = 2
    ComponentLookup[58].counts = 20
    ComponentLookup[58].name = "FederalistBookcase_Broken01Debris01"
    ComponentLookup[59].formid = 1684842
    ComponentLookup[59].mask = 2
    ComponentLookup[59].counts = 20
    ComponentLookup[59].name = "FederalistBookcase_Broken01Debris02"
    ComponentLookup[60].formid = 1512953
    ComponentLookup[60].mask = 2
    ComponentLookup[60].counts = 20
    ComponentLookup[60].name = "FederalistBookcase_Broken02"
    ComponentLookup[61].formid = 1684845
    ComponentLookup[61].mask = 2
    ComponentLookup[61].counts = 20
    ComponentLookup[61].name = "FederalistBookcase_Broken02Debris01"
    ComponentLookup[62].formid = 1512955
    ComponentLookup[62].mask = 2
    ComponentLookup[62].counts = 20
    ComponentLookup[62].name = "FederalistBookcase_Broken03"
    ComponentLookup[63].formid = 1684847
    ComponentLookup[63].mask = 2
    ComponentLookup[63].counts = 20
    ComponentLookup[63].name = "FederalistBookcase_Broken03Debris01"
    ComponentLookup[64].formid = 1684861
    ComponentLookup[64].mask = 2
    ComponentLookup[64].counts = 4
    ComponentLookup[64].name = "FederalistCoffeeTable01Debris01"
    ComponentLookup[65].formid = 1684863
    ComponentLookup[65].mask = 2
    ComponentLookup[65].counts = 4
    ComponentLookup[65].name = "FederalistCoffeeTable01Debris02"
    ComponentLookup[66].formid = 1684865
    ComponentLookup[66].mask = 2
    ComponentLookup[66].counts = 4
    ComponentLookup[66].name = "FederalistCoffeeTable01Debris03"
    ComponentLookup[67].formid = 1684867
    ComponentLookup[67].mask = 2
    ComponentLookup[67].counts = 4
    ComponentLookup[67].name = "FederalistCoffeeTableSmall01Debris01"
    ComponentLookup[68].formid = 1684869
    ComponentLookup[68].mask = 2
    ComponentLookup[68].counts = 4
    ComponentLookup[68].name = "FederalistCoffeeTableSmall01Debris02"
    ComponentLookup[69].formid = 7707
    ComponentLookup[69].mask = 1
    ComponentLookup[69].counts = 2
    ComponentLookup[69].name = "FenceChainlink01"
    ComponentLookup[70].formid = 632584
    ComponentLookup[70].mask = 1
    ComponentLookup[70].counts = 2
    ComponentLookup[70].name = "FenceChainlink01Electric"
    ComponentLookup[71].formid = 7704
    ComponentLookup[71].mask = 1
    ComponentLookup[71].counts = 2
    ComponentLookup[71].name = "FenceChainlink01R"
    ComponentLookup[72].formid = 7705
    ComponentLookup[72].mask = 1
    ComponentLookup[72].counts = 2
    ComponentLookup[72].name = "FenceChainlink01RR"
    ComponentLookup[73].formid = 7708
    ComponentLookup[73].mask = 1
    ComponentLookup[73].counts = 2
    ComponentLookup[73].name = "FenceChainlink02"
    ComponentLookup[74].formid = 7702
    ComponentLookup[74].mask = 1
    ComponentLookup[74].counts = 2
    ComponentLookup[74].name = "FenceChainlink03"
    ComponentLookup[75].formid = 138925
    ComponentLookup[75].mask = 1
    ComponentLookup[75].counts = 2
    ComponentLookup[75].name = "FenceChainlinkCornerIn01"
    ComponentLookup[76].formid = 140251
    ComponentLookup[76].mask = 1
    ComponentLookup[76].counts = 2
    ComponentLookup[76].name = "FenceChainlinkCornerIn01R"
    ComponentLookup[77].formid = 140254
    ComponentLookup[77].mask = 1
    ComponentLookup[77].counts = 2
    ComponentLookup[77].name = "FenceChainlinkCornerIn01RR"
    ComponentLookup[78].formid = 138935
    ComponentLookup[78].mask = 1
    ComponentLookup[78].counts = 2
    ComponentLookup[78].name = "FenceChainlinkCornerOut01"
    ComponentLookup[79].formid = 274614
    ComponentLookup[79].mask = 1
    ComponentLookup[79].counts = 2
    ComponentLookup[79].name = "FenceChainlinkDown128"
    ComponentLookup[80].formid = 274615
    ComponentLookup[80].mask = 1
    ComponentLookup[80].counts = 2
    ComponentLookup[80].name = "FenceChainlinkDown256"
    ComponentLookup[81].formid = 386418
    ComponentLookup[81].mask = 1
    ComponentLookup[81].counts = 2
    ComponentLookup[81].name = "FenceChainlinkDown32"
    ComponentLookup[82].formid = 274616
    ComponentLookup[82].mask = 1
    ComponentLookup[82].counts = 2
    ComponentLookup[82].name = "FenceChainlinkDown64"
    ComponentLookup[83].formid = 180603
    ComponentLookup[83].mask = 1
    ComponentLookup[83].counts = 2
    ComponentLookup[83].name = "FenceChainlinkEndLeft01R"
    ComponentLookup[84].formid = 180605
    ComponentLookup[84].mask = 1
    ComponentLookup[84].counts = 2
    ComponentLookup[84].name = "FenceChainlinkEndLeft02RR"
    ComponentLookup[85].formid = 180606
    ComponentLookup[85].mask = 1
    ComponentLookup[85].counts = 2
    ComponentLookup[85].name = "FenceChainlinkEndRight01R"
    ComponentLookup[86].formid = 180600
    ComponentLookup[86].mask = 1
    ComponentLookup[86].counts = 2
    ComponentLookup[86].name = "FenceChainlinkEndRight02RR"
    ComponentLookup[87].formid = 20038
    ComponentLookup[87].mask = 1
    ComponentLookup[87].counts = 2
    ComponentLookup[87].name = "FenceChainlinkGate01"
    ComponentLookup[88].formid = 140253
    ComponentLookup[88].mask = 1
    ComponentLookup[88].counts = 2
    ComponentLookup[88].name = "FenceChainlinkGate01R"
    ComponentLookup[89].formid = 180667
    ComponentLookup[89].mask = 1
    ComponentLookup[89].counts = 2
    ComponentLookup[89].name = "FenceChainlinkGate02"
    ComponentLookup[90].formid = 386411
    ComponentLookup[90].mask = 1
    ComponentLookup[90].counts = 2
    ComponentLookup[90].name = "FenceChainlinkGateLarge01"
    ComponentLookup[91].formid = 349776
    ComponentLookup[91].mask = 1
    ComponentLookup[91].counts = 2
    ComponentLookup[91].name = "FenceChainlinkGateLarge01R"
    ComponentLookup[92].formid = 386423
    ComponentLookup[92].mask = 1
    ComponentLookup[92].counts = 2
    ComponentLookup[92].name = "FenceChainlinkGateLarge02"
    ComponentLookup[93].formid = 1119001
    ComponentLookup[93].mask = 1
    ComponentLookup[93].counts = 2
    ComponentLookup[93].name = "FenceChainlinkGateStandAlone01"
    ComponentLookup[94].formid = 180664
    ComponentLookup[94].mask = 1
    ComponentLookup[94].counts = 2
    ComponentLookup[94].name = "FenceChainlinkHalf01"
    ComponentLookup[95].formid = 180625
    ComponentLookup[95].mask = 1
    ComponentLookup[95].counts = 2
    ComponentLookup[95].name = "FenceChainlinkHalf01R"
    ComponentLookup[96].formid = 180579
    ComponentLookup[96].mask = 1
    ComponentLookup[96].counts = 2
    ComponentLookup[96].name = "FenceChainlinkHalfNoPost01"
    ComponentLookup[97].formid = 180578
    ComponentLookup[97].mask = 1
    ComponentLookup[97].counts = 2
    ComponentLookup[97].name = "FenceChainlinkNoPost01"
    ComponentLookup[98].formid = 7706
    ComponentLookup[98].mask = 1
    ComponentLookup[98].counts = 2
    ComponentLookup[98].name = "FenceChainlinkPost01"
    ComponentLookup[99].formid = 274605
    ComponentLookup[99].mask = 1
    ComponentLookup[99].counts = 2
    ComponentLookup[99].name = "FenceChainlinkUp128"
		
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