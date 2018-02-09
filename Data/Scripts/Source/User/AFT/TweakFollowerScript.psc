Scriptname AFT:TweakFollowerScript extends Quest conditional

; Dont use import. It only works when .pex files are local. Once you package them up into an 
; release/final archive, the scripts wont be found and everything will break...
; import AFT

; You can decrease MAX_MANAGED to quickly see what happens
; when aliases are exhausted. This is mostly variablized
; for testing. NOTE: You can't increase beyond 32 without 
; adding support aliases

int MAX_MANAGED	   = 32 const 

Group FollowerQuestAliasesRelayCombatEndEvent
ReferenceAlias  Property pCompanion1        Auto Const
ReferenceAlias  Property pCompanion2        Auto Const
ReferenceAlias  Property pCompanion3        Auto Const
ReferenceAlias  Property pCompanion4        Auto Const
ReferenceAlias  Property pCompanion5        Auto Const
ReferenceAlias  Property pDogmeatCompanion	Auto Const
EndGroup

Group GlobalVariables
GlobalVariable Property pTweakMutexCompanions	Auto Const
GlobalVariable Property pTweakFollowerLimit		Auto Const
GlobalVariable Property pTweakFollowerCount Auto Const
GlobalVariable Property pTimeScale          Auto Const
GlobalVariable Property pTweakFollowerCatchup Auto Const
; GlobalVariable Property pGameDaysPassed     Auto
GlobalVariable Property iFollower_Com_Wait  Auto Const
GlobalVariable Property iFollower_Stance_Aggressive Auto Const
GlobalVariable Property iFollower_Stance_Defensive  Auto Const
EndGroup

FormList Property pTweakHelloTopicCait       Auto Const
FormList Property pTweakHelloTopicCodsworth  Auto Const
FormList Property pTweakHelloTopicCurie      Auto Const
FormList Property pTweakHelloTopicDanse      Auto Const
FormList Property pTweakHelloTopicDeacon     Auto Const
FormList Property pTweakHelloTopicDogmeat    Auto Const
FormList Property pTweakHelloTopicHancock    Auto Const
FormList Property pTweakHelloTopicMacCready  Auto Const
FormList Property pTweakHelloTopicNick       Auto Const
FormList Property pTweakHelloTopicPiper      Auto Const
FormList Property pTweakHelloTopicPreston    Auto Const
FormList Property pTweakHelloTopicStrong     Auto Const
FormList Property pTweakHelloTopicX688       Auto Const
FormList Property pTweakHelloTopicAda        Auto Const
FormList Property pTweakHelloTopicLongfellow Auto Const
FormList Property pTweakHelloTopicPorterGage Auto Const
FormList Property pTweakHelloTopicSpouse	 Auto Const

Group Messages
Message Property pTweakTimescale			Auto Const
Message Property pTweakMaxReached			Auto Const
Message Property pTweakUpdateMsg			Auto Const
Message Property pTweakUpdateDoneMsg		Auto Const
Message Property pTweakInfoInspecting 		Auto Const
Message Property pTweakNoWorkshopParentMsg  Auto Const
Message Property pWorkshopUnownedMessage	Auto Const
Message Property pTweakInstituteSummon		Auto Const
Message Property pTweakProgress				Auto Const
Message Property pTweakUpgradeMsg			Auto Const
Message Property pTweakShowResourceID		Auto Const
EndGroup

Group Conditionals_for_external_terminals
Bool Property pFollowerNoMorals        auto conditional
Bool Property pFollowerCatchup         auto conditional
Bool Property pFollowerPackMule        auto conditional
Bool Property pFollowerSynergy         auto conditional 
EndGroup

Bool Property pInstalled auto

Group AFT_Activator_Talk_Support
ActorValue Property pTweakTopicHello			Auto Const ; pTweakHelloTopicList
ActorValue Property pTweakTopicHelloModID		Auto Const ; pTweakHelloTopicList
ActorValue Property pTweakTopicDismiss			Auto Const ; pTweakDismissTopicList
ActorValue Property pTweakTopicDismissModID		Auto Const ; pTweakDismissTopicList
ActorValue Property pTweakTopicTrade			Auto Const ; pTweakTradeTopicList
ActorValue Property pTweakTopicTradeModID		Auto Const ; pTweakTradeTopicList
ActorValue Property pTweakTopicAck				Auto Const ; pTweakAckTopicList
ActorValue Property pTweakTopicAckModID			Auto Const ; pTweakAckTopicList
ActorValue Property pTweakTopicCancel			Auto Const ; pTweakCancelTopicList
ActorValue Property pTweakTopicCancelModID		Auto Const ; pTweakCancelTopicList
ActorValue Property pTweakTopicDistFar			Auto Const ; pTweakDistFarTopicList
ActorValue Property pTweakTopicDistFarModID		Auto Const ; pTweakDistFarTopicList
ActorValue Property pTweakTopicDistMed			Auto Const ; pTweakDistMedTopicList
ActorValue Property pTweakTopicDistMedModID		Auto Const ; pTweakDistMedTopicList
ActorValue Property pTweakTopicDistNear			Auto Const ; pTweakDistNearTopicList
ActorValue Property pTweakTopicDistNearModID	Auto Const ; pTweakDistNearTopicList
ActorValue Property pTweakTopicStyleAgg			Auto Const ; pTweakStyleAggTopicList
ActorValue Property pTweakTopicStyleAggModID	Auto Const ; pTweakStyleAggTopicList
ActorValue Property pTweakTopicStyleDef			Auto Const ; pTweakStyleDefTopicList
ActorValue Property pTweakTopicStyleDefModID	Auto Const ; pTweakStyleDefTopicList
EndGroup

; Used to detect Wait State...
ActorValue     Property pFollowerState      Auto Const
Package        Property pCommandMode_Travel Auto Const
; GlobalVariable Property iFollower_Com_Wait  Auto Const ; Above in Globals

; Scale (For AftReset/Unmanage)
ActorValue Property pTweakScale					Auto Const

; Other Quest Scripts : Note Script types are not recognized until they 
;                       have successfully compiled...
; AFT:TweakMonitorPlayerScript Property pTweakMonitorPlayerScript Auto
; Quest                    Property pTweakMonitorPlayer Auto
Quest      Property pFollowers            Auto Const
Quest      Property pTweakPipBoy          Auto Const
Quest      Property pTweakNames           Auto Const
Quest      Property pTweakScrapScanMaster Auto Const
Quest	   Property pTweakCOMSpouse		  Auto Const ;ResetAffinityScene
Quest	   Property BoS302				  Auto Const


Keyword    Property pTeammateReadyWeapon_DO Auto Const
Keyword    Property p_AttachPassenger       Auto Const
Keyword    Property p_AttachSlot2           Auto Const
Keyword    Property pPlayerCanStimpak       Auto Const
FormList   Property pTweakHumanoidKeywords  Auto Const

ReferenceAlias	Property pLostNPC			Auto Const
Quest			Property pTweakLocator		Auto Const
ReferenceAlias	Property pInfoNPC			Auto Const
Quest			Property pTweakInfo			Auto Const
Quest 			Property pTweakDedupeMaster Auto Const
Quest			Property pDN136_Attack		Auto Const

Quest			Property BoSKickOut			Auto Const
Quest			Property BoSKickOutSoft 	Auto Const
Quest			Property InstKickOut		Auto Const
Quest			Property RRKickOut 			Auto Const


ReferenceAlias[] Property pFollowerMap Auto
ReferenceAlias[] Property pManagedMap  Auto

Faction property pTweakFollowerFaction       Auto Const
Faction property pTweakNamesFaction          Auto Const
Faction property pDisallowedCompanionFaction Auto Const
Faction property pDanversFaction             Auto Const

; Items to Add to Inventory (Dont due it to fast or it breaks New Game...)
Potion   Property pTweakActivateAFT        Auto Const
Holotape Property pTweakHoloTape           Auto Const


Float Property version Auto
Int   Property pfCount Auto
Bool  Property pCharGenCacheEnabled Auto hidden
Bool  Property combatRunningFlag Auto hidden
Bool  Property instituteSummonMsgOnce Auto hidden


int CONFIRM_VERSION        = 3 const
int UPDATE_VERSION         = 4 const
int COMBAT_MONITOR         = 5 const

int EXIT_PA_BASE           = 30 const
int EXIT_PA_COMPANION1	   = 30 const
int EXIT_PA_COMPANION2	   = 31 const
int EXIT_PA_COMPANION3	   = 32 const
int EXIT_PA_COMPANION4	   = 33 const
int EXIT_PA_COMPANION5	   = 34 const

; INFO:
ActorValue Property pStrength				Auto	Const
ActorValue Property pPerception				Auto	Const
ActorValue Property pEndurance				Auto	Const
ActorValue Property pCharisma				Auto	Const
ActorValue Property pIntelligence			Auto	Const
ActorValue Property pAgility				Auto	Const
ActorValue Property pLuck					Auto	Const
ActorValue Property pHealth					Auto	Const
ActorValue Property pCarryWeight			Auto	Const

ActorValue Property pEnergyResist			Auto	Const
ActorValue Property pFireResist				Auto	Const
ActorValue Property pFrostResist			Auto	Const
ActorValue Property pPoisonResist			Auto	Const
ActorValue Property pRadResistExposure		Auto	Const
ActorValue Property pDamageResist			Auto	Const

ActorValue Property pCA_HighestReached		Auto	Const
ActorValue Property pCA_HighestThreshold	Auto	Const
ActorValue Property pCA_CurrentThreshold	Auto	Const
ActorValue Property pCA_Affinity			Auto	Const
ActorValue Property pCA_LowestThreshold		Auto	Const
ActorValue Property pCA_LowestReached		Auto	Const

GlobalVariable Property pTweakInfoVar1  Auto Const
GlobalVariable Property pTweakInfoVar2  Auto Const
GlobalVariable Property pTweakInfoVar3  Auto Const
GlobalVariable Property pTweakInfoVar4  Auto Const
GlobalVariable Property pTweakInfoVar5  Auto Const
GlobalVariable Property pTweakInfoVar6  Auto Const
GlobalVariable Property pTweakInfoVar7  Auto Const
GlobalVariable Property pTweakInfoVar8  Auto Const
GlobalVariable Property pTweakInfoVar9  Auto Const
GlobalVariable Property pTweakInfoVar10  Auto Const
GlobalVariable Property pTweakInfoVar11  Auto Const
GlobalVariable Property pTweakInfoVar12  Auto Const
GlobalVariable Property pTweakInfoVar13  Auto Const
GlobalVariable Property pTweakInfoVar14  Auto Const
GlobalVariable Property pTweakInfoVar15  Auto Const
GlobalVariable Property pTweakInfoVar16  Auto Const
GlobalVariable Property pTweakInfoVar17  Auto Const
GlobalVariable Property pTweakInfoVar18  Auto Const
GlobalVariable Property pTweakInfoVar19  Auto Const
GlobalVariable Property pTweakInfoVar20  Auto Const
GlobalVariable Property pTweakInfoVar21  Auto Const
GlobalVariable Property pTweakInfoVar22  Auto Const
GlobalVariable Property pTweakInfoVar23  Auto Const
GlobalVariable Property pTweakInfoVar24  Auto Const
GlobalVariable Property MQWonInst		 Auto Const

GlobalVariable Property pTweakIdleCooldownActiveMin		Auto Const
GlobalVariable Property pTweakIdleCooldownActiveMax		Auto Const
GlobalVariable Property pTweakIdleCooldownDismissedMin	Auto Const
GlobalVariable Property pTweakIdleCooldownDismissedMax	Auto Const

GlobalVariable Property pTweakSynergyChrBoost	Auto Const
GlobalVariable Property pTweakSynergyLckBoost	Auto Const

; Use by TweakMakeFollowerSpell to identify name of NPC.
Location Property PlayerHome Auto Conditional

Spell	Property pTweakFollowerStealth Auto Const
Spell	Property TeleportInSpell	   Auto Const

ReferenceAlias  Property pShelterMapMarker     Auto Const
Faction			Property pTweakCampHomeFaction	Auto Const
Faction			Property pTweakPosedFaction	Auto Const
Faction			Property pCurrentCompanionFaction Auto Const


; Used to confirm compatibility with some functions
Race	Property pHumanRace							Auto Const
Race	Property pGhoulRace							Auto Const
Race	Property pPowerArmorRace					Auto Const
Race	Property pSynthGen2RaceValentine			Auto Const
Race	Property pSynthGen2Race                     Auto Const
Faction Property pTweakSyncPAFaction				Auto Const

Location Property InstituteLocation					Auto Const

TweakDLC01Script Property pTweakDLC01Script			Auto Const
TweakDLC03Script Property pTweakDLC03Script			Auto Const
TweakDLC04Script Property pTweakDLC04Script			Auto Const

; Vanilla Companions
ActorBase Property CompanionCait			Auto Const
ActorBase Property Codsworth				Auto Const
ActorBase Property CompanionCurie			Auto Const
ActorBase Property BoSPaladinDanse			Auto Const
ActorBase Property CompanionDeacon			Auto Const
ActorBase Property Hancock					Auto Const
ActorBase Property CompanionMacCready		Auto Const
ActorBase Property CompanionNickValentine	Auto Const
ActorBase Property CompanionPiper			Auto Const
ActorBase Property PrestonGarvey			Auto Const
ActorBase Property CompanionStrong			Auto Const
ActorBase Property CompanionX688			Auto Const
ActorBase Property TweakCompanionNate		Auto Const
ActorBase Property TweakCompanionNora		Auto Const

Perk	  Property pTweakCarryBoost				Auto Const ; Perk increases carryweight with strength
Perk	  Property pTweakHealthBoost			Auto Const ; Perk increases health with endurance
Perk	  Property pTweakDmgResistBoost			Auto Const ; Perk increases Damage Resistance with agility
Perk	  Property pTweakRangedDmgBoost			Auto Const ; Perk increases Ranged Damage with perception
Perk	  Property pTweakPlayerSynergyChrPerk	Auto Const ; Perk increases Ranged Damage with perception
Perk	  Property pTweakPlayerSynergyLckPerk	Auto Const ; Perk increases Ranged Damage with perception
Perk	  Property pTweakZeroCarryInCombat		Auto Const ; Perk prevent weapon pickup during combat
Perk	  Property pTweakPlayerSwimMonitorPerk	Auto Const ; Sends OnEnterWater/OnExitWater to TweakMonitorPlayer
; 194 ....
GlobalVariable[] Property pToggles Auto Const

; GlobalVariable Property pTweakToggle0 Auto Const
; GlobalVariable Property pTweakToggle1 Auto Const
; GlobalVariable Property pTweakToggle2 Auto Const
; GlobalVariable Property pTweakToggle3 Auto Const
; GlobalVariable Property pTweakToggle4 Auto Const
; GlobalVariable Property pTweakToggle5 Auto Const
; GlobalVariable Property pTweakToggle6 Auto Const
; GlobalVariable Property pTweakToggle7 Auto Const
; GlobalVariable Property pTweakToggle8 Auto Const
; GlobalVariable Property pTweakToggle9 Auto Const

; GlobalVariable Property pTweakToggle10 Auto Const
; GlobalVariable Property pTweakToggle11 Auto Const
; GlobalVariable Property pTweakToggle12 Auto Const
; GlobalVariable Property pTweakToggle13 Auto Const
; GlobalVariable Property pTweakToggle14 Auto Const
; GlobalVariable Property pTweakToggle15 Auto Const
; GlobalVariable Property pTweakToggle16 Auto Const
; GlobalVariable Property pTweakToggle17 Auto Const
; GlobalVariable Property pTweakToggle18 Auto Const
; GlobalVariable Property pTweakToggle19 Auto Const

; GlobalVariable Property pTweakToggle20 Auto Const
; GlobalVariable Property pTweakToggle21 Auto Const
; GlobalVariable Property pTweakToggle22 Auto Const
; GlobalVariable Property pTweakToggle23 Auto Const
; GlobalVariable Property pTweakToggle24 Auto Const
; GlobalVariable Property pTweakToggle25 Auto Const
; GlobalVariable Property pTweakToggle26 Auto Const
; GlobalVariable Property pTweakToggle27 Auto Const
; GlobalVariable Property pTweakToggle28 Auto Const
; GlobalVariable Property pTweakToggle29 Auto Const

; GlobalVariable Property pTweakToggle30 Auto Const
; GlobalVariable Property pTweakToggle31 Auto Const
; GlobalVariable Property pTweakToggle32 Auto Const
; GlobalVariable Property pTweakToggle33 Auto Const
; GlobalVariable Property pTweakToggle34 Auto Const
; GlobalVariable Property pTweakToggle35 Auto Const
; GlobalVariable Property pTweakToggle36 Auto Const
; GlobalVariable Property pTweakToggle37 Auto Const
; GlobalVariable Property pTweakToggle38 Auto Const
; GlobalVariable Property pTweakToggle39 Auto Const

; GlobalVariable Property pTweakToggle40 Auto Const
; GlobalVariable Property pTweakToggle41 Auto Const
; GlobalVariable Property pTweakToggle42 Auto Const
; GlobalVariable Property pTweakToggle43 Auto Const
; GlobalVariable Property pTweakToggle44 Auto Const
; GlobalVariable Property pTweakToggle45 Auto Const
; GlobalVariable Property pTweakToggle46 Auto Const
; GlobalVariable Property pTweakToggle47 Auto Const
; GlobalVariable Property pTweakToggle48 Auto Const
; GlobalVariable Property pTweakToggle49 Auto Const

; GlobalVariable Property pTweakToggle50 Auto Const
; GlobalVariable Property pTweakToggle51 Auto Const
; GlobalVariable Property pTweakToggle52 Auto Const
; GlobalVariable Property pTweakToggle53 Auto Const
; GlobalVariable Property pTweakToggle54 Auto Const
; GlobalVariable Property pTweakToggle55 Auto Const
; GlobalVariable Property pTweakToggle56 Auto Const
; GlobalVariable Property pTweakToggle57 Auto Const
; GlobalVariable Property pTweakToggle58 Auto Const
; GlobalVariable Property pTweakToggle59 Auto Const

; GlobalVariable Property pTweakToggle60 Auto Const
; GlobalVariable Property pTweakToggle61 Auto Const
; GlobalVariable Property pTweakToggle62 Auto Const
; GlobalVariable Property pTweakToggle63 Auto Const
; GlobalVariable Property pTweakToggle64 Auto Const
; GlobalVariable Property pTweakToggle65 Auto Const
; GlobalVariable Property pTweakToggle66 Auto Const
; GlobalVariable Property pTweakToggle67 Auto Const
; GlobalVariable Property pTweakToggle68 Auto Const
; GlobalVariable Property pTweakToggle69 Auto Const

; GlobalVariable Property pTweakToggle70 Auto Const
; GlobalVariable Property pTweakToggle71 Auto Const
; GlobalVariable Property pTweakToggle72 Auto Const
; GlobalVariable Property pTweakToggle73 Auto Const
; GlobalVariable Property pTweakToggle74 Auto Const
; GlobalVariable Property pTweakToggle75 Auto Const
; GlobalVariable Property pTweakToggle76 Auto Const
; GlobalVariable Property pTweakToggle77 Auto Const
; GlobalVariable Property pTweakToggle78 Auto Const
; GlobalVariable Property pTweakToggle79 Auto Const

; GlobalVariable Property pTweakToggle80 Auto Const
; GlobalVariable Property pTweakToggle81 Auto Const
; GlobalVariable Property pTweakToggle82 Auto Const
; GlobalVariable Property pTweakToggle83 Auto Const
; GlobalVariable Property pTweakToggle84 Auto Const
; GlobalVariable Property pTweakToggle85 Auto Const
; GlobalVariable Property pTweakToggle86 Auto Const
; GlobalVariable Property pTweakToggle87 Auto Const
; GlobalVariable Property pTweakToggle88 Auto Const
; GlobalVariable Property pTweakToggle89 Auto Const




bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakFollowerScript"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

; See AFT:TweakDFScript for docs...
;bool Function GetSpinLock(GlobalVariable mutex, int attempts = 0, string sourcehint = "")
;	if (1.0 == mutex.mod(1))
;		trace("Giving SpinLock to [" + sourcehint + "]")
;		return true
;	endif
;	while (attempts != 0)
;		Utility.wait(0.1)
;		if (0.0 == mutex.GetValue() && 1.0 == mutex.mod(1))
;			trace("Giving SpinLock to [" + sourcehint + "] (" + attempts + " attempts left)")
;			return true
;		endif
;		attempts -= 1
;	endwhile
;	trace("[" + sourcehint + "] Failed to get SpinLock")
;	return false
;endFunction

;Function ReleaseSpinLock(GlobalVariable mutex, bool gotLock = true, string sourcehint = "")
;	if gotLock
;		trace("[" + sourcehint + "] Releasing SpinLock")
;		mutex.SetValue(0.0)
;	else
;		trace("Ignoring Spinlock Release Request from [" + sourcehint + "]")		
;	endif
;endFunction

Event OnInit()
	Trace("OnInit()")

	version           = 0.0
	pfCount           = 0
	pFollowerNoMorals = true
	pFollowerCatchup  = true
	pFollowerPackMule = true
	pFollowerSynergy  = true
	; pFollowerRegen  = true
	; pFollowerNoTrap = true
	pCharGenCacheEnabled = false
	instituteSummonMsgOnce = false
	PlayerHome=None
	
	if (!pInstalled)
		initializeManagedMap()
		initializeFollowerMap()
		pInstalled = True
	endif
	
	Trace("OnInit Finished()")
endEvent

Event OnQuestInit()
	Actor player = Game.GetPlayer()
	Trace("Registering for DistanceLessThat 1000 from Camp")
	RegisterForDistanceLessThanEvent(player, pShelterMapMarker.GetReference(), 1000)			
EndEvent

; ==============================================
; EVENT HANDLERS
; ==============================================

Function OnGameLoaded(bool firstTime=false)
	Trace("OnGameLoaded() Called")
	if pCharGenCacheEnabled
		Game.PrecacheCharGen()
	endif
	
	RegisterForKickOut()
	
	if (1.16 != version)
		; In case this is new game, wait for pInstalled to be true....
		StartTimer(0, CONFIRM_VERSION)
	else
		Trace("No Update Required")
		CheckForErrors()  ; Because... you know... Fallout 4
		GiveAFTToPlayer() ; Just in case....
		SendOnGameLoadToAliasScripts()
	endif	
	
	Trace("OnGameLoaded() Finished")
EndFunction

Event OnTimer(int aiTimerID)

	if (COMBAT_MONITOR == aiTimerID)
		if Game.GetPlayer().IsInCombat()
			StartTimer(16,COMBAT_MONITOR)
		else
			RelayCombatEndEvent()
		endif
		return
	endif

	if (CONFIRM_VERSION == aiTimerID)
		; Since this is fed by Player OnGameLoad event, this can actually fire BEFORE OnInit.
		; That is why we check Installed. It is set to True by OnInit. Dont do anything if
		; if it appears we beat the script initializer...

		if (pInstalled)
			if (version  < 1.16)
				StartTimer(0,UPDATE_VERSION)
			else
				CheckForErrors()
				GiveAFTToPlayer()
				SendOnGameLoadToAliasScripts()
			endif
			; Fall Through
		else
			Trace("Waiting for TweakFollowerScript to Initialize")
			StartTimer(5,CONFIRM_VERSION) ; Call self again in 5
		endif
		return
	endif

	if (aiTimerID >= EXIT_PA_COMPANION1 && aiTimerID <= EXIT_PA_COMPANION5)
		FollowerExitPA(aiTimerID - EXIT_PA_BASE)
		return
	endif
	
	if (UPDATE_VERSION == aiTimerID)
		Trace("Update Version Event()")
		Trace("version is [" + version + "]")

		; Show Stoppers always go first....
		AFT:TweakDFScript pDFScript = (pFollowers as AFT:TweakDFScript)
		if (!pDFScript)
			Trace("Unable to import followers. Cast to AFT:TweakDFScript failed")
			return
		endif

		Actor player	= Game.GetPlayer()
		float ov        = version
		float ov_102fix = version
		version  = 1.16

		if ov < 1.15 ; 1.16 : Added Swim Outfit 
			if ov < 1.13 ; 1.13 : Added Home Outfit and Outfit Management Reset
				if ov < 1.12 ; 1.11 : Health/Endurance boosts. 1.12 : Fixed Ghosting artifacts 
					if ov < 1.09 ; Added DLC support in 1.09. 
						if ov < 1.04 ; Affinity Fixes + No Fall Damage
							if (ov < 1.03) ; Fix 1.02 non-init and Settlement assignement compatibiliy		
							
								if (ov == 1.02)
									; Potential Bug in 1.02 upgrade process.
									if (0 == pManagedMap.Length)
										ov_102fix = 0.0
									endif
								endif
									
								if (ov_102fix < 1.0)	; First time init		
					
					
									if (20 < pTimeScale.GetValue())
										Trace("Timescale is too high. Alerting user")
										pTweakTimescale.Show()
									endif
									
									; " [ Initializing AFT :          : ]"
									pTweakUpdateMsg.Show()
												
									pFollowerNoMorals        = true
									pFollowerCatchup         = true
									pFollowerPackMule        = true
									pFollowerSynergy         = true
									PlayerHome               = None

									if (0 == pManagedMap.Length)
										initializeManagedMap()
										initializeFollowerMap()
									endif
									
									int import_count = pDFScript.v10Update()

									; bool gotlock = GetSpinLock(pTweakMutexCompanions,1, "OnTimer (UpdateVersion)") ; low priority since it is read-only	
									int numFollowers = GetAllTweakFollowers().length
									pTweakFollowerCount.SetValueInt(numFollowers)
									; ReleaseSpinLock(pTweakMutexCompanions, gotlock, "OnTimer (UpdateVersion)")

									; As AFT lets you import NPCs, protect a few important ones with
									; pDisallowedCompanionFaction
									
									Actor Kellog = (Game.GetForm(0x0009BC6C) as ActorBase).GetUniqueActor()
									Actor Amari  = (Game.GetForm(0x0009A680) as ActorBase).GetUniqueActor()
									Actor Father = (Game.GetForm(0x0002A19A) as ActorBase).GetUniqueActor()
									Actor Virgil = (Game.GetForm(0x0006B503) as ActorBase).GetUniqueActor()
									Actor Maxon  = (Game.GetForm(0x000642B8) as ActorBase).GetUniqueActor()
									Actor Des    = (Game.GetForm(0x00045AD1) as ActorBase).GetUniqueActor()
									Actor MS16SonyaBot = (Game.GetForm(0x000C895F) as ActorBase).GetUniqueActor()
									
									if Kellog
										Kellog.AddToFaction(pDisallowedCompanionFaction)
									endif
									if Amari
										Amari.AddToFaction(pDisallowedCompanionFaction)
									endIf
									if Father
										Father.AddToFaction(pDisallowedCompanionFaction)
									endIf
									if Virgil
										Virgil.AddToFaction(pDisallowedCompanionFaction)
									endIf
									if Maxon
										Maxon.AddToFaction(pDisallowedCompanionFaction)
									endif
									if Des
										Des.AddToFaction(pDisallowedCompanionFaction)
									endif
									if MS16SonyaBot
										MS16SonyaBot.AddToFaction(pDisallowedCompanionFaction)
									endif
									
									; "Thanks for installing AFT v%.2f by Dheuster<BR>See Aft Readme in your inventory for usage"
									; Old - Aft Version %.2f update complete. [%.0f] Followers Imported.  See Aft Readme in 
									; inventory for usage.									
									pTweakUpdateDoneMsg.Show(version)
									
									GiveAFTToPlayer()
									
									player.AddPerk(pTweakPlayerSynergyChrPerk)
									player.AddPerk(pTweakPlayerSynergyLckPerk)
									player.AddPerk(pTweakPlayerSwimMonitorPerk)
									EvaluateSynergy()
									
									Trace("[" + import_count + "] followers imported")
								endif ; ov < 1.0
														
							endif ; ov < 1.03
							
							if (ov != 0.0)
							
								AFT:TweakCOMSpouseScript TweakCOMSpouseScript =  pTweakCOMSpouse as AFT:TweakCOMSpouseScript
								if TweakCOMSpouseScript
									TweakCOMSpouseScript.ResetAffinityScene()
								endif
								
							endif
							
						endif ; ov < 1.04
						
						if (ov != 0.0)
							((self as Quest) as TweakShelterScript).v109Upgrade()
							
							; DLC01 Support
							if pTweakDLC01Script.Installed
								if pTweakDLC01Script.Ada && pTweakDLC01Script.Ada.IsInFaction(pTweakFollowerFaction)
									ImportTopicsForCompanion(pTweakDLC01Script.Ada)
								endif
							endif

							; DLC03 Support
							if pTweakDLC03Script.Installed
								if pTweakDLC03Script.OldLongfellow && pTweakDLC03Script.OldLongfellow.IsInFaction(pTweakFollowerFaction)
									ImportTopicsForCompanion(pTweakDLC03Script.OldLongfellow)
								endif
							endif

							; DLC04 Support
							if pTweakDLC04Script.Installed
								if pTweakDLC04Script.PorterGage && pTweakDLC04Script.PorterGage.IsInFaction(pTweakFollowerFaction)
									ImportTopicsForCompanion(pTweakDLC04Script.PorterGage)
								endif
							endif
							
							; Reset IdleCooldowns to defaults (since 1.09 disables controls)
							pTweakIdleCooldownActiveMin.SetValue(240)
							pTweakIdleCooldownActiveMax.SetValue(300)
							pTweakIdleCooldownDismissedMin.SetValue(240)
							pTweakIdleCooldownDismissedMax.SetValue(480)
						endif
						
					endif ; ov < 1.09

					if (ov != 0.0)
						((self as Quest) as TweakShelterScript).v112Upgrade()
					endif
					
				endif ; ov < 1.12
				
				; 1.13						
				if (ov != 0.0)
					int pmlength = pManagedMap.Length
					int pm = 1
					while (pm < pmlength)
						ReferenceAlias pmfix = pManagedMap[pm]
						if pmfix && pmfix.GetActorReference()
							(pmfix as TweakInventoryControl).v13upGrade()
						endif
						pm += 1
					endwhile
				endif
				
			endif

			; 1.16						
			if (ov != 0.0)
				int pmlength = pManagedMap.Length
				int pm = 1
				while (pm < pmlength)
					ReferenceAlias pmfix = pManagedMap[pm]
					if pmfix && pmfix.GetActorReference()
						(pmfix as TweakInventoryControl).v16upGrade()
					endif
					pm += 1
				endwhile
			endif
			
		endif
			
		if (ov != 0.0)
					
			Faction PlayerFaction = Game.GetForm(0x0001C21C) as Faction
			Faction pTweakManagedOutfit = Game.GetFormFromFile(0x0101F312,"AmazingFollowerTweaks.esp") as Faction
			Perk crNoFallDamage = Game.GetForm(0x0002A6FC) as Perk
			int plength = pManagedMap.Length
			int p = 1
			while (p < plength)
				ReferenceAlias rfix = pManagedMap[p]
				if rfix
					Actor afix = rfix.GetActorReference()
					if afix
						; 1.03
						if !afix.IsInFaction(PlayerFaction)
							afix.AddToFaction(PlayerFaction)
						endif
						; 1.04
						if !afix.HasPerk(crNoFallDamage)
							afix.AddPerk(crNoFallDamage)
						endif
						; 1.11
						if !afix.HasPerk(pTweakCarryBoost)
							afix.AddPerk(pTweakCarryBoost)
						endif
						if !afix.HasPerk(pTweakHealthBoost)
							afix.AddPerk(pTweakHealthBoost)
						endif
						; 1.14
						if !afix.HasPerk(pTweakDmgResistBoost)
							afix.AddPerk(pTweakDmgResistBoost)
						endif
						if !afix.HasPerk(pTweakRangedDmgBoost)
							afix.AddPerk(pTweakRangedDmgBoost)
						endif
						; 1.15
						if !afix.HasPerk(pTweakZeroCarryInCombat)
							afix.AddPerk(pTweakZeroCarryInCombat)
						endif
					endif
				endif
				p += 1
			endwhile
			
			; 1.14
			if !player.HasPerk(pTweakPlayerSynergyChrPerk)
				player.AddPerk(pTweakPlayerSynergyChrPerk)
			endif
			if !player.HasPerk(pTweakPlayerSynergyLckPerk)
				player.AddPerk(pTweakPlayerSynergyLckPerk)
			endif
			
			; 1.16
			if !player.HasPerk(pTweakPlayerSwimMonitorPerk)
				player.AddPerk(pTweakPlayerSwimMonitorPerk)
			endif			
			pTweakUpgradeMsg.Show(ov, version)
			
		endif
		
		CheckForErrors()
			
	endif
	
