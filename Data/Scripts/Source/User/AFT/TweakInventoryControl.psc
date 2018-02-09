Scriptname AFT:TweakInventoryControl extends ReferenceAlias

Group Injected

	Faction  Property pTweakNamesFaction				Auto Const
	Faction  Property pTweakEnterPAFaction				Auto Const
	Faction  Property pCurrentCompanionFaction			Auto Const

	Faction	 Property pTweakManagedOutfit				Auto Const
	Faction  Property pTweakCombatOutFitFaction			Auto Const
	Faction  Property pTweakCampOutFitFaction			Auto Const
	Faction  Property pTweakCityOutFaction				Auto Const
	Faction  Property pTweakStandardOutfitFaction		Auto Const
	Faction  Property pTweakHomeOutFitFaction			Auto Const
	Faction  Property pTweakSwimOutFitFaction			Auto Const
	
	Faction  Property pTweakPAHelmetCombatToggleFaction	Auto Const

	Keyword  Property isPowerArmorFrame					Auto Const
	Keyword  Property pLinkPowerArmor					Auto Const
	Keyword  Property pArmorTypePower					Auto Const
	Keyword  Property FurnitureTypePowerArmor			Auto Const
	Keyword  Property ArmorBodyPartHead					Auto Const
	Keyword  Property ArmorTypeHat						Auto Const
	Keyword  Property pActorTypeGhoul					Auto Const
	Keyword  Property pActorTypeHuman					Auto Const
	Keyword  Property pActorTypeSynth					Auto Const
	Keyword  Property pActorTypeSuperMutant				Auto Const
	Keyword  Property pTeammateReadyWeapon_DO			Auto Const
	Keyword  Property pLocTypeInn						Auto Const
	Keyword  Property pLocTypeBar						Auto Const
	Keyword  Property pLocTypeStore						Auto Const
	Keyword  Property pLocTypeWorkshop					Auto Const
	Keyword  Property dn_PowerArmor_Helmet				Auto Const
	Keyword  Property pTeammateDontUseAmmoKeyword		Auto Const
	Keyword  Property pPowerArmorPreventArmorDamageKeyword Auto Const
	Keyword  Property pTweakLocHome						Auto Const 

	Outfit   Property pTweakNoOutfit					Auto Const
	Armor    Property pTweakRefreshRing					Auto Const
	Weapon   Property pTweakWeap						Auto Const

	Location Property pSanctuaryHillsLocation			Auto Const
	Location Property pGoodneighborLocation				Auto Const
	Location Property pDiamondCityLocation				Auto Const
	Location Property pCovenantLocation					Auto Const
	Location Property pBunkerHillLocation				Auto Const
	Location Property pPrydwenLocation					Auto Const
	Location Property pVault81Location					Auto Const
	FormList Property pWorkshopConsumeScavenge			Auto Const

	Message	 Property pTweakScrapJunk					Auto Const
	Message	 Property pTweakScrapJunk20					Auto Const
	Message	 Property pTweakScrapJunk40					Auto Const
	Message	 Property pTweakScrapJunk60					Auto Const
	Message	 Property pTweakScrapJunk80					Auto Const
	Message	 Property pTweakScrapJunk100				Auto Const
	
	ReferenceAlias	Property pShelterMapMarker			Auto Const
	MiscObject		Property pBobbyPin					Auto Const
	ActorValue		Property pTweakInPowerArmor			Auto Const
	Quest			Property pWorkshopParent				Auto Const
	GlobalVariable	Property pTweakSettlementAsCity		Auto Const

EndGroup

Group LocalPersistance

	; processLoadEvents was added so that we could prevent
	; outfits from being put on during PARTS alterations like
	; hair, beard, etc... Part changes invoke OnLoad events,
	; but we dont want the HAT to get put back on...
	;
	; TweakFollower => TweakChangeAppearance is the primary 
	; script that makes use of this and it is also responsible
	; for setting it back, though we have a number of safeties
	; in place (Like location change)
	Bool     Property processLoadEvents Auto
	
	Bool     Property managed					Auto
	
	; Updated/Maintained by TweakSettings
	Location  Property assignedHome				Auto
	
	; Updated/Maintained by TweakSettings
	ObjectReference  Property assignedHomeRef	Auto	

EndGroup

; Hidden
Form[] Property CurrentOutfit			Auto hidden
Form[] Property SnapShotOutfit			Auto hidden

Form[] Property CombatOutfit			Auto hidden
Form[] Property CityOutfit				Auto hidden
Form[] Property CampOutfit				Auto hidden
Form[] Property StandardOutfit			Auto hidden
Form[] Property HomeOutfit				Auto hidden
Form[] Property SwimOutfit				Auto hidden

Form[] Property myHead					Auto hidden
Form[] Property PAOutfit				Auto hidden
Bool   Property CombatOutfitEnabled		Auto hidden
Bool   Property CityOutfitEnabled		Auto hidden
Bool   Property CampOutfitEnabled		Auto hidden
Bool   Property StandardOutfitEnabled	Auto hidden
Bool   Property HomeOutfitEnabled		Auto hidden
Bool   Property SwimOutfitEnabled		Auto hidden
Armor  Property pTrackedPAHelmet		Auto hidden
Weapon Property pTrackedWeapon			Auto hidden

Bool   Property ignorePAEvents			Auto hidden
Bool   Property combatInProgress		Auto hidden
Bool   Property playerIsSwimming		Auto hidden
int	   Property invRec					Auto hidden

Bool   Property originalNoAmmo			Auto hidden
Bool   Property originalPADamage		Auto hidden

; CurrentOutfitDesired indicates what outfit they SHOULD be wearing based on
; where they are and what is going on. Outfit usage is generally enforced 
; by events which in turn keep this up to date for scripts to use. 
;
; 0 = None
; 1 = Combat
; 2 = Home
; 3 = City 
; 4 = Camp 
; 5 = Standard
; 8 = Swim
Int   Property CurrentOutfitDesired Auto hidden

; Constants
int OUTFIT_NONE      = 0 const
int OUTFIT_COMBAT    = 1 const
int OUTFIT_HOME      = 2 const
int OUTFIT_CITY      = 3 const
int OUTFIT_CAMP      = 4 const
int OUTFIT_STANDARD  = 5 const
int OUTFIT_SNAPSHOT  = 6 const ; Used externally by things like the bathroom.
int OUTFIT_LASTKNOWN = 7 const
int OUTFIT_SWIM      = 8 const

int	COMBATEND_DELAYED		  = 995 const
int SELL_UNUSED_DONE          = 996 const
int ONLOAD_FLOOD_PROTECT      = 998 const
int ENTER_PA_TIMEOUT          = 999 const

int DEDUPE_PLAYER_DONE        = 997 const ; DEPRECATED


bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakInventoryControl" + self.GetActorRef().GetFactionRank(pTweakNamesFaction)
	; string logName = "TweakAppearance"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

; One time operations (typically time consuming)
Function initialize()

	Trace("initialize()")	
	processLoadEvents = true
	Actor npc = self.GetActorRef()

	ActorBase base = npc.GetActorBase()
	if (base == Game.GetForm(0x00079249) as ActorBase)     ; 1 ---=== Cait ===---
		Trace("Cait Detected.")
		npc.AddToFaction(pTweakPAHelmetCombatToggleFaction)
	elseif (base == Game.GetForm(0x00027683) as ActorBase) ; 4 ---=== Danse ===---
		Trace("Danse Detected.")
		npc.AddToFaction(pTweakPAHelmetCombatToggleFaction)
	elseif (base == Game.GetForm(0x00045AC9) as ActorBase) ; 5 ---=== Deacon ===---
		Trace("Deacon Detected.")
		npc.AddToFaction(pTweakPAHelmetCombatToggleFaction)
	elseif (base == Game.GetForm(0x00022613) as ActorBase) ; 7 ---=== Hancock ===---	
		Trace("Hanckock Detected.")
		npc.AddToFaction(pTweakPAHelmetCombatToggleFaction)
	elseif (base == Game.GetForm(0x0002740E) as ActorBase) ; 8 ---=== MacCready ===---	
		Trace("MacCready Detected.")
		npc.AddToFaction(pTweakPAHelmetCombatToggleFaction)
	elseif (base == Game.GetForm(0x00002F24) as ActorBase) ; 9 ---=== Nick Valentine ===---
		Trace("Nick Detected.")
		npc.AddToFaction(pTweakPAHelmetCombatToggleFaction)
	elseif (base == Game.GetForm(0x00002F1E) as ActorBase) ; 10 ---=== Piper ===---	
		Trace("Piper Detected.")
		npc.AddToFaction(pTweakPAHelmetCombatToggleFaction)
	elseif (base == Game.GetForm(0x00019FD9) as ActorBase) ; 11 ---=== Preston ===---
		Trace("Preston Detected.")
		npc.AddToFaction(pTweakPAHelmetCombatToggleFaction)
	elseif (base == Game.GetForm(0x000BBEE6) as ActorBase) ; 13 ---=== X6-88 ===---	
		Trace("X6-88 Detected.")
		npc.AddToFaction(pTweakPAHelmetCombatToggleFaction)	
	elseif npc.GetRace() == (Game.GetForm(0x00013746) as Race) ; HumanRace
		npc.AddToFaction(pTweakPAHelmetCombatToggleFaction)
	elseif npc.GetRace() == (Game.GetForm(0x000EAFB6) as Race) ; GhoulRace
		npc.AddToFaction(pTweakPAHelmetCombatToggleFaction)
	else
		Trace("Not Human/Ghoul Common")
	endif

	CurrentOutfitDesired  = OUTFIT_NONE
	CombatOutfitEnabled   = false
	CityOutfitEnabled     = false
	CampOutfitEnabled     = false
	StandardOutfitEnabled = false	
	HomeOutfitEnabled     = false	
	SwimOutfitEnabled     = false	
	invRec                = 0

	; managed gets set to true if SetTweakOutfit or UnequipAllGear
	; is ever called. Once managed, we monitor NPC's ItemEquip/UnEquip 
	; events and keep a CurrentOutfit array up to date. 
	
	managed              = false
	
	CurrentOutfit    = new Form[0]
	SnapShotOutfit   = new Form[0]
	CombatOutfit     = new Form[0]
	CityOutfit       = new Form[0]
	CampOutfit       = new Form[0]
	StandardOutfit   = new Form[0]
	HomeOutfit       = new Form[0]
	SwimOutfit       = new Form[0]
	PAOutfit         = new Form[0]
	myHead           = new Form[0]
	pTrackedPAHelmet = None
	
	if npc.HasKeyword(pTeammateDontUseAmmoKeyword)
		originalNoAmmo = true
	else
		originalNoAmmo = false
	endif

	if npc.HasKeyword(pPowerArmorPreventArmorDamageKeyword)
		originalPADamage = true
	else
		originalPADamage = false
	endif
	
	combatInProgress = false
	playerIsSwimming = false
	; EventFollowingPlayer()
	
EndFunction

Function v16upGrade()
	SwimOutfitEnabled = false	
	SwimOutfit        = new Form[0]
EndFunction

Function v13upGrade()
	if managed
		self.GetActorRef().AddToFaction(pTweakManagedOutfit)
		RemoveDefaultWeapon()
	endif
	HomeOutfitEnabled = false	
	HomeOutfit        = new Form[0]
	assignedHome      = ((self as ReferenceAlias) as AFT:TweakSettings).assignedHome
	assignedHomeRef   = ((self as ReferenceAlias) as AFT:TweakSettings).assignedHomeRef	
EndFunction

Function EventOnGameLoad()
EndFunction

Function EventFollowingPlayer(bool firstTime=false)
	Trace("EventFollowingPlayer()")
	processLoadEvents = true
	if firstTime
		CheckPAStatus()
	endif
	
	; Check For Deacon - Vanilla game has him monitor location change events and
	; change outfits/disguises based on environment. But it interferes with
	; AFT's Outfit management. So we disable the location monitoring.
	
	if (managed && self.GetActorReference().GetActorBase() == Game.GetForm(0x00045AC9) as ActorBase)
		Trace("Managed Deacon detected")
		Quest COMDeacon = Game.GetForm(0x000BBD9B) as Quest
		if (COMDeacon)
			COMDeaconScript pCOMDeacon = (COMDeacon as COMDeaconScript)
			if pCOMDeacon
				Trace("Unregistering COMDeacon OnLocationChange Event Monitoring")
				pCOMDeacon.UnRegisterForRemoteEvent(Game.GetPlayer(),"OnLocationChange")
				pCOMDeacon.bCanSwapDisguises = 0
			else
				Trace("Cast to COMDeaconScript Failed")
			endif
		else
			Trace("Cast to COMDeacon Quest Failed")
		endif
	endif
		
endFunction

Function EventFollowerWait()
	Trace("EventFollowerWait()")
	processLoadEvents = true
EndFunction

Function EventWaitToFollow()
	Trace("EventWaitToFollow()")				
	processLoadEvents = true
EndFunction

; When they stop following the PC
Function EventNotFollowingPlayer()
	processLoadEvents = true
	Trace("EventNotFollowingPlayer() (dismissed)")
	; If they are managed, we have to remember the original outfit (else they will go nude.)
	if managed	
		if !(HomeOutfitEnabled || StandardOutfitEnabled)
			; Need to take silent Snapshot, otherwise NPC will be nude the next time we see them:
			SetTweakOutfit(OUTFIT_STANDARD, true)
		endif
	endIf
	; Fix Deacon
	if (self.GetActorReference().GetActorBase() == Game.GetForm(0x00045AC9) as ActorBase)
		Trace("Deacon detected")
		Quest COMDeacon = Game.GetForm(0x000BBD9B) as Quest
		if (COMDeacon)
			COMDeaconScript pCOMDeacon = (COMDeacon as COMDeaconScript)
			if pCOMDeacon
				pCOMDeacon.bCanSwapDisguises = 1
			else
				Trace("Cast to COMDeaconScript Failed")
			endif
		else
			Trace("Cast to COMDeacon Quest Failed")
		endif
	endif	
endFunction

; NOTE : This only gets relayed to current followers...
Function EventPlayerWeaponDraw()
	Trace("EventPlayerWeaponDraw()")
EndFunction

Function EventPlayerWeaponSheath()
	Trace("EventPlayerWeaponSheath()")
EndFunction

Function EventPlayerSwimStart()
	playerIsSwimming = true
	RestoreTweakOutfit()
EndFunction

Function EventPlayerSwimStop()
	playerIsSwimming = false
	RestoreTweakOutfit()
EndFunction


