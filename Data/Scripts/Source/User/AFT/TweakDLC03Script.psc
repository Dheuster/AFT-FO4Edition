Scriptname AFT:TweakDLC03Script extends Quest Conditional

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
; locations
Location		Property	FarHarborWorldLocation Auto
Location		Property	RedDeathIslandLocation Auto
Location		Property	VRLocation             Auto

LocationAlias	Property	DLC03FarHarborWorldLocation Auto Const
LocationAlias	Property	DLC03RedDeathIslandLocation Auto Const
LocationAlias	Property	DLC03VRLocation             Auto Const

String PluginName = "DLCCoast.esm" const

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

	DLC03AcadiaGenericNPCFaction = None
	
	DLC03_COMOldLongfellowTalk_Greeting	= None
	DLC03_COMOldLongfellow_Greeting = None
	; DLC03_COMOldLongfellow_Agree = None
	; DLC03_COMOldLongfellow_Trade = None
  
	DLC03OldLongfellowOutfit = None
	
	FarHarborWorldLocation = None
	RedDeathIslandLocation = None
	VRLocation = None

	DLC03FarHarborWorldLocation.Clear()
	DLC03RedDeathIslandLocation.Clear()
	DLC03VRLocation.Clear()
	
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

		FarHarborWorldLocation = Game.GetFormFromFile(0x01020168,PluginName) As Location
		RedDeathIslandLocation = Game.GetFormFromFile(0x01048AC1,PluginName) As Location
		VRLocation             = Game.GetFormFromFile(0x0100750E,PluginName) As Location
		
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
	
endFunction

Int Function GetPluginID(int formid)
	int fullid = formid
	if fullid > 0x80000000
		fullid -= 0x80000000
	endif
	int lastsix = fullid % 0x01000000
	return (((formid - lastsix)/0x01000000) as Int)
EndFunction 