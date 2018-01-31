Scriptname AFT:TweakPipBoyScript extends Quest Conditional
;NOTES: This script has reached the per-script CONDITIONAL LIMIT (Which seems to be around 42... hmmm.. Montry Python Reference?)

; Character -> Quest -> TweakPipBoy -> Scripts
; This Quest acts as a state controller for the AFT PipBoy and Aft Settings interfaces. 
; Starting Point is Magic -> Potion -> TweakActivateAft

; Dont use import. It only works when .pex files are local. Once you package them up into an 
; release/final archive, the scripts wont be found and everything will break...
; import AFT

ReferenceAlias  Property pAftSettingsHolotape Auto Const

Actor    Property TerminalTarget           Auto Conditional
; Actor    Property pCodsworthRef            Auto Const

Int		Property TerminalTargetId         			Auto Conditional ; TweakNamesFaction rank of Terminal Target
Int		Property TerminalTargetOId         			Auto Conditional ; Original Name ID (before rename). Will have value 1-19 for reserved NPCs
Float	Property TerminalTargetDist       			Auto Conditional ; iFollower_Dist_Near or iFollower_Dist_Medium or iFollower_Dist_Far
Float	Property TerminalTargetStance     			Auto Conditional ; iFollower_Stance_Aggressive or iFollower_Stance_Defensive
Float	Property TerminalTargetState      			Auto Conditional ; iFollower_Com_Wait or iFollower_Com_Follow
Int		Property TerminalTargetPAState    			Auto Conditional ; 0 = No Power Armor, 1 = In PowerArmor, 2 = Link Available, 3 = Can't wear PA
Int		Property TerminalTargetHasBody    			Auto Conditional ; 1 = true, 0 = false Refers to options available in Sythn NewBody lists
Int		Property TerminalTargetConfidence			Auto Conditional ; 0 = Coward, 1 = Cautious, 2 = Average, 3 = Brave 4 = Foolhardy
Bool	Property TerminalTargetEssential  			Auto Conditional ;
Bool	Property TerminalTargetOEssential 			Auto Conditional ;
Bool	Property TerminalTargetLeveled    			Auto Conditional ;
Bool	Property TerminalTargetHasCombatOutfit 		Auto Conditional
Bool	Property TerminalTargetHasCityOutfit   		Auto Conditional
Bool	Property TerminalTargetHasCampOutfit   		Auto Conditional
Bool	Property TerminalTargetHasStandardOutfit	Auto Conditional
Bool	Property TerminalTargetPAHelmetCombatOnly	Auto Conditional
Bool	Property TerminalTargetSyncPA				Auto Conditional
Bool	Property TerminalTargetUnique				Auto Conditional
Bool	Property TerminalTargetPackMule				Auto Conditional
Bool	Property TerminalTargetIgnoreFriendlyHits	Auto Conditional
Bool 	Property TerminalTargetAvoidsTraps			Auto Conditional
Bool	Property TerminalTargetReadyWeapon			Auto Conditional
Bool	Property TerminalTargetNoDisapprove			Auto Conditional
Bool	Property TerminalTargetNoApprove			Auto Conditional
Bool	Property TerminalTargetConvNegToPos			Auto Conditional
Bool	Property TerminalTargetConvPosToNeg			Auto Conditional
Bool	Property TerminalTargetNoCommentIdle		Auto Conditional
Bool	Property TerminalTargetNoAutoRelax			Auto Conditional
Bool	Property TerminalTargetNoCommentGeneral		Auto Conditional
Bool	Property TerminalTargetNoCommentApprove		Auto Conditional
Bool	Property TerminalTargetNoCommentDisapprove	Auto Conditional
Bool	Property TerminalTargetNoCommentActivator	Auto Conditional
Bool	Property TerminalTargetActiveFollower		Auto Conditional
Bool	Property TerminalTargetUnmanaged			Auto Conditional
Bool	Property TerminalTargetUseAmmo				Auto Conditional
Bool	Property TerminalTargetPANoDamage			Auto Conditional
Bool	Property TerminalTargetTrackKills			Auto Conditional
Bool	Property CommentSynchronous					Auto Conditional ; true = 1 after another. False = all at once

; Supported Races:
; 0  = Unknown/Unsupported
; 1  = Human
; 2  = Ghoul
; 3  = Supermutant
; 4  = Synth (Gen1, Gen2, Valentine)
; 5  = Dog   (Dogmeat/Raider/Vicious/FEVHound)
; 6  = EyeBot
; 7  = Handy
; 8  = Protectron		
; 9  = SentryBot
; 10 = Assaultron
; 11 = DeathClaw
; 12 = SuperMutantBehemoth

Int		Property TerminalTargetRace					Auto Conditional ; Current Race
Int		Property TerminalTargetORace				Auto Conditional ; Original Race

Race	Property pHumanRace							Auto Const ; 1
Race	Property pGhoulRace							Auto Const ; 2
Race	Property pSuperMutantRace                   Auto Const ; 3
Race	Property pSynthGen1Race						Auto Const ; 4
Race	Property pSynthGen2Race                     Auto Const ; 4
Race	Property pSynthGen2RaceValentine			Auto Const ; 4
Race	Property pDogmeatRace                       Auto Const ; 5
Race	Property pRaiderDogRace                     Auto Const ; 5
Race	Property pViciousDogRace                    Auto Const ; 5
Race	Property pFEVHoundRace                      Auto Const ; 5
Race	Property pEyeBotRace						Auto Const ; 6
Race	Property pHandyRace							Auto Const ; 7
Race	Property pProtectronRace					Auto Const ; 8
Race	Property pSentryBotRace						Auto Const ; 9
Race	Property pAssaultronRace					Auto Const ; 10
Race	Property pDeathClawRace						Auto Const ; 11
Race	Property pSuperMutantBehemothRace			Auto Const ; 12

Race	Property pTweakInvisibleRace               Auto Const

Keyword Property pActorTypeSynth					Auto Const
Keyword Property pTeammateDontUseAmmoKeyword		Auto Const
Keyword Property pPowerArmorPreventArmorDamageKeyword Auto Const
Spell	Property pTweakManageNPCRelay				Auto Const

ActorValue Property pTweakOriginalRace				Auto Const
ActorValue Property pConfidence     				Auto  const 

ActorValue Property Strength		Auto Const
ActorValue Property Perception		Auto Const
ActorValue Property Endurance		Auto Const
ActorValue Property Charisma		Auto Const
ActorValue Property Intelligence	Auto Const
ActorValue Property Agility			Auto Const
ActorValue Property Luck			Auto Const
ActorValue Property pTweakAvailable	Auto Const

Race	Property pPowerArmorRace					Auto Const

Bool     Property PlayerIsFirstPerson      Auto;
Int      Property ActivateOnNameSelect     Auto Conditional ; 0 = Do nothing, 1 = Assign Name, 2 = Locate, 3=UnManage, 4=RLock
Int      Property DoOnTerminalClose        Auto hidden ; 0 = Nothing 1 = MakeCamp(refresh) 2 = TearDownShelter()

Bool     Property pSculptLeveledHintShown  Auto Hidden
Bool	 Property pRaceInvFixHintShow	   Auto Hidden
Bool     Property pAppearanceHintShown     Auto Hidden

Faction  Property pTweakFollowerFaction       Auto Const
Faction  Property pTweakNamesFaction          Auto Const
Faction  Property pTweakEssentialFaction      Auto Const
Faction  Property pTweakPosedFaction          Auto Const
FormList Property pTweakToggles 		      Auto Const

Faction  Property pTweakBoomstickFaction	Auto Const
Faction  Property pTweakBruiserFaction		Auto Const
Faction  Property pTweakCommandoFaction		Auto Const
Faction  Property pTweakGunslingerFaction	Auto Const
Faction  Property pTweakNinjaFaction		Auto Const
Faction  Property pTweakSniperFaction		Auto Const
Faction	 Property pTweakEnhancedFaction		Auto Const
Faction	 Property pTweakAutoStanceFaction	Auto Const

Faction	 Property pTweakManagedOutfit		Auto Const
Faction	 Property pDanversFaction			Auto Const
GlobalVariable Property pTweakMarkedForIgnore	Auto Const


Potion   Property pTweakActivateAFT           Auto Const
Holotape Property pTweakHoloTape              Auto Const
Book     Property pTweakReadme                Auto Const
Quest    Property pTweakFollower              Auto Const
Quest    Property pCOMCurieQuest              Auto Const
Quest    Property pFollowers                  Auto Const
Quest    Property pTweakNames                 Auto Const
Quest    Property pTweakVisualChoice          Auto Const
Quest    Property pTweakGatherLooseItems      Auto Const


Terminal Property pTweakRootTerminal          Auto Const
Terminal Property pTweakImportTerminal        Auto Const
Terminal Property pTweakSettingsTerminal      Auto Const
Terminal Property pTweakEssentialFailTerminal Auto Const
Terminal Property pTweakCombatAITerminal	  Auto Const
Terminal Property pTweakCombatCaution	      Auto Const
Terminal Property pTweakSettingsAITerminal	  Auto Const
Terminal Property pTweakUnmanagedTerminal	  Auto Const
Terminal Property pTweakVisualFailPosed       Auto Const ; 2
Terminal Property pTweakVisualFailPowerArmor  Auto Const ; 3 
Terminal Property pTweakVisualFailCombat      Auto Const ; 4
Terminal Property pTweakVisualFailScene       Auto Const ; 5

Terminal Property pTweakFailDisallowed       Auto Const ; 5
Terminal Property pTweakFailPotential        Auto Const ; 5
Terminal Property pTweakFailNoPrefab		 Auto COnst
Terminal Property pTweakFailBadPrefab		 Auto COnst
Terminal Property pTweakCombatStyleTerminal  Auto Const
Terminal Property pTweakSelectNameTerminal	 Auto Const

Terminal Property pTweakSpecial				Auto Const

Message  Property pTweakVisualFailDistance    Auto Const 
Message  Property pTweakAvailableIn           Auto Const
Message  Property pTweakStopThat              Auto Const
Message  Property pTweakLastWarning           Auto Const

GlobalVariable Property pTweakCampAvailableTS Auto Const
GlobalVariable Property pTweakCampUFOBeamUp   Auto Const
GlobalVariable Property pTweakCloseTerminal   Auto Const
GlobalVariable Property pTweakCampUFOEnabled  Auto Const
GlobalVariable Property pTweakAllowMultInterjections Auto Const
GlobalVariable Property pTweakCommand Auto Const
GLobalVariable Property pTweakLoiterCooldown Auto Const
; GLOBAL CONDITIONS (Because we ran out of VMQUEST CONDITIONALS)
GlobalVariable Property pTweakCombatStyle Auto Const ; 0 = Default, 1 = Gunslinger, 2 = Bruiser, 3 = Commando, 4 = Boomstick, 5 = Ninja, 6 = Sniper, 7 = Enhanced
GlobalVariable Property pTweakOutfitManaged Auto Const
GlobalVariable Property pTweakTargetHasHomeOutfit Auto Const

GlobalVariable Property pTweakSpecialStr	Auto Const
GlobalVariable Property pTweakSpecialPer	Auto Const
GlobalVariable Property pTweakSpecialEnd	Auto Const
GlobalVariable Property pTweakSpecialChr	Auto Const
GlobalVariable Property pTweakSpecialInt	Auto Const
GlobalVariable Property pTweakSpecialAgl	Auto Const
GlobalVariable Property pTweakSpecialLck	Auto Const
GlobalVariable Property pTweakSpecialAvl	Auto Const


Quest Property pTweakInterjections Auto Const

; Dialogue Support
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
ActorValue Property pTweakInPowerArmor			Auto Const


Faction		Property pTweakCombatOutFitFaction			Auto Const
Faction		Property pTweakHomeOutFitFaction			Auto Const
Faction		Property pTweakCampOutFitFaction			Auto Const
Faction		Property pTweakCityOutFaction				Auto Const
Faction		Property pTweakStandardOutFitFaction		Auto Const
Faction		Property pTweakPAHelmetCombatToggleFaction	Auto Const
Faction		Property pTweakSyncPAFaction				Auto Const
Faction		Property pTweakNoRelaxFaction				Auto Const
Faction		Property pTweakPackMuleFaction				Auto Const
Faction		Property pTweakReadyWeaponFaction			Auto Const
Faction		Property pTweakTrackKills					Auto Const

; Affinity
Faction		Property pTweakNoDisapprove					Auto Const
Faction		Property pTweakNoApprove					Auto Const
Faction		Property pTweakConvNegToPos					Auto Const
Faction		Property pTweakConvPosToNeg					Auto Const
Faction     Property pTweakNoIdleChatter				Auto Const
Faction		Property pTweakNoCommentGeneral				Auto Const
Faction		Property pTweakNoCommentApprove				Auto Const
Faction		Property pTweakNoCommentDisapprove			Auto Const
Faction		Property pTweakNoCommentActivator			Auto Const
GlobalVariable Property pTweakCommentLimit				Auto Const
Terminal 	Property pTweakSettingsPersonality	  		Auto Const
Terminal	Property pTweakSettingsChat					Auto Const
Message		Property pTweakNegativeCommentsAlert		Auto Const
Message		Property pTweakPositiveCommentsAlert		Auto Const
Message		Property pTweakStatUpdate					Auto Const

Keyword  Property pLinkPowerArmor           Auto Const
Keyword  Property pArmorTypePower           Auto Const
Keyword  Property pActorTypeNPC				Auto Const
Keyword	 Property pTeammateReadyWeapon_DO	Auto Const
Package  Property pCommandMode_Travel       Auto Const

Quest    Property pTweakExpandCamp          Auto Const

Quest 	  Property TweakMemoryLounger Auto Const

Idle	Property ScrapIdle Auto Const

Faction	Property DisallowedCompanionFaction Auto Const
Faction Property PotentialCompanionFaction	Auto Const
Faction Property pCurrentCompanionFaction	Auto Const
Faction Property TweakAllowFriendlyFire  	Auto Const

; Changing Curie Appearance
; LeveledActor   Property pTweakCharCurie2 Auto Const ; Empty Leveled Actor Script
; GlobalVariable Property pTweakCOMCurieA1 Auto       ; Curie Body Option

; Changing Player Appearance
; InputEnableLayer Property PipBoyInputLayer Auto Hidden
; Keyword Property AnimFaceArchetypePlayer Auto Const

; Furniture Property pFaceGenSurgeryChair     Auto Const
; Furniture Property pNPCSinkFacegenMarker     Auto Const

;GlobalVariable iFollower_Dist_Medium       Auto Const
;GlobalVariable iFollower_Dist_Far          Auto Const
;GlobalVariable iFollower_Stance_Aggressive Auto Const
;GlobalVariable iFollower_Stance_Defensive  Auto Const
GlobalVariable Property iFollower_Com_Wait  Auto Const
;GlobalVariable iFollower_Com_Follow        Auto Const

GlobalVariable Property TweakPrefabShowNext Auto Const
GlobalVariable Property TweakPrefabShowPrev Auto Const
GlobalVariable Property TweakPrefabShowWall Auto Const
GlobalVariable Property TweakPrefabShowFull Auto Const

GlobalVariable Property pTweakNoImportRestrictions Auto Const
GlobalVariable Property pTweakRestoreAFTItems Auto Const


ActorValue	Property pFavorsPerDay			Auto Const

GlobalVariable Property pTweakMovePosedActive Auto Const

; Quest Property pTweakVisualChoice Auto Const
ActorValue Property pTweakScale Auto Const
Message Property pTweakCurrentScale Auto Const
Message Property pTweakSculptLeveled Auto Const
Message Property pTweakAppearanceHint Auto Const
Message Property pTweakDisallowedWarn Auto Const
Message Property pTweakInvisibleFix Auto Const
Message Property pTweakUniqueOnly Auto Const

FormList Property pTweakNewBodyData Auto Const
Topic Property WorkshopVendorSharedTopicB Auto Const
Perk Property pTweakRangedDmgBoost Auto Const

ActorBase[] pHasBody

Topic[] ComeAlongTopics
Topic ComeAlongStrong
Topic ComeAlongDog
int TestTogggle

int REFRESH_CAMP  = 999 const
int TEARDOWN_CAMP = 998 const
int BEAMUP_CAMP   = 997 const

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakPipBoyScript"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Event OnInit()
	TerminalTarget          = None
	TerminalTargetId        = 0
	pRaceInvFixHintShow     = False
	pSculptLeveledHintShown = False
	pAppearanceHintShown    = False
	TerminalTargetLeveled   = False
	TestTogggle = 0
EndEvent

Function OnGameLoaded(bool firstTime = false)
	Trace("OnGameLoaded() Called")
	if (firstTime)
		pHasBody = new ActorBase[0]
		ComeAlongTopics = new Topic[7]
		ComeAlongTopics[0] = Game.GetForm(0x000CE9B1) as Topic ; "Come with me, I need your help."
		ComeAlongTopics[1] = Game.GetForm(0x0015FC36) as Topic ; "Let's Head out."
		ComeAlongTopics[2] = Game.GetForm(0x0012EDCA) as Topic ; "Lets Do it!"
		ComeAlongTopics[3] = Game.GetForm(0x0011CD2C) as Topic ; "Time to hit the road"
		ComeAlongTopics[4] = Game.GetForm(0x0010F0A9) as Topic ; "I would like to travel together some more"
		ComeAlongTopics[5] = Game.GetForm(0x000F7699) as Topic ; "Lets go then"
		ComeAlongTopics[6] = Game.GetForm(0x00127002) as Topic ; "Lets move out"	
		ComeAlongStrong    = Game.GetForm(0x0010BA5C) as Topic
		ComeAlongDog	   = Game.GetForm(0x0021686F) as Topic
	endIf
	pHasBody.Clear()
	ResetVariables()
	TestTogggle = 0
	Trace("OnGameLoad() Finished")
EndFunction

Function ResetVariables()
	Trace("ResetVariables() Called")
	
    ActivateOnNameSelect				= 0
	TerminalTarget						= None
	TerminalTargetId					= 0
	TerminalTargetOId					= 0
	TerminalTargetDist					= 0
	TerminalTargetStance				= 2
	TerminalTargetState					= 0
	TerminalTargetPAState				= 0
	TerminalTargetHasBody				= 0
	TerminalTargetConfidence            = 0
	pTweakCombatStyle.SetValue(0)
	TerminalTargetEssential				= false
	TerminalTargetOEssential			= false
	TerminalTargetUnmanaged             = false
	TerminalTargetRace					= 0
	TerminalTargetORace					= 0	
	TerminalTargetUnique				= false
	TerminalTargetHasCombatOutfit		= false
	pTweakTargetHasHomeOutfit.SetValue(0)
	TerminalTargetHasCityOutfit			= false
	TerminalTargetHasCampOutfit			= false
	TerminalTargetHasStandardOutfit		= false
	TerminalTargetActiveFollower		= false
	TerminalTargetPAHelmetCombatOnly	= false
	TerminalTargetNoDisapprove			= false
	TerminalTargetPackMule				= false
	TerminalTargetIgnoreFriendlyHits    = false
	TerminalTargetReadyWeapon           = false
	TerminalTargetSyncPA				= false
	TerminalTargetNoAutoRelax			= false
	TerminalTargetAvoidsTraps			= false
	
	; Scan TweakNewBodyData for fast lookup of NPCs with Body Data:
	int i = 0
	int TweakNewBodyDataSize = pTweakNewBodyData.GetSize()
	Formlist fl  = None
	ActorBase ab = None
	
	Trace("Populating HasBody Lookup from [" + TweakNewBodyDataSize + "] BodyData entries")
	while (i < TweakNewBodyDataSize)
		fl = pTweakNewBodyData.GetAt(i) As FormList
		if (fl && fl.GetSize() > 0)
			ab = fl.GetAt(0) as ActorBase
			if (ab) ; && (pHasBody.Find(ab) < 0)
				pHasBody.Add(ab)
			endIf
		endIf
		i += 1
	endwhile
	
EndFunction

Function AftReset()
	Trace("============= AftReset() ================")
	Actor pc = Game.GetPlayer()
	pHasBody.Clear()
	TerminalTarget          = None
	TerminalTargetId        = 0
	pRaceInvFixHintShow     = False
	pSculptLeveledHintShown = False
	pAppearanceHintShown    = False
	TerminalTargetLeveled   = False
	ComeAlongStrong			= None
	ComeAlongDog			= None
	pHasBody.Clear()
	ComeAlongTopics.Clear()
	TestTogggle = 0
	
	FollowersScript pFollowersScript = (pFollowers AS FollowersScript)
	if pFollowersScript
		pTweakLoiterCooldown.SetValue(30.0)
		pFollowersScript.SetStandardLoiterCoolDownTime(pTweakLoiterCooldown.GetValue())
	endIf
	
	pc.RemoveItem(pTweakReadme, 999, true)
	pc.RemoveItem(pTweakActivateAFT,999,true)
	pc.RemoveItem(pTweakHoloTape, 999, true)
	
	if (1.0 == pTweakAllowMultInterjections.GetValue())	
		pTweakAllowMultInterjections.SetValue(0.0)
		AFT:TweakInterjectionQuestScript  pTweakInterjectionQuestScript  = pTweakInterjections as AFT:TweakInterjectionQuestScript	
		if pTweakInterjectionQuestScript
			pTweakInterjectionQuestScript.UnRegisterInterjections()
		endIf
	endIf
	
EndFUnction


