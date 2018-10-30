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
	Faction			Property pTweakSettlerFaction			Auto Const
	Faction			Property pTweakPackMuleFaction			Auto Const

	
	Faction			Property pPlayerFaction					Auto Const ; 0001C21C 
	
	Quest           Property pTweakNames					Auto Const ; 010035B1
	Quest			Property pTweakDismiss					Auto Const
	Quest			Property pTweakSettlers					Auto Const
	
	Formlist        Property pTweakCommonFactions			Auto Const ; 0101BB21
	
	Race            Property pHumanRace						Auto Const ;

	; LinkedRef for TweakGoHome package....
	Keyword         Property pTweakLocHome					Auto Const 
	Keyword         Property pTeammateReadyWeapon_DO		Auto Const
	Keyword			Property pFurnitureTypePowerArmor		Auto Const
	
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
	ActorValue Property pHealth			Auto const ; Current Value
	ActorValue Property pRadHealthMax	Auto const ; Max Health Value
	
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
	
	Perk  Property pTweakCarryBoost				Auto Const
	Perk  Property pTweakZeroCarryInCombat		Auto COnst
	Perk  Property pTweakHealthBoost			Auto Const 
	Perk  Property pTweakDmgResistBoost			Auto Const 
	Perk  Property pTweakRangedDmgBoost			Auto Const 
	Perk  Property pCompanionInspirational		Auto Const
	Spell Property pAbMagLiveLoveCompanionPerks	Auto Const
	Perk  Property Sneak01						Auto Const
	Perk  Property Sneak02						Auto Const
	Perk  Property Sneak03						Auto Const
	Perk  Property Sneak04						Auto Const
	Perk  Property ImmuneToRadiation			Auto Const
	
	Spell Property TeleportOutSpell Auto Const
	Spell Property TeleportInSpell  Auto Const
	
	Quest Property TweakDLC01 Auto Const
	Quest Property TweakDLC03 Auto Const
	Quest Property TweakDLC04 Auto Const
	
	GlobalVariable Property TweakAllowAutonomousPickup	Auto Const 	; "[ ] Allow autonomous weapon pickup"
	GlobalVariable Property HC_Rule_DamageWhenEncumbered Auto Const
	
EndGroup

Group LocalPersistance

	String    Property Name						Auto
	
	Bool      Property InBleedOut				Auto
	Bool      Property originalEssential		Auto
	Bool      Property originalProtected		Auto
	Bool      Property originalIgnoreHits		Auto
	
	Int       Property originalCarryWeight		Auto
	Int       Property originalHealth			Auto
	Int       Property originalAggression		Auto
	Int       Property originalMorality			Auto
	Int       Property originalConfidence		Auto
	Int       Property originalAssistance		Auto
	Int       Property lastCommandReceived		Auto
	
	float     Property originalBaseCarryWeight	Auto
	float     Property assignedMaxHealth		Auto
	
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
int	COMBATEND_DELAYED		  = 995 const
; int ONHIT_FLOOD_PROTECT       = 997 const

float TradeHealth
bool TradeMenuOpen = false

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

	originalStrength		=  0
	originalPerception		=  0
	originalEndurance		=  0
	originalCharisma		=  0
	originalIntelligence	=  0
	originalAgility			=  0
	originalLuck			=  0
	assignedMaxHealth		= -1
	originalFactions = new Faction[2]
	
	; 1.20 : Bug Fix - Adding HasBeenCompaninon breaks non-core Companions when unmanaged
	;originalFactions[0] = Game.GetForm(0x000A1B85) as Faction ; HasBeenCompanionFaction
	
	originalFactions[0] = Game.GetForm(0x001EC1B9) as Faction ; PotentialCompanionFaction	
	originalFactions[1] = Game.GetForm(0x001EC1B9) as Faction ; PotentialCompanionFaction
EndEvent

Function v20upGrade()
	Trace("v20upGrade()")
	Actor pc = Game.GetPlayer()
	Actor npc = self.GetActorRef()
	originalBaseCarryWeight = -1.0
	assignedMaxHealth       = -1.0
	
	ActorBase base  = npc.GetActorBase()
	int ActorBaseID = base.GetFormID()

	if (base == Game.GetForm(0x00079249) as ActorBase)     ; 1 ---=== Cait ===---
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 7.0
	elseif (base == Game.GetForm(0x000179FF) as ActorBase) ; 2 ---=== Codsworth ===---
		originalBaseCarryWeight = 110.0
		originalStrength        = 9.0
		originalEndurance       = 7.0
	elseif (base == Game.GetForm(0x00027686) as ActorBase) ; 3 ---=== Curie ===---
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 4.0
	elseif (base == Game.GetForm(0x00027683) as ActorBase) ; 4 ---=== Danse ===---
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 8.0
	elseif (base == Game.GetForm(0x00045AC9) as ActorBase) ; 5 ---=== Deacon ===---
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 7.0
	elseif (base == Game.GetForm(0x0001D15C) as ActorBase) ; 6 ---=== Dogmeat ===---
		originalBaseCarryWeight = 160.0
		originalStrength        = 4.0
		originalEndurance       = 4.0
	elseif (base == Game.GetForm(0x00022613) as ActorBase) ; 7 ---=== Hancock ===---	
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 8.0
	elseif (base == Game.GetForm(0x0002740E) as ActorBase) ; 8 ---=== MacCready ===---	
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 9.0
	elseif (base == Game.GetForm(0x00002F24) as ActorBase) ; 9 ---=== Nick Valentine ===---
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 8.0
	elseif (base == Game.GetForm(0x00002F1E) as ActorBase) ; 10 ---=== Piper ===---	
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 7.0
	elseif (base == Game.GetForm(0x00019FD9) as ActorBase) ; 11 ---=== Preston ===---
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 7.0
	elseif (base == Game.GetForm(0x00027682) as ActorBase) ; 12 ---=== Strong ===---
		originalBaseCarryWeight = 390.0
		originalStrength        = 24.0
		originalEndurance       = 8.0
	elseif (base == Game.GetForm(0x000BBEE6) as ActorBase) ; 13 ---=== X6-88 ===---	
		originalBaseCarryWeight = 310.0
		originalStrength        = 16.0
		originalEndurance       = 17.0
	elseif (base == pTweakCompanionNate) ; ---=== Nate ===---	
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 7.0
	elseif (base == pTweakCompanionNora) ; ---=== Nora ===---	
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 5.0
	elseif (ActorBaseID > 0x00ffffff)
		
		int ActorBaseMask
			
		if ActorBaseID > 0x80000000			
			ActorBaseMask = (ActorBaseID - 0x80000000) % (0x01000000)
		else
			ActorBaseMask = ActorBaseID % (0x01000000)
		endif
			
		if 0x0000FD5A == ActorBaseMask ; Ada
			originalBaseCarryWeight = 110.0
			originalStrength        = 9.0
			originalEndurance       = 7.0
		elseif 0x00006E5B == ActorBaseMask ; Longfellow
			originalBaseCarryWeight = 150.0
			originalStrength        = 5.0
			originalEndurance       = 7.0
		elseif 0x0000881D == ActorBaseMask ; Porter Gage
			originalBaseCarryWeight = 150.0
			originalStrength        = 7.0
			originalEndurance       = 7.0
		endif		
	endif
	
	if -1 == originalBaseCarryWeight
		originalBaseCarryWeight = npc.GetBaseValue(pCarryWeight)
	endif
	
	if 1.0 == TweakAllowAutonomousPickup.GetValue()
		if !npc.HasPerk(pTweakCarryBoost)
			npc.AddPerk(pTweakCarryBoost)
		endIf
		if !npc.HasPerk(pTweakZeroCarryInCombat)
			npc.AddPerk(pTweakZeroCarryInCombat)
		endIf
	endif
	
	if combatInProgress
		OnCombatEnd()
	endif
	
	; As much as I want to do this, it could also cause population to spike and food to no longer
	; be adequate at a number of settlements. I could see this upsetting users. So for now, we will
	; not auto-import Managed NPCs to Settlers during an upgrade...
	
	; Keyword	WorkshopKeyword	=	Game.GetForm(0x00054BA7) as Keyword
	;
	; if assignedHome && assignedHome.HasKeyword(WorkshopKeyword) && !npc.IsInFaction(pCurrentCompanionFaction)
	;	WorkshopNPCScript wns = (npc as WorkshopNPCScript)
	;	if !wns
	;		AFT:TweakSettlersScript	AFTSettlers = (pTweakSettlers as AFT:TweakSettlersScript)	
	;		if AFTSettlers
	;			Trace("Upgrading Non-Active Managed NPC to AFTSettler as they are assigned to a Settlement.")
	;			if AFTSettlers.MakeSettler(npc, assignedHome, false)
	;				npc.AddToFaction(pTweakSkipGoHomeFaction)
	;			endIf
	;		endIf
	;	endIf
	; endIf
	
	ReEvaluateHealth()
	
	if npc.HasPerk(pTweakHealthBoost)
		SafelyRemoveHealthBoost()		
	endif

	if (npc.GetValue(pHealth) > npc.GetValue(pRadHealthMax)) && (npc.GetValue(pRadHealthMax) > 0) && !npc.IsBleedingOut()
		float diff = npc.GetValue(pHealth) - npc.GetValue(pRadHealthMax)
		npc.DamageValue(pHealth,diff)
		ReEvaluateHealth()
	endif
	
EndFunction

