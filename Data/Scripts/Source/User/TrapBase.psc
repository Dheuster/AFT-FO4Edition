scriptName TrapBase extends objectReference
;
;This is the base trap script and handles what the trap is told by the trigger
;Any Trap should be usable with any trigger
;Trap params are on the trap (damage, timing, etc)
;Activation params are on the trigger, toggle, number of times it can be triggered, etc.
;Individual traps will be extended from this framework

						;Trigger Types for quick reference
						;0 = Single - fire the trap once do one time
						;1 = Hold - on entry turn on, on exit turn off
						;2 = Toggle - on entry or use toggle trap state
						;3 = Turn On - on entry or use turn on trap
						;4 = Turn Off - on entry or use turn off trap
						
;================================================================

;==================================================
;		Properties Block
;==================================================

bool property init auto hidden				; This should not be set by the user
TrapHitBase property hitBase auto hidden	; Used to cast the trap to hit physically

;bool property trapDisarmed auto	hidden	; This should not be set by the user
;bool property loop auto hidden				; This should not be set by the user

;bool Property fireOnlyOnce = true auto hidden	;This should be set by the user
;sound property WindupSound auto ;Played when winding up or releasing trap
;sound Property TrapHitSound auto ;Played when the trap hits something
;int property trapPushBack auto 		;push back impulse provided by the trap

;bool property overrideLoop = False auto hidden

int Property TrapLevel = 1 auto Const
{Used to determine the difficulty of the trap, currently only tied to damage
	0 = Easy
	1 = Medium (DEFAULT)
	2 = Hard
	3 = VeryHard}
	
int Property damage auto hidden Const




Group WarnProperties CollapsedOnRef
	bool property UseWarnTimer = true auto Const
	{if this is set, use the WarnTimer otherwise it goes by the animation End}
	float property WarnTime = 1.5 Auto Const
	{this is used if UseWarnTimer is true}
	int Property WarnTimerNumber = 100 auto hidden Const
	{}
	Sound property WarnSound Auto Const
	{Played from warn state is specified, but most should be hooked up on the anim}
	String Property WarnAnim = "Arm" Auto Const
	{Alert anim name}
	String Property WarnAnimEndEvent = "ArmState" Auto Const
	{Alert anim name}
EndGroup

Group FireTrapProperies CollapsedOnRef
	Bool Property IsPhysicalTrap = false auto Const
	{if this is true, prep for a phyical hit, this trap must have TrapHitBase to function}
	String Property FireTrapAnim = "Trip" Auto Const
	{Anim played when this is fired}
	String Property FireTrapAnimEndEvent = "TransitionComplete" Auto Const
	{Anim played when this is fired}
	Int Property aiSoundLevel = 50 Auto Const
EndGroup

Group DisarmProperties CollapsedOnRef
	objectReference Property lastActivateRef Auto hidden
	{This tracks who activated this last across states for disarming}
	Bool Property UseDefaultDisarm = true auto Const
	{use the default Disarm behavior - IE just play the anim and disable if needed}
	LeveledItem property TrapDisarmedReward auto Const
	{This is given to the disarming actor}
	bool property DisarmDisables = false auto Const
	{if true, disarming this "disables" the object}
	String Property DisarmAnim = "Disarm" Auto Const
	{Disarm Anim to play}
	Sound Property DisarmSound Auto Const
	{This is the sound to play when disarming
		TRPDisarmHiTech & TRPDisarmLoTech are the usual choices}

	GlobalVariable Property TrapDisarmXPReward Auto Const

	Keyword Property WorkshopNoRepairKeyword  Auto Const
EndGroup

bool isGrabbed = false

Bool property IsWorkshopVersion = false Auto

;==================================================
;		States Block
;==================================================

Auto State Idle

	Event onActivate(objectReference activateRef)
		Actor npc = activateRef as Actor
		
		if npc && (42 == npc.GetValue(Game.GetForm(0x0000030D) as ActorValue))
			; AFT : 0x0000030D = FavorsPerDay
			return
		endif
		
		lastActivateRef = activateRef
		if init == False	;determine if we should initialize
			initialize()
			init = True
		endif

		if activateRef as Actor
			if !IsWorkshopVersion
				GoToState("Disarm")
			endif 
		else
			GoToState("Warn")
		endif
	endEvent

	Event OnPowerOn(ObjectReference akPowerGenerator)
		if !isGrabbed
			debug.trace(self + "akPowerGenerator=" + akPowerGenerator)
			self.Activate(self)
		Endif
	endEvent
EndState

State Warn
	event OnBeginState(string asOldState)
		StartWarn()
	endEvent

	Event onActivate(objectReference activateRef)
		lastActivateRef = activateRef
		if activateRef as Actor
			GoToState("Disarm")
		endif
	endEvent
endState

State TrapFired
EndState

State Disarm
	event OnBeginState(string asOldState)
		DisarmTrap()
	endEvent
EndState


