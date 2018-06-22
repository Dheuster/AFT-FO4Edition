Scriptname AFT:TweakDLC04Script extends Quest Conditional

String PluginName = "DLCNukaWorld.esm" const

; This is a proxy script that can be used to inject DLC03 resources into AFT without
; creating a hard dependency on the DLC. 

Bool			Property	Installed		Auto Conditional
float			Property	version			Auto
Int				Property	resourceID		Auto

; --=== Actors ===--
Actor			Property	PorterGage			Auto
Actor			Property	Colter				Auto
Actor			Property	Nisha				Auto
Actor			Property	MagsBlack			Auto
Actor			Property	WilliamBlack		Auto
Actor			Property	Mason				Auto

ActorBase		Property	PorterGageBase      Auto
ActorBase		Property	ColterBase			Auto
ActorBase		Property	NishaBase			Auto
ActorBase		Property	MagsBlackBase		Auto
ActorBase		Property	WilliamBlackBase	Auto
ActorBase		Property	MasonBase			Auto

ReferenceAlias	Property	DLC04Gage           Auto Const
ReferenceAlias	Property	DLC04OverbossColter Auto Const
ReferenceAlias	Property	DLC04Nisha          Auto Const
ReferenceAlias	Property	DLC04MagsBlack      Auto Const
ReferenceAlias	Property	DLC04WilliamBlack   Auto Const
ReferenceAlias	Property	DLC04Mason          Auto Const

; --=== Quests ===--
Quest			Property	DLC04MQ00			Auto
Quest			Property	DLC04MQ01			Auto
Quest			Property	DLC04MQ02			Auto
Quest			Property	DLC04MQ03			Auto
Quest			Property	DLC04MQ04			Auto
Quest			Property	DLC04MQ05			Auto

; --=== Topics ===--
Topic			Property	DLC04COMGageTalk_Greeting	Auto
Topic			Property	DLC04COMGage_Hello			Auto
int				Property	DLC04COMGage_AgreeMasked = 0x0002771D	Auto Const
int				Property	DLC04COMGage_TradeMasked = 0x00027717	Auto Const
int				Property	DLC04COMGageTalk_DismissMasked = 0x00044FF9	Auto Const

; Outfits and clothes
Outfit			Property	DLC04_GageOutfit					Auto

; locations
Location		Property	NukaWorldLocation					Auto
Location		Property	NukaWorldAirfieldLocation			Auto
Location		Property	KiddieKingdomTunnelsLocation		Auto
Location		Property	BradbertonAmphitheaterLocation		Auto
Location		Property	FizztopMountainLocation				Auto
Location		Property	TheParlorLocation					Auto
Location		Property	NukaTownUSALocation					Auto

ObjectReference Property	DLC04MQ02OverlookGageMarker			Auto

LocationAlias	Property	DLC04NukaWorldLocation              Auto Const
LocationAlias	Property	DLC04NukaWorldAirfieldLocation      Auto Const
LocationAlias	Property	DLC04KiddieKingdomTunnelsLocation   Auto Const
LocationAlias	Property	DLC04BradbertonAmphitheaterLocation Auto Const
LocationAlias	Property	DLC04FizztopMountainLocation        Auto Const
LocationAlias	Property	DLC04TheParlorLocation              Auto Const
LocationAlias	Property	DLC04NukaTownUSALocation            Auto Const

; --=== Prefab Support ===--
;Quest			Property TweakScrapScanMaster			Auto Const
GlobalVariable	Property pTweakScanThreadsDone			Auto Const
GlobalVariable	Property pTweakScanObjectsFound			Auto Const
FormList		Property TweakScrapScan_DLC04			Auto Const
GlobalVariable	Property pTweakScrapAll					Auto Const
GlobalVariable	Property pTweakSettlementSnap			Auto Const
GlobalVariable	Property pTweakOptionsScanC				Auto Const
GlobalVariable	Property pTweakOptionsScanC_ExBenches	Auto Const
GlobalVariable	Property pTweakOptionsScanNC			Auto Const
GlobalVariable	Property pTweakOptionsScanNC_ExMisc		Auto Const
;GlobalVariable	Property pTweakOptionsScanNC_IncTheRest	Auto Const
;GlobalVariable	Property pTweakOptionsScanNC_ExFood		Auto Const
;GlobalVariable	Property pTweakOptionsScanNC_ExLiving	Auto Const
;GlobalVariable	Property pTweakOptionsScanC_ExTurrets	Auto Const
;GlobalVariable	Property pTweakOptionsScanC_ExFences	Auto Const
;GlobalVariable	Property pTweakOptionsScanC_ExWalls		Auto Const
;GlobalVariable	Property pTweakOptionsScanC_ExFloors	Auto Const
GlobalVariable	Property pTweakOptionsScanC_ExShops		Auto Const
GlobalVariable	Property pTweakOptionsScanC_ExCont		Auto Const
;GlobalVariable	Property pTweakOptionsScanC_ExFood		Auto Const
GlobalVariable	Property pTweakOptionsScanC_IncTheRest	Auto Const
;GlobalVariable	Property pTweakOptionsScanNC_ExCont		Auto Const

int SCAN_OBJECTS		 = 999 const

Struct SettlementDataDLC04
   int    locid
   string name
   ; bs = bounding sphere
   float  bs_x
   float  bs_y
   float  bs_z
   float  bs_radius
EndStruct

SettlementDataDLC04[] Property SettlementLookup Auto

Struct ScrapDataDLC04
   string name
   int    formid
   int    mask
   int    counts
EndStruct

; --=== LOCAL Variables ===---
ScrapDataDLC04[] ScrapDataA
ScrapDataDLC04[] ScrapDataB
GlobalVariable[] ResultArray
ObjectReference  center
float 			 radius

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakDLC04Script"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Event OnInit()
	trace("OnInit() Called")
	resourceID          = -4
	version				= 1.0
endEvent

Event OnQuestInit()
	trace("OnQuestInit() Called")
	AllToNone()
EndEvent


Function AllToNone()
	trace("AllToNone() Called")

	Installed = false
	PorterGage = None
	Colter = None
	Nisha = None
	MagsBlack = None
	WilliamBlack = None
	Mason = None

	PorterGageBase = None
	ColterBase = None
	NishaBase = None
	MagsBlackBase = None
	WilliamBlackBase = None
	MasonBase = None

	DLC04Gage.Clear()
	DLC04OverbossColter.Clear()
	DLC04Nisha.Clear()
	DLC04MagsBlack.Clear()
	DLC04WilliamBlack.Clear()
	DLC04Mason.Clear()

	DLC04MQ00 = None
	DLC04MQ01 = None
	DLC04MQ02 = None
	DLC04MQ03 = None
	DLC04MQ04 = None
	DLC04MQ05 = None

	DLC04COMGageTalk_Greeting = None
	DLC04COMGage_Hello        = None

	DLC04_GageOutfit = None

	NukaWorldLocation = None
	NukaWorldAirfieldLocation = None
	KiddieKingdomTunnelsLocation = None
	BradbertonAmphitheaterLocation = None
	FizztopMountainLocation = None
	TheParlorLocation = None
	NukaTownUSALocation = None
	
	DLC04MQ02OverlookGageMarker = None

	DLC04NukaWorldLocation.Clear()
	DLC04NukaWorldAirfieldLocation.Clear()
	DLC04KiddieKingdomTunnelsLocation.Clear()
	DLC04BradbertonAmphitheaterLocation.Clear()
	DLC04FizztopMountainLocation.Clear()
	DLC04TheParlorLocation.Clear()
	DLC04NukaTownUSALocation.Clear()

