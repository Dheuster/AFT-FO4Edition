Scriptname AFT:TweakDLC01Script extends Quest Conditional

String PluginName = "DLCRobot.esm" const

; TODO: Stores DLC01 items using -0x01 as Resource ID. Will need to update the Builder to recognize this
;       convention and lookup the negative version of the numbers using GetFormFromFile(). 

; This is a proxy script that can be used to inject DLC01 resources into AFT without
; creating a hard dependency on the DLC. 

Bool			Property	Installed		Auto Conditional
float			Property	version			Auto
Int				Property	resourceID		Auto

; --=== Actors ===--
Actor			Property	Ada				Auto
Actor			Property	Mechanist		Auto
ActorBase		Property	AdaBase			Auto
ActorBase		Property	MechanistBase	Auto
ReferenceAlias	Property	DLC01Ada		Auto Const
ReferenceAlias	Property	DLC01Mechanist	Auto Const

; --=== Quests ===--
Quest			Property	DLC01MQ00		Auto
Quest			Property	DLC01MQ01		Auto
Quest			Property	DLC01MQ02		Auto
Quest			Property	DLC01MQ04		Auto
Quest			Property	DLC01MQ05		Auto

; --=== Topics ===--
Topic			Property	DLC01COMRTalkGreetings				Auto
Topic			Property	DLC01COMRobotCompanion_Hello		Auto
int				Property	DLC01COMRobotCompanionOther_AgreeMasked	= 0x000113A0 Auto const
int				Property	DLC01COMRobotCompanion_TradeMasked		= 0x00000BD2 Auto const

; DLC01WorkshopParent_AssignConfirmMasked is actually from DLC01COMRobotCompanionTalk
int				Property	DLC01WorkshopParent_AssignConfirmMasked = 0x0100085E Auto const

; Outfits and clothes

; --=== Locations ===--
Location		Property	AdaCaravenLocation 					Auto
Location		Property	MechGeneralAtomicsFactoryLocation	Auto
Location		Property	MechLairLocation					Auto
Location		Property	MechLairRoboStoreLocation			Auto
LocationAlias	Property	DLC01CaravenLocation				Auto Const
LocationAlias	Property	DLC01GeneralAtomicsFactoryLocation	Auto Const
LocationAlias	Property	DLC01LairLocation					Auto Const
LocationAlias	Property	DLC01LairRoboStoreLocation			Auto Const

; --=== Factions ===--
Faction			Property	DLC01WorkshopRobotFaction			Auto

; --=== Prefab Support ===--
; Quest			Property TweakScrapScanMaster			Auto Const ; Possibly creates a circular dependency. Lookup at runtime....
GlobalVariable	Property pTweakScanThreadsDone			Auto Const
GlobalVariable	Property pTweakScanObjectsFound			Auto Const
FormList		Property TweakScrapScan_DLC01			Auto Const
GlobalVariable	Property pTweakScrapAll					Auto Const
GlobalVariable	Property pTweakSettlementSnap			Auto Const
GlobalVariable	Property pTweakOptionsScanC				Auto Const
GlobalVariable	Property pTweakOptionsScanC_ExBenches	Auto Const
GlobalVariable	Property pTweakOptionsScanNC			Auto Const
GlobalVariable	Property pTweakOptionsScanNC_ExMisc		Auto Const
GlobalVariable	Property pTweakOptionsScanNC_IncTheRest	Auto Const
;GlobalVariable	Property pTweakOptionsScanNC_ExFood		Auto Const
;GlobalVariable	Property pTweakOptionsScanNC_ExLiving	Auto Const
;GlobalVariable	Property pTweakOptionsScanC_ExTurrets	Auto Const
;GlobalVariable	Property pTweakOptionsScanC_ExFences	Auto Const
;GlobalVariable	Property pTweakOptionsScanC_ExWalls		Auto Const
;GlobalVariable	Property pTweakOptionsScanC_ExFloors	Auto Const
;GlobalVariable	Property pTweakOptionsScanC_ExShops		Auto Const
;GlobalVariable	Property pTweakOptionsScanC_ExCont		Auto Const
;GlobalVariable	Property pTweakOptionsScanC_ExFood		Auto Const
;GlobalVariable	Property pTweakOptionsScanC_IncTheRest	Auto Const
;GlobalVariable	Property pTweakOptionsScanNC_ExCont		Auto Const

Struct SettlementDataDLC01
   int    locid
   string name
   ; bs = bounding sphere
   float  bs_x
   float  bs_y
   float  bs_z
   float  bs_radius
EndStruct

SettlementDataDLC01[] Property SettlementLookup Auto

Struct ScrapDataDLC01
   string name
   int    formid
   int    mask
   int    counts
EndStruct

; --=== LOCAL Variables ===---
ScrapDataDLC01[] ScrapData
GlobalVariable[] ResultArray
ObjectReference center
float 			radius

int SCAN_OBJECTS		 = 999 const

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakDLC01Script"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Event OnInit()
	trace("OnInit() Called")
	resourceID          = -1
	version				= 1.0
endEvent

Event OnQuestInit()
	trace("OnQuestInit() Called")
	AllToNone()
EndEvent

