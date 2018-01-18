;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AFT:Fragments:Terminals:TERM_TweakResetConfirm_0100173C Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakMonitorPlayerScript pTweakMonitorPlayerScript = (pTweakMonitorPlayer as AFT:TweakMonitorPlayerScript)
if pTweakMonitorPlayerScript
    pTweakMonitorPlayerScript.AftReset()
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property pTweakMonitorPlayer Auto Const
