;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AFT:Fragments:Terminals:TERM_TweakSettlementTerminal_0105F9CA Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_56
Function Fragment_Terminal_56(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript TweakPipBoy = pTweakPipBoy as AFT:TweakPipBoyScript
if pTweakPipBoy
    TweakPipBoy.ResetBuildLimit()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_57
Function Fragment_Terminal_57(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript PipBoyScript = pTweakPipBoy as AFT:TweakPipBoyScript
if PipBoyScript
    PipBoyScript.StartPrefab()
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property pTweakSettlementLoader Auto Const

Quest Property pTweakPipBoy Auto Const
