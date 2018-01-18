Scriptname AFT:TweakHandlerLightSwitch extends ObjectReference Const

Quest Property pTweakFollower Auto Const
GlobalVariable Property TargetLightController Auto Const
Message Property pTweakLightOff Auto Const
Message Property pTweakLightWhite Auto Const
Message Property pTweakLightPurple Auto Const
Message Property pTweakLightBlue Auto Const
Message Property pTweakLightGreen Auto Const
Message Property pTweakLightRed Auto Const
Message Property pTweakLightYellow Auto Const
Message Property pTweakLightOrange Auto Const
Message Property pTweakLightAqua Auto Const
Message Property pTweakLightMulti Auto Const



Event OnActivate(ObjectReference akActivator)
	float currentValue = TargetLightController.GetValueInt()
	currentValue += 1.0	
	if (1.0 == currentValue)
		self.SetActivateTextOverride(pTweakLightWhite)
	elseif (2.0 == currentValue)
		self.SetActivateTextOverride(pTweakLightMulti)	
	elseif (3.0 == currentValue)
		self.SetActivateTextOverride(pTweakLightBlue)
	elseif (4.0 == currentValue)
		self.SetActivateTextOverride(pTweakLightGreen)
	elseif (5.0 == currentValue)
		self.SetActivateTextOverride(pTweakLightRed)
	elseif (6.0 == currentValue)
		self.SetActivateTextOverride(pTweakLightYellow)
	elseif (7.0 == currentValue)
		self.SetActivateTextOverride(pTweakLightOrange)
	elseif (8.0 == currentValue)
		self.SetActivateTextOverride(pTweakLightAqua)
	elseif (9.0 == currentValue)
		self.SetActivateTextOverride(pTweakLightPurple)
	else
		currentValue = 0
		self.SetActivateTextOverride(pTweakLightOff)
	endif	
	TargetLightController.SetValue(currentValue)
	
	AFT:TweakShelterScript pTweakShelterScript = (pTweakFollower as AFT:TweakShelterScript)
	if (pTweakShelterScript)
		pTweakShelterScript.MakeCamp(true)
	endif
EndEvent
