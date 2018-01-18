Scriptname AFT:TweakCOMTalkQuestScript extends COMTalkQuestScript
{Script on COM<Companion> Quest used in Relationship scene to call function on related CompanionActorScript}

Group Companion
ReferenceAlias Property rCompanionActor const auto
{Optional Override for hard coded ActorBase}
EndGroup

Function ShowInfatuationMessage()
	if rCompanionActor.GetActorReference()
		(rCompanionActor.GetActorReference() as CompanionActorScript).ShowThresholdMessage(CA_T1_Infatuation)
	else
		CompanionActor.ShowThresholdMessage(CA_T1_Infatuation)
	endif
EndFunction

Function ShowAdmirationMessage()
	if rCompanionActor.GetActorReference()
		(rCompanionActor.GetActorReference() as CompanionActorScript).ShowThresholdMessage(CA_T2_Admiration)
	else
		CompanionActor.ShowThresholdMessage(CA_T2_Admiration)
	endif
EndFunction

Function ShowNeutralMessage()
	if rCompanionActor.GetActorReference()
		(rCompanionActor.GetActorReference() as CompanionActorScript).ShowThresholdMessage(CA_T3_Neutral)
	else
		CompanionActor.ShowThresholdMessage(CA_T3_Neutral)
	endif
EndFunction

Function ShowDisdainMessage()
	if rCompanionActor.GetActorReference()
		(rCompanionActor.GetActorReference() as CompanionActorScript).ShowThresholdMessage(CA_T4_Disdain)
	else
		CompanionActor.ShowThresholdMessage(CA_T4_Disdain)
	endif
EndFunction

Function ShowHatredMessage()
	if rCompanionActor.GetActorReference()
		(rCompanionActor.GetActorReference() as CompanionActorScript).ShowThresholdMessage(CA_T4_Disdain)
	else
		CompanionActor.ShowThresholdMessage(CA_T5_Hatred)
	endif
EndFunction

Function ShowRomanticInfatuationMessage()
	if rCompanionActor.GetActorReference()
		(rCompanionActor.GetActorReference() as CompanionActorScript).ShowRomanticInfatuationMessage()
	else
		CompanionActor.ShowRomanticInfatuationMessage()
	endif
EndFunction
