Scriptname AFT:TweakGatherShowSearch extends Quest Const

Message Property TweakSearchingMsg Auto Const
int   maxMessages  = 10 const
float msgDelay     = 3.0 const

Function ShowSearching()
	StopShowSearching()
	TweakSearchingMsg.Show()
	; These happen every 3 seconds. So if maxMessages is 10, it will timeout after 30 seconds. 
	StartTimer(msgDelay, maxMessages)
EndFunction

Function StopShowSearching()
	int i = maxMessages
	while i > 0
		CancelTimer(i)
		i -= 1
	endWhile
EndFunction

Event OnTimer(int countDown)
	if (countDown > 0)
		TweakSearchingMsg.Show()
		StartTimer(msgDelay, (countDown - 1))
	endif
EndEvent