; This is mostly used to consildate threads into a single Camp Refresh when 
; Pipboy is open. May eventually be expanded to support non-camp related functions. 
Event OnTimer(int aiTimerID)
	pTweakCloseTerminal.SetValue(0.0)
	
	if (REFRESH_CAMP == aiTimerID)
		Trace("OnTImer : REFRESH_CAMP")
		Actor pc = Game.GetPlayer()
		AFT:TweakShelterScript pTweakShelterScript = (pTweakFollower as AFT:TweakShelterScript)
		if (!pTweakShelterScript)
			Trace("TweakShelterScript Cast Failure")			
			return
		endIf
		ObjectReference camp = pTweakShelterScript.pShelterMapTeleport.GetReference()
		if (!camp)
			Trace("Camp is None")
			return
		endIf
		float distance = pc.GetDistance(camp)
		if (distance > 3000)
			Trace("Player too far away [" + distance + "]")
			return
		endIf
		Trace("Calling MakeCamp(true)")
		pTweakShelterScript.MakeCamp(true)
		return
	endIf
	
	if (TEARDOWN_CAMP == aiTimerID)
		Trace("OnTImer : TEARDOWN_CAMP")
		CancelTimer(REFRESH_CAMP)
		Actor pc = Game.GetPlayer()
		AFT:TweakShelterScript pTweakShelterScript = (pTweakFollower as AFT:TweakShelterScript)
		if (!pTweakShelterScript)
			Trace("TweakShelterScript Cast Failure")			
			return
		endIf
		ObjectReference camp = pTweakShelterScript.pShelterMapTeleport.GetReference()
		if (!camp)
			Trace("Camp is None")
			return
		endIf
		float distance = pc.GetDistance(camp)
		if (distance < 2000)
			Trace("Tearing Down Camp")
			pTweakShelterScript.TearDownCamp(false)
			return
		endIf

		Trace("Player too far away for immediate teardown [" + distance + "]")		
		float CampAvailableTS = pTweakCampAvailableTS.GetValue()
		float CurrentGameTime = Utility.GetCurrentGameTime()
		if (CurrentGameTime < CampAvailableTS)
			pTweakAvailableIn.Show((24 * (CampAvailableTS - CurrentGameTime)) as Int)
			return
		endIf
	
		pTweakCampAvailableTS.SetValue(Utility.GetCurrentGameTime() + 1.0)		
		pTweakShelterScript.TearDownCamp(true)
		return
	endIf
	
	if (BEAMUP_CAMP == aiTimerID)
		CancelTimer(REFRESH_CAMP)
		AFT:TweakShelterScript pTweakShelterScript = (pTweakFollower as AFT:TweakShelterScript)
		if (!pTweakShelterScript)
			Trace("TweakShelterScript Cast Failure")			
			return
		endIf
		Trace("Refreshing Camp with Beamup")
		pTweakShelterScript.MakeCamp(true, true)
		return
	endIf
			
EndEvent

Function EventPlayerIsFirstPerson()
	PlayerIsFirstPerson = true
EndFunction

Function EventPlayerIsThirdPerson()
	PlayerIsFirstPerson = false
EndFunction

; Return true if delay occured Sheathing Weapon.
Bool Function PlayerSheathe()
	Actor pc = Game.GetPlayer()
	if pc.IsWeaponDrawn()
		InputEnableLayer sheatheLayer = None
		if PlayerIsFirstPerson
			sheatheLayer = InputEnableLayer.Create()
		endIf			
		if (!sheatheLayer)
			; Either it failed or we are in 3rd person...
			Idle pRaiderSheath =  Game.GetForm(0x00017ADD) as Idle
			if PlayerIsFirstPerson
				Game.ForceThirdPerson()
				Utility.wait(0.5)
			endIf
			pc.PlayIdle(pRaiderSheath)
			if PlayerIsFirstPerson
				Utility.wait(0.5)
				Game.ForceFirstPerson()
				return true
			endIf
		else
			Utility.wait(1.2)
			sheatheLayer.DisablePlayerControls(abMovement = false, abMenu=false, abActivate=false, abVATS=false, abFavorites=false)
			Utility.wait(0.1)
			sheatheLayer.Reset()
			sheatheLayer.Delete()
			sheatheLayer = None
			return true
		endIf
	endIf
	return false
	
EndFunction

