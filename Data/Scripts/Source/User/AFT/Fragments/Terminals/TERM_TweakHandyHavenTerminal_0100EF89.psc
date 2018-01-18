;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AFT:Fragments:Terminals:TERM_TweakHandyHavenTerminal_0100EF89 Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript PipBoyScript = pTweakPipBoy as AFT:TweakPipBoyScript
if PipBoyScript
    PipBoyScript.BuildFullPrefab()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript PipBoyScript = pTweakPipBoy as AFT:TweakPipBoyScript
if PipBoyScript
    PipBoyScript.BuildWallOnlyPrefab()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_03
Function Fragment_Terminal_03(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript PipBoyScript = pTweakPipBoy as AFT:TweakPipBoyScript
 if PipBoyScript
    PipBoyScript.NextPrefab()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_04
Function Fragment_Terminal_04(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript PipBoyScript = pTweakPipBoy as AFT:TweakPipBoyScript
if PipBoyScript
    PipBoyScript.PrevPrefab()
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property pTweakPipBoy Auto Const
