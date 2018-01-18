Scriptname AFT:TweakScanCB2NScript extends Quest

; import AFT

Quest Property TweakScrapScanMaster Auto Const
FormList Property TweakConstructed_BtoN Auto Const

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
	string logName = "TweakScanCB2NScript"
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
		; code += "    ComponentLookup[" + i + "].formid = " + TweakConstructed_BtoN.GetAt(i).GetFormID() + "\n"
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
	results = center.FindAllReferencesOfType(TweakConstructed_BtoN, radius)			
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
	
    ComponentLookup[0].formid = 1080278
    ComponentLookup[0].mask = 155649
    ComponentLookup[0].counts = 532546
    ComponentLookup[0].name = "BaseballGrenade"
    ComponentLookup[1].formid = 1279498
    ComponentLookup[1].mask = 32
    ComponentLookup[1].counts = 10
    ComponentLookup[1].name = "BaseballStatue01"
    ComponentLookup[2].formid = 177885
    ComponentLookup[2].mask = 1
    ComponentLookup[2].counts = 4
    ComponentLookup[2].name = "BasketballHoop01NoPole"
    ComponentLookup[3].formid = 1555398
    ComponentLookup[3].mask = 1
    ComponentLookup[3].counts = 6
    ComponentLookup[3].name = "BasketballHoop02"
    ComponentLookup[4].formid = 183592
    ComponentLookup[4].mask = 513
    ComponentLookup[4].counts = 514
    ComponentLookup[4].name = "BathroomBathtubBroken01"
    ComponentLookup[5].formid = 215615
    ComponentLookup[5].mask = 528
    ComponentLookup[5].counts = 321
    ComponentLookup[5].name = "BathroomToiletBroken01"
    ComponentLookup[6].formid = 363241
    ComponentLookup[6].mask = 1
    ComponentLookup[6].counts = 1
    ComponentLookup[6].name = "Berserk"
    ComponentLookup[7].formid = 363243
    ComponentLookup[7].mask = 532481
    ComponentLookup[7].counts = 4161
    ComponentLookup[7].name = "Bleedout"
    ComponentLookup[8].formid = 363242
    ComponentLookup[8].mask = 128
    ComponentLookup[8].counts = 1
    ComponentLookup[8].name = "BloatflyLarva"
    ComponentLookup[9].formid = 1079071
    ComponentLookup[9].mask = 155649
    ComponentLookup[9].counts = 532610
    ComponentLookup[9].name = "BottlecapMine"
    ComponentLookup[10].formid = 1045021
    ComponentLookup[10].mask = 2212096
    ComponentLookup[10].counts = 50860227
    ComponentLookup[10].name = "CryoGrenade"
    ComponentLookup[11].formid = 1099369
    ComponentLookup[11].mask = 2180352
    ComponentLookup[11].counts = 50868356
    ComponentLookup[11].name = "CryoMine"
    ComponentLookup[12].formid = 686334
    ComponentLookup[12].mask = 8
    ComponentLookup[12].counts = 4
    ComponentLookup[12].name = "DaisyRug"
    ComponentLookup[13].formid = 1844302
    ComponentLookup[13].mask = 3
    ComponentLookup[13].counts = 193
    ComponentLookup[13].name = "Dogmeat_Doghouse"
    ComponentLookup[14].formid = 197340
    ComponentLookup[14].mask = 21
    ComponentLookup[14].counts = 8258
    ComponentLookup[14].name = "Empty_NukaColaMachine"
    ComponentLookup[15].formid = 363250
    ComponentLookup[15].mask = 2097280
    ComponentLookup[15].counts = 65
    ComponentLookup[15].name = "Endangerol"
    ComponentLookup[16].formid = 620742
    ComponentLookup[16].mask = 3
    ComponentLookup[16].counts = 257
    ComponentLookup[16].name = "FancyTableCircle01"
    ComponentLookup[17].formid = 620756
    ComponentLookup[17].mask = 3
    ComponentLookup[17].counts = 193
    ComponentLookup[17].name = "FancyTableCircleHalf01"
    ComponentLookup[18].formid = 620738
    ComponentLookup[18].mask = 2
    ComponentLookup[18].counts = 4
    ComponentLookup[18].name = "FancyTableConsole01"
    ComponentLookup[19].formid = 652337
    ComponentLookup[19].mask = 3
    ComponentLookup[19].counts = 449
    ComponentLookup[19].name = "FancyTableDinner01"
    ComponentLookup[20].formid = 652338
    ComponentLookup[20].mask = 3
    ComponentLookup[20].counts = 449
    ComponentLookup[20].name = "FancyTableDinner02"
    ComponentLookup[21].formid = 652339
    ComponentLookup[21].mask = 3
    ComponentLookup[21].counts = 449
    ComponentLookup[21].name = "FancyTableDinner03"
    ComponentLookup[22].formid = 620746
    ComponentLookup[22].mask = 3
    ComponentLookup[22].counts = 257
    ComponentLookup[22].name = "FancyTableRextangle01"
    ComponentLookup[23].formid = 128065
    ComponentLookup[23].mask = 3
    ComponentLookup[23].counts = 449
    ComponentLookup[23].name = "FederalistBookcase01"
    ComponentLookup[24].formid = 128062
    ComponentLookup[24].mask = 3
    ComponentLookup[24].counts = 193
    ComponentLookup[24].name = "FederalistBookcaseShort01"
    ComponentLookup[25].formid = 128073
    ComponentLookup[25].mask = 3
    ComponentLookup[25].counts = 257
    ComponentLookup[25].name = "FederalistCoffeeTable01"
    ComponentLookup[26].formid = 128072
    ComponentLookup[26].mask = 3
    ComponentLookup[26].counts = 193
    ComponentLookup[26].name = "FederalistCoffeeTableSmall01"
    ComponentLookup[27].formid = 128064
    ComponentLookup[27].mask = 2
    ComponentLookup[27].counts = 4
    ComponentLookup[27].name = "FederalistTableCircle01"
    ComponentLookup[28].formid = 763053
    ComponentLookup[28].mask = 3
    ComponentLookup[28].counts = 385
    ComponentLookup[28].name = "FederalistTableLong01"
    ComponentLookup[29].formid = 763052
    ComponentLookup[29].mask = 3
    ComponentLookup[29].counts = 257
    ComponentLookup[29].name = "FederalistTableSquare01"
    ComponentLookup[30].formid = 1572396
    ComponentLookup[30].mask = 8
    ComponentLookup[30].counts = 5
    ComponentLookup[30].name = "FlagWallBOS"
    ComponentLookup[31].formid = 1582305
    ComponentLookup[31].mask = 8
    ComponentLookup[31].counts = 5
    ComponentLookup[31].name = "FlagWallInstitute"
    ComponentLookup[32].formid = 1490289
    ComponentLookup[32].mask = 8
    ComponentLookup[32].counts = 5
    ComponentLookup[32].name = "FlagWallMinutemen01"
    ComponentLookup[33].formid = 1572429
    ComponentLookup[33].mask = 8
    ComponentLookup[33].counts = 5
    ComponentLookup[33].name = "FlagWallRailRoad"
    ComponentLookup[34].formid = 1572393
    ComponentLookup[34].mask = 8
    ComponentLookup[34].counts = 5
    ComponentLookup[34].name = "FlagWallUSA"
    ComponentLookup[35].formid = 538885
    ComponentLookup[35].mask = 5
    ComponentLookup[35].counts = 68
    ComponentLookup[35].name = "Grill01"
    ComponentLookup[36].formid = 1732151
    ComponentLookup[36].mask = 1
    ComponentLookup[36].counts = 4
    ComponentLookup[36].name = "HighTechAshtray_01_Dirty"
    ComponentLookup[37].formid = 314727
    ComponentLookup[37].mask = 1
    ComponentLookup[37].counts = 2
    ComponentLookup[37].name = "HighTechRoundTable01_Dirty"
    ComponentLookup[38].formid = 222917
    ComponentLookup[38].mask = 131088
    ComponentLookup[38].counts = 129
    ComponentLookup[38].name = "Jet"
    ComponentLookup[39].formid = 1984193
    ComponentLookup[39].mask = 17
    ComponentLookup[39].counts = 257
    ComponentLookup[39].name = "LawnFlamingo01Static"
    ComponentLookup[40].formid = 593504
    ComponentLookup[40].mask = 17
    ComponentLookup[40].counts = 257
    ComponentLookup[40].name = "LawnFlamingo02Static"
    ComponentLookup[41].formid = 1592922
    ComponentLookup[41].mask = 11
    ComponentLookup[41].counts = 12545
    ComponentLookup[41].name = "MQ00ChairMamaMurphy"
    ComponentLookup[42].formid = 210811
    ComponentLookup[42].mask = 16777216
    ComponentLookup[42].counts = 1
    ComponentLookup[42].name = "Mentats"
    ComponentLookup[43].formid = 97751
    ComponentLookup[43].mask = 1
    ComponentLookup[43].counts = 4
    ComponentLookup[43].name = "MetalShelf01"
    ComponentLookup[44].formid = 98828
    ComponentLookup[44].mask = 1
    ComponentLookup[44].counts = 5
    ComponentLookup[44].name = "MetalTable01"
    ComponentLookup[45].formid = 98830
    ComponentLookup[45].mask = 1
    ComponentLookup[45].counts = 5
    ComponentLookup[45].name = "MetalTable02"
    ComponentLookup[46].formid = 98829
    ComponentLookup[46].mask = 1
    ComponentLookup[46].counts = 5
    ComponentLookup[46].name = "MetalTableRound01"
    ComponentLookup[47].formid = 303442
    ComponentLookup[47].mask = 8192
    ComponentLookup[47].counts = 1
    ComponentLookup[47].name = "MirelurkCake"
    ComponentLookup[48].formid = 1732209
    ComponentLookup[48].mask = 2
    ComponentLookup[48].counts = 4
    ComponentLookup[48].name = "ModernDomesticCoffeeTable01_Dirty"
    ComponentLookup[49].formid = 1616382
    ComponentLookup[49].mask = 3
    ComponentLookup[49].counts = 194
    ComponentLookup[49].name = "ModernDomesticTableLrg01"
    ComponentLookup[50].formid = 1616213
    ComponentLookup[50].mask = 3
    ComponentLookup[50].counts = 130
    ComponentLookup[50].name = "ModernDomesticTableMed01"
    ComponentLookup[51].formid = 958904
    ComponentLookup[51].mask = 3
    ComponentLookup[51].counts = 130
    ComponentLookup[51].name = "ModernDomesticTableSmall01"
    ComponentLookup[52].formid = 1098694
    ComponentLookup[52].mask = 24712
    ComponentLookup[52].counts = 540801
    ComponentLookup[52].name = "MolotovCocktail"
    ComponentLookup[53].formid = 914522
    ComponentLookup[53].mask = 3
    ComponentLookup[53].counts = 259
    ComponentLookup[53].name = "NPCBenchParkSit01"
    ComponentLookup[54].formid = 914524
    ComponentLookup[54].mask = 10
    ComponentLookup[54].counts = 197
    ComponentLookup[54].name = "NPCChairMemoryLoungeSit01"
    ComponentLookup[55].formid = 914521
    ComponentLookup[55].mask = 10
    ComponentLookup[55].counts = 582
    ComponentLookup[55].name = "NPCCouchMemoryLoungeSit01"
    ComponentLookup[56].formid = 128132
    ComponentLookup[56].mask = 3
    ComponentLookup[56].counts = 321
    ComponentLookup[56].name = "NpcBenchFederalistSit01"
    ComponentLookup[57].formid = 1351314
    ComponentLookup[57].mask = 264
    ComponentLookup[57].counts = 196
    ComponentLookup[57].name = "NpcChairAirplaneSit01"
    ComponentLookup[58].formid = 129163
    ComponentLookup[58].mask = 18
    ComponentLookup[58].counts = 68
    ComponentLookup[58].name = "NpcChairFederalistOfficeSit01"
    ComponentLookup[59].formid = 128846
    ComponentLookup[59].mask = 3
    ComponentLookup[59].counts = 257
    ComponentLookup[59].name = "NpcChairFederalistSit01"
    ComponentLookup[60].formid = 1732178
    ComponentLookup[60].mask = 33554433
    ComponentLookup[60].counts = 260
    ComponentLookup[60].name = "NpcChairHighTechOfficeChairDirtySit01"
    ComponentLookup[61].formid = 1732182
    ComponentLookup[61].mask = 9
    ComponentLookup[61].counts = 260
    ComponentLookup[61].name = "NpcChairHighTechRoundChairDirtySit01"
    ComponentLookup[62].formid = 1733140
    ComponentLookup[62].mask = 9
    ComponentLookup[62].counts = 260
    ComponentLookup[62].name = "NpcChairLounge01AWeathered01OttomanSit01"
    ComponentLookup[63].formid = 1731448
    ComponentLookup[63].mask = 9
    ComponentLookup[63].counts = 260
    ComponentLookup[63].name = "NpcChairLounge01AWeathered01Sit01"
    ComponentLookup[64].formid = 1733148
    ComponentLookup[64].mask = 9
    ComponentLookup[64].counts = 260
    ComponentLookup[64].name = "NpcChairLounge01BWeathered01OttomanSit01"
    ComponentLookup[65].formid = 1731460
    ComponentLookup[65].mask = 9
    ComponentLookup[65].counts = 260
    ComponentLookup[65].name = "NpcChairLounge01BWeathered01Sit01"
    ComponentLookup[66].formid = 958905
    ComponentLookup[66].mask = 10
    ComponentLookup[66].counts = 132
    ComponentLookup[66].name = "NpcChairModernDomesticSit01"
    ComponentLookup[67].formid = 958906
    ComponentLookup[67].mask = 10
    ComponentLookup[67].counts = 260
    ComponentLookup[67].name = "NpcChairModernDomesticSit02"
    ComponentLookup[68].formid = 958907
    ComponentLookup[68].mask = 10
    ComponentLookup[68].counts = 260
    ComponentLookup[68].name = "NpcChairModernDomesticSit03"
    ComponentLookup[69].formid = 538887
    ComponentLookup[69].mask = 17
    ComponentLookup[69].counts = 132
    ComponentLookup[69].name = "NpcChairPatioSit01"
    ComponentLookup[70].formid = 765264
    ComponentLookup[70].mask = 81
    ComponentLookup[70].counts = 4228
    ComponentLookup[70].name = "NpcChairPatioSit01Static"
    ComponentLookup[71].formid = 457180
    ComponentLookup[71].mask = 25
    ComponentLookup[71].counts = 8322
    ComponentLookup[71].name = "NpcChairPlayerHouseRuinKitchenSit01"
    ComponentLookup[72].formid = 457181
    ComponentLookup[72].mask = 25
    ComponentLookup[72].counts = 4163
    ComponentLookup[72].name = "NpcChairPlayerHouseRuinKitchenSit02"
    ComponentLookup[73].formid = 457182
    ComponentLookup[73].mask = 25
    ComponentLookup[73].counts = 8323
    ComponentLookup[73].name = "NpcChairPlayerHouseRuinKitchenSit03"
    ComponentLookup[74].formid = 478128
    ComponentLookup[74].mask = 11
    ComponentLookup[74].counts = 20673
    ComponentLookup[74].name = "NpcChairPlayerHouseRuinSit01"
    ComponentLookup[75].formid = 713792
    ComponentLookup[75].mask = 1
    ComponentLookup[75].counts = 4
    ComponentLookup[75].name = "NpcChairVaultSit03"
    ComponentLookup[76].formid = 1351265
    ComponentLookup[76].mask = 264
    ComponentLookup[76].counts = 328
    ComponentLookup[76].name = "NpcCouchAirplaneSit01"
    ComponentLookup[77].formid = 1351313
    ComponentLookup[77].mask = 264
    ComponentLookup[77].counts = 262
    ComponentLookup[77].name = "NpcCouchAirplaneSit02"
    ComponentLookup[78].formid = 128675
    ComponentLookup[78].mask = 11
    ComponentLookup[78].counts = 41346
    ComponentLookup[78].name = "NpcCouchFederalistSit01"
    ComponentLookup[79].formid = 1731449
    ComponentLookup[79].mask = 9
    ComponentLookup[79].counts = 260
    ComponentLookup[79].name = "NpcCouchLounge01AWeathered01Sit01"
    ComponentLookup[80].formid = 1731461
    ComponentLookup[80].mask = 9
    ComponentLookup[80].counts = 260
    ComponentLookup[80].name = "NpcCouchLounge01BWeathered01Sit01"
    ComponentLookup[81].formid = 958908
    ComponentLookup[81].mask = 10
    ComponentLookup[81].counts = 581
    ComponentLookup[81].name = "NpcCouchModernDomesticSit01"
    ComponentLookup[82].formid = 259122
    ComponentLookup[82].mask = 11
    ComponentLookup[82].counts = 28930
    ComponentLookup[82].name = "NpcCouchOfficeSit01"
    ComponentLookup[83].formid = 478129
    ComponentLookup[83].mask = 10
    ComponentLookup[83].counts = 645
    ComponentLookup[83].name = "NpcCouchPlayerHouseRuinSit01"
    ComponentLookup[84].formid = 513496
    ComponentLookup[84].mask = 17
    ComponentLookup[84].counts = 67
    ComponentLookup[84].name = "NpcStoolDinerIntSit01"
    ComponentLookup[85].formid = 129339
    ComponentLookup[85].mask = 3
    ComponentLookup[85].counts = 193
    ComponentLookup[85].name = "NpcStoolFederalistSit01"
    ComponentLookup[86].formid = 885700
    ComponentLookup[86].mask = 1
    ComponentLookup[86].counts = 5
    ComponentLookup[86].name = "NpcStoolIndustrialMetalSit01"
    ComponentLookup[87].formid = 958909
    ComponentLookup[87].mask = 1
    ComponentLookup[87].counts = 4
    ComponentLookup[87].name = "NpcStoolModernDomesticSit01"
    ComponentLookup[88].formid = 457262
    ComponentLookup[88].mask = 3
    ComponentLookup[88].counts = 66
    ComponentLookup[88].name = "NpcStoolPlayerHouseRuinSit01"
    ComponentLookup[89].formid = 463283
    ComponentLookup[89].mask = 1
    ComponentLookup[89].counts = 3
    ComponentLookup[89].name = "NpcStoolPlayerHouseRuinSit02"
    ComponentLookup[90].formid = 463284
    ComponentLookup[90].mask = 1
    ComponentLookup[90].counts = 3
    ComponentLookup[90].name = "NpcStoolPlayerHouseRuinSit03"
    ComponentLookup[91].formid = 96895
    ComponentLookup[91].mask = 1
    ComponentLookup[91].counts = 3
    ComponentLookup[91].name = "NpcStoolStadiumSit01"
    ComponentLookup[92].formid = 1841005
    ComponentLookup[92].mask = 3
    ComponentLookup[92].counts = 514
    ComponentLookup[92].name = "NpcTablePicnicSit01"
    ComponentLookup[93].formid = 334021
    ComponentLookup[93].mask = 0
    ComponentLookup[93].counts = 0
    ComponentLookup[93].name = "OrangeMentats"
    ComponentLookup[94].formid = 363181
    ComponentLookup[94].mask = 2097152
    ComponentLookup[94].counts = 2
    ComponentLookup[94].name = "Overdrive"
    ComponentLookup[95].formid = 882417
    ComponentLookup[95].mask = 1
    ComponentLookup[95].counts = 2
    ComponentLookup[95].name = "OxygenTank"
    ComponentLookup[96].formid = 363255
    ComponentLookup[96].mask = 1
    ComponentLookup[96].counts = 1
    ComponentLookup[96].name = "Pax"
    ComponentLookup[97].formid = 1090365
    ComponentLookup[97].mask = 115968
    ComponentLookup[97].counts = 50610308
    ComponentLookup[97].name = "PlasmaGrenade"
    ComponentLookup[98].formid = 1090370
    ComponentLookup[98].mask = 345344
    ComponentLookup[98].counts = 51134661
    ComponentLookup[98].name = "PlasmaMine"
    ComponentLookup[99].formid = 483134
    ComponentLookup[99].mask = 3
    ComponentLookup[99].counts = 193
    ComponentLookup[99].name = "PlayerHouse_Ruin_CoffeeTable01"	
	
EndFunction

; Add this to Container FormList
;
; GlobalVariable   Property pTweakOptionsScanCheckCont  Auto
;
; bool checkContainer = (pTweakOptionsScanCheckCont.GetValue() == 1.0)
; if (!checkContainer || (result.GetItemCount() == 0))


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