Function UnManage()

	; Exit PA, Stop monitoring and management....
	Actor npc = self.GetActorRef()
	
	if 1.0 == npc.GetValue(pTweakInPowerArmor) || npc.WornHasKeyword(pArmorTypePower)	
		if npc.GetActorBase() != (Game.GetForm(0x00027683) as ActorBase)
			; With the exception of Danse, everyone exits their PA...
			ExitPA()
		endif
	endif	
	ObjectReference onpc       = self.GetReference()
	ObjectReference oldPA      = onpc.GetLinkedRef(pLinkPowerArmor)
	if oldPA
		oldPA.SetLinkedRef(None, pLinkPowerArmor)
		onpc.SetLinkedRef(None, pLinkPowerArmor)
	endIf
	
	; If Managed, Clear the outfits and restore...
	if managed
		UnManageOutfits()
	endif

	myHead.Clear()
	pTrackedPAHelmet = None
	
	if npc.HasKeyword(pTeammateDontUseAmmoKeyword)
		if !originalNoAmmo
			npc.RemoveKeyword(pTeammateDontUseAmmoKeyword)
		endif
	else
		if originalNoAmmo
			npc.AddKeyword(pTeammateDontUseAmmoKeyword)
		endif	
	endif

	if npc.HasKeyword(pPowerArmorPreventArmorDamageKeyword)
		if !originalPADamage
			npc.RemoveKeyword(pTeammateDontUseAmmoKeyword)			
		endif
	else
		if originalPADamage
			npc.AddKeyword(pTeammateDontUseAmmoKeyword)			
		endif
	endif
		
EndFunction

Function UnManageOutfits()

	if !managed
		return
	endif

	Actor npc = self.GetActorRef()
	ActorBase base = npc.GetActorBase()
	ClearAllOutfits()
	if (base == Game.GetForm(0x00079249) as ActorBase)     ; 1 ---=== Cait ===---
		; 1.14 BUG: If you call SetOutfit on the Actor without first calling it on the
		;           Actorbase, it removes most of the inventory...
		SetOutfitFix(npc, Game.GetForm(0x00086204) as Outfit)
	elseif (base == Game.GetForm(0x00027686) as ActorBase) ; 3 ---=== Curie ===---
		if npc.GetRace() == (Game.GetForm(0x00013746) as Race) ; HumanRace
			SetOutfitFix(npc, Game.GetForm(0x001E2F26) as Outfit)
		endif			
	elseif (base == Game.GetForm(0x00027683) as ActorBase) ; 4 ---=== Danse ===---
		SetOutfitFix(npc, Game.GetForm(0x000E04A1) as Outfit)
	elseif (base == Game.GetForm(0x00045AC9) as ActorBase) ; 5 ---=== Deacon ===---
		TweakFollowerScript pTweakFollowerScript = (GetOwningQuest() as TweakFollowerScript)
		if pTweakFollowerScript
			pTweakFollowerScript.RemoveDeaconItems()	
		endif
		Quest COMDeacon = Game.GetForm(0x000BBD9B) as Quest
		if (COMDeacon)
			COMDeaconScript pCOMDeacon = (COMDeacon as COMDeaconScript)
			if pCOMDeacon
				Trace("Unregistering COMDeacon OnLocationChange Event Monitoring")
				pCOMDeacon.RegisterForRemoteEvent(Game.GetPlayer(),"OnLocationChange")
				pCOMDeacon.bCanSwapDisguises = 1
			else
				Trace("Cast to COMDeaconScript Failed")
			endif
		else
			Trace("Cast to COMDeacon Quest Failed")
		endif
		SetOutfitFix(npc, Game.GetForm(0x0018AAD8) as Outfit)
	elseif (base == Game.GetForm(0x00022613) as ActorBase) ; 7 ---=== Hancock ===---	
		SetOutfitFix(npc, Game.GetForm(0x0010B6C0) as Outfit)
	elseif (base == Game.GetForm(0x0002740E) as ActorBase) ; 8 ---=== MacCready ===---	
		Armor Armor_MacCready_Raider_Underarmor = Game.GetForm(0x0004A53B) as Armor
		Armor TweakArmor_MacCready_Raider_Underarmor = Game.GetFormFromFile(0x0100367F,"AmazingFollowerTweaks.esp") as Armor
		if (0 != npc.GetItemCount(TweakArmor_MacCready_Raider_Underarmor))
			npc.RemoveItem(TweakArmor_MacCready_Raider_Underarmor)
		endif
		if (0 == npc.GetItemCount(Armor_MacCready_Raider_Underarmor))
			npc.AddItem(Armor_MacCready_Raider_Underarmor)
		endIf
		SetOutfitFix(npc, Game.GetForm(0x00171858) as Outfit)
	elseif (base == Game.GetForm(0x00002F24) as ActorBase) ; 9 ---=== Nick Valentine ===---
		SetOutfitFix(npc, Game.GetForm(0x000EBE75) as Outfit)
	elseif (base == Game.GetForm(0x00002F1E) as ActorBase) ; 10 ---=== Piper ===---	
		SetOutfitFix(npc, Game.GetForm(0x0009F253) as Outfit)
	elseif (base == Game.GetForm(0x00019FD9) as ActorBase) ; 11 ---=== Preston ===---
		SetOutfitFix(npc, Game.GetForm(0x0001F158) as Outfit)
	elseif (base == Game.GetForm(0x00027682) as ActorBase) ; 12 ---=== Strong ===---	
		SetOutfitFix(npc, Game.GetForm(0x001B51AB) as Outfit)
	elseif (base == Game.GetForm(0x000BBEE6) as ActorBase) ; 13 ---=== X6-88 ===---	
		SetOutfitFix(npc, Game.GetForm(0x001275C0) as Outfit)
	else
		AFT:TweakDLC03Script pTweakDLC03Script = (Game.GetFormFromFile(0x0100C98E,"AmazingFollowerTweaks.esp") as Quest) as AFT:TweakDLC03Script
		AFT:TweakDLC04Script pTweakDLC04Script = (Game.GetFormFromFile(0x0100E815,"AmazingFollowerTweaks.esp") as Quest) as AFT:TweakDLC04Script
		if (pTweakDLC03Script && pTweakDLC03Script.Installed && base == pTweakDLC03Script.OldLongfellowBase)
			SetOutfitFix(npc, pTweakDLC03Script.DLC03OldLongfellowOutfit)
		elseif (pTweakDLC04Script && pTweakDLC04Script.Installed && base == pTweakDLC04Script.PorterGageBase)
			SetOutfitFix(npc, pTweakDLC04Script.DLC04_GageOutfit)
		elseif (npc.GetRace() == (Game.GetForm(0x00013746) as Race) || npc.GetRace() == (Game.GetForm(0x000EAFB6) as Race)) 
			; HumanRace or GhoulRace
			SetOutfitFix(npc, Game.GetForm(0x0006D7BA) as Outfit)
		endif
	endif
	managed = false
	npc.RemoveFromFaction(pTweakManagedOutfit)
	RestoreDefaultWeapon()
	npc.UnEquipAll()
	BumpArmorAI()
EndFunction

Function SetOutfitFix(Actor theActor, Outfit theOutfit)
	if theActor.GetActorBase().IsUnique()		
		theActor.GetActorBase().SetOutfit(theOutfit)
		theActor.SetOutfit(theOutfit)
	else
		Actor pc = Game.GetPlayer()
		ObjectReference theContainer = pc.placeAtMe(Game.GetForm(0x00020D57), 1, False, False, True)
		
		theContainer.SetPosition(pc.GetPositionX(), pc.GetPositionY(),pc.GetPositionZ() - 200)
		if theContainer
			theActor.RemoveAllItems(theContainer, True)
			int maxwait = 10
			while (theActor.GetItemCount(None) > 0 && maxwait > 0)
				Utility.WaitMenuMode(0.2)
				maxwait -= 1
			endWhile
			if (0 == maxwait)
				Trace("Warning : Not all items removed from follower")
				Utility.WaitMenuMode(0.2)
			endIf
		endif
		theActor.SetOutfit(theOutfit)
		if theContainer
			; If theActor is not loaded in memory, the items will be deleted. So in that 
			; case, move items to player.
			if theActor.Is3DLoaded()
				theContainer.RemoveAllItems(theActor, True)
			else
				theContainer.RemoveAllItems(pc, True)
			endif			
			int maxwait = 10
			while (theContainer.GetItemCount(None) > 0 && maxwait > 0)
				Utility.WaitMenuMode(0.2)
				maxwait -= 1
			endWhile
			if (0 == maxwait)
				Trace("Warning : Not all items removed from theContainer")
				Utility.WaitMenuMode(0.2)
				theContainer.Disable(False)
			else
				theContainer.Disable(False)
				theContainer.Delete()
			endIf
		endif		
	endif
EndFunction

;===============================================================================
; POWER ARMOR Management
;===============================================================================
; NOTE: OnSit handler creates a 2 way links between NPCs and their POWER ARMORS
; so we can quickly find an NPC's armor as well as determine if an unoccupied
; armor is already assigned to an NPC.  Cleanup handler UNASSIGN the PA if
; the player or another Follower is ordered into the suite (thus the keyword
; would map to nothing)
;
; If you blindly tell NPCs to ExitPA and EnterAssignedPA, those without 
; assigned PAs will ignore the commands. The player can assign a PA by
; commanding the NPC to enter a PA. 
;
; I considered implementing a command where followers would search the area 
; for unassigned PA and get into them if found, but it is hard to determine
; if a PA is actually accessible (May be in a locked cage). That is really
; hard to figure out programatically. So,  AFT PA management requires you
; to tell an NPC to enter a PA first. 
;
; EnterAssignedPA assumes you have gained legitimate access to the PA at some
; point. 
Event OnSit(ObjectReference akFurniture)
	Trace("OnSit [" + akFurniture + "]")
	if akFurniture.HasKeyword(FurnitureTypePowerArmor)
		Actor npc = self.GetActorReference()

		Trace("PA Detected [" + akFurniture + "]")
		if (akFurniture.IsFurnitureInUse())
			Trace("PA Is in Use (We are exiting)")
			npc.SetValue(pTweakInPowerArmor, 0.0)
		else
			Trace("PA Is in NOT in use (We are entering)")
			npc.SetValue(pTweakInPowerArmor, 1.0)
		endif
					
		ObjectReference onpc       = self.GetReference()
		ObjectReference oldPA      = onpc.GetLinkedRef(pLinkPowerArmor)
		ObjectReference PAPrevUser = akFurniture.GetLinkedRef(pLinkPowerArmor)
		
		; Cleanup links if there is a change in assignment...
		if (oldPA && oldPA != akFurniture && onpc == oldPA.GetLinkedRef(pLinkPowerArmor))
			; Unassign link to Self on Previous PA (since we are no longer the user)
			oldPA.SetLinkedRef(None, pLinkPowerArmor)
		endif
		if (PAPrevUser && PAPrevUser != onpc && akFurniture == PAPrevUser.GetLinkedRef(pLinkPowerArmor))
			; Unassign link to PA on previous PA's user since we are now using it...
			PAPrevUser.SetLinkedRef(None, pLinkPowerArmor)
		endif
		
		; Enforce assignment to current NPC
		onpc.SetLinkedRef(akFurniture,pLinkPowerArmor)
		akFurniture.SetLinkedRef(onpc,pLinkPowerArmor)

		if npc.IsInFaction(pTweakEnterPAFaction)
			npc.RemoveFromFaction(pTweakEnterPAFaction)
			npc.EvaluatePackage()
		endif
		
		if (npc.IsInFaction(pTweakPAHelmetCombatToggleFaction))		
			TryToUnEquipPAHelmet()
		endif		
		
	endif
EndEvent

ObjectReference Function GetAssignedPA()
	ObjectReference onpc = self.GetReference()
	ObjectReference ret = onpc.GetLinkedRef(pLinkPowerArmor)
	if (ret)
		if (ret.GetLinkedRef(pLinkPowerArmor) == onpc)
			return ret
		endif
	endif
	return None	
EndFunction

Function ExitPA(bool nowait=false)
	Trace("ExitPA")
	Actor npc = self.GetActorRef()
	if !npc.Is3DLoaded()
		Trace("Ignoring. NPC is not in loaded area")
		return
	endif
	if (npc.GetWorldSpace() != Game.GetPlayer().GetWorldSpace())
		Trace("Ignoring. NPC is not in same worldspace as player (Institute?)")
		return
	endif	
	if npc.IsInFaction(pTweakEnterPAFaction)
		npc.RemoveFromFaction(pTweakEnterPAFaction)
		npc.EvaluatePackage()
	endif		
		
	if !(1.0 == npc.GetValue(pTweakInPowerArmor) || npc.WornHasKeyword(pArmorTypePower))
		Trace("Ignoring. NPC does not appear to be wearing any PowerArmor")
		return
	endif
	
	if (npc.IsInFaction(pTweakPAHelmetCombatToggleFaction))		
		TryToEquipPAHelmet()
	endif
	npc.SwitchToPowerArmor(None)
	
	if nowait
		return
	endIf
	
	; Try not to return until they are out of the PA. IE: we should be able to 
	; immediatly call EnterAssignedPA()
	
	ObjectReference pa = npc.GetLinkedRef(pLinkPowerArmor)
	if (!pa)
		int maxwait = 6
		while ( None == npc.GetLinkedRef(pLinkPowerArmor) && maxwait > 0 )
			Utility.wait(1.0)
			maxwait -= 1
		endwhile
		pa = npc.GetLinkedRef(pLinkPowerArmor)
	endif
	if (!pa)
		Trace("No pLinkPowerArmor found within 6 seconds. Aborting...")	
		return
	endif
	
	Trace("Actor linked to PA [" + pa + "]")
	
	; Wait for the exiting animation to finish...
	int maxwait = 6
	while (pa.IsFurnitureInUse() && maxwait > 0)
		Utility.wait(1.0)
		maxwait -= 1
	endwhile
EndFunction

