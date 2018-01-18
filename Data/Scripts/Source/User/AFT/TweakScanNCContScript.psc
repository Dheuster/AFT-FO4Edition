Scriptname AFT:TweakScanNCContScript extends Quest

; import AFT

Quest Property TweakScrapScanMaster Auto Const
FormList Property TweakNonConstructed_Cont Auto Const

GlobalVariable   Property pTweakSettlementSnap Auto Const

GlobalVariable   Property pTweakScanThreadsDone Auto
GlobalVariable[] Property ResultArray Auto
GlobalVariable   Property pTweakOptionsScanCheckCont  Auto
GlobalVariable   Property pTweakScrapAll Auto Const

Struct ComponentData
	int formid    = 0
	int mask    = 0
	int counts  = 0
	string name = ""
EndStruct

ComponentData[] Property ComponentLookup Auto

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakScanNCContScript"
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
	; while i < 46
		; code += "    ComponentLookup[" + i + "].formid = " + TweakNonConstructed_Cont.GetAt(i).GetFormID() + "\n"
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
	results = center.FindAllReferencesOfType(TweakNonConstructed_Cont, radius)			
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
	bool checkContainer = (pTweakOptionsScanCheckCont.GetValue() == 1.0)

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
				if (!checkContainer || (result.GetItemCount() == 0 || snapshot))
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
	ComponentLookup = new ComponentData[46]
	int i = 0
	while (i < ComponentLookup.length)
		ComponentLookup[i] = new ComponentData
		i += 1
	endWhile
EndFunction

