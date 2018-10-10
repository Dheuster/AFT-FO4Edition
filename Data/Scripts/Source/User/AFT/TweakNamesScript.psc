Scriptname AFT:TweakNamesScript extends Quest

Faction Property  pTweakNamesFaction Auto Const
; FormList Property pTweakCustomNames Auto Const
String[] Property IndexToString Auto

ActorValue Property CraftingAbilityMedicine	Auto Const

Group Standard_Companions
	ActorBase Property CompanionCait			Auto Const ; Cell : CombatZone01 Ref : CaitRef
	ActorBase Property Codsworth				Auto Const ; Cell : SanctuaryExt02(-20,22) Ref : Codsworth1Ref
	ActorBase Property CompanionCurie			Auto Const ; Cell : Vault81Secret Ref : CurieRef
	ActorBase Property BoSPaladinDanse			Auto Const ; Cell : CambridgePDExt02(-8,02) Ref : BoSPaladineDanseRef
	ActorBase Property CompanionDeacon			Auto Const ; Cell : RailroadHQ01 Ref : DeaconRef
	ActorBase Property Dogmeat					Auto Const ; Cell : RedRocketExt(-17,19) Ref : DogmeatRef
	ActorBase Property Hancock					Auto Const ; Cell : GoodneighborOldStateHouse Ref : HancockREF
	ActorBase Property CompanionMacCready		Auto Const ; Cell : GoodneighborTheThirdRail Ref : CompMacCreadyRef
	ActorBase Property CompanionPiper			Auto Const ; Cell : DmndPublick01 Ref : PiperRef
	ActorBase Property PrestonGarvey			Auto Const ; Cell : ConcordMuseum01 Ref : PrestonGarveyRef
	ActorBase Property CompanionStrong			Auto Const ; Cell : BackBayFence01 (00,-7) Ref : CompanionStrongRef
	ActorBase Property CompanionNickValentine	Auto Const ; Cell : DmndValentines01 Ref : NickValentineREF
	ActorBase Property CompanionX688			Auto Const ; Cell : Wilderness (19, 06) : CompanionX6-88Ref
	ActorBase Property TweakCompanionNora		Auto Const
	ActorBase Property TweakCompanionNate		Auto Const
EndGroup

; I dont like the fact that this script knows about TweakFollowerQuest, but there is an 
; issue that must be addressed. We dont want to hand out an already used name as it could
; lead to big issues. But users can re-assign names and even kick-out NPCs from AFT management. 
; So my option was to either create a convulted and unreliable event system to keep this quest 
; in sync or simply look at the ground truth on the main quest. Looking at the ground truth
; means being "aware" of the big picture: The fact that this is used by TweakFollower
; to manage exactly 32 NPCs, a number that no-so conincedentally fits into an int based bitmask.  

Quest Property pTweakFollower Auto Const

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakNamesScript"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

int NoraBASEID = 0
int NateBASEID = 0
Event OnInit()
	Trace("OnInit")
	if TweakCompanionNora
		NoraBASEID = TweakCompanionNora.GetFormID()
	endif
	if TweakCompanionNate
		NateBASEID = TweakCompanionNate.GetFormID()
	endif
	initIndexToString()
	Trace("OnInit Finished")	
EndEvent

Function OnGameLoaded(bool firstTime=False)
	Trace("OnGameLoaded() Called")
	; Do nothing for now...
	Trace("OnGameLoaded() Finished")
EndFunction

