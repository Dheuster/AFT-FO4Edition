Scriptname AFT:TweakUnlockVisibleScript extends Quest

FormList Property TweakConstructed_Cont Auto Const
FormList Property TweakNonConstructed_Cont Auto Const
FormList Property TweakGatherLooseContainers Auto Const
FormList Property TweakDoorScan Auto Const
FormList Property TweakTerminalScan Auto Const
ActorBase Property Player Auto Const

Quest Property Followers Auto Const
Keyword Property Followers_Command_LockPick_Allowed 	Auto Const
Keyword Property Followers_Command_HackTerminal_Allowed Auto Const


GlobalVariable Property TweakUnlockVisibleRadius Auto Const

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakUnlockVisibleScript"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Function UnlockVisible()

	Trace("UnlockVisible()")	
	float maxRadius = TweakUnlockVisibleRadius.GetValue()
	
	Actor pc = Game.GetPlayer()
	ObjectReference center = pc as ObjectReference

	; Result Holders:
	ObjectReference closestLocked = None
	
	; Resused Variables.
	float pX = pc.X
	float pY = pc.Y
	float pZ = pc.Z	
	float closestDistance = 500000.0
	float diffX = 0
	float diffY = 0
	float diffZ = 0
	float diffDistance = 0
	bool candidate = True
	ObjectReference result
	Actor owner = None
	ActorBase ownerBase = None
	Faction ownerFaction = None
	
	Trace("Scan TweakDoorScan Start")
	ObjectReference[] results = center.FindAllReferencesOfType(TweakDoorScan, maxRadius)
	int numresults = results.length
	Trace("Scan TweakDoorScan Complete [" + numresults + "] found")
	int i = 0
	while i < numresults
		result = results[i]
		if (result.IsLocked())
			if HasLineOfSight(pc,result)
				diffX = result.GetPositionX() - pX
				diffY = result.GetPositionY() - pY
				diffZ = result.GetPositionZ() - pZ
				diffDistance = (diffX * diffX) + (diffY * diffY) + (diffZ + diffZ)
				if diffDistance < closestDistance
					closestDistance = diffDistance
					closestLocked = result
				else
					Trace("Rejected: Door isn't closer than previous closest Door")
				endif
			else
				Trace("Rejected: Door Doesn't have LOS with Player")
			endif
		endif
		i += 1
	endwhile
	
	Trace("Scan TweakDoorScan Processing Complete")

	if closestLocked
		; If a door is found in front of the player, go with that. It is cheaper to find doors because
		; they dont require ownership checks and it is unlikely a door AND a locked container are 
		; both in front of the player.
		HandleResult(closestLocked, Followers_Command_LockPick_Allowed)
		return
	endif
		
	Trace("Scan TweakConstructed_Cont Start")
	results = center.FindAllReferencesOfType(TweakConstructed_Cont, maxRadius)
	numresults = results.length
	Trace("Scan TweakConstructed_Cont Complete [" + numresults + "] found")
	i = 0
	while i < numresults
		candidate = True
		result = results[i]
		if (result.IsLocked())
			owner = result.GetActorRefOwner()
			ownerBase = result.GetActorOwner()
			if (owner)
				if (owner.GetFactionReaction(pc) > 1)
					Trace("Accepted: Container Owner is Ally to player")
				else
					Trace("Rejected: Container owned By Another Actor")
					candidate = False
				endIf
			elseif (ownerBase)
				if (ownerBase == Player)
					Trace("Accepted: Container owner is Player")
				else
					Trace("Rejected: Container owned By another Actor Base")
					candidate = False
				endIf
			else
				ownerFaction = result.GetFactionOwner()
				if (ownerFaction)
					if (pc.IsInFaction(ownerFaction))
						Trace("Accepted: Player member of container owning Faction")
					elseIf (ownerFaction.GetFactionReaction(pc) > 1)
						Trace("Accepted: Container Faction is Ally to player")
					else
						Trace("Rejected: Container Faction isn't associated with Player")
						candidate = False
					endIf
				endIf
			endIf
			if candidate
				if HasLineOfSight(pc,result)
					diffX = result.GetPositionX() - pX
					diffY = result.GetPositionY() - pY
					diffZ = result.GetPositionZ() - pZ
					diffDistance = (diffX * diffX) + (diffY * diffY) + (diffZ + diffZ)
					if diffDistance < closestDistance
						closestDistance = diffDistance
						closestLocked = result
					else
						Trace("Rejected: Container isn't closer than previous closest container")
					endif
				else
					Trace("Rejected: Container Doesn't have LOS with Player")
				endif
			endif
		endif
		i += 1
	endwhile
	
	Trace("Scan TweakConstructed_Cont Processing Complete")
	
	Trace("Scan TweakNonConstructed_Cont Start")
	results = center.FindAllReferencesOfType(TweakNonConstructed_Cont, maxRadius)
	numresults = results.length
	Trace("Scan TweakNonConstructed_Cont Complete [" + numresults + "] found")
	i = 0
	while i < numresults
		candidate = True
		result = results[i]
		if (result.IsLocked())
			owner = result.GetActorRefOwner()
			ownerBase = result.GetActorOwner()
			if (owner)
				if (owner.GetFactionReaction(pc) > 1)
					Trace("Accepted: Container Owner is Ally to player")
				else
					Trace("Rejected: Container owned By Another Actor")
					candidate = False
				endIf
			elseif (ownerBase)
				if (ownerBase == Player)
					Trace("Accepted: Container owner is Player")
				else
					Trace("Rejected: Container owned By another Actor Base")
					candidate = False
				endIf
			else
				ownerFaction = result.GetFactionOwner()
				if (ownerFaction)
					if (pc.IsInFaction(ownerFaction))
						Trace("Accepted: Player member of container owning Faction")
					elseIf (ownerFaction.GetFactionReaction(pc) > 1)
						Trace("Accepted: Container Faction is Ally to player")
					else
						Trace("Rejected: Container Faction isn't associated with Player")
						candidate = False
					endIf
				endIf
			endIf
			if candidate
				if HasLineOfSight(pc,result)
					diffX = result.GetPositionX() - pX
					diffY = result.GetPositionY() - pY
					diffZ = result.GetPositionZ() - pZ
					diffDistance = (diffX * diffX) + (diffY * diffY) + (diffZ + diffZ)
					if diffDistance < closestDistance
						closestDistance = diffDistance
						closestLocked = result
					else
						Trace("Rejected: Container isn't closer than previous closest container")
					endif
				else
					Trace("Rejected: Container Doesn't have LOS with Player")
				endif
			endif
		endif
		i += 1
	endwhile
	
	Trace("Scan TweakNonConstructed_Cont Processing Complete")
	
	Trace("Scan TweakGatherLooseContainers Start")
	results = center.FindAllReferencesOfType(TweakGatherLooseContainers, maxRadius)
	numresults = results.length
	Trace("Scan TweakGatherLooseContainers Complete [" + numresults + "] found")
	i = 0
	while i < numresults
		candidate = True
		result = results[i]
		if (result.IsLocked())
			owner = result.GetActorRefOwner()
			ownerBase = result.GetActorOwner()
			if (owner)
				if (owner.GetFactionReaction(pc) > 1)
					Trace("Accepted: Container Owner is Ally to player")
				else
					Trace("Rejected: Container owned By Another Actor")
					candidate = False
				endIf
			elseif (ownerBase)
				if (ownerBase == Player)
					Trace("Accepted: Container owner is Player")
				else
					Trace("Rejected: Container owned By another Actor Base")
					candidate = False
				endIf
			else
				ownerFaction = result.GetFactionOwner()
				if (ownerFaction)
					if (pc.IsInFaction(ownerFaction))
						Trace("Accepted: Player member of container owning Faction")
					elseIf (ownerFaction.GetFactionReaction(pc) > 1)
						Trace("Accepted: Container Faction is Ally to player")
					else
						Trace("Rejected: Container Faction isn't associated with Player")
						candidate = False
					endIf
				endIf
			endIf
			if candidate
				if HasLineOfSight(pc,result)
					diffX = result.GetPositionX() - pX
					diffY = result.GetPositionY() - pY
					diffZ = result.GetPositionZ() - pZ
					diffDistance = (diffX * diffX) + (diffY * diffY) + (diffZ + diffZ)
					if diffDistance < closestDistance
						closestDistance = diffDistance
						closestLocked = result
					else
						Trace("Rejected: Container isn't closer than previous closest container")
					endif
				else
					Trace("Rejected: Container Doesn't have LOS with Player")
				endif
			endif
		endif
		i += 1
	endwhile
	
	Trace("Scan TweakGatherLooseContainers Processing Complete")
	
	if closestLocked
		HandleResult(closestLocked, Followers_Command_LockPick_Allowed)
		return
	endif
	
	Trace("Scan TweakTerminalScan Start")
	results = center.FindAllReferencesOfType(TweakTerminalScan, maxRadius)
	numresults = results.length
	Trace("Scan TweakTerminalScan Complete [" + numresults + "] found")
	i = 0
	while i < numresults
		candidate = True
		result = results[i]
		if (result.IsLocked())
			owner = result.GetActorRefOwner()
			ownerBase = result.GetActorOwner()
			if (owner)
				if (owner.GetFactionReaction(pc) > 1)
					Trace("Accepted: Terminal Owner is Ally to player")
				else
					Trace("Rejected: Terminal owned By Another Actor")
					candidate = False
				endIf
			elseif (ownerBase)
				if (ownerBase == Player)
					Trace("Accepted: Terminal owner is Player")
				else
					Trace("Rejected: Terminal owned By another Actor Base")
					candidate = False
				endIf
			else
				ownerFaction = result.GetFactionOwner()
				if (ownerFaction)
					if (pc.IsInFaction(ownerFaction))
						Trace("Accepted: Player member of Terminal owning Faction")
					elseIf (ownerFaction.GetFactionReaction(pc) > 1)
						Trace("Accepted: Terminal Faction is Ally to player")
					else
						Trace("Rejected: Terminal Faction isn't associated with Player")
						candidate = False
					endIf
				endIf
			endIf
			if candidate
				if HasLineOfSight(pc,result)
					diffX = result.GetPositionX() - pX
					diffY = result.GetPositionY() - pY
					diffZ = result.GetPositionZ() - pZ
					diffDistance = (diffX * diffX) + (diffY * diffY) + (diffZ + diffZ)
					if diffDistance < closestDistance
						closestDistance = diffDistance
						closestLocked = result
					else
						Trace("Rejected: Terminal isn't closer than previous closest container")
					endif
				else
					Trace("Rejected: Terminal Doesn't have LOS with Player")
				endif
			endif
		endif
		i += 1
	endwhile
	
	Trace("Scan TweakTerminalScan Processing Complete")	
	
	if closestLocked
		HandleResult(closestLocked, Followers_Command_HackTerminal_Allowed)
		return
	endif
	
EndFunction

bool Function HasLineOfSight(Actor pc, ObjectReference target)
	; HasDetectionLOS isn't reliable. Especially with terminals as many are set into walls. 
	float zOffset = Game.GetPlayer().GetHeadingAngle(target)
	if (zOffset < 45 && zoffset > -45)
		return true
	endif
	return false
EndFunction

Function HandleResult(ObjectReference closestLocked, Keyword requiredkeyword)
	TweakDFScript pTweakDFScript = (Followers as TweakDFScript)
	if pTweakDFScript
		pTweakDFScript.CommandModeFigureItOut(closestLocked, requiredkeyword, (Followers_Command_LockPick_Allowed == requiredkeyword))
	endif
EndFunction