endFunction

Function OnGameLoaded(bool firstcall)
	trace("OnGameLoaded() Called")
	
	if (Game.IsPluginInstalled(PluginName))	
	
		trace(PluginName + " Detected")

		bool 	issue = false

		; Load Resources
		DLC04MQ00 = Game.GetFormFromFile(0x01000800,PluginName) As Quest
		DLC04MQ01 = Game.GetFormFromFile(0x01000801,PluginName) As Quest
		DLC04MQ02 = Game.GetFormFromFile(0x01000802,PluginName) As Quest
		DLC04MQ03 = Game.GetFormFromFile(0x01000803,PluginName) As Quest
		DLC04MQ04 = Game.GetFormFromFile(0x01000804,PluginName) As Quest
		DLC04MQ05 = Game.GetFormFromFile(0x01000805,PluginName) As Quest
							
		if (!DLC04MQ00 || !DLC04MQ01 || !DLC04MQ02 || !DLC04MQ03)
			trace("Unable To Load DLC04MQ00 or DLC04MQ01 or DLC04MQ02 or DLC04MQ03")
			issue = True
		elseif (!DLC04MQ04 || !DLC04MQ05)
			trace("Unable To Load DLC04MQ04 or DLC04MQ05")
			issue = True
		else
			trace("Loaded DLC04 Quests")
		endif
		
		DLC04COMGageTalk_Greeting = Game.GetFormFromFile(0x01046DD6,PluginName) As Topic
		DLC04COMGage_Hello = Game.GetFormFromFile(0x01029BDE,PluginName) As Topic

		if (!DLC04COMGageTalk_Greeting || !DLC04COMGage_Hello)
			trace("Unable To Load DLC04COMGageTalk_Greeting or DLC04COMGage_Hello")
			issue = True
		else
			trace("Loaded DLC04 Topics")
		endif
		
		DLC04_GageOutfit   = Game.GetFormFromFile(0x01031F4D,PluginName) As Outfit
		
		if (!DLC04_GageOutfit  )
			trace("Unable To Load DLC04_GageOutfit  ")
			issue = True
		else
			trace("Loaded DLC04_GageOutfit  ")
		endif
		
		PorterGageBase		= Game.GetFormFromFile(0x0100881D,PluginName) As ActorBase
		ColterBase			= Game.GetFormFromFile(0x0100A50A,PluginName) As ActorBase
		NishaBase			= Game.GetFormFromFile(0x0100A4E2,PluginName) As ActorBase
		MagsBlackBase		= Game.GetFormFromFile(0x0100D3EB,PluginName) As ActorBase
		WilliamBlackBase	= Game.GetFormFromFile(0x0100D3ED,PluginName) As ActorBase
		MasonBase			= Game.GetFormFromFile(0x0100F436,PluginName) As ActorBase
		
		if PorterGageBase
			trace("Loaded DLC04 PorterGage ActorBase")
			PorterGage = PorterGageBase.GetUniqueActor()
		else
			trace("Unable To Load PorterGage ActorBase")
			issue = True
		endif
		
		if ColterBase
			trace("Loaded DLC04 Colter ActorBase")
			Colter = ColterBase.GetUniqueActor()
		else
			trace("Unable To Load Colter ActorBase")
			issue = True
		endif
		
		if NishaBase
			trace("Loaded DLC04 Nisha ActorBase")
			Nisha = NishaBase.GetUniqueActor()
		else
			trace("Unable To Load Nisha ActorBase")
			issue = True
		endif
		
		if MagsBlackBase
			trace("Loaded DLC04 MagsBlack ActorBase")
			MagsBlack = MagsBlackBase.GetUniqueActor()
		else
			trace("Unable To Load MagsBlack ActorBase")
			issue = True
		endif
		
		if WilliamBlackBase
			trace("Loaded DLC04 WilliamBlack ActorBase")
			WilliamBlack = WilliamBlackBase.GetUniqueActor()
		else
			trace("Unable To Load WilliamBlack ActorBase")
			issue = True
		endif
		
		if MasonBase
			trace("Loaded DLC04 Mason ActorBase")
			Mason = MasonBase.GetUniqueActor()
		else
			trace("Unable To Load Mason ActorBase")
			issue = True
		endif
		
		if !PorterGage
			; Backup
			ReferenceAlias PorterGageREF = None
			if DLC04MQ01
				PorterGageREF = DLC04MQ01.GetAlias(1) As ReferenceAlias
				if PorterGageREF
					PorterGage = PorterGageREF.GetActorReference()
				endif
				if (!PorterGage && DLC04MQ02)
					PorterGageREF = DLC04MQ02.GetAlias(0) As ReferenceAlias
					if PorterGageREF
						PorterGage = PorterGageREF.GetActorReference()
					endif
					if (!PorterGage && DLC04MQ03)
						PorterGageREF = DLC04MQ03.GetAlias(0) As ReferenceAlias
						if PorterGageREF
							PorterGage = PorterGageREF.GetActorReference()
						endif
						if (!PorterGage && DLC04MQ04)
							PorterGageREF = DLC04MQ04.GetAlias(31) As ReferenceAlias
							if PorterGageREF
								PorterGage = PorterGageREF.GetActorReference()
							endif						
						endif						
					endif				
				endif
			endif
		endif

		if !Colter
			; Backup
			ReferenceAlias ColterREF = None
			if DLC04MQ01
				ColterREF = DLC04MQ01.GetAlias(0) As ReferenceAlias
				if ColterREF
					Colter = ColterREF.GetActorReference()
				endif
			endif
		endif

		
		if !Nisha
			; Backup
			ReferenceAlias NishaREF = None
			if DLC04MQ02
				NishaREF = DLC04MQ02.GetAlias(1) As ReferenceAlias
				if NishaREF
					Nisha = NishaREF.GetActorReference()
				endif
				if (!Nisha && DLC04MQ05)
					NishaREF = DLC04MQ05.GetAlias(0) As ReferenceAlias
					if NishaREF
						Nisha = NishaREF.GetActorReference()
					endif
				endif
			endif
		endif
		
		if !MagsBlack
			; Backup
			ReferenceAlias MagsBlackREF = None
			if DLC04MQ02
				MagsBlackREF = DLC04MQ02.GetAlias(2) As ReferenceAlias
				if MagsBlackREF
					MagsBlack = MagsBlackREF.GetActorReference()
				endif
				if (!MagsBlack && DLC04MQ05)
					MagsBlackREF = DLC04MQ05.GetAlias(2) As ReferenceAlias
					if MagsBlackREF
						MagsBlack = MagsBlackREF.GetActorReference()
					endif
				endif
			endif
		endif
		
		if !WilliamBlack
			; Backup
			ReferenceAlias WilliamBlackREF = None
			if DLC04MQ02
				WilliamBlackREF = DLC04MQ02.GetAlias(4) As ReferenceAlias
				if WilliamBlackREF
					WilliamBlack = WilliamBlackREF.GetActorReference()
				endif
				if (!WilliamBlack && DLC04MQ05)
					WilliamBlackREF = DLC04MQ05.GetAlias(3) As ReferenceAlias
					if WilliamBlackREF
						WilliamBlack = WilliamBlackREF.GetActorReference()
					endif
				endif
			endif
		endif

		if !Mason
			; Backup
			ReferenceAlias MasonREF = None
			if DLC04MQ02
				MasonREF = DLC04MQ02.GetAlias(3) As ReferenceAlias
				if MasonREF
					Mason = MasonREF.GetActorReference()
				endif
				if (!Mason && DLC04MQ05)
					MasonREF = DLC04MQ05.GetAlias(4) As ReferenceAlias
					if MasonREF
						Mason = MasonREF.GetActorReference()
					endif
				endif
			endif
		endif
				
		If PorterGage
			trace("Loaded DLC04 PorterGage Actor")
			DLC04Gage.ForceRefTo(PorterGage)
		else
			trace("Unable To Fill DLC04Gage Reference Alias")
			issue = True			
		endif
		
		If Colter
			trace("Loaded DLC04 Colter Actor")
			DLC04OverbossColter.ForceRefTo(Colter)
		else
			trace("Unable To Fill DLC04OverbossColter Reference Alias")
			issue = True			
		endif
				
		If Nisha
			trace("Loaded DLC04 Nisha Actor")
			DLC04Nisha.ForceRefTo(Nisha)
		else
			trace("Unable To Fill DLC04Nisha Reference Alias")
			issue = True			
		endif

		If MagsBlack
			trace("Loaded DLC04 MagsBlack Actor")
			DLC04MagsBlack.ForceRefTo(MagsBlack)
		else
			trace("Unable To Fill DLC04MagsBlack Reference Alias")
			issue = True			
		endif
		
		If WilliamBlack
			trace("Loaded DLC04 WilliamBlack Actor")
			DLC04WilliamBlack.ForceRefTo(WilliamBlack)
		else
			trace("Unable To Fill DLC04WilliamBlack Reference Alias")
			issue = True			
		endif

		If Mason
			trace("Loaded DLC04 Mason Actor")
			DLC04Mason.ForceRefTo(Mason)
		else
			trace("Unable To Fill DLC04Mason Reference Alias")
			issue = True			
		endif
		
		NukaWorldLocation              = Game.GetFormFromFile(0x01008060,PluginName) As Location
		NukaWorldAirfieldLocation      = Game.GetFormFromFile(0x010503BD,PluginName) As Location
		KiddieKingdomTunnelsLocation   = Game.GetFormFromFile(0x01017646,PluginName) As Location
		BradbertonAmphitheaterLocation = Game.GetFormFromFile(0x01055A05,PluginName) As Location
		FizztopMountainLocation        = Game.GetFormFromFile(0x01056DB2,PluginName) As Location
		TheParlorLocation              = Game.GetFormFromFile(0x01056DB3,PluginName) As Location
		NukaTownUSALocation            = Game.GetFormFromFile(0x0101FCEC,PluginName) As Location
						
		if NukaWorldLocation
			trace("Loaded DLC04NukaWorldLocation")
			DLC04NukaWorldLocation.ForceLocationTo(NukaWorldLocation)
		else
			trace("Unable To Load NukaWorldLocation Location")
			issue = True			
		endif
		if NukaWorldAirfieldLocation
			trace("Loaded DLC04NukaWorldAirfieldLocation")
			DLC04NukaWorldAirfieldLocation.ForceLocationTo(NukaWorldAirfieldLocation)
		else
			trace("Unable To Load NukaWorldAirfieldLocation Location")
			issue = True			
		endif
		if KiddieKingdomTunnelsLocation
			trace("Loaded DLC04KiddieKingdomTunnelsLocation")
			DLC04KiddieKingdomTunnelsLocation.ForceLocationTo(KiddieKingdomTunnelsLocation)
		else
			trace("Unable To Load KiddieKingdomTunnelsLocation Location")
			issue = True			
		endif
		if BradbertonAmphitheaterLocation
			trace("Loaded DLC04BradbertonAmphitheaterLocation")
			DLC04BradbertonAmphitheaterLocation.ForceLocationTo(BradbertonAmphitheaterLocation)
		else
			trace("Unable To Load BradbertonAmphitheaterLocation Location")
			issue = True			
		endif
		if FizztopMountainLocation
			trace("Loaded DLC04FizztopMountainLocation")
			DLC04FizztopMountainLocation.ForceLocationTo(FizztopMountainLocation)
		else
			trace("Unable To Load FizztopMountainLocation Location")
			issue = True			
		endif
		if TheParlorLocation
			trace("Loaded DLC04TheParlorLocation")
			DLC04TheParlorLocation.ForceLocationTo(TheParlorLocation)
		else
			trace("Unable To Load TheParlorLocation Location")
			issue = True			
		endif
		if NukaTownUSALocation
			trace("Loaded DLC04NukaTownUSALocation")
			DLC04NukaTownUSALocation.ForceLocationTo(NukaTownUSALocation)
		else
			trace("Unable To Load NukaTownUSALocation Location")
			issue = True			
		endif
		
		if !DLC04MQ02OverlookGageMarker
			if DLC04MQ02
				ReferenceAlias DLC04MQ02OverlookGageMarkerREF = DLC04MQ02.GetAlias(5) As ReferenceAlias
				if DLC04MQ02OverlookGageMarkerREF
					DLC04MQ02OverlookGageMarker = DLC04MQ02OverlookGageMarkerREF.GetReference()
					if !DLC04MQ02OverlookGageMarker
						trace("Unable To Load DLC04MQ02OverlookGageMarker: ReferenceAlias unfilled. (Has Quest Started?)")
					endif
				else
					trace("Unable To Load DLC04MQ02OverlookGageMarker: DLC04MQ02.GetAlias(5) did not cast to ReferenceAlias")
				endif
			else
				trace("Unable To Load DLC04MQ02OverlookGageMarker (DLC04MQ02 unavailable)")
			endif
		endif
		
		if !DLC04MQ02OverlookGageMarker
			issue = True
		endif
		
		if (issue)
			Trace("AFT Message : Some DLC04 (Nuka World) Resources Failed to Import. Compatibility issues likely.")
		endif
		
		if (!Installed)
			Trace("AFT Message : Performing 1st time install tasks...")
			Installed = true
		endif
				
	else
		Trace("DLC04 (Nuka World) Not Detected")	
		If (Installed)
			Trace("AFT Message : AFT Unloading DLC04 (Nuka World) resources...")
			AllToNone()
		endIf
	endif
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
	
    SettlementLookup[0].name       = "NukaWorldRedRocket"
    SettlementLookup[0].locid      =  0x0000BCED
	;                                 actual   +  bs offset
    SettlementLookup[0].bs_x       = 21962.91   + 312.04
    SettlementLookup[0].bs_y       = 32503.41   - 626.21
    SettlementLookup[0].bs_z       = 3136.96    - 1743.79
	;                                ~bs radius +  extra
    SettlementLookup[0].bs_radius  = 5760       +  450
	
