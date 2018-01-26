Scriptname AFT:TweakInfoScript extends Quest

ReferenceAlias	Property pInfoNPC	Auto Const
ReferenceAlias	Property pInfoBook	Auto Const
ReferenceAlias	Property pPlayer	Auto Const

Faction		Property pCurrentCompanionFaction 	Auto Const
FormList	Property pTweakCommonFactionNames 	Auto Const
FormList	Property pTweakCommonFactions 	  	Auto Const
FormList	Property pTweakScanKeywords			Auto Const
FormList	Property pTweakScanKeywordsNames	Auto Const
FormList	Property pTweakScanSpells			Auto Const
FormList	Property pTweakScanSpellsNames		Auto Const
FormList	Property pTweakScanEffects			Auto Const
FormList	Property pTweakScanEffectsNames		Auto Const
FormList	Property pTweakScanPerks			Auto Const
FormList	Property pTweakScanPerksNames		Auto Const
Message		Property pTweakInfoMore 			Auto Const
Faction		Property pTweakCampHomeFaction 		Auto Const

; Book Flavors
Book		Property pTweakInfoBookStats 		Auto Const
Book		Property pTweakInfoBookRelationship	Auto Const
Book		Property pTweakInfoBookAI			Auto Const
Book		Property pTweakInfoBookTraits		Auto Const
Book		Property pTweakInfoBookEffects		Auto Const
Book		Property pTweakInfoBookPerks		Auto Const
Book		Property pTweakInfoBookFactions		Auto Const
Book		Property pTweakInfoBookKeywords		Auto Const
Book		Property pTweakInfoBookReactions	Auto Const
Book		Property pTweakInfoBook 			Auto Const

ActorValue		Property pCA_Affinity			Auto Const
ActorValue		Property pCA_CurrentThreshold	Auto Const
GlobalVariable	Property pCA_T1_Infatuation		Auto Const ; 1000
GlobalVariable	Property pCA_TCustom1_Confidant	Auto Const ; 750
GlobalVariable	Property pCA_T2_Admiration		Auto Const ; 500
GlobalVariable	Property pCA_TCustom2_Friend	Auto Const ; 250
GlobalVariable	Property pCA_T3_Neutral			Auto Const ; 0
GlobalVariable	Property pCA_T4_Disdain			Auto Const ; -500
GlobalVariable	Property pCA_T5_Hatred			Auto Const ; -1000

Message		Property pTweakInfoNA				Auto Const
Message		Property pTweakInfoTrue 			Auto Const
Message		Property pTweakInfoFalse			Auto Const
Message		Property pTweakInfoInLove			Auto Const
Message		Property pTweakInfoInfatuated		Auto Const
Message		Property pTweakInfoConfidant		Auto Const
Message		Property pTweakInfoAdmiration		Auto Const
Message		Property pTweakInfoFriend			Auto Const
Message		Property pTweakInfoNeutral			Auto Const
Message		Property pTweakInfoDisdain			Auto Const
Message		Property pTweakInfoHate				Auto Const

ActorValue	Property pAggression    			Auto Const
Message		Property pTweakInfoUnaggressive		Auto Const ; 0
Message		Property pTweakInfoAggressive		Auto Const ; 1
Message		Property pTweakInfoVeryAggressive	Auto Const ; 2
Message		Property pTweakInfoFrenzied			Auto Const ; 3

ActorValue	Property pConfidence    			Auto Const
Message		Property pTweakInfoCowardly			Auto Const ; 0
Message		Property pTweakInfoCautious			Auto Const ; 1
Message		Property pTweakInfoAverage			Auto Const ; 2
Message		Property pTweakInfoBrave			Auto Const ; 3
Message		Property pTweakInfoFoolhardy		Auto Const ; 4

ActorValue	Property pAssistance				Auto Const  
Message		Property pTweakInfoHelpsNobody		Auto Const ; 0
Message		Property pTweakInfoHelpsAllies		Auto Const ; 1
Message		Property pTweakInfoHelpsFriends		Auto Const ; 2

ActorValue	Property pMorality      			Auto Const
Message		Property pTweakInfoAnyCrime			Auto Const ; 0
Message		Property pTweakInfoViolentCrime		Auto Const ; 1
Message		Property pTweakInfoPropertyCrime	Auto Const ; 2
Message		Property pTweakInfoNoCrime			Auto Const ; 3

Message		Property pTweakInfoAftCamp			Auto Const
Message		Property pTweakInfoEmpty			Auto Const

Race		Property pAlienRace					Auto Const
Race		Property pDogmeatRace				Auto Const
Race		Property pFEVHoundRace				Auto Const
Race		Property pRaiderDogRace				Auto Const
Race		Property pSuperMutantRace			Auto Const
Race		Property pViciousDogRace			Auto Const
Race		Property pHumanRace					Auto Const

Message		Property pTweakInfoAlien			Auto Const
Message		Property pTweakInfoDog				Auto Const
Message		Property pTweakInfoSuperMutant		Auto Const
Message		Property pTweakInfoSuperMutt		Auto Const
Message		Property pTweakInfoHumanSynth		Auto Const

Message		Property pTweakInfoFFIgnore			Auto Const
Message		Property pTweakInfoFFReact			Auto Const

Perk		Property pImmuneToRadiation			Auto Const
Perk		Property pImmuneToPoison			Auto Const
Quest		Property pBoS301					Auto Const
Message		Property pTweakInfoInspecting 		Auto Const

; Reaction Scan
Faction			property pTweakNoDisapprove			Auto Const
Faction			property pTweakNoApprove			Auto Const
Faction			property pTweakConvNegToPos			Auto Const
Faction			property pTweakConvPosToNeg			Auto Const

