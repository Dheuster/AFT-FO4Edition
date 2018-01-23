;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AFT:Fragments:Terminals:TERM_TweakCoolDownAutoRelaxT_01007CA5 Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy as AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
    pTweakPipBoyScript.SetLoiterCooldown(30.0)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy as AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
    pTweakPipBoyScript.SetLoiterCooldown(45.0)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_03
Function Fragment_Terminal_03(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy as AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
    pTweakPipBoyScript.SetLoiterCooldown(60.0)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_04
Function Fragment_Terminal_04(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy as AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
    pTweakPipBoyScript.SetLoiterCooldown(75.0)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_05
Function Fragment_Terminal_05(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy as AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
    pTweakPipBoyScript.SetLoiterCooldown(90.0)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_06
Function Fragment_Terminal_06(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy as AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
    pTweakPipBoyScript.SetLoiterCooldown(105.0)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_07
Function Fragment_Terminal_07(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy as AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
    pTweakPipBoyScript.SetLoiterCooldown(120.0)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property pTweakLoiterCooldown Auto Const

Quest Property pTweakPipBoy Auto Const
