Scriptname AFT:TweakShowerHandler extends ObjectReference Const

ActorValue Property Variable06 Auto Const
Keyword Property LinkCustom08 Auto Const
Keyword Property LinkCustom09 Auto Const
Door    Property InstituteShower01 Auto Const
MovableStatic Property PipeWaterLeakGardens Auto Const
Quest   Property pTweakFollower Auto Const
Faction Property pTweakNamesFaction Auto Const

Event OnLoad()
	if IsEnabled()
		ObjectReference wrapper = GetLinkedRef(LinkCustom09)
		if (!wrapper)
			wrapper = PlaceAtMe(InstituteShower01)
			SetLinkedRef(wrapper, LinkCustom09)
		endif
		if wrapper
			wrapper.SetPosition(GetPositionX(), GetPositionY(), GetPositionZ() - 5)
			wrapper.SetAngle(0,0,GetAngleZ())
			wrapper.Disable()
			wrapper.Enable()
			int openState = wrapper.GetOpenState()
			if (openState > 2)
				wrapper.SetOpen(true)
			endif
		endif
	else
		ObjectReference wrapper = GetLinkedRef(LinkCustom09)
		if (wrapper)
			wrapper.Disable()
		endif
	endif
EndEvent

Event OnUnload()
	ObjectReference wrapper = GetLinkedRef(LinkCustom09)
	if (wrapper)
		wrapper.Disable()
		if IsDeleted()
			SetLinkedRef(None, LinkCustom09)
			wrapper.Delete()
		endif
	endif
	ObjectReference theWater = GetLinkedRef(LinkCustom08)
	if (theWater)
		SetLinkedRef(None, LinkCustom08)
		theWater.Disable()
		theWater.Delete()
		theWater = None
	endif
EndEvent
 
Event OnActivate(ObjectReference akActionRef)
	Actor npc = akActionRef as Actor
	if (!npc)
		return		
	endif
	
	; Ignore unless they are managed...
	int nameId = npc.GetFactionRank(pTweakNamesFaction)
	if (nameId < 0)
		return
	endif
		
	ObjectReference wrapper = GetLinkedRef(LinkCustom09)
	if wrapper
		wrapper.SetOpen(false)
	endif
	AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower As AFT:TweakFollowerScript)
	if (pTweakFollowerScript)

		; We could store the prevweapon off as an actorValue 
		; and then restore when they exit...
		
		SetValue(Variable06,0)
		Weapon prevweapon = npc.GetEquippedWeapon()
		if prevweapon
			SetValue(Variable06,prevweapon.GetFormID())
		endif
		
		pTweakFollowerScript.UnEquipAllGear(npc, true)
	endif
	int maxwait = 4
	while ((maxwait > 0) && (wrapper.GetOpenState() != 3))
		Utility.wait(1.0)
		maxwait -= 1
	endwhile
	if IsFurnitureInUse()
		ObjectReference theWater = GetLinkedRef(LinkCustom08)
		if !theWater
			theWater = PlaceAtMe(PipeWaterLeakGardens)
			SetLinkedRef(theWater, LinkCustom08)
		endif
	endif	
EndEvent

Event OnExitFurniture(ObjectReference akActionRef)
	Actor npc = akActionRef as Actor
	ObjectReference theWater = GetLinkedRef(LinkCustom08)
	if (theWater)
		SetLinkedRef(None, LinkCustom08)
		theWater.Disable()
		theWater.Delete()
		theWater = None
	endif
	if (npc.GetFactionRank(pTweakNamesFaction) > -1)
		AFT:TweakFollowerScript pTweakFollowerScript = (pTweakFollower As AFT:TweakFollowerScript)
		if pTweakFollowerScript
			pTweakFollowerScript.RestoreTweakOutfit(npc)
		endif
	endif
	ObjectReference wrapper = GetLinkedRef(LinkCustom09)
	if wrapper
		wrapper.SetOpen(true)
	endif
	int prevweaponID = GetValue(Variable06) as Int
	if (0 != prevweaponID)
		Weapon prevweapon = Game.GetForm(prevweaponID) as Weapon
		SetValue(Variable06,0)
		if (prevweapon)
			npc.EquipItem(prevweapon,false,true)
		endif
	endif
EndEvent