EndEvent

Function CheckForErrors()
	Trace("Check for Errors")
	int plength = pManagedMap.Length
	int p = 1
	while (p < plength)
		ReferenceAlias r = pManagedMap[p]
		if r
			Actor a = r.GetActorReference()
			if a
				if a.IsGhost() && a.IsInFaction(pCurrentCompanionFaction)
					Trace("Active Follower found that is marked as Ghost. Updating")
					a.SetGhost(false)
				endif
			endIf
		endIf
		p += 1
	endwhile
EndFunction

Function AftReset()
	Trace("============= AftReset() ================")		

	CancelTimer(CONFIRM_VERSION)
	CancelTimer(UPDATE_VERSION)
	CancelTimer(COMBAT_MONITOR)

	Actor player = Game.GetPlayer()
	
	if pTweakLocator.IsRunning()
		pTweakLocator.Stop()
		UnRegisterForRemoteEvent(pTweakLocator,"OnStageSet")
	endif
	
	if pTweakInfo.IsRunning()
		pTweakInfo.Stop()
	endif
	if pTweakScrapScanMaster.IsRunning()
		pTweakScrapScanMaster.Stop()
	endif

	ActorBase TweakCompanionNateBase = Game.GetFormFromFile(0x01048098, "AmazingFollowerTweaks.esp") as ActorBase
	if TweakCompanionNateBase
		Actor Nate = TweakCompanionNateBase.GetUniqueActor()
		if Nate && Nate.IsEnabled()
			Nate.RemoveAllItems(player,true)
			Nate.Disable()
			; Long shot, but give it a try....
			AFT:TweakCOMSpouseScript TweakCOMSpouseScript =  pTweakCOMSpouse as AFT:TweakCOMSpouseScript
			if TweakCOMSpouseScript
				TweakCOMSpouseScript.MQ102SpouseCorpseMaleREF.Enable()
			endif
		endif
	endif
	
	ActorBase TweakCompanionNoraBase = Game.GetFormFromFile(0x01043410, "AmazingFollowerTweaks.esp") as ActorBase
	if TweakCompanionNoraBase
		Actor Nora = TweakCompanionNoraBase.GetUniqueActor()
		if Nora && Nora.IsEnabled()
			Nora.RemoveAllItems(player,true)
			Nora.Disable()
			; Long shot, but give it a try....
			AFT:TweakCOMSpouseScript TweakCOMSpouseScript =  pTweakCOMSpouse as AFT:TweakCOMSpouseScript
			if TweakCOMSpouseScript
				TweakCOMSpouseScript.MQ102SpouseCorpseFemaleREF.Enable()
			endif
		endif
	endif
	
	if pTweakCOMSpouse && pTweakCOMSpouse.IsRunning()
		pTweakCOMSpouse.Stop()
	endif
	
	Actor Kellog = (Game.GetForm(0x0009BC6C) as ActorBase).GetUniqueActor()
	Actor Amari  = (Game.GetForm(0x0009A680) as ActorBase).GetUniqueActor()
	Actor Father = (Game.GetForm(0x0002A19A) as ActorBase).GetUniqueActor()
	Actor Virgil = (Game.GetForm(0x0006B503) as ActorBase).GetUniqueActor()
	Actor Maxon  = (Game.GetForm(0x000642B8) as ActorBase).GetUniqueActor()
	Actor Des    = (Game.GetForm(0x00045AD1) as ActorBase).GetUniqueActor()
	Actor MS16SonyaBot = (Game.GetForm(0x000C895F) as ActorBase).GetUniqueActor()
			
	if Kellog
		Kellog.RemoveFromFaction(pDisallowedCompanionFaction)
	endif
	if Amari
		Amari.RemoveFromFaction(pDisallowedCompanionFaction)
	endIf
	if Father
		Father.RemoveFromFaction(pDisallowedCompanionFaction)
	endIf
	if Virgil
		Virgil.RemoveFromFaction(pDisallowedCompanionFaction)
	endIf
	if Maxon
		Maxon.RemoveFromFaction(pDisallowedCompanionFaction)
	endif
	if Des
		Des.RemoveFromFaction(pDisallowedCompanionFaction)
	endif
	if MS16SonyaBot
		MS16SonyaBot.RemoveFromFaction(pDisallowedCompanionFaction)
	endif
	
	Actor npc = None
	int i = 1
	int nextstatus = 1
	int pMapLength = pManagedMap.length
	
	while (i < pMapLength)
		npc = pManagedMap[i].GetActorRef()
		if (npc)
			nextstatus -= 1
			if 0 == nextstatus
				nextstatus = 3
				pTweakProgress.Show(i, pMapLength)
			endif
			UnManageFollower(npc)			
		endif
		i += 1
	endWhile
	
	pManagedMap.Clear()
	pFollowerMap.Clear()
	
	CancelTimer(EXIT_PA_BASE)
	CancelTimer(EXIT_PA_COMPANION1)
	CancelTimer(EXIT_PA_COMPANION2)
	CancelTimer(EXIT_PA_COMPANION3)
	CancelTimer(EXIT_PA_COMPANION4)
	CancelTimer(EXIT_PA_COMPANION5)
	
	version           = 0.0
	pfCount           = 0
	pFollowerNoMorals = true
	pFollowerCatchup  = true
	pFollowerPackMule = true
	pFollowerSynergy  = true
	pCharGenCacheEnabled = false
	instituteSummonMsgOnce = false
	PlayerHome=None
	
	pTweakFollowerCount.SetValue(0.0)	
	pTweakFollowerCatchup.SetValue(1.0)
	
	if player.HasPerk(pTweakPlayerSynergyChrPerk)
		player.RemovePerk(pTweakPlayerSynergyChrPerk)
	endif
	if player.HasPerk(pTweakPlayerSynergyLckPerk)
		player.RemovePerk(pTweakPlayerSynergyLckPerk)
	endif
	if player.HasPerk(pTweakPlayerSwimMonitorPerk)
		player.RemovePerk(pTweakPlayerSwimMonitorPerk)
	endif

EndFunction

Function LockRotationByNameID(int id)
	Trace("LockRotationByNameID on id [" + id + "] called")

	AFT:TweakDFScript pDFScript = (pFollowers as AFT:TweakDFScript)
	if !pDFScript
		Trace("LockRotationByNameID : Cast to AFT:TweakDFScript Failed")
		return
	endif
		
	if (0 == id)
		; Unlock Rotation
		pDFScript.UnLockRotation()
		return
	endif
	
	ReferenceAlias npcref = NameIdToManagedRef(id)	
	if (!npcref)
		Trace("LockRotationByNameID : No id matching [" + id + "] found")
		return
	endif
	
	pDFScript.LockRotation(npcref.GetActorReference())
EndFunction

Function EnablePAHelmetCombatByNameID(int id)

	Trace("EnablePAHelmetCombatByNameID on id [" + id + "] called")

	if (0 == id)
		int i = 0
		int pFollowerMapLength = pFollowerMap.length	
		Actor npc
		Trace("Applying EnablePAHelmetCombatToggle to [" + pFollowerMapLength + "] aliases")
		while (i < pFollowerMapLength)
			npc = pFollowerMap[i].GetActorRef()
			if (npc)
				int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
				if (followerId > 0)
					ReferenceAlias a = pManagedMap[followerId]
					(a as TweakInventoryControl).EnablePAHelmetCombatToggle()
				endif
			endif
			i += 1
		endWhile	
		return
	endif
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	
	if (!npcref)
		Trace("EnablePAHelmetCombatByNameID : No id matching [" + id + "] found")
		return
	endif
	
	(npcref as TweakInventoryControl).EnablePAHelmetCombatToggle()
	
EndFunction

Function DisablePAHelmetCombatByNameID(int id)

	Trace("DisablePAHelmetCombatByNameID on id [" + id + "] called")

	if (0 == id)
		int i = 0
		int pFollowerMapLength = pFollowerMap.length	
		Actor npc
		Trace("Applying DisablePAHelmetCombatToggle to [" + pFollowerMapLength + "] aliases")
		while (i < pFollowerMapLength)
			npc = pFollowerMap[i].GetActorRef()
			if (npc)
				int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
				if (followerId > 0)
					ReferenceAlias a = pManagedMap[followerId]
					(a as TweakInventoryControl).DisablePAHelmetCombatToggle()
				endif
			endif
			i += 1
		endWhile	
		return
	endif
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	
	if (!npcref)
		Trace("DisablePAHelmetCombatByNameID : No id matching [" + id + "] found")
		return
	endif
	
	(npcref as TweakInventoryControl).DisablePAHelmetCombatToggle()
	
EndFunction

Event OnDistanceLessThan(ObjectReference player, ObjectReference aftcamp, float afDistance)
	UnregisterForDistanceEvents(player, aftcamp)
	if (aftcamp == pShelterMapMarker.GetReference())
		Trace("Approaching Camp. Triggering Camp Outfits...")
		; Maybe it is not someone following us...
		int i = 1
		int pMapLength = pManagedMap.length
		Actor npc
		while (i < pMapLength)
			npc = pManagedMap[i].GetActorRef()
			if (npc && npc.Is3DLoaded())		
				(pManagedMap[i] as TweakInventoryControl).OnLoad()
			endif
			i += 1
		endWhile		
		RegisterForDistanceGreaterThanEvent(player, aftcamp, 1000)
		return
	endif
EndEvent

Event OnDistanceGreaterThan(ObjectReference player, ObjectReference aftcamp, float afDistance)
	UnregisterForDistanceEvents(player, aftcamp)
	if (aftcamp == pShelterMapMarker.GetReference())
		Trace("Leaving Camp....")
		RegisterForDistanceLessThanEvent(player, aftcamp, 1000)
		return
	endif
EndEvent

; Called from TweakShelterScript : TearDownCamp()
Function ReleaseCampPosed()
	; We are tearing down camp. We need to unpose anyone who is assigned to 
	; camp and currently posed. 
	int i = 1
	int pMapLength = pManagedMap.length
	ReferenceAlias npcref
	Actor npc
	while (i < pMapLength)
		npcref = pManagedMap[i]
		npc = npcref.GetActorReference()
		if (npc && npc.IsInFaction(pTweakCampHomeFaction) && npc.IsInFaction(pTweakPosedFaction))
			(npcref As TweakAppearance).StopPosing(true)
		endif
		i += 1
	endWhile
EndFunction

; This should be a MOD Level setting. I looked through the original games code
; and it appears like they never clear the cache. IE: I think they left it always
; loaded to avoid bugs with the Barber/Doctor merchants. So this would only 
; benefit a situation where maybe another mod has disabled it. Flipping this
; would be my first suggestion to someone who says sculpt isn't working...
Function EnableCharGenCache(bool abEnable = true)

	Trace("EnableCharGenCache()")
	Actor player = Game.GetPlayer()

	if (abEnable)
		Game.PrecacheCharGen()
		pCharGenCacheEnabled = true
	else
		Game.PrecacheCharGenClear()
		pCharGenCacheEnabled = false
	endif
	
EndFunction

Function GiveAFTToPlayer()
	Trace("GiveAFTToPlayer()")
	AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy as AFT:TweakPipBoyScript)
	if pTweakPipBoyScript
		pTweakPipBoyScript.EnsurePlayerHasAFT(true)
		return
	endif
	
	Trace("ERROR : AFT not delivered to player because of casting failure. Attempting Recovery")
	Actor pc = Game.GetPlayer()
	if (pc.GetItemCount(pTweakHoloTape) <= 0)
		Trace("Adding HoloTape")
		ObjectReference theHolotape = pc.PlaceAtMe(pTweakHoloTape)
		pc.AddItem(theHolotape,1,true)
		if (pTweakPipBoy)
			ReferenceAlias AftSettingsHolotape = pTweakPipBoy.GetAlias(2) as ReferenceAlias
			if AftSettingsHolotape
				AftSettingsHolotape.ForceRefTo(theHolotape)
			endif
		endif
	else
		Trace("GetItemCount Reports Players already has HoloTape")
	endif
	
	if (pc.GetItemCount( pTweakActivateAFT) <= 0)
		Trace("Adding Activator")
		pc.AddItem( pTweakActivateAFT,1,true)
		pc.MarkItemAsFavorite(pTweakActivateAFT, 2)
	else
		Trace("GetItemCount Reports Players already has Activator")
	endif
EndFunction

Function SendOnGameLoadToAliasScripts()
	Trace("OnGameLoadAliases()")
	int i = 1
	int max_aliases = pManagedMap.Length
	ReferenceAlias npcref
	Actor npc
	Var[] params = new Var[0]
	while (i < max_aliases)
		npcref = pManagedMap[i]
		npc = npcref.GetActorRef()
		if (npc)
			(npcref As TweakSettings).CallFunctionNoWait("EventOnGameLoad", params)
			(npcref As TweakAppearance).CallFunctionNoWait("EventOnGameLoad", params)
			(npcref As TweakInventoryControl).CallFunctionNoWait("EventOnGameLoad", params)
			; (npcref As TweakSettings).EventOnGameLoad()
			; (npcref As TweakAppearance).EventOnGameLoad()
			; (npcref As TweakInventoryControl).EventOnGameLoad()
		endif
		i += 1
	endWhile	
EndFunction

; Event fired from AFT:TweakDFScript (Followers Quest) when an NPC is asked to join the
; active followers group. The NPC may or may not have previously been managed. 
Function EventFollowerRecruited(Actor npc)
	Trace("EventFollowerRecruited()")
	bool firstTime = false

	; Whether we can import them or not (May be at capacity), the 
	; number of ACTIVE followers may still have changed. Take a look
	; and update:
	
	int numFollowers = GetAllTweakFollowers().length
	pTweakFollowerCount.SetValueInt(numFollowers)
	
	int id = npc.GetFactionRank(pTweakFollowerFaction) As Int	
	if (id < 1)
		Trace("EventFollowerRecruited() : Follower Unknown. Importing...")
		if (!ImportFollower(npc))
			trace("EventFollowerRecruited() : Import Failed") ; import should have said something.
			return
		endif
		id = npc.GetFactionRank(pTweakFollowerFaction) As Int
		firstTime = true
	else
		Trace("EventFollowerRecruited() : Follower Recognized")
	endif
	
	ReferenceAlias a = pManagedMap[id]
	if (!(a != None && a.GetActorRef())) ; if a==None || !a.GetActorRef()
		; They were unmanaged?
		trace("EventFollowerRecruited() : No Managed NPC found at [" + id +"] Attempting to recover")
		npc.SetFactionRank(pTweakFollowerFaction, 0)
		if (!ImportFollower(npc))
			trace("EventFollowerRecruited() : Recovery Failed")
			return
		endif
		id = npc.GetFactionRank(pTweakFollowerFaction) As Int
		a = pManagedMap[id]
	endif
	
	if (a && a.GetActorRef())
		npc.RemoveKeyword(p_AttachPassenger)
		npc.RemoveKeyword(p_AttachSlot2)
		if npc.HasKeywordInFormList(pTweakHumanoidKeywords)
			npc.AddKeyword(p_AttachPassenger)
			npc.AddKeyword(pPlayerCanStimpak)
		else
			npc.AddKeyword(p_AttachSlot2)
		endif		
				
		(a As TweakSettings).EventFollowingPlayer(firstTime)
		(a As TweakAppearance).EventFollowingPlayer(firstTime)	
		(a As TweakInventoryControl).EventFollowingPlayer(firstTime)
		; (a As TweakActions).EventFollowingPlayer()
		; (a As TweakPose).EventFollowingPlayer()
		; (a As TweakLevelup).EventFollowingPlayer()
		; (a As TweakPossession).EventFollowingPlayer()
		
		; bool gotlock = GetSpinLock(pTweakMutexCompanions,1, "EventFollowerRecruited") ; low priority since it is read-only
		; ReleaseSpinLock(pTweakMutexCompanions, gotlock, "EventFollowerRecruited")
		
	endif
	
	; NOTE: EvaluateSynergy() Called from Quest Followers Script TweakDFScript After this method returns
	;       for consistency

endFunction

Function EventFollowerWait(Actor npc)
	Trace("EventFollowerWait()")
	int id = npc.GetFactionRank(pTweakFollowerFaction) As Int	
	if (id < 1)
		Trace("EventFollowerWait : Follower Unknown. Ignoring Event")
		return
	endif
	
	ReferenceAlias a = pManagedMap[id]
	if !a.GetActorRef()
		Trace("EventFollowerWait : Follower ID mapped to unfilled reference. Ignoring Event.")
		return
	endif
	
	(a As TweakSettings).EventFollowerWait()
	(a As TweakAppearance).EventFollowerWait()
	(a As TweakInventoryControl).EventFollowerWait()
	; (a As TweakActions).EventFollowerWait()
	; (a As TweakPose).EventFollowerWait()
	; (a As TweakLevelup).EventFollowerWait()
	; (a As TweakPossession).EventFollowerWait()

endFunction

Function EventFollowerFollow(Actor npc)
	Trace("EventFollowerFollow()")
	int id = npc.GetFactionRank(pTweakFollowerFaction) As Int	
	if (id < 1)
		Trace("EventFollowerFollow : Follower Unknown. Ignoring Event")
		return
	endif
	
	ReferenceAlias a = pManagedMap[id]
	if !a.GetActorRef()
		Trace("EventFollowerFollow : Follower ID mapped to unfilled reference. Ignoring Event.")
		return
	endif
	
	(a As TweakSettings).EventWaitToFollow()
	(a As TweakAppearance).EventWaitToFollow()
	(a As TweakInventoryControl).EventWaitToFollow()
	; (a As TweakActions).EventWaitToFollow()
	; (a As TweakPose).EventWaitToFollow()
	; (a As TweakLevelup).EventWaitToFollow()
	; (a As TweakPossession).EventWaitToFollow()

endFunction

Function EventFollowerDismissed(Actor npc)

	; This is called from TweakDFScript AFTER the ref is freed...
	; NOTE: NPC may not be managed....
	int numFollowers = (GetAllTweakFollowers().length)
	pTweakFollowerCount.SetValueInt(numFollowers)
	
	if npc.HasSpell(pTweakFollowerStealth)
		npc.RemoveSpell(pTweakFollowerStealth)
	endif
	
	Trace("EventFollowerDismissed()")
	int id = npc.GetFactionRank(pTweakFollowerFaction) As Int	
	if (id < 1)
		Trace("EventFollowerDismissed : Follower Unknown. Ignoring Event")
		return
	endif
	
	ReferenceAlias a = pManagedMap[id]
	if !a.GetActorRef()
		Trace("EventFollowerDismissed : Follower ID mapped to unfilled reference. Ignoring Event.")
		return
	endif

	; In skyrim, we removed from PlayerFaction to Avoid rand bounties when dismissed. However
	; in Fallout 4, PlayerFaction is needed for settlement workshop compatibility
	
	(a As TweakSettings).EventNotFollowingPlayer()
	(a As TweakAppearance).EventNotFollowingPlayer()
	(a As TweakInventoryControl).EventNotFollowingPlayer()
	; (a As TweakActions).EventNotFollowingPlayer()
	; (a As TweakPose).EventNotFollowingPlayer()
	; (a As TweakLevelup).EventNotFollowingPlayer()
	; (a As TweakPossession).EventNotFollowingPlayer()

	; NOTE: EvaluateSynergy() Called from Quest Followers Script TweakDFScript After this method returns
	;       for consistency. The follower hasn't been removed when this is called, so it most wait
	;       until the reference on Followers Quest is cleared.
	
endFunction

Function EventPlayerEnterPA()

	; Relayed From TweakMonitorPlayer Quest
	Trace("EventPlayerEnterPA()")

	int i = 0
	int pFollowerMapLength = pFollowerMap.length	
	Actor npc
	while (i < pFollowerMapLength)
		npc = pFollowerMap[i].GetActorRef()
		if (npc && npc.IsInFaction(pTweakSyncPAFaction) && npc.Is3DLoaded())

			; NOTE: CURIE can be assigned to a PA but then her body can be 
			; changed to a robot. So to be safe, we need to perform race
			; checks since links may exist from the past when assignment was
			; Okay....
	
			Race r = npc.GetRace()
			if (r == pHumanRace || r == pGhoulRace || r == pSynthGen2RaceValentine || r == pSynthGen2Race)
				int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
				if (followerId > 0)
					ReferenceAlias a = pManagedMap[followerId]
					(a as TweakInventoryControl).EnterAssignedPA()
				endif
			endif
			
		endif
		i += 1
	endWhile
	
EndFunction

Function EventPlayerExitPA()

	; Relayed From TweakMonitorPlayer Quest
	Trace("EventPlayerExitPA()")

	int i = 0
	int pFollowerMapLength = pFollowerMap.length	
	Actor npc
	while (i < pFollowerMapLength)
		npc = pFollowerMap[i].GetActorRef()
		if (npc && npc.IsInFaction(pTweakSyncPAFaction) && npc.Is3DLoaded())
			StartTimer(Utility.RandomInt(2,8), EXIT_PA_BASE + i)
		endif
		i += 1
	endWhile
	
EndFunction

Function EventPlayerEnterVertibird()
	Trace("EventPlayerEnterVertibird")	
	int i = 0
	int pFollowerMapLength = pFollowerMap.length	
	Actor npc
	while (i < pFollowerMapLength)
		npc = pFollowerMap[i].GetActorRef()
		if (npc)
			npc.EvaluatePackage()
		endif			
		i += 1
	endWhile
EndFunction

Function EventPlayerExitedVertibird()
	Trace("EventPlayerExitedVertibird")
	int i = 0
	int pFollowerMapLength = pFollowerMap.length	
	Actor npc
	while (i < pFollowerMapLength)
		npc = pFollowerMap[i].GetActorRef()
		if (npc)
			if (npc.IsGhost())
				Trace("Correcting Slot[" + i + "] (Reporting is Ghost)")
				npc.SetGhost(false)
			endif
			npc.EvaluatePackage()
		endif			
		i += 1
	endWhile
EndFunction

Function EventPlayerSneakStart()
	int i = 0
	int pFollowerMapLength = pFollowerMap.length	
	Actor npc
	while (i < pFollowerMapLength)
		npc = pFollowerMap[i].GetActorRef()
		if (npc && npc.Is3DLoaded())
		
			if !npc.HasSpell(pTweakFollowerStealth)
				npc.AddSpell(pTweakFollowerStealth)
			endif
			
			int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
			if (followerId > 0)
				ReferenceAlias a = pManagedMap[followerId]
				(a as TweakSettings).EventPlayerSneakStart()
			endIf

		endif
		i += 1
	endWhile
EndFunction

Function EventPlayerSneakExit()
	int i = 0
	int pFollowerMapLength = pFollowerMap.length	
	Actor npc
	while (i < pFollowerMapLength)
		npc = pFollowerMap[i].GetActorRef()
		if (npc && npc.Is3DLoaded())
			if npc.HasSpell(pTweakFollowerStealth)
				npc.RemoveSpell(pTweakFollowerStealth)
			endIf
			
			int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
			if (followerId > 0)
				ReferenceAlias a = pManagedMap[followerId]
				(a as TweakSettings).EventPlayerSneakExit()
			endIf
		endif
		i += 1
	endWhile
EndFunction

; Relayed by TweakMonitorPlayer
Function OnPlayerStartSwim()
	Trace("OnPlayerStartSwim")

	int i = 0
	int pFollowerMapLength = pFollowerMap.length	
	Actor npc
	while (i < pFollowerMapLength)
		npc = pFollowerMap[i].GetActorRef()
		if (npc && npc.Is3DLoaded())
		
			int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
			if (followerId > 0)
				ReferenceAlias a = pManagedMap[followerId]
				(a as TweakInventoryControl).EventPlayerSwimStart()
			endIf
		endif
		i += 1
	endWhile
EndFunction

; Relayed by TweakMonitorPlayer
Function OnPlayerStopSwim()
	Trace("OnPlayerStopSwim")
	int i = 0
	int pFollowerMapLength = pFollowerMap.length	
	Actor npc
	while (i < pFollowerMapLength)
		npc = pFollowerMap[i].GetActorRef()
		if (npc && npc.Is3DLoaded())
		
			int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
			if (followerId > 0)
				ReferenceAlias a = pManagedMap[followerId]
				(a as TweakInventoryControl).EventPlayerSwimStop()
			endIf
		endif
		i += 1
	endWhile
