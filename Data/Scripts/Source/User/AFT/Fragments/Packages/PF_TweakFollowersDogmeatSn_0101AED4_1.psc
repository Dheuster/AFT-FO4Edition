;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AFT:Fragments:Packages:PF_TweakFollowersDogmeatSn_0101AED4_1 Extends Package Hidden Const

;BEGIN FRAGMENT Fragment_Begin
Function Fragment_Begin(Actor akActor)
;BEGIN CODE
DogmeatIdles.setDogmeatAGITATED()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Change
Function Fragment_Change(Actor akActor)
;BEGIN CODE
DogmeatIdles.setDogmeatNeutral()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
