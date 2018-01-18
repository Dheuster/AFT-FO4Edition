Scriptname AFT:TweakScanNCVtowScript extends Quest

; import AFT

Quest Property TweakScrapScanMaster Auto Const
FormList Property TweakNonConstructed_Vtow Auto Const

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
	string logName = "TweakScanNCVtowScript"
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
	; while i < 40
		; code += "    ComponentLookup[" + i + "].formid = " + TweakNonConstructed_Vtow.GetAt(i).GetFormID() + "\n"
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
	results = center.FindAllReferencesOfType(TweakNonConstructed_Vtow, radius)			
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
	
	center = None
	if (0 == lookupsuccess)
		pTweakScanThreadsDone.mod(-1.0)
		return
	endif
		
	pTweakScanObjectsFound.mod(lookupsuccess)
	
	if (lookupsuccess != 0)
		i = 0
		while (i < 31)
			if scrapdata[i] != 0
				Trace("Adding [" + scrapdata[i] + "] to ResultArray [" + i + "]")
				ResultArray[i].mod(scrapdata[i])
			endif
			i += 1
		endwhile
	endif
	
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
	ComponentLookup = new ComponentData[40]
	int i = 0
	while (i < ComponentLookup.length)
		ComponentLookup[i] = new ComponentData
		i += 1
	endWhile
EndFunction

