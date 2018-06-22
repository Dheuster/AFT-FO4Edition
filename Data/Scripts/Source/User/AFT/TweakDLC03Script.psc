Scriptname AFT:TweakDLC03Script extends Quest Conditional

String PluginName = "DLCCoast.esm" const

;NOTES: Arrays can't exceed 128 items in papyrus. That is why we divide the items up over
;       3 arrays and re-use a single formlist to perform the searches.
;
;       Stores DLC03 items using -0x03 as Resource ID. Will need to update the Builder to recognize this
;       convention and lookup the negative version of the numbers using GetFormFromFile(). 

; This is a proxy script that can be used to inject DLC03 resources into AFT without
; creating a hard dependency on the DLC. 

Bool			Property	Installed		Auto Conditional
float			Property	version			Auto
Int				Property	resourceID		Auto

; --=== Actors ===--
Actor			Property	OldLongfellow		Auto
Actor			Property	DiMA				Auto
Actor			Property	KasumiNakano		Auto

ActorBase		Property	OldLongfellowBase	Auto
ActorBase		Property	DiMABase			Auto
ActorBase		Property	KasumiNakanoBase	Auto

ReferenceAlias	Property	DLC03_CompanionOldLongfellow	Auto Const
ReferenceAlias	Property	DLC03DiMA						Auto Const
ReferenceAlias	Property	DLC03KasumiNakano				Auto Const

; --=== Quests ===--
Quest			Property	DLC03MQ00			Auto
Quest			Property	DLC03MQ01			Auto
Quest			Property	DLC03MQ02			Auto
Quest			Property	DLC03MQ03			Auto
Quest			Property	DLC03MQ04			Auto
Quest			Property	DLC03MQ05			Auto
Quest			Property	DLC03MQ06			Auto
Quest			Property	DLC03MQPostQuest	Auto
Quest			Property	DLC03VisitLongFellowsCabin Auto
Faction			Property	DLC03AcadiaGenericNPCFaction	Auto

RefCollectionAlias Property	DLC03AcadiaSynthRefugees Auto

; --=== Topics ===--
Topic			Property	DLC03_COMOldLongfellowTalk_Greeting	Auto
Topic			Property	DLC03_COMOldLongfellow_Greeting		Auto
int				Property	DLC03_COMOldLongfellow_AgreeMasked = 0x0000F125	Auto Const
int				Property	DLC03_COMOldLongfellow_TradeMasked 	= 0x0000F11F	Auto Const
int				Property	DLC03_COMOldLongfellowTalk_DismissMasked = 0x0001537B	Auto Const

; Outfits and clothes
Outfit			Property	DLC03OldLongfellowOutfit	Auto

; --=== Locations ===--
Location		Property	FarHarborWorldLocation  Auto
Location		Property	RedDeathIslandLocation  Auto
Location		Property	VRLocation              Auto
Location		Property	LongfellowCabinLocation Auto
ObjectReference Property	DLC03LongfellowCabinRef Auto 
LocationAlias	Property	DLC03FarHarborWorldLocation   Auto Const
LocationAlias	Property	DLC03RedDeathIslandLocation   Auto Const
LocationAlias	Property	DLC03VRLocation               Auto Const
LocationAlias	Property	DLC03LongfellowsCabinLocation Auto Const

; --=== Prefab Support ===--
; Quest			Property TweakScrapScanMaster			Auto Const ; Possibly creates a circular dependency. Lookup at runtime....
GlobalVariable	Property pTweakScanThreadsDone			Auto Const
GlobalVariable	Property pTweakScanObjectsFound			Auto Const
FormList		Property TweakScrapScan_DLC03			Auto Const
GlobalVariable	Property pTweakScrapAll					Auto Const
GlobalVariable	Property pTweakSettlementSnap			Auto Const
GlobalVariable	Property pTweakOptionsScanC				Auto Const
GlobalVariable	Property pTweakOptionsScanC_ExBenches	Auto Const
GlobalVariable	Property pTweakOptionsScanNC			Auto Const
GlobalVariable	Property pTweakOptionsScanNC_ExMisc		Auto Const
GlobalVariable	Property pTweakOptionsScanNC_IncTheRest	Auto Const
GlobalVariable	Property pTweakOptionsScanNC_ExFood		Auto Const
GlobalVariable	Property pTweakOptionsScanNC_ExLiving	Auto Const
;GlobalVariable	Property pTweakOptionsScanC_ExTurrets	Auto Const
;GlobalVariable	Property pTweakOptionsScanC_ExFences	Auto Const
GlobalVariable	Property pTweakOptionsScanC_ExWalls		Auto Const
GlobalVariable	Property pTweakOptionsScanC_ExFloors	Auto Const
;GlobalVariable	Property pTweakOptionsScanC_ExShops		Auto Const
;GlobalVariable	Property pTweakOptionsScanC_ExCont		Auto Const
;GlobalVariable	Property pTweakOptionsScanC_ExFood		Auto Const
GlobalVariable	Property pTweakOptionsScanC_IncTheRest	Auto Const
GlobalVariable	Property pTweakOptionsScanNC_ExCont		Auto Const

int SCAN_OBJECTS		 = 999 const

Struct SettlementDataDLC03
   int    locid
   string name
   ; bs = bounding sphere
   float  bs_x
   float  bs_y
   float  bs_z
   float  bs_radius
EndStruct

SettlementDataDLC03[] Property SettlementLookup Auto

Struct ScrapDataDLC03
   string name
   int    formid
   int    mask
   int    counts
EndStruct

; --=== LOCAL Variables ===---
ScrapDataDLC03[] ScrapDataA
ScrapDataDLC03[] ScrapDataB
ScrapDataDLC03[] ScrapDataC
GlobalVariable[] ResultArray
ObjectReference  center
float 			 radius

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakDLC03Script"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Event OnInit()
	resourceID          = -3
	version				= 1.0
	AllToNone()
endEvent

Function AllToNone()

	Installed	  = false
	OldLongfellow = None
	DiMA          = None
	KasumiNakano  = None

	OldLongfellowBase = None
	DiMABase          = None
	KasumiNakanoBase  = None

	DLC03_CompanionOldLongfellow.Clear()
	DLC03DiMA.Clear()
	DLC03KasumiNakano.Clear()

	DLC03MQ00 = None
	DLC03MQ01 = None
	DLC03MQ02 = None
	DLC03MQ03 = None
	DLC03MQ04 = None
	DLC03MQ05 = None
	DLC03MQ06 = None
	DLC03MQPostQuest = None
	DLC03MQPostQuest = None
	DLC03VisitLongFellowsCabin = None	
	DLC03AcadiaGenericNPCFaction = None
	
	DLC03_COMOldLongfellowTalk_Greeting	= None
	DLC03_COMOldLongfellow_Greeting = None
	; DLC03_COMOldLongfellow_Agree = None
	; DLC03_COMOldLongfellow_Trade = None
  
	DLC03OldLongfellowOutfit = None
	
	FarHarborWorldLocation = None
	RedDeathIslandLocation = None
	VRLocation = None
	LongfellowCabinLocation = None

	DLC03LongfellowCabinRef = None
	
	DLC03FarHarborWorldLocation.Clear()
	DLC03RedDeathIslandLocation.Clear()
	DLC03VRLocation.Clear()
	DLC03LongfellowsCabinLocation.Clear()
	
endFunction


Function OnGameLoaded(bool firstcall)
	if (Game.IsPluginInstalled(PluginName))	
	
		trace(PluginName + " Detected")

		bool 	issue = false

		; Load Resources
		DLC03MQ00 = Game.GetFormFromFile(0x01001B3E,PluginName) As Quest
		DLC03MQ01 = Game.GetFormFromFile(0x01001B3F,PluginName) As Quest
		DLC03MQ02 = Game.GetFormFromFile(0x01001B40,PluginName) As Quest
		DLC03MQ03 = Game.GetFormFromFile(0x01001B41,PluginName) As Quest
		DLC03MQ04 = Game.GetFormFromFile(0x01001B42,PluginName) As Quest
		DLC03MQ05 = Game.GetFormFromFile(0x01001B43,PluginName) As Quest
		DLC03MQ06 = Game.GetFormFromFile(0x01001B44,PluginName) As Quest
		DLC03MQPostQuest = Game.GetFormFromFile(0x01004F2C,PluginName) As Quest
		DLC03VisitLongFellowsCabin = Game.GetFormFromFile(0x0104DF30,PluginName) As Quest
		
		if DLC03MQ00
			resourceID = GetPluginID(DLC03MQ00.GetFormID())
		elseif DLC03MQ01
			resourceID = GetPluginID(DLC03MQ01.GetFormID())
		elseif DLC03MQ02
			resourceID = GetPluginID(DLC03MQ02.GetFormID())
		elseif DLC03MQ03
			resourceID = GetPluginID(DLC03MQ03.GetFormID())
		elseif DLC03MQ04
			resourceID = GetPluginID(DLC03MQ04.GetFormID())
		elseif DLC03MQ05
			resourceID = GetPluginID(DLC03MQ05.GetFormID())
		elseif DLC03MQ06
			resourceID = GetPluginID(DLC03MQ06.GetFormID())
		endif
					
		if (!DLC03MQ00 || !DLC03MQ01 || !DLC03MQ02 || !DLC03MQ03)
			trace("Unable To Load DLC03MQ00 or DLC03MQ01 or DLC03MQ02 or DLC03MQ03")
			issue = True
		elseif (!DLC03MQ04 || !DLC03MQ05 || !DLC03MQ06 || !DLC03MQPostQuest)
			trace("Unable To Load DLC03MQ04 or DLC03MQ05 or DLC03MQ06 or DLC03MQPostQuest")
			issue = True
		elseif (!DLC03VisitLongFellowsCabin)
			trace("Unable To Load DLC03VisitLongFellowsCabin")
			issue = True
		else
			trace("Loaded DLC03 Quests")
		endif

		DLC03AcadiaGenericNPCFaction = Game.GetFormFromFile(0x0104F110,PluginName) As Faction
		if !DLC03AcadiaGenericNPCFaction
			trace("Unable To Load DLC03AcadiaGenericNPCFaction")
			issue = True
		else
			trace("Loaded DLC03 Factions")
		endif
		
		DLC03_COMOldLongfellowTalk_Greeting = Game.GetFormFromFile(0x0101537E,PluginName) As Topic
		DLC03_COMOldLongfellow_Greeting = Game.GetFormFromFile(0x01012F2F,PluginName) As Topic
		; DLC03_COMOldLongfellow_Agree = Game.GetFormFromFile(0x0100F125,PluginName) As Topic
		; DLC03_COMOldLongfellow_Trade = Game.GetFormFromFile(0x0100F11F,PluginName) As Topic

		if (!DLC03_COMOldLongfellowTalk_Greeting || !DLC03_COMOldLongfellow_Greeting)
			trace("Unable To Load DLC03_COMOldLongfellowTalk_Greeting or DLC03_COMOldLongfellow_Greeting")
			issue = True
		else
			trace("Loaded DLC03 Topics")
		endif
		
		DLC03OldLongfellowOutfit = Game.GetFormFromFile(0x01048ED9,PluginName) As Outfit
		
		if (!DLC03OldLongfellowOutfit)
			trace("Unable To Load DLC03OldLongfellowOutfit")
			issue = True
		else
			trace("Loaded DLC03OldLongfellowOutfit")
		endif
		
		OldLongfellowBase = Game.GetFormFromFile(0x01006E5B,PluginName) As ActorBase
		DiMABase          = Game.GetFormFromFile(0x01004639,PluginName) As ActorBase
		KasumiNakanoBase  = Game.GetFormFromFile(0x01003ECA,PluginName) As ActorBase

		if OldLongfellowBase
			trace("Loaded DLC03 OldLongfellow ActorBase")
			OldLongfellow = OldLongfellowBase.GetUniqueActor()
		else
			trace("Unable To Load OldLongfellow ActorBase")
			issue = True
		endif
		
		if DiMABase
			trace("Loaded DLC03 DiMA ActorBase")
			DiMA = DiMABase.GetUniqueActor()
		else
			trace("Unable To Load DiMA ActorBase")
			issue = True
		endif
		
		if KasumiNakanoBase
			trace("Loaded DLC03 KasumiNakano ActorBase")
			KasumiNakano = KasumiNakanoBase.GetUniqueActor()
		else
			trace("Unable To Load KasumiNakano ActorBase")
			issue = True
		endif
		
		if !OldLongfellow
			; Backup
			ReferenceAlias LongfellowREF = None
			if DLC03MQ02
				LongfellowREF = DLC03MQ02.GetAlias(3) As ReferenceAlias
				if LongfellowREF
					OldLongfellow = LongfellowREF.GetActorReference()
				endif
			endif
		endif
		
		if !DiMA
			; Backup
			ReferenceAlias DimaREF = None
			if DLC03MQ03
				DimaREF = DLC03MQ03.GetAlias(0) As ReferenceAlias
				if DimaREF
					DiMA = DimaREF.GetActorReference()
				endif
				if (!DiMA && DLC03MQ05)
					DimaREF = DLC03MQ05.GetAlias(3) As ReferenceAlias
					if DimaREF
						DiMA = DimaREF.GetActorReference()
					endif
					if (!DiMA && DLC03MQ06)
						DimaREF = DLC03MQ06.GetAlias(33) As ReferenceAlias
						if DimaREF
							DiMA = DimaREF.GetActorReference()
						endif
					endif
				endif
			endif
		endif
		
		if !KasumiNakano
			; Backup
			ReferenceAlias KasumiREF = None
			if DLC03MQ03
				KasumiREF = DLC03MQ03.GetAlias(1) As ReferenceAlias
				if KasumiREF
					KasumiNakano = KasumiREF.GetActorReference()
				endif
				if (!KasumiNakano && DLC03MQ05)
					KasumiREF = DLC03MQ05.GetAlias(4) As ReferenceAlias
					if KasumiREF
						KasumiNakano = KasumiREF.GetActorReference()
					endif
					if (!KasumiNakano && DLC03MQPostQuest)
						KasumiREF = DLC03MQPostQuest.GetAlias(0) As ReferenceAlias
						if KasumiREF
							KasumiNakano = KasumiREF.GetActorReference()
						endif
					endif
				endif
			endif
		endif
		
		If OldLongfellow
			trace("Loaded DLC03 OldLongfellow Actor")
			DLC03_CompanionOldLongfellow.ForceRefTo(OldLongfellow)
		else
			trace("Unable To Fill DLC03_CompanionOldLongfellow Reference Alias")
			issue = True			
		endif
		
		If DiMA
			trace("Loaded DLC03 DiMA Actor")
			DLC03DiMA.ForceRefTo(DiMA)
		else
			trace("Unable To Fill DLC03DiMA Reference Alias")
			issue = True			
		endif
				
		If KasumiNakano
			trace("Loaded DLC03 KasumiNakano Actor")
			DLC03KasumiNakano.ForceRefTo(KasumiNakano)
		else
			trace("Unable To Fill DLC03KasumiNakano Reference Alias")
			issue = True			
		endif

		FarHarborWorldLocation  = Game.GetFormFromFile(0x01020168,PluginName) As Location
		RedDeathIslandLocation  = Game.GetFormFromFile(0x01048AC1,PluginName) As Location
		VRLocation              = Game.GetFormFromFile(0x0100750E,PluginName) As Location
		LongfellowCabinLocation = Game.GetFormFromFile(0x01020649,PluginName) As Location
		
		if FarHarborWorldLocation
			trace("Loaded DLC03FarHarborWorldLocation")
			DLC03FarHarborWorldLocation.ForceLocationTo(FarHarborWorldLocation)
		else
			trace("Unable To Load FarHarborWorldLocation Location")
			issue = True			
		endif
		if RedDeathIslandLocation
			trace("Loaded DLC03RedDeathIslandLocation")
			DLC03RedDeathIslandLocation.ForceLocationTo(RedDeathIslandLocation)
		else
			trace("Unable To Load RedDeathIslandLocation Location")
			issue = True			
		endif
		if VRLocation
			trace("Loaded DLC03VRLocation")
			DLC03VRLocation.ForceLocationTo(VRLocation)
		else
			trace("Unable To Load VRLocation Location")
			issue = True			
		endif
		if LongfellowCabinLocation
			trace("Loaded DLC03LongfellowsCabinLocation")
			DLC03LongfellowsCabinLocation.ForceLocationTo(LongfellowCabinLocation)
		else
			trace("Unable To Load LongfellowCabinLocation Location")
			issue = True			
		endif
		
		if !DLC03LongfellowCabinRef
			if DLC03VisitLongFellowsCabin
				ReferenceAlias CabinMarker = DLC03VisitLongFellowsCabin.GetAlias(1) As ReferenceAlias
				if CabinMarker
					DLC03LongfellowCabinRef = CabinMarker.GetReference()
				endif
			endif
		endif
		if !DLC03LongfellowCabinRef
			issue = true
		endif

		if (issue)
			Trace("AFT Message : Some DLC03 (Far Harbor) Resources Failed to Import. Compatibility issues likely.")
		endif
				
		if (!Installed)
			Trace("AFT Message : Performing 1st time install tasks...")
			Installed = true
		endif
				
	elseIf (Installed)
		Trace("AFT Message : AFT Unloading DLC03 (Far Harbor) resources...")
		AllToNone()
	endIf
	center = None
	
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
	if (0 == SettlementLookup.length)
		initialize_SettlementData()
	endif
	return SettlementLookup[lookupindex].name
