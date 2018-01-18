Scriptname AFT:TweakDedupeMasterScript extends Quest

; Dont use import. It only works when .pex files are local. Once you package them up into an 
; release/final archive, the scripts wont be found and everything will break...
; import AFT

Quest Property pTweakDedupeThread1					Auto Const
Quest Property pTweakDedupeThread2					Auto Const
Quest Property pTweakDedupeThread3					Auto Const
Quest Property pTweakDedupeThread4					Auto Const

FormList Property pWorkshopConsumeScavenge			Auto Const

GlobalVariable   Property pTweakDedupeThreadsDone	Auto Const
Message			 Property TweakDedupeProgressMsg    Auto Const
Message			 Property TweakDedupeDoneMsg        Auto Const

int DEDUPE_PROGRESS = 1 const


; Scan is asynchronous. This temporary property is used to remember the 
; the receiver of results between two methods that fire within a second
; of each other. Property is almost immediatly reset to NONE. 
;
; Consider redoing method to use CallNoWait() instead of Timer to fork. 


; LOCAL SCOPE

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakDedupeMasterScript"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction


Function PlayerDedupe(Actor pReceiver)
	Trace("PlayerDedupe Called")
	; We dont want this function to return until it is done...
	Var[] params = new Var[1]
	params[0] = pReceiver
	self.CallFunctionNoWait("DedupeHelper", params)
EndFunction

form[] pcOutfit
Function DedupeHelper(Actor Receiver)
	Trace("DedupeHelper Called")
	if !Receiver
		trace("No Receiver. Bailing")
		return
	endif
	
	Actor pc = Game.GetPlayer()
	pTweakDedupeThreadsDone.SetValue(4)
	
	; Give Walls and Floors a head start....
	AFT:TweakDedupeThread1Script pThread1 = (pTweakDedupeThread1 as AFT:TweakDedupeThread1Script)
	AFT:TweakDedupeThread2Script pThread2 = (pTweakDedupeThread2 as AFT:TweakDedupeThread2Script)
	AFT:TweakDedupeThread3Script pThread3 = (pTweakDedupeThread3 as AFT:TweakDedupeThread3Script)
	AFT:TweakDedupeThread4Script pThread4 = (pTweakDedupeThread4 as AFT:TweakDedupeThread4Script)

	AddInventoryEventFilter(None)
	RegisterForRemoteEvent(pc,"OnItemUnEquipped")
	pcOutfit = new Form[0]
	
	TweakDedupeProgressMsg.Show()
	StartTimer(2.0, DEDUPE_PROGRESS)
	Var[] params = new Var[1]
	params[0] = Receiver
	
	if pThread1
		Trace("Calling pThread1.Dedupe()")
		pThread1.CallFunctionNoWait("Dedupe", params)
	endif
	if pThread2
		Trace("Calling pThread2.Dedupe()")
		pThread2.CallFunctionNoWait("Dedupe", params)
	endif
	if pThread3
		Trace("Calling pThread3.Dedupe()")
		pThread3.CallFunctionNoWait("Dedupe", params)
	endif
	if pThread4
		Trace("Calling pThread4.Dedupe()")
		pThread4.CallFunctionNoWait("Dedupe", params)
	endif
	
    int timeout = 40	
    while (timeout > 0)
		int done = pTweakDedupeThreadsDone.GetValueInt()
		Trace("[" + done + "] of [4] threads still running")
        if (0 ==  done)
            timeout = -1
        Else
            timeout -= 1
            Utility.Wait(0.5)
        EndIf
    endWhile

	pTweakDedupeThreadsDone.SetValue(0)
	
	if (0 == timeout)
		Trace("Dedupe Finished (max time reached)")
        Utility.Wait(0.5)		
	else
		Trace("Dedupe Finished")
	endif
	
	UnRegisterForRemoteEvent(pc,"OnItemUnEquipped")
	RemoveAllInventoryEventFilters()

	Trace("Moving Junk To NPC")
	pc.RemoveItem(pWorkshopConsumeScavenge,-1,true,Receiver)
	
	if pcOutfit
		int outfititems = pcOutfit.Length
		if outfititems > 0
			Trace("Outfit items detected. Equipping items on player...")	
			int oi = 0
			while (oi < outfititems)
				Trace("Equip [" + pcOutfit[oi] + "]")	
				pc.EquipItem(pcOutfit[oi], false, true)
				oi += 1
			endwhile
		endif
	
		Trace("Cleaning up pcOutfit")	
		pcOutfit.Clear()
		pcOutfit = None
	else
		Trace("Warning: pcOutfit is None.")
	endif
		
	Armor pipboy = Game.GetForm(0x00021B3B) as Armor
	if !pc.IsEquipped(pipboy)
		Trace("PipBoy is not equipped. Equipping PipBoy")	
		pc.EquipItem(pipboy)
	else
		Trace("PipBoy is already equipped")
	endif
	
	Sound takeAll = Game.GetForm(0x000802A6) as Sound
	if takeAll
		takeAll.play(pc)
	endif
		
EndFunction

Event Actor.OnItemUnEquipped(Actor pc, Form akBaseObject, ObjectReference akReference)
	; Trace("PC.OnItemUnEquipped [" + akBaseObject + "]")
	pcOutfit.Add(akBaseObject)
EndEvent

Event OnTimer(int aiTimerID)
	if (DEDUPE_PROGRESS == aiTimerID)
		int current = pTweakDedupeThreadsDone.GetValueInt()
		Trace("Progress Fired: current [" + current + "]")
		if (current > 0)
			TweakDedupeProgressMsg.Show() 
			StartTimer(2.0, 1)
		else
			TweakDedupeDoneMsg.Show(4, 4) 
		endif
	endif
EndEvent