Function EnterAssignedPA(bool snapto = false)
	Trace("EnterAssignedPA()")
	Actor npc = self.GetActorRef()
	if !npc.Is3DLoaded()
		Trace("NPC is not in loaded area. Aborting")
		return
	endif
	if (npc.GetWorldSpace() != Game.GetPlayer().GetWorldSpace())
		Trace("Ignoring. NPC is not in same worldspace as player (Institute?)")
		return
	endif		
	if 1.0 == npc.GetValue(pTweakInPowerArmor) || npc.WornHasKeyword(pArmorTypePower)
		Trace("NPC is already wearing PowerArmor.")
		if (npc.IsInFaction(pTweakPAHelmetCombatToggleFaction))
			Trace("NPC is in Faction TweakPAHelmetCombatToggleFaction")
			TryToUnEquipPAHelmet()
		endif
		return
	endif	
	
	ObjectReference akPowerArmor = npc.GetLinkedRef(pLinkPowerArmor)
	if (!akPowerArmor)
		Trace("No PowerArmor assigned. Aborting...")
		return
	endif
	
	if akPowerArmor.IsFurnitureInUse()
		Trace("Assigned PowerArmor in use. Aborting")
		return
	endif
	
	Bool movetonpc = false
	if (!akPowerArmor.Is3DLoaded())
		akPowerArmor.MoveTo(npc)
		akPowerArmor.Disable() ; Fix Texture Blur bug
		akPowerArmor.Enable()		
		movetonpc = true
	elseif (!DistanceWithin(npc, akPowerArmor, 1000))
		movetonpc = true
	endif
	if movetonpc
		float[] posdata = TraceCircle(npc,100)
		akPowerArmor.SetPosition(posdata[0],posdata[1],posdata[2])
		akPowerArmor.SetAngle(0.0, 0.0, npc.GetAngleZ())
		Utility.Wait(0.3)
	endif
	
	if (CombatOutfitEnabled)
		RestoreTweakOutfit(OUTFIT_COMBAT)
	endif
	
	if (snapto)
		npc.SwitchToPowerArmor(akPowerArmor)
		if npc.IsInFaction(pTweakEnterPAFaction)
			npc.RemoveFromFaction(pTweakEnterPAFaction)
			npc.EvaluatePackage()
		endif
		if (npc.IsInFaction(pTweakPAHelmetCombatToggleFaction))		
			TryToUnEquipPAHelmet()
		endif		
		return
	endif
	
	npc.AddToFaction(pTweakEnterPAFaction)
	npc.EvaluatePackage()

	Float actualDistance = npc.GetDistance(akPowerArmor)
	int maxwait
	if (actualDistance < 115)
		maxwait = 18
	elseif ((actualDistance < 215))
		maxwait = 22
	elseif ((actualDistance < 315))
		maxwait = 26
	elseif ((actualDistance < 415))
		maxwait = 30
	elseif ((actualDistance < 515))
		maxwait = 34
	elseif ((actualDistance < 615))
		maxwait = 38
	elseif ((actualDistance < 715))
		maxwait = 42
	elseif ((actualDistance < 815))
		maxwait = 46
	elseif ((actualDistance < 915))
		maxwait = 50
	else
		maxwait = 60
	endif
	StartTimer(maxwait,ENTER_PA_TIMEOUT)	
EndFunction

Function TryToUnEquipPAHelmet()
	Trace("TryToEquipPAHelmet")
	Actor npc = self.GetActorRef()
	if !pTrackedPAHelmet
		Trace("No pTrackedPAHelmet. Searching")
		Armor Armor_Power_Raider_Helm	= Game.GetForm(0x00140C54) as Armor
		Armor Armor_Power_T45_Helm		= Game.GetForm(0x00154ABF) as Armor
		Armor Armor_Power_T51_Helm		= Game.GetForm(0x00140C4E) as Armor
		Armor Armor_Power_T60_Helm		= Game.GetForm(0x00140C4A) as Armor
		Armor Armor_Power_X01_Helm		= Game.GetForm(0x00154AC5) as Armor
		if npc.IsEquipped(Armor_Power_Raider_Helm)
			Trace("pTrackedPAHelmet = Armor_Power_Raider_Helm")
			pTrackedPAHelmet = Armor_Power_Raider_Helm
		elseif npc.IsEquipped(Armor_Power_T45_Helm)
			Trace("pTrackedPAHelmet = Armor_Power_T45_Helm")
			pTrackedPAHelmet = Armor_Power_T45_Helm
		elseif npc.IsEquipped(Armor_Power_T51_Helm)
			Trace("pTrackedPAHelmet = Armor_Power_T51_Helm")
			pTrackedPAHelmet = Armor_Power_T51_Helm
		elseif npc.IsEquipped(Armor_Power_T60_Helm)
			Trace("pTrackedPAHelmet = Armor_Power_T60_Helm")
			pTrackedPAHelmet = Armor_Power_T60_Helm
		elseif npc.IsEquipped(Armor_Power_X01_Helm)
			Trace("pTrackedPAHelmet = Armor_Power_X01_Helm")
			pTrackedPAHelmet = Armor_Power_X01_Helm
		endif
	else
		Trace("pTrackedPAHelmet found")
	endIf
	if (pTrackedPAHelmet && !combatInProgress)
		if npc.IsEquipped(pTrackedPAHelmet)
			ignorePAEvents = true
			Trace("Unequipping Helmet")				
			npc.UnEquipItem(pTrackedPAHelmet)
			ignorePAEvents = false
		else
			Trace("Ignored : Helmet not currently equipped")				
		endif
	else
		Trace("Ignored : No pTrackedPAHelmet or combatInProgress")		
	endif
EndFunction

Function TryToEquipPAHelmet()
	Trace("TryToEquipPAHelmet")
	Actor npc = self.GetActorRef()
	if (pTrackedPAHelmet)
		if !npc.IsEquipped(pTrackedPAHelmet)
			if 0 != npc.GetItemCount(pTrackedPAHelmet)
				ignorePAEvents = true
				npc.EquipItem(pTrackedPAHelmet)
				ignorePAEvents = false
				Utility.wait(0.5)
				if (!npc.IsEquipped(pTrackedPAHelmet))
					Trace("EQUIP FAILURE ** But at least it was detected")
					
					; Retry the more expensive way....
					Trace("PAOutfit.length = [" + PAOutfit.length + "]")
					int i = 0
					int pa_numparts = PAOutfit.length
					ignorePAEvents = true
					while (i < pa_numparts)
						Armor pa_part = PAOutfit[i] as Armor
						if pa_part
							Trace("Unequipping Part [" + pa_part + "]")
							npc.UnequipItem(pa_part)
						endif
						i += 1
					endwhile
					Trace("Bumping AI")
					BumpArmorAI()
					pa_numparts = PAOutfit.length
					while (i < pa_numparts)
						Armor pa_part = PAOutfit[i] as Armor
						if pa_part
							Trace("Equipping Part [" + pa_part + "]")
							npc.EquipItem(pa_part)
						endif
						i += 1
					endwhile
					ignorePAEvents = false
				else
					Trace("pTrackedPAHelmet Successfully Equipped")			
				endif
			else
				Trace("Ignored : Follower does not have the helmet")			
			endif
		else
			Trace("Ignored : pTrackedPAHelmet already Equipped")
		endif
	else
		Trace("Ignored : No pTrackedPAHelmet")
	endif
EndFunction

Function EnablePAHelmetCombatToggle()
	Actor npc = self.GetActorReference()
	npc.AddToFaction(pTweakPAHelmetCombatToggleFaction)
	if !(1.0 == npc.GetValue(pTweakInPowerArmor) || npc.WornHasKeyword(pArmorTypePower))
		return
	endif
	TryToUnEquipPAHelmet()
EndFunction

Function DisablePAHelmetCombatToggle()
	Actor npc = self.GetActorReference()
	npc.RemoveFromFaction(pTweakPAHelmetCombatToggleFaction)
	if !(1.0 == npc.GetValue(pTweakInPowerArmor) || npc.WornHasKeyword(pArmorTypePower))
		return
	endif
	TryToEquipPAHelmet()
EndFunction

Function CheckPAStatus()
	Trace("CheckPAStatus()")
	Actor npc = self.GetActorRef()	
	if (npc.IsInFaction(pTweakPAHelmetCombatToggleFaction) && npc.Is3DLoaded() && (1.0 == npc.GetValue(pTweakInPowerArmor) || npc.WornHasKeyword(pArmorTypePower)))
		TryToUnEquipPAHelmet()
	endif
EndFunction


;===============================================================================
; OUTFIT Management
;===============================================================================
; Orginally I wanted to do snapshots. IE: Call UnequipAll and monitor 
; OnItemUnequip events to figure out what the NPC was wearing. However it turns 
; out that Bulk functions don't reliably fire Unequip events for all 
; worn/readied items. In fact, they dont even reliably update the 3d Model in 
; game 
; 
; The bug has something to do with weapons already equipped when the mod is 
; installed. If you use unequipall on an npc who had weapons equipped before 
; your mod was installed, there is a good chance only events for the weapons
; will fire.  
;
; Instead of taking a snapshot, we monitor OnItemEquip events an maintain our 
; own internal tracking list of what the NPC is wearing. As a result, 
; anytime the user uses the command "UnequipAll", we start "managing" the NPC's
; inventory. From that moment forward, we keep a "CurrentOutfit" array up to 
; date. Anytime UnequipAll() is called we clear the CurrentOutfit (since we know
; about how unreliable the events are in that case) As a result, most scripts 
; throughout AFT use the local UnequipAllGear() method to ensure that the 
; CurrentOutfit is in sync. 
;
; If SetTweakOutfit is called and the NPC is not already managed, we strip them 
; down. So the first time you set someones outfit, they may become naked. After 
; that, they wont. 
;
; We register for an event to get notified when the barter menu closes, at which
; point the CurrentOutfit should have the items we care about. 
;
; FUNCTION NOTES
;
; RestoreTweakOutfit() : If you call this with no parameters or the
; value OUTFIT_NONE (0), it will attempt to restore the appropriate 
; outfit for the current location if one is set. However, to restore
; the snapshot outfit, you must specify it as a parameter.
;
;  * When working with SNAPSHOTS, consider calling ClearTweakOutfit()
;    instead of RestoreTweakOutfit as it will restore and clean
;    up at the same time. 
;
; SetTweakOutfit() : When passed a silent flag, it will ignore the 
; call if the NPC is not managed. This is intentional so that 
; a follow up call to UnEquipAll and then RestoreOutfit (later) 
; will leave them naked (but managed). The player may have to fix 
; the NPC once, but after that they wont have to bother again. 
;
; UnEquipAll strips the NPC down and begins management if it is not 
; already running. For this reason, we should almost never call
; npc.UnequipAll. Try to redirect all UnequipAll calls to this
; script to maximize the possibility of finding a good moment 
; to start monitoring follower changes. 


; ScriptSource means source is from automated script. Example: NPC uses a scripted
; furniture. If it comes from a pipboy directed command, it should be false.
Function UnequipAllGear(bool InvokedFromFurniture=false)

	if (InvokedFromFurniture && !managed)
		trace("Ignoring UnequipAllGear request. NPC is not managed.")
		return
	endif
	
	Actor npc = self.GetActorRef()
	
	bool wasInPA = false
	if 1.0 == npc.GetValue(pTweakInPowerArmor) || npc.WornHasKeyword(pArmorTypePower)
		wasInPA = true
		ExitPA()
	endif	

	if !managed 
		SetOutfitFix(npc, pTweakNoOutfit)
		; Deacon Check....
		if (npc.GetActorBase() == Game.GetForm(0x00045AC9) as ActorBase)
			TweakFollowerScript pTweakFollowerScript = (GetOwningQuest() as TweakFollowerScript)
			if pTweakFollowerScript
				pTweakFollowerScript.AddDeaconItems()	
			endif
			Quest COMDeacon = Game.GetForm(0x000BBD9B) as Quest
			if (COMDeacon)
				COMDeaconScript pCOMDeacon = (COMDeacon as COMDeaconScript)
				if pCOMDeacon
					Trace("Unregistering COMDeacon OnLocationChange Event Monitoring")
					pCOMDeacon.UnRegisterForRemoteEvent(Game.GetPlayer(),"OnLocationChange")
					pCOMDeacon.bCanSwapDisguises = 0
				else
					Trace("Cast to COMDeaconScript Failed")
				endif
			else
				Trace("Cast to COMDeacon Quest Failed")
			endif
		endIf
		; MacCready Check....		
		if (npc.GetActorBase() == Game.GetForm(0x0002740E) as ActorBase)
			; ClothesDeaconWig
			Armor Armor_MacCready_Raider_Underarmor = Game.GetForm(0x0004A53B) as Armor
			Armor TweakArmor_MacCready_Raider_Underarmor = Game.GetFormFromFile(0x0100367F,"AmazingFollowerTweaks.esp") as Armor
			if (0 != npc.GetItemCount(Armor_MacCready_Raider_Underarmor))
				npc.RemoveItem(Armor_MacCready_Raider_Underarmor)
			endif	
			if (0 == npc.GetItemCount(TweakArmor_MacCready_Raider_Underarmor))
				npc.AddItem(TweakArmor_MacCready_Raider_Underarmor)
			endIf			
		endif
	endif
	
	npc.UnEquipAll()
	BumpArmorAI()
	managed = true
	npc.AddToFaction(pTweakManagedOutfit)
	RemoveDefaultWeapon()
	
	CurrentOutfit.clear()
	myHead.Clear()
	PAOutfit.Clear()
	
	if (wasInPA)
		EnterAssignedPA()
	endif	
	
EndFunction