Function initialize_ComponentData()

    ; Array co-insides with FORMLIST. This was generated using Python.
	
    ComponentLookup[0].formid = 128083
    ComponentLookup[0].mask = 2
    ComponentLookup[0].counts = 20
    ComponentLookup[0].name = "FederalistDesk01_Prewar"
    ComponentLookup[1].formid = 1941483
    ComponentLookup[1].mask = 2
    ComponentLookup[1].counts = 20
    ComponentLookup[1].name = "FederalistDesk01_Prewar_Empty"
    ComponentLookup[2].formid = 1682546
    ComponentLookup[2].mask = 1
    ComponentLookup[2].counts = 2
    ComponentLookup[2].name = "HighTechTrashcan01"
    ComponentLookup[3].formid = 1682547
    ComponentLookup[3].mask = 1
    ComponentLookup[3].counts = 5
    ComponentLookup[3].name = "HighTechTrashCan01Dirty"
    ComponentLookup[4].formid = 396468
    ComponentLookup[4].mask = 65
    ComponentLookup[4].counts = 130
    ComponentLookup[4].name = "Loot_AmmoBox"
    ComponentLookup[5].formid = 2139901
    ComponentLookup[5].mask = 65
    ComponentLookup[5].counts = 130
    ComponentLookup[5].name = "Loot_Medkit_Chems_Dirty"
    ComponentLookup[6].formid = 2139904
    ComponentLookup[6].mask = 65
    ComponentLookup[6].counts = 130
    ComponentLookup[6].name = "Loot_Medkit_Chems_Wall_Dirty"
    ComponentLookup[7].formid = 383224
    ComponentLookup[7].mask = 524289
    ComponentLookup[7].counts = 66
    ComponentLookup[7].name = "Loot_Prewar_Cooler"
    ComponentLookup[8].formid = 308969
    ComponentLookup[8].mask = 65
    ComponentLookup[8].counts = 130
    ComponentLookup[8].name = "Loot_Prewar_Medkit"
    ComponentLookup[9].formid = 460793
    ComponentLookup[9].mask = 65
    ComponentLookup[9].counts = 130
    ComponentLookup[9].name = "Loot_Prewar_Medkit_Chems"
    ComponentLookup[10].formid = 463662
    ComponentLookup[10].mask = 65
    ComponentLookup[10].counts = 130
    ComponentLookup[10].name = "Loot_Prewar_Medkit_Chems_Wall"
    ComponentLookup[11].formid = 935542
    ComponentLookup[11].mask = 65
    ComponentLookup[11].counts = 130
    ComponentLookup[11].name = "Loot_Prewar_Medkit_Empty"
    ComponentLookup[12].formid = 308970
    ComponentLookup[12].mask = 65
    ComponentLookup[12].counts = 130
    ComponentLookup[12].name = "Loot_Prewar_Medkit_Wall"
    ComponentLookup[13].formid = 1160306
    ComponentLookup[13].mask = 65
    ComponentLookup[13].counts = 130
    ComponentLookup[13].name = "Loot_Prewar_Medkit_Wall_Empty"
    ComponentLookup[14].formid = 576768
    ComponentLookup[14].mask = 65
    ComponentLookup[14].counts = 130
    ComponentLookup[14].name = "Loot_Prewar_Safe"
    ComponentLookup[15].formid = 2204018
    ComponentLookup[15].mask = 65
    ComponentLookup[15].counts = 130
    ComponentLookup[15].name = "Loot_Prewar_Safe_Drugs"
    ComponentLookup[16].formid = 412220
    ComponentLookup[16].mask = 73
    ComponentLookup[16].counts = 4225
    ComponentLookup[16].name = "Loot_Prewar_Suitcase_Clothes"
    ComponentLookup[17].formid = 422065
    ComponentLookup[17].mask = 65
    ComponentLookup[17].counts = 66
    ComponentLookup[17].name = "Loot_Prewar_ToolBox"
    ComponentLookup[18].formid = 587447
    ComponentLookup[18].mask = 65
    ComponentLookup[18].counts = 132
    ComponentLookup[18].name = "Loot_Prewar_Toolcase"
    ComponentLookup[19].formid = 415190
    ComponentLookup[19].mask = 2
    ComponentLookup[19].counts = 3
    ComponentLookup[19].name = "Loot_Prewar_WoodCrate"
    ComponentLookup[20].formid = 232478
    ComponentLookup[20].mask = 65
    ComponentLookup[20].counts = 130
    ComponentLookup[20].name = "Loot_Raider_AmmoBox"
    ComponentLookup[21].formid = 231946
    ComponentLookup[21].mask = 524289
    ComponentLookup[21].counts = 66
    ComponentLookup[21].name = "Loot_Raider_Cooler"
    ComponentLookup[22].formid = 223529
    ComponentLookup[22].mask = 524289
    ComponentLookup[22].counts = 66
    ComponentLookup[22].name = "Loot_Raider_Cooler_Chems"
    ComponentLookup[23].formid = 412213
    ComponentLookup[23].mask = 65
    ComponentLookup[23].counts = 130
    ComponentLookup[23].name = "Loot_Raider_Medkit_Chems"
    ComponentLookup[24].formid = 875623
    ComponentLookup[24].mask = 65
    ComponentLookup[24].counts = 130
    ComponentLookup[24].name = "Loot_Raider_Medkit_Chems_Wall"
    ComponentLookup[25].formid = 232482
    ComponentLookup[25].mask = 73
    ComponentLookup[25].counts = 4225
    ComponentLookup[25].name = "Loot_Raider_Suitcase_Armor"
    ComponentLookup[26].formid = 232477
    ComponentLookup[26].mask = 65
    ComponentLookup[26].counts = 66
    ComponentLookup[26].name = "Loot_Raider_Toolbox"
    ComponentLookup[27].formid = 660875
    ComponentLookup[27].mask = 2
    ComponentLookup[27].counts = 3
    ComponentLookup[27].name = "Loot_Raider_WoodCrate"
    ComponentLookup[28].formid = 1704832
    ComponentLookup[28].mask = 65
    ComponentLookup[28].counts = 132
    ComponentLookup[28].name = "Loot_ToolChest"
    ComponentLookup[29].formid = 367258
    ComponentLookup[29].mask = 65
    ComponentLookup[29].counts = 66
    ComponentLookup[29].name = "Loot_Toolbox"
    ComponentLookup[30].formid = 1704831
    ComponentLookup[30].mask = 65
    ComponentLookup[30].counts = 66
    ComponentLookup[30].name = "Loot_ToolboxLarge"
    ComponentLookup[31].formid = 840349
    ComponentLookup[31].mask = 1
    ComponentLookup[31].counts = 2
    ComponentLookup[31].name = "MetalBox"
    ComponentLookup[32].formid = 594935
    ComponentLookup[32].mask = 1
    ComponentLookup[32].counts = 6
    ComponentLookup[32].name = "PlayerHouse_Ruin_Dryer01"
    ComponentLookup[33].formid = 2239936
    ComponentLookup[33].mask = 1
    ComponentLookup[33].counts = 6
    ComponentLookup[33].name = "PlayerHouse_Ruin_Dryer01_Empty"
    ComponentLookup[34].formid = 594934
    ComponentLookup[34].mask = 1
    ComponentLookup[34].counts = 6
    ComponentLookup[34].name = "PlayerHouse_Ruin_Washer01"
    ComponentLookup[35].formid = 1924400
    ComponentLookup[35].mask = 1
    ComponentLookup[35].counts = 6
    ComponentLookup[35].name = "PlayerHouse_Ruin_Washer01_Empty"
    ComponentLookup[36].formid = 654937
    ComponentLookup[36].mask = 2
    ComponentLookup[36].counts = 20
    ComponentLookup[36].name = "Prewar_Fancy_Curio01"
    ComponentLookup[37].formid = 654934
    ComponentLookup[37].mask = 2
    ComponentLookup[37].counts = 20
    ComponentLookup[37].name = "Prewar_Fancy_Dresser01"
    ComponentLookup[38].formid = 102267
    ComponentLookup[38].mask = 1
    ComponentLookup[38].counts = 2
    ComponentLookup[38].name = "Prewar_Locker_01"
    ComponentLookup[39].formid = 1174364
    ComponentLookup[39].mask = 1
    ComponentLookup[39].counts = 2
    ComponentLookup[39].name = "Prewar_Locker_Wall01"
    ComponentLookup[40].formid = 1174363
    ComponentLookup[40].mask = 1
    ComponentLookup[40].counts = 2
    ComponentLookup[40].name = "Prewar_Locker_Wall02"
    ComponentLookup[41].formid = 138874
    ComponentLookup[41].mask = 1
    ComponentLookup[41].counts = 2
    ComponentLookup[41].name = "Prewar_TrashCan"
    ComponentLookup[42].formid = 1729343
    ComponentLookup[42].mask = 1
    ComponentLookup[42].counts = 2
    ComponentLookup[42].name = "Prewar_TrashCan_Empty"
    ComponentLookup[43].formid = 715702
    ComponentLookup[43].mask = 1
    ComponentLookup[43].counts = 6
    ComponentLookup[43].name = "SanctuaryMailbox"
    ComponentLookup[44].formid = 549418
    ComponentLookup[44].mask = 1
    ComponentLookup[44].counts = 6
    ComponentLookup[44].name = "SanctuaryMailboxEmpty"
    ComponentLookup[45].formid = 279117
    ComponentLookup[45].mask = 2
    ComponentLookup[45].counts = 3
    ComponentLookup[45].name = "WoodCrate_Empty"
				
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