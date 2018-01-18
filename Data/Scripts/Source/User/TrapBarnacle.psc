Scriptname TrapBarnacle extends ObjectReference

Group AnimNames CollapsedOnRef
	String Property TriggerAnim = "Trip" auto
	;String Property TriggerEvent = "TransitionComplete" auto
	;String Property ResetAnim = "Stage1" auto
	;String Property ResetEvent = "TransitionComplete" auto
	;String Property DisarmAnim = "stage1" auto
	;String Property DisarmEvent = "TransitionComplete" auto
EndGroup

Sound Property TriggerSound auto

Explosion Property BarnacleExplosion Auto 

Hazard Property BarnacleHazard Auto

ObjectReference Property MyHazard Auto Hidden
;==================================================
;		Events Block
;==================================================

Event OnReset()
    self.setdestroyed(false)
    gotostate("Active")
    reset()
EndEvent

;==================================================
;		State Block
;==================================================

Auto state Active
	Event OnTriggerEnter(ObjectReference akActionRef)
		debug.Trace(self + ": Entered by >> " + akActionRef)
		Actor npc = akActionRef as Actor
		if npc && (42 == npc.GetValue(Game.GetForm(0x0000030D) as ActorValue))
			; AFT : 0x0000030D = FavorsPerDay
			return
		endif
		TriggerSound.play(self) 
		playAnimation(TriggerAnim)
		;placeatme(ExplosionToPlace)
		if(BarnacleHazard)
      		MyHazard = placeatme(BarnacleHazard)
      		starttimer(5, 10)
    	endif
    	gotostate("Inactive")
	EndEvent
	
	Event OnHit(ObjectReference akTarget, ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked, string asMaterialName)
		debug.Trace(self + ": Hit by >> " + akAggressor)
		Actor npc = akAggressor as Actor
		if npc && (42 == npc.GetValue(Game.GetForm(0x0000030D) as ActorValue))
			; AFT : 0x0000030D = FavorsPerDay
			return
		endif
		TriggerSound.play(self)
		playAnimation(TriggerAnim)
		;placeatme(ExplosionToPlace)
		if(BarnacleHazard)
      		MyHazard = placeatme(BarnacleHazard)
      		starttimer(5, 10)
    	endif
    	gotostate("Inactive")
    EndEvent


;	Event onActivate(objectReference akActivator)
;		debug.Trace(self + ": Activated by >> " + akActivator)
;		TriggerSound.play(self)
;		playAnimation(TriggerAnim)
;		gotostate("Inactive")
;	EndEvent
EndState

state Inactive
	Event OnBeginState(string asOldState)
	   
	EndEvent

	Event OnTimer(int aiTimerID)
  		if(aiTimerID == 10 && MyHazard)
    		MyHazard.delete()
  		endif
  			self.setdestroyed(true)
	EndEvent

EndState