EndFunction



Function UnManageByNameID(int id = 0)
	Trace("UnManageByNameID called for  [" + id + "]")
	ReferenceAlias npcref = NameIdToManagedRef(id)
	
	if (!npcref)
		Trace("UnManageByNameID : No id matching [" + id + "] found")
		return
	endif

	UnManageFollower(npcref.GetActorReference())
EndFunction

Function UnManageFollower(Actor npc)

	int followerid = npc.GetFactionRank(pTweakFollowerFaction) As Int		
	if (followerid < 1)
		Trace("Follower Unmanaged. Ignoring")
		return
	endIf

	Perk crNoFallDamage = Game.GetForm(0x0002A6FC) as Perk
	
	if npc.HasPerk(crNoFallDamage)
		npc.RemovePerk(crNoFallDamage)
	endif
	if npc.HasPerk(pTweakCarryBoost)
		npc.RemovePerk(pTweakCarryBoost)
	endif
	if npc.HasPerk(pTweakHealthBoost)
		npc.RemovePerk(pTweakHealthBoost)
	endif
	if npc.HasPerk(pTweakDmgResistBoost)
		npc.RemovePerk(pTweakDmgResistBoost)
	endif
	if npc.HasPerk(pTweakRangedDmgBoost)
		npc.RemovePerk(pTweakRangedDmgBoost)
	endif
	if npc.HasPerk(pTweakZeroCarryInCombat)
		npc.RemovePerk(pTweakZeroCarryInCombat)
	endif	
	
	FollowersScript pFollowersScript = (pFollowers As FollowersScript)
	if pFollowersScript
		Trace("UnManageFollower : Dismissing Follower")
		pFollowersScript.DismissCompanion(npc, false, true)
	endif
	AFT:TweakNamesScript pTweakNamesScript = (pTweakNames as AFT:TweakNamesScript)
	if pTweakNamesScript
		Trace("UnManageFollower : Resetting Name")
		pTweakNamesScript.ResetName(npc, true)
	endif
			
	float cscale = npc.GetValue(pTweakScale)
	if 100 != cscale
		npc.SetValue(pTweakScale,100)
		npc.SetScale(1.0)
	endif

	if (npc.GetActorBase() == Game.GetForm(0x00002F24) as ActorBase) ; Nick Valentine
		RemoveNickItems()
	endif
	
	npc.SetValue(pTweakTopicHello, 0) 
	npc.SetValue(pTweakTopicHelloModID, 0) 
	npc.SetValue(pTweakTopicDismiss, 0) 
	npc.SetValue(pTweakTopicDismissModID, 0) 
	npc.SetValue(pTweakTopicTrade, 0) 
	npc.SetValue(pTweakTopicTradeModID, 0) 
	npc.SetValue(pTweakTopicAck, 0) 
	npc.SetValue(pTweakTopicAckModID, 0) 
	npc.SetValue(pTweakTopicCancel, 0) 
	npc.SetValue(pTweakTopicCancelModID, 0) 
	npc.SetValue(pTweakTopicDistFar, 0) 
	npc.SetValue(pTweakTopicDistFarModID, 0) 
	npc.SetValue(pTweakTopicDistMed, 0) 
	npc.SetValue(pTweakTopicDistMedModID, 0) 
	npc.SetValue(pTweakTopicDistNear, 0) 
	npc.SetValue(pTweakTopicDistNearModID, 0) 
	npc.SetValue(pTweakTopicStyleAgg, 0) 
	npc.SetValue(pTweakTopicStyleAggModID, 0) 
	npc.SetValue(pTweakTopicStyleDef, 0) 
	npc.SetValue(pTweakTopicStyleDefModID, 0) 
	
	UnregisterForRemoteEvent(npc, "OnDeath")
			
	ReferenceAlias a = pManagedMap[followerid]
	if a.GetActorRef()
		
		; Order Matters. TweakSettings will blow away all factions, so if you need
		; faction checks, do those UnManage calls first....

		(a As TweakAppearance).UnManage()
		(a As TweakInventoryControl).UnManage()
		(a As TweakSettings).UnManage()
				
		Trace("UnManageFollower : Clearing Reference and freeing slot")
		a.clear()
	else
		Trace("UnManageFollower : Follower ID mapped to unfilled reference. Ckipping Clear")
	endif
	
	; bool gotlock = GetSpinLock(pTweakMutexCompanions,1, "UnManageFollower") ; low priority since it is read-only	
	int numFollowers = GetAllTweakFollowers().length
	pTweakFollowerCount.SetValueInt(numFollowers)
	; ReleaseSpinLock(pTweakMutexCompanions, gotlock, "UnManageFollower")

	
EndFunction

Function EvaluateSynergy()
	float luckBoost     = 0
	float charismaBoost = 0
	
	ReferenceAlias[] theList = GetAllTweakFollowers(excludeDog=True)

	int theListLength = theList.length
	
	int i = 0
	
	Actor npc
	
	float npcCharisma
	float npcLuck
	
	while (i < theListLength)
	
		npc = theList[i].GetActorRef()
		npcCharisma = npc.GetValue(pCharisma)
		npcLuck     = npc.GetValue(pLuck)
		
		if (npcCharisma > 14)
			if (npcCharisma > 24)
				charismaBoost += 2
			else
				charismaBoost += 1
			endif
		endif
		
		if (npcLuck > 14)
			if (npcLuck > 24)
				luckBoost += 2
			else 
				luckBoost += 1
			endif
		endif
		
		i += 1
	endWhile
	
	if luckBoost != pTweakSynergyLckBoost.GetValue()
		pTweakSynergyLckBoost.SetValue(luckBoost)
	endif
	
	if charismaBoost != pTweakSynergyChrBoost.GetValue()
		pTweakSynergyChrBoost.SetValue(charismaBoost)
	endif
		
EndFunction

Function SetPackMule(Actor npc, bool isPackMule)
	Trace("SetPackMule(" + npc + "," + isPackMule + ")")
	int id = npc.GetFactionRank(pTweakFollowerFaction) As Int	
	if (id < 1)
		Trace("SetPackMule : Follower Unknown. Ignoring Call")
		return
	endif
	
	ReferenceAlias a = pManagedMap[id]
	if !a.GetActorRef()
		Trace("SetPackMule : Follower ID mapped to unfilled reference. Ignoring Event.")
		return
	endif

	(a As TweakSettings).SetPackMule(isPackMule)
EndFunction

Function SetConfidence(Actor npc, int value)
	Trace("SetConfidence(" + npc + "," + value + ")")
	int id = npc.GetFactionRank(pTweakFollowerFaction) As Int	
	if (id < 1)
		Trace("SetConfidence : Follower Unknown. Ignoring Call")
		return
	endif
	
	ReferenceAlias a = pManagedMap[id]
	if !a.GetActorRef()
		Trace("SetConfidence : Follower ID mapped to unfilled reference. Ignoring Event.")
		return
	endif

	(a As TweakSettings).SetConfidence(value)
EndFunction



; This event is called when an actor we registered for has died. Note the first parameter is the actor
; that sent the event, and the following parameters match the OnDeath event itself
Event Actor.OnDeath(Actor akFollower, Actor akKiller)

	Trace("Actor.OnDeath [" + akFollower + "]")
	UnregisterForRemoteEvent(akFollower, "OnDeath")
	FollowersScript pFollowersScript = (pFollowers As FollowersScript)
	if pFollowersScript
		Trace("Actor.OnDeath : Dismissing Follower")
		pFollowersScript.DismissCompanion(akFollower, false, true)
	endif
	AFT:TweakNamesScript pTweakNamesScript = (pTweakNames as AFT:TweakNamesScript)
	if pTweakNamesScript
		Trace("Actor.OnDeath : Resetting Name")
		pTweakNamesScript.ResetName(akFollower, true)
	endif
	
	; There maybe other things we need to do (Unregister for events?) But for now...
	; (a As TweakSettings).HandleDeath()
		
	int id = akFollower.GetFactionRank(pTweakFollowerFaction) As Int	
	if (id > 0)
		ReferenceAlias a = pManagedMap[id]
		if a.GetActorRef()
			Trace("Actor.OnDeath : Clearing Reference and freeing slot")
			a.clear()
		else
			Trace("Actor.OnDeath : Follower ID mapped to unfilled reference. Ckipping Clear")
			; TODO : Recovery? Scan for NPC?
		endif
	else
		Trace("Actor.OnDeath : Follower Unknown. Ignoring Event")
		; TODO : Recovery? Scan for NPC?
	endif
			
	; bool gotlock = GetSpinLock(pTweakMutexCompanions,1, "Actor.OnDeath") ; low priority since it is read-only	
	int numFollowers = GetAllTweakFollowers().length
	pTweakFollowerCount.SetValueInt(numFollowers)
	; ReleaseSpinLock(pTweakMutexCompanions, gotlock, "Actor.OnDeath")
	
EndEvent

Function FollowerExitPA(int followermapindex)
	Actor npc = pFollowerMap[followermapindex].GetActorRef()
	if npc && npc.Is3DLoaded()
		int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
		if (followerId > 0)
			ReferenceAlias a = pManagedMap[followerId]
			(a as TweakInventoryControl).ExitPA(true)
		endif
	endif
EndFunction

; Gets called by Quest Script TweakPipboy?
Bool Function GetOriginallyEssential(Actor npc)
	Trace(" GetOriginallyEssential()")
	int id = npc.GetFactionRank(pTweakFollowerFaction) As Int	
	if (id < 1)
		Trace("ToggleEssential : Follower Unknown. Ignoring Event")
		; TODO : Recovery? Scan for NPC and assign to slot if NPC not assigned?
		return 0
	endif
	
	ReferenceAlias a = pManagedMap[id]
	if !a.GetActorRef()
		Trace("ToggleEssential : Follower ID mapped to unfilled reference. Ignoring Event.")
		; TODO : Recovery? Scan for NPC and assign to slot if NPC not assigned?
		return 0
	endif
	return (a As TweakSettings).originalEssential

EndFunction

Function ToggleTrackKills(Actor npc)
	Trace("ToggleTrackKills()")
	int id = npc.GetFactionRank(pTweakFollowerFaction) As Int	
	if (id < 1)
		Trace("ToggleTrackKills : Follower Unknown. Ignoring Event")
		; TODO : Recovery? Scan for NPC and assign to slot if NPC not assigned?
		return
	endif
	
	ReferenceAlias a = pManagedMap[id]
	if !a.GetActorRef()
		Trace("ToggleTrackKills : Follower ID mapped to unfilled reference. Ignoring Event.")
		; TODO : Recovery? Scan for NPC and assign to slot if NPC not assigned?
		return
	endif
	(a As TweakSettings).ToggleTrackKills()
EndFunction

Function ToggleEssential(Actor npc)

	Trace("ToggleEssential()")
	int id = npc.GetFactionRank(pTweakFollowerFaction) As Int	
	if (id < 1)
		Trace("ToggleEssential : Follower Unknown. Ignoring Event")
		; TODO : Recovery? Scan for NPC and assign to slot if NPC not assigned?
		return
	endif
	
	ReferenceAlias a = pManagedMap[id]
	if !a.GetActorRef()
		Trace("ToggleEssential : Follower ID mapped to unfilled reference. Ignoring Event.")
		; TODO : Recovery? Scan for NPC and assign to slot if NPC not assigned?
		return
	endif
	(a As TweakSettings).ToggleEssential()
	
EndFunction

Location Function GetHomeLoc(Actor npc, int type = 0) ; 0 = assigned, 1 = original

	Trace("GetHomeLoc()")
	
	TweakSettings s = None	
	int followerId = npc.GetFactionRank(pTweakFollowerFaction)
	if (followerId > 0)
		s = (pManagedMap[followerId] as TweakSettings)
		if s && !s.assignedHome
			s.AssignHome()
			Utility.wait(0.1)
		endif
	endif	
	
	; Special Case : Managed Follower Assigned to AFT Camp
	if ((0 == type) && s && npc.IsInFaction(pTweakCampHomeFaction))
		return s.assignedHome
		; return pTweakCampLocation
	endif
	
	WorkshopNPCScript    WNS = npc as WorkshopNPCScript
	CompanionActorScript CAS = npc as CompanionActorScript
	DogmeatActorScript   DAS = npc as DogmeatActorScript
	
	if (0 == type)
	
		Location assignedHome = None
		if (CAS)
			assignedHome = CAS.HomeLocation
		elseIf (DAS)
			assignedHome = DAS.HomeLocation
		endIf
		If (WNS)
			; WNS Trumps CAS for assignment, but only if it is assigned or the NPC is not CAS/DAS
			int workshopID = WNS.GetWorkshopID() ; npc.GetValue(pWorkshopParent.WorkshopIDActorValue) as int
			if (!assignedHome || workshopID > -1)
				WorkshopParentScript pWorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
				RefCollectionAlias wscollection = pWorkshopParent.WorkshopsCollection
				if (workshopID < wscollection.GetCount())
					WorkshopScript workshopRef = wscollection.GetAt(workshopID) as WorkshopScript
					if workshopRef
						assignedHome = workshopRef.GetCurrentLocation()
					endIf
				endIf
			endIf			
		endIf
		if (!assignedHome && s)
			assignedHome = s.assignedHome
		endIf		
		return assignedHome
	endIf

	; TYPE = 1 : original
	Location originalHome = None
	if (s && s.originalHome)
		originalHome = s.originalHome
	endif
	if !originalHome
		ActorBase base = npc.GetActorBase()
		if (base == Game.GetForm(0x00079249) as ActorBase)     ; 1 ---=== Cait ===---
			originalHome = Game.GetForm(0x0001905B) as Location ; CombatZoneLocation		
		elseIf (base == Game.GetForm(0x000179FF) as ActorBase) ; 2 ---=== Codsworth ===---
			originalHome = Game.GetForm(0x0001F229) as Location ; SanctuaryHillsPlayerHouseLocation
		elseIf (base == Game.GetForm(0x00027686) as ActorBase) ; 3 ---=== Curie ===---
			originalHome = Game.GetForm(0x0002BE8D) as Location ; Vault81Location
		elseIf (base == Game.GetForm(0x00027683) as ActorBase) ; 4 ---=== Danse ===---
			originalHome = Game.GetForm(0x0001FA4A) as Location ; CambridgePDLocation
		elseIf (base == Game.GetForm(0x00045AC9) as ActorBase) ; 5 ---=== Deacon ===---
			originalHome = Game.GetForm(0x000482C2) as Location ; RailroadHQLocation
		elseIf (base == Game.GetForm(0x0001D15C) as ActorBase) ; 6 ---=== Dogmeat ===---
			originalHome = Game.GetForm(0x00024FAB) as Location ; RedRocketTruckStopLocation
		elseIf (base == Game.GetForm(0x00022613) as ActorBase) ; 7 ---=== Hancock ===---	
			originalHome = Game.GetForm(0x0002260F) as Location ; GoodneighborOldStateHouseLocation
		elseIf (base == Game.GetForm(0x0002740E) as ActorBase) ; 8 ---=== MacCready ===---	
			originalHome = Game.GetForm(0x0002267F) as Location ; GoodneighborTheThirdRailLocation	
		elseIf (base == Game.GetForm(0x00002F24) as ActorBase) ; 9 ---=== Nick Valentine ===---
			originalHome = Game.GetForm(0x00003979) as Location ; DiamondCityValentinesLocation	
		elseIf (base == Game.GetForm(0x00002F1E) as ActorBase) ; 10 ---=== Piper ===---	
			originalHome = Game.GetForm(0x00003962) as Location ; DiamondCityPublickOccurrencesLocation
		elseIf (base == Game.GetForm(0x00019FD9) as ActorBase) ; 11 ---=== Preston ===---
			originalHome = Game.GetForm(0x0001F228) as Location ; SanctuaryHillsLocation
		elseIf (base == Game.GetForm(0x00027682) as ActorBase) ; 12 ---=== Strong ===---	
			originalHome = Game.GetForm(0x0001DAF7) as Location ; TrinityTowerLocation	
		elseIf (base == Game.GetForm(0x000BBEE6) as ActorBase) ; 13 ---=== X6-88 ===---	
			originalHome = Game.GetForm(0x001BBC22) as Location ; InstituteSRBLocation				
		elseIf (CAS)
			originalHome = CAS.HomeLocation
		elseIf (DAS)
			originalHome = DAS.HomeLocation
		elseIf (WNS)
			WorkshopParentScript pWorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
			int workshopID = npc.GetValue(pWorkshopParent.WorkshopIDActorValue) as int
			if (workshopID > -1)
				RefCollectionAlias wscollection = pWorkshopParent.WorkshopsCollection
				if (workshopID < wscollection.GetCount())
					WorkshopScript workshopRef = wscollection.GetAt(workshopID) as WorkshopScript
					if workshopRef
						originalHome = workshopRef.GetCurrentLocation()
					endIf
				endIf
			endIf
		endIf
	endif
	
	if !originalHome
		originalHome = npc.GetCurrentLocation()
	endif
	if !originalHome
		originalHome = Game.GetForm(0x0001F229) as Location ; SanctuaryHillsPlayerHouseLocation
	endif
	return originalHome

EndFunction

; Assign an alias, but do not assume they are now following...
; If silent is false and we are at CAPACITY, pop up a messagebox
; letting them know. If silent is true, don't say anything and
; simply fail. 
bool Function ImportFollower(Actor npc, bool silent = false)
	Trace("AFT TweakFollowerScript : ImportFollower(" + npc.GetActorBase() + ")")

	int followerid = AssignFollowerId(npc, silent)
	if (0 == followerid)
		Trace("Unable to Assign FollowerID...")
		return false
	endif
	
	int nameid = 0
	AFT:TweakNamesScript pTweakNamesScript = (pTweakNames as AFT:TweakNamesScript)
	if pTweakNamesScript
		nameid = pTweakNamesScript.GetNameIndex(npc, true)
		Trace("TweakNames Asssigned NameId [" + nameid + "]")
	else
		Trace("TweakNames Failed to Cast to TweakNamesScript")
	endif
	
	
	ReferenceAlias a = pManagedMap[followerid]
	a.Clear()
	a.ForceRefTo(npc)			

	if (!a.GetActorRef())
		Trace("AFT Warning: Save Game Compatibility Issue Detected.")
		return false
	EndIf

	RegisterForRemoteEvent(npc,"OnDeath")
	
	; pfCount += 1

	; Add some spoken lines....
	ImportTopicsForCompanion(npc)
	
	(a As TweakSettings).initialize()
	(a As TweakAppearance).initialize()
	(a As TweakInventoryControl).initialize()
	
	; Add AFT Stength = Carry Capacity Boost Perks 
	; (after init to avoid getting baked into original values)
	
	npc.AddPerk(pTweakCarryBoost)
	npc.AddPerk(pTweakHealthBoost)
	npc.AddPerk(pTweakDmgResistBoost)
	npc.AddPerk(pTweakRangedDmgBoost)
	npc.AddPerk(pTweakZeroCarryInCombat)
	
	; (a As TweakActions).initialize() ; Old TweakMagic
	; (a As TweakPose).initialize()
	; (a As TweakLevelup).initialize()
	; (a As TweakPossession).initialize()
	
	; TODO Make Remaining a Global, Add it to the Quest Data Tab and tokenize it into the info area
		
	return true
	
EndFunction

; Assign a Follower ID. Stored as the Faction Rank for TweakFollowerFaction
; (Not to be confused with the NameID, which is is the Faction Rank from TweakNamesFaction)
int Function AssignFollowerID(Actor npc, bool silent)
	if (None == npc)
		return 0
	endif

	int id = npc.GetFactionRank(pTweakFollowerFaction) As Int	
	if (id > 0)	
		Trace("NPC ignored. Rank in TweakFollowerFaction > 0")
		return id
	endif
	
	if npc.IsInFaction(pDanversFaction)
		Trace("NPC ignored. Member of DanversFaction")
		return 0
	endIf
	
	Quest selfQuest = (self as Quest)
	if (!selfQuest)
		Trace("AFT Warning: Unable to cast self (TweakFollowerScript) to Quest")
		return 0
	endif
		
	ReferenceAlias a      = None
	ReferenceAlias r      = None
	Actor f               = None	
	int pManagedMapLength = MAX_MANAGED + 1 ; 33 ( 1 -> 32, dont include 0 )
	int max_minus_one     = MAX_MANAGED
	bool free             = true
	int i                 = 1 ; intentional. Index 0 = Player. 1 - (MAX_MANAGED + 1) are alias slots. 
	int searched          = 0 ; track how many we have visited ...
	
	; Speed up by starting at last known used slot
	if (MAX_MANAGED == pfCount)
		pfCount          = 0
	else
		i = pfCount + 1
	endif
	
	if (!a)
		Trace("Searching [" + MAX_MANAGED + "] aliases for free slot start at [" + i + "]")
	endif
	
	while (!a && i < pManagedMapLength)
		r = pManagedMap[i]
		f = r.GetActorRef()
		if (f && !f.IsDead())
			Trace("Slot [" + i + "] is occupied")
			searched += 1
			i        += 1
		else
			Trace("Slot [" + i + "] available")
			a       = r
			id      = i
			pfCount = i
		EndIf
	EndWhile
	
	if (!a && 0 != pfCount)
		Trace("Wrap Around. Searching from [1] to [" + pfCount + "]")
		i = 1
		while (!a && i <= pfCount)
			r = pManagedMap[i]
			f = r.GetActorRef()
			if (f && !f.IsDead())
				Trace("Slot [" + i + "] is occupied")
				searched += 1
				i        += 1
			else
				Trace("Slot [" + i + "] available")
				a       = r
				id      = i
				pfCount = i
			EndIf		
		endwhile
	endif

	if (MAX_MANAGED == searched)
		Trace("AFT Warning: Unable to manage NPC. Out of available Slots.")
		pfCount = 0
		if (!silent)
			pTweakMaxReached.show()
		endif
		return 0
	else
		Trace("MAX_MANAGED [" + MAX_MANAGED + "] != searched [" + searched + "]")	
	endif	
	
	if (!a)
		; ??? (Init timing issue?)
		Trace("AFT Warning: Unable to manage NPC. pManagedMap.length = [" + pManagedMapLength + "]")
		return 0
	endif
			
	if (id < 1)
		Trace("AFT Warning: id < 1 : Assertion Failure")
		return 0
	endif
	if (id > MAX_MANAGED)
		Trace("AFT Warning: ID > " + MAX_MANAGED + " : Assertion Failure")
		return 0
	endif
	
	Trace("ImportFollower : Assiging Follower ID [" + id + "]")
	npc.SetFactionRank(pTweakFollowerFaction, id)
	return id

EndFunction

Function ViewGearByNameId(int id, Int type=0)

	Trace("View Gear on id [" + id + "] called")
	if (utility.IsInMenuMode() == true)
		Trace("Bailing. Can't open inventory while in Menu Mode...")
		return
	endif
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	if (!npcref)
		Trace("ViewGearByNameId : No id matching [" + id + "] found")
		return
	endif
	
	; TODO:
	TweakInventoryControl pTweakInventoryControl = npcref As TweakInventoryControl
	if (!pTweakInventoryControl)
	    Trace("ViewGearByNameId : Cast to TweakInventoryControl Failed.")
	    return
	endif
	pTweakInventoryControl.ViewInventory()
	
	; npcref.GetActorReference().OpenInventory(true)
	; Utility.wait(0.1)
	return

EndFunction

; Function/Event call relayed from TweakMoniterPlayer Quest
Function EventPlayerWeaponDraw()
	Trace("EventPlayerWeaponDraw()")
	
	Actor npc
	int followerId
	ReferenceAlias a
	int i = 0
	int pFollowerMapLength = pFollowerMap.length
	Trace("pFollowerMapLength ["  + pFollowerMapLength + "]")
	while (i < pFollowerMapLength)
		npc = pFollowerMap[i].GetActorReference()
		if (npc)
			followerId = npc.GetFactionRank(pTweakFollowerFaction)
			if (followerId > 0)
				Trace("Calling WeaponDraw Events on [" + i + "] (followerid:" + followerId + ")")
				a = pManagedMap[followerId]
				(a As TweakSettings).EventPlayerWeaponDraw()         ; Are they in the way?
				(a As TweakAppearance).EventPlayerWeaponDraw()       ; Should we stop Pose?
				(a As TweakInventoryControl).EventPlayerWeaponDraw() ; Put on Helmet?
			else
				Trace("EventPlayerWeaponDraw : FollowerId Lookup Failed. Not Found in TweakFollowerFaction")
			endif
		endif
		i += 1
	endWhile

	if (pTweakFollowerCatchup.GetValue() == 1.0)
		MoveToPlayer(None, true, 180.0, true, 1000, 100) ; General Catchup
	endif
	
EndFunction

; Function/Event call relayed from TweakMoniterPlayer Quest
Function EventPlayerWeaponSheath()
	Trace("EventPlayerWeaponSheath()")	
	
	Actor npc
	int followerId
	ReferenceAlias a
	int i = 0
	int pFollowerMapLength = pFollowerMap.length
	Trace("pFollowerMapLength ["  + pFollowerMapLength + "]")
	while (i < pFollowerMapLength)
		npc = pFollowerMap[i].GetActorReference()
		if (npc)
			followerId = npc.GetFactionRank(pTweakFollowerFaction)
			if (followerId > 0)
				Trace("Calling WeaponSheath Events on [" + i + "] (followerid:" + followerId + ")")
				a = pManagedMap[followerId]
				; (a As TweakSettings).EventPlayerWeaponSheath()         
				; (a As TweakAppearance).EventPlayerWeaponSheath()
				(a As TweakInventoryControl).EventPlayerWeaponSheath() ; Remove Helmet?
			else
				Trace("EventPlayerWeaponDraw : FollowerId Lookup Failed. Not Found in TweakFollowerFaction")
			endif
		endif
		i += 1
	endWhile
	
EndFunction

Function PoseByNameId(int id = 0, int startingPose = -1)

	Trace("PoseByNameId called for  [" + id + "]")

	ReferenceAlias npcref = NameIdToManagedRef(id)
	
	if (!npcref)
		Trace("PoseByNameId : No id matching [" + id + "] found")
		return
	endif
			
	TweakAppearance pTweakAppearance = (npcref As TweakAppearance)
			
	if (!pTweakAppearance)
		Trace("PoseByNameId : Cast to TweakAppearance Failed")
		return
	endif
	
	Trace("Calling PoseFollower(" + startingPose + ")")
	pTweakAppearance.PoseFollower(startingPose)
EndFunction

Function NewBodyByNameId(int id = 0)

	Trace("NewBodyByNameId called for  [" + id + "]")

	ReferenceAlias npcref = NameIdToManagedRef(id)
	
	if (!npcref)
		Trace("NewBodyByNameId : No id matching [" + id + "] found")
		return
	endif
			
	TweakAppearance pTweakAppearance = (npcref As TweakAppearance)
			
	if (!pTweakAppearance)
		Trace("NewBodyByNameId : Cast to TweakAppearance Failed")
		return
	endif
	
	pTweakAppearance.NewBody()
	
EndFunction

Function UnEquipAllGear(Actor npc, bool InvokedFromFurniture = false)
	if (npc)
		int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
		if (followerId > 0)
			ReferenceAlias a = pManagedMap[followerId]
			(a as TweakInventoryControl).UnEquipAllGear(InvokedFromFurniture)
		endif
	endif
EndFunction

Function UnEquipGearByNameId(int id = 0)

	Trace("UnEquipGear on id [" + id + "] called")

	if (0 == id)
		int i = 0
		int pFollowerMapLength = pFollowerMap.length	
		Actor npc
		Trace("Applying UnEquipAll to [" + pFollowerMapLength + "] aliases")
		while (i < pFollowerMapLength)
			npc = pFollowerMap[i].GetActorRef()
			if (npc)
				int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
				if (followerId > 0)
					ReferenceAlias a = pManagedMap[followerId]
					(a as TweakInventoryControl).UnEquipAllGear()
				endif
			endif
			i += 1
		endWhile	
		return
	endif
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	
	if (!npcref)
		Trace("UnEquipGearByName : No id matching [" + id + "] found")
		return
	endif
	
	(npcref as TweakInventoryControl).UnEquipAllGear()
	
endFunction

Function TakePlayerJunk(Actor npc)
	if (npc)
		int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
		if (followerId > 0)
			ReferenceAlias a = pManagedMap[followerId]
			(a as TweakInventoryControl).TakePlayerJunk()			
		endif
	endif