Function InitIndexToString()
	IndexToString = new String[111]
	IndexToString[0] = "Unknown"
	IndexToString[1] = "Cait"
	IndexToString[2] = "Codsworth"
	IndexToString[3] = "Curie"
	IndexToString[4] = "Danse"
	IndexToString[5] = "Deacon"
	IndexToString[6] = "Dogmeat"
	IndexToString[7] = "John Hancock"
	IndexToString[8] = "MacCready"
	IndexToString[9] = "Nick Valentine"
	IndexToString[10] = "Piper"
	IndexToString[11] = "Preston"
	IndexToString[12] = "Strong"
	IndexToString[13] = "X6-88"
	IndexToString[14] = "Ada"
	IndexToString[15] = "Longfellow"
	IndexToString[16] = "Porter Gage"
	IndexToString[17] = "Nate"
	IndexToString[18] = "Nora"
	IndexToString[19] = "Follower 1"
	IndexToString[20] = "Follower 2"
	IndexToString[21] = "Follower 3"
	IndexToString[22] = "Follower 4"
	IndexToString[23] = "Follower 5"
	IndexToString[24] = "Follower 6"
	IndexToString[25] = "Follower 7"
	IndexToString[26] = "Follower 8"
	IndexToString[27] = "Follower 9"
	IndexToString[28] = "Follower 10"
	IndexToString[29] = "Follower 11"
	IndexToString[30] = "Follower 12"
	IndexToString[31] = "Follower 13"
	IndexToString[32] = "Follower 14"
	IndexToString[33] = "Follower 15"
	IndexToString[34] = "Follower 16"
	IndexToString[35] = "Follower 17"
	IndexToString[36] = "Follower 18"
	IndexToString[37] = "Follower 19"
	IndexToString[38] = "Follower 20"
	IndexToString[39] = "Follower 21"
	IndexToString[40] = "Follower 22"
	IndexToString[41] = "Follower 23"
	IndexToString[42] = "Follower 24"
	IndexToString[43] = "Follower 25"
	IndexToString[44] = "Follower 26"
	IndexToString[45] = "Follower 27"
	IndexToString[46] = "Follower 28"
	IndexToString[47] = "Follower 29"
	IndexToString[48] = "Follower 30"
	IndexToString[49] = "Follower 31"
	IndexToString[50] = "Follower 32"
	IndexToString[51] = "Addison"
	IndexToString[52] = "Alex"
	IndexToString[53] = "Andy"
	IndexToString[54] = "Ash"
	IndexToString[55] = "Assface"
	IndexToString[56] = "Bacon"
	IndexToString[57] = "Bash"
	IndexToString[58] = "Blaze"
	IndexToString[59] = "Bobby"
	IndexToString[60] = "Boom"
	IndexToString[61] = "Brick"
	IndexToString[62] = "Bull"
	IndexToString[63] = "Burke"
	IndexToString[64] = "Butch"
	IndexToString[65] = "Caden"
	IndexToString[66] = "Charlie"
	IndexToString[67] = "Chase"
	IndexToString[68] = "Chopper"
	IndexToString[69] = "Claw"
	IndexToString[70] = "Clunk"
	IndexToString[71] = "Corrie"
	IndexToString[72] = "Dag"
	IndexToString[73] = "Deth"
	IndexToString[74] = "Finn"
	IndexToString[75] = "Flash"
	IndexToString[76] = "Flynn"
	IndexToString[77] = "Fury"
	IndexToString[78] = "Hammer"
	IndexToString[79] = "Hans"
	IndexToString[80] = "Hardi"
	IndexToString[81] = "Harper"
	IndexToString[82] = "Hook"
	IndexToString[83] = "Indiana"
	IndexToString[84] = "Jack"
	IndexToString[85] = "Jessie"
	IndexToString[86] = "Jet"
	IndexToString[87] = "Jordyn"
	IndexToString[88] = "Kaelyne"
	IndexToString[89] = "Kelly"
	IndexToString[90] = "Max"
	IndexToString[91] = "Nate"
	IndexToString[92] = "Peyton"
	IndexToString[93] = "Pyscho"
	IndexToString[94] = "Qin"
	IndexToString[95] = "Ray"
	IndexToString[96] = "Reagan"
	IndexToString[97] = "Red"
	IndexToString[98] = "Rex"
	IndexToString[99] = "Riley"
	IndexToString[100] = "Rock"
	IndexToString[101] = "Rook"
	IndexToString[102] = "Sam"
	IndexToString[103] = "Sidney"
	IndexToString[104] = "Skyler"
	IndexToString[105] = "Spike"
	IndexToString[106] = "Taylor"
	IndexToString[107] = "Timmy"
	IndexToString[108] = "Tracy"
	IndexToString[109] = "Vash"
	IndexToString[110] = "Watson"
EndFunction

