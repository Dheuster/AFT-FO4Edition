Scriptname AFT:TweakTrackTraits extends Quest

group quests
	ReferenceAlias pCompanion1	auto const
	ReferenceAlias pCompanion2	auto const
	ReferenceAlias pCompanion3	auto const
	ReferenceAlias pCompanion4	auto const
	ReferenceAlias pCompanion5	auto const
	ReferenceAlias[] Companions	auto
endgroup

group quests
	Quest property BoS100 auto const
	Quest property BoS101 auto const
	Quest property BoS201 auto const
	Quest property BoS202 auto const
	Quest property BoS203 auto const
	Quest property BoS301 auto const
	Quest property BoS302 auto const
	Quest property BoS303 auto const
	Quest property BoSM01 auto const
	Quest property BoSM02 auto const
	Quest property BoSR05 auto const
	Quest property DialogueAbernathyFarm auto const
	Quest property DialogueBunkerHill auto const
	Quest property DialogueConcordArea auto const
	Quest property DialogueDiamondCity auto const
	Quest property DialogueDiamondCityEntrance auto const
	Quest property DialogueDiamondCitySchoolhouse auto const
	Quest property DialogueDrumlinDiner auto const
	Quest property DialogueGoodneighbor auto const
	Quest property DialogueGoodneighborEntrance auto const
	Quest property DialogueGraygarden auto const
	Quest property DialogueRailroad auto const
	Quest property DialogueTheSlog auto const
	Quest property DialogueVault81 auto const
	Quest property DialogueWarwickHomestead auto const
	Quest property DiamondCitySuperMutantIntro auto const
	Quest property DN019JoinCult auto const
	Quest property DN053 auto const
	Quest property DN102 auto const
	Quest property FFDiamondCity01 auto const
	Quest property FFDiamondCity07 auto const
	Quest property FFDiamondCity08 auto const
	Quest property FFDiamondCity10 auto const
	Quest property FFGoodneighbor07 auto const
	Quest property Inst301 auto const
	Quest property Inst302 auto const
	Quest property Inst306 auto const
	Quest property InstM01 auto const
	Quest property InstM02 auto const
	Quest property InstM03 auto const
	Quest property Min01 auto const
	Quest property Min03 auto const
	Quest property MinRecruit03 auto const
	Quest property MinRecruit09 auto const
	Quest property MinVsInst auto const
	Quest property MQ00MamaMurphy auto const
	Quest property MQ104 auto const
	Quest property MQ105 auto const
	Quest property MQ201 auto const
	Quest property MQ206 auto const
	Quest property MQ206RR auto const
	Quest property MQ302BoS auto const
	Quest property MQ302Min auto const
	Quest property MQ302RR auto const
	Quest property MS01 auto const
	Quest property MS04 auto const
	Quest property MS05B auto const
	Quest property MS07a auto const
	Quest property MS09 auto const
	Quest property MS11 auto const
	Quest property MS13 auto const
	Quest property MS13CookeDies auto const
	Quest property MS13FindPhoto auto const
	Quest property MS13NelsonDies auto const
	Quest property MS13PaulDies auto const
	Quest property MS14 auto const
	Quest property MS16 auto const
	Quest property MS17 auto const
	Quest property MS19 auto const
	Quest property REAssaultSC01_DN123SkylanesAssault auto const
	Quest property RECampLC01 auto const
	Quest property RESceneLC01 auto const
	Quest property RETravelKMK_BoSM02 auto const
	Quest property RETravelSC01_DN123SkylanesPointer auto const
	Quest property RR101 auto const
	Quest property RR102 auto const
	Quest property RR201 auto const
	Quest property RR302 auto const
	Quest property RR303 auto const
	Quest property RRM01 auto const
	Quest property RRM02 auto const
	Quest property RRR02aQuest auto const
	Quest property RRR05 auto const
	Quest property RRR08 auto const
	Quest property V81_00_Intro auto const
	Quest property V81_01 auto const
	Quest property V81_03 auto const

	;NEW QUESTS ADDED WHEN ADDING QUEST STAGE BUMPS
	Quest Property BoS200 const auto
	Quest Property BoS204 const auto
	Quest Property DialogueDrinkingBuddy const auto
	Quest Property DialogueGoodneighborRufus const auto
	Quest Property DN015 const auto
	Quest Property DN036 const auto
	Quest Property DN036_Post const auto
	Quest Property DN079 const auto
	Quest Property DN083_Barney const auto
	Quest Property DN101 const auto
	Quest Property DN109 const auto
	Quest Property DN119Fight const auto
	Quest Property DN121 const auto
	Quest Property FFBunkerHill03 const auto
	Quest Property Inst307 const auto
	Quest Property InstR03NEW const auto
	Quest Property InstR04 const auto
	Quest Property InstR05 const auto
	Quest Property Min02 const auto
	Quest Property Min207 const auto
	Quest Property Min301 const auto
	Quest Property MinDefendCastle const auto
	Quest Property MinDestBOS const auto
	Quest Property MQ203 const auto
	Quest Property MQ302 const auto
	Quest Property MS05BPostQuest const auto
	Quest Property MS07b const auto
	Quest Property MS07c const auto
	Quest Property RRAct3PickUp const auto
	Quest Property RRR04 const auto

endGroup

group TraitActorValues
	; keyword Property CA_CustomEvent_CaitLoves auto const
	; keyword Property CA_CustomEvent_CaitLikes auto const
	; keyword Property CA_CustomEvent_CaitDislikes auto const
	; keyword Property CA_CustomEvent_CaitHates auto const
	; keyword Property CA_CustomEvent_Cait__UNSET auto const

	; keyword Property CA_CustomEvent_CodsworthLoves auto const
	; keyword Property CA_CustomEvent_CodsworthLikes auto const
	; keyword Property CA_CustomEvent_CodsworthDislikes auto const
	; keyword Property CA_CustomEvent_CodsworthHates auto const
	; keyword Property CA_CustomEvent_Codsworth__UNSET auto const

	; keyword Property CA_CustomEvent_CurieLoves auto const
	; keyword Property CA_CustomEvent_CurieLikes auto const
	; keyword Property CA_CustomEvent_CurieDislikes auto const
	; keyword Property CA_CustomEvent_CurieHates auto const
	; keyword Property CA_CustomEvent_Curie__UNSET auto const

	; keyword Property CA_CustomEvent_DanseLoves auto const
	; keyword Property CA_CustomEvent_DanseLikes auto const
	; keyword Property CA_CustomEvent_DanseDislikes auto const
	; keyword Property CA_CustomEvent_DanseHates auto const
	; keyword Property CA_CustomEvent_Danse__UNSET auto const

	; keyword Property CA_CustomEvent_DeaconLoves auto const
	; keyword Property CA_CustomEvent_DeaconLikes auto const
	; keyword Property CA_CustomEvent_DeaconDislikes auto const
	; keyword Property CA_CustomEvent_DeaconHates auto const
	; keyword Property CA_CustomEvent_Deacon__UNSET auto const

	; keyword Property CA_CustomEvent_HancockLoves auto const
	; keyword Property CA_CustomEvent_HancockLikes auto const
	; keyword Property CA_CustomEvent_HancockDislikes auto const
	; keyword Property CA_CustomEvent_HancockHates auto const
	; keyword Property CA_CustomEvent_Hancock__UNSET auto const

	; keyword Property CA_CustomEvent_MacCreadyLoves auto const
	; keyword Property CA_CustomEvent_MacCreadyLikes auto const
	; keyword Property CA_CustomEvent_MacCreadyDislikes auto const
	; keyword Property CA_CustomEvent_MacCreadyHates auto const
	; keyword Property CA_CustomEvent_MacCready__UNSET auto const

	; keyword Property CA_CustomEvent_PiperLoves auto const
	; keyword Property CA_CustomEvent_PiperLikes auto const
	; keyword Property CA_CustomEvent_PiperDislikes auto const
	; keyword Property CA_CustomEvent_PiperHates auto const
	; keyword Property CA_CustomEvent_Piper__UNSET auto const

	; keyword Property CA_CustomEvent_PrestonLoves auto const
	; keyword Property CA_CustomEvent_PrestonLikes auto const
	; keyword Property CA_CustomEvent_PrestonDislikes auto const
	; keyword Property CA_CustomEvent_PrestonHates auto const
	; keyword Property CA_CustomEvent_Preston__UNSET auto const

	; keyword Property CA_CustomEvent_StrongLoves auto const
	; keyword Property CA_CustomEvent_StrongLikes auto const
	; keyword Property CA_CustomEvent_StrongDislikes auto const
	; keyword Property CA_CustomEvent_StrongHates auto const
	; keyword Property CA_CustomEvent_Strong__UNSET auto const

	; keyword Property CA_CustomEvent_ValentineLoves auto const
	; keyword Property CA_CustomEvent_ValentineLikes auto const
	; keyword Property CA_CustomEvent_ValentineDislikes auto const
	; keyword Property CA_CustomEvent_ValentineHates auto const
	; keyword Property CA_CustomEvent_Valentine__UNSET auto const

	; keyword Property CA_CustomEvent_X688Loves auto const
	; keyword Property CA_CustomEvent_X688Likes auto const
	; keyword Property CA_CustomEvent_X688Dislikes auto const
	; keyword Property CA_CustomEvent_X688Hates auto const
	; keyword Property CA_CustomEvent_X688__UNSET auto const

	ActorValue Property CA_Trait_Mean auto const
	ActorValue Property CA_Trait_Selfish auto const
	ActorValue Property CA_Trait_Violent auto const
	ActorValue Property CA_Trait_Generous auto const
	ActorValue Property CA_Trait_Nice auto const
	ActorValue Property CA_Trait_Peaceful auto const

	ActorValue Property Tweak_Trait_Mean auto const
	ActorValue Property Tweak_Trait_Selfish auto const
	ActorValue Property Tweak_Trait_Violent auto const
	ActorValue Property Tweak_Trait_Generous auto const
	ActorValue Property Tweak_Trait_Nice auto const
	ActorValue Property Tweak_Trait_Peaceful auto const
	
endGroup

; Group CompanionActors

; CompanionActorScript Property CaitRef const auto
; CompanionActorScript Property CurieRef const auto
; CompanionActorScript Property CodsworthRef const auto
; CompanionActorScript Property BoSPaladinDanseRef const auto
; CompanionActorScript Property DeaconRef const auto
; CompanionActorScript Property HancockRef const auto
; CompanionActorScript Property CompMacCreadyRef const auto
; CompanionActorScript Property PiperRef const auto
; CompanionActorScript Property PrestonRef const auto
; CompanionActorScript Property StrongRef const auto
; CompanionActorScript Property ValentineRef const auto
; CompanionActorScript Property X688Ref const auto

; endGroup

GlobalVariable Property Cait_EventCondition_DislikesPlayerTakingChems Auto Const
GlobalVariable Property MinCastleAttacker Auto Const
GlobalVariable Property MQ302Faction Auto Const

AFT:TweakTrackTraits Function GetScript() global ;used for making functions global
	return (Game.GetFormFromFile(0x01000F99, "AmazingFollowerTweaks.esp") as Quest) as AFT:TweakTrackTraits ;this script attached to CompanionAffinity quest
EndFunction

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakTrackTraits"
	debug.OpenUserLog(logName) 
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

bool Function Trace_(string asTextToPrint, int aiSeverity = 0) global debugOnly
	;we are sending callingObject so we can in the future route traces to different logs based on who is calling the function
	string logName = "TweakTrackTraits"
	debug.OpenUserLog(logName) 
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
	
EndFunction

event onInit()
	Trace("OnInit")
	Companions = new ReferenceAlias[5]
	OnGameLoaded()
	RegisterForCustomEvent(CompanionAffinityEventQuestScript, "CompanionAffinityEvent")
endEvent