EndFunction


Function TakePlayerDuplicates(Actor npc)
	if (npc)
		int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
		if (followerId > 0)
			AFT:TweakDedupeMasterScript DedupeMaster = pTweakDedupeMaster as AFT:TweakDedupeMasterScript
			if DedupeMaster
				DedupeMaster.PlayerDedupe(npc)
			else
				Trace("Cast to TweakDedupeMasterScript Failed")		
				return
			endif
		endif
	endif
EndFunction

Function ScrapJunk(Actor npc)
	if (npc)
		int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
		if (followerId > 0)
			ReferenceAlias a = pManagedMap[followerId]
			(a as TweakInventoryControl).ScrapJunk()			
		endif
	endif
EndFunction

Function GivePlayerScrap(Actor npc)
	if (npc)
		int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
		if (followerId > 0)
			ReferenceAlias a = pManagedMap[followerId]
			(a as TweakInventoryControl).GivePlayerScrap()			
		endif
	endif	
EndFunction

Function GivePlayerJunkByNameID(int id)
	if (0 == id)
		int i = 0
		int pFollowerMapLength = pFollowerMap.length	
		Actor npc
		Trace("Applying GivePlayerJunkByNameID to [" + pFollowerMapLength + "] aliases")
		while (i < pFollowerMapLength)
			npc = pFollowerMap[i].GetActorRef()
			if (npc)
				int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
				if (followerId > 0)
					ReferenceAlias a = pManagedMap[followerId]
					(a as TweakInventoryControl).GivePlayerJunk()
				endif
			endif			
			i += 1
		endWhile
		return
	endif
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	if (!npcref)
		Trace("GivePlayerScrapByNameID : No id matching [" + id + "] found")
		return
	endif
	(npcref as TweakInventoryControl).GivePlayerJunk()
EndFunction

Function GivePlayerScrapByNameID(int id)
	if (0 == id)
		int i = 0
		int pFollowerMapLength = pFollowerMap.length	
		Actor npc
		Trace("Applying GivePlayerScrapByNameID to [" + pFollowerMapLength + "] aliases")
		while (i < pFollowerMapLength)
			npc = pFollowerMap[i].GetActorRef()
			if (npc)
				int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
				if (followerId > 0)
					ReferenceAlias a = pManagedMap[followerId]
					(a as TweakInventoryControl).GivePlayerScrap()
				endif
			endif			
			i += 1
		endWhile
		return
	endif
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	if (!npcref)
		Trace("GivePlayerScrapByNameID : No id matching [" + id + "] found")
		return
	endif
	(npcref as TweakInventoryControl).GivePlayerScrap()
EndFunction

Function SellUnused(Actor npc)
	if (npc)
		int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
		if (followerId > 0)
			ReferenceAlias a = pManagedMap[followerId]
			(a as TweakInventoryControl).SellUnused()			
		endif
	endif	
EndFunction

Function TransferUnusedGearToPlayer(Actor npc)
	if (npc)
		int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
		if (followerId > 0)
			ReferenceAlias a = pManagedMap[followerId]
			(a as TweakInventoryControl).TransferUnusedGearToPlayer()
		endif
	endif
EndFunction

Function TransferUnusedByNameID(int id)
	if (0 == id)
		int i = 0
		int pFollowerMapLength = pFollowerMap.length	
		Actor npc
		Trace("Applying TransferUnusedGearToPlayer to [" + pFollowerMapLength + "] aliases")
		while (i < pFollowerMapLength)
			npc = pFollowerMap[i].GetActorRef()
			if (npc)
				int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
				if (followerId > 0)
					ReferenceAlias a = pManagedMap[followerId]
					(a as TweakInventoryControl).TransferUnusedGearToPlayer()
				endif
			endif			
			i += 1
		endWhile
		return
	endif
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	if (!npcref)
		Trace("TransferUnusedByNameID : No id matching [" + id + "] found")
		return
	endif
	(npcref as TweakInventoryControl).TransferUnusedGearToPlayer()
EndFunction

Function TransferAllByNameID(int id)
	if (0 == id)
		int i = 0
		int pFollowerMapLength = pFollowerMap.length	
		Actor npc
		Trace("Applying TransferUnusedGearToPlayer to [" + pFollowerMapLength + "] aliases")
		while (i < pFollowerMapLength)
			npc = pFollowerMap[i].GetActorRef()
			if (npc)
				int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
				if (followerId > 0)
					ReferenceAlias a = pManagedMap[followerId]
					(a as TweakInventoryControl).GivePlayerAll()
				endif
			endif			
			i += 1
		endWhile
		return
	endif
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	if (!npcref)
		Trace("TransferUnusedByNameID : No id matching [" + id + "] found")
		return
	endif
	(npcref as TweakInventoryControl).GivePlayerAll()
EndFunction

Bool Function ExitPowerArmor(Actor npc, bool synchronous = true)
	if (npc && npc.Is3DLoaded())
		int max_aliases = pManagedMap.Length
		int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int
		if (followerId > 0 && followerId < max_aliases)
			ReferenceAlias a = pManagedMap[followerId]
			(a as TweakInventoryControl).ExitPA(!synchronous)
			return true
		else
			npc.SwitchToPowerArmor(None)
		endif
	endif
	return false
EndFunction

; synchronous is more stable. Async can crash the game if things are
; wonky...
Bool Function ExitPowerArmorByNameId(int id = 0, bool synchronous = false)

	Trace("ExitPowerArmorByNameId called on [" + id + "]")

	if (0 == id)
		int i = 0
		int pFollowerMapLength = pFollowerMap.length	
		Actor npc
		Trace("Applying ExitPowerArmor to [" + pFollowerMapLength + "] aliases")
		while (i < pFollowerMapLength)
			npc = pFollowerMap[i].GetActorRef()
			if (npc && npc.Is3DLoaded())
				int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
				if (followerId > 0)
					ReferenceAlias a = pManagedMap[followerId]
					(a as TweakInventoryControl).ExitPA(!synchronous)
				else
					npc.SwitchToPowerArmor(None)
				endif
			endif			
			i += 1
		endWhile
		return true
	endif
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	if (!npcref)
		Trace("ExitPowerArmorByNameId : No id matching [" + id + "] found")
		return false
	endif
	if (npcref.GetActorReference().Is3DLoaded())
		(npcref as TweakInventoryControl).ExitPA(!synchronous)
		return true
	endif
	return false
EndFunction

Function EnterPowerArmorByNameId(int id = 0)

	Trace("EnterPowerArmorByNameId called on [" + id + "]")

	if (0 == id)
		int i = 0
		int pFollowerMapLength = pFollowerMap.length	
		Actor npc
		Trace("Applying EnterPowerArmor to [" + pFollowerMapLength + "] aliases")
		while (i < pFollowerMapLength)
			npc = pFollowerMap[i].GetActorRef()
			if (npc && npc.Is3DLoaded())
				int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
				if (followerId > 0)
					ReferenceAlias a = pManagedMap[followerId]
					(a as TweakInventoryControl).EnterAssignedPA()
				endif
			endif			
			i += 1
		endWhile
		return
	endif
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	if (!npcref)
		Trace("EnterPowerArmorByNameId : No id matching [" + id + "] found")
		return
	endif
	(npcref as TweakInventoryControl).EnterAssignedPA()
		
EndFunction

; Target Outfits (From TweakInventoryControl):
;
; NONE      = 0 const
; COMBAT    = 1 const
; HOME      = 2 const
; CITY      = 3 const
; CAMP      = 4 const
; STANDARD  = 5 const
; SNAPSHOT  = 6 const ; Used externally by things like the bathroom.
; LASTKNOWN = 7 const
Function ClearTweakOutfit(Actor npc, int targetOutfit = 0)
	ReferenceAlias a = None
	int id = npc.GetFactionRank(pTweakFollowerFaction) As Int	
	if (id > 0)
		a = pManagedMap[id]
		(a as TweakInventoryControl).ClearTweakOutfit(targetOutfit)
	endif
EndFunction

Function UnManageOutfits(Actor npc)
	ReferenceAlias a = None
	int id = npc.GetFactionRank(pTweakFollowerFaction) As Int	
	if (id > 0)
		a = pManagedMap[id]
		(a as TweakInventoryControl).UnManageOutfits()
	endif	
EndFunction

Function ClearAllOutfits(Actor npc)
	ReferenceAlias a = None
	int id = npc.GetFactionRank(pTweakFollowerFaction) As Int	
	if (id > 0)
		a = pManagedMap[id]
		(a as TweakInventoryControl).ClearAllOutfits()
	endif	
EndFunction

Function SetTweakOutfit(Actor npc, int targetOutfit = 0, bool silent = false)
	ReferenceAlias a = None
	int id = npc.GetFactionRank(pTweakFollowerFaction) As Int	
	if (id > 0)
		a = pManagedMap[id]
		if (a.GetActorReference().GetActorBase() == Game.GetForm(0x00002F24) as ActorBase) ; Nick Valentine
			AddNickItems()
		endif
		(a as TweakInventoryControl).SetTweakOutfit(targetOutfit, silent)
	endif
EndFunction

Function RestoreTweakOutfit(Actor npc, int targetOutfit = 0, bool AvoidUnequipAll = true)
	int id = npc.GetFactionRank(pTweakFollowerFaction) As Int	
	if (id > 0)
		ReferenceAlias a = pManagedMap[id]
		(a as TweakInventoryControl).RestoreTweakOutfit(targetOutfit, AvoidUnequipAll)
	endif
EndFunction

Function AssignHome(Actor npc)
	ReferenceAlias a = None
	int id = npc.GetFactionRank(pTweakFollowerFaction) As Int	
	if (id > 0)
		a = pManagedMap[id]
		(a as TweakSettings).AssignHome()
	endif
EndFunction

Function LocateFollowerByNameID(int id = 0)
	Trace("LocateFollowerByNameID")

	if (0 == id)
		Trace("No NPC Selected")
		return
	endIf
	
	if pTweakLocator.IsRunning()
		pTweakLocator.SetStage(20)
		Utility.wait(2.0)
	endif

	if pTweakLocator.IsRunning()
		Utility.wait(2.0)
		if pTweakLocator.IsRunning()
			pTweakLocator.Stop()
			pLostNPC.Clear()
		endIf
	endIf
	
	pTweakLocator.Reset()
	ReferenceAlias npcref = NameIdToManagedRef(id)
	pLostNPC.ForceRefTo(npcref.GetReference())

	RegisterForRemoteEvent(pTweakLocator,"OnStageSet")
	Trace("Starting Locator Quest")
	
	pTweakLocator.Start()
	
EndFunction

; type:
; 0 = All
; 1 = Stats
; 2 = Relationship
; 3 = AI
; 4 = Traits
; 5 = Effects
; 6 = Perks
; 7 = Factions
; 8 = Keywords

Function FollowerInfo(Actor npc, int type = 0)
	Trace("FollowerInfo")

	if (!npc)
		Trace("No NPC Selected")
		return
	endIf
	
	if pTweakInfo.IsRunning()
		pTweakInfo.Stop()
	endif
	
	pTweakInfo.Reset()
	pInfoNPC.ForceRefTo(npc)
	Utility.wait(0.1)
	Trace("Calling pTweakInfoInspecting.Show()")
	pTweakInfoInspecting.Show()
	
	pTweakInfoVar1.SetValue(npc.GetLevel())

	if (0 == type || 1 == type)
		pTweakInfoVar2.SetValue(npc.GetValue(pStrength))
		pTweakInfoVar3.SetValue(npc.GetValue(pPerception))
		pTweakInfoVar4.SetValue(npc.GetValue(pEndurance))
		pTweakInfoVar5.SetValue(npc.GetValue(pCharisma))
		pTweakInfoVar6.SetValue(npc.GetValue(pIntelligence))
		pTweakInfoVar7.SetValue(npc.GetValue(pAgility))
		pTweakInfoVar8.SetValue(npc.GetValue(pLuck))
		pTweakInfoVar9.SetValue(npc.GetValue(pHealth))
		pTweakInfoVar10.SetValue(npc.GetValue(pCarryWeight))
	
		pTweakInfoVar11.SetValue(npc.GetValue(pEnergyResist))
		pTweakInfoVar12.SetValue(npc.GetValue(pFireResist))
		pTweakInfoVar13.SetValue(npc.GetValue(pFrostResist))
		pTweakInfoVar14.SetValue(npc.GetValue(pPoisonResist))
		pTweakInfoVar15.SetValue(npc.GetValue(pRadResistExposure))
		pTweakInfoVar16.SetValue(npc.GetValue(pDamageResist))
		
		int followerId = npc.GetFactionRank(pTweakFollowerFaction)
		if (followerId > 0)
			TweakSettings ts = (pManagedMap[followerId] as TweakSettings)
			pTweakInfoVar23.SetValueInt(ts.GetNumKilled())
		else
			pTweakInfoVar23.SetValueInt(-1)
		endif	
		
	endif

	if (0 == type || 2 == type)
		CompanionActorScript cas = npc as CompanionActorScript
		if cas
			CompanionActorScript:ThresholdData tdataup   = cas.GetNextThreshold(true)
			CompanionActorScript:ThresholdData tdatadown = cas.GetNextThreshold(false)		
			pTweakInfoVar17.SetValue(cas.MaxAffinity)
			pTweakInfoVar18.SetValue(tdataup.Threshold_Global.GetValue())
			pTweakInfoVar19.SetValue(npc.GetValue(pCA_Affinity))
			pTweakInfoVar20.SetValue(tdatadown.Threshold_Global.GetValue())
			pTweakInfoVar21.SetValue(cas.MinAffinity)
		else
			pTweakInfoVar17.SetValue(-1)
			pTweakInfoVar18.SetValue(-1)
			pTweakInfoVar19.SetValue(-1)
			pTweakInfoVar20.SetValue(-1)
			pTweakInfoVar21.SetValue(-1)
		endIf
	endif
	
	if (0 == type || 4 == type)
		int followerId = npc.GetFactionRank(pTweakFollowerFaction)
		if (followerId > 0)
			TweakSettings tws = (pManagedMap[followerId] as TweakSettings)
			pTweakInfoVar24.SetValueInt(tws.AliasIndex as Int)
		else
			pTweakInfoVar24.SetValueInt(-1)
		endif
	endif
	
	
	Trace("Starting Info Quest")
	pTweakInfo.Start()
	
	Utility.Wait(0.1)
	AFT:TweakInfoScript pTweakInfoScript = pTweakInfo as AFT:TweakInfoScript
	if (pTweakInfoScript)
	
		TweakSettings s = None	
		int followerId = npc.GetFactionRank(pTweakFollowerFaction)
		if (followerId > 0)
			s = (pManagedMap[followerId] as TweakSettings)
		endif	
	
		pTweakInfoScript.Setup(type)
		if (0 == type || 7 == type)
			if s
				pTweakInfoScript.UpdateFactions(s.originalFactions)
			else
				Faction[] originalFactions = new Faction[0]
				pTweakInfoScript.UpdateFactions(originalFactions)				
			endif
		endif
		if (0 == type || 3 == type)
			if s
				pTweakInfoScript.UpdateAI(s.originalAggression, s.originalConfidence,  s.originalAssistance, s.originalMorality)
			else
				int originalAggression   = npc.GetValue(Game.GetForm(0x000002BC) as ActorValue)  As Int	
				int originalConfidence   = npc.GetValue(Game.GetForm(0x000002BD) as ActorValue)  As Int
				int originalAssistance   = npc.GetValue(Game.GetForm(0x000002C1) as ActorValue)  As Int
				int originalMorality     = npc.GetValue(Game.GetForm(0x000002BF) as ActorValue)  As Int
				pTweakInfoScript.UpdateAI(originalAggression, originalConfidence,  originalAssistance, originalMorality)			
			endif
		endif
		if (0 == type || 4 == type)
		
			Location assignedHome = GetHomeLoc(npc)
			Location originalHome = GetHomeLoc(npc,1)
			
			if s
				pTweakInfoScript.UpdateTraits(s.originalRace, originalHome, assignedHome)
			else
				Race originalRace = npc.GetRace()
				ActorBase base = npc.GetActorBase()
				if (base == Game.GetForm(0x00027686) as ActorBase) ; 3 ---=== Curie ===---
					originalRace = Game.GetForm(0x000359F4) as Race		; HandyRace
				endif
				pTweakInfoScript.UpdateTraits(originalRace, originalHome, assignedHome)
			endif
		endif
		pTweakInfoScript.ShowInfo()
	endif

EndFunction

Event Quest.OnStageSet(Quest pQuest, int auiStageID, int auiItemID)
	Trace("Quest [" + pQuest + "] Stage Changed to [" + auiStageID + "]")
	if (pTweakLocator == pQuest)
		if (20 == auiStageID)
			UnRegisterForRemoteEvent(pTweakLocator,"OnStageSet")
			pLostNPC.Clear()
		endif
	elseif BoSKickOut == pQuest
		if (20 == auiStageID || 30 == auiStageID)
			UnRegisterForRemoteEvent(BoSKickOut,"OnStageSet")
			HandleBoSKickOut()
		endif
	elseif BoSKickOutSoft == pQuest
		if (10 == auiStageID)
			UnRegisterForRemoteEvent(BoSKickOutSoft,"OnStageSet")
			HandleBoSKickOut()
		endif
	elseif RRKickOut == pQuest
		if (100 == auiStageID)
			UnRegisterForRemoteEvent(RRKickOut,"OnStageSet")
			HandleRRKickOut()
		endif
	endif
EndEvent

Event Quest.OnQuestInit(Quest auiQuest)
	Trace("Quest.OnQuestInit Called : auiQuest [" + auiQuest + "]")
	UnregisterForRemoteEvent(auiQuest, "OnQuestInit")
	
	if BoSKickOut == auiQuest
		RegisterForRemoteEvent(BoSKickOut,"OnStageSet")
	elseif BoSKickOutSoft == auiQuest
		RegisterForRemoteEvent(BoSKickOutSoft,"OnStageSet")
	elseif InstKickOut == auiQuest
		; Handle X6-88
		HandleInstKickOut()
	elseif RRKickOut == auiQuest
		RegisterForRemoteEvent(RRKickOut,"OnStageSet")
	else
		RegisterForRemoteEvent(auiQuest, "OnQuestInit")
	endif
EndEvent

Bool Function SetFollowerFollowByNameId(int id = 0)

	Trace("SetFollowerFollowByNameId called on [" + id + "]")

	AFT:TweakDFScript pDFScript = (pFollowers as AFT:TweakDFScript)
	if !pDFScript
		Trace("SetFollowerFollowByNameId : Cast to AFT:TweakDFScript Failed")
		return false
	endif
		
	if (0 == id)
		int i = 0
		int pFollowerMapLength = pFollowerMap.length
		Actor npc
		Trace("Applying Follow to [" + pFollowerMapLength + "] aliases")
		while (i < pFollowerMapLength)
			npc = pFollowerMap[i].GetActorRef()
			if (npc)			
				pDFScript.FollowerFollow(npc)
			endif
			i += 1
		endWhile
		return true
	endif
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	
	if (!npcref)
		Trace("SetFollowerFollowByNameId : No id matching [" + id + "] found")
		return false
	endif
	
	pDFScript.FollowerFollow(npcref.GetActorReference())
	return true
	
EndFunction

Bool Function SetFollowerStayByNameId(int id = 0)

	Trace("SetFollowerStayByNameId called on [" + id + "]")

	AFT:TweakDFScript pDFScript = (pFollowers as AFT:TweakDFScript)
	if !pDFScript
		Trace("SetFollowerStayByNameId : Cast to TweakDFScript Failed")
		return false
	endif

	if (0 == id)
		int i = 0
		int pFollowerMapLength = pFollowerMap.length
		Actor npc
		Trace("Applying Stay to [" + pFollowerMapLength + "] aliases")
		while (i < pFollowerMapLength)
			npc = pFollowerMap[i].GetActorRef()
			if (npc)			
				pDFScript.FollowerWait(npc)
			endif
			i += 1
		endWhile
		return true
	endif
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	
	if (!npcref)
		Trace("SetFollowerStayByNameId : No id matching [" + id + "] found")
		return false
	endif
	
	pDFScript.FollowerWait(npcref.GetActorReference())
	return true
	
EndFunction

Bool Function SetFollowerHangoutByNameId(int id = 0)

	Trace("SetFollowerHangoutByNameId called on [" + id + "]")

	AFT:TweakDFScript pDFScript = (pFollowers as AFT:TweakDFScript)
	if !pDFScript
		Trace("SetFollowerHangoutByNameId : Cast to TweakDFScript Failed")
		return false
	endif

	if (0 == id)
		int i = 0
		int pFollowerMapLength = pFollowerMap.length
		Actor npc
		Trace("Applying Hangout to [" + pFollowerMapLength + "] aliases")
		while (i < pFollowerMapLength)
			npc = pFollowerMap[i].GetActorRef()
			if (npc)			
				pDFScript.FollowerHangout(npc)
			endif
			i += 1
		endWhile
		return true
	endif
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	
	if (!npcref)
		Trace("SetFollowerHangoutByNameId : No id matching [" + id + "] found")
		return false
	endif
	
	pDFScript.FollowerHangout(npcref.GetActorReference())
	return true
	
EndFunction

Bool Function DismissFollowerByNameId(int id = 0)

	Trace("DismissFollowerByNameId called on [" + id + "]")

	AFT:TweakDFScript pDFScript = (pFollowers as AFT:TweakDFScript)
	if !pDFScript
		Trace("DismissFollowerByNameId : Cast to TweakDFScript Failed")
		return false
	endif

	if (0 == id)
		int i = 0
		int pFollowerMapLength = pFollowerMap.length
		Actor npc
		Trace("Applying Dismiss to [" + pFollowerMapLength + "] aliases")
		while (i < pFollowerMapLength)
			npc = pFollowerMap[i].GetActorRef()
			if (npc)			
				pDFScript.DismissCompanion(npc, false, false)
			endif
			i += 1
		endWhile
		return true
	endif
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	
	if (!npcref)
		Trace("DismissFollowerByNameId : No id matching [" + id + "] found")
		return false
	endif
	
	pDFScript.DismissCompanion(npcref.GetActorReference())
	return true

EndFunction
	
Bool Function SetFollowerDistanceFarByNameId(int id = 0)

	Trace("SetFollowerDistanceFarByNameId [" + id + "]")

	FollowersScript pFollowersScript = (pFollowers As FollowersScript)
	if !pFollowersScript
		Trace("SetFollowerDistanceFarByNameId : Cast to FollowersScript Failed")
		return false
	endif
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	
	if (!npcref)
		Trace("SetFollowerDistanceFarByNameId : No id matching [" + id + "] found")
		return false
	endif
	
	pFollowersScript.FollowerSetDistanceFar(npcref.GetActorReference())

EndFunction

Bool Function SetFollowerDistanceMedByNameId(int id = 0)

	Trace("SetFollowerDistanceMedByNameId [" + id + "]")

	FollowersScript pFollowersScript = (pFollowers As FollowersScript)
	if !pFollowersScript
		Trace("SetFollowerDistanceMedByNameId : Cast to FollowersScript Failed")
		return false
	endif
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	
	if (!npcref)
		Trace("SetFollowerDistanceMedByNameId : No id matching [" + id + "] found")
		return false
	endif
	
	pFollowersScript.FollowerSetDistanceMedium(npcref.GetActorReference())

EndFunction

Bool Function SetFollowerDistanceNearByNameId(int id = 0)

	Trace("SetFollowerDistanceNearByNameId [" + id + "]")

	FollowersScript pFollowersScript = (pFollowers As FollowersScript)
	if !pFollowersScript
		Trace("SetFollowerDistanceNearByNameId : Cast to FollowersScript Failed")
		return false
	endif
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	
	if (!npcref)
		Trace("SetFollowerDistanceNearByNameId : No id matching [" + id + "] found")
		return false
	endif
	
	pFollowersScript.FollowerSetDistanceNear(npcref.GetActorReference())

EndFunction

Bool Function SetFollowerStanceAutoByNameId(int id = 0)

	Trace("SetFollowerStanceAutoByNameId [" + id + "]")	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	if (!npcref)
		Trace("SetFollowerStanceAutoByNameId : No id matching [" + id + "] found")
		return false
	endif	
	(npcref as TweakSettings).SetFollowerStanceAuto()
	
EndFunction

Bool Function SetFollowerStanceAggressiveByNameId(int id = 0)

	Trace("SetFollowerStanceAggressiveByNameId [" + id + "]")	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	if (!npcref)
		Trace("SetFollowerStanceAggressiveByNameId : No id matching [" + id + "] found")
		return false
	endif	
	(npcref as TweakSettings).SetFollowerStanceAggressive()
	
EndFunction

Bool Function SetFollowerStanceDefensiveByNameId(int id = 0)

	Trace("SetFollowerStanceDefensiveByNameId [" + id + "]")	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	if (!npcref)
		Trace("SetFollowerStanceDefensiveByNameId : No id matching [" + id + "] found")
		return false
	endif
	(npcref as TweakSettings).SetFollowerStanceDefensive()
	
EndFunction

Function ChangeExpressionByNameId(int id = 0)

	Trace("ChangeExpressionByNameId [" + id + "]")
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	if (!npcref)
		Trace("ChangeExpressionByNameId : No id matching [" + id + "] found")
		return
	endif

	TweakAppearance pTweakAppearance = (npcref As TweakAppearance)		
	if (!pTweakAppearance)
		Trace("ChangeExpressionByNameId : Cast to TweakAppearance Failed")
		return
	endif

	pTweakAppearance.ChangeExpression()
	
EndFunction

Function ChangePostureByNameId(int id = 0)

	Trace("ChangePostureByNameId [" + id + "]")
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	if (!npcref)
		Trace("ChangePostureByNameId : No id matching [" + id + "] found")
		return
	endif

	TweakAppearance pTweakAppearance = (npcref As TweakAppearance)		
	if (!pTweakAppearance)
		Trace("ChangePostureByNameId : Cast to TweakAppearance Failed")
		return
	endif

	pTweakAppearance.ChangePosture()
	
EndFunction

Function MovePosedByNameId(int id = 0)

	Trace("MovePosedByNameId [" + id + "]")
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	if (!npcref)
		Trace("MovePosedByNameId : No id matching [" + id + "] found")
		return
	endif

	TweakAppearance pTweakAppearance = (npcref As TweakAppearance)		
	if (!pTweakAppearance)
		Trace("MovePosedByNameId : Cast to TweakAppearance Failed")
		return
	endif

	pTweakAppearance.MovePosed()
	
EndFunction

Function StopPoseByNameId(int id = 0)

	Trace("StopPoseByNameId [" + id + "]")
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	if (!npcref)
		Trace("StopPoseByNameId : No id matching [" + id + "] found")
		return
	endif

	TweakAppearance pTweakAppearance = (npcref As TweakAppearance)		
	if (!pTweakAppearance)
		Trace("StopPoseByNameId : Cast to TweakAppearance Failed")
		return
	endif

	pTweakAppearance.StopPosing(true)
	
EndFunction

Function SculptByNameId(int id = 0, int uiMenu = 1)

	Trace("SculptByNameId [" + id + "]")
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	if (!npcref)
		Trace("SculptByNameId : No id matching [" + id + "] found")
		return
	endif

	TweakAppearance pTweakAppearance = (npcref As TweakAppearance)		
	if (!pTweakAppearance)
		Trace("SculptByNameId : Cast to TweakAppearance Failed")
		return
	endif

	pTweakAppearance.Sculpt(uiMenu)
	
EndFunction

Function SculptLeveledByNameId(int id = 0, int uiMenu = 1)

	Trace("SculptLeveledByNameId [" + id + "]")
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	if (!npcref)
		Trace("SculptLeveledByNameId : No id matching [" + id + "] found")
		return
	endif

	TweakAppearance pTweakAppearance = (npcref As TweakAppearance)		
	if (!pTweakAppearance)
		Trace("SculptLeveledByNameId : Cast to TweakAppearance Failed")
		return
	endif
	TweakChangeAppearance pTweakChangeAppearance = ((self as Quest) as TweakChangeAppearance)	
	if !pTweakChangeAppearance
		Trace("SculptLeveledByNameId : Quest cast TweakChangeAppearance failed.")				
		return
	endif

	pTweakChangeAppearance.SculptLeveled(pTweakAppearance, uiMenu)
	
EndFunction


