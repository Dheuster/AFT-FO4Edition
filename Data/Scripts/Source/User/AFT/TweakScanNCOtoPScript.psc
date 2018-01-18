Scriptname AFT:TweakScanNCOtoPScript extends Quest

; import AFT

Quest Property TweakScrapScanMaster Auto Const
FormList Property TweakNonConstructed_OtoP Auto Const

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
	string logName = "TweakScanNCOtoPScript"
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
		; code += "    ComponentLookup[" + i + "].formid = " + TweakNonConstructed_OtoP.GetAt(i).GetFormID() + "\n"
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
	results = center.FindAllReferencesOfType(TweakNonConstructed_OtoP, radius)			
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

    ComponentLookup[0].formid = 240109
    ComponentLookup[0].mask = 18
    ComponentLookup[0].counts = 65
    ComponentLookup[0].name = "OfficeBoxPapers03"
    ComponentLookup[1].formid = 1037207
    ComponentLookup[1].mask = 18
    ComponentLookup[1].counts = 65
    ComponentLookup[1].name = "OfficeBoxPapers03Prewar"
    ComponentLookup[2].formid = 1734633
    ComponentLookup[2].mask = 18
    ComponentLookup[2].counts = 65
    ComponentLookup[2].name = "OfficeBoxPapersOpen01"
    ComponentLookup[3].formid = 1734638
    ComponentLookup[3].mask = 18
    ComponentLookup[3].counts = 65
    ComponentLookup[3].name = "OfficeBoxPapersOpen02"
    ComponentLookup[4].formid = 1734641
    ComponentLookup[4].mask = 18
    ComponentLookup[4].counts = 65
    ComponentLookup[4].name = "OfficeBoxPapersOpen03"
    ComponentLookup[5].formid = 1734643
    ComponentLookup[5].mask = 18
    ComponentLookup[5].counts = 65
    ComponentLookup[5].name = "OfficeBoxPapersOpen04"
    ComponentLookup[6].formid = 1734667
    ComponentLookup[6].mask = 18
    ComponentLookup[6].counts = 65
    ComponentLookup[6].name = "OfficeBoxPapersOpen05"
    ComponentLookup[7].formid = 1734684
    ComponentLookup[7].mask = 18
    ComponentLookup[7].counts = 65
    ComponentLookup[7].name = "OfficeBoxPapersOpen06"
    ComponentLookup[8].formid = 1734731
    ComponentLookup[8].mask = 18
    ComponentLookup[8].counts = 65
    ComponentLookup[8].name = "OfficeBoxPapersOpen07"
    ComponentLookup[9].formid = 1748483
    ComponentLookup[9].mask = 18
    ComponentLookup[9].counts = 65
    ComponentLookup[9].name = "OfficeBoxPapersOpen08"
    ComponentLookup[10].formid = 1748484
    ComponentLookup[10].mask = 18
    ComponentLookup[10].counts = 65
    ComponentLookup[10].name = "OfficeBoxPapersOpen09"
    ComponentLookup[11].formid = 1748485
    ComponentLookup[11].mask = 18
    ComponentLookup[11].counts = 65
    ComponentLookup[11].name = "OfficeBoxPapersOpen09a"
    ComponentLookup[12].formid = 1748486
    ComponentLookup[12].mask = 18
    ComponentLookup[12].counts = 65
    ComponentLookup[12].name = "OfficeBoxPapersOpen09b"
    ComponentLookup[13].formid = 300576
    ComponentLookup[13].mask = 1
    ComponentLookup[13].counts = 4
    ComponentLookup[13].name = "OfficeFileCabinetDrawer01"
    ComponentLookup[14].formid = 714033
    ComponentLookup[14].mask = 1
    ComponentLookup[14].counts = 4
    ComponentLookup[14].name = "OfficeFileCabinetDrawer01_Beige"
    ComponentLookup[15].formid = 300577
    ComponentLookup[15].mask = 1
    ComponentLookup[15].counts = 4
    ComponentLookup[15].name = "OfficeFileCabinetEmpty01"
    ComponentLookup[16].formid = 714035
    ComponentLookup[16].mask = 1
    ComponentLookup[16].counts = 4
    ComponentLookup[16].name = "OfficeFileCabinetEmpty01_Beige"
    ComponentLookup[17].formid = 714034
    ComponentLookup[17].mask = 1
    ComponentLookup[17].counts = 4
    ComponentLookup[17].name = "OfficeFileCabinetEmpty01_Steel"
    ComponentLookup[18].formid = 275273
    ComponentLookup[18].mask = 133
    ComponentLookup[18].counts = 8452
    ComponentLookup[18].name = "PhoneBooth"
    ComponentLookup[19].formid = 276033
    ComponentLookup[19].mask = 129
    ComponentLookup[19].counts = 258
    ComponentLookup[19].name = "PhoneBooth_TopAddition"
    ComponentLookup[20].formid = 1804955
    ComponentLookup[20].mask = 1
    ComponentLookup[20].counts = 15
    ComponentLookup[20].name = "PickUpTruck01"
    ComponentLookup[21].formid = 1580561
    ComponentLookup[21].mask = 1
    ComponentLookup[21].counts = 10
    ComponentLookup[21].name = "PickUpTruck01A_Static"
    ComponentLookup[22].formid = 1580593
    ComponentLookup[22].mask = 1
    ComponentLookup[22].counts = 10
    ComponentLookup[22].name = "PickUpTruck01B_Static"
    ComponentLookup[23].formid = 1804956
    ComponentLookup[23].mask = 1
    ComponentLookup[23].counts = 15
    ComponentLookup[23].name = "PickUpTruck02"
    ComponentLookup[24].formid = 1588911
    ComponentLookup[24].mask = 1
    ComponentLookup[24].counts = 10
    ComponentLookup[24].name = "PickUpTruck02A_Static"
    ComponentLookup[25].formid = 1588912
    ComponentLookup[25].mask = 1
    ComponentLookup[25].counts = 10
    ComponentLookup[25].name = "PickUpTruck02B_Static"
    ComponentLookup[26].formid = 1804957
    ComponentLookup[26].mask = 1
    ComponentLookup[26].counts = 15
    ComponentLookup[26].name = "PickUpTruck03"
    ComponentLookup[27].formid = 1588913
    ComponentLookup[27].mask = 1
    ComponentLookup[27].counts = 10
    ComponentLookup[27].name = "PickUpTruck03A_Static"
    ComponentLookup[28].formid = 1588914
    ComponentLookup[28].mask = 1
    ComponentLookup[28].counts = 10
    ComponentLookup[28].name = "PickUpTruck03B_Static"
    ComponentLookup[29].formid = 1804958
    ComponentLookup[29].mask = 1
    ComponentLookup[29].counts = 15
    ComponentLookup[29].name = "PickUpTruck04"
    ComponentLookup[30].formid = 1588915
    ComponentLookup[30].mask = 1
    ComponentLookup[30].counts = 10
    ComponentLookup[30].name = "PickUpTruck04A_Static"
    ComponentLookup[31].formid = 1588916
    ComponentLookup[31].mask = 1
    ComponentLookup[31].counts = 10
    ComponentLookup[31].name = "PickUpTruck04B_Static"
    ComponentLookup[32].formid = 1804959
    ComponentLookup[32].mask = 1
    ComponentLookup[32].counts = 15
    ComponentLookup[32].name = "PickUpTruck05"
    ComponentLookup[33].formid = 1804960
    ComponentLookup[33].mask = 1
    ComponentLookup[33].counts = 15
    ComponentLookup[33].name = "PickUpTruck06"
    ComponentLookup[34].formid = 1804961
    ComponentLookup[34].mask = 1
    ComponentLookup[34].counts = 15
    ComponentLookup[34].name = "PickUpTruck07"
    ComponentLookup[35].formid = 1804962
    ComponentLookup[35].mask = 1
    ComponentLookup[35].counts = 15
    ComponentLookup[35].name = "PickUpTruck08"
    ComponentLookup[36].formid = 1804963
    ComponentLookup[36].mask = 1
    ComponentLookup[36].counts = 15
    ComponentLookup[36].name = "PickUpTruck09"
    ComponentLookup[37].formid = 1804964
    ComponentLookup[37].mask = 1
    ComponentLookup[37].counts = 15
    ComponentLookup[37].name = "PickUpTruck10"
    ComponentLookup[38].formid = 1804965
    ComponentLookup[38].mask = 1
    ComponentLookup[38].counts = 15
    ComponentLookup[38].name = "PickUpTruck11"
    ComponentLookup[39].formid = 2218937
    ComponentLookup[39].mask = 1
    ComponentLookup[39].counts = 10
    ComponentLookup[39].name = "PickUpTruck_Postwar_Cheap01"
    ComponentLookup[40].formid = 2218938
    ComponentLookup[40].mask = 1
    ComponentLookup[40].counts = 10
    ComponentLookup[40].name = "PickUpTruck_Postwar_Cheap02"
    ComponentLookup[41].formid = 2218939
    ComponentLookup[41].mask = 1
    ComponentLookup[41].counts = 10
    ComponentLookup[41].name = "PickUpTruck_Postwar_Cheap03"
    ComponentLookup[42].formid = 2218940
    ComponentLookup[42].mask = 1
    ComponentLookup[42].counts = 10
    ComponentLookup[42].name = "PickUpTruck_Postwar_Cheap04"
    ComponentLookup[43].formid = 346562
    ComponentLookup[43].mask = 2
    ComponentLookup[43].counts = 1
    ComponentLookup[43].name = "PicketFenceB_SlatSingle01"
    ComponentLookup[44].formid = 98826
    ComponentLookup[44].mask = 2
    ComponentLookup[44].counts = 20
    ComponentLookup[44].name = "PicnicTable01Static"
    ComponentLookup[45].formid = 98827
    ComponentLookup[45].mask = 2
    ComponentLookup[45].counts = 20
    ComponentLookup[45].name = "PicnicTable02Static"
    ComponentLookup[46].formid = 1883966
    ComponentLookup[46].mask = 2
    ComponentLookup[46].counts = 4
    ComponentLookup[46].name = "PictureAbstractRect01"
    ComponentLookup[47].formid = 1884529
    ComponentLookup[47].mask = 2
    ComponentLookup[47].counts = 4
    ComponentLookup[47].name = "PictureAbstractRect01Framed01"
    ComponentLookup[48].formid = 1884530
    ComponentLookup[48].mask = 2
    ComponentLookup[48].counts = 4
    ComponentLookup[48].name = "PictureAbstractRect01Framed02"
    ComponentLookup[49].formid = 1883964
    ComponentLookup[49].mask = 2
    ComponentLookup[49].counts = 4
    ComponentLookup[49].name = "PictureAbstractSquare01"
    ComponentLookup[50].formid = 117863
    ComponentLookup[50].mask = 2
    ComponentLookup[50].counts = 4
    ComponentLookup[50].name = "PictureFrame01"
    ComponentLookup[51].formid = 117864
    ComponentLookup[51].mask = 2
    ComponentLookup[51].counts = 4
    ComponentLookup[51].name = "PictureFrame02"
    ComponentLookup[52].formid = 117858
    ComponentLookup[52].mask = 2
    ComponentLookup[52].counts = 4
    ComponentLookup[52].name = "PictureFrame03"
    ComponentLookup[53].formid = 117859
    ComponentLookup[53].mask = 2
    ComponentLookup[53].counts = 4
    ComponentLookup[53].name = "PictureFrame04"
    ComponentLookup[54].formid = 117860
    ComponentLookup[54].mask = 2
    ComponentLookup[54].counts = 4
    ComponentLookup[54].name = "PictureFrame05"
    ComponentLookup[55].formid = 117861
    ComponentLookup[55].mask = 2
    ComponentLookup[55].counts = 4
    ComponentLookup[55].name = "PictureFrame06"
    ComponentLookup[56].formid = 1020646
    ComponentLookup[56].mask = 2
    ComponentLookup[56].counts = 4
    ComponentLookup[56].name = "PictureFrame07"
    ComponentLookup[57].formid = 1048711
    ComponentLookup[57].mask = 2
    ComponentLookup[57].counts = 4
    ComponentLookup[57].name = "PictureFrameModern01"
    ComponentLookup[58].formid = 1048712
    ComponentLookup[58].mask = 2
    ComponentLookup[58].counts = 4
    ComponentLookup[58].name = "PictureFrameModern02"
    ComponentLookup[59].formid = 1048713
    ComponentLookup[59].mask = 2
    ComponentLookup[59].counts = 4
    ComponentLookup[59].name = "PictureFrameModern03"
    ComponentLookup[60].formid = 1048714
    ComponentLookup[60].mask = 2
    ComponentLookup[60].counts = 4
    ComponentLookup[60].name = "PictureFrameModern04"
    ComponentLookup[61].formid = 1048715
    ComponentLookup[61].mask = 2
    ComponentLookup[61].counts = 4
    ComponentLookup[61].name = "PictureFrameModern05"
    ComponentLookup[62].formid = 1048716
    ComponentLookup[62].mask = 2
    ComponentLookup[62].counts = 4
    ComponentLookup[62].name = "PictureFrameModern06"
    ComponentLookup[63].formid = 1603174
    ComponentLookup[63].mask = 2
    ComponentLookup[63].counts = 4
    ComponentLookup[63].name = "PictureFramePortrait01"
    ComponentLookup[64].formid = 1603175
    ComponentLookup[64].mask = 2
    ComponentLookup[64].counts = 4
    ComponentLookup[64].name = "PictureFramePortrait02"
    ComponentLookup[65].formid = 1603176
    ComponentLookup[65].mask = 2
    ComponentLookup[65].counts = 4
    ComponentLookup[65].name = "PictureFramePortrait03"
    ComponentLookup[66].formid = 1603177
    ComponentLookup[66].mask = 2
    ComponentLookup[66].counts = 4
    ComponentLookup[66].name = "PictureFramePortrait04"
    ComponentLookup[67].formid = 1603178
    ComponentLookup[67].mask = 2
    ComponentLookup[67].counts = 4
    ComponentLookup[67].name = "PictureFramePortrait05"
    ComponentLookup[68].formid = 1603179
    ComponentLookup[68].mask = 2
    ComponentLookup[68].counts = 4
    ComponentLookup[68].name = "PictureFramePortrait06"
    ComponentLookup[69].formid = 1603180
    ComponentLookup[69].mask = 2
    ComponentLookup[69].counts = 4
    ComponentLookup[69].name = "PictureFramePortrait07"
    ComponentLookup[70].formid = 1733005
    ComponentLookup[70].mask = 2
    ComponentLookup[70].counts = 4
    ComponentLookup[70].name = "PictureFrameRect01"
    ComponentLookup[71].formid = 1733043
    ComponentLookup[71].mask = 2
    ComponentLookup[71].counts = 4
    ComponentLookup[71].name = "PictureFrameRect02"
    ComponentLookup[72].formid = 1733045
    ComponentLookup[72].mask = 2
    ComponentLookup[72].counts = 4
    ComponentLookup[72].name = "PictureFrameRect03"
    ComponentLookup[73].formid = 1733047
    ComponentLookup[73].mask = 2
    ComponentLookup[73].counts = 4
    ComponentLookup[73].name = "PictureFrameRect04"
    ComponentLookup[74].formid = 1733049
    ComponentLookup[74].mask = 2
    ComponentLookup[74].counts = 4
    ComponentLookup[74].name = "PictureFrameRect05"
    ComponentLookup[75].formid = 1733051
    ComponentLookup[75].mask = 2
    ComponentLookup[75].counts = 4
    ComponentLookup[75].name = "PictureFrameRect06"
    ComponentLookup[76].formid = 1733053
    ComponentLookup[76].mask = 2
    ComponentLookup[76].counts = 4
    ComponentLookup[76].name = "PictureFrameRect07"
    ComponentLookup[77].formid = 1001269
    ComponentLookup[77].mask = 5
    ComponentLookup[77].counts = 67
    ComponentLookup[77].name = "PlayerHouse_KitchenRefrigeratorDoor02_Blue"
    ComponentLookup[78].formid = 362570
    ComponentLookup[78].mask = 5
    ComponentLookup[78].counts = 69
    ComponentLookup[78].name = "PlayerHouse_KitchenStove01"
    ComponentLookup[79].formid = 315853
    ComponentLookup[79].mask = 8
    ComponentLookup[79].counts = 1
    ComponentLookup[79].name = "PlayerHouse_Rug01"
    ComponentLookup[80].formid = 315854
    ComponentLookup[80].mask = 8
    ComponentLookup[80].counts = 1
    ComponentLookup[80].name = "PlayerHouse_Rug02"
    ComponentLookup[81].formid = 163508
    ComponentLookup[81].mask = 8
    ComponentLookup[81].counts = 1
    ComponentLookup[81].name = "PlayerHouse_Rug03"
    ComponentLookup[82].formid = 163509
    ComponentLookup[82].mask = 8
    ComponentLookup[82].counts = 1
    ComponentLookup[82].name = "PlayerHouse_Rug04"
    ComponentLookup[83].formid = 163510
    ComponentLookup[83].mask = 8
    ComponentLookup[83].counts = 1
    ComponentLookup[83].name = "PlayerHouse_Rug05"
    ComponentLookup[84].formid = 315847
    ComponentLookup[84].mask = 2
    ComponentLookup[84].counts = 4
    ComponentLookup[84].name = "PlayerHouse_CoatRack01"
    ComponentLookup[85].formid = 471660
    ComponentLookup[85].mask = 2
    ComponentLookup[85].counts = 1
    ComponentLookup[85].name = "PlayerHouse_Ruin_CoatRack01"
    ComponentLookup[86].formid = 1684897
    ComponentLookup[86].mask = 2
    ComponentLookup[86].counts = 4
    ComponentLookup[86].name = "PlayerHouse_Ruin_CoffeeTable01Debris01"
    ComponentLookup[87].formid = 1684899
    ComponentLookup[87].mask = 2
    ComponentLookup[87].counts = 4
    ComponentLookup[87].name = "PlayerHouse_Ruin_CoffeeTable01Debris02"
    ComponentLookup[88].formid = 1684901
    ComponentLookup[88].mask = 2
    ComponentLookup[88].counts = 4
    ComponentLookup[88].name = "PlayerHouse_Ruin_CoffeeTable01Debris03"
    ComponentLookup[89].formid = 702246
    ComponentLookup[89].mask = 5
    ComponentLookup[89].counts = 69
    ComponentLookup[89].name = "PlayerHouse_Ruin_KitchenRefrigerator02_Static_BareMetal"
    ComponentLookup[90].formid = 702240
    ComponentLookup[90].mask = 5
    ComponentLookup[90].counts = 69
    ComponentLookup[90].name = "PlayerHouse_Ruin_KitchenRefrigerator02_Static_Blue"
    ComponentLookup[91].formid = 702247
    ComponentLookup[91].mask = 5
    ComponentLookup[91].counts = 69
    ComponentLookup[91].name = "PlayerHouse_Ruin_KitchenRefrigerator02_Static_White"
    ComponentLookup[92].formid = 702248
    ComponentLookup[92].mask = 5
    ComponentLookup[92].counts = 69
    ComponentLookup[92].name = "PlayerHouse_Ruin_KitchenRefrigerator02_Static_Yellow"
    ComponentLookup[93].formid = 1725566
    ComponentLookup[93].mask = 5
    ComponentLookup[93].counts = 67
    ComponentLookup[93].name = "PlayerHouse_Ruin_KitchenRefrigeratorDoor02Static_BareMetal"
    ComponentLookup[94].formid = 1098406
    ComponentLookup[94].mask = 5
    ComponentLookup[94].counts = 67
    ComponentLookup[94].name = "PlayerHouse_Ruin_KitchenRefrigeratorDoor02Static_Blue"
    ComponentLookup[95].formid = 1725567
    ComponentLookup[95].mask = 5
    ComponentLookup[95].counts = 67
    ComponentLookup[95].name = "PlayerHouse_Ruin_KitchenRefrigeratorDoor02Static_White"
    ComponentLookup[96].formid = 1098408
    ComponentLookup[96].mask = 5
    ComponentLookup[96].counts = 67
    ComponentLookup[96].name = "PlayerHouse_Ruin_KitchenRefrigeratorDoor02Static_Yellow"
    ComponentLookup[97].formid = 702243
    ComponentLookup[97].mask = 5
    ComponentLookup[97].counts = 67
    ComponentLookup[97].name = "PlayerHouse_Ruin_KitchenRefrigeratorDoor02_BareMetal"
    ComponentLookup[98].formid = 702239
    ComponentLookup[98].mask = 5
    ComponentLookup[98].counts = 67
    ComponentLookup[98].name = "PlayerHouse_Ruin_KitchenRefrigeratorDoor02_Blue"
    ComponentLookup[99].formid = 702244
    ComponentLookup[99].mask = 5
    ComponentLookup[99].counts = 67
    ComponentLookup[99].name = "PlayerHouse_Ruin_KitchenRefrigeratorDoor02_White"
	
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