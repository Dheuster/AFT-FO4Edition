;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AFT:Fragments:Terminals:TERM_TweakCampQuestUFO_010279C0 Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
if Game.GetPlayer().GetGoldAmount() > 9999
    Game.RemovePlayerCaps(10000)
    pTweakSalvageUFO.SetStage(20)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property pTweakSalvageUFO Auto Const

GlobalVariable Property pTweakCampUFOEnabled Auto Const