Function EyePartsByNameId(int id = 0)
	Trace(" EyePartsByNameId() Called")				
	ActivatePartsByNameId(id,1)
EndFunction

Function HeadPartsByNameId(int id = 0)
	Trace("HeadPartsByNameId() Called")				
	ActivatePartsByNameId(id,2)
EndFunction

Function HairPartsByNameId(int id = 0)
	Trace("HairPartsByNameId() Called")		
	ActivatePartsByNameId(id,3)
EndFunction

Function BeardPartsByNameId(int id = 0)
	Trace("BeardPartsByNameId() Called")		
	ActivatePartsByNameId(id,4)
EndFunction

Function ActivatePartsByNameId(int id, int part=1)
	Trace("ActivatePartsByNameId() Called")	
	
	ReferenceAlias npcref = NameIdToManagedRef(id)
	if (!npcref)
		Trace("ActivatePartsByNameId : No id matching [" + id + "] found")
		return
	endif

	TweakAppearance pTweakAppearance = (npcref As TweakAppearance)
	
	if (!pTweakAppearance)
		Trace("ActivatePartsByNameId : Cast to TweakAppearance Failed")
		return
	endif
	
	if (2 == part) 
		pTweakAppearance.EditHeadParts()
	elseif (3 == part)
		pTweakAppearance.EditHairParts()
	elseif (4 == part)
		pTweakAppearance.EditBeardParts()
	else
		pTweakAppearance.EditEyeParts()
	endif
	
EndFunction

Function AddNickItems()
	ActorBase NickBase = Game.GetForm(0x00002F24) as ActorBase
	Actor Nick = NickBase.GetUniqueActor()
	
	bool hadsomething = false
	Armor TweakNickBadass			= Game.GetFormFromFile(0x0103E7C1,"AmazingFollowerTweaks.esp") as Armor
	if (0 == Nick.GetItemCount(TweakNickBadass))
		Nick.AddItem(TweakNickBadass)
	else
		hadsomething = true
	endIf
	Armor TweakNickBlackArmor		= Game.GetFormFromFile(0x0103E7B5,"AmazingFollowerTweaks.esp") as Armor
	if (0 == Nick.GetItemCount(TweakNickBlackArmor))
		Nick.AddItem(TweakNickBlackArmor)
	else
		hadsomething = true
	endIf
	Armor TweakNickColonialDuster	= Game.GetFormFromFile(0x0103E7BB,"AmazingFollowerTweaks.esp") as Armor
	if (0 == Nick.GetItemCount(TweakNickColonialDuster))
		Nick.AddItem(TweakNickColonialDuster)
	else
		hadsomething = true
	endIf
	Armor TweakNickHeavy			= Game.GetFormFromFile(0x0103E7BA,"AmazingFollowerTweaks.esp") as Armor
	if (0 == Nick.GetItemCount(TweakNickHeavy))
		Nick.AddItem(TweakNickHeavy)
	else
		hadsomething = true
	endIf
	Armor TweakNickLeatherDuster	= Game.GetFormFromFile(0x0103E7C5,"AmazingFollowerTweaks.esp") as Armor
	if (0 == Nick.GetItemCount(TweakNickLeatherDuster))
		Nick.AddItem(TweakNickLeatherDuster)
	else
		hadsomething = true
	endIf
	Armor TweakNickMedium			= Game.GetFormFromFile(0x0103E7BE,"AmazingFollowerTweaks.esp") as Armor
	if (0 == Nick.GetItemCount(TweakNickMedium))
		Nick.AddItem(TweakNickMedium)
	else
		hadsomething = true
	endIf
	Armor TweakNickArmorMinutemanHat= Game.GetFormFromFile(0x0103E7C3,"AmazingFollowerTweaks.esp") as Armor
	if (0 == Nick.GetItemCount(TweakNickArmorMinutemanHat))
		Nick.AddItem(TweakNickArmorMinutemanHat)
	else
		hadsomething = true
	endIf
	Armor TweakNickSilverArmor		= Game.GetFormFromFile(0x0103E7C9,"AmazingFollowerTweaks.esp") as Armor
	if (0 == Nick.GetItemCount(TweakNickSilverArmor))
		Nick.AddItem(TweakNickSilverArmor)
	else
		hadsomething = true
	endIf
	Armor TweakNickSilverShroudHat	= Game.GetFormFromFile(0x0103E7CA,"AmazingFollowerTweaks.esp") as Armor
	if (0 == Nick.GetItemCount(TweakNickSilverShroudHat))
		Nick.AddItem(TweakNickSilverShroudHat)
	else
		hadsomething = true
	endIf
	Armor TweakNickClothesTuxedo	= Game.GetFormFromFile(0x0103E7CC,"AmazingFollowerTweaks.esp") as Armor
	if (0 == Nick.GetItemCount(TweakNickClothesTuxedo))
		Nick.AddItem(TweakNickClothesTuxedo)
	else
		hadsomething = true
	endIf
	Armor TweakNickArmorVault111	= Game.GetFormFromFile(0x0103E7CE,"AmazingFollowerTweaks.esp") as Armor
	if (0 == Nick.GetItemCount(TweakNickArmorVault111))
		Nick.AddItem(TweakNickArmorVault111)
	else
		hadsomething = true
	endIf
	Armor TweakNickSunGlasses	    = Game.GetFormFromFile(0x0103E7D0,"AmazingFollowerTweaks.esp") as Armor
	if (0 == Nick.GetItemCount(TweakNickSunGlasses))
		Nick.AddItem(TweakNickSunGlasses)
	else
		hadsomething = true
	endIf
	Armor TweakNickValentineCoat	= Game.GetFormFromFile(0x0103E7D1,"AmazingFollowerTweaks.esp") as Armor
	if (0 == Nick.GetItemCount(TweakNickValentineCoat))
		Nick.AddItem(TweakNickValentineCoat)
	else
		hadsomething = true
	endIf
	Armor TweakNickValentineHat		= Game.GetFormFromFile(0x0103E7D2,"AmazingFollowerTweaks.esp") as Armor
	if (0 == Nick.GetItemCount(TweakNickValentineHat))
		Nick.AddItem(TweakNickValentineHat)
	else
		hadsomething = true
	endIf
	if (!hadsomething)
		Nick.EquipItem(TweakNickValentineCoat)
		Nick.EquipItem(TweakNickValentineHat)
	endif
EndFunction

Function RemoveNickItems()
	ActorBase NickBase = Game.GetForm(0x00002F24) as ActorBase
	Actor Nick = NickBase.GetUniqueActor()
	if Nick.IsDead()
		return
	endif
	
	bool hadsomething = false
	Armor TweakNickBadass			= Game.GetFormFromFile(0x0103E7C1,"AmazingFollowerTweaks.esp") as Armor
	if (Nick.GetItemCount(TweakNickBadass) > 0)
		Nick.RemoveItem(TweakNickBadass, 999 , true)
	endIf
	Armor TweakNickBlackArmor		= Game.GetFormFromFile(0x0103E7B5,"AmazingFollowerTweaks.esp") as Armor
	if (Nick.GetItemCount(TweakNickBlackArmor) > 0)
		Nick.RemoveItem(TweakNickBlackArmor, 999 , true)
	endIf
	Armor TweakNickColonialDuster	= Game.GetFormFromFile(0x0103E7BB,"AmazingFollowerTweaks.esp") as Armor
	if (Nick.GetItemCount(TweakNickColonialDuster) > 0)
		Nick.RemoveItem(TweakNickColonialDuster, 999 , true)
	endIf
	Armor TweakNickHeavy			= Game.GetFormFromFile(0x0103E7BA,"AmazingFollowerTweaks.esp") as Armor
	if (Nick.GetItemCount(TweakNickHeavy) > 0)
		Nick.RemoveItem(TweakNickHeavy, 999 , true)
	endIf
	Armor TweakNickLeatherDuster	= Game.GetFormFromFile(0x0103E7C5,"AmazingFollowerTweaks.esp") as Armor
	if (Nick.GetItemCount(TweakNickLeatherDuster) > 0)
		Nick.RemoveItem(TweakNickLeatherDuster, 999 , true)
	endIf
	Armor TweakNickMedium			= Game.GetFormFromFile(0x0103E7BE,"AmazingFollowerTweaks.esp") as Armor
	if (Nick.GetItemCount(TweakNickMedium) > 0)
		Nick.RemoveItem(TweakNickMedium, 999 , true)
	endIf
	Armor TweakNickArmorMinutemanHat= Game.GetFormFromFile(0x0103E7C3,"AmazingFollowerTweaks.esp") as Armor
	if (Nick.GetItemCount(TweakNickArmorMinutemanHat) > 0)
		Nick.RemoveItem(TweakNickArmorMinutemanHat, 999 , true)
	endIf
	Armor TweakNickSilverArmor		= Game.GetFormFromFile(0x0103E7C9,"AmazingFollowerTweaks.esp") as Armor
	if (Nick.GetItemCount(TweakNickSilverArmor) > 0)
		Nick.RemoveItem(TweakNickSilverArmor, 999 , true)
	endIf
	Armor TweakNickSilverShroudHat	= Game.GetFormFromFile(0x0103E7CA,"AmazingFollowerTweaks.esp") as Armor
	if (Nick.GetItemCount(TweakNickSilverShroudHat) > 0)
		Nick.RemoveItem(TweakNickSilverShroudHat, 999 , true)
	endIf
	Armor TweakNickClothesTuxedo	= Game.GetFormFromFile(0x0103E7CC,"AmazingFollowerTweaks.esp") as Armor
	if (Nick.GetItemCount(TweakNickClothesTuxedo) > 0)
		Nick.RemoveItem(TweakNickClothesTuxedo, 999 , true)
	endIf
	Armor TweakNickArmorVault111	= Game.GetFormFromFile(0x0103E7CE,"AmazingFollowerTweaks.esp") as Armor
	if (Nick.GetItemCount(TweakNickArmorVault111) > 0)
		Nick.RemoveItem(TweakNickArmorVault111, 999 , true)
	endIf
	Armor TweakNickSunGlasses	    = Game.GetFormFromFile(0x0103E7D0,"AmazingFollowerTweaks.esp") as Armor
	if (Nick.GetItemCount(TweakNickSunGlasses) > 0)
		Nick.RemoveItem(TweakNickSunGlasses, 999 , true)
	endIf
	Armor TweakNickValentineCoat	= Game.GetFormFromFile(0x0103E7D1,"AmazingFollowerTweaks.esp") as Armor
	if (Nick.GetItemCount(TweakNickValentineCoat) > 0)
		Nick.RemoveItem(TweakNickValentineCoat, 999 , true)
	endIf
	Armor TweakNickValentineHat		= Game.GetFormFromFile(0x0103E7D2,"AmazingFollowerTweaks.esp") as Armor
	if (0 == Nick.GetItemCount(TweakNickValentineHat))
		Nick.RemoveItem(TweakNickValentineHat, 999 , true)
	endIf
EndFunction

Function AddDeaconItems()
	ActorBase DeaconBase = Game.GetForm(0x00045AC9) as ActorBase
	Actor Deacon = DeaconBase.GetUniqueActor()
	
	bool hadsomething = false
	
	; ClothesDeaconWig
	Armor ClothesDeaconWig = Game.GetForm(0x0004A521) as Armor
	Armor TweakClothesDeaconWig = Game.GetFormFromFile(0x01003669,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(ClothesDeaconWig))
		Deacon.RemoveItem(ClothesDeaconWig)
	endif	
	if (0 == Deacon.GetItemCount(TweakClothesDeaconWig))
		Deacon.AddItem(TweakClothesDeaconWig)
	else
		hadsomething = true
	endIf
	
	; ClothesDeaconSunGlasses
	Armor ClothesDeaconSunGlasses = Game.GetForm(0x0004A520) as Armor
	Armor TweakClothesDeaconSunGlasses = Game.GetFormFromFile(0x0100366A,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(ClothesDeaconSunGlasses))
		Deacon.RemoveItem(ClothesDeaconSunGlasses)
	endif	
	if (0 == Deacon.GetItemCount(TweakClothesDeaconSunGlasses))
		Deacon.AddItem(TweakClothesDeaconSunGlasses)
	else
		hadsomething = true
	endIf
	
	; ClothesDeaconScientist
	Armor ClothesDeaconScientist = Game.GetForm(0x00237677) as Armor
	Armor TweakClothesDeaconScientist = Game.GetFormFromFile(0x0100366B,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(ClothesDeaconScientist))
		Deacon.RemoveItem(ClothesDeaconScientist)
	endif	
	if (0 == Deacon.GetItemCount(TweakClothesDeaconScientist))
		Deacon.AddItem(TweakClothesDeaconScientist)
	else
		hadsomething = true
	endIf

	; ClothesDeaconResident7Hat
	Armor ClothesDeaconResident7Hat = Game.GetForm(0x00237683) as Armor
	Armor TweakClothesDeaconResident7Hat = Game.GetFormFromFile(0x0100366C,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(ClothesDeaconResident7Hat))
		Deacon.RemoveItem(ClothesDeaconResident7Hat)
	endif	
	if (0 == Deacon.GetItemCount(TweakClothesDeaconResident7Hat))
		Deacon.AddItem(TweakClothesDeaconResident7Hat)
	else
		hadsomething = true
	endIf
	
	; ClothesDeaconResident7
	Armor ClothesDeaconResident7 = Game.GetForm(0x00237682) as Armor
	Armor TweakClothesDeaconResident7 = Game.GetFormFromFile(0x0100366D,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(ClothesDeaconResident7))
		Deacon.RemoveItem(ClothesDeaconResident7)
	endif	
	if (0 == Deacon.GetItemCount(TweakClothesDeaconResident7))
		Deacon.AddItem(TweakClothesDeaconResident7)
	else
		hadsomething = true
	endIf

	; ClothesDeaconResident3
	Armor ClothesDeaconResident3 = Game.GetForm(0x00237685) as Armor
	Armor TweakClothesDeaconResident3 = Game.GetFormFromFile(0x0100366E,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(ClothesDeaconResident3))
		Deacon.RemoveItem(ClothesDeaconResident3)
	endif	
	if (0 == Deacon.GetItemCount(TweakClothesDeaconResident3))
		Deacon.AddItem(TweakClothesDeaconResident3)
	else
		hadsomething = true
	endIf

	; ClothesDeaconPrewarShortSleeves
	Armor ClothesDeaconPrewarShortSleeves = Game.GetForm(0x0004A51F) as Armor
	Armor TweakClothesDeaconPrewarShortSleeves = Game.GetFormFromFile(0x0100366F,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(ClothesDeaconPrewarShortSleeves))
		Deacon.RemoveItem(ClothesDeaconPrewarShortSleeves)
	endif	
	if (0 == Deacon.GetItemCount(TweakClothesDeaconPrewarShortSleeves))
		Deacon.AddItem(TweakClothesDeaconPrewarShortSleeves)
	else
		hadsomething = true
	endIf

	; ClothesDeaconMobster
	Armor ClothesDeaconMobster = Game.GetForm(0x00237679) as Armor
	Armor TweakClothesDeaconMobster = Game.GetFormFromFile(0x01003670,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(ClothesDeaconMobster))
		Deacon.RemoveItem(ClothesDeaconMobster)
	endif	
	if (0 == Deacon.GetItemCount(TweakClothesDeaconMobster))
		Deacon.AddItem(TweakClothesDeaconMobster)
	else
		hadsomething = true
	endIf

	; ClothesDeaconMobsterHat
	Armor ClothesDeaconMobsterHat = Game.GetForm(0x0023767A) as Armor
	Armor TweakClothesDeaconMobsterHat = Game.GetFormFromFile(0x01003671,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(ClothesDeaconMobsterHat))
		Deacon.RemoveItem(ClothesDeaconMobsterHat)
	endif	
	if (0 == Deacon.GetItemCount(TweakClothesDeaconMobsterHat))
		Deacon.AddItem(TweakClothesDeaconMobsterHat)
	else
		hadsomething = true
	endIf

	; ClothesDeaconMinutemanOutfit
	Armor ClothesDeaconMinutemanOutfit = Game.GetForm(0x00237680) as Armor
	Armor TweakClothesDeaconMinutemanOutfit = Game.GetFormFromFile(0x01003672,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(ClothesDeaconMinutemanOutfit))
		Deacon.RemoveItem(ClothesDeaconMinutemanOutfit)
	endif	
	if (0 == Deacon.GetItemCount(TweakClothesDeaconMinutemanOutfit))
		Deacon.AddItem(TweakClothesDeaconMinutemanOutfit)
	else
		hadsomething = true
	endIf

	; ClothesDeaconMinutemanHat
	Armor ClothesDeaconMinutemanHat = Game.GetForm(0x0023767F) as Armor
	Armor TweakClothesDeaconMinutemanHat = Game.GetFormFromFile(0x01003673,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(ClothesDeaconMinutemanHat))
		Deacon.RemoveItem(ClothesDeaconMinutemanHat)
	endif	
	if (0 == Deacon.GetItemCount(TweakClothesDeaconMinutemanHat))
		Deacon.AddItem(TweakClothesDeaconMinutemanHat)
	else
		hadsomething = true
	endIf

	; ClothesDeaconMechanic
	Armor ClothesDeaconMechanic = Game.GetForm(0x00237686) as Armor
	Armor TweakClothesDeaconMechanic = Game.GetFormFromFile(0x01003674,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(ClothesDeaconMechanic))
		Deacon.RemoveItem(ClothesDeaconMechanic)
	endif	
	if (0 == Deacon.GetItemCount(TweakClothesDeaconMechanic))
		Deacon.AddItem(TweakClothesDeaconMechanic)
	else
		hadsomething = true
	endIf
	
	; Armor_DeaconVault81_Underwear
	Armor Armor_DeaconVault81_Underwear = Game.GetForm(0x00237678) as Armor
	Armor TweakArmor_DeaconVault81_Underwear = Game.GetFormFromFile(0x01003675,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(Armor_DeaconVault81_Underwear))
		Deacon.RemoveItem(Armor_DeaconVault81_Underwear)
	endif	
	if (0 == Deacon.GetItemCount(TweakArmor_DeaconVault81_Underwear))
		Deacon.AddItem(TweakArmor_DeaconVault81_Underwear)
	else
		hadsomething = true
	endIf

	; Armor_DeaconRustic_Underarmor
	Armor Armor_DeaconRustic_Underarmor = Game.GetForm(0x00237684) as Armor
	Armor TweakArmor_DeaconRustic_Underarmor = Game.GetFormFromFile(0x01003676,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(Armor_DeaconRustic_Underarmor))
		Deacon.RemoveItem(Armor_DeaconRustic_Underarmor)
	endif	
	if (0 == Deacon.GetItemCount(TweakArmor_DeaconRustic_Underarmor))
		Deacon.AddItem(TweakArmor_DeaconRustic_Underarmor)
	else
		hadsomething = true
	endIf

	; Armor_DeaconRaider_Underarmor
	Armor Armor_DeaconRaider_Underarmor = Game.GetForm(0x00237687) as Armor
	Armor TweakArmor_DeaconRaider_Underarmor = Game.GetFormFromFile(0x01003677,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(Armor_DeaconRaider_Underarmor))
		Deacon.RemoveItem(Armor_DeaconRaider_Underarmor)
	endif	
	if (0 == Deacon.GetItemCount(TweakArmor_DeaconRaider_Underarmor))
		Deacon.AddItem(TweakArmor_DeaconRaider_Underarmor)
	else
		hadsomething = true
	endIf	

	; Armor_DeaconLeather_LegRight
	Armor Armor_DeaconLeather_LegRight = Game.GetForm(0x00237688) as Armor
	Armor TweakArmor_DeaconLeather_LegRight = Game.GetFormFromFile(0x01003678,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(Armor_DeaconLeather_LegRight))
		Deacon.RemoveItem(Armor_DeaconLeather_LegRight)
	endif	
	if (0 == Deacon.GetItemCount(TweakArmor_DeaconLeather_LegRight))
		Deacon.AddItem(TweakArmor_DeaconLeather_LegRight)
	else
		hadsomething = true
	endIf	
	
	; Armor_DeaconHighschool_UnderArmor
	Armor Armor_DeaconHighschool_UnderArmor = Game.GetForm(0x00237681) as Armor
	Armor TweakArmor_DeaconHighschool_UnderArmor = Game.GetFormFromFile(0x01003679,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(Armor_DeaconHighschool_UnderArmor))
		Deacon.RemoveItem(Armor_DeaconHighschool_UnderArmor)
	endif	
	if (0 == Deacon.GetItemCount(TweakArmor_DeaconHighschool_UnderArmor))
		Deacon.AddItem(TweakArmor_DeaconHighschool_UnderArmor)
	else
		hadsomething = true
	endIf	

	; Armor_DeaconDCGuard_UnderArmor
	Armor Armor_DeaconDCGuard_UnderArmor = Game.GetForm(0x0023767E) as Armor
	Armor TweakArmor_DeaconDCGuard_UnderArmor = Game.GetFormFromFile(0x0100367A,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(Armor_DeaconDCGuard_UnderArmor))
		Deacon.RemoveItem(Armor_DeaconDCGuard_UnderArmor)
	endif	
	if (0 == Deacon.GetItemCount(TweakArmor_DeaconDCGuard_UnderArmor))
		Deacon.AddItem(TweakArmor_DeaconDCGuard_UnderArmor)
	else
		hadsomething = true
	endIf	

	; Armor_DeaconDCGuard_TorsoArmor
	Armor Armor_DeaconDCGuard_TorsoArmor = Game.GetForm(0x0023767D) as Armor
	Armor TweakArmor_DeaconDCGuard_TorsoArmor = Game.GetFormFromFile(0x0100367B,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(Armor_DeaconDCGuard_TorsoArmor))
		Deacon.RemoveItem(Armor_DeaconDCGuard_TorsoArmor)
	endif	
	if (0 == Deacon.GetItemCount(TweakArmor_DeaconDCGuard_TorsoArmor))
		Deacon.AddItem(TweakArmor_DeaconDCGuard_TorsoArmor)
	else
		hadsomething = true
	endIf	

	; Armor_DeaconDCGuard_RArm
	Armor Armor_DeaconDCGuard_RArm = Game.GetForm(0x0023767C) as Armor
	Armor TweakArmor_DeaconDCGuard_RArm = Game.GetFormFromFile(0x0100367C,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(Armor_DeaconDCGuard_RArm))
		Deacon.RemoveItem(Armor_DeaconDCGuard_RArm)
	endif	
	if (0 == Deacon.GetItemCount(TweakArmor_DeaconDCGuard_RArm))
		Deacon.AddItem(TweakArmor_DeaconDCGuard_RArm)
	else
		hadsomething = true
	endIf	

	; Armor_DeaconDCGuard_LArm
	Armor Armor_DeaconDCGuard_LArm = Game.GetForm(0x0023767B) as Armor
	Armor TweakArmor_DeaconDCGuard_LArm = Game.GetFormFromFile(0x0100367D,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(Armor_DeaconDCGuard_LArm))
		Deacon.RemoveItem(Armor_DeaconDCGuard_LArm)
	endif	
	if (0 == Deacon.GetItemCount(TweakArmor_DeaconDCGuard_LArm))
		Deacon.AddItem(TweakArmor_DeaconDCGuard_LArm)
	else
		hadsomething = true
	endIf	
	if (!hadsomething)
		Deacon.EquipItem(TweakArmor_DeaconHighschool_UnderArmor)
		Deacon.EquipItem(TweakArmor_DeaconLeather_LegRight)
		Deacon.EquipItem(TweakArmor_DeaconDCGuard_RArm)
		Deacon.EquipItem(TweakArmor_DeaconDCGuard_LArm)
		Deacon.EquipItem(TweakClothesDeaconSunGlasses)
		Deacon.EquipItem(TweakClothesDeaconWig)		
	endif
EndFunction

