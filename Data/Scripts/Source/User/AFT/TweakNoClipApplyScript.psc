Scriptname AFT:TweakNoClipApplyScript extends activemagiceffect

Formlist Property TweakElevatorList Auto Const
ActorValue Property Paralysis Auto Const

bool Function Trace(string asTextToPrint, Actor npc = None, int aiSeverity = 0) debugOnly
	string logName = "TweakNoClipApplyScript"
	debug.OpenUserLog(logName)
	if npc
		RETURN debug.TraceUser(logName, npc + asTextToPrint, aiSeverity)
	endif
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

; When NoCLIP is enabled and the follower is in an elevator when it comes to a stop, something about being paralyzed during the cell transition 
; causes the NPC to fall into ragdoll... which is bad. Recovery requires a load screen and then a Summon All Followers. 
;
; To avoid, we try our best to detect if we are near or in an elevator and ignore the Effect Start when that is the case.
Event OnEffectStart(Actor akTarget, Actor akCaster)

	Trace("OnEffectStart", akTarget)
	Trace("  Target [" + akTarget + "] Caster [" + akCaster + "]", akTarget)
		
	if (0 == akTarget.GetValue(Paralysis) )
		if (0 != (akCaster.FindAllReferencesOfType(TweakElevatorList,200)).Length)
			Trace("  Aborting: Nearby Elevators Found:",akTarget)
			return
		endif
		if (akTarget.GetActorBase().GetFormID() == 0x0001D15C)
			float[] posdata = TraceCircle(akCaster, 100.0, 180.0)
			akTarget.SetPosition(posdata[0],posdata[1],posdata[2])
			akTarget.SetAngle(0.0,0.0, akCaster.GetAngleZ())
			return
		endif
		Trace("  Activating NoClip",akTarget)
		akTarget.SetValue(Paralysis,2)		
	else
		Trace("  Aborting: Paralysis value is not 0",akTarget)		
	endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	Trace("OnEffectFinish", akTarget)
	if (2.0 == akTarget.GetValue(Paralysis))
		Trace("  DeActivating NoClip",akTarget)
		akTarget.SetValue(Paralysis,0)
	else
		Trace("  Aborting: Paralysis value is not 2",akTarget)		
	endif
	
endEvent

; AngleOffset:
;  -90     = Players left. 
;   90     = Players right, 
; 180/-180 = behind player
Float[] Function TraceCircle(ObjectReference n, Float radius = 500.0, Float angleOffset = 0.0)
	
    float azimuth = ConvertToSinCosCompatibleAngle(n.GetAngleZ(), angleOffset)

    Float xoffset = radius * Math.cos(azimuth)
    Float yoffset = radius * Math.sin(azimuth)

    Float[] r = new Float[3]
    r[0] =  (n.GetPositionX() + xoffset)
    r[1] =  (n.GetPositionY() + yoffset)
    r[2] =   n.GetPositionZ()
    return r

endFunction

Float Function ConvertToSinCosCompatibleAngle(Float original, Float angleOffset = 0.0)

	; See TweakFollowerScript for explanation
	return Enforce360Bounds(450 - original + angleOffset)	
	
EndFunction

Float Function Enforce360Bounds(float a)
    if (a < 0) 
        a = a + 360
    endIf
    if (a > 360)
        a = a - 360
    endIf 
	return a
EndFunction  
