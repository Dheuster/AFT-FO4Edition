Scriptname AFT:TweakInterjectionQuestScript extends Quest

TweakBos100Interjections			Property pTweakBos100Interjections				Auto Const
TweakBos200Interjections			Property pTweakBos200Interjections				Auto Const
TweakBos300Interjections			Property pTweakBos300Interjections				Auto Const
TweakDiamondInterjections			Property pTweakDiamondInterjections				Auto Const
TweakInst300Interjections			Property pTweakInst300Interjections				Auto Const
TweakMemoryDenInterjections			Property pTweakMemoryDenInterjections			Auto Const
TweakMinInterjections				Property pTweakMinInterjections					Auto Const
TweakMS07Interjections				Property pTweakMS07Interjections				Auto Const
TweakMS09Interjections				Property pTweakMS09Interjections				Auto Const
TweakMS13Interjections				Property pTweakMS13Interjections				Auto Const
TweakMS13PhotoInterjections			Property pTweakMS13PhotoInterjections			Auto Const
TweakMS14Interjections				Property pTweakMS14Interjections				Auto Const
TweakRR100Interjections				Property pTweakRR100Interjections				Auto Const
TweakRR300Interjections				Property pTweakRR300Interjections				Auto Const
TweakStartGameEnabledInterjections	Property pTweakStartGameEnabledInterjections	Auto Const
GlobalVariable						Property pTweakAllowMultInterjections 			Auto Const

int NO_LOAD_FLOOD = 200 const

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	debug.OpenUserLog("TweakInterjectionQuestScript")
	RETURN debug.TraceUser("TweakInterjectionQuestScript", asTextToPrint, aiSeverity)
EndFunction

Event OnInit()
	Actor player = Game.GetPlayer()
	RegisterForRemoteEvent(player,"OnPlayerLoadGame")	
	; Give WorkshopParent Quest time start up on a New Game....
	StartTimer(4.0, NO_LOAD_FLOOD)
EndEvent

Event Actor.OnPlayerLoadGame(Actor akSender)
	Trace("OnPlayerLoadGame Called")
	StartTimer(0.1, NO_LOAD_FLOOD)
EndEvent

Event OnTimer(int timerID)
	CancelTimer(timerID)
	if (NO_LOAD_FLOOD == timerID)
		Trace("OnTimer : NO_LOAD_FLOOD")
		if (1.0 == pTweakAllowMultInterjections.GetValue())	
			UnRegisterInterjections()	
			RegisterInterjections()
		endif
		return
	endif
EndEvent

Function UnRegisterInterjections()
	Trace("UnRegisterInterjections")
	pTweakBos100Interjections.UnRegisterInterjections()
	pTweakBos200Interjections.UnRegisterInterjections()
	pTweakBos300Interjections.UnRegisterInterjections()
	pTweakDiamondInterjections.UnRegisterInterjections()
	pTweakInst300Interjections.UnRegisterInterjections()
	pTweakMemoryDenInterjections.UnRegisterInterjections()
	pTweakMinInterjections.UnRegisterInterjections()
	pTweakMS07Interjections.UnRegisterInterjections()
	pTweakMS09Interjections.UnRegisterInterjections()
	pTweakMS13Interjections.UnRegisterInterjections()
	pTweakMS13PhotoInterjections.UnRegisterInterjections()
	pTweakMS14Interjections.UnRegisterInterjections()
	pTweakRR100Interjections.UnRegisterInterjections()
	pTweakRR300Interjections.UnRegisterInterjections()
	pTweakStartGameEnabledInterjections.UnRegisterInterjections()
	
	Actor player = Game.GetPlayer()
	UnRegisterForRemoteEvent(player,"OnPlayerLoadGame")	
EndFunction

Function RegisterInterjections()
	Trace("RegisterInterjections")
	if (1.0 == pTweakAllowMultInterjections.GetValue())	
		pTweakBos100Interjections.RegisterInterjections()
		pTweakBos200Interjections.RegisterInterjections()
		pTweakBos300Interjections.RegisterInterjections()
		pTweakDiamondInterjections.RegisterInterjections()
		pTweakInst300Interjections.RegisterInterjections()
		pTweakMemoryDenInterjections.RegisterInterjections()
		pTweakMinInterjections.RegisterInterjections()
		pTweakMS07Interjections.RegisterInterjections()
		pTweakMS09Interjections.RegisterInterjections()
		pTweakMS13Interjections.RegisterInterjections()
		pTweakMS13PhotoInterjections.RegisterInterjections()
		pTweakMS14Interjections.RegisterInterjections()
		pTweakRR100Interjections.RegisterInterjections()
		pTweakRR300Interjections.RegisterInterjections()
		pTweakStartGameEnabledInterjections.RegisterInterjections()

		Actor player = Game.GetPlayer()
		RegisterForRemoteEvent(player,"OnPlayerLoadGame")		
	endif
EndFunction