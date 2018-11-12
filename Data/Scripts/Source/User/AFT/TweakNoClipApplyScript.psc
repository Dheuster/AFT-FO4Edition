Scriptname AFT:TweakNoClipApplyScript extends activemagiceffect

Formlist Property TweakElevatorList Auto Const
Faction	 Property TweakPosedFaction Auto Const
ActorValue Property Paralysis Auto Const

bool Function Trace(string asTextToPrint, Actor npc = None, int aiSeverity = 0) debugOnly
	string logName = "TweakNoClipApplyScript"
	debug.OpenUserLog(logName)
	if npc
		RETURN debug.TraceUser(logName, npc + asTextToPrint, aiSeverity)
	endif
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Trace("OnEffectStart", akTarget)
	Trace("  Target [" + akTarget + "] Caster [" + akCaster + "]", akTarget)

	; 1.22 : Safer Implementation
	
	if (0 != akTarget.GetValue(Paralysis) )
		Trace("  Aborting: Paralysis is not 0 (companion paralyzed/knocked out)",akTarget)
		return
	endif

	if (aktarget.IsBleedingOut())
		Trace("  Aborting: Target is Bleeding Out",akTarget)
		return
	endif
	
	if (2.0 == aktarget.GetFactionRank(TweakPosedFaction))
		Trace("  Aborting: Target is Posed:",akTarget)
		return
	endif
		
	if (0 != (akCaster.FindAllReferencesOfType(TweakElevatorList,200)).Length)
		Trace("  Aborting: Nearby Elevators Found:",akTarget)
		return
	endif

			
	; int ActorBaseID = akTarget.GetActorBase().GetFormID()
	; if (ActorBaseID > 0x00ffffff)
		; if ActorBaseID > 0x80000000
			; ActorBaseID -= 0x80000000
		; endif
		; int ActorBaseMask = ActorBaseID % (0x01000000) 
		; if 0x0000FD5A == ActorBaseMask ; Ada
			; float[] posdata = TraceCircle(akCaster, 100.0, 180.0)
			; akTarget.SetPosition(posdata[0],posdata[1],posdata[2])
			; akTarget.SetAngle(0.0,0.0, akCaster.GetAngleZ())
			; return
		; endif
	; elseif (ActorBaseID == 0x0001D15C)
		; float[] posdata = TraceCircle(akCaster, 100.0, 180.0)
		; akTarget.SetPosition(posdata[0],posdata[1],posdata[2])
		; akTarget.SetAngle(0.0,0.0, akCaster.GetAngleZ())
		; return
	; endif
	
	Trace("  Activating NoClip v1.22",akTarget)	
	
	; This allows the player to walk through NPCs...but if an animation event
	; fires while they are paralyzed (hit by something for example. Elevator 
	; comes to a stop. Begin to use furniture. Etc.... ), they will go into ragdoll, 
	; which requires console to fix. (recycleactor + moveto player). Not an option
	; for xbox users. So we are going with the safer implementation, even if it 
	; is less cool. 
	;
	; If I can figure out a way to recover the AI from ragdoll when the effect ends, 
	; I may re-enable in the future. But for now, it is causing too many bug reports.
	
	; akTarget.SetValue(Paralysis, 2)

	float[] posdata = TraceCircle(akCaster, 100.0, 180.0)
	akTarget.SetPosition(posdata[0],posdata[1],posdata[2])
	akTarget.SetAngle(0.0,0.0, akCaster.GetAngleZ())
	
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	Trace("OnEffectFinish", akTarget)
	
	; 1.22 : We leave this check in place incase someone was
	; in no-clip during the upgrade. 
	
	if (2.0 == akTarget.GetValue(Paralysis))
		Trace("  DeActivating NoClip",akTarget)
		akTarget.SetValue(Paralysis,0)
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
