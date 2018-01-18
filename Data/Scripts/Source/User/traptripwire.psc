Scriptname TrapTripwire extends ObjectReference

Group AnimNames CollapsedOnRef
	String Property TriggerAnim = "Trip" auto const
	;String Property TriggerEvent = "TransitionComplete" auto
	;String Property ResetAnim = "Stage1" auto
	;String Property ResetEvent = "TransitionComplete" auto
	;String Property DisarmAnim = "stage1" auto
	;String Property DisarmEvent = "TransitionComplete" auto
EndGroup

Sound Property TriggerSound auto const
keyword Property LocTypeWorkshop Auto Const

Bool Property TreatAsFloorVersion Auto Const Conditional
{This is checked by condition functions on the activator, but is never called in the script}

Bool  Property IsWorkshopVersion = false Auto

bool isArmed = true

bool property triggerByEnemiesOnly = false auto 

Group Disarmed CollapsedOnRef
	LeveledItem property TrapDisarmedReward auto Const
	{This is given to the disarming actor}
	Sound Property DisarmSound Auto Const
	{This is the sound to play when disarming
		TRPDisarmHiTech & TRPDisarmLoTech are the usual choices}

	GlobalVariable Property TrapDisarmXPReward Auto Const
EndGroup

bool property DontDisarm = false auto const

message property cantDisarmMessage auto const


;==================================================
;		Events Block
;==================================================

Event OnReset()
	Debug.Trace(Self + ": is being reset")
	if IsWorkshopVersion
		PlayAnimation("TurnOff")
	else
    	self.setdestroyed(false)
    	PlayAnimation("Reset")
    	reset()
    endif
    ;;;;Self.Enable()
    
    GoToState("Active")
    isArmed = true
EndEvent

Event OnLoad()
	Self.BlockActivation()
	;CheckForWorkshop()
EndEvent

;==================================================
;		States Block
;==================================================

Auto state Active
	Event OnTriggerEnter(ObjectReference akActionRef)
		if ShouldTrigger(akActionRef)
			GoToState("Busy")
			debug.Trace(self + ": Entered by >> " + akActionRef)
			Trigger()
		endif
	EndEvent

	Event onActivate(objectReference akActivator)
		Debug.Trace(Self + ": was Activated by >> " + akActivator)
		if akActivator as actor
			Debug.Trace(Self + "::: akActivator is an Actor")
			Debug.Trace(Self + "::::: IsWorkshopVersion = " + IsWorkshopVersion)
			
			if IsWorkshopVersion
	    		TriggerSound.play(self)
				playAnimation(TriggerAnim)
				gotostate("Inactive")
			elseif !IsWorkshopVersion
				GoToState("Busy")
				DisarmTrigger(akActivator as Actor)
			endif
		else
			TriggerSound.play(self)
			playAnimation(TriggerAnim)
			gotostate("Inactive")
		Endif
	EndEvent

	Event OnHit(ObjectReference akTarget, ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, \
 				bool abSneakAttack, bool abBashAttack, bool abHitBlocked, string apMaterial)
		debug.Trace(self + ": Hit Was Hit")
		debug.Trace(self + "::: akTarget == " + akTarget)
		debug.Trace(self + "::: akProjectile == " + akProjectile)
		GoToState("Busy")
		Trigger()
	EndEvent

	Event OnDestructionStageChanged(int aiOldStage, int aiCurrentStage)
		if aiCurrentStage == 1
			debug.Trace(self + "::: OnDestructionStageChanged : aiCurrentStage == " + aiCurrentStage)
			GoToState("Busy")
			Trigger()
		endif
	EndEvent
EndState



state Inactive
	Event OnBeginState(string asOldState)
		isArmed = false
		if !IsWorkshopVersion
	    	self.setdestroyed(true)
	    endif
	EndEvent

	Event OnActivate(ObjectReference akActionRef)
	    if akActionRef as actor && IsWorkshopVersion
	    	SetArmed(true)
	    EndIf
	EndEvent
EndState

State Busy
EndState

State Disarmed
	Event onBeginState(string previousState)
		isArmed = false
		PlayAnimation("Trip")
		ObjectReference ObjSelf = self as ObjectReference
		DisarmSound.Play(ObjSelf)
		setDestroyed()
		;Self.Disable()
	endEvent
EndState

Event OnWorkshopObjectPlaced(ObjectReference akReference)
	Debug.Trace(Self + ": TRAP WAS PLACED IN WORKSHOP MODE")
	;CheckForWorkshop()
	IsWorkshopVersion = true
	if !IsPowered()
		GoToState("Busy")
	endif
EndEvent

Event OnworkshopObjectMoved(ObjectReference akReference)
	IsWorkshopVersion = true
EndEvent

Event OnPowerOn(ObjectReference akPowerGenerator)
	;if GetState() == "Busy"
		GoToState("Active")
	;endif
EndEvent

Event OnPowerOff()
	GoToState("Busy")
EndEvent


;==================================================
;		Functions Block
;==================================================

;Centralized
Function Trigger()
	TriggerSound.play(self)
	playAnimation(TriggerAnim)
	self.Activate(self, true)
	gotostate("Inactive")
	isArmed = false
EndFunction

Function DisarmTrigger(Actor DisarmingActor)
	if !DontDisarm 
		DisarmingActor.AddItem(TrapDisarmedReward)
		GoToState("Disarmed")
		if !IsWorkshopVersion
			Game.RewardPlayerXP(TrapDisarmXPReward.GetValueInt())
		endif
	else
		cantDisarmMessage.show()
	endif
EndFunction

; return true if the ref should trigger me
bool function ShouldTrigger(ObjectReference akTriggerRef)
	Actor TriggerActor = akTriggerRef as Actor
	if triggerByEnemiesOnly && TriggerActor && TriggerActor.IsHostileToActor(Game.GetPlayer()) == false
		return false
	elseif TriggerActor && (42 == TriggerActor.GetValue(Game.GetForm(0x0000030D) as ActorValue))
		; AFT : 0x0000030D = FavorsPerDay
		return false
	else
		return true
	endif
endFunction

Function SetArmed(bool shouldBeArmed = true)
	Debug.Trace(Self + ": shouldBeArmed = " + shouldBeArmed)
	if shouldBeArmed
		Debug.Trace(Self + ": Should be getting Reset")
		OnReset()
	else
		if IsWorkshopVersion
			Debug.Trace(Self + ": Should be getting Inactive")
    		TriggerSound.play(self)
			playAnimation(TriggerAnim)
			gotostate("Inactive")
		else
			Debug.Trace(Self + ": Should be getting Disarmed")
			GoToState("Disarmed")
		endif
	endif
EndFunction

bool Function GetIsArmed()
	return isArmed
EndFunction

;/
Function CheckForWorkshop()
	if GetCurrentLocation().HasKeyword(LocTypeWorkshop)
		IsWorkshopVersion = True
	endif
EndFunction
/;