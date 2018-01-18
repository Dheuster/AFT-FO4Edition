Scriptname AFT:TweakDLC04Script extends Quest Conditional

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

LocationAlias	Property	DLC04NukaWorldLocation              Auto Const
LocationAlias	Property	DLC04NukaWorldAirfieldLocation      Auto Const
LocationAlias	Property	DLC04KiddieKingdomTunnelsLocation   Auto Const
LocationAlias	Property	DLC04BradbertonAmphitheaterLocation Auto Const
LocationAlias	Property	DLC04FizztopMountainLocation        Auto Const
LocationAlias	Property	DLC04TheParlorLocation              Auto Const
LocationAlias	Property	DLC04NukaTownUSALocation            Auto Const


String PluginName = "DLCNukaWorld.esm" const

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakDLC04Script"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Event OnInit()
	resourceID          = -4
	version				= 1.0
	AllToNone()
endEvent

Function AllToNone()

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

	DLC04NukaWorldLocation.Clear()
	DLC04NukaWorldAirfieldLocation.Clear()
	DLC04KiddieKingdomTunnelsLocation.Clear()
	DLC04BradbertonAmphitheaterLocation.Clear()
	DLC04FizztopMountainLocation.Clear()
	DLC04TheParlorLocation.Clear()
	DLC04NukaTownUSALocation.Clear()

endFunction

Function OnGameLoaded(bool firstcall)
	
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
		
		if DLC04MQ00
			resourceID = GetPluginID(DLC04MQ00.GetFormID())
		elseif DLC04MQ01
			resourceID = GetPluginID(DLC04MQ01.GetFormID())
		elseif DLC04MQ02
			resourceID = GetPluginID(DLC04MQ02.GetFormID())
		elseif DLC04MQ03
			resourceID = GetPluginID(DLC04MQ03.GetFormID())
		elseif DLC04MQ04
			resourceID = GetPluginID(DLC04MQ04.GetFormID())
		elseif DLC04MQ05
			resourceID = GetPluginID(DLC04MQ05.GetFormID())
		endif
					
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
		
		if (issue)
			Trace("AFT Message : Some DLC04 (Nuka World) Resources Failed to Import. Compatibility issues likely.")
		endif
				
		if (!Installed)
			Trace("AFT Message : Performing 1st time install tasks...")
			Installed = true
		endif
				
	elseIf (Installed)
		Trace("AFT Message : AFT Unloading DLC04 (Nuka World) resources...")
		AllToNone()
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