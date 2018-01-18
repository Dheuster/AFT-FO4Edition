;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AFT:Fragments:Terminals:TERM_TweakCooldownIdleDismis_0100A369 Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
pTweakIdleCooldownDismissedMin.SetValue(240)
pTweakIdleCooldownDismissedMax.SetValue(480)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
pTweakIdleCooldownDismissedMin.SetValue(480)
pTweakIdleCooldownDismissedMax.SetValue(720)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_03
Function Fragment_Terminal_03(ObjectReference akTerminalRef)
;BEGIN CODE
pTweakIdleCooldownDismissedMin.SetValue(720)
pTweakIdleCooldownDismissedMax.SetValue(960)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_04
Function Fragment_Terminal_04(ObjectReference akTerminalRef)
;BEGIN CODE
pTweakIdleCooldownDismissedMin.SetValue(960)
pTweakIdleCooldownDismissedMax.SetValue(1200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_05
Function Fragment_Terminal_05(ObjectReference akTerminalRef)
;BEGIN CODE
pTweakIdleCooldownDismissedMin.SetValue(1200)
pTweakIdleCooldownDismissedMax.SetValue(1800)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_06
Function Fragment_Terminal_06(ObjectReference akTerminalRef)
;BEGIN CODE
pTweakIdleCooldownDismissedMin.SetValue(1800)
pTweakIdleCooldownDismissedMax.SetValue(3600)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property pTweakIdleCooldownDismissedMin Auto Const

GlobalVariable Property pTweakIdleCooldownDismissedMax Auto Const