Function AllToNone()
	trace("AllToNone() Called")

	Installed			= false
	Ada = None
	Mechanist = None
	AdaBase = None
	MechanistBase = None
	DLC01Ada.Clear()
	DLC01Mechanist.Clear()
	
	DLC01MQ00 = None
	DLC01MQ01 = None
	DLC01MQ02 = None
	DLC01MQ04 = None
	DLC01MQ05 = None

	DLC01COMRTalkGreetings = None
	DLC01COMRobotCompanion_Hello = None
	; DLC01COMRobotCompanionOther_Agree = None
	; DLC01COMRobotCompanion_Trade = None

	AdaCaravenLocation = None
	MechGeneralAtomicsFactoryLocation = None
	MechLairLocation = None
	MechLairRoboStoreLocation = None
	DLC01WorkshopRobotFaction = None

	DLC01CaravenLocation.Clear()
	DLC01GeneralAtomicsFactoryLocation.Clear()
	DLC01LairLocation.Clear()
	DLC01LairRoboStoreLocation.Clear()
	
endFunction

Function OnGameLoaded(bool firstcall)
	trace("OnGameLoaded() Called")
	
	if (Game.IsPluginInstalled(PluginName))	
	
		trace(PluginName + " Detected")

		bool 	issue = false

		; Load Resources
		DLC01MQ00 = Game.GetFormFromFile(0x01000805,PluginName) As Quest
		DLC01MQ01 = Game.GetFormFromFile(0x01000806,PluginName) As Quest
		DLC01MQ02 = Game.GetFormFromFile(0x01000801,PluginName) As Quest
		DLC01MQ04 = Game.GetFormFromFile(0x01002833,PluginName) As Quest
		DLC01MQ05 = Game.GetFormFromFile(0x010010F5,PluginName) As Quest

		if DLC01MQ00
			resourceID = GetPluginID(DLC01MQ00.GetFormID())
		elseif DLC01MQ01
			resourceID = GetPluginID(DLC01MQ01.GetFormID())
		elseif DLC01MQ02
			resourceID = GetPluginID(DLC01MQ02.GetFormID())
		elseif DLC01MQ04
			resourceID = GetPluginID(DLC01MQ04.GetFormID())
		elseif DLC01MQ05
			resourceID = GetPluginID(DLC01MQ05.GetFormID())
		endif
		
		if (!DLC01MQ00 || !DLC01MQ01 || !DLC01MQ02 || !DLC01MQ04 || !DLC01MQ05)
			trace("At least 1 of the DLC01 Quests did not load.")
			issue = True
		else
			trace("Loaded DLC01 Quests")
		endif
		
		DLC01COMRTalkGreetings = Game.GetFormFromFile(0x01000908,PluginName) As Topic
		DLC01COMRobotCompanion_Hello = Game.GetFormFromFile(0x01000BF2,PluginName) As Topic
		; DLC01COMRobotCompanionOther_Agree = Game.GetFormFromFile(0x010113A0,PluginName) As Topic
		; DLC01COMRobotCompanion_Trade = Game.GetFormFromFile(0x01000BD2,PluginName) As Topic

		if (!DLC01COMRTalkGreetings || !DLC01COMRobotCompanion_Hello)
			trace("Unable To Load DLC01COMRTalkGreetings or DLC01COMRobotCompanion_Hello")
			issue = True
		else
			trace("Loaded DLC01 Topics")
		endif
		
		AdaBase       = Game.GetFormFromFile(0x0100FD5A,PluginName) As ActorBase
		MechanistBase = Game.GetFormFromFile(0x010008B2,PluginName) As ActorBase
		
		if AdaBase
			trace("Loaded DLC01 Ada ActorBase")
			Ada = AdaBase.GetUniqueActor()
		else
			trace("Unable To Load Ada ActorBase")
			issue = True
		endif
		
		if MechanistBase
			trace("Loaded DLC01 Mechanist ActorBase")
			Mechanist = MechanistBase.GetUniqueActor()
		else
			trace("Unable To Load Mechanist ActorBase")
			issue = True
		endif
		
		if !Ada
			; Backup
			ReferenceAlias AdaREF = None
			if DLC01MQ01
				AdaREF = DLC01MQ01.GetAlias(77) As ReferenceAlias
				if AdaREF
					Ada = AdaREF.GetActorReference()
				endif
				if (!Ada && DLC01MQ02)
					AdaREF = DLC01MQ02.GetAlias(0) As ReferenceAlias
					if AdaREF
						Ada = AdaREF.GetActorReference()
					endif
					if (!Ada && DLC01MQ04)
						AdaREF = DLC01MQ04.GetAlias(0) As ReferenceAlias
						if AdaREF
							Ada = AdaREF.GetActorReference()
						endif
						if (!Ada && DLC01MQ05)
							AdaREF = DLC01MQ05.GetAlias(7) As ReferenceAlias
							if AdaREF
								Ada = AdaREF.GetActorReference()
							endif
						endif
					endif
				endif
			endif
		endif
		
		if !Mechanist
			; Backup
			ReferenceAlias MechanistREF = None
			if DLC01MQ05
				MechanistREF = DLC01MQ05.GetAlias(2) As ReferenceAlias
				if MechanistREF
					Mechanist = MechanistREF.GetActorReference()
				endif
			endif
		endif
		
		If Ada
			trace("Loaded DLC01 Ada Actor")
			DLC01Ada.ForceRefTo(Ada)
		else
			trace("Unable To Fill DLC01Ada Reference Alias")
			issue = True			
		endif
		
		If Mechanist
			trace("Loaded DLC01 Mechanist Actor")
			DLC01Mechanist.ForceRefTo(Mechanist)
		else
			trace("Unable To Fill DLC01Mechanist Reference Alias")
			issue = True			
		endif
				
		AdaCaravenLocation = Game.GetFormFromFile(0x0100FFFA,PluginName) As Location
		MechGeneralAtomicsFactoryLocation = Game.GetFormFromFile(0x01011362,PluginName) As Location
		MechLairLocation = Game.GetFormFromFile(0x010008A4,PluginName) As Location
		MechLairRoboStoreLocation = Game.GetFormFromFile(0x0101089D,PluginName) As Location
		DLC01WorkshopRobotFaction = Game.GetFormFromFile(0x0100F47A,PluginName) As Faction
		
		if AdaCaravenLocation
			trace("Loaded DLC01CaravenLocation")
			DLC01CaravenLocation.ForceLocationTo(AdaCaravenLocation)
		else
			trace("Unable To Load AdaCCaravenLocation Location")
			issue = True			
		endif
		if MechGeneralAtomicsFactoryLocation
			trace("Loaded DLC01GeneralAtomicsFactoryLocation")
			DLC01GeneralAtomicsFactoryLocation.ForceLocationTo(MechGeneralAtomicsFactoryLocation)
		else
			trace("Unable To Load MechGeneralAtomicsFactoryLocation Location")
			issue = True			
		endif
		if MechLairLocation
			trace("Loaded DLC01LairLocation")
			DLC01LairLocation.ForceLocationTo(MechLairLocation)
		else
			trace("Unable To Load MechLairLocation Location")
			issue = True			
		endif
		if MechLairRoboStoreLocation
			trace("Loaded DLC01LairRoboStoreLocation")
			DLC01LairRoboStoreLocation.ForceLocationTo(MechLairRoboStoreLocation)
		else
			trace("Unable To Load MechLairRoboStoreLocation Location")
			issue = True			
		endif		
		
		if DLC01WorkshopRobotFaction
			trace("Loaded DLC01WorkshopRobotFaction")
		else
			trace("Unable To Load DLC01WorkshopRobotFaction Faction")
			issue = True			
		endif

		if (issue)
			Trace("AFT Message : Some DLC01 (Automatron) Resources Failed to Import. Compatibility issues likely.")
		endif
		
		if (!Installed)
			Trace("AFT Message : Performing 1st time install tasks...")			
			Installed = true
		endif
				
	else
		Trace("DLC01 (Automatron) Not Detected")	
		If (Installed)
			Trace("AFT Message : AFT Unloading DLC01 (Automatron) resources...")
			AllToNone()
			Installed = false
		endif
	endIf
	
