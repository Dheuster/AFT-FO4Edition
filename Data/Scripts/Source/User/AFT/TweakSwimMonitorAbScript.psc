Scriptname AFT:TweakSwimMonitorAbScript extends activemagiceffect

TweakMonitorPlayerScript Property pTweakMonitorPlayer Auto Const
  
Event OnEffectStart(Actor akTarget, Actor akCaster)
	pTweakMonitorPlayer.CallFunctionNoWait("OnPlayerStartSwim", new Var[0])
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	pTweakMonitorPlayer.CallFunctionNoWait("OnPlayerStopSwim", new Var[0])
EndEvent
