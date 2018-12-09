;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AFT:Fragments:Quests:QF_TweakCOMSpouse_0104529E Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0030_Item_00
Function Fragment_Stage_0030_Item_00()
;BEGIN AUTOCAST TYPE aft:tweakcomspousescript
Quest __temp = self as Quest
aft:tweakcomspousescript kmyQuest = __temp as aft:tweakcomspousescript
;END AUTOCAST
;BEGIN CODE
kmyQuest.EnableMS19()
kmyQuest.RescueSpouse()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0035_Item_00
Function Fragment_Stage_0035_Item_00()
;BEGIN AUTOCAST TYPE aft:tweakcomspousescript
Quest __temp = self as Quest
aft:tweakcomspousescript kmyQuest = __temp as aft:tweakcomspousescript
;END AUTOCAST
;BEGIN CODE
kmyQuest.ExplainPast()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0036_Item_00
Function Fragment_Stage_0036_Item_00()
;BEGIN AUTOCAST TYPE aft:tweakcomspousescript
Quest __temp = self as Quest
aft:tweakcomspousescript kmyQuest = __temp as aft:tweakcomspousescript
;END AUTOCAST
;BEGIN CODE
; This will kick off the Curie Comment Scene
kmyQuest.ExplainPastFinished()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0037_Item_00
Function Fragment_Stage_0037_Item_00()
;BEGIN AUTOCAST TYPE aft:tweakcomspousescript
Quest __temp = self as Quest
aft:tweakcomspousescript kmyQuest = __temp as aft:tweakcomspousescript
;END AUTOCAST
;BEGIN CODE
kmyQuest.RescueSpouseCurieCommentFinished()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0038_Item_00
Function Fragment_Stage_0038_Item_00()
;BEGIN AUTOCAST TYPE aft:tweakcomspousescript
Quest __temp = self as Quest
aft:tweakcomspousescript kmyQuest = __temp as aft:tweakcomspousescript
;END AUTOCAST
;BEGIN CODE
kmyQuest.ExitVaultReactionFinished()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0039_Item_00
Function Fragment_Stage_0039_Item_00()
;BEGIN AUTOCAST TYPE aft:tweakcomspousescript
Quest __temp = self as Quest
aft:tweakcomspousescript kmyQuest = __temp as aft:tweakcomspousescript
;END AUTOCAST
;BEGIN CODE
kmyQuest.ExitVaultReactionFinished()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0080_Item_00
Function Fragment_Stage_0080_Item_00()
;BEGIN CODE
FollowersScript.GetScript().SetCompanion(Alias_Spouse.GetActorReference())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0090_Item_00
Function Fragment_Stage_0090_Item_00()
;BEGIN CODE
FollowersScript.GetScript().DismissCompanion(Alias_Spouse.GetActorReference())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0110_Item_00
Function Fragment_Stage_0110_Item_00()
;BEGIN CODE
; Alias_Spouse.TryToSetActorValue(CA_WantsToTalk, 2) ;has forcegreeted
; Alias_Spouse.GetActorReference().EvaluatePackage()
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
Alias_Spouse.GetActorReference().SetValue(CA_AffinitySceneToPlay,0)