Function SafelyRemoveHealthBoost()
	Trace("SafelyRemoveHealthBoost()")
	Actor npc = self.GetActorRef()
	if npc.HasPerk(pTweakHealthBoost)
		npc.StartDeferredKill()
		float beforeHealth = npc.GetValue(pHealth)	
		npc.RemovePerk(pTweakHealthBoost)
		float afterHealth  = npc.GetValue(pHealth)
		bool endDeferred = true
		if (beforeHealth != afterHealth)
			if (afterHealth < 1.0)
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
		endif
		if endDeferred
			npc.EndDeferredKill()
		endif					
	endif
EndFunction

Function ReEvaluateHealth(bool force=false)
	Trace("ReEvaluateHealth")	
	float minEndurance = originalEndurance
	
	Actor npc = self.GetActorRef()
	if (!force && (npc.GetBaseValue(pEndurance) == minEndurance))
		Trace("Endurance is the same. Bailing")
		return
	endIf
	
	Actor pc = Game.GetPlayer()
	ActorBase base  = npc.GetActorBase()

	assignedMaxHealth = -1.0
	if (base == Game.GetForm(0x00079249) as ActorBase)     ; 1 ---=== Cait ===---
		assignedMaxHealth       = 135.0
		Trace("Cait Detected: [" + assignedMaxHealth + "] base")
		; originalEndurance    = 7.0
	elseif (base == Game.GetForm(0x000179FF) as ActorBase) ; 2 ---=== Codsworth ===---
		assignedMaxHealth       = 95.0
		Trace("Codsworth Detected: [" + assignedMaxHealth + "] base")
		; originalEndurance    = 7.0
	elseif (base == Game.GetForm(0x00027686) as ActorBase) ; 3 ---=== Curie ===---
		assignedMaxHealth       = 230.0
		Trace("Curie Detected: [" + assignedMaxHealth + "] base")
		; originalEndurance    = 4.0		
	elseif (base == Game.GetForm(0x00027683) as ActorBase) ; 4 ---=== Danse ===---
		assignedMaxHealth       = 60
		Trace("Danse Detected: [" + assignedMaxHealth + "] base")
		; originalEndurance    = 8.0
	elseif (base == Game.GetForm(0x00045AC9) as ActorBase) ; 5 ---=== Deacon ===---
		assignedMaxHealth       = 85
		Trace("Deacon Detected: [" + assignedMaxHealth + "] base")
		; originalEndurance    = 7.0
	elseif (base == Game.GetForm(0x0001D15C) as ActorBase) ; 6 ---=== Dogmeat ===---
		assignedMaxHealth       = 140
		Trace("Dogmeat Detected: [" + assignedMaxHealth + "] base")
		; originalEndurance    = 4.0
	elseif (base == Game.GetForm(0x00022613) as ActorBase) ; 7 ---=== Hancock ===---	
		assignedMaxHealth       = 60
		Trace("Hancock Detected: [" + assignedMaxHealth + "] base")
		; originalEndurance    = 8.0
	elseif (base == Game.GetForm(0x0002740E) as ActorBase) ; 8 ---=== MacCready ===---	
		assignedMaxHealth       = 35
		Trace("MacCready Detected: [" + assignedMaxHealth + "] base")
		; originalEndurance    = 9.0
	elseif (base == Game.GetForm(0x00002F24) as ActorBase) ; 9 ---=== Nick Valentine ===---
		assignedMaxHealth       = 100
		Trace("Nick Detected: [" + assignedMaxHealth + "] base")
		; originalEndurance    = 8.0
	elseif (base == Game.GetForm(0x00002F1E) as ActorBase) ; 10 ---=== Piper ===---	
		assignedMaxHealth       = 85
		Trace("Piper Detected: [" + assignedMaxHealth + "] base")
		; originalEndurance    = 7.0
	elseif (base == Game.GetForm(0x00019FD9) as ActorBase) ; 11 ---=== Preston ===---
		assignedMaxHealth       = 85
		Trace("Preston Detected: [" + assignedMaxHealth + "] base")
		; originalEndurance       = 7.0
	elseif (base == Game.GetForm(0x00027682) as ActorBase) ; 12 ---=== Strong ===---
		assignedMaxHealth       = 120
		Trace("Strong Detected: [" + assignedMaxHealth + "] base")
		; originalEndurance    = 8.0
	elseif (base == Game.GetForm(0x000BBEE6) as ActorBase) ; 13 ---=== X6-88 ===---	
		assignedMaxHealth       = 135
		Trace("X6-88 Detected: [" + assignedMaxHealth + "] base")
		; originalEndurance    = 17.0
	elseif (base == pTweakCompanionNate) ; ---=== Nate ===---
		Trace("Nate Detected: [" + assignedMaxHealth + "] base")
		assignedMaxHealth       = 135
		; originalEndurance    = 7.0
	elseif (base == pTweakCompanionNora) ; ---=== Nora ===---	
		assignedMaxHealth       = 135
		Trace("Nora Detected: [" + assignedMaxHealth + "] base")
		; originalEndurance    = 5.0
	else
		int ActorBaseID = base.GetFormID()
		if (ActorBaseID > 0x00ffffff)		
			int ActorBaseMask
				
			if ActorBaseID > 0x80000000			
				ActorBaseMask = (ActorBaseID - 0x80000000) % (0x01000000)
			else
				ActorBaseMask = ActorBaseID % (0x01000000)
			endif
				
			if 0x0000FD5A == ActorBaseMask ; Ada
				assignedMaxHealth       = 145
				Trace("Ada Detected: [" + assignedMaxHealth + "] base")
				; originalEndurance    = 7.0
			elseif 0x00006E5B == ActorBaseMask ; Longfellow
				assignedMaxHealth       = 135
				Trace("Longfellow Detected: [" + assignedMaxHealth + "] base")
				; originalEndurance    = 7.0
			elseif 0x0000881D == ActorBaseMask ; Porter Gage
				assignedMaxHealth       = 135
				Trace("Gage Detected: [" + assignedMaxHealth + "] base")
				; originalEndurance    = 7.0
			endif
		endif
	endif
	
	if (assignedMaxHealth < 1)
		assignedMaxHealth = 85
		Trace("Unrecognized: [" + assignedMaxHealth + "] base")
	endif
	
	; The game provides a levelup boost of 5 per pc level
	; In most cases, the min level is level 10. So if they 
	; are less than level 10, just give them a boost of 50. 
	; If they are greater, compute the boost
	
	if (pc.GetLevel() > 10)
		float boost = (pc.GetLevel() * 5.0)
		Trace("PC.LEVEL > 10 : Adding [" + boost + "]")		
		assignedMaxHealth += boost
	else
		Trace("PC.LEVEL <= 10 : Adding [50]")		
		assignedMaxHealth += 50.0
	endif
	
	; Each stat allocated over 5 adds 25 points of health.
    ; So at 10, the follower got a health boost of 125 
    ; and at 25, the boost is 500.
	
	if npc.GetBaseValue(pEndurance) > minEndurance
		minEndurance = npc.GetBaseValue(pEndurance)
	endif
	if (minEndurance > 5.0)
		float boost = ((minEndurance - 5.0) * 25.0)
		Trace("minEndurance > 5 : Adding [" + boost + "]")
		assignedMaxHealth += boost
	else
		Trace("NPC.Endurance <= 5 : No Boost")
	endif
	
	EnforceMaxHealth()
	
	if (npc.GetBaseValue(pEndurance) <= originalEndurance)
		assignedMaxHealth = -1
	endif
	
EndFunction

Function ToggleAllowAutonomousPickup()
	Actor npc = self.GetActorRef()
	if (0.0 == TweakAllowAutonomousPickup.getValue())
		if npc.HasPerk(pTweakCarryBoost)
			npc.RemovePerk(pTweakCarryBoost)
		endIf
		npc.ModValue(pCarryWeight, 0)			
		enforceCarryWeight = 0
		enforceSettings()
	else
		npc.ModValue(pCarryWeight, 0)			
		ResetCarryWeight()
	endIf
	UnregisterForMenuOpenCloseEvent("ContainerMenu")
	RegisterForMenuOpenCloseEvent("ContainerMenu")
EndFunction

Function ResetCarryWeight()
	Actor npc = self.GetActorRef()
	enforceCarryWeight = -1
	if npc.IsInFaction(pTweakPackMuleFaction)
		enforceCarryWeight = 2000
	else
		enforceCarryWeight = (originalBaseCarryWeight + (npc.GetValue(pStrength) * 10.0)) as int
		if 1.0 == HC_Rule_DamageWhenEncumbered.GetValue()
			enforceCarryWeight -= 50
		endif
	endif
EndFunction

float Function GetCarryWeightInfo()
	Actor npc = self.GetActorRef()
	if npc.IsInFaction(pTweakPackMuleFaction)
		return 2000.0
	else
		float cinfo = (originalBaseCarryWeight + (npc.GetValue(pStrength) * 10.0))
		if 1.0 == HC_Rule_DamageWhenEncumbered.GetValue()
			cinfo -= 50.0
		endif
		return cinfo
	endif
EndFunction

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