EndFunction

Function allocate_SettlementLookup(int len)

	; When you have an array of structs, you must still 
	; allocate each individual struct....
	
	SettlementLookup = new SettlementDataDLC04[len]
	int i = 0
	while (i < len)
		SettlementLookup[i] = new SettlementDataDLC04
		i += 1
	endWhile
EndFunction

Function Scan(ObjectReference p_center, float p_radius)
	Trace("Scan Called")
	
	bool snapshot            = (pTweakSettlementSnap.GetValue() == 1.0)

	; Early Bail if current location is not part of DLC:	
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
	startTimer(0.0, SCAN_OBJECTS); Basically this is the same thing as FORK....
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
	
	prepare_ScrapData()
	int lenA = ScrapDataA.length
	int lenB = ScrapDataB.length
	if 0 == (lenA + lenB)
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
	ScrapDataDLC04 lookup
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
	
		trace("Updating TweakScrapScan_DLC04 with ScrapDataA")
		TweakScrapScan_DLC04.Revert()
		
		i = 0
		while (i < lenA)
			Form item = Game.GetFormFromFile(ScrapDataA[i].formid,PluginName)
			if item
				trace("- Adding [" + ScrapDataA[i].name + "]")
				TweakScrapScan_DLC04.AddForm(item)
			else
				trace("- [" + ScrapDataA[i].name + "] not found")
			endif
			i += 1
		endwhile
	
		Trace("Scanning...")

		results = center.FindAllReferencesOfType(TweakScrapScan_DLC04, radius)			
		numresults = results.length
	
		Trace("Scanning Complete: [" + numresults + "] objects found")
		TweakScrapScan_DLC04.Revert()
	
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
					lookupindex = ScrapDataA.FindStruct("formid",rid)
					if (lookupindex > -1)
						lookup = ScrapDataA[lookupindex]
						lookupsuccess += 1
						if snapshot				
							params[0] = lookup.name
							params[1] = ((-0x04000000) - rid)  ; ResourceID -0x04 tells AFT it is DLOC04 object.
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
	
		trace("Updating TweakScrapScan_DLC04 with ScrapDataB")
		TweakScrapScan_DLC04.Revert()
		
		i = 0
		while (i < lenB)
			Form item = Game.GetFormFromFile(ScrapDataB[i].formid,PluginName)
			if item
				trace("- Adding [" + ScrapDataB[i].name + "]")
				TweakScrapScan_DLC04.AddForm(item)
			else
				trace("- [" + ScrapDataB[i].name + "] not found")
			endif
			i += 1
		endwhile
	
		Trace("Scanning...")

		results = center.FindAllReferencesOfType(TweakScrapScan_DLC04, radius)			
		numresults = results.length
	
		Trace("Scanning Complete: [" + numresults + "] objects found")
		TweakScrapScan_DLC04.Revert()
	
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
							params[1] = ((-0x04000000) - rid)  ; ResourceID -0x04 tells AFT it is DLOC04 object.
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
	pTweakScanThreadsDone.mod(-1.0)
	center = None
	
