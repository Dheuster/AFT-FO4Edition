Scriptname AFT:TweakProximity extends Quest
{set stages when player gets within proximity of configured objects}

struct StageInfo

	ReferenceAlias target
	{ alias you want to check the distance from - always checking against the player }

	ObjectReference instance = None
	{ optional instance to fill referencealiases with on Quest init (If you want Optional ReferenceAliases) }
	
	bool disableOnProximity = false
	{ Should the ReferenceAlias be disabled when player gets within proximity }
	
	bool deleteOnProximity = false
	{ Should the ReferenceAlias be deleted when player gets within proximity }
	
	float radius
	{ radius of proximity }

	int StartStage
	{ setup distance monitoring for ref when we reach this stage }

	int StageToSet
	{ stage to change to when proximity check fires }

endStruct

StageInfo[] property Stages auto Const

Event OnQuestInit()
	int i = 0
	while i < Stages.Length
		StageInfo theStageInfo = Stages[i]
		if (theStageInfo.instance)
			theStageInfo.target.ForceRefIfEmpty(theStageInfo.instance)
		endif
		i += 1		
	endWhile
EndEvent

Event OnStageSet(int auiStageID, int auiItemID)
	Actor player = Game.GetPlayer()
	
	int i = 0
	while i < Stages.Length
		StageInfo theStageInfo = Stages[i]
		
		; If stage is forced before distance event by external script, make sure event is unregistered...
		if (theStageInfo.radius > 0)
			if auiStageID == theStageInfo.StartStage
				RegisterForDistanceLessThanEvent(Game.GetPlayer(), theStageInfo.target, theStageInfo.radius)
			elseif auiStageID == theStageInfo.StageToSet
				UnRegisterForDistanceEvents(Game.GetPlayer(), theStageInfo.target)
				if theStageInfo.disableOnProximity || theStageInfo.deleteOnProximity
					ObjectReference instance = theStageInfo.target.GetReference()
					theStageInfo.target.Clear()
					if (theStageInfo.disableOnProximity || theStageInfo.deleteOnProximity)
						instance.SetPosition(0,0,10)
					endif
					if (theStageInfo.disableOnProximity)
						instance.Disable()
				    endif
					if (theStageInfo.deleteOnProximity)
						instance.Delete()
					endif
					instance = None
				endif
				theStageInfo.instance = None
			endif
		endif
		i += 1
	endWhile

endEvent

Event OnDistanceLessThan(ObjectReference akObj1, ObjectReference akObj2, float afDistance)
	UnRegisterForDistanceEvents(akObj1, akObj2)
	int i = 0
	while i < Stages.Length
		StageInfo theStageInfo = Stages[i]
		if (theStageInfo.target.GetRef() == akObj2)
			SetStage(theStageInfo.StageToSet)
			if theStageInfo.disableOnProximity || theStageInfo.deleteOnProximity
				ObjectReference instance = theStageInfo.target.GetReference()
				theStageInfo.target.Clear()
				if (theStageInfo.disableOnProximity || theStageInfo.deleteOnProximity)
					instance.SetPosition(0,0,10)
				endif
				if (theStageInfo.disableOnProximity)
					instance.Disable()
				endif
				if (theStageInfo.deleteOnProximity)
					instance.Delete()
				endif
				instance = None
			endif
			theStageInfo.instance = None
		endif
		i += 1
	endWhile
EndEvent