GlobalVariable  Property CA_Event_Likes				Auto Const
GlobalVariable  Property CA_Event_Loves				Auto Const
GlobalVariable  Property CA_Event_Dislikes			Auto Const
GlobalVariable  Property CA_Event_Hates				Auto Const
GlobalVariable  Property TweakRevealSynth			Auto Const

ActorValue	Property CA_Trait_Generous			Auto Const
ActorValue	Property CA_Trait_Mean				Auto Const
ActorValue	Property CA_Trait_Nice				Auto Const
ActorValue	Property CA_Trait_Peaceful			Auto Const
ActorValue	Property CA_Trait_Selfish			Auto Const
ActorValue	Property CA_Trait_Violent			Auto Const
Keyword		Property CA__CustomEvent_Generous	Auto Const
Keyword		Property CA__CustomEvent_Mean		Auto Const
Keyword		Property CA__CustomEvent_Nice		Auto Const
Keyword		Property CA__CustomEvent_Peaceful	Auto Const
Keyword		Property CA__CustomEvent_Selfish	Auto Const
Keyword		Property CA__CustomEvent_Violent	Auto Const
Keyword		Property CA__CustomEvent_MinSettlementHelp			Auto Const
Keyword		Property CA__CustomEvent_MinSettlementRefuseHelp	Auto Const
Keyword		Property CA_Event_ChemAddiction		Auto Const
Keyword		Property CA_Event_ChemUse			Auto Const
Keyword		Property CA_Event_DonateItem		Auto Const
Keyword		Property CA_Event_DrinkAlcohol		Auto Const
Keyword		Property CA_Event_EatCorpse			Auto Const
Keyword		Property CA_Event_EnterPowerArmor	Auto Const
Keyword		Property CA_Event_EnterVertibird	Auto Const
Keyword		Property CA_Event_HackComputer		Auto Const
Keyword		Property CA_Event_HealDogmeant		Auto Const
Keyword		Property CA_Event_ModArmor			Auto Const
Keyword		Property CA_Event_ModWeapon			Auto Const
Keyword		Property CA_Event_Murder			Auto Const
Keyword		Property CA_Event_PickLock			Auto Const
Keyword		Property CA_Event_PickLockOwnedDoor	Auto Const
Keyword		Property CA_Event_SpeechForMoreCaps	Auto Const
Keyword		Property CA_Event_Steal				Auto Const
Keyword		Property CA_Event_StealPickPocket	Auto Const
Keyword		Property CA_Event_WalkAroundNaked	Auto Const
Message		Property pTweakInfoReactionNone		Auto Const
Message		Property pTweakInfoReactionLikes	Auto Const
Message		Property pTweakInfoReactionDislikes	Auto Const
Message		Property pTweakInfoReactionLoves	Auto Const
Message		Property pTweakInfoReactionHates	Auto Const

TweakDLC03Script Property pTweakDLC03Script		Auto Const

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakInfo"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

; Which Book do we instantiate?
; 0 = All
; 1 = Stats
; 2 = Relationship
; 3 = AI
; 4 = Traits
; 5 = Effects
; 6 = Perks
; 7 = Factions
; 8 = Keywords
; 9 = Reactions
Function Setup(int type = 0)
	Trace("Setup(" + type + ")")
	
	Actor pc = pPlayer.GetActorReference()
	Actor npc = pInfoNPC.GetActorReference()
	ObjectReference theBook

	if (9 == type)
		theBook = pc.PlaceAtMe(pTweakInfoBookReactions)
	elseif (8 == type)
		theBook = pc.PlaceAtMe(pTweakInfoBookKeywords)
	elseif (7 == type)
		theBook = pc.PlaceAtMe(pTweakInfoBookFactions)
	elseif (6 == type)
		theBook = pc.PlaceAtMe(pTweakInfoBookPerks)
	elseif (5 == type)
		theBook = pc.PlaceAtMe(pTweakInfoBookEffects)
	elseif (4 == type)
		theBook = pc.PlaceAtMe(pTweakInfoBookTraits)
	elseif (3 == type)
		theBook = pc.PlaceAtMe(pTweakInfoBookAI)
	elseif (2 == type)
		theBook = pc.PlaceAtMe(pTweakInfoBookRelationship)
	elseif (1 == type)
		theBook = pc.PlaceAtMe(pTweakInfoBookStats)
	else
		theBook = pc.PlaceAtMe(pTweakInfoBook)
	endif
	pInfoBook.ForceRefTo(theBook)
	if (9 == type) ; Reactions
		UpdateReactions(npc, theBook)
	elseif (8 == type) ; Keywords
		UpdateKeywords(npc, theBook)
	elseif (7 == type) ; Factions
		; Must be called from TweakFollowersScript
	elseif (6 == type) ; Perks
		UpdatePerks(npc, theBook)
	elseif (5 == type) ; Effects
		UpdateEffects(npc, theBook)
	elseif (4 == type) ; Traits
		; Must be called from TweakFollowersScript
	elseif (3 == type) ; AI
		; Must be called from TweakFollowersScript
	elseif (2 == type) ; Relationship
		; Globals must be set from TweakFollowersScript
		UpdateRelationship(npc, theBook)		
	elseif (1 == type) ; Stats
		; Globals must be set from TweakFollowersScript
	else
		Trace("Update Keywords")
		UpdateKeywords(npc, theBook)
		pTweakInfoInspecting.Show()		
		Trace("Update Perks")
		UpdatePerks(npc, theBook)		
		pTweakInfoInspecting.Show()		
		Trace("Update Effects")
		UpdateEffects(npc, theBook)
		pTweakInfoInspecting.Show()		
		Trace("Update Relationship")
		UpdateRelationship(npc, theBook)		
		pTweakInfoInspecting.Show()
		Trace("Update Reactions")
		UpdateReactions(npc, theBook)
		pTweakInfoInspecting.Show()
	endif
	
