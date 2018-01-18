Scriptname AFT:TweakScanCW2wScript extends Quest

; import AFT

Quest Property TweakScrapScanMaster Auto Const
FormList Property TweakConstructed_Wtow Auto Const

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
	string logName = "TweakScanCW2wScript"
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
		; code += "    ComponentLookup[" + i + "].formid = " + TweakConstructed_Wtow.GetAt(i).GetFormID() + "\n"
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
	results = center.FindAllReferencesOfType(TweakConstructed_Wtow, radius)			
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

    ; Array co-insides with FORMLIST. This was generated using a combination of
	; Python and Papyrus...
	
    ComponentLookup[0].formid = 1431407
    ComponentLookup[0].mask = 547
    ComponentLookup[0].counts = 270465
    ComponentLookup[0].name = "WorkshopPowerPylon01"
    ComponentLookup[1].formid = 1281014
    ComponentLookup[1].mask = 549
    ComponentLookup[1].counts = 802888
    ComponentLookup[1].name = "WorkshopPowerPylon02"
    ComponentLookup[2].formid = 1333309
    ComponentLookup[2].mask = 551
    ComponentLookup[2].counts = 17567874
    ComponentLookup[2].name = "WorkshopPowerPylonSwitch01"
    ComponentLookup[3].formid = 1281016
    ComponentLookup[3].mask = 549
    ComponentLookup[3].counts = 806985
    ComponentLookup[3].name = "WorkshopPowerPylonSwitch02"
    ComponentLookup[4].formid = 1281012
    ComponentLookup[4].mask = 37
    ComponentLookup[4].counts = 4162
    ComponentLookup[4].name = "WorkshopPowerSwitchbox01"
    ComponentLookup[5].formid = 2164192
    ComponentLookup[5].mask = 1059
    ComponentLookup[5].counts = 266306
    ComponentLookup[5].name = "WorkshopPoweredSpeaker01"
    ComponentLookup[6].formid = 1339063
    ComponentLookup[6].mask = 32801
    ComponentLookup[6].counts = 8387
    ComponentLookup[6].name = "WorkshopPressurePlate01"
    ComponentLookup[7].formid = 172435
    ComponentLookup[7].mask = 8389157
    ComponentLookup[7].counts = 34365514
    ComponentLookup[7].name = "WorkshopRadioBeacon"
    ComponentLookup[8].formid = 550732
    ComponentLookup[8].mask = 3
    ComponentLookup[8].counts = 323
    ComponentLookup[8].name = "WorkshopScavengingStation"
    ComponentLookup[9].formid = 803908
    ComponentLookup[9].mask = 549
    ComponentLookup[9].counts = 806985
    ComponentLookup[9].name = "WorkshopSiren01"
    ComponentLookup[10].formid = 2283992
    ComponentLookup[10].mask = 1185
    ComponentLookup[10].counts = 266306
    ComponentLookup[10].name = "WorkshopStrobeLight01"
    ComponentLookup[11].formid = 2165617
    ComponentLookup[11].mask = 546
    ComponentLookup[11].counts = 4226
    ComponentLookup[11].name = "WorkshopSwitchDelay01"
    ComponentLookup[12].formid = 2240276
    ComponentLookup[12].mask = 546
    ComponentLookup[12].counts = 4226
    ComponentLookup[12].name = "WorkshopSwitchDelay02"
    ComponentLookup[13].formid = 725042
    ComponentLookup[13].mask = 546
    ComponentLookup[13].counts = 4226
    ComponentLookup[13].name = "WorkshopSwitchInterval01"
    ComponentLookup[14].formid = 2279019
    ComponentLookup[14].mask = 1411
    ComponentLookup[14].counts = 50864258
    ComponentLookup[14].name = "WorkshopTelevision01"
    ComponentLookup[15].formid = 2279023
    ComponentLookup[15].mask = 1411
    ComponentLookup[15].counts = 50864322
    ComponentLookup[15].name = "WorkshopTelevision01Table"
    ComponentLookup[16].formid = 846455
    ComponentLookup[16].mask = 1316
    ComponentLookup[16].counts = 540802
    ComponentLookup[16].name = "WorkshopTerminal"
    ComponentLookup[17].formid = 2156673
    ComponentLookup[17].mask = 1057
    ComponentLookup[17].counts = 4290
    ComponentLookup[17].name = "WorkshopTrapElectricalArc01"
    ComponentLookup[18].formid = 2089822
    ComponentLookup[18].mask = 8516
    ComponentLookup[18].counts = 1589380
    ComponentLookup[18].name = "WorkshopTrapFlameThrower01"
    ComponentLookup[19].formid = 1333011
    ComponentLookup[19].mask = 16842817
    ComponentLookup[19].counts = 536706
    ComponentLookup[19].name = "WorkshopTrapRadiation"
    ComponentLookup[20].formid = 2005286
    ComponentLookup[20].mask = 8650753
    ComponentLookup[20].counts = 4228
    ComponentLookup[20].name = "WorkshopTripwireLaser01"
    ComponentLookup[21].formid = 2005290
    ComponentLookup[21].mask = 8650753
    ComponentLookup[21].counts = 4228
    ComponentLookup[21].name = "WorkshopTripwireLaser02"
    ComponentLookup[22].formid = 2338323
    ComponentLookup[22].mask = 1
    ComponentLookup[22].counts = 2
    ComponentLookup[22].name = "WorkshopWallShelfMetal01"
    ComponentLookup[23].formid = 2338324
    ComponentLookup[23].mask = 1
    ComponentLookup[23].counts = 2
    ComponentLookup[23].name = "WorkshopWallShelfMetal02"
    ComponentLookup[24].formid = 2338325
    ComponentLookup[24].mask = 2
    ComponentLookup[24].counts = 2
    ComponentLookup[24].name = "WorkshopWallShelfWood01"
    ComponentLookup[25].formid = 2338326
    ComponentLookup[25].mask = 2
    ComponentLookup[25].counts = 2
    ComponentLookup[25].name = "WorkshopWallShelfWood02"
    ComponentLookup[26].formid = 132492
    ComponentLookup[26].mask = 8741
    ComponentLookup[26].counts = 34087242
    ComponentLookup[26].name = "WorkshopWaterPurifier"
    ComponentLookup[27].formid = 1153978
    ComponentLookup[27].mask = 613
    ComponentLookup[27].counts = 35144340
    ComponentLookup[27].name = "WorkshopWaterPurifierLarge"
    ComponentLookup[28].formid = 2327621
    ComponentLookup[28].mask = 32
    ComponentLookup[28].counts = 20
    ComponentLookup[28].name = "Workshop_Fountain01"
    ComponentLookup[29].formid = 2282193
    ComponentLookup[29].mask = 161
    ComponentLookup[29].counts = 4162
    ComponentLookup[29].name = "Workshop_HighTechLightCeiling04_Dirty_Cream_On"
    ComponentLookup[30].formid = 2282197
    ComponentLookup[30].mask = 161
    ComponentLookup[30].counts = 4162
    ComponentLookup[30].name = "Workshop_HighTechLightCeiling04_Dirty_Orange_On"
    ComponentLookup[31].formid = 2282194
    ComponentLookup[31].mask = 161
    ComponentLookup[31].counts = 4162
    ComponentLookup[31].name = "Workshop_HighTechLightCeiling06_Dirty_Cream_On"
    ComponentLookup[32].formid = 2282198
    ComponentLookup[32].mask = 161
    ComponentLookup[32].counts = 4162
    ComponentLookup[32].name = "Workshop_HighTechLightCeiling06_Dirty_Orange_On"
    ComponentLookup[33].formid = 2282181
    ComponentLookup[33].mask = 161
    ComponentLookup[33].counts = 4162
    ComponentLookup[33].name = "Workshop_HighTechLightFloor01_Dirty_Cream_On"
    ComponentLookup[34].formid = 2282184
    ComponentLookup[34].mask = 161
    ComponentLookup[34].counts = 4162
    ComponentLookup[34].name = "Workshop_HighTechLightFloor01_Dirty_Orange_On"
    ComponentLookup[35].formid = 2282180
    ComponentLookup[35].mask = 161
    ComponentLookup[35].counts = 4162
    ComponentLookup[35].name = "Workshop_HighTechLightFloor02_Dirty_Cream_On"
    ComponentLookup[36].formid = 2282185
    ComponentLookup[36].mask = 161
    ComponentLookup[36].counts = 4162
    ComponentLookup[36].name = "Workshop_HighTechLightFloor02_Dirty_Orange_On"
    ComponentLookup[37].formid = 2282199
    ComponentLookup[37].mask = 161
    ComponentLookup[37].counts = 4162
    ComponentLookup[37].name = "Workshop_HighTechLightFloor03_Dirty_Cream_On"
    ComponentLookup[38].formid = 2282179
    ComponentLookup[38].mask = 161
    ComponentLookup[38].counts = 4162
    ComponentLookup[38].name = "Workshop_HighTechLightFloor03_Dirty_Orange_On"
    ComponentLookup[39].formid = 2282191
    ComponentLookup[39].mask = 161
    ComponentLookup[39].counts = 4162
    ComponentLookup[39].name = "Workshop_HighTechLightFloor05_On"
    ComponentLookup[40].formid = 2282189
    ComponentLookup[40].mask = 161
    ComponentLookup[40].counts = 4162
    ComponentLookup[40].name = "Workshop_HighTechLightFloor07_On"
    ComponentLookup[41].formid = 2327613
    ComponentLookup[41].mask = 32
    ComponentLookup[41].counts = 20
    ComponentLookup[41].name = "Workshop_LionStatue01"
    ComponentLookup[42].formid = 2327614
    ComponentLookup[42].mask = 32
    ComponentLookup[42].counts = 20
    ComponentLookup[42].name = "Workshop_LionStatue02"
    ComponentLookup[43].formid = 2327618
    ComponentLookup[43].mask = 32
    ComponentLookup[43].counts = 10
    ComponentLookup[43].name = "Workshop_MinuteManStatue01"
    ComponentLookup[44].formid = 2329992
    ComponentLookup[44].mask = 9
    ComponentLookup[44].counts = 259
    ComponentLookup[44].name = "Workshop_RaiderTent01"
    ComponentLookup[45].formid = 2329993
    ComponentLookup[45].mask = 9
    ComponentLookup[45].counts = 259
    ComponentLookup[45].name = "Workshop_RaiderTent02"
    ComponentLookup[46].formid = 2329994
    ComponentLookup[46].mask = 9
    ComponentLookup[46].counts = 259
    ComponentLookup[46].name = "Workshop_RaiderTent03"
    ComponentLookup[47].formid = 977901
    ComponentLookup[47].mask = 188672
    ComponentLookup[47].counts = 33829058
    ComponentLookup[47].name = "fragGrenade"
    ComponentLookup[48].formid = 939714
    ComponentLookup[48].mask = 155905
    ComponentLookup[48].counts = 51130562
    ComponentLookup[48].name = "fragMine"
    ComponentLookup[49].formid = 363252
    ComponentLookup[49].mask = 16777217
    ComponentLookup[49].counts = 257
    ComponentLookup[49].name = "lockJoint"
    ComponentLookup[50].formid = 363253
    ComponentLookup[50].mask = 128
    ComponentLookup[50].counts = 1
    ComponentLookup[50].name = "mindCloud"
    ComponentLookup[51].formid = 363276
    ComponentLookup[51].mask = 129
    ComponentLookup[51].counts = 65
    ComponentLookup[51].name = "radscorpionVenom"
    ComponentLookup[52].formid = 352479
    ComponentLookup[52].mask = 161
    ComponentLookup[52].counts = 4162
    ComponentLookup[52].name = "workshopLightbulbLight"
    ComponentLookup[53].formid = 2399984
    ComponentLookup[53].mask = 1048577
    ComponentLookup[53].counts = 199
    ComponentLookup[53].name = "workshop_MeatTotem01"
    ComponentLookup[54].formid = 2399985
    ComponentLookup[54].mask = 1048577
    ComponentLookup[54].counts = 199
    ComponentLookup[54].name = "workshop_MeatTotem02"
    ComponentLookup[55].formid = 2399982
    ComponentLookup[55].mask = 1048577
    ComponentLookup[55].counts = 199
    ComponentLookup[55].name = "workshop_MeatTotem03"
    ComponentLookup[56].formid = 2399983
    ComponentLookup[56].mask = 1048577
    ComponentLookup[56].counts = 199
    ComponentLookup[56].name = "workshop_MeatTotem04"
    ComponentLookup[57].formid = 2399927
    ComponentLookup[57].mask = 1
    ComponentLookup[57].counts = 4
    ComponentLookup[57].name = "workshop_NoTrespassing"
    ComponentLookup[58].formid = 2399931
    ComponentLookup[58].mask = 2
    ComponentLookup[58].counts = 3
    ComponentLookup[58].name = "workshop_PictureAbstractRect01Framed01A"
    ComponentLookup[59].formid = 2399932
    ComponentLookup[59].mask = 2
    ComponentLookup[59].counts = 3
    ComponentLookup[59].name = "workshop_PictureAbstractRect01Framed01B"
    ComponentLookup[60].formid = 2399933
    ComponentLookup[60].mask = 2
    ComponentLookup[60].counts = 3
    ComponentLookup[60].name = "workshop_PictureAbstractRect01Framed01C"
    ComponentLookup[61].formid = 2399935
    ComponentLookup[61].mask = 2
    ComponentLookup[61].counts = 3
    ComponentLookup[61].name = "workshop_PictureAbstractRect01Framed01D"
    ComponentLookup[62].formid = 2399936
    ComponentLookup[62].mask = 2
    ComponentLookup[62].counts = 3
    ComponentLookup[62].name = "workshop_PictureAbstractRect01Framed01E"
    ComponentLookup[63].formid = 2399937
    ComponentLookup[63].mask = 2
    ComponentLookup[63].counts = 3
    ComponentLookup[63].name = "workshop_PictureAbstractRect01Framed01F"
    ComponentLookup[64].formid = 2399938
    ComponentLookup[64].mask = 2
    ComponentLookup[64].counts = 3
    ComponentLookup[64].name = "workshop_PictureAbstractRect01Framed01G"
    ComponentLookup[65].formid = 2399939
    ComponentLookup[65].mask = 2
    ComponentLookup[65].counts = 3
    ComponentLookup[65].name = "workshop_PictureAbstractRect01Framed01H"
    ComponentLookup[66].formid = 2399940
    ComponentLookup[66].mask = 2
    ComponentLookup[66].counts = 3
    ComponentLookup[66].name = "workshop_PictureAbstractRect01Framed01I"
    ComponentLookup[67].formid = 2399941
    ComponentLookup[67].mask = 2
    ComponentLookup[67].counts = 3
    ComponentLookup[67].name = "workshop_PictureAbstractRect01Framed01J"
    ComponentLookup[68].formid = 2399942
    ComponentLookup[68].mask = 2
    ComponentLookup[68].counts = 3
    ComponentLookup[68].name = "workshop_PictureAbstractRect01Framed01K"
    ComponentLookup[69].formid = 2399943
    ComponentLookup[69].mask = 2
    ComponentLookup[69].counts = 3
    ComponentLookup[69].name = "workshop_PictureAbstractRect01Framed02A"
    ComponentLookup[70].formid = 2399944
    ComponentLookup[70].mask = 2
    ComponentLookup[70].counts = 3
    ComponentLookup[70].name = "workshop_PictureAbstractRect01Framed02B"
    ComponentLookup[71].formid = 2399945
    ComponentLookup[71].mask = 2
    ComponentLookup[71].counts = 3
    ComponentLookup[71].name = "workshop_PictureAbstractRect01Framed02C"
    ComponentLookup[72].formid = 2399946
    ComponentLookup[72].mask = 2
    ComponentLookup[72].counts = 3
    ComponentLookup[72].name = "workshop_PictureAbstractRect01Framed02D"
    ComponentLookup[73].formid = 2399947
    ComponentLookup[73].mask = 2
    ComponentLookup[73].counts = 3
    ComponentLookup[73].name = "workshop_PictureAbstractRect01Framed02E"
    ComponentLookup[74].formid = 2399948
    ComponentLookup[74].mask = 2
    ComponentLookup[74].counts = 3
    ComponentLookup[74].name = "workshop_PictureAbstractRect01Framed02F"
    ComponentLookup[75].formid = 2399949
    ComponentLookup[75].mask = 2
    ComponentLookup[75].counts = 3
    ComponentLookup[75].name = "workshop_PictureAbstractRect01Framed02G"
    ComponentLookup[76].formid = 2399950
    ComponentLookup[76].mask = 2
    ComponentLookup[76].counts = 3
    ComponentLookup[76].name = "workshop_PictureAbstractRect01Framed02H"
    ComponentLookup[77].formid = 2399952
    ComponentLookup[77].mask = 2
    ComponentLookup[77].counts = 3
    ComponentLookup[77].name = "workshop_PictureAbstractRect01Framed02J"
    ComponentLookup[78].formid = 2399953
    ComponentLookup[78].mask = 2
    ComponentLookup[78].counts = 3
    ComponentLookup[78].name = "workshop_PictureAbstractRect01Framed02K"
    ComponentLookup[79].formid = 2399954
    ComponentLookup[79].mask = 2
    ComponentLookup[79].counts = 3
    ComponentLookup[79].name = "workshop_PictureAbstractRect01Framed02L"
    ComponentLookup[80].formid = 620078
    ComponentLookup[80].mask = 2
    ComponentLookup[80].counts = 5
    ComponentLookup[80].name = "workshop_PictureFrame01A"
    ComponentLookup[81].formid = 620042
    ComponentLookup[81].mask = 2
    ComponentLookup[81].counts = 5
    ComponentLookup[81].name = "workshop_PictureFrame02A"
    ComponentLookup[82].formid = 620041
    ComponentLookup[82].mask = 2
    ComponentLookup[82].counts = 5
    ComponentLookup[82].name = "workshop_PictureFrame03A"
    ComponentLookup[83].formid = 620079
    ComponentLookup[83].mask = 2
    ComponentLookup[83].counts = 5
    ComponentLookup[83].name = "workshop_PictureFrame04A"
    ComponentLookup[84].formid = 620083
    ComponentLookup[84].mask = 2
    ComponentLookup[84].counts = 5
    ComponentLookup[84].name = "workshop_PictureFrame05A"
    ComponentLookup[85].formid = 620084
    ComponentLookup[85].mask = 2
    ComponentLookup[85].counts = 5
    ComponentLookup[85].name = "workshop_PictureFrame06A"
    ComponentLookup[86].formid = 620085
    ComponentLookup[86].mask = 2
    ComponentLookup[86].counts = 5
    ComponentLookup[86].name = "workshop_PictureFrame07A"
    ComponentLookup[87].formid = 620070
    ComponentLookup[87].mask = 2
    ComponentLookup[87].counts = 5
    ComponentLookup[87].name = "workshop_PictureFrameModern01A"
    ComponentLookup[88].formid = 620071
    ComponentLookup[88].mask = 2
    ComponentLookup[88].counts = 5
    ComponentLookup[88].name = "workshop_PictureFrameModern02A"
    ComponentLookup[89].formid = 620074
    ComponentLookup[89].mask = 2
    ComponentLookup[89].counts = 5
    ComponentLookup[89].name = "workshop_PictureFrameModern03A"
    ComponentLookup[90].formid = 620075
    ComponentLookup[90].mask = 2
    ComponentLookup[90].counts = 5
    ComponentLookup[90].name = "workshop_PictureFrameModern04A"
    ComponentLookup[91].formid = 620076
    ComponentLookup[91].mask = 2
    ComponentLookup[91].counts = 5
    ComponentLookup[91].name = "workshop_PictureFrameModern05A"
    ComponentLookup[92].formid = 620077
    ComponentLookup[92].mask = 2
    ComponentLookup[92].counts = 5
    ComponentLookup[92].name = "workshop_PictureFrameModern06A"
    ComponentLookup[93].formid = 2399956
    ComponentLookup[93].mask = 2
    ComponentLookup[93].counts = 3
    ComponentLookup[93].name = "workshop_PictureFramePortrait01"
    ComponentLookup[94].formid = 2399957
    ComponentLookup[94].mask = 2
    ComponentLookup[94].counts = 3
    ComponentLookup[94].name = "workshop_PictureFramePortrait02"
    ComponentLookup[95].formid = 2399958
    ComponentLookup[95].mask = 2
    ComponentLookup[95].counts = 3
    ComponentLookup[95].name = "workshop_PictureFramePortrait03"
    ComponentLookup[96].formid = 2399959
    ComponentLookup[96].mask = 2
    ComponentLookup[96].counts = 3
    ComponentLookup[96].name = "workshop_PictureFramePortrait04"
    ComponentLookup[97].formid = 2399960
    ComponentLookup[97].mask = 2
    ComponentLookup[97].counts = 3
    ComponentLookup[97].name = "workshop_PictureFramePortrait05"
    ComponentLookup[98].formid = 2399961
    ComponentLookup[98].mask = 2
    ComponentLookup[98].counts = 3
    ComponentLookup[98].name = "workshop_PictureFramePortrait06"
    ComponentLookup[99].formid = 2399962
    ComponentLookup[99].mask = 2
    ComponentLookup[99].counts = 3
    ComponentLookup[99].name = "workshop_PictureFramePortrait07"
			
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
