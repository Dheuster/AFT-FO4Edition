;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AFT:Fragments:Quests:QF__0100ED9E_2 Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0050_Item_00
Function Fragment_Stage_0050_Item_00()
;BEGIN CODE
; Then get her to follow
FollowersScript.GetScript().SetCompanion(Alias_Curie.GetActorReference())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0080_Item_00
Function Fragment_Stage_0080_Item_00()
;BEGIN CODE
; Set up as a companion
actor aCurie = Alias_Curie.GetActorReference()
FollowersScript.GetScript().SetCompanion(aCurie)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0082_Item_00
Function Fragment_Stage_0082_Item_00()
;BEGIN CODE
; Curie now moves to her spot
Alias_Curie.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0083_Item_00
Function Fragment_Stage_0083_Item_00()
;BEGIN CODE
; Let the player know she's a companion
Alias_Curie.GetActorRef().SetAvailableToBeCompanion()

; Start the scene
pCOMCurie_PickUpScene_Initial.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0085_Item_00
Function Fragment_Stage_0085_Item_00()
;BEGIN AUTOCAST TYPE COMCurieScript
Quest __temp = self as Quest
COMCurieScript kmyQuest = __temp as COMCurieScript
;END AUTOCAST
;BEGIN CODE
; Check to see when the player leaves Vault 81
kmyQuest.RegisterLocationChange()

; Now make her join
SetStage(80)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0090_Item_00
Function Fragment_Stage_0090_Item_00()
;BEGIN CODE
debug.trace(self + "Stage 90")
FollowersScript.GetScript().DismissCompanion(Alias_Curie.GetActorReference())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0110_Item_00
Function Fragment_Stage_0110_Item_00()
;BEGIN CODE
Alias_Curie.TryToSetActorValue(CA_WantsToTalk, 2)
Alias_Curie.GetActorReference().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0120_Item_00
Function Fragment_Stage_0120_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneHatred()
Alias_Curie.GetActorReference().DisallowCompanion(SuppressDismissMessage = true)
(Alias_Curie.GetActorReference() as CompanionActorScript).SetHasLeftPlayerPermanently()