EndFunction

Function UpdateFactions(Faction[] originalFactions)
	Trace("UpdateFactions()")
	Actor pc = pPlayer.GetActorReference()	
	Actor npc = pInfoNPC.GetActorReference()
	ObjectReference theBook =  pInfoBook.GetReference()
	if !theBook
		theBook = pc.PlaceAtMe(pTweakInfoBook)
		if theBook
			pInfoBook.ForceRefTo(theBook)
		endif
	endif
	
	if !npc || !theBook
		Trace("npc or book is empty. Aborting")
		return		
	endif

	int maxdisplayfactions = 20

	string[] FactionTokens = new string[maxdisplayfactions]	
	int i = 0
	while (i < maxdisplayfactions)
		FactionTokens[i] = "TweakFaction" + (i + 1)
		i += 1
	endwhile
	
	Faction ftest
	Message fname
	int tokenindex = 0
	i = 0 
	int numfactionstocheck = pTweakCommonFactions.GetSize()
	while (i < numfactionstocheck && tokenindex < maxdisplayfactions)
		ftest = pTweakCommonFactions.GetAt(i) as Faction
		if (-1 != originalFactions.Find(ftest))
			fname = pTweakCommonFactionNames.GetAt(i) as Message
			theBook.AddTextReplacementData(FactionTokens[tokenindex], fname)
			tokenindex += 1
		endif
		i += 1
	endwhile
	
	; You have to fill in all tokens or the parse barfs and bails....
	while (tokenindex < 20)
		theBook.AddTextReplacementData(FactionTokens[tokenindex], pTweakInfoEmpty)
		tokenindex += 1
	endwhile
		
EndFunction

Function UpdateAI(int oAggression, int oConfidence, int oAssistance, int oMorals)
	Trace("UpdateAI()")
	Actor npc = pInfoNPC.GetActorReference()
	ObjectReference theBook =  pInfoBook.GetReference()
	
	if !npc || !theBook
		Trace("npc or book is empty. Aborting")
		return		
	endif

	if (3 == oAggression)
		theBook.AddTextReplacementData("TweakOriginalAggression", pTweakInfoFrenzied)
	elseif (2 == oAggression)
		theBook.AddTextReplacementData("TweakOriginalAggression", pTweakInfoVeryAggressive)
	elseif (1 == oAggression)
		theBook.AddTextReplacementData("TweakOriginalAggression", pTweakInfoAggressive)
	else
		theBook.AddTextReplacementData("TweakOriginalAggression", pTweakInfoUnaggressive)
		if (0 != oAggression)
			Trace("oAggression is [" + oAggression + "]. Using Default of 0")
		endif
	endif
	
	
	if (4 == oConfidence)
		theBook.AddTextReplacementData("TweakOriginalConfidence", pTweakInfoFoolhardy)
	elseif (3 == oConfidence)
		theBook.AddTextReplacementData("TweakOriginalConfidence", pTweakInfoBrave)
	elseif (2 == oConfidence)
		theBook.AddTextReplacementData("TweakOriginalConfidence", pTweakInfoAverage)
	elseif (1 == oConfidence)
		theBook.AddTextReplacementData("TweakOriginalConfidence", pTweakInfoCautious)
	else 
		theBook.AddTextReplacementData("TweakOriginalConfidence", pTweakInfoCowardly)
		if (0 != oConfidence)
			Trace("oConfidence is [" + oConfidence + "]. Using Default of 0")
		endif
	endif

	if (2 == oAssistance)
		theBook.AddTextReplacementData("TweakOriginalAssistance", pTweakInfoHelpsFriends)
	elseif (1 == oAssistance)
		theBook.AddTextReplacementData("TweakOriginalAssistance", pTweakInfoHelpsAllies)
	else
		theBook.AddTextReplacementData("TweakOriginalAssistance", pTweakInfoHelpsNobody)
		if (0 != oAssistance)
			Trace("oAssistance is [" + oAssistance + "]. Using Default of 0")
		endif
	endif
	
	if (3 == oMorals)
		theBook.AddTextReplacementData("TweakOriginalMorality", pTweakInfoNoCrime)
	elseif (2 == oMorals)
		theBook.AddTextReplacementData("TweakOriginalMorality", pTweakInfoPropertyCrime)
	elseif (1 == oMorals)
		theBook.AddTextReplacementData("TweakOriginalMorality", pTweakInfoViolentCrime)
	else
		theBook.AddTextReplacementData("TweakOriginalMorality", pTweakInfoAnyCrime)
		if (0 != oMorals)
			Trace("oMorals is [" + oMorals + "]. Using Default of 0")
		endif
	endif	
	
	int cAggression = npc.GetValue(pAggression) As Int
	if (3 == cAggression)
		theBook.AddTextReplacementData("TweakCurrentAggression", pTweakInfoFrenzied)
	elseif (2 == cAggression)
		theBook.AddTextReplacementData("TweakCurrentAggression", pTweakInfoVeryAggressive)
	elseif (1 == cAggression)
		theBook.AddTextReplacementData("TweakCurrentAggression", pTweakInfoAggressive)
	else
		theBook.AddTextReplacementData("TweakCurrentAggression", pTweakInfoUnaggressive)
		if (0 != cAggression)
			Trace("Aggression is [" + cAggression + "]. Using Default of 0")
		endif
	endif

	int cConfidence = npc.GetValue(pConfidence) As Int
	if (4 == cConfidence)
		theBook.AddTextReplacementData("TweakCurrentConfidence", pTweakInfoFoolhardy)
	elseif (3 == cConfidence)
		theBook.AddTextReplacementData("TweakCurrentConfidence", pTweakInfoBrave)
	elseif (2 == cConfidence)
		theBook.AddTextReplacementData("TweakCurrentConfidence", pTweakInfoAverage)
	elseif (1 == cConfidence)
		theBook.AddTextReplacementData("TweakCurrentConfidence", pTweakInfoCautious)
	else
		theBook.AddTextReplacementData("TweakCurrentConfidence", pTweakInfoCowardly)
		if (0 != cConfidence)
			Trace("cConfidence is [" + cConfidence + "]. Using Default of 0")
		endif
	endif
	
	int cAssistance = npc.GetValue(pAssistance) As Int
	if (2 == cAssistance)
		theBook.AddTextReplacementData("TweakCurrentAssistance", pTweakInfoHelpsFriends)
	elseif (1 == cAssistance)
		theBook.AddTextReplacementData("TweakCurrentAssistance", pTweakInfoHelpsAllies)
	else
		theBook.AddTextReplacementData("TweakCurrentAssistance", pTweakInfoHelpsNobody)
		if (0 != cAssistance)
			Trace("cAssistance is [" + cAssistance + "]. Using Default of 0")
		endif
	endif
	
	int cMorals = npc.GetValue(pMorality) As Int
	if (3 == cMorals)
		theBook.AddTextReplacementData("TweakCurrentMorality", pTweakInfoNoCrime)
	elseif (2 == cMorals)
		theBook.AddTextReplacementData("TweakCurrentMorality", pTweakInfoPropertyCrime)
	elseif (1 == cMorals)
		theBook.AddTextReplacementData("TweakCurrentMorality", pTweakInfoViolentCrime)
	else
		theBook.AddTextReplacementData("TweakCurrentMorality", pTweakInfoAnyCrime)
		if (0 != cMorals)
			Trace("cMorals is [" + cMorals + "]. Using Default of 0")
		endif
	endif
	
