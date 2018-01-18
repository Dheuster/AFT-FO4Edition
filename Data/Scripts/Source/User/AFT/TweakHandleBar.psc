Scriptname AFT:TweakHandleBar extends ObjectReference Const

Keyword   Property LinkCustom08 Auto Const
Keyword   Property LinkCustom09 Auto Const
Furniture Property pTweakFurnBarStool Auto Const

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakHandleBar"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

int ONLOAD_FLOOD_PROT   = 999 const
int ONUNLOAD_FLOOD_PROT = 999 const

Event OnTimer(int akTimer)
	if ONLOAD_FLOOD_PROT == akTimer
		OnLoadHelper()
		return
	endif
	if ONUNLOAD_FLOOD_PROT == akTimer
		OnUnLoadHelper()
	endif
EndEvent

Event OnLoad()
	Trace("OnLoad")
	CancelTimer(ONLOAD_FLOOD_PROT)
	StartTimer(0.5, ONLOAD_FLOOD_PROT)
EndEvent

Event OnUnload()
	Trace("OnUnload")
	CancelTimer(ONUNLOAD_FLOOD_PROT)
	StartTimer(0.5, ONUNLOAD_FLOOD_PROT)
EndEvent

Function OnLoadHelper()
	Trace("OnLoadHelper")
	ObjectReference theBarStool1 = GetLinkedRef(LinkCustom08)
	ObjectReference theBarStool2 = GetLinkedRef(LinkCustom09)
	if IsEnabled()
		Trace("IsEnabled")
		if (!theBarStool1)
			Trace("Creating BarStool1")
			theBarStool1 = PlaceAtMe(pTweakFurnBarStool)
			SetLinkedRef(theBarStool1, LinkCustom08)
		endif
		if (theBarStool1)
			Trace("Moving BarStool1")
			float[] posdata = TraceCircle(self,140,-150)
			theBarStool1.SetPosition(posdata[0],posdata[1],posdata[2])
			theBarStool1.SetAngle(0,0,theBarStool1.GetAngleZ() + theBarStool1.GetHeadingAngle(self))
			; Fix Texture Glitch
			theBarStool1.Disable()
			theBarStool1.Enable()
		endif
		if (!theBarStool2)
			Trace("Creating BarStool2")
			theBarStool2 = PlaceAtMe(pTweakFurnBarStool)
			SetLinkedRef(theBarStool2, LinkCustom09)
		endif
		if theBarStool2
			Trace("Moving BarStool2")
			float[] posdata = TraceCircle(self,130,170)
			theBarStool2.SetPosition(posdata[0],posdata[1],posdata[2])
			theBarStool2.SetAngle(0,0,theBarStool2.GetAngleZ() + theBarStool2.GetHeadingAngle(self))
			; Fix Texture Glitch
			theBarStool2.Disable()
			theBarStool2.Enable()
		endif		
	else
		Trace("Not Enabled")
		if (theBarStool1)
			Trace("Disabling BarStool1")
			theBarStool1.Disable()
		endif
		if (theBarStool2)
			Trace("Disabling BarStool2")
			theBarStool2.Disable()
		endif
	endif
EndFunction

Function OnUnLoadHelper()
	Trace("OnUnLoadHelper")
	ObjectReference theBarStool1 = GetLinkedRef(LinkCustom08)
	ObjectReference theBarStool2 = GetLinkedRef(LinkCustom09)
	if (theBarStool1)
		Trace("Deleting theBarStool1")
		SetLinkedRef(None, LinkCustom08)
		theBarStool1.Disable()
		theBarStool1.Delete()
		theBarStool1 = None
	endif
	if (theBarStool2)
		Trace("Deleting theBarStool2")
		SetLinkedRef(None, LinkCustom09)
		theBarStool2.Disable()
		theBarStool2.Delete()
		theBarStool2 = None
	endif
EndFunction

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
    endif
    if (a >= 360)
        a = a - 360
    endif 
	return a
EndFunction