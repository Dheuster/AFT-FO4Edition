;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AFT:Fragments:Quests:QF_TweakExpandCamp_01026A8B_1 Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0010_Item_00
Function Fragment_Stage_0010_Item_00()
;BEGIN CODE
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0020_Item_00
Function Fragment_Stage_0020_Item_00()
;BEGIN CODE
SetObjectiveCompleted(10)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0030_Item_00
Function Fragment_Stage_0030_Item_00()
;BEGIN CODE
AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy as AFT:TweakPipBoyScript)
if pTweakPipBoyScript
    pTweakPipBoyScript.TearDownCampRelay()
endif
SetObjectiveCompleted(20)
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0040_Item_00
Function Fragment_Stage_0040_Item_00()
;BEGIN CODE
pTweakCampModule1Enabled.SetValue(1.0)
AFT:TweakShelterScript pTweakShelterScript = (pTweakFollower as AFT:TweakShelterScript)
if pTweakShelterScript
    ObjectReference camp = pTweakShelterScript.pShelterMapTeleport.GetReference()
    if (!pTweakShelterScript.ShelterSetup)
        pTweakCampModule1Enabled.SetValue(2.0)
    elseif (camp && Game.GetPlayer().GetDistance(camp) < 2000)
        pTweakCampModule1Enabled.SetValue(2.0)
        AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy as AFT:TweakPipBoyScript)
        if pTweakPipBoyScript
            pTweakPipBoyScript.RefreshCamp()
        endif
    endif
endif
SetObjectiveCompleted(30)
SetObjectiveDisplayed(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0050_Item_00
Function Fragment_Stage_0050_Item_00()
;BEGIN CODE
pTweakCampModule2Enabled.SetValue(1.0)
AFT:TweakShelterScript pTweakShelterScript = (pTweakFollower as AFT:TweakShelterScript)
if pTweakShelterScript
    ObjectReference camp = pTweakShelterScript.pShelterMapTeleport.GetReference()
    if (!pTweakShelterScript.ShelterSetup)
        pTweakCampModule2Enabled.SetValue(2.0)
    elseif (camp && Game.GetPlayer().GetDistance(camp) < 2000)
        pTweakCampModule2Enabled.SetValue(2.0)
        AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy as AFT:TweakPipBoyScript)
        if pTweakPipBoyScript
            pTweakPipBoyScript.RefreshCamp()
        endif
    endif
endif
SetObjectiveCompleted(40)
SetObjectiveDisplayed(50)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0060_Item_00
Function Fragment_Stage_0060_Item_00()
;BEGIN CODE
pTweakCampModule3Enabled.SetValue(1.0)
AFT:TweakShelterScript pTweakShelterScript = (pTweakFollower as AFT:TweakShelterScript)
if pTweakShelterScript
    ObjectReference camp = pTweakShelterScript.pShelterMapTeleport.GetReference()
    if (!pTweakShelterScript.ShelterSetup)
        pTweakCampModule3Enabled.SetValue(2.0)
    elseif (camp && Game.GetPlayer().GetDistance(camp) < 2000)
        pTweakCampModule3Enabled.SetValue(2.0)
        AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy as AFT:TweakPipBoyScript)
        if pTweakPipBoyScript
            pTweakPipBoyScript.RefreshCamp()
        endif
    endif
endif
SetObjectiveCompleted(50)
SetObjectiveDisplayed(60)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0070_Item_00
Function Fragment_Stage_0070_Item_00()
;BEGIN CODE
Mobile4b.GetReference().Disable()
Mobile4c.GetReference().Disable()
Mobile4d.GetReference().Disable()
Mobile4e.GetReference().Disable()
Mobile4f.GetReference().Disable()
Mobile4g.GetReference().Disable()
Mobile4h.GetReference().Disable()
Mobile4i.GetReference().Disable()
Mobile4j.GetReference().Disable()
Mobile4k.GetReference().Disable()
Mobile4l.GetReference().Disable()
Mobile4m.GetReference().Disable()
Mobile4n.GetReference().Disable()
Mobile4o.GetReference().Disable()
Mobile4p.GetReference().Disable()

pTweakCampModule4Enabled.SetValue(1.0)
AFT:TweakShelterScript pTweakShelterScript = (pTweakFollower as AFT:TweakShelterScript)
if pTweakShelterScript
    ObjectReference camp = pTweakShelterScript.pShelterMapTeleport.GetReference()
    if (!pTweakShelterScript.ShelterSetup)
        pTweakCampModule4Enabled.SetValue(2.0)
    elseif (camp && Game.GetPlayer().GetDistance(camp) < 2000)
        pTweakCampModule4Enabled.SetValue(2.0)
        AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy as AFT:TweakPipBoyScript)
        if pTweakPipBoyScript
            pTweakPipBoyScript.RefreshCamp()
        endif
    endif
endif
SetObjectiveCompleted(60)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property Mobile4b Auto Const

ReferenceAlias Property Mobile4c Auto Const

ReferenceAlias Property Mobile4d Auto Const

ReferenceAlias Property Mobile4e Auto Const

ReferenceAlias Property Mobile4f Auto Const

ReferenceAlias Property Mobile4g Auto Const

ReferenceAlias Property Mobile4h Auto Const

ReferenceAlias Property Mobile4i Auto Const

ReferenceAlias Property Mobile4j Auto Const

ReferenceAlias Property Mobile4k Auto Const

ReferenceAlias Property Mobile4l Auto Const

ReferenceAlias Property Mobile4m Auto Const

ReferenceAlias Property Mobile4n Auto Const

ReferenceAlias Property Mobile4o Auto Const

ReferenceAlias Property Mobile4p Auto Const

Quest Property pTweakFollower Auto Const

GlobalVariable Property pTweakCampModule1Enabled Auto Const

GlobalVariable Property pTweakCampModule2Enabled Auto Const

GlobalVariable Property pTweakCampModule3Enabled Auto Const

GlobalVariable Property pTweakCampModule4Enabled Auto Const

Quest Property pTweakPipBoy Auto Const
