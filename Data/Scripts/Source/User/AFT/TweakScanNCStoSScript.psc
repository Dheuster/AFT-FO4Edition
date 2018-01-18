Scriptname AFT:TweakScanNCStoSScript extends Quest

; import AFT

Quest Property TweakScrapScanMaster Auto Const
FormList Property TweakNonConstructed_StoS Auto Const

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
	string logName = "TweakScanNCStoSScript"
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
		; code += "    ComponentLookup[" + i + "].formid = " + TweakNonConstructed_StoS.GetAt(i).GetFormID() + "\n"
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
	results = center.FindAllReferencesOfType(TweakNonConstructed_StoS, radius)			
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
	
    ComponentLookup[0].formid = 2218929
    ComponentLookup[0].mask = 1
    ComponentLookup[0].counts = 10
    ComponentLookup[0].name = "Sedan_Postwar_Cheap01"
    ComponentLookup[1].formid = 2218930
    ComponentLookup[1].mask = 1
    ComponentLookup[1].counts = 10
    ComponentLookup[1].name = "Sedan_Postwar_Cheap02"
    ComponentLookup[2].formid = 2218931
    ComponentLookup[2].mask = 1
    ComponentLookup[2].counts = 10
    ComponentLookup[2].name = "Sedan_Postwar_Cheap03"
    ComponentLookup[3].formid = 2218932
    ComponentLookup[3].mask = 1
    ComponentLookup[3].counts = 10
    ComponentLookup[3].name = "Sedan_Postwar_Cheap04"
    ComponentLookup[4].formid = 207652
    ComponentLookup[4].mask = 2
    ComponentLookup[4].counts = 4
    ComponentLookup[4].name = "ShackWallHalfL01"
    ComponentLookup[5].formid = 207651
    ComponentLookup[5].mask = 2
    ComponentLookup[5].counts = 4
    ComponentLookup[5].name = "ShackWallHalfR01"
    ComponentLookup[6].formid = 402916
    ComponentLookup[6].mask = 1
    ComponentLookup[6].counts = 4
    ComponentLookup[6].name = "ShoppingCart01"
    ComponentLookup[7].formid = 1052578
    ComponentLookup[7].mask = 1
    ComponentLookup[7].counts = 4
    ComponentLookup[7].name = "ShoppingCart01Static"
    ComponentLookup[8].formid = 1529124
    ComponentLookup[8].mask = 1
    ComponentLookup[8].counts = 2
    ComponentLookup[8].name = "SignNoTrespassingGovtProperty"
    ComponentLookup[9].formid = 142560
    ComponentLookup[9].mask = 1
    ComponentLookup[9].counts = 2
    ComponentLookup[9].name = "SignRoad25MPH01"
    ComponentLookup[10].formid = 142557
    ComponentLookup[10].mask = 1
    ComponentLookup[10].counts = 2
    ComponentLookup[10].name = "SignRoadConcord01"
    ComponentLookup[11].formid = 216885
    ComponentLookup[11].mask = 1
    ComponentLookup[11].counts = 2
    ComponentLookup[11].name = "SignRoad_CurveLeft01"
    ComponentLookup[12].formid = 1641518
    ComponentLookup[12].mask = 1
    ComponentLookup[12].counts = 2
    ComponentLookup[12].name = "SignRoad_CurveLeft01Dest"
    ComponentLookup[13].formid = 240199
    ComponentLookup[13].mask = 1
    ComponentLookup[13].counts = 2
    ComponentLookup[13].name = "SignRoad_CurveLeft02"
    ComponentLookup[14].formid = 1641546
    ComponentLookup[14].mask = 1
    ComponentLookup[14].counts = 2
    ComponentLookup[14].name = "SignRoad_CurveLeft02Dest"
    ComponentLookup[15].formid = 240200
    ComponentLookup[15].mask = 1
    ComponentLookup[15].counts = 2
    ComponentLookup[15].name = "SignRoad_CurveLeft03"
    ComponentLookup[16].formid = 1641574
    ComponentLookup[16].mask = 1
    ComponentLookup[16].counts = 2
    ComponentLookup[16].name = "SignRoad_CurveLeft03Dest"
    ComponentLookup[17].formid = 240198
    ComponentLookup[17].mask = 1
    ComponentLookup[17].counts = 2
    ComponentLookup[17].name = "SignRoad_CurveLeft_NoPost01"
    ComponentLookup[18].formid = 1641602
    ComponentLookup[18].mask = 1
    ComponentLookup[18].counts = 2
    ComponentLookup[18].name = "SignRoad_CurveLeft_NoPost01Dest"
    ComponentLookup[19].formid = 216897
    ComponentLookup[19].mask = 1
    ComponentLookup[19].counts = 2
    ComponentLookup[19].name = "SignRoad_CurveRight01"
    ComponentLookup[20].formid = 1641520
    ComponentLookup[20].mask = 1
    ComponentLookup[20].counts = 2
    ComponentLookup[20].name = "SignRoad_CurveRight01Dest"
    ComponentLookup[21].formid = 240202
    ComponentLookup[21].mask = 1
    ComponentLookup[21].counts = 2
    ComponentLookup[21].name = "SignRoad_CurveRight02"
    ComponentLookup[22].formid = 1641548
    ComponentLookup[22].mask = 1
    ComponentLookup[22].counts = 2
    ComponentLookup[22].name = "SignRoad_CurveRight02Dest"
    ComponentLookup[23].formid = 240203
    ComponentLookup[23].mask = 1
    ComponentLookup[23].counts = 2
    ComponentLookup[23].name = "SignRoad_CurveRight03"
    ComponentLookup[24].formid = 1641576
    ComponentLookup[24].mask = 1
    ComponentLookup[24].counts = 2
    ComponentLookup[24].name = "SignRoad_CurveRight03Dest"
    ComponentLookup[25].formid = 240201
    ComponentLookup[25].mask = 1
    ComponentLookup[25].counts = 2
    ComponentLookup[25].name = "SignRoad_CurveRight_NoPost01"
    ComponentLookup[26].formid = 1641604
    ComponentLookup[26].mask = 1
    ComponentLookup[26].counts = 2
    ComponentLookup[26].name = "SignRoad_CurveRight_NoPost01Dest"
    ComponentLookup[27].formid = 240190
    ComponentLookup[27].mask = 1
    ComponentLookup[27].counts = 2
    ComponentLookup[27].name = "SignRoad_MPH25_01"
    ComponentLookup[28].formid = 1641530
    ComponentLookup[28].mask = 1
    ComponentLookup[28].counts = 2
    ComponentLookup[28].name = "SignRoad_MPH25_01Dest"
    ComponentLookup[29].formid = 240204
    ComponentLookup[29].mask = 1
    ComponentLookup[29].counts = 2
    ComponentLookup[29].name = "SignRoad_MPH25_02"
    ComponentLookup[30].formid = 1641558
    ComponentLookup[30].mask = 1
    ComponentLookup[30].counts = 2
    ComponentLookup[30].name = "SignRoad_MPH25_02Dest"
    ComponentLookup[31].formid = 240205
    ComponentLookup[31].mask = 1
    ComponentLookup[31].counts = 2
    ComponentLookup[31].name = "SignRoad_MPH25_03"
    ComponentLookup[32].formid = 1641586
    ComponentLookup[32].mask = 1
    ComponentLookup[32].counts = 2
    ComponentLookup[32].name = "SignRoad_MPH25_03Dest"
    ComponentLookup[33].formid = 240206
    ComponentLookup[33].mask = 1
    ComponentLookup[33].counts = 2
    ComponentLookup[33].name = "SignRoad_MPH25_NoPost01"
    ComponentLookup[34].formid = 1641614
    ComponentLookup[34].mask = 1
    ComponentLookup[34].counts = 2
    ComponentLookup[34].name = "SignRoad_MPH25_NoPost01Dest"
    ComponentLookup[35].formid = 240188
    ComponentLookup[35].mask = 1
    ComponentLookup[35].counts = 2
    ComponentLookup[35].name = "SignRoad_MPH45_01"
    ComponentLookup[36].formid = 1641532
    ComponentLookup[36].mask = 1
    ComponentLookup[36].counts = 2
    ComponentLookup[36].name = "SignRoad_MPH45_01Dest"
    ComponentLookup[37].formid = 240207
    ComponentLookup[37].mask = 1
    ComponentLookup[37].counts = 2
    ComponentLookup[37].name = "SignRoad_MPH45_02"
    ComponentLookup[38].formid = 1641560
    ComponentLookup[38].mask = 1
    ComponentLookup[38].counts = 2
    ComponentLookup[38].name = "SignRoad_MPH45_02Dest"
    ComponentLookup[39].formid = 240208
    ComponentLookup[39].mask = 1
    ComponentLookup[39].counts = 2
    ComponentLookup[39].name = "SignRoad_MPH45_03"
    ComponentLookup[40].formid = 1641588
    ComponentLookup[40].mask = 1
    ComponentLookup[40].counts = 2
    ComponentLookup[40].name = "SignRoad_MPH45_03Dest"
    ComponentLookup[41].formid = 240209
    ComponentLookup[41].mask = 1
    ComponentLookup[41].counts = 2
    ComponentLookup[41].name = "SignRoad_MPH45_NoPost01"
    ComponentLookup[42].formid = 1641616
    ComponentLookup[42].mask = 1
    ComponentLookup[42].counts = 2
    ComponentLookup[42].name = "SignRoad_MPH45_NoPost01Dest"
    ComponentLookup[43].formid = 240189
    ComponentLookup[43].mask = 1
    ComponentLookup[43].counts = 2
    ComponentLookup[43].name = "SignRoad_MPH75_01"
    ComponentLookup[44].formid = 1641534
    ComponentLookup[44].mask = 1
    ComponentLookup[44].counts = 2
    ComponentLookup[44].name = "SignRoad_MPH75_01Dest"
    ComponentLookup[45].formid = 240210
    ComponentLookup[45].mask = 1
    ComponentLookup[45].counts = 2
    ComponentLookup[45].name = "SignRoad_MPH75_02"
    ComponentLookup[46].formid = 1641562
    ComponentLookup[46].mask = 1
    ComponentLookup[46].counts = 2
    ComponentLookup[46].name = "SignRoad_MPH75_02Dest"
    ComponentLookup[47].formid = 240211
    ComponentLookup[47].mask = 1
    ComponentLookup[47].counts = 2
    ComponentLookup[47].name = "SignRoad_MPH75_03"
    ComponentLookup[48].formid = 1641590
    ComponentLookup[48].mask = 1
    ComponentLookup[48].counts = 2
    ComponentLookup[48].name = "SignRoad_MPH75_03Dest"
    ComponentLookup[49].formid = 240212
    ComponentLookup[49].mask = 1
    ComponentLookup[49].counts = 2
    ComponentLookup[49].name = "SignRoad_MPH75_NoPost01"
    ComponentLookup[50].formid = 1641618
    ComponentLookup[50].mask = 1
    ComponentLookup[50].counts = 2
    ComponentLookup[50].name = "SignRoad_MPH75_NoPost01Dest"
    ComponentLookup[51].formid = 216882
    ComponentLookup[51].mask = 1
    ComponentLookup[51].counts = 2
    ComponentLookup[51].name = "SignRoad_NoLeft01"
    ComponentLookup[52].formid = 1641511
    ComponentLookup[52].mask = 1
    ComponentLookup[52].counts = 2
    ComponentLookup[52].name = "SignRoad_NoLeft01Dest"
    ComponentLookup[53].formid = 240214
    ComponentLookup[53].mask = 1
    ComponentLookup[53].counts = 2
    ComponentLookup[53].name = "SignRoad_NoLeft02"
    ComponentLookup[54].formid = 1641542
    ComponentLookup[54].mask = 1
    ComponentLookup[54].counts = 2
    ComponentLookup[54].name = "SignRoad_NoLeft02Dest"
    ComponentLookup[55].formid = 240215
    ComponentLookup[55].mask = 1
    ComponentLookup[55].counts = 2
    ComponentLookup[55].name = "SignRoad_NoLeft03"
    ComponentLookup[56].formid = 1641570
    ComponentLookup[56].mask = 1
    ComponentLookup[56].counts = 2
    ComponentLookup[56].name = "SignRoad_NoLeft03Dest"
    ComponentLookup[57].formid = 240213
    ComponentLookup[57].mask = 1
    ComponentLookup[57].counts = 2
    ComponentLookup[57].name = "SignRoad_NoLeft_NoPost01"
    ComponentLookup[58].formid = 1641598
    ComponentLookup[58].mask = 1
    ComponentLookup[58].counts = 2
    ComponentLookup[58].name = "SignRoad_NoLeft_NoPost01Dest"
    ComponentLookup[59].formid = 216883
    ComponentLookup[59].mask = 1
    ComponentLookup[59].counts = 2
    ComponentLookup[59].name = "SignRoad_NoRight01"
    ComponentLookup[60].formid = 1641516
    ComponentLookup[60].mask = 1
    ComponentLookup[60].counts = 2
    ComponentLookup[60].name = "SignRoad_NoRight01Dest"
    ComponentLookup[61].formid = 240217
    ComponentLookup[61].mask = 1
    ComponentLookup[61].counts = 2
    ComponentLookup[61].name = "SignRoad_NoRight02"
    ComponentLookup[62].formid = 1641544
    ComponentLookup[62].mask = 1
    ComponentLookup[62].counts = 2
    ComponentLookup[62].name = "SignRoad_NoRight02Dest"
    ComponentLookup[63].formid = 240218
    ComponentLookup[63].mask = 1
    ComponentLookup[63].counts = 2
    ComponentLookup[63].name = "SignRoad_NoRight03"
    ComponentLookup[64].formid = 1641572
    ComponentLookup[64].mask = 1
    ComponentLookup[64].counts = 2
    ComponentLookup[64].name = "SignRoad_NoRight03Dest"
    ComponentLookup[65].formid = 240216
    ComponentLookup[65].mask = 1
    ComponentLookup[65].counts = 2
    ComponentLookup[65].name = "SignRoad_NoRight_NoPost01"
    ComponentLookup[66].formid = 1641600
    ComponentLookup[66].mask = 1
    ComponentLookup[66].counts = 2
    ComponentLookup[66].name = "SignRoad_NoRight_NoPost01Dest"
    ComponentLookup[67].formid = 216899
    ComponentLookup[67].mask = 1
    ComponentLookup[67].counts = 2
    ComponentLookup[67].name = "SignRoad_OneWayL01"
    ComponentLookup[68].formid = 1641526
    ComponentLookup[68].mask = 1
    ComponentLookup[68].counts = 2
    ComponentLookup[68].name = "SignRoad_OneWayL01Dest"
    ComponentLookup[69].formid = 240220
    ComponentLookup[69].mask = 1
    ComponentLookup[69].counts = 2
    ComponentLookup[69].name = "SignRoad_OneWayL02"
    ComponentLookup[70].formid = 1641554
    ComponentLookup[70].mask = 1
    ComponentLookup[70].counts = 2
    ComponentLookup[70].name = "SignRoad_OneWayL02Dest"
    ComponentLookup[71].formid = 240221
    ComponentLookup[71].mask = 1
    ComponentLookup[71].counts = 2
    ComponentLookup[71].name = "SignRoad_OneWayL03"
    ComponentLookup[72].formid = 1641582
    ComponentLookup[72].mask = 1
    ComponentLookup[72].counts = 2
    ComponentLookup[72].name = "SignRoad_OneWayL03Dest"
    ComponentLookup[73].formid = 240219
    ComponentLookup[73].mask = 1
    ComponentLookup[73].counts = 2
    ComponentLookup[73].name = "SignRoad_OneWayL_NoPost01"
    ComponentLookup[74].formid = 1641610
    ComponentLookup[74].mask = 1
    ComponentLookup[74].counts = 2
    ComponentLookup[74].name = "SignRoad_OneWayL_NoPost01Dest"
    ComponentLookup[75].formid = 216894
    ComponentLookup[75].mask = 1
    ComponentLookup[75].counts = 2
    ComponentLookup[75].name = "SignRoad_OneWayR01"
    ComponentLookup[76].formid = 1641528
    ComponentLookup[76].mask = 1
    ComponentLookup[76].counts = 2
    ComponentLookup[76].name = "SignRoad_OneWayR01Dest"
    ComponentLookup[77].formid = 240223
    ComponentLookup[77].mask = 1
    ComponentLookup[77].counts = 2
    ComponentLookup[77].name = "SignRoad_OneWayR02"
    ComponentLookup[78].formid = 1641556
    ComponentLookup[78].mask = 1
    ComponentLookup[78].counts = 2
    ComponentLookup[78].name = "SignRoad_OneWayR02Dest"
    ComponentLookup[79].formid = 240224
    ComponentLookup[79].mask = 1
    ComponentLookup[79].counts = 2
    ComponentLookup[79].name = "SignRoad_OneWayR03"
    ComponentLookup[80].formid = 1641584
    ComponentLookup[80].mask = 1
    ComponentLookup[80].counts = 2
    ComponentLookup[80].name = "SignRoad_OneWayR03Dest"
    ComponentLookup[81].formid = 240222
    ComponentLookup[81].mask = 1
    ComponentLookup[81].counts = 2
    ComponentLookup[81].name = "SignRoad_OneWayR_NoPost01"
    ComponentLookup[82].formid = 1641612
    ComponentLookup[82].mask = 1
    ComponentLookup[82].counts = 2
    ComponentLookup[82].name = "SignRoad_OneWayR_NoPost01Dest"
    ComponentLookup[83].formid = 1641510
    ComponentLookup[83].mask = 1
    ComponentLookup[83].counts = 2
    ComponentLookup[83].name = "SignRoad_RR01Dest"
    ComponentLookup[84].formid = 1641538
    ComponentLookup[84].mask = 1
    ComponentLookup[84].counts = 2
    ComponentLookup[84].name = "SignRoad_RR02Dest"
    ComponentLookup[85].formid = 240227
    ComponentLookup[85].mask = 1
    ComponentLookup[85].counts = 2
    ComponentLookup[85].name = "SignRoad_RR03"
    ComponentLookup[86].formid = 1641566
    ComponentLookup[86].mask = 1
    ComponentLookup[86].counts = 2
    ComponentLookup[86].name = "SignRoad_RR03Dest"
    ComponentLookup[87].formid = 216881
    ComponentLookup[87].mask = 1
    ComponentLookup[87].counts = 2
    ComponentLookup[87].name = "SignRoad_RR101"
    ComponentLookup[88].formid = 240226
    ComponentLookup[88].mask = 1
    ComponentLookup[88].counts = 2
    ComponentLookup[88].name = "SignRoad_RR102"
    ComponentLookup[89].formid = 240225
    ComponentLookup[89].mask = 1
    ComponentLookup[89].counts = 2
    ComponentLookup[89].name = "SignRoad_RR_NoPost01"
    ComponentLookup[90].formid = 1641594
    ComponentLookup[90].mask = 1
    ComponentLookup[90].counts = 2
    ComponentLookup[90].name = "SignRoad_RR_NoPost01Dest"
    ComponentLookup[91].formid = 216879
    ComponentLookup[91].mask = 1
    ComponentLookup[91].counts = 2
    ComponentLookup[91].name = "SignRoad_Stop01"
    ComponentLookup[92].formid = 1009521
    ComponentLookup[92].mask = 1
    ComponentLookup[92].counts = 2
    ComponentLookup[92].name = "SignRoad_Stop01Dest"
    ComponentLookup[93].formid = 240229
    ComponentLookup[93].mask = 1
    ComponentLookup[93].counts = 2
    ComponentLookup[93].name = "SignRoad_Stop02"
    ComponentLookup[94].formid = 1641536
    ComponentLookup[94].mask = 1
    ComponentLookup[94].counts = 2
    ComponentLookup[94].name = "SignRoad_Stop02Dest"
    ComponentLookup[95].formid = 240230
    ComponentLookup[95].mask = 1
    ComponentLookup[95].counts = 2
    ComponentLookup[95].name = "SignRoad_Stop03"
    ComponentLookup[96].formid = 1641564
    ComponentLookup[96].mask = 1
    ComponentLookup[96].counts = 2
    ComponentLookup[96].name = "SignRoad_Stop03Dest"
    ComponentLookup[97].formid = 240228
    ComponentLookup[97].mask = 1
    ComponentLookup[97].counts = 2
    ComponentLookup[97].name = "SignRoad_Stop_NoPost01"
    ComponentLookup[98].formid = 1641592
    ComponentLookup[98].mask = 1
    ComponentLookup[98].counts = 2
    ComponentLookup[98].name = "SignRoad_Stop_NoPost01Dest"
    ComponentLookup[99].formid = 216901
    ComponentLookup[99].mask = 1
    ComponentLookup[99].counts = 2
    ComponentLookup[99].name = "SignRoad_TurnLeft01"
	
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