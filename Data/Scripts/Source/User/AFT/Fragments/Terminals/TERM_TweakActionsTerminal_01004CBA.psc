;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AFT:Fragments:Terminals:TERM_TweakActionsTerminal_01004CBA Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy As AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
    pTweakPipBoyScript.StayRelay()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy As AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
    pTweakPipBoyScript.FollowRelay()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_03
Function Fragment_Terminal_03(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy as AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
    pTweakPipBoyScript.DismissRelay()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_04
Function Fragment_Terminal_04(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy As AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
        pTweakPipBoyScript.ExitPowerArmorRelay()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_05
Function Fragment_Terminal_05(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy As AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
        pTweakPipBoyScript.BehindMeRelay()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_07
Function Fragment_Terminal_07(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy As AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
        pTweakPipBoyScript.EnterPowerArmorRelay()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_08
Function Fragment_Terminal_08(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy As AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
        pTweakPipBoyScript.ExitPowerArmorRelay()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_09
Function Fragment_Terminal_09(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript  =  (pTweakPipBoy As AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)

    pTweakPipBoyScript.SummonRelay()

endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_10
Function Fragment_Terminal_10(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy as AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
    pTweakPipBoyScript.MakeCampRelay()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_11
Function Fragment_Terminal_11(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy as AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
    pTweakPipBoyScript.TearDownCampRelay()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_12
Function Fragment_Terminal_12(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy as AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
    pTweakPipBoyScript.GetPlayerPowerArmor()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_13
Function Fragment_Terminal_13(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower As AFT:TweakFollowerScript)
if (pTweakFollowerScript)
        pTweakFollowerScript.SetFollowerStayByNameId(0)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_14
Function Fragment_Terminal_14(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower As AFT:TweakFollowerScript)
if (pTweakFollowerScript)
    pTweakFollowerScript.SetFollowerFollowByNameId(0)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_16
Function Fragment_Terminal_16(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy As AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
        pTweakPipBoyScript.EnterPowerArmorRelay()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_17
Function Fragment_Terminal_17(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript  =  (pTweakPipBoy As AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
    pTweakPipBoyScript.SetCompanionRelay()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_18
Function Fragment_Terminal_18(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy As AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
    pTweakPipBoyScript.HangoutRelay()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_19
Function Fragment_Terminal_19(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower As AFT:TweakFollowerScript)
if (pTweakFollowerScript)
        pTweakFollowerScript.SetFollowerHangoutByNameId(0)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_20
Function Fragment_Terminal_20(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript  =  (pTweakPipBoy As AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
    pTweakPipBoyScript.GatherLooseItems()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_21
Function Fragment_Terminal_21(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript  =  (pTweakPipBoy As AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
    pTweakPipBoyScript.RetreatRelay()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_22
Function Fragment_Terminal_22(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript  =  (pTweakPipBoy As AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
    pTweakPipBoyScript.AttackRelay()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_23
Function Fragment_Terminal_23(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy As AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
        pTweakPipBoyScript.ToggleCommandMode()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_24
Function Fragment_Terminal_24(ObjectReference akTerminalRef)
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript  =  (pTweakPipBoy As AFT:TweakPipBoyScript)
if (pTweakPipBoyScript)
    pTweakPipBoyScript.UnlockVisible()
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property pTweakPipBoy Auto Const
Quest Property pTweakFollower Auto Const