; BUGFIX: When player changes Followers equipment, the perks are lost. 
; This can cause a sudden drop in health and kill the NPC. So we make
; all companions invulnerable when trade menu opens. When the menu closes, 
; we reset AFT's perks before removing the invulnerability. (And heal the 
; npc if they are 0 or less HP).

Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	if (asMenuName == "ContainerMenu")	
		Actor npc = self.GetActorRef()
		bool allowCarryPerk = (1.0 == TweakAllowAutonomousPickup.getValue())
		
		if abOpening == true
			Trace("EventTradeBegin()")
			TradeMenuOpen = true	
			npc.StartDeferredKill()
			TradeHealth = npc.GetValue(pHealth)
			if !allowCarryPerk
				FixCarryWeightForTradeStart()
			endif
		else
			Trace("EventTradeEnd()")
			TradeMenuOpen = false
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
				if allowCarryPerk
					npc.RemovePerk(pTweakCarryBoost)
				endif
				npc.RemovePerk(pTweakZeroCarryInCombat)
				npc.RemovePerk(pTweakRangedDmgBoost)
				npc.RemovePerk(pCompanionInspirational)
				npc.RemoveSpell(pAbMagLiveLoveCompanionPerks)
				npc.RemovePerk(Sneak01)
				npc.RemovePerk(Sneak02)
				npc.RemovePerk(Sneak03)
				npc.RemovePerk(Sneak04)
				npc.RemovePerk(ImmuneToRadiation)
				
				Utility.wait(1.0)
				Trace("Adding Perks Back")
				npc.AddPerk(ImmuneToRadiation)
				npc.AddPerk(pTweakDmgResistBoost)
				if allowCarryPerk
					npc.AddPerk(pTweakCarryBoost)
				endif
				npc.AddPerk(pTweakZeroCarryInCombat)
				npc.AddPerk(pTweakRangedDmgBoost)
				npc.AddPerk(pCompanionInspirational)
				npc.AddSpell(pAbMagLiveLoveCompanionPerks)	
				npc.AddPerk(Sneak01)
				npc.AddPerk(Sneak02)
				npc.AddPerk(Sneak03)
				npc.AddPerk(Sneak04)
				Trace("Perks restored")
			endif
			if !allowCarryPerk
				FixCarryWeightForTradeEnd()		
			endif	
			if endDeferred
				npc.EndDeferredKill()
			endif				
			enforceSettings()
		endif
	endif
EndEvent

Function FixCarryWeightForTradeStart()
	Trace("TmpEnableCarryWeight()")
	ResetCarryWeight()
	Actor npc = self.GetActorRef()
	if enforceCarryWeight > -1 && (enforceCarryWeight != npc.GetValue(pCarryWeight))
		Trace("Attempt 1")
		npc.SetValue(pCarryWeight, enforceCarryWeight)
		Utility.WaitMenuMode(0.1)
		float currentCarryWeight = npc.GetValue(pCarryWeight)
		if (currentCarryWeight == enforceCarryWeight)
			Trace("Attempt 1 : Success!")
		else
			Trace("Attempt 1 : Failure. Current CarryWeight [" + currentCarryWeight + "]. Retrying")
			float diff = (enforceCarryWeight - currentCarryWeight)
			npc.ModValue(pCarryWeight, diff)
			Utility.WaitMenuMode(0.1)
			currentCarryWeight = npc.GetValue(pCarryWeight)
			if (currentCarryWeight == enforceCarryWeight)
				Trace("Attempt 2 : Success!")
			else
				Trace("Attempt 2 : Failure. Current CarryWeight [" + currentCarryWeight + "]. Bailing")
			endif
		endif
	endif
EndFunction

Function FixCarryWeightForTradeEnd()
	enforceCarryWeight = 0
	if (enforceCarryWeight != self.GetActorRef().GetValue(pCarryWeight))
		enforceSettings()
	endif
