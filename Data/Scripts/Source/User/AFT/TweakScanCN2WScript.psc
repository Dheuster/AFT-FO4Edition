Scriptname AFT:TweakScanCN2WScript extends Quest

; import AFT

Quest Property TweakScrapScanMaster Auto Const
FormList Property TweakConstructed_NtoW Auto Const

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

Activator  Property  WorkshopLightbox01  Auto Const ; = Game.GetForm(0x001F59AC)
ActorValue Property WorkshopLightboxCycling Auto Const         ;= Game.GetForm(0x00210B6F) as ActorValue
ActorValue Property WorkshopLightboxCyclingType Auto Const     ;= Game.GetForm(0x00210C75) as ActorValue
ActorValue Property WorkshopTerminalLightBrightness Auto Const ;= Game.GetForm(0x00210C77) as ActorValue
ActorValue Property WorkshopTerminalLightColor Auto Const      ;= Game.GetForm(0x001F57D2) as ActorValue
FormList   Property TweakConstructed_Wires Auto Const


bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakScanCN2WScript"
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
		; code += "    ComponentLookup[" + i + "].formid = " + TweakConstructed_NtoW.GetAt(i).GetFormID() + "\n"
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
	results = center.FindAllReferencesOfType(TweakConstructed_NtoW, radius)			
	int numresults = results.length
	
	Trace("Scanning Complete: [" + numresults + "] objects found")
	
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
								
					if (rid == 2054572) ; LightBox
						WorkshopLightBoxScript wlb = result as WorkshopLightBoxScript
						if (wlb)
							int total     = 0
							; bit 1   : [ ] : Cycling
							total += ((wlb.GetValue(WorkshopLightboxCycling)) as Int)
							; bit 2-3 : [X][ ][ ] : CyclingType
							total += ((2 * wlb.GetValue(WorkshopLightboxCyclingType)) as Int)
							; bit 4-5 : [X][X][X][ ][ ] : Brightness
							total += ((8 * wlb.GetValue(WorkshopTerminalLightBrightness)) as Int)
							; bit 6-8 : [X][X][X][X][X][ ][ ][ ] : Color
							total += ((32 * wlb.GetValue(WorkshopTerminalLightColor)) as Int)
							Trace("rid 2054572 adding code [" + total + "]")
							params[9] = total
						else
							Trace("rid 2054572 did not case to WorkshopLightBoxScript")
						endif
					endif
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
	
	
	; ==== SPECIAL ====
	; Wires are special. 
	
	int wiresuccess = 0
	
	results = center.FindAllReferencesOfType(TweakConstructed_Wires, radius)	
	numresults = results.length
	Trace("Wire Scan Complete: [" + numresults + "] objects found")
	center = None	
	if (0 != numresults)
		keepgoing = true
		i = 0
		while (i != numresults && keepgoing)
			result = results[i]
			if scrapall
				result.SetPosition(0,0,10)
				result.Disable()
				result.Delete()
			elseif (!result.IsDisabled())	
				wiresuccess += 1
				if !snapshot
					result.SetPosition(0,0,10)
					result.Disable()
					result.Delete()
					Trace("Adding Scrap [BlackWireSpline01] to scrapdata")
				endif
			endif
			
			scrapdata[5] += 1 ; Copper
			i += 1
			if (0 == (i % 30))
				keepgoing = (pTweakScanThreadsDone.GetValue() > 0.0)
			endif
		endwhile
	endif

	if (0 == lookupsuccess + wiresuccess)
		pTweakScanThreadsDone.mod(-1.0)
		return
	endif
	
	; Dont include wires...
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
	
    ComponentLookup[0].formid = 385618
    ComponentLookup[0].mask = 11
    ComponentLookup[0].counts = 8513
    ComponentLookup[0].name = "PlayerHouse_Ruin_Crib01_WithMobile"
    ComponentLookup[1].formid = 483135
    ComponentLookup[1].mask = 3
    ComponentLookup[1].counts = 193
    ComponentLookup[1].name = "PlayerHouse_Ruin_EndTable01"
    ComponentLookup[2].formid = 483146
    ComponentLookup[2].mask = 3
    ComponentLookup[2].counts = 257
    ComponentLookup[2].name = "PlayerHouse_Ruin_EndTable02"
    ComponentLookup[3].formid = 219887
    ComponentLookup[3].mask = 3
    ComponentLookup[3].counts = 386
    ComponentLookup[3].name = "PlayerHouse_Ruin_KitchenBar01_Bare"
    ComponentLookup[4].formid = 483147
    ComponentLookup[4].mask = 11
    ComponentLookup[4].counts = 12417
    ComponentLookup[4].name = "PlayerHouse_Ruin_Ottoman01"
    ComponentLookup[5].formid = 472331
    ComponentLookup[5].mask = 8
    ComponentLookup[5].counts = 3
    ComponentLookup[5].name = "PlayerHouse_Ruin_Rug01"
    ComponentLookup[6].formid = 463285
    ComponentLookup[6].mask = 8
    ComponentLookup[6].counts = 6
    ComponentLookup[6].name = "PlayerHouse_Ruin_Rug02"
    ComponentLookup[7].formid = 163512
    ComponentLookup[7].mask = 8
    ComponentLookup[7].counts = 6
    ComponentLookup[7].name = "PlayerHouse_Ruin_Rug03"
    ComponentLookup[8].formid = 163513
    ComponentLookup[8].mask = 8
    ComponentLookup[8].counts = 6
    ComponentLookup[8].name = "PlayerHouse_Ruin_Rug04"
    ComponentLookup[9].formid = 457177
    ComponentLookup[9].mask = 3
    ComponentLookup[9].counts = 259
    ComponentLookup[9].name = "PlayerHouse_Ruin_TableKitchen01"
    ComponentLookup[10].formid = 457178
    ComponentLookup[10].mask = 3
    ComponentLookup[10].counts = 258
    ComponentLookup[10].name = "PlayerHouse_Ruin_TableKitchen02"
    ComponentLookup[11].formid = 457179
    ComponentLookup[11].mask = 3
    ComponentLookup[11].counts = 259
    ComponentLookup[11].name = "PlayerHouse_Ruin_TableKitchen03"
    ComponentLookup[12].formid = 469980
    ComponentLookup[12].mask = 3
    ComponentLookup[12].counts = 257
    ComponentLookup[12].name = "PlayerHouse_Ruin_WetBar02"
    ComponentLookup[13].formid = 1085562
    ComponentLookup[13].mask = 31
    ComponentLookup[13].counts = 34345474
    ComponentLookup[13].name = "PoolTable01"
    ComponentLookup[14].formid = 314752
    ComponentLookup[14].mask = 3
    ComponentLookup[14].counts = 130
    ComponentLookup[14].name = "PottedPlantSet_PotAPlant01_Dirty"
    ComponentLookup[15].formid = 314755
    ComponentLookup[15].mask = 3
    ComponentLookup[15].counts = 130
    ComponentLookup[15].name = "PottedPlantSet_PotAPlant02_Dirty"
    ComponentLookup[16].formid = 314777
    ComponentLookup[16].mask = 3
    ComponentLookup[16].counts = 130
    ComponentLookup[16].name = "PottedPlantSet_PotAPlant03_Dirty"
    ComponentLookup[17].formid = 314778
    ComponentLookup[17].mask = 3
    ComponentLookup[17].counts = 130
    ComponentLookup[17].name = "PottedPlantSet_PotAPlant04_Dirty"
    ComponentLookup[18].formid = 314780
    ComponentLookup[18].mask = 3
    ComponentLookup[18].counts = 130
    ComponentLookup[18].name = "PottedPlantSet_PotBPlant01_Dirty"
    ComponentLookup[19].formid = 314781
    ComponentLookup[19].mask = 3
    ComponentLookup[19].counts = 130
    ComponentLookup[19].name = "PottedPlantSet_PotBPlant02_Dirty"
    ComponentLookup[20].formid = 314808
    ComponentLookup[20].mask = 3
    ComponentLookup[20].counts = 130
    ComponentLookup[20].name = "PottedPlantSet_PotBPlant03_Dirty"
    ComponentLookup[21].formid = 314818
    ComponentLookup[21].mask = 3
    ComponentLookup[21].counts = 130
    ComponentLookup[21].name = "PottedPlantSet_PotBPlant04_Dirty"
    ComponentLookup[22].formid = 210813
    ComponentLookup[22].mask = 2098176
    ComponentLookup[22].counts = 65
    ComponentLookup[22].name = "Psycho"
    ComponentLookup[23].formid = 1045023
    ComponentLookup[23].mask = 115968
    ComponentLookup[23].counts = 33833027
    ComponentLookup[23].name = "PulseGrenade"
    ComponentLookup[24].formid = 1090372
    ComponentLookup[24].mask = 345344
    ComponentLookup[24].counts = 34357444
    ComponentLookup[24].name = "PulseMine"
    ComponentLookup[25].formid = 1325777
    ComponentLookup[25].mask = 1076
    ComponentLookup[25].counts = 266370
    ComponentLookup[25].name = "RadioDiamondCityReceiverOff"
    ComponentLookup[26].formid = 802041
    ComponentLookup[26].mask = 1076
    ComponentLookup[26].counts = 266370
    ComponentLookup[26].name = "RadioFreedomReceiverOff"
    ComponentLookup[27].formid = 1331323
    ComponentLookup[27].mask = 1076
    ComponentLookup[27].counts = 266370
    ComponentLookup[27].name = "RadioInstituteReceiverOff"
    ComponentLookup[28].formid = 2023149
    ComponentLookup[28].mask = 1
    ComponentLookup[28].counts = 6
    ComponentLookup[28].name = "RaiderCampPole01"
    ComponentLookup[29].formid = 2023150
    ComponentLookup[29].mask = 1
    ComponentLookup[29].counts = 6
    ComponentLookup[29].name = "RaiderCampPole02"
    ComponentLookup[30].formid = 2023151
    ComponentLookup[30].mask = 1
    ComponentLookup[30].counts = 4
    ComponentLookup[30].name = "RaiderCampPole03"
    ComponentLookup[31].formid = 2023152
    ComponentLookup[31].mask = 1
    ComponentLookup[31].counts = 4
    ComponentLookup[31].name = "RaiderCampPole04"
    ComponentLookup[32].formid = 2023167
    ComponentLookup[32].mask = 1
    ComponentLookup[32].counts = 4
    ComponentLookup[32].name = "RaiderCampPole04LG"
    ComponentLookup[33].formid = 2023168
    ComponentLookup[33].mask = 1
    ComponentLookup[33].counts = 4
    ComponentLookup[33].name = "RaiderCampPole04MED"
    ComponentLookup[34].formid = 2023169
    ComponentLookup[34].mask = 1
    ComponentLookup[34].counts = 4
    ComponentLookup[34].name = "RaiderCampPole04SM"
    ComponentLookup[35].formid = 2023170
    ComponentLookup[35].mask = 1
    ComponentLookup[35].counts = 4
    ComponentLookup[35].name = "RaiderCampPole05"
    ComponentLookup[36].formid = 2023171
    ComponentLookup[36].mask = 1
    ComponentLookup[36].counts = 4
    ComponentLookup[36].name = "RaiderCampPole06"
    ComponentLookup[37].formid = 2243019
    ComponentLookup[37].mask = 1
    ComponentLookup[37].counts = 6
    ComponentLookup[37].name = "Raider_Clutter01"
    ComponentLookup[38].formid = 2243025
    ComponentLookup[38].mask = 1
    ComponentLookup[38].counts = 9
    ComponentLookup[38].name = "Raider_Clutter05"
    ComponentLookup[39].formid = 421966
    ComponentLookup[39].mask = 5
    ComponentLookup[39].counts = 68
    ComponentLookup[39].name = "RedRocketGasSign01"
    ComponentLookup[40].formid = 975823
    ComponentLookup[40].mask = 3
    ComponentLookup[40].counts = 643
    ComponentLookup[40].name = "Shelf_GroceryStore_OneSided"
    ComponentLookup[41].formid = 975817
    ComponentLookup[41].mask = 3
    ComponentLookup[41].counts = 836
    ComponentLookup[41].name = "Shelf_GroceryStore_TwoSided"
    ComponentLookup[42].formid = 1729214
    ComponentLookup[42].mask = 1
    ComponentLookup[42].counts = 4
    ComponentLookup[42].name = "SignEmployeesHandWash01"
    ComponentLookup[43].formid = 1729212
    ComponentLookup[43].mask = 1
    ComponentLookup[43].counts = 4
    ComponentLookup[43].name = "SignEmployeesOnly01"
    ComponentLookup[44].formid = 1522462
    ComponentLookup[44].mask = 1
    ComponentLookup[44].counts = 4
    ComponentLookup[44].name = "SignHardwareElectrical"
    ComponentLookup[45].formid = 1522463
    ComponentLookup[45].mask = 1
    ComponentLookup[45].counts = 4
    ComponentLookup[45].name = "SignHardwarePlumbing"
    ComponentLookup[46].formid = 1522461
    ComponentLookup[46].mask = 1
    ComponentLookup[46].counts = 4
    ComponentLookup[46].name = "SignHardwareTools"
    ComponentLookup[47].formid = 102319
    ComponentLookup[47].mask = 1
    ComponentLookup[47].counts = 4
    ComponentLookup[47].name = "SignNoSmoking01"
    ComponentLookup[48].formid = 102321
    ComponentLookup[48].mask = 1
    ComponentLookup[48].counts = 4
    ComponentLookup[48].name = "SignRestricted01"
    ComponentLookup[49].formid = 102327
    ComponentLookup[49].mask = 1
    ComponentLookup[49].counts = 4
    ComponentLookup[49].name = "SignRestroom02"
    ComponentLookup[50].formid = 102324
    ComponentLookup[50].mask = 1
    ComponentLookup[50].counts = 4
    ComponentLookup[50].name = "SignRestroomFemale01"
    ComponentLookup[51].formid = 102325
    ComponentLookup[51].mask = 1
    ComponentLookup[51].counts = 4
    ComponentLookup[51].name = "SignRestroomMale01"
    ComponentLookup[52].formid = 102328
    ComponentLookup[52].mask = 1
    ComponentLookup[52].counts = 4
    ComponentLookup[52].name = "SignRestroomWashHands01"
    ComponentLookup[53].formid = 194
    ComponentLookup[53].mask = 32
    ComponentLookup[53].counts = 1
    ComponentLookup[53].name = "SplineEndpointMarker"
    ComponentLookup[54].formid = 1028534
    ComponentLookup[54].mask = 1048577
    ComponentLookup[54].counts = 131
    ComponentLookup[54].name = "SuperMutant_Cart"
    ComponentLookup[55].formid = 511625
    ComponentLookup[55].mask = 1
    ComponentLookup[55].counts = 10
    ComponentLookup[55].name = "TablePatio01"
    ComponentLookup[56].formid = 291560
    ComponentLookup[56].mask = 10
    ComponentLookup[56].counts = 129
    ComponentLookup[56].name = "TaxidermyBrahmin01"
    ComponentLookup[57].formid = 291557
    ComponentLookup[57].mask = 10
    ComponentLookup[57].counts = 65
    ComponentLookup[57].name = "TaxidermyMirelurk01"
    ComponentLookup[58].formid = 291558
    ComponentLookup[58].mask = 10
    ComponentLookup[58].counts = 65
    ComponentLookup[58].name = "TaxidermyMolerat01"
    ComponentLookup[59].formid = 291559
    ComponentLookup[59].mask = 10
    ComponentLookup[59].counts = 129
    ComponentLookup[59].name = "TaxidermyRadStag01"
    ComponentLookup[60].formid = 402896
    ComponentLookup[60].mask = 5
    ComponentLookup[60].counts = 194
    ComponentLookup[60].name = "Tricycle01"
    ComponentLookup[61].formid = 1053337
    ComponentLookup[61].mask = 131088
    ComponentLookup[61].counts = 66
    ComponentLookup[61].name = "UltraJet"
    ComponentLookup[62].formid = 899131
    ComponentLookup[62].mask = 6145
    ComponentLookup[62].counts = 4164
    ComponentLookup[62].name = "WaterPump01Furn"
    ComponentLookup[63].formid = 840359
    ComponentLookup[63].mask = 12
    ComponentLookup[63].counts = 129
    ComponentLookup[63].name = "WelcomeMat001"
    ComponentLookup[64].formid = 840360
    ComponentLookup[64].mask = 12
    ComponentLookup[64].counts = 129
    ComponentLookup[64].name = "WelcomeMat002"
    ComponentLookup[65].formid = 840361
    ComponentLookup[65].mask = 12
    ComponentLookup[65].counts = 129
    ComponentLookup[65].name = "WelcomeMat003"
    ComponentLookup[66].formid = 840362
    ComponentLookup[66].mask = 12
    ComponentLookup[66].counts = 129
    ComponentLookup[66].name = "WelcomeMat004"
    ComponentLookup[67].formid = 840363
    ComponentLookup[67].mask = 12
    ComponentLookup[67].counts = 129
    ComponentLookup[67].name = "WelcomeMat005"
    ComponentLookup[68].formid = 840364
    ComponentLookup[68].mask = 12
    ComponentLookup[68].counts = 129
    ComponentLookup[68].name = "WelcomeMat006"
    ComponentLookup[69].formid = 1607226
    ComponentLookup[69].mask = 38977
    ComponentLookup[69].counts = 85475600
    ComponentLookup[69].name = "WorkshopArtillery"
    ComponentLookup[70].formid = 377505
    ComponentLookup[70].mask = 3
    ComponentLookup[70].counts = 323
    ComponentLookup[70].name = "WorkshopBar01"
    ComponentLookup[71].formid = 2400396
    ComponentLookup[71].mask = 3
    ComponentLookup[71].counts = 323
    ComponentLookup[71].name = "WorkshopBar01Counter"
    ComponentLookup[72].formid = 1114865
    ComponentLookup[72].mask = 3
    ComponentLookup[72].counts = 323
    ComponentLookup[72].name = "WorkshopBar02"
    ComponentLookup[73].formid = 2400397
    ComponentLookup[73].mask = 3
    ComponentLookup[73].counts = 323
    ComponentLookup[73].name = "WorkshopBar02Counter"
    ComponentLookup[74].formid = 1114866
    ComponentLookup[74].mask = 3
    ComponentLookup[74].counts = 323
    ComponentLookup[74].name = "WorkshopBar03"
    ComponentLookup[75].formid = 2400398
    ComponentLookup[75].mask = 3
    ComponentLookup[75].counts = 323
    ComponentLookup[75].name = "WorkshopBar03Counter"
    ComponentLookup[76].formid = 786896
    ComponentLookup[76].mask = 3
    ComponentLookup[76].counts = 260
    ComponentLookup[76].name = "WorkshopBell01"
    ComponentLookup[77].formid = 673531
    ComponentLookup[77].mask = 513
    ComponentLookup[77].counts = 514
    ComponentLookup[77].name = "WorkshopBrahminFeedTrough"
    ComponentLookup[78].formid = 238241
    ComponentLookup[78].mask = 4259
    ComponentLookup[78].counts = 17043522
    ComponentLookup[78].name = "WorkshopCeilingFanLight01"
    ComponentLookup[79].formid = 866516
    ComponentLookup[79].mask = 161
    ComponentLookup[79].counts = 8260
    ComponentLookup[79].name = "WorkshopConstructionLight01"
    ComponentLookup[80].formid = 2384494
    ComponentLookup[80].mask = 129
    ComponentLookup[80].counts = 132
    ComponentLookup[80].name = "WorkshopEatOTronic01Dirty"
    ComponentLookup[81].formid = 197510
    ComponentLookup[81].mask = 4645
    ComponentLookup[81].counts = 33824900
    ComponentLookup[81].name = "WorkshopGenerator"
    ComponentLookup[82].formid = 1172165
    ComponentLookup[82].mask = 4452
    ComponentLookup[82].counts = 103830148
    ComponentLookup[82].name = "WorkshopGeneratorLarge"
    ComponentLookup[83].formid = 362551
    ComponentLookup[83].mask = 4645
    ComponentLookup[83].counts = 50606279
    ComponentLookup[83].name = "WorkshopGeneratorMedium"
    ComponentLookup[84].formid = 2331952
    ComponentLookup[84].mask = 4385
    ComponentLookup[84].counts = 565519
    ComponentLookup[84].name = "WorkshopGeneratorWindmill"
    ComponentLookup[85].formid = 2382196
    ComponentLookup[85].mask = 1411
    ComponentLookup[85].counts = 50864258
    ComponentLookup[85].name = "WorkshopHighTechTelevision01"
    ComponentLookup[86].formid = 786883
    ComponentLookup[86].mask = 161
    ComponentLookup[86].counts = 4162
    ComponentLookup[86].name = "WorkshopIndCatLight"
    ComponentLookup[87].formid = 1760364
    ComponentLookup[87].mask = 1201
    ComponentLookup[87].counts = 34087042
    ComponentLookup[87].name = "WorkshopJukebox01"
    ComponentLookup[88].formid = 2054572
    ComponentLookup[88].mask = 161
    ComponentLookup[88].counts = 4162
    ComponentLookup[88].name = "WorkshopLightbox01"
    ComponentLookup[89].formid = 1760361
    ComponentLookup[89].mask = 161
    ComponentLookup[89].counts = 24642
    ComponentLookup[89].name = "WorkshopMirrorBall01"
    ComponentLookup[90].formid = 134208
    ComponentLookup[90].mask = 8
    ComponentLookup[90].counts = 6
    ComponentLookup[90].name = "WorkshopNpcBedGroundSleep01"
    ComponentLookup[91].formid = 2345413
    ComponentLookup[91].mask = 9
    ComponentLookup[91].counts = 324
    ComponentLookup[91].name = "WorkshopNpcBedHospitalBedLay01"
    ComponentLookup[92].formid = 1623407
    ComponentLookup[92].mask = 9
    ComponentLookup[92].counts = 324
    ComponentLookup[92].name = "WorkshopNpcBedMetalLay01"
    ComponentLookup[93].formid = 2345412
    ComponentLookup[93].mask = 9
    ComponentLookup[93].counts = 324
    ComponentLookup[93].name = "WorkshopNpcBedMilitaryCottLay01"
    ComponentLookup[94].formid = 1150807
    ComponentLookup[94].mask = 8
    ComponentLookup[94].counts = 3
    ComponentLookup[94].name = "WorkshopNpcBedSleepingBagSleep01"
    ComponentLookup[95].formid = 1150795
    ComponentLookup[95].mask = 9
    ComponentLookup[95].counts = 324
    ComponentLookup[95].name = "WorkshopNpcBedVaultLay01"
    ComponentLookup[96].formid = 150162
    ComponentLookup[96].mask = 545
    ComponentLookup[96].counts = 8322
    ComponentLookup[96].name = "WorkshopPowerConnectorCeiling01"
    ComponentLookup[97].formid = 2361968
    ComponentLookup[97].mask = 545
    ComponentLookup[97].counts = 8322
    ComponentLookup[97].name = "WorkshopPowerConnectorFloor01"
    ComponentLookup[98].formid = 786886
    ComponentLookup[98].mask = 545
    ComponentLookup[98].counts = 8322
    ComponentLookup[98].name = "WorkshopPowerConnectorWall01"
    ComponentLookup[99].formid = 2146954
    ComponentLookup[99].mask = 547
    ComponentLookup[99].counts = 266306
    ComponentLookup[99].name = "WorkshopPowerCounter01"	
		
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