; TODO : Rename to getNameIndex, scrap the parameter
int Function GetNameIndex(Actor npc, Bool assign = false)

	ActorBase base = npc.GetActorBase()
	Trace("GetNameIndex ActorBase: [" + base + "]")
	
	int currentid = npc.GetFactionRank(pTweakNamesFaction)
	if (currentid > 0)
		Trace("NPC already has assigned name")	
		return currentid
	endif
		
	int targetid = 0
	int ActorBaseID = base.GetFormID()
	
	; Do we know this person?
	if (base == CompanionCait)              ; Cait: 0x00079249
		targetid = 1
	elseif (base == Codsworth)              ; Codsworth: 0x000179FF
		targetid = 2
	elseif (base == CompanionCurie)         ; Curie: 0x00027686
		targetid = 3
	elseif (base == BoSPaladinDanse)        ; Danse: 0x00027683
		targetid = 4
	elseif (base == CompanionDeacon)        ; Deacon: 0x00045AC9
		targetid = 5
	elseif (base == Dogmeat)                ; Dogmeat: 0x0001D15C
		targetid = 6
	elseif (base == Hancock)                ; Hancock: 0x00022613
		targetid = 7
	elseif (base == CompanionMacCready)     ; MacCready: 0x0002740E
		targetid = 8
	elseif (base == CompanionNickValentine) ; Valentine: 0x00002F24
		targetid = 9
	elseif (base == CompanionPiper)         ; Piper: 0x00002F1E
		targetid = 10
	elseif (base == PrestonGarvey)          ; Preston: 0x00019FD9
		targetid = 11
	elseif (base == CompanionStrong)        ; Strong: 0x00027682
		targetid = 12
	elseif (base == CompanionX688)          ; X688: 0x000BBEE6
		targetid = 13
	elseif (base == TweakCompanionNora)
		targetid = 18
	elseif (base == TweakCompanionNate)
		targetid = 17
	elseif (ActorBaseID > 0x00ffffff)
	
		; Modulous fails if value over 0x80000000, so 
		; we subtract 0x80000000 if the value is larger.
		
		if ActorBaseID > 0x80000000
			ActorBaseID -= 0x80000000
		endif
	
		; Eliminate first two digits...
		; NOTE: This may not work if the value is greater
		;       than 0x20000000. (If the user has more than 32 mods installed.)
		int ActorBaseMask = ActorBaseID % (0x01000000) 
		
		; Now compare MASK
		if     0x0000FD5A == ActorBaseMask ; Ada
			targetid = 14
		elseif 0x00006E5B == ActorBaseMask ; Longfellow
			targetid = 15
		elseif 0x0000881D == ActorBaseMask ; Porter Gage
			targetid = 16
		endif	
	endif
	
	if (0 != targetid)
		Trace("Standard Companion [" + targetid + "] identified.")
		npc.SetFactionRank(pTweakNamesFaction, targetid)
		return targetid
	endif
		
	float reInstallValue = npc.GetValue(CraftingAbilityMedicine)
	
	if reInstallValue > 18.0 && reInstallValue < 111.0
		npc.SetValue(CraftingAbilityMedicine, 0.0)
		if (reInstallValue > 50.0)
			AssignName(npc, reInstallValue as int)
			return reInstallValue as int
		else
			npc.SetFactionRank(pTweakNamesFaction, reInstallValue as int)
			return reInstallValue as int			
		endif
	endif
	
	Trace("Unrecognized NPC")
	
	if (assign)
		Trace("Assign is True")
		TweakFollowerScript pTweakFollowerScript = (pTweakFollower as TweakFollowerScript)
		if pTweakFollowerScript	
					
			bool[] mask = pTweakFollowerScript.GetUsedGenericNameSlots()
			int masklen = mask.Length
			Trace("GetUsedGenericNameSlots returned [" + masklen +"] booleans")			
			int i = 0
			while (i < masklen && 0 == targetid)
				if !mask[i]
					targetid = i + 19
				endif
				i += 1
			endwhile
			
		else
			Trace("Unable to cast TweakFollower to TweakFollowerScript")		
		endif		
	endif
	
	if (0 != targetid)
		Trace("Assigning Companion Name ID [" + targetid + "]")		
		npc.SetFactionRank(pTweakNamesFaction, targetid)
		return targetid
	else
		Trace("No available Names? (That shouldn't be possible)")
	endif
	return 0	
endFunction

Function ResetName(Actor npc, bool bPermanent = false)

	Trace("ResetName NPC [" + npc + "]")
	if (!npc)
		Trace("NPC Invalid. Try again...")
		return
	endif

	int id = npc.GetFactionRank(pTweakNamesFaction)
	if (id > 50)
	
		ReferenceAlias nameOverride = ((self As Quest).GetAlias(id) As ReferenceAlias)
		if nameOverride
			nameOverride.Clear()
		endif
		; (npc as ObjectReference).SetActivateTextOverride(None)
		
		npc.SetFactionRank(pTweakNamesFaction, 0)
		if !bPermanent
			GetNameIndex(npc, true)
		endif
	endif
	
