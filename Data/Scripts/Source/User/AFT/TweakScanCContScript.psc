Scriptname AFT:TweakScanCContScript extends Quest

; import AFT

Quest Property TweakScrapScanMaster Auto Const
FormList Property TweakConstructed_Cont Auto Const

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
	string logName = "TweakScanCContScript"
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
	; while i < 36
		; code += "    ComponentLookup[" + i + "].formid = " + TweakConstructed_Cont.GetAt(i).GetFormID() + "\n"
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
	results = center.FindAllReferencesOfType(TweakConstructed_Cont, radius)			
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
	ComponentLookup = new ComponentData[36]
	int i = 0
	while (i < ComponentLookup.length)
		ComponentLookup[i] = new ComponentData
		i += 1
	endWhile
EndFunction

Function initialize_ComponentData()

    ; Array co-insides with FORMLIST. This was generated using Python.
	
    ComponentLookup[0].formid = 97293
    ComponentLookup[0].mask = 5
    ComponentLookup[0].counts = 68
    ComponentLookup[0].name = "CigaretteMachine01"
    ComponentLookup[1].formid = 128080
    ComponentLookup[1].mask = 3
    ComponentLookup[1].counts = 386
    ComponentLookup[1].name = "FederalistFileCabinet01_Prewar"
    ComponentLookup[2].formid = 1529088
    ComponentLookup[2].mask = 3
    ComponentLookup[2].counts = 258
    ComponentLookup[2].name = "FootLocker01"
    ComponentLookup[3].formid = 1732168
    ComponentLookup[3].mask = 3
    ComponentLookup[3].counts = 258
    ComponentLookup[3].name = "HighTechDesk01_Dirty"
    ComponentLookup[4].formid = 1682547
    ComponentLookup[4].mask = 1
    ComponentLookup[4].counts = 4
    ComponentLookup[4].name = "HighTechTrashCan01Dirty"
    ComponentLookup[5].formid = 1325852
    ComponentLookup[5].mask = 5
    ComponentLookup[5].counts = 68
    ComponentLookup[5].name = "IceMachine01"
    ComponentLookup[6].formid = 412217
    ComponentLookup[6].mask = 65
    ComponentLookup[6].counts = 130
    ComponentLookup[6].name = "Loot_Prewar_Safe_Floor"
    ComponentLookup[7].formid = 177890
    ComponentLookup[7].mask = 65
    ComponentLookup[7].counts = 66
    ComponentLookup[7].name = "LunchPail"
    ComponentLookup[8].formid = 1919599
    ComponentLookup[8].mask = 65
    ComponentLookup[8].counts = 68
    ComponentLookup[8].name = "MagazineRackContainer01"
    ComponentLookup[9].formid = 1919602
    ComponentLookup[9].mask = 65
    ComponentLookup[9].counts = 68
    ComponentLookup[9].name = "MagazineRackContainer02"
    ComponentLookup[10].formid = 2382503
    ComponentLookup[10].mask = 1048577
    ComponentLookup[10].counts = 130
    ComponentLookup[10].name = "MeatBag_Floor001"
    ComponentLookup[11].formid = 2382504
    ComponentLookup[11].mask = 1048577
    ComponentLookup[11].counts = 130
    ComponentLookup[11].name = "MeatBag_Floor002"
    ComponentLookup[12].formid = 2347720
    ComponentLookup[12].mask = 1
    ComponentLookup[12].counts = 4
    ComponentLookup[12].name = "MetalBoxWorkshop"
    ComponentLookup[13].formid = 97924
    ComponentLookup[13].mask = 5
    ComponentLookup[13].counts = 68
    ComponentLookup[13].name = "MilkVendingMachine01"
    ComponentLookup[14].formid = 775484
    ComponentLookup[14].mask = 1
    ComponentLookup[14].counts = 6
    ComponentLookup[14].name = "OfficeDesk01"
    ComponentLookup[15].formid = 300578
    ComponentLookup[15].mask = 1
    ComponentLookup[15].counts = 4
    ComponentLookup[15].name = "OfficeFileCabinet01_Prewar"
    ComponentLookup[16].formid = 775470
    ComponentLookup[16].mask = 1
    ComponentLookup[16].counts = 4
    ComponentLookup[16].name = "OfficeFileCabinet02"
    ComponentLookup[17].formid = 775473
    ComponentLookup[17].mask = 1
    ComponentLookup[17].counts = 4
    ComponentLookup[17].name = "OfficeFileCabinet03"
    ComponentLookup[18].formid = 594938
    ComponentLookup[18].mask = 3
    ComponentLookup[18].counts = 258
    ComponentLookup[18].name = "PlayerHouse_Ruin_Dresser01"
    ComponentLookup[19].formid = 594939
    ComponentLookup[19].mask = 3
    ComponentLookup[19].counts = 258
    ComponentLookup[19].name = "PlayerHouse_Ruin_Dresser02"
    ComponentLookup[20].formid = 594940
    ComponentLookup[20].mask = 3
    ComponentLookup[20].counts = 257
    ComponentLookup[20].name = "PlayerHouse_Ruin_WetBar01"
    ComponentLookup[21].formid = 302495
    ComponentLookup[21].mask = 1
    ComponentLookup[21].counts = 8
    ComponentLookup[21].name = "Prewar_Cabinet_Garage_01"
    ComponentLookup[22].formid = 302496
    ComponentLookup[22].mask = 1
    ComponentLookup[22].counts = 8
    ComponentLookup[22].name = "Prewar_Cabinet_Garage_02"
    ComponentLookup[23].formid = 302497
    ComponentLookup[23].mask = 1
    ComponentLookup[23].counts = 8
    ComponentLookup[23].name = "Prewar_Cabinet_Garage_03"
    ComponentLookup[24].formid = 302498
    ComponentLookup[24].mask = 1
    ComponentLookup[24].counts = 8
    ComponentLookup[24].name = "Prewar_Cabinet_Garage_04"
    ComponentLookup[25].formid = 302492
    ComponentLookup[25].mask = 1
    ComponentLookup[25].counts = 8
    ComponentLookup[25].name = "Prewar_Cabinet_Garage_05"
    ComponentLookup[26].formid = 652330
    ComponentLookup[26].mask = 2
    ComponentLookup[26].counts = 4
    ComponentLookup[26].name = "Prewar_Fancy_Bureau01"
    ComponentLookup[27].formid = 1467020
    ComponentLookup[27].mask = 5
    ComponentLookup[27].counts = 68
    ComponentLookup[27].name = "TrashBin01"
    ComponentLookup[28].formid = 1674430
    ComponentLookup[28].mask = 36865
    ComponentLookup[28].counts = 20682
    ComponentLookup[28].name = "WorkshopSafeFloor01"
    ComponentLookup[29].formid = 2326978
    ComponentLookup[29].mask = 1
    ComponentLookup[29].counts = 4
    ComponentLookup[29].name = "Workshop_BossTrunk"
    ComponentLookup[30].formid = 2273660
    ComponentLookup[30].mask = 524289
    ComponentLookup[30].counts = 66
    ComponentLookup[30].name = "Workshop_Prewar_Cooler"
    ComponentLookup[31].formid = 2273659
    ComponentLookup[31].mask = 9
    ComponentLookup[31].counts = 129
    ComponentLookup[31].name = "Workshop_Prewar_Suitcase_Clothes"
    ComponentLookup[32].formid = 2273661
    ComponentLookup[32].mask = 1
    ComponentLookup[32].counts = 2
    ComponentLookup[32].name = "Workshop_Prewar_ToolBox"
    ComponentLookup[33].formid = 2273662
    ComponentLookup[33].mask = 1
    ComponentLookup[33].counts = 4
    ComponentLookup[33].name = "Workshop_ToolChest"
    ComponentLookup[34].formid = 2326970
    ComponentLookup[34].mask = 2
    ComponentLookup[34].counts = 3
    ComponentLookup[34].name = "Workshop_WoodCrate"
    ComponentLookup[35].formid = 302499
    ComponentLookup[35].mask = 1
    ComponentLookup[35].counts = 6
    ComponentLookup[35].name = "Prewar_Office_Desk_01"

	
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