EndFunction

Function prepare_ScrapData()
	
	trace("prepare_ScrapData")

	ScrapDataA.clear()
	ScrapDataB.clear()
	
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
	bool c_include_shops	 = (pTweakOptionsScanC_ExShops.GetValue() == 0.0)
	bool c_include_conts	 = (pTweakOptionsScanC_ExCont.GetValue() == 0.0)
;   bool c_include_food		 = (pTweakOptionsScanC_ExFood.GetValue() == 0.0)
	bool c_include_therest	 = (pTweakOptionsScanC_IncTheRest.GetValue() == 1.0)

;	bool nc_include_conts    = (pTweakOptionsScanNC_ExCont.GetValue() == 0.0)
;	bool nc_include_living   = (pTweakOptionsScanNC_ExLiving.GetValue() == 0.0)
;	bool nc_include_food     = (pTweakOptionsScanNC_ExFood.GetValue() == 0.0)
	bool nc_include_misc     = (pTweakOptionsScanNC_ExMisc.GetValue() == 0.0)
;	bool nc_include_therest  = (pTweakOptionsScanNC_IncTheRest.GetValue() == 1.0)
	
	int  expectedA = 0
	int  expectedB = 0
	
	if (includeCreatable == 1.0 || snapshot || scrapall)
		expectedA += 122
		expectedB += 19
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
			expectedB += 6
		endif
		if (c_include_shops)
			expectedB += 6
		endIf
		if (c_include_conts)
			expectedB += 7
		endIf
;		if (c_include_food)
;			expected += 0
;		endIf
		if (c_include_therest)
			expectedA += 122
		endIf
	endif

	if (includeNonCreatable || snapshot || scrapall)
		expectedB += 4
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
			expectedB += 4
		endIf
;		if (nc_include_therest)
;			expected += 38
;		endIf
	endIf

	if (0 == (expectedA + expectedB))
		trace("No Expected Results. Bailing.")
		return		
	endIf
	
	; ----------------------
	; Allocate
	; ----------------------
	if (0 != expectedA)
		ScrapDataA = new ScrapDataDLC04[expectedA]
		int i = 0
		while (i < expectedA)
			ScrapDataA[i] = new ScrapDataDLC04
			i += 1
		endWhile
	endif
	if (0 != expectedB)
		ScrapDataB = new ScrapDataDLC04[expectedB]
		int i = 0
		while (i < expectedB)
			ScrapDataB[i] = new ScrapDataDLC04
			i += 1
		endWhile
	endif
		
	; ----------------------
	; Populate
	; ----------------------
	int a = 0
	int b = 0

	if (includeCreatable == 1.0 || snapshot || scrapall)
		b = includeConstructableBenches(b)
		b = includeConstructableCont(b)
		a = includeConstructableTheRest(a)
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
			; 6
			b = includeConstructableBenches(b)
		endif
		if (c_include_shops)
			; 6
			b = includeConstructableShops(b)
		endIf
		if (c_include_conts)
			; 7
			b = includeConstructableCont(b)
		endIf
;		if (c_include_food)
;		endIf
		if (c_include_therest)
			; 122
			a = includeConstructableTheRest(a)
		endIf
	endif

	if (includeNonCreatable || snapshot || scrapall)
		b = includeNonConstructableMisc(b)
	else

;		if (nc_include_conts)
;		endIf
;		if (nc_include_living)
;		endIf
;		if (nc_include_food)
;		endIf
		if (nc_include_misc)
			b = includeNonConstructableMisc(b)
		endIf
;		if (nc_include_therest)
;			c = includeNonConstructableTheRest(c)
;		endif
	endIf
	
	if (a != expectedA)
		trace("Checksum Error: ExpectedA [" + expectedA + "] Created [" + a + "]")
	endIf
	if (b != expectedB)
		trace("Checksum Error: ExpectedB [" + expectedB + "] Created [" + b + "]")
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

int Function includeConstructableBenches(int b)
	ScrapDataB[b].name		= "DLC04_WorkbenchSodaMachine_Freestanding_Victory" ; c_Rubber:1 c_Steel:4
	ScrapDataB[b].formid	=  0x0004D8E9
	ScrapDataB[b].mask		=  5
	ScrapDataB[b].counts	=  68
	b += 1
	ScrapDataB[b].name		= "DLC04_WorkbenchSodaMachine_Freestanding_Quartz" ; c_Rubber:1 c_Steel:4
	ScrapDataB[b].formid	=  0x0004D8ED
	ScrapDataB[b].mask		=  5
	ScrapDataB[b].counts	=  68
	b += 1
	ScrapDataB[b].name		= "DLC04_WorkbenchSodaMachine_Freestanding_Orange" ; c_Rubber:1 c_Steel:4
	ScrapDataB[b].formid	=  0x00017D26
	ScrapDataB[b].mask		=  5
	ScrapDataB[b].counts	=  68
	b += 1
	ScrapDataB[b].name		= "DLC04_WorkbenchSodaMachine_Freestanding_Quantum" ; c_Rubber:1 c_Steel:4
	ScrapDataB[b].formid	=  0x0004D8E6
	ScrapDataB[b].mask		=  5
	ScrapDataB[b].counts	=  68
	b += 1	
	ScrapDataB[b].name		= "DLC04WorkshopBoozeStill01" ; c_Steel:3 c_Wood:5 c_Copper:2
	ScrapDataB[b].formid	=  0x00030A99
	ScrapDataB[b].mask		=  35
	ScrapDataB[b].counts	=  8515
	b += 1
	ScrapDataB[b].name		= "DLC04WorkshopRaiderRadioTransmitter" ; circuitry:2 copper:6 crystal:2 rubber:1 steel:10 
	ScrapDataB[b].formid	=  0x00015AA0
	ScrapDataB[b].mask		=  8389669
	ScrapDataB[b].counts	=  34103370
	b += 1	
	return b