; The default targetOutfit 0 does nothing. You have to pass in a non-zero value to record the 
; contents of CurrentOutfit to an outfit array. If the silent flag is true, then no barter menu
; will appear. If the NPC is not already managed and silent is true, then the command is ignored.
bool wasReadyWeapon = true
bool wasTeammate    = true
Function SetTweakOutfit(int targetOutfit = 0, bool silent = false)
	Trace("SetTweakOutfit(" + targetOutfit + ")")	
	
	; silent means we dont want any prompts or messages.	
	if (silent && !managed)
		Trace("Followers outfit is not managed. Ignoring Request")
		return
	endIf
	
	Actor npc = self.GetActorReference()
	if 1.0 == npc.GetValue(pTweakInPowerArmor) || npc.WornHasKeyword(pArmorTypePower)
		Trace("Ignoring SetTweakOutfit. NPC is wearing PowerArmor")
		return
	endif	
	
	; CurrentOutfitDesired willbe 0 is outfit management is not enabled. 
	if (0 == targetOutfit)
		Trace("NoOP : SetTweakOutfit OUTFIT_NONE")
		return
	endif
	
	if (!npc.Is3DLoaded())
		Trace("NPC 3D is not loaded. Ignoring...")
		return
	endif

	Form[] gear
	if (OUTFIT_SNAPSHOT == targetOutfit)
		Trace("Setting Gear to SnapShotOutfit [" + SnapShotOutfit + "]")
		gear = SnapShotOutfit
	elseif (OUTFIT_COMBAT == targetOutfit)
		Trace("Setting Gear to CombatOutfit [" + CombatOutfit + "]")
		npc.AddToFaction(pTweakCombatOutFitFaction)
		CombatOutfitEnabled = true
		gear = CombatOutfit
	elseif (OUTFIT_SWIM == targetOutfit)
		Trace("Setting Gear to SwimOutfit [" + SwimOutfit + "]")
		npc.AddToFaction(pTweakSwimOutFitFaction)
		SwimOutfitEnabled = true
		gear = SwimOutfit
	elseif (OUTFIT_HOME == targetOutfit)
		Trace("Setting Gear to HomeOutfit [" + HomeOutfit + "]")
		npc.AddToFaction(pTweakHomeOutFitFaction)
		HomeOutfitEnabled = true
		gear = HomeOutfit		
	elseif (OUTFIT_CAMP == targetOutfit)
		Trace("Setting Gear to CampOutfit [" + CampOutfit + "]")
		npc.AddToFaction(pTweakCampOutFitFaction)
		CampOutfitEnabled = true
		gear = CampOutfit
	elseif (OUTFIT_CITY == targetOutfit)
		Trace("Setting Gear to CityOutfit [" + CityOutfit + "]")
		npc.AddToFaction(pTweakCityOutFaction)
		CityOutfitEnabled = true		
		gear = CityOutfit
	elseif (OUTFIT_STANDARD == targetOutfit)
		Trace("Setting Gear to StandardOutfit [" + StandardOutfit + "]")
		npc.AddToFaction(pTweakStandardOutfitFaction)
		StandardOutfitEnabled = true
		gear = StandardOutfit
	else
		Trace("No Match for targetOutfit [" + targetOutfit + "]")
		return
	endif
	
	; NOTE : !empty_array evaluates as true. Even (None == empty_array) evaluates as true. 
	; So, you need to track it independently. 
	
	Trace("Clearing outfit [" + targetOutfit + "]")
	gear.Clear()
	
	if (managed && silent)
		int curr_len = CurrentOutfit.length
		Trace("Using CurrentOutfit. [" + curr_len + "] items")
		int i = 0
		while (i < curr_len)
			gear.Add(CurrentOutfit[i])
			i += 1
		endwhile
		return
	endif
	
	wasReadyWeapon = npc.HasKeyword(pTeammateReadyWeapon_DO)
	wasTeammate    = npc.IsPlayerTeammate()
	invRec 		   = targetOutfit
	
	if (!wasTeammate)
		npc.SetPlayerTeammate(true)
	endif
	if (wasReadyWeapon)
		npc.RemoveKeyword(pTeammateReadyWeapon_DO)
	endif
		
	; Make sure there aren't any buffered latent
	; operations pending
	Utility.wait(0.10)
	
	if (!managed)
		UnequipAllGear() ; This will enable management
		Utility.wait(0.1)
	endif

	RegisterForMenuOpenCloseEvent("ContainerMenu")
	Utility.wait(0.1)
	npc.OpenInventory(true)	
		
endFunction


Function ClearTweakOutfit(int targetOutfit)
	Trace("ClearTweakOutfit [" + targetOutfit + "]")
	RestoreTweakOutfit(targetOutfit)
	Actor npc = self.GetActorReference()
	Form[] gear
	if (OUTFIT_COMBAT == targetOutfit)
		Trace("Clearing CombatOutfit [" + CombatOutfit + "]")
		npc.RemoveFromFaction(pTweakCombatOutFitFaction)		
		CombatOutfitEnabled = false		
		gear = CombatOutfit		
	elseif (OUTFIT_SWIM == targetOutfit)
		Trace("Clearing SwimOutfit [" + SwimOutfit + "]")
		npc.RemoveFromFaction(pTweakSwimOutFitFaction)
		SwimOutfitEnabled = false
		gear = SwimOutfit
	elseif (OUTFIT_HOME == targetOutfit)
		Trace("Clearing HomeOutfit [" + HomeOutfit + "]")
		npc.RemoveFromFaction(pTweakHomeOutFitFaction)
		HomeOutfitEnabled = false
		gear = HomeOutfit
	elseif (OUTFIT_CAMP == targetOutfit)
		Trace("Clearing CampOutfit [" + CampOutfit + "]")
		npc.RemoveFromFaction(pTweakCampOutFitFaction)
		CampOutfitEnabled = false
		gear = CampOutfit
	elseif (OUTFIT_CITY == targetOutfit)
		Trace("Clearing CityOutfit [" + CityOutfit + "]")
		npc.RemoveFromFaction(pTweakCityOutFaction)
		CityOutfitEnabled = false		
		gear = CityOutfit
	elseif (OUTFIT_STANDARD == targetOutfit)
		Trace("Clearing StandardOutfit [" + StandardOutfit + "]")
		npc.RemoveFromFaction(pTweakStandardOutFitFaction)
		StandardOutfitEnabled = false
		gear = StandardOutfit
	elseif (OUTFIT_SNAPSHOT == targetOutfit)
		Trace("Clearing SnapShotOutfit [" + SnapShotOutfit + "]")
		gear = SnapShotOutfit
	else
		Trace("TargetOutfit invalid")
		return
	endif
	
	gear.Clear()
	
EndFunction

Function ClearAllOutfits()
	Trace("ClearAllOutfits")
	Actor npc = self.GetActorReference()
	if CombatOutfitEnabled
		Trace("Clearing CombatOutfit")
		npc.RemoveFromFaction(pTweakCombatOutFitFaction)		
		CombatOutfitEnabled = false		
		CombatOutfit.clear()		
	endif
	
	; Quest TweakFollower registers for Player Distance events
	; in regards to AFT Camp. It in turn will invokde this
	; methods OnLoad handler if the player gets within 1000
	; of camp center. 
	
	if SwimOutfitEnabled
		Trace("Clearing SwimOutfit")
		npc.RemoveFromFaction(pTweakSwimOutFitFaction)
		SwimOutfitEnabled = false
		SwimOutfit.clear()
	endif
	if HomeOutfitEnabled
		Trace("Clearing HomeOutfit")
		npc.RemoveFromFaction(pTweakHomeOutFitFaction)
		HomeOutfitEnabled = false
		HomeOutfit.clear()
	endif
	if CampOutfitEnabled
		Trace("Clearing CampOutfit")
		npc.RemoveFromFaction(pTweakCampOutFitFaction)
		CampOutfitEnabled = false
		CampOutfit.clear()
	endif
	if CityOutfitEnabled
		Trace("Clearing CityOutfit")
		npc.RemoveFromFaction(pTweakCityOutFaction)
		CityOutfitEnabled = false		
		CityOutfit.clear()
	endif
	if StandardOutfitEnabled
		Trace("Clearing StandardOutfit")
		npc.RemoveFromFaction(pTweakStandardOutFitFaction)
		StandardOutfitEnabled = false
		StandardOutfit.clear()
	endif
	SnapShotOutfit.clear()
endFunction

; There are two ways we can do this. We can strip them of everything and then
; equip the items in the outfit. This is pretty strait forward and generally
; works, but causes a nudity flash when changing outfits. 
;
; The second way is we tell the NPC to equip all the items in the outfit
; and then compare the currentoutfit (that we constantly track) with the
; items in the requested outfit and unequip differences.  This is more
; prone to bugs, but prevents nudity flashing. 
Function RestoreTweakOutfit(int targetOutfit = 0, bool AvoidUnequipAll = true)
	Trace("RestoreTweakOutfit [" + targetOutfit + "]")
	if !managed
		Trace("NPC is not managed. Ignoring Call")
		return
	endif
	if (targetOutfit < 0 || targetOutfit > 8)
		Trace("Invalid TargetOutfit")
		return
	endif
	
	Actor npc = self.GetActorReference()
	if 1.0 == npc.GetValue(pTweakInPowerArmor) || npc.WornHasKeyword(pArmorTypePower)
		Trace("Ignoring RestoreTweakOutfit. NPC is wearing PowerArmor")
		
		; NEW 1.14 : Equip Combat Outfit weapon when combat starts. Even in PA:
		if OUTFIT_COMBAT == targetOutfit || (CombatOutfitEnabled && combatInProgress && npc.IsPlayerTeammate())
			pTrackedWeapon = None
			Int n_items = CombatOutfit.length
			if (n_items > 0)
				Form c_item
				Int c = 0
				while (c < n_items)
					c_item = CombatOutfit[c]
					if (c_item && c_item as Weapon && 0 != npc.GetItemCount(c_item))
						Trace("EquipItem [" + c_item + "]")
						pTrackedWeapon = (c_item as Weapon)
						npc.EquipItem(c_item, true, true)
						c = n_items
					endif
					c += 1
				endWhile
			endif
		endif	
		return
	endif	
	
	Form[] gear = None
	
	; Criteria May not be met (IE: Restore combat outside combat because
	; it is being disabled)
	
	if 0 == targetOutfit
		if (CombatOutfitEnabled && combatInProgress)
			targetOutfit = OUTFIT_COMBAT
		elseif (SwimOutfitEnabled && playerIsSwimming)
			targetOutfit = OUTFIT_SWIM			
		elseif (HomeOutfitEnabled && ShouldUseHomeOutfit())
			targetOutfit = OUTFIT_HOME
		elseif (CampOutfitEnabled && npc.GetDistance(pShelterMapMarker.GetReference()) < 1000)
			targetOutfit = OUTFIT_CAMP
		elseif (CityOutfitEnabled && IsInCity())
			targetOutfit = OUTFIT_CITY
		elseif (StandardOutfitEnabled)
			targetOutfit = OUTFIT_STANDARD
		elseif CurrentOutfit.length > 0
			targetOutfit = OUTFIT_LASTKNOWN
		else
			targetOutfit = OUTFIT_NONE		
		endIf
	endIf
	
	; Set gear ptr based on assessment or bail
	if (OUTFIT_SNAPSHOT == targetOutfit)
		gear = SnapShotOutfit
	elseif (OUTFIT_COMBAT == targetOutfit)
		CurrentOutfitDesired = OUTFIT_COMBAT
		gear = CombatOutfit
	elseif (OUTFIT_SWIM == targetOutfit)
		CurrentOutfitDesired = OUTFIT_SWIM
		gear = SwimOutfit	
	elseif (OUTFIT_HOME == targetOutfit)
		CurrentOutfitDesired = OUTFIT_HOME
		gear = HomeOutfit
	elseif (OUTFIT_CAMP == targetOutfit)
		CurrentOutfitDesired = OUTFIT_CAMP
		gear = CampOutfit
	elseif (OUTFIT_CITY == targetOutfit)
		CurrentOutfitDesired = OUTFIT_CITY
		gear = CityOutfit
	elseif (OUTFIT_STANDARD == targetOutfit)
		CurrentOutfitDesired = OUTFIT_STANDARD
		gear = StandardOutfit
	elseif (OUTFIT_LASTKNOWN == targetOutfit)
		CurrentOutfitDesired = OUTFIT_LASTKNOWN
		gear = CurrentOutfit
	else	
		CurrentOutfitDesired = OUTFIT_NONE
		return
	endif
	
		
	; NOTE : !empty_array evaluates as true. Even (None == empty_array) evaluates as true. 
	; So, you need to track it independently. 
		
	if(!AvoidUnequipAll)
		UnequipAllGear()
		Int numitems = gear.length
		Int i = 0
		Form item
		if (gear == CombatOutfit)
			pTrackedWeapon = None
			while (i < numitems)
				item = gear[i]
				if (0 != npc.GetItemCount(item))
					Trace("EquipItem [" + item + "]")
					if item as Weapon
						; Remember so Standard Outfit/Set Outfit can marks
						; as removable.
						pTrackedWeapon = (item as Weapon)
						npc.EquipItem(item, true, true)
					else
						npc.EquipItem(item, false, true)
					endIf
				else
					Trace("NPC no longer has item [" + item + "]")
				endif				
				i += 1
			endWhile			
		else
			while (i < numitems)
				item = gear[i]
				if (0 != npc.GetItemCount(item))
					Trace("EquipItem [" + item + "]")
					npc.EquipItem(item, false, true)
				else
					Trace("NPC no longer has item [" + item + "]")
				endif				
				i += 1
			endWhile
		endif
		return
	endif

	; Normal/Default case: AvoidUnequipAll is true (which is default)
	managed = false ; We need to freeze CurrentOutfit so we can compare later
	
	Int numitems = gear.length
	Trace("Snapshot [" + targetOutfit + "] has [" + numitems + "] pieces")
	
	if (numitems > 0)
		Form item
		Int i = 0
		if (gear == CombatOutfit)
		
			while (i < numitems)
				item = gear[i]
				if (item)
					if (0 != npc.GetItemCount(item))
						Trace("EquipItem [" + item + "]")
						if item as Weapon
							pTrackedWeapon = (item as Weapon)
						else
							npc.EquipItem(item, false, true)
						endIf
					else
						Trace("NPC not longer has item [" + item + "]")
					endif				
				endif
				i += 1
			endWhile
			
			if pTrackedWeapon && npc.IsPlayerTeammate()
				npc.EquipItem(pTweakWeap)
				Utility.wait(0.32) ; at least 0.25 
				npc.UnequipItem(pTweakWeap)
				Utility.wait(0.32) ; at least 0.25
				npc.RemoveItem(pTweakWeap)
				Utility.wait(0.32) ; at least 0.25
				npc.EquipItem(pTrackedWeapon, true, true)
				; TODO : Telease Tracked Weapon after 10 seconds?
			endif
			
		else
			; if pTrackedWeapon && npc.IsEquipped(pTrackedWeapon)
				; npc.UnequipItem(pTrackedWeapon)
				; pTrackedWeapon = None
			; endif
			while (i < numitems)
				item = gear[i]
				if (item)
					if (0 != npc.GetItemCount(item))
						Trace("EquipItem [" + item + "]")
						npc.EquipItem(item, false, true)
					else
						Trace("NPC not longer has item [" + item + "]")
					endif				
				endif
				i += 1
			endWhile
		endif
	endif

	if gear == CurrentOutfit
		Trace("Skipping Sync. CurrentOutfit is Chosen outfit")
		managed = true
		Trace("Done")
		return
	endif
	
	int i = 0
	int curr_len = CurrentOutfit.length
	while (i < curr_len)
		Form item = CurrentOutfit[i]
		if !(item as Weapon)
			if (npc.IsEquipped(item) && (gear.Find(item) < 0))
				Trace("UnEquipItem [" + item + "]")
				npc.UnEquipItem(item,false,true)
				int pos = myHead.Find(item)
				if (pos > -1)
					Trace("Removing from myHead")
					myHead.Remove(pos)
				endif
			endif
		endif
		i += 1
	endWhile
	
	Trace("Syncing CurrentOutfit with Chosen outfit")
	CurrentOutfit.Clear()
	myHead.Clear()
	i = 0
	while (i < numitems)
		Form akBaseItem = gear[i]
		int formid = akBaseItem.GetFormID()
		if (akBaseItem.HasKeyword(ArmorBodyPartHead) || akBaseItem.HasKeyword(ArmorTypeHat) || formid == 0x00125891 || \
								formid == 0x0004A520 || formid == 0x001C4BE8 || formid == 0x000FD9AA || \
								formid == 0x001738AA || formid == 0x000E628A || formid == 0x000A81AF)
			myHead.Add(akBaseItem)
		endif
		CurrentOutfit.Add(akBaseItem)
		i += 1
	endWhile
	
	managed = true
	Trace("Done")
	