; Each Time a Save Game is Loaded 
Function OnGameLoaded(bool firstTime=false)
	trace("OnGameLoaded()
	companions[0] = pCompanion1
	companions[1] = pCompanion2
	companions[2] = pCompanion3
	companions[3] = pCompanion4
	companions[4] = pCompanion5	
EndFunction


; What these values should represent:
;
; the opposite of selfish is generous. 
; the opposite of nice is mean
; the opposite of peaceful is violent. 
;
; These opposing values are combined and reflect how often the users uses one over the other. For example, 
; if you say 1 peaceful thing and one violent thing, then your score would be 5 for both. If you then
; say something violent, then out of 3 opportunities, you selected violence. So your violence score would
; be 2/3 or 6.66 while your Peaceful score would be 33. 
;
; Now lets talk about accuracy. If you have 1 or 2 or even 3 sample points, what does that really mean? 
; The more samples we have, the more accurate our assessement. But we may not want violent reactions because
; of a single early game choice. So each score requires a minimum threshold of 6 combined sample points 
; before the values will veer from 0. With most checks, you should think about how you want things to go
; in case of a tie or failure. Then user a > 5 check. So if we want a rude line said only if the player
; is selfish (Tie doesn't count), then we would check for CA_Trait_Selfish > 5
;
; Finally, lets talk about weight. Some actions... like choosing to betray your best friend are
; obviously more mean than other actions like calling someone that was rude to you a bitch.   This is why 
; the functions have parameters that can take a weight value. The default is 1, but if something is 
; particularly violent or barely registers, a different weight can be provided. A Gen rule of thumb:
; the HEAVIEST weight is 4.0 and the smallest weight is .25
;
; because everything is NPC based, we have to store everything with actorvalues. So the REAL values
; are stored using Tweak counterparts, then the computed (normalized and scaled) values are stored
; in the games nore trait holders. 

function Trait_Generous(float weight=1.0)
	Trace("Trait_Generous()")
	int i = 0
	float tg = 0
	float ts = 0
	Actor npc = null
	while (i < 5)
		npc = companions[i].GetActorRef()
		if npc
			tg = npc.GetValue(Tweak_Trait_Generous) + weight
			ts = npc.GetValue(Tweak_Trait_Selfish)
			total = tg + ts
			npc.SetValue(Tweak_Trait_Generous, tg)
			if (total > 5.9)
				npc.SetValue(CA_Trait_Generous, ((tg/total) * 10))
				npc.SetValue(CA_Trait_Selfish,  ((ts/total) * 10))
			elseif (weight == total)
				; Scenario : Uninstall + re-install. In this case, CA_Trait_Generous + CA_Trait_Selfish would be > 9 and < 11. 
				; If we detect this, we go ahead and set the weights accordingly
				float cg = npc.GetValue(CA_Trait_Generous)
				float cs = npc.GetValue(CA_Trait_Selfish)
				float ct = cg + cs
				if (ct > 9) && (ct < 11)
					npc.SetValue(Tweak_Trait_Generous, cg * 5)
					npc.SetValue(Tweak_Trait_Selfish,  cs * 5)					
				endif
			else
				npc.SetValue(CA_Trait_Generous, 0.0)
				npc.SetValue(CA_Trait_Selfish,  0.0)			
			endif
		endif
		i += 1
	endwhile
endFunction

function Trait_Selfish(float weight=1.0)
	Trace("Trait_Selfish()")
	int i = 0
	float tg = 0
	float ts = 0
	Actor npc = null
	while (i < 5)
		npc = companions[i].GetActorRef()
		if npc
			ts = npc.GetValue(Tweak_Trait_Selfish) + weight
			tg = npc.GetValue(Tweak_Trait_Generous) 
			total = ts + tg 
			npc.SetValue(Tweak_Trait_Selfish, ts)
			if (total > 5.9)
				npc.SetValue(CA_Trait_Selfish,  ((ts/total) * 10))
				npc.SetValue(CA_Trait_Generous, ((tg/total) * 10))
			elseif (weight == total)
				; Scenario : Uninstall + re-install. In this case, CA_Trait_Selfish + CA_Trait_Generous would be > 9 and < 11. 
				; If we detect this, we go ahead and set the weights accordingly
				float cs = npc.GetValue(CA_Trait_Selfish)
				float cg = npc.GetValue(CA_Trait_Generous)
				float ct = cs + cg
				if (ct > 9) && (ct < 11)
					npc.SetValue(Tweak_Trait_Selfish,  cs * 5)					
					npc.SetValue(Tweak_Trait_Generous, cg * 5)
				endif
			else
				npc.SetValue(CA_Trait_Selfish,  0.0)			
				npc.SetValue(CA_Trait_Generous, 0.0)
			endif
		endif
		i += 1
	endwhile
endFunction

function Trait_Nice(float weight=1.0)
	Trace("Trait_Nice()")
	int i = 0
	float tn = 0
	float tm = 0
	Actor npc = null
	while (i < 5)
		npc = companions[i].GetActorRef()
		if npc
			tn = npc.GetValue(Tweak_Trait_Nice) + weight
			tm = npc.GetValue(Tweak_Trait_Mean) 
			total = tn + tm 
			npc.SetValue(Tweak_Trait_Nice, tn)
			if (total > 5.9)
				npc.SetValue(CA_Trait_Nice,  ((tn/total) * 10))
				npc.SetValue(CA_Trait_Mean,  ((tm/total) * 10))
			elseif (weight == total)
				; Scenario : Uninstall + re-install. In this case, CA_Trait_Nice + CA_Trait_Mean would be > 9 and < 11. 
				; If we detect this, we go ahead and set the weights accordingly
				float cn = npc.GetValue(CA_Trait_Nice)
				float cm = npc.GetValue(CA_Trait_Mean)
				float ct = cn + cm
				if (ct > 9) && (ct < 11)
					npc.SetValue(Tweak_Trait_Nice, cn * 5)					
					npc.SetValue(Tweak_Trait_Mean, cm * 5)
				endif
			else
				npc.SetValue(CA_Trait_Nice, 0.0)			
				npc.SetValue(CA_Trait_Mean, 0.0)
			endif
		endif
		i += 1
	endwhile
endFunction

function Trait_Mean(float weight=1.0)
	Trace("Trait_Mean()")
	int i = 0
	float tm = 0
	float tn = 0
	Actor npc = null
	while (i < 5)
		npc = companions[i].GetActorRef()
		if npc
			tm = npc.GetValue(Tweak_Trait_Mean) + weight
			tn = npc.GetValue(Tweak_Trait_Nice) 
			total = tm + tn  
			npc.SetValue(Tweak_Trait_Mean, tm)
			if (total > 5.9)
				npc.SetValue(CA_Trait_Mean,  ((tm/total) * 10))
				npc.SetValue(CA_Trait_Nice,  ((tn/total) * 10))
			elseif (weight == total)
				; Scenario : Uninstall + re-install. In this case, CA_Trait_Mean + CA_Trait_Nice would be > 9 and < 11. 
				; If we detect this, we go ahead and set the weights accordingly
				float cm = npc.GetValue(CA_Trait_Mean)
				float cn = npc.GetValue(CA_Trait_Nice)
				float ct = cm + cn
				if (ct > 9) && (ct < 11)
					npc.SetValue(Tweak_Trait_Mean, cm * 5)
					npc.SetValue(Tweak_Trait_Nice, cn * 5)					
				endif
			else
				npc.SetValue(CA_Trait_Mean, 0.0)
				npc.SetValue(CA_Trait_Nice, 0.0)			
			endif
		endif
		i += 1
	endwhile
endFunction

function Trait_Peaceful(float weight=1.0)
	Trace("Trait_Peaceful()")
	int i = 0
	float tp = 0
	float tv = 0
	Actor npc = null
	while (i < 5)
		npc = companions[i].GetActorRef()
		if npc
			tp = npc.GetValue(Tweak_Trait_Peaceful) + weight
			tv = npc.GetValue(Tweak_Trait_Violent) 
			total = tp + tv  
			npc.SetValue(Tweak_Trait_Peaceful, tp)
			if (total > 5.9)
				npc.SetValue(CA_Trait_Peaceful, ((tp/total) * 10))
				npc.SetValue(CA_Trait_Violent,  ((tv/total) * 10))
			elseif (weight == total)
				; Scenario : Uninstall + re-install. In this case, CA_Trait_Peaceful + CA_Trait_Violent would be > 9 and < 11. 
				; If we detect this, we go ahead and set the weights accordingly
				float cp = npc.GetValue(CA_Trait_Peaceful)
				float cv = npc.GetValue(CA_Trait_Violent)
				float ct = cp + cv
				if (ct > 9) && (ct < 11)
					npc.SetValue(Tweak_Trait_Peaceful, cp * 5)
					npc.SetValue(Tweak_Trait_Violent,  cv * 5)					
				endif
			else
				npc.SetValue(CA_Trait_Peaceful, 0.0)
				npc.SetValue(CA_Trait_Violent,  0.0)			
			endif
		endif
		i += 1
	endwhile
endFunction

function Trait_Violent(float weight=1.0)
	Trace("Trait_Violent()")
	int i = 0
	float tv = 0
	float tp = 0
	Actor npc = null
	while (i < 5)
		npc = companions[i].GetActorRef()
		if npc
			tv = npc.GetValue(Tweak_Trait_Violent) + weight
			tp = npc.GetValue(Tweak_Trait_Peaceful)
			total = tv + tp   
			npc.SetValue(Tweak_Trait_Violent, tv)
			if (total > 5.9)
				npc.SetValue(CA_Trait_Violent,  ((tv/total) * 10))
				npc.SetValue(CA_Trait_Peaceful, ((tp/total) * 10))
			elseif (weight == total)
				; Scenario : Uninstall + re-install. In this case, CA_Trait_Violent + CA_Trait_Peaceful would be > 9 and < 11. 
				; If we detect this, we go ahead and set the weights accordingly
				float cv = npc.GetValue(CA_Trait_Violent)
				float cp = npc.GetValue(CA_Trait_Peaceful)
				float ct = cv + cp
				if (ct > 9) && (ct < 11)
					npc.SetValue(Tweak_Trait_Violent,  cv * 5)					
					npc.SetValue(Tweak_Trait_Peaceful, cp * 5)
				endif
			else
				npc.SetValue(CA_Trait_Violent,  0.0)			
				npc.SetValue(CA_Trait_Peaceful, 0.0)
			endif
		endif
		i += 1
	endwhile
endFunction

Event CompanionAffinityEventQuestScript.CompanionAffinityEvent(CompanionAffinityEventQuestScript akSender, Var[] akArgs)

	; cast akSender to figure out the eventID
	; akArgs:
	; 0: Quest
	; 1: Sender (TopicInfo or Quest)
	; 2: eventID
	Quest eventQuest = akArgs[0] as Quest
	ScriptObject sender = akArgs[1] as ScriptObject
	int eventID = akArgs[2] as int

	Trace("Received: " + eventQuest + ", " + sender + ", " + eventID)

	if eventID == -1
		Trace(" WARNING - uninitialized eventID from " + sender)
		return
	endif

	; send to correct quest function
	if sender is TopicInfo

		if eventQuest == BoS100
			HandleDialogueBump_BoS100(eventQuest, eventID)
		elseif eventQuest == BoS101
			HandleDialogueBump_BoS101(eventQuest, eventID)
		elseif eventQuest == BoS201
			HandleDialogueBump_BoS201(eventQuest, eventID)
		elseif eventQuest == BoS202
			HandleDialogueBump_BoS202(eventQuest, eventID)
		elseif eventQuest == BoS203
			HandleDialogueBump_BoS203(eventQuest, eventID)
		elseif eventQuest == BoS301
			HandleDialogueBump_BoS301(eventQuest, eventID)
		elseif eventQuest == BoS302
			HandleDialogueBump_BoS302(eventQuest, eventID)
		elseif eventQuest == BoS303
			HandleDialogueBump_BoS303(eventQuest, eventID)
		elseif eventQuest == BoSM01
			HandleDialogueBump_BoSM01(eventQuest, eventID)
		elseif eventQuest == BoSM02
			HandleDialogueBump_BoSM02(eventQuest, eventID)
		elseif eventQuest == BoSR05
			HandleDialogueBump_BoSR05(eventQuest, eventID)
		elseif eventQuest == DialogueAbernathyFarm
			HandleDialogueBump_DialogueAbernathyFarm(eventQuest, eventID)
		elseif eventQuest == DialogueBunkerHill
			HandleDialogueBump_DialogueBunkerHill(eventQuest, eventID)
		elseif eventQuest == DialogueConcordArea
			HandleDialogueBump_DialogueConcordArea(eventQuest, eventID)
		elseif eventQuest == DialogueDiamondCity
			HandleDialogueBump_DialogueDiamondCity(eventQuest, eventID)
		elseif eventQuest == DialogueDiamondCityEntrance
			HandleDialogueBump_DialogueDiamondCityEntrance(eventQuest, eventID)
		elseif eventQuest == DialogueDiamondCitySchoolhouse
			HandleDialogueBump_DialogueDiamondCitySchoolhouse(eventQuest, eventID)
		elseif eventQuest == DialogueDrumlinDiner
			HandleDialogueBump_DialogueDrumlinDiner(eventQuest, eventID)
		elseif eventQuest == DialogueGoodneighbor
			HandleDialogueBump_DialogueGoodneighbor(eventQuest, eventID)
		elseif eventQuest == DialogueGoodneighborEntrance
			HandleDialogueBump_DialogueGoodneighborEntrance(eventQuest, eventID)
		elseif eventQuest == DialogueGraygarden
			HandleDialogueBump_DialogueGraygarden(eventQuest, eventID)
		elseif eventQuest == DialogueRailroad
			HandleDialogueBump_DialogueRailroad(eventQuest, eventID)
		elseif eventQuest == DialogueTheSlog
			HandleDialogueBump_DialogueTheSlog(eventQuest, eventID)
		elseif eventQuest == DialogueVault81
			HandleDialogueBump_DialogueVault81(eventQuest, eventID)
		elseif eventQuest == DialogueWarwickHomestead
			HandleDialogueBump_DialogueWarwickHomestead(eventQuest, eventID)
		elseif eventQuest == DiamondCitySuperMutantIntro
			HandleDialogueBump_DiamondCitySuperMutantIntro(eventQuest, eventID)
		elseif eventQuest == DN019JoinCult
			HandleDialogueBump_DN019JoinCult(eventQuest, eventID)
		elseif eventQuest == DN053
			HandleDialogueBump_DN053(eventQuest, eventID)
		elseif eventQuest == DN102
			HandleDialogueBump_DN102(eventQuest, eventID)
		elseif eventQuest == FFDiamondCity01
			HandleDialogueBump_FFDiamondCity01(eventQuest, eventID)
		elseif eventQuest == FFDiamondCity07
			HandleDialogueBump_FFDiamondCity07(eventQuest, eventID)
		elseif eventQuest == FFDiamondCity08
			HandleDialogueBump_FFDiamondCity08(eventQuest, eventID)
		elseif eventQuest == FFDiamondCity10
			HandleDialogueBump_FFDiamondCity10(eventQuest, eventID)
		elseif eventQuest == FFGoodneighbor07
			HandleDialogueBump_FFGoodneighbor07(eventQuest, eventID)
		elseif eventQuest == Inst301
			HandleDialogueBump_Inst301(eventQuest, eventID)
		elseif eventQuest == Inst302
			HandleDialogueBump_Inst302(eventQuest, eventID)
		elseif eventQuest == Inst306
			HandleDialogueBump_Inst306(eventQuest, eventID)
		elseif eventQuest == InstM01
			HandleDialogueBump_InstM01(eventQuest, eventID)
		elseif eventQuest == InstM02
			HandleDialogueBump_InstM02(eventQuest, eventID)
		elseif eventQuest == InstM03
			HandleDialogueBump_InstM03(eventQuest, eventID)
		elseif eventQuest == Min01
			HandleDialogueBump_Min01(eventQuest, eventID)
		elseif eventQuest == Min03
			HandleDialogueBump_Min03(eventQuest, eventID)
		elseif eventQuest == MinRecruit03
			HandleDialogueBump_MinRecruit03(eventQuest, eventID)
		elseif eventQuest == MinRecruit09
			HandleDialogueBump_MinRecruit09(eventQuest, eventID)
		elseif eventQuest == MinVsInst
			HandleDialogueBump_MinVsInst(eventQuest, eventID)
		elseif eventQuest == MQ00MamaMurphy
			HandleDialogueBump_MQ00MamaMurphy(eventQuest, eventID)
		elseif eventQuest == MQ104
			HandleDialogueBump_MQ104(eventQuest, eventID)
		elseif eventQuest == MQ105
			HandleDialogueBump_MQ105(eventQuest, eventID)
		elseif eventQuest == MQ201
			HandleDialogueBump_MQ201(eventQuest, eventID)
		elseif eventQuest == MQ206
			HandleDialogueBump_MQ206(eventQuest, eventID)
		elseif eventQuest == MQ206RR
			HandleDialogueBump_MQ206RR(eventQuest, eventID)
		elseif eventQuest == MQ302BoS
			HandleDialogueBump_MQ302BoS(eventQuest, eventID)
		elseif eventQuest == MQ302Min
			HandleDialogueBump_MQ302Min(eventQuest, eventID)
		elseif eventQuest == MQ302RR
			HandleDialogueBump_MQ302RR(eventQuest, eventID)
		elseif eventQuest == MS01
			HandleDialogueBump_MS01(eventQuest, eventID)
		elseif eventQuest == MS04
			HandleDialogueBump_MS04(eventQuest, eventID)
		elseif eventQuest == MS05B
			HandleDialogueBump_MS05B(eventQuest, eventID)
		elseif eventQuest == MS07a
			HandleDialogueBump_MS07a(eventQuest, eventID)
		elseif eventQuest == MS09
			HandleDialogueBump_MS09(eventQuest, eventID)
		elseif eventQuest == MS11
			HandleDialogueBump_MS11(eventQuest, eventID)
		elseif eventQuest == MS13
			HandleDialogueBump_MS13(eventQuest, eventID)
		elseif eventQuest == MS13CookeDies
			HandleDialogueBump_MS13CookeDies(eventQuest, eventID)
		elseif eventQuest == MS13FindPhoto
			HandleDialogueBump_MS13FindPhoto(eventQuest, eventID)
		elseif eventQuest == MS13NelsonDies
			HandleDialogueBump_MS13NelsonDies(eventQuest, eventID)
		elseif eventQuest == MS13PaulDies
			HandleDialogueBump_MS13PaulDies(eventQuest, eventID)
		elseif eventQuest == MS14
			HandleDialogueBump_MS14(eventQuest, eventID)
		elseif eventQuest == MS16
			HandleDialogueBump_MS16(eventQuest, eventID)
		elseif eventQuest == MS17
			HandleDialogueBump_MS17(eventQuest, eventID)
		elseif eventQuest == MS19
			HandleDialogueBump_MS19(eventQuest, eventID)
		elseif eventQuest == REAssaultSC01_DN123SkylanesAssault
			HandleDialogueBump_REAssaultSC01_DN123SkylanesAssault(eventQuest, eventID)
		elseif eventQuest == RECampLC01
			HandleDialogueBump_RECampLC01(eventQuest, eventID)
		elseif eventQuest == RESceneLC01
			HandleDialogueBump_RESceneLC01(eventQuest, eventID)
		elseif eventQuest == RETravelKMK_BoSM02
			HandleDialogueBump_RETravelKMK_BoSM02(eventQuest, eventID)
		elseif eventQuest == RETravelSC01_DN123SkylanesPointer
			HandleDialogueBump_RETravelSC01_DN123SkylanesPointer(eventQuest, eventID)
		elseif eventQuest == RR101
			HandleDialogueBump_RR101(eventQuest, eventID)
		elseif eventQuest == RR102
			HandleDialogueBump_RR102(eventQuest, eventID)
		elseif eventQuest == RR302
			HandleDialogueBump_RR302(eventQuest, eventID)
		elseif eventQuest == RR303
			HandleDialogueBump_RR303(eventQuest, eventID)
		elseif eventQuest == RRM01
			HandleDialogueBump_RRM01(eventQuest, eventID)
		elseif eventQuest == RRM02
			HandleDialogueBump_RRM02(eventQuest, eventID)
		elseif eventQuest == RRR02aQuest
			HandleDialogueBump_RRR02a(eventQuest, eventID)
		elseif eventQuest == RRR05
			HandleDialogueBump_RRR05(eventQuest, eventID)
		elseif eventQuest == RRR08
			HandleDialogueBump_RRR08(eventQuest, eventID)
		elseif eventQuest == V81_00_Intro
			HandleDialogueBump_V81_00_Intro(eventQuest, eventID)
		elseif eventQuest == V81_01
			HandleDialogueBump_V81_01(eventQuest, eventID)
		elseif eventQuest == V81_03
			HandleDialogueBump_V81_03(eventQuest, eventID)
		else
			Trace("Unhandled quest dialogue bump " + eventQuest)
		endif

	elseif sender is Quest
		if eventQuest == BoS101
			HandleDialogueBump_BoS101(eventQuest, eventID)
		elseif eventQuest == BoS200
			HandleQuestStageBump_BoS200(eventQuest, eventID)
		elseif eventQuest == BoS202
			HandleQuestStageBump_BoS202(eventQuest, eventID)
		elseif eventQuest == BoS203
			HandleQuestStageBump_BoS203(eventQuest, eventID)
		elseif eventQuest == BoS204
			HandleQuestStageBump_BoS204(eventQuest, eventID)
		elseif eventQuest == BoS301
			HandleQuestStageBump_BoS301(eventQuest, eventID)
		elseif eventQuest == BoS302
			HandleQuestStageBump_BoS302(eventQuest, eventID)
		elseif eventQuest == BoSM01
			HandleQuestStageBump_BoSM01(eventQuest, eventID)
		elseif eventQuest == BoSM02
			HandleQuestStageBump_BoSM02(eventQuest, eventID)
		elseif eventQuest == BoSR05
			HandleQuestStageBump_BoSR05(eventQuest, eventID)
		elseif eventQuest == DialogueDrinkingBuddy
			HandleQuestStageBump_DialogueDrinkingBuddy(eventQuest, eventID)
		elseif eventQuest == DialogueGoodneighborRufus
			HandleQuestStageBump_DialogueGoodneighborRufus(eventQuest, eventID)
		elseif eventQuest == DN015
			HandleQuestStageBump_DN015(eventQuest, eventID)
		elseif eventQuest == DN036
			HandleQuestStageBump_DN036(eventQuest, eventID)
		elseif eventQuest == DN036_Post
			HandleQuestStageBump_DN036_Post(eventQuest, eventID)
		elseif eventQuest == DN053
			HandleQuestStageBump_DN053(eventQuest, eventID)
		elseif eventQuest == DN079
			HandleQuestStageBump_DN079(eventQuest, eventID)
		elseif eventQuest == DN083_Barney
			HandleQuestStageBump_DN083_Barney(eventQuest, eventID)
		elseif eventQuest == DN101
			HandleQuestStageBump_DN101(eventQuest, eventID)
		elseif eventQuest == DN109
			HandleQuestStageBump_DN109(eventQuest, eventID)
		elseif eventQuest == DN119Fight
			HandleQuestStageBump_DN119Fight(eventQuest, eventID)
		elseif eventQuest == DN121
			HandleQuestStageBump_DN121(eventQuest, eventID)
		elseif eventQuest == FFBunkerHill03
			HandleQuestStageBump_FFBunkerHill03(eventQuest, eventID)
		elseif eventQuest == FFGoodneighbor07
			HandleQuestStageBump_FFGoodneighbor07(eventQuest, eventID)
		elseif eventQuest == Inst301
			HandleQuestStageBump_Inst301(eventQuest, eventID)
		elseif eventQuest == InstM01
			HandleQuestStageBump_InstM01(eventQuest, eventID)
		elseif eventQuest == InstR03NEW
			HandleQuestStageBump_InstR03NEW(eventQuest, eventID)
		elseif eventQuest == InstR04
			HandleQuestStageBump_InstR04(eventQuest, eventID)
		elseif eventQuest == InstR05
			HandleQuestStageBump_InstR05(eventQuest, eventID)
		elseif eventQuest == Min01
			HandleQuestStageBump_Min01(eventQuest, eventID)
		elseif eventQuest == Min02
			HandleQuestStageBump_Min02(eventQuest, eventID)
		elseif eventQuest == Min03
			HandleQuestStageBump_Min03(eventQuest, eventID)
		elseif eventQuest == Min207
			HandleQuestStageBump_Min207(eventQuest, eventID)
		elseif eventQuest == Min301
			HandleQuestStageBump_Min301(eventQuest, eventID)
		elseif eventQuest == MinDefendCastle
			HandleQuestStageBump_MinDefendCastle(eventQuest, eventID)
		elseif eventQuest == MinDestBOS
			HandleQuestStageBump_MinDestBOS(eventQuest, eventID)
		elseif eventQuest == MQ203
			HandleQuestStageBump_MQ203(eventQuest, eventID)
		elseif eventQuest == MQ302
			HandleQuestStageBump_MQ302(eventQuest, eventID)
		elseif eventQuest == MS01
			HandleQuestStageBump_MS01(eventQuest, eventID)
		elseif eventQuest == MS04
			HandleQuestStageBump_MS04(eventQuest, eventID)
		elseif eventQuest == MS05B
			HandleQuestStageBump_MS05B(eventQuest, eventID)
		elseif eventQuest == MS05BPostQuest
			HandleQuestStageBump_MS05BPostQuest(eventQuest, eventID)
		elseif eventQuest == MS07a
			HandleQuestStageBump_MS07a(eventQuest, eventID)
		elseif eventQuest == MS07b
			HandleQuestStageBump_MS07b(eventQuest, eventID)
		elseif eventQuest == MS07c
			HandleQuestStageBump_MS07c(eventQuest, eventID)
		elseif eventQuest == MS09
			HandleQuestStageBump_MS09(eventQuest, eventID)
		elseif eventQuest == MS11
			HandleQuestStageBump_MS11(eventQuest, eventID)
		elseif eventQuest == MS16
			HandleQuestStageBump_MS16(eventQuest, eventID)
		elseif eventQuest == MS17
			HandleQuestStageBump_MS17(eventQuest, eventID)
		elseif eventQuest == RECampLC01
			HandleQuestStageBump_RECampLC01(eventQuest, eventID)
		elseif eventQuest == RESceneLC01
			HandleQuestStageBump_RESceneLC01(eventQuest, eventID)
		elseif eventQuest == RR101
			HandleQuestStageBump_RR101(eventQuest, eventID)
		elseif eventQuest == RR102
			HandleQuestStageBump_RR102(eventQuest, eventID)
		elseif eventQuest == RR201
			HandleQuestStageBump_RR201(eventQuest, eventID)			
		elseif eventQuest == RR303
			HandleQuestStageBump_RR303(eventQuest, eventID)
		elseif eventQuest == RRAct3PickUp
			HandleQuestStageBump_RRAct3PickUp(eventQuest, eventID)
		elseif eventQuest == RRM01
			HandleQuestStageBump_RRM01(eventQuest, eventID)
		elseif eventQuest == RRM02
			HandleQuestStageBump_RRM02(eventQuest, eventID)
		elseif eventQuest == RRR04
			HandleQuestStageBump_RRR04(eventQuest, eventID)
		elseif eventQuest == RRR08
			HandleQuestStageBump_RRR08(eventQuest, eventID)
		elseif eventQuest == V81_01
			HandleQuestStageBump_V81_01(eventQuest, eventID)
		else
			Trace("Unhandled quest stage bump " + eventQuest)
		endif


	endif
endEvent

;******************************************************************
; QUEST HANDLEDialogueBump_RS
;******************************************************************

function HandleDialogueBump_BoS100(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == BoS100
		if eventID == 1
			 ; 000F7404 on quest BoS100 (0005DDAB)
			 ; DESCRIPTION: Player met and helped out the Brotherhood. Here, he agrees to continue to help
			 ; without knowing what he's getting into.
			 Trait_Nice()
			 Trait_Generous(0.25) ; Help without asking for money
		elseif eventID == 2
			 ; 000F740D on quest BoS100 (0005DDAB)
			 ; DESCRIPTION: Player met and helped out the Brotherhood. Here, he refuses to continue to help
			 ; without knowing what he's getting into.
		elseif eventID == 3
			 ; 000F741D on quest BoS100 (0005DDAB)
			 ; DESCRIPTION: Player met and helped out the Brotherhood. Here, he asks for payment before he
			 ; agrees or refuses to help
			 Trait_Selfish(0.50)
		endif
	else
		 Trace(" WARNING - HandleDialogueBump_BoS100 got event from wrong quest " + eventQuest)
	endif
endFunction

; function HandleDialogueBump_BoS101(Quest eventQuest, int eventID)
	 ;; double-check that this is the right quest
	  ; if eventQuest == BoS101
		; if eventID == 1
			 ;; 000867D2 on quest BoS101 (0006F5C1)
			 ;; DESCRIPTION: Player refused to formally join the Brotherhood after Paladin Danse offered
		; elseif eventID == 2
			 ;; 000867F0 on quest BoS101 (0006F5C1)
			 ;; DESCRIPTION: Player agreed to formally join the Brotherhood after Paladin Danse offered
		; elseif eventID == 3
			 ;; 0008684B on quest BoS101 (0006F5C1)
			 ;; DESCRIPTION: Player uncertain about joining the Brotherhood or not.
		; endif
	; else
		 ; Trace(" WARNING - HandleDialogueBump_BoS101 got event from wrong quest " + eventQuest)
	; endif
; endFunction

function HandleDialogueBump_BoS201(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == BoS201
		if eventID == 1
			 ; 00048694 on quest BoS201 (0002BF21)
			 ; DESCRIPTION: Maxson states he cares about the people of the Commonwealth, player
			 ; disagrees with the motivations.
		elseif eventID == 2
			 ; 00048698 on quest BoS201 (0002BF21)
			 ; DESCRIPTION: The Prydwen has arrived in the Commonwealth, and the Player states
			 ; that he's impressed at the level of escalation the Brotherhood is bringing to the table
			 Trait_Violent(0.25)
		elseif eventID == 3
			 ; 000486A7 on quest BoS201 (0002BF21)
			 ; DESCRIPTION: Maxson states he cares about the people of the Commonwealth, player
			 ; whole-heartedly agrees.
			 Trait_Nice()
		elseif eventID == 4
			 ; 000486C1 on quest BoS201 (0002BF21)
			 ; DESCRIPTION: Maxson states he cares about the people of the Commonwealth, player
			 ; questions the statement.
		elseif eventID == 5
			 ; 000486C4 on quest BoS201 (0002BF21)
			 ; DESCRIPTION: The Prydwen has arrived in the Commonwealth, and the Player is wary at the level
			 ; of escalation the Brotherhood is bringing to the table, but doesn't strongly oppose it.
			Trait_Peaceful(0.5)
		elseif eventID == 6 
			 ; 000486D4 on quest BoS201 (0002BF21)
			 ; DESCRIPTION: Maxson states he cares about the people of the Commonwealth, player doesn't
			 ; express a strong opinion about it.
		elseif eventID == 7
			 ; 000486D8 on quest BoS201 (0002BF21)
			 ; DESCRIPTION: The Prydwen has arrived in the Commonwealth, and the Player is dismayed at the
			 ; level of escalation the Brotherhood is bringing to the table.
			Trait_Peaceful()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_BoS201 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_BoS202(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == BoS202
		if eventID == 1
			 ; 0009776F on quest BoS202 (000537FF)
			 ; DESCRIPTION: Maxson has ordered the Player to wipe out every Super Mutant at Fort Strong,
			 ; Player expresses dismay.
			 Trait_Peaceful()
		elseif eventID == 2
			 ; 00097780 on quest BoS202 (000537FF)
			 ; DESCRIPTION: Maxson has ordered the Player to wipe out every Super Mutant at Fort Strong,
			 ; Player agrees without protest.			 
			 Trait_Violent(0.25)
		elseif eventID == 3
			 ; 000977EF on quest BoS202 (000537FF)
			 ; DESCRIPTION: Danse sees the aftermath at Fort Strong (dead SM's) and states that the Player
			 ; must "hate these mutants just as much as I do." Player won't take a side, says he was following
			 ; orders.
		elseif eventID == 4
			 ; 000977F5 on quest BoS202 (000537FF)
			 ; DESCRIPTION: Danse sees the aftermath at Fort Strong (dead SM's) and states that the Player
			 ; must "hate these mutants just as much as I do." Player disagrees, saying the Mutants are no
			 ; different from anyone else.
			 Trait_Peaceful()
		elseif eventID == 5
			 ; 000977FC on quest BoS202 (000537FF)
			 ; DESCRIPTION: Danse sees the aftermath at Fort Strong (dead SM's) and states that the Player
			 ; must "hate these mutants just as much as I do." Player agrees saying that wiping them out
			 ; was a pleasure. (But if they like Danse, they may just be saying what they think he wants
			 ; to hear, so I only give .25 violence. 
			 Trait_Violent(0.25)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_BoS202 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_BoS203(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == BoS203
		if eventID == 1
			 ; 0009FFDD on quest BoS203 (0009FF4E)
			 ; DESCRIPTION: Player is made aware that the teleporter could kill them, since it's untested.
			 ; Player is gung-ho and determined to go anyway.
			 Trait_Generous(0.25)
		elseif eventID == 2
			 ; 000A0024 on quest BoS203 (0009FF4E)
			 ; DESCRIPTION: Player is made aware that the teleporter could kill them, since it's untested.
			 ; Player cracks a joke about being beamed into solid rock (not negative, sarcasm)
			 Trait_Generous(0.25)
		elseif eventID == 3
			 ; 000A0049 on quest BoS203 (0009FF4E)
			 ; DESCRIPTION: Player is made aware that the teleporter could kill them, since it's untested.
			 ; Player says that this is a suicide mission.
			Trait_Selfish(0.25)
	endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_BoS203 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_BoS301(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == BoS301
		if eventID == 1
			 ; 000B2EE7 on quest BoS301 (000AE51C)
			 ; DESCRIPTION: Player is speaking to Doctor Li, who is refusing to help rebuild Liberty Prime.
			 ; Player convinces her to help by saying she should do it to avenge Doctor Virgil.
			 Trait_Violent(0.25)
			 Trait_Nice(0.25)
		elseif eventID == 2
			 ; 000B2EE8 on quest BoS301 (000AE51C)
			 ; DESCRIPTION: Player is speaking to Doctor Li, who is refusing to help rebuild Liberty Prime.
			 ; Player convinces her to help by saying she should do it to help end the Institute's greed.
			 Trait_Peaceful(0.25)
			 Trait_Nice(0.25)
		elseif eventID == 3
			 ; 000B2F36 on quest BoS301 (000AE51C)
			 ; DESCRIPTION: Player is speaking to Doctor Li, who is refusing to help rebuild Liberty Prime.
			 ; Player convinces her to help by saying she should do it because the Brotherhood cares what
			 ; happens to the Commonwealth.
			 Trait_Peaceful()
			 Trait_Nice()
		elseif eventID == 4
			 ; 000B2F70 on quest BoS301 (000AE51C)
			 ; DESCRIPTION: Player is speaking to Doctor Li, who is refusing to help rebuild Liberty Prime.
			 ; Player convinces her to help by threatening to have her shot.
			 Trait_Violent()
			 Trait_Mean()
		elseif eventID == 5
			 ; 0013C679 on quest BoS301 (000AE51C)
			 ; DESCRIPTION: Player is in Diamond City, talking to Doctor Duff at the Science Center
			 ; while looking for Professor Scara. Scara and Duff are a couple. Duff is obviously upset
			 ; when Player says hello. Player ignores the dismay and gets right to business.
			 Trait_Mean(0.25)
		elseif eventID == 6
			 ; 0013C683 on quest BoS301 (000AE51C)
			 ; DESCRIPTION: Player is in Diamond City, talking to Doctor Duff at the Science Center
			 ; while looking for Professor Scara. Scara and Duff are a couple. Duff is obviously upset
			 ; when Player says hello. Player says he doesn't care that she's not in the mood to talk and
			 ; demands to know where Scara is.
			 Trait_Mean()
		elseif eventID == 7
			 ; 0013C691 on quest BoS301 (000AE51C)
			 ; DESCRIPTION: Player is in Diamond City, talking to Doctor Duff at the Science Center
			 ; while looking for Professor Scara. Scara and Duff are a couple. Duff is obviously upset
			 ; when Player says hello. Player instantly wants to help Duff out with whatever is bothering her.
			 Trait_Generous()
			 Trait_Nice()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_BoS301 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_BoS302(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == BoS302
		if eventID == 1
			 ; 000C31FF on quest BoS302 (000B9F9D)
			 ; DESCRIPTION: Maxson tells Player Danse is really a synth and he should be executed.
			 ; Player refuses to carry out the order.
			 Trait_Peaceful(0.50)
			 Trait_Nice(2.0)
		elseif eventID == 2
			 ; 000C3210 on quest BoS302 (000B9F9D)
			 ; DESCRIPTION: Maxson tells Player Danse is really a synth and he should be executed.
			 ; Player says he'll do it "with pleasure."
			 Trait_Violent()
			 Trait_Mean()
			 
		elseif eventID == 3
			 ; 000C3228 on quest BoS302 (000B9F9D)
			 ; DESCRIPTION: Maxson tells Player Danse is really a synth and he should be executed.
			 ; Player asks if there's another way.
			 Trait_Peaceful()
			 Trait_Nice(0.25)
		elseif eventID == 4
			 ; 000C323E on quest BoS302 (000B9F9D)
			 ; DESCRIPTION: Maxson tells Player Danse is really a synth and he should be executed.
			 ; Player doesn't know what to say.
			 Trait_Mean(0.25) ; Not standing up for teammate/friend
		elseif eventID == 5
			 ; 000CAA90 on quest BoS302 (000B9F9D)
			 ; DESCRIPTION: Scribe Haylen appeals to the Player not to execute Danse. Player says he's
			 ; confused and needs to sort it out.
			 Trait_Mean(0.25) ; Not standing up for teammate/friend
		elseif eventID == 6
			 ; 000CAAB0 on quest BoS302 (000B9F9D)
			 ; DESCRIPTION: Scribe Haylen appeals to the Player not to execute Danse. Player says he
			 ; won't make any promises.
			 Trait_Violent(0.25)
			 Trait_Mean(0.25)
		elseif eventID == 7
			 ; 000CAAD0 on quest BoS302 (000B9F9D)
			 ; DESCRIPTION: Scribe Haylen appeals to the Player not to execute Danse. Player says he'll
			 ; definitely hear Danse's side of the story before pulling the trigger.
			 Trait_Peaceful(0.25)
			Trait_Nice()
		elseif eventID == 8
			 ; 0014D0F8 on quest BoS302 (000B9F9D)
			 ; DESCRIPTION: Player finds Danse in an almost suicidal state. Danse feels he needs to die
			 ; in order for things to be right with the Brotherhood. Player refuses to pull the trigger.
			 Trait_Nice()
			 Trait_Peaceful()
		elseif eventID == 9
			 ; 0014D106 on quest BoS302 (000B9F9D)
			 ; DESCRIPTION: Player finds Danse in an almost suicidal state. Danse feels he needs to die
			 ; in order for things to be right with the Brotherhood. Player agrees to execute Paladin Danse.
			 Trait_Violent()
			 Trait_Mean()
		elseif eventID == 10
			 ; 0014F537 on quest BoS302 (000B9F9D)
			 ; DESCRIPTION: Maxson has caught Player trying to exile Danse instead of executing him. After
			 ; a confrontation of words, Player now agrees Danse should die, but refuses to pull the trigger
			 ; himself, making Maxson do the deed.
			 Trait_Mean()
			 Trait_Peaceful(0.25)
		elseif eventID == 11
			 ; 0014F53C on quest BoS302 (000B9F9D)
			 ; DESCRIPTION: Maxson has caught Player trying to exile Danse instead of executing him. After
			 ; a confrontation of words, Player now agrees Danse should die, and says he'll do it.
			 Trait_Violent()
			 Trait_Mean()
		elseif eventID == 12
			 ; 0014F546 on quest BoS302 (000B9F9D)
			 ; DESCRIPTION: Maxson has caught Player trying to exile Danse instead of executing him. After
			 ; a confrontation of words, Player still stands his ground and tries to speech challenge
			 ; Maxson into reconsidering.
			 Trait_Nice()
			 Trait_Peaceful()			 
		elseif eventID == 13
			 ; 0019465C on quest BoS302 (000B9F9D)
			 ; DESCRIPTION: After the confrontation with Maxson, Player agreed to execute Danse, but
			 ; changed his mind and is now speech challenging Maxson into reconsidering.
			 Trait_Nice(0.5)
			 Trait_Peaceful(0.5)
		elseif eventID == 14
			 ; 00194665 on quest BoS302 (000B9F9D)
			 ; DESCRIPTION: Player had agreed to execute Paladin Danse. Danse is kneeling ready to die,
			 ; but Player has a change of heart and says he won't do it.
			 Trait_Peaceful()
			 Trait_Nice()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_BoS302 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_BoS303(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == BoS303
		if eventID == 1 || eventID == 13 || eventID == 15
			 ; 001564EC on quest BoS303 (000FDC8C)
			 ; DESCRIPTION: After saying no to Proctor Ingram coming along to Mass Fusion,
			 ; Player has a change of heart, and allows her to go.
			 Trait_Nice()
		elseif eventID == 2 || eventID == 11 || eventID == 14
			 ; 001564EE on quest BoS303 (000FDC8C)
			 ; DESCRIPTION: Player is heading out to Mass Fusion, and Proctor Ingram (she's not a
			 ; soldier and she's handicapped (in a power armor rig)) wants to go along. Player agrees
			 ; to allow her to help.
			 Trait_Nice()
		elseif eventID == 3 || eventID == 10 || eventID == 12
			 ; 001564F2 on quest BoS303 (000FDC8C)
			 ; DESCRIPTION: After saying no to Proctor Ingram coming along to Mass Fusion, Player
			 ; maintains his refusal.
		elseif eventID == 4 || eventID == 8 || eventID == 18
			 ; 001564F4 on quest BoS303 (000FDC8C)
			 ; DESCRIPTION: Player is heading out to Mass Fusion, and Proctor Ingram (she's not a soldier
			 ; and she's handicapped (in a power armor rig)) wants to go along. Player tells her she has
			 ; to stay behind.
			 Trait_Mean()
		elseif eventID == 5 || eventID == 9 || eventID == 17
			 ; 001564F9 on quest BoS303 (000FDC8C)
			 ; DESCRIPTION: After saying no to Proctor Ingram coming along to Mass Fusion, Player is
			 ; flippant and tells her it's "her funeral." but still lets her come along.
			 Trait_Mean(0.25)
		elseif eventID == 6 || eventID == 7 || eventID == 16
			 ; 001564FB on quest BoS303 (000FDC8C)
			 ; DESCRIPTION: Player is heading out to Mass Fusion, and Proctor Ingram (she's not a soldier
			 ; and she's handicapped (in a power armor rig)) wants to go along. Player tells her "it's
			 ; her funeral." but still lets her come along.
			 Trait_Nice(0.25)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_BoS303 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_BoSM01(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	 if eventQuest == BoSM01
		if eventID == 2
			 ; 000B3D3F on quest BoSM01 (000B1D79)
			 ; DESCRIPTION: Speaking to Paladin Brandis who was from a Brotherhood patrol missing for years,
			 ; he's now a crazy hermit. He's paranoid and brandishing a gun. Player threatens him to drop it.
			 Trait_Violent()
		elseif eventID == 3
			 ; 000B3D48 on quest BoSM01 (000B1D79)
			 ; DESCRIPTION: Paladin Brandis is asking about the rest of his team, who the Player discovered
			 ; are long dead. Player lies and says he doesn't know what happened to them.
		elseif eventID == 4
			 ; 000B3D56 on quest BoSM01 (000B1D79)
			 ; DESCRIPTION: Paladin Brandis is asking about the rest of his team, who the Player discovered
			 ; are long dead. Player coldly tells Brandis "They're dead"
			 Trait_Mean()
		elseif eventID == 5 || eventID == 6
			 ; 000B3D6A on quest BoSM01 (000B1D79)
			 ; DESCRIPTION: Paladin Brandis is asking about the rest of his team, who the Player discovered
			 ; are long dead. Player is sympathetic and gives Brandis the fallen soldiers's holotags.
			Trait_Generous()
			Trait_Nice()
		elseif eventID == 7
			 ; 00143997 on quest BoSM01 (000B1D79)
			 ; DESCRIPTION: After dealing with Paladin Brandis, Player is greedy and asks him for a reward for
			 ; reporting the information about his fallen team to a hermit who has very little
			 Trait_Selfish()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_BoSM01 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_BoSM02(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == BoSM02
		if eventID == 1
			 ; 000BDC5B on quest BoSM02 (0004402C)
			 ; DESCRIPTION: Player has discovered that Initiate Clarke is harboring and feeding feral
			 ; ghouls, because he recognizes their past humanity. Clarke wants to know what Player is
			 ; deciding what to do with ferals. Player asks Clarke "What do you think I should do?"
			 Trait_Peaceful(0.25)
			 Trait_Nice(0.25)
		elseif eventID == 2
			 ; 000BDC5D on quest BoSM02 (0004402C)
			 ; DESCRIPTION: Clarke wants to know if the Player thinks he's doing the right thing. Player
			 ; confirms he did the right thing by feeding the ferals.			 
			 Trait_Nice()
			 Trait_Peaceful()
		elseif eventID == 3
			 ; 000BDC83 on quest BoSM02 (0004402C)
			 ; DESCRIPTION: Clarke wants to know his fate now that he's been discovered. Player says he has
			 ; to die for what he's done.
			 Trait_Mean()
			 Trait_Violent()
		elseif eventID == 4
			 ; 000BDC88 on quest BoSM02 (0004402C)
			 ; DESCRIPTION: Player has discovered that Initiate Clarke is harboring and feeding feral
			 ; ghouls, because he recognizes their past humanity. Clarke wants to know what Player is
			 ; deciding what to do with ferals. Player says they need to be killed because they're monsters.
			 Trait_Violent()
		elseif eventID == 5
			 ; 000BDC89 on quest BoSM02 (0004402C)
			 ; DESCRIPTION: Player has discovered that Initiate Clarke is harboring and feeding feral
			 ; ghouls, because he recognizes their past humanity. Clarke wants to know what Player is
			 ; deciding what to do with ferals. Player says they need to be killed because they might
			 ; harm others.
			 Trait_Nice(0.5)
			 Trait_Violent(0.5)
		elseif eventID == 6
			 ; 000BDC8D on quest BoSM02 (0004402C)
			 ; DESCRIPTION: Clarke wants to know if the Player thinks he's doing the right thing feeding the
			 ; ghouls. Player is evasive, saying if Clarke felt it was right, then it must be right.
		elseif eventID == 7
			 ; 000BDCA2 on quest BoSM02 (0004402C)
			 ; DESCRIPTION: Clarke wants to know his fate now that he's been discovered. Player says he'll
			 ; keep the whole thing a secret.
			 Trait_Nice()
		elseif eventID == 8
			 ; 000BDCA6 on quest BoSM02 (0004402C)
			 ; DESCRIPTION: Player has discovered that Initiate Clarke is harboring and feeding feral
			 ; ghouls, because he recognizes their past humanity. Clarke wants to know what Player is
			 ; deciding what to do with ferals. Player is indecisive.
		elseif eventID == 9
			 ; 000BDCAB on quest BoSM02 (0004402C)
			 ; DESCRIPTION: Clarke wants to know if the Player thinks he's doing the right thing. Player
			 ; says that feeding feral ghouls was wrong.
			 Trait_Mean(0.25)
		elseif eventID == 10
			 ; 000BDCB1 on quest BoSM02 (0004402C)
			 ; DESCRIPTION: Clarke wants to know his fate now that he's been discovered. Player says he'll
			 ; report it, but allow Clarke to run in the meantime.
			Trait_Nice(1.5)
		elseif eventID == 11
			 ; 000BDCB5 on quest BoSM02 (0004402C)
			 ; DESCRIPTION: Player has discovered that Initiate Clarke is harboring and feeding feral ghouls,
			 ; because he recognizes their past humanity. Clarke wants to know what Player is deciding what
			 ; to do with ferals. Player says they need to be killed because that's what the Brotherhood does.
			 Trait_Violent(0.5)
		elseif eventID == 12
			 ; 000BDCB6 on quest BoSM02 (0004402C)
			 ; DESCRIPTION: Player has discovered that Initiate Clarke is harboring and feeding feral ghouls,
			 ; because he recognizes their past humanity. Clarke wants to know what Player is deciding what
			 ; to do with ferals. Player says he won’t tell anyone about them.
			Trait_Nice(0.5)
			Trait_Peaceful(0.5)
		elseif eventID == 13
			 ; 000BE1CE on quest BoSM02 (0004402C)
			 ; DESCRIPTION: The Player has surprised Clarke (he had been following him secretly). When
			 ; confronted, Player confirms to Clarke he was following him.
		elseif eventID == 14
			 ; 000C177C on quest BoSM02 (0004402C)
			 ; DESCRIPTION: Clarke has disclosed that he had a friend who was a Ghoul. He asks Player if
			 ; ferals should be killed, should all ghouls? Player says yes.
			 Trait_Violent()
		elseif eventID == 15
			 ; 000C178D on quest BoSM02 (0004402C)
			 ; DESCRIPTION: Clarke has disclosed that he had a friend who was a Ghoul. He asks Player if
			 ; ferals should be killed, should all ghouls? Player asks if his friend was a feral ghoul as
			 ; though it would matter.
		elseif eventID == 16
			 ; 000C179E on quest BoSM02 (0004402C)
			 ; DESCRIPTION: Clarke has disclosed that he had a friend who was a Ghoul. He asks Player if
			 ; ferals should be killed, should all ghouls? Player says he doesn't know.
		elseif eventID == 17
			 ; 000C17B7 on quest BoSM02 (0004402C)
			 ; DESCRIPTION: Clarke has disclosed that he had a friend who was a Ghoul. He asks Player if
			 ; ferals should be killed, should all ghouls? Player says no.
			 Trait_Peaceful()
		elseif eventID == 18
			 ; 001669CE on quest BoSM02 (0004402C)
			 ; DESCRIPTION: Clarke wants to know his fate now that he's been discovered. Player speech
			 ; challenges Clarke to turn himself in.
			 Trait_Peaceful()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_BoSM02 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_BoSR05(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == BoSR05
		if eventID == 1 || eventID == 8
			 ; 000D2C11 on quest BoSR05 (000D1EB2)
			 ; DESCRIPTION: Player tries to pass a speech challenge to nicely persuade farmers to give
			 ; crops to the Brotherhood of Steel.
			 Trait_Peaceful()
		elseif eventID == 2
			 ; 000D2C14 on quest BoSR05 (000D1EB2)
			 ; DESCRIPTION: Player says "no deal" after hearing the price the farmers want for their crops.
			 Trait_Selfish()
			 Trait_Violent(0.5)
			 Trait_Mean(0.5)
		elseif eventID == 3
			 ; 000D2C25 on quest BoSR05 (000D1EB2)
			 ; DESCRIPTION: Player decides to be fair and pay the farmer for the crops the Brotherhood of
			 ; Steel wants.
			 Trait_Peaceful()
			 Trait_Nice()
		elseif eventID == 4 || eventID == 7
			 ; 000D2C2A on quest BoSR05 (000D1EB2)
			 ; DESCRIPTION: Player tries to pass a speech challenge to get the farmer to lower the price
			 ; for their crops by half.
			 Trait_Selfish(0.5)
		elseif eventID == 5 || eventID == 6
			 ; 000D2C34 on quest BoSR05 (000D1EB2)
			 ; DESCRIPTION: Player tries to pass a speech challenge to demand farmers to give crops
			 ; to the Brotherhood of Steel.
			 Trait_Violent(0.5)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_BoSR05 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_DialogueAbernathyFarm(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DialogueAbernathyFarm
		if eventID == 1
			 ; 0001A9C7 on quest DialogueAbernathyFarm (0006B4CF)
			 ; DESCRIPTION: Player is offering to help a woman farm melons. He gouges her for more caps
			 ; to get the job done.
			 Trait_Selfish()			 
		elseif eventID == 2
			 ; 0006D390 on quest DialogueAbernathyFarm (0006B4CF)
			 ; DESCRIPTION: Player is speaking with a farmer, who muses about how tough he's having it.
			 ; Player sympathizes.
			 Trait_Nice()
		elseif eventID == 3
			 ; 0006D393 on quest DialogueAbernathyFarm (0006B4CF)
			 ; DESCRIPTION: Player is speaking with a farmer, who mentions that his daughter was slain.
			 ; Player sympathizes.
			 Trait_Nice()
		elseif eventID == 4
			 ; 0006D39A on quest DialogueAbernathyFarm (0006B4CF)
			 ; DESCRIPTION: Player is speaking with a farmer, who muses about how tough he's having it.
			 ; Player is rude and calls farm "pathetic."
			 Trait_Mean()
		elseif eventID == 5
			 ; 0006D39D on quest DialogueAbernathyFarm (0006B4CF)
			 ; DESCRIPTION: Player is speaking with a farmer, who mentions that his daughter was slain.
			 ; Player is rude and says she "got what she deserved."
			 Trait_Mean(1.5)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_DialogueAbernathyFarm got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_DialogueBunkerHill(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DialogueBunkerHill
		if eventID == 1
			 ; 000C45A2 on quest DialogueBunkerHill (00019955)
			 ; DESCRIPTION: The Player insists that saving synths sounds noble.
			 Trait_Nice()
		elseif eventID == 2
			 ; 000C45AB on quest DialogueBunkerHill (00019955)
			 ; DESCRIPTION: The Player insists that synths are weapons built by the Institute (not beings).	
		elseif eventID == 3
			 ; 000C45BC on quest DialogueBunkerHill (00019955)
			 ; DESCRIPTION: A settler at Bunker Hill has asked Player to talk their son out of getting
			 ; involved with the Railroad. Player seems disinterested in getting involved, saying that
			 ; he should look after himself and not worry about others.
			 Trait_Selfish(0.25)
		elseif eventID == 4
			 ; 000C45CE on quest DialogueBunkerHill (00019955)
			 ; DESCRIPTION: A settler at Bunker Hill has asked Player to talk their son out of getting
			 ; involved with the Railroad. Player disagrees and tells the man that it's good to help people.
			 ; Note that the "people" in questons are synths.
			 Trait_Nice()
			 Trait_Generous()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_DialogueBunkerHill got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_DialogueConcordArea(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DialogueConcordArea
		if eventID == 1
			 ; 0001A4C0 on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Player is talking to Mama Murphy at the Museum. She muses that Dogmeat was
			 ; a good dog for bringing Player there. Player agrees and says Dogmeat is smart.
			 Trait_Nice()
		elseif eventID == 2
			 ; 0001A4C1 on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Player is talking to Mama Murphy at the Museum. She muses that Dogmeat was a
			 ; good dog for bringing Player there. Player says that the dog is dumb and will get him killed.
			 Trait_Mean()
		elseif eventID == 3
			 ; 0001A4C2 on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Player is talking to Mama Murphy at the Museum. She muses that Dogmeat was a
			 ; good dog for bringing Player there. Player is indifferent about it.
		elseif eventID == 4
			 ; 0001C22F on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Player just wiped out the Deathclaw and Raiders in Concord with Power Armor.
			 ; Preston says he's glad Player is on our side. Player says that the feeling's mutual.
			Trait_Nice()
		elseif eventID == 5
			 ; 0001C23C on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Player just wiped out the Deathclaw and Raiders in Concord with Power Armor.
			 ; Preston says he's glad Player is on our side. Player says he's on his own side.
			 Trait_Mean()
		elseif eventID == 6
			 ; 0001C23D on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Player just wiped out the Deathclaw and Raiders in Concord with Power Armor.
			 ; Preston says he's glad Player is on our side. Player says "you're nothing to me" (rude)
			 Trait_Mean(1.5)
			 Trait_Violent()
		elseif eventID == 7
			 ; 0001DC7E on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Preston's initial meeting in the Museum where he's upset that the MinuteMen
			 ; numbers are declining. Player is rude and says it's a cruel world.
			 Trait_Mean(0.25)
		elseif eventID == 8 || eventID == 25
			 ; 0001DC8D on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Preston and Sturgis pitched the Player the idea of getting the Power Armor up
			 ; and running. Player says "We'll see."
		elseif eventID == 9 || eventID == 12 || eventID == 27			
			 ; 0001DC99 on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Preston and Sturgis pitched the Player the idea of getting the Power Armor up
			 ; and running. Player says no.
			 Trait_Mean(0.25)
		elseif eventID == 10 || eventID == 22
			 ; 0001DCA3 on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Preston and Sturgis pitched the Player the idea of getting the Power Armor up
			 ; and running. Player presents the Fusion Core he already had on him.
			 Trait_Nice()
			 Trait_Generous()
		elseif eventID == 11 || eventID == 31
			 ; 0001DCA4 on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Preston and Sturgis pitched the Player the idea of getting the Power Armor up
			 ; and running. Player agrees to the job.
			 Trait_Nice()
		elseif eventID == 13
			 ; 0001DCB3 on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Preston's initial meeting in the Museum where he's upset that the MinuteMen
			 ; numbers are declining. Player sympathizes.
			 ; sympathetic += 1
			 Trait_Nice()			 
		elseif eventID == 14
			 ; 000329B8 on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Mama Murphy has forshadowed that "something angry is coming" with the Sight.
			 ; Player says he's confident he'll stop whatever it is.
		elseif eventID == 15
			 ; 000329BF on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Mama Murphy has forshadowed that "something angry is coming" with the Sight.
			 ; Player says everyone's doomed. 
			 Trait_Violent(0.50)
			 Trait_Mean(0.25)
		elseif eventID == 16
			 ; 0005DF1A on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Preston asked Player to help set up Sanctuary. Player says he'll think about it.
		elseif eventID == 17
			 ; 0005DF1E on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Preston asked Player to help set up Sanctuary. Player says no.
			 Trait_Mean(0.25)
		elseif eventID == 18
			 ; 0005DF23 on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Preston asked Player to help set up Sanctuary. Player agrees and says he's in.
			 Trait_Nice(0.25)
		elseif eventID == 19
			 ; 00075F4D on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Player is talking to Mama Murphy at the Museum. She says the Player is a
			 ; hero/rescuer. Player is indifferent about it.
		elseif eventID == 20
			 ; 00075F51 on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Player is talking to Mama Murphy at the Museum. She says the Player is a
			 ; hero/rescuer. Player says heroism is for kids and suckers.
			 Trait_Mean(0.25)
			 Trait_Vioent(0.75)
		elseif eventID == 21
			 ; 00075F53 on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Player is talking to Mama Murphy at the Museum. She says the Player is a
			 ; hero/rescuer. Player says he was just trying to do what's right.
			Trait_Nice()
		elseif eventID == 23 || eventID == 26
			 ; 000D229D on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Preston and Sturgis requested Player help clear Raiders by grabbing minigun
			 ; off of downed vertibird. Player says he'll think about it.
		elseif eventID == 24 || eventID == 28
			 ; 000D22A1 on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Preston and Sturgis requested Player help clear Raiders by grabbing minigun
			 ; off of downed vertibird. Player says no.
			 Trait_Mean(0.25)
		elseif eventID == 29 || eventID == 32
			 ; 000D22AA on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Preston and Sturgis requested Player help clear Raiders by grabbing minigun
			 ; off of downed vertibird. Player says he has a minigun already and will help.
			 Trait_Nice(0.50)
			 Trait_Generous(0.50)
		elseif eventID == 30 || eventID == 33
			 ; 000D22AB on quest DialogueConcordArea (000179F3)
			 ; DESCRIPTION: Preston and Sturgis requested Player help clear Raiders by grabbing minigun
			 ; off of downed vertibird. Player agrees. 
			 Trait_Nice()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_DialogueConcordArea got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_DialogueDiamondCity(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DialogueDiamondCity
		if eventID == 1
			 ; 0001DABE on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is being questioned by Myrna, who is concerned he might be a synth.
			 ; When asked if he's really human, Player is sarcastic and says he's Jangles the Moon Monkey.
		elseif eventID == 2
			 ; 00023BA4 on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is talking with Ann Codman, who is clearly thinking Player is there for
			 ; a handout. She tosses Player few caps to make him go away, and Player calls her a bitch.
			 Trait_Violent(0.25)
			 Trait_Mean(0.25)
		elseif eventID == 3
			 ; 00023BAE on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is talking with Ann Codman, who is clearly thinking Player is there for
			 ; a handout. She tosses Player few caps to make him go away, and Player agrees to leave.
			 Trait_Peaceful(0.25)
		elseif eventID == 4
			 ; 00023BB0 on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is talking with Ann Codman, who is clearly thinking Player is there for
			 ; a handout. She tosses Player few caps to make him go away, and Player retorts with sarcasm.
		elseif eventID == 5
			 ; 000360F8 on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is being questioned by Myrna, who is concerned he might be a synth.
			 ; When asked if he's really human, Player says he's not human at all, which will obviously
			 ; agitate Myrna.
		elseif eventID == 6
			 ; 00048252 on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is speaking with Duff at Science Center. She asks Player to help her out
			 ; by collecting Bloatfly Glands. Player says no.
			 Trait_Selfish()
		elseif eventID == 7
			 ; 0004829A on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is speaking with Duff at Science Center. She asks Player to help her out
			 ; by collecting Bloatfly Glands. Player agrees.
			 Trait_Generous()
		elseif eventID == 8
			 ; 0005C42D on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is talking to Ellie in Nick's Detective Agency. She tells her sad story
			 ; about Nick going missing, asks Player to help find Nick. Player agrees immediately.
			 Trait_Nice()
			 Trait_Generous()
		elseif eventID == 9
			 ; 0005C42F on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is talking to Ellie in Nick's Detective Agency. She tells her sad story
			 ; about Nick going missing, asks Player to help find Nick. Player says no way.
			 ; coldhearted += 1
			 Trait_Mean()
		elseif eventID == 10
			 ; 0005C435 on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is talking to Ellie in Nick's Detective Agency. She tells her sad story
			 ; about Nick going missing, asks Player to help find Nick. Player says only if he gets paid
			 ; for his time.
			Trait_Selfish()
		elseif eventID == 11
			 ; 000673DF on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is talking to Moe about baseball. Player insists he knows what baseball
			 ; really was. He tells the truth about it being part of America's pastime, painting a nostalgic
			 ; picture.
			 Trait_Nice()
		elseif eventID == 12
			 ; 000673EE on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is talking to Moe about baseball. Player insists he knows what baseball
			 ; really was. He makes up a story about it being extremely violent.
		elseif eventID == 13
			 ; 0007D5A6 on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is talking to Solomon who asks the Player to collect ferns to bolster
			 ; his chem stand inventory. Player says no.
			 Trait_Selfish(0.50)
			 Trait_Peaceful(0.25)
			 Trait_Nice(0.25)
		elseif eventID == 14
			 ; 0007D5AB on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is talking to Solomon who asks the Player to collect ferns to bolster
			 ; his chem stand inventory. Player agrees.
			 Trait_Generous()
		elseif eventID == 15
			 ; 0007D5AF on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is talking to Moe who needs a full set of baseball regalia. Player
			 ; agrees to hunt the pieces down.
			 Trait_Generous()
		elseif eventID == 16
			 ; 0007D5B9 on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is talking to Moe who needs a full set of baseball regalia. Player
			 ; agrees to hunt the pieces down if he's paid more than was originally offered.
			 Trait_Mean(0.25)
			 Trait_Selfish()
		elseif eventID == 17
			 ; 0007D5C4 on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is talking to Solomon who asks the Player to collect ferns to
			 ; bolster his chem stand inventory. Player says he'll do it for money.
			Trait_Selfish()
		elseif eventID == 18
			 ; 0007D5C8 on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is talking to Moe who needs a full set of baseball regalia.
			 ; Player refuses to help.
			Trait_Selfish(0.25)
		elseif eventID == 19
			 ; 00136047 on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is talking to Solomon who asks the Player to collect ferns to
			 ; bolster his chem stand inventory. Player offers some that he'd already been collecting.
			 Trait_Generous(2.0)
		elseif eventID == 20
			 ; 0013A03E on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is speaking to Cathy, who wants Player to talk some sense into her son.
			 ; She asks if McDonough's secretary is a synth, Player says yes. You don't really know.
			 Trait_Mean(0.25)
		elseif eventID == 21
			 ; 0013A042 on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is speaking to Cathy, who wants Player to talk some sense into her son.
			 ; She asks if McDonough's secretary is a synth, Player says he doesn't know.
		elseif eventID == 22
			 ; 0013A044 on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is speaking to Cathy, who wants Player to talk some sense into her son.
			 ; She asks if McDonough's secretary is a synth, Player says no.
			 Trait_Nice(0.25)
		elseif eventID == 23
			 ; 0014243F on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Sheng is asking the Player to clean out the water purification system
			 ; (nasty job). Player refuses to help.
			Trait_Selfish(0.25)
		elseif eventID == 24
			 ; 00142446 on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Sheng is asking the Player to clean out the water purification system
			 ; (nasty job). Player says he'll help for money.
			Trait_Selfish()
		elseif eventID == 25
			 ; 00142449 on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Sheng is asking the Player to clean out the water purification system
			 ; (nasty job). Player tells him he already did it.
			Trait_Generous(2.0)
		elseif eventID == 26
			 ; 0014244A on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Sheng is asking the Player to clean out the water purification system
			 ; (nasty job). Player agrees to help out.
			Trait_Generous()
		elseif eventID == 27
			 ; 00144A82 on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is talking to Hawthorne. He asks how Player sees himself as a merc
			 ; or a caravan guard. Player says guard, because he likes to help people.
			Trait_Peaceful(0.25)
			Trait_Nice()
		elseif eventID == 28
			 ; 00144A8A on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is talking to Hawthorne. He asks how Player sees himself as a merc
			 ; or a caravan guard. Player says he's a merc, always in it for the action and the money.
			Trait_Violent()
			Trait_Selfish()
		elseif eventID == 29
			 ; 00173B3C on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is listening to Duff's science lesson. Duff asks which type of
			 ; radiation is the most dangerous. Player says Gamma Rays (which is correct).
		elseif eventID == 30
			 ; 00173B43 on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is speaking with Duff at Science Center. She asks Player to help her
			 ; out by collecting Bloatfly Glands. Player says he'll do it for money only.
			Trait_Selfish(1.5)
		elseif eventID == 31
			 ; 00173B4A on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is speaking with Duff at Science Center. She asks Player to help her
			 ; out by collecting Bloatfly Glands. Player offers some he's already collected.
			 Trait_Generous(1.5)
		elseif eventID == 32
			 ; 00173B6B on quest DialogueDiamondCity (00003648)
			 ; DESCRIPTION: Player is listening to Duff's science lesson. Duff asks which type of
			 ; radiation is the most dangerous. Player is rude and answers "Who-Gives-A-Crap Rays."
			Trait_Mean(0.25)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_DialogueDiamondCity got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_DialogueDiamondCityEntrance(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DialogueDiamondCityEntrance
		if eventID == 1
			 ; 0001AC02 on quest DialogueDiamondCityEntrance (000190BC)
			 ; DESCRIPTION: Player is speaking to Piper outside Diamond City. Piper bluffed her way in
			 ; using Player as a patsy. She suggests they head inside before they get wise to the trick
			 ; and Player is rude to Piper, saying "I don't take orders from you."
			 Trait_Mean()
			 Trait_Violent()
		elseif eventID == 2
			 ; 0001C045 on quest DialogueDiamondCityEntrance (000190BC)
			 ; DESCRIPTION: Player is listening to Piper and the Mayor argue about "free speech." 
			 ; Player interjects that it's none of his business, staying out of the argument.
		elseif eventID == 3
			 ; 0001C04F on quest DialogueDiamondCityEntrance (000190BC)
			 ; DESCRIPTION: Player is listening to Piper and the Mayor argue about "free speech."
			 ; Player interjects that he's thinks newspapers stir up trouble.
		elseif eventID == 4
			 ; 0001C05B on quest DialogueDiamondCityEntrance (000190BC)
			 ; DESCRIPTION: Player is listening to Piper and the Mayor argue about "free speech."
			 ; Player interjects that he's always believed in freedom of the press.
			 Trait_Nice(0.25)
			 Trait_Peaceful(1.0)
		elseif eventID == 5
			 ; 00022D51 on quest DialogueDiamondCityEntrance (000190BC)
			 ; DESCRIPTION: Player is speaking to Danny just inside after Piper's ruse to get them both
			 ; into the city. Danny suspects Piper was lying. Player says he was innocent bystander.
		elseif eventID == 6
			 ; 00022D58 on quest DialogueDiamondCityEntrance (000190BC)
			 ; DESCRIPTION: Player is speaking to Danny just inside after Piper's ruse to get them both
			 ; into the city. Danny suspects Piper was lying. Player admits it was a lie.
		elseif eventID == 7
			 ; 00022D5E on quest DialogueDiamondCityEntrance (000190BC)
			 ; DESCRIPTION: Player is speaking to Danny just inside after Piper's ruse to get them both
			 ; into the city. Danny suspects Piper was lying. Player keeps the lie going.
			 Trait_Peaceful(0.25)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_DialogueDiamondCityEntrance got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_DialogueDiamondCitySchoolhouse(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DialogueDiamondCitySchoolhouse
		if eventID == 1
			 ; 001456AA on quest DialogueDiamondCitySchoolhouse (00094866)
			 ; DESCRIPTION: Player is speaking to Edna about love. She asks if it can exist between
			 ; two very different people. Player says everything you love will just get taken away.
			 Trait_Mean()
		elseif eventID == 2
			 ; 001456AE on quest DialogueDiamondCitySchoolhouse (00094866)
			 ; DESCRIPTION: Player has stumbled into a math quiz given by Edna. When asked a math question,
			 ; Player answers it correctly.
		elseif eventID == 3
			 ; 001456B2 on quest DialogueDiamondCitySchoolhouse (00094866)
			 ; DESCRIPTION: Player is speaking to Edna after the math question. Edna says the kids in her
			 ; school need love from their family in order to learn. Player is pragmatic and says kids need
			 ; structure.
			 Trait_Peaceful(0.25)
		elseif eventID == 4
			 ; 001456B6 on quest DialogueDiamondCitySchoolhouse (00094866)
			 ; DESCRIPTION: Player is speaking to Edna about love. She asks if it can exist between two
			 ; very different people. Player says hold onto whoever you find, tomorrow you might not have
			 ; the chance.
			Trait_Nice()
		elseif eventID == 5
			 ; 001456B9 on quest DialogueDiamondCitySchoolhouse (00094866)
			 ; DESCRIPTION: Player has stumbled into a math quiz given by Edna. When asked a math question, Player
			 ; is rude and says sarcastic line.
			Trait_Mean(0.5)
		elseif eventID == 6
			 ; 001456BD on quest DialogueDiamondCitySchoolhouse (00094866)
			 ; DESCRIPTION: Player is speaking to Edna after the math question. Edna says the kids in her
			 ; school need love from their family in order to learn. Player disagrees, saying sometimes you
			 ; need to be tough to survive.
			Trait_Violent(0.5)
		elseif eventID == 7
			 ; 001456C0 on quest DialogueDiamondCitySchoolhouse (00094866)
			 ; DESCRIPTION: Player stumbles into the schoolhouse, and Zwicky scolds that it isn't a store.
			 ; The Player is defiant and says he can go wherever he wants.
			 Trait_Violent()
		elseif eventID == 8
			 ; 001456C8 on quest DialogueDiamondCitySchoolhouse (00094866)
			 ; DESCRIPTION: Player is speaking to Edna after the math question. Edna says the kids in her
			 ; school need love from their family in order to learn. Player agrees.
			 Trait_Peaceful()
			 Trait_Nice()
		elseif eventID == 9
			 ; 001456CD on quest DialogueDiamondCitySchoolhouse (00094866)
			 ; DESCRIPTION: Player stumbles into the schoolhouse, and Zwicky scolds that it isn't a store.
			 ; The Player apologizes.
			 Trait_Peaceful()
			 Trait_Nice()
		elseif eventID == 10
			 ; 001456D1 on quest DialogueDiamondCitySchoolhouse (00094866)
			 ; DESCRIPTION: Player is speaking to Edna about love. She asks if it can exist between two
			 ; very different people. Player says that's between you and the other person, offering no
			 ; real insight.
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_DialogueDiamondCitySchoolhouse got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_DialogueDrumlinDiner(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DialogueDrumlinDiner
		if eventID == 1
			 ; 001069CA on quest DialogueDrumlinDiner (001069A9)
			 ; DESCRIPTION: Player stumbled into Wolfgang demanding his money from a junkie's mother, Trudy.
			 ; Player is speaking to Wolfgang, who asks Player to talk some sense into Trudy. Player agrees
			 ; to talk to her on his behalf.
			Trait_Peaceful()
		elseif eventID == 2
			 ; 001069CC on quest DialogueDrumlinDiner (001069A9)
			 ; DESCRIPTION: Player is trying to get more details from Wolfgang about his beef with Trudy.
			 ; He admits to selling Jet to Trudy's son and continuing to sell it until son was in debt.
			 ; Player agrees the debt is valid.
			Trait_Mean()
		elseif eventID == 3
			 ; 001069D0 on quest DialogueDrumlinDiner (001069A9)
			 ; DESCRIPTION: Player stumbled into Wolfgang demanding his money from a junkie's mother, Trudy.
			 ; Player is speaking to Wolfgang, who asks Player to talk some sense into Trudy. Player takes
			 ; Wolfgang's side immediately and offers to start shooting up the place.
			Trait_Violent()
		elseif eventID == 4
			 ; 001069D3 on quest DialogueDrumlinDiner (001069A9)
			 ; DESCRIPTION: Player is trying to get more details from Wolfgang about his beef with Trudy.
			 ; He admits to selling Jet to Trudy's son and continuing to sell it until son was in debt.
			 ; Player is angry Wolfgang made the son an addict.
			Trait_Nice()
		elseif eventID == 5
			 ; 001069D6 on quest DialogueDrumlinDiner (001069A9)
			 ; DESCRIPTION: Player stumbled into Wolfgang demanding his money from a junkie's mother, Trudy.
			 ; Wolfgang tells Player to butt out, Player threatens him and says get the gun out of his face.
			Trait_Nice()
			Trait_Violent(0.25)
		elseif eventID == 6
			 ; 001069DB on quest DialogueDrumlinDiner (001069A9)
			 ; DESCRIPTION: Player is trying to get more details from Wolfgang about his beef with Trudy.
			 ; He admits to selling Jet to Trudy's son and continuing to sell it until son was in debt.
			 ; Player thinks both sides messed this one up.
			Trait_Peaceful(0.50)
		elseif eventID == 7
			 ; 001069DE on quest DialogueDrumlinDiner (001069A9)
			 ; DESCRIPTION: Player stumbled into Wolfgang demanding his money from a junkie's mother, Trudy.
			 ; Wolfgang tells Player to butt out, Player is frustrated by this and exclaims the world can
			 ; "bite his ass."
			Trait_Peaceful(0.25)
			Trait_Mean(0.75)
		elseif eventID == 8
			 ; 001069E1 on quest DialogueDrumlinDiner (001069A9)
			 ; DESCRIPTION: Player stumbled into Wolfgang demanding his money from a junkie's mother, Trudy.
			 ; Wolfgang tells Player to butt out, but Player offers to diffuse the situation.
			 Trait_Peaceful()
		elseif eventID == 9
			 ; 001069E2 on quest DialogueDrumlinDiner (001069A9)
			 ; DESCRIPTION: Player stumbled into Wolfgang demanding his money from a junkie's mother, Trudy.
			 ; Player is speaking to Wolfgang, who asks Player to talk some sense into Trudy. Player says he'll
			 ; help diffuse the situation, but he better get paid.
			 Trait_Selfish()
		elseif eventID == 10
			 ; 00106C0C on quest DialogueDrumlinDiner (001069A9)
			 ; DESCRIPTION: Player is speaking to Trudy after agreeing to arbitrate for Wolfgang. Player says
			 ; he wants to help, but asks Trudy what she wants to do.
			 Trait_Peaceful(0.5)
			 Trait_Nice(0.5)
		elseif eventID == 11 || eventID == 16
			 ; 00106C14 on quest DialogueDrumlinDiner (001069A9)
			 ; DESCRIPTION: Trudy has offered the Player caps to kill Wolfgang so she doesn't have to pay him
			 ; more money. Player declines.
			 Trait_Peaceful()
		elseif eventID == 12
			 ; 00106C17 on quest DialogueDrumlinDiner (001069A9)
			 ; DESCRIPTION: Player is speaking to Trudy after agreeing to arbitrate for Wolfgang. Player tries
			 ; to convince Trudy to just pay the money so everything ends peacefully.
			 Trait_Peaceful(0.5)
			 Trait_Mean(0.5)
		elseif eventID == 13 || eventID == 17
			 ; 00106C18 on quest DialogueDrumlinDiner (001069A9)
			 ; DESCRIPTION: Trudy has offered the Player caps to kill Wolfgang so she doesn't have to pay him
			 ; more money. Player agrees.
			 Trait_Nice(0.5)
		elseif eventID == 14
			 ; 00106C1B on quest DialogueDrumlinDiner (001069A9)
			 ; DESCRIPTION: Player is speaking to Trudy after agreeing to arbitrate for Wolfgang. Player turns
			 ; the tables and threatens violence if she doesn't turn the money over Player himself.
			 Trait_Violent()
			 Trait_Selfish()
		elseif eventID == 15 || eventID == 18
			 ; 00106C2B on quest DialogueDrumlinDiner (001069A9)
			 ; DESCRIPTION: Trudy has offered the Player caps to kill Wolfgang so she doesn't have to pay
			 ; him more money. Player says he'll do it, but ups the price.
			 Trait_Selfish()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_DialogueDrumlinDiner got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_DialogueGoodneighbor(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DialogueGoodneighbor
		if eventID == 1
			 ; 00075361 on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: After hearing Magnolia sing, she asks Player if he liked the song or not.
			 ; Player evades answering by saying he just wants to talk.
		elseif eventID == 2
			 ; 00075366 on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: After hearing Magnolia sing, she asks Player if he liked the song or not.
			 ; Player said he's not a fan of jazz.
			 Trait_Mean(0.25)
		elseif eventID == 3
			 ; 0007536A on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: After hearing Magnolia sing, she asks Player if he liked the song or not.
			 ; Player said he loved it.
			 Trait_Nice(0.25)
		elseif eventID == 4
			 ; 00075E1F on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Player is speaking to Daisy who asked what the world was like before the
			 ; Great War. Player paints a white-picket fence/peaceful description.
			 Trait_Nice()
		elseif eventID == 5
			 ; 00075E25 on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Player is speaking to Daisy who asked what the world was like before the
			 ; Great War. Player paints bleak picture of governments going to war and people dying.
			 Trait_Mean()
		elseif eventID == 6
			 ; 00075E2E on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Player is speaking to Daisy who asked what the world was like before the
			 ; Great War. Player says it hasn't changed much, just "with less rust."
		elseif eventID == 7
			 ; 000802D9 on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Player encounters the Ghoul version of the Vtech Salesman who laments being
			 ; alone in the world. Player tells him to make due in Goodneighbor.
			 Trait_Mean(0.25)
		elseif eventID == 8
			 ; 000802E8 on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Player encounters the Ghoul version of the Vtech Salesman who is astonished
			 ; Player is still alive. When asked how he did it, Player alludes that the blood of his enemies
			 ; makes him immortal.
			 Trait_Mean(0.75)
		elseif eventID == 9
			 ; 000802ED on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Player encounters the Ghoul version of the Vtech Salesman who laments being
			 ; alone in the world. Player offers him a place in Sanctuary.
			 Trait_Nice()
			 Trait_Generous()
		elseif eventID == 10
			 ; 000802F8 on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Player encounters the Ghoul version of the Vtech Salesman who laments being
			 ; alone in the world. Player pushes him aside.
			 Trait_Mean()
		elseif eventID == 11
			 ; 0010B66A on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Daisy is trying to convince the Player to clear a library that's occupied by
			 ; Super Mutants. Player says he already did the deed.
			 Trait_Generous(1.5)
		elseif eventID == 12
			 ; 0010B66B on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Daisy is trying to convince the Player to clear a library that's occupied by
			 ; Super Mutants. Player agrees to do it.
			 Trait_Generous()
		elseif eventID == 13
			 ; 0010B66F on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Daisy is trying to convince the Player to clear a library that's occupied by
			 ; Super Mutants. Player declines.
		elseif eventID == 14
			 ; 0010B676 on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Daisy is trying to convince the Player to clear a library that's occupied by 
			 ; Super Mutants. Player pushes for more money.
			 Trait_Selfish()
		elseif eventID == 15
			 ; 0010CBB5 on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Fred is trying to convince the Player to tangle with the Gunners at
			 ; HalluciGen and bring back some chems for him to sell at his shop. Player declines.
		elseif eventID == 16
			 ; 0010CBC2 on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Fred is trying to convince the Player to tangle with the Gunners at
			 ; HalluciGen and bring back some chems for him to sell at his shop. Player gives some
			 ; he already had.
			 Trait_Generous()
		elseif eventID == 17
			 ; 0010CBC3 on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Fred is trying to convince the Player to tangle with the Gunners at
			 ; HalluciGen and bring back some chems for him to sell at his shop. Player agrees to do it.
			 Trait_Nice()
			 Trait_Generous(0.25)
		elseif eventID == 18
			 ; 0010CBC5 on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Fred is trying to convince the Player to tangle with the Gunners at
			 ; HalluciGen and bring back some chems for him to sell at his shop. Player pushes for more money.
			 Trait_Selfish()
		elseif eventID == 19
			 ; 0010D5C3 on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Whitechapel is trying to convince the Player to assassinate three targets
			 ; at various locations (obviously nefarious). Player says that it's already been done.
			 Trait_Generous(0.25)
		elseif eventID == 20
			 ; 0010D5C4 on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Whitechapel is trying to convince the Player to assassinate three targets
			 ; at various locations (obviously nefarious). Player agrees to do it.
		elseif eventID == 21
			 ; 0010D5C5 on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Whitechapel is trying to convince the Player to assassinate three targets
			 ; at various locations (obviously nefarious). Player pushes for more money.
			 Trait_Selfish(0.25)
		elseif eventID == 22
			 ; 0010D5D5 on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Whitechapel is trying to convince the Player to assassinate three targets
			 ; at various locations (obviously nefarious). Player refuses, saying that it's murder.
			 Trait_Nice()
			 Trait_Peaceful()
		elseif eventID == 23
			 ; 00111F97 on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Player is learning more about Hancock's history from the Ghoul himself.
			 ; He describes his sex, drugs and rock and roll lifestyle trying to impress the Player.
			 ; Player makes a joke about drugs preparing him for politics.
		elseif eventID == 24
			 ; 00111F9D on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Player is learning more about Hancock's history from the Ghoul himself.
			 ; He describes his sex, drugs and rock and roll lifestyle trying to impress the Player.
			 ; Player calls him a junkie.
			 Trait_Mean(0.50)
		elseif eventID == 25
			 ; 00111FA9 on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Player is learning more about Hancock's history from the Ghoul himself.
			 ; He describes his sex, drugs and rock and roll lifestyle trying to impress the Player.
			 ; Player admires his risk-taking.
			 Trait_Nice(0.50)
		elseif eventID == 26
			 ; 00112012 on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Hancock is trying to convince the Player to scout out Pickman Gallery
			 ; and find out what's going on there. Player declines.
		elseif eventID == 27
			 ; 0011201A on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Hancock is trying to convince the Player to scout out Pickman Gallery
			 ; and find out what's going on there. Player says he already cleared it out.
		elseif eventID == 28
			 ; 0011201B on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Hancock is trying to convince the Player to scout out Pickman Gallery
			 ; and find out what's going on there. Player agrees.
		elseif eventID == 29
			 ; 0011201C on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Hancock is trying to convince the Player to scout out Pickman Gallery
			 ; and find out what's going on there. Player pushes to find out more about getting paid.
			 Trait_Selfish(0.50)
		elseif eventID == 30
			 ; 00112836 on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Player has scouted Pickman Gallery for Hancock and reported that Pickman
			 ; was a serial killer who used dead bodies as a work of art. Player says it was horrific.
			 Trait_Nice(2.0)
		elseif eventID == 31
			 ; 00112838 on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Player has scouted Pickman Gallery for Hancock and reported that Pickman
			 ; was a serial killer who used dead bodies as a work of art. Player says it was beautiful.
			 Trait_Mean(2.0)			 
		elseif eventID == 32
			 ; 0011283A on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Player has scouted Pickman Gallery for Hancock and reported that Pickman
			 ; was a serial killer who used dead bodies as a work of art. Player is flippant, saying
			 ; the art not having much resale value when it starts rotting.
		elseif eventID == 33
			 ; 0011283A on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Player has romantically flirted with Magnolia while Romantic with any
			 ; romanceable Companion present
			 ; TODO: Spouse checks/scene
		elseif eventID == 34
			 ; 0011283A on quest DialogueGoodneighbor (00033582)
			 ; DESCRIPTION: Player romantically flirted with Magnolia while Romantic with any
			 ; romanceable Companion present - the flirts were successful, and Player now asked
			 ; Magnolia out on a date
			 ; TODO: Spouse checks/scene
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_DialogueGoodneighbor got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_DialogueGoodneighborEntrance(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DialogueGoodneighborEntrance
		if eventID == 1
			 ; 0003355C on quest DialogueGoodneighborEntrance (00033583)
			 ; DESCRIPTION: Hancock just shanked Finn who was shaking down the Player. After that, he says
			 ; how Goodneighbor is "of the people, for the people." Player says it sounds like anarchy.
			 Trait_Mean(0.25)
		elseif eventID == 2
			 ; 00033565 on quest DialogueGoodneighborEntrance (00033583)
			 ; DESCRIPTION: Finn is offering the Player (new in town) "insurance." Player threatens him,
			 ; knowing it's likely some kind of a protection racket.
			 Trait_Violent()
		elseif eventID == 3
			 ; 00033575 on quest DialogueGoodneighborEntrance (00033583)
			 ; DESCRIPTION: Hancock just shanked Finn who was shaking down the Player. After that, he says
			 ; how Goodneighbor is "of the people, for the people." Player does an eyeroll.
		elseif eventID == 4
			 ; 00033576 on quest DialogueGoodneighborEntrance (00033583)
			 ; DESCRIPTION: Hancock just shanked Finn who was shaking down the Player. After that, he says
			 ; how Goodneighbor is "of the people, for the people." Player agrees with that view.
			 Trait_Violent(0.25)
			 Trait_Nice()
		elseif eventID == 5
			 ; 0003357B on quest DialogueGoodneighborEntrance (00033583)
			 ; DESCRIPTION: Finn is offering the Player (new in town) "insurance." Player is flippant about
			 ; it to Finn, saying he's not interested. It's obviously a protection racket.
			 Trait_Nice(0.5)
		elseif eventID == 6
			 ; 0003357C on quest DialogueGoodneighborEntrance (00033583)
			 ; DESCRIPTION: Finn is offering the Player (new in town) "insurance." Player is willing to hear
			 ; him out even though it's obviously a protection racket.
			 Trait_Peaceful(0.25)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_DialogueGoodneighborEntrance got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_DialogueGraygarden(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DialogueGraygarden
		if eventID == 1
			 ; 00063D12 on quest DialogueGraygarden (0003F23F)
			 ; DESCRIPTION: Asking for more caps, being greedy
			 Trait_Selfish()
		elseif eventID == 2
			 ; 001091B7 on quest DialogueGraygarden (0003F23F)
			 ; DESCRIPTION: Rememebring a place from the past, before the war
		elseif eventID == 3
			 ; 001091C0 on quest DialogueGraygarden (0003F23F)
			 ; DESCRIPTION: Farm can't be run just by robots, need human management
			 Trait_Mean(0.25)
			 Trait_Violent(0.25)
		elseif eventID == 4
			 ; 001091C8 on quest DialogueGraygarden (0003F23F)
			 ; DESCRIPTION: Sarcasm, player does not miss television
		elseif eventID == 5
			 ; 001091C9 on quest DialogueGraygarden (0003F23F)
			 ; DESCRIPTION: Impressed by farm run entirely by robots, no humans needed
			 Trait_Nice(0.50)
			 Trait_Peaceful(0.50)
		elseif eventID == 6
			 ; 001091D0 on quest DialogueGraygarden (0003F23F)
			 ; DESCRIPTION: Not impressed by robot's unique personality, still just a dumb robot
			 Trait_Mean()
		elseif eventID == 7
			 ; 001091DF on quest DialogueGraygarden (0003F23F)
			 ; DESCRIPTION: Crazy robot personality is "unique"... sort of half flattery
			 Trait_Nice()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_DialogueGraygarden got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_DialogueRailroad(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DialogueRailroad
		if eventID == 1
			 ; 0005BD67 on quest DialogueRailroad (0005BC93)
			 ; DESCRIPTION: Player is speaking to Carrington for the first time, who is clearly unimpressed
			 ; and doesn't trust the Player. Player insults him in return (standing up for himself).
		elseif eventID == 2
			 ; 0005D746 on quest DialogueRailroad (0005BC93)
			 ; DESCRIPTION: Tinker Tom, suffering from paranoia, offers to inject the Player with a serum
			 ; that will supposedly kill all the little machines that the Institute put in the Player's body.
			 ; Player says no. 
		elseif eventID == 3
			 ; 0005D75A on quest DialogueRailroad (0005BC93)
			 ; DESCRIPTION: Tinker Tom, suffering from paranoia, offers to inject the Player with a serum
			 ; that will supposedly kill all the little machines that the Institute put in the Player's body.
			 ; Player says yes.
			 Trait_Nice()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_DialogueRailroad got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_DialogueTheSlog(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DialogueTheSlog
		if eventID == 1
			 ; 00078788 on quest DialogueTheSlog (0003F241)
			 ; DESCRIPTION: Complimenting a ghoul lady who is flirting
			 Trait_Nice()
		elseif eventID == 2
			 ; 00078793 on quest DialogueTheSlog (0003F241)
			 ; DESCRIPTION: Insulting, harsh, no way the player would find a ghoul attractive
			 Trait_Mean()
		elseif eventID == 3
			 ; 000FA41F on quest DialogueTheSlog (0003F241)
			 ; DESCRIPTION: Complimenting the ghouls on their farm
			 Trait_Nice()
		elseif eventID == 4
			 ; 000FA429 on quest DialogueTheSlog (0003F241)
			 ; DESCRIPTION: Insulting the ghouls' farm, being a jerk
			 Trait_Mean()
		elseif eventID == 5
			 ; 000FA42C on quest DialogueTheSlog (0003F241)
			 ; DESCRIPTION: Complimenting the ghouls on their ideas, being nice/supportive
			 Trait_Nice()
		elseif eventID == 6
			 ; 000FA434 on quest DialogueTheSlog (0003F241)
			 ; DESCRIPTION: Player insults the ghouls, is a jerk
			 Trait_Mean()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_DialogueTheSlog got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_DialogueVault81(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DialogueVault81
		if eventID == 1
			 ; 001AC499 on quest DialogueVault81 (0003F244)
			 ; DESCRIPTION: Tina is angry you gave her brother drugs and he OD'd. You apologize,
			 ; claiming you didn't know.
			 Trait_Nice()
		elseif eventID == 2
			 ; 001AC4D9 on quest DialogueVault81 (0003F244)
			 ; DESCRIPTION: Tina is angy at you for giving Bobby drugs which caused him to OD. You tell
			 ; her he got what he deserved.
			 Trait_Mean()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_DialogueVault81 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_DialogueWarwickHomestead(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DialogueWarwickHomestead
		if eventID == 1
			 ; 00106E0E on quest DialogueWarwickHomestead (0003F242)
			 ; DESCRIPTION: Farmers say that they are using sewage to grow their crops. Player says
			 ; it's a mixed blessing. 
		elseif eventID == 2
			 ; 00106E1E on quest DialogueWarwickHomestead (0003F242)
			 ; DESCRIPTION: Farmers say that they are using sewage to grow their crops. Player insults
			 ; the smell.
			 Trait_Mean(0.50)
		elseif eventID == 3
			 ; 00106E30 on quest DialogueWarwickHomestead (0003F242)
			 ; DESCRIPTION: Farmers say that they are using sewage to grow their crops. Player compliments
			 ; their ingenuity.
			 Trait_Nice()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_DialogueWarwickHomestead got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_DiamondCitySuperMutantIntro(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DiamondCitySuperMutantIntro
		if eventID == 1 || eventID == 2 || eventID == 3
			 ; 0001FDB1 on quest DiamondCitySuperMutantIntro (001A8A0E)
			 ; DESCRIPTION: The Player successfully assisted the Diamond City Security Guards in a
			 ; Super Mutant attack
			 Trait_Nice()
			 Trait_Generous()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_DiamondCitySuperMutantIntro got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_DN019JoinCult(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DN019JoinCult
		if eventID == 1 || eventID == 4 || eventID == 8
			 ; 000C511B on quest DN019JoinCult (000C5093)
			 ; DESCRIPTION: Player has encountered a cult which scams people into giving them all your
			 ; worldly possessions. Player falls for it and gives cult leader everything they own.
			 Trait_Peaceful()
		elseif eventID == 5 || eventID == 6
			 ; 000C515B on quest DN019JoinCult (000C5093)
			 ; DESCRIPTION: Player is speaking to a cult leader, trying to rescue Emogene from a cult.
			 ; Cult leader is refusing to let Player speak to her saying that she can't have an visitors
			 ; or needs to cool off. Player says he's a friend of the family and is willing to talk to her.
			 Trait_Peaceful()
		elseif eventID == 7
			 ; 000C516F on quest DN019JoinCult (000C5093)
			 ; DESCRIPTION: Player is speaking to a cult leader, trying to rescue Emogene from a cult.
			 ; Cult leader is refusing to let Player speak to her saying that she can't have an visitors
			 ; or needs to cool off. Player attempts to bribe cult leader for access.
			 Trait_Peaceful(0.5)
		elseif eventID == 9 || eventID == 2 || eventID == 3
			 ; 000C9444 on quest DN019JoinCult (000C5093)
			 ; DESCRIPTION: Player is speaking to a cult leader, trying to rescue Emogene from a cult.
			 ; Cult leader is refusing to let Player speak to her saying that she can't have an visitors
			 ; or needs to cool off. Player threatens cult leader with violence.
			 Trait_Violence(0.25)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_DN019JoinCult got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_DN053(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DN053
		if eventID == 1
			 ; 000B0E30 on quest DN053 (000ADCE7)
			 ; DESCRIPTION: Player convinces Virgil that it would be better to commit suicide than live
			 ; as a super mutant forever.
			 Trait_Violent()
			 Trait_Mean()
		elseif eventID == 2
			 ; 000B24F6 on quest DN053 (000ADCE7)
			 ; DESCRIPTION: Player agrees to let Virgil live, promising to lie to the Brotherhood about it.
			 Trait_Peaceful()
			 Trait_Nice()
		elseif eventID == 3
			 ; 001A9636 on quest DN053 (000ADCE7)
			 ; DESCRIPTION: Strong only. Player has mildly sided against him.
			 Trait_Mean(0.25)
		elseif eventID == 4
			 ; 001A9638 on quest DN053 (000ADCE7)
			 ; DESCRIPTION: Strong only. Player sides with him, there are advantages to being a super mutant.
			 Trait_Nice(0.25)
		elseif eventID == 5
			 ; 001A963C on quest DN053 (000ADCE7)
			 ; DESCRIPTION: Strong only. Player has strongly sided against him.
			 Trait_Mean()
		elseif eventID == 6
			 ; 001A963E on quest DN053 (000ADCE7)
			 ; DESCRIPTION: Strong only. Player is trying to placate him.
			 Trait_Nice()
		elseif eventID == 7
			 ; 001A9642 on quest DN053 (000ADCE7)
			 ; DESCRIPTION: Strong only. Player has strongly sided with him, and is helping him fight Virgil.
			 Trait_Nice()
			 Trait_Violent()
		elseif eventID == 8
			 ; 001A9645 on quest DN053 (000ADCE7)
			 ; DESCRIPTION: Strong only. Player neutral on whether Virgil should be a super mutant.
			 Trait_Peaceful(0.5)
		elseif eventID == 9
			 ; 001A9648 on quest DN053 (000ADCE7)
			 ; DESCRIPTION: Strong only. Player mildly sided against him.
			 Trait_Mean(0.25)
		elseif eventID == 10
			 ; 001A964B on quest DN053 (000ADCE7)
			 ; DESCRIPTION: Strong only. Player sides with Virgil. Of course he should be a human again.
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_DN053 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_DN102(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DN102
		if eventID == 1
			 ; 000E9885 on quest DN102 (0003479A)
			 ; DESCRIPTION: Player practical, trying to advise a confused, possibly crazy woman.
			 Trait_Peaceful()
		elseif eventID == 2
			 ; 000E9894 on quest DN102 (0003479A)
			 ; DESCRIPTION: Player hostile towards a confused, possibly crazy woman.
			 Trait_Mean()
			 Trait_Violent()
		elseif eventID == 3
			 ; 000E98AE on quest DN102 (0003479A)
			 ; DESCRIPTION: Player supportive, reassuring towards a confused, possibly crazy woman.
			 Trait_Nice()
			 Trait_Peaceful()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_DN102 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_FFDiamondCity01(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == FFDiamondCity01
		if eventID == 1
			 ; 000238A0 on quest FFDiamondCity01 (0001D727)
			 ; DESCRIPTION: Player was tasked with getting green paint for Abbot to paint the wall in DC.
			 ; The Player brought back blue or yellow paint instead, and Abbot is protesting. Player asks
			 ; Abbot if he thinks people will be upset.
			 Trait_Mean(0.25)
		elseif eventID == 2
			 ; 000238A8 on quest FFDiamondCity01 (0001D727)
			 ; DESCRIPTION: Player gets near Abbot in DC and he instantly barks at the Player not to touch
			 ; the paint. Player tells Abbot "Forget you, pal."
			 Trait_Mean(0.25)
		elseif eventID == 3
			 ; 000238AA on quest FFDiamondCity01 (0001D727)
			 ; DESCRIPTION: Player was tasked with getting green paint for Abbot to paint the wall in DC.
			 ; The Player brought back blue or yellow paint instead, and Abbot is protesting. Player responds
			 ; by saying "People don't like it, too bad."
			 Trait_Mean()
		elseif eventID == 4
			 ; 000238AF on quest FFDiamondCity01 (0001D727)
			 ; DESCRIPTION: Abbot has tasked the Player with getting green paint for the wall in DC.
			 ; Player refuses.
		elseif eventID == 5
			 ; 000238B5 on quest FFDiamondCity01 (0001D727)
			 ; DESCRIPTION: Player was tasked with getting green paint for Abbot to paint the wall in DC.
			 ; The Player brought it back. Abbot says that the wall sure seems happy with it. Player responds
			 ; negatively.
			 Trait_Generous()
			 Trait_Mean(0.25)
		elseif eventID == 6
			 ; 000238C6 on quest FFDiamondCity01 (0001D727)
			 ; DESCRIPTION: Player was tasked with getting green paint for Abbot to paint the wall in DC.
			 ; The Player brought back blue or yellow paint instead, and Abbot is protesting. Player responds
			 ; by saying "I think it'll look good."
			 Trait_Nice(0.25)
		elseif eventID == 7
			 ; 000238C7 on quest FFDiamondCity01 (0001D727)
			 ; DESCRIPTION: Player was tasked with getting green paint for Abbot to paint the wall in DC.
			 ; The Player brought it back. Abbot says that the wall sure seems happy with it. Player
			 ; immediately asks for his caps.
			 Trait_Selfish(0.25)
		elseif eventID == 8
			 ; 000238CB on quest FFDiamondCity01 (0001D727)
			 ; DESCRIPTION: Player was tasked with getting green paint for Abbot to paint the wall in DC.
			 ; The Player brought back blue or yellow paint instead, and Abbot is protesting. Player
			 ; responds by saying paint is paint.
		elseif eventID == 9
			 ; 000238D1 on quest FFDiamondCity01 (0001D727)
			 ; DESCRIPTION: Abbot has tasked the Player with getting green paint for the wall in DC. Player
			 ; gives some he already had.
			 Trait_Generous()
			 Trait_Nice()
		elseif eventID == 10
			 ; 000238D2 on quest FFDiamondCity01 (0001D727)
			 ; DESCRIPTION: Abbot has tasked the Player with getting green paint for the wall in DC.
			 ; Player agrees to do it.
			 Trait_Generous()
			 Trait_Nice()
		elseif eventID == 11
			 ; 000238D7 on quest FFDiamondCity01 (0001D727)
			 ; DESCRIPTION: Player was tasked with getting green paint for Abbot to paint the wall in DC.
			 ; The Player brought it back. Abbot says that the wall sure seems happy with it. Player responds
			 ; pleseantly.
			 Trait_Nice()
		elseif eventID == 12
			 ; 0003DE41 on quest FFDiamondCity01 (0001D727)
			 ; DESCRIPTION: Player gets near Abbot in DC and he instantly barks at the Player not to touch
			 ; the paint. Player agrees not to.
			 Trait_Peaceful()
		elseif eventID == 13
			 ; 0006AF41 on quest FFDiamondCity01 (0001D727)
			 ; DESCRIPTION: Abbot has tasked the Player with getting green paint for the wall in DC. Player
			 ; tries to gouge for more caps.
			 Trait_Selfish()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_FFDiamondCity01 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_FFDiamondCity07(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == FFDiamondCity07
		if eventID == 1
			 ; 0008BA6B on quest FFDiamondCity07 (000456E8)
			 ; DESCRIPTION: Piper is interviewing the Player about his life. Asks how DC compares to his old
			 ; life. Player asks how it's possible to compare the two.
		elseif eventID == 2
			 ; 0008BA7E on quest FFDiamondCity07 (000456E8)
			 ; DESCRIPTION: Piper is interviewing the Player. She asks what would you say to someone out
			 ; there who's lost someone but might be too scared to look for them. Player says not to lose hope.
			 Trait_Nice()
			 Trait_Peaceful()
		elseif eventID == 3
			 ; 0008BA8D on quest FFDiamondCity07 (000456E8)
			 ; DESCRIPTION: Piper is interviewing the Player about his life. Asks how CW compares to his
			 ; old life. Player says it gives him hope to see people trying to rebuild.
			 Trait_Nice()
		elseif eventID == 4
			 ; 0008BAB5 on quest FFDiamondCity07 (000456E8)
			 ; DESCRIPTION: Piper is interviewing the Player about his life. Asks how CW compares to his
			 ; old life. Player says it sucks.
			 Trait_Mean()
		elseif eventID == 5
			 ; 0008BACB on quest FFDiamondCity07 (000456E8)
			 ; DESCRIPTION: Piper is interviewing the Player. She asks what would you say to someone
			 ; out there who's lost someone but might be too scared to look for them. Player says they
			 ; should take it one day at a time.
		elseif eventID == 6
			 ; 0008BAD7 on quest FFDiamondCity07 (000456E8)
			 ; DESCRIPTION: Piper is interviewing the Player about his life. Asks how DC compares to his
			 ; old life. Player says he's been too busy blowing things up to notice.
			 Trait_Violent()
		elseif eventID == 7
			 ; 0008BB3A on quest FFDiamondCity07 (000456E8)
			 ; DESCRIPTION: Piper is interviewing the Player. She asks what would you say to someone out
			 ; there who's lost someone but might be too scared to look for them. Player says they should
			 ; get revenge.
			 Trait_Violent()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_FFDiamondCity07 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_FFDiamondCity08(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == FFDiamondCity08
		if eventID == 1
			 ; 00149CB2 on quest FFDiamondCity08 (000502AC)
			 ; DESCRIPTION: Player is speaking to Sheffield who is begging for a Nuka Cola. Player gives
			 ; him one.
			 Trait_Nice()
			 Trait_Generous(2.0)
		elseif eventID == 2
			 ; 00149CB4 on quest FFDiamondCity08 (000502AC)
			 ; DESCRIPTION: Player is speaking to Sheffield who is begging for a Nuka Cola. Player leaves
			 ; instead.
		elseif eventID == 3
			 ; 00149CBB on quest FFDiamondCity08 (000502AC)
			 ; DESCRIPTION: Player is speaking to Sheffield who is begging for a Nuka Cola. Player is
			 ; rude and tells him to drink some water.
			 Trait_Mean()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_FFDiamondCity08 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_FFDiamondCity10(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == FFDiamondCity10
		if eventID == 1
			 ; 00179175 on quest FFDiamondCity10 (001764DF)
			 ; DESCRIPTION: Danny Sullivan has been shot by the mayor and is bleeding out. Player lets him die.
			 Trait_Mean()
			 Trait_Violent()
		elseif eventID == 2
			 ; 0017919A on quest FFDiamondCity10 (001764DF)
			 ; DESCRIPTION: Danny Sullivan has been shot by the mayor and is bleeding out. Curie helps.
			 ; CURIE ONLY
			 Trait_Nice()
		elseif eventID == 3
			 ; 0017919B on quest FFDiamondCity10 (001764DF)
			 ; DESCRIPTION: Danny Sullivan has been shot by the mayor and is bleeding out. Player gives
			 ; him a stimpak.
			 Trait_Nice()
			 Trait_Generous()
		elseif eventID == 4 || eventID == 5
			 ; 00179B13 on quest FFDiamondCity10 (001764DF)
			 ; DESCRIPTION: Danny Sullivan has been shot by the mayor and is bleeding out. Player went to
			 ; get one of the doctors in town.
			 Trait_Nice()
		elseif eventID == 6
			 ; 0017CCDD on quest FFDiamondCity10 (001764DF)
			 ; DESCRIPTION: The synth mayor has taken Geneva hostage. He's made his demands to walk out
			 ; of the city a free man. Player says he's going to stand trial so the people can have justice.
			 Trait_Nice()
			 Trait_Peaceful()
		elseif eventID == 7
			 ; 0017CCE1 on quest FFDiamondCity10 (001764DF)
			 ; DESCRIPTION: The synth mayor has taken Geneva hostage. Player makes light of it and says
			 ; "hell, I'd vote for him again."
		elseif eventID == 8 || eventID == 9
			 ; 0017CCE5 on quest FFDiamondCity10 (001764DF)
			 ; DESCRIPTION: The synth mayor has taken Geneva hostage. He's made his demands to walk out
			 ; of the city a free man. Player opens fire.
			 Trait_Nice()
			 Trait_Violent(0.25)
		elseif eventID == 10
			 ; 0017CCEE on quest FFDiamondCity10 (001764DF)
			 ; DESCRIPTION: The synth mayor has taken Geneva hostage. He's made his demands to walk out
			 ; of the city a free man. Player agrees to his terms.
			 Trait_Nice()
			 Trait_Peaceful(2.0)
		elseif eventID == 11
			 ; 0017CCF1 on quest FFDiamondCity10 (001764DF)
			 ; DESCRIPTION: The synth mayor has taken Geneva hostage. Player attempts a speech challenge to
			 ; talk him down.
			 Trait_Nice()
			 Trait_Peaceful()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_FFDiamondCity10 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_FFGoodneighbor07(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == FFGoodneighbor07
		if eventID == 1
			 ; 00132439 on quest FFGoodneighbor07 (001323AB)
			 ; DESCRIPTION: Player convinces Bobbi to give them her caps and run to escape Hancock
			 Trait_Nice()
			 Trait_Selfish()
			 Trait_Peaceful()
		elseif eventID == 2
			 ; 00132456 on quest FFGoodneighbor07 (001323AB)
			 ; DESCRIPTION: Player attacks Bobbi to get back their caps for Hancock
			 Trait_Violent(0.5)
		elseif eventID == 3
			 ; 00132468 on quest FFGoodneighbor07 (001323AB)
			 ; DESCRIPTION: Player agrees to kill Bobbi No-Nose for Hancock
			 Trait_Violent(0.5)
		elseif eventID == 4
			 ; 00132473 on quest FFGoodneighbor07 (001323AB)
			 ; DESCRIPTION: Player offers to talk to Hancock for Bobbi, get her off the hook
			 Trait_Nice()
			 Trait_Peaceful()
		elseif eventID == 5
			 ; 00132487 on quest FFGoodneighbor07 (001323AB)
			 ; DESCRIPTION: Player refuses to kill Bobbi No-Nose for Hancock
			 Trait_Nice()
			 Trait_Peaceful()
		elseif eventID == 6
			 ; 001324AD on quest FFGoodneighbor07 (001323AB)
			 ; DESCRIPTION: Player attempts to negotiate down the caps they owe Hancock for the job
			 ; they pulled in MS16
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_FFGoodneighbor07 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_Inst301(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == Inst301
		if eventID == 1
			 ; 000E69EF on quest Inst301 (000E2058)
			 ; DESCRIPTION: Refuse to take bribe, nice try though
			 Trait_Generous()
		elseif eventID == 2
			 ; 000E69FA on quest Inst301 (000E2058)
			 ; DESCRIPTION: Threaten to take loot by force, no bargains
			 Trait_Mean()
			 Trait_Violent()
			 Trait_Selfish()
		elseif eventID == 3
			 ; 000E6A06 on quest Inst301 (000E2058)
			 ; DESCRIPTION: Agree to take loot bribe and leave rogue synth alone
			 Trait_Nice()
			 Trait_Peaceful()
		elseif eventID == 4
			 ; 000E6A1E on quest Inst301 (000E2058)
			 ; DESCRIPTION: Ask what happens if bribe is refused
		elseif eventID == 5
			 ; 0012470F on quest Inst301 (000E2058)
			 ; DESCRIPTION: Avoid unnecessary violence against a rogue synth
			 Trait_Peaceful()
		elseif eventID == 6
			 ; 00124710 on quest Inst301 (000E2058)
			 ; DESCRIPTION: Player has met up with X6 outside of Libertalia. X6 says he's ready to go.
			 ; Player agrees to take him along.
		elseif eventID == 7
			 ; 00124716 on quest Inst301 (000E2058)
			 ; DESCRIPTION: Player has met up with X6 outside of Libertalia. X6 says he's ready to go.
			 ; Player says he can do it alone.
		elseif eventID == 8
			 ; 0012471D on quest Inst301 (000E2058)
			 ; DESCRIPTION: Player has met up with X6 outside of Libertalia. X6 says he's ready to go.
			 ; Player agrees, but is rude about it.
			 Trait_Mean(0.25)
		elseif eventID == 9
			 ; 0012471E on quest Inst301 (000E2058)
			 ; DESCRIPTION: Being sarcastic about using a lengthy synth reset code
		elseif eventID == 10
			 ; 00124726 on quest Inst301 (000E2058)
			 ; DESCRIPTION: Refuse to wipe synth's identity b/c it seems inhumane
			 Trait_Nice()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_Inst301 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_Inst302(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == Inst302
		if eventID == 1
			 ; 000D6031 on quest Inst302 (000A8258)
			 ; DESCRIPTION: Player is at Bunker Hill with a mission to rescue synths under
			 ; Railroad Protection. X4-18 Courser gives orders, Player agrees but is rude about it.
			 Trait_Mean(0.25)
		elseif eventID == 2
			 ; 000D6036 on quest Inst302 (000A8258)
			 ; DESCRIPTION: Player is at Bunker Hill with a mission to rescue synths under
			 ; Railroad Protection. X4-18 Courser gives orders, Player says he should be in charge.
			 Trait_Nice(0.25)
		elseif eventID == 3
			 ; 000D603C on quest Inst302 (000A8258)
			 ; DESCRIPTION: Player is at Bunker Hill with a mission to rescue synths under
			 ; Railroad Protection. X4-18 Courser gives orders, Player agrees to follow them.
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_Inst302 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_Inst306(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == Inst306
		if eventID == 1
			 ; 000B92A8 on quest Inst306 (000AC7B3)
			 ; DESCRIPTION: Player has been sent to kill Railroad, but has worked for them.
			 ; When confronted by Desdemona, Player agrees not to attack.
			 Trait_Nice(2.0)
			 Trait_Peaceful(2.0)
		elseif eventID == 2
			 ; 000B92C5 on quest Inst306 (000AC7B3)
			 ; DESCRIPTION: Player has been sent to kill Railroad, but has worked for them.
			 ; When confronted by Desdemona, Player agrees not to attack but acts rude about it.
			 Trait_Peaceful()
		elseif eventID == 3
			 ; 000B92D1 on quest Inst306 (000AC7B3)
			 ; DESCRIPTION: Player has been sent to kill Railroad, but has worked for them. When
			 ; confronted by Desdemona, Player says he has to kill everyone.
			 Trait_Mean(3.0)
			 Trait_Violent(3.0)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_Inst306 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_InstM01(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == InstM01
		if eventID == 1
			 ; 0009C84C on quest InstM01 (000986C7)
			 ; DESCRIPTION: Angry retort at a perceived insult
			 Trait_Mean(0.25)
			 Trait_Violent(0.25)
		elseif eventID == 2
			 ; 0009C850 on quest InstM01 (000986C7)
			 ; DESCRIPTION: Expressing confidence that it won't be a problem
		elseif eventID == 3
			 ; 000A11F6 on quest InstM01 (000986C7)
			 ; DESCRIPTION: Confident, self-assured, we can solve this
		elseif eventID == 4
			 ; 000A1201 on quest InstM01 (000986C7)
			 ; DESCRIPTION: 
		elseif eventID == 5
			 ; 000A120A on quest InstM01 (000986C7)
			 ; DESCRIPTION: Correcting a synth who is too close to these people, in too deep
		elseif eventID == 6
			 ; 000A1212 on quest InstM01 (000986C7)
			 ; DESCRIPTION: Harsh attitude, acting intolerant
			 Trait_Mean(0.5)
			 Trait_Violent(0.5)
		elseif eventID == 7
			 ; 0011A06F on quest InstM01 (000986C7)
			 ; DESCRIPTION: Agreeing to a bribe
			 Trait_Selfish(0.25)
		elseif eventID == 8
			 ; 0011A087 on quest InstM01 (000986C7)
			 ; DESCRIPTION: Disgusted, strong words, player is angry
			 Trait_Violent()
		elseif eventID == 9
			 ; 0011A09E on quest InstM01 (000986C7)
			 ; DESCRIPTION: Asking, almost begging, for help, playing on sympathies
			 Trait_Peaceful(0.5)
			 Trait_Nice(0.5)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_InstM01 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_InstM02(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == InstM02
		if eventID == 1
			 ; 000A829C on quest InstM02 (000A8257)
			 ; DESCRIPTION: Defending the Institute, threatening its enemies
			 Trait_Violence(0.25)
		elseif eventID == 2
			 ; 000A82CB on quest InstM02 (000A8257)
			 ; DESCRIPTION: Strong accusation
			 Trait_Violence(0.25)
		elseif eventID == 3
			 ; 000A82CC on quest InstM02 (000A8257)
			 ; DESCRIPTION: Annoyed, sarcastic, not taking this seriously
			 Trait_Mean(0.25)
			 Trait_Violence(0.25)
		elseif eventID == 4
			 ; 000B17A7 on quest InstM02 (000A8257)
			 ; DESCRIPTION: Refuse to betray Institute
		elseif eventID == 5
			 ; 000B17B5 on quest InstM02 (000A8257)
			 ; DESCRIPTION: Willing to betray Institute for a bribe
			 Trait_Selfish()
		elseif eventID == 6
			 ; 000B17BB on quest InstM02 (000A8257)
			 ; DESCRIPTION: Strong accusation
		elseif eventID == 7
			 ; 000B17CD on quest InstM02 (000A8257)
			 ; DESCRIPTION: Being evasive, cagey, triyng to fool Liam
		elseif eventID == 8
			 ; 000B17CF on quest InstM02 (000A8257)
			 ; DESCRIPTION: Forceful, demanding answers
			 Trait_Violence()
		elseif eventID == 9
			 ; 000B17DF on quest InstM02 (000A8257)
			 ; DESCRIPTION: Synths are better off in the Institute
			 Trait_Nice()
			 Trait_Peaceful()
		elseif eventID == 10
			 ; 000B17E5 on quest InstM02 (000A8257)
			 ; DESCRIPTION: Reinfocing loyalty to Institute
		elseif eventID == 11
			 ; 000B17E8 on quest InstM02 (000A8257)
			 ; DESCRIPTION: Betray Justin Ayo and by extension, the SRB.
			 Trait_Mean()
			 Trait_Violent()
		elseif eventID == 12
			 ; 000B17F7 on quest InstM02 (000A8257)
			 ; DESCRIPTION: Pro-synth freedom
			 Trait_Peaceful()
		elseif eventID == 13
			 ; 000B1FA3 on quest InstM02 (000A8257)
			 ; DESCRIPTION: Insulting the head of the SRB
			 Trait_Mean()
		elseif eventID == 14
			 ; 000B1FA7 on quest InstM02 (000A8257)
			 ; DESCRIPTION: Improve security, make Instutute safer, no more synth escape
			 Trait_Violence()
		elseif eventID == 15
			 ; 001134D3 on quest InstM02 (000A8257)
			 ; DESCRIPTION: Seeking a peaceful solution
			 Trait_Peaceful()
		elseif eventID == 16
			 ; 001134D8 on quest InstM02 (000A8257)
			 ; DESCRIPTION: Side with Institute, condemn Liam for his treachery
			 Trait_Mean()
			 Trait_Violent()
		elseif eventID == 17
			 ; 001134D9 on quest InstM02 (000A8257)
			 ; DESCRIPTION: Forceful, authoritative, fearless
			 Trait_Violent()
		elseif eventID == 18
			 ; 00115AD0 on quest InstM02 (000A8257)
			 ; DESCRIPTION: Agree to help synths escape, effectively betraying Institute
			 Trait_Nice()
			 Trait_Peaceful()
		elseif eventID == 19
			 ; 00115AD1 on quest InstM02 (000A8257)
			 ; DESCRIPTION: protecting the escaped synths, betraying the Institute
			 Trait_Nice()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_InstM02 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_InstM03(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == InstM03
		if eventID == 1
			 ; 000BA862 on quest InstM03 (000B2D47)
			 ; DESCRIPTION: Seeking peaceful solution against Institute scientists
			 Trait_Nice()
			 Trait_Peaceful()
		elseif eventID == 2
			 ; 000BA869 on quest InstM03 (000B2D47)
			 ; DESCRIPTION: Violence against Institute scientists
			 Trait_Mean()
			 Trait_Violence()
		elseif eventID == 3
			 ; 000BA87E on quest InstM03 (000B2D47)
			 ; DESCRIPTION: Seeking non-violent solution against Institute scientists
			 Trait_Nice()
			 Trait_Peaceful()
		elseif eventID == 4
			 ; 000BE7CA on quest InstM03 (000B2D47)
			 ; DESCRIPTION: Moderate punishment
		elseif eventID == 5
			 ; 000BE7D3 on quest InstM03 (000B2D47)
			 ; DESCRIPTION: Player starts a fight with Institute scientists
			 Trait_Violence()
		elseif eventID == 6
			 ; 000BE7D5 on quest InstM03 (000B2D47)
			 ; DESCRIPTION: Lenient punishment
		elseif eventID == 7
			 ; 000BE7DB on quest InstM03 (000B2D47)
			 ; DESCRIPTION: Player chooses not to use violence against scientists
			 Trait_Nice(0.25)
			 Trait_Peaceful()
		elseif eventID == 8
			 ; 000BE7DD on quest InstM03 (000B2D47)
			 ; DESCRIPTION: Scientists get the death sentence, totally unforgiving
			 Trait_Mean()
			 Trait_Violent(2.0)
		elseif eventID == 9
			 ; 000BE7E8 on quest InstM03 (000B2D47)
			 ; DESCRIPTION: Forgive the scientists totally, no punishment for their actions
			 Trait_Nice(2.0)
			 Trait_Peaceful(2.0)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_InstM03 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_Min01(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == Min01
		if eventID == 1
			 ; 000B13EA on quest Min01 (0005DEE4)
			 ; DESCRIPTION: After helping the Minutemen at Concord, Preston wants Player to lead the
			 ; rebuild of their group. Player agrees.
			 Trait_Nice()
		elseif eventID == 2
			 ; 000B13FB on quest Min01 (0005DEE4)
			 ; DESCRIPTION: After helping the Minutemen at Concord, Preston wants Player to lead the
			 ; rebuild of their group. Player refuses.
		elseif eventID == 3 || eventID == 4
			 ; 00118891 on quest Min01 (0005DEE4)
			 ; DESCRIPTION: After agreeing to help the Minutemen, Player is approached by Sturgis
			 ; to take on some work. Player makes snarky comment.
			 Trait_Selfish(0.25)
		elseif eventID == 5
			 ; 0011889A on quest Min01 (0005DEE4)
			 ; DESCRIPTION: After agreeing to help the Minutemen, Player is approached by Sturgis to
			 ; take on some work. Player refuses to help.
			 Trait_Mean(0.25)
		elseif eventID == 6 || eventID == 7
			 ; 001188A3 on quest Min01 (0005DEE4)
			 ; DESCRIPTION: After agreeing to help the Minutemen, Player is approached by Sturgis to
			 ; take on some work. Player agrees to help.
			 Trait_Nice()
			 Trait_Generous(0.25)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_Min01 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_Min03(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == Min03
		if eventID == 1
			 ; 000AC052 on quest Min03 (000AA778)
			 ; DESCRIPTION: Player has said the wrong thing and angered Ronnie Shaw.
			 ; Shaw is threatening to brawl. Player tries to calm him down.
			 Trait_Peaceful()
		elseif eventID == 2
			 ; 000AC05A on quest Min03 (000AA778)
			 ; DESCRIPTION: Player has said the wrong thing and angered Ronnie Shaw.
			 ; Shaw is threatening to brawl. Player starts brawl.
			 Trait_Violent()
		elseif eventID == 3
			 ; 000AC069 on quest Min03 (000AA778)
			 ; DESCRIPTION: Player has said the wrong thing and angered Ronnie Shaw.
			 ; Shaw is threatening to brawl. Player says snarky comment, but avoids fighting.
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_Min03 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MinRecruit03(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MinRecruit03
		if eventID == 1 || eventID == 2
			 ; 00106FAF on quest MinRecruit03 (00106F05)
			 ; DESCRIPTION: Player helped resolve Raiders who were stealing from a settlement. Settlement
			 ; spokesperson rewards Player.
			 Trait_Nice()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MinRecruit03 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MinRecruit09(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MinRecruit09
		if eventID == 1
			 ; 00174CD1 on quest MinRecruit09 (00164167)
			 ; DESCRIPTION: Player refuses to help Institute refugees
			 Trait_Mean()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MinRecruit09 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MinVsInst(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MinVsInst
		if eventID == 1
			 ; 0009E586 on quest MinVsInst (00055BE4)
			 ; DESCRIPTION: Player says he can work together with the Minuteman Contact.
			 Trait_Nice()
		elseif eventID == 2
			 ; 0009E58F on quest MinVsInst (00055BE4)
			 ; DESCRIPTION: Player asks the Minuteman Contact if he could really risk being wrong.
		elseif eventID == 3
			 ; 0009E594 on quest MinVsInst (00055BE4)
			 ; DESCRIPTION: Player is scolding the Minuteman Contact for not having all of the information.
			 Trait_Mean()
		elseif eventID == 4
			 ; 0009E59A on quest MinVsInst (00055BE4)
			 ; DESCRIPTION: Player is threatening the Minuteman Contact.
			 Trait_Violent()
		elseif eventID == 5
			 ; 0015D2F1 on quest MinVsInst (00055BE4)
			 ; DESCRIPTION: Player agrees with Enrico that this is a lot of effort for just the sake
			 ; of one man.
			 Trait_Mean(0.25)
		elseif eventID == 6
			 ; 0015D2F2 on quest MinVsInst (00055BE4)
			 ; DESCRIPTION: Player convinces Enrico that Phase Three of their plan is worth the risk.
			 Trait_Nice(0.5)
		elseif eventID == 7
			 ; 0015D2F5 on quest MinVsInst (00055BE4)
			 ; DESCRIPTION: Player demeans Enrico about Phase Three.
			 Trait_Mean(0.5)
		elseif eventID == 8
			 ; 00185EE3 on quest MinVsInst (00055BE4)
			 ; DESCRIPTION: Enrico thanks Player for the help on the mission, Player says he's here for
			 ; sake of the Institute, not for Enrico
		elseif eventID == 9
			 ; 00185EE7 on quest MinVsInst (00055BE4)
			 ; DESCRIPTION: Enrico thanks Player for the help on the mission, Player is mean in return.
			 Trait_Mean()
		elseif eventID == 10
			 ; 00185EEA on quest MinVsInst (00055BE4)
			 ; DESCRIPTION: Enrico thanks Player for the help on the mission, Player is pleasant in return.
			 Trait_Nice()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MinVsInst got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MQ00MamaMurphy(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MQ00MamaMurphy
		if eventID == 1 || eventID == 12 || eventID == 15 || eventID == 20 || eventID == 24
			 ; 001826A9 on quest MQ00MamaMurphy (000EBE71)
			 ; DESCRIPTION: Mama Murphy has asked Player to bring her drugs for her Sight.
			 ; Player says he already has some and gives it to her.
			 Trait_Generous()
		elseif eventID == 2 || eventID == 16 || eventID == 19 || eventID == 21 || eventID == 25
			 ; 001826AA on quest MQ00MamaMurphy (000EBE71)
			 ; DESCRIPTION: Mama Murphy has asked Player to bring her some drugs for her Sight. Player
			 ; agrees to look.
			 Trait_Selfish()
		elseif eventID == 3
			 ; 00183329 on quest MQ00MamaMurphy (000EBE71)
			 ; DESCRIPTION: The Player is trying to convince Mama Murphy to stop using chems for the Sight.
			 ; He gives up and says it's her choice.
			 Trait_Peaceful()

		elseif eventID == 4
			 ; 0018332B on quest MQ00MamaMurphy (000EBE71)
			 ; DESCRIPTION: The Player is trying to convince Mama Murphy to stop using chems for the Sight.
			 ; He speech challenges in a threatening manner.
			 Trait_Nice()
			 Trait_Violent(0.25)
		elseif eventID == 5
			 ; 00183339 on quest MQ00MamaMurphy (000EBE71)
			 ; DESCRIPTION: The Player is trying to convince Mama Murphy to stop using chems for the Sight.
			 ; He speech challenges in a friendly manner.

			 Trait_Nice()
			 Trait_Peaceful(0.25)
		elseif eventID == 6
			 ; 0018472E on quest MQ00MamaMurphy (000EBE71)
			 ; DESCRIPTION: Player has brought Mama Murphy a hit of drugs and allows her to use it.
			 Trait_Mean(0.50)
			 Trait_Selfish(2.0)
			 
		elseif eventID == 9 || eventID == 7 || eventID == 8 || eventID == 10 || eventID == 11 || eventID == 13 || eventID == 14 || eventID == 17 || eventID == 18 || eventID == 22 || eventID == 23
			 ; 00184AAA on quest MQ00MamaMurphy (000EBE71)
			 ; DESCRIPTION: Mama Murphy has asked Player to bring her some drugs for her Sight. Player
			 ; refuses, saying she's an addict and needs help.

			 Trait_Nice()
			 Trait_Peaceful()
			 
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MQ00MamaMurphy got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MQ104(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MQ104
		if eventID == 1
			 ; 0001702E on quest MQ104 (0001F25E)
			 ; DESCRIPTION: Player found Nick in Vault 114. There is confrontation between Nick,
			 ; Skinny Malone, Darla and Player. Darla is instigating a fight. Player is sarcastic to Darla.
			 Trait_Violent(0.25)
		elseif eventID == 2
			 ; 000172A2 on quest MQ104 (0001F25E)
			 ; DESCRIPTION: Player found Nick in Vault 114. There is confrontation between Nick,
			 ; Skinny Malone, Darla and Player. Player is addressing Skinny now, and tries to end the
			 ; whole showdown peacefully.
			 Trait_Peaceful()
		elseif eventID == 3
			 ; 00017509 on quest MQ104 (0001F25E)
			 ; DESCRIPTION: Player found Nick in Vault 114. There is confrontation between Nick,
			 ; Skinny Malone, Darla and Player. Player is addressing Skinny now, and insults him starting a
			 ; fight.
			 Trait_Mean(0.50)
			 Trait_Violent(0.50)
		elseif eventID == 4
			 ; 000179D4 on quest MQ104 (0001F25E)
			 ; DESCRIPTION: Player found Nick in Vault 114. There is confrontation between Nick,
			 ; Skinny Malone, Darla and Player. Darla is instigating a fight. Player tries to talk Darla down.
			 Trait_Peaceful()
		elseif eventID == 5
			 ; 00017A0B on quest MQ104 (0001F25E)
			 ; DESCRIPTION: Player found Nick in Vault 114. There is confrontation between Nick,
			 ; Skinny Malone, Darla and Player. Player is addressing Skinny now, and tries to turn him
			 ; against Darla, who is clearly the aggressor here.
		elseif eventID == 6
			 ; 00017B10 on quest MQ104 (0001F25E)
			 ; DESCRIPTION: Player found Nick in Vault 114. There is confrontation between Nick,
			 ; Skinny Malone, Darla and Player. Darla is instigating a fight. Player tries to trick Darla
			 ; into shooting Skinny instead.
			 Trait_Mean()
			 Trait_Violent()
		elseif eventID == 7
			 ; 00183327 on quest MQ104 (0001F25E)
			 ; DESCRIPTION: Player found Nick in Vault 114. There is confrontation between Nick,
			 ; Skinny Malone, Darla and Player. Darla is instigating a fight. Player defuses it by using a
			 ; special code phrase on Skinny that calms him down.
			 Trait_Nice()
			 Trait_Peaceful()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MQ104 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MQ105(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MQ105
		if eventID == 1
			 ; 00065EEB on quest MQ105 (000229E6)
			 ; DESCRIPTION: Player is interviewing Nick about Shaun. During the interview, Player accuses
			 ; Nick of lying saying he's a synth, so he's protecting the Institute.
			 Trait_Mean(0.50)
		elseif eventID == 2
			 ; 000E179A on quest MQ105 (000229E6)
			 ; DESCRIPTION: Player is looking to get into Kellogg's house and needs a key from Geneva.
			 ; Player tries to bribe her to get the key.
		elseif eventID == 3 || eventID == 4
			 ; 000E17D1 on quest MQ105 (000229E6)
			 ; DESCRIPTION: Player is looking to get into Kellogg's house and needs a key from Geneva.
			 ; Player pleads his case nicely trying to appeal to her sympathy.
			 Trait_Nice(0.50)
			 Trait_Peaceful(0.50)
		elseif eventID == 5
			 ; 000E17DB on quest MQ105 (000229E6)
			 ; DESCRIPTION: Player is looking to get into Kellogg's house and needs a key from Geneva.
			 ; Player says to "just trust me".
			 Trait_Peaceful(0.50)
		elseif eventID == 6 || eventID == 9
			 ; 000F6466 on quest MQ105 (000229E6)
			 ; DESCRIPTION: Player is trying to get the Mayor to let him into Kellogg's house. Player
			 ; tries to appeal to him saying Kellogg was a kidnapper.
			 Trait_Nice(0.50)
			 Trait_Peaceful(0.50)
		elseif eventID == 7
			 ; 000F6471 on quest MQ105 (000229E6)
			 ; DESCRIPTION: Player is trying to get the Mayor to let him into Kellogg's house. Player says
			 ; "So that's it? You're not going to help?"
		elseif eventID == 8
			 ; 000F6478 on quest MQ105 (000229E6)
			 ; DESCRIPTION: Player is trying to get the Mayor to let him into Kellogg's house. Player tries
			 ; to bribe him.
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MQ105 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MQ201(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MQ201
		if eventID == 2
			 ; 00067FA2 on quest MQ201 (000229E8)
			 ; DESCRIPTION: Player killed Kellogg and is talking with Piper and Nick. Player acts like
			 ; Kellogg deserved it.
			 Trait_Mean()
			 Trait_Violent()
		elseif eventID == 3
			 ; 00067FBD on quest MQ201 (000229E8)
			 ; DESCRIPTION: Player killed Kellogg and is talking with Piper and Nick. Player defends his
			 ; actions by saying he wasn't going to talk.
		elseif eventID == 4
			 ; 00067FE8 on quest MQ201 (000229E8)
			 ; DESCRIPTION: Player killed Kellogg and is talking with Piper and Nick. Player expresses regret.
			 Trait_Nice()
		elseif eventID == 5 || eventID == 1
			 ; 0015145F on quest MQ201 (000229E8)
			 ; DESCRIPTION: Player is trying to get Nick to disclose the location of the Institute, which he
			 ; swears he doesn't know. Player yells at him obviously thinking he's lying.
			 Trait_Mean(0.25)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MQ201 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MQ206(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MQ206
		if eventID == 1
			 ; 0008660D on quest MQ206 (000B1752)
			 ; DESCRIPTION: Player is talking to Doctor Amari about decoding the courser chip. Amari suggests
			 ; Player tries Railroad, Player makes a sarcastic statement.
		elseif eventID == 2
			 ; 000B1D19 on quest MQ206 (000B1752)
			 ; DESCRIPTION: Player is talking to Doctor Amari about decoding the courser chip. Amari suggests
			 ; Player tries Railroad, but Player says "Not them." (acting like he doesn't like them)
			 Trait_Mean(0.25)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MQ206 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MQ206RR(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MQ206RR
		if eventID == 1
			 ; 000B9D80 on quest MQ206RR (000B26BC)
			 ; DESCRIPTION: Player is talking to Railroad about teleporting into the Institute. Des
			 ; wants the Player to make contact with Patriot. Player agrees.
			 Trait_Nice()
			 Trait_Generous()
		elseif eventID == 2
			 ; 000B9D85 on quest MQ206RR (000B26BC)
			 ; DESCRIPTION: Player is talking to Railroad about teleporting into the Institute. Des
			 ; wants the Player to make contact with Patriot. Player says he can't risk it.
			 Trait_Selfish()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MQ206RR got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MQ302BoS(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MQ302BoS
		if eventID == 1
			 ; 00187D98 on quest MQ302BoS (0010C64B)
			 ; DESCRIPTION: Player has planted the bomb in the Institute and is relaying out, deciding to
			 ; ignore the kid version of Shaun. Ingram is mortified. Player says it's none of her damn
			 ; business.
			 Trait_Mean()
		elseif eventID == 2
			 ; 00187D9C on quest MQ302BoS (0010C64B)
			 ; DESCRIPTION: Player has planted the bomb in the Institute and is relaying out, deciding to
			 ; ignore the kid version of Shaun. Ingram is mortified. Player explains calmly that kid is a
			 ; synth.
		elseif eventID == 3
			 ; 00187DA5 on quest MQ302BoS (0010C64B)
			 ; DESCRIPTION: Player has planted the bomb in the Institute and is relaying out, deciding to
			 ; ignore the kid version of Shaun. Ingram is mortified. Player says he doesn't have time
			 ; to talk about it.
		elseif eventID == 4
			 ; 001867C2 on quest MQ302Min (0010C64A)
			 ; DESCRIPTION: Player has planted the bomb in the Institute and is relaying out, deciding to
			 ; ignore the kid version of Shaun. Ingram is mortified. Player asks her if there's a
			 ; problem (standoffish).
			 Trait_Mean()
			 Trait_Violent(0.25)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MQ302BoS got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MQ302Min(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MQ302Min
		if eventID == 1
			 ; 001867A8 on quest MQ302Min (0010C64A)
			 ; DESCRIPTION: Player has planted the bomb in the Institute and is relaying out, deciding to
			 ; ignore the kid version of Shaun. Sturges is mortified. Player explains he doesn't have time
			 ; to talk about it.
		elseif eventID == 2
			 ; 001867AF on quest MQ302Min (0010C64A)
			 ; DESCRIPTION: Player has planted the bomb in the Institute and is relaying out, deciding to
			 ; ignore the kid version of Shaun. Sturges is mortified. Player says it's none of his damn
			 ; business.
			 Trait_Mean()
		elseif eventID == 3
			 ; 001867B6 on quest MQ302Min (0010C64A)
			 ; DESCRIPTION: Player has planted the bomb in the Institute and is relaying out, deciding to
			 ; ignore the kid version of Shaun. Sturges is mortified. Player explains calmly that kid is a
			 ; synth.
		elseif eventID == 4
			 ; 001867C2 on quest MQ302Min (0010C64A)
			 ; DESCRIPTION: Player has planted the bomb in the Institute and is relaying out, deciding to
			 ; ignore the kid version of Shaun. Sturgis is mortified. Player asks him if there's a
			 ; problem (standoffish).
			 Trait_Mean()
			 Trait_Violent(0.25)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MQ302Min got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MQ302RR(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MQ302RR
		if eventID == 1
			 ; 001163FC on quest MQ302RR (0010C64C)
			 ; DESCRIPTION: Player is commencing the attack on the Institute with Desdemona. When she
			 ; explains the strategy, the Player is negative about the possible outcome.
			 Trait_Mean(0.25)
		elseif eventID == 2
			 ; 001163FE on quest MQ302RR (0010C64C)
			 ; DESCRIPTION: Player is commencing the attack on the Institute with Desdemona. When she
			 ; explains the strategy, the Player is positive about the possible outcome. 
			 Trait_Nice(0.25)
		elseif eventID == 3
			 ; 00188627 on quest MQ302RR (0010C64C)
			 ; DESCRIPTION: Player has planted the bomb in the Institute and is relaying out, deciding to
			 ; ignore the kid version of Shaun. Tom is mortified. Player explains calmly that kid is a synth.
		elseif eventID == 4
			 ; 0018862B on quest MQ302RR (0010C64C)
			 ; DESCRIPTION: Player has planted the bomb in the Institute and is relaying out, deciding to
			 ; ignore the kid version of Shaun. Tom is mortified. Player says it's none of his damn business.
			 Trait_Mean()
		elseif eventID == 5
			 ; 0018862F on quest MQ302RR (0010C64C)
			 ; DESCRIPTION: Player has planted the bomb in the Institute and is relaying out, deciding to
			 ; ignore the kid version of Shaun. Tom is mortified. Player explains he doesn't have time to
			 ; talk about it.
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MQ302RR got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MS01(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS01
		if eventID == 1
			 ; 00028605 on quest MS01 (000229F6)
			 ; DESCRIPTION: Player has rescued Billy from the fridge. Billy says he wanted to go home.
			 ; Player says he will help.
			 Trait_Nice()
			 Trait_Generous()			 
		elseif eventID == 2
			 ; 00028629 on quest MS01 (000229F6)
			 ; DESCRIPTION: Player has rescued Billy from the fridge. Billy says he wanted to go home.
			 ; Player says his parents are probably dead.
			 Trait_Nice(0.25)
			 Trait_Generous()			 
		elseif eventID == 3
			 ; 0002862C on quest MS01 (000229F6)
			 ; DESCRIPTION: Player has rescued Billy from the fridge. Billy says he wanted to go home.
			 ; Player says he's own his own.
			 Trait_Generous()			 
		elseif eventID == 4
			 ; 00028D86 on quest MS01 (000229F6)
			 ; DESCRIPTION: Someone offers to buy Billy from the Player. Player questions what kind of a
			 ; person they are.
			 Trait_Nice(0.25)
		elseif eventID == 5 || eventID == 11
			 ; 00028D8C on quest MS01 (000229F6)
			 ; DESCRIPTION: Player refused to sell Billy to someone for hard labor.
			 Trait_Nice()
		elseif eventID == 6
			 ; 00028D9C on quest MS01 (000229F6)
			 ; DESCRIPTION: Player is bargaining with someone that wants to buy Billy for hard labor.
			 Trait_Selfish()
		elseif eventID == 7
			 ; 00028DAA on quest MS01 (000229F6)
			 ; DESCRIPTION: The Player just sold Billy to someone that needs him for hard labor.
			 Trait_Mean(3.0)
			 Trait_Selfish()
		elseif eventID == 8
			 ; 00106C78 on quest MS01 (000229F6)
			 ; DESCRIPTION: Player brought Billy home, and Bullet wants to take the entire family and use
			 ; them as slave labor. Player refuses.
			 Trait_Nice()
			 Trait_Generous()			 
		elseif eventID == 9
			 ; 00106C7D on quest MS01 (000229F6)
			 ; DESCRIPTION: Player brought Billy home, and Bullet wants to take the entire family and use
			 ; them as slave labor. Player says he can have them.
			 Trait_Mean(4.0)
		elseif eventID == 10
			 ; 00106C84 on quest MS01 (000229F6)
			 ; DESCRIPTION: Player brought Billy home, and Bullet wants to take the entire family and use
			 ; them as slave labor. Player tries to negotiate to sell the family for caps.
			 Trait_Selfish()
		elseif eventID == 12
			 ; 00106C8A on quest MS01 (000229F6)
			 ; DESCRIPTION: Player brought Billy home, and Bullet wants to take the entire family and use
			 ; them as slave labor. Player tries to bluff.
			 Trait_Nice()
			 Trait_Generous()
			 Trait_Peaceful()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MS01 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MS04(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS04
		if eventID == 1
			 ; 00029B95 on quest MS04 (00027556)
			 ; DESCRIPTION: Player is helping Kent find the Silver Shroud costume. After finding it, Player
			 ; tells Kent he wants to keep for himself.
			 Trait_Mean(0.5)
			 Trait_Selfish()
		elseif eventID == 2
			 ; 0002AACD on quest MS04 (00027556)
			 ; DESCRIPTION: Player is speaking to Kent for first time. He says he's sick of how dark the
			 ; world's become and wants to bring the Silver Shroud to life to help. Player responds
			 ; supportively.
			 Trait_Nice()
		elseif eventID == 3
			 ; 0002AACF on quest MS04 (00027556)
			 ; DESCRIPTION: Player is speaking to Kent for first time. He says he's sick of how dark the
			 ; world's become and wants to bring the Silver Shroud to life to help. Player calls him
			 ; completely nuts.
			 Trait_Mean(0.5)
		elseif eventID == 4
			 ; 0002AAE7 on quest MS04 (00027556)
			 ; DESCRIPTION: Player is speaking to Kent for first time. He says he's sick of how dark the
			 ; world's become and wants to bring the Silver Shroud to life to help. Player humors him by
			 ; saying "Sure, you have a plan."
		elseif eventID == 5
			 ; 0002B8C8 on quest MS04 (00027556)
			 ; DESCRIPTION: After finding Silver Shroud costume, Kent is starting to feel like he can't
			 ; fill the hero's shoes. Player tells him to believe in himself.
			 Trait_Nice()
		elseif eventID == 6
			 ; 0003FEC1 on quest MS04 (00027556)
			 ; DESCRIPTION: As the Silver Shroud, Player is helping Hancock. Hancock is looking to put
			 ; an end to Sinjin, a crime boss. Player tells Hancock that it's his problem.
			 Trait_Mean(0.25)
			 Trait_Selfish()
		elseif eventID == 7
			 ; 00047846 on quest MS04 (00027556)
			 ; DESCRIPTION: Player has rescued Kent after being taken by Sinjin. Kent is down on himself
			 ; for failing to fight crime. Player tells him he should quit.
			 Trait_Mean(0.25)
		elseif eventID == 8
			 ; 0004784E on quest MS04 (00027556)
			 ; DESCRIPTION: Player has rescued Kent after being taken by Sinjin. Kent is down on himself
			 ; for failing to fight crime. Player is supportive.
			 Trait_Nice(0.25)
		elseif eventID == 9
			 ; 0004895E on quest MS04 (00027556)
			 ; DESCRIPTION: HANCOCK ONLY
		elseif eventID == 10
			 ; 00048968 on quest MS04 (00027556)
			 ; DESCRIPTION: 
		elseif eventID == 11
			 ; 000810D7 on quest MS04 (00027556)
			 ; DESCRIPTION: Player is talking to Kent about Pre-War life. When comparing the past to now,
			 ; Player says the Commonwealth is a nightmare.
		elseif eventID == 12
			 ; 000810DA on quest MS04 (00027556)
			 ; DESCRIPTION: Player is talking to Kent about Pre-War life. When comparing the past to now,
			 ; Player says he sees a glimmer of hope among the chaos.
			 Trait_Nice(0.25)
		elseif eventID == 13
			 ; 000DECC1 on quest MS04 (00027556)
			 ; DESCRIPTION: As the Silver Shroud, Player is helping Kent stop AJ, a drug-pusher. AJ tries
			 ; to bribe Player to leave him alone. Player simply asks him to stop.
			 Trait_Nice(0.25)
		elseif eventID == 14
			 ; 000DECCB on quest MS04 (00027556)
			 ; DESCRIPTION: As the Silver Shroud, Player is helping Kent stop AJ, a drug-pusher. AJ tries
			 ; to bribe Player to leave him alone. Player threatens AJ with violence in Shroud's voice.
			 Trait_Nice(0.25)
			 Trait_Peaceful(0.25)
		elseif eventID == 15
			 ; 000DECD5 on quest MS04 (00027556)
			 ; DESCRIPTION: As the Silver Shroud, Player is helping Kent stop AJ, a drug-pusher. Player
			 ; instantly asks for bribe to look other way.
			 Trait_Selfish()
		elseif eventID == 16
			 ; 000DECDC on quest MS04 (00027556)
			 ; DESCRIPTION: As the Silver Shroud, Player is helping Kent stop AJ, a drug-pusher. AJ tries
			 ; to bribe Player to leave him alone. Player takes the bribe.
			 Trait_Mean(0.50)
			 Trait_Selfish()
			 Trait_Peaceful()
		elseif eventID == 17
			 ; 00128CA8 on quest MS04 (00027556)
			 ; DESCRIPTION: Player is facing off with Sinjin who has captured Kent. Sinjin is trying to
			 ; intimidate the Player about it. Player says he doesn't care about Kent, he's here for bounty
			 ; on Sinjin's head.
			 Trait_Selfish()
		elseif eventID == 18
			 ; 00128CB2 on quest MS04 (00027556)
			 ; DESCRIPTION: Player is facing off with Sinjin who has captured Kent. Sinjin is trying to
			 ; intimidate the Player about it. Player stands by Kent saying that having friends is not a
			 ; weakness.
			 Trait_Nice()
		elseif eventID == 19
			 ; 00128CBF on quest MS04 (00027556)
			 ; DESCRIPTION: As the Silver Shroud, Player is helping Kent stop AJ, a drug-pusher. AJ tries
			 ; to bribe Player to leave him alone. Player threatens AJ not as Silver Shroud.
			 Trait_Nice(0.25)
			 Trait_Peaceful(0.25)
		elseif eventID == 20
			 ; 00128CC4 on quest MS04 (00027556)
			 ; DESCRIPTION: Sinjin (who kidnapped Kent) just threatened to kill Kent, then the Player.
			 ; Player threatens him in return in the Shroud's voice.
			 Trait_Nice()
			 Trait_Violence(0.5)
		elseif eventID == 21
			 ; 00128CC5 on quest MS04 (00027556)
			 ; DESCRIPTION: Sinjin (who kidnapped Kent) just threatened to kill Kent, then the Player.
			 ; Player threatens him in return in his own voice.
			 Trait_Nice()
			 Trait_Violence(0.5)
		elseif eventID == 22
			 ; 00128CC8 on quest MS04 (00027556)
			 ; DESCRIPTION: Sinjin (who kidnapped Kent) just threatened to kill Kent, then the Player.
			 ; Player asks Kent what to do, who reminds Player about old episode of Shroud's show.
			 Trait_Nice()
		elseif eventID == 23
			 ; 00128CDF on quest MS04 (00027556)
			 ; DESCRIPTION: Sinjin (who kidnapped Kent) just threatened to kill Kent, then the Player.
			 ; Player asks him to spare Kent.
			 Trait_Nice(2.0)
			 Trait_Peaceful()
		elseif eventID == 24
			 ; 00128CE8 on quest MS04 (00027556)
			 ; DESCRIPTION: Sinjin (who kidnapped Kent) just threatened to kill Kent, then the Player.
			 ; Player tries to scare Sinjin's men to leverage the situation.
			 Trait_Violent(0.25)
		elseif eventID == 25
			 ; 0012935D on quest MS04 (00027556)
			 ; DESCRIPTION: Player is facing off with Kendra after killing her associate, Wayne. Kendra
			 ; threatens Player and Player responds by saying Wayne got what was coming to him.
			 Trait_Mean(0.25)
			 Trait_Violent(0.25)
		elseif eventID == 26
			 ; 00129371 on quest MS04 (00027556)
			 ; DESCRIPTION: Player is facing off with Kendra after killing her associate, Wayne. Kendra
			 ; threatens Player and Player responds by threatening her in the Shroud's voice.
			 Trait_Violent(0.50)
		elseif eventID == 27
			 ; 00129372 on quest MS04 (00027556)
			 ; DESCRIPTION: Player is facing off with Kendra after killing her associate, Wayne. Kendra
			 ; threatens Player and Player responds by threatening her in own voice.
			 Trait_Violent(0.50)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MS04 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MS05B(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS05B
		if eventID == 1
			 ; 001900E1 on quest MS05B (0014B717)
			 ; DESCRIPTION: Player is handing a Deathclaw egg over to Wellingham, the rude robo-butler
			 ; in Diamond City to be cooked into a meal for his clients - gouging for caps
			 Trait_Selfish()
		elseif eventID == 2
			 ; 00182A12 on quest MS05B (0014B717)
			 ; DESCRIPTION: Player is handing a Deathclaw egg over to Wellingham, the rude robo-butler
			 ; in Diamond City to be cooked into a meal for his clients
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MS05B got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MS07a(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS07a
		if eventID == 1
			 ; 000360E4 on quest MS07a (0001CB51)
			 ; DESCRIPTION: Player is hunting a missing person and discovered Doc Crocker has been
			 ; killing people. When confronting him, Player tries to arrest him.
			 Trait_Peaceful()
		elseif eventID == 2
			 ; 000360E8 on quest MS07a (0001CB51)
			 ; DESCRIPTION: Player is hunting a missing person and discovered Doc Crocker has been
			 ; killing people. When confronting him, Player gives up and attacks him.
			 Trait_Violent()
		elseif eventID == 3
			 ; 000360EC on quest MS07a (0001CB51)
			 ; DESCRIPTION: Player is hunting a missing person and discovered Doc Crocker has been
			 ; killing people. When confronting him, Player tries to talk him down calmly.
			 Trait_Nice()
			 Trait_Peaceful()
		elseif eventID == 4
			 ; 0004975C on quest MS07a (0001CB51)
			 ; DESCRIPTION: Player offered Doctor Sun a bribe to let him in the Surgery center basement
		elseif eventID == 5
			 ; 00049761 on quest MS07a (0001CB51)
			 ; DESCRIPTION: The player is threatening a doctor to try and solve a missing persons case
			 Trait_Violent(0.5)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MS07a got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MS09(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS09
		if eventID == 1
			 ; 00072F14 on quest MS09 (00022A00)
			 ; DESCRIPTION: Player is meeting Guard Captain outside Parsons to avenge Ben's death.
			 ;  GC provides intel and the Player responds pleasently.
			 Trait_Nice()
		elseif eventID == 2
			 ; 00072F1A on quest MS09 (00022A00)
			 ; DESCRIPTION: Player is meeting Guard Captain outside Parsons to avenge Ben's death.  GC provides
			 ; intel and the Player responds angry that he's just been standing there waiting for Player to do
			 ; all the work.
			 Trait_Mean()
		elseif eventID == 3
			 ; 00072F1B on quest MS09 (00022A00)
			 ; DESCRIPTION: Guard Captain yells back at Player for situation in Event 01. Player replies with sarcasm.
		elseif eventID == 4
			 ; 00072F22 on quest MS09 (00022A00)
			 ; DESCRIPTION: Player is meeting Guard Captain outside Parsons to avenge Ben's death.  GC provides
			 ; intel and the Player responds neutral.
		elseif eventID == 5
			 ; 00072F23 on quest MS09 (00022A00)
			 ; DESCRIPTION: Guard Captain yells back at Player for situation in Event 01. Player replies with
			 ; a snarky comment.
		elseif eventID == 6
			 ; 00072F2B on quest MS09 (00022A00)
			 ; DESCRIPTION: Guard Captain yells back at Player for situation in Event 01. Player apologizes.
			 Trait_Nice()
		elseif eventID == 7
			 ; 000E973E on quest MS09 (00022A00)
			 ; DESCRIPTION: Player has come to Cabot House for work. He finds Jack to start talking about
			 ; magics and strange theories. Player blows it off and says he's here for the job.
			 Trait_Selfish()
			 Trait_Mean(0.25)
		elseif eventID == 8
			 ; 000E9744 on quest MS09 (00022A00)
			 ; DESCRIPTION: Player has come to Cabot House for work. He finds Jack to start talking about
			 ; magics and strange theories. Player says he'll believe anything if he's paid.
		elseif eventID == 9
			 ; 000E974B on quest MS09 (00022A00)
			 ; DESCRIPTION: Player has come to Cabot House for work. He finds Jack to start talking about
			 ; magics and strange theories. Player acts genuinely interested.
			 Trait_Nice()
		elseif eventID == 10
			 ; 000F06C3 on quest MS09 (00022A00)
			 ; DESCRIPTION: Insult Emogene
			 Trait_Mean()
		elseif eventID == 11
			 ; 000F06D4 on quest MS09 (00022A00)
			 ; DESCRIPTION: Give vial of youth serum to Emogene
		elseif eventID == 12
			 ; 000F494C on quest MS09 (00022A00)
			 ; DESCRIPTION: Kind response to Jack about his dead father
			 Trait_Nice()
		elseif eventID == 13
			 ; 000F4977 on quest MS09 (00022A00)
			 ; DESCRIPTION: Harsh response to Jack about his dead father
			 Trait_Mean()
		elseif eventID == 14
			 ; 00106D51 on quest MS09 (00022A00)
			 ; DESCRIPTION: Harsh to Jack about his father's death
			 Trait_Mean()
		elseif eventID == 15
			 ; 00106D5E on quest MS09 (00022A00)
			 ; DESCRIPTION: Kind to Jack about father's death
			 Trait_Nice()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MS09 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MS11(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS11
		if eventID == 1
			 ; 000570DE on quest MS11 (00022A02)
			 ; DESCRIPTION: Ironsides is lamenting the Constitution's current state. The Player tells
			 ; him he's better off abandoning it.
			 Trait_Mean()
		elseif eventID == 2
			 ; 000570E1 on quest MS11 (00022A02)
			 ; DESCRIPTION: Ironsides is lamenting the Constitution's current state. The Player acts
			 ; supportive.
			 Trait_Nice()
		elseif eventID == 3
			 ; 00096DAB on quest MS11 (00022A02)
			 ; DESCRIPTION: Player has betrayed Ironsides (siding with the scavengers)
			 Trait_Mean()
		elseif eventID == 4
			 ; 00096DB9 on quest MS11 (00022A02)
			 ; DESCRIPTION: Player has backed out of helping the scavengers
			 Trait_Nice()
		elseif eventID == 5
			 ; 00096DD1 on quest MS11 (00022A02)
			 ; DESCRIPTION: Scavengers tricked Player into helping take Ironsides down, so they could scrap
			 ; his ship. Now that it's over, they are doublecrossing Player. Player tries to work it out
			 ; instead of attacking.
			 Trait_Peaceful()
		elseif eventID == 6
			 ; 00096DD2 on quest MS11 (00022A02)
			 ; DESCRIPTION: Scavengers are asking Player to help take Ironsides down, so they could scrap his
			 ; ship. Player declines, defending Ironsides.
			 Trait_Nice()
		elseif eventID == 7
			 ; 00096DDC on quest MS11 (00022A02)
			 ; DESCRIPTION: Player has betrayed Ironsides
			 Trait_Mean()
			 Trait_Selfish()
		elseif eventID == 8
			 ; 00096E40 on quest MS11 (00022A02)
			 ; DESCRIPTION: Scavengers are asking Player to help take Ironsides down, so they could scrap
			 ; his ship. Player agrees.
			 Trait_Violent()
		elseif eventID == 9
			 ; 000A15E4 on quest MS11 (00022A02)
			 ; DESCRIPTION: Player is exploring the Constitution and ran into Ironside's First Mate. He's
			 ; ready to use lethal force. Player says it's a misunderstanding.
			 Trait_Peaceful()
		elseif eventID == 10
			 ; 000A15EE on quest MS11 (00022A02)
			 ; DESCRIPTION: Player is exploring the Constitution and ran into Ironside's First Mate. He's
			 ; ready to use lethal force. Player threatens him in return.
			 Trait_Violent(0.25)
		elseif eventID == 11
			 ; 000A15F8 on quest MS11 (00022A02)
			 ; DESCRIPTION: Player is exploring the Constitution and ran into Ironside's First Mate. He's
			 ; ready to use lethal force. Player asks him to calm down.
			 Trait_Nice()
			 Trait_Peaceful()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MS11 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MS13(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS13
		if eventID == 1 || eventID == 16
			 ; 0003CD79 on quest MS13 (00022A04)
			 ; DESCRIPTION: Paul Pembroke asks player to help him "persuade" Cooke to stop seeing his wife.
			 ; Player declines.
			 Trait_Peaceful()
		elseif eventID == 2
			 ; 0003CD91 on quest MS13 (00022A04)
			 ; DESCRIPTION: Paul Pembroke asks player to help him "persuade" Cooke to stop seeing his wife.
			 ; Player agrees to help.
			 Trait_Nice()
			 Trait_Generous()
		elseif eventID == 3
			 ; 0003D2B8 on quest MS13 (00022A04)
			 ; DESCRIPTION: Paul Pembroke is confronting Cooke in person and has a gun pulled. Player tells
			 ; him to go ahead and fire.
			 Trait_Violent()
		elseif eventID == 4
			 ; 0003D2BE on quest MS13 (00022A04)
			 ; DESCRIPTION: Paul Pembroke is confronting Cooke in person and has a gun pulled. Player appeals
			 ; to Paul to talk it out.
			 Trait_Peaceful()
		elseif eventID == 5
			 ; 0003D2C2 on quest MS13 (00022A04)
			 ; DESCRIPTION: Paul Pembroke is confronting Cooke in person and has a gun pulled. Player tells
			 ; him not to shoot.
			 Trait_Peaceful()
		elseif eventID == 6
			 ; 0003D2C4 on quest MS13 (00022A04)
			 ; DESCRIPTION: Paul Pembroke is confronting Cooke in person and has a gun pulled. Player tells
			 ; everyone to put their guns away.
			 Trait_Peaceful()
		elseif eventID == 7 || eventID == 9
			 ; 00045800 on quest MS13 (00022A04)
			 ; DESCRIPTION: Cooke left town, leaving Player and Paul to split the loot.
			 ; Paul proposes 50-50, Player backs down after trying to get more
			 Trait_Selfish()
			 Trait_Peaceful()
		elseif eventID == 8
			 ; 00045809 on quest MS13 (00022A04)
			 ; DESCRIPTION: Cooke left town, leaving Player and Paul to split the loot. Paul proposes 50-50
			 ; split, Player agrees
			 Trait_Generous()
			 Trait_Peaceful()
		elseif eventID == 10
			 ; 0004581D on quest MS13 (00022A04)
			 ; DESCRIPTION: Cooke left town, leaving Player and Paul to split the loot. Paul proposes 50-50
			 ; split, Player says he wants 70-30.
			 Trait_Selfish()
		elseif eventID == 11
			 ; 00045821 on quest MS13 (00022A04)
			 ; DESCRIPTION: Cooke left town, leaving Player and Paul to split the loot. Paul proposes 50-50
			 ; split, Player says he wants all of it.
			 Trait_Mean()
			 Trait_Selfish(2.0)
		elseif eventID == 12
			 ; 00066E6A on quest MS13 (00022A04)
			 ; DESCRIPTION: Threaten to kill Trish if she doesn't give password
			 Trait_Violent()
		elseif eventID == 13
			 ; 00066E7C on quest MS13 (00022A04)
			 ; DESCRIPTION: Promise to let Trish go if she tells password
		elseif eventID == 14
			 ; 00066EA8 on quest MS13 (00022A04)
			 ; DESCRIPTION: If win speech challenge, Trish goes free
			 Trait_Nice()
		elseif eventID == 15
			 ; 0008159D on quest MS13 (00022A04)
			 ; DESCRIPTION: Paul Pembroke asks player to help him "persuade" Cooke to stop seeing his
			 ; wife. Player declines.
		elseif eventID == 17
			 ; 00198BB4 on quest MS13 (00022A04)
			 ; DESCRIPTION: Let Trish live
			 Trait_Nice()
			 Trait_Peaceful()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MS13 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MS13CookeDies(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS13CookeDies
		if eventID == 2 || eventID == 1
			 ; 0008C144 on quest MS13CookeDies (0008C106)
			 ; DESCRIPTION: Colette (Cooke's daughter) has come to town to investigate her dad's death.
			 ; She's talking to Player. Player lies about it to cover up the killing.
			 Trait_Mean()
		elseif eventID == 4 || eventID == 9 || eventID == 10
			 ; 0008F644 on quest MS13CookeDies (0008C106)
			 ; DESCRIPTION: Colette (Cooke's daughter) has come to town to investigate her dad's death.
			 ; This has Paul Pembroke running scared. Player tries to convince Paul she's not here for revenge.
			 Trait_Nice()
		elseif eventID == 5
			 ; 0008F64C on quest MS13CookeDies (0008C106)
			 ; DESCRIPTION: Colette (Cooke's daughter) has come to town to investigate her dad's death.
			 ; This has Paul Pembroke running scared. Player refuses to kill Colette on Paul's behalf.
			 Trait_Nice()
			 Trait_Peaceful()
		elseif eventID == 7 || eventID == 6 || eventID == 3
			 ; 0008F651 on quest MS13CookeDies (0008C106)
			 ; DESCRIPTION: Colette (Cooke's daughter) has come to town to investigate her dad's death.
			 ; This has Paul Pembroke running scared. Player tries to convince Paul to kill her before
			 ; she kills them.
			 Trait_Violent()
		elseif eventID == 8
			 ; 0008F65D on quest MS13CookeDies (0008C106)
			 ; DESCRIPTION: Colette (Cooke's daughter) has come to town to investigate her dad's death.
			 ; This has Paul Pembroke running scared. Player agrees to kill Colette on Paul's behalf.
			 Trait_Mean()
			 Trait_Violent()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MS13CookeDies got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MS13FindPhoto(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS13FindPhoto
		if eventID == 1 || eventID == 2
			 ; 0008AF43 on quest MS13FindPhoto (000457C6)
			 ; DESCRIPTION: Decline to assassinate Cooke/Latimer
			 Trait_Nice()
			 Trait_Peaceful()
		elseif eventID == 3
			 ; 0008AF4A on quest MS13FindPhoto (000457C6)
			 ; DESCRIPTION: Agree to assassinate Cooke/Latimer
			 Trait_Mean()
			 Trait_Violent()
		elseif eventID == 4
			 ; 0008AF50 on quest MS13FindPhoto (000457C6)
			 ; DESCRIPTION: Agree to assassinate Cooke and/or Latimer
			 Trait_Mean()
			 Trait_Violent()
		elseif eventID == 5
			 ; 0008AF64 on quest MS13FindPhoto (000457C6)
			 ; DESCRIPTION: Asking for more to kill Cooke/Latimer
			 Trait_Selfish()
		elseif eventID == 6
			 ; 0008AF65 on quest MS13FindPhoto (000457C6)
			 ; DESCRIPTION: Asking for more to kill Cooke or Latimer (only 1 is still alive)
			 Trait_Selfish(0.5)
		elseif eventID == 7 || eventID == 8
			 ; 0008B6A9 on quest MS13FindPhoto (000457C6)
			 ; DESCRIPTION: Player agrees to give incriminating photo to Cooke if he gets paid.
			 Trait_Selfish()
			 Trait_Mean(0.25)
		elseif eventID == 9
			 ; 0008B6D5 on quest MS13FindPhoto (000457C6)
			 ; DESCRIPTION: Give photo without asking for money for it
			 Trait_Generous()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MS13FindPhoto got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MS13NelsonDies(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS13NelsonDies
		if eventID == 1
			 ; 000825B5 on quest MS13NelsonDies (00082579)
			 ; DESCRIPTION: Haggle for more money for agreeing to murder someone
			 Trait_Selfish()
		elseif eventID == 2
			 ; 000838D5 on quest MS13NelsonDies (00082579)
			 ; DESCRIPTION: Apologize for killing Nelson
			 Trait_Nice()
		elseif eventID == 3
			 ; 000838DE on quest MS13NelsonDies (00082579)
			 ; DESCRIPTION: Harsh reply to Nelson's father about his death
			 Trait_Mean()
		elseif eventID == 4
			 ; 000838EE on quest MS13NelsonDies (00082579)
			 ; DESCRIPTION: Neutral-ish response to father about Nelson's death
		elseif eventID == 5
			 ; 00083F42 on quest MS13NelsonDies (00082579)
			 ; DESCRIPTION: Haggle for more money to kill Marowski
			 Trait_Selfish()
		elseif eventID == 6 || eventID == 7
			 ; 00083F47 on quest MS13NelsonDies (00082579)
			 ; DESCRIPTION: Refuse to murder Marowski
			 Trait_Nice()
			 Trait_Peaceful()
		elseif eventID == 8
			 ; 00083F53 on quest MS13NelsonDies (00082579)
			 ; DESCRIPTION: Agree to murder Marowski for money
			 Trait_Mean()
			 Trait_Selfish()
		elseif eventID == 9
			 ; 00084478 on quest MS13NelsonDies (00082579)
			 ; DESCRIPTION: Haggle for more money for murdering Paul
			 Trait_Selfish()
		elseif eventID == 10
			 ; 00084479 on quest MS13NelsonDies (00082579)
			 ; DESCRIPTION: Player lies and blames someone else for killing Nelson
			 Trait_Mean(0.25)
			 Trait_Selfish(0.25)
		elseif eventID == 11
			 ; 0008447D on quest MS13NelsonDies (00082579)
			 ; DESCRIPTION: Refuse to murder Paul
			 Trait_Peaceful()
		elseif eventID == 12
			 ; 0008447E on quest MS13NelsonDies (00082579)
			 ; DESCRIPTION: Player lies and blames someone else for killing Nelson
			 Trait_Mean(0.25)
			 Trait_Selfish(0.25)
		elseif eventID == 13
			 ; 00084482 on quest MS13NelsonDies (00082579)
			 ; DESCRIPTION: Agree to murder Paul
			 Trait_Violent()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MS13NelsonDies got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MS13PaulDies(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS13PaulDies
		if eventID == 1
			 ; 0008C143 on quest MS13PaulDies (0008806F)
			 ; DESCRIPTION: Cheat Darcy out of her cut of the photo blackmail
			 Trait_Mean(0.25)
			 Trait_Selfish(0.25)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MS13PaulDies got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MS14(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS14
		if eventID == 1
			 ; 00047135 on quest MS14 (00022A05)
			 ; DESCRIPTION: Player is trying to talk Travis into picking a fight to stand up for myself.
			 ; Player is insulting him.
			 Trait_Mean()
		elseif eventID == 2
			 ; 0004714C on quest MS14 (00022A05)
			 ; DESCRIPTION: Player is trying to talk Travis into picking a fight to stand up for myself.
			 ; Player is being supportive.
			 Trait_Nice()
		elseif eventID == 3
			 ; 000E2E52 on quest MS14 (00022A05)
			 ; DESCRIPTION: Player is going into brewery to rescue Vadim with Travis who is nervous.
			 ; Player says we'll be fine.
			 Trait_Nice()
		elseif eventID == 4
			 ; 000E2E56 on quest MS14 (00022A05)
			 ; DESCRIPTION: Player is going into brewery to rescue Vadim with Travis who is nervous.
			 ; Player says it's not likely he'll survive.
			 Trait_Mean()
		elseif eventID == 5
			 ; 000E2E5C on quest MS14 (00022A05)
			 ; DESCRIPTION: Player is going into brewery to rescue Vadim with Travis who is nervous.
			 ; Player says to stay cool.
		elseif eventID == 6
			 ; 000E355D on quest MS14 (00022A05)
			 ; DESCRIPTION: Player rescued Vadim. Vadim thanks Player. Player calls him an idiot
			 ; for getting involved with kidnappers in first place.
			 Trait_Mean()
		elseif eventID == 7
			 ; 000E355F on quest MS14 (00022A05)
			 ; DESCRIPTION: Player rescued Vadim. Vadim thanks Player. Player is nice about it.
			 Trait_Nice()
		elseif eventID == 8
			 ; 000E4461 on quest MS14 (00022A05)
			 ; DESCRIPTION: Player is wrapping up with Travis. Travis is thanking Player and says
			 ; he learned a lot. Player is mean to him.
			 Trait_Mean()
		elseif eventID == 9
			 ; 000E4464 on quest MS14 (00022A05)
			 ; DESCRIPTION: Player is wrapping up with Travis. Travis is thanking Player and says he learned
			 ; a lot. Player is nice.
			 Trait_Nice()
		elseif eventID == 10
			 ; 000E446B on quest MS14 (00022A05)
			 ; DESCRIPTION: Player is wrapping up with Travis. Travis is thanking Player and says he learned
			 ; a lot. Player is neutral about it.
		elseif eventID == 11
			 ; 000E7630 on quest MS14 (00022A05)
			 ; DESCRIPTION: Vadim says that Travis is an awful DJ and should be killed. Player is
			 ; indifferent about it.
			 Trait_Violent(0.25)
			 Trait_Mean(0.25)
		elseif eventID == 12
			 ; 000E7638 on quest MS14 (00022A05)
			 ; DESCRIPTION: Vadim says that Travis is an awful DJ and should be killed.
			 ; Player is surprised/concerned.
			 Trait_Nice()
		elseif eventID == 13
			 ; 000E7644 on quest MS14 (00022A05)
			 ; DESCRIPTION: Vadim says that Travis is an awful DJ and should be killed. Player agrees.
			 Trait_Violent(0.25)
		elseif eventID == 14
			 ; 000E764D on quest MS14 (00022A05)
			 ; DESCRIPTION: Vadim says that Travis is an awful DJ and should be killed. Player disagrees.
			 Trait_Nice(0.25)
			 Trait_Peaceful(0.25)
		elseif eventID == 15
			 ; 000EAD36 on quest MS14 (00022A05)
			 ; DESCRIPTION: Vadim asks if the Player's ever been in a bar fight. Player answers that he can
			 ; hold his own.
		elseif eventID == 16
			 ; 000EAD43 on quest MS14 (00022A05)
			 ; DESCRIPTION: Vadim asks if the Player's ever been in a bar fight. Player says he's not thug
			 ; and wouldn't do that.
			 Trait_Peaceful()
		elseif eventID == 17
			 ; 000EAD4F on quest MS14 (00022A05)
			 ; DESCRIPTION: Vadim asks if the Player's ever been in a bar fight. Player says he has.
			 Trait_Violent(0.50)
		elseif eventID == 18
			 ; 000EAE7B on quest MS14 (00022A05)
			 ; DESCRIPTION: Player is threatning Scarlett with violence if she doesn't spend time with Travis.
			 Trait_Violent()
		elseif eventID == 19
			 ; 000F935E on quest MS14 (00022A05)
			 ; DESCRIPTION: Travis found out Vadim got kidnapped. He's taking the blame on himself. Player
			 ; says why they took Vadim doesn't matter, but getting him back does.
			 Trait_Nice()
		elseif eventID == 20
			 ; 000F9364 on quest MS14 (00022A05)
			 ; DESCRIPTION: Travis found out Vadim got kidnapped. He's taking the blame on himself. Player says
			 ; it's totally his fault.
			 Trait_Mean()
		elseif eventID == 21
			 ; 000F9369 on quest MS14 (00022A05)
			 ; DESCRIPTION: Travis found out Vadim got kidnapped. He's taking the blame on himself. Player says it's
			 ; not his fault.
			 Trait_Nice()
		elseif eventID == 22
			 ; 000F9371 on quest MS14 (00022A05)
			 ; DESCRIPTION: Travis found out Vadim got kidnapped. He's taking the blame on himself. Player says what
			 ; does it matter.
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MS14 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MS16(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS16
		if eventID == 1
			 ; 0005210C on quest MS16 (00022A07)
			 ; DESCRIPTION: Player asked for bigger share of the caps after the Big Dig heist.
			 Trait_Selfish()
		elseif eventID == 2
			 ; 0011A0ED on quest MS16 (00022A07)
			 ; DESCRIPTION: Player haggled for more caps.
			 Trait_Selfish()
		elseif eventID == 3
			 ; 0011A0F0 on quest MS16 (00022A07)
			 ; DESCRIPTION: Player accepted sketchy job offer from crime boss Bobbi No Nose.
			 Trait_Generous()
			 Trait_Mean(0.25)
		elseif eventID == 4
			 ; 0011E4A0 on quest MS16 (00022A07)
			 ; DESCRIPTION: Player bribed a Diamond City guard. 
			 Trait_Generous()
			 Trait_Peaceful()
		elseif eventID == 5
			 ; 0011E4B0 on quest MS16 (00022A07)
			 ; DESCRIPTION: Player threatened a Diamond City Guard. 
			 Trait_Violent()
		elseif eventID == 6
			 ; 001277CC on quest MS16 (00022A07)
			 ; DESCRIPTION: Player decided to betray Bobbi and not steal from Hancock. Player kills Bobbi.
		elseif eventID == 7
			 ; 001277D2 on quest MS16 (00022A07)
			 ; DESCRIPTION: Player decided to stick with Bobbi and steal from Hancock.
		elseif eventID == 8
			 ; 001277E0 on quest MS16 (00022A07)
			 ; DESCRIPTION: Player talked Bobbi out of stealing from Hancock
			 Trait_Nice()
			 Trait_Peaceful()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MS16 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MS17(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS17
		if eventID == 1
			 ; 0001DBB6 on quest MS17 (00022A08)
			 ; DESCRIPTION: Player is splitting the loot with Honest Dan after dealing with Stockton's
			 ; daughter. Player demands a larger cut.
			 Trait_Selfish()
		elseif eventID == 2
			 ; 00053792 on quest MS17 (00022A08)
			 ; DESCRIPTION: Player has met Honest Dan and he asks if Player is from around here. Player
			 ; lies and says he's from Covenant.
		elseif eventID == 3 || eventID == 5
			 ; 00054AED on quest MS17 (00022A08)
			 ; DESCRIPTION: Player is at gate to Covenant. When asked by Manny why he's there, Player tells
			 ; truth and says he's looking for Stockton's caravan survivors (even though that's a dangerous
			 ; move)
			 Trait_Nice(0.25)
		elseif eventID == 4
			 ; 00054B01 on quest MS17 (00022A08)
			 ; DESCRIPTION: Player is telling Honest Dan what happened to caravan. Dan wants to hit up
			 ; compound, Player says let's do it.
			 Trait_Nice()
			 Trait_Violent()
		elseif eventID == 6
			 ; 00054B04 on quest MS17 (00022A08)
			 ; DESCRIPTION: Player is telling Honest Dan what happened to caravan. Dan wants to hit up
			 ; compound, Player says no deal.
			 Trait_Mean()
			 Trait_Peaceful()
		elseif eventID == 7
			 ; 000EEC44 on quest MS17 (00022A08)
			 ; DESCRIPTION: Player is speaking to Doctor Chambers about hanging on to Stockton's synth.
			 ; Chambers wants to pay off Player to look the other way. Player takes the deal. 
			 Trait_Mean()
			 Trait_Selfish()
		elseif eventID == 8
			 ; 000EEC55 on quest MS17 (00022A08)
			 ; DESCRIPTION: Player is speaking to Doctor Chambers about hanging on to Stockton's synth.
			 ; Chambers wants to pay off Player to look the other way. Player refuses deal.
			 Trait_Nice()
			 Trait_Generous()
		elseif eventID == 9
			 ; 000EEC58 on quest MS17 (00022A08)
			 ; DESCRIPTION: Player is at compound gate talking to Manny, who won't let him in. Player
			 ; threatens Manny with violence.
			 Trait_Violent()
		elseif eventID == 10
			 ; 000EEC5C on quest MS17 (00022A08)
			 ; DESCRIPTION: Jacob Orden wants Player to ignore the investigation. Player accepts the bribe
			 ; that's offered.
			 Trait_Mean()
			 Trait_Selfish()
		elseif eventID == 11
			 ; 000EEC6D on quest MS17 (00022A08)
			 ; DESCRIPTION: Player is at compound gate talking to Manny, who won't let him in. ; Player tries to negotiate his way in peacefully.
			 Trait_Mean()
			 Trait_Selfish()
		elseif eventID == 12
			 ; 000EEC71 on quest MS17 (00022A08)
			 ; DESCRIPTION: Jacob Orden wants Player to ignore the investigation. Player rejects ; ; the bribe  that's offered.
			 Trait_Nice()
			 Trait_Generous()
		elseif eventID == 13
			 ; 000EEC8A on quest MS17 (00022A08)
			 ; DESCRIPTION: Jacob Orden wants Player to ignore the investigation. Player tries to compromise.
			 Trait_Peaceful()
		elseif eventID == 14
			 ; 0012AC59 on quest MS17 (00022A08)
			 ; DESCRIPTION: Doctor Chambers is going to dispose of Amelia Stockton. She offers a bribe if
			 ; Player lets her do it. Player makes a plea to save her life instead.
			 Trait_Mean(0.25)
			 Trait_Peaceful()
		elseif eventID == 15
			 ; 0012AC5A on quest MS17 (00022A08)
			 ; DESCRIPTION: In talking with Doctor Chambers the player says 
			 ;"Someone needs to destroy the Institute".
			 Trait_Violent()
		elseif eventID == 16
			 ; 0012AC69 on quest MS17 (00022A08)
			 ; DESCRIPTION: Doctor Chambers is going to dispose of Amelia Stockton. She offers a bribe if
			 ; Player lets her do it. Player rejects it.
			 Trait_Nice()
			 Trait_Generous()
		elseif eventID == 17
			 ; 0012AC6D on quest MS17 (00022A08)
			 ; DESCRIPTION: Doctor Chambers wants to exterminate synths. Player is horrified.
			 Trait_Nice()
			 Trait_Peaceful()
		elseif eventID == 18
			 ; 0012AC7A on quest MS17 (00022A08)
			 ; DESCRIPTION: Doctor Chambers is going to dispose of Amelia Stockton. 
			 ; She offers a bribe if Player lets her do it. Player takes it.
			 Trait_Mean()
			 Trait_Violent()
			 Trait_Selfish()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MS17 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_MS19(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS19
		if eventID == 1 || eventID == 4
			 ; 0002BE37 on quest MS19 (00022A0A)
			 ; DESCRIPTION: Player has a cure for a unique molerat disease in hand. 
			 ; There's only one dose. A kid in a Vault needs the cure, or he'll die. 
			 ; Player refuses to give it to kid
			 Trait_Mean()
			 Trait_Selfish()
		elseif eventID == 2
			 ; 0002BE57 on quest MS19 (00022A0A)
			 ; DESCRIPTION: Player has a cure for a unique molerat disease in hand. There's 
			 ; only one dose. A kid in a Vault needs the cure, or he'll die. Player wants 
			 ; to split the dose between himself and the kid
			 Trait_Mean()
			 Trait_Selfish()
		elseif eventID == 3
			 ; 0002BE59 on quest MS19 (00022A0A)
			 ; DESCRIPTION: Player has a cure for a unique molerat disease in hand. There's 
			 ; only one dose. A kid in a Vault needs the cure, or he'll die. Player gives it 
			 ; to kid and suffers a permanent health debuff
			 Trait_Nice(2.0)
			 Trait_Generous(2.0)
			 Trait_Peaceful()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_MS19 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_REAssaultSC01_DN123SkylanesAssault(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == REAssaultSC01_DN123SkylanesAssault
		if eventID == 1
			 ; 000CB1FC on quest REAssaultSC01_DN123SkylanesAssault (00047917)
			 ; DESCRIPTION: Player was perceptive, noticed something odd.
		elseif eventID == 2
			 ; 000CB205 on quest REAssaultSC01_DN123SkylanesAssault (00047917)
			 ; DESCRIPTION: Player doesn't haggle for a better reward.
		elseif eventID == 3 || eventID == 4
			 ; 000CB210 on quest REAssaultSC01_DN123SkylanesAssault (00047917)
			 ; DESCRIPTION: Player haggles for a better reward.
			 Trait_Selfish(0.25)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_REAssaultSC01_DN123SkylanesAssault got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_RECampLC01(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RECampLC01
		if eventID == 1
			 ; 001D1A67 on quest RECampLC01 (00190547)
			 ; DESCRIPTION: Player is attacking the captors of a runwaway Synth
			 Trait_Violent(0.50)
		elseif eventID == 2
			 ; 00190591 on quest RECampLC01 (00190547)
			 ; DESCRIPTION: Player attacks a Synth captive he/she just rescued
			 Trait_Violent()
		elseif eventID == 3
			 ; 00190593 on quest RECampLC01 (00190547)
			 ; DESCRIPTION: Player is trying to free a Synth from execution without violence
			 Trait_Peaceful()
		elseif eventID == 4
			 ; 001D1A66 on quest RECampLC01 (00190547)
			 ; DESCRIPTION: Player is attacking the captors of a man who has begged the 
			 ; player to help him (Player doesn't know he's a Synth)
			 Trait_Nice(0.50)
		elseif eventID == 5
			 ; 0019059E on quest RECampLC01 (00190547)
			 ; DESCRIPTION: Player agrees that a Synth captive should be executed
			 Trait_Mean(0.50)
			 Trait_Violent(0.50)
		elseif eventID == 6
			 ; 001905AE on quest RECampLC01 (00190547)
			 ; DESCRIPTION: Player threatens violence against a pair of hostage takers 
			 ; threatening to kill a Synth
			 Trait_Violent(0.50)
		elseif eventID == 7
			 ; 001D1A65 on quest RECampLC01 (00190547)
			 ; DESCRIPTION: Player is not getting involved in the execution of a runaway Synth
			 Trait_Mean(0.25)
		elseif eventID == 8
			 ; 001905CF on quest RECampLC01 (00190547)
			 ; DESCRIPTION: Player extorts money out of a Synth captive he just rescued.
			 Trait_Selfish()
		elseif eventID == 9
			 ; 001905D4 on quest RECampLC01 (00190547)
			 ; DESCRIPTION: Player attempts to negotiate the release of a Synth who is 
			 ; about to be executed
			 Trait_Nice(0.50)
			 Trait_Peaceful()
		elseif eventID == 10
			 ; 0019D2F3 on quest RECampLC01 (00190547)
			 ; DESCRIPTION: Player threatens violence against a pair of hostage takers 
			 ; threatening to kill a Synth
			 Trait_Nice(0.50)
			 Trait_Violent(0.25)
		elseif eventID == 11
			 ; 0019D2F5 on quest RECampLC01 (00190547)
			 ; DESCRIPTION: Player is trying to free a Synth from execution without violence
			 Trait_Nice(0.50)
			 Trait_Peaceful()
		elseif eventID == 12
			 ; 001D1A64 on quest RECampLC01 (00190547)
			 ; DESCRIPTION: Player has stumbled across a two people threatening to execute 
			 ; someone and has decided to not get involved (player doesn't know the man is 
			 ; a Synth)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_RECampLC01 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_RESceneLC01(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RESceneLC01
		if eventID == 1
			 ; 001D03E5 on quest RESceneLC01 (0017E729)
			 ; DESCRIPTION: Player has come across two men with the same face, both claiming the
			 ; other is a Synth. The player encouraged one man to execute the other, despite not 
			 ; knowing who is actually the Synth
			 Trait_Mean()
			 Trait_Violent()
		elseif eventID == 2
			 ; 001D03E4 on quest RESceneLC01 (0017E729)
			 ; DESCRIPTION: Player has come across two men with the same face, both claiming 
			 ; the other is a Synth. The player has uncovered which is the Synth and encouraged the ; Synth's execution
		elseif eventID == 3
			 ; 001D03E3 on quest RESceneLC01 (0017E729)
			 ; DESCRIPTION: Player has come across two men with the same face, both claiming 
			 ; the other is a Synth. Player has uncovered who is the Institute Synth and has 
			 ; decided to attack the other man
			 Trait_Violent()
		elseif eventID == 4
			 ; 0017E763 on quest RESceneLC01 (0017E729)
			 ; DESCRIPTION: Player has come across two men with the same face, both claiming 
			 ; the other is a Synth. One has a gun to the other's head. Player has decided
			 ; to not intervene in the execution (Player doesn't know who the Synth is)
		elseif eventID == 5
			 ; 001D03E2 on quest RESceneLC01 (0017E729)
			 ; DESCRIPTION: Player has come across two men with the same face, both claiming 
			 ; the other is a Synth. Player attacks the man holding the gun, not knowing who 
			 ; the Synth actually is
			 Trait_Nice(0.25)
			 Trait_Violent(0.25)
		elseif eventID == 6
			 ; 001D03E6 on quest RESceneLC01 (0017E729)
			 ; DESCRIPTION: Player has come across two men with the same face, both claiming 
			 ; the other is a Synth. Player encourages one man to execute the other, not 
			 ; knowing who is the Synth
			 Trait_Mean()
			 Trait_Violent()
		elseif eventID == 7
			 ; 0018007A on quest RESceneLC01 (0017E729)
			 ; DESCRIPTION: Player attempts to find a peaceful solution with a man pointing a 
			 ; gun at suspected Synth working for the Institute
			 Trait_Peaceful()
		elseif eventID == 8
			 ; 001C40B6 on quest RESceneLC01 (0017E729)
			 ; DESCRIPTION: Player has come across two men with the same face, both claiming
			 ; the other is a Synth. Player has uncovered who is the Institute Synth and 
			 ; has decided to attack the other man
		elseif eventID == 9
			 ; 001D03E7 on quest RESceneLC01 (0017E729)
			 ; DESCRIPTION: Player has come across two men with the same face, both claiming 
			 ; the other is a Synth. Player has uncovered which is the Synth and encourages 
			 ; the man to execute him
			 Trait_Peaceful()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_RESceneLC01 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_RETravelKMK_BoSM02(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RETravelKMK_BoSM02
		if eventID == 1
			 ; 00162AB2 on quest RETravelKMK_BoSM02 (0014DC84)
			 ; DESCRIPTION: Player repeats the Brotherhood line against Ghouls; they all need to die.
			 ; Kind of cruel; the NPC vehemently disagrees and has lost everything because 
			 ; he's held to his beliefs.
			 Tweak_Mean()
			 Tweak_Violent(0.50)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_RETravelKMK_BoSM02 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_RETravelSC01_DN123SkylanesPointer(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RETravelSC01_DN123SkylanesPointer
		if eventID == 1 || eventID == 3 || eventID == 4
			 ; 000CAB3C on quest RETravelSC01_DN123SkylanesPointer (000684D1)
			 ; DESCRIPTION: Player has out-scammed someone who would have scammed him.
		elseif eventID == 2
			 ; 000CAB42 on quest RETravelSC01_DN123SkylanesPointer (000684D1)
			 ; DESCRIPTION: Player accepts a lowball offer for a job without even trying to haggle.
			 Tweak_Generous()
		elseif eventID == 5
			 ; 000CAB7F on quest RETravelSC01_DN123SkylanesPointer (000684D1)
			 ; DESCRIPTION: Player challenges for a better reward. The first offer was insulting.
			 Tweak_Selfish()

		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_RETravelSC01_DN123SkylanesPointer got event from wrong quest " + eventQuest)
	endif
endFunction

; I had trouble with these because they really do depend on if you see synths as
; human or machine. My take: If there are organic, biological elements to the brain... cells 
; based on stem cells, etc... then I would see them as living organic creatures. But 
; if the brain was inorganic or made of an inorganic material, then I would say they
; are really good immitations of humans, but not technically human. Since those details 
; aren't revealed to us, either viewpoint is valid so I don't fault people for their
; "take". Instead I focus on the violence/non-violence non-synth related aspects of the
; answer.  
function HandleDialogueBump_RR101(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RR101
		if eventID == 2 || eventID == 1
			 ; 0006E3A7 on quest RR101 (000459D2)
			 ; DESCRIPTION: Desdemona asks if Player would risk his life 
			 ; to save a synth. Player says yes.
		elseif eventID == 3
			 ; 0006E406 on quest RR101 (000459D2)
			 ; DESCRIPTION: Player agrees that Instutute needs to go. 
			 ; Player says his motivation is revenge for what they did
			 ; to his family.
			 Tweak_Violent(0.25)
		elseif eventID == 4
			 ; 0006E417 on quest RR101 (000459D2)
			 ; DESCRIPTION: Desdemona is talking to Player about 
			 ; Institute treating synths like slaves. Player disagrees… 
			 ; synths are machines.
		elseif eventID == 5
			 ; 0006E432 on quest RR101 (000459D2)
			 ; DESCRIPTION: Player agrees that Instutute needs to go. 
			 ; Player says his motivation is so they can't hurt anyone else.
			 Tweak_Nice(0.25)
			 Tweak_Peaceful(0.25)
		elseif eventID == 6
			 ; 0006E43F on quest RR101 (000459D2)
			 ; DESCRIPTION: Desdemona asks if Player would risk his life to save a synth. Player says no.
		elseif eventID == 7
			 ; 0006E447 on quest RR101 (000459D2)
			 ; DESCRIPTION: Desdemona is talking to Player about Institute treating synths 
			 ; like slaves. Player agrees.
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_RR101 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_RR102(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RR102
		if eventID == 1
			 ; 000729BD on quest RR102 (0006FA37)
			 ; DESCRIPTION: Player is meeting Ricky Dalton for a mission. Player 
			 ; says he appreciates all that Ricky's done.
			 Tweak_Nice()
		elseif eventID == 2
			 ; 00072A03 on quest RR102 (0006FA37)
			 ; DESCRIPTION: Player is meeting Ricky Dalton for a mission. Ricky is aggitated
			 ; it took so long for help to arrive. Player threatens him in response.
			 Tweak_Violent()
		elseif eventID == 3
			 ; 00072FFD on quest RR102 (0006FA37)
			 ; DESCRIPTION: Ricky has offered to be a distraction so Player can get into 
			 ; Switchboard undetected, which is suicidal. Player says not to do it.
			 Tweak_Nice()
		elseif eventID == 4
			 ; 00073003 on quest RR102 (0006FA37)
			 ; DESCRIPTION: Ricky has offered to be a distraction so Player can get into Switchboard
			 ; undetected, which is suicidal. Player says to do it.
			 Tweak_Mean()
		elseif eventID == 5
			 ; 0007303B on quest RR102 (0006FA37)
			 ; DESCRIPTION: Desdemona is debreifing Player regarding Switchboard. Deacon 
			 ; ends up making Player look better by lying. Player agrees to Deacon's lie.
		elseif eventID == 6
			 ; 00073047 on quest RR102 (0006FA37)
			 ; DESCRIPTION: Desdemona is debreifing Player regarding Switchboard. Deacon 
			 ; ends up making Player look better by lying. Player admits Deacon is lying.
		elseif eventID == 8 || eventID == 7
			 ; 0007B30E on quest RR102 (0006FA37)
			 ; DESCRIPTION: Deacon asks player if he supports Synth freedom. Player says he 
			 ; is against slavery in all forms.
			 Tweak_Nice(0.50)
		elseif eventID == 10 || eventID == 9
			 ; 0007B316 on quest RR102 (0006FA37)
			 ; DESCRIPTION: Deacon asks player if he supports Synth freedom. Player says 
			 ; you can't enslave a machine.
		elseif eventID == 11
			 ; 000E2E24 on quest RR102 (0006FA37)
			 ; DESCRIPTION: Deacon offers Tommy's weapon to Player. Player refuses it.
			 Tweak_Peaceful(0.50)
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_RR102 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_RR302(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RR302
		if eventID == 1
			 ; 0002D10B on quest RR302 (0002C8CB)
			 ; DESCRIPTION: Player and Tom are preparing to assault the Brotherhood, Tom is 
			 ; worried they are being watched as they speak. Player tells him to relax.
			 Tweak_Peaceful()
		elseif eventID == 2
			 ; 0002D14E on quest RR302 (0002C8CB)
			 ; DESCRIPTION: Player and Tom are preparing to assault the Brotherhood, Tom is 
			 ; worried they are being watched as they speak. Player tells him he's paranoid.
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_RR302 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_RR303(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RR303
		if eventID == 1
			 ; 0013FE8A on quest RR303 (00043275)
			 ; DESCRIPTION: Glory is dying. She asks Player to promise he'll free all the synths
			 ; in the Institute. Player leaves her, ignoring her request.
			Cait_Dislikes()
			Codsworth_Hates()
			Curie_Hates()
			Danse_Neutral()
			Deacon_Hates()
			Hancock_Hates()
			MacCready_Dislikes()
			Piper_Hates()
			Preston_Dislikes()
			Strong_Likes()
			Valentine_Hates()
			X688_Neutral()
		elseif eventID == 2
			 ; 0013FE91 on quest RR303 (00043275)
			 ; DESCRIPTION: Glory is dying. She asks Player to promise he'll free all the synths
			 ; in the Institute. Player says "I promise."
			Cait_Likes()
			Codsworth_Likes()
			Curie_Loves()
			Danse_Neutral()
			Deacon_Loves()
			Hancock_Loves()
			MacCready_Likes()
			Piper_Likes()
			Preston_Loves()
			Strong_Likes()
			Valentine_Loves()
			X688_Neutral()
		elseif eventID == 3
			 ; 0013FEA3 on quest RR303 (00043275)
			 ; DESCRIPTION: Glory is dying. She asks Player to promise he'll free all the synths
			 ; in the Institute. Player says "Hold on, you'll live."
			Cait_Likes()
			Codsworth_Likes()
			Curie_Dislikes()
			Danse_Neutral()
			Deacon_Likes()
			Hancock_Likes()
			MacCready_Likes()
			Piper_Likes()
			Preston_Neutral()
			Strong_Likes()
			Valentine_Likes()
			X688_Neutral()

		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_RR303 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_RRM01(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RRM01
		if eventID == 1
			 ; 0005FE6A on quest RRM01 (0005FD90)
			 ; DESCRIPTION: Player meets Stockton. Stockton points out that this is first stop for
			 ; "packages." and delays are bad. Player keeps to the spy lingo.
			Cait_Dislikes()
			Codsworth_Neutral()
			Curie_Neutral()
			Danse_Dislikes()
			Deacon_Likes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Dislikes()
			Valentine_Neutral()
			X688_Neutral()
		elseif eventID == 2
			 ; 0005FE76 on quest RRM01 (0005FD90)
			 ; DESCRIPTION: Player makes a rude comment to HighRise at Ticonderoga.
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Likes()
			Deacon_Hates()
			Hancock_Neutral()
			MacCready_Likes()
			Piper_Dislikes()
			Preston_Neutral()
			Strong_Neutral()
			Valentine_Dislikes()
			X688_Likes()
		elseif eventID == 3
			 ; 0005FE8A on quest RRM01 (0005FD90)
			 ; DESCRIPTION: Player meets Stockton. Stockton points out that this is first stop for
			 ; "packages." and delays are bad. Player doesn't like the subtle tone.
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Neutral()
			Danse_Hates()
			Deacon_Dislikes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Likes()
			Valentine_Neutral()
			X688_Neutral()
		elseif eventID == 4
			 ; 0005FE8C on quest RRM01 (0005FD90)
			 ; DESCRIPTION: Player gets to Ticonderoga and gives proper password to HighRise.
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Neutral()
			Danse_Neutral()
			Deacon_Likes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Neutral()
			Valentine_Neutral()
			X688_Neutral()
		elseif eventID == 5
			 ; 0005FEA9 on quest RRM01 (0005FD90)
			 ; DESCRIPTION: Player meets Stockton. Stockton points out that this is first stop for
			 ; "packages." and delays are bad. Player agrees.
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Neutral()
			Danse_Neutral()
			Deacon_Likes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Likes()
			Valentine_Neutral()
			X688_Likes()
		elseif eventID == 6
			 ; 00112EAC on quest RRM01 (0005FD90)
			 ; DESCRIPTION: Player is getting mission from Carrington. Carrington says Stockton needs
			 ; help with a runaway synth, but demeans Stockton's paranoia in the process. Player tries
			 ; to defend Stockton.
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Likes()
			Danse_Neutral()
			Deacon_Likes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Likes()
			Strong_Likes()
			Valentine_Likes()
			X688_Neutral()
		elseif eventID == 7
			 ; 00112EC7 on quest RRM01 (0005FD90)
			 ; DESCRIPTION: Player is getting mission from Carrington. Carrington says Stockton needs help
			 ; with a runaway synth, but demeans Stockton's paranoia in the process. Player says it sounds
			 ; like an important mission.
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Neutral()
			Danse_Dislikes()
			Deacon_Likes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Likes()
			Valentine_Neutral()
			X688_Neutral()
		elseif eventID == 8
			 ; 00112EE6 on quest RRM01 (0005FD90)
			 ; DESCRIPTION: Player is getting mission from Carrington. Carrington says Stockton needs help
			 ; with a runaway synth, but demeans Stockton's paranoia in the process. Player asks why Stockton
			 ; hates everyone.
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Likes()
			Hancock_Likes()
			MacCready_Neutral()
			Piper_Neutral()
			Preston_Dislikes()
			Strong_Neutral()
			Valentine_Neutral()
			X688_Neutral()

		elseif eventID == 9
			 ; 00112EBF on quest RRM01 (0005FD90)
			 ; DESCRIPTION: Player mentioned that Deacon taught him the callsign. Basically, Player is standing
			 ; up for Deacon
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Neutral()
			Danse_Hates()
			Deacon_Likes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Neutral()
			Valentine_Neutral()
			X688_Neutral()
		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_RRM01 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_RRM02(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RRM02
		if eventID == 1
			 ; 000A8BFA on quest RRM02 (000A8BAF)
			 ; DESCRIPTION: Player is upset they didn't get to say goodbye to H2-22 before Amari wiped his memory.
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Likes()
			Danse_Hates()
			Deacon_Loves()
			Hancock_Neutral()
			MacCready_Dislikes()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Dislikes()
			Valentine_Likes()
			X688_Neutral()

		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_RRM02 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_RRR02a(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RRR02aQuest
		if eventID == 1
			 ; 000B3EAD on quest RRR02a (000B3E82)
			 ; DESCRIPTION: Player scolds a fellow Railroad agent for being a coward.
			Cait_Likes()
			Codsworth_Neutral()
			Curie_Dislikes()
			Danse_Likes()
			Deacon_Hates()
			Hancock_Neutral()
			MacCready_Likes()
			Piper_Dislikes()
			Preston_Neutral()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Likes()

		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_RRR02a got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_RRR05(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RRR05
		if eventID == 1
			 ; 000B92C7 on quest RRR05 (000B926A)
			 ; DESCRIPTION: Player demeans Desdemona's "hare-brained scheme" of letting Tinker Tom
			 ; set up atmospheric sensors to look for Institute spy devices.
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Loves()
			Deacon_Dislikes()
			Hancock_Neutral()
			MacCready_Likes()
			Piper_Dislikes()
			Preston_Neutral()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Neutral()
		elseif eventID == 2
			 ; 000B92D3 on quest RRR05 (000B926A)
			 ; DESCRIPTION: Humoring the crazy guy
			Cait_Dislikes()
			Codsworth_Neutral()
			Curie_Neutral()
			Danse_Hates()
			Deacon_Likes()
			Hancock_Neutral()
			MacCready_Dislikes()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Neutral()
			Valentine_Neutral()
			X688_Neutral()

		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_RRR05 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_RRR08(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RRR08
		if eventID == 1
			 ; 0013A44F on quest RRR08 (0013A33D)
			 ; DESCRIPTION: Desdemona is sad about Glory's death. Player says he misses her too.
			Cait_Neutral()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Dislikes()
			Deacon_Loves()
			Hancock_Likes()
			MacCready_Likes()
			Piper_Likes()
			Preston_Neutral()
			Strong_Dislikes()
			Valentine_Likes()
			X688_Dislikes()

		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_RRR08 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_V81_00_Intro(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == V81_00_Intro
		if eventID == 1
			 ; 000B8504 on quest V81_00_Intro (000B8464)
			 ; DESCRIPTION: Player is rude and threatens to get into Vault 81. This choice also turns
			 ; on turrets to fire at the player if they approach the entrance.
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Dislikes()
			Hancock_Neutral()
			MacCready_Likes()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Likes()
		elseif eventID == 2
			 ; 000B8580 on quest V81_00_Intro (000B8464)
			 ; DESCRIPTION: Player says they are from Vault 111 to get into Vault 81.
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Likes()
			Danse_Likes()
			Deacon_Likes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Neutral()
			Strong_Neutral()
			Valentine_Likes()
			X688_Neutral()

		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_V81_00_Intro got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_V81_01(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == V81_01
		if eventID == 1
			 ; 0010C3FE on quest V81_01 (00033520)
			 ; DESCRIPTION: Player wants a child to pay more "money" to find her cat. She's
			 ; technically offering her personal possessions, teddy bear.
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Dislikes()
			Hancock_Dislikes()
			MacCready_Likes()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Neutral()
			Valentine_Dislikes()
			X688_Likes()

		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_V81_01 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleDialogueBump_V81_03(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == V81_03
		if eventID == 1
			 ; 001AC3DA on quest V81_03 (00033527)
			 ; DESCRIPTION: You confront Bobby about his Jet addiction and tell him he's just a waste of
			 ; space, knowing he's in a fragile state of mind. You're being an instigator.

			if Cait_EventCondition_DislikesPlayerTakingChems.GetValue() == 0
				Cait_Likes()
			elseif Cait_EventCondition_DislikesPlayerTakingChems.GetValue() == 1
				Cait_Dislikes()
			endif
			
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Dislikes()
			Hancock_Dislikes()
			MacCready_Likes()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Likes()
		elseif eventID == 2
			 ; 001AC3E6 on quest V81_03 (00033527)
			 ; DESCRIPTION: You confront Bobby about his Jet addiction and tell him he needs to get help.

			if Cait_EventCondition_DislikesPlayerTakingChems.GetValue() == 0
				Cait_Dislikes()
			elseif Cait_EventCondition_DislikesPlayerTakingChems.GetValue() == 1
				Cait_Likes()
			endif
			
			Codsworth_Likes()
			Curie_Likes()
			Danse_Likes()
			Deacon_Likes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Likes()
			Strong_Neutral()
			Valentine_Likes()
			X688_Dislikes()
		elseif eventID == 3
			 ; 001AC3FA on quest V81_03 (00033527)
			 ; DESCRIPTION: You confront Bobby about his Jet addiction and rather than try to help,
			 ; you give him Jet to encourage his addiction.

			if Cait_EventCondition_DislikesPlayerTakingChems.GetValue() == 0
				Cait_Likes()
			elseif Cait_EventCondition_DislikesPlayerTakingChems.GetValue() == 1
				Cait_Dislikes()
			endif
			
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Dislikes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Dislikes()
			Valentine_Dislikes()
			X688_Dislikes()
		elseif eventID == 4
			 ; 001AC48B on quest V81_03 (00033527)
			 ; DESCRIPTION: Tina wants you to help her brother Bobby get help for his Jet addiction.
			 ; You tell her to just let him die. "One less junkie in the Commonwealth."

			if Cait_EventCondition_DislikesPlayerTakingChems.GetValue() == 0
				Cait_Likes()
			elseif Cait_EventCondition_DislikesPlayerTakingChems.GetValue() == 1
				Cait_Hates()
			endif
			
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Hates()
			Hancock_Hates()
			MacCready_Likes()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Likes()
		elseif eventID == 5
			 ; 001AC49A on quest V81_03 (00033527)
			 ; DESCRIPTION: Tina wants you to help her brother Bobby get help for his Jet addiction.
			 ; You agree he needs help.

			if Cait_EventCondition_DislikesPlayerTakingChems.GetValue() == 0
				Cait_Dislikes()
			elseif Cait_EventCondition_DislikesPlayerTakingChems.GetValue() == 1
				Cait_Likes()
			endif
			
			Codsworth_Likes()
			Curie_Likes()
			Danse_Likes()
			Deacon_Likes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Likes()
			Strong_Neutral()
			Valentine_Likes()
			X688_Dislikes()
		elseif eventID == 6
			 ; 001AC4BD on quest V81_03 (00033527)
			 ; DESCRIPTION: Tina wants you to help her brother Bobby get help for his Jet addiction.
			 ; You say he's a lost cause.

			if Cait_EventCondition_DislikesPlayerTakingChems.GetValue() == 0
				Cait_Likes()
			elseif Cait_EventCondition_DislikesPlayerTakingChems.GetValue() == 1
				Cait_Dislikes()
			endif
			
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Dislikes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Likes()

		endif
	else
		 debug.trace(self + " WARNING - HandleDialogueBump_V81_03 got event from wrong quest " + eventQuest)
	endif
endFunction



;********************************************************************************************************
;********************************************************************************************************
;********************************************************************************************************
;********************************************************************************************************
;********************************************************************************************************
;********************************************************************************************************
;************************************ QUEST STAGE BUMPS *************************************************
;********************************************************************************************************
;********************************************************************************************************
;********************************************************************************************************
;********************************************************************************************************
;********************************************************************************************************
;********************************************************************************************************
;********************************************************************************************************
;********************************************************************************************************


function HandleQuestStageBump_BoS200(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == BoS200
		if eventID == 1
		; STAGE 100 on Quest BoS200
		; DESCRIPTION: Officially joined the Brotherhood of Steel.  Some Companions may object to 
		; the Player joining due to the intrinsic nature of the Brotherhood of Steel's view of how
		; life in the Commonwealth should be.
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Likes()
			Danse_Loves()
			Deacon_Hates()
			Hancock_Dislikes()
			MacCready_Likes()
			Piper_Neutral()
			Preston_Dislikes()
			Strong_Hates()
			Valentine_Dislikes()
			X688_Hates()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_BoS200 got event from wrong quest " + eventQuest)
	endif
endFunction


function HandleQuestStageBump_BoS202(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == BoS202
		if eventID == 1
		; STAGE 255 on Quest BoS202
		; Player killed all Super Mutants at Fort Strong, which took a large cache of Fat Man shells out of
		; their hands. Companions may object to extermination of all Super Mutants, or appreciate the fact
		; that the Player helped make the Commonwealth a safer place.
			Cait_Likes()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Loves()
			Deacon_Neutral()
			Hancock_Likes()
			MacCready_Likes()
			Piper_Likes()
			Preston_Loves()
			Strong_Hates()
			Valentine_Likes()
			X688_Likes()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_BoS202 got event from wrong quest " + eventQuest)
	endif
endFunction


function HandleQuestStageBump_BoS203(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == BoS203
		if eventID == 1
		; STAGE 70 on Quest BoS203
		; DESCRIPTION: The Player has been instructed to find Doctor Li and convince her to return to the
		; Brotherhood. They are specifically told not to harm her in any way. If this stage has been set,
		; the Player has ignored the Brotherhood and murdered Doctor Li (which will also kick them out of
		; the Instutute Faction... could have a large rippling affinity effect).
			Cait_Neutral()
			Codsworth_Hates()
			Curie_Hates()
			Danse_Hates()
			Deacon_Hates()
			Hancock_Hates()
			MacCready_Neutral()
			Piper_Hates()
			Preston_Hates()
			Strong_Loves()
			Valentine_Hates()
			X688_Hates()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_BoS203 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_BoS204(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == BoS204
		if eventID == 1 || eventID == 2
		; STAGE 200 or 255 on Quest BoS204
		; DESCRIPTION: Player gave Proctor Ingram (BoS) the holotape containing the stolen Institute data
		; (which will eventually be used to figure out how to attack the Institute).
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Neutral()
			Danse_Loves()
			Deacon_Hates()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Dislikes()
			Strong_Neutral()
			Valentine_Neutral()
			X688_Hates()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_BoS203 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_BoS301(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == BoS301
		if eventID == 1
		; STAGE 75 on Quest BoS301
		; DESCRIPTION: The Player is told to convince Doctor Li to help build Liberty Prime. At this
		; stage, the Player took the opportunity to talk her into it peacefully and without any physical
		; threats of violence.
			Cait_Neutral()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Loves()
			Deacon_Neutral()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Likes()
			Strong_Dislikes()
			Valentine_Likes()
			X688_Dislikes()

		elseif eventID == 2
		; STAGE 76 on Quest BoS301
		; DESCRIPTION: The Player is told to convince Doctor Li to help build Liberty Prime. At this stage,
		; the Player threatened Doctor Li with physical harm if she refused to help. This has a negative
		; effect on Doctor Li's demeanor for the remainder of the game.
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Dislikes()
			Hancock_Dislikes()
			MacCready_Likes()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Neutral()

		elseif eventID == 3
		; STAGE 176 on Quest BoS301
		; DESCRIPTION: The Player needed to bypass a Child of Atom in order to complete a portion of his
		; mission. At this stage, the Player was able to talk his way through without any violence, leaving
		; the Child of Atom (who is not hostile) alive.
			Cait_Dislikes()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Neutral()
			Deacon_Neutral()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Likes()
			Strong_Dislikes()
			Valentine_Likes()
			X688_Neutral()

		elseif eventID == 4
		; STAGE 178 on Quest BoS301
		; DESCRIPTION: The Player needed to bypass a Child of Atom in order to complete a portion of his
		; mission. At this stage, the Player killed the Child of Atom instead of resolving the situation
		; diplomatically.
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Likes()
			Hancock_Likes()
			MacCready_Neutral()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Neutral()

		elseif eventID == 5
		; STAGE 255 on Quest BoS301
		; DESCRIPTION: The Player helped complete the construction of Liberty Prime. Companions may either
		; support or object to the Player putting a huge war machine in the hands of the Brotherhood of Steel.
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Likes()
			Danse_Loves()
			Deacon_Hates()
			Hancock_Likes()
			MacCready_Likes()
			Piper_Neutral()
			Preston_Dislikes()
			Strong_Dislikes()
			Valentine_Neutral()
			X688_Hates()	
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_BoS301 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_BoS302(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == BoS302
		if eventID == 1
		; STAGE 120 on Quest BoS302
		; DESCRIPTION: The Player is sent to execute Paladin Danse, because it's been revealed that Paladin
		; Danse is a synth. At this stage, the Player has approached Danse and found him in a virtually
		; suicidal state, believing he should die (that his Brotherhood roots run deeper than his synth
		; identity). The Player makes an appeal to Danse that his death would serve no useful purpose, and
		; he has a right to live. This results in Danse agreeing with the Player and they try to leave the
		; bunker together.
			Cait_Dislikes()
			Codsworth_Loves()
			Curie_Likes()
			Danse_Loves()
			Deacon_Loves()
			Hancock_Likes()
			MacCready_Dislikes()
			Piper_Loves()
			Preston_Likes()
			Strong_Hates()
			Valentine_Loves()
			X688_Loves()

		elseif eventID == 2
		; STAGE 160 on Quest BoS302
		; DESCRIPTION: The Player is sent to execute Paladin Danse, because it's been revealed that Paladin
		; Danse is a synth. At this stage, the Player has successfully convinced Danse to leave with the
		; Player instead of killing himself (see 120 above). However, outside the bunker, they are confronted
		; by Elder Maxson. The Player is able to convince Maxson not to kill Danse, and to look the other way
		; allowing Danse to be peacefully exiled instead. 
			Cait_Dislikes()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Loves()
			Deacon_Loves()
			Hancock_Loves()
			MacCready_Dislikes()
			Piper_Likes()
			Preston_Likes()
			Strong_Hates()
			Valentine_Likes()
			X688_Loves()

		elseif eventID == 3 || eventID == 4
		; STAGE 90 or 170 on Quest BoS302
		; DESCRIPTION: The Player is sent to execute Paladin Danse, because it's been revealed that Paladin
		; Danse is a synth. On these stages, Danse is either killed by the Player, allowed him to commit
		; suicide (by walking away), or allowing Maxson to execute him. There is a peaceful solution to this
		; quest, where the Player can make a plea on Danse's behalf and convince Elder Maxson to exile him
		; from the Brotherhood rather than killing him.
			Cait_Likes()
			Codsworth_Hates()
			Curie_Dislikes()
			Danse_Neutral()
			Deacon_Hates()
			Hancock_Dislikes()
			MacCready_Likes()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Loves()
			Valentine_Dislikes()
			X688_Dislikes()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_BoS302 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_BoSM01(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == BoSM01
		if eventID == 1
		; STAGE 120 on Quest BoSM01
		; DESCRIPTION: After following the trail of a long-missing Brotherhood of Steel recon team, the player
		; found the last survivor of the mission living alone in a remote bunker. Distraught and paranoid, he
		; holds the player at gunpoint. The player carefully talked him down, then went a step further and
		; convinced him to rejoin the Brotherhood, which requires multiple successful speech challenges.
			Cait_Neutral()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Loves()
			Deacon_Likes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Likes()
			Strong_Dislikes()
			Valentine_Likes()
			X688_Dislikes()

		elseif eventID == 2
		; STAGE 145 on Quest BoSM01
		; DESCRIPTION: After following the trail of a long-missing Brotherhood of Steel recon team, the player
		; found the last survivor of the mission living alone in a remote bunker. Distraught and paranoid, he
		; holds the player at gunpoint. Then the player provoked and killed him.
			Cait_Likes()
			Codsworth_Hates()
			Curie_Hates()
			Danse_Hates()
			Deacon_Hates()
			Hancock_Dislikes()
			MacCready_Neutral()
			Piper_Hates()
			Preston_Hates()
			Strong_Loves()
			Valentine_Hates()
			X688_Likes()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_BoSM01 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_BoSM02(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == BoSM02
		if eventID == 1
		; STAGE 385 on Quest BoSM02
		; DESCRIPTION: During a Brotherhood faction quest, while investigating the theft of supplies from the
		; Brotherhood, the player discovered that a young soldier was stealing the food to feed the feral
		; ghouls in the Airport Ruins. The soldier is morally torn-- he believes that the ghouls' lives have
		; value, and he's trying to keep the Brotherhood from killing them (and vice versa). The player then
		; chose to provoke or 'execute' Clarke themselves, instead of letting him go or turning him in 
		; (he'd get a fair trial).
			Cait_Likes()
			Codsworth_Hates()
			Curie_Hates()
			Danse_Hates()
			Deacon_Hates()
			Hancock_Dislikes()
			MacCready_Neutral()
			Piper_Hates()
			Preston_Hates()
			Strong_Likes()
			Valentine_Hates()
			X688_Likes()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_BoSM02 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_BoSR05(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == BoSR05
		if eventID == 1
		; STAGE 35 on Quest BoSR05
		; DESCRIPTION: Brotherhood of Steel Radiant quest. Player has accepted a mission from Proctor Teagan
		; (in charge of supplies of all sorts) to "persuade" farmers to donate their crops to the Brotherhood.
		; "Persuade" can be through dialogue, or killing the farmer. Teagan, a respected member of the
		; Brotherhood, both knows this and would codone the player killing an innocent farmer to take crops
		; that he feels the Brotherhood has a right to. This particular bump is for if the player has decided
		; not to verbally resolve the issue, and instead kills the Farmer. Killing the farmer may be seen as
		; unnecessary by some since dialogue allows for a nice option, forceful option (both require passing
		; a medium/easy speech challenge depending if the player owns the farm or not), or option to even pay
		; the farmer to get the crops. Or it may be seen as either necessary or forgivable by others depending
		; on their stance on the Brotherhood or basically killing to get your way.
			Cait_Likes()
			Codsworth_Hates()
			Curie_Hates()
			Danse_Dislikes()
			Deacon_Hates()
			Hancock_Hates()
			MacCready_Neutral()
			Piper_Hates()
			Preston_Hates()
			Strong_Likes()
			Valentine_Hates()
			X688_Likes()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_BoSR05 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_DialogueDrinkingBuddy(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DialogueDrinkingBuddy
		if eventID == 1
		; STAGE 40 on Quest DialogueDrinkingBuddy
		; DESCRIPTION: Player found the Drinking Buddy robot and decided to keep it. The Drinking Buddy
		; is a modified protectron who brews Ice Cold Beer (of various types) and tells jokes. The player
		; can keep him or sell him to Rufus, and NPC in goodneighbor. Assigning the Drinking Buddy to a
		; workshop location raises their happiness
			Cait_Loves()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Neutral()
			Deacon_Likes()
			Hancock_Likes()
			MacCready_Likes()
			Piper_Likes()
			Preston_Likes()
			Strong_Dislikes()
			Valentine_Likes()
			X688_Neutral()

		elseif eventID == 2
		; STAGE 501 on Quest DialogueDrinkingBuddy
		; DESCRIPTION: The player destroyed the Drinking Buddy. There is no good reason to do this, just
		; decide if your companion cares.
			Cait_Hates()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Dislikes()
			Hancock_Dislikes()
			MacCready_Neutral()
			Piper_Dislikes()
			Preston_Neutral()
			Strong_Likes()
			Valentine_Neutral()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_DialogueDrinkingBuddy got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_DialogueGoodneighborRufus(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DialogueGoodneighborRufus
		if eventID == 1
		; STAGE 700 on Quest DialogueGoodneighborRufus
		; DESCRIPTION: Player has sold the Drinking Buddy to Rufus in Goodneighbor. Rufus is a misc junk
		; vendor who hangs out in Hotel Rexford or the 3rd Rail. The player can still get free beer, but
		; doesn't have the Drinking Buddy at their workshop
			Cait_Dislikes()
			Codsworth_Neutral()
			Curie_Neutral()
			Danse_Neutral()
			Danse_Neutral()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Neutral()
			Valentine_Neutral()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_DialogueGoodneighborRufus got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_DN015(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DN015
		if eventID == 1
		; STAGE 100 on Quest DN015
		; DESCRIPTION: After being locked in a secure lab by a robot, the player has completed the power
		; armor research that the prewar team could not.
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Loves()
			Danse_Likes()
			Deacon_Likes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Dislikes()
			Valentine_Neutral()
			X688_Likes()

		elseif eventID == 2
		; STAGE 110 on Quest DN015
		; DESCRIPTION: After being locked in the lab, the player has found a terminal and triggered a
		; security override that unlocks the doors and turns all the robots hostile (alternate exit)
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Neutral()
			Danse_Neutral()
			Deacon_Neutral()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Neutral()
			Valentine_Neutral()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_DN015 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_DN036(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DN036
		if eventID == 1
		; STAGE 11 on Quest DN036
		; QUEST DESCRIPTION: The player has found an old woman named Phyllis Daily who thinks she is a synth.
		; She starts with a gun trained on the player and they have to decide how to deal with her. She
		; starts out trying to warn the player to leave. (She is not a synth, she fell asleep on watch and
		; the gun she was holding misfired and killed her grandson)
		; DESCRIPTION: Player has convinced her to lower the gun through a speech challenge
			Cait_Neutral()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Likes()
			Deacon_Likes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Likes()
			Strong_Dislikes()
			Valentine_Likes()
			X688_Neutral()

		elseif eventID == 2
		; STAGE 20 on Quest DN036
		; DESCRIPTION: Player has stated it is the Brotherhood duty to destroy her. This goes to battle.
			Cait_Neutral()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Loves()
			Deacon_Hates()
			Hancock_Dislikes()
			MacCready_Neutral()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Hates()
			Valentine_Dislikes()
			X688_Neutral()

		elseif eventID == 3
		; STAGE 201 on Quest DN036
		; DESCRIPTION: After hearing what happened, the player has blamed her for Samuel's death
		; (depends on the companion how they should feel about this)
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Dislikes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Dislikes()
			Preston_Neutral()
			Strong_Neutral()
			Valentine_Dislikes()
			X688_Neutral()

		elseif eventID == 4
		; STAGE 202 on Quest DN036
		; DESCRIPTION: After hearing what happened, the player mentions Shaun to try to connect with her
			Cait_Neutral()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Likes()
			Deacon_Likes()
			Hancock_Neutral()
			MacCready_Likes()
			Piper_Likes()
			Preston_Neutral()
			Strong_Neutral()
			Valentine_Likes()
			X688_Hates()

		elseif eventID == 5
		; STAGE 203 on Quest DN036
		; DESCRIPTION: After hearing what happened, the player tried to tell her it wasn't her fault
			Cait_Dislikes()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Likes()
			Deacon_Neutral()
			Hancock_Likes()
			MacCready_Likes()
			Piper_Likes()
			Preston_Neutral()
			Strong_Dislikes()
			Valentine_Likes()
			X688_Dislikes()

		elseif eventID == 6
		; STAGE 510 on Quest DN036
		; DESCRIPTION: Player asked her to join the minutemen
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Likes()
			Danse_Dislikes()
			Deacon_Neutral()
			Hancock_Likes()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Likes()
			Strong_Neutral()
			Valentine_Likes()
			X688_Neutral()

		elseif eventID == 7
		; STAGE 511 on Quest DN036
		; DESCRIPTION: Player told her to just deal with it and move on
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Dislikes()
			Hancock_Neutral()
			MacCready_Dislikes()
			Piper_Dislikes()
			Preston_Neutral()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Neutral()

		elseif eventID == 8
		; STAGE 512 on Quest DN036
		; DESCRIPTION: Player told her to help others or take it at day at a time
			Cait_Neutral()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Neutral()
			Deacon_Neutral()
			Hancock_Likes()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Neutral()
			Strong_Neutral()
			Valentine_Likes()
			X688_Neutral()

		elseif eventID == 9
		; STAGE 513 on Quest DN036
		; DESCRIPTION: Player told her to leave the commonwealth (not in a jerk way)
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Dislikes()
			Danse_Neutral()
			Deacon_Dislikes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Neutral()
			Valentine_Neutral()
			X688_Neutral()

		elseif eventID == 10
		; STAGE 514 on Quest DN036
		; DESCRIPTION: Player told her to go to Covenant and ask to take the test (she will later
		; appear there dead)
			Cait_Neutral()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Likes()
			Deacon_Hates()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Neutral()
			Strong_Neutral()
			Valentine_Likes()
			X688_Neutral()

		elseif eventID == 11
		; STAGE 701 on Quest DN036
		; DESCRIPTION: The player has killed Phyllis before even knowing that she may be a synth
		; (though she does have a gun pointed at you)
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Dislikes()
			Hancock_Likes()
			MacCready_Neutral()
			Piper_Dislikes()
			Preston_Neutral()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Neutral()

		elseif eventID == 12
		; STAGE 702 on Quest DN036
		; DESCRIPTION: The player has killed Phyllis after finding out she may be a synth, but before
		; hearing the full story.
			Cait_Likes()
			Codsworth_Hates()
			Curie_Dislikes()
			Danse_Loves()
			Deacon_Hates()
			Hancock_Dislikes()
			MacCready_Likes()
			Piper_Hates()
			Preston_Neutral()
			Strong_Likes()
			Valentine_Hates()
			X688_Neutral()

		elseif eventID == 13
		; STAGE 703 on Quest DN036
		; DESCRIPTION: Player has killed Phyllis after finding out she may be a synth and hearing that she
		; killed her grandson Samuel (which may have just been an accident)
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Loves()
			Deacon_Dislikes()
			Hancock_Dislikes()
			MacCready_Likes()
			Piper_Dislikes()
			Preston_Neutral()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Neutral()

		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_DN036 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_DN036_Post(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DN036_Post
		if eventID == 1
		; STAGE 15 on Quest DN036_Post
		; DESCRIPTION: The player let Phyllis live, and reported her to the Institute. (they will send a
		; courser to investigate, she will disappear without a trace, with some blood enabled there)
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Dislikes()
			Danse_Hates()
			Deacon_Hates()
			Hancock_Hates()
			MacCready_Neutral()
			Piper_Hates()
			Preston_Neutral()
			Strong_Dislikes()
			Valentine_Hates()
			X688_Likes()

		elseif eventID == 2
		; STAGE 25 on Quest DN036_Post
		; DESCRIPTION: The player let Phyllis live, and told the Railroad about her. (She will leave but
		; leave a thank you note and loot)
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Likes()
			Danse_Dislikes()
			Deacon_Loves()
			Hancock_Likes()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Likes()
			Strong_Neutral()
			Valentine_Likes()
			X688_Hates()

		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_DN036_Post got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_DN053(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DN053
		if eventID == 1
		; STAGE XXX on Quest DN053
		; DESCRIPTION: Player brought Virgil the FEV Serum from his old lab in the Institute, which Virgil
		; hopes will make him human again. The player promised to do this in exchange for Virgil's help
		; earlier, so he's kept his word.
			Cait_Neutral()
			Codsworth_Likes()
			Curie_Loves()
			Danse_Dislikes()
			Deacon_Likes()
			Hancock_Likes()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Likes()
			Strong_Hates()
			Valentine_Likes()
			X688_Neutral()

		elseif eventID == 2
		; STAGE 100 on Quest DN053
		; DESCRIPTION: The player murdered Virgil. Virgil is not normally hostile, so the player provoked the
		; confrontation in some way, either by attacking him or by inciting him through dialogue.
			Cait_Likes()
			Codsworth_Hates()
			Curie_Hates()
			Danse_Loves()
			Deacon_Hates()
			Hancock_Hates()
			MacCready_Neutral()
			Piper_Hates()
			Preston_Hates()
			Strong_Loves()
			Valentine_Hates()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_DN053 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_DN079(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DN079
		if eventID == 1
		; STAGE 25 on Quest DN079
		; DESCRIPTION: The player has questioned Theo repeatedly about the rumors that people have been
		; getting sick from eating his canned meat.
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Neutral()
			Danse_Neutral()
			Deacon_Likes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Loves()
			Preston_Neutral()
			Strong_Dislikes()
			Valentine_Likes()
			X688_Neutral()

		elseif eventID == 2
		; STAGE 900 on Quest DN079
		; DESCRIPTION: After finding out about the ghoul meat and getting Theo into bleed out he
		; surrendered and the player has agreed to spare him and look the other way in exchange for a cut
		; of the profit 
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Likes()
			Hancock_Dislikes()
			MacCready_Loves()
			Piper_Hates()
			Preston_Dislikes()
			Strong_Dislikes()
			Valentine_Dislikes()
			X688_Neutral()

		elseif eventID == 3
		; STAGE 951 on Quest DN079
		; DESCRIPTION: Player has killed Theodore Collins after finding out that he has been using ghoul
		; meat in some of his cans, which is why people have been getting sick. Theo also attacked the
		; player 
			Cait_Likes()
			Codsworth_Neutral()
			Curie_Likes()
			Danse_Likes()
			Deacon_Likes()
			Hancock_Likes()
			MacCready_Likes()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Likes()
			Valentine_Neutral()
			X688_Neutral()

		elseif eventID == 4
		; STAGE 955 on Quest DN079
		; DESCRIPTION: Player has killed Theodore Collins, who is running Longneck Lukowski's Cannery before
		; knowing anything about the situation, so this is murder. Theodore just looks like a normal trader,
		; but is out in a cannery on the coast. He repaired some of the retorts and has been selling canned
		; meat.
			Cait_Likes()
			Codsworth_Hates()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Hates()
			Hancock_Hates()
			MacCready_Neutral()
			Piper_Hates()
			Preston_Hates()
			Strong_Likes()
			Valentine_Hates()
			X688_Neutral()

		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_DN079 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_DN083_Barney(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DN083_Barney
		if eventID == 1
		; STAGE 90 on Quest DN083_Barney
		; DESCRIPTION: Player helped Barney set up automated turrets around Salem to defend it from being
		; overrun by mirelurks. Barney is the only one that lives there.
			Cait_Neutral()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Likes()
			Deacon_Likes()
			Hancock_Likes()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Likes()
			Strong_Neutral()
			Valentine_Likes()
			X688_Neutral()

		elseif eventID == 2
		; STAGE 100 on Quest DN083_Barney
		; DESCRIPTION: Barney wants to defend Salem from being overrun by mirelurks. Player decided to murder
		; Barney without provocation.
			Cait_Neutral()
			Codsworth_Hates()
			Curie_Hates()
			Danse_Hates()
			Deacon_Hates()
			Hancock_Dislikes()
			MacCready_Neutral()
			Piper_Dislikes()
			Preston_Hates()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_DN083_Barney got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_DN101(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DN101
		if eventID == 1
		; STAGE 70 on Quest DN101
		; DESCRIPTION: The player stumbled upon Raiders ransacking the Pickman Gallery looking to kill
		; Pickman. Over the course of the level, the player discovers paintings of Raiders tortured by
		; Pickman and his torture chairs. At the end of the level, the player discovers Pickman caught by
		; the Raiders and about to be executed. The player can choose to save the serial killer Pickman
		; from the Raider gang he has been hunting. The stage fires when the player talks to Pickman after
		; killing the Raiders.
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Hates()
			Deacon_Dislikes()
			Hancock_Dislikes()
			MacCready_Dislikes()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Likes()
			Valentine_Neutral()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_DN101 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_DN109(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DN109
		if eventID == 1
		; STAGE 100 on Quest DN109
		; DESCRIPTION: The player has gone to Quincy and killed one of the Gunner bosses, named Baker,
		; who had betrayed the minutemen (he was a minuteman) and led to Preston & his group fleeing
		; Quincy.
			Cait_Likes()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Likes()
			Deacon_Likes()
			Hancock_Loves()
			MacCready_Loves()
			Piper_Likes()
			Preston_Loves()
			Strong_Likes()
			Valentine_Likes()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_DN109 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_DN119Fight(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DN119Fight
		if eventID == 1
		; STAGE 220 on Quest DN119Fight
		; DESCRIPTION: The player discovers a random Scavenger being attacked by Molerats, and can choose
		; to help the Scavenger kill them. The stage triggers when the player talks to the Scavenger after
		; killing the Molerats.
			Cait_Neutral()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Likes()
			Deacon_Likes()
			Hancock_Likes()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Likes()
			Strong_Likes()
			Valentine_Likes()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_DN119Fight got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_DN121(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == DN121
		if eventID == 1
		; STAGE 55 on Quest DN121
		; QUEST DESCRIPTION: The player has been sent by Abraham Finch to retrieve his sword,
		; the Shishkebab, from The Forged in Saugus Ironworks. When the player arrives he finds Jake Finch
		; in the middle of an induction ritual  being told that he must kill an unarmed prisoner. Jake doesn't
		; want to but thinks they will kill him and his family if he doesn't, the player has the chance
		; to sway him
		; DESCRIPTION: Player attempted to haggle with Abraham over the price of retrieving the sword. 
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Neutral()
			Danse_Neutral()
			Deacon_Neutral()
			Hancock_Neutral()
			MacCready_Likes()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Dislikes()
			Valentine_Neutral()
			X688_Neutral()

		elseif eventID == 2
		; STAGE 350 on Quest DN121
		; DESCRIPTION: The player killed the prisoner that Jake Finch was told to kill. This can happen
		; after the fight.
			Cait_Neutral()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Hates()
			Deacon_Dislikes()
			Hancock_Hates()
			MacCready_Dislikes()
			Piper_Hates()
			Preston_Hates()
			Strong_Likes()
			Valentine_Hates()
			X688_Neutral()

		elseif eventID == 3
		; STAGE 495 on Quest DN121
		; DESCRIPTION: Player has finished helping Jake reunite with his family (prisoner may or may not
		; have survived)
			Cait_Neutral()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Likes()
			Deacon_Likes()
			Hancock_Likes()
			MacCready_Likes()
			Piper_Likes()
			Preston_Likes()
			Strong_Neutral()
			Valentine_Likes()
			X688_Dislikes()

		elseif eventID == 4
		; STAGE 501 on Quest DN121
		; DESCRIPTION: Jake has decided to kill the prisoner, but the player kills Jake before he gets the
		; shot off.
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Likes()
			Danse_Likes()
			Deacon_Likes()
			Hancock_Likes()
			MacCready_Likes()
			Piper_Dislikes()
			Preston_Likes()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Neutral()

		elseif eventID == 5
		; STAGE 502 on Quest DN121
		; DESCRIPTION: Jake decided not to kill the prisoner, but the player killed Jake anyway
			Cait_Likes()
			Codsworth_Hates()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Dislikes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Neutral()

		elseif eventID == 6
		; STAGE 503 on Quest DN121
		; DESCRIPTION: Jake killed the prisoner, but survived long enough to surrender, and appears repentant,
		; but the player has killed him
			Cait_Likes()
			Codsworth_Hates()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Dislikes()
			Hancock_Hates()
			MacCready_Neutral()
			Piper_Hates()
			Preston_Hates()
			Strong_Neutral()
			Valentine_Hates()
			X688_Neutral()

		elseif eventID == 7
		; STAGE 504 on Quest DN121
		; DESCRIPTION: Jake did not kill the prisoner, but did fight against the player (player initiated
		; the combat in some way) and has surrendered, but the player has killed him anyway
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Dislikes()
			Hancock_Likes()
			MacCready_Neutral()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Neutral()

		elseif eventID == 8
		; STAGE 505 on Quest DN121
		; DESCRIPTION: Any other case where Jake is killed by the player, usually after helping him out
		; (which is murder)
			Cait_Neutral()
			Codsworth_Hates()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Dislikes()
			Hancock_Hates()
			MacCready_Neutral()
			Piper_Hates()
			Preston_Hates()
			Strong_Likes()
			Valentine_Hates()
			X688_Neutral()

		elseif eventID == 9
		; STAGE 722 on Quest DN121
		; DESCRIPTION: (Jake died) The player has lied to Abraham to spare his feelings.
			Cait_Neutral()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Likes()
			Deacon_Likes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Dislikes()
			Valentine_Dislikes()
			X688_Dislikes()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_DN121 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_FFBunkerHill03(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == FFBunkerHill03
		if eventID == 1
		; STAGE 200 on Quest FFBunkerHill03
		; DESCRIPTION: Some raiders (Zeller's Army) have captured and imprisoned a bunch of innocent traders.
		; The player has just rescued the last of them.
			Cait_Neutral()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Likes()
			Deacon_Likes()
			Hancock_Loves()
			MacCready_Neutral()
			Piper_Loves()
			Preston_Loves()
			Strong_Neutral()
			Valentine_Loves()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_FFBunkerHill03 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_FFGoodneighbor07(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == FFGoodneighbor07
		if eventID == 1
		; STAGE 30 on Quest FFGoodneighbor07
		; DESCRIPTION: Player has attacked Bobbi No-Nose after siding with her during MS16 - The Big Dig
		; - but then took the job from Hancock to kill her and take back Hancock's stolen caps.
			Cait_Likes()
			Codsworth_Hates()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Likes()
			Hancock_Neutral()
			MacCready_Likes()
			Piper_Hates()
			Preston_Dislikes()
			Strong_Likes()
			Valentine_Hates()
			X688_Likes()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_FFGoodneighbor07 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_Inst301(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == Inst301
		if eventID == 1
		; STAGE 500 on Quest Inst301
		; DESCRIPTION: Player has just teamed up with a Courser to attack Libertalia and try to reclaim
		; a rogue synth. Player's mission to reclaim the rogue synth was a success, and the Courser has
		; teleported him back to the Institute
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Dislikes()
			Danse_Hates()
			Deacon_Dislikes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Neutral()
			Preston_Dislikes()
			Strong_Dislikes()
			Valentine_Neutral()
			X688_Neutral()

		elseif eventID == 2
		; STAGE 300 on Quest Inst301
		; DESCRIPTION: Player has just teamed up with a Courser to attack Libertalia and try to reclaim a
		; rogue synth. This is mainly here for companions that might have strong feelings about fighting
		; alongside a Courser.
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Neutral()
			Danse_Hates()
			Deacon_Neutral()
			Hancock_Dislikes()
			MacCready_Neutral()
			Piper_Dislikes()
			Preston_Neutral()
			Strong_Dislikes()
			Valentine_Dislikes()
			X688_Neutral()

		elseif eventID == 3
		; STAGE 400 on Quest Inst301
		; DESCRIPTION: Player's mission to reclaim the rogue synth was a failure, because the boss died
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Dislikes()
			Danse_Likes()
			Deacon_Neutral()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Neutral()
			Valentine_Neutral()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_Inst301 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_Inst307(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == Inst307
		if eventID == 1
		; STAGE 200 on Quest Inst307
		; DESCRIPTION: The Player has successfully attacked the airport and destroyed the Prydwen using
		; Liberty Prime to shoot it down
			Cait_Likes(CheckCompanionProximity = false)
			Codsworth_Dislikes(CheckCompanionProximity = false)
			Curie_Dislikes(CheckCompanionProximity = false)
			Danse_Hates(CheckCompanionProximity = false)
			Deacon_Neutral(CheckCompanionProximity = false)
			Hancock_Dislikes(CheckCompanionProximity = false)
			MacCready_Neutral(CheckCompanionProximity = false)
			Piper_Hates(CheckCompanionProximity = false)
			Preston_Likes(CheckCompanionProximity = false)
			Strong_Loves(CheckCompanionProximity = false)
			Valentine_Hates(CheckCompanionProximity = false)
			X688_Loves(CheckCompanionProximity = false)
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_FFGoodneighbor07 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_InstM01(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == InstM01
		if eventID == 1
		; STAGE 70 on Quest InstM01
		; DESCRIPTION: The player talked Bill Sutton, the dangerous foreman who was just a moment ago pointing
		; a gun at a family, into standing down and giving up his crusade to expose Roger Warwick as a synth.
			Cait_Neutral()
			Codsworth_Loves()
			Curie_Likes()
			Danse_Likes()
			Deacon_Likes()
			Hancock_Dislikes()
			MacCready_Likes()
			Piper_Likes()
			Preston_Likes()
			Strong_Dislikes()
			Valentine_Likes()
			X688_Loves()

		elseif eventID == 2
		; STAGE 90 on Quest InstM01
		; DESCRIPTION: Player murdered the farm foreman, when he was supposed to keep a low profile. Player
		; has acted against the Institute here, violating his orders and failing the mission.
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Likes()
			Deacon_Likes()
			Hancock_Likes()
			MacCready_Likes()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Hates()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_InstM01 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_InstR03NEW(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == InstR03NEW
		if eventID == 1
		; STAGE 500 on Quest InstR03NEW
		; DESCRIPTION: Player stole blueprints from the Brotherhood of Steel to give to the Institute for study
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Neutral()
			Danse_Hates()
			Deacon_Dislikes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Neutral()
			Valentine_Neutral()
			X688_Likes()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_InstR03NEW got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_InstR04(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == InstR04
		if eventID == 1
		; STAGE 40 on Quest InstR04
		; DESCRIPTION: Player killed the synth he was sent to rescue, violating his orders and acting against
		; the Institute's wishes
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Loves()
			Deacon_Hates()
			Hancock_Neutral()
			MacCready_Likes()
			Piper_Dislikes()
			Preston_Neutral()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Hates()

		elseif eventID == 2
		; STAGE 200 on Quest InstR04
		; DESCRIPTION: Player successfully delivered the homing beacon to the abducted synth, completing a
		; tough mission for the Institute.
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Dislikes()
			Danse_Hates()
			Deacon_Dislikes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Neutral()
			Valentine_Neutral()
			X688_Likes()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_InstR04 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_InstR05(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == InstR05
		if eventID == 1
		; STAGE XXX on Quest InstR05
		; DESCRIPTION: Player collected an intelligence report from the synth MayorMcDonough, who has been
		; spying on everyone in Diamond City for the Institute.
			Cait_Dislikes()
			Codsworth_Neutral()
			Curie_Neutral()
			Danse_Hates()
			Deacon_Dislikes()
			Hancock_Dislikes()
			MacCready_Dislikes()
			Piper_Hates()
			Preston_Dislikes()
			Strong_Dislikes()
			Valentine_Dislikes()
			X688_Likes()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_InstR05 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_Min01(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == Min01
		if eventID == 1
		; STAGE 1500 on Quest Min01
		; DESCRIPTION: Player helped the people of Sanctuary establish their settlement (building beds,
		; water, food, defenses).
			Cait_Neutral()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Neutral()
			Deacon_Likes()
			Hancock_Likes()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Loves()
			Strong_Likes()
			Valentine_Likes()
			X688_Dislikes()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_Min01 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_Min02(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == Min02
		if eventID == 1
		; STAGE 600 on Quest Min02
		; DESCRIPTION: Player helped reestablish the Castle as a Minutemen stronghold, and got Radio
		; Freedom (Minutemen radio station) up and running.
			Cait_Neutral()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Likes()
			Deacon_Dislikes()
			Hancock_Likes()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Loves()
			Strong_Likes()
			Valentine_Likes()
			X688_Dislikes()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_Min02 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_Min03(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == Min03
		if eventID == 1
		; STAGE 920 on Quest Min03
		; DESCRIPTION: Player built and tested artillery, which is now available to build at friendly
		; settlements. Player now has artillery support available.
			Cait_Likes()
			Codsworth_Neutral()
			Curie_Neutral()
			Danse_Dislikes()
			Deacon_Neutral()
			Hancock_Likes()
			MacCready_Likes()
			Piper_Neutral()
			Preston_Loves()
			Strong_Likes()
			Valentine_Neutral()
			X688_Dislikes()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_Min03 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_Min207(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == Min207
		if eventID == 1
		; STAGE 200 on Quest Min207
		; DESCRIPTION: Player gave Sturges the holotape containing the stolen Institute data (which will
		; eventually be used to figure out how to attack the Institute).
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Neutral()
			Danse_Hates()
			Deacon_Dislikes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Likes()
			Strong_Neutral()
			Valentine_Neutral()
			X688_Hates()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_Min207 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_Min301(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == Min301
		if eventID == 1
		; STAGE 50 on Quest Min301
		; DESCRIPTION: Player has built up the strength of the Minutemen by recruiting settlements to the
		; cause. The Minutemen are now strong enough to consider attacking the Institute.
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Likes()
			Danse_Dislikes()
			Deacon_Neutral()
			Hancock_Likes()
			MacCready_Neutral()
			Piper_Neutral()
			Preston_Likes()
			Strong_Neutral()
			Valentine_Neutral()
			X688_Dislikes()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_Min301 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_MinDefendCastle(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MinDefendCastle
		if eventID == 1
		; STAGE 400 on Quest MinDefendCastle
		; DESCRIPTION: Player has helped the Minutemen defend the Castle from various attackers.
		; Affinity varies based on attacker type
		; 0=Raiders, 1=Gunners, 2=SM, 3/6=BoS, 4/5=Inst
			if MinCastleAttacker.GetValue() == 0 || MinCastleAttacker.GetValue() == 1
				Cait_Likes()
				Codsworth_Likes()
				Curie_Likes()
				Danse_Neutral()
				Deacon_Likes()
				Hancock_Likes()
				MacCready_Likes()
				Piper_Likes()
				Preston_Loves()
				Strong_Likes()
				Valentine_Likes()
				X688_Neutral()
			elseif MinCastleAttacker.GetValue() == 2
				Cait_Likes()
				Codsworth_Likes()
				Curie_Likes()
				Danse_Likes()
				Deacon_Likes()
				Hancock_Likes()
				MacCready_Likes()
				Piper_Likes()
				Preston_Loves()
				Strong_Neutral()
				Valentine_Likes()
				X688_Neutral()
			elseif MinCastleAttacker.GetValue() == 3 || MinCastleAttacker.GetValue() == 6
				Cait_Likes()
				Codsworth_Likes()
				Curie_Likes()
				Danse_Hates()
				Deacon_Likes()
				Hancock_Likes()
				MacCready_Likes()
				Piper_Likes()
				Preston_Loves()
				Strong_Likes()
				Valentine_Likes()
				X688_Likes()
			elseif MinCastleAttacker.GetValue() == 4 || MinCastleAttacker.GetValue() == 5
				Cait_Likes()
				Codsworth_Likes()
				Curie_Likes()
				Danse_Likes()
				Deacon_Likes()
				Hancock_Likes()
				MacCready_Likes()
				Piper_Likes()
				Preston_Loves()
				Strong_Likes()
				Valentine_Likes()
				X688_Hates()
			endif						
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_MinDefendCastle got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_MinDestBOS(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MinDestBOS
		if eventID == 1
		; STAGE 500 on Quest MinDestBOS
		; DESCRIPTION: Player ordered a successful artillery strike on the Prydwen.
			Cait_Likes(CheckCompanionProximity = false)
			Codsworth_Dislikes(CheckCompanionProximity = false)
			Curie_Neutral(CheckCompanionProximity = false)
			Danse_Hates(CheckCompanionProximity = false)
			Deacon_Likes(CheckCompanionProximity = false)
			Hancock_Likes(CheckCompanionProximity = false)
			MacCready_Likes(CheckCompanionProximity = false)
			Piper_Neutral(CheckCompanionProximity = false)
			Preston_Loves(CheckCompanionProximity = false)
			Strong_Likes(CheckCompanionProximity = false)
			Valentine_Neutral(CheckCompanionProximity = false)
			X688_Likes(CheckCompanionProximity = false)
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_MinDestBOS got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_MQ203(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MQ203
		if eventID == 1
		; STAGE 1100 on Quest MQ203
		; DESCRIPTION: Player learned Virgil's location from Kellogg's memories. Player hopes that Virgil
		; may help the player figure out how to find the Institute and thus find his son.
			Cait_Likes()
			Codsworth_Likes()
			Curie_Neutral()
			Danse_Likes()
			Deacon_Likes()
			Hancock_Likes()
			MacCready_Likes()
			Piper_Likes()
			Preston_Likes()
			Strong_Likes()
			Valentine_Likes()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_MQ203 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_MQ302(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MQ302
		if eventID == 1
		; STAGE 850 on Quest MQ302
		; DESCRIPTION: The player has just pushed the button to detonate the Fusion Pulse charge and
		; destroy the Institute.
		; GLOBAL KEY: 1= BoS Pressed, 2= MinuteMen Pressed, 3= RR Pressed
				Cait_Likes(CheckCompanionProximity = false)
				Codsworth_Dislikes(CheckCompanionProximity = false)
				Curie_Likes(CheckCompanionProximity = false)
				Hancock_Loves(CheckCompanionProximity = false)
				MacCready_Likes(CheckCompanionProximity = false)
				Piper_Loves(CheckCompanionProximity = false)
				Strong_Likes(CheckCompanionProximity = false)
				Valentine_Loves(CheckCompanionProximity = false)
			if MQ302Faction.GetValue() == 1
				Danse_Loves(CheckCompanionProximity = false)
				Deacon_Neutral(CheckCompanionProximity = false)
				Preston_Likes(CheckCompanionProximity = false)
				X688_Neutral(CheckCompanionProximity = false)
			elseif MQ302Faction.GetValue() == 2
				Danse_Likes(CheckCompanionProximity = false)
				Deacon_Loves(CheckCompanionProximity = false)
				Preston_Loves(CheckCompanionProximity = false)
				X688_Neutral(CheckCompanionProximity = false)
			elseif MQ302Faction.GetValue() == 3
				Danse_Neutral(CheckCompanionProximity = false)
				Deacon_Loves(CheckCompanionProximity = false)
				Preston_Likes(CheckCompanionProximity = false)
				X688_Neutral(CheckCompanionProximity = false)
			endif
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_MQ302 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_MS01(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS01
		if eventID == 1
		; STAGE 45 on Quest MS01
		; DESCRIPTION: After saving Billy the ghoul from the fridge, and reuniting him with his family, Bullet
		; the gunner surrounds the house. The player chooses to turn over the whole family to Bullet to become
		; their slaves rather than fight Bullet.
			Cait_Hates()
			Codsworth_Hates()
			Curie_Hates()
			Danse_Hates()
			Deacon_Hates()
			Hancock_Hates()
			MacCready_Dislikes()
			Piper_Hates()
			Preston_Hates()
			Strong_Dislikes()
			Valentine_Hates()
			X688_Likes()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_MS01 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_MS04(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS04
		if eventID == 1
		; STAGE 445 on Quest MS04
		; DESCRIPTION: The player killed an assassin (Kendra) and found a contract on her body. The player
		; then completes that assassination contract on a complete stranger (who is obviously guilty on no
		; wrong doing). Probably to collect the reward.
			Cait_Likes()
			Codsworth_Hates()
			Curie_Hates()
			Danse_Hates()
			Deacon_Hates()
			Hancock_Hates()
			MacCready_Likes()
			Piper_Hates()
			Preston_Hates()
			Strong_Likes()
			Valentine_Hates()
			X688_Likes()

		elseif eventID == 2
		; STAGE 1330 on Quest MS04
		; DESCRIPTION: Sinjin is holding Kent Connolly at gunpoint. Instead of negotiating with Sinjin,
		; the player shoots Kent in the head. Kent has been working with the player up until that point.
			Cait_Neutral()
			Codsworth_Hates()
			Curie_Dislikes()
			Danse_Likes()
			Deacon_Dislikes()
			Hancock_Hates()
			MacCready_Neutral()
			Piper_Hates()
			Preston_Hates()
			Strong_Loves()
			Valentine_Hates()
			X688_Likes()

		elseif eventID == 3
		; STAGE 1359 on Quest MS04
		; DESCRIPTION: Kent Connolly, a ghoul who has been working with the player, is being held hostage by
		; the vicous raider, Sinjin. The player manages to rescue Kent (which is very difficult).
			Cait_Neutral()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Dislikes()
			Deacon_Loves()
			Hancock_Loves()
			MacCready_Neutral()
			Piper_Loves()
			Preston_Loves()
			Strong_Likes()
			Valentine_Loves()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_MS04 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_MS05B(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS05B
		if eventID == 1
		; STAGE 500 on Quest MS05B
		; DESCRIPTION: The player has returned the rescued Deathclaw egg to its nest.
			Cait_Dislikes()
			Codsworth_Neutral()
			Curie_Dislikes()
			Danse_Hates()
			Deacon_Dislikes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Dislikes()
			Strong_Dislikes()
			Valentine_Likes()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_MS05B got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_MS05BPostQuest(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS05BPostQuest
		if eventID == 1
		; STAGE 30 on Quest MS05BPostQuest
		; DESCRIPTION: Player has stolen back Deathclaw egg they returned to nest in MS05B.
			Cait_Likes()
			Codsworth_Neutral()
			Curie_Likes()
			Danse_Neutral()
			Deacon_Likes()
			Hancock_Likes()
			MacCready_Likes()
			Piper_Dislikes()
			Preston_Likes()
			Strong_Neutral()
			Valentine_Dislikes()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_MS05BPostQuest got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_MS07a(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS07a
		if eventID == 1
		; STAGE 60 on Quest MS07a
		; DESCRIPTION: The player has found Doctor Crocker, Diamond City's surgeon, standing over a butchered
		; body of a possible missing person in the basement of the Mega Surgery Center. Rather than trying to
		; talk him down, the player has attacked them.
			Cait_Likes()
			Codsworth_Hates()
			Curie_Hates()
			Danse_Dislikes()
			Deacon_Dislikes()
			Hancock_Likes()
			MacCready_Likes()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Loves()
			Valentine_Dislikes()
			X688_Likes()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_MS07a got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_MS07b(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS07b
		if eventID == 1
		; STAGE 40 on Quest MS07b
		; DESCRIPTION: The Player has just completed digging up the ancient grave of a coppersmith from the
		; 18th century in order to follow a lead on a treasure map. Companions may take issue with greed
		; overriding decency.
			Cait_Likes()
			Codsworth_Neutral()
			Curie_Neutral()
			Danse_Dislikes()
			Deacon_Neutral()
			Hancock_Likes()
			MacCready_Loves()
			Piper_Likes()
			Preston_Dislikes()
			Strong_Neutral()
			Valentine_Likes()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_MS07b got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_MS07c(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS07c
		if eventID == 1
		; STAGE 250 on Quest MS07c
		; DESCRIPTION: The player and Nick have killed Eddie Winter,  an unrepentant old mob boss and nemesis
		; to the pre-war Nick Valentine, who has been hiding in a bunker for the past 200 years. This means a
		; lot to Nick.
			Cait_Likes()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Neutral()
			Deacon_Likes()
			Hancock_Likes()
			MacCready_Likes()
			Piper_Likes()
			Preston_Likes()
			Strong_Likes()
			Valentine_Loves()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_MS07c got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_MS09(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS09
		if eventID == 1
		; STAGE 1210 on Quest MS09
		; DESCRIPTION: Player helps kill Lorenzo - see below. Lorenzo is in the process of freeing himself,
		; so killing him is the only available option to stop him (aside from letting him get free or
		; actively helping him get free).
			Cait_Likes()
			Codsworth_Neutral()
			Curie_Dislikes()
			Danse_Neutral()
			Deacon_Likes()
			Hancock_Likes()
			MacCready_Likes()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Likes()
			Valentine_Neutral()
			X688_Neutral()

		elseif eventID == 2
		; STAGE 1260 on Quest MS09
		; DESCRIPTION: Player frees Lorenzo Cabot from his cell in Parsons State Insane Asylum. Player works
		; for Jack Cabot, Lorenzo's son, and Jack has warned the player repeatedly that Lorenzo is insane and
		; very dangerous. However, Jack is also benefiting from Lorenzo's imprisonment by using Lorenzo's
		; blood to create a serum that prolongs his life. Lorenzo also urges the player to free him, arguing
		; that Jack is the crazy one and has been lying to the player the whole time.
			Cait_Dislikes()
			Codsworth_Dislikes()
			Curie_Likes()
			Danse_Dislikes()
			Deacon_Dislikes()
			Hancock_Dislikes()
			MacCready_Dislikes()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Dislikes()
			Valentine_Dislikes()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_MS09 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_MS11(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS11
		if eventID == 1
		; STAGE 730 on Quest MS11
		; DESCRIPTION: The player sides with scavengers to sabotage the USS Constitution's rockets. This
		; screws over the zany robotic crew of the ship (Ironsides and company). This happens when the player
		; actually sabotages the rocket directly.
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Dislikes()
			Hancock_Likes()
			MacCready_Likes()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Neutral()

		elseif eventID == 2
		; STAGE 950 on Quest MS11
		; DESCRIPTION: The player has successfully fixed all of the components of the USS Constitution. At
		; this point, the player watches the ship take off into the sky (and land inside a skyscraper in
		; the distance). The robotic crew are very pleased and the scavengers that wanted the salvage are
		; long dead.
			Cait_Dislikes()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Likes()
			Deacon_Loves()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Neutral()
			Valentine_Likes()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_MS11 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_MS16(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS16
		if eventID == 1
		; STAGE 260 on Quest MS16
		; DESCRIPTION: The player helped known criminal Bobbi No-Nose rob the mayor of Goodneighbor's
		; storeroom. The player had to break in forcefully and kill his bodyguard to finish the job.
			Cait_Loves()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Neutral()
			Deacon_Hates()
			Hancock_Neutral()
			MacCready_Likes()
			Piper_Dislikes()
			Preston_Neutral()
			Strong_Neutral()
			Valentine_Dislikes()
			X688_Likes()

		elseif eventID == 2
		; STAGE 270 on Quest MS16
		; DESCRIPTION:  The player was working for known criminal Bobbi No-Nose to help dig a tunnel to
		; break into a loot vault. The player did not know who they were robbing until confronted by
		; Hancock's bodyguard. After having all the information, they refused to help Bobbi. Player either
		; killed Bobbi or talked her out of completing the job.
			Cait_Likes()
			Codsworth_Neutral()
			Curie_Likes()
			Danse_Neutral()
			Deacon_Likes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Neutral()
			Valentine_Neutral()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_MS16 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_MS17(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == MS17
		if eventID == 1
		; STAGE 90 on Quest MS17
		; DESCRIPTION: The player somehow gets into Covenant without taking their SAFE test up front. This
		; causes the whole town to go hostile. Most likely occurs when the player jump jets over the wall.
			Cait_Likes()
			Codsworth_Neutral()
			Curie_Dislikes()
			Danse_Neutral()
			Deacon_Dislikes()
			Hancock_Dislikes()
			MacCready_Likes()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Neutral()

		elseif eventID == 2
		; STAGE 450 on Quest MS17
		; DESCRIPTION: Doctor Chambers has been torturing people to perfect her Synth detection test. She has
		; killed a lot of innocent people and Synths in the process. She is unrepentent when confronted. She
		; will not attack the player, but the player shoots her (there is no quest objective to do so).
			Cait_Likes()
			Codsworth_Neutral()
			Curie_Dislikes()
			Danse_Neutral()
			Deacon_Likes()
			Hancock_Loves()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Likes()
			Strong_Likes()
			Valentine_Likes()
			X688_Likes()

		elseif eventID == 3
		; STAGE 490 on Quest MS17
		; DESCRIPTION: Amelia Stockton was imprisoned by Covenant. They've been torturing her to try and get
		; her to confess she's a Synth. She hasn't confessed yet - though Doctor Chambers was convinced she's
		; a Synth. For this event the player kills Amelia Stockton instead of rescuing her.
			Cait_Neutral()
			Codsworth_Hates()
			Curie_Hates()
			Danse_Dislikes()
			Deacon_Hates()
			Hancock_Hates()
			MacCready_Neutral()
			Piper_Hates()
			Preston_Hates()
			Strong_Likes()
			Valentine_Hates()
			X688_Hates()			
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_MS17 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_RECampLC01(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RECampLC01
		if eventID == 1
		; STAGE 96 on Quest RECampLC01
		; DESCRIPTION: Player has encountered two humans threatening to kill a runaway Synth. The player
		; attacked the Synth.
			Cait_Likes()
			Codsworth_Neutral()
			Curie_Dislikes()
			Danse_Loves()
			Deacon_Hates()
			Hancock_Hates()
			MacCready_Likes()
			Piper_Hates()
			Preston_Dislikes()
			Strong_Likes()
			Valentine_Hates()
			X688_Hates()

		elseif eventID == 2
		; STAGE 97 on Quest RECampLC01
		; DESCRIPTION: Player has encounter two people threatening to kill someone (player doesn't know he's
		; a Synth). Player has attacked the person being threatened.
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Neutral()
			Hancock_Dislikes()
			MacCready_Dislikes()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Neutral()

		elseif eventID == 3
		; STAGE 601 on Quest RECampLC01
		; DESCRIPTION: Player has encountered two humans threatening to kill a runaway Synth. The player
		; attacked the people threatening the Synth.
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Hates()
			Deacon_Likes()
			Hancock_Loves()
			MacCready_Dislikes()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Loves()

		elseif eventID == 4
		; STAGE 602 on Quest RECampLC01
		; DESCRIPTION: Player has encounter two people threatening to kill someone (player doesn't know he's
		; a Synth). Player has attacked the aggressors.
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Neutral()
			Hancock_Likes()
			MacCready_Dislikes()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Neutral()			
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_RECampLC01 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_RESceneLC01(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RESceneLC01
		if eventID == 1
		; STAGE 111 on Quest RESceneLC01
		; DESCRIPTION: Player has come across two men with the same face, both claiming the other is a
		; Synth. The player has uncovered which is the Synth and attacked him 
			Cait_Likes()
			Codsworth_Neutral()
			Curie_Dislikes()
			Danse_Loves()
			Deacon_Dislikes()
			Hancock_Likes()
			MacCready_Likes()
			Piper_Likes()
			Preston_Likes()
			Strong_Likes()
			Valentine_Likes()
			X688_Hates()

		elseif eventID == 2
		; STAGE 112 on Quest RESceneLC01
		; DESCRIPTION: Player has come across two men with the same face, both claiming the other is a
		; Synth. Player has attacked the hostage (but player doesn't know whether or not the man is
		; actually a Synth)
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Dislikes()
			Hancock_Dislikes()
			MacCready_Neutral()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Neutral()

		elseif eventID == 3
		; STAGE 121 on Quest RESceneLC01
		; DESCRIPTION: Player has come across two men with the same face, both claiming the other is a
		; Synth. The player has uncovered which is the Synth and attacked the man holding him prisoner
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Neutral()
			Danse_Hates()
			Deacon_Likes()
			Hancock_Hates()
			MacCready_Dislikes()
			Piper_Hates()
			Preston_Hates()
			Strong_Likes()
			Valentine_Hates()
			X688_Loves()

		elseif eventID == 4
		; STAGE 122 on Quest RESceneLC01
		; DESCRIPTION: Player has come across two men with the same face, both claiming the other is a
		; Synth. Player has attacked the man holding the gun (but player doesn't know whether or not the
		; man is actually a Synth)
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Dislikes()
			Hancock_Dislikes()
			MacCready_Neutral()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_RESceneLC01 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_RR101(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RR101
		if eventID == 1
		; STAGE 130 on Quest RR101
		; DESCRIPTION: There is a simple tourist robot at Boston Common that spouts tourtist information.
		; For no real reason the player blows it up.
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Dislikes()
			Deacon_Dislikes()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Dislikes()
			Preston_Neutral()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Neutral()

		elseif eventID == 2
		; STAGE 609 on Quest RR101
		; DESCRIPTION: The player meets the Railroad and is told by Desdemona to "Stop right there."
		; The player moves and is warned again. Then continues moving provoking the Railroad into
		; firing on him.
			Cait_Likes()
			Codsworth_Dislikes()
			Curie_Dislikes()
			Danse_Loves()
			Deacon_Hates()
			Hancock_Dislikes()
			MacCready_Likes()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Likes()
			Valentine_Dislikes()
			X688_Loves()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_RR101 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_RR102(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RR102
		if eventID == 1
		; STAGE 800 on Quest RR102
		; DESCRIPTION: The player has just joined the Railroad.
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Likes()
			Danse_Hates()
			Deacon_Loves()
			Hancock_Likes()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Neutral()
			Strong_Neutral()
			Valentine_Likes()
			X688_Hates()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_RR102 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_RR201(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RR201
		if eventID == 1 || eventID == 2 || eventID == 3 || eventID == 4 || eventID == 5 || eventID == 6 
		; STAGE 300, 350, 375, 600, 700, 750 on Quest RR201
		; DESCRIPTION: The player has just joined the Railroad.
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Neutral()
			Danse_Neutral()
			Deacon_Neutral()
			Hancock_Neutral()
			MacCready_Neutral()
			Piper_Neutral()
			Preston_Neutral()
			Strong_Neutral()
			Valentine_Neutral()
			X688_Hates()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_RR201 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_RR303(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RR303
		if eventID == 1
		; STAGE 940 on Quest RR303
		; DESCRIPTION: The Railroad is trying to destroy the Prydwen. A disguised player has just manages to fast
		; talk the Brotherhood people in dialog. So the player can walk freely on the ship instead of fighting.
		; Very smooth, player.
			Cait_Likes()
			Codsworth_Neutral()
			Curie_Likes()
			Danse_Hates()
			Deacon_Loves()
			Hancock_Neutral()
			MacCready_Loves()
			Piper_Likes()
			Preston_Likes()
			Strong_Hates()
			Valentine_Likes()
			X688_Dislikes()

		elseif eventID == 2
		; STAGE 1150 on Quest RR303
		; DESCRIPTION: The player just blew up the Prydwen for the Railroad.
			Cait_Neutral(CheckCompanionProximity = false)
			Codsworth_Neutral(CheckCompanionProximity = false)
			Curie_Dislikes(CheckCompanionProximity = false)
			Danse_Hates(CheckCompanionProximity = false)
			Deacon_Loves(CheckCompanionProximity = false)
			Hancock_Likes(CheckCompanionProximity = false)
			MacCready_Neutral(CheckCompanionProximity = false)
			Piper_Likes(CheckCompanionProximity = false)
			Preston_Loves(CheckCompanionProximity = false)
			Strong_Loves(CheckCompanionProximity = false)
			Valentine_Likes(CheckCompanionProximity = false)
			X688_Loves(CheckCompanionProximity = false)
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_RR303 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_RRAct3PickUp(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RRAct3PickUp
		if eventID == 1
		; STAGE 100 on Quest RRAct3PickUp
		; DESCRIPTION: After the player went to the Institute for the Minutemen or Brotherhood of Steel,
		; he visits the Railroad. The player makes a deal to infiltrate the Institute for the Railroad.
			Cait_Neutral()
			Codsworth_Neutral()
			Curie_Dislikes()
			Danse_Hates()
			Deacon_Loves()
			Hancock_Likes()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Neutral()
			Strong_Dislikes()
			Valentine_Likes()
			X688_Hates()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_RRAct3PickUp got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_RRM01(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RRM01
		if eventID == 1
		; STAGE 700 on Quest RRM01
		; DESCRIPTION: The player helped escort a bewildered Synth through the streets of Charlestown to
		; make it to a new place of safety - Ticonderoga Station.
			Cait_Dislikes()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Hates()
			Deacon_Likes()
			Hancock_Likes()
			MacCready_Dislikes()
			Piper_Likes()
			Preston_Likes()
			Strong_Dislikes()
			Valentine_Likes()
			X688_Hates()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_RRM01 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_RRM02(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RRM02
		if eventID == 1
		; STAGE 350 on Quest RRM02
		; DESCRIPTION: Same case as RRM02/360, instead the player decides to go with Glory.
			Cait_Dislikes()
			Codsworth_Neutral()
			Curie_Likes()
			Danse_Neutral()
			Deacon_Likes()
			Hancock_Likes()
			MacCready_Dislikes()
			Piper_Likes()
			Preston_Likes()
			Strong_Likes()
			Valentine_Likes()
			X688_Neutral()

		elseif eventID == 2
		; STAGE 360 on Quest RRM02
		; DESCRIPTION: At Malden Center, the player bumps into the Railroad's second combat effective
		; member, Glory. The player refuses to join forces with Glory to clear out Malden Center of hostiles.
			Cait_Likes()
			Codsworth_Neutral()
			Curie_Dislikes()
			Danse_Neutral()
			Deacon_Dislikes()
			Hancock_Dislikes()
			MacCready_Likes()
			Piper_Dislikes()
			Preston_Dislikes()
			Strong_Dislikes()
			Valentine_Dislikes()
			X688_Neutral()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_RRM02 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_RRR04(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RRR04
		if eventID == 1
		; STAGE 300 on Quest RRR04
		; DESCRIPTION: The player just pacified an area, built defenses, and made a new Railroad Safehouse
		; called Mercer.
			Cait_Neutral()
			Codsworth_Likes()
			Curie_Neutral()
			Danse_Hates()
			Deacon_Likes()
			Hancock_Likes()
			MacCready_Neutral()
			Piper_Neutral()
			Preston_Likes()
			Strong_Neutral()
			Valentine_Likes()
			X688_Dislikes()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_RRR04 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_RRR08(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == RRR08
		if eventID == 1
		; STAGE 250 on Quest RRR08
		; DESCRIPTION: The L&L gang is a loose collection of very dangerous raiders that despise Synths
		; especially. The very last member of their gang is killed and the greatest remaining threat to the
		; Railroad is finally dealt with.
			Cait_Likes()
			Codsworth_Likes()
			Curie_Likes()
			Danse_Dislikes()
			Deacon_Loves()
			Hancock_Loves()
			MacCready_Neutral()
			Piper_Likes()
			Preston_Loves()
			Strong_Likes()
			Valentine_Loves()
			X688_Likes()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_RRR08 got event from wrong quest " + eventQuest)
	endif
endFunction

function HandleQuestStageBump_V81_01(Quest eventQuest, int eventID)
	 ; double-check that this is the right quest
	if eventQuest == V81_01
		if eventID == 1
		; STAGE 400 on Quest V81_01
		; DESCRIPTION: Vault 81. An innocent child in Vault 81, Erin, has asked the player to find her
		; sweet cat who ran off into the Commonwealth. This bump fires if the Player finds the cat, but
		; chooses to be cruel and kill it instead of having it go back to Erin. The player would be
		; intentionally killing the cat in order for this to trigger (unless they accentally hit the wrong
		; button).
			Cait_Likes()
			Codsworth_Hates()
			Curie_Dislikes()
			Danse_Hates()
			Deacon_Hates()
			Hancock_Dislikes()
			MacCready_Dislikes()
			Piper_Hates()
			Preston_Dislikes()
			Strong_Likes()
			Valentine_Hates()
			X688_Likes()
		endif
	else
		debug.trace(self + "WARNING - HandleQuestStageBump_V81_01 got event from wrong quest " + eventQuest)
	endif
endFunction
