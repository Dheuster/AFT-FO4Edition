;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AFT:Fragments:Terminals:TERM_TweakToolsTerminal_01005C62_1 Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_03
Function Fragment_Terminal_03(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy As AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
    pTweakPipBoyScript.SummonRelay()
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property pTweakPipBoy Auto Const
