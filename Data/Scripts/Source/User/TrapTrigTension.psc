Scriptname TrapTrigTension extends ObjectReference
;


Group Disarmed CollapsedOnRef
	LeveledItem property TrapDisarmedReward auto Const
	{This is given to the disarming actor}
	Sound Property DisarmSound Auto Const
	{This is the sound to play when disarming
		TRPDisarmHiTech & TRPDisarmLoTech are the usual choices}
	GlobalVariable Property TrapDisarmXPReward Auto Const
EndGroup

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;			States Block
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Auto State Waiting
	Event onActivate(objectReference akActionRef)
		if akActionRef as Actor
			GoToState("Busy")
			DisarmTrigger(akActionRef as Actor)
		else
			GoToState("Triggered")
		Endif
	EndEvent
EndState

State Triggered
	Event onBeginState(string previousState)
		PlayAnimation("Trip")
		setDestroyed()
		self.activate(self, true)
	endEvent
EndState

State Disarmed
	Event onBeginState(string previousState)
		;PlayAnimation("Trip")
		ObjectReference ObjSelf = self as ObjectReference
		DisarmSound.Play(ObjSelf)
		setDestroyed()
		Self.Disable()
	endEvent
EndState

State Busy
EndState

Function DisarmTrigger(Actor DisarmingActor)
	DisarmingActor.AddItem(TrapDisarmedReward)
	GoToState("Disarmed")
	Game.RewardPlayerXP(TrapDisarmXPReward.GetValueInt())
	
EndFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;			Event Block
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Event onReset()
	setDestroyed(false)
	Self.Enable()
	PlayAnimation("Reset")
	GoToState("Waiting")
	reset()
endEvent

Event OnLoad()
	objectReference myOpenableObject
	Self.BlockActivation()
	if getLinkedRef()
		myOpenableObject = getLinkedRef()
		RegisterForRemoteEvent(myOpenableObject, "onOpen")
	endif

	if (getLinkedRef().getBaseObject() as door)
		RegisterForRemoteEvent(myOpenableObject, "onActivate")
	endif	
EndEvent

Event ObjectReference.OnOpen(ObjectReference akSender, objectReference akOpener)
	objectReference myOpenableObject = getLinkedRef()
	if myOpenableObject == akSender
		Actor npc = akOpener as Actor
		if npc && (42 == npc.GetValue(Game.GetForm(0x0000030D) as ActorValue))
			; AFT : 0000030D = FavorsPerDay
			return
		endif
		self.activate(self)
	endif
EndEvent

Event ObjectReference.OnActivate(ObjectReference akSender, objectReference akOpener)
	objectReference myOpenableObject = getLinkedRef()
	if myOpenableObject == akSender && !myOpenableObject.isLocked()
		Actor npc = akOpener as Actor
		if npc && (42 == npc.GetValue(Game.GetForm(0x0000030D) as ActorValue))
			; AFT : 0000030D = FavorsPerDay
			return
		endif
		self.activate(self)
	endif
EndEvent