EndFunction

Function UpdateTraits(Race oRace, Location oLocation, Location aLocation)
	Trace("UpdateTraits()")
	Actor npc = pInfoNPC.GetActorReference()
	ObjectReference theBook =  pInfoBook.GetReference()
	
	if !npc || !theBook
		Trace("npc or book is empty. Aborting")
		return		
	endif

	Race cRace = npc.GetRace()
	Trace("cRace = [" + oRace + "]")
	form cfrace = cRace
	if (cfRace == pAlienRace)
		Trace("Using Alien Sub")
		cfrace = pTweakInfoAlien
	elseif (cRace == pDogmeatRace || cRace == pRaiderDogRace || cRace == pViciousDogRace)
		Trace("Using Dog Sub")
		cfrace = pTweakInfoDog
	elseif (cRace == pSuperMutantRace)
		Trace("Using Supermutant Sub")
		cfrace = pTweakInfoSuperMutant
	elseif (cRace == pFEVHoundRace)
		Trace("Using Supermutt Sub")
		cfrace = pTweakInfoSuperMutt	
	elseif (cRace == pHumanRace)
		if (1.0 == TweakRevealSynth.GetValue())
			ActorBase base = npc.GetActorBase()
			WorkshopNPCScript ws = (npc as WorkshopNPCScript)		
			if (base == Game.GetForm(0x00027683) as ActorBase) ; Special for Danse...
				if (pBoS301.IsObjectiveCompleted(180))
					Trace("BoS301:180 objective complete")
					cfrace = pTweakInfoHumanSynth
				else
					Trace("BoS301:180 objective not complete")
				endif		
			elseif npc.HasPerk(pImmuneToRadiation) && npc.HasPerk(pImmuneToPoison)
				cfrace = pTweakInfoHumanSynth
			elseif (None != ws && ws.bIsSynth)
				cfrace = pTweakInfoHumanSynth
			else
				Trace("Does not have synth immunities. Checking DeathItem...")
				int ActorBaseID   = base.GetFormID()
				int ActorBaseMask
				
				if ActorBaseID > 0x80000000
					ActorBaseMask = (ActorBaseID - 0x80000000) % 0x01000000
				else
					ActorBaseMask = ActorBaseID % 0x01000000
				endif
								
				if (base == Game.GetForm(0x00039fc8) as ActorBase) ; Amelia Stockton
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x0017e78c) as ActorBase) ; Art
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x000d6049) as ActorBase) ; B2-57
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x000d604f) as ActorBase) ; F6-33
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x000e20fd) as ActorBase) ; F6-33
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x00045acf) as ActorBase) ; Glory
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x0005fefd) as ActorBase) ; H2-22
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x001905ed) as ActorBase) ; Jules
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x0004efe2) as ActorBase) ; K1-98
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x0002268a) as ActorBase) ; Magnolia
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x00002f08) as ActorBase) ; Mayor McDonough
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x0003f23c) as ActorBase) ; Roger Warwick
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x000570c3) as ActorBase) ; Shaun
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x00019fda) as ActorBase) ; Sturges
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x001a9510) as ActorBase) ; Timothy
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x000ef222) as ActorBase) ; X4-18
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x000bbee6) as ActorBase) ; X6-88 
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x0010fa73) as ActorBase) ; X9-27
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x000d6051) as ActorBase) ; Y9-14
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x000d29f8) as ActorBase) ; Z1-14
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x0004efec) as ActorBase) ; Z2-47
					cfrace = pTweakInfoHumanSynth
				elseif (base == Game.GetForm(0x000d6053) as ActorBase) ; Z3-22
			
				elseif (ActorBaseID > 0x00ffffff && ActorBaseMask > 0)
				
					; Debatable if it is cheaper to put everything
					; in 1 array and do the mask upfront, but this
					; way our MOD/DLC support checks and memory
					; allocation only happen if a mod/dlc
					; actorbase is deetcted....
					
					int[] HasSynthDeathItemMask = new Int[13]
					HasSynthDeathItemMask[0]  = (0x0000463e) ; Aster (Far Harbor)
					HasSynthDeathItemMask[1]  = (0x00005c9b) ; Brooks
					HasSynthDeathItemMask[2]  = (0x00005c80) ; Avery
					HasSynthDeathItemMask[3]  = (0x0000463a) ; Chase
					HasSynthDeathItemMask[4]  = (0x00004640) ; Cog
					HasSynthDeathItemMask[5]  = (0x0002175a) ; Cole
					HasSynthDeathItemMask[6]  = (0x0000463f) ; Dejen
					HasSynthDeathItemMask[7]  = (0x00004639) ; Dima
					HasSynthDeathItemMask[8]  = (0x0000463c) ; Faraday
					HasSynthDeathItemMask[9]  = (0x00004642) ; Jule
					HasSynthDeathItemMask[10] = (0x0000463b) ; Miranda
					HasSynthDeathItemMask[11] = (0x00004641) ; Naveen
					HasSynthDeathItemMask[12] = (0x000212ab) ; High Confessor Tektus
					
					if HasSynthDeathItemMask.Find(ActorBaseMask) > -1
						cfrace = pTweakInfoHumanSynth
					else
						Trace("Does not have DeathItem...")
						if pTweakDLC03Script.Installed
							if npc.IsInFaction(pTweakDLC03Script.DLC03AcadiaGenericNPCFaction)
								cfrace = pTweakInfoHumanSynth								
							endif
						endif
					endif					
				endif
			endif
		endif ; Reveal Synth
	endif
	
	form frace = oRace
	Trace("oRace = [" + oRace + "]")
	if (oRace == pAlienRace)
		frace = pTweakInfoAlien
	elseif (oRace == pDogmeatRace || oRace == pRaiderDogRace || oRace == pViciousDogRace)
		frace = pTweakInfoDog
	elseif (oRace == pSuperMutantRace)
		frace = pTweakInfoSuperMutant
	elseif (oRace == pFEVHoundRace)
		frace = pTweakInfoSuperMutt	
	elseif (oRace == pHumanRace)
		if cfrace == pTweakInfoHumanSynth
			frace = pTweakInfoHumanSynth
		endif
	endif
			
	theBook.AddTextReplacementData("TweakOriginalRace", frace)
	theBook.AddTextReplacementData("TweakOriginalHome", oLocation)	
	theBook.AddTextReplacementData("TweakCurrentRace", cfrace)
	
	if npc.IsInFaction(pTweakCampHomeFaction)
		theBook.AddTextReplacementData("TweakCurrentHome", pTweakInfoAftCamp)
	elseif aLocation
		theBook.AddTextReplacementData("TweakCurrentHome", aLocation)
	else
		theBook.AddTextReplacementData("TweakCurrentHome", oLocation)
	endif
	
	if npc.GetActorBase().IsUnique()
		theBook.AddTextReplacementData("TweakUnique", pTweakInfoTrue)
	else
		theBook.AddTextReplacementData("TweakUnique", pTweakInfoFalse)
	endif

	if (npc.GetLeveledActorBase() != npc.GetActorBase())
		theBook.AddTextReplacementData("TweakTemplated", pTweakInfoTrue)
	else
		theBook.AddTextReplacementData("TweakTemplated", pTweakInfoFalse)
	endif
	
	if (npc.IsIgnoringFriendlyHits())
		theBook.AddTextReplacementData("TweakFriendlyFire", pTweakInfoFFIgnore)
	else
		theBook.AddTextReplacementData("TweakFriendlyFire", pTweakInfoFFReact)	
	endif
	
