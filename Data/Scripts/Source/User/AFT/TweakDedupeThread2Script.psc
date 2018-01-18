Scriptname AFT:TweakDedupeThread2Script extends Quest

Quest Property TweakDedupeMaster Auto Const
FormList Property TweakDedupe2Items Auto Const
GlobalVariable  Property pTweakDedupeThreadsDone Auto Const
Form Property Arena_Wager_Container Auto Const

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakDedupeThread2Script"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Function Dedupe(Actor Receiver)
	Actor pc = Game.GetPlayer()

	float[] posdata = TraceCircle(Receiver,-100)
	
	ObjectReference dupContainer = Receiver.PlaceAtMe(Arena_Wager_Container)
	dupContainer.SetPosition(posdata[0],posdata[1],posdata[2])
	ObjectReference filterContainer = Receiver.PlaceAtMe(Arena_Wager_Container)
	filterContainer.SetPosition(posdata[0],posdata[1],posdata[2])
	
	if (!dupContainer || !filterContainer)
		Trace("Bailing. Container creation Failure")
		if dupContainer
			dupContainer.disable()
			dupContainer.delete()
			dupContainer = None
		endif
		if filterContainer
			filterContainer.disable()
			filterContainer.delete()
			filterContainer = None
		endif
		pTweakDedupeThreadsDone.mod(-1.0)
		return
	endIf
	
	Trace("Beginning Single item extraction")
	
	int i = 0
	bool keepgoing = true
	int numitems = TweakDedupe2Items.GetSize()
	while (i < numitems && keepgoing)
		pc.RemoveItem(TweakDedupe2Items.GetAt(i),1,true,filterContainer)
		i += 1
		if (0 == (i % 32))
			keepgoing = (pTweakDedupeThreadsDone.GetValue() > 0.0)
		endif
	endWhile
	Trace("Single item extraction complete")

	Utility.waitMenuMode(0.1)
	
	pc.RemoveItem(TweakDedupe2Items,-1,true,dupContainer)
		
	Utility.waitMenuMode(0.1)
	
	if	dupContainer
		Trace("Moving Duplicates To Receiver")

		dupContainer.RemoveItem(TweakDedupe2Items,-1,true,Receiver)
		Utility.WaitMenuMode(0.1)
		int maxwait = 10
		while (maxwait > 0 && dupContainer.GetItemCount() > 0)
			Utility.WaitMenuMode(0.5)
			maxwait -= 1
		endWhile
		if 0 == maxwait
			Trace("Warning : Not all elements removed from dupContainer")
			dupContainer.RemoveAllItems(Receiver)	
			Utility.WaitMenuMode(0.3)
		endif		
		dupContainer.Disable()
		dupContainer.Delete()
		dupContainer = None
	else
		Trace("Warning: dupContainer is None.")
	endif
		
	if	filterContainer
	
		Trace("Moving single copies back to Player")
		filterContainer.RemoveItem(TweakDedupe2Items,-1,true,pc)
		
		Utility.WaitMenuMode(0.1)
		int maxwait = 10
		while (maxwait > 0 && filterContainer.GetItemCount() > 0)
			Utility.WaitMenuMode(0.5)
			maxwait -= 1
		endWhile
		if 0 == maxwait
			Trace("Warning : Not all elements removed from filterContainer Using Backup Implementation")
			filterContainer.RemoveAllItems(pc)
			Utility.WaitMenuMode(0.3)
		endif
				
		filterContainer.Disable()
		filterContainer.Delete()
		filterContainer = None
	else
		Trace("Warning: filterContainer is None.")
	endif
	
	pTweakDedupeThreadsDone.mod(-1.0)

EndFunction

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