; Alias_Spouse.GetActorReference().DisallowCompanion(SuppressDismissMessage = true)
; (Alias_Spouse.GetActorReference() as CompanionActorScript).SetHasLeftPlayerPermanently()
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
(Alias_Spouse.GetActorReference() as CompanionActorScript).SetAffinityBetweenThresholds(CA_T5_Hatred, CA_T4_Disdain)
Alias_Spouse.GetActorReference().SetValue(CA_AffinitySceneToPlay,0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0150_Item_00
Function Fragment_Stage_0150_Item_00()
;BEGIN CODE
; Alias_Spouse.TryToSetActorValue(CA_WantsToTalk, 2) ;has forcegreeted
; Alias_Spouse.GetActorReference().EvaluatePackage()
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
Alias_Spouse.GetActorReference().SetValue(CA_AffinitySceneToPlay,0)
; FollowersScript.GetScript().DisallowCompanion(Alias_Spouse.GetActorReference(), SuppressDismissMessage = true)
; (Alias_Spouse.GetActorReference() as CompanionActorScript).SetHasLeftPlayerPermanently()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0210_Item_00
Function Fragment_Stage_0210_Item_00()
;BEGIN CODE
; Alias_Spouse.TryToSetActorValue(CA_WantsToTalk, 2) ;has forcegreeted
; Alias_Spouse.GetActorReference().EvaluatePackage()
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
Alias_Spouse.GetActorReference().SetValue(CA_AffinitySceneToPlay,0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0240_Item_00
Function Fragment_Stage_0240_Item_00()
;BEGIN CODE
; Alias_Spouse.TryToSetActorValue(CA_WantsToTalk, 2) ;has forcegreeted
; Alias_Spouse.GetActorReference().EvaluatePackage()
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
Alias_Spouse.GetActorReference().SetValue(CA_AffinitySceneToPlay,0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0320_Item_00
Function Fragment_Stage_0320_Item_00()
;BEGIN CODE
;Alias_Spouse.TryToSetActorValue(CA_WantsToTalk, 2) ;has forcegreeted
;Alias_Spouse.GetActorReference().EvaluatePackage()
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
Alias_Spouse.GetActorReference().SetValue(CA_AffinitySceneToPlay,0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0350_Item_00
Function Fragment_Stage_0350_Item_00()
;BEGIN CODE
;Alias_Spouse.TryToSetActorValue(CA_WantsToTalk, 2) ;has forcegreeted
;Alias_Spouse.GetActorReference().EvaluatePackage()
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
Alias_Spouse.GetActorReference().SetValue(CA_AffinitySceneToPlay,0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0406_Item_00
Function Fragment_Stage_0406_Item_00()
;BEGIN CODE
;Alias_Spouse.TryToSetActorValue(CA_WantsToTalk, 2) ;has forcegreeted
;Alias_Spouse.GetActorReference().EvaluatePackage()
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
Alias_Spouse.GetActorReference().SetValue(CA_AffinitySceneToPlay,0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0410_Item_00
Function Fragment_Stage_0410_Item_00()
;BEGIN CODE
;Alias_Spouse.TryToSetActorValue(CA_WantsToTalk, 2) ;has forcegreeted
;Alias_Spouse.GetActorReference().EvaluatePackage()
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
Alias_Spouse.GetActorReference().SetValue(CA_AffinitySceneToPlay,0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0440_Item_00
Function Fragment_Stage_0440_Item_00()
;BEGIN CODE
;Alias_Spouse.TryToSetActorValue(CA_WantsToTalk, 2) ;has forcegreeted
;Alias_Spouse.GetActorReference().EvaluatePackage()
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
Alias_Spouse.GetActorReference().SetValue(CA_AffinitySceneToPlay,0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0470_Item_00
Function Fragment_Stage_0470_Item_00()
;BEGIN CODE
;Alias_Spouse.TryToSetActorValue(CA_WantsToTalk, 2) ;has forcegreeted
;Alias_Spouse.GetActorReference().EvaluatePackage()
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
Alias_Spouse.GetActorReference().SetValue(CA_AffinitySceneToPlay,0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0496_Item_00
Function Fragment_Stage_0496_Item_00()
;BEGIN CODE
;Alias_Spouse.TryToSetActorValue(CA_WantsToTalk, 2) ;has forcegreeted
;Alias_Spouse.GetActorReference().EvaluatePackage()
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
Alias_Spouse.GetActorReference().SetValue(CA_AffinitySceneToPlay,0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0510_Item_00
Function Fragment_Stage_0510_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
;Alias_Spouse.TryToSetActorValue(CA_WantsToTalk, 2) ;has forcegreeted

;; Added until we do this properly
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0515_Item_00
Function Fragment_Stage_0515_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneInfatuation()
(Alias_Spouse.GetActorRef() as CompanionActorScript).RomanceDeclined(isPermanent = false)
kmyquest.UnlockedInfatuation()
Alias_Spouse.GetActorReference().SetValue(CA_AffinitySceneToPlay,0)
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
(Alias_Spouse.GetActorRef() as CompanionActorScript).RomanceFail()
kmyquest.UnlockedInfatuation()
Alias_Spouse.GetActorReference().SetValue(CA_AffinitySceneToPlay,0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0522_Item_00
Function Fragment_Stage_0522_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneInfatuation()
(Alias_Spouse.GetActorRef() as CompanionActorScript).RomanceDeclined(isPermanent = true)
kmyquest.UnlockedInfatuation()
Alias_Spouse.GetActorReference().SetValue(CA_AffinitySceneToPlay,0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0525_Item_00
Function Fragment_Stage_0525_Item_00()
;BEGIN AUTOCAST TYPE affinityscenehandlerscript
Quest __temp = self as Quest
affinityscenehandlerscript kmyQuest = __temp as affinityscenehandlerscript
;END AUTOCAST
;BEGIN CODE
kmyquest.EndSceneInfatuation()
(Alias_Spouse.GetActorRef() as CompanionActorScript).RomanceSuccess()
kmyquest.UnlockedInfatuation()
Alias_Spouse.GetActorReference().SetValue(CA_AffinitySceneToPlay,0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0540_Item_00
Function Fragment_Stage_0540_Item_00()
;BEGIN CODE
; Alias_Spouse.TryToSetActorValue(CA_WantsToTalk, 2) ;has forcegreeted
; Alias_Spouse.GetActorReference().EvaluatePackage()
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
Alias_Spouse.GetActorReference().SetValue(CA_AffinitySceneToPlay,0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0600_Item_00
Function Fragment_Stage_0600_Item_00()
;BEGIN CODE
; Alias_Spouse.TryToSetActorValue(CA_WantsToTalkMurder, 1)
; Alias_Spouse.GetActorReference().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0610_Item_00
Function Fragment_Stage_0610_Item_00()
;BEGIN CODE
; Alias_Spouse.TryToSetActorValue(CA_WantsToTalkMurder, 2) ;has forcegreeted
; Alias_Spouse.GetActorReference().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0620_Item_00
Function Fragment_Stage_0620_Item_00()
;BEGIN CODE
; Alias_Spouse.TryToSetActorValue(CA_WantsToTalkMurder, 0) ;done wanting to talk - scene resolved
; Alias_Spouse.GetActorReference().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0640_Item_00
Function Fragment_Stage_0640_Item_00()
;BEGIN AUTOCAST TYPE aft:tweakcomspousescript
Quest __temp = self as Quest
aft:tweakcomspousescript kmyQuest = __temp as aft:tweakcomspousescript
;END AUTOCAST
;BEGIN CODE
kmyQuest.FinishSpouseConvo()
Alias_Spouse.GetActorReference().SetValue(CA_AffinitySceneToPlay,0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0650_Item_00
Function Fragment_Stage_0650_Item_00()
;BEGIN AUTOCAST TYPE aft:tweakcomspousescript
Quest __temp = self as Quest
aft:tweakcomspousescript kmyQuest = __temp as aft:tweakcomspousescript
;END AUTOCAST
;BEGIN CODE
kmyQuest.FinishSpouseConvo()
Alias_Spouse.GetActorReference().SetValue(CA_AffinitySceneToPlay,0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0660_Item_00
Function Fragment_Stage_0660_Item_00()
;BEGIN AUTOCAST TYPE aft:tweakcomspousescript
Quest __temp = self as Quest
aft:tweakcomspousescript kmyQuest = __temp as aft:tweakcomspousescript
;END AUTOCAST
;BEGIN CODE
kmyQuest.FinishSpouseConvo()
Alias_Spouse.GetActorReference().SetValue(CA_AffinitySceneToPlay,0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0670_Item_00
Function Fragment_Stage_0670_Item_00()
;BEGIN CODE
Alias_Spouse.GetActorReference().SetValue(MQ302Companion,0)
Alias_Spouse.TryToSetActorValue(CA_WantsToTalk, 0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0700_Item_00
Function Fragment_Stage_0700_Item_00()
;BEGIN CODE
pTweakOutOfTime.Show()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property Alias_Nora Auto Const

ActorValue Property CA_WantsToTalk Auto Const

ActorValue Property CA_WantsToTalkMurder Auto Const

GlobalVariable Property CA_T5_Hatred Auto Const

GlobalVariable Property CA_T4_Disdain Auto Const

Message Property pTweakOutOfTime Auto Const

Scene Property TweakCOMSpouseRescueHelperBootstrap Auto Const

ReferenceAlias Property Alias_Spouse Auto Const

ActorValue Property CA_AffinitySceneToPlay Auto Const

ActorValue Property FollowerEndgameForceGreetOn Auto Const

ActorValue Property MQ302Companion Auto Const
