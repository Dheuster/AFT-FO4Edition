Scriptname TrapCanChimes extends ObjectReference

Sound Property TriggerSound auto const
int Property aiSoundLevel auto const

MiscObject Property Item01 auto const
int Property Item01Number auto const

explosion property havokNudge auto const

bool Property deleteOnLooted = false auto const

GlobalVariable Property TrapDisarmXPReward Auto Const

keyword Property LocTypeWorkshop Auto Const

bool Property IsWorkshopVersion = false Auto
;==================================================
;		Events Block
;==================================================

Event OnReset()
    self.setdestroyed(false)
    ClearDestruction()
    reset() 
EndEvent

Event OnLoad()
    RegisterforHitEvent(self)
EndEvent

Event OnUnload()
    UnregisterforHitEvent(self)
EndEvent

Event OnCellAttach()
	;CheckForWorkshop()
EndEvent

;==================================================
;		State Block
;==================================================

Auto state Active
	Event OnTriggerEnter(ObjectReference akActionRef)
		Actor npc = akActionRef as Actor
		if npc && (42 == npc.GetValue(Game.GetForm(0x0000030D) as ActorValue))
			; AFT : 0x0000030D = FavorsPerDay
			return
		endif
		debug.Trace(self + ": Entered by >> " + akActionRef)
		TriggerSound.play(self)
		CreateDetectionEvent(akActionRef as Actor, aiSoundLevel)
        if havokNudge
            self.placeAtMe(havokNudge)
        endIf
        ApplyHavokImpulse(0.0, 0.0, -1.0, 15.0)

	EndEvent

	Event OnHit(ObjectReference akTarget, ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, \
  bool abSneakAttack, bool abBashAttack, bool abHitBlocked, string apMaterial)
	    OnTriggerEnter(akAggressor)
	    RegisterforHitEvent(self)
	EndEvent

	Event onActivate(objectReference akActivator)
		debug.Trace(self + ": Activated by >> " + akActivator)
		TriggerSound.play(self)
		self.disable()
		if deleteOnLooted
			self.delete()
		endif
		Game.getplayer().additem(item01,Item01Number)
		gotostate("Inactive")
		if !IsWorkshopVersion
			Game.RewardPlayerXP(TrapDisarmXPReward.GetValueInt())
		endif
	EndEvent
EndState

state Inactive
	Event OnBeginState(string asOldState)
	    self.setdestroyed(true)
	EndEvent
EndState


Event OnWorkshopObjectPlaced(ObjectReference akReference)
	Debug.Trace(Self + ": TRAP WAS PLACED IN WORKSHOP MODE")
	;CheckForWorkshop()
	IsWorkshopVersion = true
EndEvent

Event OnworkshopObjectMoved(ObjectReference akReference)
	IsWorkshopVersion = true
EndEvent

;/
Function CheckForWorkshop()
	if GetCurrentLocation().HasKeyword(LocTypeWorkshop)
		IsWorkshopVersion = True
	endif
EndFunction
/;