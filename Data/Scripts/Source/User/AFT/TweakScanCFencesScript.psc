Scriptname AFT:TweakScanCFencesScript extends Quest

; import AFT

Quest Property TweakScrapScanMaster Auto Const
FormList Property TweakConstructed_Fences Auto Const

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
	string logName = "TweakScanCFencesScript"
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
	; while i < 31
		; code += "    ComponentLookup[" + i + "].formid = " + TweakConstructed_Fences.GetAt(i).GetFormID() + "\n"
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
	results = center.FindAllReferencesOfType(TweakConstructed_Fences, radius)			
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
	ComponentLookup = new ComponentData[31]
	int i = 0
	while (i < ComponentLookup.length)
		ComponentLookup[i] = new ComponentData
		i += 1
	endWhile
EndFunction

Function initialize_ComponentData()

    ; Array co-insides with FORMLIST. This was generated using Python.
	
    ComponentLookup[0].formid = 385240
    ComponentLookup[0].mask = 3
    ComponentLookup[0].counts = 260
    ComponentLookup[0].name = "DeerFence_Corner01"
    ComponentLookup[1].formid = 447305
    ComponentLookup[1].mask = 3
    ComponentLookup[1].counts = 132
    ComponentLookup[1].name = "DeerFence_Lean01"
    ComponentLookup[2].formid = 447306
    ComponentLookup[2].mask = 3
    ComponentLookup[2].counts = 132
    ComponentLookup[2].name = "DeerFence_Lean02"
    ComponentLookup[3].formid = 385241
    ComponentLookup[3].mask = 3
    ComponentLookup[3].counts = 130
    ComponentLookup[3].name = "DeerFence_Long01"
    ComponentLookup[4].formid = 385242
    ComponentLookup[4].mask = 3
    ComponentLookup[4].counts = 130
    ComponentLookup[4].name = "DeerFence_Long02"
    ComponentLookup[5].formid = 385243
    ComponentLookup[5].mask = 1
    ComponentLookup[5].counts = 2
    ComponentLookup[5].name = "DeerFence_NoPost01"
    ComponentLookup[6].formid = 385244
    ComponentLookup[6].mask = 2
    ComponentLookup[6].counts = 2
    ComponentLookup[6].name = "DeerFence_Post01"
    ComponentLookup[7].formid = 385256
    ComponentLookup[7].mask = 2
    ComponentLookup[7].counts = 2
    ComponentLookup[7].name = "DeerFence_Post02"
    ComponentLookup[8].formid = 337280
    ComponentLookup[8].mask = 2
    ComponentLookup[8].counts = 3
    ComponentLookup[8].name = "PicketFenceB_EndL01"
    ComponentLookup[9].formid = 340580
    ComponentLookup[9].mask = 2
    ComponentLookup[9].counts = 3
    ComponentLookup[9].name = "PicketFenceB_EndL02"
    ComponentLookup[10].formid = 337281
    ComponentLookup[10].mask = 2
    ComponentLookup[10].counts = 3
    ComponentLookup[10].name = "PicketFenceB_EndR01"
    ComponentLookup[11].formid = 340581
    ComponentLookup[11].mask = 2
    ComponentLookup[11].counts = 3
    ComponentLookup[11].name = "PicketFenceB_EndR02"
    ComponentLookup[12].formid = 480020
    ComponentLookup[12].mask = 2
    ComponentLookup[12].counts = 3
    ComponentLookup[12].name = "PicketFenceB_Gate01"
    ComponentLookup[13].formid = 337276
    ComponentLookup[13].mask = 2
    ComponentLookup[13].counts = 6
    ComponentLookup[13].name = "PicketFenceB_Long01"
    ComponentLookup[14].formid = 346563
    ComponentLookup[14].mask = 2
    ComponentLookup[14].counts = 6
    ComponentLookup[14].name = "PicketFenceB_Long02"
    ComponentLookup[15].formid = 337277
    ComponentLookup[15].mask = 2
    ComponentLookup[15].counts = 2
    ComponentLookup[15].name = "PicketFenceB_Post01"
    ComponentLookup[16].formid = 337278
    ComponentLookup[16].mask = 2
    ComponentLookup[16].counts = 3
    ComponentLookup[16].name = "PicketFenceB_Short01"
    ComponentLookup[17].formid = 337279
    ComponentLookup[17].mask = 2
    ComponentLookup[17].counts = 3
    ComponentLookup[17].name = "PicketFenceB_Short02"
    ComponentLookup[18].formid = 337283
    ComponentLookup[18].mask = 2
    ComponentLookup[18].counts = 3
    ComponentLookup[18].name = "PicketFenceB_Short03"
    ComponentLookup[19].formid = 346561
    ComponentLookup[19].mask = 2
    ComponentLookup[19].counts = 3
    ComponentLookup[19].name = "PicketFenceB_Short04"
    ComponentLookup[20].formid = 2279009
    ComponentLookup[20].mask = 3
    ComponentLookup[20].counts = 258
    ComponentLookup[20].name = "workshop_DeerFence_Gate01"
    ComponentLookup[21].formid = 1788601
    ComponentLookup[21].mask = 7
    ComponentLookup[21].counts = 8836
    ComponentLookup[21].name = "workshop_JunkWall01"
    ComponentLookup[22].formid = 1788602
    ComponentLookup[22].mask = 7
    ComponentLookup[22].counts = 8836
    ComponentLookup[22].name = "workshop_JunkWall01A"
    ComponentLookup[23].formid = 1788603
    ComponentLookup[23].mask = 3
    ComponentLookup[23].counts = 644
    ComponentLookup[23].name = "workshop_JunkWall02"
    ComponentLookup[24].formid = 1788604
    ComponentLookup[24].mask = 3
    ComponentLookup[24].counts = 644
    ComponentLookup[24].name = "workshop_JunkWall02A"
    ComponentLookup[25].formid = 1788605
    ComponentLookup[25].mask = 7
    ComponentLookup[25].counts = 16777
    ComponentLookup[25].name = "workshop_JunkWall03"
    ComponentLookup[26].formid = 1788612
    ComponentLookup[26].mask = 7
    ComponentLookup[26].counts = 16777
    ComponentLookup[26].name = "workshop_JunkWall03A"
    ComponentLookup[27].formid = 1788606
    ComponentLookup[27].mask = 3
    ComponentLookup[27].counts = 964
    ComponentLookup[27].name = "workshop_JunkWallCorner01"
    ComponentLookup[28].formid = 1788607
    ComponentLookup[28].mask = 3
    ComponentLookup[28].counts = 964
    ComponentLookup[28].name = "workshop_JunkWallCorner01A"
    ComponentLookup[29].formid = 1788608
    ComponentLookup[29].mask = 3
    ComponentLookup[29].counts = 134
    ComponentLookup[29].name = "workshop_JunkWallDoor01"
    ComponentLookup[30].formid = 1788609
    ComponentLookup[30].mask = 3
    ComponentLookup[30].counts = 134
    ComponentLookup[30].name = "workshop_JunkWallDoor01A"

		
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

