;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AFT:Fragments:Terminals:TERM_TweakSettingsTerminal_01005C61_1 Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_04
Function Fragment_Terminal_04(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy As AFT:TweakPipBoyScript)
if pTweakPipBoyScript
    pTweakPipBoyScript.ToggleEssential()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_10
Function Fragment_Terminal_10(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy As AFT:TweakPipBoyScript)
if pTweakPipBoyScript
    pTweakPipBoyScript.ToggleEssential()
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property pTweakPipBoy Auto Const
