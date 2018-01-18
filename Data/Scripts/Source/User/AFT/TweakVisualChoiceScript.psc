Scriptname AFT:TweakVisualChoiceScript extends Quest

ReferenceAlias Property TargetActor Auto
Scene Property TweakVCScene1 Auto

GlobalVariable Property pTweakVCUpText Auto;    0 = None 1 = Toggle 2 = Add    3 = Choose
GlobalVariable Property pTweakVCDownText Auto;  0 = None 1 = Done   2 = Remove 3 = Alt
GlobalVariable Property pTweakVCLeftText Auto;  0 = None 1 = Done   2 = Prev 
GlobalVariable Property pTweakVCRightText Auto; 0 = None 1 = Done   2 = Next 

ScriptObject Property receiver_script Auto hidden

int TIMER_MONITOR_SCENE = 0
int TIMER_AVOID_SCENE_COLLAPSE = 1

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakVisualChoiceScript"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Event OnQuestInit()
	Trace("OnQuestInit()")
	pTweakVCUpText.SetValue(1)
	pTweakVCDownText.SetValue(3)
	pTweakVCLeftText.SetValue(2)
	pTweakVCRightText.SetValue(0)
	receiver_script = None
	Trace("OnQuestInit() Finished")	
EndEvent

Function OnGameLoaded(bool firstCall=False)
	Trace("OnGameLoaded()")
	pTweakVCUpText.SetValue(0)
	pTweakVCDownText.SetValue(0)
	pTweakVCLeftText.SetValue(0)
	pTweakVCRightText.SetValue(0)
	EndChoice()
	Trace("OnGameLoaded() Finished")	
EndFunction

Function EndChoice()
	Trace("EndChoice Called")
	if TweakVCScene1.IsPlaying()
		TweakVCScene1.Stop()
	endif
	CancelTimer(TIMER_MONITOR_SCENE)
	if receiver_script
		Var[] params = new Var[0]
		receiver_script.CallFunctionNoWait("OnChoiceEnd",params)
		receiver_script = None
	endif
	Actor npc = TargetActor.GetActorReference()
	if npc
		UnRegisterForDistanceEvents(Game.GetPlayer(),npc)
		TargetActor.Clear()
	endif
EndFunction

; max_radius : If non-zero and npc is furhter than this value, they will be teleported
;              to the player.
; min_radius : If non-zero and npc is CLOSER than this value, they will be teleported away to the min_radius. 
;              
; Pass in the same value for max and min to enforce a specific distance. 
Bool Function StartChoice(Actor npc, ScriptObject receiver, float max_radius = 150.0, float min_radius = 0.0)

	Trace("StartChoice Called")
	if (!npc)
		Trace("NPC is None. Aborting")
		return false
	endif
	if (!receiver)
		Trace("receiver is None. Aborting")
		return false
	endif
	
	bool doMoveNPC = false
	Actor pc = Game.GetPlayer()

	if (max_radius > 299)
		max_radius = 300
	endif

	if (min_radius < 0)
		min_radius = 0
	endif
	
	float ax = 0.0
	float ay = 0.0
	
	if (0 != max_radius && !DistanceWithin(npc, pc, max_radius))
		doMoveNPC = true
		float[] posdata = TraceCircle(pc,max_radius,0)
		; SetPosition resets the x and y angles...
		ax = npc.GetAngleX()
		ay = npc.GetAngleY()
		npc.SetPosition(posdata[0],posdata[1],posdata[2])
	elseif  (0 != min_radius && DistanceWithin(npc, pc, min_radius))
		doMoveNPC = true
		float[] posdata = TraceCircle(pc,min_radius,0)
		; SetPosition resets the x and y angles...
		ax = npc.GetAngleX()
		ay = npc.GetAngleY()
		npc.SetPosition(posdata[0],posdata[1],posdata[2])		
	endif
	
	Trace("Forcing NPC into ReferenceAlias")
	TargetActor.ForceRefTo(npc)
	RegisterForDistanceGreaterThanEvent(pc, npc, 300.0)
			
	receiver_script = receiver	
	Trace("Starting Scene")
	TweakVCScene1.Start()	
	npc.EvaluatePackage()
	
	if (doMoveNPC)
		; Wait a moment for the Scene AI to stop the NPC
		Utility.wait(1.0)	
		npc.SetAngle(ax, ay, npc.GetAngleZ() + npc.GetHeadingAngle(pc))
	endif
	
	Var[] params = new Var[0]
	receiver_script.CallFunctionNoWait("OnChoiceBegin",params)

	; Start up a Monitor Timer to detect when the scene ends. 
	StartTimer(4.0,TIMER_MONITOR_SCENE)
	return true
	
