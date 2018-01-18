Scriptname TrapBreakableWalkway extends ObjectReference
{This goes on the triggerVolume}




sound Property creakingSound auto
perk Property LightStep auto
ActorValue Property Mass auto
keyword Property LinkCustom01 const auto
bool enabled = true
bool fadeInOut = true

float CurrentWeightPressure = 0.0
float DamageRefreshTime = 0.25
ObjectReference[] boards
int DamageTimerID = 100
int BoardCount = 0
int soundID
bool soundActive
bool randomInitialDamage = true 

Auto State Active
	Event OnTriggerEnter(ObjectReference akActionRef)
		float pressureIncrease = GetPressureIncrease(akActionRef)
		AdjustWeightPressure(pressureIncrease)
		StartTimer(DamageRefreshTime, DamageTimerID)
		if !soundActive
			soundActive = true
			ObjectReference objSelf = self as ObjectReference
			soundID = creakingSound.Play(objSelf)
		endif
	EndEvent

	Event OnTriggerLeave(ObjectReference akActionRef)
		float pressureIncrease = GetPressureIncrease(akActionRef)
		AdjustWeightPressure(-pressureIncrease)
		if soundActive && CurrentWeightPressure <= 0
			Sound.StopInstance(soundID)
			soundActive = false
		endif
	EndEvent	


	Event OnTimer(int aiTimerID)
		;debug.Trace(self + ": Timer has gone off time to damage boards")
		;debug.Trace(self + ": CurrentWeightPressure == " + CurrentWeightPressure)
		if GetTriggerObjectCount() > 0 && BoardCount > 0
			StartTimer(DamageRefreshTime, DamageTimerID)
			DamageBoards()
		else
		endif
	EndEvent
EndState

State Done
	Event OnBeginState(string asOldState)
	   	;debug.Trace(self + ": All Boards Destroyed")
		CancelTimer(DamageTimerID)
		Sound.StopInstance(soundID)
		soundActive = false
		GetLinkedRef(LinkCustom01).enablenowait()
	EndEvent
EndState

Event onCellAttach()
	int i = 0
	boards = getLinkedRefChain()
	BoardCount = 0
	while i < boards.length
		if boards[i].isDestroyed()
		else
			if randomInitialDamage
				boards[i].damageObject(utility.RandomFloat(1.0, 25.0))
			endif
			registerforRemoteEvent(boards[i], "OnDestructionStageChanged")
			BoardCount += 1
		endif
		i += 1
	endWhile
	if BoardCount <= 0
		goToState("Done")
	endif
EndEvent

Event onReset()
	GetLinkedRef(LinkCustom01).disablenowait()
	int i = 0
	int count = boards.length
	;debug.Trace(self + ": Damaging Boards")
	while i < count
		boards[i].EnableNoWait()
		boards[i].ClearDestruction()
		boards[i].Reset()
		i += 1
	endWhile

EndEvent

;************************************
;	This is where we talk to the boards
;************************************

Function DamageBoards()
	int i = 0
	int count = boards.length
	;debug.Trace(self + ": Damaging Boards")
	while i < count
		boards[i].damageObject(CurrentWeightPressure)
		i += 1
	endWhile
Endfunction

Event objectReference.OnDestructionStageChanged(ObjectReference akSender, int aiOldStage, int aiCurrentStage)
	BoardCount -= 1
	unRegisterForRemoteEvent(akSender, "OnDestructionStageChanged")
	if BoardCount <= 0
		goToState("Done")
	Endif
EndEvent

;************************************
;	These determine how much "weight" is currently on the boards
;		This is the damage done to each board when the timer goes off
;************************************

Function AdjustWeightPressure(float weightChange)
	CurrentWeightPressure += weightChange
EndFunction


float Function GetPressureIncrease(ObjectReference akActionRef)
	float RefPressure = 10.0		;baseline
	Actor npc = akActionRef as actor
	if npc
		if akActionRef.getValue(Mass) < 1.0 || (42 == npc.GetValue(Game.GetForm(0x0000030D) as ActorValue))
			RefPressure = 0
		else
			if npc.hasPerk(LightStep)
				RefPressure -=5
			endif

			RefPressure *= akActionRef.getValue(Mass)

			if npc.IsInPowerArmor()
				RefPressure += 40
			endif
		endif
	endif
	;debug.Trace(self + ": RefPressure change is " + RefPressure)
	return RefPressure
EndFunction