;==================================================
;		Parent Functions & Events
;==================================================

;Warn will usually either be an animation with a timer or just an animation with an end
Function StartWarn() 		; Placeholder - replaced with trap specific function
	ResolveLeveledDamage()
	if UseWarnTimer
		PlayAnimation(WarnAnim)
		StartTimer(WarnTime, WarnTimerNumber)
	else
		PlayAnimationAndWait(WarnAnim, WarnAnimEndEvent)
		FireTrap()
	endif
endFunction

;This is where the actual fun stuff happens!
Function fireTrap() 		; Placeholder - replaced with trap specific function
	;hitbase.goToState(canHit)
	ObjectReference ObjSelf = (Self as ObjectReference)
	ObjSelf.AddKeyword(WorkshopNoRepairKeyword)
	;Go to TrapFired so this can't be activated to disarm
	GoToState("TrapFired")
	LocalFireTrap()

	CreateDetectionEvent(game.GetPlayer(), aiSoundLevel)

	;If this is a physical animating trap
	if IsPhysicalTrap
		hitbase.goToState("canHit")
		PlayAnimationAndWait(FireTrapAnim, FireTrapAnimEndEvent)
		hitbase.goToState("cannotHit")
	endif
	ObjSelf.RemoveKeyword(WorkshopNoRepairKeyword)
	;PlayAnimation("Trip")

endFunction

Function DisarmTrap()
	;Disarm the trap
	if UseDefaultDisarm
		PlayAnimation(DisarmAnim)
	else
		LocalDisarmTrap()
	endif

	if DisarmSound
		objectReference objSelf = self as objectReference
		DisarmSound.Play(objSelf)
	endif
	;Give a reward to the actor if there is something in the LeveledItem
	;	otherwise use the localDisarmReward
	if !DefaultDisarmReward()
		LocalDisarmReward()
	endif

	if !IsWorkshopVersion
		Game.RewardPlayerXP(TrapDisarmXPReward.GetValueInt())
	endif

	;if this trap just disables, do so now
	if DisarmDisables
		self.Disable()
	endif	

	Self.SetDestroyed()
endFunction

bool Function DefaultDisarmReward()
	if lastActivateRef as Actor && TrapDisarmedReward
		if lastActivateRef == game.getPlayer()
			;if this is the player add items with notification
			(lastActivateRef as Actor).AddItem(TrapDisarmedReward, abSilent = false)
		else
			;if not the player, do this silently AKA if this is a companion
			(lastActivateRef as Actor).AddItem(TrapDisarmedReward, abSilent = true)
		endif
		return true
	else
		return false
	endif
endFunction

Function initialize() 	; Placeholder - replaced with trap specific function
endFunction

;placeholder for if this is needed later
Function resetLimiter()	; Placeholder - replaced with trap specific function
endFunction

;
Event OnTimer(int aiTimerID)
	if getState() != "Disarm" && getState() != "Disarmed" && getState() != "TrapFired"
		if aiTimerID == WarnTimerNumber
			fireTrap()
		endif
	endif
	LocalOnTimer(aiTimerID)
EndEvent

Event OnWorkshopObjectRepaired(ObjectReference akReference)
	debug.Trace(self + ": Recieved OnWorkshopObjectRepaired from >> " + akReference)
	;if akReference == self as objectReference
		RepairTrap()
	;endif

		if IsPowered()
			debug.trace(self + "Was repaired and already has power")
			self.Activate(self)
		Endif
EndEvent

Event OnWorkshopObjectMoved(ObjectReference akReference)
	Debug.Trace(Self + ": TRAP WAS MOVED IN WORKSHOP MODE")
	isGrabbed = false
	if IsPowered()
		debug.trace(self + "Was repaired and already has power")
		self.Activate(self)
	Endif
EndEvent

Event OnWorkshopObjectGrabbed(ObjectReference akReference)
	Debug.Trace(Self + ": TRAP WAS GRABBED IN WORKSHOP MODE")
	isGrabbed = true
EndEvent

Function RepairTrap()
	self.SetDestroyed(False)
	PlayAnimation("Set")
	GoToState("Idle")
EndFunction

Event onReset()
	goToState("Idle")
	self.Enable()
	Self.SetDestroyed(false)
	self.reset()
endEvent
;==================================================
;		Child Functions - Define in extended script
;==================================================
Function ResolveLeveledDamage () 	;placeholder function, declared in children
	hitBase = (self as objectReference) as TrapHitBase
	hitBase.damage = 0					;In child functions this will be defined
EndFunction

;Put the local stuff in here
Function LocalFireTrap()
EndFunction

;Put local disarm needs here
Function LocalDisarmTrap()
EndFunction

;Put local disarm rewards here
Function LocalDisarmReward()
EndFunction

;Use if the child needs specific timer events
Function LocalOnTimer(int aiTimerID)
endFunction

;Use if this trap needs special handling for workshop repairs
Function LocalRepairTrap()
EndFunction