; And kill her quest
pCOMCurieQuest.SetStage(9000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0130_Item_00
Function Fragment_Stage_0130_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneHatred()
(Alias_Curie.GetActorReference() as CompanionActorScript).SetAffinityBetweenThresholds(CA_T5_Hatred, CA_T4_Disdain)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0150_Item_00
Function Fragment_Stage_0150_Item_00()
;BEGIN CODE
Alias_Curie.TryToSetActorValue(CA_WantsToTalk, 2) ;has forcegreeted
Alias_Curie.GetActorReference().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0160_Item_00
Function Fragment_Stage_0160_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneHatred()
FollowersScript.GetScript().DisallowCompanion(Alias_Curie.GetActorReference(), SuppressDismissMessage = true)
(Alias_Curie.GetActorReference() as CompanionActorScript).SetHasLeftPlayerPermanently()


; And kill her quest
pCOMCurieQuest.SetStage(9000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0210_Item_00
Function Fragment_Stage_0210_Item_00()
;BEGIN CODE
Alias_Curie.TryToSetActorValue(CA_WantsToTalk, 2)
Alias_Curie.GetActorReference().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0220_Item_00
Function Fragment_Stage_0220_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneDisdain()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0240_Item_00
Function Fragment_Stage_0240_Item_00()
;BEGIN CODE
Alias_Curie.TryToSetActorValue(CA_WantsToTalk, 2)
Alias_Curie.GetActorReference().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0250_Item_00
Function Fragment_Stage_0250_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneDisdain()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0320_Item_00
Function Fragment_Stage_0320_Item_00()
;BEGIN CODE
Alias_Curie.TryToSetActorValue(CA_WantsToTalk, 2)
Alias_Curie.GetActorReference().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0330_Item_00
Function Fragment_Stage_0330_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneNeutral()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0350_Item_00
Function Fragment_Stage_0350_Item_00()
;BEGIN CODE
Alias_Curie.TryToSetActorValue(CA_WantsToTalk, 2)
Alias_Curie.GetActorReference().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0360_Item_00
Function Fragment_Stage_0360_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneNeutral()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0406_Item_00
Function Fragment_Stage_0406_Item_00()
;BEGIN CODE
Alias_Curie.TryToSetActorValue(CA_WantsToTalk, 2)
Alias_Curie.GetActorReference().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0407_Item_00
Function Fragment_Stage_0407_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneFriend()

; Start up "Emergent Behavior" quest
pCOMCurieQuest.SetStage(100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0410_Item_00
Function Fragment_Stage_0410_Item_00()
;BEGIN CODE
Alias_Curie.TryToSetActorValue(CA_WantsToTalk, 2)
Alias_Curie.GetActorReference().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0420_Item_00
Function Fragment_Stage_0420_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneAdmiration()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0440_Item_00
Function Fragment_Stage_0440_Item_00()
;BEGIN CODE
Alias_Curie.TryToSetActorValue(CA_WantsToTalk, 2)
Alias_Curie.GetActorReference().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0450_Item_00
Function Fragment_Stage_0450_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneAdmiration()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0470_Item_00
Function Fragment_Stage_0470_Item_00()
;BEGIN CODE
Alias_Curie.TryToSetActorValue(CA_WantsToTalk, 2)
Alias_Curie.GetActorReference().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0480_Item_00
Function Fragment_Stage_0480_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneAdmiration()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0496_Item_00
Function Fragment_Stage_0496_Item_00()
;BEGIN CODE
Alias_Curie.TryToSetActorValue(CA_WantsToTalk, 2)
Alias_Curie.GetActorReference().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0497_Item_00
Function Fragment_Stage_0497_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneConfidant()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0510_Item_00
Function Fragment_Stage_0510_Item_00()
;BEGIN CODE
Alias_Curie.TryToSetActorValue(CA_WantsToTalk, 2)
Alias_Curie.GetActorReference().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0520_Item_00
Function Fragment_Stage_0520_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneInfatuation()
kmyquest.UnlockedInfatuation()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0525_Item_00
Function Fragment_Stage_0525_Item_00()
;BEGIN CODE
(Alias_Curie.GetActorReference() as CompanionActorScript).SetAffinityBetweenThresholds(CA_T1_Infatuation, CA_T2_Admiration)
Alias_Curie.TryToSetActorValue(CA_WantsToTalk, 0)
Alias_Curie.GetActorReference().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0540_Item_00
Function Fragment_Stage_0540_Item_00()
;BEGIN CODE
Alias_Curie.TryToSetActorValue(CA_WantsToTalk, 2)
Alias_Curie.GetActorReference().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0550_Item_00
Function Fragment_Stage_0550_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneInfatuation()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0560_Item_00
Function Fragment_Stage_0560_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneInfatuation()
(Alias_Curie.GetActorRef() as CompanionActorScript).RomanceDeclined(isPermanent = false)
; And flag that the Infatuation Scene is complete
SetStage(520)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0565_Item_00
Function Fragment_Stage_0565_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneInfatuation()
(Alias_Curie.GetActorRef() as CompanionActorScript).RomanceFail()
kmyquest.UnlockedInfatuation()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0570_Item_00
Function Fragment_Stage_0570_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneInfatuation()
(Alias_Curie.GetActorRef() as CompanionActorScript).RomanceDeclined(isPermanent = true)
kmyquest.UnlockedInfatuation()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0575_Item_00
Function Fragment_Stage_0575_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneInfatuation()
(Alias_Curie.GetActorRef() as CompanionActorScript).RomanceSuccess()
; Flag that Curie is in love with the PC (this was a Curie specific flag before the system supported it)
COMCurieIsInLove.SetValue(1)
kmyquest.UnlockedInfatuation()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0600_Item_00
Function Fragment_Stage_0600_Item_00()
;BEGIN CODE
Alias_Curie.TryToSetActorValue(CA_WantsToTalk, 1)
Alias_Curie.GetActorReference().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0610_Item_00
Function Fragment_Stage_0610_Item_00()
;BEGIN CODE
Alias_Curie.TryToSetActorValue(CA_WantsToTalk, 2)
Alias_Curie.GetActorReference().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0620_Item_00
Function Fragment_Stage_0620_Item_00()
;BEGIN CODE
Alias_Curie.TryToSetActorValue(CA_WantsToTalk, 0) ;done wanting to talk - scene resolved
Alias_Curie.GetActorReference().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0625_Item_00
Function Fragment_Stage_0625_Item_00()
;BEGIN CODE
; lower affinity to 10% above Admiration
(Alias_Curie.GetActorReference() as CompanionActorScript).SetAffinityTowardNextLowestThreshold(0.9)
setStage(620)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property Alias_Curie Auto Const

ActorValue Property CA_WantsToTalk Auto Const

GlobalVariable Property CA_T5_Hatred Auto Const

GlobalVariable Property CA_T4_Disdain Auto Const

GlobalVariable Property CA_T1_Infatuation Auto Const

GlobalVariable Property CA_T2_Admiration Auto Const

GlobalVariable Property COMCurieIsInLove Auto Const

Quest Property pCOMCurieQuest Auto Const

ReferenceAlias Property Alias_CurieSynth Auto Const

GlobalVariable Property pCOMCurieIsSynth Auto Const

ActorValue Property CA_WantsToTalkMurder Auto Const Mandatory

Scene Property pCOMCurie_PickUpScene_Initial Auto Const Mandatory