Function RemoveDeaconItems()
	ActorBase DeaconBase = Game.GetForm(0x00045AC9) as ActorBase
	Actor Deacon = DeaconBase.GetUniqueActor()
	
	bool hadsomething = false
	
	; ClothesDeaconWig
	Armor ClothesDeaconWig = Game.GetForm(0x0004A521) as Armor
	Armor TweakClothesDeaconWig = Game.GetFormFromFile(0x01003669,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakClothesDeaconWig))
		Deacon.RemoveItem(TweakClothesDeaconWig)
	endif	
	if (0 == Deacon.GetItemCount(ClothesDeaconWig))
		Deacon.AddItem(ClothesDeaconWig)
	else
		hadsomething = true
	endIf
	
	; ClothesDeaconSunGlasses
	Armor ClothesDeaconSunGlasses = Game.GetForm(0x0004A520) as Armor
	Armor TweakClothesDeaconSunGlasses = Game.GetFormFromFile(0x0100366A,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakClothesDeaconSunGlasses))
		Deacon.RemoveItem(TweakClothesDeaconSunGlasses)
	endif	
	if (0 == Deacon.GetItemCount(ClothesDeaconSunGlasses))
		Deacon.AddItem(ClothesDeaconSunGlasses)
	else
		hadsomething = true
	endIf
	
	; ClothesDeaconScientist
	Armor ClothesDeaconScientist = Game.GetForm(0x00237677) as Armor
	Armor TweakClothesDeaconScientist = Game.GetFormFromFile(0x0100366B,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakClothesDeaconScientist))
		Deacon.RemoveItem(TweakClothesDeaconScientist)
	endif	
	if (0 == Deacon.GetItemCount(ClothesDeaconScientist))
		Deacon.AddItem(ClothesDeaconScientist)
	else
		hadsomething = true
	endIf

	; ClothesDeaconResident7Hat
	Armor ClothesDeaconResident7Hat = Game.GetForm(0x00237683) as Armor
	Armor TweakClothesDeaconResident7Hat = Game.GetFormFromFile(0x0100366C,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakClothesDeaconResident7Hat))
		Deacon.RemoveItem(TweakClothesDeaconResident7Hat)
	endif	
	if (0 == Deacon.GetItemCount(ClothesDeaconResident7Hat))
		Deacon.AddItem(ClothesDeaconResident7Hat)
	else
		hadsomething = true
	endIf
	
	; ClothesDeaconResident7
	Armor ClothesDeaconResident7 = Game.GetForm(0x00237682) as Armor
	Armor TweakClothesDeaconResident7 = Game.GetFormFromFile(0x0100366D,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakClothesDeaconResident7))
		Deacon.RemoveItem(TweakClothesDeaconResident7)
	endif	
	if (0 == Deacon.GetItemCount(ClothesDeaconResident7))
		Deacon.AddItem(ClothesDeaconResident7)
	else
		hadsomething = true
	endIf

	; ClothesDeaconResident3
	Armor ClothesDeaconResident3 = Game.GetForm(0x00237685) as Armor
	Armor TweakClothesDeaconResident3 = Game.GetFormFromFile(0x0100366E,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakClothesDeaconResident3))
		Deacon.RemoveItem(TweakClothesDeaconResident3)
	endif	
	if (0 == Deacon.GetItemCount(ClothesDeaconResident3))
		Deacon.AddItem(ClothesDeaconResident3)
	else
		hadsomething = true
	endIf

	; ClothesDeaconPrewarShortSleeves
	Armor ClothesDeaconPrewarShortSleeves = Game.GetForm(0x0004A51F) as Armor
	Armor TweakClothesDeaconPrewarShortSleeves = Game.GetFormFromFile(0x0100366F,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakClothesDeaconPrewarShortSleeves))
		Deacon.RemoveItem(TweakClothesDeaconPrewarShortSleeves)
	endif	
	if (0 == Deacon.GetItemCount(ClothesDeaconPrewarShortSleeves))
		Deacon.AddItem(ClothesDeaconPrewarShortSleeves)
	else
		hadsomething = true
	endIf

	; ClothesDeaconMobster
	Armor ClothesDeaconMobster = Game.GetForm(0x00237679) as Armor
	Armor TweakClothesDeaconMobster = Game.GetFormFromFile(0x01003670,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakClothesDeaconMobster))
		Deacon.RemoveItem(TweakClothesDeaconMobster)
	endif	
	if (0 == Deacon.GetItemCount(ClothesDeaconMobster))
		Deacon.AddItem(ClothesDeaconMobster)
	else
		hadsomething = true
	endIf

	; ClothesDeaconMobsterHat
	Armor ClothesDeaconMobsterHat = Game.GetForm(0x0023767A) as Armor
	Armor TweakClothesDeaconMobsterHat = Game.GetFormFromFile(0x01003671,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakClothesDeaconMobsterHat))
		Deacon.RemoveItem(TweakClothesDeaconMobsterHat)
	endif	
	if (0 == Deacon.GetItemCount(ClothesDeaconMobsterHat))
		Deacon.AddItem(ClothesDeaconMobsterHat)
	else
		hadsomething = true
	endIf

	; ClothesDeaconMinutemanOutfit
	Armor ClothesDeaconMinutemanOutfit = Game.GetForm(0x00237680) as Armor
	Armor TweakClothesDeaconMinutemanOutfit = Game.GetFormFromFile(0x01003672,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakClothesDeaconMinutemanOutfit))
		Deacon.RemoveItem(TweakClothesDeaconMinutemanOutfit)
	endif	
	if (0 == Deacon.GetItemCount(ClothesDeaconMinutemanOutfit))
		Deacon.AddItem(ClothesDeaconMinutemanOutfit)
	else
		hadsomething = true
	endIf

	; ClothesDeaconMinutemanHat
	Armor ClothesDeaconMinutemanHat = Game.GetForm(0x0023767F) as Armor
	Armor TweakClothesDeaconMinutemanHat = Game.GetFormFromFile(0x01003673,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakClothesDeaconMinutemanHat))
		Deacon.RemoveItem(TweakClothesDeaconMinutemanHat)
	endif	
	if (0 == Deacon.GetItemCount(ClothesDeaconMinutemanHat))
		Deacon.AddItem(ClothesDeaconMinutemanHat)
	else
		hadsomething = true
	endIf

	; ClothesDeaconMechanic
	Armor ClothesDeaconMechanic = Game.GetForm(0x00237686) as Armor
	Armor TweakClothesDeaconMechanic = Game.GetFormFromFile(0x01003674,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakClothesDeaconMechanic))
		Deacon.RemoveItem(TweakClothesDeaconMechanic)
	endif	
	if (0 == Deacon.GetItemCount(ClothesDeaconMechanic))
		Deacon.AddItem(ClothesDeaconMechanic)
	else
		hadsomething = true
	endIf
	
	; Armor_DeaconVault81_Underwear
	Armor Armor_DeaconVault81_Underwear = Game.GetForm(0x00237678) as Armor
	Armor TweakArmor_DeaconVault81_Underwear = Game.GetFormFromFile(0x01003675,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakArmor_DeaconVault81_Underwear))
		Deacon.RemoveItem(TweakArmor_DeaconVault81_Underwear)
	endif	
	if (0 == Deacon.GetItemCount(Armor_DeaconVault81_Underwear))
		Deacon.AddItem(Armor_DeaconVault81_Underwear)
	else
		hadsomething = true
	endIf

	; Armor_DeaconRustic_Underarmor
	Armor Armor_DeaconRustic_Underarmor = Game.GetForm(0x00237684) as Armor
	Armor TweakArmor_DeaconRustic_Underarmor = Game.GetFormFromFile(0x01003676,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakArmor_DeaconRustic_Underarmor))
		Deacon.RemoveItem(TweakArmor_DeaconRustic_Underarmor)
	endif	
	if (0 == Deacon.GetItemCount(Armor_DeaconRustic_Underarmor))
		Deacon.AddItem(Armor_DeaconRustic_Underarmor)
	else
		hadsomething = true
	endIf

	; Armor_DeaconRaider_Underarmor
	Armor Armor_DeaconRaider_Underarmor = Game.GetForm(0x00237687) as Armor
	Armor TweakArmor_DeaconRaider_Underarmor = Game.GetFormFromFile(0x01003677,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakArmor_DeaconRaider_Underarmor))
		Deacon.RemoveItem(TweakArmor_DeaconRaider_Underarmor)
	endif	
	if (0 == Deacon.GetItemCount(Armor_DeaconRaider_Underarmor))
		Deacon.AddItem(Armor_DeaconRaider_Underarmor)
	else
		hadsomething = true
	endIf	

	; Armor_DeaconLeather_LegRight
	Armor Armor_DeaconLeather_LegRight = Game.GetForm(0x00237688) as Armor
	Armor TweakArmor_DeaconLeather_LegRight = Game.GetFormFromFile(0x01003678,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakArmor_DeaconLeather_LegRight))
		Deacon.RemoveItem(TweakArmor_DeaconLeather_LegRight)
	endif	
	if (0 == Deacon.GetItemCount(Armor_DeaconLeather_LegRight))
		Deacon.AddItem(Armor_DeaconLeather_LegRight)
	else
		hadsomething = true
	endIf	
	
	; Armor_DeaconHighschool_UnderArmor
	Armor Armor_DeaconHighschool_UnderArmor = Game.GetForm(0x00237681) as Armor
	Armor TweakArmor_DeaconHighschool_UnderArmor = Game.GetFormFromFile(0x01003679,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakArmor_DeaconHighschool_UnderArmor))
		Deacon.RemoveItem(TweakArmor_DeaconHighschool_UnderArmor)
	endif	
	if (0 == Deacon.GetItemCount(Armor_DeaconHighschool_UnderArmor))
		Deacon.AddItem(Armor_DeaconHighschool_UnderArmor)
	else
		hadsomething = true
	endIf	

	; Armor_DeaconDCGuard_UnderArmor
	Armor Armor_DeaconDCGuard_UnderArmor = Game.GetForm(0x0023767E) as Armor
	Armor TweakArmor_DeaconDCGuard_UnderArmor = Game.GetFormFromFile(0x0100367A,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakArmor_DeaconDCGuard_UnderArmor))
		Deacon.RemoveItem(TweakArmor_DeaconDCGuard_UnderArmor)
	endif	
	if (0 == Deacon.GetItemCount(Armor_DeaconDCGuard_UnderArmor))
		Deacon.AddItem(Armor_DeaconDCGuard_UnderArmor)
	else
		hadsomething = true
	endIf	

	; Armor_DeaconDCGuard_TorsoArmor
	Armor Armor_DeaconDCGuard_TorsoArmor = Game.GetForm(0x0023767D) as Armor
	Armor TweakArmor_DeaconDCGuard_TorsoArmor = Game.GetFormFromFile(0x0100367B,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakArmor_DeaconDCGuard_TorsoArmor))
		Deacon.RemoveItem(TweakArmor_DeaconDCGuard_TorsoArmor)
	endif	
	if (0 == Deacon.GetItemCount(Armor_DeaconDCGuard_TorsoArmor))
		Deacon.AddItem(Armor_DeaconDCGuard_TorsoArmor)
	else
		hadsomething = true
	endIf	

	; Armor_DeaconDCGuard_RArm
	Armor Armor_DeaconDCGuard_RArm = Game.GetForm(0x0023767C) as Armor
	Armor TweakArmor_DeaconDCGuard_RArm = Game.GetFormFromFile(0x0100367C,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakArmor_DeaconDCGuard_RArm))
		Deacon.RemoveItem(TweakArmor_DeaconDCGuard_RArm)
	endif	
	if (0 == Deacon.GetItemCount(Armor_DeaconDCGuard_RArm))
		Deacon.AddItem(Armor_DeaconDCGuard_RArm)
	else
		hadsomething = true
	endIf	

	; Armor_DeaconDCGuard_LArm
	Armor Armor_DeaconDCGuard_LArm = Game.GetForm(0x0023767B) as Armor
	Armor TweakArmor_DeaconDCGuard_LArm = Game.GetFormFromFile(0x0100367D,"AmazingFollowerTweaks.esp") as Armor
	if (0 != Deacon.GetItemCount(TweakArmor_DeaconDCGuard_LArm))
		Deacon.RemoveItem(TweakArmor_DeaconDCGuard_LArm)
	endif	
	if (0 == Deacon.GetItemCount(Armor_DeaconDCGuard_LArm))
		Deacon.AddItem(Armor_DeaconDCGuard_LArm)
	else
		hadsomething = true
	endIf	
	if (!hadsomething)
		Deacon.EquipItem(Armor_DeaconHighschool_UnderArmor)
		Deacon.EquipItem(Armor_DeaconLeather_LegRight)
		Deacon.EquipItem(Armor_DeaconDCGuard_RArm)
		Deacon.EquipItem(Armor_DeaconDCGuard_LArm)
		Deacon.EquipItem(ClothesDeaconSunGlasses)
		Deacon.EquipItem(ClothesDeaconWig)		
	endif
EndFunction

Actor Function GetManagedByNameId(int id)
	if (id < 1)
		return None 
	endif
	
	ReferenceAlias r = None
	Actor f = None
	
	int pManagedMapLength = pManagedMap.Length
	int i            = 1		
	Trace("Searching [" + pManagedMapLength + "] aliases for ID [" + id + "]")
	while (i < pManagedMapLength)
		r = pManagedMap[i]
		f = r.GetActorRef()
		if (f && (id == f.GetFactionRank(pTweakNamesFaction)))
			return f
		EndIf
		i += 1
	EndWhile
	return None
EndFunction

Function ClearSettlement()
	Trace("ClearSettlement() Called")
	WorkshopParentScript WorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
	if !WorkshopParent
		pTweakNoWorkshopParentMsg.Show()
		return
	endif
	Actor pc = Game.GetPlayer()
	; Get Current Workshop
	WorkshopScript WorkshopRef = WorkshopParent.GetWorkshopFromLocation(pc.GetCurrentLocation())
	if !WorkshopRef
		pTweakNoWorkshopParentMsg.Show()
		return
	endif
	if (WorkshopRef.OwnedByPlayer)	
		AFT:TweakScrapScanScript pScanner =  (pTweakScrapScanMaster as AFT:TweakScrapScanScript)
		if (pScanner)
			pScanner.Scan(WorkshopRef)
		endif
	else
		pWorkshopUnownedMessage.Show()
	endif
EndFunction

Function SettlementSnapshot(int stype = 0)
	Trace("SettlementSnapshot() Called")
	AFT:TweakScrapScanScript pScanner =  (pTweakScrapScanMaster as AFT:TweakScrapScanScript)
	if (pScanner)
		pScanner.Scan(Game.GetPlayer(), true, stype)
	endif
EndFunction

; Called from TweakNamesScript
bool[] Function GetUsedGenericNameSlots()
	Trace("GetUsedGenericNameSlots() Called")
	bool[] ret = new bool[MAX_MANAGED]
	int r = 0
	while (r < MAX_MANAGED)
		ret[r] = false
		r += 1
	endwhile

	Actor npc             = None
	int pManagedMapLength = pManagedMap.Length
	int i                 = 1
	int id                = 0
	
	Trace("Building boolean array from [" + pManagedMapLength + "] aliases")
	while (i < pManagedMapLength)
		npc = pManagedMap[i].GetActorRef()
		if (npc)
			id = npc.GetFactionRank(pTweakNamesFaction)
			if (id > 18 && id < 51)
				ret[(id - 19)] = true
			endif
		endif
		i += 1
	EndWhile
	return ret
EndFunction

Function CurrentFollowerTogglesOn()	
	Trace("CurrentFollowerTogglesOn")
	AllTogglesOff()
	
	Actor npc
	int pFollowerMapLength = pFollowerMap.length
	int i  = 0
	int id = 0
		
	Trace("Processing [" + pFollowerMapLength + "] aliases")
	while (i < pFollowerMapLength)
		npc = pFollowerMap[i].GetActorRef()
		if (npc)
			id = npc.GetFactionRank(pTweakNamesFaction)
			if (id > 0)
				pToggles[id].SetValue(1.0)
			else
				Trace("Detected NPC with ID 0. Ignoring")
			endif			
		endif
		i += 1
	endWhile
EndFunction

Function CurrentManagedTogglesOn()	
	Trace("CurrentManagedTogglesOn() Called")	
	AllTogglesOff()
	
	Actor npc             = None
	int pManagedMapLength = pManagedMap.Length
	int i                 = 1
    int id                = 0
	
	Trace("Processing [" + pManagedMapLength + "] aliases")
	while (i < pManagedMapLength)
		npc = pManagedMap[i].GetActorRef()
		if (npc)
			id = npc.GetFactionRank(pTweakNamesFaction)
			if (id > 0)
				pToggles[id].SetValue(1.0)
			else
				Trace("Detected NPC with ID 0. Ignoring")
			endif
		endif
		i += 1
	EndWhile	
endFunction

Function AvailableCustomNameTogglesOn()

    ; First entry is Unknown (index 0)
	; Next 18 (index 1 - 18) are common + reserved names.  
	; Next 32 (index 19 -> 50) are generics (follower 1, follower 2, etc...)
	; Beyond that (index 51 and up) are custom names.
	
	Trace("AvailableCustomNameTogglesOn()")	
	int FirstCustom = 51 ; 50 = Follower32, 51 = Addison
	
	int size = pToggles.Length
	int i = 0
	Trace("Flipping [" + FirstCustom + "] toggles off")
	while (i < FirstCustom)
		pToggles[i].SetValue(0.0)
		i += 1
	endWhile
	
	if (size <= FirstCustom)
		Trace("TweakToggles size <= [" +  FirstCustom + "] Aborting...")
		return
	endIf

	i = FirstCustom
	while i < size
		pToggles[i].SetValue(1.0)
		i += 1
	endWhile

	int maxnumcustom = (size - FirstCustom) ; should be 60...
	
	Actor npc             = None
	int pManagedMapLength = pManagedMap.Length ; 32
	i                     = 1
    int id                = 0
	
	Trace("Processing [" + pManagedMapLength + "] aliases")
	while (i < pManagedMapLength)
		npc = pManagedMap[i].GetActorRef()
		if (npc)
			id = npc.GetFactionRank(pTweakNamesFaction)
			if (id >= FirstCustom)
				pToggles[id].SetValue(0.0)
			endif
		endif
		i += 1
	EndWhile

EndFunction

Function AllTogglesOn()
	Trace("AllTogglesOn() Called")
	int size = pToggles.Length	
	if (size > 0)
		int i = 0
		Trace("Updating [" + size + "] toggles")
		while (i < size)
			pToggles[i].SetValue(1.0)
			i += 1
		endWhile
	endIf
EndFunction

Function AllTogglesOff()
	Trace("AllTogglesOff() Called")
	int size = pToggles.Length	
	if (size > 0)
		int i = 0
		Trace("Updating [" + size + "] toggles")
		while (i < size)
			pToggles[i].SetValue(0.0)
			i += 1
		endWhile
	endIf
EndFunction

; DEPRECATED:

int[] Function GetCurrentFollowerNameSlots()	
	Trace("GetCurrentFollowerNameSlots")
	; Deprecated
	int [] ret = new int[0]
	return ret
endFunction

bool[] Function GetAvailableCustomNameSlots(int maxnumcustom)
	Trace("GetAvailableCustomNameSlots() Called")
	; Deprecated

	; bool[] ret = new bool[maxnumcustom]
	; int r = 0
	; while (r < maxnumcustom)
		; ret[r] = true
		; r += 1
	; endwhile
	
	; Actor npc             = None
	; int pManagedMapLength = pManagedMap.Length
	; int i                 = 1
    ; int id                = 0
	
	; Trace("Building boolean array from [" + pManagedMapLength + "] aliases")
	; while (i < pManagedMapLength)
		; npc = pManagedMap[i].GetActorRef()
		; if (npc)
			; id = npc.GetFactionRank(pTweakNamesFaction)
			; if (id > 50)
				; ret[(id - 51)] = false
			; endif
		; endif
		; i += 1
	; EndWhile
	; return ret

EndFunction

bool[] Function GetManagedNameSlots(int retlen=111)
	Trace("GetManagedSlots() Called")
	
	; Deprecated

	; bool[] ret = new bool[retlen]	
	; if (retlen < 1)
		; Trace("TweakToggles is empty. Aborting...")
		; return ret
	; endif
	
	; int i = 0
	; while (i < retlen)
		; ret[i] = false
		; i += 1
	; endwhile
	
	; Actor npc             = None
	; int pManagedMapLength = pManagedMap.Length
	; i                      = 1
    ; int id                = 0
	; int maxretindex       = retlen - 10
	
	; Trace("Building boolean array from [" + pManagedMapLength + "] aliases")
	; while (i < pManagedMapLength)
		; npc = pManagedMap[i].GetActorRef()
		; if (npc)
			; id = npc.GetFactionRank(pTweakNamesFaction)
			; if (id > 0)
				; if (id > maxretindex)
					; Trace("ID [" + id + "] larger than TweakToggles formlist. Ignoring...")
				; else
					; ret[id] = true
				; endif
			; endif
		; endif
		; i += 1
	; EndWhile
	; return ret

EndFunction

; Function FlipCurrentFollowerToggles(bool value)
	; Trace("FlipCurrentFollowerToggles (" + value + ")")
	; AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy As AFT:TweakPipBoyScript)
	; if pTweakPipBoyScript
	
		; int i  = 0
		; int id = 0
		; int pFollowerMapLength = pFollowerMap.length
		; Actor npc
		
		; Trace("Searching [" + pFollowerMapLength + "] aliases for toggled")
		; while (i < pFollowerMapLength)
			; npc = pFollowerMap[i].GetActorRef()
			; if (npc)
				; id = npc.GetFactionRank(pTweakNamesFaction)
				; Trace("Flipping Toggle for  (" + id + ")")
				; pTweakPipBoyScript.FlipToggle(id, value)
			; endif
			; i += 1
		; endWhile	
	; endif
; EndFunction

; WeaponDraw Event -> Summon All Follwoers (behind you) - Does not include Waiting
; Speak to NPC -> Get Behind me, should have ID (includes waiting)
; Tools -> Summon All Followers (summons all in front of you. Includes Waiting)
Function MoveToPlayerByNameId(int id, bool excludeWaiting=false, float startingOffset=180.0, bool excludeInCombat=false, float outsideradius = 0.0, float cylinder_height = 0.0)
	Trace("MoveToPlayerByNameId() Called")
	
	if (id > 0)
		ReferenceAlias npcref = NameIdToManagedRef(id)
		if (!npcref)
			Trace("Not Found")
			return
		endif
		MoveToPlayer(npcref.GetActorReference(), excludeWaiting, startingOffset, excludeInCombat, outsideradius, cylinder_height)
	else
		MoveToPlayer(None, excludeWaiting, startingOffset, excludeInCombat, outsideradius, cylinder_height)
		if combatRunningFlag
			if !Game.GetPlayer().IsInCombat()
				combatRunningFlag = false
				RelayCombatEndEvent()
			endif
		endif		
	endIf
	
EndFunction

