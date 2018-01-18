Scriptname AFT:TweakVCLeftSelectTopic extends TopicInfo

Quest Property pTweakVisualChoice Auto Const

Event OnBegin(ObjectReference akSpeaker, bool hasBeenSaid)
	TweakVisualChoiceScript pTweakVisualChoiceScript = pTweakVisualChoice as TweakVisualChoiceScript
	if (pTweakVisualChoiceScript)
		pTweakVisualChoiceScript.EventOnChooseLeft()
	endif
EndEvent

Event OnEnd(ObjectReference akSpeaker, bool hasBeenSaid)
EndEvent