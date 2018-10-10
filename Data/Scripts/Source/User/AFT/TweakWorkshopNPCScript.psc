Scriptname AFT:TweakWorkshopNPCScript extends RefCollectionAlias

ActorValue Property LeftAttackCondition auto const
ActorValue Property LeftMobilityCondition auto const
ActorValue Property PerceptionCondition auto const
ActorValue Property RightAttackCondition auto const
ActorValue Property RightMobilityCondition auto const
ActorValue Property EnduranceCondition Auto const
ActorValue Property Rads Auto const
ActorValue Property Health Auto const
SPELL Property CureAddictions Auto Const
Hardcore:HC_ManagerScript Property HC_Manager const auto
ActorValue Property HC_IsCompanionInNeedOfHealing Auto Const


bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakWorkshopNPCScript"
	debug.OpenUserLog(logName) 
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

; Event Relays for any NPCs that have been turned into AFT managed Settlers.
; See TweakSettlersScript for main Support. 

Event OnActivate(ObjectReference oNPC, ObjectReference akActionRef)
	Trace("OnActivate oNPC [" + oNPC + "] akActionRef [" + akActionRef + "]")
	(GetOwningQuest() as TweakSettlersScript).TweakOnActivate(oNPC, akActionRef)
EndEvent

Event OnCommandModeEnter(ObjectReference oNPC)
	Trace("OnCommandModeEnter oNPC [" + oNPC + "]")
EndEvent

Event OnCommandModeGiveCommand(ObjectReference oNPC, int aeCommandType, ObjectReference akTarget)
	Trace("OnCommandModeGiveCommand oNPC [" + oNPC + "] aeCommandType [" + aeCommandType + "] akTarget [" + akTarget + "]")
	(GetOwningQuest() as TweakSettlersScript).TweakOnCommandModeGiveCommand(oNPC, aeCommandType, akTarget)
endEvent

Event OnEnterBleedout(ObjectReference oNPC)
	Trace("OnEnterBleedout oNPC [" + oNPC + "]")
	(GetOwningQuest() as TweakSettlersScript).TweakOnEnterBleedout(oNPC)
EndEvent

Event OnCombatStateChanged(ObjectReference oNPC, Actor akTarget, int aeCombatState)
	Trace("OnCombatStateChanged oNPC [" + oNPC + "] akTarget [" + akTarget + "] aeCombatState [" + aeCombatState + "]")
	(GetOwningQuest() as TweakSettlersScript).TweakOnCombatStateChanged(oNPC, akTarget, aeCombatState)
EndEvent

Event OnDeath(ObjectReference oNPC, Actor akKiller)
	Trace("OnCombatStateChanged oNPC [" + oNPC + "] akKiller [" + akKiller + "]")
	(GetOwningQuest() as TweakSettlersScript).TweakOnDeath(oNPC, akKiller)
EndEvent

Event OnWorkshopNPCTransfer(ObjectReference oNPC, Location akNewWorkshopLocation, Keyword akActionKW)
	Trace("OnWorkshopNPCTransfer oNPC [" + oNPC + "] akNewWorkshopLocation [" + akNewWorkshopLocation + "] akActionKW [" + akActionKW + "]")
	(GetOwningQuest() as TweakSettlersScript).TweakOnWorkshopNPCTransfer(oNPC, akNewWorkshopLocation, akActionKW)
endEvent

Event OnLoad(ObjectReference oNPC)
	; Heal Settlers on Load as there is no way to heal them otherwise.
	Trace("OnLoad oNPC [" + oNPC + "]")
	Actor npc = oNPC as Actor
	if npc
		HealAll(npc)
	endif
	(GetOwningQuest() as TweakSettlersScript).TweakOnLoad(oNPC)
EndEvent

Function HealAll(Actor myPatient)
	int RadsToHeal = (mypatient.GetValue(Rads) as int)
	mypatient.RestoreValue(Rads, RadsToHeal)
	myPatient.RestoreValue(Health, 9999)
	myPatient.RestoreValue(LeftAttackCondition, 9999)
	myPatient.RestoreValue(LeftMobilityCondition, 9999)
	myPatient.RestoreValue(PerceptionCondition, 9999)
	myPatient.RestoreValue(RightAttackCondition, 9999)
	myPatient.RestoreValue(RightMobilityCondition, 99999)
	myPatient.RestoreValue(EnduranceCondition, 9999)

	;for new survival - curing diseases
	if myPatient == Game.GetPlayer()
		HC_Manager.ClearDisease()
	else
		myPatient.SetValue(HC_IsCompanionInNeedOfHealing, 0)
	endif
	CureAddictions.Cast(myPatient, myPatient)
EndFunction
