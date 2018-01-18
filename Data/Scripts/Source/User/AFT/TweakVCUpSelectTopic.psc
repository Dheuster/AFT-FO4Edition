Scriptname AFT:TweakVCUpSelectTopic extends TopicInfo

Quest Property pTweakVisualChoice Auto Const

Event OnBegin(ObjectReference akSpeaker, bool hasBeenSaid)
	TweakVisualChoiceScript pTweakVisualChoiceScript = pTweakVisualChoice as TweakVisualChoiceScript
	if (pTweakVisualChoiceScript)
		pTweakVisualChoiceScript.EventOnChooseUp()
	endif
EndEvent

Event OnEnd(ObjectReference akSpeaker, bool hasBeenSaid)
EndEvent