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

; Called from TweakMonitorPlayer
Function OnGameLoaded(bool firstTime=false)
	Trace("OnGameLoaded() Called")
	StartTimer(4.0, NO_LOAD_FLOOD)
EndFunction

Event OnInit()
	Trace("OnInit() Called")
EndEvent

Event OnQuestInit()
	Trace("OnQuestInit() Called")
EndEvent

Event Actor.OnPlayerLoadGame(Actor akSender)

	; 1.18 : Left in for stray events from previous versions
	; of the mod. We now rely on TweakMonitorPlayer to call 
	; OnGameLoaded. This ensures we dont register for 
	; interjections before the rest of the mod has initialized. 
	
	Trace("OnPlayerLoadGame Called")
	UnRegisterForRemoteEvent(Game.GetPlayer(),"OnPlayerLoadGame")	
	
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
EndFunction

Function RegisterInterjections()
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
	endif
EndFunction
