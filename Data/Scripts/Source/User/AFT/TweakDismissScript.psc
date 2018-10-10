Scriptname AFT:TweakDismissScript extends Quest Conditional

Bool Property IsCasCompanion Auto Conditional
Bool Property HasOriginalHome Auto Conditional

ReferenceAlias	Property dismissedNPC		Auto Const
LocationAlias	Property originalHome		Auto Const
LocationAlias	Property assignedHome		Auto Const
Message 		Property TweakDismissMenu	Auto Const
Message			Property TweakDismissMessage Auto Const
Event OnQuestInit()
	IsCasCompanion  = false
	HasOriginalHome = false
EndEvent

Function ShowDismiss(Actor npc, Location home)
	if (npc)
		dismissedNPC.ForceRefTo(npc)
	endif
	if (home)
		originalHome.ForceLocationTo(home)
	endif
	TweakDismissMessage.Show()
	Utility.WaitMenuMode(0.1)
	dismissedNPC.Clear()
	originalHome.Clear()	
EndFunction

int Function ShowMenu(Actor npc, Location home, Location assigned=None)
	dismissedNPC.ForceRefTo(npc)
	if (home)
		HasOriginalHome = true
		originalHome.ForceLocationTo(home)
	else
		HasOriginalHome = false
	endif
	if (assigned)
		assignedHome.ForceLocationTo(assigned)
	elseif (HasOriginalHome)
		assignedHome.ForceLocationTo(home)
	endif
	
	if (npc as CompanionActorScript)
		IsCasCompanion = True
	elseif (npc as DogmeatActorScript)
		IsCasCompanion = True
	else
		IsCasCompanion = false
	endif
	int choice = TweakDismissMenu.Show()
	dismissedNPC.Clear()
	originalHome.Clear()
	assignedHome.Clear()	
	return choice
EndFunction