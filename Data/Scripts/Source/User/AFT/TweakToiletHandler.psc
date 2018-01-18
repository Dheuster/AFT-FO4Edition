Scriptname AFT:TweakToiletHandler extends ObjectReference Const

Quest   Property pTweakFollower Auto Const
Faction Property pTweakFollowerFaction Auto Const

Event OnActivate(ObjectReference akActionRef)
	Actor npc = akActionRef as Actor
	if (!npc)
		return		
	endif
	if (!npc.IsInFaction(pTweakFollowerFaction))
		return
	endif
	
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower As AFT:TweakFollowerScript)
	if pTweakFollowerScript
		
		; Human/Ghoul/Biped slots:
		; 30 = Hair Top
		; 31 = Hair Long
		; 32 = FaceGen Head
		; 33 = BODY
		; 34 = L Hand
		; 35 = R Hand
		; 36 = [U] Torso ; U = Under "A" armors...
		; 37 = [U] L Arm
		; 38 - [U] R Arm
		; 39 - [U] L Leg
		; 40 - [U] R Leg
		; 41 - [A] Torso
		; 42 - [A] L Arm
		; 43 - [A] R Arm
		; 44 - [A] L Leg
		; 45 - [A] R Leg
		; 46 - Headband
		; 47 - Eyes
		; 48 - Beard
		; 49 - Mouth
		; 50 - Neck
		; 51 - Ring
		; 52 - Scalp
		; 53 - Decapitation
		; 54 through 58 - Unnamed
		; 59 - Shield
		; 60 - Pipboy
		; 61 - FX
		
		pTweakFollowerScript.UnEquipAllGear(npc, true)
		
		; npc.UnequipItemSlot(39)
		; npc.UnequipItemSlot(40)
		; npc.UnequipItemSlot(44)
		; npc.UnequipItemSlot(45)		
		; Force Refresh:
		; BumpArmorAI(npc)
	endif	
EndEvent

Event OnExitFurniture(ObjectReference akActionRef)
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower As AFT:TweakFollowerScript)
	if pTweakFollowerScript
		pTweakFollowerScript.RestoreTweakOutfit((akActionRef as Actor))
	endif
EndEvent