endFunction

int Function includeConstructableShops(int b)
	ScrapDataB[b].name		= "DLC04_RaiderWorkshopStoreMisc01" ; c_Steel:3 c_Wood:5
	ScrapDataB[b].formid	=  0x00035727
	ScrapDataB[b].mask		=  3
	ScrapDataB[b].counts	=  323
	b += 1
	ScrapDataB[b].name		= "DLC04_RaiderWorkshopStoreWeapons01" ; c_Steel:3 c_Wood:5
	ScrapDataB[b].formid	=  0x0001E95F
	ScrapDataB[b].mask		=  3
	ScrapDataB[b].counts	=  323
	b += 1
	ScrapDataB[b].name		= "DLC04_RaiderWorkshopStoreClothing01" ; c_Steel:3 c_Wood:5
	ScrapDataB[b].formid	=  0x0001E95E
	ScrapDataB[b].mask		=  3
	ScrapDataB[b].counts	=  323
	b += 1
	ScrapDataB[b].name		= "DLC04_RaiderWorkshopStoreChems01" ; c_Steel:3 c_Wood:5
	ScrapDataB[b].formid	=  0x0001E961
	ScrapDataB[b].mask		=  3
	ScrapDataB[b].counts	=  323
	b += 1
	ScrapDataB[b].name		= "DLC04_RaiderWorkshopStoreBar01" ; c_Steel:3 c_Wood:5
	ScrapDataB[b].formid	=  0x0001E960
	ScrapDataB[b].mask		=  3
	ScrapDataB[b].counts	=  323
	b += 1
	ScrapDataB[b].name		= "DLC04_RaiderWorkshopStoreArmor01" ; c_Steel:3 c_Wood:5
	ScrapDataB[b].formid	=  0x0001E95D
	ScrapDataB[b].mask		=  3
	ScrapDataB[b].counts	=  323
	b += 1
	return b
endFunction

int Function includeConstructableCont(int b)
	ScrapDataB[b].name		= "DLC04Workshop_CashRegisterContainer_Nuka" ; c_Screws:1 c_Steel:2 
	ScrapDataB[b].formid	=  0x00050323
	ScrapDataB[b].mask		=  65
	ScrapDataB[b].counts	=  66
	b += 1
	; DLC04_workshopRecipe_Trashcans
	ScrapDataB[b].name		= "DLC04_Trashcan02_Container" ; c_Rubber:1 c_Steel:4 
	ScrapDataB[b].formid	=  0x000296BC
	ScrapDataB[b].mask		=  5
	ScrapDataB[b].counts	=  68
	b += 1
	ScrapDataB[b].name		= "DLC04_Trashcan02B_Container" ; c_Rubber:1 c_Steel:4 
	ScrapDataB[b].formid	=  0x0002B618
	ScrapDataB[b].mask		=  5
	ScrapDataB[b].counts	=  68
	b += 1
	ScrapDataB[b].name		= "DLC04_Trashcan01_Container" ; c_Rubber:1 c_Steel:4 
	ScrapDataB[b].formid	=  0x000296BB
	ScrapDataB[b].mask		=  5
	ScrapDataB[b].counts	=  68
	b += 1
	ScrapDataB[b].name		= "DLC04_Trashcan04_Container" ; c_Rubber:1 c_Steel:4 
	ScrapDataB[b].formid	=  0x000296BD
	ScrapDataB[b].mask		=  5
	ScrapDataB[b].counts	=  68
	b += 1
	ScrapDataB[b].name		= "DLC04WorkshopRaiderTributeChest" ; adhesive:5 aluminum:6 cloth:2 fiberglass:4 wood:3
	ScrapDataB[b].formid	=  0x0001D95A
	ScrapDataB[b].mask		=  540938
	ScrapDataB[b].counts	=  68444291
	b += 1
	ScrapDataB[b].name		= "DLC04WorkshopRaiderPickMeUpStation" ; antiseptic:3 circuitry:2 fertilizer:2 steel:6
	ScrapDataB[b].formid	=  0x00032F47
	ScrapDataB[b].mask		=  134349825
	ScrapDataB[b].counts	=  794758
	b += 1
	return b
endFunction