EndFunction

float Function GetLocationRadius(int lookupindex)
	if (0 == SettlementLookup.length)
		initialize_SettlementData()
	endif
	return SettlementLookup[lookupindex].bs_radius
EndFunction

float Function GetLocationCenterX(int lookupindex)
	if (0 == SettlementLookup.length)
		initialize_SettlementData()
	endif
	return SettlementLookup[lookupindex].bs_x
EndFunction

float Function GetLocationCenterY(int lookupindex)
	if (0 == SettlementLookup.length)
		initialize_SettlementData()
	endif
	return SettlementLookup[lookupindex].bs_y
EndFunction

float Function GetLocationCenterZ(int lookupindex)
	if (0 == SettlementLookup.length)
		initialize_SettlementData()
	endif
	return SettlementLookup[lookupindex].bs_z
EndFunction

Function initialize_SettlementData()

	; Data pulled from WOrldObjects/Static/DLC/Workshop/*Border
	; (Provides map coordinates of border objects) (Use Info, Dbl click 
	; on instance, Edit to get coordinate values from map editor)
	;
    ; Then use NifScope to extract bounding sphere information
	; and its offset (bs offset = bounding sphere offset). People 
	; tend to put walls and turrets on the borders. A sphere may not 
	; include these items if they go too high, which is why we add a 
	; minimum buffer of 450 to all radiuses to ensure those 
	; on-the-border turrents are included in clearing operations. 
	
	allocate_SettlementLookup(4)
	
    SettlementLookup[0].name      = "DaltonFarm"
    SettlementLookup[0].locid      =  0x00038EAE
	;        CK map coords +  nifscope bounding sphere offsets
    SettlementLookup[0].bs_x       = 3525.96    + 287.55
    SettlementLookup[0].bs_y       = 60151.32   + 1212.52
    SettlementLookup[0].bs_z       = 2008.00    - 1193.21
	;                                ~bs radius +  extra
    SettlementLookup[0].bs_radius  =  5640      +  450
	
    SettlementLookup[1].name      = "EchoLake"
    SettlementLookup[1].locid      =  0x0000F101
	;                                 actual    +  bs offset
    SettlementLookup[1].bs_x       = -21472.48  - 210.76
    SettlementLookup[1].bs_y       = 4976.51    - 497.91
    SettlementLookup[1].bs_z       = 1949.51    - 995.65
    SettlementLookup[1].bs_radius  = 4530       + 450	

    SettlementLookup[2].name      = "LongfellowsCabin"
    SettlementLookup[2].locid      =  0x00020649
	
	;SettlementLookup[2].bs_x       =  54021.2305 + 281.912109
	;SettlementLookup[2].bs_y       =  43289.2227 - 245.979492
	;SettlementLookup[2].bs_z       =  2282.4268  - 1526.252808
	;SettlementLookup[2].bs_radius  =  6760
	
	;                                 actual   +  bs offset
    SettlementLookup[2].bs_x       =  54320.72  +  0.00
    SettlementLookup[2].bs_y       =  41387.07  +  0.00
    SettlementLookup[2].bs_z       =  0.00      +  0.00
    SettlementLookup[2].bs_radius  =  5750      +  1000	

    SettlementLookup[3].name      = "NationalPark"
    SettlementLookup[3].locid      =  0x00009353

	;                                 actual   +  bs offset
    SettlementLookup[3].bs_x       =  25113.85 -  39.22
    SettlementLookup[3].bs_y       =  46918.24 - 258.82
    SettlementLookup[3].bs_z       =  2803.51  - 902.94
    SettlementLookup[3].bs_radius  =  4755     +  450	
	
		
	
EndFunction

Function allocate_SettlementLookup(int len)

	; When you have an array of structs, you must still 
	; allocate each individual struct....
	
	SettlementLookup = new SettlementDataDLC03[len]
	int i = 0
	while (i < len)
		SettlementLookup[i] = new SettlementDataDLC03
		i += 1
	endWhile
EndFunction

Function Scan(ObjectReference p_center, float p_radius)
	Trace("Scan Called")
	; Early Bail if current location is not part of DLC:	
	if (GetPluginID(p_center.GetCurrentLocation().GetFormID()) != resourceID)
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

	Trace("OnTimer [" + aiTimerID + "]")
	CancelTimer(aiTimerID)
	if (SCAN_OBJECTS == aiTimerID)
		Trace("SCAN_OBJECTS Detected")
		ScanHelper()
		return
	else
		Trace("Not SCAN_OBJECTS[" + SCAN_OBJECTS + "]")
	endif
	
EndEvent

; Notes: Modulous unreliable on values greater than 0x80000000
Function ScanHelper()
	Trace("ScanHelper Called. Scanning...")
	
	prepare_ScrapData()
	int lenA = ScrapDataA.length
	int lenB = ScrapDataB.length
	int lenC = ScrapDataC.length
	if 0 == (lenA + lenB + lenC)
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
	
	; common conditions
	bool scrapall            = (pTweakScrapAll.GetValue()       == 1.0)
	bool snapshot            = (pTweakSettlementSnap.GetValue() == 1.0)
	
	; tracking
	int lookupsuccess = 0
	int[] scrapresults = new int[31]		
	int	s = 0
	while (s < 31)
		scrapresults[s] = 0
		s += 1
	endwhile

	; local reused
	ObjectReference[] results
	ObjectReference   result
	int numresults = 0
	int lookupindex   = 0
	ScrapDataDLC03 lookup
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
	
	int i = 0
	int nextcheck = 30

	if (0 != lenA)
	
		trace("Updating TweakScrapScan_DLC03 with ScrapDataA")
		TweakScrapScan_DLC03.Revert()
		
		i = 0
		while (i < lenA)
			Form item = Game.GetFormFromFile(ScrapDataA[i].formid,PluginName)
			if item
				trace("- Adding [" + ScrapDataA[i].name + "]")
				TweakScrapScan_DLC03.AddForm(item)
			else
				trace("- [" + ScrapDataA[i].name + "] not found")
			endif
			i += 1
		endwhile
	
		Trace("Scanning...")

		results = center.FindAllReferencesOfType(TweakScrapScan_DLC03, radius)			
		numresults = results.length
	
		Trace("Scanning Complete: [" + numresults + "] objects found")
		TweakScrapScan_DLC03.Revert()
	
		if (0 != numresults)
		
			i = 0
			nextcheck = 30
									
			while (i != numresults && keepgoing)
				result = results[i]
				if scrapall
					result.SetPosition(0,0,0)
					result.Disable()
					result.Delete()
				elseif (!result.IsDisabled())
					rbase = result.GetBaseObject()
					; The fact that we are in this branch means that resourceID is greater then 0x80. 
					rid   = rbase.GetFormID()
					if rid > 0x80000000
						rid = rid - 0x80000000
					endif
					rid = rid % 0x01000000
					lookupindex = ScrapDataA.FindStruct("formid",rid)
					if (lookupindex > -1)
						lookup = ScrapDataA[lookupindex]
						lookupsuccess += 1
						if snapshot				
							params[0] = lookup.name
							params[1] = ((-0x03000000) - rid)  ; ResourceID -0x03 tells AFT it is DLOC03 object.
							params[2] = result.GetPositionX()
							params[3] = result.GetPositionY()
							params[4] = result.GetPositionZ()
							params[5] = result.GetAngleX()
							params[6] = result.GetAngleY()
							params[7] = result.GetAngleZ()
							params[8] = result.GetScale()
							; params[9] = -1
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

		endIf
	endIf
	ScrapDataA.Clear()
		
	if (keepgoing && (0 != lenB))
	
		trace("Updating TweakScrapScan_DLC03 with ScrapDataB")
		TweakScrapScan_DLC03.Revert()
		
		i = 0
		while (i < lenB)
			Form item = Game.GetFormFromFile(ScrapDataB[i].formid,PluginName)
			if item
				trace("- Adding [" + ScrapDataB[i].name + "]")
				TweakScrapScan_DLC03.AddForm(item)
			else
				trace("- [" + ScrapDataB[i].name + "] not found")
			endif
			i += 1
		endwhile
	
		Trace("Scanning...")

		results = center.FindAllReferencesOfType(TweakScrapScan_DLC03, radius)			
		numresults = results.length
	
		Trace("Scanning Complete: [" + numresults + "] objects found")
		TweakScrapScan_DLC03.Revert()
	
		if (0 != numresults)
		
			i = 0
			nextcheck = 30
			
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
					lookupindex = ScrapDataB.FindStruct("formid",rid)
					if (lookupindex > -1)
						lookup = ScrapDataB[lookupindex]
						lookupsuccess += 1
						if snapshot				
							params[0] = lookup.name
							params[1] = ((-0x03000000) - rid)  ; ResourceID -0x03 tells AFT it is DLOC03 object.
							params[2] = result.GetPositionX()
							params[3] = result.GetPositionY()
							params[4] = result.GetPositionZ()
							params[5] = result.GetAngleX()
							params[6] = result.GetAngleY()
							params[7] = result.GetAngleZ()
							params[8] = result.GetScale()
							; params[9] = -1
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
		endIf
	endIf
	ScrapDataB.Clear()

	if (keepgoing && (0 != lenC))
	
		trace("Updating TweakScrapScan_DLC03 with ScrapDataC")
		TweakScrapScan_DLC03.Revert()
		
		i = 0
		Trace("Using slow (60/sec) form lookup method for ScrapDataC")
		while (i < lenC)
			Form item = Game.GetFormFromFile(ScrapDataC[i].formid,PluginName)
			if item
				trace("- Adding [" + ScrapDataC[i].name + "]")
				TweakScrapScan_DLC03.AddForm(item)
			else
				trace("- [" + ScrapDataC[i].name + "] not found")
			endif
			i += 1
		endwhile
	
		Trace("Scanning...")

		results = center.FindAllReferencesOfType(TweakScrapScan_DLC03, radius)			
		numresults = results.length
	
		Trace("Scanning Complete: [" + numresults + "] objects found")
		TweakScrapScan_DLC03.Revert()
	
		if (0 != numresults)
		
			i = 0
			nextcheck = 30
			
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
					lookupindex = ScrapDataC.FindStruct("formid",rid)
					if (lookupindex > -1)
						lookup = ScrapDataC[lookupindex]
						lookupsuccess += 1
						if snapshot				
							params[0] = lookup.name
							params[1] = ((-0x03000000) - rid)  ; ResourceID -0x03 tells AFT it is DLOC03 object.
							params[2] = result.GetPositionX()
							params[3] = result.GetPositionY()
							params[4] = result.GetPositionZ()
							params[5] = result.GetAngleX()
							params[6] = result.GetAngleY()
							params[7] = result.GetAngleZ()
							params[8] = result.GetScale()
							; params[9] = -1
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
		endIf
	endIf	
	ScrapDataC.Clear()
	
	if (0 != lookupsuccess)
		Trace("Updating Results")
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
	pTweakScanThreadsDone.mod(-1.0)
	center = None
	Trace("Finished")
		
EndFunction

Function prepare_ScrapData()

	trace("prepare_ScrapData")

	ScrapDataA.clear()
	ScrapDataB.clear()
	ScrapDataC.clear()
	
	; ----------------------
	; calculate
	; ----------------------
	bool scrapall            = (pTweakScrapAll.GetValue()       == 1.0)
	bool snapshot            = (pTweakSettlementSnap.GetValue() == 1.0)
	bool includeCreatable    = (pTweakOptionsScanC.GetValue()   == 1.0)
	bool includeNonCreatable = (pTweakOptionsScanNC.GetValue()  == 1.0)
	
;	bool c_include_turrets   = (pTweakOptionsScanC_ExTurrets.GetValue() == 0.0)
;	bool c_include_fences    = (pTweakOptionsScanC_ExFences.GetValue() == 0.0)
	bool c_include_walls     = (pTweakOptionsScanC_ExWalls.GetValue() == 0.0)
	bool c_include_floors    = (pTweakOptionsScanC_ExFloors.GetValue() == 0.0)
; 	bool c_include_benches   = (pTweakOptionsScanC_ExBenches.GetValue() == 0.0)
;	bool c_include_shops	 = (pTweakOptionsScanC_ExShops.GetValue() == 0.0)
;	bool c_include_conts	 = (pTweakOptionsScanC_ExCont.GetValue() == 0.0)
;   bool c_include_food		 = (pTweakOptionsScanC_ExFood.GetValue() == 0.0)
	bool c_include_therest	 = (pTweakOptionsScanC_IncTheRest.GetValue() == 1.0)

	bool nc_include_conts    = (pTweakOptionsScanNC_ExCont.GetValue() == 0.0)
	bool nc_include_living   = (pTweakOptionsScanNC_ExLiving.GetValue() == 0.0)
	bool nc_include_food     = (pTweakOptionsScanNC_ExFood.GetValue() == 0.0)
	bool nc_include_misc     = (pTweakOptionsScanNC_ExMisc.GetValue() == 0.0)
	bool nc_include_therest  = (pTweakOptionsScanNC_IncTheRest.GetValue() == 1.0)
	
	int  expectedA = 0
	int  expectedB = 0
	int  expectedC = 0
	
	if (includeCreatable == 1.0 || snapshot || scrapall)
		expectedA += 126
	else
;		if (c_include_turrets)
;			expected += 0
;		endif
;		if (c_include_fences)
;			expected += 0
;		endif
		if (c_include_walls)
			expectedA += 44
		endif
		if (c_include_floors)
			expectedA += 40
		endif
;		if (c_include_benches)
;			expected += 1
;		endif
;		if (c_include_shops)
;			expected += 0
;		endIf
;		if (c_include_conts)
;			expected += 0
;		endIf
;		if (c_include_food)
;			expected += 0
;		endIf
		if (c_include_therest)
			expectedA += 42
		endIf
	endif

	if (includeNonCreatable || snapshot || scrapall)
		expectedB += 104
		expectedC += 101
	else
		if (nc_include_conts)
			expectedB += 3
		endIf
		if (nc_include_living)
			expectedB += 39
		endIf
		if (nc_include_food)
			expectedB += 2
		endIf
		if (nc_include_misc)
			expectedC += 101
		endIf
		if (nc_include_therest)
			expectedB += 60
		endIf
	endIf

	if (0 == (expectedA + expectedB + expectedC))
		trace("No Expected Results. Bailing.")
		return		
	endIf
	
	; ----------------------
	; Allocate
	; ----------------------
	if (0 != expectedA)
		ScrapDataA = new ScrapDataDLC03[expectedA]
		int i = 0
		while (i < expectedA)
			ScrapDataA[i] = new ScrapDataDLC03
			i += 1
		endWhile
	endif
	if (0 != expectedB)
		ScrapDataB = new ScrapDataDLC03[expectedB]
		int i = 0
		while (i < expectedB)
			ScrapDataB[i] = new ScrapDataDLC03
			i += 1
		endWhile
	endif
	if (0 != expectedC)
		ScrapDataC = new ScrapDataDLC03[expectedC]
		int i = 0
		while (i < expectedC)
			ScrapDataC[i] = new ScrapDataDLC03
			i += 1
		endWhile
	endif
	
	; ----------------------
	; Populate
	; ----------------------
	int a = 0
	int b = 0
	int c = 0

	if (includeCreatable == 1.0 || snapshot || scrapall)
		a = includeConstructableWalls(a)
		a = includeConstructableFloors(a)
		a = includeConstructableTheRest(a)
	else
;		if (c_include_turrets)
;		endif
;		if (c_include_fences)
;		endif
		if (c_include_walls)
			a = includeConstructableWalls(a)
		endif
		if (c_include_floors)
			a = includeConstructableFloors(a)
		endif
;		if (c_include_benches)
;		endif
;		if (c_include_shops)
;		endIf
;		if (c_include_conts)
;		endIf
;		if (c_include_food)
;		endIf
		if (c_include_therest)
			a = includeConstructableTheRest(a)
		endIf
	endif
	
	if (includeNonCreatable || snapshot || scrapall)
		b = includeNonConstructableContainers(b) ; 3 total
		b = includeNonConstructableLiving(b) ; 39 total
		b = includeNonConstructableFood(b) ; 2 total
		c = includeNonConstructableMisc(c) ; 81 total
		b = includeNonConstructableTheRest(b) ; 60 total
	else
		if (nc_include_conts)
			b = includeNonConstructableContainers(b)
		endIf
		if (nc_include_living)
			b = includeNonConstructableLiving(b)
		endIf
		if (nc_include_food)
			b = includeNonConstructableFood(b)
		endIf
		if (nc_include_misc)
			c = includeNonConstructableMisc(c)
		endIf		
		if (nc_include_therest)
			b = includeNonConstructableTheRest(b)
		endif
	endIf

	if (a != expectedA)
		trace("Checksum Error: ExpectedA [" + expectedA + "] Created [" + a + "]")
	endIf
	if (b != expectedB)
		trace("Checksum Error: ExpectedB [" + expectedB + "] Created [" + b + "]")
	endIf
	if (c != expectedC)
		trace("Checksum Error: ExpectedC [" + expectedC + "] Created [" + c + "]")
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

int Function includeConstructableWalls(int a)
	ScrapDataA[a].name      = "Dlc03BarnDoorSm02" ; c_Wood:4
	ScrapDataA[a].formid    =  0x000566C3
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnDoorSm01" ; c_Wood:4
	ScrapDataA[a].formid    =  0x000566C2
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnDoorMed01" ; c_Wood:4
	ScrapDataA[a].formid    =  0x00054558
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnDoorMed01alt" ; c_Wood:4
	ScrapDataA[a].formid    =  0x00054559
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnDoorMed02" ; c_Wood:4
	ScrapDataA[a].formid    =  0x0005455A
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnDoorMed02alt" ; c_Wood:4
	ScrapDataA[a].formid    =  0x0005455B
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallHalfPrefCorA01" ; c_Glass:4 c_Wood:10
	ScrapDataA[a].formid    =  0x00054560
	ScrapDataA[a].mask		=  130
	ScrapDataA[a].counts	=  266
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallHalfPrefCorA02" ; c_Glass:4 c_Wood:10
	ScrapDataA[a].formid    =  0x00054561
	ScrapDataA[a].mask		=  130
	ScrapDataA[a].counts	=  266
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallA01" ; c_Wood:8
	ScrapDataA[a].formid    =  0x00054591
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallA02" ; c_Wood:8
	ScrapDataA[a].formid    =  0x00054592
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallA03" ; c_Wood:8
	ScrapDataA[a].formid    =  0x000545A1
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallA04" ; c_Wood:8
	ScrapDataA[a].formid    =  0x00054593
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallB01" ; c_Wood:8
	ScrapDataA[a].formid    =  0x00054594
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallB02" ; c_Wood:8
	ScrapDataA[a].formid    =  0x00054595
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallD01" ; c_Wood:8
	ScrapDataA[a].formid    =  0x0005455C
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallD02" ; c_Wood:8
	ScrapDataA[a].formid    =  0x0005455D
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallE01" ; c_Wood:8
	ScrapDataA[a].formid    =  0x0005455E
	ScrapDataA[a].mask		=  2  
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallE02" ; c_Wood:8
	ScrapDataA[a].formid    =  0x0005455F
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallTopA01" ; c_Wood:8
	ScrapDataA[a].formid    =  0x00054563
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallTopArchL01" ; c_Wood:8
	ScrapDataA[a].formid    =  0x00054564
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallTopArchR01" ; c_Wood:8
	ScrapDataA[a].formid    =  0x00054565
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallTopSlantL01" ; c_Wood:8
	ScrapDataA[a].formid    =  0x00054569
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallTopSlantR01" ; c_Wood:8
	ScrapDataA[a].formid    =  0x0005456B
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallTopSlantLFull01" ; c_Wood:8
	ScrapDataA[a].formid    =  0x0005456A
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallTopSlantRFull01" ; c_Wood:8
	ScrapDataA[a].formid    =  0x0005456C
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallTopFasciaL01" ; c_Wood:8
	ScrapDataA[a].formid    =  0x00054567
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallTopFasciaR01" ; c_Wood:8
	ScrapDataA[a].formid    =  0x00054568
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  8
	a += 1			
	ScrapDataA[a].name      = "Dlc03BarnWallC01" ; c_Wood:8 c_Glass:4
	ScrapDataA[a].formid    =  0x00054596
	ScrapDataA[a].mask		=  130
	ScrapDataA[a].counts	=  264
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallC02" ; c_Wood:8 c_Glass:4
	ScrapDataA[a].formid    =  0x00054597
	ScrapDataA[a].mask		=  130
	ScrapDataA[a].counts	=  264
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallC03" ; c_Wood:8 c_Glass:4
	ScrapDataA[a].formid    =  0x00054598
	ScrapDataA[a].mask		=  130
	ScrapDataA[a].counts	=  264
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallTopB01" ; c_Wood:8 c_Glass:4
	ScrapDataA[a].formid    =  0x00054566
	ScrapDataA[a].mask		=  130
	ScrapDataA[a].counts	=  264
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallF01" ; c_Wood:8 c_Glass:2
	ScrapDataA[a].formid    =  0x0005459A
	ScrapDataA[a].mask		=  130
	ScrapDataA[a].counts	=  136
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallF02" ; c_Wood:8 c_Glass:2
	ScrapDataA[a].formid    =  0x0005459B
	ScrapDataA[a].mask		=  130
	ScrapDataA[a].counts	=  136
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallC04" ; c_Wood:8 c_Glass:2
	ScrapDataA[a].formid    =  0x00054599
	ScrapDataA[a].mask		=  130
	ScrapDataA[a].counts	=  136
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnWallTopC01" ; c_Wood:8 c_Glass:2
	ScrapDataA[a].formid    =  0x000545A4
	ScrapDataA[a].mask		=  130
	ScrapDataA[a].counts	=  136
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnPost02" ; c_Wood:2
	ScrapDataA[a].formid    =  0x0005D70B
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  2
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnPost01" ; c_Wood:3
	ScrapDataA[a].formid    =  0x00054576
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnOuthouseA01" ; c_Wood:6 c_Concrete:2
	ScrapDataA[a].formid    =  0x0005459C
	ScrapDataA[a].mask		=  2050
	ScrapDataA[a].counts	=  134
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnOuthouseB01" ; c_Wood:6 c_Concrete:2
	ScrapDataA[a].formid    =  0x0005459F
	ScrapDataA[a].mask		=  2050
	ScrapDataA[a].counts	=  134
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnOuthouseA02" ; c_Wood:6 c_Concrete:2
	ScrapDataA[a].formid    =  0x0005459D
	ScrapDataA[a].mask		=  2050
	ScrapDataA[a].counts	=  134
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnOuthouseB02" ; c_Wood:6 c_Concrete:2
	ScrapDataA[a].formid    =  0x0005459E
	ScrapDataA[a].mask		=  2050
	ScrapDataA[a].counts	=  134
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnOuthouseChair01" ; c_Wood:4
	ScrapDataA[a].formid    =  0x000545A0
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnOuthouseDoor01" ; c_Wood:4
	ScrapDataA[a].formid    =  0x000545A3
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnOuthouseDoor02" ; c_Wood:4
	ScrapDataA[a].formid    =  0x000545A2
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  4
	a += 1
	return a
EndFunction

int Function includeConstructableFloors(int a)
	ScrapDataA[a].name      = "Dlc03BarnFloorWood01" ; c_Wood:6
	ScrapDataA[a].formid    =  0x00054573
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnFloorWoodHalf01" ; c_Wood:6
	ScrapDataA[a].formid    =  0x00054574
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnFloorWoodSmSq01" ; c_Wood:6
	ScrapDataA[a].formid    =  0x00054575
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnFloorSlate01" ; c_Concrete:8
	ScrapDataA[a].formid    =  0x00054572
	ScrapDataA[a].mask		=  2048 
	ScrapDataA[a].counts	=  8
	a += 1	
	ScrapDataA[a].name      = "Dlc03BarnFloorMeshFull01" ; c_Steel:3 c_Wood:4
	ScrapDataA[a].formid    =  0x00054570
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  259
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnFloorMesh01" ; c_Steel:3 c_Wood:4
	ScrapDataA[a].formid    =  0x00054557
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  259
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnFloorMesh02" ; c_Steel:3 c_Wood:4
	ScrapDataA[a].formid    =  0x0005456D
	ScrapDataA[a].mask		=  3 
	ScrapDataA[a].counts	=  259
	a += 1 
	ScrapDataA[a].name      = "Dlc03BarnFloorMesh03" ; c_Steel:3 c_Wood:4
	ScrapDataA[a].formid    =  0x0005456E
	ScrapDataA[a].mask		=  3 
	ScrapDataA[a].counts	=  259
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnFloorMesh04" ; c_Steel:3 c_Wood:4
	ScrapDataA[a].formid    =  0x0005456F
	ScrapDataA[a].mask		=  3 
	ScrapDataA[a].counts	=  259
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnFloorMeshSmSq01" ; c_Steel:3 c_Wood:4
	ScrapDataA[a].formid    =  0x00054571
	ScrapDataA[a].mask		=  3 
	ScrapDataA[a].counts	=  259
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofCupola01" ; c_Glass:2 c_Steel:2 c_Wood:5
	ScrapDataA[a].formid    =  0x00054581
	ScrapDataA[a].mask		=  131
	ScrapDataA[a].counts	=  8514
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofPrefC01" ; c_Wood:12
	ScrapDataA[a].formid    =  0x0005458A
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  12
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofPrefC02" ; c_Wood:12
	ScrapDataA[a].formid    =  0x0005458B
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  12
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofPrefD01" ; c_Glass:3 c_Wood:12
	ScrapDataA[a].formid    =  0x000545A5
	ScrapDataA[a].mask		=  130
	ScrapDataA[a].counts	=  204
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofPrefA01" ; c_Glass:3 c_Wood:12
	ScrapDataA[a].formid    =  0x00054588
	ScrapDataA[a].mask		=  130
	ScrapDataA[a].counts	=  204
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofPrefB01" ; c_Glass:3 c_Wood:12
	ScrapDataA[a].formid    =  0x00054589
	ScrapDataA[a].mask		=  130
	ScrapDataA[a].counts	=  204
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofPrefD02"  ; c_Glass:3 c_Wood:12
	ScrapDataA[a].formid    =  0x000545A6
	ScrapDataA[a].mask		=  130
	ScrapDataA[a].counts	=  204
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofPlatB01" ; c_Steel:3 c_Wood:4
	ScrapDataA[a].formid    =  0x00054586
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  259
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofPlatBCorIn01" ; c_Steel:3 c_Wood:4
	ScrapDataA[a].formid    =  0x00054587
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  259
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofA01" ; c_Wood:6
	ScrapDataA[a].formid    =  0x00054578
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofA02"  ; c_Wood:6
	ScrapDataA[a].formid    =  0x00054579
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofA03" ; c_Wood:6
	ScrapDataA[a].formid    =  0x0005457A
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofB01" ; c_Wood:6
	ScrapDataA[a].formid    =  0x0005457B
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofB02" ; c_Wood:6
	ScrapDataA[a].formid    =  0x0005457C
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofB03" ; c_Wood:6
	ScrapDataA[a].formid    =  0x0005457D
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofCorIn01" ; c_Wood:6
	ScrapDataA[a].formid    =  0x00054580
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofFlatA01" ; c_Wood:6
	ScrapDataA[a].formid    =  0x00054582
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofFlatB01"  ; c_Wood:6
	ScrapDataA[a].formid    =  0x00054583
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofCap01" ; c_Wood:6
	ScrapDataA[a].formid    =  0x0005457E
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofTwinPeakA01" ; c_Wood:6
	ScrapDataA[a].formid    =  0x0005458C
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofTwinPeakB01" ; c_Wood:6
	ScrapDataA[a].formid    =  0x0005458D
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofTwinPeakC01" ; c_Wood:6
	ScrapDataA[a].formid    =  0x0005458E
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofTwinPeakD01" ; c_Wood:6
	ScrapDataA[a].formid    =  0x0005D6B0
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofTwinPeakE01" ; c_Wood:6
	ScrapDataA[a].formid    =  0x0005D6B1
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofTwinPeakF01" ; c_Wood:6
	ScrapDataA[a].formid    =  0x0005D6B2
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofTwinPeakG01" ; c_Wood:6
	ScrapDataA[a].formid    =  0x0005D6B3
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofPlatA01" ; c_Wood:6
	ScrapDataA[a].formid    =  0x00054584
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnRoofPlatACorIn01" ; c_Wood:6
	ScrapDataA[a].formid    =  0x00054585
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  6			
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnStairs01"  ; c_Steel:5
	ScrapDataA[a].formid    =  0x0005458F
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  5		
	a += 1
	ScrapDataA[a].name      = "Dlc03BarnStairs02" ; c_Steel:5
	ScrapDataA[a].formid    =  0x00054590
	ScrapDataA[a].mask		=  1 
	ScrapDataA[a].counts	=  5		
	a += 1
	return a
endFunction

int Function includeConstructableTheRest(int a)
	; FormList: DLC03BannersChildrenofAtom (Decorations)
	ScrapDataA[a].name      = "DLC03WorkshopCOABanner01"  ; c_Cloth:4 c_Wood:2
	ScrapDataA[a].formid    =  0x00054543
	ScrapDataA[a].mask		=  10
	ScrapDataA[a].counts	=  258
	a += 1
	ScrapDataA[a].name      = "DLC03WorkshopCOABanner02"  ; c_Cloth:4 c_Wood:2
	ScrapDataA[a].formid    =  0x00054544
	ScrapDataA[a].mask		=  10
	ScrapDataA[a].counts	=  258
	a += 1
	ScrapDataA[a].name      = "DLC03WorkshopCOABanner03" ; c_Cloth:4 c_Wood:2
	ScrapDataA[a].formid    =  0x00054545
	ScrapDataA[a].mask		=  10
	ScrapDataA[a].counts	=  258			
	a += 1
	ScrapDataA[a].name      = "DLC03WorkshopCOABanner04" ; c_Cloth:4 c_Wood:2
	ScrapDataA[a].formid    =  0x00054546
	ScrapDataA[a].mask		=  10
	ScrapDataA[a].counts	=  258		
	a += 1
	ScrapDataA[a].name      = "DLC03WorkshopCOABanner05" ; c_Cloth:4 c_Wood:2
	ScrapDataA[a].formid    =  0x00054547
	ScrapDataA[a].mask		=  10
	ScrapDataA[a].counts	=  258		
	a += 1
	; FormList: DLC03EchoLakeGenericSigns (Decorations) 
	ScrapDataA[a].name      = "DLC03WorkshopSignEchoLumberLake_Gen01" ; c_Wood:2
	ScrapDataA[a].formid    =  0x00054552
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  2			
	a += 1
	ScrapDataA[a].name      = "DLC03WorkshopSignEchoLumberLake_Gen02"  ; c_Wood:2
	ScrapDataA[a].formid    =  0x00054553
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  2			
	a += 1
	ScrapDataA[a].name      = "DLC03WorkshopSignEchoLumberLake_Gen03" ; c_Wood:2
	ScrapDataA[a].formid    =  0x00054554
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  2			
	a += 1
	ScrapDataA[a].name      = "DLC03WorkshopSignEchoLumberLake_Gen04" ; c_Wood:2
	ScrapDataA[a].formid    =  0x00054555
	ScrapDataA[a].mask		=  2 
	ScrapDataA[a].counts	=  2			
	a += 1
	ScrapDataA[a].name      = "DLC03WorkshopSignEchoLumberLake_Gen05" ; c_Wood:2
	ScrapDataA[a].formid    =  0x00054556
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  2			
	a += 1
	; FormList: DLC03Fishnetcrates (Decorations)
	ScrapDataA[a].name      = "FishNetFallenCrates02"  ; c_Cloth:4 c_Wood:8
	ScrapDataA[a].formid    =  0x000025EF
	ScrapDataA[a].mask		=  10
	ScrapDataA[a].counts	=  264			
	a += 1
	ScrapDataA[a].name      = "FishNetFallenCrates01"  ; c_Cloth:4 c_Wood:8
	ScrapDataA[a].formid    =  0x000025E1
	ScrapDataA[a].mask		=  10
	ScrapDataA[a].counts	=  264			
	a += 1
	; FormList: DLC03FishRackStandingShort (Furniture)
	ScrapDataA[a].name      = "FishRackStandingShort01"  ; c_Cloth:1 c_Steel:1 c_Wood:3
	ScrapDataA[a].formid    =  0x0000190C
	ScrapDataA[a].mask		=  11
	ScrapDataA[a].counts	=  4289			
	a += 1
	ScrapDataA[a].name      = "FishRackStandingShort01SCO1" ; c_Cloth:1 c_Steel:1 c_Wood:3
	ScrapDataA[a].formid    =  0x00002B79
	ScrapDataA[a].mask		=  11
	ScrapDataA[a].counts	=  4289			
	a += 1
	; FormList: DLC03FishRackStandingTall (Furniture)
	ScrapDataA[a].name      = "FishRackStandingTall01"   ; c_Cloth:2 c_Steel:3 c_Wood:4
	ScrapDataA[a].formid    =  0x0000190A
	ScrapDataA[a].mask		=  11
	ScrapDataA[a].counts	=  8451			
	a += 1
	ScrapDataA[a].name      = "FishRackStandingTall01SC01" ; c_Cloth:2 c_Steel:3 c_Wood:4
	ScrapDataA[a].formid    =  0x00002B7A
	ScrapDataA[a].mask		=  11
	ScrapDataA[a].counts	=  8451		
	a += 1
	; FormList: DLC03FishRackTableHalf (Furniture)
	ScrapDataA[a].name      = "FishRackTable01Half01"  ; c_Steel:2 c_Wood:4
	ScrapDataA[a].formid    =  0x000024EA
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  258			
	a += 1
	ScrapDataA[a].name      = "FishRackTable02Half01" ; c_Steel:2 c_Wood:4
	ScrapDataA[a].formid    =  0x000024E8
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  258			
	a += 1
	ScrapDataA[a].name      = "FishRackTable03Half01"  ; c_Steel:2 c_Wood:4
	ScrapDataA[a].formid    =  0x000024F3
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  258			
	a += 1
	; FormList: DLC03FishRackTableLong (Furniture)
	ScrapDataA[a].name      = "FishRackTable01Long01" ; c_Steel:3 c_Wood:6
	ScrapDataA[a].formid    =  0x000024E7
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  387
	a += 1
	ScrapDataA[a].name      = "FishRackTable02Long01" ; c_Steel:3 c_Wood:6
	ScrapDataA[a].formid    =  0x000024E9
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  387
	a += 1
	ScrapDataA[a].name      = "FishRackTable03Long01" ; c_Steel:3 c_Wood:6
	ScrapDataA[a].formid    =  0x000024F2
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  387
	a += 1
	; FormList: DLC03HangingBuoyCeiling (Decorations)
	ScrapDataA[a].name      = "BuoyHangHookLG01" ; c_Cork:2 c_Steel:1 c_Wood:2
	ScrapDataA[a].formid    =  0x0000160A
	ScrapDataA[a].mask		=  268435459
	ScrapDataA[a].counts	=  8321	
	a += 1
	ScrapDataA[a].name      = "BuoyHangHookMed01" ; c_Cork:2 c_Steel:1 c_Wood:2
	ScrapDataA[a].formid    =  0x00001609
	ScrapDataA[a].mask		=  268435459
	ScrapDataA[a].counts	=  8321
	a += 1
	; FormList: DLC03HangingBuoyWall (Decorations)
	ScrapDataA[a].name      = "BuoyRopeWall01" ; c_Cork:2 c_Steel:2 c_Wood:2
	ScrapDataA[a].formid    =  0x00001514
	ScrapDataA[a].mask		=  268435459
	ScrapDataA[a].counts	=  8321
	a += 1
	ScrapDataA[a].name      = "BuoyRopeWall01" ; c_Cork:2 c_Steel:2 c_Wood:2
	ScrapDataA[a].formid    =  0x00001511
	ScrapDataA[a].mask		=  268435459
	ScrapDataA[a].counts	=  8321
	a += 1
	ScrapDataA[a].name      = "BuoyRopeWall01" ; c_Cork:2 c_Steel:2 c_Wood:2
	ScrapDataA[a].formid    =  0x0000161E
	ScrapDataA[a].mask		=  268435459
	ScrapDataA[a].counts	=  8321
	a += 1
	ScrapDataA[a].name      = "BuoyRopeWall01" ; c_Cork:2 c_Steel:2 c_Wood:2
	ScrapDataA[a].formid    =  0x0000161F
	ScrapDataA[a].mask		=  268435459
	ScrapDataA[a].counts	=  8321
	a += 1
	ScrapDataA[a].name      = "BuoyRopeWall01" ; c_Cork:2 c_Steel:2 c_Wood:2
	ScrapDataA[a].formid    =  0x0000161D
	ScrapDataA[a].mask		=  268435459
	ScrapDataA[a].counts	=  8321
	a += 1
	ScrapDataA[a].name      = "BuoyWallClusterLG01" ; c_Cork:2 c_Steel:2 c_Wood:2
	ScrapDataA[a].formid    =  0x00001515
	ScrapDataA[a].mask		=  268435459
	ScrapDataA[a].counts	=  8321
	a += 1
	ScrapDataA[a].name      = "BuoyWallClusterMed02" ; c_Cork:2 c_Steel:2 c_Wood:2
	ScrapDataA[a].formid    =  0x0000191F
	ScrapDataA[a].mask		=  268435459
	ScrapDataA[a].counts	=  8321
	a += 1
	; FormList: DLC03LanternBottles (Decorations)
	; DLC03CoA_PlayerJoinedCoA = 1/ DLC03MQ06_NucleusDestroyed = 1
	ScrapDataA[a].name      = "DLC03WorkshopLanternBottle01" ; c_Glass:2 c_Steel:2
	ScrapDataA[a].formid    =  0x0005454A
	ScrapDataA[a].mask		=  129
	ScrapDataA[a].counts	=  130
	a += 1
	ScrapDataA[a].name      = "DLC03WorkshopLanternBottle02" ; c_Glass:2 c_Steel:2
	ScrapDataA[a].formid    =  0x0005454B
	ScrapDataA[a].mask		=  129
	ScrapDataA[a].counts	=  130			
	a += 1
	ScrapDataA[a].name      = "DLC03WorkshopLanternBottle03" ; c_Glass:2 c_Steel:2
	ScrapDataA[a].formid    =  0x0005454C
	ScrapDataA[a].mask		=  129
	ScrapDataA[a].counts	=  130		
	a += 1
	ScrapDataA[a].name      = "DLC03WorkshopLanternBottle04" ; c_Glass:2 c_Steel:2
	ScrapDataA[a].formid    =  0x0005454D
	ScrapDataA[a].mask		=  129
	ScrapDataA[a].counts	=  130		
	a += 1
	ScrapDataA[a].name      = "DLC03WorkshopLanternBottleHanging03" ; c_Glass:2 c_Steel:2
	ScrapDataA[a].formid    =  0x0005454E
	ScrapDataA[a].mask		=  129
	ScrapDataA[a].counts	=  130		
	a += 1
	ScrapDataA[a].name      = "DLC03WorkshopLanternBottleHanging06" ; c_Glass:2 c_Steel:2
	ScrapDataA[a].formid    =  0x0005454F
	ScrapDataA[a].mask		=  129
	ScrapDataA[a].counts	=  130		
	a += 1
	ScrapDataA[a].name      = "DLC03WorkshopLanternBulbHanging02" ; c_Glass:2 c_Steel:2
	ScrapDataA[a].formid    =  0x00054550
	ScrapDataA[a].mask		=  129
	ScrapDataA[a].counts	=  130		
	a += 1
	; Other
	ScrapDataA[a].name      = "DLC03_VimColaMachine" ; Furniture ; c_Plastic:2 c_Rubber:1 c_Steel:2
	ScrapDataA[a].formid    =  0x0000A2BF
	ScrapDataA[a].mask		=  21
	ScrapDataA[a].counts	=  8258
	a += 1
	ScrapDataA[a].name      = "DLC03FishBasket" ; Decorations ; c_Wood:2
	ScrapDataA[a].formid    =  0x0001AC44
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  2			
	a += 1
	ScrapDataA[a].name      = "DLC03LobsterCage01" ; Decorations ; c_Steel:2 c_Wood:3
	ScrapDataA[a].formid    =  0x0002C59C
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  194
	a += 1
	ScrapDataA[a].name      = "DLC03_PicnicGrill01" ; Decorations ; c_Rubber:2 c_Steel:4
	ScrapDataA[a].formid    =  0x00020198
	ScrapDataA[a].mask		=  5
	ScrapDataA[a].counts	=  132
	a += 1
	return a
EndFunction

int Function includeNonConstructableContainers(int b) ; 3 total
	; DLC03workshopscraprecipe_Hangingdeer 
	ScrapDataB[b].name      = "DLC03HangingDoeContainer" ; Container
	ScrapDataB[b].formid    =  0x00038EFA
	ScrapDataB[b].mask		=  0
	ScrapDataB[b].counts	=  0
	b += 1
	ScrapDataB[b].name      = "DLC03HangingBuckContainer" ; Container
	ScrapDataB[b].formid    =  0x00038EFB
	ScrapDataB[b].mask		=  0
	ScrapDataB[b].counts	=  0
	b += 1
	ScrapDataB[b].name      = "DLC03_TentContainer" ; c_Cloth:2 c_Steel:1
	ScrapDataB[b].formid    =  0x00049C39
	ScrapDataB[b].mask		=  9
	ScrapDataB[b].counts	=  129
	b += 1
	return b
endFunction

int Function includeNonConstructableLiving(int b) ; 39 total
	; DLC03workshopscraprecipe_GenLogs
	ScrapDataB[b].name      = "DLC03GenLogStraight01a" ; c_Wood:4
	ScrapDataB[b].formid    =  0x00023A9F
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "DLC03GenLogStraight01b" ; c_Wood:4
	ScrapDataB[b].formid    =  0x00023AA0
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "DLC03GenLogStraight02a" ; c_Wood:4
	ScrapDataB[b].formid    =  0x00023AA1
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "DLC03GenLogStraight02b" ; c_Wood:4
	ScrapDataB[b].formid    =  0x00023AA2
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "DLC03GenLogChopped01" ; c_Wood:4
	ScrapDataB[b].formid    =  0x00029426
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "DLC03GenLogDisk01" ; c_Wood:4
	ScrapDataB[b].formid    =  0x00029425
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "PierPostBuoySC01" ; c_Wood:4
	ScrapDataB[b].formid    =  0x00004026
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "PierPostBuoySC02" ; c_Wood:4
	ScrapDataB[b].formid    =  0x00004027
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "PierPostBuoySC03" ; c_Wood:4
	ScrapDataB[b].formid    =  0x00004025
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "PierPostBuoySC04" ; c_Wood:4
	ScrapDataB[b].formid    =  0x0000419E
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1
	; DLC03workshopscraprecipe_Trees
	ScrapDataB[b].name      = "TreeRedPineDead01" ; c_Wood:20
	ScrapDataB[b].formid    =  0x00001B5A
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  20
	b += 1
	ScrapDataB[b].name      = "TreeRedPineFull01" ; c_Wood:20
	ScrapDataB[b].formid    =  0x00001B58
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  20
	b += 1
	ScrapDataB[b].name      = "TreeRedPineHalf01" ; c_Wood:20
	ScrapDataB[b].formid    =  0x00001B59
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  20
	b += 1
	ScrapDataB[b].name      = "TreeRedPineHalf03" ; c_Wood:20
	ScrapDataB[b].formid    =  0x000024FB
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  20
	b += 1
	ScrapDataB[b].name      = "TreeRedPineStump01" ; c_Wood:20
	ScrapDataB[b].formid    =  0x00006C8A
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  20
	b += 1
	ScrapDataB[b].name      = "TreeRedPineStump02" ; c_Wood:20
	ScrapDataB[b].formid    =  0x00006C8C
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  20
	b += 1
	ScrapDataB[b].name      = "TreeRedPineDead02" ; c_Wood:20
	ScrapDataB[b].formid    =  0x000024FA
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  20
	b += 1
	ScrapDataB[b].name      = "TreeRedPineHalf02" ; c_Wood:20
	ScrapDataB[b].formid    =  0x000024F9
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  20
	b += 1
	ScrapDataB[b].name      = "TreeRedPineLog01" ; c_Wood:20
	ScrapDataB[b].formid    =  0x00006C88
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  20
	b += 1
	ScrapDataB[b].name      = "TreeRedPineFallen01" ; c_Wood:20
	ScrapDataB[b].formid    =  0x0000443D
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  20
	b += 1
	ScrapDataB[b].name      = "TreeRedPineFull02" ; c_Wood:20
	ScrapDataB[b].formid    =  0x00005434
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  20
	b += 1
	ScrapDataB[b].name      = "TreeBeachPine01" ; c_Wood:20
	ScrapDataB[b].formid    =  0x000024FC
	ScrapDataB[b].mask		=  2 
	ScrapDataB[b].counts	=  20
	b += 1
	ScrapDataB[b].name      = "TreeBeachPine02" ; c_Wood:20
	ScrapDataB[b].formid    =  0x000025A4
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  20
	b += 1
	ScrapDataB[b].name      = "TreeBeachPineLog01" ; c_Wood:20
	ScrapDataB[b].formid    =  0x000072E0
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  20
	b += 1
	ScrapDataB[b].name      = "TreeBeachPineStump01" ; c_Wood:20
	ScrapDataB[b].formid    =  0x000072DF
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  20
	b += 1
	ScrapDataB[b].name      = "TreePineSmall01" ; c_Wood:20     ; NOT FOUND....
	ScrapDataB[b].formid    =  0x00004F4C
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  20
	b += 1
	ScrapDataB[b].name      = "TreePineSmall02" ; c_Wood:20     ; NOT FOUND....
	ScrapDataB[b].formid    =  0x00004F4D
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  20
	b += 1
	ScrapDataB[b].name      = "TreePineSmall03" ; c_Wood:20
	ScrapDataB[b].formid    =  0x00004F4E
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  20
	b += 1
	ScrapDataB[b].name      = "TreePineSmall04" ; c_Wood:20
	ScrapDataB[b].formid    =  0x00005436
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  20
	b += 1
    ScrapDataB[b].name      = "TreeBeachPineSCCluster01_DLC03" ; c_Wood:40
    ScrapDataB[b].formid    =  0x00004F59
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  40
	b += 1
    ScrapDataB[b].name      = "TreeBeachPineSCCluster02_DLC03" ; c_Wood:40
    ScrapDataB[b].formid    =  0x00005CEF
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  40
	b += 1
    ScrapDataB[b].name      = "TreeBeachPineSCCluster03_DLC03" ; c_Wood:40
    ScrapDataB[b].formid    =  0x0000C44A
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  40
	b += 1
    ScrapDataB[b].name      = "TreeRedPineSCCluster01_DLC03" ; c_Wood:40
    ScrapDataB[b].formid    =  0x00003D04
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  40
	b += 1
    ScrapDataB[b].name      = "TreeRedPineSCCluster02_DLC03" ; c_Wood:40
    ScrapDataB[b].formid    =  0x00003D05
	ScrapDataB[b].mask		=  2 
	ScrapDataB[b].counts	=  40
	b += 1
    ScrapDataB[b].name      = "TreeRedPineSCCluster03_DLC03" ; c_Wood:40
    ScrapDataB[b].formid    =  0x00003D08
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  40
	b += 1
    ScrapDataB[b].name      = "TreeRedPineSCCluster04_DLC03" ; c_Wood:40
    ScrapDataB[b].formid    =  0x00003D0A
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  40
	b += 1
    ScrapDataB[b].name      = "TreeRedPineSCCluster05_DLC03" ; c_Wood:40
    ScrapDataB[b].formid    =  0x00004F56
	ScrapDataB[b].mask		=  2 
	ScrapDataB[b].counts	=  40
	b += 1
    ScrapDataB[b].name      = "TreeRedPineSCCluster06_DLC03" ; c_Wood:40
    ScrapDataB[b].formid    =  0x00005CF0
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  40
	b += 1
    ScrapDataB[b].name      = "TreeRedPineSCCluster07_DLC03" ; c_Wood:40
    ScrapDataB[b].formid    =  0x00005CF1
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  40
	b += 1	
	return b
endFunction

int Function includeNonConstructableFood(int b)
	ScrapDataB[b].name      = "FloraBloodLeaf01DLC03"
	ScrapDataB[b].formid    =  0x0001683E
	ScrapDataB[b].mask		=  0
	ScrapDataB[b].counts	=  0
	b += 1
	ScrapDataB[b].name      = "FloraBloodLeaf02DLC03"
	ScrapDataB[b].formid    =  0x00016842
	ScrapDataB[b].mask		=  0
	ScrapDataB[b].counts	=  0
	b += 1		
	return b
endFunction

int Function includeNonConstructableMisc(int c)
	; DLC03_workshopScrapRecipe_BeachUmbrellas
	ScrapDataC[c].name      = "DLC03_BeachUmbrella01" ; c_Cloth:2 c_Steel:1
	ScrapDataC[c].formid    =  0x000422DB
	ScrapDataC[c].mask		=  9
	ScrapDataC[c].counts	=  129
	c += 1
	ScrapDataC[c].name      = "DLC03_BeachUmbrella02" ; c_Cloth:2 c_Steel:1
	ScrapDataC[c].formid    =  0x000422DC
	ScrapDataC[c].mask		=  9
	ScrapDataC[c].counts	=  129
	c += 1
	; DLC03workshopscraprecipe_BldColondivider
	ScrapDataC[c].name      = "DLC03_BldColonDividerPillar01" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A97
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_BldColonDividerShort1Way01" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A96
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	; DLC03workshopscraprecipe_Conveyor
	ScrapDataC[c].name      = "DLC03_ConveyorStr01A" ; c_Rubber:3 c_Springs:4 c_Steel:8
	ScrapDataC[c].formid    =  0x00039AB8
	ScrapDataC[c].mask		=  32773
	ScrapDataC[c].counts	=  16584
	c += 1
	ScrapDataC[c].name      = "DLC03_ConveyorStr01B" ; c_Rubber:3 c_Springs:4 c_Steel:8
	ScrapDataC[c].formid    =  0x00039AB7
	ScrapDataC[c].mask		=  32773
	ScrapDataC[c].counts	=  16584
	c += 1
	ScrapDataC[c].name      = "DLC03_ConveyorStr02A" ; c_Rubber:3 c_Springs:4 c_Steel:8
	ScrapDataC[c].formid    =  0x00039ABB
	ScrapDataC[c].mask		=  32773
	ScrapDataC[c].counts	=  16584
	c += 1
	ScrapDataC[c].name      = "DLC03_ConveyorStrRamp01A" ; c_Rubber:3 c_Springs:4 c_Steel:8
	ScrapDataC[c].formid    =  0x00039AB9
	ScrapDataC[c].mask		=  32773
	ScrapDataC[c].counts	=  16584
	c += 1
	ScrapDataC[c].name      = "DLC03_ConveyorStrRamp02A" ; c_Rubber:3 c_Springs:4 c_Steel:8
	ScrapDataC[c].formid    =  0x00039ABA
	ScrapDataC[c].mask		=  32773
	ScrapDataC[c].counts	=  16584
	c += 1
	; DLC03workshopscraprecipe_WoodCounters
	ScrapDataC[c].name      = "DLC03_CounterOuterMid01" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A71
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_CounterOuterMid02" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A72
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_CounterOuterMidHalf02" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A73
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_CounterOuterMidHalf01" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A74
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_CounterOuterCrnIn02" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A75
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_CounterOuterCrnIn01" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A76
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_CounterOuterCornerSharp02" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A77
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_CounterOuterCrnOut02" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A78
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_CounterOuterCrnOut01" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A79
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_CounterMid01" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A7A
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_CounterMidHalf01" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A7B
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_CounterCornerIn01" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A87
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_CounterCornerOut01" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A86
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_CounterCornerSharp01" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A88
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1

	; DLC03workshopscraprecipe_FederalistDisplayBoxes			
	ScrapDataC[c].name      = "DLC03_FederalistDisplayBoxWallShort01" ; c_Screws:2 c_Wood:4
	ScrapDataC[c].formid    =  0x00039A6C
	ScrapDataC[c].mask		=  66
	ScrapDataC[c].counts	=  132
	c += 1
	ScrapDataC[c].name      = "DLC03_FederalistDisplayBoxWallTall01" ; c_Screws:2 c_Wood:4
	ScrapDataC[c].formid    =  0x00039A6D
	ScrapDataC[c].mask		=  66
	ScrapDataC[c].counts	=  132
	c += 1
	ScrapDataC[c].name      = "DLC03_FederalistDisplayBoxMidTallIntact01" ; c_Screws:2 c_Wood:4
	ScrapDataC[c].formid    =  0x00039A6E
	ScrapDataC[c].mask		=  66
	ScrapDataC[c].counts	=  132
	c += 1
	ScrapDataC[c].name      = "DLC03_FederalistDisplayBoxWallTallIntact01" ; c_Screws:2 c_Wood:4
	ScrapDataC[c].formid    =  0x00039A6F
	ScrapDataC[c].mask		=  66
	ScrapDataC[c].counts	=  132
	c += 1
	ScrapDataC[c].name      = "DLC03_FederalistDisplayBoxMidShortIntact01" ; c_Screws:2 c_Wood:4
	ScrapDataC[c].formid    =  0x00039A70
	ScrapDataC[c].mask		=  66
	ScrapDataC[c].counts	=  132
	c += 1
	ScrapDataC[c].name      = "DLC03_FederalistDisplayBoxWallShortIntact01" ; c_Screws:2 c_Wood:4
	ScrapDataC[c].formid    =  0x00039A8D
	ScrapDataC[c].mask		=  66
	ScrapDataC[c].counts	=  132
	c += 1
	; DLC03workshopscraprecipe_FishNets (Skippped for now, 19 of them)
	ScrapDataC[c].name		= "FishNetFallenFlatG01" ; c_Cloth:3
	ScrapDataC[c].formid	=  0x000025BC
	ScrapDataC[c].mask		=  8
	ScrapDataC[c].counts	=  3
	c += 1			
	ScrapDataC[c].name		= "FishNetFallenFlatG02" ; c_Cloth:3
	ScrapDataC[c].formid	=  0x000025BD
	ScrapDataC[c].mask		=  8
	ScrapDataC[c].counts	=  3
	c += 1			
	ScrapDataC[c].name		= "FishNetRackHang02" ; c_Cloth:3
	ScrapDataC[c].formid	=  0x000039ED
	ScrapDataC[c].mask		=  8
	ScrapDataC[c].counts	=  3
	c += 1			
	ScrapDataC[c].name		= "FishNetFallenFlatSM01" ; c_Cloth:3
	ScrapDataC[c].formid	=  0x000025BE
	ScrapDataC[c].mask		=  8
	ScrapDataC[c].counts	=  3
	c += 1			
	ScrapDataC[c].name		= "FishNetFallenFlatSM02" ; c_Cloth:3
	ScrapDataC[c].formid	=  0x000025BF
	ScrapDataC[c].mask		=  8
	ScrapDataC[c].counts	=  3
	c += 1			
	ScrapDataC[c].name		= "FishNetFallenCor01" ; c_Cloth:3
	ScrapDataC[c].formid	=  0x000025C6
	ScrapDataC[c].mask		=  8
	ScrapDataC[c].counts	=  3
	c += 1			
	ScrapDataC[c].name		= "FishNetFallen02" ; c_Cloth:3
	ScrapDataC[c].formid	=  0x000024D3
	ScrapDataC[c].mask		=  8
	ScrapDataC[c].counts	=  3
	c += 1			
	ScrapDataC[c].name		= "FishNetHanging01" ; c_Cloth:3
	ScrapDataC[c].formid	=  0x000024AF
	ScrapDataC[c].mask		=  8
	ScrapDataC[c].counts	=  3
	c += 1			
	ScrapDataC[c].name		= "FishNetFallenPile01SC01" ; c_Cloth:3
	ScrapDataC[c].formid	=  0x000037AD
	ScrapDataC[c].mask		=  8
	ScrapDataC[c].counts	=  3
	c += 1			
	ScrapDataC[c].name		= "FishNetFallen01" ; c_Cloth:3
	ScrapDataC[c].formid	=  0x000024D1
	ScrapDataC[c].mask		=  8
	ScrapDataC[c].counts	=  3
	c += 1			
	ScrapDataC[c].name		= "FishNetFallenPile01" ; c_Cloth:3
	ScrapDataC[c].formid	=  0x000024B3
	ScrapDataC[c].mask		=  8
	ScrapDataC[c].counts	=  3
	c += 1			
	ScrapDataC[c].name		= "FishNetFallenCor02" ; c_Cloth:3
	ScrapDataC[c].formid	=  0x000039EF
	ScrapDataC[c].mask		=  8
	ScrapDataC[c].counts	=  3
	c += 1			
	ScrapDataC[c].name		= "FishNetFallenWall01SC02" ; c_Cloth:3
	ScrapDataC[c].formid	=  0x000037B3
	ScrapDataC[c].mask		=  8
	ScrapDataC[c].counts	=  3
	c += 1			
	ScrapDataC[c].name		= "FishNetFallenPile01SC02" ; c_Cloth:3
	ScrapDataC[c].formid	=  0x000037AF
	ScrapDataC[c].mask		=  8
	ScrapDataC[c].counts	=  3
	c += 1			
	ScrapDataC[c].name		= "FishNetFallenWall01" ; c_Cloth:3
	ScrapDataC[c].formid	=  0x000025A9
	ScrapDataC[c].mask		=  8
	ScrapDataC[c].counts	=  3
	c += 1			
	ScrapDataC[c].name		= "FishNetFallenHanging02" ; c_Cloth:3
	ScrapDataC[c].formid	=  0x000024B2
	ScrapDataC[c].mask		=  8
	ScrapDataC[c].counts	=  3
	c += 1			
	ScrapDataC[c].name		= "FishNetFallenHanging03" ; c_Cloth:3
	ScrapDataC[c].formid	=  0x000024B1
	ScrapDataC[c].mask		=  8
	ScrapDataC[c].counts	=  3
	c += 1			
	ScrapDataC[c].name		= "FishNetFallenHangingTorn03" ; c_Cloth:3
	ScrapDataC[c].formid	=  0x000024C6
	ScrapDataC[c].mask		=  8
	ScrapDataC[c].counts	=  3
	c += 1			
	ScrapDataC[c].name		= "FishNetFallenHanging04" ; c_Cloth:3
	ScrapDataC[c].formid	=  0x000024B7
	ScrapDataC[c].mask		=  8
	ScrapDataC[c].counts	=  3
	c += 1
	; DLC03workshopscraprecipe_FishRack
	ScrapDataC[c].name      = "FishRackStandingTall02" ; c_Wood:4
	ScrapDataC[c].formid    =  0x0000190B
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "FishRackStandingTall04SC01" ; c_Wood:4
	ScrapDataC[c].formid    =  0x000039F6
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "FishRackStandingTall01SC03" ; c_Wood:4
	ScrapDataC[c].formid    =  0x000039F3
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "FishRackStandingTall02SC01" ; c_Wood:4
	ScrapDataC[c].formid    =  0x000039F7
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "FishRackStandingTall01SC02" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00002B7E
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_FlagpoleUSAFlag02" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039AA0
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	; DLC03workshopscraprecipe_Groceryshelvesbroken
	ScrapDataC[c].name      = "DLC03_Shelf_Grocery_OneSided_Broken01" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A7D
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_Shelf_Grocery_OneSided_Broken02" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A7F
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_Shelf_Grocery_OneSided_Broken03" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A80
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_Shelf_Grocery_TwoSided_Broken01" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A7E
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_Shelf_Grocery_TwoSided_Broken02" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A81
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_Shelf_Grocery_TwoSided_Broken03" ; c_Wood:4
	ScrapDataC[c].formid    =  0x00039A82
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	; DLC03workshopscraprecipe_HangingBuoy
	ScrapDataC[c].name      = "BuoyWallClusterMed01" ; c_Cork:2 c_Steel:4
	ScrapDataC[c].formid    =  0x00001516
	ScrapDataC[c].mask		=  268435457
	ScrapDataC[c].counts	=  132
	c += 1
	ScrapDataC[c].name      = "BuoyWallClusterSm02" ; c_Cork:2 c_Steel:4
	ScrapDataC[c].formid    =  0x00001513
	ScrapDataC[c].mask		=  268435457
	ScrapDataC[c].counts	=  132
	c += 1
	; DLC03workshopscraprecipe_Hangingdeer 
	ScrapDataC[c].name      = "DLC03_HighTechCounter_Cap01" ; c_Steel:6
	ScrapDataC[c].formid    =  0x0003A310
	ScrapDataC[c].mask		=  1
	ScrapDataC[c].counts	=  6
	c += 1
	; DLC03_workshopScrapRecipe_Megaloader
	ScrapDataC[c].name      = "workshop_DLC03_MegaloaderNoAms01" ; c_Glass:3 c_Rubber:8 c_Springs:4 c_Steel:15
	ScrapDataC[c].formid    =  0x0003555D
	ScrapDataC[c].mask		=  32901
	ScrapDataC[c].counts	=  1061391
	c += 1
	ScrapDataC[c].name      = "workshop_DLC03_Megaloader01" ; c_Glass:3 c_Rubber:8 c_Springs:4 c_Steel:15
	ScrapDataC[c].formid    =  0x00035556
	ScrapDataC[c].mask		=  32901
	ScrapDataC[c].counts	=  1061391
	c += 1
	ScrapDataC[c].name      = "workshop_DLC03_MegaloaderBase01" ; c_Glass:3 c_Rubber:8 c_Springs:4 c_Steel:15
	ScrapDataC[c].formid    =  0x00035557
	ScrapDataC[c].mask		=  32901
	ScrapDataC[c].counts	=  1061391
	c += 1
	ScrapDataC[c].name      = "workshop_DLC03_MegaloaderBucket01" ; c_Glass:3 c_Rubber:8 c_Springs:4 c_Steel:15
	ScrapDataC[c].formid    =  0x00035558
	ScrapDataC[c].mask		=  32901
	ScrapDataC[c].counts	=  1061391
	c += 1
	ScrapDataC[c].name      = "workshop_DLC03_MegaloaderBucket02" ; c_Glass:3 c_Rubber:8 c_Springs:4 c_Steel:15
	ScrapDataC[c].formid    =  0x00035559
	ScrapDataC[c].mask		=  32901
	ScrapDataC[c].counts	=  1061391
	c += 1
	ScrapDataC[c].name      = "workshop_DLC03_MegaloaderBucket03" ; c_Glass:3 c_Rubber:8 c_Springs:4 c_Steel:15
	ScrapDataC[c].formid    =  0x0003555A
	ScrapDataC[c].mask		=  32901
	ScrapDataC[c].counts	=  1061391
	c += 1
	ScrapDataC[c].name      = "DLC03_MegaloaderForklift01" ; c_Glass:3 c_Rubber:8 c_Springs:4 c_Steel:15
	ScrapDataC[c].formid    =  0x0003555B
	ScrapDataC[c].mask		=  32901
	ScrapDataC[c].counts	=  1061391
	c += 1
	; DLC03workshopscraprecipe_ParkPost
	ScrapDataC[c].name      = "DLC03_ParkPostA01" ; c_Wood:2
	ScrapDataC[c].formid    =  0x00039AA4
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  2
	c += 1
	ScrapDataC[c].name      = "DLC03_ParkPostA02" ; c_Wood:2
	ScrapDataC[c].formid    =  0x00039AA5
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  2
	c += 1
	; DLC03workshopscraprecipe_PicnicGrills
	ScrapDataC[c].name      = "DLC03_PicnicGrill02" ; c_Steel:3
	ScrapDataC[c].formid    =  0x0002019B
	ScrapDataC[c].mask		=  1
	ScrapDataC[c].counts	=  3
	c += 1
	; DLC03workshopscraprecipe_PrivetHedge
	ScrapDataC[c].name      = "DLC03_PrivetHedgePostWar03" ; c_Wood:4
	ScrapDataC[c].formid    =  0x0003DC8D
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_PrivetHedgePostWar01" ; c_Wood:4
	ScrapDataC[c].formid    =  0x0003DC8E
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_PrivetHedgePostWar02" ; c_Wood:4
	ScrapDataC[c].formid    =  0x0003DC8F
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	; DLC03workshopscraprecipe_ShelfBig
	ScrapDataC[c].name      = "DLC03_Shelf_Big_Wood" ; c_Steel:3 c_Wood:6
	ScrapDataC[c].formid    =  0x0003A2FE
	ScrapDataC[c].mask		=  3
	ScrapDataC[c].counts	=  387
	c += 1
	ScrapDataC[c].name      = "DLC03_Shelf_Big_Wood_HalfLength" ; c_Steel:3 c_Wood:6
	ScrapDataC[c].formid    =  0x0003A300
	ScrapDataC[c].mask		=  3
	ScrapDataC[c].counts	=  387
	c += 1
	; DLC03workshopscraprecipe_ShippingCrates
	ScrapDataC[c].name      = "DLC03_CrateLargeAquaMuddy" ; c_Steel:8
	ScrapDataC[c].formid    =  0x00039AB1
	ScrapDataC[c].mask		=  1
	ScrapDataC[c].counts	=  8
	c += 1
	ScrapDataC[c].name      = "DLC03_CrateLargeAquaRusty" ; c_Steel:8
	ScrapDataC[c].formid    =  0x00039AAC
	ScrapDataC[c].mask		=  1 
	ScrapDataC[c].counts	=  8
	c += 1
	ScrapDataC[c].name      = "DLC03_ShippingCrate01Blue" ; c_Steel:8
	ScrapDataC[c].formid    =  0x00039AB2
	ScrapDataC[c].mask		=  1
	ScrapDataC[c].counts	=  8
	c += 1
	ScrapDataC[c].name      = "DLC03_ShippingCrate01Orange" ; c_Steel:8
	ScrapDataC[c].formid    =  0x00039AB3
	ScrapDataC[c].mask		=  1
	ScrapDataC[c].counts	=  8
	c += 1
	ScrapDataC[c].name      = "DLC03_ShippingCrate01Yellow" ; c_Steel:8
	ScrapDataC[c].formid    =  0x00039AB4
	ScrapDataC[c].mask		=  1
	ScrapDataC[c].counts	=  8
	c += 1			
	; DLC03workshopscraprecipe_Signclutter
	ScrapDataC[c].name      = "DLC03_SignClutterL01b" ; c_Steel:2
	ScrapDataC[c].formid    =  0x00039A9A
	ScrapDataC[c].mask		=  1
	ScrapDataC[c].counts	=  2
	c += 1
	ScrapDataC[c].name      = "DLC03_SignClutterL02" ; c_Steel:2
	ScrapDataC[c].formid    =  0x00039A9B
	ScrapDataC[c].mask		=  1
	ScrapDataC[c].counts	=  2
	c += 1
	ScrapDataC[c].name      = "DLC03_Sign_GiftShop" ; c_Steel:2
	ScrapDataC[c].formid    =  0x0003CF9E
	ScrapDataC[c].mask		=  1
	ScrapDataC[c].counts	=  2
	c += 1			
	; Other
	ScrapDataC[c].name      = "DLC03_BannerFlagSwag01" ; c_Cloth:2
	ScrapDataC[c].formid    =  0x00039A90
	ScrapDataC[c].mask		=  8
	ScrapDataC[c].counts	=  2
	c += 1
	ScrapDataC[c].name      = "DLC03_Clothingrack_01" ; c_Steel:2
	ScrapDataC[c].formid    =  0x00039A84
	ScrapDataC[c].mask		=  1
	ScrapDataC[c].counts	=  2
	c += 1			
	ScrapDataC[c].name      = "DLC03_Crane_01" ; c_Cloth:3 c_Gears:5 c_Steel:12
	ScrapDataC[c].formid    =  0x00039AC3
	ScrapDataC[c].mask		=  4105
	ScrapDataC[c].counts	=  20684
	c += 1
	ScrapDataC[c].name      = "DecoRoofCoastB1x1StrL01Dam02" ; c_Steel:3 c_Wood:2
	ScrapDataC[c].formid    =  0x0000098C
	ScrapDataC[c].mask		=  3
	ScrapDataC[c].counts	=  131
	c += 1
	ScrapDataC[c].name      = "DLC03_Mirror03" ; c_Glass:2 c_Steel:2
	ScrapDataC[c].formid    =  0x00039A94
	ScrapDataC[c].mask		=  129
	ScrapDataC[c].counts	=  130
	c += 1
	ScrapDataC[c].name      = "DLC03_NParkBoard01" ; c_Wood:3
	ScrapDataC[c].formid    =  0x0003CF98
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  3
	c += 1
	ScrapDataC[c].name      = "DLC03_ParkStoneBlockA" ; c_Concrete:4
	ScrapDataC[c].formid    =  0x000369FE
	ScrapDataC[c].mask		=  2048
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_Shelf_Big_End" ; c_Steel:2
	ScrapDataC[c].formid    =  0x0003A2FF
	ScrapDataC[c].mask		=  1
	ScrapDataC[c].counts	=  2
	c += 1
	ScrapDataC[c].name      = "DLC03_TruckTrailerFlatbed01" ; c_Rubber:6 c_Steel:15 c_Wood:4
	ScrapDataC[c].formid    =  0x00039AA8
	ScrapDataC[c].mask		=  7
	ScrapDataC[c].counts	=  24847
	c += 1
	ScrapDataC[c].name      = "DLC03_Vault_WaterFountain01" ; c_Steel:3
	ScrapDataC[c].formid    =  0x00039A92
	ScrapDataC[c].mask		=  1
	ScrapDataC[c].counts	=  3
	c += 1
	ScrapDataC[c].name      = "DLC03_CafeCounter01" ; c_Wood:4
	ScrapDataC[c].formid    =  0x0003A32A
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_CafeCounter02" ; c_Wood:4
	ScrapDataC[c].formid    =  0x0003A32B
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03_CafeCounterBar01" ; c_Wood:4
	ScrapDataC[c].formid    =  0x0003A32C
	ScrapDataC[c].mask		=  2
	ScrapDataC[c].counts	=  4
	c += 1
	ScrapDataC[c].name      = "DLC03FogCondenserFurniture"
	ScrapDataC[c].formid    =  0x0003EF36
	ScrapDataB[c].mask		=  65537
	ScrapDataB[c].counts	=  132
	c += 1
	ScrapDataC[c].name      = "FloraFogCondensorJug01"
	ScrapDataC[c].formid    =  0x00048BA6
	ScrapDataC[c].mask		=  1
	ScrapDataC[c].counts	=  3
	c += 1
	return c
endFunction

int Function includeNonConstructableTheRest(int b)
	; DLC03_workshopScrapRecipe_BarnKit
	ScrapDataB[b].name      = "DLC03_Echobarnbuilding01" ; c_Wood:10
	ScrapDataB[b].formid    =  0x0003DC6D
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  10
	b += 1
	ScrapDataB[b].name      = "DLC03_Echobarnbuilding02" ; c_Wood:10
	ScrapDataB[b].formid    =  0x0003DC6F
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  10
	b += 1
	ScrapDataB[b].name      = "DLC03_Echobarnbuilding03" ; c_Wood:10
	ScrapDataB[b].formid    =  0x0003DC86
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  10
	b += 1
	; DLC03workshopscraprecipe_BarnFoundation
	ScrapDataB[b].name      = "BarnFoundationMid01" ; c_Concrete:4
	ScrapDataB[b].formid    =  0x00009DF6
	ScrapDataB[b].mask		=  2048
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "BarnFoundationCorIn01" ; c_Concrete:4
	ScrapDataB[b].formid    =  0x00009DF8
	ScrapDataB[b].mask		=  2048
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "BarnFoundationCorIn02" ; c_Concrete:4
	ScrapDataB[b].formid    =  0x00009DF7
	ScrapDataB[b].mask		=  2048
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "BarnFoundationHalfL01" ; c_Concrete:4
	ScrapDataB[b].formid    =  0x00009DF4
	ScrapDataB[b].mask		=  2048
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "BarnFoundationHalfR01" ; c_Concrete:4
	ScrapDataB[b].formid    =  0x00009DF3
	ScrapDataB[b].mask		=  2048
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "BarnFoundationQrtr01" ; c_Concrete:4
	ScrapDataB[b].formid    =  0x00009DF5
	ScrapDataB[b].mask		=  2048
	ScrapDataB[b].counts	=  4
	b += 1
	; DLC03_workshopScrapRecipe_BarnOuthouses
	ScrapDataB[b].name      = "DLC03_OuthouseLFCabin" ; c_Wood:4
	ScrapDataB[b].formid    =  0x000422D5
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1	
	ScrapDataB[b].name      = "BarnOuthouse01" ; c_Wood:4
	ScrapDataB[b].formid    =  0x000041AE
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1	
	ScrapDataB[b].name      = "BarnOuthouse02" ; c_Wood:4
	ScrapDataB[b].formid    =  0x0009897
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1	
	ScrapDataB[b].name      = "BarnOuthouseBase01" ; c_Wood:4
	ScrapDataB[b].formid    =  0x000989B
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1	
	ScrapDataB[b].name      = "BarnOuthouseChair01Static" ; c_Wood:4
	ScrapDataB[b].formid    =  0x00098A5
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1	
	ScrapDataB[b].name      = "BarnOuthouseDoorStatic01" ; c_Wood:4
	ScrapDataB[b].formid    =  0x00041AF
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1	
	ScrapDataB[b].name      = "BarnOuthouseDoorStatic02" ; c_Wood:4
	ScrapDataB[b].formid    =  0x001092A
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1	
	; DLC03workshopscraprecipe_DecohouseSC
	ScrapDataB[b].name      = "DLC03_WorkshopDecoBasehouse01" ; c_Concrete:10 c_Rubber:5 c_Steel:15 c_Wood:20
	ScrapDataB[b].formid    =  0x0003DC5B
	ScrapDataB[b].mask		=  2055
	ScrapDataB[b].counts	=  2643215
	b += 1
	ScrapDataB[b].name      = "DLC03_WorkshopDecoBasehouse02" ; c_Concrete:10 c_Rubber:5 c_Steel:15 c_Wood:20
	ScrapDataB[b].formid    =  0x0003DC5D
	ScrapDataB[b].mask		=  2055
	ScrapDataB[b].counts	=  2643215
	b += 1
	; DLC03_workshopScrapRecipe_DestroyedWall
	ScrapDataB[b].name      = "workshop_DLC03_ShackWallHalfL01Dest" ; c_Glass:1 c_Steel:3 c_Wood:2
	ScrapDataB[b].formid    =  0x00035564
	ScrapDataB[b].mask		=  131
	ScrapDataB[b].counts	=  4227
	b += 1
	ScrapDataB[b].name      = "workshop_DLC03_ShackWallHalfR01Dest" ; c_Glass:1 c_Steel:3 c_Wood:2
	ScrapDataB[b].formid    =  0x0003556D
	ScrapDataB[b].mask		=  131
	ScrapDataB[b].counts	=  4227
	b += 1
	ScrapDataB[b].name      = "workshop_DLC03_ShackWallOuter03Dest" ; c_Glass:1 c_Steel:3 c_Wood:2
	ScrapDataB[b].formid    =  0x0003556E
	ScrapDataB[b].mask		=  131
	ScrapDataB[b].counts	=  4227
	b += 1
	ScrapDataB[b].name      = "workshop_DLC03_ShackWallOuterCap01ADest" ; c_Glass:1 c_Steel:3 c_Wood:2
	ScrapDataB[b].formid    =  0x00035563
	ScrapDataB[b].mask		=  131
	ScrapDataB[b].counts	=  4227
	b += 1
	ScrapDataB[b].name      = "workshop_DLC03_ShackWallOuterCap01BDest" ; c_Glass:1 c_Steel:3 c_Wood:2
	ScrapDataB[b].formid    =  0x00035565
	ScrapDataB[b].mask		=  131
	ScrapDataB[b].counts	=  4227
	b += 1
	ScrapDataB[b].name      = "workshop_DLC03_ShackWallOuterCap01Door01Dest" ; c_Glass:1 c_Steel:3 c_Wood:2
	ScrapDataB[b].formid    =  0x0003556F
	ScrapDataB[b].mask		=  131
	ScrapDataB[b].counts	=  4227
	b += 1
	; DLC03workshopscraprecipe_PierRailing
	ScrapDataB[b].name      = "DLC03_PierRailing01"  ; c_Steel:4
	ScrapDataB[b].formid    =  0x0003DC61
	ScrapDataB[b].mask		=  1
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "DLC03_PierRailing01SCBuoy01" ; c_Steel:4
	ScrapDataB[b].formid    =  0x0003DC62
	ScrapDataB[b].mask		=  1
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "DLC03_PierRailing02" ; c_Steel:4
	ScrapDataB[b].formid    =  0x0003DC63
	ScrapDataB[b].mask		=  1
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "DLC03_PierRailing02SCBuoy01" ; c_Steel:4
	ScrapDataB[b].formid    =  0x0003DC64
	ScrapDataB[b].mask		=  1
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "DLC03_PierRailingLong01" ; c_Steel:4
	ScrapDataB[b].formid    =  0x0003DC65
	ScrapDataB[b].mask		=  1
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "DLC03_PierRailingLong01SCBuoy01" ; c_Steel:4
	ScrapDataB[b].formid    =  0x0003DC66
	ScrapDataB[b].mask		=  1
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "DLC03_PierRailingLong02" ; c_Steel:4
	ScrapDataB[b].formid    =  0x0003DC67
	ScrapDataB[b].mask		=  1
	ScrapDataB[b].counts	=  4
	b += 1
	ScrapDataB[b].name      = "DLC03_PierRailingLong02SCBuoy01" ; c_Steel:4
	ScrapDataB[b].formid    =  0x0003DC68
	ScrapDataB[b].mask		=  1
	ScrapDataB[b].counts	=  4
	b += 1			
	ScrapDataB[b].name      = "BarnDoorSmR01" ; c_Wood:2
	ScrapDataB[b].formid    =  0x00003A5B
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  2
	b += 1
	ScrapDataB[b].name      = "DLC03_NParkBuilding01" ; c_Steel:2 c_Wood:7
	ScrapDataB[b].formid    =  0x0003CF9B
	ScrapDataB[b].mask		=  3
	ScrapDataB[b].counts	=  450
	b += 1
	ScrapDataB[b].name      = "DLC03_ShackBridgeFree01" ; c_Wood:5
	ScrapDataB[b].formid    =  0x0003CFA1
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  5
	b += 1			
	ScrapDataB[b].name      = "DLC03_ADV011_ShackCorner01" ; c_Wood:4
	ScrapDataB[b].formid    =  0x00035566
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1	
	ScrapDataB[b].name      = "DLC03_ADV011_ShackCorner02" ; c_Wood:4
	ScrapDataB[b].formid    =  0x00035567
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1	
	ScrapDataB[b].name      = "DLC03_ADV011_ShackMid01" ; c_Wood:4
	ScrapDataB[b].formid    =  0x00035568
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1	
	ScrapDataB[b].name      = "DLC03_ADV011_ShackMid02" ; c_Wood:4
	ScrapDataB[b].formid    =  0x00035569
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1	
	ScrapDataB[b].name      = "DLC03_ADV011_ShackMid03" ; c_Wood:4
	ScrapDataB[b].formid    =  0x0003556A
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1	
	ScrapDataB[b].name      = "DLC03_ADV011_ShackMid04" ; c_Wood:4
	ScrapDataB[b].formid    =  0x0003556B
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  4
	b += 1	
	ScrapDataB[b].name      = "DLC03NucleusReactor01" ; c_NuclearMaterial:20 c_Steel:6
	ScrapDataB[b].formid    =  0x0004A94E
	ScrapDataB[b].mask		=  65537
	ScrapDataB[b].counts	=  1286
	b += 1
	ScrapDataB[b].name      = "DLC03FogCondenser_FarHarborFF02" ; c_NuclearMaterial:2 c_Steel:4
	ScrapDataB[b].formid    =  0x0005636F
	ScrapDataB[b].mask		=  65537
	ScrapDataB[b].counts	=  132
	b += 1
	ScrapDataB[b].name      = "DLC03FogCondenser01" ; c_NuclearMaterial:2 c_Steel:4
	ScrapDataB[b].formid    =  0x0003FE19
	ScrapDataB[b].mask		=  65537
	ScrapDataB[b].counts	=  132
	b += 1
	ScrapDataB[b].name      = "DLC03FarHarborFF02_FogCondenserActivator" ; c_NuclearMaterial:2 c_Steel:4
	ScrapDataB[b].formid    =  0x0004DC81
	ScrapDataB[b].mask		=  65537
	ScrapDataB[b].counts	=  132
	b += 1
	ScrapDataB[b].name      = "DLC03_TentBed" ; c_Steel:1 c_Cloth:2 c_Wood:2
	ScrapDataB[b].formid    =  0x00049C3A
	ScrapDataB[b].mask		=  11
	ScrapDataB[b].counts	=  8321
	b += 1
	ScrapDataB[b].name      = "PaintedWoodDoorBrokenA01_DLC03" ; c_Wood:2
	ScrapDataB[b].formid    =  0x0000D80E
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  2
	b += 1
	ScrapDataB[b].name      = "PaintedWoodDoorBrokenA02_DLC03" ; c_Wood:2
	ScrapDataB[b].formid    =  0x0000D810
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  2
	b += 1
	ScrapDataB[b].name      = "PaintedWoodDoorDouble02_DLC03" ; c_Wood:3
	ScrapDataB[b].formid    =  0x0000D813
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  3
	b += 1 
	ScrapDataB[b].name      = "PaintedWoodDoorWinBrokenA02_DLC03" ; c_Wood:3 c_Glass:2
	ScrapDataB[b].formid    =  0x0000D80F
	ScrapDataB[b].mask		=  130
	ScrapDataB[b].counts	=  131
	b += 1
	ScrapDataB[b].name      = "workshop_DLC03_ShackDoorBarricade01Dest" ; c_Wood:2
	ScrapDataB[b].formid    =  0x00035572
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  2
	b += 1
	ScrapDataB[b].name      = "DLC03_Barn_BarnMed_001" ; c_Wood:10 c_Steel:5 c_Glass:2
	ScrapDataB[b].formid    =  0x000044CC
	ScrapDataB[b].mask		=  131
	ScrapDataB[b].counts	=  8837
	b += 1
	ScrapDataB[b].name      = "DLC03_Barn_BarnMed_001foundation" ; c_Concrete:10
	ScrapDataB[b].formid    =  0x00009DFE
	ScrapDataB[b].mask		=  2048
	ScrapDataB[b].counts	=  10
	b += 1
	ScrapDataB[b].name      = "DLC03_Barn_BarnMed_002" ; c_Wood:8 c_Steel:4 c_Glass:2 c_Concrete:5
	ScrapDataB[b].formid    =  0x000044CD
	ScrapDataB[b].mask		=  2179
	ScrapDataB[b].counts	=  1319428
	b += 1
	ScrapDataB[b].name      = "DLC03_Barn_BarnMed_002foundation" ; c_Concrete:10
	ScrapDataB[b].formid    =  0x00009DFD
	ScrapDataB[b].mask		=  2048
	ScrapDataB[b].counts	=  10
	b += 1
	ScrapDataB[b].name      = "DLC03_Barn_BarnMed_003" ; c_Wood:12 c_Steel:5 c_Glass:4 c_Concrete:8
	ScrapDataB[b].formid    =  0x000044CE
	ScrapDataB[b].mask		=  2179
	ScrapDataB[b].counts	=  2114309
	b += 1
	ScrapDataB[b].name      = "DLC03_Barn_BarnMed_003foundation" ; c_Concrete:10
	ScrapDataB[b].formid    =  0x00009DFC
	ScrapDataB[b].mask		=  2048
	ScrapDataB[b].counts	=  10
	b += 1
	ScrapDataB[b].name      = "DLC03_Barn_FringeCoveTest_01" ; c_Wood:8 c_Steel:4 c_Glass:2 c_Concrete:5
	ScrapDataB[b].formid    =  0x0000C54A
	ScrapDataB[b].mask		=  2179
	ScrapDataB[b].counts	=  1319428
	b += 1
	ScrapDataB[b].name      = "BranchPileStump02_DLC03" ; c_Wood:10
	ScrapDataB[b].formid    =  0x00016747
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  10
	b += 1
	ScrapDataB[b].name      = "BranchPileStumpRocks02_DLC03" ; c_Wood:10
	ScrapDataB[b].formid    =  0x00016745
	ScrapDataB[b].mask		=  2
	ScrapDataB[b].counts	=  10
	b += 1	
	return b
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
