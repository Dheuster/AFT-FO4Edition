Scriptname AFT:TweakScanNCFtoOScript extends Quest

; import AFT

Quest Property TweakScrapScanMaster Auto Const
FormList Property TweakNonConstructed_FtoO Auto Const

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
	string logName = "TweakScanNCFtoOScript"
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
		; code += "    ComponentLookup[" + i + "].formid = " + TweakNonConstructed_FtoO.GetAt(i).GetFormID() + "\n"
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
	results = center.FindAllReferencesOfType(TweakNonConstructed_FtoO, radius)			
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
	
    ComponentLookup[0].formid = 274608
    ComponentLookup[0].mask = 1
    ComponentLookup[0].counts = 2
    ComponentLookup[0].name = "FenceChainlinkUp256"
    ComponentLookup[1].formid = 386417
    ComponentLookup[1].mask = 1
    ComponentLookup[1].counts = 2
    ComponentLookup[1].name = "FenceChainlinkUp32"
    ComponentLookup[2].formid = 274604
    ComponentLookup[2].mask = 1
    ComponentLookup[2].counts = 2
    ComponentLookup[2].name = "FenceChainlinkUp64"
    ComponentLookup[3].formid = 1590518
    ComponentLookup[3].mask = 1
    ComponentLookup[3].counts = 2
    ComponentLookup[3].name = "FenceWIRailingDamFree01"
    ComponentLookup[4].formid = 1590525
    ComponentLookup[4].mask = 1
    ComponentLookup[4].counts = 2
    ComponentLookup[4].name = "FenceWIRailingDamFree02"
    ComponentLookup[5].formid = 1146166
    ComponentLookup[5].mask = 3
    ComponentLookup[5].counts = 132
    ComponentLookup[5].name = "FenceWoodPost01"
    ComponentLookup[6].formid = 1146167
    ComponentLookup[6].mask = 3
    ComponentLookup[6].counts = 132
    ComponentLookup[6].name = "FenceWoodStr01"
    ComponentLookup[7].formid = 1150840
    ComponentLookup[7].mask = 3
    ComponentLookup[7].counts = 132
    ComponentLookup[7].name = "FenceWoodStr02"
    ComponentLookup[8].formid = 1150841
    ComponentLookup[8].mask = 3
    ComponentLookup[8].counts = 132
    ComponentLookup[8].name = "FenceWoodStr03"
    ComponentLookup[9].formid = 315914
    ComponentLookup[9].mask = 1
    ComponentLookup[9].counts = 6
    ComponentLookup[9].name = "FloorJackGarage01"
    ComponentLookup[10].formid = 549605
    ComponentLookup[10].mask = 129
    ComponentLookup[10].counts = 66
    ComponentLookup[10].name = "Floorlamp01"
    ComponentLookup[11].formid = 583580
    ComponentLookup[11].mask = 129
    ComponentLookup[11].counts = 66
    ComponentLookup[11].name = "Floorlamp01On"
    ComponentLookup[12].formid = 549612
    ComponentLookup[12].mask = 129
    ComponentLookup[12].counts = 66
    ComponentLookup[12].name = "FloorlampNoFrillies"
    ComponentLookup[13].formid = 583579
    ComponentLookup[13].mask = 129
    ComponentLookup[13].counts = 66
    ComponentLookup[13].name = "FloorlampNoFrilliesOn"
    ComponentLookup[14].formid = 285161
    ComponentLookup[14].mask = 129
    ComponentLookup[14].counts = 66
    ComponentLookup[14].name = "FloorlampNoShadeBrokenBulb"
    ComponentLookup[15].formid = 196133
    ComponentLookup[15].mask = 129
    ComponentLookup[15].counts = 66
    ComponentLookup[15].name = "FloorlampNoShadeOff"
    ComponentLookup[16].formid = 617567
    ComponentLookup[16].mask = 129
    ComponentLookup[16].counts = 66
    ComponentLookup[16].name = "FloorlampNoShadeOn"
    ComponentLookup[17].formid = 138292
    ComponentLookup[17].mask = 1
    ComponentLookup[17].counts = 6
    ComponentLookup[17].name = "GRailCurveRampL01"
    ComponentLookup[18].formid = 138301
    ComponentLookup[18].mask = 1
    ComponentLookup[18].counts = 6
    ComponentLookup[18].name = "GRailCurveRampL02"
    ComponentLookup[19].formid = 138291
    ComponentLookup[19].mask = 1
    ComponentLookup[19].counts = 6
    ComponentLookup[19].name = "GRailCurveRampR01"
    ComponentLookup[20].formid = 138332
    ComponentLookup[20].mask = 1
    ComponentLookup[20].counts = 6
    ComponentLookup[20].name = "GRailCurveShortR01"
    ComponentLookup[21].formid = 138275
    ComponentLookup[21].mask = 1
    ComponentLookup[21].counts = 6
    ComponentLookup[21].name = "GRailEnd01"
    ComponentLookup[22].formid = 138276
    ComponentLookup[22].mask = 1
    ComponentLookup[22].counts = 6
    ComponentLookup[22].name = "GRailEnd01Haz"
    ComponentLookup[23].formid = 138313
    ComponentLookup[23].mask = 1
    ComponentLookup[23].counts = 6
    ComponentLookup[23].name = "GRailEnd01R"
    ComponentLookup[24].formid = 138277
    ComponentLookup[24].mask = 1
    ComponentLookup[24].counts = 6
    ComponentLookup[24].name = "GRailEnd02"
    ComponentLookup[25].formid = 138278
    ComponentLookup[25].mask = 1
    ComponentLookup[25].counts = 6
    ComponentLookup[25].name = "GRailEnd02Haz"
    ComponentLookup[26].formid = 138326
    ComponentLookup[26].mask = 1
    ComponentLookup[26].counts = 6
    ComponentLookup[26].name = "GRailEnd02R"
    ComponentLookup[27].formid = 138330
    ComponentLookup[27].mask = 1
    ComponentLookup[27].counts = 6
    ComponentLookup[27].name = "GRailPiece01"
    ComponentLookup[28].formid = 138294
    ComponentLookup[28].mask = 1
    ComponentLookup[28].counts = 6
    ComponentLookup[28].name = "GRailRamp01"
    ComponentLookup[29].formid = 138308
    ComponentLookup[29].mask = 1
    ComponentLookup[29].counts = 6
    ComponentLookup[29].name = "GRailRamp02"
    ComponentLookup[30].formid = 138283
    ComponentLookup[30].mask = 1
    ComponentLookup[30].counts = 6
    ComponentLookup[30].name = "GRailStr01"
    ComponentLookup[31].formid = 1966309
    ComponentLookup[31].mask = 1
    ComponentLookup[31].counts = 6
    ComponentLookup[31].name = "GRailStr01SC01"
    ComponentLookup[32].formid = 138274
    ComponentLookup[32].mask = 1
    ComponentLookup[32].counts = 6
    ComponentLookup[32].name = "GRailStrShort01"
    ComponentLookup[33].formid = 1736099
    ComponentLookup[33].mask = 1
    ComponentLookup[33].counts = 2
    ComponentLookup[33].name = "Handcart01"
    ComponentLookup[34].formid = 1364115
    ComponentLookup[34].mask = 1
    ComponentLookup[34].counts = 2
    ComponentLookup[34].name = "HospitalBed01Frame"
    ComponentLookup[35].formid = 931793
    ComponentLookup[35].mask = 1
    ComponentLookup[35].counts = 5
    ComponentLookup[35].name = "IndustrialCart01"
    ComponentLookup[36].formid = 958893
    ComponentLookup[36].mask = 1
    ComponentLookup[36].counts = 2
    ComponentLookup[36].name = "IndustrialMetalTableSmall01A"
    ComponentLookup[37].formid = 1848194
    ComponentLookup[37].mask = 16
    ComponentLookup[37].counts = 1
    ComponentLookup[37].name = "LobsterFloat01"
    ComponentLookup[38].formid = 1848187
    ComponentLookup[38].mask = 16
    ComponentLookup[38].counts = 1
    ComponentLookup[38].name = "LobsterFloat01_Static"
    ComponentLookup[39].formid = 1848199
    ComponentLookup[39].mask = 16
    ComponentLookup[39].counts = 1
    ComponentLookup[39].name = "LobsterFloat02"
    ComponentLookup[40].formid = 1848196
    ComponentLookup[40].mask = 16
    ComponentLookup[40].counts = 1
    ComponentLookup[40].name = "LobsterFloat02_Static"
    ComponentLookup[41].formid = 1848200
    ComponentLookup[41].mask = 16
    ComponentLookup[41].counts = 1
    ComponentLookup[41].name = "LobsterFloat03"
    ComponentLookup[42].formid = 1848197
    ComponentLookup[42].mask = 16
    ComponentLookup[42].counts = 1
    ComponentLookup[42].name = "LobsterFloat03_Static"
    ComponentLookup[43].formid = 1848201
    ComponentLookup[43].mask = 16
    ComponentLookup[43].counts = 1
    ComponentLookup[43].name = "LobsterFloat04"
    ComponentLookup[44].formid = 1848198
    ComponentLookup[44].mask = 16
    ComponentLookup[44].counts = 1
    ComponentLookup[44].name = "LobsterFloat04_Static"
    ComponentLookup[45].formid = 1181986
    ComponentLookup[45].mask = 2
    ComponentLookup[45].counts = 4
    ComponentLookup[45].name = "Lobster_Cage_01"
    ComponentLookup[46].formid = 1734064
    ComponentLookup[46].mask = 2
    ComponentLookup[46].counts = 5
    ComponentLookup[46].name = "LoungeChair01"
    ComponentLookup[47].formid = 1734067
    ComponentLookup[47].mask = 2
    ComponentLookup[47].counts = 5
    ComponentLookup[47].name = "LoungeChair02"
    ComponentLookup[48].formid = 1734068
    ComponentLookup[48].mask = 2
    ComponentLookup[48].counts = 5
    ComponentLookup[48].name = "LoungeChair03"
    ComponentLookup[49].formid = 1150707
    ComponentLookup[49].mask = 1
    ComponentLookup[49].counts = 4
    ComponentLookup[49].name = "MetalBarrelCoastMoss01"
    ComponentLookup[50].formid = 1150708
    ComponentLookup[50].mask = 1
    ComponentLookup[50].counts = 4
    ComponentLookup[50].name = "MetalBarrelCoastMoss02"
    ComponentLookup[51].formid = 402890
    ComponentLookup[51].mask = 1
    ComponentLookup[51].counts = 4
    ComponentLookup[51].name = "MetalBarrelMovable01"
    ComponentLookup[52].formid = 402892
    ComponentLookup[52].mask = 1
    ComponentLookup[52].counts = 4
    ComponentLookup[52].name = "MetalBarrelMovable02"
    ComponentLookup[53].formid = 101588
    ComponentLookup[53].mask = 1
    ComponentLookup[53].counts = 4
    ComponentLookup[53].name = "MetalBarrelStatic01"
    ComponentLookup[54].formid = 101593
    ComponentLookup[54].mask = 1
    ComponentLookup[54].counts = 4
    ComponentLookup[54].name = "MetalBarrelStatic02"
    ComponentLookup[55].formid = 1684981
    ComponentLookup[55].mask = 1
    ComponentLookup[55].counts = 6
    ComponentLookup[55].name = "MetalShelf01Debris01"
    ComponentLookup[56].formid = 1684983
    ComponentLookup[56].mask = 1
    ComponentLookup[56].counts = 6
    ComponentLookup[56].name = "MetalShelf01Debris02"
    ComponentLookup[57].formid = 1684985
    ComponentLookup[57].mask = 1
    ComponentLookup[57].counts = 6
    ComponentLookup[57].name = "MetalShelf01Debris03"
    ComponentLookup[58].formid = 1752632
    ComponentLookup[58].mask = 1
    ComponentLookup[58].counts = 6
    ComponentLookup[58].name = "MetalShelf01_Broken01"
    ComponentLookup[59].formid = 1752634
    ComponentLookup[59].mask = 1
    ComponentLookup[59].counts = 6
    ComponentLookup[59].name = "MetalShelf01_Broken02"
    ComponentLookup[60].formid = 1752637
    ComponentLookup[60].mask = 1
    ComponentLookup[60].counts = 6
    ComponentLookup[60].name = "MetalShelf01_Broken03"
    ComponentLookup[61].formid = 1752639
    ComponentLookup[61].mask = 1
    ComponentLookup[61].counts = 6
    ComponentLookup[61].name = "MetalShelf01_Broken04"
    ComponentLookup[62].formid = 97754
    ComponentLookup[62].mask = 1
    ComponentLookup[62].counts = 6
    ComponentLookup[62].name = "MetalShelf02"
    ComponentLookup[63].formid = 1684987
    ComponentLookup[63].mask = 1
    ComponentLookup[63].counts = 6
    ComponentLookup[63].name = "MetalShelf02Debris01"
    ComponentLookup[64].formid = 1684989
    ComponentLookup[64].mask = 1
    ComponentLookup[64].counts = 6
    ComponentLookup[64].name = "MetalShelf02Debris02"
    ComponentLookup[65].formid = 97752
    ComponentLookup[65].mask = 1
    ComponentLookup[65].counts = 6
    ComponentLookup[65].name = "MetalShelf03"
    ComponentLookup[66].formid = 1684991
    ComponentLookup[66].mask = 1
    ComponentLookup[66].counts = 6
    ComponentLookup[66].name = "MetalShelf03Debris01"
    ComponentLookup[67].formid = 1684993
    ComponentLookup[67].mask = 1
    ComponentLookup[67].counts = 6
    ComponentLookup[67].name = "MetalShelf03Debris02"
    ComponentLookup[68].formid = 97753
    ComponentLookup[68].mask = 1
    ComponentLookup[68].counts = 6
    ComponentLookup[68].name = "MetalShelf04"
    ComponentLookup[69].formid = 1684995
    ComponentLookup[69].mask = 1
    ComponentLookup[69].counts = 6
    ComponentLookup[69].name = "MetalShelf04Debris01"
    ComponentLookup[70].formid = 1752625
    ComponentLookup[70].mask = 1
    ComponentLookup[70].counts = 6
    ComponentLookup[70].name = "MetalShelf04_Broken01"
    ComponentLookup[71].formid = 1752627
    ComponentLookup[71].mask = 1
    ComponentLookup[71].counts = 6
    ComponentLookup[71].name = "MetalShelf04_Broken02"
    ComponentLookup[72].formid = 1752629
    ComponentLookup[72].mask = 1
    ComponentLookup[72].counts = 6
    ComponentLookup[72].name = "MetalShelf04_Broken03"
    ComponentLookup[73].formid = 1752631
    ComponentLookup[73].mask = 1
    ComponentLookup[73].counts = 6
    ComponentLookup[73].name = "MetalShelf_Piece"
    ComponentLookup[74].formid = 1684997
    ComponentLookup[74].mask = 1
    ComponentLookup[74].counts = 6
    ComponentLookup[74].name = "MetalTable01Debris01"
    ComponentLookup[75].formid = 1684999
    ComponentLookup[75].mask = 1
    ComponentLookup[75].counts = 6
    ComponentLookup[75].name = "MetalTable02Debris01"
    ComponentLookup[76].formid = 1364114
    ComponentLookup[76].mask = 1
    ComponentLookup[76].counts = 2
    ComponentLookup[76].name = "MilitaryCot01Frame"
    ComponentLookup[77].formid = 119511
    ComponentLookup[77].mask = 9
    ComponentLookup[77].counts = 130
    ComponentLookup[77].name = "MuseumDivider01"
    ComponentLookup[78].formid = 119538
    ComponentLookup[78].mask = 9
    ComponentLookup[78].counts = 130
    ComponentLookup[78].name = "MuseumDivider02"
    ComponentLookup[79].formid = 225578
    ComponentLookup[79].mask = 2
    ComponentLookup[79].counts = 20
    ComponentLookup[79].name = "NpcChairFederalistOfficeSit01Static"
    ComponentLookup[80].formid = 517566
    ComponentLookup[80].mask = 2
    ComponentLookup[80].counts = 20
    ComponentLookup[80].name = "NpcChairFederalistSit01Static"
    ComponentLookup[81].formid = 555621
    ComponentLookup[81].mask = 2
    ComponentLookup[81].counts = 20
    ComponentLookup[81].name = "NpcChairFederalistSit01_Static"
    ComponentLookup[82].formid = 469565
    ComponentLookup[82].mask = 17
    ComponentLookup[82].counts = 325
    ComponentLookup[82].name = "NpcChairPlayerHouseRuinKitchenSit01Static"
    ComponentLookup[83].formid = 469566
    ComponentLookup[83].mask = 17
    ComponentLookup[83].counts = 325
    ComponentLookup[83].name = "NpcChairPlayerHouseRuinKitchenSit02Static"
    ComponentLookup[84].formid = 469567
    ComponentLookup[84].mask = 17
    ComponentLookup[84].counts = 325
    ComponentLookup[84].name = "NpcChairPlayerHouseRuinKitchenSit03Static"
    ComponentLookup[85].formid = 713793
    ComponentLookup[85].mask = 65
    ComponentLookup[85].counts = 66
    ComponentLookup[85].name = "NpcChairVaultSit02Closed"
    ComponentLookup[86].formid = 957153
    ComponentLookup[86].mask = 65
    ComponentLookup[86].counts = 66
    ComponentLookup[86].name = "NpcChairVaultSit02ClosedStatic"
    ComponentLookup[87].formid = 988830
    ComponentLookup[87].mask = 65
    ComponentLookup[87].counts = 66
    ComponentLookup[87].name = "NpcChairVaultSit02NoWait"
    ComponentLookup[88].formid = 754078
    ComponentLookup[88].mask = 65
    ComponentLookup[88].counts = 66
    ComponentLookup[88].name = "NpcChairVaultSit02Static"
    ComponentLookup[89].formid = 713794
    ComponentLookup[89].mask = 65
    ComponentLookup[89].counts = 66
    ComponentLookup[89].name = "NpcChairVaultSit03Closed"
    ComponentLookup[90].formid = 957154
    ComponentLookup[90].mask = 65
    ComponentLookup[90].counts = 66
    ComponentLookup[90].name = "NpcChairVaultSit03ClosedStatic"
    ComponentLookup[91].formid = 988831
    ComponentLookup[91].mask = 65
    ComponentLookup[91].counts = 66
    ComponentLookup[91].name = "NpcChairVaultSit03NoWait"
    ComponentLookup[92].formid = 754079
    ComponentLookup[92].mask = 65
    ComponentLookup[92].counts = 66
    ComponentLookup[92].name = "NpcChairVaultSit03Static"
    ComponentLookup[93].formid = 214627
    ComponentLookup[93].mask = 1
    ComponentLookup[93].counts = 2
    ComponentLookup[93].name = "NukaColaMachinePanel01"
    ComponentLookup[94].formid = 214629
    ComponentLookup[94].mask = 1
    ComponentLookup[94].counts = 2
    ComponentLookup[94].name = "NukaColaMachinePanel02"
    ComponentLookup[95].formid = 214625
    ComponentLookup[95].mask = 21
    ComponentLookup[95].counts = 8258
    ComponentLookup[95].name = "NukaColaMachine_Broken01"
    ComponentLookup[96].formid = 240107
    ComponentLookup[96].mask = 18
    ComponentLookup[96].counts = 65
    ComponentLookup[96].name = "OfficeBoxPapers01"
    ComponentLookup[97].formid = 1037205
    ComponentLookup[97].mask = 18
    ComponentLookup[97].counts = 65
    ComponentLookup[97].name = "OfficeBoxPapers01Prewar"
    ComponentLookup[98].formid = 240108
    ComponentLookup[98].mask = 18
    ComponentLookup[98].counts = 65
    ComponentLookup[98].name = "OfficeBoxPapers02"
    ComponentLookup[99].formid = 1037206
    ComponentLookup[99].mask = 18
    ComponentLookup[99].counts = 65
    ComponentLookup[99].name = "OfficeBoxPapers02Prewar"
	
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