; For combatStart events, each script is on its own. We dont want to share
; the event incase the followers are spread out. However, we need to share
; the combatEnd event because only the NPC that makes the killing blow gets
; cstat value of 0. TweakSettings is the one script attached to everyone
; That relays the 0 event here. 
;
; There is also a backup timer that begins monitor the player combat state 
; every 15 seconds incase we miss cstate 0 event for some reason. (Person 
; who makes killing blow isn't a managed NPC for example...) 
Function CombatStateChanged(int cstate)
	Trace("CombatStateChanged [" + cstate + "]")
	if (1 == cState)
		if (!combatRunningFlag)
			combatRunningFlag = true
			StartTimer(16,COMBAT_MONITOR)
		else
			Trace("Ignored. combatRunningFlag is already true")
		endif
	elseif (0 == cState)
		if (combatRunningFlag)
			combatRunningFlag = false
			RelayCombatEndEvent()
		else
			Trace("Ignored. combatRunningFlag is already false")
		endif
	endif
EndFunction

Function RelayCombatEndEvent()
	Trace("RelayCombatEndEvent()")

	CancelTimer(COMBAT_MONITOR)
	int i = 0
	int pFollowerMapLength = pFollowerMap.length	
	Actor npc
	while (i < pFollowerMapLength)
		npc = pFollowerMap[i].GetActorRef()
		if (npc)
			int followerId = npc.GetFactionRank(pTweakFollowerFaction) As Int	
			if (followerId > 0)
				ReferenceAlias a = pManagedMap[followerId]
				; We can add more as needed
				(a As TweakSettings).OnCombatEnd()
				(a as TweakInventoryControl).OnCombatEnd()
			endif
		endif
		i += 1
	endWhile
		
EndFunction

Function TeleportToHere(Actor npc)
	int id = npc.GetFactionRank(pTweakFollowerFaction) As Int	
	if (id > 0)
		(pManagedMap[id] as TweakSettings).teleportToHere()
	endif
EndFunction

Function TeleportAway(Actor npc)
	int id = npc.GetFactionRank(pTweakFollowerFaction) As Int	
	if (id > 0)
		(pManagedMap[id] as TweakSettings).teleportAway()
	endif
EndFunction

Function MoveToPlayer(Actor npc, bool excludeWaiting=false, float startingOffset=180.0, bool excludeInCombat=false, float outsideradius = 0.0, float cylinder_height = 0.0, bool TeleportToHere = false)
	Trace("MoveToPlayer() Called")

	AFT:TweakDFScript	pDFScript 		   = None
	Actor			pc   			   = Game.GetPlayer()	
	float			npcPlaceAngle
	float[]			posdata
		
	; The coupling of pDFScript and excludeWaiting is intentional. If either is
	; False/None, we skip the force-follow operation below. By coupling them into 
	; 1 value, we only perform one conditional instead of 2...
	
	if (!excludeWaiting)
		pDFScript = (pFollowers as AFT:TweakDFScript)
		if (!pDFScript)
			Trace("Cast to TweakDFScript Failed")
		endif
	else
		Trace("ExcludeWaiting = True : Followers will not be told to follow")
	endif
	
	Location pLoc = pc.GetCurrentLocation()

	if (!npc && 0.0 == MQWonInst.GetValue() && !pDN136_Attack.GetStageDone(10) && InstituteLocation.isChild(pLoc) )			
		if (!instituteSummonMsgOnce)
			; Based on your rank and standing with the Institute, 
			;only your dog is currently allowed inside
			pTweakInstituteSummon.Show()
			instituteSummonMsgOnce = true
		endif
				
		npc = pDogmeatCompanion.GetActorRef()
		if !npc
			return
		endIf
	endIf
	
	if (npc)
		if (!excludeInCombat || !npc.IsInCombat())
			npcPlaceAngle = startingOffset
			Location fLoc = npc.GetCurrentLocation()
			; Set to Follow (Otherwise AI package may teleport them back...)
			if (pDFScript)
				Trace("Commanding npc [" + npc + "] to Follow")
				pDFScript.FollowerFollow(npc)
			endif
			
			; SetPosition resets the Angles...
			float ax = npc.GetAngleX()
			float ay = npc.GetAngleY()
			
			if (fLoc && pLoc && fLoc.IsSameLocation(pLoc))
				Trace("Changing npc position [" + npc + "]")
				posdata=TraceCircle(pc, 125, npcPlaceAngle)		
				npc.SetPosition(posdata[0],posdata[1],posdata[2])
				if TeleportToHere
					npc.AddSpell(TeleportInSpell)
				endif			
			else
				Trace("Moving npc [" + npc + "]")
				posdata=TraceCircleOffsets(pc, 125, npcPlaceAngle)		
				npc.MoveTo(pc, posdata[0], posdata[1], posdata[2], false)
				if TeleportToHere
					npc.AddSpell(TeleportInSpell)
				endif			
			endif
			npc.SetAngle(ax, ay, npc.GetAngleZ() + npc.GetHeadingAngle(pc))
		else	
			Trace("Ignoring [" + npc + "] : excludeInCombat is true and npc is in combat.")
		endif
		return
	endif
	
	; bool gotlock = GetSpinLock(pTweakMutexCompanions,1, "MoveToPlayer") ; low priority since it is read-only	
	ReferenceAlias[] theList = GetAllTweakFollowers(excludeWaiting, false, outsideradius, cylinder_height)
	; ReleaseSpinLock(pTweakMutexCompanions, gotlock, "MoveToPlayer")
	
	Trace("GetAllTweakFollowers returned [" + theList.length + "]")

	if (theList.length < 1)
		return
	endif
	
	npc = theList[0].GetActorRef()
	Location fLoc	
	
	if (!excludeInCombat || !npc.IsInCombat())	
		npcPlaceAngle = startingOffset
		fLoc = npc.GetCurrentLocation()
		if (pDFScript)
			Trace("Commanding npc [" + npc + "] to Follow")
			pDFScript.FollowerFollow(npc)
		endif	
		if npc.IsInCombat()
			npc.StopCombat()
		endif

		float ax = npc.GetAngleX()
		float ay = npc.GetAngleY()

		if (fLoc && pLoc && fLoc.IsSameLocation(pLoc))
			Trace("Changing npc position [" + npc + "]")
			posdata=TraceCircle(pc, 125, npcPlaceAngle)		
			npc.SetPosition(posdata[0],posdata[1],posdata[2])
			if TeleportToHere
				npc.AddSpell(TeleportInSpell)
			endif			
		else
			Trace("Moving npc [" + npc + "]")
			posdata=TraceCircleOffsets(pc, 125, npcPlaceAngle)		
			npc.MoveTo(pc, posdata[0], posdata[1], posdata[2], false)
			if TeleportToHere
				npc.AddSpell(TeleportInSpell)
			endif			
		endif
		npc.SetAngle(ax,ay, npc.GetAngleZ() + npc.GetHeadingAngle(pc))
	else
		Trace("Ignoring [" + npc + "] : excludeInCombat is true and npc is in combat.")
	endif
	
	int i = 1
	float offset = 22
	int theListLength = theList.length
	
	while (i < theListLength)
		npc = theList[i].GetActorRef()		
		if (!excludeInCombat || !npc.IsInCombat())
			fLoc = npc.GetCurrentLocation()
			npcPlaceAngle = (startingOffset - offset)

			if (pDFScript)
				Trace("Commanding npc [" + npc + "] to Follow")
				pDFScript.FollowerFollow(npc)
			endif
			if npc.IsInCombat()
				npc.StopCombat()
			endif

			float ax = npc.GetAngleX()
			float ay = npc.GetAngleY()
			
			
			if (fLoc && pLoc && fLoc.IsSameLocation(pLoc))
				Trace("Changing npc position [" + npc + "]")
				posdata=TraceCircle(pc, 125, npcPlaceAngle)
				npc.SetPosition(posdata[0],posdata[1],posdata[2])
				if TeleportToHere
					npc.AddSpell(TeleportInSpell)
				endif			
			else
				Trace("Moving npc [" + npc + "]")
				posdata = TraceCircleOffsets(pc, 125, npcPlaceAngle)
				npc.MoveTo(pc, posdata[0], posdata[1], posdata[2], false)
				if TeleportToHere
					npc.AddSpell(TeleportInSpell)
				endif			
			endif
			npc.SetAngle(ax,ay, npc.GetAngleZ() + npc.GetHeadingAngle(pc))
		else
			Trace("Ignoring [" + npc + "] : excludeInCombat is true and npc is visible.")
		endif
		
		i += 1
		if (i < theList.length)
			npc = theList[i].GetActorRef()
			if (!excludeInCombat || !npc.IsInCombat())
				npcPlaceAngle = (offset - startingOffset)
				fLoc = npc.GetCurrentLocation()
				
				if (pDFScript)
					Trace("Commanding npc [" + npc + "] to Follow")
					pDFScript.FollowerFollow(npc)
				endif

				if npc.IsInCombat()
					npc.StopCombat()
				endif
				
				Trace("Moving npc [" + npc + "]")
				float ax = npc.GetAngleX()
				float ay = npc.GetAngleY()
				
				if (fLoc && pLoc && fLoc.IsSameLocation(pLoc))
					posdata=TraceCircle(pc, 125, npcPlaceAngle)		
					npc.SetPosition(posdata[0],posdata[1],posdata[2]) 
					if TeleportToHere
						npc.AddSpell(TeleportInSpell)
					endif			
				else
					posdata = TraceCircleOffsets(pc, 125, npcPlaceAngle)
					npc.MoveTo(pc, posdata[0], posdata[1], posdata[2], false)
					if TeleportToHere
						npc.AddSpell(TeleportInSpell)
					endif			
				endif
				npc.SetAngle(ax,ay, npc.GetAngleZ() + npc.GetHeadingAngle(pc))
			else
				Trace("Ignoring [" + npc + "] : excludeInCombat is true and npc is in combat.")
			endif
			i += 1
		endif
		offset += 22
	endWhile
EndFunction

; Used by TweakShelterScript...
ReferenceAlias[] Function GetAllTweakFollowers(Bool excludeWaiting=False, Bool excludeDog=False, float outsideradius = 0.0, float cylinder_height = 0.0, Bool excludeNonCore=False )
	
	ReferenceAlias[] ret = new ReferenceAlias[0]
	int i = 0
	int pFollowerMapLength = pFollowerMap.length
	Actor npc
	float ComWait = iFollower_Com_Wait.GetValue()
	Actor pc = Game.GetPlayer()
	
	Trace("Gathering Followers from [" + pFollowerMapLength + "] aliases")
	while (i < pFollowerMapLength)
		npc = pFollowerMap[i].GetActorRef()
		if (npc && !npc.IsDead())
			if (!excludeDog || ( pFollowerMap[i] != pDogmeatCompanion))
				if (!excludeNonCore || IsCoreCompanion(npc))
					if (!excludeWaiting || ( npc.GetCurrentPackage() != pCommandMode_Travel && npc.GetValue(pFollowerState) != ComWait))
						if (0 == outsideradius || !DistanceWithinCylinder(pc,npc,outsideradius, cylinder_height))
							int id = npc.GetFactionRank(pTweakFollowerFaction) As Int	
							if (id > 0)
								ret.Add(pManagedMap[id])
							endif
						else
							Trace("[" + i + "] Rejected : Not Outside specified radius [" + outsideradius + "]")
						endif
					else
						Trace("[" + i + "] Rejected : Exclude Waiting is True and Follower is Waiting...")
					endif
				else
					Trace("[" + i + "] Rejected : Exclude Spouse Specified and NPC is Spouse")
				endif
			else
				Trace("[" + i + "] Rejected : Exclude Dog Specified and NPC is Dog")
			endif
		else
			Trace("[" + i + "] Rejected : Slot Empty or NPC is Dead...")
		endif
		i = i + 1
	endWhile
	return ret

endFunction

; AngleOffset:
;  -90     = Players left. 
;   90     = Players right, 
; 180/-180 = behind player
Float[] Function TraceCircle(ObjectReference n, Float radius = 500.0, Float angleOffset = 0.0)	
    float azimuth = ConvertToSinCosCompatibleAngle(n.GetAngleZ(), angleOffset)	
    Float xoffset = radius * Math.cos(azimuth)
    Float yoffset = radius * Math.sin(azimuth)
    Float[] r = new Float[3]
    r[0] =  (n.GetPositionX() + xoffset)
    r[1] =  (n.GetPositionY() + yoffset)
    r[2] =   n.GetPositionZ()
    return r
endFunction

; AngleOffset:
;  -90     = Players left. 
;   90     = Players right, 
; 180/-180 = behind player
Float[] Function TraceCircleOffsets(ObjectReference n, Float radius = 500.0, Float angleOffset = 0.0)
    float azimuth = ConvertToSinCosCompatibleAngle(n.GetAngleZ(), angleOffset)	
    Float[] r = new Float[3]
    r[0] =  radius * Math.cos(azimuth) ; X Offset
    r[1] =  radius * Math.sin(azimuth) ; Y Offset
    r[2] =  0 ; Z Offset
    return r
EndFunction


Float Function ConvertToSinCosCompatibleAngle(Float original, Float angleOffset = 0.0)

	; SIN/COS assume a cartisian coordinate system with Angle 0 pointing horizontally down the positive
	; x axis and the angles proceeding counter-clockwise.  The TES Engine points angle 0 along the Y 
	; axis and rotates clockwise (instead of the expected counter-clockwise).
	;
	;        GameEngine              Required by Sin/Cos 
	; 
	;             N
	;            +y                          +y
    ;             0                          90
    ;             |                           |
	; W -x 270----V----90 +x E     -x 180-----V-----0 +x
	;             |                           |
	;            180                         270
    ;            -y                          -y
    ;             S
	;
	; We can fix the angle value by subtracting the given angle from 90. Note that subtracting
	; from 450 (same thing as 90), decreases the probability of a needed second operation 
	; (to keep the value within 360 ). That is, angleOffset is often 0.0 and there are
	; more degrees above 90 than below it, so higher values are 75% more likely across
	; the input distribution range.
	
	return Enforce360Bounds(450 - original + angleOffset)
	
EndFunction

Float Function Enforce360Bounds(float a)
    if (a < 0) 
        a = a + 360
    endif
    if (a > 360)
        a = a - 360
    endif 
	return a
EndFunction

Function initializeFollowerMap()
	pFollowerMap = new ReferenceAlias[0]
	pFollowerMap.Add(pCompanion1)
	pFollowerMap.Add(pCompanion2)
	pFollowerMap.Add(pCompanion3)
	pFollowerMap.Add(pCompanion4)
	pFollowerMap.Add(pCompanion5)
	pFollowerMap.Add(pDogmeatCompanion)
endFunction

Function initializeManagedMap()
	 
	int max_aliases  = MAX_MANAGED + 1 ; index 0 = player. Actually only 32 followers.
	pManagedMap      = new ReferenceAlias[max_aliases]
	
	Quest selfQuest = (self as Quest)
	if (!selfQuest)
		Trace("AFT Warning: Unable to cast self (TweakFollowerScript) to Quest. initializeManagedMap aborted.")
		return
	endif
	
	int i            = 0
	Trace("Initializing ManagedMap from [" + max_aliases + "] aliases")
	while (i < max_aliases)
		pManagedMap[i] = (selfQuest.GetAlias(i) as ReferenceAlias)
		i += 1
	endwhile

EndFunction

ReferenceAlias Function NameIdToManagedRef(int id = 0)
	Trace("NameIdToManagedRef Called()")
	if (0 == id)
		return None
	endif
	
	int i = 0
	int pMapLength = pFollowerMap.length
	Actor npc
	
	Trace("Attempt 1 : Searching for ReferenceAlias within [" + pMapLength + "] aliases")	
	while (i < pMapLength)
		npc = pFollowerMap[i].GetActorRef()
		if (npc && (id == npc.GetFactionRank(pTweakNamesFaction)))
			Trace("NPC Found in Follower Map at index [" + i + "]")	
			int followerId = npc.GetFactionRank(pTweakFollowerFaction)
			if (followerId < 1)
				Trace("NameIdToManagedRef : FollowerId Lookup Failed. Not Found in TweakFollowerFaction")
				return None
			endif
			return pManagedMap[followerId]
		endif
		i += 1
	endWhile
	
	; Maybe it is not someone following us...
	i = 1
	pMapLength = pManagedMap.length
	Trace("Attempt 2 : Searching for ReferenceAlias within [" + pMapLength + "] aliases")	
	while (i < pMapLength)
		npc = pManagedMap[i].GetActorRef()
		if (npc && (id == npc.GetFactionRank(pTweakNamesFaction)))
			Trace("NPC Found in Managed Map at index [" + i + "]")
			return pManagedMap[i]
		endif
		i += 1
	endWhile
		
	Trace("NameIdToManagedRef : No id matching [" + id + "] in [" + i + "] aliases")											
	return None
EndFunction

Function ImportTopicsForCompanion(Actor npc)
	Trace("ImportTopicsForCompanion [" + npc + "]")											
	if (None == npc)
		return
	endif
	
	int NameID = npc.GetFactionRank(pTweakNamesFaction)
	Trace("NameID [" + NameID + "]")											
	; int ActorBaseID = (npc.GetActorBase().GetFormID() as Int)
	
	; if ActorBaseID == 0x00079249     ; ---=== Cait ===---
	if NameID == 1
		Trace("Setting up AV Topics for Cait")		
		npc.SetValue(pTweakTopicHello,    0x000EF268) ; TopicCheck(0x000EF268, "pTweakTopicHello"))  ; && 0x0007921C "ComCait:Favors:Show"/"ComCait:Misc:COMCaitHello"
		npc.SetValue(pTweakTopicTrade,    0x001012D4) ; TopicCheck(0x001012D4, "pTweakTopicTrade"))  ; "ComCait:Favors:Trade"
		npc.SetValue(pTweakTopicAck,      0x000EF26C) ; TopicCheck(0x000EF26C, "pTweakTopicAck"))    ; "ComCait:Favors:Agree"
		npc.SetValue(pTweakTopicCancel,   0x000EF26B) ; TopicCheck(0x000EF26B, "pTweakTopicCancel")) ; "ComCait:Favors:ExitFavorState"
		npc.SetValue(pTweakTopicDismiss,  0x0002AE64) ; "Followers:PlayerDialogue:FollowersSayCommandGoHome"
		npc.SetValue(pTweakTopicDistFar,  0x0002AE61) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceFar"
		npc.SetValue(pTweakTopicDistMed,  0x0002AE62) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceMedium"
		npc.SetValue(pTweakTopicDistNear, 0x0002AE63) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceNear"
		npc.SetValue(pTweakTopicStyleAgg, 0x0002AE60) ; "Followers:PlayerDialogue:FollowersSayCommandStanceAggressive"
		npc.SetValue(pTweakTopicStyleDef, 0x0002AE5F) ; "Followers:PlayerDialogue:FollowersSayCommandStanceDefensive"
		return		
	endif
	
	; if ActorBaseID == 0x000179FF ; ---=== Codsworth ===---
	if NameID == 2 
	
		Trace("Setting up AV Topics for Codsworth")		
		npc.SetValue(pTweakTopicHello,    0x000F12C8) ; TopicCheck(0x000F12C8, "pTweakTopicHello"))  ; && 0x000F1248 "ComCodsworth:Favors:Show"/"ComCodsworth:Misc:COMCodsworthHellos"
		npc.SetValue(pTweakTopicTrade,    0x0008442C) ; TopicCheck(0x0008442C, "pTweakTopicTrade"))  ; "ComCodsworth:Favors:Trade"
		npc.SetValue(pTweakTopicAck,      0x000F12CD) ; TopicCheck(0x000F12CD, "pTweakTopicAck"))    ; "ComCodsworth:Favors:Agree"
		npc.SetValue(pTweakTopicCancel,   0x000F12CC) ; TopicCheck(0x000F12CC, "pTweakTopicCancel")) ; "ComCodsworth:Favors:ExitFavorState"
		npc.SetValue(pTweakTopicDismiss,  0x0002AE64) ; "Followers:PlayerDialogue:FollowersSayCommandGoHome"
		npc.SetValue(pTweakTopicDistFar,  0x0002AE61) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceFar"
		npc.SetValue(pTweakTopicDistMed,  0x0002AE62) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceMedium"
		npc.SetValue(pTweakTopicDistNear, 0x0002AE63) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceNear"
		npc.SetValue(pTweakTopicStyleAgg, 0x0002AE60) ; "Followers:PlayerDialogue:FollowersSayCommandStanceAggressive"
		npc.SetValue(pTweakTopicStyleDef, 0x0002AE5F) ; "Followers:PlayerDialogue:FollowersSayCommandStanceDefensive"
		return
	endif
	
	; if ActorBaseID == 0x00027686 ; ---=== Curie ===---
	if NameID == 3 
		
		Trace("Setting up AV Topics for Curie")
		Form Hello1 = Game.GetForm(0x0010BA4F) ; "ComCurie:Favors:Show"
		Form Hello2 = Game.GetForm(0x0010BA40) ; "ComCurie:Misc:COMCurieHellos"
		if !pTweakHelloTopicCurie.HasForm(Hello1)
			pTweakHelloTopicCurie.AddForm(Hello1)
		endif
		if !pTweakHelloTopicCurie.HasForm(Hello2)
			pTweakHelloTopicCurie.AddForm(Hello2)
		endif		
		; example 0x01234567 (19088743) % 0x01000000 (16777216) = 0x00234567 (2311527)
		int formid  = pTweakHelloTopicCurie.GetFormID()
		int localid
		
		if formid > 0x80000000
			localid = (formid - 0x80000000) % 0x01000000
		else
			localid = formid % 0x01000000
		endif
		
		; int modid   = formid / 0x01000000
		int modid   = 0x00000100 ; Special Value. Means use AmazingFollowerTweaks.esp
		npc.SetValue(pTweakTopicHello,      localid) 
		npc.SetValue(pTweakTopicHelloModID, modid) 
		
		npc.SetValue(pTweakTopicTrade,    0x00204818) ; TopicCheck(0x00204818, "pTweakTopicTrade")) ; "ComCurie:Favors:Trade"
		npc.SetValue(pTweakTopicAck,      0x0010BA4B) ; TopicCheck(0x0010BA4B, "pTweakTopicAck")) ; "ComCurie:Favors:Agree"
		npc.SetValue(pTweakTopicCancel,   0x0010BA4C) ; TopicCheck(0x0010BA4C, "pTweakTopicCancel")) ; "ComCurie:Favors:ExitFavorState"
		npc.SetValue(pTweakTopicDismiss,  0x0002AE64) ; "Followers:PlayerDialogue:FollowersSayCommandGoHome"
		npc.SetValue(pTweakTopicDistFar,  0x0002AE61) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceFar"
		npc.SetValue(pTweakTopicDistMed,  0x0002AE62) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceMedium"
		npc.SetValue(pTweakTopicDistNear, 0x0002AE63) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceNear"
		npc.SetValue(pTweakTopicStyleAgg, 0x0002AE60) ; "Followers:PlayerDialogue:FollowersSayCommandStanceAggressive"
		npc.SetValue(pTweakTopicStyleDef, 0x0002AE5F) ; "Followers:PlayerDialogue:FollowersSayCommandStanceDefensive"
		return	
	endif
	
	; if ActorBaseID == 0x00027683 ; ---=== Danse ===---
	if NameID == 4 
		
		Trace("Setting up AV Topics for Danse")
		; npc.SetValue(pTweakTopicHello,    0x0010D5F7) ; && 0x0010E271 "ComDanse:Favors:Show"/"ComDanse:Misc:COMDanseHellos"

		Form Hello1 = Game.GetForm(0x0010D5F7) ; "ComDanse:Favors:Show"
		Form Hello2 = Game.GetForm(0x0010BA40) ; "ComDanse:Misc:COMDanseHellos"
		if !pTweakHelloTopicDanse.HasForm(Hello1)
			pTweakHelloTopicDanse.AddForm(Hello1)
		endif
		if !pTweakHelloTopicDanse.HasForm(Hello2)
			pTweakHelloTopicDanse.AddForm(Hello2)
		endif
		int formid  = pTweakHelloTopicDanse.GetFormID()
		int localid
		if formid > 0x80000000
			localid = (formid - 0x80000000) % 0x01000000
		else
			localid = formid % 0x01000000
		endif
		; int modid   = formid / 0x01000000
		int modid   = 0x00000100 ; Special Value. Means use AmazingFollowerTweaks.esp
		npc.SetValue(pTweakTopicHello,      localid) 
		npc.SetValue(pTweakTopicHelloModID, modid) 
		
		npc.SetValue(pTweakTopicTrade,    0x001AC17E) ; "ComDanse:Favors:Trade"
		npc.SetValue(pTweakTopicAck,      0x0010D5FB) ; "ComDanse:Favors:Agree"
		npc.SetValue(pTweakTopicCancel,   0x0010D5FA) ; "ComDanse:Favors:ExitFavorState"
		npc.SetValue(pTweakTopicDismiss,  0x0002AE64) ; "Followers:PlayerDialogue:FollowersSayCommandGoHome"
		npc.SetValue(pTweakTopicDistFar,  0x0002AE61) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceFar"
		npc.SetValue(pTweakTopicDistMed,  0x0002AE62) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceMedium"
		npc.SetValue(pTweakTopicDistNear, 0x0002AE63) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceNear"
		npc.SetValue(pTweakTopicStyleAgg, 0x0002AE60) ; "Followers:PlayerDialogue:FollowersSayCommandStanceAggressive"
		npc.SetValue(pTweakTopicStyleDef, 0x0002AE5F) ; "Followers:PlayerDialogue:FollowersSayCommandStanceDefensive"
		return
	endif
	
	; if ActorBaseID == 0x00045AC9 ; ---=== Deacon ===---
	if NameID == 5 
	
		Trace("Setting up AV Topics for Deacon")
		; npc.SetValue(pTweakTopicHello,    0x000F94A5) ; && 0x000F7600 "ComDeacon:Favors:Show"/"ComDeacon:Misc:Hellos"
		
		Form Hello1 = Game.GetForm(0x000F94A5) ; "ComDeacon:Favors:Show"
		Form Hello2 = Game.GetForm(0x000F7600) ; "ComDeacon:Misc:Hellos"
		if !pTweakHelloTopicDeacon.HasForm(Hello1)
			pTweakHelloTopicDeacon.AddForm(Hello1)
		endif
		if !pTweakHelloTopicDeacon.HasForm(Hello2)
			pTweakHelloTopicDeacon.AddForm(Hello2)
		endif		
		int formid  = pTweakHelloTopicDeacon.GetFormID()
		int localid
		if formid > 0x80000000
			localid = (formid - 0x80000000) % 0x01000000
		else
			localid = formid % 0x01000000
		endif
		; int modid   = formid / 0x01000000
		int modid   = 0x00000100 ; Special Value. Means use AmazingFollowerTweaks.esp
		npc.SetValue(pTweakTopicHello,      localid) 
		npc.SetValue(pTweakTopicHelloModID, modid) 
		
		npc.SetValue(pTweakTopicTrade,    0x00204817) ; "ComDeacon:Favors:Trade"
		npc.SetValue(pTweakTopicAck,      0x000F94A9) ; "ComDeacon:Favors:Agree"
		npc.SetValue(pTweakTopicCancel,   0x000F94A8) ; "ComDeacon:Favors:ExitFavorState"
		npc.SetValue(pTweakTopicDismiss,  0x0002AE64) ; "Followers:PlayerDialogue:FollowersSayCommandGoHome"
		npc.SetValue(pTweakTopicDistFar,  0x0002AE61) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceFar"
		npc.SetValue(pTweakTopicDistMed,  0x0002AE62) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceMedium"
		npc.SetValue(pTweakTopicDistNear, 0x0002AE63) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceNear"
		npc.SetValue(pTweakTopicStyleAgg, 0x0002AE60) ; "Followers:PlayerDialogue:FollowersSayCommandStanceAggressive"
		npc.SetValue(pTweakTopicStyleDef, 0x0002AE5F) ; "Followers:PlayerDialogue:FollowersSayCommandStanceDefensive"
		return	
	endif
	
	; if ActorBaseID == 0x0001D15C ; ---=== Dogmeat ===---
	if NameID == 6 
	
		Trace("Setting up AV Topics for Dogmeat")
		npc.SetValue(pTweakTopicHello,    0x0005134C) ; && 0x002306CA ""CreatureDialogueDogmeat:Favors:Show"/"CreatureDialogueDogmeat:Favors:ExitFavorState"
		npc.SetValue(pTweakTopicTrade,    0x002306C8) ; "CreatureDialogueDogmeat:Favors:Trade"
		npc.SetValue(pTweakTopicAck,      0x0005134C) ; "CreatureDialogueDogmeat:Favors:Agree"
		npc.SetValue(pTweakTopicCancel,   0x002306CA) ; "CreatureDialogueDogmeat:Favors:ExitFavorState"
	  
		npc.SetValue(pTweakTopicDismiss,  0x0002AE64) ; "Followers:PlayerDialogue:FollowersSayCommandGoHome"
		npc.SetValue(pTweakTopicDistFar,  0x002306CA) ; "CreatureDialogueDogmeat:Favors:ExitFavorState"
		npc.SetValue(pTweakTopicDistMed,  0x0005134C) ; "CreatureDialogueDogmeat:Favors:Agree"
		npc.SetValue(pTweakTopicDistNear, 0x0005134C) ; "CreatureDialogueDogmeat:Favors:Agree"
		npc.SetValue(pTweakTopicStyleAgg, 0x0005134C) ; "CreatureDialogueDogmeat:Favors:Agree"
		npc.SetValue(pTweakTopicStyleDef, 0x0005134C) ; "CreatureDialogueDogmeat:Favors:Agree"
		return
	endif
	
	; if ActorBaseID == 0x00022613 ; ---=== Hancock ===---
	if NameID == 7
		  
		Trace("Setting up AV Topics for Hancock")
		; npc.SetValue(pTweakTopicHello,    0x00126054) ; && 0x00126092 "ComHancock:Favors:Show"/"ComHancock:Misc:COMHancockHellos"
		
		Form Hello1 = Game.GetForm(0x00126054) ; "ComHancock:Favors:Show"
		Form Hello2 = Game.GetForm(0x00126092) ; "ComHancock:Misc:COMHancockHellos"
		if !pTweakHelloTopicHancock.HasForm(Hello1)
			pTweakHelloTopicHancock.AddForm(Hello1)
		endif
		if !pTweakHelloTopicHancock.HasForm(Hello2)
			pTweakHelloTopicHancock.AddForm(Hello2)
		endif
		int formid  = pTweakHelloTopicHancock.GetFormID()
		int localid
		if formid > 0x80000000
			localid = (formid - 0x80000000) % 0x01000000
		else
			localid = formid % 0x01000000
		endif
		; int modid   = formid / 0x01000000
		int modid   = 0x00000100 ; Special Value. Means use AmazingFollowerTweaks.esp
		npc.SetValue(pTweakTopicHello,      localid) 
		npc.SetValue(pTweakTopicHelloModID, modid) 
		
		npc.SetValue(pTweakTopicTrade,    0x00126053) ; "ComHancock:Favors:Trade"
		npc.SetValue(pTweakTopicAck,      0x00126058) ; "ComHancock:Favors:Agree"
		npc.SetValue(pTweakTopicCancel,   0x00126057) ; "ComHancock:Favors:ExitFavorState"
		npc.SetValue(pTweakTopicDismiss,  0x0002AE64) ; "Followers:PlayerDialogue:FollowersSayCommandGoHome"
		npc.SetValue(pTweakTopicDistFar,  0x00126058) ; "ComHancock:Favors:Agree"
		npc.SetValue(pTweakTopicDistMed,  0x00126058) ; "ComHancock:Favors:Agree"
		npc.SetValue(pTweakTopicDistNear, 0x00126058) ; "ComHancock:Favors:Agree"
		npc.SetValue(pTweakTopicStyleAgg, 0x00126058) ; "ComHancock:Favors:Agree"
		npc.SetValue(pTweakTopicStyleDef, 0x00126058) ; "ComHancock:Favors:Agree"
		return
	endif
	
	; if ActorBaseID == 0x0002740E ; ---=== MacCready ===---
	if NameID == 8 
		
		Trace("Setting up AV Topics for MacCready")
		; npc.SetValue(pTweakTopicHello,    0x00119BC4) ; && 0x0011CD65 "ComMacCready:Favors:Show"/"ComMacCready:Misc:COMMacCreadyHellosX"
		
		Form Hello1 = Game.GetForm(0x00119BC4) ; "CComMacCready:Favors:Show"
		Form Hello2 = Game.GetForm(0x0011CD65) ; "ComMacCready:Misc:COMMacCreadyHellosX"
		if !pTweakHelloTopicMacCready.HasForm(Hello1)
			pTweakHelloTopicMacCready.AddForm(Hello1)
		endif
		if !pTweakHelloTopicMacCready.HasForm(Hello2)
			pTweakHelloTopicMacCready.AddForm(Hello2)
		endif
		int formid  = pTweakHelloTopicMacCready.GetFormID()
		int localid
		if formid > 0x80000000
			localid = (formid - 0x80000000) % 0x01000000
		else
			localid = formid % 0x01000000
		endif
		; int modid   = formid / 0x01000000
		int modid   = 0x00000100 ; Special Value. Means use AmazingFollowerTweaks.esp
		npc.SetValue(pTweakTopicHello,      localid) 
		npc.SetValue(pTweakTopicHelloModID, modid) 

		
		npc.SetValue(pTweakTopicTrade,    0x001AC17F) ; "ComMacCready:Favors:Trade"
		npc.SetValue(pTweakTopicAck,      0x00119BC8) ; "ComMacCready:Favors:Agree"
		npc.SetValue(pTweakTopicCancel,   0x00119BC7) ; "ComMacCready:Favors:ExitFavorState"	  
		npc.SetValue(pTweakTopicDismiss,  0x0002AE64) ; "Followers:PlayerDialogue:FollowersSayCommandGoHome"
		npc.SetValue(pTweakTopicDistFar,  0x00119BC8) ; "ComMacCready:Favors:Agree"
		npc.SetValue(pTweakTopicDistMed,  0x00119BC8) ; "ComMacCready:Favors:Agree"
		npc.SetValue(pTweakTopicDistNear, 0x00119BC8) ; "ComMacCready:Favors:Agree"
		npc.SetValue(pTweakTopicStyleAgg, 0x00119BC8) ; "ComMacCready:Favors:Agree"
		npc.SetValue(pTweakTopicStyleDef, 0x00119BC8) ; "ComMacCready:Favors:Agree"
		return
	endif
	
	
	; if ActorBaseID == 0x00002F24 ; ---=== Nick Valentine ===---
	if NameID == 9 
		  
		Trace("Setting up AV Topics for Nick")
		; npc.SetValue(pTweakTopicHello,    0x001576F7) ; && 0x001576EC "ComNick:Favors:Show"/"ComNick:Misc:COMNickHellos"

		Form Hello1 = Game.GetForm(0x001576F7) ; "ComNick:Favors:Show"		
		Form Hello2 = Game.GetForm(0x001576EC) ; "ComNick:Misc:COMNickHellos"
		if !pTweakHelloTopicNick.HasForm(Hello1)
			pTweakHelloTopicNick.AddForm(Hello1)
		endif
		if !pTweakHelloTopicNick.HasForm(Hello2)
			pTweakHelloTopicNick.AddForm(Hello2)
		endif
		int formid  = pTweakHelloTopicNick.GetFormID()
		int localid
		if formid > 0x80000000
			localid = (formid - 0x80000000) % 0x01000000
		else
			localid = formid % 0x01000000
		endif
		; int modid   = formid / 0x01000000
		int modid   = 0x00000100 ; Special Value. Means use AmazingFollowerTweaks.esp
		
		Trace("Setting Nick Hello Value : [" + localid + "]")
		npc.SetValue(pTweakTopicHello,      localid) 
		Trace("Setting Nick Hello ModID : [" + modid + "]")
		npc.SetValue(pTweakTopicHelloModID, modid) 
		
		Trace("Confirm : Value for pTweakTopicHello [" + npc.GetValue(pTweakTopicHello) + "]")
		Trace("Confirm : Value for pTweakTopicHelloModID [" + npc.GetValue(pTweakTopicHelloModID) + "]")
		
		npc.SetValue(pTweakTopicTrade,    0x001576F6) ; "ComNick:Favors:Trade"
		npc.SetValue(pTweakTopicAck,      0x001576FB) ; "ComNick:Favors:Agree"
		npc.SetValue(pTweakTopicCancel,   0x001576FA) ; "ComNick:Favors:ExitFavorState"
		npc.SetValue(pTweakTopicDismiss,  0x0002AE64) ; "Followers:PlayerDialogue:FollowersSayCommandGoHome"
		npc.SetValue(pTweakTopicDistFar,  0x001576FB) ; "ComNick:Favors:Agree"
		npc.SetValue(pTweakTopicDistMed,  0x001576FB) ; "ComNick:Favors:Agree"
		npc.SetValue(pTweakTopicDistNear, 0x001576FB) ; "ComNick:Favors:Agree"
		npc.SetValue(pTweakTopicStyleAgg, 0x001576FB) ; "ComNick:Favors:Agree"
		npc.SetValue(pTweakTopicStyleDef, 0x001576FB) ; "ComNick:Favors:Agree"
		return
	endif
	
	; if ActorBaseID == 0x00002F1E ; ---=== Piper ===---
	if NameID == 10 
		  
		Trace("Setting up AV Topics for Piper")
		; npc.SetValue(pTweakTopicHello,    0x00162C61) ; && 0x00162C56 "ComPiper:Favors:Show"/"ComPiper:Misc:COMPiperHellos"
		
		Form Hello1 = Game.GetForm(0x00162C61) ; "ComPiper:Favors:Show"
		Form Hello2 = Game.GetForm(0x00162C56) ; "ComPiper:Misc:COMPiperHellos"
		if !pTweakHelloTopicPiper.HasForm(Hello1)
			pTweakHelloTopicPiper.AddForm(Hello1)
		endif
		if !pTweakHelloTopicPiper.HasForm(Hello2)
			pTweakHelloTopicPiper.AddForm(Hello2)
		endif
		int formid  = pTweakHelloTopicPiper.GetFormID()
		int localid
		if formid > 0x80000000
			localid = (formid - 0x80000000) % 0x01000000
		else
			localid = formid % 0x01000000
		endif
		; int modid   = formid / 0x01000000
		int modid   = 0x00000100 ; Special Value. Means use AmazingFollowerTweaks.esp
		npc.SetValue(pTweakTopicHello,      localid) 
		npc.SetValue(pTweakTopicHelloModID, modid) 
		
		npc.SetValue(pTweakTopicTrade,    0x00162C60) ; "ComPiper:Favors:Trade"
		npc.SetValue(pTweakTopicAck,      0x00162C65) ; "ComPiper:Favors:Agree"
		npc.SetValue(pTweakTopicCancel,   0x00162C64) ; "ComPiper:Favors:ExitFavorState"
		npc.SetValue(pTweakTopicDismiss,  0x0002AE64) ; "Followers:PlayerDialogue:FollowersSayCommandGoHome"
		npc.SetValue(pTweakTopicDistFar,  0x00162C65) ; "ComPiper:Favors:Agree"
		npc.SetValue(pTweakTopicDistMed,  0x00162C65) ; "ComPiper:Favors:Agree"
		npc.SetValue(pTweakTopicDistNear, 0x00162C65) ; "ComPiper:Favors:Agree"
		npc.SetValue(pTweakTopicStyleAgg, 0x00162C65) ; "ComPiper:Favors:Agree"
		npc.SetValue(pTweakTopicStyleDef, 0x00162C65) ; "ComPiper:Favors:Agree"
		return
	endif
	
	; if ActorBaseID == 0x00019FD9 ; ---=== Preston ===---
	if NameID == 11 
		  
		Trace("Setting up AV Topics for Preston")
		; npc.SetValue(pTweakTopicHello,    0x000F5C5A) ; && 0x0007925D "ComPreston:Favors:Show"/"ComPreston:Misc:Hello"
		Form Hello1 = Game.GetForm(0x000F5C5A) ; "ComPreston:Favors:Show"
		Form Hello2 = Game.GetForm(0x0007925D) ; "ComPreston:Misc:Hello"
		if !pTweakHelloTopicPreston.HasForm(Hello1)
			pTweakHelloTopicPreston.AddForm(Hello1)
		endif
		if !pTweakHelloTopicPreston.HasForm(Hello2)
			pTweakHelloTopicPreston.AddForm(Hello2)
		endif
		int formid  = pTweakHelloTopicPreston.GetFormID()
		int localid
		if formid > 0x80000000
			localid = (formid - 0x80000000) % 0x01000000
		else
			localid = formid % 0x01000000
		endif
		; int modid   = formid / 0x01000000
		int modid   = 0x00000100 ; Special Value. Means use AmazingFollowerTweaks.esp
		npc.SetValue(pTweakTopicHello,      localid) 
		npc.SetValue(pTweakTopicHelloModID, modid) 
		
		npc.SetValue(pTweakTopicTrade,    0x00204819) ; "ComPreston:Favors:Trade"
		npc.SetValue(pTweakTopicAck,      0x000F5C5E) ; "ComPreston:Favors:Agree"
		npc.SetValue(pTweakTopicCancel,   0x000F5C5D) ; "ComPreston:Favors:ExitFavorState"
		npc.SetValue(pTweakTopicDismiss,  0x0002AE64) ; "Followers:PlayerDialogue:FollowersSayCommandGoHome"
		npc.SetValue(pTweakTopicDistFar,  0x0002AE61) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceFar"
		npc.SetValue(pTweakTopicDistMed,  0x0002AE62) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceMedium"
		npc.SetValue(pTweakTopicDistNear, 0x0002AE63) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceNear"
		npc.SetValue(pTweakTopicStyleAgg, 0x0002AE60) ; "Followers:PlayerDialogue:FollowersSayCommandStanceAggressive"
		npc.SetValue(pTweakTopicStyleDef, 0x0002AE5F) ; "Followers:PlayerDialogue:FollowersSayCommandStanceDefensive"
		return
	endif
	
	; if ActorBaseID == 0x00027682 ; ---=== Strong ===---
	if NameID == 12 
		
		Trace("Setting up AV Topics for Strong")
		; npc.SetValue(pTweakTopicHello,    0x00135AA6) ; && 0x0011F765 "ComStrong:Favors:Show"/"ComStrong:Misc:ComStrongHello"
		Form Hello1 = Game.GetForm(0x00135AA6) ; "ComStrong:Favors:Show"
		Form Hello2 = Game.GetForm(0x0011F765) ; "ComStrong:Misc:ComStrongHello"
		if !pTweakHelloTopicStrong.HasForm(Hello1)
			pTweakHelloTopicStrong.AddForm(Hello1)
		endif
		if !pTweakHelloTopicStrong.HasForm(Hello2)
			pTweakHelloTopicStrong.AddForm(Hello2)
		endif
		int formid  = pTweakHelloTopicStrong.GetFormID()
		int localid
		if formid > 0x80000000
			localid = (formid - 0x80000000) % 0x01000000
		else
			localid = formid % 0x01000000
		endif
		; int modid   = formid / 0x01000000
		int modid   = 0x00000100 ; Special Value. Means use AmazingFollowerTweaks.esp
		npc.SetValue(pTweakTopicHello,      localid) 
		npc.SetValue(pTweakTopicHelloModID, modid) 
				
		npc.SetValue(pTweakTopicTrade,    0x00135AA5) ; "ComStrong:Favors:Trade"
		npc.SetValue(pTweakTopicAck,      0x00135AAA) ; "ComStrong:Favors:Agree"
		npc.SetValue(pTweakTopicCancel,   0x00135AA9) ; "ComStrong:Favors:ExitFavorState"
	
		npc.SetValue(pTweakTopicDismiss,  0x0002AE64) ; "Followers:PlayerDialogue:FollowersSayCommandGoHome"
		npc.SetValue(pTweakTopicDistFar,  0x0002AE61) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceFar"
		npc.SetValue(pTweakTopicDistMed,  0x0002AE62) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceMedium"
		npc.SetValue(pTweakTopicDistNear, 0x0002AE63) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceNear"
		npc.SetValue(pTweakTopicStyleAgg, 0x0002AE60) ; "Followers:PlayerDialogue:FollowersSayCommandStanceAggressive"
		npc.SetValue(pTweakTopicStyleDef, 0x0002AE5F) ; "Followers:PlayerDialogue:FollowersSayCommandStanceDefensive"
		return
	endif
	
	; if ActorBaseID == 0x000BBEE6 ; ---=== X6-88 ===---
	if NameID == 13 
		  
		Trace("Setting up AV Topics for X6-88")
		; npc.SetValue(pTweakTopicHello,    0x0011B981) ; && 0x0011CE29 "ComX688:Favors:Show"/"ComX688:Misc:Hello"
		Form Hello1 = Game.GetForm(0x0011B981) ; "ComX688:Favors:Show"
		Form Hello2 = Game.GetForm(0x0011CE29) ; "ComX688:Misc:Hello"
		if !pTweakHelloTopicX688.HasForm(Hello1)
			pTweakHelloTopicX688.AddForm(Hello1)
		endif
		if !pTweakHelloTopicX688.HasForm(Hello2)
			pTweakHelloTopicX688.AddForm(Hello2)
		endif
		int formid  = pTweakHelloTopicX688.GetFormID()
		int localid
		if formid > 0x80000000
			localid = (formid - 0x80000000) % 0x01000000
		else
			localid = formid % 0x01000000
		endif
		; int modid   = formid / 0x01000000
		int modid   = 0x00000100 ; Special Value. Means use AmazingFollowerTweaks.esp
		npc.SetValue(pTweakTopicHello,      localid) 
		npc.SetValue(pTweakTopicHelloModID, modid) 
		
		npc.SetValue(pTweakTopicTrade,    0x00204816) ; "ComX688:Favors:Trade"
		npc.SetValue(pTweakTopicAck,      0x0011B985) ; "ComX688:Favors:Agree"
		npc.SetValue(pTweakTopicCancel,   0x0011B984) ; "ComX688:Favors:ExitFavorState"
		npc.SetValue(pTweakTopicDismiss,  0x0002AE64) ; "Followers:PlayerDialogue:FollowersSayCommandGoHome"
		npc.SetValue(pTweakTopicDistFar,  0x0002AE61) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceFar"
		npc.SetValue(pTweakTopicDistMed,  0x0002AE62) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceMedium"
		npc.SetValue(pTweakTopicDistNear, 0x0002AE63) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceNear"
		npc.SetValue(pTweakTopicStyleAgg, 0x0002AE60) ; "Followers:PlayerDialogue:FollowersSayCommandStanceAggressive"
		npc.SetValue(pTweakTopicStyleDef, 0x0002AE5F) ; "Followers:PlayerDialogue:FollowersSayCommandStanceDefensive"
		return
	endif

	if NameID == 14
	
		; Ada
		if pTweakDLC01Script.Installed
			Trace("Setting up AV Topics for Ada")
		
			if !pTweakHelloTopicAda.HasForm(pTweakDLC01Script.DLC01COMRTalkGreetings)
				pTweakHelloTopicAda.AddForm(pTweakDLC01Script.DLC01COMRTalkGreetings)
			endif
			if !pTweakHelloTopicAda.HasForm(pTweakDLC01Script.DLC01COMRobotCompanion_Hello)
				pTweakHelloTopicAda.AddForm(pTweakDLC01Script.DLC01COMRobotCompanion_Hello)
			endif
			int formid  = pTweakHelloTopicAda.GetFormID()
			int localid
			if formid > 0x80000000
				localid = (formid - 0x80000000) % 0x01000000
			else
				localid = formid % 0x01000000
			endif
			; int modid   = formid / 0x01000000
			
			int modid   = 0x00000100 ; Special Value. Means use AmazingFollowerTweaks.esp
			npc.SetValue(pTweakTopicHello,      localid) 
			npc.SetValue(pTweakTopicHelloModID, modid) 
		
			modid   = 0x00000101 ; Special Value. Means use DLCRobot.esm
			npc.SetValue(pTweakTopicTrade,    pTweakDLC01Script.DLC01COMRobotCompanion_TradeMasked)
			npc.SetValue(pTweakTopicTradeModID, modid)
			
			npc.SetValue(pTweakTopicAck,      pTweakDLC01Script.DLC01COMRobotCompanionOther_AgreeMasked)
			npc.SetValue(pTweakTopicAckModID, modid)
			
			; npc.SetValue(pTweakTopicCancel,   0x)
			; npc.SetValue(pTweakTopicCancelModID, modid)
			
			npc.SetValue(pTweakTopicDismiss,  pTweakDLC01Script.DLC01WorkshopParent_AssignConfirmMasked)
			npc.SetValue(pTweakTopicDismissModID, modid)
			
			; npc.SetValue(pTweakTopicDistFar,  0x) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceFar"
			; npc.SetValue(pTweakTopicDistMed,  0x) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceMedium"
			; npc.SetValue(pTweakTopicDistNear, 0x) ; "Followers:PlayerDialogue:FollowersSayCommandDistanceNear"
			; npc.SetValue(pTweakTopicStyleAgg, 0x) ; "Followers:PlayerDialogue:FollowersSayCommandStanceAggressive"
			; npc.SetValue(pTweakTopicStyleDef, 0x) ; "Followers:PlayerDialogue:FollowersSayCommandStanceDefensive"
			return
		else
			Trace("TweakDLC01Script Not installed.... Skipping Ada")
		endif
		
	endif

	if NameID == 15
		; Longfellow
		if pTweakDLC03Script.Installed
			Trace("Setting up AV Topics for Longfellow")
		
			if !pTweakHelloTopicLongfellow.HasForm(pTweakDLC03Script.DLC03_COMOldLongfellowTalk_Greeting)
				pTweakHelloTopicLongfellow.AddForm(pTweakDLC03Script.DLC03_COMOldLongfellowTalk_Greeting)
			endif
			if !pTweakHelloTopicLongfellow.HasForm(pTweakDLC03Script.DLC03_COMOldLongfellow_Greeting)
				pTweakHelloTopicLongfellow.AddForm(pTweakDLC03Script.DLC03_COMOldLongfellow_Greeting)
			endif
			int formid  = pTweakHelloTopicLongfellow.GetFormID()
			int localid
			if formid > 0x80000000
				localid = (formid - 0x80000000) % 0x01000000
			else
				localid = formid % 0x01000000
			endif
			
			int modid   = 0x00000100 ; Special Value. Means use AmazingFollowerTweaks.esp
			npc.SetValue(pTweakTopicHello,      localid) 
			npc.SetValue(pTweakTopicHelloModID, modid) 
		
			modid   = 0x00000103 ; Special Value. Means use DLCCoast.esm
			npc.SetValue(pTweakTopicTrade,    pTweakDLC03Script.DLC03_COMOldLongfellow_TradeMasked)
			npc.SetValue(pTweakTopicTradeModID, modid)
			
			npc.SetValue(pTweakTopicAck,      pTweakDLC03Script.DLC03_COMOldLongfellow_AgreeMasked)
			npc.SetValue(pTweakTopicAckModID, modid)
			
			npc.SetValue(pTweakTopicDismiss,  pTweakDLC03Script.DLC03_COMOldLongfellowTalk_DismissMasked)
			npc.SetValue(pTweakTopicDismissModID, modid)
			
			return
		else
			Trace("TweakDLC03Script Not installed.... Skipping Longfellow")
		endif	
	
	endif

	if NameID == 16	
		; PorterGage
		if pTweakDLC04Script.Installed
			Trace("Setting up AV Topics for Longfellow")
		
			if !pTweakHelloTopicPorterGage.HasForm(pTweakDLC04Script.DLC04COMGageTalk_Greeting)
				pTweakHelloTopicPorterGage.AddForm(pTweakDLC04Script.DLC04COMGageTalk_Greeting)
			endif
			if !pTweakHelloTopicPorterGage.HasForm(pTweakDLC04Script.DLC04COMGage_Hello)
				pTweakHelloTopicPorterGage.AddForm(pTweakDLC04Script.DLC04COMGage_Hello)
			endif
			int formid  = pTweakHelloTopicPorterGage.GetFormID()
			int localid
			if formid > 0x80000000
				localid = (formid - 0x80000000) % 0x01000000
			else
				localid = formid % 0x01000000
			endif
			
			int modid   = 0x00000100 ; Special Value. Means use AmazingFollowerTweaks.esp
			npc.SetValue(pTweakTopicHello,      localid) 
			npc.SetValue(pTweakTopicHelloModID, modid) 
		
			modid   = 0x00000104 ; Special Value. Means use DLCNukaWorld.esm
			npc.SetValue(pTweakTopicTrade,    pTweakDLC04Script.DLC04COMGage_TradeMasked)
			npc.SetValue(pTweakTopicTradeModID, modid)
			
			npc.SetValue(pTweakTopicAck,      pTweakDLC04Script.DLC04COMGage_AgreeMasked)
			npc.SetValue(pTweakTopicAckModID, modid)
			
			npc.SetValue(pTweakTopicDismiss,  pTweakDLC04Script.DLC04COMGageTalk_DismissMasked)
			npc.SetValue(pTweakTopicDismissModID, modid)
			
			return
		else
			Trace("TweakDLC04Script Not installed.... Skipping PorterGage")
		endif			
	endif
	
	if NameID == 17 || NameID == 18
		; Nate/Nora
		Trace("Setting up AV Topics for Spouse")
		Form Hello1 = Game.GetFormFromFile(0x0104BE29, "AmazingFollowerTweaks.esp") ; "TweakComSpouse:Misc:COMSpouseHello"
		Form Hello2 = Game.GetFormFromFile(0x0100268D, "AmazingFollowerTweaks.esp") ; "TweakComSpouseTalk:Misc:TweakCOMSpouseTalkGreetings"
		if !pTweakHelloTopicSpouse.HasForm(Hello1)
			pTweakHelloTopicSpouse.AddForm(Hello1)
		endif
		if !pTweakHelloTopicSpouse.HasForm(Hello2)
			pTweakHelloTopicSpouse.AddForm(Hello2)
		endif
		int formid  = pTweakHelloTopicSpouse.GetFormID()
		int localid
		if formid > 0x80000000
			localid = (formid - 0x80000000) % 0x01000000
		else
			localid = formid % 0x01000000
		endif
		; int modid   = formid / 0x01000000
		int modid   = 0x00000100 ; Special Value. Means use AmazingFollowerTweaks.esp
		
		npc.SetValue(pTweakTopicHello,      localid) 
		npc.SetValue(pTweakTopicHelloModID, modid) 
		
		npc.SetValue(pTweakTopicTrade,      0x010074BC) ; "TweakComSpouse:Favors:Trade"
		npc.SetValue(pTweakTopicTradeModID, modid) 
		
		npc.SetValue(pTweakTopicAck,        0x01006CF0) ; "TweakComSpouse:Favors:Agree"
		npc.SetValue(pTweakTopicAckModID,   modid)      
		
		npc.SetValue(pTweakTopicCancel,     0x01002692) ; "TweakComSpouseTalk:Scene:TweakCOMSpouseTalk_TalkScene:NeverMind(response)"
		npc.SetValue(pTweakTopicCancelModID,modid)      
		
		npc.SetValue(pTweakTopicDismiss,    0x01002694) ; "TweakComSpouseTalk:Scene:TweakCOMSpouseTalk_TalkScene:Dismiss(response)"
		npc.SetValue(pTweakTopicDismissModID,    modid) 
		
		npc.SetValue(pTweakTopicDistFar,    0x01006CF0) ; "TweakComSpouse:Favors:Agree"
		npc.SetValue(pTweakTopicDistFarModID,    modid)      

		npc.SetValue(pTweakTopicDistMed,    0x01006CF0) ; "TweakComSpouse:Favors:Agree"
		npc.SetValue(pTweakTopicDistMedModID,    modid)      

		npc.SetValue(pTweakTopicDistNear,   0x01006CF0) ; "TweakComSpouse:Favors:Agree"
		npc.SetValue(pTweakTopicDistNearModID,   modid)      
		
		npc.SetValue(pTweakTopicStyleAgg,   0x01006CF0) ; "TweakComSpouse:Favors:Agree"
		npc.SetValue(pTweakTopicStyleAggModID,   modid)
		
		npc.SetValue(pTweakTopicStyleDef,   0x01006CF0) ; "TweakComSpouse:Favors:Agree"
		npc.SetValue(pTweakTopicStyleDefModID,   modid) 
		return		
	endif
	
	Trace("NameID Unknown. Not Topics Available")											