endFunction

Function HandleCombatEnd()
	if (!combatInProgress)
		return
	endif
	combatInProgress = False
	CancelTimer(COMBATEND_DELAYED)
	
	Actor npc=self.GetActorRef()
	
	if npc.IsDead()
		return
	endif

	if 1.0 == npc.GetValue(pTweakInPowerArmor) || npc.WornHasKeyword(pArmorTypePower)
		Trace("PowerArmor Detected")
		if (npc.IsInFaction(pTweakPAHelmetCombatToggleFaction))
			Trace("NPC is in TweakPAHelmetCombatToggleFaction")
			if (pTrackedPAHelmet)
				Trace("pTrackedPAHelmet has value")
				if (npc.IsEquipped(pTrackedPAHelmet))
					Trace("pTrackedPAHelmet is Equipped. Attempting to UnEquip")
					Actor pc = Game.GetPlayer()
					ignorePAEvents = true
					npc.UnEquipItem(pTrackedPAHelmet)
					ignorePAEvents = false
					if (npc.IsEquipped(pTrackedPAHelmet))
						Trace("UNEQUIP FAILURE ** But at least it was detected")
					endif
				endif
			endif
		endif
		return
	endif	
	
	RestoreTweakOutfit()
EndFunction

;===============================================================================
; Gear Management
;===============================================================================
; These are mostly convenience scripts for doing things to save the player time.
; IE: Instead of having to stop exploring every few hours to unload and sell gear
; at a city, you can just use your companions.  This is particularly useful
; for people who are not a fan of fasttravel. 
;
; Functions are created in the order I suspect they would be used. IE: First, 
; give junk to NPC. Have NPC convert junk to scrap (Normally lighter). None-Junk
; like armor and weapons you dont need, would likely get sold. Player can earmark
; reserved items by assigning them to one of the 4 outfits. Followers will never
; sell items associated with their outfits.
; 
; If no outfits are set, the commands change to reflect that:
;
;  - Take My Junk
;  - Take My Duplicate Items
;  - Convert Junk to Scrap
;  - Give me your scrap
;  - Sell Your Unused Gear / Sell All Your Gear
;  - Give me your unused gear / Give me All Your Gear

;--------------------------------------
; Take My Junk
;--------------------------------------
Function TakePlayerJunk()
	Trace("TakePlayerJunk()")
	
	Actor npc = self.GetActorReference()
	Actor pc  = Game.GetPlayer()	
	int prevCount = npc.GetItemCount()
	pc.RemoveItem(pWorkshopConsumeScavenge, -1,true, npc)
	if (prevCount != npc.GetItemCount())
		Sound takeAll = Game.GetForm(0x000802A6) as Sound
		if takeAll
			takeAll.play(pc)
		endif
	endif	
EndFunction

;--------------------------------------
; Convert Junk to Scrap
;--------------------------------------

ObjectReference scrapContainer
int[] scrapTotals
component[] components
form[] scrap
int scrapState

Function ScrapJunk()
	Trace("ScrapJunk()")
	Actor npc = self.GetActorReference()	
	Actor pc  = Game.GetPlayer()
	
	Form GenericContainer = Game.GetForm(0x00020D57)
	float[] posdata = TraceCircle(npc,-100)
	scrapContainer = npc.PlaceAtMe(GenericContainer)
	scrapContainer.SetPosition(posdata[0],posdata[1],posdata[2])
		
	int prevCount = npc.GetItemCount()	
	npc.RemoveItem(pWorkshopConsumeScavenge,-1,true,scrapContainer)		
	
	if (prevCount == npc.GetItemCount())
		scrapContainer.RemoveAllItems(npc)
		scrapContainer.Disable()
		pTweakScrapJunk100.Show()
		Utility.wait(2.0)
		scrapContainer.Delete()
		scrapContainer = None
		return
	endIf

	scrapTotals = new int[31]       ; Cleared by ScrapJunkFinalize
	components  = new component[31] ; Cleared by ScrapJunkFinalize
	
	int i = 0
	while i < 31
		scrapTotals[i] = 0
		components[i] = pWorkshopConsumeScavenge.GetAt(i) as Component
		i += 1
	endwhile
		
	scrap     = new form[31]      ; Cleared by ScrapJunkFinalize
	scrap[0]  = Game.GetForm(0x001BF72D) ; Acid
	scrap[1]  = Game.GetForm(0x001BF72E) ; Adhesive
	scrap[2]  = Game.GetForm(0x00106D98) ; Rubber
	scrap[3]  = Game.GetForm(0x00069081) ; Screws
	scrap[4]  = Game.GetForm(0x0006907A) ; Aluminum
	scrap[5]  = Game.GetForm(0x000AEC5B) ; AntiBallisticFiber
	scrap[6]  = Game.GetForm(0x001BF72F) ; Antiseptic
	scrap[7]  = Game.GetForm(0x000AEC5C) ; Asbestos
	scrap[8]  = Game.GetForm(0x000AEC5D) ; Bone
	scrap[9]  = Game.GetForm(0x000AEC5E) ; Ceramic
	scrap[10] = Game.GetForm(0x0006907B) ; Circuitry
	scrap[11] = Game.GetForm(0x000AEC5F) ; Cloth
	scrap[12] = Game.GetForm(0x00106D99) ; Concrete
	scrap[13] = Game.GetForm(0x0006907C) ; Copper
	scrap[14] = Game.GetForm(0x000AEC60) ; Cork
	scrap[15] = Game.GetForm(0x0006907D) ; Crystal
	scrap[16] = Game.GetForm(0x001BF730) ; Fertilizer
	scrap[17] = Game.GetForm(0x000AEC61) ; Fiberglass
	scrap[18] = Game.GetForm(0x00069087) ; FiberOptics
	scrap[19] = Game.GetForm(0x000731A4) ; Steel	
	scrap[20] = Game.GetForm(0x000AEC66) ; Silver
	scrap[21] = Game.GetForm(0x0006907E) ; Gears
	scrap[22] = Game.GetForm(0x00069085) ; Glass
	scrap[23] = Game.GetForm(0x000AEC62) ; Gold
	scrap[24] = Game.GetForm(0x00069082) ; Springs
	scrap[25] = Game.GetForm(0x000AEC63) ; Lead
	scrap[26] = Game.GetForm(0x000AEC64) ; Leather
	scrap[27] = Game.GetForm(0x000731A3) ; Wood
	scrap[28] = Game.GetForm(0x0006907F) ; Plastic
	scrap[29] = Game.GetForm(0x00069086) ; NuclearMaterial
	scrap[30] = Game.GetForm(0x001BF732) ; Oil	
	
	scrapState = 31

	RegisterForRemoteEvent(scrapContainer,"OnItemRemoved")
	AddInventoryEventFilter(None)	
	pTweakScrapJunk.Show()	
	ScrapJunkEM()
		
EndFunction

; EventMachine
Function ScrapJunkEM()
	if (0 == scrapState || 0 == scrapContainer.GetItemCount())
		ScrapJunkFinalize()
		return
	endif
		
	scrapState -= 1
	if (24 == scrapState)
		pTweakScrapJunk20.Show()
	elseif (18 == scrapState)
		pTweakScrapJunk40.Show()
	elseif (12 == scrapState)
		pTweakScrapJunk60.Show()
	elseif (6 == scrapState)
		pTweakScrapJunk80.Show()
	endif
	
	scrapContainer.RemoveComponents(components[scrapState], 1)
	StartTimer(0.1, scrapState)
EndFunction