int Function includeConstructableTheRest(int a)

	; DLC04_workshopRecipe_PackChairs
	ScrapDataA[a].name		= "DLC04PackNpcChairModernDomesticSit03" ; c_Cloth:2 c_Wood:4
	ScrapDataA[a].formid	=  0x00043B6F
	ScrapDataA[a].mask		=  10
	ScrapDataA[a].counts	=  132
	a += 1
	ScrapDataA[a].name		= "DLC04PackNpcChairModernDomesticSit02" ; c_Cloth:2 c_Wood:4
	ScrapDataA[a].formid	=  0x00043B6E
	ScrapDataA[a].mask		=  10
	ScrapDataA[a].counts	=  132
	a += 1
	ScrapDataA[a].name		= "DLC04PackNpcChairModernDomesticSit01" ; c_Cloth:2 c_Wood:4
	ScrapDataA[a].formid	=  0x00043B6D
	ScrapDataA[a].mask		=  10
	ScrapDataA[a].counts	=  132
	a += 1
	ScrapDataA[a].name		= "DLC04PackNpcCouchModernDomesticSit01" ; c_Cloth:2 c_Wood:4
	ScrapDataA[a].formid	=  0x00043B6C
	ScrapDataA[a].mask		=  10
	ScrapDataA[a].counts	=  132
	a += 1
	; DLC04_workshopRecipe_AnimatronicsBroken
	ScrapDataA[a].name		= "DLC04AnimatronicBroken01" ; c_Steel:1 c_Wood:3
	ScrapDataA[a].formid	=  0x00042431
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  193
	a += 1
	ScrapDataA[a].name		= "DLC04AnimatronicBroken02" ; c_Steel:1 c_Wood:3
	ScrapDataA[a].formid	=  0x0004242F
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  193
	a += 1
	ScrapDataA[a].name		= "DLC04AnimatronicBroken03" ; c_Steel:1 c_Wood:3
	ScrapDataA[a].formid	=  0x00042430
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  193
	a += 1
	ScrapDataA[a].name		= "DLC04AnimatronicBroken04" ; c_Steel:1 c_Wood:3
	ScrapDataA[a].formid	=  0x0004242E
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  193
	a += 1
	; DLC04_workshopRecipe_PackMannequins
	ScrapDataA[a].name		= "DLC04PackMannequin01" ; c_Leather:2 c_Steel:1 c_Wood:3
	ScrapDataA[a].formid	=  0x0004A1A6
	ScrapDataA[a].mask		=  33554435
	ScrapDataA[a].counts	=  8385
	a += 1
	ScrapDataA[a].name		= "DLC04PackMannequin02" ; c_Leather:2 c_Steel:1 c_Wood:3
	ScrapDataA[a].formid	=  0x0004A1A7
	ScrapDataA[a].mask		=  33554435
	ScrapDataA[a].counts	=  8385
	a += 1
	ScrapDataA[a].name		= "DLC04PackMannequin03" ; c_Leather:2 c_Steel:1 c_Wood:3
	ScrapDataA[a].formid	=  0x0004A1A5
	ScrapDataA[a].mask		=  33554435
	ScrapDataA[a].counts	=  8385
	a += 1
	; DLC04_workshopRecipe_KK_NukaRacer
	ScrapDataA[a].name		= "DLC04_KiddieNukaRacer01" ; c_Leather:1 c_Steel:3 
	ScrapDataA[a].formid	=  0x000222D4
	ScrapDataA[a].mask		=  33554433
	ScrapDataA[a].counts	=  67
	a += 1
	ScrapDataA[a].name		= "DLC04_KiddieNukaRacer02" ; c_Leather:1 c_Steel:3 
	ScrapDataA[a].formid	=  0x000222D7
	ScrapDataA[a].mask		=  33554433
	ScrapDataA[a].counts	=  67
	a += 1
	; DLC04_workshopRecipe_BumperCars
	ScrapDataA[a].name		= "DLC04Workshop_BumperCar_Blue" ; c_Leather:1 c_Rubber:2 c_Steel:3 
	ScrapDataA[a].formid	=  0x0005034E
	ScrapDataA[a].mask		=  33554437
	ScrapDataA[a].counts	=  4227
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_BumperCar_Red" ; c_Leather:1 c_Rubber:2 c_Steel:3 
	ScrapDataA[a].formid	=  0x0005034C
	ScrapDataA[a].mask		=  33554437
	ScrapDataA[a].counts	=  4227
	a += 1
	; DLC04_workshopRecipe_BP_Bottles
	ScrapDataA[a].name		= "DLC04Workshop_NukaBottle_Blue" ; c_Steel:8
	ScrapDataA[a].formid	=  0x000503A1
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_NukaBottle_Orange" ; c_Steel:8
	ScrapDataA[a].formid	=  0x000503A2
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_NukaBottle_Red" ; c_Steel:8
	ScrapDataA[a].formid	=  0x000503A3
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_NukaBottle_Silver" ; c_Steel:8
	ScrapDataA[a].formid	=  0x000503A4
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_NukaColaBottleLarge01" ; c_Steel:8
	ScrapDataA[a].formid	=  0x000503A0
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  8
	a += 1
	; DLC04_workshopRecipe_KK_IceCream
	ScrapDataA[a].name		= "DLC04Workshop_KK_IceCream01AddOn" ; c_Steel:3 c_Wood:2
	ScrapDataA[a].formid	=  0x00050394
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  131
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_KK_IceCream02AddOn" ; c_Steel:3 c_Wood:2
	ScrapDataA[a].formid	=  0x00050395
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  131
	a += 1
	; DLC04_workshopRecipe_KK_Gumdrops
	ScrapDataA[a].name		= "DLC04_KK_Gumdrop01AddOn" ; c_Steel:3 c_Wood:2
	ScrapDataA[a].formid	=  0x00016BF7
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  131
	a += 1
	ScrapDataA[a].name		= "DLC04_KK_Gumdrop02AddOn" ; c_Steel:3 c_Wood:2
	ScrapDataA[a].formid	=  0x0003295F
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  131
	a += 1
	ScrapDataA[a].name		= "DLC04_KK_Gumdrop03AddOn" ; c_Steel:3 c_Wood:2
	ScrapDataA[a].formid	=  0x00032960
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  131
	a += 1
	ScrapDataA[a].name		= "DLC04_KK_Gumdrop04AddOn" ; c_Steel:3 c_Wood:2
	ScrapDataA[a].formid	=  0x00032961
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  131
	a += 1
	; DLC04_workshopRecipe_KK_Suckers
	ScrapDataA[a].name		= "DLC04_KK_CandySucker01AddOn" ; c_Steel:5
	ScrapDataA[a].formid	=  0x000170CC
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  5
	a += 1
	ScrapDataA[a].name		= "DLC04_KK_CandySucker02AddOn" ; c_Steel:5
	ScrapDataA[a].formid	=  0x00031F54
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  5
	a += 1
	ScrapDataA[a].name		= "DLC04_KK_CandySucker03AddOn" ; c_Steel:5
	ScrapDataA[a].formid	=  0x00031F55
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  5
	a += 1
	ScrapDataA[a].name		= "DLC04_KK_CandySucker04AddOn" ; c_Steel:5
	ScrapDataA[a].formid	=  0x00031F56
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  5
	a += 1
	; DLC04_workshopRecipe_SA_StatueLarge
	ScrapDataA[a].name		= "DLC04_ZooStatue_Bear" ; c_Steel:6
	ScrapDataA[a].formid	=  0x00017DF3
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name		= "DLC04_ZooStatue_Gorilla" ; c_Steel:6
	ScrapDataA[a].formid	=  0x00017DEC
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  6
	a += 1
	; DLC04_workshopRecipe_SA_StatueSnakes
	ScrapDataA[a].name		= "DLC04_SnakeStatuesL01" ; c_Steel:5
	ScrapDataA[a].formid	=  0x0004BF47
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  5
	a += 1
	ScrapDataA[a].name		= "DLC04_SnakeStatuesR01" ; c_Steel:5
	ScrapDataA[a].formid	=  0x00049EE9
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  5
	a += 1
	; DLC04_workshopRecipe_GZ_Rockets
	ScrapDataA[a].name		= "DLC04_GZ_Rocket01Static" ; c_Steel:6
	ScrapDataA[a].formid	=  0x0003407E
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name		= "DLC04_GZ_Rocket01Static01WORKSHOP" ; c_Steel:6
	ScrapDataA[a].formid	=  0x0005177E
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  6
	a += 1
	; DLC04_workshopRecipe_GZ_Cutout
	ScrapDataA[a].name		= "DLC04_Sign_NukaGirl02" ; c_Wood:3
	ScrapDataA[a].formid	=  0x0004B064
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_Cutout_Alien" ; c_Wood:3
	ScrapDataA[a].formid	=  0x0005031E
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  3
	a += 1
	; DLC04_workshopRecipe_WW_Cactus
	ScrapDataA[a].name		= "DLC04_Cactus01" ; c_Steel:3
	ScrapDataA[a].formid	=  0x00041A12
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04_Cactus02" ; c_Steel:3
	ScrapDataA[a].formid	=  0x00041A14
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  3
	a += 1
	; DLC04_workshopRecipe_WW_Cutout
	ScrapDataA[a].name		= "DLC04Workshop_CutOut_DocPhosphate" ; c_Wood:3
	ScrapDataA[a].formid	=  0x0005036B
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_CutOut_MadMulligan" ; c_Wood:3
	ScrapDataA[a].formid	=  0x0005036C
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_CutOut_MissTrixie" ; c_Wood:3
	ScrapDataA[a].formid	=  0x0005036D
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_CutOut_SherriffBruce" ; c_Wood:3
	ScrapDataA[a].formid	=  0x0005036E
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_CutOut_OneEyedIke" ; c_Wood:3
	ScrapDataA[a].formid	=  0x0003F680
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  3
	a += 1
	; DLC04_workshopRecipe_NW_Lamps
	ScrapDataA[a].name		= "DLC04Workshop_StreetLamp02" ; c_Copper:2 c_Glass:2 c_Steel:6
	ScrapDataA[a].formid	=  0x00050349
	ScrapDataA[a].mask		=  161
	ScrapDataA[a].counts	=  8326
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_StreetLampBanner02a" ; c_Copper:2 c_Glass:2 c_Steel:6
	ScrapDataA[a].formid	=  0x0005034A
	ScrapDataA[a].mask		=  161
	ScrapDataA[a].counts	=  8326
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_StreetLampTilingRemap01" ; c_Copper:2 c_Glass:2 c_Steel:6
	ScrapDataA[a].formid	=  0x00050344
	ScrapDataA[a].mask		=  161
	ScrapDataA[a].counts	=  8326
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_StreetLampTilingRemapBanner01a" ; c_Copper:2 c_Glass:2 c_Steel:6
	ScrapDataA[a].formid	=  0x00050345
	ScrapDataA[a].mask		=  161
	ScrapDataA[a].counts	=  8326
	a += 1
	; DLC04_workshopRecipe_NW_SignsClutterAll
	ScrapDataA[a].name		= "DLC04Workshop_SignClutterPost" ; c_Steel:3
	ScrapDataA[a].formid	=  0x00050330
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04_SignClutterA01" ; c_Steel:3
	ScrapDataA[a].formid	=  0x0003F673
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04_SignClutterA02_Information" ; c_Steel:3
	ScrapDataA[a].formid	=  0x0003F674
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04_SignClutterA03_Exit" ; c_Steel:3
	ScrapDataA[a].formid	=  0x0003F670
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04_SignClutterA04_Refreshments" ; c_Steel:3
	ScrapDataA[a].formid	=  0x0003F671
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04_SignClutterA05_FirstAid" ; c_Steel:3
	ScrapDataA[a].formid	=  0x0003F672
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04_SignClutterA06_Rides" ; c_Steel:3
	ScrapDataA[a].formid	=  0x0004ABE6
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04_SignClutterA07_Games" ; c_Steel:3
	ScrapDataA[a].formid	=  0x0004ABE4
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04_SignClutterA08_Restrooms" ; c_Steel:3
	ScrapDataA[a].formid	=  0x0004ABE7
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04_SignClutterA09_GiftShop" ; c_Steel:3
	ScrapDataA[a].formid	=  0x0004ABE8
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04_SignClutterA10_Theater" ; c_Steel:3
	ScrapDataA[a].formid	=  0x0004ABE9
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  3
	a += 1
	; DLC04_workshopRecipe_SA_SignMedium
	ScrapDataA[a].name		= "DLC04_Sign_Keephandsincage" ; c_Steel:4
	ScrapDataA[a].formid	=  0x000247B9
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name		= "DLC04_Sign_Donotfeedtheanimals" ; c_Steel:4
	ScrapDataA[a].formid	=  0x00023438
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name		= "DLC04_Sign_Warning_Alligator" ; c_Steel:4
	ScrapDataA[a].formid	=  0x000247B5
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name		= "DLC04_Sign_Warning_Buffalo" ; c_Steel:4
	ScrapDataA[a].formid	=  0x000247B6
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name		= "DLC04_Sign_Warning_Cagereaching01" ; c_Steel:4
	ScrapDataA[a].formid	=  0x000247B4
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name		= "DLC04_Sign_Warning_Cagereaching02" ; c_Steel:4
	ScrapDataA[a].formid	=  0x000247B7
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name		= "DLC04_Sign_Warning_Gazelle" ; c_Steel:4
	ScrapDataA[a].formid	=  0x000247B8
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  4
	a += 1
	; DLC04_workshopRecipe_NW_Cutout
	ScrapDataA[a].name		= "DLC04Workshop_Cutout_Bottle" ; c_Wood:3
	ScrapDataA[a].formid	=  0x0005031F
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_Cutout_Cappy" ; c_Wood:3
	ScrapDataA[a].formid	=  0x00050320
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_Cutout_NukaCola" ; c_Wood:3
	ScrapDataA[a].formid	=  0x00050321
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_Sign_KingColaCutoutSTATIC_Blue" ; c_Wood:3
	ScrapDataA[a].formid	=  0x00050315
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_Sign_KingColaCutoutSTATIC_Green" ; c_Wood:3
	ScrapDataA[a].formid	=  0x00050316
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_Sign_KingColaCutoutSTATIC_Red" ; c_Wood:3
	ScrapDataA[a].formid	=  0x00050314
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_Sign_Mustbethistall_ShortSTATIC_Blue" ; c_Wood:3
	ScrapDataA[a].formid	=  0x00050319
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_Sign_Mustbethistall_ShortSTATIC_Green" ; c_Wood:3
	ScrapDataA[a].formid	=  0x0005031A
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_Sign_Mustbethistall_ShortSTATIC_Red" ; c_Wood:3
	ScrapDataA[a].formid	=  0x00050318
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_AmphitheaterPropShrub01" ; c_Wood:3
	ScrapDataA[a].formid	=  0x0002D436
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_AmphitheaterPropShrub01" ; c_Wood:3
	ScrapDataA[a].formid	=  0x0002D435
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  3
	a += 1
	; DLC04_workshopRecipe_NW_StatueBottleCappy
	ScrapDataA[a].name		= "DLC04BottleAndCappyFingerDip" ; c_Steel:8
	ScrapDataA[a].formid	=  0x0003F9C4
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name		= "DLC04BottleAndCappyLaidBack" ; c_Steel:8
	ScrapDataA[a].formid	=  0x000401D9
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  8
	a += 1
	; DLC04_workshopRecipe_Pike
	ScrapDataA[a].name		= "DLC04_Pike01" ; c_Steel:4 
	ScrapDataA[a].formid	=  0x0000AE73
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name		= "DLC04_Pike02" ; c_Steel:4 
	ScrapDataA[a].formid	=  0x0000AE74
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name		= "DLC04_Pike03" ; c_Steel:4 
	ScrapDataA[a].formid	=  0x00012B84
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  4
	a += 1
	; DLC04_workshopRecipe_PikeWithHead
	ScrapDataA[a].name		= "DLC04_Pike01_A" ; c_Steel:4 
	ScrapDataA[a].formid	=  0x00013A51
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name		= "DLC04_Pike01_B" ; c_Steel:4 
	ScrapDataA[a].formid	=  0x00013A52
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name		= "DLC04_Pike02_A" ; c_Steel:4 
	ScrapDataA[a].formid	=  0x00013A53
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name		= "DLC04_Pike02_B" ; c_Steel:4 
	ScrapDataA[a].formid	=  0x00013A54
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name		= "DLC04_Pike03_A" ; c_Steel:4 
	ScrapDataA[a].formid	=  0x00013A55
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name		= "DLC04_Pike03_B" ; c_Steel:4 
	ScrapDataA[a].formid	=  0x00013A56
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  4
	a += 1
	; Other
	ScrapDataA[a].name		= "DLC04_Flagpole_NukaCola_WithFlag" ; c_Cloth:2 c_Steel:2
	ScrapDataA[a].formid	=  0x0001DC07
	ScrapDataA[a].mask		=  9
	ScrapDataA[a].counts	=  130
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_TablePatio01_Nuka" ; c_Steel:10
	ScrapDataA[a].formid	=  0x00050324
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  10
	a += 1
	ScrapDataA[a].name		= "DLC04_VendorCart02" ; c_Steel:8
	ScrapDataA[a].formid	=  0x0002E609
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name		= "DLC04_ParkMap" ; c_Steel:8
	ScrapDataA[a].formid	=  0x00037856
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name		= "DLC04_NukaGlobe01" ; c_Steel:8
	ScrapDataA[a].formid	=  0x000488C0
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  8
	a += 1
	ScrapDataA[a].name		= "DLC04AnimatronicOperatorTrainer" ; c_Gears:2 c_Steel:1 c_Wood:3
	ScrapDataA[a].formid	=  0x00043A9A
	ScrapDataA[a].mask		=  4099
	ScrapDataA[a].counts	=  8385
	a += 1
	ScrapDataA[a].name		= "DLC04AnimatronicOperatorSlitThroat" ; c_Steel:1 c_Wood:3
	ScrapDataA[a].formid	=  0x00042432
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  193
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_Lightbox_StarportArt03" ; c_Rubber:2 c_Steel:4 c_Wood:10
	ScrapDataA[a].formid	=  0x0005033E
	ScrapDataA[a].mask		=  7
	ScrapDataA[a].counts	=  8836
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_Lightbox_StarportArt02" ; c_Rubber:2 c_Steel:4 c_Wood:10
	ScrapDataA[a].formid	=  0x0005033D
	ScrapDataA[a].mask		=  7
	ScrapDataA[a].counts	=  8836
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_Lightbox_StarportArt01" ; c_Rubber:2 c_Steel:4 c_Wood:10
	ScrapDataA[a].formid	=  0x0005033C
	ScrapDataA[a].mask		=  7
	ScrapDataA[a].counts	=  8836
	a += 1
	ScrapDataA[a].name		= "DLC04_Sign_Tickets02" ; c_Steel:3
	ScrapDataA[a].formid	=  0x000401AE
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  3
	a += 1
	ScrapDataA[a].name		= "DLC04_Sign_Warning_Keephandandfeet" ; c_Steel:2
	ScrapDataA[a].formid	=  0x000217C5
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  2
	a += 1
	ScrapDataA[a].name		= "DLC04_Sign_Warning_ClothesRequired" ; c_Steel:2
	ScrapDataA[a].formid	=  0x000217C6
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  2
	a += 1
	ScrapDataA[a].name		= "DLC04_Sign_Spit" ; c_Steel:2
	ScrapDataA[a].formid	=  0x000217C7
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  2
	a += 1
	ScrapDataA[a].name		= "DLC04_BloodTrough" ; c_Steel:2 c_Wood:3
	ScrapDataA[a].formid	=  0x00012B80
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  194
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_WW_Trough" ; c_Wood:4
	ScrapDataA[a].formid	=  0x00050370
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name		= "DLC04WW_HitchPost01" ; c_Wood:3
	ScrapDataA[a].formid	=  0x00007BE1
	ScrapDataA[a].mask		=  2
	ScrapDataA[a].counts	=  3
	a += 1	
	ScrapDataA[a].name		= "DLC04WW_HayBale01" ; c_Steel:2 c_Wood:3
	ScrapDataA[a].formid	=  0x00043A5A
	ScrapDataA[a].mask		=  3
	ScrapDataA[a].counts	=  194
	a += 1
	ScrapDataA[a].name		= "DLC04_Nukacade_TokenDispenser01" ; c_Steel:4 c_Gears:1 c_Screws:1
	ScrapDataA[a].formid	=  0x0004BD38
	ScrapDataA[a].mask		=  4164
	ScrapDataA[a].counts	=  4164
	a += 1
	ScrapDataA[a].name		= "DLC04_Nukacade_HoopShot" ; c_Circuitry:2 c_Screws:1 c_Steel:8 c_Wood:3
	ScrapDataA[a].formid	=  0x0004BD31
	ScrapDataA[a].mask		=  1091
	ScrapDataA[a].counts	=  528584
	a += 1
	ScrapDataA[a].name		= "DLC04_Nukacade_BanditRoundup" ; c_Circuitry:2 c_Screws:2 c_Steel:8 c_Wood:3
	ScrapDataA[a].formid	=  0x0004BD30
	ScrapDataA[a].mask		=  1091
	ScrapDataA[a].counts	=  532680
	a += 1
	ScrapDataA[a].name		= "DLC04_Nukacade_NukaZapperRace" ; c_Circuitry:2 c_Screws:2 c_Steel:8 c_Wood:3
	ScrapDataA[a].formid	=  0x0004CBDC
	ScrapDataA[a].mask		=  1091
	ScrapDataA[a].counts	=  532680
	a += 1
	ScrapDataA[a].name		= "DLC04_Nukacade_AtomicRollers01Blue" ; c_Circuitry:2 c_Copper:1 c_Screws:2 c_Steel:6
	ScrapDataA[a].formid	=  0x0004BD34
	ScrapDataA[a].mask		=  1121
	ScrapDataA[a].counts	=  532550
	a += 1
	ScrapDataA[a].name		= "DLC04_Nukacade_WhackaCommie01Red" ; c_Circuitry:2 c_Copper:1 c_Screws:2 c_Steel:6
	ScrapDataA[a].formid	=  0x0004BD36
	ScrapDataA[a].mask		=  1121
	ScrapDataA[a].counts	=  532550
	a += 1
	ScrapDataA[a].name		= "DLC04Workshop_NpcChairPatioSit01_Nuka" ; c_Plastic:2 c_Steel:4 
	ScrapDataA[a].formid	=  0x00050325
	ScrapDataA[a].mask		=  17
	ScrapDataA[a].counts	=  132
	a += 1
	ScrapDataA[a].name		= "DLC04_BannerPack02_Workshop" ; c_Cloth:4
	ScrapDataA[a].formid	=  0x00056A3A
	ScrapDataA[a].mask		=  8
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name		= "DLC04_BannerPack" ; c_Cloth:6
	ScrapDataA[a].formid	=  0x00047F50
	ScrapDataA[a].mask		=  8
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name		= "DLC04_BannerDisciples02_Workshop" ; c_Cloth:4
	ScrapDataA[a].formid	=  0x00056A35
	ScrapDataA[a].mask		=  8
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name		= "DLC04_BannerOperators" ; c_Cloth:6
	ScrapDataA[a].formid	=  0x00047F46
	ScrapDataA[a].mask		=  8
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name		= "DLC04WorkshopRadioRaiderAmplifierOff" ; c_Circuitry:1 c_Copper:2 c_FiberOptics:2 c_Fiberglass:4 c_Rubber:2
	ScrapDataA[a].formid	=  0x0001D95A
	ScrapDataA[a].mask		=  787492
	ScrapDataA[a].counts	=  67637378
	a += 1
	ScrapDataA[a].name		= "DLC04_BannerOperators02_Workshop" ; c_Cloth:4 
	ScrapDataA[a].formid	=  0x00056A37
	ScrapDataA[a].mask		=  8
	ScrapDataA[a].counts	=  4
	a += 1
	ScrapDataA[a].name		= "DLC04_BannerDisciples" ; c_Cloth:6 
	ScrapDataA[a].formid	=  0x00012B86
	ScrapDataA[a].mask		=  8
	ScrapDataA[a].counts	=  6
	a += 1
	ScrapDataA[a].name		= "DLC04_Totem" ; c_Steel:7 
	ScrapDataA[a].formid	=  0x0000AE71
	ScrapDataA[a].mask		=  1
	ScrapDataA[a].counts	=  7
	a += 1
	return a
EndFunction

int Function includeNonConstructableMisc(int b)
	ScrapDataB[b].name		= "DLC04_Scrap_BabyCarriageStatic01" ; c_Steel:2
	ScrapDataB[b].formid	=  0x00
	ScrapDataB[b].mask		=  1
	ScrapDataB[b].counts	=  2
	b += 1
	ScrapDataB[b].name		= "DLC04_Scrap_BillboardBldgLGCornerD02" ; c_Steel:8
	ScrapDataB[b].formid	=  0x00
	ScrapDataB[b].mask		=  1
	ScrapDataB[b].counts	=  8
	b += 1
	; DLC04_workshopScrapRecipe_Debris03Lg
	ScrapDataB[b].name		= "DLC04_DebrisMound01_WetMud" ; c_Steel:8
	ScrapDataB[b].formid	=  0x0000B40B
	ScrapDataB[b].mask		=  1
	ScrapDataB[b].counts	=  8
	b += 1
	ScrapDataB[b].name		= "DLC04_DebrisPile01_WetMud" ; c_Steel:8
	ScrapDataB[b].formid	=  0x0000B408
	ScrapDataB[b].mask		=  1
	ScrapDataB[b].counts	=  8
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