EndFunction

Function UpdateRelationship(Actor npc, ObjectReference theBook)
	Trace("UpdateRelationship()")
	; Actor npc = pInfoNPC.GetActorReference()
	; ObjectReference theBook =  pInfoBook.GetReference()
	
	if !npc || !theBook
		Trace("npc or book is empty. Aborting")
		return		
	endif
	
	CompanionActorScript cas = npc as CompanionActorScript
	if cas
		
		bool romancable = false
		; Romancable : Cait, Hancock, Piper, Preston, Curie, MacCready, Danse, Porter Gage
		; InfatuationRomanticMessage : Property is left undefined on CAS companions that 
		; don't support Romance
		
		if !cas.InfatuationRomanticMessage
			theBook.AddTextReplacementData("TweakRomanceable",  pTweakInfoFalse)
			romancable = false
		else
			theBook.AddTextReplacementData("TweakRomanceable",  pTweakInfoTrue)
			romancable = false
		endif
				
		float currentAffinity  = npc.GetValue(pCA_Affinity)
		float currentThreshold = npc.GetValue(pCA_CurrentThreshold)
		
		if (currentThreshold >= pCA_T1_Infatuation.GetValue())
			if (romancable && cas.IsRomantic())
				theBook.AddTextReplacementData("TweakRelationship",  pTweakInfoInLove)
			else
				theBook.AddTextReplacementData("TweakRelationship",  pTweakInfoInfatuated)
			endif				
		elseif (currentThreshold >= pCA_TCustom1_Confidant.GetValue())
			theBook.AddTextReplacementData("TweakRelationship",  pTweakInfoConfidant)
		elseif (currentThreshold >= pCA_T2_Admiration.GetValue())
			theBook.AddTextReplacementData("TweakRelationship",  pTweakInfoAdmiration)
		elseif (currentThreshold >= pCA_TCustom2_Friend.GetValue())
			theBook.AddTextReplacementData("TweakRelationship",  pTweakInfoFriend)
		elseif (currentThreshold >= pCA_T3_Neutral.GetValue())
			theBook.AddTextReplacementData("TweakRelationship",  pTweakInfoNeutral)
		elseif (currentThreshold >= pCA_T4_Disdain.GetValue())
			theBook.AddTextReplacementData("TweakRelationship",  pTweakInfoDisdain)
		elseif (currentThreshold <= pCA_T5_Hatred.GetValue())
			theBook.AddTextReplacementData("TweakRelationship",  pTweakInfoHate)			
		endif
		
		
		if cas.IsRomantic()
			theBook.AddTextReplacementData("TweakIsRomantic",   pTweakInfoTrue)
		else
			theBook.AddTextReplacementData("TweakIsRomantic",   pTweakInfoFalse)
		endif
						
	else
		theBook.AddTextReplacementData("TweakRomanceable",  pTweakInfoNA)
		theBook.AddTextReplacementData("TweakIsRomantic",   pTweakInfoNA)
		if (npc.GetActorBase() == Game.GetForm(0x0001D15C) as ActorBase) ; Dogmeat check
			theBook.AddTextReplacementData("TweakRelationship", pTweakInfoInLove)
		else
			theBook.AddTextReplacementData("TweakRelationship", pTweakInfoNA)
		endif
	endif	

