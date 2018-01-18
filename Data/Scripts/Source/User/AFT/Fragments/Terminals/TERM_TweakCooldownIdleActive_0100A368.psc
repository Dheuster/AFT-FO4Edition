;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AFT:Fragments:Terminals:TERM_TweakCooldownIdleActive_0100A368 Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
pTweakIdleCooldownActiveMin.SetValue(120)
pTweakIdleCooldownActiveMax.SetValue(180)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
pTweakIdleCooldownActiveMin.SetValue(240)
pTweakIdleCooldownActiveMax.SetValue(300)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_03
Function Fragment_Terminal_03(ObjectReference akTerminalRef)
;BEGIN CODE
pTweakIdleCooldownActiveMin.SetValue(480)
pTweakIdleCooldownActiveMax.SetValue(600)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_04
Function Fragment_Terminal_04(ObjectReference akTerminalRef)
;BEGIN CODE
pTweakIdleCooldownActiveMin.SetValue(600)
pTweakIdleCooldownActiveMax.SetValue(780)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_05
Function Fragment_Terminal_05(ObjectReference akTerminalRef)
;BEGIN CODE
pTweakIdleCooldownActiveMin.SetValue(780)
pTweakIdleCooldownActiveMax.SetValue(960)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_06
Function Fragment_Terminal_06(ObjectReference akTerminalRef)
;BEGIN CODE
pTweakIdleCooldownActiveMin.SetValue(960)
pTweakIdleCooldownActiveMax.SetValue(1200)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property pTweakIdleCooldownActiveMin Auto Const

GlobalVariable Property pTweakIdleCooldownActiveMax Auto Const
