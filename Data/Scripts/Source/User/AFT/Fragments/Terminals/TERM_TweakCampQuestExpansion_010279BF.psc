;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AFT:Fragments:Terminals:TERM_TweakCampQuestExpansion_010279BF Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
if Game.GetPlayer().GetGoldAmount() > 499
    Game.RemovePlayerCaps(500)
    pTweakExpandCamp.SetStage(20)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
if Game.GetPlayer().GetItemCount(c_wood_scrap) > 199
    Game.GetPlayer().RemoveItem(c_wood_scrap,200)
    pTweakExpandCamp.SetStage(30)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_03
Function Fragment_Terminal_03(ObjectReference akTerminalRef)
;BEGIN CODE
if Game.GetPlayer().GetGoldAmount() > 599
    Game.RemovePlayerCaps(600)
    pTweakExpandCamp.SetStage(30)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_04
Function Fragment_Terminal_04(ObjectReference akTerminalRef)
;BEGIN CODE
if Game.GetPlayer().GetGoldAmount() > 499
    Game.RemovePlayerCaps(500)
    pTweakExpandCamp.SetStage(40)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_05
Function Fragment_Terminal_05(ObjectReference akTerminalRef)
;BEGIN CODE
if Game.GetPlayer().GetGoldAmount() > 499
    Game.RemovePlayerCaps(500)
    pTweakExpandCamp.SetStage(50)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_06
Function Fragment_Terminal_06(ObjectReference akTerminalRef)
;BEGIN CODE
if Game.GetPlayer().GetGoldAmount() > 499
    Game.RemovePlayerCaps(500)
    pTweakExpandCamp.SetStage(60)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_07
Function Fragment_Terminal_07(ObjectReference akTerminalRef)
;BEGIN CODE
if Game.GetPlayer().GetGoldAmount() > 499
    Game.RemovePlayerCaps(500)
    pTweakExpandCamp.SetStage(70)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property pTweakExpandCamp Auto Const

MiscObject Property c_Wood_scrap Auto Const