EndFunction

Function UpdateReactions(Actor npc, ObjectReference theBook)

	Trace("UpdateReactions()")

	if !npc || !theBook
		Trace("npc or book is empty. Aborting")
		return		
	endif
	
	CompanionActorScript CAS = npc as CompanionActorScript
	if !CAS
		Trace("NPC is not CAS:")
		theBook.AddTextReplacementData("TweakReactionGenerous",	pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakReactionMean",		pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakReactionNice",		pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakReactionPeaceful",	pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakReactionSelfish",	pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakReactionViolent",	pTweakInfoReactionNone)
		
		theBook.AddTextReplacementData("TweakChemUse",			pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakChemAddiction",	pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakDonate",			pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakDrinkAcohol",		pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakUsePowerArmor",	pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakUseVertibird",		pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakHackComputer",		pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakPickLock",			pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakPickOwnedLock",	pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakHealDog",			pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakUpgradeArmor",		pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakUpgradeWeapon",	pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakMurder",			pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakSpeechForCaps",	pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakSteal",			pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakPickpocket",		pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakNudity",			pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakEatCorpse",		pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakHelpSettlement",	pTweakInfoReactionNone)
		theBook.AddTextReplacementData("TweakAvoidSettlement",	pTweakInfoReactionNone)
		return
	endif

	bool NoDisapprove	= npc.IsInFaction(pTweakNoDisapprove)
	bool NoApprove		= npc.IsInFaction(pTweakNoApprove)
	bool ConvNegToPos	= npc.IsInFaction(pTweakConvNegToPos)
	bool ConvPosToNeg	= npc.IsInFaction(pTweakConvPosToNeg)
	
	; TRAITS:
	
	Message reaction
	reaction = GetTraitReaction(CAS, CA_Trait_Generous, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	TRACE("CA_Trait_Generous Reaction [" + reaction + "]")
	theBook.AddTextReplacementData("TweakReactionGenerous",	reaction)
	reaction = GetTraitReaction(CAS, CA_Trait_Mean, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	TRACE("CA_Trait_Mean Reaction [" + reaction + "]")
	theBook.AddTextReplacementData("TweakReactionMean",	reaction)
	reaction = GetTraitReaction(CAS, CA_Trait_Nice, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	TRACE("CA_Trait_Mean Reaction [" + reaction + "]")
	theBook.AddTextReplacementData("TweakReactionNice",	reaction)
	reaction = GetTraitReaction(CAS, CA_Trait_Peaceful, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	TRACE("CA_Trait_Peaceful Reaction [" + reaction + "]")
	theBook.AddTextReplacementData("TweakReactionPeaceful",	reaction)
	reaction = GetTraitReaction(CAS, CA_Trait_Selfish, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	TRACE("CA_Trait_Selfish Reaction [" + reaction + "]")
	theBook.AddTextReplacementData("TweakReactionSelfish",	reaction)	
	reaction = GetTraitReaction(CAS, CA_Trait_Violent, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	TRACE("CA_Trait_Violent Reaction [" + reaction + "]")
	theBook.AddTextReplacementData("TweakReactionViolent",	reaction)
	
	; (Common) KEYWORDS:

	reaction = GetKeywordReaction(CAS, CA_Event_ChemUse, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	theBook.AddTextReplacementData("TweakChemUse",	reaction)
	reaction = GetKeywordReaction(CAS, CA_Event_ChemAddiction, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	theBook.AddTextReplacementData("TweakChemAddiction", reaction)	
	reaction = GetKeywordReaction(CAS, CA_Event_DonateItem, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	theBook.AddTextReplacementData("TweakDonate", reaction)	
	reaction = GetKeywordReaction(CAS, CA_Event_DrinkAlcohol, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	theBook.AddTextReplacementData("TweakDrinkAcohol", reaction)
	reaction = GetKeywordReaction(CAS, CA_Event_EnterPowerArmor, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	theBook.AddTextReplacementData("TweakUsePowerArmor", reaction)
	reaction = GetKeywordReaction(CAS, CA_Event_EnterVertibird, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	theBook.AddTextReplacementData("TweakUseVertibird", reaction)	
	reaction = GetKeywordReaction(CAS, CA_Event_HackComputer, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	theBook.AddTextReplacementData("TweakHackComputer", reaction)
	reaction = GetKeywordReaction(CAS, CA_Event_PickLock, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	theBook.AddTextReplacementData("TweakPickLock", reaction)
	reaction = GetKeywordReaction(CAS, CA_Event_PickLockOwnedDoor, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	theBook.AddTextReplacementData("TweakPickOwnedLock", reaction)
	reaction = GetKeywordReaction(CAS, CA_Event_HealDogmeant, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	theBook.AddTextReplacementData("TweakHealDog", reaction)
	reaction = GetKeywordReaction(CAS, CA_Event_ModArmor, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	theBook.AddTextReplacementData("TweakUpgradeArmor", reaction)
	reaction = GetKeywordReaction(CAS, CA_Event_ModWeapon, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	theBook.AddTextReplacementData("TweakUpgradeWeapon", reaction)
	reaction = GetKeywordReaction(CAS, CA_Event_Murder, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	theBook.AddTextReplacementData("TweakMurder", reaction)
	reaction = GetKeywordReaction(CAS, CA_Event_SpeechForMoreCaps, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	theBook.AddTextReplacementData("TweakSpeechForCaps", reaction)
	reaction = GetKeywordReaction(CAS, CA_Event_Steal, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	theBook.AddTextReplacementData("TweakSteal", reaction)
	reaction = GetKeywordReaction(CAS, CA_Event_StealPickPocket, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	theBook.AddTextReplacementData("TweakPickpocket", reaction)
	reaction = GetKeywordReaction(CAS, CA_Event_WalkAroundNaked, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	theBook.AddTextReplacementData("TweakNudity", reaction)
	reaction = GetKeywordReaction(CAS, CA_Event_EatCorpse, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	theBook.AddTextReplacementData("TweakEatCorpse", reaction)
	reaction = GetKeywordReaction(CAS, CA__CustomEvent_MinSettlementHelp, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	theBook.AddTextReplacementData("TweakHelpSettlement",	reaction)
	reaction = GetKeywordReaction(CAS, CA__CustomEvent_MinSettlementRefuseHelp, NoDisapprove, NoApprove, ConvNegToPos, ConvPosToNeg)
	theBook.AddTextReplacementData("TweakAvoidSettlement",	reaction)
	
EndFunction

Message Function GetTraitReaction(CompanionActorScript CAS, ActorValue trait, bool NoDisapprove, bool NoApprove, bool ConvNegToPos, bool ConvPosToNeg)

	Message reaction = pTweakInfoReactionNone
	int i = CAS.TraitPreference_Array.FindStruct("Trait", trait)
	if (i > -1)
		if CAS.TraitPreference_Array[i].Likes
			; original = Likes
			if ConvPosToNeg
				if !NoDisapprove
					reaction = pTweakInfoReactionDislikes
				endif			
			else
				if !NoApprove
					reaction = pTweakInfoReactionLikes
				endif
			endif
		else 
			; original = Dislikes
			if ConvNegToPos
				if !NoApprove
					reaction = pTweakInfoReactionLikes
				endif
			else
				if !NoDisapprove
					reaction = pTweakInfoReactionDislikes
				endif
			endif
		endif
	endif
	return reaction
	
EndFunction

Message Function GetKeywordReaction(CompanionActorScript CAS, Keyword kword, bool NoDisapprove, bool NoApprove, bool ConvNegToPos, bool ConvPosToNeg)

	Message reaction = pTweakInfoReactionNone
	CompanionActorScript:EventData AffinityEventData = CAS.GetEventDataByKeyword(CAS.EventData_Array, kword)
	if AffinityEventData
		GlobalVariable opinion = AffinityEventData.Disposition_Global
		if (CA_Event_Likes == opinion)		
			if ConvPosToNeg
				if !NoDisapprove
					reaction = pTweakInfoReactionDislikes
				endif				
			else ; (!ConvPosToNeg && (ConvNegToPos || !ConvNegToPos)) = (!ConvPosToNeg && TRUE) = (!ConvPosToNeg)
				if !NoApprove
					reaction = pTweakInfoReactionLikes
				endif
			endif
		elseif (CA_Event_Loves == opinion)
			if ConvPosToNeg
				if !NoDisapprove
					reaction = pTweakInfoReactionHates
				endif				
			else ; (!ConvPosToNeg && (ConvNegToPos || !ConvNegToPos)) = (!ConvPosToNeg && TRUE) = (!ConvPosToNeg)
				if !NoApprove
					reaction = pTweakInfoReactionLoves
				endif
			endif
		elseif (CA_Event_Dislikes == opinion)
			if (ConvNegToPos)
				if !NoApprove
					reaction = pTweakInfoReactionLikes					
				endif
			else 
				if !NoDisapprove
					reaction = pTweakInfoReactionDislikes
				endif
			endIf
		elseif (CA_Event_Hates == opinion)
			if (ConvNegToPos)
				if !NoApprove
					reaction = pTweakInfoReactionLoves					
				endif
			else 
				if !NoDisapprove
					reaction = pTweakInfoReactionHates
				endif
			endIf
		endif
	endif
	return reaction
endFunction

Function UpdateEffects(Actor npc, ObjectReference theBook)
	Trace("UpdateEffects()")
	; Actor npc = pInfoNPC.GetActorReference()
	; ObjectReference theBook =  pInfoBook.GetReference()
	
	if !npc || !theBook
		Trace("npc or book is empty. Aborting")
		return		
	endif

	int maxdisplayeffects = 20

	string[] EffectTokens = new string[maxdisplayeffects]	
	int i = 0
	while (i < maxdisplayeffects)
		EffectTokens[i] = "TweakEffect" + (i + 1)
		i += 1
	endwhile
	
	int tokenindex = 0

	Spell stest
	Message sname
	i = 0 
	int numspellstocheck = pTweakScanSpells.GetSize()
	while (i < numspellstocheck && tokenindex < maxdisplayeffects)
		stest = pTweakScanSpells.GetAt(i) as Spell
		if (npc.HasSpell(stest))
			sname = pTweakScanSpellsNames.GetAt(i) as Message
			theBook.AddTextReplacementData(EffectTokens[tokenindex], sname)
			tokenindex += 1
		endif
		i += 1
	endwhile
	
	MagicEffect mtest
	Message mname
	i = 0 
	int numeffectstocheck = pTweakScanEffects.GetSize()
	while (i < numeffectstocheck && tokenindex < maxdisplayeffects)
		mtest = pTweakScanEffects.GetAt(i) as MagicEffect
		if (npc.HasMagicEffect(mtest))
			mname = pTweakScanEffectsNames.GetAt(i) as Message
			theBook.AddTextReplacementData(EffectTokens[tokenindex], mname)
			tokenindex += 1
		endif
		i += 1
	endwhile
		
	while (tokenindex < 20)
		theBook.AddTextReplacementData(EffectTokens[tokenindex], pTweakInfoEmpty)
		tokenindex += 1
	endwhile
	
EndFunction

Function UpdateKeywords(Actor npc, ObjectReference theBook)
	Trace("UpdateKeywords()")
	; Actor npc = pInfoNPC.GetActorReference()
	; ObjectReference theBook =  pInfoBook.GetReference()
	
	if !npc || !theBook
		Trace("npc or book is empty. Aborting")
		return		
	endif

	int maxdisplaykeywords = 20

	string[] KeywordTokens = new string[maxdisplaykeywords]	
	int i = 0
	while (i < maxdisplaykeywords)
		KeywordTokens[i] = "TweakKeyword" + (i + 1)
		i += 1
	endwhile
	
	int tokenindex = 0

	Keyword ktest
	Message kname
	i = 0 
	int numkeywordstocheck = pTweakScanKeywords.GetSize()
	while (i < numkeywordstocheck && tokenindex < maxdisplaykeywords)
		ktest = pTweakScanKeywords.GetAt(i) as Keyword
		if (npc.HasKeyword(ktest))
			kname = pTweakScanKeywordsNames.GetAt(i) as Message
			theBook.AddTextReplacementData(KeywordTokens[tokenindex], kname)
			tokenindex += 1
		endif
		i += 1
	endwhile

	while (tokenindex < 20)
		theBook.AddTextReplacementData(KeywordTokens[tokenindex], pTweakInfoEmpty)
		tokenindex += 1
	endwhile
	
EndFunction

Function UpdatePerks(Actor npc, ObjectReference theBook)
	Trace("UpdatePerks()")
	; Actor npc = pInfoNPC.GetActorReference()
	; ObjectReference theBook =  pInfoBook.GetReference()
	
	if !npc || !theBook
		Trace("npc or book is empty. Aborting")
		return		
	endif

	int maxdisplayperks = 20

	string[] PerkTokens = new string[maxdisplayperks]	
	int i = 0
	while (i < maxdisplayperks)
		PerkTokens[i] = "TweakPerk" + (i + 1)
		i += 1
	endwhile
	
	int tokenindex = 0

	Perk ptest
	Message pname
	i = 0 
	int numperkstocheck = pTweakScanPerks.GetSize()
	while (i < numperkstocheck && tokenindex < maxdisplayperks)
		ptest = pTweakScanPerks.GetAt(i) as Perk
		if (npc.HasPerk(ptest))
			pname = pTweakScanPerksNames.GetAt(i) as Message
			theBook.AddTextReplacementData(PerkTokens[tokenindex], pname)
			tokenindex += 1
		endif
		i += 1
	endwhile

	while (tokenindex < 20)
		theBook.AddTextReplacementData(PerkTokens[tokenindex], pTweakInfoEmpty)
		tokenindex += 1
	endwhile
	
EndFunction

Function ShowInfo()
	Trace("ShowInfo()")

	ObjectReference theBook =  pInfoBook.GetReference()
	Actor pc = pPlayer.GetActorReference()
	Actor npc = pInfoNPC.GetActorReference()
	
	if (theBook)
		Float[] infront=TraceCircle(pc, 50, 0)
		theBook.SetPosition(infront[0],infront[1], infront[2]) 
		Trace("Attempting Activate")
		theBook.Activate(pc)
		; Wait till they close the book.... 
		Utility.wait(0.50)
	endif
	
	if (0 == pc.GetItemCount(pTweakInfoBook)) ; it is on the ground...		
		Trace("Player Dropped Book")
		theBook.Disable(true)
		theBook.Delete()
		pInfoBook.Clear()
		theBook=None
	else
		Trace("Player Took Book")
		pc.RemoveItem(pTweakInfoBook,1,true)
		theBook.Disable(true)
		theBook.Delete()
		pInfoBook.Clear()
		theBook=None
	endif
	
	self.Stop()
	self.Reset()

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