EndFunction

; Do : Play with Clears Name when Removed. See if we can get secondary NPC name assignement working.
Bool Function AssignName(Actor npc, int id)
	Trace("AssignName NPC [" + npc + "] => [" + IdToString(id) + "]")
	if (!npc)
		Trace("NPC Invalid. Try again...")
		return false
	endif
	
	int oldid = npc.GetFactionRank(pTweakNamesFaction)
	if (id > 50)

		; TODO : Confirm slot is available with TweakFollowerScript? If the selection 
		;        screen disables toggles of NPCs with the name, seems like this 
		;        shouldn't be possible...

		npc.SetFactionRank(pTweakNamesFaction, id)
		
		; NOTE: "Clear Name when Removed" is key to making this work. If an
		; actor is using the default name provided by the ActorBase, you can 
		; override it by putting a MESSAGE in the DisplayName field. If the 
		; alias that overrides it checks the Clear Name flag, the name is
		; reset when the alias releases the NPC. Thus an NPC can be renamed
		; multiple times as long as all names have that flag.
		; 
		; However there are two ways this can break. One is if an alias has 
		; a display name and the "Clear Name when Removed" isn't checked. So
		; if you run across an NPC whos name has already been changed by a 
		; quest, you may not be able to change it again.  This is the case with 
		; Dogmeat as his name is "Dog" when you approach him, but then
		; the DogmeatQuest changes his name after you talk to him (and decide to
		; to call him "Dogmeat"). Ironically, there is only 1 line of audio with 
		; that name.
		;
		; The other scenario this wont work is with a leveled Actor. When an Actor(base) 
		; points at a template and inherits Traits, the name and appearance come from the
		; leveling system and are constanly re-enforced. This is why you can't change
		; Curie's name or appearance. They do in fact change, but less than a second
		; later, they are changed back by the game engine. We could make a bunch of
		; Curie "Clones" with different names and swap them in (like we do with her
		; appearance), but with 10 body options and 60 names, it would take 600+ actor 
		; definitions to cover all cases offered by this mod and I am not up to it.
		
		if (6 == oldid) ; DogMeat needs special attention...
			Quest pDogMeatQuest = Game.GetForm(0x0006DFAF) as Quest
			if pDogMeatQuest
				ReferenceAlias pNameAlias = (pDogMeatQuest.GetAlias(11) as ReferenceAlias)
				if pNameAlias
					if pNameAlias.GetActorRef()
						pNameAlias.Clear()
						; Change this global to prevent the line where the player says the dogs name...
						GlobalVariable PlayerKnowsDogmeatName = Game.GetForm(0x0004AF3D) as GlobalVariable
						if (PlayerKnowsDogmeatName)
							PlayerKnowsDogmeatName.SetValue(0)
						endif
					else
						Trace("DogNameAlias has already been cleared")
					endif
				else
					Trace("Unable to Cast DogNameAlias (alias 11) to ReferenceAlias")
				endif
			else
				Trace("Unable to Cast DogMeat Quest")
			endif
		endif
		
		; Attempt to Force Name onto NPC. Note : Order is important as the aliases are
		; not marked for reuse. So we must remove before we assign or the assign will
		; fail.
		
		ReferenceAlias nameOverride
		if (oldid > 50)
			nameOverride = ((self As Quest).GetAlias(oldid) As ReferenceAlias)
			if nameOverride
				nameOverride.Clear()
			else
				Trace("Unable to retrieve OLD ReferenceAlias for Name Override Assignment")
			endif
		endif
		nameOverride = ((self As Quest).GetAlias(id) As ReferenceAlias)
		if nameOverride		
			nameOverride.ForceRefTo(npc)
		else
			Trace("Unable to retrieve ReferenceAlias for Name Override Assignment")
		endif

		; Attempt to Override small text next to "E"
		; Message hover_override = (pTweakCustomNames.GetAt((id - 51)) As Message)
		; if (hover_override)
		;	(npc as ObjectReference).SetActivateTextOverride(hover_override)
		; endif
	endif
EndFunction

String Function IdToString(int id)
	return IndexToString[id]
endFunction