endFunction

Int Function GetPluginID(int formid)
	int fullid = formid
	if fullid > 0x80000000
		fullid -= 0x80000000
	endif
	int lastsix = fullid % 0x01000000
	return (((formid - lastsix)/0x01000000) as Int)
EndFunction 

; ==========================================================
; PreFab Support
; ==========================================================
Int Function FindLocation(int lid)
	Trace("FindLocation Called")	
	if (0 == SettlementLookup.length)
		initialize_SettlementData()
		if (0 == SettlementLookup.length)
			return -1
		endif
	endif
	int maskedlid = lid
	if (maskedlid > 0x00ffffff)	
		int lidadjusted = maskedlid
		if (lidadjusted > 0x80000000)
			lidadjusted -= 0x80000000
		endif		
		maskedlid = lidadjusted % 0x01000000
	endif
	return SettlementLookup.FindStruct("locid",maskedlid)
EndFunction

string Function GetLocationName(int lookupindex)
	Trace("GetLocationName Called")	
	if (0 == SettlementLookup.length)
		initialize_SettlementData()
	endif
	return SettlementLookup[lookupindex].name
EndFunction

float Function GetLocationRadius(int lookupindex)
	Trace("GetLocationRadius Called")	
	if (0 == SettlementLookup.length)
		initialize_SettlementData()
	endif
	return SettlementLookup[lookupindex].bs_radius
EndFunction

float Function GetLocationCenterX(int lookupindex)
	Trace("GetLocationCenterX Called")	
	if (0 == SettlementLookup.length)
		initialize_SettlementData()
	endif
	return SettlementLookup[lookupindex].bs_x
EndFunction

float Function GetLocationCenterY(int lookupindex)
	Trace("GetLocationCenterY Called")	
	if (0 == SettlementLookup.length)
		initialize_SettlementData()
	endif
	return SettlementLookup[lookupindex].bs_y
EndFunction

float Function GetLocationCenterZ(int lookupindex)
	Trace("GetLocationCenterZ Called")	
	if (0 == SettlementLookup.length)
		initialize_SettlementData()
	endif
	return SettlementLookup[lookupindex].bs_z
EndFunction

