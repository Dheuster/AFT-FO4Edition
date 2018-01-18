scriptName TrapExplGas extends objectReference
;
;
;==================================================

;==================================================
;		Properties Block
;==================================================

Group Formlists CollapsedOnRef
	formlist property TrapExplOnHit auto Const
	{projectiles that will set this off when they hit}

	formlist property TrapExplOnEnter auto Const
	{objects that will set this off when they enter}

	formlist property TrapExplOnMagicEffectApply auto Const
	{magicEffects that will set this off when applied}

	;;;;;CULL - THIS CAN PROBABLY BE REMOVED LATER;;;;;
	formlist property TrapExplGasTrapEquippedSpell auto hidden Const
	{OUTDATED - Spells that will set this off if equipped and drawn}

	formlist property TrapExplGasWeapon auto Const
	{weapons that will set this off on hit, specifically explosions}
EndGroup

Group CheckActorFlags CollapsedOnRef
	bool property checkActorEquippedItems = TRUE auto Const
	{Whether or not to check items the player is carrying
		default = True on explosive gas
		set to off on oil pool}
	bool property checkActorMagic = FALSE auto Const
	{check the actors drawn magic
		default = true on explosive gas
		set to off on oil pool}

	keyword property flameKeyword Auto Const
	keyword property lightningKeyword auto Const
	bool property lightningIgnites = FALSE Auto Const
	{if this is true lightning should ignite this trap
		default == false} 
EndGroup
	
;light property Torch01 auto

Group StoredVars CollapsedOnRef
	projectile property storedProjectile auto hidden
	objectReference property storedObjRef auto hidden
	MagicEffect property storedEffect1 auto hidden
	MagicEffect property storedEffect2 auto hidden
	MagicEffect property storedEffect3 auto hidden
	MagicEffect property storedEffect4 auto hidden
	int property storedEffectIncrement =  1 auto hidden
EndGroup

;==================================================
;		Core Scripting Block
;==================================================

auto state waiting
	;Start of the new script
	Event OnHit(ObjectReference akTarget, ObjectReference akAggressor, Form akWeapon, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked, string asMaterialName)
		debug.Trace(self + ": was hit!")
		debug.Trace("	akWeapon == " + akWeapon)
		debug.Trace("	akProjectile == " + akProjectile)
		debug.Trace("	akAggressor == " + akAggressor)
		
		Actor npc = akAggressor as Actor
		if npc && (42 == npc.GetValue(Game.GetForm(0x0000030D) as ActorValue))
			; AFT : 0x0000030D = FavorsPerDay
			return
		endif
		
		if !akProjectile || akProjectile != storedProjectile
			storedProjectile = akProjectile
 			debug.Trace(self + " is testing " + akProjectile + " due to onHit, akWeapon = " + akWeapon)
			
			If TrapExplGasWeapon.hasForm(akWeapon) ;|| akweapon == torch01 ;<- no torches CULL
 				debug.Trace(self + " is exploding due to " + akWeapon + " being in formlist " + TrapExplGasWeapon)
				GasExplode(akAggressor)
			ElseIf TrapExplOnHit.hasForm(akProjectile)
 				debug.Trace(self + " is exploding due to " + akProjectile)
				GasExplode(akAggressor)
			ElseIf akWeapon.HasKeyword(flameKeyword)
 				debug.Trace(self + " is exploding due to " + akWeapon + " - hasKeyword")
				GasExplode(akAggressor)
			endif
		endif
	endEvent
	
	Event OnMagicEffectApply(ObjectReference akTarget, ObjectReference akCaster, MagicEffect akEffect)
		Actor npc = akCaster as Actor
		if npc && (42 == npc.GetValue(Game.GetForm(0x0000030D) as ActorValue))
			; AFT : 0x0000030D = FavorsPerDay
			return
		endif
	
		if akEffect == storedEffect1 || akEffect == storedEffect2 || akEffect == storedEffect3 || akEffect == storedEffect4
			;if the effect == any of the stored effects do nothing
		else
			if storedEffectIncrement == 1
				storedEffect1 = akEffect
				storedEffectIncrement = 2
			elseif storedEffectIncrement == 2
				storedEffect2 = akEffect
				storedEffectIncrement = 3
			elseif storedEffectIncrement == 3
				storedEffect3 = akEffect
				storedEffectIncrement = 4
			else
				storedEffect4 = akEffect
				storedEffectIncrement = 1
			endif
 			debug.Trace(self + " is testing " + akEffect + " due to onMagicEffectApply")
			if TrapExplOnMagicEffectApply.hasForm(akEffect as form)
 				debug.Trace(self + " is exploding due to " + akEffect)
				GasExplode(akCaster)
			elseif akEffect.hasKeyword(flameKeyword)
 				debug.Trace(self + " is exploding due to " + akEffect)
				GasExplode(akCaster)
			elseif lightningIgnites && akEffect.hasKeyword(lightningKeyword)
 				debug.Trace(self + " is exploding due to " + akEffect)
				GasExplode(akCaster)
			endif
		endif
	endEvent
	

	event onTriggerEnter(objectReference triggerRef)
		debug.Trace(self + ": has been entered by >> " + triggerRef)
		form TriggerBase = triggerRef.GetBaseObject()
		Actor npc = triggerRef as Actor
		if (npc) || !storedObjRef || storedObjRef.getBaseObject() != TriggerBase
			if npc
				if (42 == npc.GetValue(Game.GetForm(0x0000030D) as ActorValue))
					; AFT : 0x0000030D = FavorsPerDay
					return					
				endif
			else
				storedObjRef = triggerRef
			endIf
 			debug.Trace(self + " is testing " + triggerRef + " due to onTriggerEnter")
			if TrapExplOnEnter.hasForm(TriggerBase)
 				debug.Trace(self + " is exploding due to " + triggerRef)
				GasExplode(triggerRef)
			; Checking to see if the entering ref is an actor
			elseif npc
				;check actor equipped items if necessary
				if checkActorEquippedItems
					checkActorWeapons(npc)
				elseif checkActorMagic
					If npc.hasMagicEffectWithKeyword(flameKeyword)
 						debug.Trace(self + " is exploding due to " + triggerRef + " having flame effect")
						GasExplode(triggerRef)
					ElseIf lightningIgnites
						if npc.hasMagicEffectWithKeyword(lightningKeyword)
 							debug.Trace(self + " is exploding due to " + triggerRef + " having lightning effect")
							GasExplode(triggerRef)
						endif
					endif
				endif
			endif
		endif
	endEvent
	
	
	
