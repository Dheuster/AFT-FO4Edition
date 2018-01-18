Scriptname AFT:TweakScanNCStoTScript extends Quest

; import AFT

Quest Property TweakScrapScanMaster Auto Const
FormList Property TweakNonConstructed_StoT Auto Const

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
	string logName = "TweakScanNCStoTScript"
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
		; code += "    ComponentLookup[" + i + "].formid = " + TweakNonConstructed_StoT.GetAt(i).GetFormID() + "\n"
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
	results = center.FindAllReferencesOfType(TweakNonConstructed_StoT, radius)			
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
	
    ComponentLookup[0].formid = 1641522
    ComponentLookup[0].mask = 1
    ComponentLookup[0].counts = 2
    ComponentLookup[0].name = "SignRoad_TurnLeft01Dest"
    ComponentLookup[1].formid = 240232
    ComponentLookup[1].mask = 1
    ComponentLookup[1].counts = 2
    ComponentLookup[1].name = "SignRoad_TurnLeft02"
    ComponentLookup[2].formid = 1641550
    ComponentLookup[2].mask = 1
    ComponentLookup[2].counts = 2
    ComponentLookup[2].name = "SignRoad_TurnLeft02Dest"
    ComponentLookup[3].formid = 240233
    ComponentLookup[3].mask = 1
    ComponentLookup[3].counts = 2
    ComponentLookup[3].name = "SignRoad_TurnLeft03"
    ComponentLookup[4].formid = 1641578
    ComponentLookup[4].mask = 1
    ComponentLookup[4].counts = 2
    ComponentLookup[4].name = "SignRoad_TurnLeft03Dest"
    ComponentLookup[5].formid = 240231
    ComponentLookup[5].mask = 1
    ComponentLookup[5].counts = 2
    ComponentLookup[5].name = "SignRoad_TurnLeft_NoPost01"
    ComponentLookup[6].formid = 1641606
    ComponentLookup[6].mask = 1
    ComponentLookup[6].counts = 2
    ComponentLookup[6].name = "SignRoad_TurnLeft_NoPost01Dest"
    ComponentLookup[7].formid = 216902
    ComponentLookup[7].mask = 1
    ComponentLookup[7].counts = 2
    ComponentLookup[7].name = "SignRoad_TurnRight01"
    ComponentLookup[8].formid = 1641524
    ComponentLookup[8].mask = 1
    ComponentLookup[8].counts = 2
    ComponentLookup[8].name = "SignRoad_TurnRight01Dest"
    ComponentLookup[9].formid = 240235
    ComponentLookup[9].mask = 1
    ComponentLookup[9].counts = 2
    ComponentLookup[9].name = "SignRoad_TurnRight02"
    ComponentLookup[10].formid = 1641552
    ComponentLookup[10].mask = 1
    ComponentLookup[10].counts = 2
    ComponentLookup[10].name = "SignRoad_TurnRight02Dest"
    ComponentLookup[11].formid = 240236
    ComponentLookup[11].mask = 1
    ComponentLookup[11].counts = 2
    ComponentLookup[11].name = "SignRoad_TurnRight03"
    ComponentLookup[12].formid = 1641580
    ComponentLookup[12].mask = 1
    ComponentLookup[12].counts = 2
    ComponentLookup[12].name = "SignRoad_TurnRight03Dest"
    ComponentLookup[13].formid = 240234
    ComponentLookup[13].mask = 1
    ComponentLookup[13].counts = 2
    ComponentLookup[13].name = "SignRoad_TurnRight_NoPost01"
    ComponentLookup[14].formid = 1641608
    ComponentLookup[14].mask = 1
    ComponentLookup[14].counts = 2
    ComponentLookup[14].name = "SignRoad_TurnRight_NoPost01Dest"
    ComponentLookup[15].formid = 216884
    ComponentLookup[15].mask = 1
    ComponentLookup[15].counts = 2
    ComponentLookup[15].name = "SignRoad_Yield01"
    ComponentLookup[16].formid = 1009525
    ComponentLookup[16].mask = 1
    ComponentLookup[16].counts = 2
    ComponentLookup[16].name = "SignRoad_Yield01Dest"
    ComponentLookup[17].formid = 240196
    ComponentLookup[17].mask = 1
    ComponentLookup[17].counts = 2
    ComponentLookup[17].name = "SignRoad_Yield02"
    ComponentLookup[18].formid = 1641540
    ComponentLookup[18].mask = 1
    ComponentLookup[18].counts = 2
    ComponentLookup[18].name = "SignRoad_Yield02Dest"
    ComponentLookup[19].formid = 240197
    ComponentLookup[19].mask = 1
    ComponentLookup[19].counts = 2
    ComponentLookup[19].name = "SignRoad_Yield03"
    ComponentLookup[20].formid = 1641568
    ComponentLookup[20].mask = 1
    ComponentLookup[20].counts = 2
    ComponentLookup[20].name = "SignRoad_Yield03Dest"
    ComponentLookup[21].formid = 240195
    ComponentLookup[21].mask = 1
    ComponentLookup[21].counts = 2
    ComponentLookup[21].name = "SignRoad_Yield_NoPost01"
    ComponentLookup[22].formid = 1641596
    ComponentLookup[22].mask = 1
    ComponentLookup[22].counts = 2
    ComponentLookup[22].name = "SignRoad_Yield_NoPost01Dest"
    ComponentLookup[23].formid = 1527090
    ComponentLookup[23].mask = 1
    ComponentLookup[23].counts = 2
    ComponentLookup[23].name = "SignSmallEngineRepair"
    ComponentLookup[24].formid = 1196343
    ComponentLookup[24].mask = 2
    ComponentLookup[24].counts = 1
    ComponentLookup[24].name = "Sign_DontFeedTheBears01"
    ComponentLookup[25].formid = 1196345
    ComponentLookup[25].mask = 2
    ComponentLookup[25].counts = 1
    ComponentLookup[25].name = "Sign_DontFeedTheBears02"
    ComponentLookup[26].formid = 183589
    ComponentLookup[26].mask = 528
    ComponentLookup[26].counts = 129
    ComponentLookup[26].name = "SinkBroken01"
    ComponentLookup[27].formid = 183590
    ComponentLookup[27].mask = 528
    ComponentLookup[27].counts = 129
    ComponentLookup[27].name = "SinkBroken02"
    ComponentLookup[28].formid = 1716311
    ComponentLookup[28].mask = 1
    ComponentLookup[28].counts = 10
    ComponentLookup[28].name = "SportsCar01_Static"
    ComponentLookup[29].formid = 1716312
    ComponentLookup[29].mask = 1
    ComponentLookup[29].counts = 10
    ComponentLookup[29].name = "SportsCar02_Static"
    ComponentLookup[30].formid = 1716313
    ComponentLookup[30].mask = 1
    ComponentLookup[30].counts = 10
    ComponentLookup[30].name = "SportsCar03_Static"
    ComponentLookup[31].formid = 1716314
    ComponentLookup[31].mask = 1
    ComponentLookup[31].counts = 10
    ComponentLookup[31].name = "SportsCar04_Static"
    ComponentLookup[32].formid = 2218941
    ComponentLookup[32].mask = 1
    ComponentLookup[32].counts = 10
    ComponentLookup[32].name = "SportsCar_Postwar_Cheap01"
    ComponentLookup[33].formid = 2218942
    ComponentLookup[33].mask = 1
    ComponentLookup[33].counts = 10
    ComponentLookup[33].name = "SportsCar_Postwar_Cheap02"
    ComponentLookup[34].formid = 2218943
    ComponentLookup[34].mask = 1
    ComponentLookup[34].counts = 10
    ComponentLookup[34].name = "SportsCar_Postwar_Cheap03"
    ComponentLookup[35].formid = 2218944
    ComponentLookup[35].mask = 1
    ComponentLookup[35].counts = 10
    ComponentLookup[35].name = "SportsCar_Postwar_Cheap04"
    ComponentLookup[36].formid = 1622786
    ComponentLookup[36].mask = 1
    ComponentLookup[36].counts = 10
    ComponentLookup[36].name = "StationWagon01A_Static"
    ComponentLookup[37].formid = 1622787
    ComponentLookup[37].mask = 1
    ComponentLookup[37].counts = 10
    ComponentLookup[37].name = "StationWagon01B_Static"
    ComponentLookup[38].formid = 1622791
    ComponentLookup[38].mask = 1
    ComponentLookup[38].counts = 10
    ComponentLookup[38].name = "StationWagon02A_Static"
    ComponentLookup[39].formid = 1622792
    ComponentLookup[39].mask = 1
    ComponentLookup[39].counts = 10
    ComponentLookup[39].name = "StationWagon02B_Static"
    ComponentLookup[40].formid = 1622793
    ComponentLookup[40].mask = 1
    ComponentLookup[40].counts = 10
    ComponentLookup[40].name = "StationWagon03A_Static"
    ComponentLookup[41].formid = 1622794
    ComponentLookup[41].mask = 1
    ComponentLookup[41].counts = 10
    ComponentLookup[41].name = "StationWagon03B_Static"
    ComponentLookup[42].formid = 1622795
    ComponentLookup[42].mask = 1
    ComponentLookup[42].counts = 10
    ComponentLookup[42].name = "StationWagon04A_Static"
    ComponentLookup[43].formid = 1622796
    ComponentLookup[43].mask = 1
    ComponentLookup[43].counts = 10
    ComponentLookup[43].name = "StationWagon04B_Static"
    ComponentLookup[44].formid = 2382301
    ComponentLookup[44].mask = 1
    ComponentLookup[44].counts = 10
    ComponentLookup[44].name = "StationWagon05A_Static"
    ComponentLookup[45].formid = 2218933
    ComponentLookup[45].mask = 1
    ComponentLookup[45].counts = 10
    ComponentLookup[45].name = "StationWagon_Postwar_Cheap01"
    ComponentLookup[46].formid = 2218934
    ComponentLookup[46].mask = 1
    ComponentLookup[46].counts = 10
    ComponentLookup[46].name = "StationWagon_Postwar_Cheap02"
    ComponentLookup[47].formid = 2218935
    ComponentLookup[47].mask = 1
    ComponentLookup[47].counts = 10
    ComponentLookup[47].name = "StationWagon_Postwar_Cheap03"
    ComponentLookup[48].formid = 2218936
    ComponentLookup[48].mask = 1
    ComponentLookup[48].counts = 10
    ComponentLookup[48].name = "StationWagon_Postwar_Cheap04"
    ComponentLookup[49].formid = 949657
    ComponentLookup[49].mask = 65
    ComponentLookup[49].counts = 67
    ComponentLookup[49].name = "StepLadderClosed"
    ComponentLookup[50].formid = 949658
    ComponentLookup[50].mask = 65
    ComponentLookup[50].counts = 67
    ComponentLookup[50].name = "StepLadderClosedSmall"
    ComponentLookup[51].formid = 949659
    ComponentLookup[51].mask = 65
    ComponentLookup[51].counts = 67
    ComponentLookup[51].name = "StepLadderOpen"
    ComponentLookup[52].formid = 949660
    ComponentLookup[52].mask = 65
    ComponentLookup[52].counts = 67
    ComponentLookup[52].name = "StepLadderOpenSmall"
    ComponentLookup[53].formid = 6994
    ComponentLookup[53].mask = 133
    ComponentLookup[53].counts = 8522
    ComponentLookup[53].name = "StreetLamp01"
    ComponentLookup[54].formid = 120162
    ComponentLookup[54].mask = 133
    ComponentLookup[54].counts = 8522
    ComponentLookup[54].name = "StreetLamp02"
    ComponentLookup[55].formid = 149537
    ComponentLookup[55].mask = 133
    ComponentLookup[55].counts = 8522
    ComponentLookup[55].name = "StreetLamp03"
    ComponentLookup[56].formid = 149533
    ComponentLookup[56].mask = 133
    ComponentLookup[56].counts = 4296
    ComponentLookup[56].name = "StreetLampBase01"
    ComponentLookup[57].formid = 149534
    ComponentLookup[57].mask = 133
    ComponentLookup[57].counts = 8522
    ComponentLookup[57].name = "StreetLampPost01"
    ComponentLookup[58].formid = 770633
    ComponentLookup[58].mask = 69
    ComponentLookup[58].counts = 8260
    ComponentLookup[58].name = "TerminalBroken01"
    ComponentLookup[59].formid = 1363112
    ComponentLookup[59].mask = 69
    ComponentLookup[59].counts = 8260
    ComponentLookup[59].name = "TerminalBroken02"
    ComponentLookup[60].formid = 770634
    ComponentLookup[60].mask = 69
    ComponentLookup[60].counts = 8260
    ComponentLookup[60].name = "TerminalBrokenCorded01"
    ComponentLookup[61].formid = 1363113
    ComponentLookup[61].mask = 69
    ComponentLookup[61].counts = 8260
    ComponentLookup[61].name = "TerminalBrokenCorded02"
    ComponentLookup[62].formid = 239169
    ComponentLookup[62].mask = 4
    ComponentLookup[62].counts = 4
    ComponentLookup[62].name = "Tire01"
    ComponentLookup[63].formid = 932524
    ComponentLookup[63].mask = 4
    ComponentLookup[63].counts = 4
    ComponentLookup[63].name = "Tire01Clean"
    ComponentLookup[64].formid = 239168
    ComponentLookup[64].mask = 4
    ComponentLookup[64].counts = 4
    ComponentLookup[64].name = "Tire02"
    ComponentLookup[65].formid = 932523
    ComponentLookup[65].mask = 4
    ComponentLookup[65].counts = 4
    ComponentLookup[65].name = "Tire02Clean"
    ComponentLookup[66].formid = 239167
    ComponentLookup[66].mask = 4
    ComponentLookup[66].counts = 4
    ComponentLookup[66].name = "Tire03"
    ComponentLookup[67].formid = 407668
    ComponentLookup[67].mask = 4
    ComponentLookup[67].counts = 4
    ComponentLookup[67].name = "Tire03Hollow"
    ComponentLookup[68].formid = 906185
    ComponentLookup[68].mask = 4
    ComponentLookup[68].counts = 4
    ComponentLookup[68].name = "Tire03HollowStatic"
    ComponentLookup[69].formid = 950895
    ComponentLookup[69].mask = 4
    ComponentLookup[69].counts = 4
    ComponentLookup[69].name = "TireGlowingSea01"
    ComponentLookup[70].formid = 239182
    ComponentLookup[70].mask = 4
    ComponentLookup[70].counts = 30
    ComponentLookup[70].name = "TirePile01"
    ComponentLookup[71].formid = 239184
    ComponentLookup[71].mask = 4
    ComponentLookup[71].counts = 30
    ComponentLookup[71].name = "TirePile02"
    ComponentLookup[72].formid = 7640
    ComponentLookup[72].mask = 4
    ComponentLookup[72].counts = 4
    ComponentLookup[72].name = "TireRubber01"
    ComponentLookup[73].formid = 239185
    ComponentLookup[73].mask = 4
    ComponentLookup[73].counts = 10
    ComponentLookup[73].name = "TireStack01"
    ComponentLookup[74].formid = 239183
    ComponentLookup[74].mask = 4
    ComponentLookup[74].counts = 30
    ComponentLookup[74].name = "TireWall01"
    ComponentLookup[75].formid = 239181
    ComponentLookup[75].mask = 4
    ComponentLookup[75].counts = 30
    ComponentLookup[75].name = "TireWall02"
    ComponentLookup[76].formid = 183591
    ComponentLookup[76].mask = 528
    ComponentLookup[76].counts = 257
    ComponentLookup[76].name = "ToiletBroken01"
    ComponentLookup[77].formid = 183593
    ComponentLookup[77].mask = 528
    ComponentLookup[77].counts = 257
    ComponentLookup[77].name = "ToiletBroken02"
    ComponentLookup[78].formid = 183594
    ComponentLookup[78].mask = 528
    ComponentLookup[78].counts = 257
    ComponentLookup[78].name = "ToiletBroken03"
    ComponentLookup[79].formid = 236013
    ComponentLookup[79].mask = 2
    ComponentLookup[79].counts = 3
    ComponentLookup[79].name = "ToolRackGarage01"
    ComponentLookup[80].formid = 1610080
    ComponentLookup[80].mask = 1
    ComponentLookup[80].counts = 5
    ComponentLookup[80].name = "TrashCanMetal"
    ComponentLookup[81].formid = 1610083
    ComponentLookup[81].mask = 1
    ComponentLookup[81].counts = 2
    ComponentLookup[81].name = "TrashCanMetal_Lid"
    ComponentLookup[82].formid = 1726795
    ComponentLookup[82].mask = 1
    ComponentLookup[82].counts = 5
    ComponentLookup[82].name = "TrashcanMetalOffice01"
    ComponentLookup[83].formid = 1726794
    ComponentLookup[83].mask = 1
    ComponentLookup[83].counts = 5
    ComponentLookup[83].name = "TrashcanMetalOffice01_Prewar"
    ComponentLookup[84].formid = 804086
    ComponentLookup[84].mask = 1
    ComponentLookup[84].counts = 5
    ComponentLookup[84].name = "TrashBinStatic01"
    ComponentLookup[85].formid = 804089
    ComponentLookup[85].mask = 1
    ComponentLookup[85].counts = 5
    ComponentLookup[85].name = "TrashBinStatic02"
    ComponentLookup[86].formid = 804094
    ComponentLookup[86].mask = 1
    ComponentLookup[86].counts = 2
    ComponentLookup[86].name = "TrashBinStaticDoor01"
    ComponentLookup[87].formid = 804097
    ComponentLookup[87].mask = 1
    ComponentLookup[87].counts = 2
    ComponentLookup[87].name = "TrashBinStaticDoor02"
    ComponentLookup[88].formid = 230809
    ComponentLookup[88].mask = 2
    ComponentLookup[88].counts = 12
    ComponentLookup[88].name = "TreeBlasted01"
    ComponentLookup[89].formid = 684550
    ComponentLookup[89].mask = 2
    ComponentLookup[89].counts = 12
    ComponentLookup[89].name = "TreeBlasted01Lichen"
    ComponentLookup[90].formid = 684551
    ComponentLookup[90].mask = 2
    ComponentLookup[90].counts = 12
    ComponentLookup[90].name = "TreeBlasted01LichenFX"
    ComponentLookup[91].formid = 234445
    ComponentLookup[91].mask = 2
    ComponentLookup[91].counts = 12
    ComponentLookup[91].name = "TreeBlasted02"
    ComponentLookup[92].formid = 684552
    ComponentLookup[92].mask = 2
    ComponentLookup[92].counts = 12
    ComponentLookup[92].name = "TreeBlasted02Lichen"
    ComponentLookup[93].formid = 684553
    ComponentLookup[93].mask = 2
    ComponentLookup[93].counts = 12
    ComponentLookup[93].name = "TreeBlasted02LichenFX"
    ComponentLookup[94].formid = 300338
    ComponentLookup[94].mask = 2
    ComponentLookup[94].counts = 12
    ComponentLookup[94].name = "TreeBlasted04"
    ComponentLookup[95].formid = 254093
    ComponentLookup[95].mask = 2
    ComponentLookup[95].counts = 12
    ComponentLookup[95].name = "TreeBlasted05"
    ComponentLookup[96].formid = 1185107
    ComponentLookup[96].mask = 2
    ComponentLookup[96].counts = 12
    ComponentLookup[96].name = "TreeBlastedForestBurntFallen01"
    ComponentLookup[97].formid = 1185108
    ComponentLookup[97].mask = 2
    ComponentLookup[97].counts = 12
    ComponentLookup[97].name = "TreeBlastedForestBurntFallen02_Bottom"
    ComponentLookup[98].formid = 1185099
    ComponentLookup[98].mask = 2
    ComponentLookup[98].counts = 12
    ComponentLookup[98].name = "TreeBlastedForestBurntFallen02_Top"
    ComponentLookup[99].formid = 1185100
    ComponentLookup[99].mask = 2
    ComponentLookup[99].counts = 12
    ComponentLookup[99].name = "TreeBlastedForestBurntFallen03"
	
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