;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AFT:Fragments:Terminals:TERM_TweakCampTerminal_01025B24 Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_04
Function Fragment_Terminal_04(ObjectReference akTerminalRef)
;BEGIN CODE
if (!pTweakSalvageUFO.IsRunning() && pTweakSalvageUFO.GetStage() < 10)
    if pTweakSalvageUFO.Start()
        pTweakSalvageUFO.SetActive()
    endif
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_07
Function Fragment_Terminal_07(ObjectReference akTerminalRef)
;BEGIN CODE
if (!pTweakExpandCamp.IsRunning() && pTweakExpandCamp.GetStage() < 10)
    if pTweakExpandCamp.Start()
        pTweakExpandCamp.SetActive()
    endif
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property pTweakCampUFOHieght Auto Const

Quest Property pTweakFollower Auto Const

Quest Property pTweakPipBoy Auto Const

Quest Property pTweakExpandCamp Auto Const

Quest Property pTweakSalvageUFO Auto Const

GlobalVariable Property pTweakCloseTerminal Auto Const