Function initialize_SettlementData()

	Trace("initialize_SettlementData Called")	

	; Data pulled from WOrldObjects/Static/DLC/Workshop/*Border
	; (Provides map coordinates of border objects) (Use Info, Dbl click 
	; on instance, Edit to get coordinate values from map editor)
	;
    ; Then use Used NifScope to extract bounding sphere information
	; and its offset (bs offset = bounding sphere offset). People 
	; tend to put walls and turrets on the borders. A sphere may not 
	; include these items if they go too high, which is why we add a 
	; minimum buffer of 450 to all radiuses to ensure those 
	; on-the-border turrents are included in clearing operations. 
	
	allocate_SettlementLookup(1)
	
    SettlementLookup[0].name       = "MechanistLair"
    SettlementLookup[0].locid      =  0x000008A4
	;                                 actual   +  bs offset
    SettlementLookup[0].bs_x       = -3448.00 +  0.00
    SettlementLookup[0].bs_y       =  1400.00 +  0.00
    SettlementLookup[0].bs_z       =  -128.00 +  128.00
	;                                 ~w/25    +  extra
    SettlementLookup[0].bs_radius  =  1600 + 450
	
EndFunction

Function allocate_SettlementLookup(int len)

	; When you have an array of structs, you must still 
	; allocate each individual struct....
	
	SettlementLookup = new SettlementDataDLC01[len]
	int i = 0
	while (i < len)
		SettlementLookup[i] = new SettlementDataDLC01
		i += 1
	endWhile
EndFunction

Function Scan(ObjectReference p_center, float p_radius)
	Trace("Scan Called")
	; Early Bail if current location is not part of DLC:
	
	bool snapshot            = (pTweakSettlementSnap.GetValue() == 1.0)
	if (snapshot && GetPluginID(p_center.GetCurrentLocation().GetFormID()) != resourceID)
		trace("Area does not belong to [" + PluginName + "]. Bailing.")
		pTweakScanThreadsDone.mod(-1.0)
		return
	endif

	; Only 1 scan at a time...
	if (None != center)
		Trace("Scan already in progress. Aborting...")
		pTweakScanThreadsDone.mod(-1.0)
		return
	endif
	center = p_center
	
	radius = p_radius 
	Trace("Starting Timer")
	startTimer(0.0, SCAN_OBJECTS) ; Basically this is the same thing as FORK....
EndFunction

Event OnTimer(int aiTimerID)

	CancelTimer(aiTimerID)
	if (SCAN_OBJECTS == aiTimerID)
		ScanHelper()
		return
	endif
	
EndEvent

; Notes: Modulous unreliable on values greater than 0x80000000
Function ScanHelper()
	Trace("ScanHelper Called. Scanning...")

	TweakScrapScan_DLC01.Revert()
	
	int residoffset = 0
	if resourceID < 129
		residoffset = resourceID * 0x01000000
	endif

	trace("Creating ScrapData")
	
	prepare_ScrapData()
	int len = ScrapData.length
	if 0 == len
		pTweakScanThreadsDone.mod(-1.0)
		center = None	
		return
	endif

	Quest pTweakScrapScanMaster = Game.GetFormFromFile(0x0100919A,"AmazingFolloweTweaks.esp") as Quest
	if !pTweakScrapScanMaster
		pTweakScanThreadsDone.mod(-1.0)
		center = None	
		return
	endIf
	
	trace("Updating TweakScrapScan_DLC01")
	
	int i = 0
	if (0 == residoffset)
		while (i < len)
			Form item = Game.GetFormFromFile(ScrapData[i].formid,PluginName)
			if item
				trace("- Adding [" + ScrapData[i].name + "]")
				TweakScrapScan_DLC01.AddForm(item)
			else
				trace("- [" + ScrapData[i].name + "] not found")
			endif
			i += 1
		endwhile
	else
		Trace("Using optimized form lookup method for ScrapData")
		while (i < len)
			Form item = Game.GetForm(ScrapData[i].formid + residoffset)
			if item
				trace("- Adding [" + ScrapData[i].name + "]")
				TweakScrapScan_DLC01.AddForm(item)
			else
				trace("- [" + ScrapData[i].name + "] not found")
			endif
			i += 1		
		endwhile
	endif
	
	ObjectReference[] results
	ObjectReference   result

	Trace("Scanning...")

	results = center.FindAllReferencesOfType(TweakScrapScan_DLC01, radius)			
	int numresults = results.length
	
	Trace("Scanning Complete: [" + numresults + "] objects found")
	TweakScrapScan_DLC01.Revert()
	
	if (0 == numresults)
		ScrapData.Clear()
		pTweakScanThreadsDone.mod(-1.0)
		center = None	
		return
	endif
	
	; tracking
	int lookupsuccess = 0
	int lookupindex   = 0
	int[] scrapresults = new int[31]		
	int	s = 0
	while (s < 31)
		scrapresults[s] = 0
		s += 1
	endwhile

	ScrapDataDLC01 lookup
	
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
	
	Form	rbase	
	int 	bit
	int 	offset
	int		rid
	int 	count
	bool	keepgoing = true
	
	Var[]	params = new Var[10]
	params[9] = -1
	AFT:TweakScrapScanScript ScrapScanMaster = pTweakScrapScanMaster as AFT:TweakScrapScanScript

	bool scrapall            = (pTweakScrapAll.GetValue()       == 1.0)
	bool snapshot            = (pTweakSettlementSnap.GetValue() == 1.0)
	
	i = 0
	int nextcheck = 30
	if (0 == residoffset)
		while (i != numresults && keepgoing)
			result = results[i]
			if scrapall
				result.SetPosition(0,0,0)
				result.Disable()
				result.Delete()
			elseif (!result.IsDisabled())
				rbase = result.GetBaseObject()
				rid   = rbase.GetFormID()
				if rid > 0x80000000
					rid = rid - 0x80000000
				endif
				rid = rid % 0x01000000
				lookupindex = ScrapData.FindStruct("formid",rid)
				if (lookupindex > -1)
					lookup = ScrapData[lookupindex]
					lookupsuccess += 1
					if snapshot				
						params[0] = lookup.name
						params[1] = ((-0x01000000) - rid)  ; ResourceID -0x01 tells AFT it is DLOC01 object.
						params[2] = result.GetPositionX()
						params[3] = result.GetPositionY()
						params[4] = result.GetPositionZ()
						params[5] = result.GetAngleX()
						params[6] = result.GetAngleY()
						params[7] = result.GetAngleZ()
						params[8] = result.GetScale()
						;params[9] = -1
						Trace("Adding Components [" + lookup.name + "] to scrapresults")
						ScrapScanMaster.CallFunctionNoWait("TweakBuildInfo", params)
					else			
						result.SetPosition(0,0,10)
						result.Disable()
						result.Delete()
						Trace("Adding Scrap [" + lookup.name + "] to scrapresults")
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
							scrapresults[offset] += count
						endif
						offset += 1
					endWhile
				endif
			endif
			i += 1
			if (nextcheck == i)
				nextcheck += 30
				keepgoing = (pTweakScanThreadsDone.GetValue() > 0.0)
			endif
		endwhile		
	else
		Trace("Using optimized rid computation method for ScrapData")
		while (i != numresults && keepgoing)
			result = results[i]
			if scrapall
				result.SetPosition(0,0,0)
				result.Disable()
				result.Delete()
			elseif (!result.IsDisabled())
				rbase = result.GetBaseObject()
				rid   = rbase.GetFormID() - residoffset
				if ((rid > 0) && (rid < 0x01000000))
					lookupindex = ScrapData.FindStruct("formid",rid)
					if (lookupindex > -1)
						lookup = ScrapData[lookupindex]
						lookupsuccess += 1
						if snapshot				
							params[0] = lookup.name
							params[1] = ((-0x01000000) - rid)  ; ResourceID -0x01 tells AFT it is DLOC01 object.
							params[2] = result.GetPositionX()
							params[3] = result.GetPositionY()
							params[4] = result.GetPositionZ()
							params[5] = result.GetAngleX()
							params[6] = result.GetAngleY()
							params[7] = result.GetAngleZ()
							params[8] = result.GetScale()
							;params[9] = -1
							Trace("Adding Components [" + lookup.name + "] to scrapresults")
							ScrapScanMaster.CallFunctionNoWait("TweakBuildInfo", params)
						else			
							result.SetPosition(0,0,10)
							result.Disable()
							result.Delete()
							Trace("Adding Scrap [" + lookup.name + "] to scrapresults")
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
								scrapresults[offset] += count
							endif
							offset += 1
						endWhile
					endif
				endif
			endif
			
			i += 1
			if (nextcheck == i)
				nextcheck += 30
				keepgoing = (pTweakScanThreadsDone.GetValue() > 0.0)
			endif
			
		endwhile
	endif

	if (0 != lookupsuccess)
		pTweakScanObjectsFound.mod(lookupsuccess)
		initialize_ResultArray()
		i = 0
		while (i < 31)
			if scrapresults[i] != 0
				Trace("Adding [" + scrapresults[i] + "] to ResultArray [" + i + "]")
				ResultArray[i].mod(scrapresults[i])
			endif
			i += 1
		endwhile
		ResultArray.clear()
	endif
	
	scrapresults.clear()
	ScrapData.clear()
	pTweakScanThreadsDone.mod(-1.0)
	center = None	
		
EndFunction

Function prepare_ScrapData()
	
	trace("prepare_ScrapData")

	ScrapData.clear()
	
	; ----------------------
	; calculate
	; ----------------------
	bool scrapall            = (pTweakScrapAll.GetValue()       == 1.0)
	bool snapshot            = (pTweakSettlementSnap.GetValue() == 1.0)
	bool includeCreatable    = (pTweakOptionsScanC.GetValue()   == 1.0)
	bool includeNonCreatable = (pTweakOptionsScanNC.GetValue()  == 1.0)
	
;	bool c_include_turrets   = (pTweakOptionsScanC_ExTurrets.GetValue() == 0.0)
;	bool c_include_fences    = (pTweakOptionsScanC_ExFences.GetValue() == 0.0)
;	bool c_include_walls     = (pTweakOptionsScanC_ExWalls.GetValue() == 0.0)
;	bool c_include_floors    = (pTweakOptionsScanC_ExFloors.GetValue() == 0.0)
	bool c_include_benches   = (pTweakOptionsScanC_ExBenches.GetValue() == 0.0)
;	bool c_include_shops	 = (pTweakOptionsScanC_ExShops.GetValue() == 0.0)
;	bool c_include_conts	 = (pTweakOptionsScanC_ExCont.GetValue() == 0.0)
;   bool c_include_food		 = (pTweakOptionsScanC_ExFood.GetValue() == 0.0)
;	bool c_include_therest	 = (pTweakOptionsScanC_IncTheRest.GetValue() == 1.0)

;	bool nc_include_conts    = (pTweakOptionsScanNC_ExCont.GetValue() == 0.0)
;	bool nc_include_living   = (pTweakOptionsScanNC_ExLiving.GetValue() == 0.0)
;	bool nc_include_food     = (pTweakOptionsScanNC_ExFood.GetValue() == 0.0)
	bool nc_include_misc     = (pTweakOptionsScanNC_ExMisc.GetValue() == 0.0)
	bool nc_include_therest  = (pTweakOptionsScanNC_IncTheRest.GetValue() == 1.0)
	

		
	int  expected = 0
	
	if (includeCreatable == 1.0 || snapshot || scrapall)
		expected += 1
	else
;		if (c_include_turrets)
;			expected += 0
;		endif
;		if (c_include_fences)
;			expected += 0
;		endif
;		if (c_include_walls)
;			expected += 0
;		endif
;		if (c_include_floors)
;			expected += 0
;		endif
		if (c_include_benches)
			expected += 1
		endif
;		if (c_include_shops)
;			expected += 0
;		endIf
;		if (c_include_conts)
;			expected += 0
;		endIf
;		if (c_include_food)
;			expected += 0
;		endIf
;		if (c_include_therest))
;			expected += 0
;		endIf
	endif

	if (includeNonCreatable || snapshot || scrapall)
		expected += 87
	else
;		if (nc_include_conts)
;			expected += 0
;		endIf
;		if (nc_include_living)
;			expected += 0
;		endIf
;		if (nc_include_food)
;			expected += 0
;		endIf
		if (nc_include_misc)
			expected += 49
		endIf
		if (nc_include_therest)
			expected += 38
		endIf
	endIf

	if (0 == expected)
		trace("No Expected Results. Bailing.")
		return		
	endIf
	
	; ----------------------
	; Allocate
	; ----------------------
	ScrapData = new ScrapDataDLC01[expected]
	int i = 0
	while (i < expected)
		ScrapData[i] = new ScrapDataDLC01
		i += 1
	endWhile
	
	; ----------------------
	; Populate
	; ----------------------
	int c = 0

	if (includeCreatable == 1.0 || snapshot || scrapall)
		ScrapData[c].name       = "WorkbenchRobot"
		ScrapData[c].formid     =  0x01001F16
		ScrapData[c].mask  =  0
		c += 1
	else
;		if (c_include_turrets)
;		endif
;		if (c_include_fences)
;		endif
;		if (c_include_walls)
;		endif
;		if (c_include_floors)
;		endif
		if (c_include_benches)
			ScrapData[c].name       = "WorkbenchRobot"
			ScrapData[c].formid     =  0x01001F16
			ScrapData[c].mask  =  0
			c += 1
		endif
;		if (c_include_shops)
;		endIf
;		if (c_include_conts)
;		endIf
;		if (c_include_food)
;		endIf
;		if (c_include_therest))
;		endIf
	endif

	if (includeNonCreatable || snapshot || scrapall)
		c = includeNonConstructableMisc(c)
		c = includeNonConstructableTheRest(c)
	else

;		if (nc_include_conts)
;		endIf
;		if (nc_include_living)
;		endIf
;		if (nc_include_food)
;		endIf
		if (nc_include_misc)
			c = includeNonConstructableMisc(c)
		endIf		
		if (nc_include_therest)
			c = includeNonConstructableTheRest(c)
		endif
	endIf
	
	if (c != expected)
		trace("Checksum Error: Expected [" + expected + "] Created [" + c + "]")
	endIf

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

int Function includeNonConstructableMisc(int c)
	ScrapData[c].name       = "DLC01Scrappable_EatOTronic01Dirty" ; c_Steel:4
	ScrapData[c].formid     =  0x0000DBC3
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  4
	c += 1
	ScrapData[c].name       = "DLC01RoboBrainInChair"
	ScrapData[c].formid     =  0x00004F2A
	ScrapData[c].mask  		=  0 
	ScrapData[c].counts		=  0
	c += 1
	ScrapData[c].name       = "DLC01_TrashClump01_RobotDebris"
	ScrapData[c].formid     =  0x000109E2
	ScrapData[c].mask  		=  0
	ScrapData[c].counts		=  0
	c += 1
	ScrapData[c].name       = "DLC01_TrashClump02_RobotDebris"
	ScrapData[c].formid     =  0x000109E1
	ScrapData[c].mask  		=  0
	ScrapData[c].counts		=  0
	c += 1
	ScrapData[c].name       = "DLC01_TrashClump03_RobotDebris"
	ScrapData[c].formid     =  0x000109E0
	ScrapData[c].mask  		=  0
	ScrapData[c].counts		=  0
	c += 1
	ScrapData[c].name       = "DLC01RoboBrainHead"
	ScrapData[c].formid     =  0x00004F2B
	ScrapData[c].mask  		=  0
	ScrapData[c].counts		=  0
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_BarrelTankFlammable" ; c_Aluminum:2 c_Steel:2
	ScrapData[c].formid     =  0x0000DBF5
	ScrapData[c].mask  		=  257
	ScrapData[c].counts		=  130
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_Gurney01" ; c_Steel:2 c_Wood:1
	ScrapData[c].formid     =  0x0000DBCC
	ScrapData[c].mask  		=  3
	ScrapData[c].counts		=  66
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_Gurney01Static" ; c_Steel:2 c_Wood:1
	ScrapData[c].formid     =  0x0000DBC6
	ScrapData[c].mask  		=  3
	ScrapData[c].counts		=  66
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_Sawhorse01" ; c_Wood:2
	ScrapData[c].formid     =  0x0000DBB6
	ScrapData[c].mask  		=  2
	ScrapData[c].counts		=  2
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_Vault_OxygenTank_01" ; c_Steel:2
	ScrapData[c].formid     =  0x0000DBCD
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  2
	c += 1
	ScrapData[c].name       = "DLC01LairScrappable_NpcChairHighTechOfficeChairDirtySit01Static" ; c_Leather:1 c_Plastic:1 c_Steel:2
	ScrapData[c].formid     =  0x0000DBFC
	ScrapData[c].mask  		=  33554449
	ScrapData[c].counts		=  4162
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_ConstructionLight_Floor" ; c_Copper:2 c_Glass:2 c_Steel:1
	ScrapData[c].formid     =  0x0000E302
	ScrapData[c].mask  		=  161
	ScrapData[c].counts		=  8321
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_ConstructionLight_FloorOn" ; c_Copper:2 c_Glass:2 c_Steel:1
	ScrapData[c].formid     =  0x0000E2FA
	ScrapData[c].mask  		=  161
	ScrapData[c].counts		=  8321
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_Vault_Cart_01" ; c_Steel:2
	ScrapData[c].formid     =  0x0000DBF4
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  2
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_Vault_Shelf_03" ; c_Steel:4
	ScrapData[c].formid     =  0x0000DBC7
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  4
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_CrateLargeAquaMud" ; c_Steel:3
	ScrapData[c].formid     =  0x0000DBF1
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_CrateLargeBlueRust" ; c_Steel:3
	ScrapData[c].formid     =  0x0000DBEF
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_CrateLargeGreenRusty" ; c_Steel:3
	ScrapData[c].formid     =  0x0000DBF0
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_CrateLargeGreyMud"  ; c_Steel:3
	ScrapData[c].formid     =  0x0000DBBE
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_CrateLargeOrange" ; c_Steel:3
	ScrapData[c].formid     =  0x0000B250
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_CrateLargeOrangeMud" ; c_Steel:3
	ScrapData[c].formid     =  0x0000DBC0
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_CrateLargeOrangeMuddy" ; c_Steel:3
	ScrapData[c].formid     =  0x0000DBBD
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_CrateLargeOrangeRust" ; c_Steel:3
	ScrapData[c].formid     =  0x0000DBBF
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_CrateLargeRedMud" ; c_Steel:3
	ScrapData[c].formid     =  0x0000DBB7
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_FatmanCrate" ; c_Steel:3
	ScrapData[c].formid     =  0x0000DBC2
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_FlatbedCart" ; c_Steel:2 c_Wood:1
	ScrapData[c].formid     =  0x0000DBFD
	ScrapData[c].mask  		=  3
	ScrapData[c].counts		=  66
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_FlatbedCart_Small" ; c_Steel:2 c_Wood:1
	ScrapData[c].formid     =  0x0000DBFB
	ScrapData[c].mask  		=  3
	ScrapData[c].counts		=  66
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_Forklift01" ; c_Aluminum:6 c_Rubber:4 c_Steel:6
	ScrapData[c].formid     =  0x0000B24A
	ScrapData[c].mask  		=  261
	ScrapData[c].counts		=  24838
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_HospitalLights03StandDamagedUnlit" ; c_Copper:2 c_Glass:2 c_Steel:2
	ScrapData[c].formid     =  0x0000DBC4
	ScrapData[c].mask  		=  161
	ScrapData[c].counts		=  8322
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_HospitalLights04CeilingDamagedUnlit" ; c_Copper:2 c_Glass:2 c_Steel:2
	ScrapData[c].formid     =  0x0000DBC5
	ScrapData[c].mask  		=  161
	ScrapData[c].counts		=  8322
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndustrialCart01" ; c_Steel:5
	ScrapData[c].formid     =  0x00010115
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  5
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndustrialMetalTableLarge01" ; c_Steel:4
	ScrapData[c].formid     =  0x0000DBF2
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  4
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_MegaloaderBase01" ; c_Copper:2 c_Glass:2 c_Steel:1
	ScrapData[c].formid     =  0x0000F897
	ScrapData[c].mask  		=  161
	ScrapData[c].counts		=  8321
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_MegaloaderForklift02" ; c_Aluminum:6 c_Rubber:4 c_Steel:6
	ScrapData[c].formid     =  0x0000F898
	ScrapData[c].mask  		=  261
	ScrapData[c].counts		=  24838
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_NpcBenchShortVaultSit01Static" ; c_Steel:4
	ScrapData[c].formid     =  0x0000DBCB 
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  4
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_Prewar_Locker_Empty01" ; c_Steel:4
	ScrapData[c].formid     =  0x0000DBC8
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  4
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_Debris01" ; c_Steel:1
	ScrapData[c].formid     =  0x0000DBC1
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  1
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_Debris02" ; c_Steel:1
	ScrapData[c].formid     =  0x0000DBCE
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  1
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_Debris12" ; c_Steel:1
	ScrapData[c].formid     =  0x00010C5E
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  1
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_Debris04" ; c_Steel:1
	ScrapData[c].formid     =  0x0000DBD4
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  1
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_Debris05" ; c_Steel:1
	ScrapData[c].formid     =  0x0000DBFE
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  1
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_Debris06" ; c_Steel:1
	ScrapData[c].formid     =  0x0000E303
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  1
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_Debris08" ; c_Steel:1
	ScrapData[c].formid     =  0x0000E305
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  1
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_Debris13" ; c_Steel:1
	ScrapData[c].formid     =  0x00010C60
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  1
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_Debris09" ; c_Steel:1
	ScrapData[c].formid     =  0x0000E2FB
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  1
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_Debris10" ; c_Steel:1
	ScrapData[c].formid     =  0x0000E300
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  1
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_Debris11" ; c_Steel:1
	ScrapData[c].formid     =  0x00010117
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  1
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_Debris12b" ; c_Steel:1
	ScrapData[c].formid     =  0x00010C56
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  1
	c += 1
	return c
endFunction

int Function includeNonConstructableTheRest(int c)
	ScrapData[c].name       = "DLC01SecurityDoorLight"
	ScrapData[c].formid     =  0x000072E6
	ScrapData[c].mask  		=  0
	ScrapData[c].counts		=  0
	c += 1
	ScrapData[c].name       = "DLC01RobotLiftLight" ; 1 Steel
	ScrapData[c].formid     =  0x000026C7
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  1
	c += 1
	ScrapData[c].name       = "DLC01MechIrisDoor01"
	ScrapData[c].formid     =  0x00003DF5
	ScrapData[c].mask  		=  0
	ScrapData[c].counts		=  0
	c += 1
	ScrapData[c].name       = "DLC01MechGearDoor01"
	ScrapData[c].formid     =  0x00003DF1
	ScrapData[c].mask  		=  0
	ScrapData[c].counts		=  0
	c += 1
	ScrapData[c].name       = "DLC01MechGarageDoor01"
	ScrapData[c].formid     =  0x00003DFA
	ScrapData[c].mask  		=  0
	ScrapData[c].counts		=  0
	c += 1
	ScrapData[c].name       = "DLC01MechBarDoor02"
	ScrapData[c].formid     =  0x00004D38
	ScrapData[c].mask  		=  0
	ScrapData[c].counts		=  0
	c += 1
	ScrapData[c].name       = "DLC01MechBarDoor01"
	ScrapData[c].formid     =  0x00003DFC
	ScrapData[c].mask  		=  0
	ScrapData[c].counts		=  0
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_SecurityGateSm01A" ; c_Steel:8
	ScrapData[c].formid     =  0x0000B24F
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  8
	c += 1 
	ScrapData[c].name       = "DLC01Scrappable_SecurityGateLg01" ; c_Steel:8
	ScrapData[c].formid     =  0x0000B24E
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  8
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_JailDoorStatic01" ; c_Steel:2
	ScrapData[c].formid     =  0x0000DBC9
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  2
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_JailSmCage02" ; c_Steel:4
	ScrapData[c].formid     =  0x0000DBCA
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  4
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_SecurityGateFencing01" ; c_Steel:8
	ScrapData[c].formid     =  0x0000B24B
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  8
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_SecurityGateFencingExLg01" ; c_Steel:8
	ScrapData[c].formid     =  0x0000B24D
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  8
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_SecurityGateFencingExSm01" ; c_Steel:8
	ScrapData[c].formid     =  0x0000B24C
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  8
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndCat1Way01" ; c_Steel:3
	ScrapData[c].formid     =  0x0000B23D
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndCat2Way01" ; c_Steel:3
	ScrapData[c].formid     =  0x0000B23C
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndCatConc1Way01" ; c_Steel:3
	ScrapData[c].formid     =  0x0000B23B 
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndCatConc1WayBrokenCap02" ; c_Steel:3
	ScrapData[c].formid     =  0x0000B23A
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndCatConc2Way01" ; c_Steel:3
	ScrapData[c].formid     =  0x0000B239
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndCatConc3Way01" ; c_Steel:3
	ScrapData[c].formid     =  0x0000B238
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndCatConc4Way01" ; c_Steel:3
	ScrapData[c].formid     =  0x0000B237
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndCatConcCircle128Main01" ; c_Steel:3
	ScrapData[c].formid     =  0x0000B236
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndCatConcRampHalf01" ; c_Steel:3
	ScrapData[c].formid     =  0x0000B235
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndFrame1024x512EmptyShape01"  ; c_Steel:5
	ScrapData[c].formid     =  0x0000B242
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  5
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndFrame1024x768EmptyShapeEdge02" ; c_Steel:5
	ScrapData[c].formid     =  0x0000B247
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  5
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndFrame256Straight01" ; c_Steel:5
	ScrapData[c].formid     =  0x0000B240
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  5
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndFrame256Straight03" ; c_Steel:5
	ScrapData[c].formid     =  0x0000B249
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  5
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndFrame256x256VShapeEdge01" ; c_Steel:5
	ScrapData[c].formid     =  0x0000B245
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  5
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndFrame256x256XShapeEdge01" ; c_Steel:5
	ScrapData[c].formid     =  0x0000B244
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  5
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndFrame512x256EmptyShape01" ; c_Steel:5
	ScrapData[c].formid     =  0x0000B246
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  5
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndFrame768x512EmptyShapeEdge01" ; c_Steel:5
	ScrapData[c].formid     =  0x0000B248
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  5
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndFrame768x768EmptyShapeEdge01" ; c_Steel:5
	ScrapData[c].formid     =  0x0000B243
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  5
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndFrameCat256x256EmptyShape01" ; c_Steel:3
	ScrapData[c].formid     =  0x0000B23F
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndFrameCat256x256EmptyShape02" ; c_Steel:3
	ScrapData[c].formid     =  0x0000B241
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Scrappable_IndFrameCat45Degree01" ; c_Steel:3
	ScrapData[c].formid     =  0x0000B23E
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01_BLDGMetalGarageDoorComANoName" ; c_Steel:3
	ScrapData[c].formid     =  0x00004E71
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01_BLDGMetalGarageDoorComDmgA" ; c_Steel:3
	ScrapData[c].formid     =  0x0000431E
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  3
	c += 1
	ScrapData[c].name       = "DLC01Lair_EntranceSecurityDoor" ; c_Steel:10
	ScrapData[c].formid     =  0x000087B1
	ScrapData[c].mask  		=  1
	ScrapData[c].counts		=  10
	c += 1
	return c
endFunction

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