Function SetCompanionRelay()

	Trace("SetCompanionRelay()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("SetCompanionRelay", params)
		return
	endIf

	if TerminalTarget
		Topic theTopic
		ActorBase base = TerminalTarget.GetActorBase()
		if (base == Game.GetForm(0x0001D15C) as ActorBase) ; DOGMEAT
			theTopic = ComeAlongDog
		elseif (base == Game.GetForm(0x00027682) as ActorBase) ; STRONG
			theTopic = ComeAlongStrong
		else
			theTopic = ComeAlongTopics[Utility.RandomInt(0,6)]
		endIf
		
		if theTopic
			Actor pc = Game.GetPlayer()
			pc.Say(theTopic, pc, false, (TerminalTarget as ObjectReference))
			if pc.IsTalking()
				int maxwait = 15
				while (pc.IsTalking() && maxwait > 0)
					Utility.wait(0.5)
					maxwait -= 1
				endwhile
			endIf
		endIf

		AFT:TweakDFScript pTweakDFScript = (pFollowers AS AFT:TweakDFScript)
		if (pTweakDFScript)
			Trace("Calling DFScript SetCompanion for ID [" + TerminalTargetID + "]")
			pTweakDFScript.SetCompanion(TerminalTarget, true, true, true)
		endIf
		
		; Say Acknowledgment
		SpeakDialogue(TerminalTarget, pTweakTopicAck, pTweakTopicAckModID, "pTweakTopicAck")
		
	endIf
	
endFunction

Function ViewReadmeRelay()

	Trace("ViewReadmeRelay()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("ViewReadmeRelay", params)
		return
	endIf
	
	Actor pc = Game.GetPlayer()
	pc.RemoveItem(pTweakReadme, 999, true)
	Utility.wait(0.25)
	
	ObjectReference aftReadMe = pc.PlaceAtMe(pTweakReadme)
	if (aftReadMe)
		Float [] infront=TraceCircle(pc, 50, 0)
		aftReadMe.SetPosition(infront[0],infront[1],infront[2])
		aftReadMe.Activate(Game.GetPlayer())
		; Wait until they close the book:
		Utility.wait(0.5)
	endIf
	; Did they take it?
	if (0 == pc.GetItemCount(pTweakReadme))
		; It is on the ground...
		aftReadMe.Disable(true)
		aftReadMe.Delete()
		aftReadMe=None
		pc.AddItem(pTweakReadme)
	endIf
EndFUnction

Function SalvageUFO()
	Trace("SalvageUFO()")
	pTweakCampUFOEnabled.SetValue(1.0)
	AFT:TweakShelterScript pTweakShelterScript = (pTweakFollower as AFT:TweakShelterScript)
	if !pTweakShelterScript
		Trace("Cast to pTweakShelterScript failure")
		return
	endIf
	ObjectReference camp = pTweakShelterScript.pShelterMapTeleport.GetReference()
	if !camp
		Trace("camp is None...")
		return
	endIf
	float distance = Game.GetPlayer().GetDistance(camp)
	if (distance > 2500)
		Trace("distance > 2500 [" + distance + "]")
		return
	endIf
	if (!pTweakShelterScript.ShelterSetup)
		Trace("ShelterSetup is false....")
		return
	endIf
	pTweakCampUFOEnabled.SetValue(2.0)
	RefreshCamp()
EndFunction

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

; This is called from the Camp Terminal, so dont wait for menumode to end...
Function RefreshCamp()
	Trace("RefreshCamp()")
	AFT:TweakShelterScript pTweakShelterScript = (pTweakFollower as AFT:TweakShelterScript)
	if (pTweakShelterScript)
		if (!pTweakShelterScript.ShelterSetup)
			Trace("TweakShelterScript.ShelterSetup is false. Skipping")
			return
		endIf
	else
		Trace("TweakShelterScript Cast Failure()")
	endIf	
	Trace("STARTING TIMER")
	StartTimer(0.2,REFRESH_CAMP)
EndFunction

; Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
    ; if (asMenuName== "TerminalMenu")
        ; if (!abOpening)
			; UnregisterForMenuOpenCloseEvent("TerminalMenu")			
			; if (0 == DoOnTerminalClose)
				; return
			; endIf
			; AFT:TweakShelterScript pTweakShelterScript = (pTweakFollower as AFT:TweakShelterScript)
			; if pTweakShelterScript
				; if (1 == DoOnTerminalClose)
					; Trace("Refreshing Camp")
					; pTweakShelterScript.MakeCamp(true)
					; return
				; endIf
				; if (2 == DoOnTerminalClose)
					; Trace("Tearing Down Camp")
					; pTweakShelterScript.TearDownCamp(false)
					; return
				; endIf
			; else
				; Trace("Unable to cast pTweakFollower to TweakShelterScript")
			; endIf	
        ; endIf
    ; endIf
; endEvent

Function BeamMeUpRelay()
	Trace("BeamMeUpRelay()")
	pTweakCloseTerminal.SetValue(1.0)
	StartTimer(0.1,BEAMUP_CAMP)		
EndFunction
	
Function TearDownCampRelay()
	Trace("TearDownCampRelay()")
	pTweakCloseTerminal.SetValue(1.0)
	StartTimer(0.1, TEARDOWN_CAMP)
EndFunction


Function ManageOutfits()
    StandardOutfitSnapshotRelay()
EndFunction

Function UnManageOutfits()

	Trace("UnManageOutfits()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("UnManageOutfits", params)
		return		
	endIf
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.UnManageOutfits(TerminalTarget)
		TerminalTargetHasCombatOutfit   = false
		pTweakTargetHasHomeOutfit.SetValue(0)
		TerminalTargetHasCityOutfit     = false
		TerminalTargetHasCampOutfit     = false
		TerminalTargetHasStandardOutfit = false
	endIf	
	
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

Function CombatOutfitSnapshotRelay()

	Trace("CombatOutfitSnapshotRelay()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("CombatOutfitSnapshotRelay", params)
		return
	endIf

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.SetTweakOutfit(TerminalTarget, 1)
	endIf

endFunction
	
Function HomeOutfitSnapshotRelay()

	Trace("HomeOutfitSnapshotRelay()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("HomeOutfitSnapshotRelay", params)
		return
	endIf

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.SetTweakOutfit(TerminalTarget, 2)
	endIf

endFunction

Function CityOutfitSnapshotRelay()

	Trace("CityOutfitSnapshotRelay()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("CityOutfitSnapshotRelay", params)
		return
	endIf
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.SetTweakOutfit(TerminalTarget, 3)
	endIf

endFunction

Function CampOutfitSnapshotRelay()

	Trace("CampOutfitSnapshotRelay()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("CampOutfitSnapshotRelay", params)
		return
	endIf

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.SetTweakOutfit(TerminalTarget, 4)
	endIf
	
endFunction

Function StandardOutfitSnapshotRelay()

	Trace("StandardOutfitSnapshotRelay()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("StandardOutfitSnapshotRelay", params)
		return
	endIf

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.SetTweakOutfit(TerminalTarget, 5)
	endIf
	
endFunction


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
Function CombatOutfitReset()

	Trace("CombatOutfitReset()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("CombatOutfitReset", params)
		return
	endIf

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.ClearTweakOutfit(TerminalTarget, 1)
		TerminalTargetHasCombatOutfit = false
	endIf

endFunction
	
Function HomeOutfitReset()

	Trace("HomeOutfitReset()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("HomeOutfitReset", params)
		return
	endIf

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.ClearTweakOutfit(TerminalTarget, 2)
		pTweakTargetHasHomeOutfit.SetValue(0)
	endIf

endFunction

Function CityOutfitReset()

	Trace("CityOutfitReset()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("CityOutfitReset", params)
		return
	endIf

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.ClearTweakOutfit(TerminalTarget, 3)
		TerminalTargetHasCityOutfit = false
	endIf

endFunction

Function CampOutfitReset()

	Trace("CampOutfitReset()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("CampOutfitReset", params)
		return
	endIf

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.ClearTweakOutfit(TerminalTarget, 4)
		TerminalTargetHasCampOutfit = false
	endIf
	
endFunction

Function StandardOutfitReset()

	Trace("StandardOutfitReset()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("StandardOutfitReset", params)
		return
	endIf

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.ClearTweakOutfit(TerminalTarget, 5)
		TerminalTargetHasStandardOutfit = false
	endIf
	
endFunction

Function ClearAllOutfitsRelay()
	Trace("ClearAllOutfitsRelay()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("ClearAllOutfitsRelay", params)
		return
	endIf

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.ClearAllOutfits(TerminalTarget)
		TerminalTargetHasCombatOutfit   = false
		pTweakTargetHasHomeOutfit.SetValue(0)
		TerminalTargetHasCityOutfit     = false
		TerminalTargetHasCampOutfit     = false
		TerminalTargetHasStandardOutfit = false
	endIf

endFunction

Function ExitPowerArmorRelay()
	Trace("ExitPowerArmorRelay()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("ExitPowerArmorRelay", params)
		return
	endIf

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.ExitPowerArmorByNameId(TerminalTargetId)
	endIf
EndFunction

Function MakeCampRelay()

	Trace("MakeCampRelay()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("MakeCampRelay", params)
		return
	endIf
	
	If 0 != TerminalTargetId
		SpeakDialogue(TerminalTarget, pTweakTopicAck, pTweakTopicAckModID, "pTweakTopicAck")
	endIf
		
	AFT:TweakShelterScript pTweakShelterScript = (pTweakFollower as AFT:TweakShelterScript)
	if pTweakShelterScript
		pTweakCampAvailableTS.SetValue(0.0)
		pTweakShelterScript.MakeCamp()
		if (pTweakShelterScript.ShelterSetup)
			if (!pTweakExpandCamp.IsRunning() && pTweakExpandCamp.GetStage() < 10)
				if pTweakExpandCamp.Start()
					pTweakExpandCamp.SetActive()
				else
					Trace("Failed to start TweakExpandCamp")
				endIf
			endIf
		endIf
	else
		Trace("Unable to cast pTweakFollower to TweakShelterScript")
	endIf
	
endFunction

Function ResetBuildLimit()

	Trace("ResetBuildLimit()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("ResetBuildLimit", params)
		return
	endIf
	
	WorkshopParentScript WorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
	WorkshopScript 		 WorkshopRef    = WorkshopParent.GetWorkshopFromLocation(Game.GetPlayer().GetCurrentLocation())
	WorkshopRef.CurrentTriangles=0
	WorkshopRef.SetValue(WorkshopParent.WorkshopCurrentTriangles, 0)				
	WorkshopRef.currentDraws=0
	WorkshopRef.SetValue(WorkshopParent.WorkshopCurrentDraws, 0)

endFunction

Function GetPlayerPowerArmor()

	Trace("GetPlayerPowerArmor()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("GetPlayerPowerArmor", params)
		return
	endIf

	Actor player = Game.GetPlayer()
	if !player.WornHasKeyword(pArmorTypePower)
		; LinkedRef Managed by TweakMonitorPlayer Quest....
		ObjectReference pa = player.GetLinkedRef(pLinkPowerArmor)
		if (pa && pa.GetLinkedRef(pLinkPowerArmor) == player)
			float[] posdata = TraceCircle(player, 200, 45)
			ObjectReference spawnMarker = player.PlaceAtMe(Game.GetForm(0x00024571))
			spawnMarker.SetPosition(posdata[0],posdata[1],posdata[2])
			spawnMarker.MoveToNearestNavmeshLocation()
			spawnMarker.SetAngle(0.0,0.0, player.GetAngleZ() - 45)
			if (!pa.Is3DLoaded())
				pa.MoveTo(spawnMarker)
			else
				pa.SetPosition(spawnMarker.GetPositionX(), spawnMarker.GetPositionY(), spawnMarker.GetPositionZ())
				pa.SetAngle(0.0,0.0, spawnMarker.GetAngleZ())
			endIf
			pa.Disable()
			pa.Enable()
			Utility.wait(0.1)	
		endIf
	endIf
EndFunction

int PrefabIndex = 0
Function StartPrefab()
  Game.RequestSave()
  PrefabIndex = 0
  ShowPrefab()
EndFunction

Function NextPrefab()
  PrefabIndex += 1
  ShowPrefab()
EndFunction

Function PrevPrefab()
  PrefabIndex -= 1
  ShowPrefab()
EndFunction

Function ShowPrefab()

	Utility.waitmenumode(0.1)
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("ShowPrefab", params)
		return
	endIf

    Keyword TweakPrefabs = Game.GetFormFromFile(0x0100EF7B,"AmazingFollowerTweaks.esp") as Keyword
	if !TweakPrefabs
		Trace("No TweakPrefabs")
		return
	endIf		
	WorkshopParentScript WorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
	if !WorkshopParent
		Trace("No WorkshopParent")
		return
	endIf
	WorkshopScript WorkshopRef = WorkshopParent.GetWorkshopFromLocation(Game.GetPlayer().GetCurrentLocation())
	if !WorkshopRef
		Trace("No WorkshopRef (For current location) Found")
		return
	endIf
	; if !WorkshopRef.OwnedByPlayer
		; Trace("Workshop Not Owned")
		; pWorkshopUnownedMessage.Show()
		; return None
	; endIf            
	
	ObjectReference[] local_prefabs = WorkshopRef.GetRefsLinkedToMe(TweakPrefabs)
	if 0 == local_prefabs.length
		Trace("No Prefabs")
		; "No prefabs have been defined for this settlement"
		pTweakFailNoPrefab.ShowOnPipBoy()
		return
	endIf
		
	if (PrefabIndex < 0)
		PrefabIndex = (local_prefabs.length - 1)
	endIf

    if PrefabIndex > (local_prefabs.length - 1)
		PrefabIndex
	endIf

	TweakPrefabOption pTweakPrefab = local_prefabs[PrefabIndex] as TweakPrefabOption
	if (!pTweakPrefab)
		Trace("ObjectReference did not cast to TweakPrefabOption")
		; "This Prefab is Not compatible or Incorrectly configured."
		pTweakFailBadPrefab.ShowOnPipBoy()
		return
	endIf
	if (!pTweakPrefab.PrefabTerminal)
		Trace("TweakPrefabOption did not provide a Terminal")
		; "This Prefab is Not compatible or Incorrectly configured."
		pTweakFailBadPrefab.ShowOnPipBoy()
		return
	endIf
	
	if 0 == PrefabIndex	
		Trace("PrefabIndex == 0, Setting Show Previous to False")
		TweakPrefabShowPrev.SetValue(0.0)
	else
		Trace("PrefabIndex > 0, Setting Show Previous to True")
		TweakPrefabShowPrev.SetValue(1.0)
	endIf
	
	if PrefabIndex == (local_prefabs.length - 1)	
		Trace("PrefabIndex = prefabs.length (-1). Setting Show Next to False")
		TweakPrefabShowNext.SetValue(0.0)
	else
		Trace("PrefabIndex < prefabs.length (-1). Setting Show Next to True")
		TweakPrefabShowNext.SetValue(1.0)
	endIf
	
	if pTweakPrefab.PrefabHasFullOption
		Trace("pTweakPrefab.PrefabHasFullOption is TRUE. Setting TweakPrefabShowFull to TRUE")
		TweakPrefabShowFull.SetValue(1.0)
	else
		Trace("pTweakPrefab.PrefabHasFullOption is FALSE. Setting TweakPrefabShowFull to False")
		TweakPrefabShowFull.SetValue(0.0)
	endIf

	if pTweakPrefab.PrefabHasWallOnlyOption
		Trace("pTweakPrefab.PrefabHasWallOnlyOption is TRUE. Setting TweakPrefabShowWall to True")
		TweakPrefabShowWall.SetValue(1.0)
	else
		Trace("pTweakPrefab.PrefabHasWallOnlyOption is FALSE. Setting TweakPrefabShowWall to False")
		TweakPrefabShowWall.SetValue(0.0)
	endIf
		
	; TODO : Update Globals to Control What shows up on PrefabTerminal
	pTweakPrefab.PrefabTerminal.ShowOnPipBoy()
	
EndFunction

Function BuildFullPrefab()
	Utility.waitmenumode(0.1)
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("BuildFullPrefab", params)
		return
	endIf
	BuildPrefab(1)
endFunction

Function BuildWallOnlyPrefab()
	Utility.waitmenumode(0.1)
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("BuildWallOnlyPrefab", params)
		return
	endIf
	BuildPrefab(0)
endFunction

Function BuildPrefab(int type)

    Keyword TweakPrefabs = Game.GetFormFromFile(0x0100EF7B,"AmazingFollowerTweaks.esp") as Keyword
	if !TweakPrefabs
		Trace("No TweakPrefabs")
		return
	endIf		
	WorkshopParentScript WorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
	if !WorkshopParent
		Trace("No WorkshopParent")
		return
	endIf
	WorkshopScript WorkshopRef = WorkshopParent.GetWorkshopFromLocation(Game.GetPlayer().GetCurrentLocation())
	if !WorkshopRef
		Trace("No WorkshopRef")
		return
	endIf
	; if !WorkshopRef.OwnedByPlayer
		; Trace("Workshop Not Owned")
		; pWorkshopUnownedMessage.Show()
		; return None
	; endIf            
	
	ObjectReference[] local_prefabs = WorkshopRef.GetRefsLinkedToMe(TweakPrefabs)
	if 0 == local_prefabs.length
		; TODO : "No prefabs have been defined for this settlement"
		Trace("No Prefabs")
		return
	endIf
		
	if (PrefabIndex < 0)
		Trace("Unexpected Negative Index")
		return
	endIf

    if PrefabIndex > (local_prefabs.length - 1)
		Trace("Unexpected Index (Too Large)")
		return
	endIf

	TweakPrefabOption pTweakPrefab = local_prefabs[PrefabIndex] as TweakPrefabOption
	if (!pTweakPrefab)
		; TODO: "This Prefab is Not compatible or Incorrectly configured."
		Trace("ObjectReference did not cast to TweakPrefabOption")
		return
	endIf
	
	pTweakPrefab.Load(type)
	
EndFunction

Function ToggleReadyWeapon(bool backToPip=True)
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("ToggleReadyWeapon", params)
		return
	endIf

	if TerminalTarget.HasKeyword(pTeammateReadyWeapon_DO)
		TerminalTarget.RemoveKeyword(pTeammateReadyWeapon_DO)
		if TerminalTarget.IsInFaction(pTweakReadyWeaponFaction)
			TerminalTarget.RemoveFromFaction(pTweakReadyWeaponFaction)
		endIf
		TerminalTargetReadyWeapon = false
	else
		TerminalTarget.AddKeyword(pTeammateReadyWeapon_DO)
		if !TerminalTarget.IsInFaction(pTweakReadyWeaponFaction)
			TerminalTarget.AddToFaction(pTweakReadyWeaponFaction)
		endIf
		TerminalTargetReadyWeapon = true
	endIf	
	
	if backToPip
		pTweakSettingsAITerminal.ShowOnPipBoy()
	endIf
	
EndFunction


Function SetConfidenceRelay(int value, bool backToPip=True)
	Utility.waitmenumode(0.1)
	
	Trace("SetConfidenceRelay()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[2]
		params[0] = value
		params[1] = backToPip
		self.CallFunctionNoWait("SetConfidenceRelay", params)
		return
	endIf

	If !TerminalTarget
		Trace("No Terminal Target")
		return
	endIf

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.SetConfidence(TerminalTarget, value)
		TerminalTargetConfidence = value
	endIf

	if backToPip
		pTweakCombatCaution.ShowOnPipBoy()
	endIf
	
EndFUnction


; ChangeRace Options:
; NOTE: Most robots (8-12) wont work unless the original race matched.
;
;   0  = Human
;   1  = Ghoul
;   2  = Supermutant
;   3  = Synth Gen1
;   4  = Synth Gen2 (or Valentine if Valentine)
;   5  = RaiderDig/Vicious/FEVHound
;   6  = ViciousDog
;   7  = FEVHound
;   8  = EyeBot
;   9  = Handy
;   10 = Protectron		
;   11 = SentryBot
;   12 = Assaultron
;   13 = DeathClaw
;   14 = SuperMutantBehemoth

Function ChangeRace(int option)
	Utility.waitmenumode(0.1)
	
	Trace("ChangeRace()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = option
		self.CallFunctionNoWait("ChangeRace", params)
		return
	endIf

	If !TerminalTarget
		Trace("No Terminal Target")
		return
	endIf

	if (1.0 == TerminalTarget.GetValue(pTweakInPowerArmor) || TerminalTarget.WornHasKeyword(pArmorTypePower))
		Trace("Follower in Power Armor. Aborting")
		pTweakVisualFailPowerArmor.ShowOnPipBoy()
		return
	endIf	
	
	If !TerminalTarget.GetActorBase().isUnique()
		Trace("Terminal Target Not Unique. Bailing.")
		pTweakUniqueOnly.Show()
		return
	endIf

	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (!pTweakFollowerScript)
		Trace("Failure to cast to TweakFOllowerScript")	
	endIf

	; Backup, incase they werent initialized properly. 
	int orace = TerminalTarget.GetValue(pTweakOriginalRace) as Int
	if 0 == orace
		TerminalTarget.SetValue(pTweakOriginalRace, TerminalTarget.GetRace().GetFormID())
	endIf
	
	race targetrace = None
	if TerminalTarget && pTweakFollowerScript
	
		if (!pRaceInvFixHintShow)
			pRaceInvFixHintShow = True
			pTweakInvisibleFix.Show()
		endIf
		
		if 0 == option
			Trace("Setting TerminalTarget to Human")
			targetrace = pHumanRace
		elseif 1 == option
			Trace("Setting TerminalTarget to Ghoul")
			targetrace = pGhoulRace
		elseif 2 == option
			Trace("Setting TerminalTarget to SuperMutant")
			targetrace = pSuperMutantRace
		elseif 3 == option
			Trace("Setting TerminalTarget to SynthGen1")
			targetrace = pSynthGen1Race
		elseif 4 == option
			if 9 == TerminalTargetOId
				Trace("Setting TerminalTarget to SynthGen2RaceValentine")
				targetrace = pSynthGen2RaceValentine
			else
				Trace("Setting TerminalTarget to SynthGen2Race")
				targetrace = pSynthGen2Race
			endIf			
		elseif 5 == option
			Trace("Setting TerminalTarget to RaiderDogRace")
			targetrace = pRaiderDogRace
		elseif 6 == option
			Trace("Setting TerminalTarget to ViciousDogRace")
			targetrace = pViciousDogRace
		elseif 7 == option
			Trace("Setting TerminalTarget to FEVHoundRace")
			targetrace = pFEVHoundRace
		elseif 8 == option
			Trace("Setting TerminalTarget to EyeBotRace")
			targetrace = pEyeBotRace
		elseif 9 == option
			Trace("Setting TerminalTarget to HandyRace")
			targetrace = pHandyRace
		elseif 10 == option
			Trace("Setting TerminalTarget to ProtectronRace")
			targetrace = pProtectronRace
		elseif 11 == option
			Trace("Setting TerminalTarget to SentryBotRace")
			targetrace = pSentryBotRace
		elseif 12 == option
			Trace("Setting TerminalTarget to AssaultronRace")
			targetrace = pAssaultronRace
		elseif 13 == option
			Trace("Setting TerminalTarget to DeathClawRace")
			targetrace = pDeathClawRace
		elseif 14 == option
			Trace("Setting TerminalTarget to SuperMutantBehemothRace")
			targetrace = pSuperMutantBehemothRace
		else
			Trace("Unknown Race Option [" + option + "]")
		endIf
		
		if targetrace
		
			; No point in saving off gear as new race isn't likely compatible anyway.
			pTweakFollowerScript.ClearAllOutfits(TerminalTarget)
			pTweakFollowerScript.UnEquipAllGear(TerminalTarget)
		
			; Force current race textures and body data to unload.
			TerminalTarget.SetRace(pTweakInvisibleRace)
			Utility.wait(0.5)
			int maxwait = 10
			while (TerminalTarget.GetRace() != pTweakInvisibleRace && maxwait > 0)
				Utility.wait(0.5)
				maxwait -= 1
			endWhile

			; Now load race into clean space
			TerminalTarget.SetRace(targetrace)
			Utility.wait(0.5)
			maxwait = 10
			while (TerminalTarget.GetRace() != targetrace && maxwait > 0)
				Utility.wait(0.5)
				maxwait -= 1
			endWhile

			; Sometimes new races will equip default weapon which can cause 
			; odd things. So strip them down again
			
			pTweakFollowerScript.UnEquipAllGear(TerminalTarget)
			
			if TerminalTarget.HasKeyword(pActorTypeSynth)
			
				; Removing this keyword will allow synth bodies
				; to use furniture (Like PowerArmor)
				
				TerminalTarget.RemoveKeyword(pActorTypeSynth)
				
			endIf
		endIf
	endIf

	
	Trace("Done")
	
EndFunction

Function ToggleIgnoreFriendlyHits(bool backToPip=True)
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("ToggleIgnoreFriendlyHits", params)
		return
	endIf

	if TerminalTarget.IsIgnoringFriendlyHits()
		TerminalTarget.IgnoreFriendlyHits(false)
		TerminalTargetIgnoreFriendlyHits = false
		if !TerminalTarget.IsInFaction(TweakAllowFriendlyFire)
			TerminalTarget.AddToFaction(TweakAllowFriendlyFire)
		endIf
	else
		TerminalTarget.IgnoreFriendlyHits(true)
		TerminalTargetIgnoreFriendlyHits = true
		if TerminalTarget.IsInFaction(TweakAllowFriendlyFire)
			TerminalTarget.RemoveFromFaction(TweakAllowFriendlyFire)
		endIf
	endIf
	
	if backToPip
		pTweakCombatAITerminal.ShowOnPipBoy()
	endIf
	
EndFunction

Function TogglePackMule(bool backToPip=True)
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("TogglePackMule", params)
		return
	endIf

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)	
	if (pTweakFollowerScript && TerminalTarget)
		if TerminalTarget.IsInFaction(pTweakPackMuleFaction)
			TerminalTarget.RemoveFromFaction(pTweakPackMuleFaction)
			pTweakFollowerScript.SetPackMule(TerminalTarget, false)
		else
			TerminalTarget.AddToFaction(pTweakPackMuleFaction)
			pTweakFollowerScript.SetPackMule(TerminalTarget, true)
		endIf	
		TerminalTargetPackMule = TerminalTarget.IsInFaction(pTweakPackMuleFaction)
	endIf
	
	if backToPip
		pTweakSettingsTerminal.ShowOnPipBoy()
	endIf
	
EndFunction

Function ToggleSyncPA(bool backToPip=True)
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("ToggleSyncPA", params)
		return
	endIf

	if (TerminalTarget)
		bool current = TerminalTarget.IsInFaction(pTweakSyncPAFaction)
		if current
			TerminalTarget.RemoveFromFaction(pTweakSyncPAFaction)
		else
			TerminalTarget.AddToFaction(pTweakSyncPAFaction)
		endIf

		if backToPip
			TerminalTargetSyncPA = TerminalTarget.IsInFaction(pTweakSyncPAFaction)		
			if (TerminalTargetSyncPA != current)
				pTweakSettingsAITerminal.ShowOnPipBoy()
			endIf
		endIf
	endIf
EndFunction

Function ToggleAutoRelax(bool backToPip=True)

	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("ToggleAutoRelax", params)
		return
	endIf

	if (TerminalTarget)
		bool current = TerminalTarget.IsInFaction(pTweakNoRelaxFaction)
		if current
			TerminalTarget.RemoveFromFaction(pTweakNoRelaxFaction)
		else
			TerminalTarget.AddToFaction(pTweakNoRelaxFaction)
		endIf
		
		if backToPip
			TerminalTargetNoAutoRelax = TerminalTarget.IsInFaction(pTweakNoRelaxFaction)		
			if (TerminalTargetNoAutoRelax != current)
				pTweakSettingsAITerminal.ShowOnPipBoy()
			endIf
		endIf
	endIf
	
EndFunction

; ReloadScript TweakPipBoyScript
Actor PreviousTerminalTarget
Function Test()

	Trace("Test()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("Test", params)
		return
	endIf
	
	Actor pc = Game.GetPlayer()
	Utility.wait(0.1)
			
	If TerminalTarget
				
		; Scene interception?
		; Scene is owned by Quest. We know we can't get Register for Quest stages until the quest is running. 
		; So scenes may be similar.
		
		TestTogggle += 1
		if 2 == TestTogggle
			pTweakStopThat.Show()
		endIf
		if TestTogggle > 3
			int dchoice = pTweakLastWarning.Show()
			; 0  = Full Diagnostics
			; 1  = Add Cheats
			; 2  = RadStorm
			; 3  = Spouse Friend
			; 4  = Spouse Admiration
			; 5  = Spouse Confidant
			; 6  = Spouse Infatuated
			; 7  = Energy Shield
			; 8  = Synth Eyes
			; 9  = Sculpt Curie
			; 10 = Cancel
			
			Trace("Diagnostics Choice [" + dchoice + "]")
			if 10 == dchoice
				return
			endIf
			
			if (0 == dchoice)
				AFT:TweakDiagnostics pTweakDiagnostics = (self as Quest) as AFT:TweakDiagnostics
				if pTweakDiagnostics
					pTweakDiagnostics.RunDiagnostics(TerminalTarget)
				else
					Trace("Failed to cast TweakDiagnostics")
				endIf
			endIf
			if (1 == dchoice)
				; Money/Items Cheats for testing
				pc.AddItem(Game.GetForm(0x0000000F), 50000)
				Container qaBookChest = Game.GetForm(0x001E7DA6) as Container
				float[] p = TraceCircle(pc,120)
				ObjectReference bChest = pc.PlaceAtMe(qaBookChest)
				bChest.SetPosition(p[0],p[1],p[2])
				bChest.SetAngle(0.0,0.0, pc.GetAnglex() - 180)
				bChest.AddItem(Game.GetForm(0x00216215))
				Container qaArmorChest = Game.GetForm(0x001E7DA2) as Container
				p = TraceCircle(pc,-120)
				ObjectReference aChest = pc.PlaceAtMe(qaArmorChest)
				aChest.SetPosition(p[0],p[1],p[2])
				aChest.SetAngle(0.0,0.0, pc.GetAnglex())
			endIf
			if (2 == dchoice)
				Weather CommonwealthGSRadstorm = Game.GetForm(0x001C3D5E) as Weather
				CommonwealthGSRadstorm.ForceActive()
			endIf
			if (dchoice > 2 && dchoice < 7)
				Quest TweakCOMSpouse = Game.GetFormFromFile(0x0104529E,"AmazingFollowerTweaks.esp") as Quest
				if TweakCOMSpouse
					ReferenceAlias Spouse = (TweakCOMSpouse.GetAlias(8) as ReferenceAlias)
					if Spouse
						Actor theSpouse = Spouse.GetActorReference()
						if theSpouse && !theSpouse.IsDead() && theSpouse.IsInFaction(pCurrentCompanionFaction)
							if 3 == dchoice
								ActorValue CA_Affinity   = Game.GetForm(0x000A1B80) as ActorValue
								theSpouse.SetValue(CA_Affinity, 239.0)
								Utility.wait(1.0)
								Keyword CA_CustomEvent_PrestonLoves = Game.GetForm(0x001716C2) as Keyword
								FollowersScript.SendAffinityEvent(self, CA_CustomEvent_PrestonLoves, ShouldSuppressComment = false, IsDialogueBump = true)					
							elseif 4 == dchoice
								ActorValue CA_Affinity   = Game.GetForm(0x000A1B80) as ActorValue
								theSpouse.SetValue(CA_Affinity, 499.0)
								Utility.wait(1.0)
								Keyword CA_CustomEvent_PrestonLoves = Game.GetForm(0x001716C2) as Keyword
								FollowersScript.SendAffinityEvent(self, CA_CustomEvent_PrestonLoves, ShouldSuppressComment = false, IsDialogueBump = true)
							elseif 5 == dchoice
								ActorValue CA_Affinity   = Game.GetForm(0x000A1B80) as ActorValue
								theSpouse.SetValue(CA_Affinity, 749.0)
								Utility.wait(1.0)
								Keyword CA_CustomEvent_PrestonLoves = Game.GetForm(0x001716C2) as Keyword
								FollowersScript.SendAffinityEvent(self, CA_CustomEvent_PrestonLoves, ShouldSuppressComment = false, IsDialogueBump = true)
							elseif 6 == dchoice
								ActorValue CA_Affinity   = Game.GetForm(0x000A1B80) as ActorValue
								theSpouse.SetValue(CA_Affinity, 999.0)
								Utility.wait(1.0)
								Keyword CA_CustomEvent_PrestonLoves = Game.GetForm(0x001716C2) as Keyword
								FollowersScript.SendAffinityEvent(self, CA_CustomEvent_PrestonLoves, ShouldSuppressComment = false, IsDialogueBump = true)
							endIf
						else
							trace("Spouse Reference Unfilled")
						endIf
					else
						trace("GetAlias(8) did not cast to ReferenceAlias (Is Quest Running?)")
					endIf
				else
					trace("Quest TweakCOMSpouse not found")
				endIf						
			endIf
			if (7 == dchoice)
				; EnergyShield : UFO Tech Upgrade?
				MovableStatic Ms09ForceField = Game.GetForm(0x001E2F2B) as MovableStatic
				float[] postdata = TraceCircle(pc,200)
				ObjectReference mfx = pc.PlaceAtMe(Ms09ForceField)
				mfx.SetAngle(0.0,0.0, pc.GetAnglex() - 180)
				Utility.wait(0.1)
			endIf
			if (8 == dchoice)
				; DetectLife (Need to add this to a pair of glasses)
				Spell TweakTargetingHud = Game.GetFormFromFile(0x010045B9,"AmazingFollowerTweaks.esp") as Spell
				if pc.HasSpell(TweakTargetingHud)
					Trace("Removing TweakTargetingHud")
					pc.DispelSpell(TweakTargetingHud)
					pc.RemoveSpell(TweakTargetingHud)
				else
					Trace("AddSpell [" + TweakTargetingHud + "]")				
					pc.AddSpell(TweakTargetingHud,false)
					TweakTargetingHud.Cast(pc)
				endIf
			endIf
			if (9 == dchoice)
				AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
				pTweakFollowerScript.SculptLeveledByNameId(3)
			endIf			
		endIf
	else
		TestTogggle = 0
	endIf
EndFunction

Function AppearanceHint()
	if !pAppearanceHintShown
		pTweakAppearanceHint.show()
		pAppearanceHintShown = true
	endIf
EndFunction


Function EvaluateTerminalTarget()

	if (TerminalTarget)

		if (pHasBody.find(TerminalTarget.GetActorBase()) > -1)
			TerminalTargetHasBody = 1
		else
			TerminalTargetHasBody = 0
		endIf		

		TerminalTargetId     = TerminalTarget.GetFactionRank(pTweakNamesFaction)
		if (TerminalTargetId > 0)
			Trace("Id in Names Faction is [" + TerminalTargetId + "]")
			; SPECIAL CASE: If Curie and her quest is not yet done:
			if (3 == TerminalTargetId && pCOMCurieQuest.GetStage() < 500)
				TerminalTargetHasBody = 0
			endIf			
		else
			Trace("No ID Found in Names Faction Lookup")
		endIf
		
		TerminalTargetOId = TerminalTargetId
		if (TerminalTargetOId > 18)
			; Do we know this person?
			ActorBase base = TerminalTarget.GetActorBase()
			int MaskedID = base.GetFormID() % 0x01000000
			if (base == Game.GetForm(0x00079249) as ActorBase)     ; 1 ---=== Cait ===---
				TerminalTargetOId = 1
			elseif (base == Game.GetForm(0x000179FF) as ActorBase) ; 2 ---=== Codsworth ===---
				TerminalTargetOId = 2
			elseif (base == Game.GetForm(0x00027686) as ActorBase) ; 3 ---=== Curie ===---
				TerminalTargetOId = 3
			elseif (base == Game.GetForm(0x00027683) as ActorBase) ; 4 ---=== Danse ===---
				TerminalTargetOId = 4
			elseif (base == Game.GetForm(0x00045AC9) as ActorBase) ; 5 ---=== Deacon ===---
				TerminalTargetOId = 5
			elseif (base == Game.GetForm(0x0001D15C) as ActorBase) ; 6 ---=== Dogmeat ===---
				TerminalTargetOId = 6
			elseif (base == Game.GetForm(0x00022613) as ActorBase) ; 7 ---=== Hancock ===---	
				TerminalTargetOId = 7
			elseif (base == Game.GetForm(0x0002740E) as ActorBase) ; 8 ---=== MacCready ===---	
				TerminalTargetOId = 8
			elseif (base == Game.GetForm(0x00002F24) as ActorBase) ; 9 ---=== Nick Valentine ===---
				TerminalTargetOId = 9
			elseif (base == Game.GetForm(0x00002F1E) as ActorBase) ; 10 ---=== Piper ===---	
				TerminalTargetOId = 10
			elseif (base == Game.GetForm(0x00019FD9) as ActorBase) ; 11 ---=== Preston ===---
				TerminalTargetOId = 11
			elseif (base == Game.GetForm(0x00027682) as ActorBase) ; 12 ---=== Strong ===---	
				TerminalTargetOId = 12
			elseif (base == Game.GetForm(0x000BBEE6) as ActorBase) ; 13 ---=== X6-88 ===---	
				TerminalTargetOId = 13
			elseif (base == Game.GetFormFromFile(0x01048098,"AmazingFollowerTweaks.esp") as ActorBase) ; ---=== Nate ===---	
				TerminalTargetOId = 17
			elseif (base == Game.GetFormFromFile(0x01043410,"AmazingFollowerTweaks.esp") as ActorBase) ; ---=== Nora ===---	
				TerminalTargetOId = 18
			elseif 0x0000FD5A == MaskedID ; Ada
				TerminalTargetOId = 14
			elseif 0x00006E5B == MaskedID ; Longfellow
				TerminalTargetOId = 15
			elseif 0x0000881D == MaskedID ; Porter Gage
				TerminalTargetOId = 16
			endIf			
		endIf

		if TerminalTarget.IsInFaction(pTweakManagedOutfit)
			pTweakOutfitManaged.SetValue(1.0)
		else
			pTweakOutfitManaged.SetValue(0.0)			
		endIf
		
		
		if (TerminalTarget.IsInFaction(pTweakCombatOutFitFaction))
			TerminalTargetHasCombatOutfit = true
		else
			TerminalTargetHasCombatOutfit = false
		endIf
		if (TerminalTarget.IsInFaction(pTweakHomeOutFitFaction))
			pTweakTargetHasHomeOutfit.SetValue(1)
		else
			pTweakTargetHasHomeOutfit.SetValue(0)
		endIf
		
		if (TerminalTarget.IsInFaction(pTweakCityOutFaction))
			TerminalTargetHasCityOutfit = true
		else
			TerminalTargetHasCityOutfit = false
		endIf
		if (TerminalTarget.IsInFaction(pTweakCampOutFitFaction))
			TerminalTargetHasCampOutfit = true
		else
			TerminalTargetHasCampOutfit = false
		endIf
		if (TerminalTarget.IsInFaction(pCurrentCompanionFaction))
			TerminalTargetActiveFollower = true
			if !TerminalTarget.IsInFaction(pTweakFollowerFaction)
				TerminalTargetUnmanaged = true
			else
				TerminalTargetUnmanaged = false
			endIf			
		else
			TerminalTargetActiveFollower = false
			TerminalTargetUnmanaged      = false ; true when CurrentCompanionFaction but not TweakFollowerFaction
		endIf
		if (TerminalTarget.IsInFaction(pTweakStandardOutFitFaction))
			TerminalTargetHasStandardOutfit = true
		else
			TerminalTargetHasStandardOutfit = false
		endIf
		if (TerminalTarget.IsInFaction(pTweakPAHelmetCombatToggleFaction))
			TerminalTargetPAHelmetCombatOnly = true
		else
			TerminalTargetPAHelmetCombatOnly = false
		endIf
		if (TerminalTarget.IsInFaction(pTweakSyncPAFaction))
			TerminalTargetSyncPA = true
		else
			TerminalTargetSyncPA = false
		endIf
		if (TerminalTarget.IsIgnoringFriendlyHits())
			TerminalTargetIgnoreFriendlyHits = true
		else
			TerminalTargetIgnoreFriendlyHits = false
		endIf
		if (TerminalTarget.HasKeyword(pTeammateReadyWeapon_DO))
			TerminalTargetReadyWeapon = true
		else
			TerminalTargetReadyWeapon = false
		endIf
		if (TerminalTarget.IsInFaction(pTweakPackMuleFaction))
			TerminalTargetPackMule = true
		else
			TerminalTargetPackMule = false
		endIf
		if (42 == TerminalTarget.GetValue(pFavorsPerDay))
			TerminalTargetAvoidsTraps = true
		else
			TerminalTargetAvoidsTraps = false
		endIf
		if (TerminalTarget.IsInFaction(pTweakNoDisapprove))
			TerminalTargetNoDisapprove = true
		else
			TerminalTargetNoDisapprove = false
		endIf
		if (TerminalTarget.IsInFaction(pTweakNoApprove))
			TerminalTargetNoApprove = true
		else
			TerminalTargetNoApprove = false
		endIf
		if (TerminalTarget.IsInFaction(pTweakConvNegToPos))
			TerminalTargetConvNegToPos = true
		else
			TerminalTargetConvNegToPos = false
		endIf
		if (TerminalTarget.IsInFaction(pTweakConvPosToNeg))
			TerminalTargetConvPosToNeg = true
		else
			TerminalTargetConvPosToNeg = false
		endIf
		if (TerminalTarget.IsInFaction(pTweakNoIdleChatter))
			TerminalTargetNoCommentIdle = true
		else
			TerminalTargetNoCommentIdle = false
		endIf
		if (TerminalTarget.IsInFaction(pTweakNoRelaxFaction))
			TerminalTargetNoAutoRelax = true
		else
			TerminalTargetNoAutoRelax = false
		endIf
		if (TerminalTarget.IsInFaction(pTweakNoCommentGeneral))
			TerminalTargetNoCommentGeneral = true
		else
			TerminalTargetNoCommentGeneral = false
		endIf
		if (TerminalTarget.IsInFaction(pTweakNoCommentApprove))
			TerminalTargetNoCommentApprove = true
		else
			TerminalTargetNoCommentApprove = false
		endIf
		if (TerminalTarget.IsInFaction(pTweakNoCommentDisapprove))
			TerminalTargetNoCommentDisapprove = true
		else
			TerminalTargetNoCommentDisapprove = false
		endIf
		if (TerminalTarget.IsInFaction(pTweakNoCommentActivator))
			TerminalTargetNoCommentActivator = true
		else
			TerminalTargetNoCommentActivator = false
		endIf
		if (TerminalTarget.GetActorBase().IsUnique())
			TerminalTargetUnique = true
		else
			TerminalTargetUnique = false
		endIf
		
		if TerminalTarget.IsInFaction(pTweakTrackKills)
			TerminalTargetTrackKills = true
		else
			TerminalTargetTrackKills = false
		endIf
		
		if TerminalTarget.HasKeyword(pTeammateDontUseAmmoKeyword)
			TerminalTargetUseAmmo = false
		else
			TerminalTargetUseAmmo = true
		endIf
		
		if TerminalTarget.HasKeyword(pPowerArmorPreventArmorDamageKeyword)
			TerminalTargetPANoDamage = true
		else
			TerminalTargetPANoDamage = false
		endIf
				
		TerminalTargetConfidence = TerminalTarget.GetValue(pConfidence) as int
		

		if TerminalTarget.IsInFaction(pTweakGunslingerFaction)
			pTweakCombatStyle.SetValue(1)
		elseif TerminalTarget.IsInFaction(pTweakBruiserFaction)
			pTweakCombatStyle.SetValue(2)
		elseif TerminalTarget.IsInFaction(pTweakCommandoFaction)
			pTweakCombatStyle.SetValue(3)
		elseif TerminalTarget.IsInFaction(pTweakBoomstickFaction)
			pTweakCombatStyle.SetValue(4)
		elseif TerminalTarget.IsInFaction(pTweakNinjaFaction)
			pTweakCombatStyle.SetValue(5)
		elseif TerminalTarget.IsInFaction(pTweakSniperFaction)
			pTweakCombatStyle.SetValue(6)
		elseif TerminalTarget.IsInFaction(pTweakEnhancedFaction)
			pTweakCombatStyle.SetValue(7)
		else
			pTweakCombatStyle.SetValue(0)
		endIf
		
		Race tt_race = TerminalTarget.GetRace()
		if (tt_race == pHumanRace)
			TerminalTargetRace = 1
		elseif (tt_race == pGhoulRace)
			TerminalTargetRace = 2
		elseif (tt_race == pSuperMutantRace)
			TerminalTargetRace = 3
		elseif (tt_race == pSynthGen1Race || tt_race == pSynthGen2Race || tt_race == pSynthGen2RaceValentine)
			TerminalTargetRace = 4
		elseif (tt_race == pDogmeatRace || tt_race == pRaiderDogRace || tt_race == pViciousDogRace || tt_race == pFEVHoundRace)
			TerminalTargetRace = 5
		elseif (tt_race == pEyeBotRace)
			TerminalTargetRace = 6
		elseif (tt_race == pHandyRace)
			TerminalTargetRace = 7
		elseif (tt_race == pSentryBotRace)
			TerminalTargetRace = 8
		elseif (tt_race == pProtectronRace)
			TerminalTargetRace = 9
		elseif (tt_race == pAssaultronRace)
			TerminalTargetRace = 10
		elseif (tt_race == pDeathClawRace)
			TerminalTargetRace = 11			
		elseif (tt_race == pSuperMutantBehemothRace)
			TerminalTargetRace = 12
		else
			TerminalTargetRace = 0
		endIf

		int o_raceid = TerminalTarget.GetValue(pTweakOriginalRace) as Int
		
		if tt_race.GetFormID() == o_raceid
			TerminalTargetORace = TerminalTargetRace
		elseif (o_raceid == pHumanRace.GetFormID())
			TerminalTargetORace = 1
		elseif (o_raceid == pGhoulRace.GetFormID())
			TerminalTargetORace = 2
		elseif (o_raceid == pSuperMutantRace.GetFormID())
			TerminalTargetORace = 3			
		elseif o_raceid == pSynthGen1Race.GetFormID() || o_raceid == pSynthGen2Race.GetFormID() || o_raceid == pSynthGen2RaceValentine.GetFormID()
			TerminalTargetORace = 4
		elseif (o_raceid == pDogmeatRace.GetFormID() || o_raceid == pRaiderDogRace.GetFormID() || o_raceid == pViciousDogRace.GetFormID() || o_raceid == pFEVHoundRace.GetFormID())
			TerminalTargetORace = 5
		elseif (o_raceid == pEyeBotRace.GetFormID())
			TerminalTargetORace = 6
		elseif (o_raceid == pHandyRace.GetFormID())
			TerminalTargetORace = 7
		elseif (o_raceid == pSentryBotRace.GetFormID())
			TerminalTargetORace = 8
		elseif (o_raceid == pProtectronRace.GetFormID())
			TerminalTargetORace = 9
		elseif (o_raceid == pAssaultronRace.GetFormID())
			TerminalTargetORace = 10
		elseif (o_raceid == pDeathClawRace.GetFormID())
			TerminalTargetORace = 11			
		elseif (o_raceid == pSuperMutantBehemothRace.GetFormID())
			TerminalTargetORace = 12
		else
			TerminalTargetORace = 0
		endIf		
		Trace("TerminalTargetORace [" + TerminalTargetORace + "]")

		AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
		
		TerminalTargetEssential = TerminalTarget.IsEssential()
		TerminalTargetDist      = TerminalTarget.GetValue(Game.GetCommonProperties().FollowerDistance)
		TerminalTargetState     = TerminalTarget.GetValue(Game.GetCommonProperties().FollowerState)

		; Need to CHeck Faction and only use Stance if Faction is not Auto
		if TerminalTarget.IsInFaction(pTweakAutoStanceFaction)
			TerminalTargetStance    = 2.0
		else
			TerminalTargetStance    = TerminalTarget.GetValue(Game.GetCommonProperties().FollowerStance)
		endif
		
		TerminalTargetOEssential = False
		if (pTweakFollowerScript)
			TerminalTargetOEssential = pTweakFollowerScript.GetOriginallyEssential(TerminalTarget)
		endIf
		
		if (TerminalTarget.GetCurrentPackage() == pCommandMode_Travel)
			if (TerminalTargetState != iFollower_Com_Wait.GetValue())
				if (pTweakFollowerScript)
					pTweakFollowerScript.SetFollowerStayByNameId(TerminalTargetId)
				endIf
				TerminalTargetState  = iFollower_Com_Wait.GetValue()
			endIf
		endIf
		
		if (1 == TerminalTargetRace || 2 == TerminalTargetRace || 4 == TerminalTargetRace || tt_race == pPowerArmorRace)
			if (1.0 == TerminalTarget.GetValue(pTweakInPowerArmor) || TerminalTarget.WornHasKeyword(pArmorTypePower))
				TerminalTargetPAState = 1
			else
				; Rely on TweakInventory to catch UnEquipItem event and set the LinkedRef propery
				ObjectReference lastPowerArmor = TerminalTarget.GetLinkedRef(pLinkPowerArmor)
				if (lastPowerArmor)
					TerminalTargetPAState = 2
					Trace("Found Previous PA")
					if (lastPowerArmor.Is3DLoaded())
						Trace("3D is loaded (Nearby)")
					else
						Trace("3D is not loaded")
					endIf			
				else
					TerminalTargetPAState = 0
				endIf
			endIf
		else
			TerminalTargetPAState = 3 ; Can not wear PA
		endIf
		TerminalTargetLeveled = (TerminalTarget.GetLeveledActorBase() != TerminalTarget.GetActorBase())
	else
		TerminalTargetId = 0
		AFT:TweakDFScript pTweakDFScript = (pFollowers AS AFT:TweakDFScript)
		if (pTweakDFScript)
			CommentSynchronous = pTweakDFScript.CommentSynchronous
		else
			Trace("Unable to Cast Followers to TweakDFScript")
		endIf
		
	endIf

EndFunction

Function PrepSPECIAL()

	Trace("PrepSPECIAL Called")
	If !TerminalTarget
		pTweakSpecialStr.SetValue(0)
		pTweakSpecialPer.SetValue(0)
		pTweakSpecialEnd.SetValue(0)
		pTweakSpecialChr.SetValue(0)
		pTweakSpecialInt.SetValue(0)
		pTweakSpecialAgl.SetValue(0)
		pTweakSpecialLck.SetValue(0)
		pTweakSpecialAvl.SetValue(0)
		return
	endIf
	
	; Grab Current Stats
	float cStrength		= TerminalTarget.GetBaseValue(Strength)
	float cPerception	= TerminalTarget.GetBaseValue(Perception)
	float cEndurance	= TerminalTarget.GetBaseValue(Endurance)
	float cCharisma		= TerminalTarget.GetBaseValue(Charisma)
	float cIntelligence	= TerminalTarget.GetBaseValue(Intelligence)
	float cAgility		= TerminalTarget.GetBaseValue(Agility)
	float cLuck			= TerminalTarget.GetBaseValue(Luck)
	float pAvailable	= TerminalTarget.GetValue(pTweakAvailable)
	
	if cStrength < 1
		cStrength = 1
		TerminalTarget.SetValue(Strength, 1)
	endIf
	if cPerception < 1
		cPerception = 1
		TerminalTarget.SetValue(Perception, 1)
	endIf
	if cEndurance < 1
		cEndurance = 1
		TerminalTarget.SetValue(Endurance, 1)
	endIf
	if cCharisma < 1
		cCharisma = 1
		TerminalTarget.SetValue(Charisma, 1)
	endIf	
	if cIntelligence < 1
		cIntelligence = 1
		TerminalTarget.SetValue(Intelligence, 1)
	endIf	
	if cAgility < 1
		cAgility = 1
		TerminalTarget.SetValue(Agility, 1)
	endIf	
	if cLuck < 1
		cLuck = 1
		TerminalTarget.SetValue(Luck, 1)
	endIf	
	
	if pAvailable < 0
		pAvailable = 0
	endIf
	
	pAvailable += cStrength
	pAvailable += cPerception
	pAvailable += cEndurance
	pAvailable += cCharisma
	pAvailable += cIntelligence
	pAvailable += cAgility
	pAvailable += cLuck
	
	; Calculate Minimum
	; 25 Base + 1 point per level up to level 50. Then 1 point every other level from 50 to 100. 
	; So by the time you reach level 100, you have 100 points, but you have 75 at level 50. 
	int plevel = Game.GetPlayer().GetLevel()
	float minimum = 0
	
	if plevel < 51
		minimum = 25.0 + plevel
	else
		minimum = 75.0 + ((((plevel - 50)/2) as Int) as float)
	endIf
	
	if pAvailable < minimum
		pAvailable = minimum
	endIf

	pAvailable -= cStrength
	pAvailable -= cPerception
	pAvailable -= cEndurance
	pAvailable -= cCharisma
	pAvailable -= cIntelligence
	pAvailable -= cAgility
	pAvailable -= cLuck
	
	if pAvailable < 0
		pAvailable = 0
	endIf

	Trace("Player Level [" + plevel + "]")
	Trace("Strength     [" + cStrength + "]")
	Trace("Perception   [" + cPerception + "]")
	Trace("Endurance    [" + cEndurance + "]")
	Trace("Charisma     [" + cCharisma + "]")
	Trace("Intelligence [" + cIntelligence + "]")
	Trace("Agility      [" + cAgility + "]")
	Trace("Luck         [" + cLuck + "]")
	Trace("Available    [" + pAvailable + "]")
	
	pTweakSpecialStr.SetValue(cStrength)
	pTweakSpecialPer.SetValue(cPerception)
	pTweakSpecialEnd.SetValue(cEndurance)
	pTweakSpecialChr.SetValue(cCharisma)
	pTweakSpecialInt.SetValue(cIntelligence)
	pTweakSpecialAgl.SetValue(cAgility)
	pTweakSpecialLck.SetValue(cLuck)
	pTweakSpecialAvl.SetValue(pAvailable)
	TerminalTarget.SetValue(pTweakAvailable, pAvailable)
	
EndFunction

Function IncreaseSPECIAL(int letter)
	Trace("IncreaseSPECIAL Called")

	if !TerminalTarget
		return
	endIf
	
	ActorValue attribute
	GlobalVariable gTweakSpecial 
	if (1 == letter)
		attribute = Strength
		gTweakSpecial = pTweakSpecialStr
	elseif (2 == letter)
		attribute = Perception
		gTweakSpecial = pTweakSpecialPer
	elseif (3 == letter)
		attribute = Endurance
		gTweakSpecial = pTweakSpecialEnd
	elseif (4 == letter)
		attribute = Charisma
		gTweakSpecial = pTweakSpecialChr
	elseif (5 == letter)
		attribute = Intelligence
		gTweakSpecial = pTweakSpecialInt
	elseif (6 == letter)
		attribute = Agility
		gTweakSpecial = pTweakSpecialAgl
	elseif (7 == letter)
		attribute = Luck
		gTweakSpecial = pTweakSpecialLck
	else
		return
	endIf
		
	float pAvailable = TerminalTarget.GetValue(pTweakAvailable)	
	if (pAvailable > 0)
		float pAttributeValue = TerminalTarget.GetBaseValue(attribute)
		if pAttributeValue < 25
			pAttributeValue += 1
			pAvailable -= 1
			TerminalTarget.SetValue(attribute, pAttributeValue)
			TerminalTarget.SetValue(pTweakAvailable, pAvailable)			
			gTweakSpecial.SetValue(pAttributeValue)
			pTweakSpecialAvl.SetValue(pAvailable)
			AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
			if (pTweakFollowerScript)
				pTweakFollowerScript.EvaluateSynergy()
			endIf
		endIf
	endIf
	
EndFunction

Function SetSPECIAL(Actor Target=None, int pStrength=1, int pPerception=1, int pEndurance=1, int pCharisma=1, int pIntelligence=1, int pAgility=1, int pLuck=1, bool distribute=false)
	Trace("SetSPECIAL Called")

	if !Target
		Trace("Target = TerminalTarget")
		Target = TerminalTarget
	endIf
	
	if !Target
		Trace("Target/TerminalTarget is None. Aborting")
		return
	endIf

	float pAvailable = Target.GetValue(pTweakAvailable)
	if pAvailable < 0
		pAvailable = 0
	endIf
	
	pAvailable += Target.GetBaseValue(Strength)
	pAvailable += Target.GetBaseValue(Perception)
	pAvailable += Target.GetBaseValue(Endurance)
	pAvailable += Target.GetBaseValue(Charisma)
	pAvailable += Target.GetBaseValue(Intelligence)
	pAvailable += Target.GetBaseValue(Agility)
	pAvailable += Target.GetBaseValue(Luck)

	Trace("Total Available [" + pAvailable + "]")

	int plevel = Game.GetPlayer().GetLevel()
	float minimum = 0
	
	if plevel < 51
		minimum = 25.0 + plevel
	else
		minimum = 75.0 + ((((plevel - 50)/2) as Int) as float)
	endIf
	
	if (pAvailable < minimum)
		Trace("Assigning Alternative Minimum [" + minimum + "]")
		pAvailable = minimum
	endIf
		
	if distribute
	
		Trace("Distribute is True")
		; Distribute means the values are not hard values but distribution percentages that 
		; should add up to 100. , we aren't forcing a specific set of values. Rather we want to 
		; strive for a distribution. IE: A Bruiser might have:
		; 
		; S=40, P=5, E=40, C=1, I=4, A=5, L=5
		
		int[] attributes = new int[7]

		attributes[0] = 1 ; Perception
		attributes[1] = 1 ; Endurance
		attributes[2] = 1 ; Agility
		attributes[3] = 1 ; Strength
		attributes[4] = 1 ; Intelligence
		attributes[5] = 1 ; Charisma
		attributes[6] = 1 ; Luck
		
		float cAvailable = pAvailable - 7
		if cAvailable > 0
		
			int pps = ((pPerception   * cAvailable)/100) as Int
			int eps = ((pEndurance    * cAvailable)/100) as Int
			int aps = ((pAgility      * cAvailable)/100) as Int		
			int sps = ((pStrength     * cAvailable)/100) as Int
			int ips = ((pIntelligence * cAvailable)/100) as Int			
			int cps = ((pCharisma     * cAvailable)/100) as Int
			int lps = ((pLuck         * cAvailable)/100) as Int

			attributes[0] += pps ; Perception
			attributes[1] += eps ; Endurance
			attributes[2] += aps ; Agility
			attributes[3] += sps ; Strength
			attributes[4] += ips ; Intelligence
			attributes[5] += cps ; Charisma
			attributes[6] += lps ; Luck
			
			cAvailable -= pps
			cAvailable -= eps
			cAvailable -= aps
			cAvailable -= sps
			cAvailable -= ips
			cAvailable -= cps
			cAvailable -= lps
			
			; Spread the remainder
			int index = 0
			while (cAvailable > 0)
				attributes[index] += 1
				cAvailable -= 1
				index += 1
			endwhile
			
		endIf
		
		pPerception   = attributes[0]
		pEndurance    = attributes[1]
		pAgility      = attributes[2]
		pStrength     = attributes[3]
		pIntelligence = attributes[4]
		pCharisma     = attributes[5]
		pLuck         = attributes[6]
		
	else
		Trace("Distribute is False")
	endIf
	
	if pStrength < 1
		Trace("Fixing pStrength")
		pStrength = 1
	endIf
	if pPerception < 1
		Trace("Fixing pPerception")
		pPerception = 1
	endIf
	if pEndurance < 1
		Trace("Fixing pEndurance")
		pEndurance = 1
	endIf
	if pCharisma < 1
		Trace("Fixing pCharisma")
		pCharisma = 1
	endIf	
	if pIntelligence < 1
		Trace("Fixing pIntelligence")
		pIntelligence = 1
	endIf	
	if pAgility < 1
		Trace("Fixing pAgility")
		pAgility = 1
	endIf	
	if pLuck < 1
		Trace("Fixing pLuck")
		pLuck = 1
	endIf	
		
	Trace("Final Values")
	
	Trace("Strength     [" + pStrength + "]")
	Trace("Perception   [" + pPerception + "]")
	Trace("Endurance    [" + pEndurance + "]")
	Trace("Charisma     [" + pCharisma + "]")
	Trace("Intelligence [" + pIntelligence + "]")
	Trace("Agility      [" + pAgility + "]")
	Trace("Luck         [" + pLuck + "]")
	
	Trace("Updating ActorValues")
	Target.SetValue(Strength,     pStrength)
	Target.SetValue(Perception,   pPerception)
	Target.SetValue(Endurance,    pEndurance)
	Target.SetValue(Charisma,     pCharisma)
	Target.SetValue(Intelligence, pIntelligence)
	Target.SetValue(Agility,      pAgility)
	Target.SetValue(Luck,         pLuck)

	Trace("Updating Globals")
	pTweakSpecialStr.SetValue(pStrength)
	pTweakSpecialPer.SetValue(pPerception)
	pTweakSpecialEnd.SetValue(pEndurance)
	pTweakSpecialChr.SetValue(pCharisma)
	pTweakSpecialInt.SetValue(pIntelligence)
	pTweakSpecialAgl.SetValue(pAgility)
	pTweakSpecialLck.SetValue(pLuck)
	
	
	; How many attributes are available?
	Trace("Computing Available. Starting [" + pAvailable + "]")
	pAvailable -= pStrength
	pAvailable -= pPerception
	pAvailable -= pEndurance
	pAvailable -= pCharisma
	pAvailable -= pIntelligence
	pAvailable -= pAgility
	pAvailable -= pLuck	
	
	if pAvailable < 0
		pAvailable = 0
	endIf	
	
	Trace("Computing Available. Final [" + pAvailable + "]")
	Target.SetValue(pTweakAvailable, pAvailable)	
	pTweakSpecialAvl.SetValue(pAvailable)
	
	; Update Synergy Perk Changes...
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.EvaluateSynergy()
	endIf
	
	; Ranged Damage Perk only applies change when added (doesn't monitor for changes). 
	; So we have to remove and re-add the perk when stats change to account for new
	; changes...
	if Target.HasPerk(pTweakRangedDmgBoost)
		Target.RemovePerk(pTweakRangedDmgBoost)
		Target.AddPerk(pTweakRangedDmgBoost)
	endIf
	
EndFunction

Function SetLoiterCooldown(float value)
	FollowersScript pFollowersScript = (pFollowers AS FollowersScript)
	if pFollowersScript
		pTweakLoiterCooldown.SetValue(value)
		pFollowersScript.SetStandardLoiterCoolDownTime(pTweakLoiterCooldown.GetValue())
	endIf
EndFunction

Function SetCombatStyle(int option, bool backToPip=True)

	Trace("SetCombatStyle() Called")
	
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[2]
		params[0] = option
		params[1] = backToPip
		self.CallFunctionNoWait("SetCombatStyle", params)
		return
	endIf

	if (TerminalTarget)
	
		TerminalTarget.RemoveFromFaction(pTweakGunslingerFaction)
		TerminalTarget.RemoveFromFaction(pTweakBruiserFaction)
		TerminalTarget.RemoveFromFaction(pTweakCommandoFaction)
		TerminalTarget.RemoveFromFaction(pTweakBoomstickFaction)	
		TerminalTarget.RemoveFromFaction(pTweakNinjaFaction)
		TerminalTarget.RemoveFromFaction(pTweakSniperFaction)
		TerminalTarget.RemoveFromFaction(pTweakEnhancedFaction)
				
		if 1 == option
			TerminalTarget.AddToFaction(pTweakGunslingerFaction)
			pTweakCombatStyle.SetValue(1)
			; S P E C I A L : 15 35 20 5 5 10 10
			SetSPECIAL(TerminalTarget, 15, 35, 20, 5, 5, 10, 10, true)
		elseif 2 == option 
			TerminalTarget.AddToFaction(pTweakBruiserFaction)
			pTweakCombatStyle.SetValue(2)
			; S P E C I A L : 40 5 40 1 4 5 5
			SetSPECIAL(TerminalTarget, 40, 5, 40, 1, 4, 5, 5, true)
		elseif 3 == option 
			TerminalTarget.AddToFaction(pTweakCommandoFaction)
			pTweakCombatStyle.SetValue(3)
			; S P E C I A L : 25 25 25 5 5 10 5
			SetSPECIAL(TerminalTarget, 25, 25, 25, 5, 5, 10, 5, true)
		elseif 4 == option
			TerminalTarget.AddToFaction(pTweakBoomstickFaction)
			pTweakCombatStyle.SetValue(4)
			; S P E C I A L : 25 10 25 5 15 15 5
			SetSPECIAL(TerminalTarget, 25, 10, 25, 5, 15, 15, 5, true)
		elseif 5 == option 
			TerminalTarget.AddToFaction(pTweakNinjaFaction)
			pTweakCombatStyle.SetValue(5)
			; S P E C I A L : 25 10 25 5 15 15 5
			SetSPECIAL(TerminalTarget, 20, 10, 25, 1, 12, 20, 12, true)
		elseif 6 == option 
			TerminalTarget.AddToFaction(pTweakSniperFaction)
			pTweakCombatStyle.SetValue(6)
			; S P E C I A L : 12 40 15 1 8 4 20
			SetSPECIAL(TerminalTarget, 12, 40, 15, 1,  8, 4, 20, true)
		elseif 7 == option 
			TerminalTarget.AddToFaction(pTweakEnhancedFaction)
			pTweakCombatStyle.SetValue(7)
			; S P E C I A L : 22 22 21 1 5 21 8
			SetSPECIAL(TerminalTarget, 22, 22, 21, 1, 5, 21, 8, true)
		else
			pTweakCombatStyle.SetValue(0)		
		endIf
		if (option > 0 && option < 8)
			pTweakStatUpdate.Show()
		endIf
		
		if backToPip
			pTweakCombatStyleTerminal.ShowOnPipBoy()
		endIf
		
	endIf
		
EndFunction

Function ExeAFTMenuCommand(int command)
	pTweakCommand.SetValue(command)
	pTweakManageNPCRelay.Cast(Game.GetPlayer())
EndFunction

; This method is typically called from Script AFT::TweakTargetRelayScript, which is attached to MagicAffect 
; TweakTargetRelay. Prior to calling this method it sets the local script ObjectReference TerminalTarget to 
; the Actor under the target hair. If there is no ACTOR under the targethair, TerminalTarget will be NONE. 
; Note that not every actor is an NPC. Sometimes they are moving machines like vertibirds or turrets.

Function ActivateAft(Actor npc = None)

	Trace("ActivateAft() Called")
	
	; Note: TerminalTargetId is not the same as FollowerID. FollowerID comes from the 
	; TweakFollowerFaction rank and will be between 1 and 32, corresponding toggle
	; the alias that manages the NPC. The TerminalTargetId comes from the TweakNamesFactionRank. 
	; and can range from 1 to 110. Either can be used to lookup an NPC, though FollowerID 
	; is much faster. Still, the PipBoy is the main interface and it works off of Name
	; IDs, so "id" normally reffers to the NameID. FollowerID is normally explicitly stated
	; in the variable or function name when it is expected...
		
	TerminalTargetId = 0
	if (npc != None)
		TerminalTarget = npc
	endIf
	
	EvaluateTerminalTarget() ; Retreive ID and other things
	
	if (TerminalTarget)
	
		if (TerminalTarget.IsInFaction(pTweakFollowerFaction))
		
			if (TerminalTarget.IsInFaction(DisallowedCompanionFaction) == True)
				pTweakDisallowedWarn.Show()
			endIf
			if (!TerminalTarget.IsInFaction(pTweakPosedFaction))
				SpeakDialogue(TerminalTarget, pTweakTopicHello, pTweakTopicHelloModID, "pTweakTopicHello",  75, 80)
			endIf
			
			Trace("TerminalTarget ID Found [" + TerminalTargetId + "]")
			float theCommand = pTweakCommand.GetValue()
			if (0 == theCommand)
				pTweakRootTerminal.ShowOnPipBoy()
			else
				handleCommand(theCommand)
			endIf
			
		elseif (TerminalTarget.IsInFaction(pCurrentCompanionFaction))
			; Use this if they run out of management slots...
			float theCommand = pTweakCommand.GetValue()
			if (0 == theCommand)
				pTweakUnmanagedTerminal.ShowOnPipBoy()
			else
				; GetBehindMe (1)
				; Trade
				; Wait Here
				; Follower Me
				; Dismiss
				; Info
				; Fetch PowerArmor
				; Exit PowerArmor
				; Setup Camp
				; TearDown Camp
				
				
				
				
				handleCommand(theCommand)
			endIf			
		else
			Trace("TerminalTarget is not in TweakFOllowerFaction")
			float theCommand = pTweakCommand.GetValue()
			if (0 == theCommand)
				if TerminalTarget.IsInFaction(pDanversFaction)
					pTweakMarkedForIgnore.SetValue(1.0)
				else
					pTweakMarkedForIgnore.SetValue(0.0)
				endIf			
				pTweakImportTerminal.ShowOnPipBoy()
			else
				; Only Scan and Import allowed
				if (10 == theCommand || 11 == theCommand)
					handleCommand(theCommand)
				endIf
			endIf
		endIf
		
	else
		Trace("TerminalTarget is NONE")
	
		if (0 == pTweakMovePosedActive.GetValueInt())
			; ALL FOLLOWERS MODE:		
			float theCommand = pTweakCommand.GetValue()
			if (0 == theCommand)
				pTweakRootTerminal.ShowOnPipBoy()
			else
				handleCommand(theCommand)
			endIf
		else
			TweakChangeAppearance pTweakChangeAppearance = (pTweakFollower as TweakChangeAppearance)
			if pTweakChangeAppearance
				; End Move Pose State
				pTweakChangeAppearance.OnChooseDown()
			endIf
		endIf
		
		
	endIf	
	
	EnsurePlayerHasAFT()

EndFunction

Function handleCommand(float theCommand)

	pTweakCommand.SetValue(0.0)

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)

	if theCommand < 69
		if theCommand < 39
			if theCommand < 14

				; ============================
				; TerminalTarget Not Required:
				; ============================
			
				; Actions
				; -------
				if 1.0 == theCommand
					SummonRelay()
				elseif 125.0 == theCommand
					GatherLooseItems()
				elseif 2.0 == theCommand
					pTweakFollowerScript.SetFollowerStayByNameId(0)
				elseif 3.0 == theCommand ; AllHangout
					pTweakFollowerScript.SetFollowerHangoutByNameId(0)
				elseif 4.0 == theCommand ; All Follow
					pTweakFollowerScript.SetFollowerFollowByNameId(0)
				elseif 5.0 == theCommand ; Enter PowerArmor
					EnterPowerArmorRelay()
				elseif 6.0 == theCommand ; Exit Powerarmor
					ExitPowerArmorRelay()
				elseif 7.0 == theCommand ; Setup Camp
					AFT:TweakShelterScript pTweakShelterScript = (pTweakFollower as AFT:TweakShelterScript)
					if (!pTweakShelterScript.ShelterSetup)
						MakeCampRelay()
					endIf
				elseif 8.0 == theCommand ; Teardown Camp
					AFT:TweakShelterScript pTweakShelterScript = (pTweakFollower as AFT:TweakShelterScript)
					if (pTweakShelterScript.ShelterSetup)
						TearDownCampRelay()
					endIf
				endIf
				
				if theCommand < 9
					return
				endIf
				
				; Gear:
				; -----
				if 9.0 == theCommand ; UnequipAll
					UnEquipAllRelay()
				elseif 10.0 == theCommand ; Give All Junk
					GivePlayerJunkRelay()
				elseif 11.0 == theCommand ; Give All Scrap
					GivePlayerScrapRelay()
				elseif 12.0 == theCommand ; Give Non-Outfit Gear
					TransferUnusedRelay()
				elseif 13.0 == theCommand ; Give All Gear
					TransferAllRelay()
				endIf
			
			else ; theCOmmand >= 14
			
				; Tools:
				; -----
				if 14.0 == theCommand ; UnmanageNPC
					if TerminalTarget
						pTweakFollowerScript.UnManageFollower(TerminalTarget)
					else
						UnManageNPCSetup(); 
						pTweakSelectNameTerminal.ShowOnPipBoy()
					endIf
				elseif 15.0 == theCommand ; Camp Expansion Buyout
					Terminal TweakCampQuestExpansion = Game.GetFormFromFile(0x010279BF,"AmazingFollowerTweaks.esp") as Terminal
					if TweakCampQuestExpansion
						Actor player = Game.GetPlayer()
						if (player.GetItemCount(TweakCampQuestExpansion) < 1)
							player.AddItem(TweakCampQuestExpansion)
						endIf
					endIf
				elseif 16.0 == theCommand ; Clear Settlement
					pTweakFollowerScript.ClearSettlement()
				elseif 17.0 == theCommand ; Reset Build Limit
					ResetBuildLimit()
				elseif 18.0 == theCommand ; Locate NPC
					LocateNPCSetup()
					pTweakSelectNameTerminal.ShowOnPipBoy()
				elseif 19.0 == theCommand ; Load Prefab
					StartPrefab()
				endIf
				
				if None == TerminalTarget
					return
				endIf

				if theCommand < 20
					return
				endIf
				
				; ============================
				; TerminalTarget Required:
				; ============================

				; Actions:
				; --------
				if 20.0 == theCommand ; GetBehindMe
					BehindMeRelay()
				elseif 21.0 == theCommand ; Wait Here
					StayRelay()
				elseif 22.0 == theCommand ; Hangout Here
					HangoutRelay()
				elseif 23.0 == theCommand ; ComeWithMe
					SetCompanionRelay()
				elseif 24.0 == theCommand ; Follow Me
					FollowRelay()
				elseif 25.0 == theCommand ; Fetch PowerArmor
					GetPlayerPowerArmor()
				elseif 26.0 == theCommand ; Dismiss
					DismissRelay()
				endIf
				
				if theCommand < 27
					return
				endIf
				
				; Gear:
				; -----
				
				if 27.0 == theCommand ; Trade 
					TradeRelay()
				elseif 28.0 == theCommand ; Set/Unset Standard Outfit 
					if TerminalTargetPAState != 1
						if 0 == TerminalTargetHasStandardOutfit
							StandardOutfitSnapshotRelay()
						elseif 1 == TerminalTargetHasStandardOutfit
							StandardOutfitReset()
						endIf
					endIf
				elseif 29.0 == theCommand ; Set/Unset Combat Outfit 
					if TerminalTargetPAState != 1
						if 0 == TerminalTargetHasCombatOutfit
							CombatOutfitSnapshotRelay()
						elseif 1 == TerminalTargetHasCombatOutfit
							CombatOutfitReset()
						endIf
					endIf
				elseif 30.0 == theCommand ; Set/Unset City Outfit 
					if TerminalTargetPAState != 1
						if 0 == TerminalTargetHasCityOutfit
							CityOutfitSnapshotRelay()
						elseif 1 == TerminalTargetHasCityOutfit
							CityOutfitReset()
						endIf
					endIf
				elseif 31.0 == theCommand ; Set/Unset Camp Outfit 
					if TerminalTargetPAState != 1
						if 0 == TerminalTargetHasCampOutfit
							CampOutfitSnapshotRelay()
						elseif 1 == TerminalTargetHasCampOutfit
							CampOutfitReset()
						endIf		
					endIf
				elseif 32.0 == theCommand ; Set/Unset Home Outfit 
					if TerminalTargetPAState != 1
						if 0.0 == pTweakTargetHasHomeOutfit.GetValue()
							HomeOutfitSnapshotRelay()
						elseif 1.0 == pTweakTargetHasHomeOutfit.GetValue()
							HomeOutfitReset()
						endIf
					endIf
				elseif 33.0 == theCommand ; Clear All Outfits
					if TerminalTargetPAState != 1
						ClearAllOutfitsRelay()
					endIf		
				elseif 34.0 == theCommand ; UnManage Outfits
					if TerminalTargetPAState != 1
						UnManageOutfits()
					endIf
					
				elseif 35.0 == theCommand ; Dedupe
					TakePlayerDuplicatesRelay()
				elseif 36.0 == theCommand ; Dejunk
					TakePlayerJunkRelay()
				elseif 37.0 == theCommand ; Sell Non-Outfit Gear
					SellUnusedRelay()
				elseif 38 == theCommand
					if TerminalTargetOId == 9
						AddNickItemsRelay()
					endIf
				endIf
			endIf

		else ; theCommand >= 39
		
			if theCommand < 59
		
				; Combat AI:
				; ----------

				if 39.0 == theCommand ; Default
					SetCombatStyle(0, false)
				elseif 40.0 == theCommand ; Gunslinger
					SetCombatStyle(1, false)
				elseif 41.0 == theCommand ; Bruiser
					SetCombatStyle(2, false)
				elseif 42.0 == theCommand ; Commando
					SetCombatStyle(3, false)
				elseif 43.0 == theCommand ; Boomstick
					SetCombatStyle(4, false)
				elseif 44.0 == theCommand ; Ninja
					SetCombatStyle(5, false)
				elseif 45.0 == theCommand ; Sniper
					SetCombatStyle(6, false)
				elseif 46.0 == theCommand ; Dynamic
					SetCombatStyle(7, false)
				elseif 47.0 == theCommand ; Set Aggressive
					StyleAggRelay()
				elseif 48.0 == theCommand ; Set Defensive
					StyleDefRelay()
				elseif 126.0 == theCommand ; Set Auto Aggression
					StyleAutoRelay()
				elseif 49.0 == theCommand ; Set Coward
					SetConfidenceRelay(0,false)
				elseif 50.0 == theCommand ; Set Cautious
					SetConfidenceRelay(1,false)
				elseif 51.0 == theCommand ; Set Average
					SetConfidenceRelay(2,false)
				elseif 52.0 == theCommand ; Set Brave
					SetConfidenceRelay(3,false)
				elseif 53.0 == theCommand ; Set Foolhardy
					SetConfidenceRelay(4,false)
				elseif 54.0 == theCommand ; Set Distance Near
					DistNearRelay()
				elseif 55.0 == theCommand ; Set Distance Med
					DistMedRelay()
				elseif 56.0 == theCommand ; Set Distance Far
					DistFarRelay()
				elseif 57.0 == theCommand ; Toggle PA Helmet
					if TerminalTargetPAState != 3
						if 0 == TerminalTargetPAHelmetCombatOnly
							EnablePAHelmetCombatRelay(false)
						elseif 1 == TerminalTargetPAHelmetCombatOnly
							DisablePAHelmetCombatRelay(false)
						endIf
					endIf
				elseif 58.0 == theCommand ; Toggle Ignore Friendly Hits
					ToggleIgnoreFriendlyHits(false)
				endIf

			else ; theCommand >= 59
			
				; Info:
				; -----
				if 59 == theCommand ; All Info
					Info(0)
				elseif 60 == theCommand ; Info Stats
					Info(1)
				elseif 61 == theCommand ; Info Relationship
					Info(2)
				elseif 62 == theCommand ; Info AI
					Info(3)
				elseif 63 == theCommand ; Info Traits
					Info(4)
				elseif 64 == theCommand ; Info Reactions
					Info(9)
				elseif 65 == theCommand ; Info Effects
					Info(5)
				elseif 66 == theCommand ; Info Perks
					Info(6)
				elseif 67 == theCommand ; Info Factions
					Info(7)
				elseif 68 == theCommand ; Info Keywords
					Info(8)
				endIf
			endIf			
		endIf
	else ; theCommand >= 69
	
		if theCommand < 104

			; Appearance:
			; -----------

			if 69 == theCommand ; Pose
				if (TerminalTargetRace == 1 || TerminalTargetRace == 2 || TerminalTargetRace == 4)
					PoseRelay()
				endIf
			elseif 70 == theCommand ; Pose Stop 
				if (TerminalTargetRace == 1 || TerminalTargetRace == 2 || TerminalTargetRace == 4)
					StopPoseRelay()
				endIf
			elseif 71 == theCommand ; Pose Move
				MovePosedRelay()
			elseif 72 == theCommand ; Scale 200%
				ScaleRelay(2.0)
			elseif 73 == theCommand ; Scale 150%
				ScaleRelay(1.5)
			elseif 74 == theCommand ; Scale 125%
				ScaleRelay(1.25)
			elseif 75 == theCommand ; Scale 105%
				ScaleRelay(1.05)
			elseif 76 == theCommand ; Scale 95%
				ScaleRelay(0.95)
			elseif 77 == theCommand ; Scale 80%
				ScaleRelay(0.80)
			elseif 78 == theCommand ; Scale 66%
				ScaleRelay(0.66)
			elseif 79 == theCommand ; Scale 50%
				ScaleRelay(0.5)
			elseif 80 == theCommand ; Reset Scale
				ScaleRelay(0)	
			elseif 81 == theCommand ; Parts Hair
				AppearanceHint()
				HairPartsRelay()
			elseif 82 == theCommand ; Parts Eyes
				if (TerminalTargetRace == 1 || TerminalTargetRace == 2 || TerminalTargetRace == 4)
					AppearanceHint()
					EyePartsRelay()
				endIf
			elseif 83 == theCommand ; Parts Beard
				if (TerminalTargetRace == 1 || TerminalTargetRace == 2 || TerminalTargetRace == 4)
					AppearanceHint()
					BeardPartsRelay()
				endIf
			elseif 84 == theCommand ; Parts Head
				if (TerminalTargetRace == 1 || TerminalTargetRace == 2 || TerminalTargetRace == 4 || TerminalTargetOID == 9)
					AppearanceHint()
					HeadPartsRelay()
				endIf
			elseif 85 == theCommand ; Set Race Human\Synth
				ChangeRace(0)
			elseif 86 == theCommand ; Set Race Ghoul
				ChangeRace(1)
			elseif 87 == theCommand ; Set Race Supermutant
				ChangeRace(2)
			elseif 88 == theCommand ; Set Race Synth Gen1
				ChangeRace(3)
			elseif 89 == theCommand ; Set Race Synth Gen2
				ChangeRace(4)
			elseif 90 == theCommand ; Set Race Dog
				ChangeRace(5)
			elseif 91 == theCommand ; Set Race Rabid Dog
				ChangeRace(6)
			elseif 92 == theCommand ; Set Race FEVDog
				ChangeRace(7)
			elseif 93 == theCommand ; Set Race Eyebot
				ChangeRace(8)
			elseif 94 == theCommand ; Set Race Handybot
				ChangeRace(9)
			elseif 95 == theCommand ; Set Race Protectron
				ChangeRace(10)
			elseif 96 == theCommand ; Set Race SentryBot
				ChangeRace(11)
			elseif 97 == theCommand ; Set Race Assaultron
				ChangeRace(12)
			elseif 98 == theCommand ; Set Race Deathclaw
				ChangeRace(13)
			elseif 99 == theCommand ; Set Race Behemoth
				ChangeRace(14)
			elseif 100 == theCommand ; Sculpt
				AppearanceHint()
				SculptRelay()
			elseif 101 == theCommand ; New Body
				if 1 == TerminalTargetHasBody
					NewBodyRelay()
				endIf
			elseif 102 == theCommand ; Posture
				ChangePostureRelay()
			elseif 103 == theCommand ; Expression
				ChangeExpressionRelay()
			endIf

		else ; theCommand >= 104
		
			; Settings:
			; -----------
			
			if 104 == theCommand ; Assign Home
				AssignHomeRelay()
			elseif 105 == theCommand ; Toggle Ignore Dislike/Hate Reactions
				ToggleNoDisapprove(false)
			elseif 106 == theCommand ; Toggle Ignore Like/Love Reactions
				ToggleNoApprove(false)
			elseif 107 == theCommand ; Toggle Swap Dislike/Hate Reactions
				ToggleConvNegToPos(false)
			elseif 108 == theCommand ; Toggle Swap Like/Love Reactions
				ToggleConvPosToNeg(false)
			elseif 109 == theCommand ; Toggle Idle Comments
				ToggleNoCommentIdle(false)
			elseif 110 == theCommand ; Toggle General Comments
				ToggleNoCommentGeneral(false)
			elseif 111 == theCommand ; Toggle Approval Comments
				ToggleNoCommentApprove(false)
			elseif 112 == theCommand ; Toggle Disaproval Comments
				ToggleNoCommentDisapprove(false)
			elseif 113 == theCommand ; Toggle Activator Comments
				ToggleNoCommentActivator(false)
			elseif 114 == theCommand ; Toggle Sync PA Use
				ToggleSyncPA(false)
			elseif 115 == theCommand ; Toggle Sync Weapon Use
				ToggleReadyWeapon(false)
			elseif 116 == theCommand ; Toggle Avoid Traps
				ToggleAvoidTrapRelay(false)
			elseif 117 == theCommand ; Toggle Autorelax
				ToggleAutoRelax(false)
			elseif 118 == theCommand ; Toggle Kill Tracking
				ToggleTrackKills(false)
			elseif 119 == theCommand ; Toggle Pack Mule
				TogglePackMule(false)
			elseif 120 == theCommand ; Toggle Unlimited Ammo
				ToggleUseAmmo(false)
			elseif 121 == theCommand ; Toggle No PA Damage
				ToggleNoPADamage(false)
			elseif 122 == theCommand ; Toggle Mortality
				ToggleEssential(false)
			endIf
			
			; Extra/Additional
			if 123 == theCommand ; Edit Special Attributes
				PrepSPECIAL()
				pTweakSpecial.ShowOnPipBoy()	
			elseif 124 == theCommand ; Assign Name
				AssignNameSetup()
				pTweakSelectNameTerminal.ShowOnPipBoy()	
			endIf
			
		endIf		
	endIf	
EndFunction

Function EnsurePlayerHasAFT(bool MarkAsFavorite = false)
	
	float ritems = pTweakRestoreAFTItems.GetValue()
	
	if (1.0 == ritems)
		Actor pc = Game.GetPlayer()
		if (pc.GetItemCount(pTweakHoloTape) <= 0)
			ObjectReference theHolotape = pAftSettingsHolotape.GetReference()		
			if !theHolotape
				Trace("Creating HoloTape")
				theHolotape = pc.PlaceAtMe(pTweakHoloTape)
				if (theHolotape)
					pAftSettingsHolotape.ForceRefTo(theHolotape)
				endIf
			endIf
			if (theHolotape)
				Trace("Adding HoloTape to players inventory")
				pc.AddItem(theHolotape,1, true)
				pc.AddItem(pTweakReadme,1, true)
			endIf		
		endIf
		
		if (pc.GetItemCount(pTweakActivateAFT) <= 0)
			pc.AddItem( pTweakActivateAFT,1,true)
			if MarkAsFavorite
				pc.MarkItemAsFavorite(pTweakActivateAFT, 2)
			endIf
		endIf
	elseif (2.0 == ritems)
		; HoloTape Only
		Actor pc = Game.GetPlayer()
		if (pc.GetItemCount(pTweakHoloTape) <= 0)
			ObjectReference theHolotape = pAftSettingsHolotape.GetReference()		
			if !theHolotape
				Trace("Creating HoloTape")
				theHolotape = pc.PlaceAtMe(pTweakHoloTape)
				if (theHolotape)
					pAftSettingsHolotape.ForceRefTo(theHolotape)
				endIf
			endIf
			if (theHolotape)
				Trace("Adding HoloTape to players inventory")
				pc.AddItem(theHolotape,1, true)
			endIf
		endIf
	elseif (3.0 == ritems)
		; Activator Only
		RestoreAFTActivator()
	endIf
	
EndFunction

Function RestoreAFTActivator()
	Actor pc = Game.GetPlayer()
	if (pc.GetItemCount(pTweakActivateAFT) <= 0)
		pc.AddItem( pTweakActivateAFT,1,true)
	endIf	
EndFunction

Function ToggleEssential(bool backToPip=True)

	Trace("ToggleEssential() Called")

	; Changing essential requires the support of the NPC's AI, which remains paused while
	; in menumode. So you can't change the essential flag until the pipboy has lowered. 

	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("ToggleEssential", params)
		return
	endIf

	if (TerminalTarget)
		AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
		if (pTweakFollowerScript)
			bool before = TerminalTargetEssential
			pTweakFollowerScript.ToggleEssential(TerminalTarget)
			TerminalTargetEssential = TerminalTarget.IsEssential()
						
			if (TerminalTargetEssential == before)
				 pTweakEssentialFailTerminal.ShowOnPipBoy()
			else
				if (TerminalTarget.GetValue(pConfidence) > 1.0)
					pTweakFollowerScript.SetConfidence(TerminalTarget,1)
				endIf
				pTweakFollowerScript.SetFollowerStanceDefensiveByNameId(TerminalTargetId)
				if backToPip
					pTweakSettingsTerminal.ShowOnPipBoy()
				endIf					
			endIf
		endIf
	endIf
EndFunction

Function Info(int type)

	Trace("Info() Called")
	
	Utility.waitmenumode(0.1)
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = type
		self.CallFunctionNoWait("Info", params)
		return
	endIf
	Trace("Info() Continuing. Var = [" + type + "]")
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.FollowerInfo(TerminalTarget, type)
	else
		Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
	endIf	
EndFunction

Function AssignHomeRelay()

	Trace("AssignHomeRelay() Called")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("AssignHomeRelay", params)
		return
	endIf
	
	; Give Hand Time to Lower...
	Utility.wait(0.75)
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.AssignHome(TerminalTarget)
	else
		Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
	endIf	
	
EndFunction

Function ResetNameRelay()

	Trace("ResetNameRelay() Called")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("ResetNameRelay", params)
		return
	endIf
	
	AFT:TweakNamesScript pTweakNamesScript = (pTweakNames as AFT:TweakNamesScript)
	if (pTweakNamesScript)
		pTweakNamesScript.ResetName(TerminalTarget)
	else
		Trace("Unable to Cast TweakNames to TweakNamesScript")		
	endIf
	
EndFunction

; Terminal Target has a value, but NPC is None
Function ToggleAFTgnored()
	Trace("ToggleAFTgnored() Called")
		
	if TerminalTarget
		if TerminalTarget.IsInFaction(pDanversFaction)
			TerminalTarget.RemoveFromFaction(pDanversFaction)
			pTweakMarkedForIgnore.SetValue(0.0)
		else
			TerminalTarget.AddToFaction(pDanversFaction)
			pTweakMarkedForIgnore.SetValue(1.0)
		endIf		
	endIf
	
endFunction
	
; Terminal Target has a value, but NPC is None
Function ImportNPCRelay()
	Trace("ImportNPCRelay() Called")
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("ImportNPCRelay", params)
		return
	endIf
	
	int potential = TerminalTarget.GetFactionRank(PotentialCompanionFaction)
	if (potential > -2 && pTweakNoImportRestrictions.GetValue() == 0.0)
		Trace("NPC Marked as PotentialCompanion")
		pTweakFailPotential.ShowOnPipBoy()
		return
	endIf
	
	if (TerminalTarget.IsInFaction(DisallowedCompanionFaction) && pTweakNoImportRestrictions.GetValue() == 0.0)
		Trace("NPC Marked as Disallowed")
		pTweakFailDisallowed.ShowOnPipBoy()
		return
	endIf
			
	FollowersScript pFollowersScript = (pFollowers AS FollowersScript)
	if (pFollowersScript && TerminalTarget)
		Actor pc = Game.GetPlayer()
		Topic theTopic = ComeAlongTopics[0] ; "Come with me. I need your help."
		if theTopic
			pc.Say(theTopic, pc, false, (TerminalTarget as ObjectReference))
			if pc.IsTalking()
				int maxwait = 15
				while (pc.IsTalking() && maxwait > 0)
					Utility.wait(0.5)
					maxwait -= 1
				endwhile
			endIf
		endIf
		
		; Topic WorkshopVendorSharedTopicB =     Game.GetForm(0x0016CC60) as Topic 
		if WorkshopVendorSharedTopicB
			TerminalTarget.Say(WorkshopVendorSharedTopicB, TerminalTarget, false, Game.GetPlayer())
		endIf
		
		pFollowersScript.SetCompanion(TerminalTarget)
	else
		Trace("Unable to Cast Followers to FollowersScript")
	endIf
	
EndFunction

Function ChangeExpressionRelay()

	Trace("ChangeExpressionRelay() Called")
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("ChangeExpressionRelay", params)
		return
	endIf

	if !pTweakVisualChoice.IsRunning()
		Trace("TweakVisualChoice Quest is not Running. Aborting")
		return
	endIf
	
	if TerminalTarget.IsInCombat()
		pTweakVisualFailCombat.ShowOnPipBoy()
		return
	endIf

	if (TerminalTarget.IsInFaction(pTweakPosedFaction) && TerminalTarget.GetDistance(Game.GetPlayer()) > 300)
		Trace("NPC too far away. Aborting")
		pTweakVisualFailDistance.Show()
		return
	endIf
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.ChangeExpressionByNameId(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
	endIf
	
EndFunction

Function StopPoseRelay()

	Trace("StopPoseRelay() Called")
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("StopPoseRelay", params)
		return
	endIf
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.StopPoseByNameId(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
	endIf
	
EndFunction

Function GatherLooseItems()

	Trace("GatherLooseItems() v2 Called")
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("GatherLooseItems", params)
		return
	endIf
		
	AFT:TweakGatherLooseScript pTweakGatherLoose = pTweakGatherLooseItems as AFT:TweakGatherLooseScript
	if pTweakGatherLoose
		Trace("Calling GatherLooseItems")
		pTweakGatherLoose.GatherLooseItems(TerminalTarget)
	else
		Trace("Aborting. pTweakGatherLoose Cast Failure")
	endIf
		
EndFunction

Function ScanActorsForItems(Actor target=None)

	Trace("ScanActorsForItems [" + target + "]...")
	
	FormList TweakActorTypes      = Game.GetFormFromFile(0x01025B3B,"AmazingFollowerTweaks.esp") as FormList

	Actor pc     = Game.GetPlayer()
	if (None == target)
		target = pc
	endIf
	
	ObjectReference[] nearby
	Actor npc
	int nsize
	int j
	bool moveit = false
	
	ObjectReference opc = pc as ObjectReference
	
	int numTypes = TweakActorTypes.GetSize()
	int i        = 0
	
	Trace("TweakActorTypes Size : [" + numTypes + "] ")
	
	while (i < numTypes)
		nearby = pc.FindAllReferencesWithKeyword(TweakActorTypes.GetAt(i), 1600.0)
		if (0 != nearby.length)
			nsize = nearby.length
			Trace("Found [" + nsize + "] [" + TweakActorTypes.GetAt(i) + "] nearby ")
			j = 0
			while j < nsize
				npc =  nearby[j] as Actor
				if npc && npc.IsDead() && 0 != npc.GetItemCount(None)
					Trace("Dead actor [" + npc + "] within 1600 of player with items. Looting")
					npc.RemoveAllItems(target, true)
				endIf
				j += 1
			endWhile
		endIf
		i += 1
	EndWhile
	
EndFunction

Function ScanContainersForItems(FormList containers, String name, Actor target=None)
	
	Trace("ScanContainersForItems [" + name + "]...")
	
	FormList TweakDedupe1         = Game.GetFormFromFile(0x010383F7,"AmazingFollowerTweaks.esp") as FormList
	FormList TweakDedupe2         = Game.GetFormFromFile(0x010161FB,"AmazingFollowerTweaks.esp") as FormList
	FormList TweakDedupe3         = Game.GetFormFromFile(0x010161FC,"AmazingFollowerTweaks.esp") as FormList
	FormList TweakDedupe4         = Game.GetFormFromFile(0x010161FD,"AmazingFollowerTweaks.esp") as FormList
	FormList TweakDedupeStackable = Game.GetFormFromFile(0x010383F8,"AmazingFollowerTweaks.esp") as FormList
	
	if containers
		Trace(name + " has [" + containers.GetSize() + "] containers")
	else
		Trace(name + " is None")
	endIf

	ObjectReference[] results
	ObjectReference result
	Actor pc = Game.GetPlayer()
	
	Trace("Scanning [" + name + "]...")
	ObjectReference center = pc as ObjectReference
		
	results = center.FindAllReferencesOfType(containers, 1600)			
	int numresults = results.length
	
	Trace("Scan [" + name + "] Complete: [" + numresults + "] container objects found")

	int i = 0
	ObjectReference containedin = None
	bool moveit = false
	
	if None == target
		target = pc
	endIf
	
	while (i < numresults)
		moveit = false
		result = results[i]
		if result
			Trace("Found Container [" + result + "]")
			if result.GetActorOwner()
				Trace("Owned By [" + result.GetActorOwner() + "]")
				moveit = false
			endIf
			if (0 != result.GetLockLevel())
				Trace("Container is Locked [" + (result.GetLockLevel()) + "]")
				moveit = false
			endIf
			if (0 == result.GetItemCount(None))
				Trace("Container is Empty [" + (result.GetItemCount(None)) + "]")
				moveit = false
			endIf
		else
			Trace("Result [" + result + "] Not a Container")
		endIf
		if moveit
			result.RemoveAllItems(target, true)
			; result.RemoveItem(TweakDedupe1,         -1, true, target)
			; result.RemoveItem(TweakDedupe2,         -1, true, target)
			; result.RemoveItem(TweakDedupe3,         -1, true, target)
			; result.RemoveItem(TweakDedupe4,         -1, true, target)
			; result.RemoveItem(TweakDedupeStackable, -1, true, target)
		endIf		
		i += 1
	endwhile
	
EndFunction

Function ScanForItems(FormList list, String name, Actor target=None)

	if list
		Trace(name + " has [" + list.GetSize() + "] elements")
	else
		Trace(name + " is None")
	endIf
	
	ObjectReference[] results
	ObjectReference result
	Actor pc = Game.GetPlayer()
	if None == target
		target = pc
	endIf
	
	Trace("Scanning [" + name + "]...")
	ObjectReference center = pc as ObjectReference
		
	results = center.FindAllReferencesOfType(list, 1600)
	int numresults = results.length
	
	Trace("Scan [" + name + "] Complete: [" + numresults + "] objects found")

	int i = 0
	ObjectReference containedin = None
	bool moveit = true
	
	while (i != numresults)
		result = results[i]
		Trace("Found [" + result + "]")
		if result.HasOwner()
			if result.GetActorRefOwner()
				Trace("Owned By Specific Actor [" + result.GetActorRefOwner() + "]")
			elseif result.GetActorOwner()
				Trace("Owned By Actor Base [" + result.GetActorOwner() + "]")
			elseif result.GetFactionOwner()
				Trace("Owned By Faction [" + result.GetFactionOwner() + "]")
			else
				Trace("Owned By Non-Loaded Entity")
			endIf
		elseif result.IsQuestItem()
			Trace("Quest Item [" + result +"]")
		else
			moveit = true
			containedin = result.GetContainer()
			if containedin
				Trace("Container [" + containedin + "] detected")
				if center == containedin
					Trace("Container is Player!")
					moveit = false
				elseif containedin as Actor
					Trace("Container is Actor [" + (containedin as Actor) + "]")
					if (containedin as Actor).IsDead()
						Trace("Container is Dead")
					else
						moveit = false
					endIf
				elseif (0 != containedin.GetLockLevel())
					Trace("Container is Locked [" + (containedin.GetLockLevel()) + "]")
					moveit = false
				endIf
			endIf
			if moveit
				target.AddItem(result,1,true)
			endIf
		endIf
		i += 1
	endwhile
		
EndFunction

Function MovePosedRelay()

	Trace("MovePosedRelay() Called")
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("MovePosedRelay", params)
		return
	endIf
	
	if !pTweakVisualChoice.IsRunning()
		Trace("TweakVisualChoice Quest is not Running. Aborting")
		return
	endIf
	
	if TerminalTarget.IsInCombat()
		Trace("NPC in combat. Aborting")
		pTweakVisualFailCombat.ShowOnPipBoy()
		return
	endIf
	
	if TerminalTarget.IsInScene()
		Trace("NPC in scene. Aborting")
		pTweakVisualFailScene.ShowOnPipBoy()
		return
	endIf

	if (TerminalTarget.GetDistance(Game.GetPlayer()) > 300)
		Trace("NPC too far away. Aborting")
		pTweakVisualFailDistance.Show()
		return
	endIf
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.MovePosedByNameId(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
	endIf
	
EndFunction

Function ChangePostureRelay()

	Trace("ChangePostureRelay() Called")
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("ChangePostureRelay", params)
		return
	endIf

	if !pTweakVisualChoice.IsRunning()
		Trace("TweakVisualChoice Quest not running. Aborting")
		return
	endIf

	if (TerminalTarget.IsInFaction(pTweakPosedFaction))
		Trace("Follower is Posed. Aborting")
		pTweakVisualFailPosed.ShowOnPipBoy()
		return
	endIf

	if (1.0 == TerminalTarget.GetValue(pTweakInPowerArmor) || TerminalTarget.WornHasKeyword(pArmorTypePower))
		Trace("Follower in Power Armor. Aborting")
		pTweakVisualFailPowerArmor.ShowOnPipBoy()
		return
	endIf	
	
	if TerminalTarget.IsInCombat()
		Trace("Follower in Combat. Aborting")
		pTweakVisualFailCombat.ShowOnPipBoy()
		return
	endIf
		
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.ChangePostureByNameId(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
	endIf
	
EndFunction

; Event Terminal.OnMenuItemRun(Terminal akSender, int auiMenuItemID, ObjectReference akTerminalRef)
;	Trace("Terminal [" + akSender + "] sent OnMenuItemRun Event [" + auiMenuItemID + "] for Object [" + akTerminalRef + "]")
	
	; NOTES: I've read you can tell if a holotape/terminal is ran from pipboy or a real terminal by checking
	;        the akTerminalRef. If the akTerminalRef is None, the player is using the PipBoy. Since this comes from
	;        the AFT Activator (which always uses the PipBoy), I suspect akTerminalRef will always be None.
	
; EndEvent

Function EyePartsRelay()

	Trace("EyePartsRelay() Called")
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("EyePartsRelay", params)
		return
	endIf

	if !pTweakVisualChoice.IsRunning()
		Trace("TweakVisualChoice Quest not running. Aborting")
		return
	endIf
	
	if TerminalTarget.IsInCombat()
		Trace("Follower in Combat. Aborting")
		pTweakVisualFailCombat.ShowOnPipBoy()
		return
	endIf
	
	if TerminalTarget.IsInScene()
		Trace("Follower in Scene. Aborting")
		pTweakVisualFailScene.ShowOnPipBoy()
		return
	endIf
	
	if (TerminalTarget.IsInFaction(pTweakPosedFaction) && TerminalTarget.GetDistance(Game.GetPlayer()) > 300)
		Trace("Follower too far away. Aborting")
		pTweakVisualFailDistance.Show()
		return
	endIf
	
	if (1.0 == TerminalTarget.GetValue(pTweakInPowerArmor) || TerminalTarget.WornHasKeyword(pArmorTypePower))
		Trace("Follower in Power Armor. Aborting")
		pTweakVisualFailPowerArmor.ShowOnPipBoy()
		return
	endIf	
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.EyePartsByNameId(id=TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
	endIf
	
EndFunction

Function HairPartsRelay()

	Trace("HairPartsRelay() Called")
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("HairPartsRelay", params)
		return
	endIf
	
	if !pTweakVisualChoice.IsRunning()
		Trace("TweakVisualChoice Quest not running. Aborting")
		return
	endIf
	
	if TerminalTarget.IsInCombat()
		Trace("Follower in Combat. Aborting")
		pTweakVisualFailCombat.ShowOnPipBoy()
		return
	endIf
	
	if TerminalTarget.IsInScene()
		Trace("Follower in Scene. Aborting")
		pTweakVisualFailScene.ShowOnPipBoy()
		return
	endIf
	
	if (TerminalTarget.IsInFaction(pTweakPosedFaction) && TerminalTarget.GetDistance(Game.GetPlayer()) > 300)
		Trace("Follower too far away. Aborting")
		pTweakVisualFailDistance.Show()
		return
	endIf
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.HairPartsByNameId(id=TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
	endIf
		
EndFunction

Function HeadPartsRelay()

	Trace("HeadPartsRelay() Called")
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("HeadPartsRelay", params)
		return
	endIf
	
	if !pTweakVisualChoice.IsRunning()
		Trace("TweakVisualChoice Quest not running. Aborting")
		return
	endIf
	
	if TerminalTarget.IsInCombat()
		Trace("Follower in Combat. Aborting")
		pTweakVisualFailCombat.ShowOnPipBoy()
		return
	endIf
	
	if TerminalTarget.IsInScene()
		Trace("Follower in Scene. Aborting")
		pTweakVisualFailScene.ShowOnPipBoy()
		return
	endIf
	
	if (TerminalTarget.IsInFaction(pTweakPosedFaction) && TerminalTarget.GetDistance(Game.GetPlayer()) > 300)
		Trace("Follower too far away. Aborting")
		pTweakVisualFailDistance.Show()
		return
	endIf
	
	if (1.0 == TerminalTarget.GetValue(pTweakInPowerArmor) || TerminalTarget.WornHasKeyword(pArmorTypePower))
		Trace("Follower in Power Armor. Aborting")
		pTweakVisualFailPowerArmor.ShowOnPipBoy()
		return
	endIf	
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.HeadPartsByNameId(id=TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
	endIf
	
EndFunction

Function BeardPartsRelay()

	Trace("BeardPartsRelay() Called")
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("BeardPartsRelay", params)
		return
	endIf
	
	if !pTweakVisualChoice.IsRunning()
		Trace("TweakVisualChoice Quest not running. Aborting")
		return
	endIf
	
	if TerminalTarget.IsInCombat()
		Trace("Follower in Combat. Aborting")
		pTweakVisualFailCombat.ShowOnPipBoy()
		return
	endIf
	
	if TerminalTarget.IsInScene()
		Trace("Follower in Scene. Aborting")
		pTweakVisualFailScene.ShowOnPipBoy()
		return
	endIf
	
	if (TerminalTarget.IsInFaction(pTweakPosedFaction) && TerminalTarget.GetDistance(Game.GetPlayer()) > 300)
		Trace("Follower too far away. Aborting")
		pTweakVisualFailDistance.Show()
		return
	endIf
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.BeardPartsByNameId(id=TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
	endIf
	
EndFunction

Function SculptRelay()

	Trace("SculptRelay() Called")
	
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("SculptRelay", params)
		return
	endIf

	; SpeakDialogue(TerminalTarget, pTweakTopicAck, pTweakTopicAckModID, "pTweakTopicAck", 50)
	
	if (TerminalTarget.IsInFaction(pTweakPosedFaction))
		Trace("Follower is Posed. Aborting")
		pTweakVisualFailPosed.ShowOnPipBoy()
		return
	endIf

	if (1.0 == TerminalTarget.GetValue(pTweakInPowerArmor) || TerminalTarget.WornHasKeyword(pArmorTypePower))
		Trace("Follower in Power Armor. Aborting")
		pTweakVisualFailPowerArmor.ShowOnPipBoy()
		return
	endIf	
	
	if TerminalTarget.IsInCombat()
		Trace("Follower in Combat. Aborting")
		pTweakVisualFailCombat.ShowOnPipBoy()
		return
	endIf
	
	if TerminalTarget.IsInScene()
		Trace("Follower in Scene. Aborting")
		pTweakVisualFailScene.ShowOnPipBoy()
		return
	endIf
	
	if (TerminalTargetLeveled && TerminalTargetHasBody)
		Trace("TerminalTargetLeveled True and TerminalTargetHasBody Calling SculptLeveledByNameId")
		PlayerSheathe()
		
		AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
		if (pTweakFollowerScript)
			pTweakFollowerScript.SculptLeveledByNameId(id=TerminalTargetOId, uiMenu=1)
			return
		else
			Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
		endIf		
	endIf

	if (TerminalTargetLeveled)	
		Trace("TerminalTargetLeveled True (And Has Body is false)")
		if (!pSculptLeveledHintShown)
			Trace("pTweakSculptLeveled")
			pTweakSculptLeveled.show()
			pSculptLeveledHintShown = True
		else
			Trace("pSculptLeveledHintShown is True. Skipping hint...")
		endIf
	else
		Trace("TerminalTargetLeveled is false...")
	endIf
	
	PlayerSheathe()
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.SculptByNameId(id=TerminalTargetId, uiMenu=1)
	else
		Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
	endIf
			
EndFunction

Function PoseRelay(int startBrowse=-1)
	
	Trace("PoseRelay()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = startBrowse
		self.CallFunctionNoWait("PoseRelay", params)
		return
	endIf

	if !pTweakVisualChoice.IsRunning()
		Trace("TweakVisualChoice Quest not running. Aborting")
		return
	endIf

	; Maybe later....
	if (1.0 == TerminalTarget.GetValue(pTweakInPowerArmor) || TerminalTarget.WornHasKeyword(pArmorTypePower))
		Trace("Follower in Power Armor. Aborting")
		pTweakVisualFailPowerArmor.ShowOnPipBoy()
		return
	endIf	
	
	if TerminalTarget.IsInCombat()
		Trace("Follower in Combat. Aborting")
		pTweakVisualFailCombat.ShowOnPipBoy()
		return
	endIf
	
	if TerminalTarget.IsInScene()
		Trace("Follower in Scene. Aborting")
		pTweakVisualFailScene.ShowOnPipBoy()
		return
	endIf
	
	if (TerminalTarget.IsInFaction(pTweakPosedFaction) && TerminalTarget.GetDistance(Game.GetPlayer()) > 300)
		Trace("Follower too far away. Aborting")
		pTweakVisualFailDistance.Show()
		return
	endIf
	
	PlayerSheathe()
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		Trace("Calling PoseByNameId()")
		pTweakFollowerScript.PoseByNameId(TerminalTargetId, startBrowse)
	else
		Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
	endIf
		
EndFunction

Function NewBodyRelay()
	
	Trace("NewBodyRelay()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("NewBodyRelay", params)
		return
	endIf

	if !pTweakVisualChoice.IsRunning()
		Trace("TweakVisualChoice Quest not running. Aborting")
		return
	endIf

	if (TerminalTarget.IsInFaction(pTweakPosedFaction))
		Trace("Follower is Posed. Aborting")
		pTweakVisualFailPosed.ShowOnPipBoy()
		return
	endIf

	if (1.0 == TerminalTarget.GetValue(pTweakInPowerArmor) || TerminalTarget.WornHasKeyword(pArmorTypePower))
		Trace("Follower in Power Armor. Aborting")
		pTweakVisualFailPowerArmor.ShowOnPipBoy()
		return
	endIf	
	
	if TerminalTarget.IsInCombat()
		Trace("Follower in Combat. Aborting")
		pTweakVisualFailCombat.ShowOnPipBoy()
		return
	endIf
	
	if TerminalTarget.IsInScene()
		Trace("Follower in Scene. Aborting")
		pTweakVisualFailScene.ShowOnPipBoy()
		return
	endIf
		
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		Trace("Calling NewBodyRelay()")
		pTweakFollowerScript.NewBodyByNameId(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
	endIf
		
EndFunction

Function AddNickItemsRelay()

	Trace("AddNickItemsRelay()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("AddNickItemsRelay", params)
		return		
	endIf
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.AddNickItems()
		Trace("Calling ViewGear Manually")
		pTweakFollowerScript.ViewGearByNameId(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
	endIf
	
EndFUnction

Function TradeRelay()

	Trace("TradeRelay()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("TradeRelay", params)
		return		
	endIf

	if TerminalTarget && TerminalTargetUnmanaged
		Trace("UnManaged NPC Detected. Using Raw implementation")
		if !SpeakDialogue(TerminalTarget, pTweakTopicTrade, pTweakTopicTradeModID, "pTweakTopicTrade", 60)
			TerminalTarget.OpenInventory(true)
		endIf
		return
	endIf
	
	if (!SpeakDialogue(TerminalTarget, pTweakTopicTrade, pTweakTopicTradeModID, "pTweakTopicTrade", 60) && (0 != TerminalTargetId))
		Trace("Calling ViewGear Manually")
		AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
		if (pTweakFollowerScript)
			pTweakFollowerScript.ViewGearByNameId(TerminalTargetId)
		else
			Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
		endIf
	endIf	
EndFunction

Function EnablePAHelmetCombatRelay(bool backToPip=True)

	Trace("EnablePAHelmetCombatRelay() Called")

	; Changing essential requires the support of the NPC's AI, which remains paused while
	; in menumode. So you can't change the essential flag until the pipboy has lowered. 

	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("EnablePAHelmetCombatRelay", params)
		return
	endIf

	if (TerminalTarget)
		AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
		if (pTweakFollowerScript)
			bool current = TerminalTargetPAHelmetCombatOnly
			pTweakFollowerScript.EnablePAHelmetCombatByNameID(TerminalTargetId)
			
			if backToPip
				utility.waitmenumode(0.2)
				TerminalTargetPAHelmetCombatOnly = TerminalTarget.IsInFaction(pTweakPAHelmetCombatToggleFaction)						
				if (current != TerminalTargetPAHelmetCombatOnly)
					pTweakCombatAITerminal.ShowOnPipBoy()
				endIf
			endIf
		else
			Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
		endIf
	endIf
EndFunction




Function DisablePAHelmetCombatRelay(bool backToPip=True)

	Trace("DisablePAHelmetCombatRelay() Called")

	; Changing essential requires the support of the NPC's AI, which remains paused while
	; in menumode. So you can't change the essential flag until the pipboy has lowered. 

	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("DisablePAHelmetCombatRelay", params)
		return
	endIf

	if (TerminalTarget)
		AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
		if (pTweakFollowerScript)
			bool current = TerminalTargetPAHelmetCombatOnly
			pTweakFollowerScript.DisablePAHelmetCombatByNameID(TerminalTargetId)
			
			if backToPip
				Utility.waitmenumode(0.2)
				TerminalTargetPAHelmetCombatOnly = TerminalTarget.IsInFaction(pTweakPAHelmetCombatToggleFaction)
				if (current != TerminalTargetPAHelmetCombatOnly)
					pTweakCombatAITerminal.ShowOnPipBoy()
				endIf
			endIf					
		else
			Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
		endIf
	endIf
EndFunction

Function ToggleUseAmmo(bool backToPip=True)
	Trace("ToggleUseAmmo() Called")

	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("ToggleUseAmmo", params)
		return
	endIf

	if (TerminalTarget)
		bool current = TerminalTargetUseAmmo
		
		if TerminalTarget.HasKeyword(pTeammateDontUseAmmoKeyword)
			TerminalTarget.RemoveKeyword(pTeammateDontUseAmmoKeyword)
		else
			TerminalTarget.AddKeyword(pTeammateDontUseAmmoKeyword)
		endIf

		if backToPip
			Utility.waitmenumode(0.2)
			TerminalTargetUseAmmo = !TerminalTarget.HasKeyword(pTeammateDontUseAmmoKeyword)
			if (current != TerminalTargetUseAmmo)
				pTweakSettingsTerminal.ShowOnPipBoy()
			endIf
		endIf
	endIf
	
EndFunction


Function ToggleNoPADamage(bool backToPip=True)

	Trace("ToggleNoPADamage() Called")

	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("ToggleNoPADamage", params)
		return
	endIf

	if (TerminalTarget)
		bool current = TerminalTargetPANoDamage

		if TerminalTarget.HasKeyword(pPowerArmorPreventArmorDamageKeyword)
			TerminalTarget.RemoveKeyword(pPowerArmorPreventArmorDamageKeyword)
		else
			TerminalTarget.AddKeyword(pPowerArmorPreventArmorDamageKeyword)
		endIf
		
		if backToPip
			Utility.waitmenumode(0.2)
			TerminalTargetPANoDamage = TerminalTarget.HasKeyword(pPowerArmorPreventArmorDamageKeyword)
			if (current != TerminalTargetPANoDamage)
				pTweakSettingsTerminal.ShowOnPipBoy()
			endIf
		endIf
	endIf
	
endFunction
	

Function ToggleAvoidTrapRelay(bool backToPip=True)
	Trace("ToggleAvoidTrapRelay() Called")

	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("ToggleAvoidTrapRelay", params)
		return
	endIf

	if (TerminalTarget)
		bool current = TerminalTargetAvoidsTraps
		if TerminalTargetAvoidsTraps
			TerminalTarget.SetValue(pFavorsPerDay,0)
		else
			TerminalTarget.SetValue(pFavorsPerDay,42)
		endIf
		
		if backToPip
			utility.waitmenumode(0.2)
			TerminalTargetAvoidsTraps = (42 == TerminalTarget.GetValue(pFavorsPerDay))
			if (current != TerminalTargetAvoidsTraps)
				pTweakSettingsAITerminal.ShowOnPipBoy()
			endIf
		endIf
	endIf	
EndFunction

Function ToggleNoDisapprove(bool backToPip=True)
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("ToggleNoDisapprove", params)
		return
	endIf

	if (TerminalTarget)
		bool current = TerminalTarget.IsInFaction(pTweakNoDisapprove)
		if current
			TerminalTarget.RemoveFromFaction(pTweakNoDisapprove)
		else
			TerminalTarget.AddToFaction(pTweakNoDisapprove)
		endIf
		
		if backToPip
			Utility.waitmenumode(0.2)
			TerminalTargetNoDisapprove = TerminalTarget.IsInFaction(pTweakNoDisapprove)
			if (current != TerminalTargetNoDisapprove)
				pTweakSettingsPersonality.ShowOnPipBoy()
			endIf
		endIf
	endIf
EndFunction

Function ToggleNoApprove(bool backToPip=True)
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("ToggleNoApprove", params)
		return
	endIf

	if (TerminalTarget)
		bool current = TerminalTarget.IsInFaction(pTweakNoApprove)
		if current
			TerminalTarget.RemoveFromFaction(pTweakNoApprove)
		else
			TerminalTarget.AddToFaction(pTweakNoApprove)
		endIf
		
		if backToPip
			utility.waitmenumode(0.2)
			TerminalTargetNoApprove = TerminalTarget.IsInFaction(pTweakNoApprove)		
			if (current != TerminalTargetNoApprove)
				pTweakSettingsPersonality.ShowOnPipBoy()
			endIf
		endIf
	endIf
EndFunction

Function ToggleTrackKills(bool backToPip=True)
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("ToggleTrackKills", params)
		return
	endIf

	If !TerminalTarget
		Trace("No Terminal Target")
		return
	endIf

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		bool current = TerminalTargetTrackKills	
		pTweakFollowerScript.ToggleTrackKills(TerminalTarget)
		
		if backToPip
			utility.waitmenumode(0.2)
			TerminalTargetTrackKills = TerminalTarget.IsInFaction(pTweakTrackKills)
			if (current != TerminalTargetTrackKills)
				pTweakSettingsAITerminal.ShowOnPipBoy()
			endIf
		endIf
	endIf

EndFunction


Function ToggleConvNegToPos(bool backToPip=True)
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("ToggleConvNegToPos", params)
		return
	endIf

	if (TerminalTarget)
	
		bool current = TerminalTargetConvNegToPos
		
		
		if TerminalTarget.IsInFaction(pTweakConvNegToPos)
			TerminalTarget.RemoveFromFaction(pTweakConvNegToPos)
		else
			TerminalTarget.AddToFaction(pTweakConvNegToPos)
			if !TerminalTarget.IsInFaction(pTweakNoCommentDisapprove)
				TerminalTarget.AddToFaction(pTweakNoCommentDisapprove)
				TerminalTargetNoCommentDisapprove = true
				pTweakNegativeCommentsAlert.Show()
			endIf
		endIf
		
		if backToPip
			utility.waitmenumode(0.2)
			TerminalTargetConvNegToPos = TerminalTarget.IsInFaction(pTweakConvNegToPos)	
			if (current != TerminalTargetConvNegToPos)
				pTweakSettingsPersonality.ShowOnPipBoy()
			endIf
		endIf
	endIf
EndFunction

Function ToggleConvPosToNeg(bool backToPip=True)
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("ToggleConvPosToNeg", params)
		return
	endIf

	if (TerminalTarget)
		bool current = TerminalTargetConvPosToNeg
		
		if TerminalTarget.IsInFaction(pTweakConvPosToNeg)
			TerminalTarget.RemoveFromFaction(pTweakConvPosToNeg)
		else
			TerminalTarget.AddToFaction(pTweakConvPosToNeg)
			if !TerminalTarget.IsInFaction(pTweakNoCommentApprove)
				TerminalTarget.AddToFaction(pTweakNoCommentApprove)
				TerminalTargetNoCommentApprove = true
				pTweakPositiveCommentsAlert.Show()
			endIf			
		endIf
		
		if backToPip
			utility.waitmenumode(0.2)
			TerminalTargetConvPosToNeg = TerminalTarget.IsInFaction(pTweakConvPosToNeg)
			if (current != TerminalTargetConvPosToNeg)
				pTweakSettingsPersonality.ShowOnPipBoy()
			endIf
		endIf
	endIf
EndFunction

Function ToggleNoCommentIdle(bool backToPip=True)
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("ToggleNoCommentIdle", params)
		return
	endIf

	if (TerminalTarget)
		bool current = TerminalTargetNoCommentIdle
		
		
		if TerminalTarget.IsInFaction(pTweakNoIdleChatter)
			TerminalTarget.RemoveFromFaction(pTweakNoIdleChatter)
		else
			TerminalTarget.AddToFaction(pTweakNoIdleChatter)
		endIf
		
		if backToPip
			utility.waitmenumode(0.2)
			TerminalTargetNoCommentIdle = TerminalTarget.IsInFaction(pTweakNoIdleChatter)
			if (current != TerminalTargetNoCommentIdle)
				pTweakSettingsChat.ShowOnPipBoy()
			endIf
		endIf
	endIf
EndFunction

Function ToggleNoCommentGeneral(bool backToPip=True)
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("ToggleNoCommentGeneral", params)
		return
	endIf

	if (TerminalTarget)
		bool current = TerminalTargetNoCommentGeneral
		
		if TerminalTarget.IsInFaction(pTweakNoCommentGeneral)
			TerminalTarget.RemoveFromFaction(pTweakNoCommentGeneral)
		else
			TerminalTarget.AddToFaction(pTweakNoCommentGeneral)
		endIf
		
		if backToPip
			utility.waitmenumode(0.2)
			TerminalTargetNoCommentGeneral = TerminalTarget.IsInFaction(pTweakNoCommentGeneral)
			if (current != TerminalTargetNoCommentGeneral)
				pTweakSettingsChat.ShowOnPipBoy()
			endIf
		endIf
	endIf
EndFunction

Function ToggleNoCommentApprove(bool backToPip=True)
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("ToggleNoCommentApprove", params)
		return
	endIf

	if (TerminalTarget)
		bool current = TerminalTargetNoCommentApprove
		if TerminalTarget.IsInFaction(pTweakNoCommentApprove)
			TerminalTarget.RemoveFromFaction(pTweakNoCommentApprove)
		else
			TerminalTarget.AddToFaction(pTweakNoCommentApprove)
		endIf
		
		if backToPip
			utility.waitmenumode(0.2)
			TerminalTargetNoCommentApprove = TerminalTarget.IsInFaction(pTweakNoCommentApprove)
			if (current != TerminalTargetNoCommentApprove)
				pTweakSettingsChat.ShowOnPipBoy()
			endIf
		endIf
	endIf
EndFunction

Function ToggleNoCommentDisapprove(bool backToPip=True)
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("ToggleNoCommentDisapprove", params)
		return
	endIf

	if (TerminalTarget)
		bool current = TerminalTargetNoCommentDisapprove
		if TerminalTarget.IsInFaction(pTweakNoCommentDisapprove)
			TerminalTarget.RemoveFromFaction(pTweakNoCommentDisapprove)
		else
			TerminalTarget.AddToFaction(pTweakNoCommentDisapprove)
		endIf
		
		if backToPip
			utility.waitmenumode(0.2)
			TerminalTargetNoCommentDisapprove = TerminalTarget.IsInFaction(pTweakNoCommentDisapprove)
			if (current != TerminalTargetNoCommentDisapprove)
				pTweakSettingsChat.ShowOnPipBoy()
			endIf
		endIf
	endIf
EndFunction

Function ToggleNoCommentActivator(bool backToPip=True)
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = backToPip
		self.CallFunctionNoWait("ToggleNoCommentActivator", params)
		return
	endIf

	if (TerminalTarget)
		bool current = TerminalTargetNoCommentActivator
		if TerminalTarget.IsInFaction(pTweakNoCommentActivator)
			TerminalTarget.RemoveFromFaction(pTweakNoCommentActivator)
		else
			TerminalTarget.AddToFaction(pTweakNoCommentActivator)
		endIf
		
		if backToPip
			utility.waitmenumode(0.2)
			TerminalTargetNoCommentActivator = TerminalTarget.IsInFaction(pTweakNoCommentActivator)
			if (current != TerminalTargetNoCommentActivator)
				pTweakSettingsChat.ShowOnPipBoy()
			endIf
		endIf
	endIf
EndFunction

Function ToggleAllowMultInterjections()
	AFT:TweakInterjectionQuestScript  pTweakInterjectionQuestScript  = pTweakInterjections as AFT:TweakInterjectionQuestScript	
	if (0.0 == pTweakAllowMultInterjections.GetValue())
		pTweakAllowMultInterjections.SetValue(1.0)
		if pTweakInterjectionQuestScript
			pTweakInterjectionQuestScript.RegisterInterjections()
		endIf
	else
		pTweakAllowMultInterjections.SetValue(0.0)
		if pTweakInterjectionQuestScript
			pTweakInterjectionQuestScript.UnRegisterInterjections()
		endIf
	endIf
EndFunction


Function ToggleCommentSynchronous()
	AFT:TweakDFScript pTweakDFScript = (pFollowers AS AFT:TweakDFScript)
	if (pTweakDFScript)
		bool current = pTweakDFScript.CommentSynchronous
		pTweakDFScript.SetCommentSynchronous(!current)
	else
		Trace("Unable to Cast Followers to TweakDFScript")
	endIf

EndFunction

Function ScaleRelay(float change)

	Trace("ScaleRelay()")
	if (Utility.IsInMenuMode())
		Var[] params = new Var[1]
		params[0] = change
		self.CallFunctionNoWait("ScaleRelay", params)
		return		
	endIf
	
	if TerminalTarget
		if (0 == change) ; Reset
			TerminalTarget.SetScale(1.0)
			TerminalTarget.SetValue(pTweakScale,100.0)
			return
		endIf
		float current = TerminalTarget.GetValue(pTweakScale)
		if current < 1.0
			current = 1.0
		endIf
		current = current * change
		if current < 1.0
			current = 1.0
		endIf
		TerminalTarget.SetValue(pTweakScale,current)
		float percent = current/100		
		TerminalTarget.SetScale(percent)
		pTweakCurrentScale.Show(percent)
	endIf
		
EndFunction		
		

Function CancelRelay()

	Trace("CancelRelay()")

	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("CancelRelay", params)
		return
	endIf
	
	; Hack : Bethedsa disabled this by adding the condition Global TrueValue == false. Luckily, 
	; the global is not marked as a constant, so we can enable briefly to allow disabled Topics
	; to play...
	
	GlobalVariable TrueValue = (Game.GetForm(0x00036E00) as GlobalVariable)
	if (None != TrueValue)
		TrueValue.SetValue(0.0)
		SpeakDialogue(TerminalTarget, pTweakTopicCancel, pTweakTopicCancelModID, "pTweakTopicCancel")
		TrueValue.SetValue(1.0)
	else
		Trace("Unable to Retrieve TrueValue GlobalVariable")
	endIf
		
	
endFunction

Function DistFarRelay()

	Trace("DistFarRelay()")

	Utility.waitmenumode(0.1)

	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("DistFarRelay", params)
		return
	endIf
	
	SpeakDialogue(TerminalTarget, pTweakTopicDistFar, pTweakTopicDistFarModID, "pTweakTopicDistFar")

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.SetFollowerDistanceFarByNameId(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to AFT:TweakFollowerScript")		
	endIf
	
EndFunction

Function DistMedRelay()
	Trace("DistMedRelay()")
	
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("DistMedRelay", params)
		return
	endIf
	
	SpeakDialogue(TerminalTarget, pTweakTopicDistMed, pTweakTopicDistMedModID, "pTweakTopicDistMed")

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.SetFollowerDistanceMedByNameId(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to AFT:TweakFollowerScript")		
	endIf
	
EndFunction

Function DistNearRelay()
	Trace("DistNearRelay()")
	
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("DistNearRelay", params)
		return
	endIf
	
	SpeakDialogue(TerminalTarget, pTweakTopicDistNear, pTweakTopicDistNearModID, "pTweakTopicDistNear")

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.SetFollowerDistanceNearByNameId(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to AFT:TweakFollowerScript")		
	endIf
	
EndFunction

Function StyleAutoRelay()
	Trace("StyleAutoRelay()")
	
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("StyleAutoRelay", params)
		return
	endIf
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.SetFollowerStanceAutoByNameId(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to AFT:TweakFollowerScript")		
	endIf
	
EndFunction

Function StyleAggRelay()
	Trace("StyleAggRelay()")
	
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("StyleAggRelay", params)
		return
	endIf
	
	SpeakDialogue(TerminalTarget, pTweakTopicStyleAgg, pTweakTopicStyleAggModID, "pTweakTopicStyleAgg")

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.SetFollowerStanceAggressiveByNameId(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to AFT:TweakFollowerScript")		
	endIf
	
EndFunction

Function StyleDefRelay()
	Trace("StyleDefRelay()")
	
	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("StyleDefRelay", params)
		return
	endIf
	
	SpeakDialogue(TerminalTarget, pTweakTopicStyleDef, pTweakTopicStyleDefModID, "pTweakTopicStyleDef")
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.SetFollowerStanceDefensiveByNameId(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
	endIf
	
EndFunction

Function StayRelay()
	Trace("StayRelay()")

	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("StayRelay", params)
		return
	endIf
	
	if TerminalTarget && TerminalTargetUnmanaged
		Trace("UnManaged NPC Detected. Using Raw implementation")
		AFT:TweakDFScript DFScript = (pFollowers as AFT:TweakDFScript)
		if DFScript
			DFScript.FollowerWait(TerminalTarget)
		endIf
		return
	endIf

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.SetFollowerStayByNameId(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
	endIf
	
EndFUnction

Function HangoutRelay()
	Trace("HangoutRelay()")

	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("HangoutRelay", params)
		return
	endIf
	
	if TerminalTarget && TerminalTargetUnmanaged
		Trace("UnManaged NPC Detected. Using Raw implementation")
		AFT:TweakDFScript DFScript = (pFollowers as AFT:TweakDFScript)
		if DFScript
			DFScript.FollowerHangout(TerminalTarget)
		endIf
		return
	endIf

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.SetFollowerHangoutByNameId(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
	endIf
	
EndFUnction

Function FollowRelay()
	Trace("FollowRelay()")

	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("FollowRelay", params)
		return
	endIf

	if TerminalTarget && TerminalTargetUnmanaged
		Trace("UnManaged NPC Detected. Using Raw implementation")
		AFT:TweakDFScript DFScript = (pFollowers as AFT:TweakDFScript)
		if DFScript
			DFScript.FollowerFollow(TerminalTarget)
		endIf
		return
	endIf
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.SetFollowerFollowByNameId(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to AFT:TweakFollowerScript")		
	endIf
	
EndFUnction


Function DismissRelay()

	Trace("DismissRelay()")

	Utility.waitmenumode(0.1)
	
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("DismissRelay", params)
		return
	endIf
	
	SpeakDialogue(TerminalTarget, pTweakTopicDismiss, pTweakTopicDismissModID, "pTweakTopicDismiss")
	
	if TerminalTarget && TerminalTargetUnmanaged
		Trace("UnManaged NPC Detected. Using Raw implementation")
		AFT:TweakDFScript DFScript = (pFollowers as AFT:TweakDFScript)
		if DFScript
			DFScript.DismissCompanion(TerminalTarget)
		endIf
		return
	endIf
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.DismissFollowerByNameId(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
	endIf

endFunction

Function BehindMeRelay()
	
	Trace("BehindMeRelay()")
	Utility.waitmenumode(0.1)
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("BehindMeRelay", params)
		return
	endIf

	if TerminalTarget && TerminalTargetUnmanaged
		Trace("UnManaged NPC Detected. Using Raw implementation")	
		Float [] posdata=TraceCircle(Game.GetPlayer(), 120, 180)		
		TerminalTarget.SetPosition(posdata[0],posdata[1],posdata[2])
		return
	endIf
		
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.MoveToPlayerByNameId(id=TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
	endIf
	
EndFunction


Function SummonRelay()
	
	Trace("SummonRelay()")
	Utility.waitmenumode(0.1)
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("SummonRelay", params)
		return
	endIf

	; SpeakDialogue(TerminalTarget, pTweakTopicAck, pTweakTopicAckModID, "pTweakTopicAck", 50, 50)
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.MoveToPlayerByNameId(id=TerminalTargetId, excludeWaiting=false, startingOffset = 0)
	else
		Trace("Unable to Cast TweakFollower to AFT:TweakFollowerScript")		
	endIf
	
EndFunction

Function UnEquipAllRelay()

	Trace("UnEquipAllRelay()")
	Utility.waitmenumode(0.1)
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("UnEquipAllRelay", params)
		return
	endIf

	SpeakDialogue(TerminalTarget, pTweakTopicAck, pTweakTopicAckModID, "pTweakTopicAck", 50, 50)
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.UnEquipGearByNameId(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to AFT:TweakFollowerScript")		
	endIf

EndFunction

Function TakePlayerJunkRelay()

	Trace("TakePlayerJunkRelay()")
	Utility.waitmenumode(0.1)
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("TakePlayerJunkRelay", params)
		return
	endIf

	SpeakDialogue(TerminalTarget, pTweakTopicAck, pTweakTopicAckModID, "pTweakTopicAck", 15, 15)
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.TakePlayerJunk(TerminalTarget)
	else
		Trace("Unable to Cast TweakFollower to AFT:TweakFollowerScript")		
	endIf

EndFunction

Function TakePlayerDuplicatesRelay()

	Trace("TakePlayerDuplicatesRelay()")
	Utility.waitmenumode(0.1)
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("TakePlayerDuplicatesRelay", params)
		return
	endIf

	SpeakDialogue(TerminalTarget, pTweakTopicAck, pTweakTopicAckModID, "pTweakTopicAck", 15, 15)
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.TakePlayerDuplicates(TerminalTarget)
	else
		Trace("Unable to Cast TweakFollower to AFT:TweakFollowerScript")		
	endIf

EndFunction

Function ScrapJunkRelay()

	Trace("ScrapJunkRelay()")
	Utility.waitmenumode(0.1)
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("ScrapJunkRelay", params)
		return
	endIf

	SpeakDialogue(TerminalTarget, pTweakTopicAck, pTweakTopicAckModID, "pTweakTopicAck", 15, 15)
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.ScrapJunk(TerminalTarget)
	else
		Trace("Unable to Cast TweakFollower to AFT:TweakFollowerScript")		
	endIf

EndFunction

Function GivePlayerJunkRelay()

	Trace("GivePlayerJunkRelay()")
	Utility.waitmenumode(0.1)
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("GivePlayerJunkRelay", params)
		return
	endIf

	if (0 != TerminalTargetId)
		SpeakDialogue(TerminalTarget, pTweakTopicAck, pTweakTopicAckModID, "pTweakTopicAck", 15, 15)
	endIf
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.GivePlayerJunkByNameID(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to AFT:TweakFollowerScript")		
	endIf

EndFunction

Function GivePlayerScrapRelay()

	Trace("GivePlayerScrapRelay()")
	Utility.waitmenumode(0.1)
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("GivePlayerScrapRelay", params)
		return
	endIf

	if (0 != TerminalTargetId)
		SpeakDialogue(TerminalTarget, pTweakTopicAck, pTweakTopicAckModID, "pTweakTopicAck", 15, 15)
	endIf
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.GivePlayerScrapByNameID(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to AFT:TweakFollowerScript")		
	endIf

EndFunction

Function SellUnusedRelay()

	Trace("SellUnusedRelay()")
	Utility.waitmenumode(0.1)
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("SellUnusedRelay", params)
		return
	endIf

	SpeakDialogue(TerminalTarget, pTweakTopicAck, pTweakTopicAckModID, "pTweakTopicAck", 15, 15)
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.SellUnused(TerminalTarget)
	else
		Trace("Unable to Cast TweakFollower to AFT:TweakFollowerScript")		
	endIf

EndFunction

Function UnManageNPC()

	Trace("UnManageNPC()")
	Utility.waitmenumode(0.1)
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("UnManageNPC", params)
		return
	endIf

	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.UnManageFollower(TerminalTarget)
	else
		Trace("Unable to Cast TweakFollower to AFT:TweakFollowerScript")		
	endIf
	
EndFunction

Function TransferUnusedRelay()

	Trace("TransferUnusedRelay()")
	Utility.waitmenumode(0.1)
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("TransferUnusedRelay", params)
		return
	endIf

	if (0 != TerminalTargetId)
		SpeakDialogue(TerminalTarget, pTweakTopicAck, pTweakTopicAckModID, "pTweakTopicAck", 15, 15)
	endIf
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.TransferUnusedByNameID(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to AFT:TweakFollowerScript")		
	endIf

EndFUnction

Function TransferAllRelay()

	Trace("TransferAllRelay()")
	Utility.waitmenumode(0.1)
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("TransferAllRelay", params)
		return
	endIf

	if (0 != TerminalTargetId)
		SpeakDialogue(TerminalTarget, pTweakTopicAck, pTweakTopicAckModID, "pTweakTopicAck", 15, 15)
	endIf
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.TransferAllByNameID(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to AFT:TweakFollowerScript")		
	endIf

EndFUnction

Function EnterPowerArmorRelay()

	Trace("EnterPowerArmorRelay()")
	
	Utility.waitmenumode(0.1)
	if (Utility.IsInMenuMode())
		Var[] params = new Var[0]
		self.CallFunctionNoWait("EnterPowerArmorRelay", params)
		return
	endIf

	if (0 != TerminalTargetId)
		SpeakDialogue(TerminalTarget, pTweakTopicAck, pTweakTopicAckModID, "pTweakTopicAck", 15, 15)
	endIf
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		pTweakFollowerScript.EnterPowerArmorByNameId(TerminalTargetId)
	else
		Trace("Unable to Cast TweakFollower to AFT:TweakFollowerScript")		
	endIf
	
EndFunction

Bool Function SpeakDialogue(Actor aSpeaker, ActorValue pTopicAV, ActorValue pModIDAV, string hint = "", int first_prob=100, int secondary_prob=100 )
	Trace("SpeakDialogue() Called for [" + aSpeaker + "] (" + TerminalTargetId + ")")
	if aSpeaker.IsInFaction(pTweakNoCommentActivator)
		Trace("Returning False. Actor member of NoCommentActivator")
		return false
	endIf	
	if aSpeaker.IsUnconscious()
		Trace("Returning False. Actor isn't conscious")
		; This wouldn't make sense...
		return false
	endIf	
	if aSpeaker.IsTalking()
		Trace("Skipping. NPC is already talking.")
		int maxwait = 20
		while (aSpeaker.IsTalking() && maxwait > 0)
			Trace("Waiting for talking to stop...")
			Utility.wait(0.5)
			maxwait -= 1
		endwhile
		return false
	endIf

	Actor playerRef = Game.GetPlayer()
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (!pTweakFollowerScript)
		Trace("Cast to AFT:TweakFollowerScript Failed")	
		return false
	endIf
	
	int formAV = (aSpeaker.GetValue(pTopicAV) as Int)
	if (0 == formAV)
		Trace("Topic [" + hint + "] not defined for NPC [" + aSpeaker + "]")
		if ((TerminalTargetRace == 1 || TerminalTargetRace == 2) && (pTweakTopicHello == pTopicAV || pTweakTopicAck == pTopicAV))
			formAV = 0x0016CC60 ; Generic "Yes"
		else
			return false
		endIf
	else
		Trace("Topic [" + hint + "] found for NPC [" + aSpeaker + "]")
	endIf
	
	Form flookup = None
	int modID  = aSpeaker.GetValue(pModIDAV) as Int	
	if modID != 0
		if modID < 256 ; modID < 0x00000100
			int fullformid = formAV + (modID * 0x01000000)
			Trace("Full FormID [" + fullformid + "]")
			flookup = Game.GetForm(fullformid)
		elseif modID == 256 ; modID == 0x00000100
			Trace("AFT FormID [" + formAV + "]")
			
			; TODO: Consider caching previous formAV and testing for equality and re-use previous flookup
			; to avoid constant GetFormFromFile() operations...
			
			flookup = Game.GetFormFromFile(formAV, "AmazingFollowerTweaks.esp")
		elseif modID == 257 ; modID == 0x00000101
			Trace("DLC01 FormID [" + formAV + "]")
			
			; TODO: Consider caching previous formAV and testing for equality and re-use previous flookup
			; to avoid constant GetFormFromFile() operations...
			
			flookup = Game.GetFormFromFile(formAV, "DLCRobot.esm")
		elseif modID == 259 ; modID == 0x00000103
			Trace("DLC03 FormID [" + formAV + "]")
			
			; TODO: Consider caching previous formAV and testing for equality and re-use previous flookup
			; to avoid constant GetFormFromFile() operations...
			
			flookup = Game.GetFormFromFile(formAV, "DLCCoast.esm")
		elseif modID == 260 ; modID == 0x00000104
			Trace("DLC04 FormID [" + formAV + "]")
			
			; TODO: Consider caching previous formAV and testing for equality and re-use previous flookup
			; to avoid constant GetFormFromFile() operations...
			
			flookup = Game.GetFormFromFile(formAV, "DLCNukaWorld.esm")
		endIf
	else
		Trace("FormID [" + formAV + "]")
		flookup = Game.GetForm(formAV)
	endIf
	
	if (None == flookup)
		Trace("Invalid FormID (" + formAV + ") for Topic [" + hint + "] on NPC [" + aSpeaker + "]")
		return false
	endIf	
	Topic t = (flookup as Topic)
	if (None == t)
		; Try FormList
		FormList fl = (flookup as FormList)
		if (None == fl)
			Trace("Failed to cast FormID (" + formAV + "), Topic [" + hint + "], NPC [" + aSpeaker + "] to Topic or FormList")
			return false
		endIf
		int numtopics = fl.GetSize()
		Trace("ActorValue points at formlist [" + fl + "] with [" + numtopics + "] Topics")
		if (0 == numtopics)
			Trace("FormList (" + formAV + "), Topic [" + hint + "], NPC [" + aSpeaker + "] is empty. Skipping")
			return false
		endIf	
		if (Utility.RandomInt(1,100) < first_prob)
			Trace("First Roll below [" + first_prob + "] Using Offset [0]")
			t = (fl.GetAt(0) as Topic)
		elseif (numtopics > 1) && (Utility.RandomInt(1,100) < secondary_prob)
			int sindex = (Utility.RandomInt(2,numtopics) - 1)
			Trace("Second Roll below [" + secondary_prob + "] Using Offset [" + sindex + "]")
			t = (fl.GetAt(sindex) as Topic)
			if (!t)
				Trace("Unable to cast FormList[" + sindex + "] (" + formAV + "), Topic [" + hint + "], NPC [" + aSpeaker + "] to Topic. Using primary")
				t = (fl.GetAt(0) as Topic)
			endIf
		else
			Trace("Skipping Voice (didn't role)")
			return false
		endIf
	endIf
	if (t)
		aSpeaker.SetHeadTracking(true)
		if !aSpeaker.HasDetectionLOS(playerRef)
			if (!aSpeaker.IsInFaction(pTweakPosedFaction))
				if (playerRef.GetDistance(aSpeaker) > 1000)			
					Trace("Skipping Voice (out of range)")
					aSpeaker.SetHeadTracking(false)
					return false
				endIf			
				Trace("NPC is not facing Player. Attempting Translate")
				float zOffset = aSpeaker.GetHeadingAngle(playerRef)
				aSpeaker.TranslateTo(aSpeaker.GetPositionX(), aSpeaker.GetPositionY(), aSpeaker.GetPositionZ(), aSpeaker.GetAngleX(), aSpeaker.GetAngleY(), aSpeaker.GetAngleZ() + zOffset, 100.0, 200.0)
				Utility.Wait(1.0)
			else
				Trace("NPC is posed. Skipping translation")
			endIf	
		else
			Trace("NPC has LOS with player. Skipping translation")
		endIf
		

		Trace("Speaking topic: " + t)
		aSpeaker.Say(t,aSpeaker,false,Game.GetPlayer())
		Utility.wait(0.5)
		int maxwait = 20
		while (aSpeaker.IsTalking() && maxwait > 0)
			Trace("Waiting for talking to stop...")
			Utility.wait(0.5)
			maxwait -= 1
		endwhile
		aSpeaker.SetHeadTracking(false)
		return true	
	endIf
		
	Trace("Unable to cast FormList[0] (" + formAV + "), Topic [" + hint + "], NPC [" + aSpeaker + "] to Topic.")
	return false
	
EndFunction


; So External Quests can reset gracefully (It is Okay to read externally,
; but writing/updating should only be done by this quest script incase
; we need to add mutexes in the future)
Function ResetTerminalTarget()
	Trace("ResetTerminalTarget() Called")

	TerminalTarget = None
	TerminalTargetId = 0
EndFunction

Function SetActivateOnNameSelect(int f)
	Trace("SetActivateOnNameSelect() Called")
	; ActivateOnNameSelect:
	;   0 = Do nothing
	;   1 = Assign Name
	;   2 = Locate
	;   3 = UnManage
	;   4 = Lock Rotation
	ActivateOnNameSelect = f
EndFunction

Function OnNameSelected(int id)
	Trace("OnNameSelected [" + id + "] ActivateOnNameSelect [" + ActivateOnNameSelect + "]")
	if (id > 0)	
		AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
		if (pTweakFollowerScript)

			if (1 == ActivateOnNameSelect)
				ActivateOnNameSelect = 0
				AFT:TweakNamesScript pTweakNamesScript = (pTweakNames as AFT:TweakNamesScript)
				if (pTweakNamesScript)
					pTweakNamesScript.AssignName(TerminalTarget,id)
				else
					Trace("Unable to Cast TweakNames to TweakNamesScript")		
				endIf
				return
			endIf

			if (2 == ActivateOnNameSelect)
				pTweakFollowerScript.LocateFollowerByNameID(id)
				ActivateOnNameSelect = 0
				return
			endIf
			
			if (3 == ActivateOnNameSelect)
				ActivateOnNameSelect = 0
				; Confirm TerminalTarget is not None and doesn't equal supplied id. 
				; Silent Dismiss TerminalTarget. Summon Swap NPC to Player and silent SetCompanion
				; Teleport DimissedTerminalTarget to their HOME location. 
				Var[] params = new Var[1]
				params[0] = id
				pTweakFollowerScript.CallFunctionNoWait("UnManageByNameID", params)
				return
			endIf
					
			if (4 == ActivateOnNameSelect)
				ActivateOnNameSelect = 0
				Var[] params = new Var[1]
				params[0] = id
				pTweakFollowerScript.CallFunctionNoWait("LockRotationByNameID", params)
				return
			endIf
			
			; 0 == ActivateOnNameSelect : Load the specified follower into the Terminal Target...
			TerminalTarget = pTweakFollowerScript.GetManagedByNameId(id)

			; TODO : While EvaluateTerminalTarget fixed ID/Instance stuff, we still need to 
			;        Relay a "SELECTION" event to TweakDFScript so that the NPC is made pCompanion 
			;        . If need be, CurrentCompanion faction might also be added (probably not though)

			EvaluateTerminalTarget()
			
		endIf
	else
		TerminalTarget   = None
		TerminalTargetId = 0
	endIf
	
EndFunction


Function LockRotationSetup()
	Trace("LockRotationSetup")
	CurrentFollowerTogglesOn()
	ActivateOnNameSelect = 4	
EndFunction

Function UnManageNPCSetup()
	Trace("UnManageNPCSetup")
	CurrentManagedTogglesOn()
	ActivateOnNameSelect = 3	
EndFunction


Function LocateNPCSetup()
	Trace("LocateNPCSetup")
	CurrentManagedTogglesOn()
	ActivateOnNameSelect = 2	
EndFunction

Function AssignNameSetup()
	Trace("AssignNameSetup Called")
	if (!TerminalTarget)
		Trace("No Terminal Target Detected")
		AllTogglesOff()
		return
	endIf
	AvailableCustomNameTogglesOn()
	ActivateOnNameSelect = 1
	return
EndFunction

; =====  SelectNameTerminal Managment ======
; These are typically called by TweakFollowerScript to prep the
; 110 global variables needed to support the SelectNameTerminal.
; Damn shame alias token substitution doesn't work when terminal
; is displayed on Pipboy... Maybe one day they will fix...

Function AllTogglesOn()
	Trace("AllTogglesOn() Called")
	int size = pTweakToggles.GetSize()
	if (size > 0)
		int i = 0
		Trace("Updating [" + size + "] toggles")
		while (i != size)
			GlobalVariable toggle = (pTweakToggles.GetAt(i) As GlobalVariable)
			toggle.SetValue(1.0)
			i += 1
		endWhile
	endIf
EndFunction

Function AllTogglesOff()
	Trace("AllTogglesOff() Called")
	int size = pTweakToggles.GetSize()
	if (size > 0)
		int i = 0
		Trace("Updating [" + size + "] toggles")
		while (i != size)
			GlobalVariable toggle = (pTweakToggles.GetAt(i) As GlobalVariable)
			toggle.SetValue(0.0)
			i += 1
		endWhile
	endIf
EndFunction

Function CurrentManagedTogglesOn()
	bool[] mask
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)	
	if (!pTweakFollowerScript)
		Trace("Unable to Cast TweakFollower to AFT:TweakFollowerScript")
		AllTogglesOn()
		return
	else	
		mask = pTweakFollowerScript.GetManagedNameSlots()
	endIf
	
	int masklen = mask.Length
	if (masklen > pTweakToggles.GetSize())
		Trace("GetManagedNameSlots() returned more slots than supported. Truncating")
		masklen = pTweakToggles.GetSize()
	endIf
	
    int i = 0
	while (i < masklen)
		GlobalVariable toggle = (pTweakToggles.GetAt(i) As GlobalVariable)	
		if (mask[i])
			toggle.SetValue(1.0)
		else
			toggle.SetValue(0.0)
		endIf
		i += 1
	endWhile
endFunction

Function CurrentFollowerTogglesOn()
	Trace("CurrentFollowerTogglesOn()")
	AllTogglesOff()
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	if (!pTweakFollowerScript)
		Trace("Unable to Cast TweakFollower to TweakFollowerScript")		
		return
	endIf	
	int[] followerNameIds = pTweakFollowerScript.GetCurrentFollowerNameSlots()
	int followerNameIdslen = followerNameIds.Length
	Trace("GetCurrentFollowerNameSlots() returned [" + followerNameIdslen + "] Name Ids")			
	int i  = 0
	int id = 0
	while (i < followerNameIdslen)
		id = followerNameIds[i]
		GlobalVariable toggle = (pTweakToggles.GetAt(id) As GlobalVariable)
		toggle.SetValue(1.0)
		i += 1
	endwhile
endFunction

Function AvailableCustomNameTogglesOn()

    ; First entry is Unknown (index 0)
	; Next 18 (index 1 - 18) are common + reserved names.  
	; Next 32 (index 19 -> 50) are generics (follower 1, follower 2, etc...)
	; Beyond that (index 51 and up) are custom names.
	
	Trace("AvailableCustomNameTogglesOn()")
	
	int size = pTweakToggles.GetSize()
	int FirstCustom = 51
	int i = 0
	Trace("Flipping [" + FirstCustom + "] toggles off")
	while (i != FirstCustom)
		GlobalVariable toggle = (pTweakToggles.GetAt(i) As GlobalVariable)
		toggle.SetValue(0.0)
		i += 1
	endWhile

	if (size < 52)
		Trace("TweakToggles size < 52. Aborting...")
		return
	endIf
	
	int maxnumcustom = (size - 51) ; should be 60...
	
	bool[] mask
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower AS AFT:TweakFollowerScript)
	
	if (!pTweakFollowerScript)
		Trace("Unable to Cast TweakFollower to AFT:TweakFollowerScript")
		mask = new bool[60]
		i = 0
		while (i < 60)
			mask[i] = true
			i += 1
		endwhile
	else
		mask = pTweakFollowerScript.GetAvailableCustomNameSlots()
	endIf
	
	int masklen = mask.Length
	if (masklen > maxnumcustom)
		Trace("GetUsedCustomNameSlots() returned more slots than supported. Truncating")
		masklen = maxnumcustom
	endIf
	
	int valueplus51 = 51

    i = 0
	while (i < masklen)
		GlobalVariable toggle = (pTweakToggles.GetAt(valueplus51) As GlobalVariable)	
		if (mask[i])
			toggle.SetValue(1.0)
		else
			toggle.SetValue(0.0)
		endIf
		i += 1
		valueplus51 += 1
	endWhile
			
EndFunction

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

Float Function ConvertToSinCosCompatibleAngle(Float original, Float angleOffset = 0.0)

	; See TweakFollowerScript for explanation
	return Enforce360Bounds(450 - original + angleOffset)	
	
EndFunction

Float Function Enforce360Bounds(float a)
    if (a < 0) 
        a = a + 360
    endIf
    if (a > 360)
        a = a - 360
    endIf 
	return a
EndFunction  