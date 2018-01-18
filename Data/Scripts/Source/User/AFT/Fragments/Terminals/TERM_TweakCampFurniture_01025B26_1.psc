;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AFT:Fragments:Terminals:TERM_TweakCampFurniture_01025B26_1 Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_09
Function Fragment_Terminal_09(ObjectReference akTerminalRef)
;BEGIN CODE
pTweakCampDogHouseEnabled.SetValue(2.0)
Game.RemovePlayerCaps(100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_11
Function Fragment_Terminal_11(ObjectReference akTerminalRef)
;BEGIN CODE
pTweakCampMisc2Enabled.SetValue(2.0)
Game.RemovePlayerCaps(100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_17
Function Fragment_Terminal_17(ObjectReference akTerminalRef)
;BEGIN CODE
pTweakInsufficientFunds.Show()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_18
Function Fragment_Terminal_18(ObjectReference akTerminalRef)
;BEGIN CODE
pTweakInsufficientFunds.Show()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property pTweakCampBed2Enabled Auto Const

GlobalVariable Property pTweakCampSeatsEnabled Auto Const

GlobalVariable Property pTweakCampDogHouseEnabled Auto Const

GlobalVariable Property pTweakCampSeats2Enabled Auto Const

Message Property pTweakInsufficientFunds Auto Const


GlobalVariable Property pTweakCampMisc2Enabled Auto Const

GlobalVariable Property pTweakCampBed1Enabled Auto Const