endFunction

int Function TopicCheck(int formID, String hint="")
	Topic t =  (Game.GetForm(formID) as Topic)
	if !t
		Trace("Cast [" + formID + "](" + hint + ") to Topic Failed...")
	endif
	return formID
EndFunction	

Function RegisterForKickOut()

	UnRegisterForRemoteEvent(BoSKickOut,"OnQuestInit")
	UnRegisterForRemoteEvent(BoSKickOut,"OnStageSet")
	UnRegisterForRemoteEvent(BoSKickOutSoft,"OnQuestInit")
	UnRegisterForRemoteEvent(BoSKickOutSoft,"OnStageSet")
	UnRegisterForRemoteEvent(InstKickOut,"OnQuestInit")
	UnRegisterForRemoteEvent(RRKickOut,"OnQuestInit")
	UnRegisterForRemoteEvent(RRKickOut,"OnStageSet")
	
	if !BoSKickOut.IsRunning()
		if 0 == BoSKickOut.GetCurrentStageID()
			RegisterForRemoteEvent(BoSKickOut,"OnQuestInit")
		endif
	elseif !(BoSKickOut.GetStageDone(10) || BoSKickOut.GetStageDone(20))
		RegisterForRemoteEvent(BoSKickOut,"OnStageSet")
	endif
	if !BoSKickOutSoft.IsRunning()
		if 0 == BoSKickOutSoft.GetCurrentStageID()
			RegisterForRemoteEvent(BoSKickOutSoft,"OnQuestInit")
		endif
	elseif !BoSKickOutSoft.GetStageDone(10)
		RegisterForRemoteEvent(BoSKickOut,"OnStageSet")
	endif
	if !InstKickOut.IsRunning()
		if 0 == InstKickOut.GetCurrentStageID()
			RegisterForRemoteEvent(InstKickOut,"OnQuestInit")
		endif
	endif
	if !RRKickOut.IsRunning()
		if 0 == RRKickOut.GetCurrentStageID()
			RegisterForRemoteEvent(RRKickOut,"OnQuestInit")
		endif
	elseif !RRKickOut.GetStageDone(100)
		RegisterForRemoteEvent(RRKickOut,"OnStageSet")
	endif
	
EndFunction

Function HandleInstKickOut()

	Actor X688 = CompanionX688.GetUniqueActor()
	if !X688.IsDead()
		if X688.IsInFaction(pTweakFollowerFaction)

			; Prevent X6-88 from turning on Player/Programming
			Faction InstituteFaction = Game.GetForm(0x0005E558) as Faction
			Faction SynthFaction     = Game.GetForm(0x00083B31) as Faction
			Faction HasBeenCompanion = Game.GetForm(0x000A1B85) as Faction
			
			X688.RemoveFromFaction(InstituteFaction)
			X688.RemoveFromFaction(SynthFaction)
			
			; Need to put him in a faction that will protect the player
			X688.AddToFaction(HasBeenCompanion)
		endif	
	endIf
	
	; Purge is complicates. And besides, between synths and scientists, who
	; is to say where the members loyalty truly lies. 
		
EndFunction

Function HandleBoSKickOut()

	Actor Danse = BoSPaladinDanse.GetUniqueActor()
	Actor Haylen = None
	ActorBase BoSScribeHaylen = Game.GetForm(0x0005DE3F) as ActorBase
	if BoSScribeHaylen
		Haylen = BoSScribeHaylen.GetUniqueActor()
	endif
	
	if !Danse.IsDead()
		if Danse.IsInFaction(pTweakFollowerFaction)	
			if BoS302.GetStageDone(20) != 1
				UnManageFollower(Danse)
				Danse.SetEssential(false)
				Danse.GetActorBase().SetEssential(false)
				Danse.GetActorBase().SetProtected(false)
				Danse.SetGhost(false)
			endif
		endif	
	endIf

	if Haylen && !Haylen.IsDead()
		if Haylen.IsInFaction(pTweakFollowerFaction)	
			if BoS302.GetStageDone(20) == 1
				Faction BoSFaction = Game.GetForm(0x0005DE41) as Faction	
				Haylen.RemoveFromFaction(BoSFaction)
				Faction BoS100FightFaction = Game.GetForm(0x001B513D) as Faction
				Haylen.RemoveFromFaction(BoS100FightFaction)
				
				; Need to put her in a faction that will protect the player
				Faction HasBeenCompanion = Game.GetForm(0x000A1B85) as Faction
				Haylen.AddToFaction(HasBeenCompanion)
			else
				UnManageFollower(Haylen)
				Haylen.SetEssential(false)
				Haylen.GetActorBase().SetEssential(false)
				Haylen.GetActorBase().SetProtected(false)
				Haylen.SetGhost(false)
			endif
		endif	
	endIf
		
	; Faction BoSFaction = Game.GetForm(0x0005DE41) as Faction	
	; if BoSFaction
		; int plength = pManagedMap.Length
		; int p = 1
		; while (p < plength)
			; ReferenceAlias pfix = pManagedMap[p]
			; if pfix
				; Actor pa = pfix.GetActorReference()
				; if (pa && pa != Danse && pa != Haylen)
					; if ((pfix as AFT:TweakSettings).originalFactions.Find(BoSFaction) > -1)		
						; UnManageFollower(pa)
						;; Unmanage will often restore their original values. So we need to make them mortal
						; pa.SetEssential(false)
						; pa.GetActorBase().SetEssential(false)
						; pa.GetActorBase().SetProtected(false)
						; pa.SetGhost(false)
					; endif
				; endif
			; endIf
			; p += 1
		; endWhile
	; endif
	
EndFunction

Function HandleRRKickOut()
	Actor Deacon = CompanionDeacon.GetUniqueActor()
	if !Deacon.IsDead()
		if Deacon.IsInFaction(pTweakFollowerFaction)
			UnManageFollower(Deacon)
			; Unmanage will often restore their original values. So we need to make them mortal
			Deacon.SetEssential(false)
			Deacon.GetActorBase().SetEssential(false)
			Deacon.GetActorBase().SetProtected(false)
			Deacon.SetGhost(false)
		endif
	endIf
	
	; Scan Managed Map and look for RailRoad Faction members.
	; When kicked out it is normally because you took the 
	; eliminate RR quest, which means we need everyone unmanaged
	; so you can kill them...
	
	Faction RailRoadFaction = Game.GetForm(0x000994F6) as Faction
	if RailRoadFaction
		int plength = pManagedMap.Length
		int p = 1
		while (p < plength)
			ReferenceAlias pfix = pManagedMap[p]
			if pfix
				Actor pa = pfix.GetActorReference()
				if pa && ((pfix as AFT:TweakSettings).originalFactions.Find(RailRoadFaction) > -1)		
					UnManageFollower(pa)
					; Unmanage will often restore their original values. So we need to make them mortal
					pa.SetEssential(false)
					pa.GetActorBase().SetEssential(false)
					pa.GetActorBase().SetProtected(false)
					pa.SetGhost(false)
				endif
			endIf
			p += 1
		endWhile
	endif
	
endFunction
			
; SQUARE ROOT is expensive. Most people dont actually want to KNOW the distance. They
; simply want equality or range checks, which you can do without the square root...
Bool Function DistanceWithinCylinder(ObjectReference a, ObjectReference b, float radius, float height)

	float az
	float bz
	float factor
	
	if (height != 0)
		az = a.GetPositionZ()
		bz = b.GetPositionZ()
		; Check Height first as it is cheap...
		factor =  az + (height/2)
		if (bz > factor)
			return false
		endif
		factor =  az - (height/2)
		if (bz < factor)
			return false
		endif
	endif
	radius = radius * radius
	factor	= a.GetPositionX() - b.GetPositionX()
	float total  = (factor * factor)
	; Early bail if we can. 
	if (total > radius)
		return false
	endif
	factor = a.GetPositionY() - b.GetPositionY()
	total += (factor * factor)
	; Early bail if we can. 
	if (total > radius)
		return false
	endif
	if (height != 0)
		factor = az - bz
	else
		factor = a.GetPositionZ() - b.GetPositionZ()
	endIf
	total += (factor * factor)
	return (radius > total)
EndFunction

Bool Function IsCoreCompanion(Actor npc)
	ActorBase base = npc.GetActorBase()

	if (base == CompanionCait)
		return true
	elseif (base == Codsworth) 
		return true
	elseif (base == CompanionCurie)
		return true	
	elseif (base == BoSPaladinDanse)
		return true
	elseif (base == CompanionDeacon)
		return true
	elseif (base == Hancock)
		return true
	elseif (base == CompanionMacCready)
		return true
	elseif (base == CompanionNickValentine)
		return true
	elseif (base == CompanionPiper)
		return true
	elseif (base == PrestonGarvey)
		return true
	elseif (base == CompanionStrong)
		return true
	elseif (base == CompanionX688)
		return true
	elseif (base == TweakCompanionNate)
		return true
	elseif (base == TweakCompanionNora)
		return true
	; else
		; if pTweakDLC01Script.Installed
			; if base == pTweakDLC01Script.AdaBase
		; endIf
		; if pTweakDLC03Script.Installed
			; if base == pTweakDLC03Script.OldLongfellow
		; endif
		; if pTweakDLC04Script.Installed
			; if base == pTweakDLC04Script.PorterGageBase
		; endif		
	endIf
	return false
EndFunction

String Function GetResourceID()
	int formid = self.GetFormID()
	int fullid = formid
	if fullid > 0x80000000
		fullid -= 0x80000000
	endif
	int lastsix = fullid % 0x01000000
	pTweakShowResourceID.Show(((formid - lastsix)/0x01000000) as Int)
EndFunction 

; int Function GetUsedGenericNameSlots()
	; Trace("GetUsedGenericNameSlots() Called")

	; Actor npc             = None
	; int pManagedMapLength = pManagedMap.Length
	; int i                 = 1	
	
	; int id
	; int bitmask = 0
	
	; Trace("Building Bitmask from [" + pManagedMapLength + "] aliases")
	; while (i < pManagedMapLength)
		; npc = pManagedMap[i].GetActorRef()
		; if (npc)
			; id = npc.GetFactionRank(pTweakNamesFaction)
			; if (id > 18 && id < 51)
				; bitmask += (Math.Pow(2,(id - 19)) as Int)
			; endif
		; endif
		; i += 1
	; EndWhile
	; return bitmask

; EndFunction