Event ObjectReference.OnItemRemoved(ObjectReference akContainer, Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	StartTimer(0.1, scrapState) ; Renew/KeepAlive
	scrapTotals[scrapState] += 1
	scrapContainer.RemoveComponents(components[scrapState], 1)
EndEvent

Function ScrapJunkFinalize()
	Actor npc = self.GetActorReference()
	RemoveAllInventoryEventFilters()
	UnRegisterForRemoteEvent(scrapContainer,"OnItemRemoved")
	
	int i = 0
	while (i < 31)
		if (scrapTotals[i] != 0)
			Trace("Adding [" + scrapTotals[i] + "] elements of type [" + i + "]")
			scrapContainer.AddItem(scrap[i],scrapTotals[i])
		endif
		i += 1
	endWhile
	
	scrapTotals.clear()
	components.clear()
	scrap.clear()
	scrapTotals = None
	components = None
	scrap = None
	
	scrapContainer.RemoveAllItems(npc)
	scrapContainer.Disable()
	
	pTweakScrapJunk100.Show()
	
	Utility.wait(2.0)
	scrapContainer.Delete()
	scrapContainer = None
	
EndFunction

;--------------------------------------
; Give me your scrap
;--------------------------------------
Function GivePlayerScrap()
	Trace("GivePlayerScrap()")
	Actor npc = self.GetActorReference()	
	Actor pc  = Game.GetPlayer()
	FormList ScrapList = Game.GetFormFromFile(0x0100B02D,"AmazingFollowerTweaks.esp") as FormList; TweakScrapComponents
	
	int prevCount = npc.GetItemCount()
	npc.RemoveItem(ScrapList,-1,true,pc)
	if (prevCount != npc.GetItemCount())
		Sound takeAll = Game.GetForm(0x000802A6) as Sound
		if takeAll
			takeAll.play(pc)
		endif
	endif
EndFunction

Function GivePlayerJunk()
	Trace("GivePlayerJunk()")

	Actor npc = self.GetActorReference()	
	Actor pc  = Game.GetPlayer()

	int prevCount = npc.GetItemCount()	
	npc.RemoveItem(pWorkshopConsumeScavenge,-1,true,pc)		
	
	if (prevCount != npc.GetItemCount())
		Sound takeAll = Game.GetForm(0x000802A6) as Sound
		if takeAll
			takeAll.play(pc)
		endif
	endif	
EndFunction

;--------------------------------------
; Sell Your Unused Gear
;--------------------------------------
Function SellUnused()
	Trace("SellUnused()")
	Actor npc = self.GetActorReference()	
	Actor pc  = Game.GetPlayer()

	bool wasInPA = false
	if 1.0 == npc.GetValue(pTweakInPowerArmor) || npc.WornHasKeyword(pArmorTypePower)
		wasInPA = true
		ExitPA()
	endif	
	
	Form GenericContainer = Game.GetForm(0x00020D57)
	float[] posdata = TraceCircle(npc,-100)
	ObjectReference sellContainer = npc.PlaceAtMe(GenericContainer)
	sellContainer.SetPosition(posdata[0],posdata[1],posdata[2])
	npc.RemoveAllItems(sellContainer)
	
	; Recover Used Items
	
	int i
	int numitems
	form item
	Weapon w_item	
	form[] myAmmo = new Form[0]
		
	if (CombatOutfitEnabled)
		i = 0
		numitems = CombatOutfit.length
		while (i < numitems)
			item = CombatOutfit[i]
			w_item = item as Weapon
			if (w_item)
				myAmmo.Add(w_item.GetAmmo())
			endif
			sellContainer.RemoveItem(item,1,true,npc)
			i += 1
		endwhile
	endIf
	if (SwimOutfitEnabled)
		i = 0
		numitems = SwimOutfit.length
		while (i < numitems)
			item = SwimOutfit[i]
			w_item = item as Weapon
			if (w_item)
				myAmmo.Add(w_item.GetAmmo())
			endif
			sellContainer.RemoveItem(item,1,true,npc)
			i += 1
		endwhile
	endIf	
	if (HomeOutfitEnabled)
		i = 0
		numitems = HomeOutfit.length
		while (i < numitems)
			item = HomeOutfit[i]
			w_item = item as Weapon
			if (w_item)
				myAmmo.Add(w_item.GetAmmo())
			endif
			sellContainer.RemoveItem(item,1,true,npc)
			i += 1
		endwhile
	endIf
	if (CityOutfitEnabled)
		i = 0
		numitems = CityOutfit.length
		while (i < numitems)
			item = CityOutfit[i]
			w_item = item as Weapon
			if (w_item)
				myAmmo.Add(w_item.GetAmmo())
			endif		
			sellContainer.RemoveItem(item,1,true,npc)
			i += 1
		endwhile
	endIf
	if (CampOutfitEnabled)
		i = 0
		numitems = CampOutfit.length
		while (i < numitems)
			item = CampOutfit[i]
			w_item = item as Weapon
			if (w_item)
				myAmmo.Add(w_item.GetAmmo())
			endif				
			sellContainer.RemoveItem(item,1,true,npc)
			i += 1
		endwhile
	endIf
	if (StandardOutfitEnabled)
		i = 0
		numitems = StandardOutfit.length
		while (i < numitems)
			item = StandardOutfit[i]
			w_item = item as Weapon
			if (w_item)
				myAmmo.Add(w_item.GetAmmo())
			endif
			sellContainer.RemoveItem(item,1,true,npc)
			i += 1
		endwhile
	endIf
	
	i = 0
	numitems = myAmmo.length
	while (i < numitems)
		sellContainer.RemoveItem(myAmmo[i],-1,true,npc)
		i += 1
	endwhile
	
	; scenario : In city, not PA. Standard outfit + City configured. 
	; After sell, she remained naked. 
	
	if !wasInPA
		RestoreTweakOutfit()
	endif
	
	int totalItems    = sellContainer.GetItemCount()
	int totalValue    = sellContainer.GetInventoryValue()
	int adjustedValue = ((totalValue / 2) As Int)
	; TODO : Factor in trade perks...
	Trace("totalItems [" + totalItems + "] totalValue [" + totalValue + "] adjustedValue [" + adjustedValue + "]")
	; TODO : Do we want to present/confirm/cancel?

	Game.GivePlayerCaps(adjustedValue)

	
	sellContainer.RemoveAllItems()
	sellContainer.Disable()
	
	if (wasInPA)
		EnterAssignedPA()
	else
		Utility.wait(2.0)
	endif
	sellContainer.Delete()

EndFunction

;--------------------------------------
; Give me your unused gear
;--------------------------------------

Function TransferUnusedGearToPlayer()

	bool wasInPA = false
	Actor npc = self.GetActorReference()
	if 1.0 == npc.GetValue(pTweakInPowerArmor) || npc.WornHasKeyword(pArmorTypePower)
		wasInPA = true
		ExitPA()
	endif	
	
	Form GenericContainer = Game.GetForm(0x00020D57)
	Actor pc  = Game.GetPlayer()
	float[] posdata = TraceCircle(npc,-100)
	ObjectReference tempContainer = npc.PlaceAtMe(GenericContainer)
	tempContainer.SetPosition(posdata[0],posdata[1],posdata[2])
	npc.RemoveAllItems(tempContainer)
	
	; Recover Used Items
	
	int i
	int numitems
	form item
	Weapon w_item	
	form[] myAmmo = new Form[0]
		
	if (CombatOutfitEnabled)
		i = 0
		numitems = CombatOutfit.length
		while (i < numitems)
			item = CombatOutfit[i]
			w_item = item as Weapon
			if (w_item)
				myAmmo.Add(w_item.GetAmmo())
			endif
			tempContainer.RemoveItem(item,1,true,npc)
			i += 1
		endwhile
	endIf
	if (SwimOutfitEnabled)
		i = 0
		numitems = SwimOutfit.length
		while (i < numitems)
			item = SwimOutfit[i]
			w_item = item as Weapon
			if (w_item)
				myAmmo.Add(w_item.GetAmmo())
			endif
			tempContainer.RemoveItem(item,1,true,npc)
			i += 1
		endwhile
	endIf	
	if (HomeOutfitEnabled)
		i = 0
		numitems = HomeOutfit.length
		while (i < numitems)
			item = HomeOutfit[i]
			w_item = item as Weapon
			if (w_item)
				myAmmo.Add(w_item.GetAmmo())
			endif
			tempContainer.RemoveItem(item,1,true,npc)
			i += 1
		endwhile
	endIf
	if (CityOutfitEnabled)
		i = 0
		numitems = CityOutfit.length
		while (i < numitems)
			item = CityOutfit[i]
			w_item = item as Weapon
			if (w_item)
				myAmmo.Add(w_item.GetAmmo())
			endif		
			tempContainer.RemoveItem(item,1,true,npc)
			i += 1
		endwhile
	endIf
	if (CampOutfitEnabled)
		i = 0
		numitems = CampOutfit.length
		while (i < numitems)
			item = CampOutfit[i]
			w_item = item as Weapon
			if (w_item)
				myAmmo.Add(w_item.GetAmmo())
			endif				
			tempContainer.RemoveItem(item,1,true,npc)
			i += 1
		endwhile
	endIf
	if (StandardOutfitEnabled)
		i = 0
		numitems = StandardOutfit.length
		while (i < numitems)
			item = StandardOutfit[i]
			w_item = item as Weapon
			if (w_item)
				myAmmo.Add(w_item.GetAmmo())
			endif
			tempContainer.RemoveItem(item,1,true,npc)
			i += 1
		endwhile
	endIf
	
	i = 0
	numitems = myAmmo.length
	while (i < numitems)
		tempContainer.RemoveItem(myAmmo[i],-1,true,npc)
		i += 1
	endwhile
	
	if (!wasInPA || !CombatOutfitEnabled)
		RestoreTweakOutfit()
	endif
	
	tempContainer.RemoveAllItems(pc)
	tempContainer.Disable()
	
	if (wasInPA)
		EnterAssignedPA()
	else
		Utility.wait(2.0)
	endif
	tempContainer.Delete()
	
EndFunction

;--------------------------------------
; Give me ALL Gear
;--------------------------------------
Function GivePlayerAll()
	Trace("GivePlayerAll()")
	Actor npc = self.GetActorReference()	
	Actor pc  = Game.GetPlayer()

	bool wasInPA = false
	if 1.0 == npc.GetValue(pTweakInPowerArmor) || npc.WornHasKeyword(pArmorTypePower)
		wasInPA = true
		ExitPA()
	endif	
	
	if !managed
		SetOutfitFix(npc, pTweakNoOutfit)
		; Deacon check
		if (npc.GetActorBase() == Game.GetForm(0x00045AC9) as ActorBase)
			TweakFollowerScript pTweakFollowerScript = (GetOwningQuest() as TweakFollowerScript)
			if pTweakFollowerScript
				pTweakFollowerScript.AddDeaconItems()	
			endif
			
			Quest COMDeacon = Game.GetForm(0x000BBD9B) as Quest
			if (COMDeacon)
				COMDeaconScript pCOMDeacon = (COMDeacon as COMDeaconScript)
				if pCOMDeacon
					Trace("Unregistering COMDeacon OnLocationChange Event Monitoring")
					pCOMDeacon.UnRegisterForRemoteEvent(Game.GetPlayer(),"OnLocationChange")
					pCOMDeacon.bCanSwapDisguises = 0
				else
					Trace("Cast to COMDeaconScript Failed")
				endif
			else
				Trace("Cast to COMDeacon Quest Failed")
			endif

		endIf
		; MacCready check
		if (npc.GetActorBase() == Game.GetForm(0x0002740E) as ActorBase)
			Armor Armor_MacCready_Raider_Underarmor = Game.GetForm(0x0004A53B) as Armor
			Armor TweakArmor_MacCready_Raider_Underarmor = Game.GetFormFromFile(0x0100367F,"AmazingFollowerTweaks.esp") as Armor
			if (0 != npc.GetItemCount(Armor_MacCready_Raider_Underarmor))
				npc.RemoveItem(Armor_MacCready_Raider_Underarmor)
			endif	
			if (0 == npc.GetItemCount(TweakArmor_MacCready_Raider_Underarmor))
				npc.AddItem(TweakArmor_MacCready_Raider_Underarmor)
			endIf			
		endif
		
	endif
	
	npc.RemoveAllItems(pc)
	BumpArmorAI()
	
	managed = true
	npc.AddToFaction(pTweakManagedOutfit)
	RemoveDefaultWeapon()

	CurrentOutfit.clear()
	myHead.Clear()
	ClearAllOutfits()
	
	if (wasInPA)
		EnterAssignedPA()
	endif
	
EndFunction


Event OnTimer(int akTimerId)
	if (akTimerID < 31)
		ScrapJunkEM()
		return
	endif
	if (akTimerID == COMBATEND_DELAYED)
		if Game.GetPlayer().IsInCombat() || self.GetActorRef().IsInCombat()
			StartTimer(20,COMBATEND_DELAYED)
		else
			HandleCombatEnd()
		endif
		return
	endif	
	if (ONLOAD_FLOOD_PROTECT == akTimerId)
		OnLoadHelper()
		return
	endif
	if (ENTER_PA_TIMEOUT == akTimerId)
		Actor npc = self.GetActorReference()
		if npc.IsInFaction(pTweakEnterPAFaction)
			EnterAssignedPA(true)
		endif
		return
	endif
EndEvent

Event OnReset()
	Trace("TweakInventoryControl OnReset() detected. (Probably should put some clothes on)")
EndEvent

Function UnEquipHeadItems()
	if (myHead)
		int myHeadLen = myHead.length
		if (myHeadLen > 0)
		
			; myHead array is volatile and will update as this
			; loop executes if managed if true. So to make it
			; work as expected, we have to freeze the myHead
			; array by disabling events (setting managed to false) 
			; until we are done.
			bool prevmanaged = managed
			managed = false
			Form item
			Actor npc = self.GetActorReference()
			int i = 0
			while (i < myHeadLen)
				item = myHead[i]
				npc.UnEquipItem(myHead[i])
				int pos = CurrentOutfit.find(item)
				if (pos > -1)
					CurrentOutfit.Remove(pos)
				endif
				i += 1
			endWhile
			myHead.Clear()
			managed = prevmanaged			
		endif
	endif
EndFunction

Function ViewInventory()
	Actor npc = self.GetActorReference()
	; Nick Valentine Check
	if (npc.GetActorBase() == Game.GetForm(0x00002F24) as ActorBase)
		invRec = 0
		RegisterForMenuOpenCloseEvent("ContainerMenu")
		Utility.wait(0.1)
	endif
	npc.OpenInventory(true)
EndFunction

;==============================================================
; OUTFIT Management
;==============================================================

Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	Trace("OnMenuOpenCloseEvent [" + asMenuName + "]")
    if (asMenuName== "ContainerMenu")
        if (abOpening)
			Trace("ContainerMenu Open Event")
		else
			Trace("ContainerMenu Close Event")
			UnregisterForMenuOpenCloseEvent(asMenuName)	

			Actor npc = self.GetActorReference()
			if (npc.GetActorBase() == Game.GetForm(0x00002F24) as ActorBase)
				Armor ClothesSynth_SynthValentineParts = Game.GetForm(0x0022F0DD) as Armor
				if !npc.IsEquipped(ClothesSynth_SynthValentineParts)
					npc.EquipItem(ClothesSynth_SynthValentineParts)
				endif
			endif
			
			Form[] gear
			if (OUTFIT_SNAPSHOT == invRec)
				Trace("invRec is SnapShotOutfit")
				gear = SnapShotOutfit
			elseif (OUTFIT_COMBAT == invRec)
				Trace("invRec is CombatOutfit")
				gear = CombatOutfit
			elseif (OUTFIT_SWIM == invRec)
				Trace("invRec is SwimOutfit")
				gear = SwimOutfit				
			elseif (OUTFIT_HOME == invRec)
				Trace("invRec is HomeOutfit")
				gear = HomeOutfit
			elseif (OUTFIT_CAMP == invRec)
				Trace("invRec is CampOutfit")
				gear = CampOutfit
			elseif (OUTFIT_CITY == invRec)
				Trace("invRec is CityOutfit")
				gear = CityOutfit
			elseif (OUTFIT_STANDARD == invRec)
				Trace("invRec is StandardOutfit")
				gear = StandardOutfit
			else
				Trace("No Match for invRec [" + invRec + "]")
				invRec = 0
				return
			endif
			invRec = 0

			int curr_len = CurrentOutfit.length
			Trace("CurrentOutfit has [" + curr_len + "] items")
			int i = 0
			Form item
			while (i < curr_len)
				item = CurrentOutfit[i]
				Trace("  Adding item [" + item + "] to outfit [" + invRec + "]")
				gear.Add(item)
				i += 1
			endwhile
			
			if (!wasTeammate)
				Trace("Restoring Teammate Status to false")
				Utility.wait(1.0)
				npc.SetPlayerTeammate(false)
			endif
			if (wasReadyWeapon)
				Trace("Restoring keyword TeammateReadyWeapon_DO")
				npc.AddKeyword(pTeammateReadyWeapon_DO)
			endif
	
			Trace("  CombatOutfit   Size [" + CombatOutfit.length   + "]")
			Trace("  HomeOutfit     Size [" + HomeOutfit.length     + "]")
			Trace("  SwimOutfit     Size [" + SwimOutfit.length     + "]")
			Trace("  CityOutfit     Size [" + CityOutfit.length     + "]")
			Trace("  CampOutfit     Size [" + CampOutfit.length     + "]")
			Trace("  StandardOutfit Size [" + StandardOutfit.length + "]")
			Trace("  CurrentOutfit  Size [" + CurrentOutfit.length  + "]")
			Trace("  SnapshotOutfit Size [" + SnapShotOutfit.length + "]")	
		endIf
		return
    endif
	UnregisterForMenuOpenCloseEvent(asMenuName)	
endEvent

Event OnItemUnequipped(Form akBaseItem, ObjectReference akReference)
	if (akBaseItem as Armor && akBaseItem.HasKeyword(pArmorTypePower))	
		if ignorePAEvents
			Trace("PA IGNORED: OnItemUnEquipped [" + akBaseItem + "]")
			return
		endif
		int find = PAOutfit.Find(akBaseItem)
		if (find > -1)
			Trace("PAOutfit: Removing [" + find + "]")
			PAOutfit.Remove(find)
		endif
		return
	endif

	if (!managed)
		Trace("IGNORED: OnItemUnEquipped [" + akBaseItem + "]")
		return
	endIf
	
	Trace("MANAGED: OnItemUnEquipped [" + akBaseItem + "]")
	
	int pos = CurrentOutfit.Find(akBaseItem)
	if (pos > -1)
		Trace("Removing [" + pos + "] from CurrentOutfit")
		CurrentOutfit.Remove(pos)
	endif
	pos = myHead.Find(akBaseItem)
	if (pos > -1)
		Trace("Removing [" + pos + "] from myHead")
		myHead.Remove(pos)
	endif

EndEvent

Event OnItemEquipped(Form akBaseItem, ObjectReference akReference)
	if (akBaseItem as Armor && akBaseItem.HasKeyword(pArmorTypePower))
		if ignorePAEvents
			Trace("PA IGNORED: OnItemEquipped [" + akBaseItem + "]")
			return
		endif
		if (akBaseItem.HasKeyword(dn_PowerArmor_Helmet))
			Trace("TrackedPAHelmet = [" + akBaseItem + "]")
			pTrackedPAHelmet = akBaseItem as Armor
		else
			Trace("PAOutfit += [" + akBaseItem + "]")
			PAOutfit.Add(akBaseItem)
		endIf
		return
	endif
	
	if (!managed)
		Trace("IGNORED: OnItemEquipped [" + akBaseItem + "]")
		return
	endIf

	if (managed)
	
		if (akBaseItem As Spell || akBaseItem As Enchantment || akBaseItem As MagicEffect || akBaseItem As Potion)
			return
		endif
		if (akBaseItem As Hazard || akBaseItem As Shout || akBaseItem As Light)
			return
		endif
		if (akBaseItem == pTweakRefreshRing) || (akBaseItem == pTweakWeap)
			return
		endif		
	
		int formid = akBaseItem.GetFormID()
		if (akBaseItem.HasKeyword(ArmorBodyPartHead) || akBaseItem.HasKeyword(ArmorTypeHat) || formid == 0x00125891 || \
								formid == 0x0004A520 || formid == 0x001C4BE8 || formid == 0x000FD9AA || \
								formid == 0x001738AA || formid == 0x000E628A || formid == 0x000A81AF)
			myHead.Add(akBaseItem)
		endif

		CurrentOutfit.Add(akBaseItem)
	endif
EndEvent

; Game consists of cells. There is a concept of a location which is a group of cells with
; a common label. IE: SanctuaryHillsLocation. No all cells however belong to a location label.
; This event fires when you enter or leave a location region. Often, there is a small space between
; the regions that has no location. So for example, when following the road near RedRocket, this
; event will fire several times within a few seconds. Once for Sanct => None. Then None => RedRocket 
; then RedRocket => None. That is part of the reason for the flood protection.
Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	Trace("OnLocationChange() Called")
	; Flood Protection
	StartTimer(2.5,ONLOAD_FLOOD_PROTECT)
EndEvent

; OnLoad means the NPC's model is has loaded. Generally this fires when you
; load a save game or when you leave an NPC (get far enough away for their
; model to unload) and then re-approach. It also fires when we changing race... 
Event OnLoad()
	Trace("OnLoad() Called")
	if processLoadEvents
		; Flood Protection
		StartTimer(2.5,ONLOAD_FLOOD_PROTECT)	
	endif
endEvent

Function OnLoadHelper()

	Trace("OnLoadHelper() Called")
	; Can still slip through from location change.
	processLoadEvents = true  
	if !managed
		return
	endif
	
	Actor npc = self.GetActorRef()
	if npc.IsDead()
		Trace("Ignoring OnLoad. NPC is Dead")
		return
	endIf
	if npc.IsDisabled()
		Trace("Ignoring OnLoad. NPC is Disabled")
		return
	endIf
	if 1.0 == npc.GetValue(pTweakInPowerArmor) || npc.WornHasKeyword(pArmorTypePower)
		Trace("Ignoring OnLoad. NPC is wearing PowerArmor")
		return
	endif	
	
	; Scenarios Covered: 
	; - Fast Travel from Camp into a City
	; - Fast Travel from Camp to non-City.
	; - Fast Travel from Camp to enemy location

	; - Fast Travel from City to Camp
	; - Fast Travel/Transition from City to non-City.
	; - Fast Travel/Transition from City to enemy Location
	
	; - Fast Travel/Transition from non-City to City
	; - Fast Travel from non-City to Camp
	; - Fast Travel/Transition from non-City to enemy Location	
	
	; - PC approaches dismissed NPC ( TweakNoOutfit = Naked unless we dress them )
	; - PC approaches waiting NPC   ( Still teammate )

	; Scenarios Not Covered: 
	; - PC approaches Camp with followers
	; - PC enters combat
	
	if !npc.Is3DLoaded()	
		if !npc.IsInFaction(pCurrentCompanionFaction)
			; Scenario : NPC told to go home. OnLocationChange events will fire
			; as they traverse the commonwealth. 
			Trace("Ignoring Event. Non-CurrentCompanion 3D is not loaded")
			return
		endif
		
		int maxwait = 8
		while (maxwait > 0 && !npc.Is3DLoaded())
			Utility.wait(0.25)
			maxwait -= 1
		endwhile
		
		if (0 == maxwait)		
			Trace("Ignoring Event. Follower 3D didn't load in time")
			return		
		endif
	endif
	
	Trace("NPC 3D Loaded")
	
	if (!CombatOutfitEnabled && !CityOutfitEnabled && !CampOutfitEnabled && !StandardOutfitEnabled && !HomeOutfitEnabled)
		Trace("OnLoad. No Outfits Enabled. Restoring Last Known")
		RestoreTweakOutfit()
		return
	endif
	
	; Combat trumps everything 
	; Swimming trumps everything but combat
	; City trumps Camp
	; Camp is at the bottom
	
	int current = CurrentOutfitDesired
	if (OUTFIT_NONE == current || OUTFIT_STANDARD == current)
		if (CombatOutfitEnabled && combatInProgress)
			Trace("Combat Detected")
			CurrentOutfitDesired = OUTFIT_COMBAT
		elseif (SwimOutfitEnabled && playerIsSwimming)
			Trace("Swim Detected")
			CurrentOutfitDesired = OUTFIT_SWIM			
		elseif (HomeOutfitEnabled && ShouldUseHomeOutfit())
			Trace("Home Detected")
			CurrentOutfitDesired = OUTFIT_HOME			
		elseif (CampOutfitEnabled && npc.GetDistance(pShelterMapMarker.GetReference()) < 1000)
			Trace("Camp Detected")
			CurrentOutfitDesired = OUTFIT_CAMP
		elseif (CityOutfitEnabled && IsInCity())
			Trace("City Location Detected")
			CurrentOutfitDesired = OUTFIT_CITY
		elseif (StandardOutfitEnabled)
			Trace("Standard Detected")
			CurrentOutfitDesired = OUTFIT_STANDARD
		else
			CurrentOutfitDesired = OUTFIT_NONE
		endIf
	elseif (OUTFIT_COMBAT == current)
		if (!combatInProgress)
			if (SwimOutfitEnabled && playerIsSwimming)
				Trace("Swim Detected")
				CurrentOutfitDesired = OUTFIT_SWIM
			elseif (HomeOutfitEnabled && ShouldUseHomeOutfit())
				CurrentOutfitDesired = OUTFIT_HOME
			elseif (CampOutfitEnabled && npc.GetDistance(pShelterMapMarker.GetReference()) < 1000)
				CurrentOutfitDesired = OUTFIT_CAMP
			elseif (CityOutfitEnabled && IsInCity())
				CurrentOutfitDesired = OUTFIT_CITY
			elseif (StandardOutfitEnabled)
				CurrentOutfitDesired = OUTFIT_STANDARD			
			else
				CurrentOutfitDesired = OUTFIT_NONE
			endif
		endIf
	elseif (OUTFIT_SWIM == current)
		if (CombatOutfitEnabled && combatInProgress)
			Trace("Combat Detected")
			CurrentOutfitDesired = OUTFIT_COMBAT
		elseif (!playerIsSwimming)
			if (HomeOutfitEnabled && ShouldUseHomeOutfit())
				CurrentOutfitDesired = OUTFIT_HOME
			elseif (CampOutfitEnabled && npc.GetDistance(pShelterMapMarker.GetReference()) < 1000)
				Trace("Camp Detected")
				CurrentOutfitDesired = OUTFIT_CAMP
			elseif (CityOutfitEnabled && IsInCity())
				Trace("City Location Detected")
				CurrentOutfitDesired = OUTFIT_CITY
			elseif (StandardOutfitEnabled)
				Trace("Standard Detected")
				CurrentOutfitDesired = OUTFIT_STANDARD
			else
				CurrentOutfitDesired = OUTFIT_NONE
			endIf
		endif		
	elseif (OUTFIT_HOME == current)
		if (npc.IsInFaction(pCurrentCompanionFaction))
			if (CombatOutfitEnabled && combatInProgress)
				Trace("Combat Detected")
				CurrentOutfitDesired = OUTFIT_COMBAT
			elseif (SwimOutfitEnabled && playerIsSwimming)
				Trace("Swim Detected")
				CurrentOutfitDesired = OUTFIT_SWIM			
			elseif (CampOutfitEnabled && npc.GetDistance(pShelterMapMarker.GetReference()) < 1000)
				Trace("Camp Detected")
				CurrentOutfitDesired = OUTFIT_CAMP
			elseif (CityOutfitEnabled && IsInCity())
				Trace("City Location Detected")
				CurrentOutfitDesired = OUTFIT_CITY
			elseif (StandardOutfitEnabled)
				Trace("Standard Detected")
				CurrentOutfitDesired = OUTFIT_STANDARD
			else
				CurrentOutfitDesired = OUTFIT_NONE
			endIf
		endif		
	elseif (OUTFIT_CITY == current)
		if (CombatOutfitEnabled && combatInProgress)
			CurrentOutfitDesired = OUTFIT_COMBAT
		elseif (SwimOutfitEnabled && playerIsSwimming)
			CurrentOutfitDesired = OUTFIT_SWIM			
		elseif (HomeOutfitEnabled && ShouldUseHomeOutfit())
			CurrentOutfitDesired = OUTFIT_HOME
		elseif (CampOutfitEnabled && npc.GetDistance(pShelterMapMarker.GetReference()) < 1000)
			CurrentOutfitDesired = OUTFIT_CAMP
		elseif (!IsInCity())
			if (StandardOutfitEnabled)
				CurrentOutfitDesired = OUTFIT_STANDARD
			else
				CurrentOutfitDesired = OUTFIT_NONE
			endif			
		endif
	elseif (OUTFIT_CAMP == current)
		if (CombatOutfitEnabled && combatInProgress)
			CurrentOutfitDesired = OUTFIT_COMBAT
		elseif (SwimOutfitEnabled && playerIsSwimming)
			CurrentOutfitDesired = OUTFIT_SWIM						
		elseif (npc.GetDistance(pShelterMapMarker.GetReference()) > 999)
			if (HomeOutfitEnabled && ShouldUseHomeOutfit())
				CurrentOutfitDesired = OUTFIT_HOME
			elseif (CityOutfitEnabled && IsInCity())
				CurrentOutfitDesired = OUTFIT_CITY
			elseif (StandardOutfitEnabled)
				CurrentOutfitDesired = OUTFIT_STANDARD			
			else
				CurrentOutfitDesired = OUTFIT_NONE
			endif			
		endif
	endif
	
	; TODO : If they are not following player (IE: They are hanging out at Sanctuary), do we 
	;        still need to restore the outfit?
	
	Trace("CurrentOutfit [" + current + "] DesiredOutfit [" + CurrentOutfitDesired + "]")
	
	; if (OUTFIT_NONE == CurrentOutfitDesired)
	;     Trace("No Enabled Outfit applicable. Ignoring LOAD Event")
	;     return
	; endif
	
	if (current != CurrentOutfitDesired)
		RestoreTweakOutfit(CurrentOutfitDesired)
	endIf
	
endFunction

Function OnCombatBegin()
	combatInProgress=true
	StartTimer(20,COMBATEND_DELAYED)
	Trace("OnCombatBegin()")
	Actor npc=self.GetActorRef()

	if 1.0 == npc.GetValue(pTweakInPowerArmor) || npc.WornHasKeyword(pArmorTypePower)
		Trace("PowerArmor Detected")
		if (npc.IsInFaction(pTweakPAHelmetCombatToggleFaction))		
			TryToEquipPAHelmet()
		endif
		return
	endif

	if (CombatOutfitEnabled)
		CurrentOutfitDesired = OUTFIT_COMBAT
		RestoreTweakOutfit(OUTFIT_COMBAT)
	endif
	
endFunction


; Called by TweakFollowerScript: RelayCombatEnd
Function OnCombatEnd()
	Trace("OnCombatEnd()")

	; ignored:
	; handleCombatEnd()
	;
	; NOTES: This gets called quicker and more often than we want, 
	;        especially if the player stays out of the fight and
	;        lets the companions do the fighting. The reactiveness 
	;        is probably great for other scripts that really need
    ;        to know the moment combat is finished. But for outfit/helmet
	;        helmet purposes, a delay is more realistic. People are
	;        cautious in real life and wont switch outfits or take
	;        off their PA helmet the MOMENT combat is over.
	;
	;        We rely on a renewed timer that lets some time pass before
	;        combat is officially considered over.  
	
EndFunction

;------------------------------------
; Real Events
;------------------------------------

; See TweakSettings for master combat detection loop.
Event OnCombatStateChanged(Actor akTarget, int cState)
	Trace("OnCombatStateChanged [" + cState + "]")
	Actor npc = self.GetActorRef()
	if (1 != cState)
		Trace("cState is not 1, returning")
		return
	endIf	
	if (!npc.IsInFaction(pCurrentCompanionFaction))
		Trace("npc is not in CurrentCompanionFaction. Returning")
		return
	endif
	if (akTarget && akTarget.IsPlayerTeammate())
		Trace("akTarget is [" + akTarget + "] and is considered a Teammate. Returning.")
		return
	endIf
	
	if (!combatInProgress)
		Trace("Combat is not in progress. Calling OnCombatBegin()")
		OnCombatBegin()
	else
		Trace("Combat is already in progress. Ignoring Event")
	endif	

endEvent

Bool Function ShouldUseHomeOutfit()
	Actor npc = self.GetActorReference()
	if !npc.IsInFaction(pCurrentCompanionFaction)
		return true
	endif
	if (assignedHomeRef && npc.GetDistance(assignedHomeRef) < 1024)
		return true
	endif
	Location loc=npc.GetCurrentLocation()
	if (loc && loc == assignedHome)
		return true
	endif
	return false
EndFunction
	
Bool Function IsInCity()
	ObjectReference onpc=self.GetReference()
	Location loc=onpc.GetCurrentLocation()
	
	if (!loc)
		return False
	endif
	
	if (loc == pSanctuaryHillsLocation)
		return true
	endif
	if (loc == pCovenantLocation)
		return true
	endif
	if (loc == pBunkerHillLocation)
		return true
	endif
	
	if (loc.HasKeyword(pLocTypeWorkshop) && 1.0 == pTweakSettlementAsCity.GetValue())
		WorkshopScript WorkshopRef = (pWorkshopParent as WorkshopParentScript).GetWorkshopFromLocation(loc)
		if WorkshopRef && WorkshopRef.OwnedByPlayer
			return true
		endif
		return false
	endif
		
	if (loc == pGoodneighborLocation || loc == pDiamondCityLocation)
		return true
	endif
	if (loc == pPrydwenLocation || loc == pVault81Location)
		return true
	endif
		
	if (pGoodneighborLocation.IsChild(loc) || pDiamondCityLocation.IsChild(loc) || pBunkerHillLocation.IsChild(loc) || pPrydwenLocation.IsChild(loc))
		if (loc.HasKeyword(pLocTypeInn) || loc.HasKeyword(pLocTypeBar) || loc.HasKeyword(pLocTypeStore))
			return true
		endif
	endIf
		
	return false
	
endFunction

bool Function IsManaged()
	return managed
EndFunction

Function BumpArmorAI()

	; The game caches the NPC's appearanced on the graphics card. There is a bug where
	; the first time you call unequip item, it properly marks the cache as expired and the
	; model updates. But if you do it a second time without changing areas (seeing a loadthe
	; screen), the model isn't update the second time.  
	;
	; A way to fix the bug is to remove an equipped item. IE: Unequip has the bug, but Remove
    ; doesn't. Of coarse we dont want to remove real gear, so we make our own 	

	Actor npc = self.GetActorRef()
	if npc.IsPlayerTeammate()
		npc.EquipItem(pTweakRefreshRing)
		Utility.wait(0.32)
		npc.RemoveItem(pTweakRefreshRing)
	else
		npc.SetPlayerTeammate(true)
		npc.EquipItem(pTweakRefreshRing)
		Utility.wait(0.32)
		npc.RemoveItem(pTweakRefreshRing)
		Utility.wait(1.0)
		npc.SetPlayerTeammate(false)
	EndIf
	
endFunction

; Only call this in situations where you want them to equip their best weapon. 
; (Possibly ignoring the weapon that the player has assigned)
Function BumpWeaponAI()

	; The game caches the NPC's appearanced on the graphics card. There is a bug where
	; the first time you call unequip item, it properly marks the cache as expired and the
	; model updates. But if you do it a second time without changing areas (seeing a load
	; screen), the model isn't update the second time.  
	;
	; A way to fix the bug is to remove an equipped item. IE: Unequip has the bug, but Remove
    ; doesn't. Of coarse we dont want to remove real gear, so we make our own 	

	; You have to equip, unequip and remove the weapon to register the event. Note, if
	; the NPC is a teammate and the TeammateReadyWeapon_DO keyword is set on them, they 
	; will just turn around and equip another weapon (typically the most powerful they have)
	; So if the goal is to simply get them to unequip a weapon, make sure that keyword is
	; removed first...
	
	Actor npc = self.GetActorRef()
	if npc.IsPlayerTeammate()
		npc.EquipItem(pTweakWeap)
		Utility.wait(0.32) ; at least 0.25 
		npc.UnequipItem(pTweakWeap)
		Utility.wait(0.32) ; at least 0.25
		npc.RemoveItem(pTweakWeap)
	else
		npc.SetPlayerTeammate(true)
		npc.EquipItem(pTweakWeap)
		Utility.wait(0.32) ; at least 0.25 
		npc.UnequipItem(pTweakWeap)
		Utility.wait(0.32) ; at least 0.25
		npc.RemoveItem(pTweakWeap)
		Utility.wait(1.0)
		npc.SetPlayerTeammate(false)
	EndIf
		
endFunction

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

Float[] Function TraceCircleOffsets(ObjectReference n, Float radius = 500.0, Float angleOffset = 0.0)
    float azimuth = ConvertToSinCosCompatibleAngle(n.GetAngleZ(), angleOffset)	
    Float[] r = new Float[3]
    r[0] =  radius * Math.cos(azimuth) ; X Offset
    r[1] =  radius * Math.sin(azimuth) ; Y Offset
    r[2] =  0 ; Z Offset
    return r
EndFunction

Float Function ConvertToSinCosCompatibleAngle(Float original, Float angleOffset = 0.0)

	; See TweakFollowerScript for explanation	
	return Enforce360Bounds(450 - original + angleOffset)
	
EndFunction

Function RemoveDefaultWeapon()

	Actor npc = self.GetActorRef()
	ActorBase base  = npc.GetActorBase()
	int ActorBaseID = base.GetFormID()
	Weapon CompPiper10mm = Game.GetForm(0x0005DF2D) as Weapon
	
	if (base == Game.GetForm(0x00079249) as ActorBase)     ; 1 ---=== Cait ===---	
		Trace("Cait Detected.")
		npc.RemoveItem(Game.GetForm(0x0005DF30) as Weapon)
	; elseif (base == Game.GetForm(0x000179FF) as ActorBase) ; 2 ---=== Codsworth ===---	
	;	Trace("Codsworth Detected.")
	elseif (base == Game.GetForm(0x00027686) as ActorBase) ; 3 ---=== Curie ===---
		Trace("Curie Detected.")
		Quest COMCurieQuest = Game.GetForm(0x0016454E) as Quest
		If COMCurieQuest && COMCurieQuest.GetStageDone(300)
			npc.RemoveItem(Game.GetForm(0x0022CC13) as Weapon,999)			
		endif
	elseif (base == Game.GetForm(0x00027683) as ActorBase) ; 4 ---=== Danse ===---
		Trace("Danse Detected.")
		npc.RemoveItem(Game.GetForm(0x0005BBA6) as Weapon)
	elseif (base == Game.GetForm(0x00045AC9) as ActorBase) ; 5 ---=== Deacon ===---
		Trace("Deacon Detected.")
		npc.RemoveItem(Game.GetForm(0x00215CE3) as Weapon)
	; elseif (base == Game.GetForm(0x0001D15C) as ActorBase) ; 6 ---=== Dogmeat ===---	
	; 	Trace("Dogmeat Detected.")
	elseif (base == Game.GetForm(0x00022613) as ActorBase) ; 7 ---=== Hancock ===---	
		Trace("Hancock Detected.")
		npc.RemoveItem(Game.GetForm(0x00062AA4) as Weapon)
		npc.RemoveItem(Game.GetForm(0x00062AA3) as Weapon)
	elseif (base == Game.GetForm(0x0002740E) as ActorBase) ; 8 ---=== MacCready ===---		
		Trace("MacCready Detected.")
		npc.RemoveItem(Game.GetForm(0x0005BBA4) as Weapon)
	elseif (base == Game.GetForm(0x00002F24) as ActorBase) ; 9 ---=== Nick Valentine ===---	
		Trace("Nick Detected.")
		npc.RemoveItem(Game.GetForm(0x0005BBA7) as Weapon)
	elseif (base == Game.GetForm(0x00002F1E) as ActorBase) ; 10 ---=== Piper ===---	
		Trace("Piper Detected.")
		npc.RemoveItem(CompPiper10mm)
	elseif (base == Game.GetForm(0x00019FD9) as ActorBase) ; 11 ---=== Preston ===---	
		Trace("Preston Detected.")	
		npc.RemoveItem(Game.GetForm(0x00062AA6) as Weapon)
	elseif (base == Game.GetForm(0x00027682) as ActorBase) ; 12 ---=== Strong ===---
		Trace("Strong Detected.")
		npc.RemoveItem(Game.GetForm(0x0005DF2E) as Weapon)
	elseif (base == Game.GetForm(0x000BBEE6) as ActorBase) ; 13 ---=== X6-88 ===---		
		Trace("X6-88 Detected.")
		npc.RemoveItem(Game.GetForm(0x00215CE4) as Weapon)
	elseif (base == Game.GetFormFromFile(0x01048098,"AmazingFollowerTweaks.esp") as ActorBase) ; ---=== Nate ===---		
		Trace("Nate Detected")	
		npc.RemoveItem(CompPiper10mm)
	elseif (base == Game.GetFormFromFile(0x01043410,"AmazingFollowerTweaks.esp") as ActorBase) ; ---=== Nora ===---		
		Trace("Nora Detected")
		npc.RemoveItem(CompPiper10mm)
	else	
		if (ActorBaseID > 0x00ffffff)
		
			; Eliminate first two digits...
			; NOTE: This may fail for users with lots of mods. Modulous
			; may be unreliable with Larger ints (greater than 0x80000000)
			int ActorBaseMask			
			if ActorBaseID > 0x80000000			
				ActorBaseMask = (ActorBaseID - 0x80000000) % (0x01000000)
			else
				ActorBaseMask = ActorBaseID % (0x01000000)
			endif
			
			; Now compare MASK
			; if 0x0000FD5A == ActorBaseMask ; Ada
			; 	Trace("Ada Detected")
			if 0x00006E5B == ActorBaseMask ; Longfellow			
				Trace("LongFellow Detected")
				Weapon DLC03_CompLeverGun = Game.GetFormFromFile(0x0104D39B,"DLCCoast.esm") as Weapon
				if DLC03_CompLeverGun
					npc.RemoveItem(DLC03_CompLeverGun)
				endif				
			elseif 0x0000881D == ActorBaseMask ; Porter Gage
				Trace("Porter Gage Detected")
				Weapon DLC04COMGageHandMadeGun = Game.GetFormFromFile(0x010496EA,"DLCNukaWorld.esm") as Weapon
				if DLC04COMGageHandMadeGun
					npc.RemoveItem(DLC04COMGageHandMadeGun)
				endif
			endif
		endif								
	endif
EndFunction

Function RestoreDefaultWeapon()

	Actor npc = self.GetActorRef()
	ActorBase base  = npc.GetActorBase()
	int ActorBaseID = base.GetFormID()
	Weapon CompPiper10mm = Game.GetForm(0x0005DF2D) as Weapon
	
	if (base == Game.GetForm(0x00079249) as ActorBase)     ; 1 ---=== Cait ===---	
		Trace("Cait Detected.")
		npc.AddItem(Game.GetForm(0x0005DF30) as Weapon)
	; elseif (base == Game.GetForm(0x000179FF) as ActorBase) ; 2 ---=== Codsworth ===---	
	;	Trace("Codsworth Detected.")
	elseif (base == Game.GetForm(0x00027686) as ActorBase) ; 3 ---=== Curie ===---
		Trace("Curie Detected.")
		Quest COMCurieQuest = Game.GetForm(0x0016454E) as Quest
		If COMCurieQuest && COMCurieQuest.GetStageDone(300)
			npc.AddItem(Game.GetForm(0x0022CC13) as Weapon)			
		endif		
	elseif (base == Game.GetForm(0x00027683) as ActorBase) ; 4 ---=== Danse ===---
		Trace("Danse Detected.")
		npc.AddItem(Game.GetForm(0x0005BBA6) as Weapon)
	elseif (base == Game.GetForm(0x00045AC9) as ActorBase) ; 5 ---=== Deacon ===---
		Trace("Deacon Detected.")
		npc.AddItem(Game.GetForm(0x00215CE3) as Weapon)
	; elseif (base == Game.GetForm(0x0001D15C) as ActorBase) ; 6 ---=== Dogmeat ===---	
	; 	Trace("Dogmeat Detected.")
	elseif (base == Game.GetForm(0x00022613) as ActorBase) ; 7 ---=== Hancock ===---	
		Trace("Hancock Detected.")
		npc.AddItem(Game.GetForm(0x00062AA4) as Weapon)
		npc.AddItem(Game.GetForm(0x00062AA3) as Weapon)
	elseif (base == Game.GetForm(0x0002740E) as ActorBase) ; 8 ---=== MacCready ===---		
		Trace("MacCready Detected.")
		npc.AddItem(Game.GetForm(0x0005BBA4) as Weapon)
	elseif (base == Game.GetForm(0x00002F24) as ActorBase) ; 9 ---=== Nick Valentine ===---	
		Trace("Nick Detected.")
		npc.AddItem(Game.GetForm(0x0005BBA7) as Weapon)
	elseif (base == Game.GetForm(0x00002F1E) as ActorBase) ; 10 ---=== Piper ===---	
		Trace("Piper Detected.")
		npc.AddItem(CompPiper10mm)
	elseif (base == Game.GetForm(0x00019FD9) as ActorBase) ; 11 ---=== Preston ===---	
		Trace("Preston Detected.")	
		npc.AddItem(Game.GetForm(0x00062AA6) as Weapon)
	elseif (base == Game.GetForm(0x00027682) as ActorBase) ; 12 ---=== Strong ===---
		Trace("Strong Detected.")
		npc.AddItem(Game.GetForm(0x0005DF2E) as Weapon)
	elseif (base == Game.GetForm(0x000BBEE6) as ActorBase) ; 13 ---=== X6-88 ===---		
		Trace("X6-88 Detected.")
		npc.AddItem(Game.GetForm(0x00215CE4) as Weapon)
	elseif (base == Game.GetFormFromFile(0x01048098,"AmazingFollowerTweaks.esp") as ActorBase) ; ---=== Nate ===---		
		Trace("Nate Detected")	
		npc.AddItem(CompPiper10mm)
	elseif (base == Game.GetFormFromFile(0x01043410,"AmazingFollowerTweaks.esp") as ActorBase) ; ---=== Nora ===---		
		Trace("Nora Detected")
		npc.AddItem(CompPiper10mm)
	else	
		if (ActorBaseID > 0x00ffffff)
		
			; Eliminate first two digits...
			; NOTE: This may fail for users with lots of mods. Modulous
			; may be unreliable with Larger ints (greater than 0x80000000)
			int ActorBaseMask			
			if ActorBaseID > 0x80000000			
				ActorBaseMask = (ActorBaseID - 0x80000000) % (0x01000000)
			else
				ActorBaseMask = ActorBaseID % (0x01000000)
			endif
			
			; Now compare MASK
			; if 0x0000FD5A == ActorBaseMask ; Ada
			; 	Trace("Ada Detected")
			if 0x00006E5B == ActorBaseMask ; Longfellow			
				Trace("LongFellow Detected")
				Weapon DLC03_CompLeverGun = Game.GetFormFromFile(0x0104D39B,"DLCCoast.esm") as Weapon
				if DLC03_CompLeverGun
					npc.AddItem(DLC03_CompLeverGun)
				endif				
			elseif 0x0000881D == ActorBaseMask ; Porter Gage
				Trace("Porter Gage Detected")
				Weapon DLC04COMGageHandMadeGun = Game.GetFormFromFile(0x010496EA,"DLCNukaWorld.esm") as Weapon
				if DLC04COMGageHandMadeGun
					npc.AddItem(DLC04COMGageHandMadeGun)
				endif
			endif
		endif								
	endif
EndFunction


; SQUARE ROOT is expensive. Most people dont actually want to KNOW the distance. They
; simply want equality or range checks, which you can do without the square root. No
; square root means you can also early bail on otherwise expensive calls.
Bool Function DistanceWithin(ObjectReference a, ObjectReference b, float radius)
	radius = radius * radius
	float factor = a.GetPositionX() - b.GetPositionX()
	float total  = (factor * factor)
	; Early bail if we can. 
	if (total > radius)
		return false
	endif
	factor = a.GetPositionY() - b.GetPositionY()
	total += (factor * factor)
	; Early bail if we can. 
	if (total > radius)
		return false
	endif
	factor = a.GetPositionZ() - b.GetPositionZ()
	total += (factor * factor)
	return (radius > total)
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

;--------------------------------------
; DEPRECATED
;--------------------------------------
; MOVED TO Quest TweakDedupeMaster : PlayerDedupe(Actor)	
Function TakePlayerDuplicates()
	Trace("TakePlayerDuplicates()")
	; DEPRECATED. SEE Quest TweakDedupeMaster : PlayerDedupe(Actor)	
EndFunction

Event ObjectReference.OnItemAdded(ObjectReference akDupCon, Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	Trace("ObjectReference.OnItemAdded")
	; ORIGINAL USE DEPRECATED. SEE Quest TweakDedupeMaster : PlayerDedupe(Actor)	
	UnRegisterForRemoteEvent(akDupCon, "OnItemAdded")
EndEvent

Event Actor.OnItemUnEquipped(Actor pc, Form akBaseObject, ObjectReference akReference)
	Trace("Actor.OnItemUnEquipped")
	; ORIGINAL USE DEPRECATED. SEE Quest TweakDedupeMaster : PlayerDedupe(Actor)	
	UnRegisterForRemoteEvent(pc, "OnItemUnEquipped")
EndEvent

Function TakePlayerDuplicatesDone()
	Trace("TakePlayerDuplicates()")
	; DEPRECATED. SEE Quest TweakDedupeMaster : PlayerDedupe(Actor)	
EndFunction