Function initialize_ComponentData()

    ; Array co-insides with FORMLIST. This was generated using Python.
	
    ComponentLookup[0].formid = 532783
    ComponentLookup[0].mask = 1
    ComponentLookup[0].counts = 10
    ComponentLookup[0].name = "VaultTecVanBare02"
    ComponentLookup[1].formid = 763287
    ComponentLookup[1].mask = 1
    ComponentLookup[1].counts = 2
    ComponentLookup[1].name = "Vault_Crate_01_Beige"
    ComponentLookup[2].formid = 763299
    ComponentLookup[2].mask = 1
    ComponentLookup[2].counts = 2
    ComponentLookup[2].name = "Vault_Crate_01_Blue"
    ComponentLookup[3].formid = 763291
    ComponentLookup[3].mask = 1
    ComponentLookup[3].counts = 2
    ComponentLookup[3].name = "Vault_Crate_01_Red"
    ComponentLookup[4].formid = 763279
    ComponentLookup[4].mask = 1
    ComponentLookup[4].counts = 2
    ComponentLookup[4].name = "Vault_Crate_01_Steel"
    ComponentLookup[5].formid = 763295
    ComponentLookup[5].mask = 1
    ComponentLookup[5].counts = 2
    ComponentLookup[5].name = "Vault_Crate_01_White"
    ComponentLookup[6].formid = 763288
    ComponentLookup[6].mask = 1
    ComponentLookup[6].counts = 2
    ComponentLookup[6].name = "Vault_Crate_02_Beige"
    ComponentLookup[7].formid = 763300
    ComponentLookup[7].mask = 1
    ComponentLookup[7].counts = 2
    ComponentLookup[7].name = "Vault_Crate_02_Blue"
    ComponentLookup[8].formid = 763292
    ComponentLookup[8].mask = 1
    ComponentLookup[8].counts = 2
    ComponentLookup[8].name = "Vault_Crate_02_Red"
    ComponentLookup[9].formid = 763280
    ComponentLookup[9].mask = 1
    ComponentLookup[9].counts = 2
    ComponentLookup[9].name = "Vault_Crate_02_Steel"
    ComponentLookup[10].formid = 763296
    ComponentLookup[10].mask = 1
    ComponentLookup[10].counts = 2
    ComponentLookup[10].name = "Vault_Crate_02_White"
    ComponentLookup[11].formid = 763289
    ComponentLookup[11].mask = 1
    ComponentLookup[11].counts = 2
    ComponentLookup[11].name = "Vault_Crate_03_Beige"
    ComponentLookup[12].formid = 763301
    ComponentLookup[12].mask = 1
    ComponentLookup[12].counts = 2
    ComponentLookup[12].name = "Vault_Crate_03_Blue"
    ComponentLookup[13].formid = 763293
    ComponentLookup[13].mask = 1
    ComponentLookup[13].counts = 2
    ComponentLookup[13].name = "Vault_Crate_03_Red"
    ComponentLookup[14].formid = 763281
    ComponentLookup[14].mask = 1
    ComponentLookup[14].counts = 2
    ComponentLookup[14].name = "Vault_Crate_03_Steel"
    ComponentLookup[15].formid = 763297
    ComponentLookup[15].mask = 1
    ComponentLookup[15].counts = 2
    ComponentLookup[15].name = "Vault_Crate_03_White"
    ComponentLookup[16].formid = 763290
    ComponentLookup[16].mask = 1
    ComponentLookup[16].counts = 2
    ComponentLookup[16].name = "Vault_Crate_04_Beige"
    ComponentLookup[17].formid = 763302
    ComponentLookup[17].mask = 1
    ComponentLookup[17].counts = 2
    ComponentLookup[17].name = "Vault_Crate_04_Blue"
    ComponentLookup[18].formid = 763294
    ComponentLookup[18].mask = 1
    ComponentLookup[18].counts = 2
    ComponentLookup[18].name = "Vault_Crate_04_Red"
    ComponentLookup[19].formid = 763282
    ComponentLookup[19].mask = 1
    ComponentLookup[19].counts = 2
    ComponentLookup[19].name = "Vault_Crate_04_Steel"
    ComponentLookup[20].formid = 763298
    ComponentLookup[20].mask = 1
    ComponentLookup[20].counts = 2
    ComponentLookup[20].name = "Vault_Crate_04_White"
    ComponentLookup[21].formid = 314941
    ComponentLookup[21].mask = 21
    ComponentLookup[21].counts = 4162
    ComponentLookup[21].name = "WaterCooler01_Dirty"
    ComponentLookup[22].formid = 716430
    ComponentLookup[22].mask = 21
    ComponentLookup[22].counts = 4162
    ComponentLookup[22].name = "WaterCooler02_Dirty"
    ComponentLookup[23].formid = 135668
    ComponentLookup[23].mask = 3
    ComponentLookup[23].counts = 258
    ComponentLookup[23].name = "WoodBarrel01"
    ComponentLookup[24].formid = 1726793
    ComponentLookup[24].mask = 2
    ComponentLookup[24].counts = 1
    ComponentLookup[24].name = "WoodBasket"
    ComponentLookup[25].formid = 1726791
    ComponentLookup[25].mask = 2
    ComponentLookup[25].counts = 1
    ComponentLookup[25].name = "WoodBox01"
    ComponentLookup[26].formid = 135669
    ComponentLookup[26].mask = 2
    ComponentLookup[26].counts = 5
    ComponentLookup[26].name = "WoodCrate01"
    ComponentLookup[27].formid = 1618460
    ComponentLookup[27].mask = 2
    ComponentLookup[27].counts = 5
    ComponentLookup[27].name = "WoodCrate01Dest"
    ComponentLookup[28].formid = 135670
    ComponentLookup[28].mask = 2
    ComponentLookup[28].counts = 5
    ComponentLookup[28].name = "WoodCrate02"
    ComponentLookup[29].formid = 1618461
    ComponentLookup[29].mask = 2
    ComponentLookup[29].counts = 5
    ComponentLookup[29].name = "WoodCrate02Dest"
    ComponentLookup[30].formid = 135671
    ComponentLookup[30].mask = 2
    ComponentLookup[30].counts = 5
    ComponentLookup[30].name = "WoodCrate03"
    ComponentLookup[31].formid = 1618462
    ComponentLookup[31].mask = 2
    ComponentLookup[31].counts = 5
    ComponentLookup[31].name = "WoodCrate03Dest"
    ComponentLookup[32].formid = 800900
    ComponentLookup[32].mask = 2
    ComponentLookup[32].counts = 4
    ComponentLookup[32].name = "WoodPallet01"
    ComponentLookup[33].formid = 800901
    ComponentLookup[33].mask = 2
    ComponentLookup[33].counts = 4
    ComponentLookup[33].name = "WoodPallet02"
    ComponentLookup[34].formid = 544121
    ComponentLookup[34].mask = 1
    ComponentLookup[34].counts = 2
    ComponentLookup[34].name = "WrhsDoorSmMetal01static"
    ComponentLookup[35].formid = 574122
    ComponentLookup[35].mask = 2
    ComponentLookup[35].counts = 4
    ComponentLookup[35].name = "WrhsWoodPallet01"
    ComponentLookup[36].formid = 1730074
    ComponentLookup[36].mask = 2055
    ComponentLookup[36].counts = 3953935
    ComponentLookup[36].name = "workshop_Res01ModernRubble02"
    ComponentLookup[37].formid = 1730071
    ComponentLookup[37].mask = 2055
    ComponentLookup[37].counts = 3953935
    ComponentLookup[37].name = "workshop_Res01ModernRubble02B"
    ComponentLookup[38].formid = 1734159
    ComponentLookup[38].mask = 2055
    ComponentLookup[38].counts = 3953935
    ComponentLookup[38].name = "workshop_Res01ModernRubble02C"
    ComponentLookup[39].formid = 1734161
    ComponentLookup[39].mask = 2055
    ComponentLookup[39].counts = 3953935
    ComponentLookup[39].name = "workshop_Res01ModernRubble02D"
	
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