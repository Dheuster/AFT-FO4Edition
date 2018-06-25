;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AFT:Fragments:TopicInfos:TIF_TweakCOMSpouseTalk_0100269F Extends TopicInfo Hidden Const

;BEGIN FRAGMENT Fragment_End
Function Fragment_End(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
pSpouse.GetActorReference().Say(COMSpouseIdle,pSpouse.GetActorReference(),false,Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Topic Property COMSpouseIdle Auto Const

ReferenceAlias Property pSpouse Auto Const
