Scriptname AFT:TweakSettings extends ReferenceAlias

float Property AliasIndex Auto Const 

Group Injected

	GlobalVariable  Property iFollower_Stance_Aggressive	Auto Const
	GlobalVariable  Property iFollower_Stance_Defensive		Auto Const
	GlobalVariable  Property pTweakIgnoreFriendlyFire		Auto Const ; 0101BB24
	
	Faction         Property pTweakEssentialFaction			Auto Const ; 0101BB23
	Faction         Property pCurrentCompanionFaction		Auto Const ; 00023C01
	Faction         Property pTweakFollowerFaction			Auto Const ; 01000F9B
	Faction         Property pTweakNamesFaction				Auto Const ; 01002E16
	Faction         Property pTweakAllowFriendlyFire		Auto Const ; 
	Faction         Property pTweakReadyWeaponFaction		Auto Const ;
	Faction         Property pTweakSyncPAFaction			Auto Const ;
	Faction			Property pTweakTrackKills				Auto Const ;
	Faction			Property pTweakRangedFaction			Auto Const
	Faction			Property pTweakSkipGoHomeFaction		Auto Const
	Faction			Property pTweakCampHomeFaction			Auto Const
	Faction			Property pTweakNoHomeFaction			Auto Const
	Faction			Property pTweakAutoStanceFaction		Auto Const

	
	Faction			Property pPlayerFaction					Auto Const ; 0001C21C 
	
	Quest           Property pTweakNames					Auto Const ; 010035B1
	Quest			Property pTweakDismiss					Auto Const
	
	Formlist        Property pTweakCommonFactions			Auto Const ; 0101BB21
	
	Race            Property pHumanRace						Auto Const ;

	; LinkedRef for TweakGoHome package....
	Keyword         Property pTweakLocHome					Auto Const 
	Keyword         Property pTeammateReadyWeapon_DO		Auto Const
	
	ObjectReference Property CaitPostCombatMarker01			Auto Const ; 0x000C73E9
	ObjectReference Property CodsworthKitchenMarker			Auto Const ; 0x00023CBC
	ObjectReference Property COMCurieIntroMarker			Auto Const ; 0x00239ED3
	ObjectReference Property BoS101PlayerStartMarker		Auto Const ; 0x00193F92
	ObjectReference Property BoS201DanseMessHallMarker		Auto Const ; 0x000AA1B9	
	ObjectReference Property DeaconHomeMarker				Auto Const ; 0x00050987
	ObjectReference Property RedRocketCenterMarker			Auto Const ; 0x0004BE79
	ObjectReference Property MS04HancockEndMarker			Auto Const ; 0x0012937E
	ObjectReference Property COMMacCreadyStartMarker		Auto Const ; 0x00115EA2
	ObjectReference Property MS07NickOfficeMarker			Auto Const ; 0x00054344
	ObjectReference Property MQ201BPiperTravelMarker02		Auto Const ; 0x001558A8
	ObjectReference Property SanctuaryLocationCenterMarker	Auto Const ; 0x0004BE7A
	ObjectReference Property MS10SafetyMarker				Auto Const ; 0x000F15CD
	ObjectReference Property InstSceneAlaneJustin1JustinMarker Auto Const ; 0x000C9D59
	
	Static			Property XMarkerHeading					Auto Const ; 0x00000034

	Location        Property pTweakCampLocation				Auto const
	
	; Marker for AFT Camp
	ObjectReference Property pAftMapMarker					Auto const 
	
	; --------------------------------------------------------------
	; ACTOR VALUES
	; --------------------------------------------------------------

	; Relationship
	; ActorValue Property pCA_Affinity Auto
	; ActorValue Property pCA_HighestThreshold Auto ; Confirmed these are updated...
	; ActorValue Property pCA_HighestReached Auto
	; ActorValue Property pCA_CurrentThreshold Auto
	; ActorValue Property pCA_LowestReached Auto
	; ActorValue Property pCA_LowestThreshold Auto
	; ActorValue Property pCA_IsRomantic Auto

	; S.P.E.C.I.A.L:
	ActorValue Property pStrength      Auto Const
	ActorValue Property pPerception    Auto Const
	ActorValue Property pEndurance     Auto Const
	ActorValue Property pCharisma      Auto Const
	ActorValue Property pIntelligence  Auto Const
	ActorValue Property pAgility       Auto Const
	ActorValue Property pLuck          Auto Const

	; AI Package Settings
	ActorValue      Property pAggression					Auto  Const
	ActorValue		Property pFollowerStance				Auto  Const
	;   0 = Unaggressive (attack no one), 
	;   1 = Aggresive (Attack actively hostile enemies)
	;   2 = Very Aggressive (Attack any non-alies including neutral factions and enemies that haven't gone hostile yet)
	;   3 = Frenzied (Attack followers and teammates)
	ActorValue      Property pMorality						Auto  Const 
	;   0 = Wont refuse any command based on ethics (will attack friends and enemies) 
	;   1 = Will attack neutral NPCs, but not allies. 
	;   2 = Property crimes only 
	;   3 = No crime...
	ActorValue      Property pConfidence					Auto  Const 
	;   0 = Coward
	;   1 = Cautious
	;   2 = Average
	;   3 = Brave
	;   4 = Foolhardy
	ActorValue      Property pAssistance					Auto  Const 
	;   0 = Helps No One 
	;   1 = Helps Allies only (Fellow Faction members and teammates) 
	;   2 = Helps faction friends and allies. 

	; Resistance
	; ActorValue Property pEnergyResist  Auto
	; ActorValue Property pFireResist    Auto
	; ActorValue Property pFrostResist   Auto
	; ActorValue Property pPoisonResist  Auto
	; ActorValue Property pDamageResist  Auto

	; General
	ActorValue Property pCarryWeight	Auto const 
	ActorValue Property pHealth			Auto const
	
	; ActorValue Property pActionPoints  Auto
	; ActorValue Property pMass          Auto
	; ActorValue Property pSpeedMult     Auto  ; Check if this is actually used
	; ActorValue Property pUnarmedDamage Auto  ; Check if this is actually used
	; ActorValue Property pHealRate      Auto

	; Custom
	ActorValue      Property pTweakOriginalRace				Auto Const	

	ActorValue      Property pTweakLastHitBy				Auto Const
	
	
	ActorBase      Property pTweakCompanionNora				Auto Const
	ActorBase      Property pTweakCompanionNate				Auto Const
	
	Perk  Property pTweakHealthBoost			Auto Const 
	Perk  Property pTweakDmgResistBoost			Auto Const 
	Perk  Property pTweakRangedDmgBoost			Auto Const 
	Perk  Property pCompanionInspirational		Auto Const
	Spell Property pAbMagLiveLoveCompanionPerks	Auto Const
	
	Spell Property TeleportOutSpell Auto Const
	Spell Property TeleportInSpell  Auto Const
	
	Quest Property TweakDLC01 Auto Const
	Quest Property TweakDLC03 Auto Const
	Quest Property TweakDLC04 Auto Const
	
EndGroup

Group LocalPersistance

	String    Property Name						Auto
	
	Bool      Property InBleedOut				Auto
	Bool      Property originalEssential		Auto
	Bool      Property originalProtected		Auto
	Bool      Property originalIgnoreHits		Auto
	
	Int       Property originalCarryWeight		Auto
	Int       Property originalAggression		Auto
	Int       Property originalMorality			Auto
	Int       Property originalConfidence		Auto
	Int       Property originalAssistance		Auto
	Int       Property lastCommandReceived		Auto
	
	float	  Property originalStrength			= 0.0 Auto  
	float	  Property originalPerception		= 0.0 Auto
	float	  Property originalEndurance		= 0.0 Auto
	float	  Property originalCharisma			= 0.0 Auto
	float	  Property originalIntelligence		= 0.0 Auto
	float	  Property originalAgility			= 0.0 Auto
	float	  Property originalLuck				= 0.0 Auto
	

	Location  Property originalHome				Auto
	Race      Property originalRace				Auto
	Faction[] Property originalFactions			Auto
	Faction   Property originalCrimeFaction		Auto

	Location  Property assignedHome				Auto
	
	ObjectReference  Property assignedHomeRef	Auto
	ObjectReference  Property originalHomeRef	Auto
	
	Bool Property teleportInOnLoad Auto

	; Faction        Property pTweakDownFaction				Auto
	; Faction        Property pTweakManagedInventoryFaction	Auto
	; Faction        Property pTweakReloadFaction			Auto
	; ReferenceAlias Property pBackpack						Auto
	; GlobalVariable Property pTweakLongRecovery			Auto
	
EndGroup

; Hidden
Int     Property enforceAggression	Auto Hidden
Int		Property enforceCarryWeight	Auto Hidden
Int		Property enforceConfidence	Auto Hidden
Bool    Property dynamicAssignment	Auto hidden
Bool    Property dynamicHome		Auto hidden
Bool    Property combatInProgress	Auto hidden
Bool	Property trackKills			Auto Hidden
int		Property numKilled			Auto Hidden

; Constants
int ONLOAD_FLOOD_PROTECT      = 998 const
; int ONHIT_FLOOD_PROTECT       = 997 const

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakSettings" + self.GetActorRef().GetFactionRank(pTweakNamesFaction)
	; string logName = "TweakSettings"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Event OnInit()
	dynamicAssignment = false
	dynamicHome       = false
	trackKills		  = false
	assignedHome      = None

	originalStrength		= 0
	originalPerception		= 0
	originalEndurance		= 0
	originalCharisma		= 0
	originalIntelligence	= 0
	originalAgility			= 0
	originalLuck			= 0

	originalFactions = new Faction[2]
	originalFactions[0] = Game.GetForm(0x000A1B85) as Faction ; HasBeenCompanionFaction
	originalFactions[1] = Game.GetForm(0x001EC1B9) as Faction ; PotentialCompanionFaction
EndEvent

Function EventPlayerSneakStart()

	if (2 == enforceAggression)
		Actor npc = self.GetActorRef()
		
		; When we make them unaggressive, we actually have to increase the assistance
		; value or they wont even defend the player when the player is attacked. 
		
		npc.SetValue(pFollowerStance, 0.0)
		npc.SetValue(pAggression,     0.0)
		npc.SetValue(pAssistance,     2.0)
		
		; NOTE: Bringing up the PipBoy to activate INFO causes PlayerSneak to
		; exit. So the info will not reflect these values unless done as 
		; a hotkey. 
		
	endIf
EndFunction

Function EventPlayerSneakExit()
	if (2 == enforceAggression)
		Actor npc = self.GetActorRef()
		
		; When we make them Aggressive, we dont need such a high assistance value		
		npc.SetValue(pFollowerStance, 1.0)
		npc.SetValue(pAggression,     1.0)
		npc.SetValue(pAssistance,     1.0)

		; NOTE: Bringing up the PipBoy to activate INFO causes PlayerSneak to
		; exit. So the info will not reflect these values unless done as 
		; a hotkey. If we want this to show up in info, we would need to 
		; set a timer and delay the actual change by 3 to 5 seconds. But that 
		; defeats the point....
		
	endIf	
EndFunction

float TradeHealth
Function EventTradeBegin()
	Actor npc = self.GetActorRef()
	npc.StartDeferredKill()
	TradeHealth = npc.GetValue(pHealth)
EndFunction

Function EventTradeEnd()
	Actor npc = self.GetActorRef()
	float currentHealth = npc.GetValue(pHealth)
	bool endDeferred = true
	if (TradeHealth != currentHealth)
		if (currentHealth < 0.0)
			npc.RestoreValue(pHealth, 9999)
			Utility.wait(0.1)
			bool wasEssential = npc.IsEssential()
			npc.SetEssential(true)
			npc.EndDeferredKill()
			endDeferred = false
			Utility.wait(0.1)
			if !wasEssential
				npc.SetEssential(false)
			endif
		endif
		npc.RemovePerk(pTweakDmgResistBoost)
		npc.RemovePerk(pTweakHealthBoost)
		npc.RemovePerk(pTweakRangedDmgBoost)
		npc.RemovePerk(pCompanionInspirational)
		npc.RemoveSpell(pAbMagLiveLoveCompanionPerks)		
		Utility.wait(1.0)
		Trace("Adding Perks Back")
		npc.AddPerk(pTweakDmgResistBoost)
		npc.AddPerk(pTweakHealthBoost)
		npc.AddPerk(pTweakRangedDmgBoost)
		npc.AddPerk(pCompanionInspirational)
		npc.AddSpell(pAbMagLiveLoveCompanionPerks)	
		Trace("Perks restored")
	endif
	if endDeferred
		npc.EndDeferredKill()
	endif		
EndFunction

; ObjectReference Cache:
;
;   ObjectReferences (instances) are normally only loaded when 
;   you enter a location (For memory management). GetForm() is 
;   runtime evaluated against current memory cache. So it 
;   it will return NONE for ObjectReferences (And Topics) unless
;   the requested ID happens to be in memory cache.
;
;   You can ensure an object is available by giving it an id
;   and the specifying/injecting the ID in the script variable
;   declarations. This gives the engine the hint it needs when
;   running the script to ensure the instance is loaded.



; Keyword Property ActorTypeCreature				Auto ; New 1.65
; Keyword property ActorTypeNPC 					Auto

; Bool property stealthFlag auto

;Event OnPackageStart(Package akNewPackage)
;endEvent

; type:
; 1 = Enemies\Hostile
; 2 = Non-Allies\Neutral
; 3 = Non-Teammates\Non-Followers

; One time operations (typically time consuming)
Function initialize()
	
	Actor npc = self.GetActorRef()
	Trace("initialize()  [" + npc.GetActorBase() + "]")
	WorkshopNPCScript    WNS = npc as WorkshopNPCScript
	CompanionActorScript CAS = npc as CompanionActorScript
	DogmeatActorScript   DAS = npc as DogmeatActorScript
	
	originalIgnoreHits   = npc.IsIgnoringFriendlyHits()
	originalAggression   = npc.GetBaseValue(pAggression)  As Int	
	
	; We want derrived carryweight. Most NPCs default to 250 so 
	; the actor record slaps on a -100 modifier. If we get base, 
	; we ignore the modifier can get inflated values. 
	
	originalCarryWeight  = npc.GetValue(pCarryWeight) As Int
	
	Trace("Original CarryWeight [" + originalCarryWeight + "]")
	
	originalStrength     = npc.GetBaseValue(pStrength)
	originalPerception   = npc.GetBaseValue(pPerception)
	originalEndurance    = npc.GetBaseValue(pEndurance)
	originalCharisma     = npc.GetBaseValue(pCharisma)
	originalIntelligence = npc.GetBaseValue(pIntelligence)
	originalAgility      = npc.GetBaseValue(pAgility)
	originalLuck         = npc.GetBaseValue(pLuck)	
	
	originalRace         = npc.GetRace()
	originalEssential    = npc.IsEssential()
	originalProtected    = npc.GetActorBase().IsProtected()
	
	if originalCarryWeight < 150
		Trace("Adjusting Original Carry Weight to 150")
		originalCarryWeight = 150
	endif
	
	Trace("originalEssential [" + originalEssential + "] (current instance)")
	Trace("originalProtected [" + originalProtected + "] (ActorBase)")
	
	; We simplify things. No one is protected. THere is only Essential and 
	; Not essential. This is convenient since Actor instances can have 
	; essential overrides (There is Actor.IsEssential). There is no counter
	; part for detecting if an instance is protected.
	
	npc.SetProtected(false)
	npc.SetEssential(true)
		
	; Fast Access for TweakPipBoy/Appearance => Race Support
	if originalRace.GetFormID() < 0x01000000
		npc.SetValue(pTweakOriginalRace, originalRace.GetFormID())
	else
		npc.SetValue(pTweakOriginalRace, -1)
	endif	
	
	originalMorality     = npc.GetBaseValue(pMorality)    As Int
	originalConfidence   = npc.GetBaseValue(pConfidence)  As Int
	originalAssistance   = npc.GetBaseValue(pAssistance)  As Int
	
	; NOTE That iFollower_Stance_Aggressive is not used by the vanilla game. We keep it
	; synched with Aggression as a courtesy in case a future patch or DLC 
	; begins to make use of it. 
	npc.SetValue(pFollowerStance, iFollower_Stance_Aggressive.GetValue())

	; Default : Auto Aggression based on Sneak State. Start them off Aggressive
	npc.SetValue(pFollowerStance, 1.0)
	npc.SetValue(pAggression,     1.0)
	npc.SetValue(pAssistance,     1.0)
	SetFollowerStanceAuto()	; enforceAggression	 = 2
	
	
	enforceCarryWeight   = -1
	enforceConfidence    = originalConfidence

	
	if (enforceConfidence < 3)
		enforceConfidence = 3
	endIf
	
	; stealthFlag = false
	int NameID     = npc.GetFactionRank(pTweakNamesFaction)
	int FollowerID = npc.GetFactionRank(pTweakFollowerFaction)
	
	AFT:TweakNamesScript pTweakNamesScript = (pTweakNames as AFT:TweakNamesScript)
	if pTweakNamesScript
		Name = pTweakNamesScript.IdToString(NameID)
	endif
	
	; Report crimes to no one. This also prevents followers from turning on PC when PC attacks NPC's faction members. 
	originalCrimeFaction = npc.GetCrimeFaction()
	npc.SetCrimeFaction(None)
	
	bool wasVoiced = false
	Faction Voices_CompanionsFaction = Game.GetForm(0x00056122) as Faction ; Voices_CompanionsFaction
	if (npc.IsInFaction(Voices_CompanionsFaction))
		originalFactions.Add(Voices_CompanionsFaction)
		wasVoiced = true
	endif
	
	bool wasDLCRobot = false
	Faction RobotFaction = None
	ActorBase base  = npc.GetActorBase()
	int ActorBaseID = base.GetFormID()
	int pluginID = GetPluginID(ActorBaseID)
	Faction f = None
	bool clearfactions = true
	bool corecompanion = false
	
	if ActorBaseID > 0x00ffffff
		clearfactions = false
	endIf
	; Ada is 0x0100FD5A
	TweakDLC01Script pTweakDLC01 = TweakDLC01 as TweakDLC01Script
	TweakDLC03Script pTweakDLC03 = TweakDLC03 as TweakDLC03Script
	TweakDLC04Script pTweakDLC04 = TweakDLC04 as TweakDLC04Script
	
	if pTweakDLC01 && pTweakDLC01.Installed
		if pluginID == pTweakDLC01.resourceID
			clearfactions = true
		endif
	endif
	if pTweakDLC03 && pTweakDLC03.Installed
		if pluginID == pTweakDLC03.resourceID
			clearfactions = true
		endIf
	endIf
	if pTweakDLC04 && pTweakDLC04.Installed
		if pluginID == pTweakDLC04.resourceID
			clearfactions = true
		endIf
	endIf

	; BUG 1.17: We don't rely on the proxy here as auto-import on an existing
	; save may beat the proxy initialization....
	if (Game.IsPluginInstalled("DLCRobot.esm") || (pTweakDLC01 && pTweakDLC01.Installed))	
		Faction pDLC01WorkshopRobotFaction = Game.GetFormFromFile(0x0100F47A,"DLCRobot.esm") As Faction
		if pDLC01WorkshopRobotFaction && npc.IsInFaction(pDLC01WorkshopRobotFaction)
			originalFactions.Add(pDLC01WorkshopRobotFaction)
			wasDLCRobot = true
		elseif pTweakDLC01.DLC01WorkshopRobotFaction && npc.IsInFaction(pTweakDLC01.DLC01WorkshopRobotFaction)
			originalFactions.Add(pTweakDLC01.DLC01WorkshopRobotFaction)
			wasDLCRobot = true		
		endif
	endif
	
	trace("Setting Default : pTeammateReadyWeapon_DO")
	; UPDATE: Default is pTeammateReadyWeapon_DO (Except Dogmeat)
	
	npc.AddKeyword(pTeammateReadyWeapon_DO)
	
	if (base == Game.GetForm(0x00079249) as ActorBase)     ; 1 ---=== Cait ===---
	
		Trace("Cait Detected.")
		corecompanion = true
		originalHome    = Game.GetForm(0x0001905B) as Location ; CombatZoneLocation
		originalHomeRef = CaitPostCombatMarker01
		
	elseif (base == Game.GetForm(0x000179FF) as ActorBase) ; 2 ---=== Codsworth ===---
	
		Trace("Codsworth Detected.")
		corecompanion = true
		originalHome = Game.GetForm(0x0001F229) as Location ; SanctuaryHillsPlayerHouseLocation
        originalHomeRef = CodsworthKitchenMarker
		
		f = Game.GetForm(0x0001D566) as Faction ; CrimeConcordArea
		if (f)
			Trace("Adding Faction CrimeConcordArea")
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x0001D566 to Faction CrimeConcordArea")
		endIf
		
		Trace("Adding Faction PlayerFaction")
		originalFactions.Add(pPlayerFaction)
		
		f = Game.GetForm(0x0001D567) as Faction ; SettlementConcordArea
		if (f)
			Trace("Adding Faction SettlementConcordArea")
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x0001D567 to Faction SettlementConcordArea")
		endIf
		f = Game.GetForm(0x000337F3) as Faction ; WorkshopNPCFaction
		if (f)
			Trace("Adding Faction WorkshopNPCFaction")
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x000337F3 to Faction WorkshopNPCFaction")
		endIf
		
	elseif (base == Game.GetForm(0x00027686) as ActorBase) ; 3 ---=== Curie ===---
	
		Trace("Curie Detected.")
		corecompanion = true
		originalHome    = Game.GetForm(0x0002BE8D) as Location ; Vault81Location
		originalHomeRef = COMCurieIntroMarker		
		originalRace = Game.GetForm(0x000359F4) as Race		; HandyRace

		; This actorvalue controls appearance restrictions. We set to human 
		; So that you can pose Curie once she changes to human. 
		npc.SetValue(pTweakOriginalRace, pHumanRace.GetFormID())
		
	elseif (base == Game.GetForm(0x00027683) as ActorBase) ; 4 ---=== Danse ===---
	
		Trace("Danse Detected.")
		corecompanion = true

		
		Quest BoS201 = Game.GetForm(0x0002BF21) as Quest
		if BoS201 && BoS201.GetStageDone(90)
			originalHome = Game.GetForm(0x00076A38) as Location ; PrydwenLocation
			originalHomeRef = BoS201DanseMessHallMarker
		else
			originalHome = Game.GetForm(0x0001FA4A) as Location ; CambridgePDLocation
			originalHomeRef = BoS101PlayerStartMarker
		endif
		
		assignedHome = originalHome
		assignedHomeRef = originalHomeRef

		f = Game.GetForm(0x001B513D) as Faction ; Bos100FightFaction
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x001B513D to Faction Bos100FightFaction")
		endIf		
		f = Game.GetForm(0x0005DE41) as Faction ; BrotherhoodofSteelFaction
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x0005DE41 to Faction BrotherhoodofSteelFaction")
		endIf		
		f = Game.GetForm(0x00176057) as Faction ; CIS_ChatWithNPCFaction_Danse
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x00176057 to Faction CIS_ChatWithNPCFaction_Danse")
		endIf	
		
	elseif (base == Game.GetForm(0x00045AC9) as ActorBase) ; 5 ---=== Deacon ===---
	
		Trace("Deacon Detected.")
		corecompanion = true
		originalHome    = Game.GetForm(0x000482C2) as Location ; RailroadHQLocation
		originalHomeRef = DeaconHomeMarker

		f = Game.GetForm(0x000BDAAA) as Faction ; CrimeRailroadHQ
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x000BDAAA to Faction CrimeRailroadHQ")
		endIf
		f = Game.GetForm(0x000994F6) as Faction ; RailroadFaction
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x000994F6 to Faction RailroadFaction")
		endIf
		
	elseif (base == Game.GetForm(0x0001D15C) as ActorBase) ; 6 ---=== Dogmeat ===---
	
		Trace("Dogmeat Detected.")
		corecompanion = true
		originalHome = Game.GetForm(0x00024FAB) as Location ; RedRocketTruckStopLocation
		originalHomeRef = RedRocketCenterMarker
		
		f = Game.GetForm(0x0006E269) as Faction ; DogmeatFaction
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x0006E269 to Faction DogmeatFaction")
		endIf
		f = Game.GetForm(0x00106C30) as Faction ; PlayerAllyFaction
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x00106C30 to Faction PlayerAllyFaction")
		endIf
		
		npc.RemoveKeyword(pTeammateReadyWeapon_DO)
		
	elseif (base == Game.GetForm(0x00022613) as ActorBase) ; 7 ---=== Hancock ===---	

		Trace("Hancock Detected.")
		corecompanion = true
		originalHome = Game.GetForm(0x0002260F) as Location ; GoodneighborOldStateHouseLocation	
		originalHomeRef = MS04HancockEndMarker

		f = Game.GetForm(0x000228A8) as Faction ; CrimeGoodneighbor
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x000228A8 to Faction CrimeGoodneighbor")
		endIf
		f = Game.GetForm(0x000E1ACD) as Faction ; GoodneighborOldStateHouseOwnerFaction
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x000E1ACD to Faction GoodneighborOldStateHouseOwnerFaction")
		endIf
		f = Game.GetForm(0x000228A9) as Faction ; SettlementGoodneighbor
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x000228A9 to Faction SettlementGoodneighbor")
		endIf		
		
	elseif (base == Game.GetForm(0x0002740E) as ActorBase) ; 8 ---=== MacCready ===---	
	
		Trace("MacCready Detected.")
		corecompanion = true
		originalHome = Game.GetForm(0x0002267F) as Location ; GoodneighborTheThirdRailLocation
		originalHomeRef = COMMacCreadyStartMarker

		f = Game.GetForm(0x000228A8) as Faction ; CrimeGoodneighbor
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x000228A8 to Faction CrimeGoodneighbor")
		endIf
		f = Game.GetForm(0x000228A9) as Faction ; SettlementGoodneighbor
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x000228A9 to Faction SettlementGoodneighbor")
		endIf
		f = Game.GetForm(0x0003CDE5) as Faction ; Voices_FollowersFaction_AO_Sniper
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x0003CDE5 to Faction Voices_FollowersFaction_AO_Sniper")
		endIf				
		
	elseif (base == Game.GetForm(0x00002F24) as ActorBase) ; 9 ---=== Nick Valentine ===---
	
		Trace("Nick Detected.")
		corecompanion = true
		originalHome = Game.GetForm(0x00003979) as Location ; DiamondCityValentinesLocation
		originalHomeRef = MS07NickOfficeMarker		

		f = Game.GetForm(0x0003E0C8) as Faction ; CaptiveFaction
		if (f)
			if (npc.IsInFaction(f))
				originalFactions.Add(f)
			endif
		else
			Trace("Failure to cast 0x0003E0C8 to Faction CaptiveFaction")
		endIf
		f = Game.GetForm(0x00002CB4) as Faction ; CrimeDiamondCity
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x00002CB4 to Faction CrimeDiamondCity")
		endIf
		f = Game.GetForm(0x000C866B) as Faction ; DmndValentinesOwnerFaction
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x000C866B to Faction DmndValentinesOwnerFaction")
		endIf
		f = Game.GetForm(0x00106C30) as Faction ; PlayerAllyFaction
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x00106C30 to Faction PlayerAllyFaction")
		endIf
		f = Game.GetForm(0x00002CB3) as Faction ; SettlementDiamondCity
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x00002CB3 to Faction SettlementDiamondCity")
		endIf		
		
	elseif (base == Game.GetForm(0x00002F1E) as ActorBase) ; 10 ---=== Piper ===---	
	
		Trace("Piper Detected.")
		corecompanion = true
		originalHome = Game.GetForm(0x00003962) as Location ; DiamondCityPublickOccurrencesLocation
		originalHomeRef = MQ201BPiperTravelMarker02

		f = Game.GetForm(0x00002CB4) as Faction ; CrimeDiamondCity
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x00002CB4 to Faction CrimeDiamondCity")
		endIf
		f = Game.GetForm(0x000644E5) as Faction ; DmndPublickOwnerFaction
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x000644E5 to Faction DmndPublickOwnerFaction")
		endIf		
		f = Game.GetForm(0x00002CB3) as Faction ; SettlementDiamondCity
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x00002CB3 to Faction SettlementDiamondCity")
		endIf
		
	elseif (base == Game.GetForm(0x00019FD9) as ActorBase) ; 11 ---=== Preston ===---
	
		Trace("Preston Detected.")
		corecompanion = true
		originalHome = Game.GetForm(0x0001F228) as Location ; SanctuaryHillsLocation
		originalHomeRef = SanctuaryLocationCenterMarker

		f = Game.GetForm(0x00068043) as Faction ; MinutemenFaction
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x00068043 to Faction MinutemenFaction")
		endIf
		f = Game.GetForm(0x0001D567) as Faction ; SettlementConcordArea
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x0001D567 to Faction SettlementConcordArea")
		endIf
		f = Game.GetForm(0x0024674F) as Faction ; WorkshopNoTrade
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x0024674F to Faction WorkshopNoTrade")
		endIf
		f = Game.GetForm(0x000337F3) as Faction ; WorkshopNPCFaction
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x000337F3 to Faction WorkshopNPCFaction")
		endIf		
		
	elseif (base == Game.GetForm(0x00027682) as ActorBase) ; 12 ---=== Strong ===---
	
		Trace("Strong Detected.")
		corecompanion = true
		originalHome = Game.GetForm(0x0001DAF7) as Location ; TrinityTowerLocation
		originalHomeRef = MS10SafetyMarker

		if originalCarryWeight < 200
			originalCarryWeight = 200
		endif
		
	elseif (base == Game.GetForm(0x000BBEE6) as ActorBase) ; 13 ---=== X6-88 ===---	
	
		Trace("X6-88 Detected.")
		corecompanion = true
		originalHome = Game.GetForm(0x001BBC22) as Location ; InstituteSRBLocation	
		originalHomeRef = InstSceneAlaneJustin1JustinMarker
		
		f = Game.GetForm(0x000A95E6) as Faction ; CrimeInstitute
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x000A95E6 to Faction CrimeInstitute")
		endIf
		f = Game.GetForm(0x0005E558) as Faction ; InstituteFaction
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x0005E558 to Faction InstituteFaction")
		endIf
		f = Game.GetForm(0x00083B31) as Faction ; SynthFaction
		if (f)
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x00083B31 to Faction SynthFaction")
		endIf
		
	elseif (base == pTweakCompanionNate) ; ---=== Nate ===---	
	
		Trace("Nate Detected")
		
		corecompanion = true
		originalHome = Game.GetForm(0x0001F229) as Location ; SanctuaryHillsPlayerHouseLocation
		originalHomeRef = CodsworthKitchenMarker
		
		Trace("Adding Faction PlayerFaction")
		originalFactions.Add(pPlayerFaction)
		
		f = Game.GetForm(0x0001D567) as Faction ; SettlementConcordArea
		if (f)
			Trace("Adding Faction SettlementConcordArea")
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x0001D567 to Faction SettlementConcordArea")
		endIf
		f = Game.GetForm(0x000337F3) as Faction ; WorkshopNPCFaction
		if (f)
			Trace("Adding Faction WorkshopNPCFaction")
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x000337F3 to Faction WorkshopNPCFaction")
		endIf
	
	elseif (base == pTweakCompanionNora) ; ---=== Nora ===---	
	
		Trace("Nora Detected")
		
		corecompanion = true
		originalHome = Game.GetForm(0x0001F229) as Location ; SanctuaryHillsPlayerHouseLocation
		originalHomeRef = CodsworthKitchenMarker
		
		Trace("Adding Faction PlayerFaction")
		originalFactions.Add(pPlayerFaction)
		
		f = Game.GetForm(0x0001D567) as Faction ; SettlementConcordArea
		if (f)
			Trace("Adding Faction SettlementConcordArea")
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x0001D567 to Faction SettlementConcordArea")
		endIf
		f = Game.GetForm(0x000337F3) as Faction ; WorkshopNPCFaction
		if (f)
			Trace("Adding Faction WorkshopNPCFaction")
			originalFactions.Add(f)
		else
			Trace("Failure to cast 0x000337F3 to Faction WorkshopNPCFaction")
		endIf
	else
	
		if (ActorBaseID > 0x00ffffff)
		
			; Eliminate first two digits...
			; NOTE: This may fail for users with lots of mods. Modulous
			; may be unreliable with Larger ints (greater than 0x80000000)
			int ActorBaseMask
			
			if ActorBaseID > 0x80000000			
				ActorBaseMask = (ActorBaseID - 0x80000000) % (0x01000000)
			else
				ActorBaseMask = ActorBaseID % (0x01000000)
			endif
			
			; Now compare MASK
			if     0x0000FD5A == ActorBaseMask ; Ada
				corecompanion = true
				if (CAS)
					originalHome    = Game.GetForm(0x00024FAB) as Location ; RedRocketTruckStopLocation
					originalHomeRef = RedRocketCenterMarker
					assignedHome    = originalHome
					assignedHomeRef = originalHomeRef					
				endIf				
			elseif 0x00006E5B == ActorBaseMask ; Longfellow
				corecompanion = true
				if pTweakDLC03 && pTweakDLC03.Installed				
					originalHome    = pTweakDLC03.LongfellowCabinLocation
					originalHomeRef = pTweakDLC03.DLC03LongfellowCabinRef
					assignedHome    = originalHome
					assignedHomeRef = originalHomeRef					
				else
					; Set to None so that he picks up dynamic assignment... (Drops an XMarker)
					originalHome    = None
					originalHomeRef = None
				endIf
			elseif 0x0000881D == ActorBaseMask ; Porter Gage
				corecompanion = true
				if pTweakDLC04 && pTweakDLC04.Installed				
					originalHome    = pTweakDLC04.NukaTownUSALocation
					originalHomeRef = pTweakDLC04.DLC04MQ02OverlookGageMarker
					assignedHome    = originalHome
					assignedHomeRef = originalHomeRef					
				else
					; Set to None so that he picks up dynamic assignment... (Drops an XMarker)
					originalHome    = None
					originalHomeRef = None
				endIf
			endif
		endif
		
		if !corecompanion
			if (CAS)
				originalHome    = CAS.HomeLocation
				originalHomeRef = LocationToMarkerRef(originalHome)
			elseif (DAS)
				originalHome    = DAS.HomeLocation
				originalHomeRef = LocationToMarkerRef(originalHome)
			endIf
		endif
		
		if (!originalHome && WNS)
			WorkshopParentScript pWorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
			int workshopID = npc.GetValue(pWorkshopParent.WorkshopIDActorValue) as int
			if (workshopID > -1)
				originalHome    = WorkShopIDToLocation(workshopID)
				originalHomeRef = LocationToWorkShopRef(originalHome)
			endif
		endif
		
		if (!originalHome)
		
			; Sometimes GetCurrentLocation() returns NONE. There ARE
			; Cells that are only associated with a Worldspace and 
			; not a Location. 
			
			originalHome    = npc.GetCurrentLocation()
			if originalHome
				dynamicHome     = true
				originalHomeRef = npc.PlaceAtMe(XMarkerHeading, 1, true)
			endif
		endif		
		
		int numFactions = pTweakCommonFactions.GetSize()
		int i = 0
		while (i < numFactions)
			f = pTweakCommonFactions.GetAt(i) as Faction
			if npc.IsInFaction(f)
				Trace("Adding Faction [" + f + "]")
				originalFactions.Add(f)
			endif
			i += 1
		endwhile
		Trace("Faction Scan Complete")
								
	endif

	; Factions can make NPCs start fighting each other. IE: Pickup a synth and a BOS
	; NPC and they will just start going at it all the time. Strip them of their 
	; factions and they play nice. 
		
	Faction SalemFaction = Game.GetForm(0x0002C125) as Faction
		
	; Update : Faction removal only on non-core companions
	;          or Custom Companions with the Salem Branding...
	if !corecompanion && clearfactions && !npc.IsInFaction(SalemFaction)
		trace("Clearing Factions (Not CORE Companion)")
		npc.RemoveFromAllFactions()
		npc.AddToFaction(pPlayerFaction)	
	endif
	
	npc.AddToFaction(originalFactions[0])
	npc.AddToFaction(originalFactions[1])
	
	if (npc.HasKeyword(pTeammateReadyWeapon_DO))
		npc.AddToFaction(pTweakReadyWeaponFaction)
	endif
		
	; Bug 1.03 : Meant to make non-sync default...
	; npc.AddToFaction(pTweakSyncPAFaction)
	
	if trackKills
		npc.AddToFaction(pTweakTrackKills)
	endif
		
	if !originalHome
		Trace("Using Default Home Location (SanctuaryHillsPlayerHouseLocation)")
		originalHome    = Game.GetForm(0x0001F229) as Location ; SanctuaryHillsPlayerHouseLocation
	endif
	if !originalHomeRef
		Trace("Using Default Home Reference (CodsworthKitchenMarker)")
		originalHomeRef = CodsworthKitchenMarker
	endif
	
	Trace("originalHome    : [" + originalHome + "]")
	Trace("originalHomeRef : [" + originalHomeRef + "]")
			
	if (WNS)
		WorkshopParentScript pWorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
		int workshopID = npc.GetValue(pWorkshopParent.WorkshopIDActorValue) as int
		if (workshopID > -1 && "assigned"  == WNS.getState())
			assignedHome    = WorkShopIDToLocation(workshopID)
			assignedHomeRef = LocationToWorkShopRef(assignedHome)
			npc.AddToFaction(pTweakSkipGoHomeFaction)
		endif
	endif
	
	if (!assignedHome)
		if (CAS)
			assignedHome    = CAS.HomeLocation
		elseif (DAS)
			assignedHome    = DAS.HomeLocation
		endIf
		if (!assignedHome)
			assignedHome 	= originalHome
		endIf
	endif
	
	((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHome = assignedHome
	
	if (!assignedHomeRef)
		if (CAS && CAS.HomeLocation)
			assignedHomeRef = LocationToMarkerRef(CAS.HomeLocation)
		elseif (DAS && DAS.HomeLocation)
			assignedHomeRef = LocationToMarkerRef(DAS.HomeLocation)
		endIf
		if (!assignedHomeRef)
			assignedHomeRef = originalHomeRef
		endIf
	endif
	
	((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef = assignedHomeRef
	npc.SetLinkedRef(assignedHomeRef,pTweakLocHome)
	
	if (wasVoiced)
		npc.AddToFaction(Voices_CompanionsFaction)
	endif
	if (wasDLCRobot)
		npc.AddToFaction(RobotFaction)
	endif
	
	npc.SetFactionRank(pTweakFollowerFaction, FollowerID)
	npc.SetFactionRank(pTweakNamesFaction,    NameID)

	; By Default, add new NPCs to this faction:
	npc.AddToFaction(pTweakEssentialFaction)

	if (base == Game.GetForm(0x0001D15C) as ActorBase) ; 6 ---=== Dogmeat ===---
		Trace("Adding Dogmeat to TweakRangedFaction")
		npc.AddToFaction(pTweakRangedFaction)
	endif
	
	combatInProgress = false
	
endFunction

Function EventOnGameLoad()
EndFunction

; Every time they join the PC.
Function EventFollowingPlayer(bool firstTime=false)

	Actor npc          = self.GetActorRef()
	Trace("EventFollowingPlayer()  [" + npc.GetActorBase() + "]")
	
	npc.AddToFaction(pCurrentCompanionFaction)	
	enforceSettings()
	
endFunction

Function EventPlayerWeaponDraw()
	Trace("EventPlayerWeaponDraw()")
	Actor npc = self.GetActorReference()
	if (DistanceWithin(Game.GetPlayer(),npc,51))
		Trace("Player is too close. Teleporting behind player... (calling TweakFollowerScript.MoveToPlayer)")
		TweakFollowerScript pTweakFollowerScript = (GetOwningQuest() as TweakFollowerScript)
		if pTweakFollowerScript
			pTweakFollowerScript.MoveToPlayer(npc)	
		endif
	else
		float distance = Game.GetPlayer().GetDistance(npc)
		Trace("Player is [" + distance + "] from npc. Not within 50. Ignoring Event")		
	endif
EndFunction

Function AttackVisible()
 
 	Actor npc = self.GetActorRef()
	npc.SetValue(pConfidence,4)
 	npc.SetValue(pAggression, 2)
	npc.EvaluatePackage()

 	; Have NPC "Peek" at surroundings (Normally they only see the player)
 	Utility.wait(0.25);
 	npc.SetPlayerTeammate(false)
	
	; This may cause issues in the combat change state handler and the OnLoad
	; Handler. I don't think Faction membership removal is necessary to get NPCs 
	; to attack. Teammate status is the main thing....
	
 	; npc.RemoveFromFaction(pCurrentCompanionFaction) 
	
 	Utility.wait(2.5)
 	npc.SetPlayerTeammate(true)
	
 	; npc.AddToFaction(pCurrentCompanionFaction)

	npc.SetValue(pConfidence,enforceConfidence)
	if (enforceAggression < 2)
		npc.SetValue(pAggression,enforceAggression)
	else
		npc.SetValue(pAggression,1)
	endif
 
endFunction

Function UnManage()

	; UnManage is similar to DEATH, but we try to return them to their original
	; state as best we can. In some cases we can't. IE: If the Player Scuplts an NPC's appearance, 
	; there is nothing we can do to restore it.
	
	Actor npc = self.GetActorRef()
	npc.SetLinkedRef(None, pTweakLocHome)
	
	if (dynamicAssignment) ; Needs Cleanup...
		dynamicAssignment = false
		if assignedHomeRef
			assignedHomeRef.Disable()
			assignedHomeRef.Delete()
			if ((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef
				((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef.Disable()
				((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef.Delete()
			endif
		endif
	else
		trace("dynamicAssignment is false")
	endif
	
	assignedHomeRef = None
	((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef = None			

	if npc.GetRace() != originalRace
		if npc.GetActorBase() != (Game.GetForm(0x00027686) as ActorBase) ; 3 ---=== Curie ===---
			npc.SetRace(originalRace)
		endif
	endif
	
	npc.IgnoreFriendlyHits(originalIgnoreHits)
	npc.SetValue(pAggression,  originalAggression)
	npc.SetValue(pCarryWeight, originalCarryWeight)
	npc.SetValue(pMorality,    originalMorality)
	npc.SetValue(pConfidence,  originalConfidence)
	npc.SetValue(pAssistance,  originalAssistance)

	bool corecompanion = false	
	ActorBase base  = npc.GetActorBase()
	int ActorBaseID = base.GetFormID()
	
	if (base == Game.GetForm(0x00079249) as ActorBase)     ; 1 ---=== Cait ===---
		corecompanion = true
	elseif (base == Game.GetForm(0x000179FF) as ActorBase) ; 2 ---=== Codsworth ===---
		corecompanion = true
	elseif (base == Game.GetForm(0x00027686) as ActorBase) ; 3 ---=== Curie ===---
		corecompanion = true
	elseif (base == Game.GetForm(0x00027683) as ActorBase) ; 4 ---=== Danse ===---
		corecompanion = true
	elseif (base == Game.GetForm(0x00045AC9) as ActorBase) ; 5 ---=== Deacon ===---
		corecompanion = true
	elseif (base == Game.GetForm(0x0001D15C) as ActorBase) ; 6 ---=== Dogmeat ===---
		corecompanion = true
	elseif (base == Game.GetForm(0x00022613) as ActorBase) ; 7 ---=== Hancock ===---	
		corecompanion = true
	elseif (base == Game.GetForm(0x0002740E) as ActorBase) ; 8 ---=== MacCready ===---	
		corecompanion = true
	elseif (base == Game.GetForm(0x00002F24) as ActorBase) ; 9 ---=== Nick Valentine ===---
		corecompanion = true
	elseif (base == Game.GetForm(0x00002F1E) as ActorBase) ; 10 ---=== Piper ===---	
		corecompanion = true
	elseif (base == Game.GetForm(0x00019FD9) as ActorBase) ; 11 ---=== Preston ===---
		corecompanion = true
	elseif (base == Game.GetForm(0x00027682) as ActorBase) ; 12 ---=== Strong ===---
		corecompanion = true
	elseif (base == Game.GetForm(0x000BBEE6) as ActorBase) ; 13 ---=== X6-88 ===---	
		corecompanion = true
	elseif (base == pTweakCompanionNate)	
		corecompanion = true
	elseif (base == pTweakCompanionNora)	
		corecompanion = true
	else
		if (ActorBaseID > 0x00ffffff)
			int ActorBaseMask
			if ActorBaseID > 0x80000000			
				ActorBaseMask = (ActorBaseID - 0x80000000) % (0x01000000)
			else
				ActorBaseMask = ActorBaseID % (0x01000000)
			endif
			
			; Now compare MASK
			if     0x0000FD5A == ActorBaseMask ; Ada
				corecompanion = true
			elseif 0x00006E5B == ActorBaseMask ; Longfellow
				corecompanion = true
			elseif 0x0000881D == ActorBaseMask ; Porter Gage
				corecompanion = true
			endif
		endif
	endif	
	
	if !corecompanion
		bool clearfactions = true
		if ActorBaseID > 0x00ffffff
			clearfactions = false
			
			TweakDLC01Script pTweakDLC01 = TweakDLC01 as TweakDLC01Script
			TweakDLC03Script pTweakDLC03 = TweakDLC03 as TweakDLC03Script
			TweakDLC04Script pTweakDLC04 = TweakDLC04 as TweakDLC04Script
			int pluginID = GetPluginID(ActorBaseID)
			
			if pTweakDLC01 && pTweakDLC01.Installed
				if pluginID == pTweakDLC01.resourceID
					clearfactions = true
				endif
			endif
			if pTweakDLC03 && pTweakDLC03.Installed
				if pluginID == pTweakDLC03.resourceID
					clearfactions = true
				endIf
			endIf
			if pTweakDLC04 && pTweakDLC04.Installed
				if pluginID == pTweakDLC04.resourceID
					clearfactions = true
				endIf
			endIf
		endIf

		; 0x0002C125 = Salem Faction....
		if clearfactions && !npc.IsInFaction(Game.GetForm(0x0002C125) as Faction)
			npc.RemoveFromAllFactions()
			int numFactions = originalFactions.Length
			int i = 0
			while (i < numFactions)
				npc.AddToFaction(originalFactions[i])
				i += 1
			endWhile
			; npc.AddToFaction(PlayerFaction)
			if (originalCrimeFaction)
				npc.AddToFaction(originalCrimeFaction)
				originalCrimeFaction = None
				npc.MakePlayerFriend() ; In case PC attacked their faction
			endif
		else
			; Remove all the TweakFactions....
			Faction TweakBoomstickFaction     = Game.GetFormFromFile(0x01010E6D,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakBruiserFaction       = Game.GetFormFromFile(0x01010E6E,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakCampOutFitFaction    = Game.GetFormFromFile(0x01035657,"AmazingFollowerTweaks.esp") as Faction			
			Faction TweakCityOutFitFaction    = Game.GetFormFromFile(0x01035658,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakCombatOutFitFaction  = Game.GetFormFromFile(0x01035656,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakCommandoFaction      = Game.GetFormFromFile(0x01010E6F,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakConvNegToPos         = Game.GetFormFromFile(0x01041598,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakConvPosToNeg         = Game.GetFormFromFile(0x01041599,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakCrimeFaction_Ignored = Game.GetFormFromFile(0x0101BB22,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakEnhancedFaction      = Game.GetFormFromFile(0x01010E83,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakEnterPAFaction       = Game.GetFormFromFile(0x01025B22,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakGunslingerFaction    = Game.GetFormFromFile(0x01010E70,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakHangoutFaction       = Game.GetFormFromFile(0x01013451,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakHomeOutFitFaction    = Game.GetFormFromFile(0x0101FAAE,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakIgnoredFaction       = Game.GetFormFromFile(0x01068A47,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakManagedOutfit        = Game.GetFormFromFile(0x0101F312,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakNinjaFaction         = Game.GetFormFromFile(0x01010E71,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakNoApprove            = Game.GetFormFromFile(0x01041592,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakNoCommentActivator   = Game.GetFormFromFile(0x01041596,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakNoCommentApprove     = Game.GetFormFromFile(0x01041594,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakNoCommentDisapprove  = Game.GetFormFromFile(0x01041595,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakNoCommentGeneral     = Game.GetFormFromFile(0x01041593,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakNoDisapprove         = Game.GetFormFromFile(0x0103FEBC,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakNoIdleChatter        = Game.GetFormFromFile(0x0104FB5C,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakNoCasFaction         = Game.GetFormFromFile(0x0103F70B,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakNoRelaxFaction       = Game.GetFormFromFile(0x0103FEBE,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakPackMuleFaction      = Game.GetFormFromFile(0x0106550A,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakPAHelmetCombatToggleFaction = Game.GetFormFromFile(0x0103FEBA,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakPosedFaction         = Game.GetFormFromFile(0x0101FF8F,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakRotateLockFollowerFaction= Game.GetFormFromFile(0x0100C1FB,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakSniperFaction        = Game.GetFormFromFile(0x01010E72,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakStandardOutfitFaction= Game.GetFormFromFile(0x0103658C,"AmazingFollowerTweaks.esp") as Faction
			Faction TweakSwimOutfitFaction    = Game.GetFormFromFile(0x010106DC,"AmazingFollowerTweaks.esp") as Faction
			
			if npc.IsInFaction(pTweakAllowFriendlyFire)
				npc.RemoveFromFaction(pTweakAllowFriendlyFire)
			endif
			if npc.IsInFaction(pTweakAutoStanceFaction)
				npc.RemoveFromFaction(pTweakAutoStanceFaction)
			endif
			if npc.IsInFaction(TweakBoomstickFaction)
				npc.RemoveFromFaction(TweakBoomstickFaction)
			endif
			if npc.IsInFaction(TweakBruiserFaction)
				npc.RemoveFromFaction(TweakBruiserFaction)
			endif
			if npc.IsInFaction(pTweakCampHomeFaction)
				npc.RemoveFromFaction(pTweakCampHomeFaction)
			endif
			if npc.IsInFaction(TweakCampOutFitFaction)
				npc.RemoveFromFaction(TweakCampOutFitFaction)
			endif	
			if npc.IsInFaction(TweakCityOutFitFaction)
				npc.RemoveFromFaction(TweakCityOutFitFaction)
			endif
			if npc.IsInFaction(TweakCombatOutFitFaction)
				npc.RemoveFromFaction(TweakCombatOutFitFaction)
			endif
			if npc.IsInFaction(TweakCommandoFaction)
				npc.RemoveFromFaction(TweakCommandoFaction)
			endif
			if npc.IsInFaction(TweakConvNegToPos)
				npc.RemoveFromFaction(TweakConvNegToPos)
			endif
			if npc.IsInFaction(TweakConvPosToNeg)
				npc.RemoveFromFaction(TweakConvPosToNeg)
			endif
			if npc.IsInFaction(TweakCrimeFaction_Ignored)
				npc.RemoveFromFaction(TweakCrimeFaction_Ignored)
			endif
			if npc.IsInFaction(TweakEnhancedFaction)
				npc.RemoveFromFaction(TweakEnhancedFaction)
			endif
			if npc.IsInFaction(TweakEnterPAFaction)
				npc.RemoveFromFaction(TweakEnterPAFaction)
			endif
			if npc.IsInFaction(pTweakEssentialFaction)
				npc.RemoveFromFaction(pTweakEssentialFaction)
			endif
			if npc.IsInFaction(pTweakFollowerFaction)
				npc.RemoveFromFaction(pTweakFollowerFaction)
			endif
			if npc.IsInFaction(TweakGunslingerFaction)
				npc.RemoveFromFaction(TweakGunslingerFaction)
			endif
			if npc.IsInFaction(TweakHangoutFaction)
				npc.RemoveFromFaction(TweakHangoutFaction)
			endif
			if npc.IsInFaction(TweakHomeOutFitFaction)
				npc.RemoveFromFaction(TweakHomeOutFitFaction)
			endif
			if npc.IsInFaction(TweakIgnoredFaction)
				npc.RemoveFromFaction(TweakIgnoredFaction)
			endif
			if npc.IsInFaction(TweakManagedOutfit)
				npc.RemoveFromFaction(TweakManagedOutfit)
			endif
			if npc.IsInFaction(pTweakNamesFaction)
				npc.RemoveFromFaction(pTweakNamesFaction)
			endif
			if npc.IsInFaction(TweakNinjaFaction)
				npc.RemoveFromFaction(TweakNinjaFaction)
			endif
			if npc.IsInFaction(TweakNoApprove)
				npc.RemoveFromFaction(TweakNoApprove)
			endif
			if npc.IsInFaction(TweakNoCommentActivator)
				npc.RemoveFromFaction(TweakNoCommentActivator)
			endif
			if npc.IsInFaction(TweakNoCommentApprove)
				npc.RemoveFromFaction(TweakNoCommentApprove)
			endif
			if npc.IsInFaction(TweakNoCommentDisapprove)
				npc.RemoveFromFaction(TweakNoCommentDisapprove)
			endif
			if npc.IsInFaction(TweakNoCommentGeneral)
				npc.RemoveFromFaction(TweakNoCommentGeneral)
			endif
			if npc.IsInFaction(TweakNoDisapprove)
				npc.RemoveFromFaction(TweakNoDisapprove)
			endif
			if npc.IsInFaction(pTweakNoHomeFaction)
				npc.RemoveFromFaction(pTweakNoHomeFaction)
			endif
			if npc.IsInFaction(TweakNoIdleChatter)
				npc.RemoveFromFaction(TweakNoIdleChatter)
			endif
			if npc.IsInFaction(TweakNoCasFaction)
				npc.RemoveFromFaction(TweakNoCasFaction)
			endif
			if npc.IsInFaction(TweakNoRelaxFaction)
				npc.RemoveFromFaction(TweakNoRelaxFaction)
			endif
			if npc.IsInFaction(TweakPackMuleFaction)
				npc.RemoveFromFaction(TweakPackMuleFaction)
			endif
			if npc.IsInFaction(TweakPAHelmetCombatToggleFaction)
				npc.RemoveFromFaction(TweakPAHelmetCombatToggleFaction)
			endif
			if npc.IsInFaction(TweakPosedFaction)
				npc.RemoveFromFaction(TweakPosedFaction)
			endif
			if npc.IsInFaction(pTweakRangedFaction)
				npc.RemoveFromFaction(pTweakRangedFaction)
			endif
			if npc.IsInFaction(pTweakReadyWeaponFaction)
				npc.RemoveFromFaction(pTweakReadyWeaponFaction)
			endif
			if npc.IsInFaction(TweakRotateLockFollowerFaction)
				npc.RemoveFromFaction(TweakRotateLockFollowerFaction)
			endif
			if npc.IsInFaction(pTweakSkipGoHomeFaction)
				npc.RemoveFromFaction(pTweakSkipGoHomeFaction)
			endif
			if npc.IsInFaction(TweakSniperFaction)
				npc.RemoveFromFaction(TweakSniperFaction)
			endif
			if npc.IsInFaction(TweakStandardOutfitFaction)
				npc.RemoveFromFaction(TweakStandardOutfitFaction)
			endif
			if npc.IsInFaction(TweakSwimOutfitFaction)
				npc.RemoveFromFaction(TweakSwimOutfitFaction)
			endif
			if npc.IsInFaction(pTweakSyncPAFaction)
				npc.RemoveFromFaction(pTweakSyncPAFaction)
			endif
			if npc.IsInFaction(pTweakTrackKills)
				npc.RemoveFromFaction(pTweakTrackKills)
			endif
		endif
	endif
		
	if npc.HasKeyword(pTeammateReadyWeapon_DO)
		npc.RemoveKeyword(pTeammateReadyWeapon_DO)
	endIf
	
	npc.SetLinkedRef(None,pTweakLocHome)
	trackKills = false
	numKilled  = -1

	npc.SetNotShowOnStealthMeter(false)
	npc.GetActorBase().SetInvulnerable(false)
	npc.SetEssential(false)
	npc.SetProtected(false)

	if (originalProtected)
		npc.SetProtected(true)
	elseif (originalEssential)
		npc.SetEssential(true)
	endif
	originalEssential=false
	originalProtected=false
	originalIgnoreHits=false
	originalAggression=0
	Name=""
	originalRace=None
	numKilled=0

	float sum = originalStrength + originalPerception + originalEndurance
	sum += originalCharisma + originalIntelligence + originalAgility + originalLuck
	
	if (sum > 0.0)
		npc.SetValue(pStrength, originalStrength)
		npc.SetValue(pPerception, originalPerception)
		npc.SetValue(pEndurance, originalEndurance)
		npc.SetValue(pCharisma, originalCharisma)
		npc.SetValue(pIntelligence, originalIntelligence)
		npc.SetValue(pAgility, originalAgility)
		npc.SetValue(pLuck, originalLuck)	
	endif
	
EndFunction

Function ToggleTrackKills()
	Actor npc = self.GetActorRef()
	if trackKills
		trackKills = false
		numKilled  = -1
		npc.RemoveFromFaction(pTweakTrackKills)
	else
		trackKills = true
		numKilled  = 0
		npc.AddToFaction(pTweakTrackKills)
	endif
EndFunction

Function ToggleEssential()
	Trace("ToggleEssential")
	Actor npc = self.GetActorRef()
	
	if npc.GetActorBase().IsProtected()
		Trace("Protected NPC detected. Attempting to Disable")
		originalProtected = true
		npc.SetProtected(false)
		if npc.GetActorBase().IsProtected()
			Trace("Instance override failed. Attempting to alter BaseActor Record")
			npc.GetActorBase().SetProtected(false)
			if npc.GetActorBase().IsProtected()
				Trace("BaseActor override failed (Possibly protected by quest Alias)")
				; No point in marking essential if we can't disable protected:
				npc.SetEssential(true)
				if !npc.IsInFaction(pTweakEssentialFaction)
					npc.AddToFaction(pTweakEssentialFaction)
				endif
				return
			else
				Trace("Successfully Removed Protections from ActorBase")			
			endif
		else
			Trace("Successfully Removed Protections from Actor Instance")			
		endif
	else
		Trace("Target Actor is not protected")
	endif
	
	; Focus on the reality. Set Faction to match outcome...
	; NOTE : Changes to essential will not work from menumode!
	
	if npc.IsEssential()
		Trace("Target Actor Was Essential. Making Non-Essential")
		npc.SetProtected(false)
		npc.SetEssential(false)
	else
		Trace("Target Actor Not Essential. Making Essential")
		npc.SetEssential(true)
	endif

	if npc.IsEssential()
		Trace("Target Actor is Essential. (Post change)")
		if !npc.IsInFaction(pTweakEssentialFaction)
			npc.AddToFaction(pTweakEssentialFaction)
		endif
	else
		Trace("Target Actor is Not Essential. (Post change)")
		if npc.IsInFaction(pTweakEssentialFaction)
			npc.RemoveFromFaction(pTweakEssentialFaction)
		endif
	endif
	
endFunction

;Function ToggleReload(Bool pRecharge)
;	Actor npc = self.GetActorRef()
;	if (pRecharge)
;		npc.AddToFaction(pTweakRechargeFaction)
;	Else
;		npc.RemoveFromFaction(pTweakRechargeFaction)
;	endif
;EndFunction

; Every time they continue following the PC after waiting
Function EventWaitToFollow()
	; CancelTimer()
	enforceSettings()
EndFunction

; When they stop following the PC
Function EventNotFollowingPlayer()
	trace("EventNotFollowingPlayer")
	
	Actor npc = self.GetActorRef()
	
	npc.RemoveFromFaction(pCurrentCompanionFaction)
	npc.SetNotShowOnStealthMeter(false)
	npc.IgnoreFriendlyHits(originalIgnoreHits)
	npc.SetValue(pAggression, originalAggression)
	npc.SetValue(pFollowerStance, 1.0)
	npc.SetValue(pAssistance,1)
	

endFunction

Actor[] targets = None

; This is the only script that relays cstat 0
Event OnCombatStateChanged(Actor akTarget, int cState)

	if (1 != cState)	
		if (0 == cState)
			AFT:TweakFollowerScript pTweakFollowerScript = (self.GetOwningQuest() as AFT:TweakFollowerScript)
			if pTweakFollowerScript
				; Trace("Calling TweakFollowerScript.CombatStateChanged(0)")
				pTweakFollowerScript.CombatStateChanged(0)
			else
				Trace("Cast to TweakFollowerScript failed. Unable to call CombatStateChanged(0)")
				OnCombatEnd()
			endif	
		endIf
		return		
	endif

	Actor npc = self.GetActorRef()
	
	if (akTarget)
		; 1 == cState
		if (akTarget == Game.GetPlayer())
			if !npc.IsInFaction(pTweakAllowFriendlyFire)
				npc.StopCombat()
				npc.StopCombatAlarm()
				npc.MakePlayerFriend()
				Utility.wait(0.1)
				return
			endif
		elseif (akTarget.IsPlayerTeammate())
		
			; If NPC goes hostile on player because of friendly fire, we still
			; want to allow companions to defend player.
			
			; npc.StopCombat()		
			; npc.SetRelationshipRank(akTarget, 3)
			; akTarget.SetRelationshipRank(npc, 3)
			; Utility.wait(0.1)
			
			return
		endif
	endIf
		
	if !npc.IsInFaction(pCurrentCompanionFaction)
		Trace("Not in CurrentCompanionFaction, Bailing.")
		return
	endIf
	
	if (!combatInProgress)
		OnCombatBegin()
	else
		Trace("Ignoring Event. CombatInProgress already true")
	endif
	
	if !trackKills
		return
	endif
	
	int i = 0
	int numtargets;
	if targets
		numtargets = targets.length
		while (i < numtargets)
			Actor theTarget = targets[i]
			if !theTarget.IsDead()
				UnRegisterForRemoteEvent(theTarget, "OnDeath")
				UnRegisterForHitEvent(theTarget, self.GetActorRef())
			endif
			i += 1
		endwhile
		targets.clear()
	endIf
	
	targets = npc.GetAllCombatTargets()
	numtargets = targets.length
	i = 0
	while (i < numtargets)
		Actor theTarget = targets[i]
		if !theTarget.IsDead()
			; Trace("Registering for OnDeath/OnHit [" + theTarget + "]")
			RegisterForRemoteEvent(theTarget, "OnDeath")
			RegisterForHitEvent(theTarget, self.GetActorRef())
		endif
		i += 1
	endwhile
	
endEvent

Function OnCombatBegin()
	AFT:TweakFollowerScript pTweakFollowerScript = (self.GetOwningQuest() as AFT:TweakFollowerScript)
	if pTweakFollowerScript
		Trace("Calling TweakFollowerScript.CombatStateChanged(1)")
		pTweakFollowerScript.CombatStateChanged(1)
	else
		Trace("Cast to TweakFollowerScript failed. Unable to call CombatStateChanged(1)")
	endif
EndFunction

; Typically called by TweakFollowersScript. RelayCombatEnd, which means you can't assume the npc
; is still alive or enabled...
Function OnCombatEnd()

	if !trackKills
		return
	endif

	int i = 0
	int numtargets = targets.length;
	while (i < numtargets)
		Actor theTarget = targets[i]
		UnRegisterForRemoteEvent(theTarget, "OnDeath")
		UnRegisterForHitEvent(theTarget, self.GetActorRef())
		i += 1
	endwhile
	targets.clear()
	targets = None
		
EndFunction

Function OnRetreatStart()
	Actor npc = self.GetActorRef()
	npc.SetValue(pConfidence,0)
	npc.SetValue(pAggression,0)
	npc.StopCombat()
	npc.StopCombatAlarm()
	; Global Variable TweakRetreat is set to 1.0 by TweakFollowerScript before
	; calling this. All Follower aliases have AI Packages at the top that 
	; see that value and cause the NPC to use a FLEE package.
	npc.EvaluatePackage()
EndFunction

Function OnRetreatStop()
	Actor npc = self.GetActorRef()
	npc.SetValue(pConfidence,enforceConfidence)
	if (enforceAggression < 2)
		npc.SetValue(pAggression,enforceAggression)
	else
		npc.SetValue(pAggression,1)
	endif
	; Global Variable TweakRetreat is set to 0.0 by TweakFollowerScript before
	; calling this. All Follower aliases should ignore their FLEE packages 
	; once we re-evaluate the stack
	npc.EvaluatePackage()
EndFunction

Event OnHit(ObjectReference akTarget, ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked, string apMaterial)
	float hp = akTarget.GetValue(pHealth) as float
	; trace("OnHit (hp [" + hp + "] akAggressor [" + akAggressor + "]")
	if (hp <= 0.0)
		IncrementKillCount(akTarget)
	else
		RegisterForHitEvent(akTarget, self.GetActorRef())
	endif
EndEvent

Event Actor.OnDeath(Actor killedNPC, Actor killerNPC)
	trace("OnDeath")
	UnRegisterForRemoteEvent(killedNPC, "OnDeath")
	UnregisterForHitEvent(killedNPC, self.GetActorRef())
EndEvent

Function IncrementKillCount(ObjectReference akTarget)
	trace("IncrementKillCount (" + akTarget + ")")
	numKilled += 1
EndFunction

int function GetNumKilled()
	return numKilled
EndFunction

Event Actor.OnKill(Actor Source, Actor akVictim)
	; DEPRECATED 1.05. SEE Object.OnHit....
	UnRegisterForRemoteEvent(Source, "OnKill")
EndEvent


Event OnTimer(int akTimerId)
	if (ONLOAD_FLOOD_PROTECT == akTimerId)
		OnLoadHelper()
		return
	endif
EndEvent

Function OnLoadHelper()

	Trace("OnLoadHelper() Called")
	enforceSettings()
	
EndFunction

Function EventFollowerWait()

	; Nothing to do for now...
		
EndFunction

Function SetFollowerStanceAuto()
	self.GetActorRef().AddToFaction(pTweakAutoStanceFaction)
	enforceAggression = 2
EndFunction

Function SetFollowerStanceAggressive()
	Actor npc = self.GetActorRef()
	if npc.IsInFaction(pTweakAutoStanceFaction)
		npc.RemoveFromFaction(pTweakAutoStanceFaction)
	endIf			
	enforceAggression = 1
	enforceSettings()
EndFunction

Function SetFollowerStanceDefensive()
	Actor npc = self.GetActorRef()
	if npc.IsInFaction(pTweakAutoStanceFaction)
		npc.RemoveFromFaction(pTweakAutoStanceFaction)
	endIf
	npc.SetValue(pFollowerStance, iFollower_Stance_Defensive.GetValue())
	enforceAggression = 0
	enforceSettings()
EndFunction

Function SetPackMule(bool enabled=true)
	if enabled
		enforceCarryWeight = 2000		
	else
		enforceCarryWeight = -1
		Trace("SetPackMule : Original CarryWeight [" + originalCarryWeight + "]")

		if originalCarryWeight < 150
			Trace("Adjusting to 150 (too small)")
			originalCarryWeight = 150
		endif
		if originalCarryWeight > 260
			Trace("Adjusting to 150 (Too large)")
			originalCarryWeight = 150
		endif
		Trace("Restoring")
		self.GetActorRef().SetValue(pCarryWeight, originalCarryWeight)
	endIf
	enforceSettings()
EndFunction

; Home is more complicated than it should be. 
;
; When writing AI against Aliases, you generally have to 
; use hard coded values. For example, a specific Location, 
; or a LocationAlias managed by some quest. The most
; flexible value you can use is a LinkedRef. LinkedRef is basically 
; key/value pair. The primary Object instance has a key (keyword)
; and you stick a pointer to another Object into the value.
; 
; Unfortunately FO4 doesn't support a LinkedLocation. So to
; make use of LinkedRef, we have to convert Locations into 
; ObjectReference... that is, provide a map that identifies
; an object within the Location that can represent the 
; location. 
;
; Many NPCs use the CompanionActor system built into FO4. These NPCs 
; have an individualized AI Package attached to the Base Actor Definition
; that directs them "HOME" when no other Quest alias is controlling them. 
;
; Other NPCs are managed by Settlements. Ever notice that every 
; settlement requires a Workbench? That is because a master quest
; called WorkshopParent maintains a list of the workbench object
; references. Under the hood, when an NPC is added to a settlement, 
; the WorkshopParent converts the location to a workbench (or a 
; settlement managed alternative center location) and adds the
; LinkedRef "WorkshopLinkHome" to the NPC with the settlement object. 
;
; We have to do something similar when we assign a home.
; What a pain...
Function AssignHome()
	trace("AssignHome")

	Actor npc = self.GetActorReference()
		
	
	; Tweak Dismiss has some aliases on it so we can make a nice Message Box
	; with filled in text. 
	AFT:TweakDismissScript pTweakDismissScript = pTweakDismiss as AFT:TweakDismissScript
	
	WorkshopParentScript pWorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
	Keyword WorkshopLinkHome    = Game.GetForm(0x0002058F) as Keyword

	int choice = 4 ; 0 = OriginalHome, 1 = Current Location (NoHome), 2 = AFT Camp, 3 = Settlement, 4 = Cancel
	bool camphomeFaction = false
	bool nohomeFaction   = false
	
	if (pTweakDismissScript)
		choice = pTweakDismissScript.ShowMenu(npc,originalHome)
		trace("choice = [" + choice + "]")
	endif

	if (4 == choice)
		return
	endif
	
	; The issue with removing upfront is they may choose to assign a settlement and then cancel.
	; So we repeat the cleanup code in each case to avoid it in the exception:
	
	if (0 == choice)  ; Original
	
		; Cleanup
		npc.RemoveFromFaction(pTweakSkipGoHomeFaction)
		if (dynamicAssignment) ; Needs Cleanup...
			dynamicAssignment = false
			if assignedHomeRef
				npc.SetLinkedRef(None, pTweakLocHome)
				assignedHomeRef.Disable()
				assignedHomeRef.Delete()
				if ((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef
					((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef.Disable()
					((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef.Delete()
				endif
			endif
		else
			trace("dynamicAssignment is false")
		endif
		
		assignedHomeRef = None
		((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef = None			
		
		Trace("Attempting to restore original Home")
				
		assignedHome    = originalHome
		assignedHomeRef = originalHomeRef
		
		if (!assignedHome)
			; This shouldn't happen as we default to SanctuaryHills. 
			nohomeFaction = true
			Trace("Assertion Error. originalHome is None. Bailing...")
			return
		endIf
		if (!assignedHomeRef)
			; This shouldn't happen as we default to CodsworthKitchenMarker. 
			nohomeFaction = true
			Trace("Assertion Error. originalHomeRef is None. Bailing...")
			return
		endif
		
		WorkshopNPCScript    WNS = npc as WorkshopNPCScript
		CompanionActorScript CAS = npc as CompanionActorScript
		DogmeatActorScript   DAS = npc as DogmeatActorScript
		
		; If someone is assigned to a settlement and
		; the player chooses this, they probably want
		; to unassign the NPC from the settlement
		
		if (WNS && WNS.GetWorkshopID() != -1)
			pWorkshopParent.RemoveActorFromWorkshopPUBLIC(WNS)
		endIf		
		if (CAS)
			Trace("Updating CAS.HomeLocation")
			CAS.HomeLocation = assignedHome
		elseif (DAS)
			Trace("Updating DAS.HomeLocation")
			DAS.HomeLocation = assignedHome
		endif
		
		Trace("Adding TweakLocHom Reference...")
		
		npc.SetLinkedRef(assignedHomeRef, pTweakLocHome)		
		((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHome    = assignedHome
		((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef = assignedHomeRef
		
				
	elseif (1 == choice) ; Current Location
	
		; Cleanup
		npc.RemoveFromFaction(pTweakSkipGoHomeFaction)
		if (dynamicAssignment) ; Needs Cleanup...
			dynamicAssignment = false
			if assignedHomeRef
				npc.SetLinkedRef(None, pTweakLocHome)
				assignedHomeRef.Disable()
				assignedHomeRef.Delete()
				if ((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef
					((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef.Disable()
					((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef.Delete()
				endif
			endif
		else
			trace("dynamicAssignment is false")
		endif
		
		assignedHomeRef = None
		((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef = None			
		
		WorkshopNPCScript    WNS = npc as WorkshopNPCScript
		CompanionActorScript CAS = npc as CompanionActorScript
		DogmeatActorScript   DAS = npc as DogmeatActorScript
		
		Trace("Attempting to assign Current Location Home")
		
		assignedHome = npc.GetCurrentLocation()		
		
		; Do we need to test for DiamondCityPlayerHouseLocation : 0x00003967
		
		if (assignedHome)
			Trace("GetCurrentLocation [" + assignedHome + "]")
		
			WorkshopScript workshopRef = pWorkshopParent.GetWorkshopFromLocation(assignedHome)
			
			assignedHomeRef = LocationToWorkShopRef(assignedHome)
									
			if (workshopRef)
				Trace("Current Location is Workshop")
				
				; The current location happens to be a workshop,
				; If NPC supports Workshops, make sure we update
				; them.
				if (WNS)
					if npc.GetActorBase().IsUnique()
						pWorkshopParent.AddActorToWorkshopPUBLIC(WNS, workshopRef)
					else
						pWorkshopParent.AddActorToWorkshopPUBLIC(WNS, workshopRef)
					endIf
					
					npc.AddToFaction(pTweakSkipGoHomeFaction)
				elseif !(CAS || DAS)
					nohomeFaction = true
				endif
			else
				if (WNS && WNS.GetWorkshopID() != -1)
					pWorkshopParent.RemoveActorFromWorkshopPUBLIC(WNS)
				endIf
			endIf

			if (CAS)
				CAS.HomeLocation = assignedHome
			elseif (DAS)
				DAS.HomeLocation = assignedHome
			endif
			
			; Codsworth Check
			if npc.GetActorBase() == (Game.GetForm(0x000179FF) as ActorBase)
				Quest DialogueCodsworthPostWar = Game.GetForm(0x0001E64E) as Quest
				if DialogueCodsworthPostWar && DialogueCodsworthPostWar.IsRunning()
					; Alias on quest forces Codsworth back to Sanctuary. But it
					; isn't needed after he is following you.
					DialogueCodsworthPostWar.Stop()
				endif
			endif		
		else
			Trace("GetCurrentLocation [None]")
			; Sometimes GetCurrentLocation() returns NONE. There ARE
			; Cells that are only associated with a Worldspace and 
			; not a Location. 
			nohomeFaction = true
		endif
		
		if !assignedHomeRef
			dynamicAssignment = true
			assignedHomeRef   = npc.PlaceAtMe(XMarkerHeading, 1, true)
		endIf
		
		npc.SetLinkedRef(assignedHomeRef, pTweakLocHome)
		((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHome    = assignedHome
		((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef = assignedHomeRef

	elseif (2 == choice) ; AFT CAMP 
	
		; Cleanup
		npc.RemoveFromFaction(pTweakSkipGoHomeFaction)
		if (dynamicAssignment) ; Needs Cleanup...
			dynamicAssignment = false
			if assignedHomeRef
				npc.SetLinkedRef(None, pTweakLocHome)
				assignedHomeRef.Disable()
				assignedHomeRef.Delete()
				if ((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef
					((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef.Disable()
					((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef.Delete()
				endif
			endif
		else
			trace("dynamicAssignment is false")
		endif
		
		assignedHomeRef = None
		((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef = None			

		Trace("Attempting to assign to Camp")
		
		camphomeFaction = true
		assignedHome    = pTweakCampLocation
		assignedHomeRef = pAftMapMarker
		
		WorkshopNPCScript    WNS = npc as WorkshopNPCScript
		CompanionActorScript CAS = npc as CompanionActorScript
		DogmeatActorScript   DAS = npc as DogmeatActorScript
		
		if (WNS && WNS.GetWorkshopID() != -1)
			pWorkshopParent.RemoveActorFromWorkshopPUBLIC(WNS)
		elseif !(CAS || DAS)
			nohomeFaction = true
		endif
	
		if (CAS)
			CAS.HomeLocation = assignedHome
		elseif (DAS)
			DAS.HomeLocation = assignedHome
		endif
		
		npc.SetLinkedRef(assignedHomeRef, pTweakLocHome)
		((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHome    = assignedHome
		((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef = assignedHomeRef
		
	elseif (3 == choice) ; Choose Settlement	
	
		WorkshopNPCScript    WNS = npc as WorkshopNPCScript		
		CompanionActorScript CAS = npc as CompanionActorScript
		DogmeatActorScript   DAS = npc as DogmeatActorScript
		Location       selection = None
		
		if (CAS && CAS.AllowDismissToSettlements && (CAS.AllowDismissToSettlements.GetValue() > 0) && CAS.DismissCompanionSettlementKeywordList)
			if npc.GetActorBase().IsUnique()
				selection = npc.OpenWorkshopSettlementMenuEx(akActionKW=pWorkshopParent.WorkshopAssignHomePermanentActor, aLocToHighlight=CAS.HomeLocation, akIncludeKeywordList=CAS.DismissCompanionSettlementKeywordList)
			else
				selection = npc.OpenWorkshopSettlementMenuEx(akActionKW=pWorkshopParent.WorkshopAssignHome, aLocToHighlight=CAS.HomeLocation, akIncludeKeywordList=CAS.DismissCompanionSettlementKeywordList)
			endIf			
		elseif pWorkshopParent.PlayerOwnsAWorkshop
			if WNS
				if npc.GetActorBase().IsUnique()
					selection = pWorkshopParent.AddActorToWorkshopPlayerChoice(npc) ; May return NONE if player hits cancel
				else
					selection = pWorkshopParent.AddPermanentActorToWorkshopPlayerChoice(npc) ; May return NONE if player hits cancel
				endif
			else
				selection = npc.OpenWorkshopSettlementMenuEx(akActionKW=pWorkshopParent.WorkshopAssignHomePermanentActor)
			endif				
		endif
		
		if (selection)
					
			; Cleanup
			npc.RemoveFromFaction(pTweakSkipGoHomeFaction)
			if (dynamicAssignment) ; Needs Cleanup...
				dynamicAssignment = false
				if assignedHomeRef
					npc.SetLinkedRef(None, pTweakLocHome)
					assignedHomeRef.Disable()
					assignedHomeRef.Delete()
					if ((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef
						((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef.Disable()
						((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef.Delete()
					endif
				endif
			else
				trace("dynamicAssignment is false")
			endif
			
			assignedHomeRef = None
			((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef = None			

			assignedHome = selection
			WorkshopScript workshopRef = pWorkshopParent.GetWorkshopFromLocation(assignedHome)
									
			if (workshopRef)
				if (WNS)
					pWorkshopParent.AddActorToWorkshopPUBLIC(WNS, workshopRef)					
					npc.AddToFaction(pTweakSkipGoHomeFaction)
				elseif !(CAS || DAS)
					nohomeFaction = true
				endif
				assignedHomeRef = LocationToWorkShopRef(assignedHome)
				if (!assignedHomeRef)
					assignedHomeRef = workshopRef
				endif
			else
				assignedHomeRef = LocationToWorkShopRef(assignedHome)
				if !assignedHomeRef
					if originalHomeRef
						assignedHomeRef = originalHomeRef
					else
						assignedHomeRef = CodsworthKitchenMarker
					endIf
				endif
				
				; This entire block is basically 1 giant assertion failure, 
				; so lets not add insult to injury by removing them from
				; their workshop...
				
				; if (WNS && WNS.GetWorkshopID() != -1)
				;	pWorkshopParent.RemoveActorFromWorkshopPUBLIC(WNS)
				; endIf
			endIf
			
			npc.SetLinkedRef(assignedHomeRef, pTweakLocHome)
			((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHome    = assignedHome
			((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef = assignedHomeRef
			
		else ; Cancel... No Change
			if !assignedHome
				; This shouldn't happen as we default to SanctuaryHills. 
				nohomeFaction = true
			endif			
		endif
	else ; Cancel... No Change
		if !assignedHome
			; This shouldn't happen as we default to SanctuaryHills. 
			nohomeFaction = true
		endif
	endif
	
	; Update Factions to ensure correct AI behaviors....
	if (!camphomeFaction && npc.IsInFaction(pTweakCampHomeFaction))
		npc.RemoveFromFaction(pTweakCampHomeFaction)
	elseif (camphomeFaction && !npc.IsInFaction(pTweakCampHomeFaction))
		npc.AddToFaction(pTweakCampHomeFaction)
	endif
	if (!nohomeFaction && npc.IsInFaction(pTweakNoHomeFaction))
		npc.RemoveFromFaction(pTweakNoHomeFaction)
	elseif (nohomeFaction && !npc.IsInFaction(pTweakNoHomeFaction))
		npc.RemoveFromFaction(pTweakSkipGoHomeFaction)
		npc.AddToFaction(pTweakNoHomeFaction)
	endif
	
EndFunction

; For when you dont care
ObjectReference Function LocationToMarkerRef(Location loc)
	ObjectReference marker = LocationToWorkShopRef(loc)
	if marker
		return marker
	endIf
	return LocationToCachedRef(loc)
EndFunction

; Provides confirmation if location is a workshop location...
Location Function WorkShopIDToLocation(int id)
	WorkshopParentScript pWorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
	RefCollectionAlias   wscollection    = pWorkshopParent.WorkshopsCollection
	if (id >= wscollection.GetCount())
		return None
	endif
	WorkshopScript workshopRef       = wscollection.GetAt(id) as WorkshopScript
	return workshopRef.GetCurrentLocation()
endFunction

; Provides confirmation if location is a workshop location...
int Function LocationToWorkShopID(Location loc)
	Location ws                          = None
	WorkshopParentScript pWorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
	RefCollectionAlias   wscollection     = pWorkshopParent.WorkshopsCollection
	
	int index = 0
	while (index < wscollection.GetCount() && loc != ws)
		WorkshopScript workshopRef = wscollection.GetAt(index) as WorkshopScript
		ws = workshopRef.GetCurrentLocation()
		if loc == ws
			return index
		endif
		index += 1
	endwhile
	return -1
EndFunction


; Provides both a translation and confirmation if
; a location is a workshop location...
ObjectReference Function LocationToWorkShopRef(Location loc)
	ObjectReference marker = None
	
	Keyword WorkshopLinkSandbox = Game.GetForm(0x0022B5A7) as Keyword
	Keyword WorkshopLinkCenter  = Game.GetForm(0x00038C0B) as Keyword
	
	Location ws                          = None
	WorkshopParentScript pWorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
	RefCollectionAlias   wscollection     = pWorkshopParent.WorkshopsCollection
	
	int index = 0
	while (index < wscollection.GetCount() && loc != ws)
		WorkshopScript workshopRef = wscollection.GetAt(index) as WorkshopScript
		ws = workshopRef.GetCurrentLocation()
		if loc == ws
			marker = workshopRef.GetLinkedRef(WorkshopLinkSandbox)			
			if marker == NONE
				marker = workshopRef.GetLinkedRef(WorkshopLinkCenter)
			endif
			if marker == NONE
				marker = workshopRef as ObjectReference
			endIf
			return marker
		endif
		index += 1
	endwhile
EndFunction

ObjectReference Function LocationToCachedRef(Location loc)
	ObjectReference marker = None
	int locid  = (loc.GetFormID() as int)
	if (0x0001905B == locid)     ; CombatZoneLocation
		marker = CaitPostCombatMarker01
	elseif (0x0001F229 == locid) ; SanctuaryHillsPlayerHouseLocation
		marker = CodsworthKitchenMarker
	elseif (0x0002BE8D == locid) ; Vault81Location
		marker = COMCurieIntroMarker
	elseif (0x0001FA4A == locid) ; CambridgePDLocation
		marker = BoS101PlayerStartMarker
	elseif (0x000482C2 == locid) ; RailroadHQLocation
		marker = DeaconHomeMarker
	elseif (0x00024FAB == locid) ; RedRocketTruckStopLocation
		marker = RedRocketCenterMarker
	elseif (0x0002260F == locid) ; GoodneighborOldStateHouseLocation
		marker = MS04HancockEndMarker
	elseif (0x0002267F == locid) ; GoodneighborTheThirdRailLocation
		marker = COMMacCreadyStartMarker
	elseif (0x00003979 == locid) ; DiamondCityValentinesLocation
		marker = MS07NickOfficeMarker
	elseif (0x00003962 == locid) ; DiamondCityPublickOccurrencesLocation
		marker = MQ201BPiperTravelMarker02
	elseif (0x0001F228 == locid) ; SanctuaryHillsLocation
		marker = SanctuaryLocationCenterMarker
	elseif (0x0001DAF7 == locid) ; TrinityTowerLocation
		marker = MS10SafetyMarker
	elseif (0x001BBC22 == locid) ; InstituteSRBLocation
		marker = InstSceneAlaneJustin1JustinMarker
	endif
	return marker
EndFunction

Function SetConfidence(int value)
	enforceConfidence = value
	self.GetActorRef().SetValue(pConfidence,enforceConfidence)
EndFunction

; IgnoreFriendlyFire status and faction is set/handled by TweakPipBoyScript.

Function enforceSettings()

	Actor npc = self.GetActorRef()
	npc.SetNotShowOnStealthMeter(true)
	if (npc.IsInFaction(pTweakEssentialFaction))
		if !npc.IsEssential()
			npc.SetEssential(true)
		endif
	elseif npc.IsEssential()
		npc.SetEssential(false)
	endif

	if enforceCarryWeight > -1
		npc.SetValue(pCarryWeight, enforceCarryWeight)
	endif
	
	if (enforceAggression < 2)
		npc.SetValue(pAggression,  enforceAggression) ; 1 = Aggresive (Attack actively hostile enemies)
		if (0 == enforceAggression)
			; Problem with 2 (help friends) is they can become hostile if you attack their faction.
			; However when aggression is unaggressive, we need the boost to make them react when
			; the player is attacked...
			npc.SetValue(pAssistance,2)
		else
			; 1 = Helps Allies only. This is fine when they are set to aggressive
			npc.SetValue(pAssistance,1)
		endif		
	endif
	
	npc.SetValue(pMorality,0)                     ; 0 = Will steal anything and murder anyone on command (defer to your judgement)
	
	if (!combatInProgress)
		; Conditionalized so player can order retreat....
		npc.SetValue(pConfidence,enforceConfidence)   ; 3 = Brave : Wont run, but also avoid putting themself in harmsway (keep distance from Deathclaw)
	endif	
	
	if (npc.IsInFaction(pTweakAllowFriendlyFire) || 0.0 == pTweakIgnoreFriendlyFire.GetValue())
		npc.IgnoreFriendlyHits(false)
	else		
		npc.IgnoreFriendlyHits(true)
	endif

	if npc.IsInFaction(pTweakReadyWeaponFaction)
		if !npc.HasKeyword(pTeammateReadyWeapon_DO)
			npc.AddKeyword(pTeammateReadyWeapon_DO)
		endIf
	else
		if npc.HasKeyword(pTeammateReadyWeapon_DO)
			npc.RemoveKeyword(pTeammateReadyWeapon_DO)
		endIf
	endif
		
	; Trap Avoidance is handled 100% by PipBoyScript
	;if (pTweakFollowerScript.followerHoldback)
	;	npc.SetAV("Aggression", 0)
	;else
	;	npc.SetAV("Aggression", 1)
	;endif

	; Morality was replaced by keywords. Actors either have the keywords 
	; to do things like pick locks and hack terminals and steal things 
	; or they dont. We can still track a setting, but pushing it is 
	; a matter of remember original keywords and adding to them. 
	
	npc.EvaluatePackage()
endFunction

Event OnReset()
	Trace("TweakSettings OnReset() detected. (Probably should re-apply settings)")
EndEvent

; Game consists of cells. There is a concept of a location which is a group of cells with
; a common label. IE: SanctuaryHillsLocation. No all cells however belong to a location label.
; This event fires when you enter or leave a location region. Often, there is a small space between
; the regions that has no location. So for example, when following the road near RedRocket, this
; event will fire several times within a few seconds. Once for Sanct => None. Then None => RedRocket 
; then RedRocket => None. That is part of the reason for the flood protection.
Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	Trace("OnLocationChange() Called")	
	; Flood Protection
	StartTimer(2.5,ONLOAD_FLOOD_PROTECT)	
EndEvent

; OnLoad means the NPC's model is has loaded. Generally this fires when you
; load a save game or when you leave an NPC (get far enough away for their
; model to unload) and then re-approach. It also fires when we changing race... 
Event OnLoad()
	Trace("OnLoad() Called")
	Actor npc = self.GetActorRef()
	if npc.IsDead()
		return
	endIf
	if (!npc.IsInFaction(pCurrentCompanionFaction))
		return
	endif
    if npc.Is3dLoaded() && teleportInOnLoad == true
        teleportInOnLoad = false
        teleportToHere()
    endIf
	; Flood Protection
	StartTimer(2.5,ONLOAD_FLOOD_PROTECT)	
endEvent

function teleportAway()
	debug.trace(self.GetActorRef() + " teleportAway: Warning. 3D will be unloaded an may not be recoverable without location change.")
	Actor npc = self.GetActorRef()
	if npc.HasSpell(teleportInSpell)
		npc.RemoveSpell(teleportInSpell)
	endif
	npc.AddSpell(teleportOutSpell)
endFunction

function teleportToHere()
	debug.trace( self.GetActorRef() + " teleportToHere")
	Actor npc = self.GetActorRef()
	if npc.HasSpell(teleportOutSpell)
		npc.RemoveSpell(teleportOutSpell)
	endif
	npc.AddSpell(TeleportInSpell)	
endFunction

Event OnCommandModeGiveCommand(int aeCommandType, ObjectReference akTarget)

	Trace("OnCommandModeGiveCommand : [" + aeCommandType + "]")
	lastCommandReceived = aeCommandType
	
    ; aeCommandType: Type of Command that is given, which is one of the following:
	; 0 - None
	; 1 - Call
	; 2 - Follow
	; 3 - Move
	; 4 - Attack
	; 5 - Inspect
	; 6 - Retrieve
	; 7 - Stay
	; 8 - Release
	; 9 - Heal
	; 10 - Workshop Assign
	; 11 - Ride Vertibird
	; 12 - Enter Power Armor
	
EndEvent

; SQUARE ROOT is expensive. Most people dont actually want to KNOW the distance. They
; simply want equality or range checks, which you can do without the square root...
Bool Function DistanceWithin(ObjectReference a, ObjectReference b, float radius)
	float total  = 0
	float factor = a.GetPositionX() - b.GetPositionX()
	total += (factor * factor)
	factor = a.GetPositionY() - b.GetPositionY()
	total += (factor * factor)
	factor = a.GetPositionZ() - b.GetPositionZ()
	total += (factor * factor)
	return ((radius * radius) > total)
EndFunction

Int Function GetPluginID(int formid)
	int fullid = formid
	if fullid > 0x80000000
		fullid -= 0x80000000
	endif
	int lastsix = fullid % 0x01000000
	return (((formid - lastsix)/0x01000000) as Int)
EndFunction 

