ScriptName TrapThistleScript extends ObjectReference 
{On entering the trigger zone, the thistle releases stinging nettles}

Explosion Property ExplosionToPlace Auto 

Hazard Property hazardToPlace Auto

ObjectReference Property MyHazard Auto Hidden 

potion property Thistle auto

float Property WarnTime = 4.0 Auto
float Property HazardClearTime = 8.0 Auto

int WarnTimerID = 99
int HazardClearID = 10

;***************************************

Function ResetThistle()
  PlayAnimation( "reset" )
  setDestroyed(false)
  clearDestruction()
endFunction

;***************************************

Event OnCellDetach()
  if(MyHazard)
    MyHazard.delete()
  endif
EndEvent 

;***************************************

Event OnTimer(int aiTimerID)
  if(aiTimerID == HazardClearID && MyHazard)
    MyHazard.delete()
  elseif aiTimerID == WarnTimerID
    gotoState("PostPoisonPlant")
  Endif
EndEvent

;***************************************

Event OnReset()
  PlayAnimation( "reset" )
  setDestroyed(false)
  clearDestruction()
EndEvent
;***************************************

Event OnActivate(ObjectReference akActionRef)
  if(akActionRef as actor)
    ;picked anim will go here
    DamageObject(10)
    CancelTimer(WarnTimerID)
    akActionRef.AddItem(Thistle, 1)
  endif
EndEvent

;***************************************

Auto State PrePoisonPlant
 Event OnTriggerEnter(objectReference akActionref)
	Actor npc = akActionref as Actor
	if npc && (42 == npc.GetValue(Game.GetForm(0x0000030D) as ActorValue))
		; AFT : 0x0000030D = FavorsPerDay
		return
	endif
    startTimer(WarnTime, WarnTimerID)
    ;gotoState("PostPoisonPlant")
    ;PlayAnimation("stage2")
    
  endEvent
EndState                             

;***************************************

State PostPoisonPlant
  Event OnTriggerEnter(ObjectReference akActionref)
      ;Do nothing
  endEvent

  Event OnBeginState(string asOldState)
    PlayAnimation("stage2")
    DamageObject(10)
    placeatme(ExplosionToPlace)
    if(HazardToPlace)
      MyHazard = placeatme(HazardToPlace)
      starttimer(HazardClearTime, HazardClearID)
    endif
  EndEvent
EndState

;***************************************


