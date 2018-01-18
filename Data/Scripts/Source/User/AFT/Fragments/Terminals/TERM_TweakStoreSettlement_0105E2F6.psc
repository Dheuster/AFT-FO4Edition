;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AFT:Fragments:Terminals:TERM_TweakStoreSettlement_0105E2F6 Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower As AFT:TweakFollowerScript)
if (pTweakFollowerScript)
    pTweakFollowerScript.SettlementSnapshot()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower As AFT:TweakFollowerScript)
if (pTweakFollowerScript)
    pTweakFollowerScript.SettlementSnapshot(1)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property pTweakFollower Auto Const