EndState

event onReset()
	self.reset()
	self.clearDestruction()
	goToState("waiting")
endEvent


event OnDestructionStageChanged(int aiOldStage, int aiCurrentStage)
; 	debug.Trace(self + " has received destruction event #" + aiCurrentStage)
endEvent

;Init listening for OnHit Events
Event OnLoad()
	RegisterForHitEvent(akTarget = self, akAggressorFilter = None, akSourceFilter = TrapExplGasWeapon, \
  		akProjectileFilter = none, aiPowerFilter = -1, aiSneakFilter = -1, aiBashFilter = -1, aiBlockFilter = -1, \
  		abMatch = true)

	RegisterForHitEvent(akTarget = self, akAggressorFilter = None, akSourceFilter = none, \
  		akProjectileFilter = TrapExplOnHit, aiPowerFilter = -1, aiSneakFilter = -1, aiBashFilter = -1, aiBlockFilter = -1, \
  		abMatch = true)

	RegisterForMagicEffectApplyEvent(akTarget = self, akCasterFilter = None, \
		akEffectFilter = TrapExplOnMagicEffectApply, abMatch = true)
EndEvent

Event OnUnload()
	UnregisterForAllEvents()
	;Clean out our vars to they aren't made persistant
	storedProjectile = NONE
	storedObjRef = NONE
	storedEffect1 = NONE
	storedEffect2 = NONE
	storedEffect3 = NONE
	storedEffect4 = NONE
EndEvent
;==================================================
;		Parent Functions - only used on parent
;==================================================


function checkActorWeapons(actor triggerActor)
	; Checking if Torch is equipped
	if triggerActor.GetEquippedItemType(0) == 11 || triggerActor.GetEquippedItemType(1) == 11
		GasExplode(triggerActor)
	; Checking if the player has weapons drawn
	ElseIf triggerActor.IsWeaponDrawn() ;This should be a function check later
		;if the player has a flamable spell equiped and drawn
; 		debug.Trace(self + " is testing " + (triggerActor).GetEquippedSpell(0) + " due to onTriggerEnter")
; 		debug.Trace(self + " is testing " + (triggerActor).GetEquippedSpell(1) + " due to onTriggerEnter")
		if triggerActor.GetEquippedSpell(0).hasKeyword(flameKeyword)	;check left hand
			GasExplode(triggerActor)
		elseif TrapExplGasTrapEquippedSpell.hasForm(triggerActor.GetEquippedSpell(1) as form)	;check right hand
			GasExplode(triggerActor)
		endif
	endif
endFunction


;==================================================
;		Child Functions - May be redefined on Child
;==================================================

function GasExplode(objectReference causeActor)
	;if (causeActor as actor)
		self.setActorCause(causeActor as actor)
	;endif
; 	debug.Trace(self + " has exploded")
	self.damageObject(5)
endFunction







