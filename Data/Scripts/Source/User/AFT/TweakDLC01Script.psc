Scriptname AFT:TweakDLC01Script extends Quest Conditional

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

; Spells
; Spell[] 	Property SpellMap					Auto 
; String[]	Property SpellNames					Auto

; Outfits and clothes

; locations
Location		Property	AdaCaravenLocation 					Auto
Location		Property	MechGeneralAtomicsFactoryLocation	Auto
Location		Property	MechLairLocation					Auto
Location		Property	MechLairRoboStoreLocation			Auto
LocationAlias	Property	DLC01CaravenLocation				Auto Const
LocationAlias	Property	DLC01GeneralAtomicsFactoryLocation	Auto Const
LocationAlias	Property	DLC01LairLocation					Auto Const
LocationAlias	Property	DLC01LairRoboStoreLocation			Auto Const

Faction			Property	DLC01WorkshopRobotFaction			Auto

String PluginName = "DLCRobot.esm" const

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakDLC01Script"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Event OnInit()
	resourceID          = -1
	Installed			= false
	version				= 1.0
	AllToNone()
endEvent

Function AllToNone()

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
				
	elseIf (Installed)
		Trace("AFT Message : AFT Unloading DLC01 (Automatron) resources...")
		AllToNone()
		Installed = false
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