EndFunction

Event OnDistanceGreaterThan(ObjectReference akObj1, ObjectReference akObj2, float afDistance)
	Trace ("OnDistanceGreaterThan [" + akObj1 + "," + akObj2 + "] : [" + afDistance + "]")
	if (akObj2 != TargetActor.GetReference())
		Trace ("akObj2 does not match expected. Unregistering Event]")
		UnRegisterForDistanceEvents(akObj1,akObj2)
		return
	endif
	if (afDistance < 300.0)
		Trace ("afDistance < 300, ignoring...")
		return
	endif
	Trace ("Player is no longer close to NPC. Ending Scene.")
	EndChoice()
EndEvent

Event OnTimer(int aiTimerID)

	Trace ("OnTimer [" + aiTimerID + "]")
	if (aiTimerID < 2)
		if (None == receiver_script)
			Trace ("receiver_script is None. Ending Scene.")
			EndChoice()
			return
		endif	
		Actor npc = TargetActor.GetActorReference()
		if (!npc)
			Trace ("TargetActor ReferenceAlias is empty. Ending Scene.")
			EndChoice()
			return
		endif
		Trace ("TargetActor ReferenceAlias has Actor")
		Scene npc_current_scene = npc.GetCurrentScene()
		if (!npc_current_scene)
			if (TIMER_MONITOR_SCENE == aiTimerID)
			
				Trace ("npc_current_scene is None. Checking Again in 2 seconds..")
		
				; When they click an arrow, there is a brief moment when
				; no scene is playing. This double hit requirement helps
				; mitigate the possiblity of the check firing at the same
				; moment. 
			
				StartTimer(2.0,TIMER_AVOID_SCENE_COLLAPSE)
				return
			endif
			Trace ("npc_current_scene is still None. Ending Scene.")
			EndChoice()
			return
		endif
		if (npc_current_scene != TweakVCScene1)
			Trace ("NPC is in scene, but not TweakVCScene1. Ending Scene.")
			EndChoice()
			return
		endif
	
		Trace ("NPC is in TweakVCScene1. Renewing timer...")
		; Still in scene. Refire...
		StartTimer(4.0,TIMER_MONITOR_SCENE)
	endif
	
EndEvent

; AngleOffset:
;  -90     = Players left. 
;   90     = Players right, 
; 180/-180 = behind player
Float[] Function TraceCircle(ObjectReference n, Float radius = 300.0, Float angleOffset = 0.0)
	
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
    if (a > 360)
        a = a - 360
    endif 
	return a
EndFunction

; Square Root is expensive. Most people are interested in equality original
; range, which doesn't require the square root function...
Bool Function DistanceWithin(ObjectReference a, ObjectReference b, float distance)
    float total  = 0.0
	float factor = (a.GetPositionX() - b.GetPositionX())
	total += (factor * factor)
	factor = (a.GetPositionY() - b.GetPositionY())
	total += (factor * factor)
	factor = (a.GetPositionZ() - b.GetPositionZ())
	total += (factor * factor)
	return ((distance * distance) > total)
EndFunction

Function EventOnChooseUp()
	Trace ("EventOnChooseUp() Fired")
	Var[] params = new Var[0]
	receiver_script.CallFunctionNoWait("OnChooseUp",params)
EndFunction

Function EventOnChooseDown()
	Trace ("EventOnChooseDown() Fired")
	Var[] params = new Var[0]
	receiver_script.CallFunctionNoWait("OnChooseDown",params)
EndFunction

Function EventOnChooseLeft()
	Trace ("EventOnChooseLeft() Fired")
	Var[] params = new Var[0]
	receiver_script.CallFunctionNoWait("OnChooseLeft",params)
EndFunction

Function EventOnChooseRight()
	Trace ("EventOnChooseRight() Fired")
	Var[] params = new Var[0]
	receiver_script.CallFunctionNoWait("OnChooseRight",params)
EndFunction