endFunction

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
	AFT:TweakSettlersScript AFTSettlers = (pTweakSettlers as AFT:TweakSettlersScript)		

		
	WorkshopNPCScript    WNS = npc as WorkshopNPCScript
	CompanionActorScript CAS = npc as CompanionActorScript
	DogmeatActorScript   DAS = npc as DogmeatActorScript
	
	originalIgnoreHits   = npc.IsIgnoringFriendlyHits()
	originalAggression   = npc.GetBaseValue(pAggression)  As Int	
	
	; We want derrived carryweight. Most NPCs default to 250 so 
	; the actor record slaps on a -100 modifier. If we get base, 
	; we ignore the modifier can get inflated values. 
	
	
	; 1.20 : In order to prevent NPCs from picking up items
	; they shouldn't, AFT now tightly manages carryweight.
	;
	; By that, I mean carryweight is enforced to be 0 at all times. 
	; The only time it changes is when the trade menu opens/closes. 
	;
	; At that moment, we set the carryweight to what it SHOULD be. 
	; That is: BASE  + 10 per strength or simply 2000 if packmule is enabled.
	; The one gotcha is that Strength can change as a result of an 
	; OnItemEquipped or OnItemUnEquipped event. So we must catch these
	; and update accordingly. 
		
	
	originalCarryWeight     = npc.GetValue(pCarryWeight) As Int
	originalBaseCarryWeight = -1.0
	originalHealth     		= npc.GetValue(pHealth) As Int
	assignedMaxHealth       = -1.0
	
	originalStrength        = -1.0
	originalEndurance       = -1.0
	
	
	originalPerception   = npc.GetBaseValue(pPerception)
	originalCharisma     = npc.GetBaseValue(pCharisma)
	originalIntelligence = npc.GetBaseValue(pIntelligence)
	originalAgility      = npc.GetBaseValue(pAgility)
	originalLuck         = npc.GetBaseValue(pLuck)	
	
	originalRace         = npc.GetRace()
	originalEssential    = npc.IsEssential()
	originalProtected    = npc.GetActorBase().IsProtected()
		
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
	
	; 0x000A7D35 = Original Female Spouse
	; 0x000A7D34 = Original Male Spouse
	if ActorBaseID > 0x00ffffff || ActorBaseID == 0x000A7D35 || ActorBaseID == 0x000A7D34
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
			RobotFaction = pDLC01WorkshopRobotFaction
			wasDLCRobot = true
		elseif pTweakDLC01.DLC01WorkshopRobotFaction && npc.IsInFaction(pTweakDLC01.DLC01WorkshopRobotFaction)
			originalFactions.Add(pTweakDLC01.DLC01WorkshopRobotFaction)
			RobotFaction = pTweakDLC01.DLC01WorkshopRobotFaction
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
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 7.0
		
	elseif (base == Game.GetForm(0x000179FF) as ActorBase) ; 2 ---=== Codsworth ===---
	
		Trace("Codsworth Detected.")
		corecompanion = true
		originalHome = Game.GetForm(0x0001F229) as Location ; SanctuaryHillsPlayerHouseLocation
        originalHomeRef = CodsworthKitchenMarker
		originalBaseCarryWeight = 110.0
		originalStrength        = 9.0
		originalEndurance       = 7.0
		
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
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 4.0

		; This actorvalue controls appearance restrictions. We set to human 
		; So that you can pose Curie once she changes to human. 
		npc.SetValue(pTweakOriginalRace, pHumanRace.GetFormID())
		
	elseif (base == Game.GetForm(0x00027683) as ActorBase) ; 4 ---=== Danse ===---
	
		Trace("Danse Detected.")
		corecompanion = true
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 8.0

		
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
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 7.0

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
		originalBaseCarryWeight = 160.0
		originalStrength        = 4.0
		originalEndurance       = 4.0
		
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
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 8.0

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
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 4.0

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
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 8.0

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
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 7.0

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
		originalBaseCarryWeight = 150
		originalStrength        = 5.0
		originalEndurance       = 7.0

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
		originalBaseCarryWeight = 390.0
		originalStrength        = 24.0
		originalEndurance       = 8.0

		if originalCarryWeight < 200
			originalCarryWeight = 200
		endif
		
	elseif (base == Game.GetForm(0x000BBEE6) as ActorBase) ; 13 ---=== X6-88 ===---	
	
		Trace("X6-88 Detected.")
		corecompanion = true
		originalHome = Game.GetForm(0x001BBC22) as Location ; InstituteSRBLocation	
		originalHomeRef = InstSceneAlaneJustin1JustinMarker
		originalBaseCarryWeight = 310.0
		originalStrength        = 16.0
		originalEndurance       = 17.0
		
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
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 7.0

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
		
		originalBaseCarryWeight = 150.0
		originalStrength        = 5.0
		originalEndurance       = 5.0
	
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
				
				originalBaseCarryWeight = 110.0
				originalStrength        = 9.0
				originalEndurance       = 7.0
				
			elseif 0x00006E5B == ActorBaseMask ; Longfellow
				corecompanion = true
				originalBaseCarryWeight = 150.0
				originalStrength        = 5.0
				originalEndurance       = 7.0
				
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
				originalBaseCarryWeight = 150.0
				originalStrength        = 7.0
				originalEndurance       = 7.0
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
		
			originalBaseCarryWeight = npc.GetBaseValue(pCarryWeight)
			originalStrength        = npc.GetBaseValue(pStrength)
			originalEndurance       = npc.GetBaseValue(pEndurance)
		
			if (CAS)
				Trace("CAS Detected. Using CAS.HomeLocation")
				originalHome    = CAS.HomeLocation
				originalHomeRef = AFTSettlers.LocationToMarker(originalHome)
			elseif (DAS)
				Trace("DAS Detected. Using DAS.HomeLocation")
				originalHome    = DAS.HomeLocation
				originalHomeRef = AFTSettlers.LocationToMarker(originalHome)
			endIf
		endif
		
		if (!originalHome && WNS)
			WorkshopParentScript pWorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
			int workshopID = npc.GetValue(pWorkshopParent.WorkshopIDActorValue) as int
			if (workshopID > -1)
				Trace("WNS Detected. Using WNS.WorkshopIDActorValue")
				originalHome    = AFTSettlers.WorkShopIDToLocation(workshopID)
				originalHomeRef = AFTSettlers.LocationToWorkShopMarker(originalHome)
			endif
		endif
		
		if (!originalHome && npc.IsInFaction(pTweakSettlerFaction))
			int workshopid = AFTSettlers.TweakGetWorkshopId(npc)
			if (workshopID > -1)
				originalHome    = AFTSettlers.WorkShopIDToLocation(workshopID)
				originalHomeRef = AFTSettlers.LocationToWorkShopMarker(originalHome)
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
		int i = 1 ; intentionally 1
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
	
	if originalCarryWeight < 150
		Trace("Adjusting Original Carry Weight to 150")
		originalCarryWeight = 150
	endif
	if originalBaseCarryWeight < 150.0
		Trace("Adjusting Original BASE Carry Weight to 150")
		originalBaseCarryWeight = 150.0
	endif
		
	ReEvaluateHealth()

	Trace("Original Strength        [" + originalStrength + "]")
	Trace("Original Endurance       [" + originalEndurance + "]")
	Trace("Original BaseCarryWeight [" + originalBaseCarryWeight + "]")
	
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
	
	; 1.20 : HasBeenCompanion Faction prevents trade menu from appearing
	;        on non-core companions when unmanaged. So we add it directly
	;        instead of hiding it in the originalFactions:
	
	; npc.AddToFaction(originalFactions[0])
	npc.AddToFaction(Game.GetForm(0x000A1B85) as Faction)  ; HasBeenCompanionFaction
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
			assignedHome    = AFTSettlers.WorkShopIDToLocation(workshopID)
			assignedHomeRef = AFTSettlers.LocationToWorkShopMarker(assignedHome)
			npc.AddToFaction(pTweakSkipGoHomeFaction)
		endif
	endif
	if (npc.IsInFaction(pTweakSettlerFaction))
		int workshopID = AFTSettlers.TweakGetWorkshopId(npc)
		if (workshopID > -1)
			assignedHome    = AFTSettlers.WorkShopIDToLocation(workshopID)
			assignedHomeRef = AFTSettlers.LocationToWorkShopMarker(assignedHome)
			npc.AddToFaction(pTweakSkipGoHomeFaction)
		endif		
	endIf
	
	
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
			assignedHomeRef = AFTSettlers.LocationToMarker(CAS.HomeLocation)
		elseif (DAS && DAS.HomeLocation)
			assignedHomeRef = AFTSettlers.LocationToMarker(DAS.HomeLocation)
		endIf
		if (!assignedHomeRef)
			assignedHomeRef = originalHomeRef
		endIf
	endif
	
	((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef = assignedHomeRef
	npc.SetLinkedRef(assignedHomeRef,pTweakLocHome)
	
	if assignedHome && npc.IsCreated()
		npc.SetPersistLoc(assignedHome)
	endif
		
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
	
	UnregisterForMenuOpenCloseEvent("ContainerMenu")
	RegisterForMenuOpenCloseEvent("ContainerMenu")
	
endFunction

Function EventOnGameLoad()
	UnregisterForMenuOpenCloseEvent("ContainerMenu")
	RegisterForMenuOpenCloseEvent("ContainerMenu")
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
			Keyword	WorkshopKeyword	=	Game.GetForm(0x00054BA7) as Keyword
			if !assignedHomeRef.HasKeyword(WorkshopKeyword)
				assignedHomeRef.SetPersistLoc(None)
				assignedHomeRef.Disable()
				assignedHomeRef.Delete()
			endif
		endif
	else
		trace("dynamicAssignment is false")
	endif
	
	if (dynamicHome) ; Needs Cleanup...
		dynamicHome = false
		if originalHomeRef
			Keyword	WorkshopKeyword	=	Game.GetForm(0x00054BA7) as Keyword
			if !originalHomeRef.HasKeyword(WorkshopKeyword)
				originalHomeRef.Disable()
				originalHomeRef.Delete()
			endif
		endif
		originalHomeRef = None
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
	
	npc.RemovePerk(pTweakDmgResistBoost)
	npc.RemovePerk(pTweakCarryBoost)
	if npc.HasPerk(pTweakHealthBoost)
		SafelyRemoveHealthBoost()
	endif
	npc.RemovePerk(pTweakRangedDmgBoost)
	
	; 1.20 : Because of the various import options, it is near impossible 
	; here to know if it is safe to remove everything. So we are much more
	; fine grained in our cleanup now:
	
	; Remove all the TweakFactions....
	Trace("Removing From All Tweak Factions")
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
	Faction TweakMedicFaction         = Game.GetFormFromFile(0x01029B3B,"AmazingFollowerTweaks.esp") as Faction
	Faction TweakMedicSpecialFaction  = Game.GetFormFromFile(0x0102B20B,"AmazingFollowerTweaks.esp") as Faction
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
	Faction	TweakUseCombatWeaponFaction = Game.GetFormFromFile(0x010265EE,"AmazingFollowerTweaks.esp") as Faction
	
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
	if npc.IsInFaction(TweakMedicFaction)
		npc.RemoveFromFaction(TweakMedicFaction)
	endif
	if npc.IsInFaction(TweakMedicSpecialFaction)
		npc.RemoveFromFaction(TweakMedicSpecialFaction)
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
	if npc.IsInFaction(TweakUseCombatWeaponFaction)
		npc.RemoveFromFaction(TweakUseCombatWeaponFaction)
	endif	
	
	if !IsCoreCompanion(npc)
	
;		bool clearAll = true
		ActorBase base  = npc.GetActorBase()
		int ActorBaseID = base.GetFormID()
		
		if ActorBaseID < 0x01000000
			npc.RemoveFromFaction(Game.GetForm(0x000A1B85) as Faction) ; HasBeenCompanion
			npc.RemovePerk(pCompanionInspirational)
			npc.RemoveSpell(pAbMagLiveLoveCompanionPerks)
			npc.RemovePerk(Sneak01)
			npc.RemovePerk(Sneak02)
			npc.RemovePerk(Sneak03)
			npc.RemovePerk(Sneak04)
			npc.RemovePerk(ImmuneToRadiation)		
		endif

		; In Case they used the Voice Menu to assign an override...
		npc.SetOverrideVoiceType(None)
		
;		TweakDLC01Script pTweakDLC01 = TweakDLC01 as TweakDLC01Script
;		TweakDLC03Script pTweakDLC03 = TweakDLC03 as TweakDLC03Script
;		TweakDLC04Script pTweakDLC04 = TweakDLC04 as TweakDLC04Script
;		int pluginID = GetPluginID(ActorBaseID)
;		
;		if pTweakDLC01 && pTweakDLC01.Installed
;			if pluginID == pTweakDLC01.resourceID
;				clearAll = false
;			endif
;		endif
;		if pTweakDLC03 && pTweakDLC03.Installed
;			if pluginID == pTweakDLC03.resourceID
;				clearAll = false
;			endIf
;		endIf
;		if pTweakDLC04 && pTweakDLC04.Installed
;			if pluginID == pTweakDLC04.resourceID
;				clearAll = false
;			endIf
;		endIf
		
;		if clearAll
;
;		endif
		
	endif
			
	Trace("Restoring Original Factions")
	int numFactions = originalFactions.Length
	int i = 1 ; intentionally 1
	
	; What if they were in DisallowedCompanionFaction and you force 
	; recruited them anyway? Then they would be returned to that. But 
	; that may be bad if the user turns around and re-installs. The 
	; Companion would not be auto-imported in that case. 
	
	Faction DisallowedCompanionFaction = Game.GetForm(0x00075D76) as Faction
	while (i < numFactions)
		if originalFactions[i] != DisallowedCompanionFaction
			npc.AddToFaction(originalFactions[i])
		endif
		i += 1
	endWhile
	
	if (originalCrimeFaction)
		npc.AddToFaction(originalCrimeFaction)
		originalCrimeFaction = None
		npc.MakePlayerFriend() ; In case PC attacked their faction
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
	assignedMaxHealth = -1

	if npc.GetValue(pStrength) != originalStrength
		npc.SetValue(pStrength, originalStrength)
	endIf
	if npc.GetValue(pPerception) != originalPerception
		npc.SetValue(pPerception, originalPerception)
	endIf
	if npc.GetValue(pEndurance) != originalEndurance
		npc.SetValue(pEndurance, originalEndurance)
	endIf
	if npc.GetValue(pCharisma) != originalCharisma
		npc.SetValue(pCharisma, originalCharisma)
	endIf
	if npc.GetValue(pIntelligence) != originalIntelligence
		npc.SetValue(pIntelligence, originalIntelligence)
	endIf
	if npc.GetValue(pAgility) != originalAgility
		npc.SetValue(pAgility, originalAgility)
	endIf
	if npc.GetValue(pLuck) != originalLuck
		npc.SetValue(pLuck, originalLuck)
	endIf
			
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
	
	
	; Q: Should we remove HasBeenCompanionFaction so that WorkshopNPC Settlers
	; will trade? 
	; A: Not for now. Users can still access gear with AFT Activator as long
	; as they remain managed.
	
	; Game.GetForm(0x000A1B85) as Faction ; 
	

endFunction

Actor[] targets = None

; cState 0 is unreliable. When the player has companions, only the last companion to deal 
; a killing blow receives the 0 state. And if the player deals the killing blow, no one
; receives it. Pre 1.2, we attempted to centralize events so that "whoever" got state
; 0 sent it to TweakFollowerScript who then relayed the event to eveyone else. However, 
; that wasn't reliable. So starting with 1.20 we use a renewable timer that calls
; a function on TweakFollowerScript to get the CombatStatus of the team. Timer will
; keep renewing until none of the team members (or the player if playing solo) have
; an active target. This causes a delay so that combat end event fires... 19 to 24 seconds
; after combat actually ends. However, I felt this was a good thing. It gives the 
; player time to initiate combat with someone else without the party do too much 
; cleanup and is more realistic from the perspective of outfits, etc... People
; don't put there normal clothes on the SECOND the last enemy falls. 
Event OnCombatStateChanged(Actor akTarget, int cState)
	Trace("OnCombatStateChanged [" + cState + "]")
	Actor npc = self.GetActorRef()
			
	if (1 != cState)
		Trace("cState is not 1, returning")
		return
	endIf
		
	; 1 == cState : Combat Started/ New Target Aquired
	if (akTarget)
		if (akTarget == Game.GetPlayer())
			if !npc.IsInFaction(pTweakAllowFriendlyFire)
				npc.StopCombat()
				npc.StopCombatAlarm()
				npc.MakePlayerFriend()
				Utility.wait(0.1)
				return
			endif
		elseif (akTarget.IsInFaction(pTweakFollowerFaction))
			npc.StopCombat()
			npc.StopCombatAlarm()
			akTarget.StopCombat()
			akTarget.StopCombatAlarm()
		endif
		
	endIf
	
	if (!combatInProgress)
		OnCombatBegin()
	else
		Trace("Ignoring Event. CombatInProgress already true")
	endif
	
	if trackKills && npc.IsInFaction(pCurrentCompanionFaction)
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
	endIf
	
endEvent

Function OnCombatBegin()
	Trace("OnCombatBegin()")
	combatInProgress = true
	Var[] noparams = new Var[0]
	Trace("Sending Relay Event to TweakInventoryControl")
	ReferenceAlias r = (self as ReferenceAlias)
	if r
		TweakInventoryControl pTweakInventoryControl = (r as TweakInventoryControl)
		if pTweakInventoryControl
			Trace("Sending Event OnCombatBegin")
			pTweakInventoryControl.CallFunctionNoWait("OnCombatBegin",noparams)
		else
			Trace("Caste to TweakInventoryControl Failed!")		
		endif
		TweakMedical pTweakMedical = (r as TweakMedical)
		if pTweakMedical
			Trace("Sending Event OnCombatBegin")
			pTweakMedical.CallFunctionNoWait("OnCombatBegin",noparams)
		else
			Trace("Caste to TweakMedical Failed!")		
		endif
		
	else
		Trace("Caste to ReferenceAlias Failed!")
	endif	
	StartTimer((20 + Utility.RandomInt(-5,5)),COMBATEND_DELAYED)
EndFunction

Function OnCombatPeriodic()
	Trace("OnCombatPeriodic()")
	Var[] noparams = new Var[0]
	ReferenceAlias r = (self as ReferenceAlias)
	if r
		TweakInventoryControl pTweakInventoryControl = (r as TweakInventoryControl)
		if pTweakInventoryControl
			Trace("Sending Event OnCombatPeriodic")
			pTweakInventoryControl.CallFunctionNoWait("OnCombatPeriodic",noparams)
		else
			Trace("Caste to TweakInventoryControl Failed!")		
		endif
		TweakMedical pTweakMedical = (r as TweakMedical)
		if pTweakMedical
			Trace("Sending Event OnCombatPeriodic")
			pTweakMedical.CallFunctionNoWait("OnCombatPeriodic",noparams)
		else
			Trace("Caste to TweakMedical Failed!")		
		endif
		
	else
		Trace("Caste to ReferenceAlias Failed!")
	endif		
EndFunction


; Typically called by TweakFollowersScript. RelayCombatEnd, which means you can't assume the npc
; is still alive or enabled...
Function OnCombatEnd()
	Trace("OnCombatEnd()")
	combatInProgress = false
	CancelTimer(COMBATEND_DELAYED)
	Var[] noparams = new Var[0]
	ReferenceAlias r = (self as ReferenceAlias)
	if r
		TweakInventoryControl pTweakInventoryControl = (r as TweakInventoryControl)
		if pTweakInventoryControl
			Trace("Sending Event OnCombatEnd")
			pTweakInventoryControl.CallFunctionNoWait("OnCombatEnd",noparams)
		else
			Trace("Caste to TweakInventoryControl Failed!")		
		endif
		TweakMedical pTweakMedical = (r as TweakMedical)
		if pTweakMedical
			Trace("Sending Event OnCombatEnd")
			pTweakMedical.CallFunctionNoWait("OnCombatEnd",noparams)
		else
			Trace("Caste to TweakMedical Failed!")		
		endif
		
	else
		Trace("Caste to ReferenceAlias Failed!")
	endif			
	
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

Event OnTimer(int akTimerId)
	if (ONLOAD_FLOOD_PROTECT == akTimerId)
		OnLoadHelper()
		return
	endif
	if (COMBATEND_DELAYED == akTimerID)
		bool companionsInCombat = false
		AFT:TweakFollowerScript pTweakFollowerScript = (self.GetOwningQuest() as AFT:TweakFollowerScript)
		if pTweakFollowerScript
			combatInProgress = (self.GetActorRef().IsInCombat() || pTweakFollowerScript.GetCompanionsInCombat())
		else
			combatInProgress = self.GetActorRef().IsInCombat()
		endif
				
		if combatInProgress
			Trace("Renewing Combat Timer")
			StartTimer((20 + Utility.RandomInt(-5,5)),COMBATEND_DELAYED)
			OnCombatPeriodic()
		else
			OnCombatEnd()
		endif
		return
	endif
EndEvent

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
	Actor npc = self.GetActorRef()
	if enabled
		if !npc.IsInFaction(pTweakPackMuleFaction)
			npc.AddToFaction(pTweakPackMuleFaction)
		endif		
		if 1.0 == TweakAllowAutonomousPickup.GetValue()
			enforceCarryWeight = 2000		
			enforceSettings()
		endif
	else
		if npc.IsInFaction(pTweakPackMuleFaction)
			npc.RemoveFromFaction(pTweakPackMuleFaction)
		endif
		if 1.0 == TweakAllowAutonomousPickup.GetValue()
			ResetCarryWeight()
			enforceSettings()
		endif
	endif
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

	; AI Notes: 
	;
	; Quest TweakFollower pushes 3 Packages on all managed Followers (Priority 91)
	;   TweakPosed    <- Keeps follower in pose. Some commands like sculpt/parts will also use this package to hold the NPC in place.
	;   TweakEnterPA  <- Used when follower is instructed to get into PA
	;   TweakStayHere <- Stand where you are if not follower and (nohomefaction or (camphome faction and camp is not setup))
	;
	; Quest Followers pushes 21 Packages (and another dozen or so for combat) on all ACTIVE Followers (Priority 90)	
    ;
	; Quest TweakLowPriortyAI pushes 2 Packages on all Managed Followers (Priority 42)
	;   TweakGoHome <- As it sounds. But is skipped if Follower is in TweakSkipGoHomeFaction
	;   TweakGoCamp <- As it sounds. But is skipped unless the Follower is in TweakCampHomeFaction
	;
	; Quest TweakSettlers pushes 13 Packages on any Settlers (Priorit 41)
	;   Various Settlement related AI Packages....
	;
	; Quest WorkshopPermanentActor pushes 1 package on all Workshop Assigned WNS companions (Priority 40)
	;   WorkshopMasterPackage (Only works on NPCs with WNS script attached)
	
	Actor pc  = Game.GetPlayer()
	Actor npc = self.GetActorReference()
		
	
	; Tweak Dismiss has some aliases on it so we can make a nice Message Box
	; with filled in text. 
	AFT:TweakDismissScript pTweakDismissScript = pTweakDismiss as AFT:TweakDismissScript
	
	WorkshopParentScript pWorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
	Keyword WorkshopLinkHome             = Game.GetForm(0x0002058F) as Keyword

	int choice = 4 ; 0 = OriginalHome, 1 = Current Location (NoHome), 2 = AFT Camp, 3 = Settlement, 4 = Cancel
	bool camphomeFaction = false
	
	if (pTweakDismissScript)
		choice = pTweakDismissScript.ShowMenu(npc,originalHome, assignedHome)
		trace("choice = [" + choice + "]")
	endif

	if (4 == choice)
		return
	endif
	
	; The issue with removing upfront is they may choose to assign a settlement and then cancel.
	; So we repeat the cleanup code in each case to avoid it in the exception:
	AFT:TweakSettlersScript AFTSettlers = (pTweakSettlers as AFT:TweakSettlersScript)		
	
	if (0 == choice)  ; Original
	
		; Cleanup
		AssignCleanHelper(npc)
		
		Trace("Attempting to restore original Home")
				
		assignedHome    = originalHome
		assignedHomeRef = originalHomeRef
		
		if (assignedHome && assignedHomeRef)
			WorkshopNPCScript    WNS = npc as WorkshopNPCScript
			CompanionActorScript CAS = npc as CompanionActorScript
				
			; 1.20 : If Original Home is a settlement (Sanctuary is defualt
			; for imported NPCs), and the NPC is ghoul, human, robot and !WNS,
			; then make them a TweakSettler
		
			AssignHomeHelper(npc, false)

			; Note : values checked above. We shouldn't get this far if either is NONE
			((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHome    = assignedHome
			((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef = assignedHomeRef
		
			; This is DEFAULT: Create an "anchor" for TweakLowPriorityAI. This is the fall back unless
			; something above added the NPC to the pTweakSkipGoHomeFaction.
		
			Trace("Adding TweakLocHom Reference...")		
			npc.SetLinkedRef(assignedHomeRef, pTweakLocHome)
		else
			; This shouldn't happen as we default to SanctuaryHills. 
			Trace("Assertion Error. originalHome is None.")
			npc.AddToFaction(pTweakNoHomeFaction)
		endIf
		
		if assignedHome
			if npc.IsCreated() && (assignedHome != pTweakCampLocation) 
				npc.SetPersistLoc(assignedHome)
			endif
		endif
		
		return
		
	endIf
	
	
	if (1 == choice) ; Current Location
		bool isSettlement = false
		; Cleanup
		AssignCleanHelper(npc)
				
		Trace("Examining current Location")		
		
		; We use "candidate" values so that we can bail if things go wrong and npc
		; has valid entries. 
		
		ObjectReference origin       = pc
		assignedHome                 = pc.GetCurrentLocation()
		
		if !assignedHome
			assignedHome = npc.GetCurrentLocation()
			if assignedHome
				origin = npc
			else
				WorkshopScript workshopRef = FindNearbyWorkshop(pc)
				if workshopRef
					assignedHomeRef = workshopRef
					assignedHome = workshopRef.GetCurrentLocation()
 					origin = pc
					isSettlement = true
				else					
					workshopRef = FindNearbyWorkshop(npc)
					if workshopRef
						assignedHomeRef = workshopRef
						assignedHome = workshopRef.GetCurrentLocation()
						origin = npc
						isSettlement = true
					endIf
				endIf
			endIf
		endIf
		
		if (assignedHome)
		
			if !assignedHomeRef
				if AFTSettlers
					assignedHomeRef = AFTSettlers.LocationToMarker(assignedHome)
				endif
			endif
			
			if !assignedHomeRef
				WorkshopScript workshopRef = FindNearbyWorkshop(pc)
				if workshopRef
					assignedHomeRef = workshopRef
 					origin = pc
					isSettlement = true
				else					
					workshopRef = FindNearbyWorkshop(npc)
					if workshopRef
						assignedHomeRef = workshopRef
						origin = npc
						isSettlement = true
					endIf
				endIf				
			endif
			
			if !isSettlement
				; Confirm
				if AFTSettlers
					if AFTSettlers.LocationToWorkShop(assignedHome)
						isSettlement = true
					elseif assignedHomeRef as WorkshopScript
						isSettlement = true
					endif
				else
					if pWorkshopParent.GetWorkshopFromLocation(assignedHome)
						isSettlement = true
					elseif assignedHomeRef as WorkshopScript
						isSettlement = true
					endif
				endif				
			endif
			
			AssignHomeHelper(npc, isSettlement) 
			
			; Codsworth Check
			if npc.GetActorBase() == (Game.GetForm(0x000179FF) as ActorBase)
				Quest DialogueCodsworthPostWar = Game.GetForm(0x0001E64E) as Quest
				if DialogueCodsworthPostWar && DialogueCodsworthPostWar.IsRunning()
					; Alias on quest forces Codsworth back to Sanctuary. But it
					; isn't needed after he is following you.
					DialogueCodsworthPostWar.Stop()
				endif
			endif
			
		endif
				
		if !assignedHomeRef
			dynamicAssignment = true
			assignedHomeRef   = origin.PlaceAtMe(XMarkerHeading, 1, true)
			assignedHomeRef.SetPersistLoc(origin.GetCurrentLocation())
		endif
		
		npc.SetLinkedRef(assignedHomeRef, pTweakLocHome)
		((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHome    = assignedHome
		((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef = assignedHomeRef
		
		if assignedHome
			if npc.IsCreated() && (assignedHome != pTweakCampLocation) 
				npc.SetPersistLoc(assignedHome)
			endif
		endif
		
		return
		
	endif
	
	if (2 == choice) ; AFT CAMP 
	
		; Cleanup
		AssignCleanHelper(npc)

		Trace("Attempting to assign to Camp")
		
		assignedHome    = pTweakCampLocation
		assignedHomeRef = pAftMapMarker
		
		AssignHomeHelper(npc, false)
		
		npc.SetLinkedRef(assignedHomeRef, pTweakLocHome)
		((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHome    = assignedHome
		((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef = assignedHomeRef
		
		npc.AddToFaction(pTweakCampHomeFaction)	
		
		; Dont set persist location to pTweakCampLocation as it doesn't exist....
		return
		
	endif
		
	if (3 == choice) ; Choose Settlement	
	
		Location selection = assignedHome
		if !selection
			selection = originalHome
			if !selection
				selection = pc.GetCurrentLocation()
				if !selection
					selection = npc.GetCurrentLocation()
				endIf
			endIf
		endIf
		
		CompanionActorScript CAS = npc as CompanionActorScript
		
		if npc.GetActorBase().IsUnique()
			Trace("NPC [" + npc + "] is Unique")
			bool LimitSelection = false
			if CAS
				Trace("NPC [" + npc + "] is CAS")
				if CAS.AllowDismissToSettlements
					Trace("NPC [" + npc + "] has AllowDismissToSettlements")
					if (CAS.AllowDismissToSettlements.GetValue() > 0)
						Trace("NPC [" + npc + "] AllowDismissToSettlements >  0")
						if CAS.DismissCompanionSettlementKeywordList
							Trace("NPC [" + npc + "] has DismissCompanionSettlementKeywordList")
							LimitSelection = true
						else
							Trace("NPC [" + npc + "] does not have DismissCompanionSettlementKeywordList")						
						endIf
					else
						Trace("NPC [" + npc + "] AllowDismissToSettlements is 0")						
					endIf
				else
					Trace("NPC [" + npc + "] does not have AllowDismissToSettlements")						
				endIf
			else
				Trace("NPC [" + npc + "] is not CAS")						
			endIf
			
			if LimitSelection
				Trace("Calling OpenWorkshopSettlementMenuEx with DismissCompanionSettlementKeywordList")						
				selection = npc.OpenWorkshopSettlementMenuEx(akActionKW=pWorkshopParent.WorkshopAssignHomePermanentActor, aLocToHighlight=selection, akIncludeKeywordList=CAS.DismissCompanionSettlementKeywordList)
			else
				Trace("Calling OpenWorkshopSettlementMenuEx with WorkshopSettlementMenuExcludeList")						
				selection = npc.OpenWorkshopSettlementMenuEx(akActionKW=pWorkshopParent.WorkshopAssignHomePermanentActor, aLocToHighlight=selection, akExcludeKeywordList=pWorkshopParent.WorkshopSettlementMenuExcludeList)
			endif
			
			
		else
			Trace("NPC [" + npc + "] is not Unqiue")	
			bool LimitSelection = false		
			if CAS
				Trace("NPC [" + npc + "] is CAS")
				if CAS.AllowDismissToSettlements
					Trace("NPC [" + npc + "] has AllowDismissToSettlements")
					if (CAS.AllowDismissToSettlements.GetValue() > 0)
						Trace("NPC [" + npc + "] AllowDismissToSettlements >  0")
						if CAS.DismissCompanionSettlementKeywordList
							Trace("NPC [" + npc + "] has DismissCompanionSettlementKeywordList")
							LimitSelection = true
						else
							Trace("NPC [" + npc + "] does not have DismissCompanionSettlementKeywordList")						
						endIf
					else
						Trace("NPC [" + npc + "] AllowDismissToSettlements is 0")						
					endIf
				else
					Trace("NPC [" + npc + "] does not have AllowDismissToSettlements")						
				endIf
			else
				Trace("NPC [" + npc + "] is not CAS")						
			endIf
			
			if LimitSelection
				Trace("Calling OpenWorkshopSettlementMenuEx with DismissCompanionSettlementKeywordList")						
				selection = npc.OpenWorkshopSettlementMenuEx(akActionKW=pWorkshopParent.WorkshopAssignHome, aLocToHighlight=selection, akIncludeKeywordList=CAS.DismissCompanionSettlementKeywordList)
			else
				Trace("Calling OpenWorkshopSettlementMenuEx with WorkshopSettlementMenuExcludeList")						
				selection = npc.OpenWorkshopSettlementMenuEx(akActionKW=pWorkshopParent.WorkshopAssignHome, aLocToHighlight=selection, akExcludeKeywordList=pWorkshopParent.WorkshopSettlementMenuExcludeList)
			endif
		endif
		
		if (selection)
			Trace("Selection [" + selection + "] detected")
					
			; Cleanup
			AssignCleanHelper(npc)
			assignedHome = selection
			AssignHomeHelper(npc)		
			
			if npc.IsInFaction(pTweakSkipGoHomeFaction)
				assignedHomeRef = npc.GetLinkedRef(WorkshopLinkHome)
				Trace("NPC [" + npc + "] is in TweakSkipGoHomeFaction. Using HomeRef [" + assignedHomeRef + "]")
			else
				; As the chooser only allows workshops, if selection is non-null, this would be very unusal..
				; As the methods above should never fail on workshops.
				
				Trace("Unexpected failure : npc was not assigned to settlement [" + selection + "]")
				
				if AFTSettlers
					assignedHomeRef = AFTSettlers.LocationToWorkShopMarker(assignedHome)
				endIf
			endIf
			
			npc.SetLinkedRef(assignedHomeRef, pTweakLocHome)
			((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHome    = assignedHome
			((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef = assignedHomeRef
			
		else ; Cancel... No Change
			if !assignedHome
				; This shouldn't happen as we default to SanctuaryHills. 
				npc.AddToFaction(pTweakNoHomeFaction)
			endif			
		endif
		
		if assignedHome
			if npc.IsCreated() && (assignedHome != pTweakCampLocation) 
				npc.SetPersistLoc(assignedHome)
			endif
		endif
		
		return
	endIf
		
	if !assignedHome
		; This shouldn't happen as we default to SanctuaryHills. 
		npc.AddToFaction(pTweakNoHomeFaction)
	endif
	
EndFunction

Function SetConfidence(int value)
	enforceConfidence = value
	self.GetActorRef().SetValue(pConfidence,enforceConfidence)
EndFunction

; IgnoreFriendlyFire status and faction is set/handled by TweakPipBoyScript.

Function enforceSettings()
	Trace("enforceSettings()")
	
	Actor npc = self.GetActorRef()
	npc.SetNotShowOnStealthMeter(true)
	if (npc.IsInFaction(pTweakEssentialFaction))
		if !npc.IsEssential()
			npc.SetEssential(true)
		endif
	elseif npc.IsEssential()
		npc.SetEssential(false)
	endif

;	if (0.0 == TweakAllowAutonomousPickup.GetValue())
;		npc.SetValue(pCarryWeight,0)
;		Utility.WaitMenuMode(1.0)
;		float currentCarryWeight = npc.GetValue(pCarryWeight)
;		if (currentCarryWeight > 0)
;			npc.SetValue(pCarryWeight,(currentCarryWeight * -1))
;		endif
;	endif		
	
	if enforceCarryWeight > -1
		npc.ModValue(pCarryWeight, 0)			
		npc.SetValue(pCarryWeight, enforceCarryWeight)
		Utility.WaitMenuMode(0.1)
		float currentCarryWeight = npc.GetValue(pCarryWeight)
		if (currentCarryWeight != enforceCarryWeight)
			float diff = (enforceCarryWeight - currentCarryWeight)
			npc.ModValue(pCarryWeight, diff)			
		endif
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

		if assignedMaxHealth > 0
			EnforceMaxHealth()
		endif
		
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

Function EnforceMaxHealth()

	; NOTES: Most actor values are derived (volatile, always changing), so never rely on 
	; a snopshot. Always re-evaluate. 
	
	; What complicates things here is that most companions have a built in handicapp of -100
	; HP that is applied at all times. So if you say setvalue(health,300), and then do an 
	; immediate getvalue, you see 200. 
	
	Trace("EnforceMaxHealth()")
	if assignedMaxHealth < 1
		Trace("Bailing : assignedMaxHealth < 1")
		return
	endif
	
	Actor npc = self.GetActorRef()
	if npc.GetValue(pRadHealthMax) != assignedMaxHealth && !npc.IsBleedingOut()
	
		Trace("  assignedMaxHealth [" + assignedMaxHealth + "] != NPC.RADHEALTHMAX [" + npc.GetValue(pRadHealthMax) + "]")
		
		; Reset Script Value Modifications
		npc.ModValue(pHealth, 0)
		
		; Heal/Restore to full health if need be:
		if (npc.GetValue(pRadHealthMax) > 0)
			if npc.GetValue(pHealth) < npc.GetValue(pRadHealthMax)
				Trace("  Raising Current Health")
				float diff = npc.GetValue(pRadHealthMax) - npc.GetValue(pHealth)
				npc.RestoreValue(pHealth, diff)
			elseif npc.GetValue(pHealth) > npc.GetValue(pRadHealthMax)
				Trace("  Lowering Current Health")
				float diff = npc.GetValue(pHealth) - npc.GetValue(pRadHealthMax)
				npc.DamageValue(pHealth, diff)
			endif
		endif

		; Compute changes from effects like armor, perks or Actor Record Handycaps:
		float fxboost = npc.GetBaseValue(pHealth) - npc.GetValue(pHealth)
		Trace("  fxboost [" + fxboost + "]")
		
		npc.SetValue(pHealth, assignedMaxHealth + fxboost)
		Utility.WaitMenuMode(0.1)
		bool success = false
		
		if (npc.GetValue(pRadHealthMax) < assignedMaxHealth)
			; m150 < a325 
			Trace("  NPC.RADHEALTHMAX [" + npc.GetValue(pRadHealthMax) + "] <  assignedMaxHealth [" + assignedMaxHealth + "]")
			float diff = (assignedMaxHealth - npc.GetValue(pRadHealthMax))
			if (diff > 0)
				npc.ModValue(pHealth, diff)
			elseif (diff + npc.GetValue(pHealth)) > 0
				Trace("Unexpected negative adjustment")
				npc.ModValue(pHealth, diff)
			endif			
		elseif (npc.GetValue(pRadHealthMax) > assignedMaxHealth)
			; m700 < a400
			Trace("  NPC.RADHEALTHMAX [" + npc.GetValue(pRadHealthMax) + "] >  assignedMaxHealth [" + assignedMaxHealth + "]")
			float diff = (assignedMaxHealth - npc.GetValue(pRadHealthMax))
			; As we are conteplating loweing the health, we have to be sure the final value is still > 0.
			if (diff > 0)
				Trace("Unexpected positive adjustment")
				npc.ModValue(pHealth, diff)
			elseif (diff + npc.GetValue(pHealth)) > 0
				npc.ModValue(pHealth, diff)
			endif			
		else
			Trace("  SUCCESS: NPC.RADHEALTHMAX == assignedMaxHealth")
			success = true
		endif

		if !success
			if (npc.GetValue(pRadHealthMax) == assignedMaxHealth)
				Trace("  SUCCESS: NPC.RADHEALTHMAX == assignedMaxHealth (Fixed)")				
			endif
		endIf
				
	else
		Trace("  assignedMaxHealth [" + assignedMaxHealth + "] == NPC.RADHEALTHMAX")
	endif
	
EndFunction

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
	self.GetActorRef().WaitFor3DLoad()
	; Flood Protection
	StartTimer(2.5,ONLOAD_FLOOD_PROTECT)	
endEvent

bool Function IsCoreCompanion(Actor npc)
	ActorBase base  = npc.GetActorBase()	
	if (base == Game.GetForm(0x00079249) as ActorBase)     ; 1 ---=== Cait ===---
		return true
	endif
	if (base == Game.GetForm(0x000179FF) as ActorBase) ; 2 ---=== Codsworth ===---
		return true
	endif
	if (base == Game.GetForm(0x00027686) as ActorBase) ; 3 ---=== Curie ===---
		return true
	endif
	if (base == Game.GetForm(0x00027683) as ActorBase) ; 4 ---=== Danse ===---
		return true
	endif
	if (base == Game.GetForm(0x00045AC9) as ActorBase) ; 5 ---=== Deacon ===---
		return true
	endif
	if (base == Game.GetForm(0x0001D15C) as ActorBase) ; 6 ---=== Dogmeat ===---
		return true
	endif
	if (base == Game.GetForm(0x00022613) as ActorBase) ; 7 ---=== Hancock ===---	
		return true
	endif
	if (base == Game.GetForm(0x0002740E) as ActorBase) ; 8 ---=== MacCready ===---	
		return true
	endif
	if (base == Game.GetForm(0x00002F24) as ActorBase) ; 9 ---=== Nick Valentine ===---
		return true
	endif
	if (base == Game.GetForm(0x00002F1E) as ActorBase) ; 10 ---=== Piper ===---	
		return true
	endif
	if (base == Game.GetForm(0x00019FD9) as ActorBase) ; 11 ---=== Preston ===---
		return true
	endif
    if (base == Game.GetForm(0x00027682) as ActorBase) ; 12 ---=== Strong ===---
		return true
	endif
	if (base == Game.GetForm(0x000BBEE6) as ActorBase) ; 13 ---=== X6-88 ===---	
		return true
	endif
	if (base == pTweakCompanionNate)	
		return true
	endif
	if (base == pTweakCompanionNora)	
		return true
	endif
	int ActorBaseID = base.GetFormID()
	if (ActorBaseID < 0x01000000)
		return false
	endif
	int ActorBaseMask
	if ActorBaseID > 0x80000000			
		ActorBaseMask = (ActorBaseID - 0x80000000) % (0x01000000)
	else
		ActorBaseMask = ActorBaseID % (0x01000000)
	endif
			
	; Now compare the MASK
	if     0x0000FD5A == ActorBaseMask ; Ada
		return true
	endif
	if 0x00006E5B == ActorBaseMask ; Longfellow
		return true
	endif
	if 0x0000881D == ActorBaseMask ; Porter Gage
		return true
	endif
	return false
EndFunction

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

WorkshopScript Function FindNearbyWorkshop(ObjectReference origin)

	Keyword				WorkshopKeyword	=	Game.GetForm(0x00054BA7) as Keyword
	ObjectReference[]	candidates		=	origin.FindAllReferencesWithKeyword(WorkshopKeyword, 4000)
	
	int cilen = candidates.Length
	if (cilen > 0)
		bool keepgoing = true
		int ci = 0
		while (ci < cilen && keepgoing)
			WorkshopScript workshopRef = candidates[ci] as WorkshopScript
			if workshopRef
				return workshopRef
			endif
			ci += 1
		endwhile
	endif
	
EndFunction

Function AssignCleanHelper(Actor npc)

	npc.RemoveFromFaction(pTweakNoHomeFaction)
	npc.RemoveFromFaction(pTweakSkipGoHomeFaction)
	npc.RemoveFromFaction(pTweakCampHomeFaction)
	if (dynamicAssignment) ; Needs Cleanup...
		dynamicAssignment = false
		if assignedHomeRef
			Keyword	WorkshopKeyword	=	Game.GetForm(0x00054BA7) as Keyword
			npc.SetLinkedRef(None, pTweakLocHome)
			if !assignedHomeRef.HasKeyword(WorkshopKeyword)
				assignedHomeRef.SetPersistLoc(None)
				assignedHomeRef.Disable()
				assignedHomeRef.Delete()
			endif
		endif
	else
		trace("dynamicAssignment is false")
	endif
		
	assignedHomeRef = None
	((self as ReferenceAlias) as AFT:TweakInventoryControl).assignedHomeRef = None

endFunction

Function AssignHomeHelper(Actor npc, bool isSettlement=true)
	Trace("AssignHomeHelper")
	Location prevHome = None
	CompanionActorScript	CAS				=	npc as CompanionActorScript
	if (CAS)
		Trace("Updating CAS.HomeLocation [" + assignedHome + "]")
		prevHome = CAS.HomeLocation
		CAS.HomeLocation = assignedHome
	else
		DogmeatActorScript   DAS = npc as DogmeatActorScript		
		if (DAS)
			Trace("Updating DAS.HomeLocation [" + assignedHome + "]")
			prevHome = DAS.HomeLocation
			DAS.HomeLocation = assignedHome
		endif
	endif	
	
	; When this method is called, certain class instance variables are expeceted to be set:
	; assignHome <- Location to assign
	
	WorkshopNPCScript		WNS				=	npc as WorkshopNPCScript
	WorkshopParentScript	pWorkshopParent	=	(Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
	AFT:TweakSettlersScript	AFTSettlers		=	(pTweakSettlers as AFT:TweakSettlersScript)
	
	if AFTSettlers
			
		if !isSettlement
			Trace("isSettlement is False. Calling UnMakeSettler")
			AFTSettlers.UnMakeSettler(npc, true)
			return
		endif
		
			
		; May want to restrict AFT Settlers to humans and robots. (No cats, dogs, Behomeths, insects, etc...)
		; For now no restrictions
				
		; Keyword ActorTypeHuman               = Game.GetForm(0x0002CB72) as Keyword
		; Keyword ActorTypeGhoul               = Game.GetForm(0x000EAFB7) as Keyword
		; Keyword ActorTypeRobot               = Game.GetForm(0x0002CB73) as Keyword
				
		; if (npc.HasKeyword(ActorTypeHuman) || npc.HasKeyword(ActorTypeGhoul) || npc.HasKeyword(ActorTypeRobot))					
		
		; MakeSettler will return false if the assignedHome Location passed in is not associated with a Workshop		
		; It does NOT however look around for nearby workshops. 
		
		if AFTSettlers.MakeSettler(npc, assignedHome, false, prevHome)
			Trace("AFTSettlers.MakeSettler returned true (Need to add to TweakSkipGoHomeFaction")
			npc.AddToFaction(pTweakSkipGoHomeFaction)
		elseif assignedHome		
			Trace("AFTSettlers.MakeSettler returned false. AssignedHome [" +  assignedHome + "] is not a workshop.")
			; assignHome is not a workshop....
			if (npc.IsInFaction(pTweakSettlerFaction))
				Trace("Calling UnMakeSettler")			
				AFTSettlers.UnMakeSettler(npc)
			endif
			if (WNS && WNS.GetWorkshopID() != -1)
				pWorkshopParent.RemoveActorFromWorkshopPUBLIC(WNS)
			endif
		endif
				
		; elseif (WNS && WNS.GetWorkshopID() != -1)
		;	pWorkshopParent.RemoveActorFromWorkshopPUBLIC(WNS)
		; endif
								
	else
			
		; Hopefully this never runs, but it is backup code just in case.
		
		Trace("ERROR : AFTSettlers failed to caste!!!!!!!")
		if (WNS)
			if (WNS.GetWorkshopID() != -1)
				pWorkshopParent.RemoveActorFromWorkshopPUBLIC(WNS)
			endif
			WorkshopScript workshopRef = pWorkshopParent.GetWorkshopFromLocation(assignedHome)
			if workshopRef
				if !assignedHomeRef
					assignedHomeRef = workshopRef
				endif
					
				; This will succeed so long as the assignedHome is a workshop AND the npc
				; has WNS scripts attached.
						
				if npc.GetActorBase().IsUnique()
					pWorkshopParent.AddActorToWorkshopPUBLIC(WNS, workshopRef)
				else
					pWorkshopParent.AddActorToWorkshopPUBLIC(WNS, workshopRef)
				endIf
				npc.AddToFaction(pTweakSkipGoHomeFaction)
			endif
		endif
				
	endif
			

EndFunction


; Provides both a translation and confirmation if
; a location is a workshop location...
;ObjectReference Function LocationToWorkShopMarker(Location loc)
;	ObjectReference marker = None
;	
;	Keyword WorkshopLinkSandbox = Game.GetForm(0x0022B5A7) as Keyword
;	Keyword WorkshopLinkCenter  = Game.GetForm(0x00038C0B) as Keyword
;	
;	Location ws                          = None
;	WorkshopParentScript pWorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
;	RefCollectionAlias   wscollection     = pWorkshopParent.WorkshopsCollection
;	
;	int index = 0
;	int wslen = wscollection.GetCount()
;	while (index < wslen && loc != ws)
;		WorkshopScript workshopRef = wscollection.GetAt(index) as WorkshopScript
;		if workshopRef
;			ws = workshopRef.GetCurrentLocation()
;			if loc == ws
;				marker = workshopRef.GetLinkedRef(WorkshopLinkSandbox)			
;				if marker == NONE
;					marker = workshopRef.GetLinkedRef(WorkshopLinkCenter)
;				endif
;				if marker == NONE
;					marker = workshopRef as ObjectReference
;				endIf
;				return marker
;			endif
;		endif
;		index += 1
;	endwhile
;	return None
;EndFunction

;WorkshopScript Function LocationToWorkShop(Location loc)
;	ObjectReference marker = None
;	
;	Keyword WorkshopLinkSandbox = Game.GetForm(0x0022B5A7) as Keyword
;	Keyword WorkshopLinkCenter  = Game.GetForm(0x00038C0B) as Keyword
;	
;	Location ws                          = None
;	WorkshopParentScript pWorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
;	RefCollectionAlias   wscollection    = pWorkshopParent.WorkshopsCollection
;	
;	int index = 0
;	int wslen = wscollection.GetCount()
;	while (index < wslen && loc != ws)
;		WorkshopScript workshopRef = wscollection.GetAt(index) as WorkshopScript
;		if workshopRef
;			ws = workshopRef.GetCurrentLocation()
;			if loc == ws
;				return workshopRef
;			endif
;		endif
;		index += 1
;	endwhile
;	return None
;EndFunction

Event OnSit(ObjectReference akFurniture)
	Trace("OnSit [" + akFurniture + "]")
	if akFurniture.HasKeyword(pFurnitureTypePowerArmor)
		if (1.0 == TweakAllowAutonomousPickup.GetValue())
			ResetCarryWeight()
		endif
		enforceSettings()
	endif
EndEvent

Event OnGetUp(ObjectReference akFurniture)
	Trace("OnGetUp()")
	if (akFurniture.HasKeyword(pFurnitureTypePowerArmor))
		if (1.0 == TweakAllowAutonomousPickup.GetValue())
			ResetCarryWeight()
		endif
		enforceSettings()
	endif
EndEvent

Event OnItemEquipped(Form akBaseItem, ObjectReference akReference)
	Trace("OnItemEquipped()")
	Actor npc = self.GetActorRef()
	if (enforceCarryWeight != npc.GetValue(pCarryWeight))
		if (0.0 == TweakAllowAutonomousPickup.GetValue())
			if TradeMenuOpen
				ResetCarryWeight()
				enforceSettings()
			else
				; enforceCarryWeight = 0
				enforceSettings()
			endif
		endIf
	endif
EndEvent

Event OnItemUnEquipped(Form akBaseItem, ObjectReference akReference)
	Trace("OnItemUnEquipped()")
	Actor npc = self.GetActorRef()
	if (enforceCarryWeight != npc.GetValue(pCarryWeight))
		if (0.0 == TweakAllowAutonomousPickup.GetValue())
			if TradeMenuOpen
				ResetCarryWeight()
				enforceSettings()
			else
				; enforceCarryWeight = 0
				enforceSettings()
			endif
		endIf
	endif
EndEvent

Int Function GetPluginID(int formid)
	int fullid = formid
	if fullid > 0x80000000
		fullid -= 0x80000000
	endif
	int lastsix = fullid % 0x01000000
	return (((formid - lastsix)/0x01000000) as Int)
EndFunction 

Function EventTradeBegin()
	; Deprecated
EndFunction

Function EventTradeEnd()
	; Deprecated
EndFunction

