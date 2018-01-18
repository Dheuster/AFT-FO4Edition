Scriptname AFT:TweakScanNCPtoSScript extends Quest

; import AFT

Quest Property TweakScrapScanMaster Auto Const
FormList Property TweakNonConstructed_PtoS Auto Const

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
	string logName = "TweakScanNCPtoSScript"
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
		; code += "    ComponentLookup[" + i + "].formid = " + TweakNonConstructed_PtoS.GetAt(i).GetFormID() + "\n"
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
	results = center.FindAllReferencesOfType(TweakNonConstructed_PtoS, radius)			
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
	
    ComponentLookup[0].formid = 702245
    ComponentLookup[0].mask = 5
    ComponentLookup[0].counts = 67
    ComponentLookup[0].name = "PlayerHouse_Ruin_KitchenRefrigeratorDoor02_Yellow"
    ComponentLookup[1].formid = 1739312
    ComponentLookup[1].mask = 5
    ComponentLookup[1].counts = 67
    ComponentLookup[1].name = "PlayerHouse_Ruin_KitchenRefrigeratorDoor03_Blue"
    ComponentLookup[2].formid = 219873
    ComponentLookup[2].mask = 3
    ComponentLookup[2].counts = 68
    ComponentLookup[2].name = "PlayerHouse_Ruin_Kitchen_Cabinet01_BareMetal"
    ComponentLookup[3].formid = 384110
    ComponentLookup[3].mask = 3
    ComponentLookup[3].counts = 68
    ComponentLookup[3].name = "PlayerHouse_Ruin_Kitchen_Cabinet01_Blue"
    ComponentLookup[4].formid = 219875
    ComponentLookup[4].mask = 3
    ComponentLookup[4].counts = 68
    ComponentLookup[4].name = "PlayerHouse_Ruin_Kitchen_Cabinet01_White"
    ComponentLookup[5].formid = 219874
    ComponentLookup[5].mask = 3
    ComponentLookup[5].counts = 68
    ComponentLookup[5].name = "PlayerHouse_Ruin_Kitchen_Cabinet01_Yellow"
    ComponentLookup[6].formid = 219876
    ComponentLookup[6].mask = 3
    ComponentLookup[6].counts = 68
    ComponentLookup[6].name = "PlayerHouse_Ruin_Kitchen_Cabinet02_BareMetal"
    ComponentLookup[7].formid = 384111
    ComponentLookup[7].mask = 3
    ComponentLookup[7].counts = 68
    ComponentLookup[7].name = "PlayerHouse_Ruin_Kitchen_Cabinet02_Blue"
    ComponentLookup[8].formid = 219878
    ComponentLookup[8].mask = 3
    ComponentLookup[8].counts = 68
    ComponentLookup[8].name = "PlayerHouse_Ruin_Kitchen_Cabinet02_White"
    ComponentLookup[9].formid = 219877
    ComponentLookup[9].mask = 3
    ComponentLookup[9].counts = 68
    ComponentLookup[9].name = "PlayerHouse_Ruin_Kitchen_Cabinet02_Yellow"
    ComponentLookup[10].formid = 219881
    ComponentLookup[10].mask = 3
    ComponentLookup[10].counts = 68
    ComponentLookup[10].name = "PlayerHouse_Ruin_Kitchen_Cabinet03_BareMetal"
    ComponentLookup[11].formid = 384112
    ComponentLookup[11].mask = 3
    ComponentLookup[11].counts = 68
    ComponentLookup[11].name = "PlayerHouse_Ruin_Kitchen_Cabinet03_Blue"
    ComponentLookup[12].formid = 219880
    ComponentLookup[12].mask = 3
    ComponentLookup[12].counts = 68
    ComponentLookup[12].name = "PlayerHouse_Ruin_Kitchen_Cabinet03_White"
    ComponentLookup[13].formid = 219879
    ComponentLookup[13].mask = 3
    ComponentLookup[13].counts = 68
    ComponentLookup[13].name = "PlayerHouse_Ruin_Kitchen_Cabinet03_Yellow"
    ComponentLookup[14].formid = 219882
    ComponentLookup[14].mask = 3
    ComponentLookup[14].counts = 68
    ComponentLookup[14].name = "PlayerHouse_Ruin_Kitchen_Cabinet04_BareMetal"
    ComponentLookup[15].formid = 384113
    ComponentLookup[15].mask = 3
    ComponentLookup[15].counts = 68
    ComponentLookup[15].name = "PlayerHouse_Ruin_Kitchen_Cabinet04_Blue"
    ComponentLookup[16].formid = 219884
    ComponentLookup[16].mask = 3
    ComponentLookup[16].counts = 68
    ComponentLookup[16].name = "PlayerHouse_Ruin_Kitchen_Cabinet04_White"
    ComponentLookup[17].formid = 219883
    ComponentLookup[17].mask = 3
    ComponentLookup[17].counts = 68
    ComponentLookup[17].name = "PlayerHouse_Ruin_Kitchen_Cabinet04_Yellow"
    ComponentLookup[18].formid = 228294
    ComponentLookup[18].mask = 3
    ComponentLookup[18].counts = 68
    ComponentLookup[18].name = "PlayerHouse_Ruin_Kitchen_Cabinet05_BareMetal"
    ComponentLookup[19].formid = 228289
    ComponentLookup[19].mask = 3
    ComponentLookup[19].counts = 68
    ComponentLookup[19].name = "PlayerHouse_Ruin_Kitchen_Cabinet05_Blue"
    ComponentLookup[20].formid = 228293
    ComponentLookup[20].mask = 3
    ComponentLookup[20].counts = 68
    ComponentLookup[20].name = "PlayerHouse_Ruin_Kitchen_Cabinet05_White"
    ComponentLookup[21].formid = 228292
    ComponentLookup[21].mask = 3
    ComponentLookup[21].counts = 68
    ComponentLookup[21].name = "PlayerHouse_Ruin_Kitchen_Cabinet05_Yellow"
    ComponentLookup[22].formid = 278473
    ComponentLookup[22].mask = 3
    ComponentLookup[22].counts = 68
    ComponentLookup[22].name = "PlayerHouse_Ruin_Kitchen_Cabinet06_BareMetal"
    ComponentLookup[23].formid = 278474
    ComponentLookup[23].mask = 3
    ComponentLookup[23].counts = 68
    ComponentLookup[23].name = "PlayerHouse_Ruin_Kitchen_Cabinet06_Blue"
    ComponentLookup[24].formid = 278475
    ComponentLookup[24].mask = 3
    ComponentLookup[24].counts = 68
    ComponentLookup[24].name = "PlayerHouse_Ruin_Kitchen_Cabinet06_White"
    ComponentLookup[25].formid = 278476
    ComponentLookup[25].mask = 3
    ComponentLookup[25].counts = 68
    ComponentLookup[25].name = "PlayerHouse_Ruin_Kitchen_Cabinet06_Yellow"
    ComponentLookup[26].formid = 228290
    ComponentLookup[26].mask = 3
    ComponentLookup[26].counts = 68
    ComponentLookup[26].name = "PlayerHouse_Ruin_Kitchen_CabinetPlatform01"
    ComponentLookup[27].formid = 163514
    ComponentLookup[27].mask = 8
    ComponentLookup[27].counts = 1
    ComponentLookup[27].name = "PlayerHouse_Ruin_Rug05"
    ComponentLookup[28].formid = 471663
    ComponentLookup[28].mask = 2
    ComponentLookup[28].counts = 20
    ComponentLookup[28].name = "PlayerHouse_Ruin_Stereo01"
    ComponentLookup[29].formid = 471664
    ComponentLookup[29].mask = 2
    ComponentLookup[29].counts = 20
    ComponentLookup[29].name = "PlayerHouse_Ruin_Stereo02"
    ComponentLookup[30].formid = 219868
    ComponentLookup[30].mask = 4194721
    ComponentLookup[30].counts = 50602054
    ComponentLookup[30].name = "PlayerHouse_Ruin_Stove01_BareMetal"
    ComponentLookup[31].formid = 384118
    ComponentLookup[31].mask = 4194721
    ComponentLookup[31].counts = 50602054
    ComponentLookup[31].name = "PlayerHouse_Ruin_Stove01_Blue"
    ComponentLookup[32].formid = 219869
    ComponentLookup[32].mask = 4194721
    ComponentLookup[32].counts = 50602054
    ComponentLookup[32].name = "PlayerHouse_Ruin_Stove01_StainlessSteel"
    ComponentLookup[33].formid = 219867
    ComponentLookup[33].mask = 4194721
    ComponentLookup[33].counts = 50602054
    ComponentLookup[33].name = "PlayerHouse_Ruin_Stove01_White"
    ComponentLookup[34].formid = 219866
    ComponentLookup[34].mask = 4194721
    ComponentLookup[34].counts = 50602054
    ComponentLookup[34].name = "PlayerHouse_Ruin_Stove01_Yellow"
    ComponentLookup[35].formid = 1684925
    ComponentLookup[35].mask = 2
    ComponentLookup[35].counts = 4
    ComponentLookup[35].name = "PlayerHouse_Ruin_WetBar02Debris01"
    ComponentLookup[36].formid = 1684927
    ComponentLookup[36].mask = 2
    ComponentLookup[36].counts = 4
    ComponentLookup[36].name = "PlayerHouse_Ruin_WetBar02Debris02"
    ComponentLookup[37].formid = 315843
    ComponentLookup[37].mask = 2
    ComponentLookup[37].counts = 20
    ComponentLookup[37].name = "PlayerHouse_Stereo01"
    ComponentLookup[38].formid = 168033
    ComponentLookup[38].mask = 1
    ComponentLookup[38].counts = 4
    ComponentLookup[38].name = "PlaygroundSwingSet01"
    ComponentLookup[39].formid = 168034
    ComponentLookup[39].mask = 1
    ComponentLookup[39].counts = 4
    ComponentLookup[39].name = "PlaygroundSwingSet02"
    ComponentLookup[40].formid = 168036
    ComponentLookup[40].mask = 1
    ComponentLookup[40].counts = 4
    ComponentLookup[40].name = "PlaygroundSwingSet03"
    ComponentLookup[41].formid = 1048075
    ComponentLookup[41].mask = 1
    ComponentLookup[41].counts = 2
    ComponentLookup[41].name = "Pot_FoodLarge"
    ComponentLookup[42].formid = 1689877
    ComponentLookup[42].mask = 1
    ComponentLookup[42].counts = 2
    ComponentLookup[42].name = "PreWarFenceChainLink01"
    ComponentLookup[43].formid = 1689888
    ComponentLookup[43].mask = 1
    ComponentLookup[43].counts = 2
    ComponentLookup[43].name = "PreWarFenceChainLinkCornerIn01"
    ComponentLookup[44].formid = 1689890
    ComponentLookup[44].mask = 1
    ComponentLookup[44].counts = 2
    ComponentLookup[44].name = "PreWarFenceChainLinkCornerIn01R"
    ComponentLookup[45].formid = 1689887
    ComponentLookup[45].mask = 1
    ComponentLookup[45].counts = 2
    ComponentLookup[45].name = "PreWarFenceChainLinkCornerOut01"
    ComponentLookup[46].formid = 1689883
    ComponentLookup[46].mask = 1
    ComponentLookup[46].counts = 2
    ComponentLookup[46].name = "PreWarFenceChainLinkDown128"
    ComponentLookup[47].formid = 1689885
    ComponentLookup[47].mask = 1
    ComponentLookup[47].counts = 2
    ComponentLookup[47].name = "PreWarFenceChainLinkDown32"
    ComponentLookup[48].formid = 1689884
    ComponentLookup[48].mask = 1
    ComponentLookup[48].counts = 2
    ComponentLookup[48].name = "PreWarFenceChainLinkDown64"
    ComponentLookup[49].formid = 104335
    ComponentLookup[49].mask = 1
    ComponentLookup[49].counts = 2
    ComponentLookup[49].name = "PreWarFenceChainLinkGateStatic01"
    ComponentLookup[50].formid = 1689879
    ComponentLookup[50].mask = 1
    ComponentLookup[50].counts = 2
    ComponentLookup[50].name = "PreWarFenceChainLinkHalf01"
    ComponentLookup[51].formid = 104336
    ComponentLookup[51].mask = 1
    ComponentLookup[51].counts = 2
    ComponentLookup[51].name = "PreWarFenceChainLinkHalfUp32"
    ComponentLookup[52].formid = 1689880
    ComponentLookup[52].mask = 1
    ComponentLookup[52].counts = 2
    ComponentLookup[52].name = "PreWarFenceChainLinkNoPost01"
    ComponentLookup[53].formid = 1689886
    ComponentLookup[53].mask = 1
    ComponentLookup[53].counts = 2
    ComponentLookup[53].name = "PreWarFenceChainLinkPost01"
    ComponentLookup[54].formid = 1689882
    ComponentLookup[54].mask = 1
    ComponentLookup[54].counts = 2
    ComponentLookup[54].name = "PreWarFenceChainLinkUp32"
    ComponentLookup[55].formid = 1689881
    ComponentLookup[55].mask = 1
    ComponentLookup[55].counts = 2
    ComponentLookup[55].name = "PreWarFenceChainLinkUp64"
    ComponentLookup[56].formid = 119507
    ComponentLookup[56].mask = 1
    ComponentLookup[56].counts = 4
    ComponentLookup[56].name = "Radiator01"
    ComponentLookup[57].formid = 533575
    ComponentLookup[57].mask = 1076
    ComponentLookup[57].counts = 266370
    ComponentLookup[57].name = "RadioDiamondCityReceiver"
    ComponentLookup[58].formid = 1778544
    ComponentLookup[58].mask = 1076
    ComponentLookup[58].counts = 266370
    ComponentLookup[58].name = "RadioDiamondCityReceiverNew"
    ComponentLookup[59].formid = 1458926
    ComponentLookup[59].mask = 1076
    ComponentLookup[59].counts = 266370
    ComponentLookup[59].name = "RadioFreedomReceiver"
    ComponentLookup[60].formid = 829597
    ComponentLookup[60].mask = 1076
    ComponentLookup[60].counts = 266370
    ComponentLookup[60].name = "RadioInstituteReceiver"
    ComponentLookup[61].formid = 759815
    ComponentLookup[61].mask = 1076
    ComponentLookup[61].counts = 266370
    ComponentLookup[61].name = "RadioStatic"
    ComponentLookup[62].formid = 477249
    ComponentLookup[62].mask = 1076
    ComponentLookup[62].counts = 266370
    ComponentLookup[62].name = "RadioStaticOff"
    ComponentLookup[63].formid = 1047434
    ComponentLookup[63].mask = 5
    ComponentLookup[63].counts = 72
    ComponentLookup[63].name = "RedR_SmBldg01_PumpMeterFREE01"
    ComponentLookup[64].formid = 1047435
    ComponentLookup[64].mask = 5
    ComponentLookup[64].counts = 72
    ComponentLookup[64].name = "RedR_SmBldg01_PumpMeterFREE02"
    ComponentLookup[65].formid = 1047437
    ComponentLookup[65].mask = 1
    ComponentLookup[65].counts = 2
    ComponentLookup[65].name = "RedR_SmBldg01_PumpPartStatic01"
    ComponentLookup[66].formid = 1047438
    ComponentLookup[66].mask = 1
    ComponentLookup[66].counts = 2
    ComponentLookup[66].name = "RedR_SmBldg01_PumpPartStatic02"
    ComponentLookup[67].formid = 1045018
    ComponentLookup[67].mask = 5
    ComponentLookup[67].counts = 134
    ComponentLookup[67].name = "RedR_SmBldg01_Pumps01"
    ComponentLookup[68].formid = 1047436
    ComponentLookup[68].mask = 5
    ComponentLookup[68].counts = 134
    ComponentLookup[68].name = "RedR_SmBldg01_Pumps02"
    ComponentLookup[69].formid = 196091
    ComponentLookup[69].mask = 5
    ComponentLookup[69].counts = 69
    ComponentLookup[69].name = "RefrigeratorBroken02"
    ComponentLookup[70].formid = 195437
    ComponentLookup[70].mask = 5
    ComponentLookup[70].counts = 69
    ComponentLookup[70].name = "RefrigeratorBroken03"
    ComponentLookup[71].formid = 702236
    ComponentLookup[71].mask = 5
    ComponentLookup[71].counts = 69
    ComponentLookup[71].name = "RefrigeratorBroken04_Static"
    ComponentLookup[72].formid = 1310253
    ComponentLookup[72].mask = 5
    ComponentLookup[72].counts = 69
    ComponentLookup[72].name = "RefrigeratorBroken05_Static"
    ComponentLookup[73].formid = 195439
    ComponentLookup[73].mask = 5
    ComponentLookup[73].counts = 67
    ComponentLookup[73].name = "RefrigeratorBrokenDoor01"
    ComponentLookup[74].formid = 702235
    ComponentLookup[74].mask = 5
    ComponentLookup[74].counts = 67
    ComponentLookup[74].name = "RefrigeratorBrokenDoor04"
    ComponentLookup[75].formid = 149837
    ComponentLookup[75].mask = 1
    ComponentLookup[75].counts = 6
    ComponentLookup[75].name = "Res01ModernDoor01RRStatic"
    ComponentLookup[76].formid = 149835
    ComponentLookup[76].mask = 1
    ComponentLookup[76].counts = 6
    ComponentLookup[76].name = "Res01ModernDoor02RRStatic"
    ComponentLookup[77].formid = 1689116
    ComponentLookup[77].mask = 1
    ComponentLookup[77].counts = 6
    ComponentLookup[77].name = "Res01ModernDoor04RRStatic"
    ComponentLookup[78].formid = 170927
    ComponentLookup[78].mask = 2055
    ComponentLookup[78].counts = 3953935
    ComponentLookup[78].name = "Res01ModernRubble01"
    ComponentLookup[79].formid = 438600
    ComponentLookup[79].mask = 2055
    ComponentLookup[79].counts = 3953935
    ComponentLookup[79].name = "Res01ModernRubble01b"
    ComponentLookup[80].formid = 173662
    ComponentLookup[80].mask = 2055
    ComponentLookup[80].counts = 3953935
    ComponentLookup[80].name = "Res01ModernRubble02"
    ComponentLookup[81].formid = 448122
    ComponentLookup[81].mask = 2055
    ComponentLookup[81].counts = 3953935
    ComponentLookup[81].name = "Res01ModernRubble02B"
    ComponentLookup[82].formid = 522888
    ComponentLookup[82].mask = 2051
    ComponentLookup[82].counts = 21445
    ComponentLookup[82].name = "Res01ModernRubble03"
    ComponentLookup[83].formid = 524059
    ComponentLookup[83].mask = 2049
    ComponentLookup[83].counts = 1295
    ComponentLookup[83].name = "Res01ModernRubbleCarport01"
    ComponentLookup[84].formid = 173649
    ComponentLookup[84].mask = 2051
    ComponentLookup[84].counts = 21445
    ComponentLookup[84].name = "Res01ModernRubbleMed01"
    ComponentLookup[85].formid = 173672
    ComponentLookup[85].mask = 2051
    ComponentLookup[85].counts = 21445
    ComponentLookup[85].name = "Res01ModernRubbleMed02"
    ComponentLookup[86].formid = 169057
    ComponentLookup[86].mask = 1
    ComponentLookup[86].counts = 8
    ComponentLookup[86].name = "Res01ModernRubbleSm01"
    ComponentLookup[87].formid = 107340
    ComponentLookup[87].mask = 1
    ComponentLookup[87].counts = 8
    ComponentLookup[87].name = "Res01ModernRubbleSm01b"
    ComponentLookup[88].formid = 524060
    ComponentLookup[88].mask = 1
    ComponentLookup[88].counts = 8
    ComponentLookup[88].name = "Res01ModernRubbleSm02"
    ComponentLookup[89].formid = 549397
    ComponentLookup[89].mask = 133
    ComponentLookup[89].counts = 8522
    ComponentLookup[89].name = "ResidentialStreetLamp01"
    ComponentLookup[90].formid = 659230
    ComponentLookup[90].mask = 2
    ComponentLookup[90].counts = 1
    ComponentLookup[90].name = "RowboatRudder01"
    ComponentLookup[91].formid = 159489
    ComponentLookup[91].mask = 65
    ComponentLookup[91].counts = 130
    ComponentLookup[91].name = "SafeNoDoor"
    ComponentLookup[92].formid = 549417
    ComponentLookup[92].mask = 1
    ComponentLookup[92].counts = 4
    ComponentLookup[92].name = "SanctuaryMailboxStand"
    ComponentLookup[93].formid = 576169
    ComponentLookup[93].mask = 1
    ComponentLookup[93].counts = 6
    ComponentLookup[93].name = "SanctuaryMailboxStatic_UseSparingly"
    ComponentLookup[94].formid = 284514
    ComponentLookup[94].mask = 8
    ComponentLookup[94].counts = 10
    ComponentLookup[94].name = "SandbagWall01"
    ComponentLookup[95].formid = 469516
    ComponentLookup[95].mask = 8
    ComponentLookup[95].counts = 10
    ComponentLookup[95].name = "SandbagWallNoSkirt01"
    ComponentLookup[96].formid = 1684517
    ComponentLookup[96].mask = 1
    ComponentLookup[96].counts = 10
    ComponentLookup[96].name = "Sedan01_Static"
    ComponentLookup[97].formid = 1684518
    ComponentLookup[97].mask = 1
    ComponentLookup[97].counts = 10
    ComponentLookup[97].name = "Sedan02_Static"
    ComponentLookup[98].formid = 1684519
    ComponentLookup[98].mask = 1
    ComponentLookup[98].counts = 10
    ComponentLookup[98].name = "Sedan03_Static"
    ComponentLookup[99].formid = 1684520
    ComponentLookup[99].mask = 1
    ComponentLookup[99].counts = 10
    ComponentLookup[99].name = "Sedan04_Static"
	
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