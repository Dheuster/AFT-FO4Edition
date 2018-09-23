Scriptname AFT:TweakCOMSpouseScript extends Quest

Int Property InfatuationPlayerResponse Auto Conditional
{1= Don't love you 2= Have to think about it 3= Still love my spouse}

; Rescue Scene....
Location		Property	Vault111Cryo				Auto Const;
Location		Property	SanctuaryHillsLocation		Auto Const;
Location		Property	SanctuaryHillsPlayerHouseLocation	Auto Const;

ObjectReference  Property MQPlayerSpousePodREF			Auto Const ; CELL : Vault111Cryo
ObjectReference  Property MQ102SpouseCorpseFemaleREF	Auto Const ; CELL : Vault111Cryo
ObjectReference  Property MQ102SpouseCorpseMaleREF		Auto Const ; CELL : Vault111Cryo
ObjectReference  Property AO_Comment_Unique_256_024		Auto Const ; CELL : Vault111Cryo
ReferenceAlias	 Property pCurie						Auto Const
ReferenceAlias	 Property pCodsworth					Auto Const
ReferenceAlias	 Property FollowPlayer					Auto Const
Faction			 Property pCurrentCompanionFaction		Auto Const
Quest			 Property MQ201							Auto Const
Quest    		 Property MQ102             			Auto Const
Quest			 Property MS19							Auto Const
Quest			 Property Min02							Auto Const
Quest			 Property MQ206							Auto Const
Quest			 Property MQ207							Auto Const
Armor			 Property pArmor_SpouseWeddingRing		Auto Const
MusicType		Property  TweakMUSMemory				Auto Const
SoundCategorySnapShot Property TweakCSRescue Auto Const
Holotape		Property  TweakCOM_HolotapeCurie        Auto Const
Holotape		Property  TweakCOM_HolotapeCurieM       Auto Const
ActorBase		Property  MQ102CryoCorpse01				Auto Const

Scene			Property TweakCOMSpouseTooLateBootstrap			Auto Const
Scene			Property TweakCOMSpouseRescueBootstrap			Auto Const
Scene			Property TweakCOMSpouseRescueHelperBootstrap	Auto Const
Scene			Property TweakCOMSpouseRescueExplainBootstrap	Auto Const
Scene			Property TweakCOMSpouseExitVault				Auto Const
Scene			Property TweakCOMSpouseCurieComment				Auto Const

Keyword			Property TweakPoseTarget						Auto Const
Keyword			Property TweakActorTypeManaged					Auto Const

Sound			Property DRScFirstAidOpen						Auto Const
Sound			Property DRScRaceCreatureOpen					Auto Const
Sound			Property OBJSynthProductionSequence4ArmOrb		Auto Const
Sound			Property DRScRaceCreatureClose					Auto Const
Sound			Property UIHealthHeartbeatALP					Auto Const
EffectShader    Property CryoCorpseFXS							Auto Const
GlobalVariable	Property TweakAllowLoiter						Auto Const
GlobalVariable	Property TweakNoIdle							Auto Const
GlobalVariable  Property GameHour								Auto Const
GlobalVariable  Property TweakSpouseGreetAllowed				Auto Const

; Curie Comment Holotape Handoff
ObjectReference Property QuickstartRespecTrigger				Auto Const
ObjectReference Property TestRespecMarker						Auto Const
Message			Property TweakCurieHandoff						Auto Const

; Subtitle Override
ReferenceAlias	Property pSubtitleOverride						Auto Const
ActorBase	    Property TweakSubtitleOverride					Auto Const

; Actual Spouse assignment
ReferenceAlias	 Property pSpouse								Auto Const
ActorBase		 Property pTweakCompanionNate			Auto Const
ActorBase		 Property pTweakCompanionNora			Auto Const
Faction			 Property pHasBeenCompanionFaction		Auto Const
ActorValue		 Property pCA_Affinity					Auto Const
ActorValue		 Property pCA_WantsToTalk				Auto Const
ActorValue		 Property pCA_AffinitySceneToPlay		Auto Const
Keyword			 Property CA_CustomEvent_PrestonLoves	Auto Const

bool 			 Property SanctuaryCommentMade 			Auto
bool 			 Property HouseCommentMade 			    Auto

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakCOMSpouseScript"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Bool SpeakLineNearPod = true
InputEnableLayer ILayer

Event OnQuestInit()

	Trace("TweakCOMSpouse Initialized!")
	Actor player = Game.getPlayer()
	
	; 1.20 : Recover Spouse on re-install
	ActorValue CISROMANTIC = Game.GetForm(0x002486EC) as ActorValue ; CCE_TestCompanionChatEvent (SkillMagAV08)
	
	float recover = player.GetValue(CISROMANTIC)
	if (recover == 1.23 || recover == 2.34 || recover == 3.45 || recover == 4.56)
	
		SanctuaryCommentMade = true
		HouseCommentMade     = true
		SpeakLineNearPod     = false

		ActorValue CAFFINITY   = Game.GetForm(0x000ADC8C) as ActorValue ; MS16FahrenheitShieldDamage
		ActorValue CSELFISH    = Game.GetForm(0x000C9B0E) as ActorValue ; Dogmeat_clickedPreMolerat
		ActorValue CMEAN       = Game.GetForm(0x00066514) as ActorValue ; EMSystemSleeping
		ActorValue CVIOLENT    = Game.GetForm(0x00084287) as ActorValue ; CompStrongBerserkAV
		ActorValue CNICE       = Game.GetForm(0x00248491) as ActorValue ; PA_Unarmed_AV
		ActorValue CGENEROUS   = Game.GetForm(0x000B9635) as ActorValue ; FWIsAttacker
		ActorValue CPEACEFUL   = Game.GetForm(0x000DCE0F) as ActorValue ; TerminalVariable01
		
		ActorValue CA_Trait_Selfish  = Game.GetForm(0x000A1B1D) as ActorValue
		ActorValue CA_Trait_Mean     = Game.GetForm(0x000A1B1F) as ActorValue
		ActorValue CA_Trait_Violent  = Game.GetForm(0x000A1B21) as ActorValue
		ActorValue CA_Trait_Peaceful = Game.GetForm(0x000A1B20) as ActorValue
		ActorValue CA_Trait_Nice     = Game.GetForm(0x000A1B1E) as ActorValue
		ActorValue CA_Trait_Generous = Game.GetForm(0x000A1B1C) as ActorValue
		
		if (recover == 1.23 || recover == 3.45)
			SpawnSpouse(true)
			; previously current follower
		else
			SpawnSpouse(false)
		endIf
		
		Actor Spouse = pSpouse.GetActorReference()
		if Spouse
		
			Spouse.SetValue(CA_Trait_Selfish,  player.GetValue(CSELFISH))
			Spouse.SetValue(CA_Trait_Mean,     player.GetValue(CMEAN))
			Spouse.SetValue(CA_Trait_Violent,  player.GetValue(CVIOLENT))
			Spouse.SetValue(CA_Trait_Peaceful, player.GetValue(CPEACEFUL))
			Spouse.SetValue(CA_Trait_Nice,     player.GetValue(CNICE))
			Spouse.SetValue(CA_Trait_Generous, player.GetValue(CGENEROUS))
			float prevAffinity = player.GetValue(CAFFINITY)
			Spouse.SetValue(pCA_Affinity,       prevAffinity)

			if (prevAffinity > 249)
				SetCurrentStageID(407)
			endIf
			if (prevAffinity > 499)
				SetCurrentStageID(420)
			endIf
			if (prevAffinity > 749)
				SetCurrentStageID(497)			
			endIf
			if (prevAffinity > 999)
				if (recover == 1.23 || recover == 2.34)
					SetCurrentStageID(525)
					CompanionActorScript cas = Spouse as CompanionActorScript
					cas.RomanceSuccess()
				else
					SetCurrentStageID(522)
					CompanionActorScript cas = Spouse as CompanionActorScript
					cas.RomanceDeclined(true)
				endif
			endIf			
		endif
		
		; ['I feel like I missed something.','COMCait','000EE445'] (975941)
		Topic MissedSomething     = Game.GetForm(0x000EE445) as Topic
		Spouse.Say(MissedSomething,Spouse,false,Game.GetPlayer())
		
		return
	endif
			
	SanctuaryCommentMade = false
	HouseCommentMade     = false
	
	; Add area trigger around corpse. 
	; 
	; If early in the game, set flag to wait and speak line after player takes
	; ring. Otherwise, speak it when they get close the spouse corpse...
	
	if (MQ102.GetCurrentStageID() < 10) && 0 == player.GetItemCount(pArmor_SpouseWeddingRing)
		Trace("Registering for OnItemAdded Scene")
		AddInventoryEventFilter(pArmor_SpouseWeddingRing)
		RegisterForRemoteEvent(player, "OnItemAdded")
		SpeakLineNearPod = false
	else
		Trace("Spouse already activated or player has already left vault (blocks spouse activation). Skipping Activation Event")
	endif

	Trace("Registering for Location Change Notification")
	RegisterForRemoteEvent(player,"OnLocationChange")
	
	if player.GetCurrentLocation() == Vault111Cryo
		UpdateOccupants()
		Trace("Player is already in Vault 111")
		UnRegisterForDistanceEvents(player, MQPlayerSpousePodREF)	
		RegisterForDistanceLessThanEvent(player, MQPlayerSpousePodREF, 350)
	endif
	
EndEvent

; Each Time a Save Game is Loaded 
Function OnGameLoaded(bool firstTime=false)
	if (pSpouse.GetActorReference())
		TweakCSRescue.Remove()
	endif
EndFunction	
	
Event Actor.OnLocationChange(Actor akPlayer, Location oldLocation, Location newLocation)

	if (pSpouse.GetActorReference() == akPlayer)
		Trace("Spouse.OnLocationChange")
		if akPlayer.IsInFaction(pCurrentCompanionFaction) && akPlayer.IsNearPlayer()
			if (SanctuaryHillsLocation == newLocation && !SanctuaryCommentMade)
				Trace("Spouse Entered Sanctuary Hills")
				Topic Nice     = Game.GetForm(0x000EB385) as Topic
				if Nice
					Trace("Nice Topic Found....")				
					Actor pc = Game.GetPlayer()
					float[] posdata = TraceCircle(pc, 180, 50)				
					; NOTE: akPlayer here is the spouse:
					akPlayer.SetPosition(posdata[0],posdata[1],posdata[2])
					akPlayer.Say(Nice,akPlayer,false,Game.GetPlayer())
					SanctuaryCommentMade = true
					if HouseCommentMade
						UnRegisterForRemoteEvent(akPlayer, "OnLocationChange")
					endif				
				else
					Trace("Nice Topic Not currently available")
				endif
			endif
			if (SanctuaryHillsPlayerHouseLocation == newLocation && !HouseCommentMade)
				Topic Familiar = Game.GetForm(0x001091B0) as Topic
				if Familiar
					Trace("Familiar Topic Found....")
					Actor pc = Game.GetPlayer()
					float[] posdata = TraceCircle(pc, 180, 50)				
					; NOTE: akPlayer here is the spouse:
					akPlayer.SetPosition(posdata[0],posdata[1],posdata[2])
					akPlayer.Say(Familiar,akPlayer,false,Game.GetPlayer())
					HouseCommentMade = true
					if SanctuaryCommentMade
						UnRegisterForRemoteEvent(akPlayer, "OnLocationChange")
					endif				
				else
					Trace("Familiar Topic Not currently available")
				endif
			endif
		endif
		return
	endif
	
	Trace("Player.OnLocationChange From [" + oldLocation + "] To [" + newLocation + "]") 

	; There are 3 Vault111 cryo lab interior areas. 
	; 1) The clean vault from the games intro (0x000CA853)
	; 2) A kellog scene Cryo room specifically for the shooting event and the memory lounger. (0x000D41A4)
	; 3) The post-prologue version you can revisit with companions : (0x0001F3FE)
	;
	; The good news is that we dont have to worry about breaking the scenes since they use a 
	; seperate  copy of the Spouse...

	int currentStageID = GetCurrentStageID()
	if (currentStageID > 39) ; Emerged from vault already said...
		UnRegisterForRemoteEvent(akPlayer,"OnLocationChange")
		UnRegisterForDistanceEvents(akPlayer, MQPlayerSpousePodREF)
		return
	endif
	
	if (newLocation == Vault111Cryo)
		if (currentStageID < 30)
			UpdateOccupants()
			Trace("Setting up Trigger Zone")
			RegisterForDistanceLessThanEvent(akPlayer, MQPlayerSpousePodREF, 350)
		endif
		return
	endif
	
	if (oldLocation == Vault111Cryo)
		Trace("Removing Trigger Zone")
		UnRegisterForDistanceEvents(akPlayer, MQPlayerSpousePodREF)
		UnRegisterForRemoteEvent(MQ102CryoCorpse01.GetUniqueActor(), "OnLoad")
		return
	endif
		
EndEvent

Bool OccupantsFrozen = true
Bool OccupantsFresh  = true

Event ObjectReference.OnLoad(ObjectReference akActor)
	Trace("OnLoad [" + akActor + "]")
	
	UnRegisterForRemoteEvent(akActor, "OnLoad")
	RegisterForRemoteEvent(akActor, "OnLoad")
	
	Actor MrAble = MQ102CryoCorpse01.GetUniqueActor()
	if (MrAble && akActor == MrAble)
		UnRegisterForRemoteEvent(akActor, "OnLoad")
		Trace("Entered Vault 111. Updating Occupants")
		Utility.Wait(4.0)
		UpdateOccupants()
		return
	endif
	Actor Spouse = pSpouse.GetActorReference()
	if (Spouse && akActor == Spouse)
		if !Spouse.IsInInterior() ; Exited Vault
			ExitVaultReaction()
		else
			Trace("Spouse Loaded, but not interior. Re-registering Load Event")
		endif
	endif	
EndEvent

Function UpdateOccupants()
	Trace("UpdateOccupants()")

	; Wait until 3D is loaded.... Otherwise none of the commands will work.
	if OccupantsFrozen || OccupantsFresh || (MQ201.GetCurrentStageID() > 9 && GetCurrentStageID() < 30)
		Actor MrAble = MQ102CryoCorpse01.GetUniqueActor()
		if !MrAble.Is3DLoaded()
			RegisterForRemoteEvent((MrAble as ObjectReference), "OnLoad")
			return
		endif
	else
		return
	endif
	
	if (MQ201.GetCurrentStageID() > 9 && GetCurrentStageID() < 30)
		if (MQ102SpouseCorpseFemaleREF && !MQ102SpouseCorpseFemaleREF.IsDisabled())
			Trace("Unfreezing Spouse (Female)")
			CryoCorpseFXS.Stop(MQ102SpouseCorpseFemaleREF)
			Utility.wait(4)
		elseif (MQ102SpouseCorpseMaleREF && !MQ102SpouseCorpseMaleREF.IsDisabled())
			Trace("Unfreezing Spouse (Male)")
			CryoCorpseFXS.Stop(MQ102SpouseCorpseMaleREF)
			Utility.wait(4)
		else
			Trace("Both Male and Female Spouse disabled...")
		endif
	endif
	
	
	if OccupantsFresh
		if (Utility.GetCurrentGameTime() > 4.0)
			Trace("4 Game days have passed. Decompose Bodies...")
				
			Race Ghoul = Game.GetForm(0x000EAFB6) as Race
			if Ghoul
			
				Actor MrAble       = MQ102CryoCorpse01.GetUniqueActor()
				Actor MrsAble      = (Game.GetForm(0x00026F38) as ActorBase).GetUniqueActor()				
				Actor MrWhitfield  = (Game.GetForm(0x00026F3D) as ActorBase).GetUniqueActor()
				Actor MrsWhitfield = (Game.GetForm(0x00026F39) as ActorBase).GetUniqueActor()
				Actor MrRussell    = (Game.GetForm(0x00026F44) as ActorBase).GetUniqueActor()
				Actor MrCallahan   = (Game.GetForm(0x0003BDAF) as ActorBase).GetUniqueActor()
				Actor MrsCallahan  = (Game.GetForm(0x0003BDB1) as ActorBase).GetUniqueActor()
				Actor MrDiPietro   = (Game.GetForm(0x0003BDB3) as ActorBase).GetUniqueActor()
				Actor MrCofran     = (Game.GetForm(0x0003BDB5) as ActorBase).GetUniqueActor()
				Actor MrsCofran    = (Game.GetForm(0x0003BDB7) as ActorBase).GetUniqueActor()
				Actor CindyCofran  = (Game.GetForm(0x0003BDB9) as ActorBase).GetUniqueActor()
				
				Armor SackHood     = Game.GetForm(0x0018E417) as Armor
				
				MrAble.SetOutfit(None)
				MrAble.UnEquipAll()
				MrAble.SetRace(Ghoul)
				MrAble.EquipItem(SackHood)
				Utility.wait(0.1)
				
				MrsAble.SetOutfit(None)
				MrsAble.UnEquipAll()
				MrsAble.SetRace(Ghoul)
				MrsAble.EquipItem(SackHood)
				Utility.wait(0.1)

				MrWhitfield.SetOutfit(None)
				MrWhitfield.UnEquipAll()
				MrWhitfield.SetRace(Ghoul)
				MrWhitfield.EquipItem(SackHood)
				Utility.wait(0.1)
				
				MrsWhitfield.SetOutfit(None)
				MrsWhitfield.UnEquipAll()
				MrsWhitfield.SetRace(Ghoul)
				MrsWhitfield.EquipItem(SackHood)
				Utility.wait(0.1)

				MrRussell.SetOutfit(None)
				MrRussell.UnEquipAll()
				MrRussell.SetRace(Ghoul)
				MrRussell.EquipItem(SackHood)
				Utility.wait(0.1)
				
				MrCallahan.SetOutfit(None)
				MrCallahan.UnEquipAll()
				MrCallahan.SetRace(Ghoul)
				MrCallahan.EquipItem(SackHood)
				Utility.wait(0.1)

				MrsCallahan.SetOutfit(None)
				MrsCallahan.UnEquipAll()
				MrsCallahan.SetRace(Ghoul)
				MrsCallahan.EquipItem(SackHood)
				Utility.wait(0.1)
				
				MrDiPietro.SetOutfit(None)
				MrDiPietro.UnEquipAll()
				MrDiPietro.SetRace(Ghoul)
				MrDiPietro.EquipItem(SackHood)
				Utility.wait(0.1)
				
				MrCofran.SetOutfit(None)
				MrCofran.UnEquipAll()
				MrCofran.SetRace(Ghoul)
				MrCofran.EquipItem(SackHood)
				Utility.wait(0.1)
				
				MrsCofran.SetOutfit(None)
				MrsCofran.UnEquipAll()
				MrsCofran.SetRace(Ghoul)
				MrsCofran.EquipItem(SackHood)
				Utility.wait(0.1)
				
				CindyCofran.SetOutfit(None)
				CindyCofran.UnEquipAll()
				CindyCofran.SetRace(Ghoul)
				CindyCofran.EquipItem(SackHood)
				Utility.wait(0.1)
				
				; Need to refreeze after Race Change just in case...
				OccupantsFrozen = True
				Utility.wait(1.0)
			else
				Trace("Ghoul Race is NONE")
			endif			
		else
			Trace("MQ102.GetCurrentStageID() < 10")
		endif		
	else
		Trace("OccupantsFresh is already false")
	endif

	if OccupantsFrozen
		
		Actor MrAble       = MQ102CryoCorpse01.GetUniqueActor()
		Actor MrsAble      = (Game.GetForm(0x00026F38) as ActorBase).GetUniqueActor()				
		Actor MrWhitfield  = (Game.GetForm(0x00026F3D) as ActorBase).GetUniqueActor()
		Actor MrsWhitfield = (Game.GetForm(0x00026F39) as ActorBase).GetUniqueActor()
		Actor MrRussell    = (Game.GetForm(0x00026F44) as ActorBase).GetUniqueActor()
		Actor MrCallahan   = (Game.GetForm(0x0003BDAF) as ActorBase).GetUniqueActor()
		Actor MrsCallahan  = (Game.GetForm(0x0003BDB1) as ActorBase).GetUniqueActor()
		Actor MrDiPietro   = (Game.GetForm(0x0003BDB3) as ActorBase).GetUniqueActor()
		Actor MrCofran     = (Game.GetForm(0x0003BDB5) as ActorBase).GetUniqueActor()
		Actor MrsCofran    = (Game.GetForm(0x0003BDB7) as ActorBase).GetUniqueActor()
		Actor CindyCofran  = (Game.GetForm(0x0003BDB9) as ActorBase).GetUniqueActor()

		Trace("Unfreezing MrAble")
		CryoCorpseFXS.Stop(MrAble)
		Utility.wait(1)
		Trace("Unfreezing MrsAble")
		CryoCorpseFXS.Stop(MrsAble)
		Utility.wait(1)
		Trace("Unfreezing MrWhitfield")
		CryoCorpseFXS.Stop(MrWhitfield)
		Utility.wait(1)
		Trace("Unfreezing MrsWhitfield")
		CryoCorpseFXS.Stop(MrsWhitfield)
		Utility.wait(1)
		Trace("Unfreezing MrRussell")
		CryoCorpseFXS.Stop(MrRussell)
		Utility.wait(1)
		Trace("Unfreezing MrCallahan")
		CryoCorpseFXS.Stop(MrCallahan)
		Utility.wait(1)
		Trace("Unfreezing MrsCallahan")
		CryoCorpseFXS.Stop(MrsCallahan)
		Utility.wait(1)
		Trace("Unfreezing MrDiPietro")
		CryoCorpseFXS.Stop(MrDiPietro)
		Utility.wait(1)
		Trace("Unfreezing MrCofran")
		CryoCorpseFXS.Stop(MrCofran)
		Utility.wait(1)
		Trace("Unfreezing MrsCofran")
		CryoCorpseFXS.Stop(MrsCofran)
		Utility.wait(1)
		Trace("Unfreezing CindyCofran")
		CryoCorpseFXS.Stop(CindyCofran)
		Utility.wait(1)	
	else
		Trace("Occupants Already Unfrozen")
	endif	

EndFunction

; Monitor Player inventory events until they take the wedding ring
; or leave Vault 111.
Event Objectreference.OnitemAdded(ObjectReference oPlayer, Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	Trace("Objectreference.OnitemAdded()")
	
	if (pSpouse.GetReference() == oPlayer)
		Trace("Spouse Recieved Item")
		if (akBaseItem == pArmor_SpouseWeddingRing)
			Trace("Item is wedding ring")
			Topic Thanks   = Game.GetForm(0x00147866) as Topic
			if Thanks
				Trace("Thanks Topic Found....")
				Actor theSpouse = pSpouse.GetActorReference()
				UnRegisterForRemoteEvent(theSpouse, "OnItemAdded")
				FollowersScript.SendAffinityEvent(self, CA_CustomEvent_PrestonLoves, ShouldSuppressComment = false, IsDialogueBump = true)
				theSpouse.Say(Thanks,theSpouse,false,Game.GetPlayer())
				Utility.wait(5.0)
			else
				Trace("Thanks Topic NOT Found....")			
			endif
		else
			Trace("Item not wedding ring")
		endif
		return		
	endif

	if (MQ102.GetCurrentStageID() > 9)
		UnRegisterForRemoteEvent(Game.GetPlayer(), "OnItemAdded")
		if (GetCurrentStageID() < 30)
			SpeakLineNearPod = True
		endif
		return	
	endif
	
	if (akBaseItem != pArmor_SpouseWeddingRing)
		Trace("Not wedding ring...")
		return
	endif
	
	Actor akPlayer = Game.GetPlayer()
	UnRegisterForRemoteEvent(akPlayer, "OnItemAdded")
	Utility.wait(2.0)
	int maxwait = 20
	Trace("Wait for player to stop talking")
	while (akPlayer.IsTalking() && maxwait > 0)
		Trace("Waiting...")
		Utility.wait(0.5)
		maxwait -= 1
	endWhile
	Trace("Done Talking")
	Utility.wait(1.5)
	MentionDoctor()	
	
EndEvent

Event OnDistanceLessThan(ObjectReference akPlayer, ObjectReference akPod, float afDistance)
	Trace("OnDistanceLessThan [" + afDistance + "]")
	UnRegisterForDistanceEvents(akPlayer, akPod)	
	if (GetCurrentStageID() > 29)
		Trace("Already Rescued or Dead")
		return		
	endif
	
	; The same event gets called for the outer and inner less than, which is why you
	; dont want to register the greater than event here, or you can end up registering
	; it multiple times...
	
	Actor Curie = pCurie.GetActorReference()
	
	if (Curie && Curie.IsInFaction(pCurrentCompanionFaction) && Curie.Is3DLoaded())
		Trace("Curie Detected.")		
		RegisterForDistanceGreaterThanEvent(Game.GetPlayer(), MQPlayerSpousePodREF, 500) ; In case they cancel
		ReturnWithCurie(Curie)
		return
	endif
		
	if (afDistance > 120)
		Trace(" Distance > 120")
		RegisterForDistanceGreaterThanEvent(Game.GetPlayer(), MQPlayerSpousePodREF, 500) ; In case they cancel
		RegisterForDistanceLessThanEvent(Game.GetPlayer(), MQPlayerSpousePodREF, 120)
		return		
	endif
	
	Trace(" Distance < 120")
	
	; Have to rescue her before Act 1 is over (Before BOS show up)
	if (MQ201.GetCurrentStageID() > 9)
		Trace("TweakCOMSpouseTooLateBootstrap.Start()")
		TweakCOMSpouseTooLateBootstrap.Start()
		return
	endif

	RegisterForDistanceGreaterThanEvent(Game.GetPlayer(), MQPlayerSpousePodREF, 500) ; In case they cancel
		
	if !SpeakLineNearPod && MQ102.GetCurrentStageID() > 9
		Trace("Activation Expired. Enabling SpeakLineNearPod")
		UnRegisterForRemoteEvent(MQPlayerSpousePodREF, "OnActivate")
		SpeakLineNearPod = True
	endif
	
	if SpeakLineNearPod
		MentionDoctor()
	endif
	
EndEvent

Event OnDistanceGreaterThan(ObjectReference akPlayer, ObjectReference akPod, float afDistance)
	Trace("Moved away from spouse corpse")
	; Close it to make rescue scene more interesting...
	
	UnRegisterForDistanceEvents(akPlayer, akPod)
	
	if (GetCurrentStageID() < 30)
		MQPlayerSpousePodREF.PlayAnimation("Stage1")	
		RegisterForDistanceLessThanEvent(akPlayer, MQPlayerSpousePodREF, 350)	
		return		
	endif
	
	Trace("Already Rescued or Dead")
	
EndEvent

Function MentionDoctor()
	Trace("MentionDoctor()")
	Actor akPlayer = Game.GetPlayer()
	Topic NoDoctor = Game.GetForm(0x00165462) as Topic
	Topic IllBeBack = Game.GetForm(0x0011CD2B) as Topic
	if NoDoctor
		Trace("NoDoctor Topic Found....")
		akPlayer.Say(NoDoctor)
		Utility.wait(2.0)
	else
		Trace("NoDoctor Topic Unavailable")
		Topic CantHelp = Game.GetForm(0x00165461) as Topic
		if CantHelp
			Trace("CantHelp Topic Found....")
			akPlayer.Say(CantHelp)
			Utility.wait(5.0)
		else
			Trace("CantHelp Topic Unavailable")
		endif
	endif
	if IllBeBack
		Trace("IllBeBack Topic Found....")
		akPlayer.Say(IllBeBack)
		Utility.wait(4.0)
	else
		Trace("IllBeBack Topic Unavailable")
	endif
EndFunction

float PrevAllowedLoiter = 1.0
float PrevNoIdle 		= 0.0
ObjectReference[] MutedActorRefs = None

Function ReturnWithCurie(Actor Curie)

	Trace("ReturnWithCurie")

	bool overridden = false
	float[] posdata
	
	if (MQ201.GetCurrentStageID() < 10)
		Trace("MQ201 < 10")

		; Prevent Condolense commentary from companions...
		; Note : This AO_Commentary_256 activator is set to self-re-enable
		;        next time we return. 
		
		AO_Comment_Unique_256_024.Disable()

		; MUTE nearby companions:
		PrevAllowedLoiter = TweakAllowLoiter.GetValue()
		TweakAllowLoiter.SetValue(0.0)
		PrevNoIdle        = TweakNoIdle.GetValue()
		TweakNoIdle.SetValue(1.0)
		Actor pc    = Game.GetPlayer()
	
		; Keyword ActorTypeNPC = Game.GetForm(0x00013794) as Keyword	
		MutedActorRefs = pc.FindAllReferencesWithKeyword(TweakActorTypeManaged, 3500)
		if (MutedActorRefs)
			Voicetype _NPC_NoLines = Game.GetForm(0x0007C61A) as Voicetype
			int mal = MutedActorRefs.length
			Trace("FindAllReferencesofType found [" + mal + "] NPCs")
			int i = 0
			Actor npc
			while (i < mal)
				npc = MutedActorRefs[i] as Actor
				if npc
					if npc.IsInFaction(pCurrentCompanionFaction)
					Trace("Muting NPC [" + npc.GetActorBase().GetFormID() + "]")
					npc.SetOverrideVoiceType(_NPC_NoLines)
					; So they honor the global idle/loiter flags...
					npc.EvaluatePackage()
					else
						Trace("Actor [" + npc + "] is not in CurrentCompanionFaction")
					endif
				else
					Trace("Not an Actor [" +MutedActorRefs[i] + "]")				
				endif
				i += 1
			endwhile
			; Re-enable Curie...
			Curie.SetOverrideVoiceType(None)
		else
			Trace("MutedActorRefs is None")
		endif
	endif
	
	Actor Codsworth = pCodsworth.GetActorReference()
	if Codsworth  && Codsworth.IsInFaction(pCurrentCompanionFaction) && Codsworth.Is3DLoaded()
		Trace("Moving Codsworth ")
		posdata = TraceCircle(MQPlayerSpousePodREF, 450, -129)	
		Codsworth.SetPosition(posdata[0],posdata[1],posdata[2] + 30)
	endif
	
	posdata = TraceCircle(MQPlayerSpousePodREF, 400, -120)
	Curie.SetPosition(posdata[0],posdata[1],posdata[2] + 30)
		
	Trace("Curie Comments")
	Topic WhatIsThat = Game.GetForm(0x0016D312) as Topic; AOT_DN028_2
	if WhatIsThat
		Utility.wait(1.0)
		Curie.Say(WhatIsThat)
		Utility.wait(1.0)
		int maxwait = 20
		while (Curie.IsTalking() && maxwait > 0)
			Trace("Waiting...")
			Utility.wait(0.5)
			maxwait -= 1
		endWhile
	endif
	Utility.wait(1.0)

	if (MQ201.GetCurrentStageID() > 9)
	
		Trace("Too Late, with Curie")
		Trace("TweakCOMSpouseTooLateBootstrap.Start()")
		TweakCOMSpouseTooLateBootstrap.Start()
		return
	endif
	
	Trace("TweakCOMSpouseRescueBootstrap.Start()")
	TweakCOMSpouseRescueBootstrap.Start()
		
EndFunction

Function RescueSpouse()

	Trace("RescueSpouse()")
	
	; NOTE : Companions are muted
	; NOTE : Loiter has been disabled
	; NOTE : Idle Chatter has been disabled
	
	; Don't need condolense commentary anymore...
	AO_Comment_Unique_256_024.Delete()

	Actor pc    = Game.GetPlayer()
	bool forcePositions = false
	float distancecheck = pc.GetDistance(MQPlayerSpousePodREF)
	if (distancecheck < 500)
		Trace("Player distance [" + distancecheck + "] from Cryopod. Using cryo as scene anchor")		
		forcePositions = true	
		ILayer = InputEnableLayer.Create()
		ILayer.DisablePlayerControls(abMovement = true, abFighting = true, abCamSwitch = false, abLooking = false, abSneaking = true, \
		abMenu = true, abActivate = false, abJournalTabs = true, abVATS = true, abFavorites = true)

		; Hard code scene 
		Trace("Opening Cryo...")		
		MQPlayerSpousePodREF.PlayAnimation("Stage2") ; Open CryoPod
		Utility.wait(4)		
		Trace("Stopping Freeze Effect")	
		if MQ102SpouseCorpseMaleREF && !MQ102SpouseCorpseMaleREF.IsDisabled()
			CryoCorpseFXS.Stop(MQ102SpouseCorpseMaleREF)
			Utility.wait(1.5)
		endif
		if MQ102SpouseCorpseFemaleREF && !MQ102SpouseCorpseFemaleREF.IsDisabled()
			CryoCorpseFXS.Stop(MQ102SpouseCorpseFemaleREF)
			Utility.wait(1.5)
		endif
	else
		Trace("Player distance [" + distancecheck + "] from Cryopod. Using player as scene anchor")		
	endif
	
	; Setup Mr SubtitleOverride...

	; The problem with actors is that they react to gravity and they bump other objects around. So we
	; need something that doesn't to create a safe spawn-to location
	
	Form InvisibleGeneric01 = Game.GetForm(0x00024571)
	float[] posdata = TraceCircle(pc, 200, -150)
	ObjectReference spawnMarker = pc.PlaceAtMe(InvisibleGeneric01)
	spawnMarker.SetPosition(posdata[0],posdata[1],posdata[2])
	spawnMarker.MoveToNearestNavmeshLocation()
	Utility.wait(0.1)

	Actor mrSubtitleOverride = pSubtitleOverride.GetActorReference()
	if mrSubtitleOverride
		if mrSubtitleOverride.IsDisabled()
			mrSubtitleOverride.Enable()
		endif
		mrSubtitleOverride.MoveToIfUnloaded(spawnMarker)
	else
		mrSubtitleOverride = TweakSubtitleOverride.GetUniqueActor()
		if !mrSubtitleOverride
			Trace("Creating TweakSubtitleOverride")	
			mrSubtitleOverride = spawnMarker.PlaceActorAtMe(TweakSubtitleOverride)
		endif
		if mrSubtitleOverride
			pSubtitleOverride.ForceRefTo(mrSubtitleOverride)
		endif
	endif
	if mrSubtitleOverride
		Trace("Positioning TweakSubtitleOverride")	
		mrSubtitleOverride.SetPosition(spawnMarker.GetPositionX(),spawnMarker.GetPositionY(),spawnMarker.GetPositionZ())
	endif
	spawnMarker.Disable()
	spawnMarker.Delete()
	
	; While we wont have to worry about filling the pSubtitleOverride alias again, we will always need to make sure
	; the alias is not disabled and close enough to the player to be part of the scene. (within 250 radius of player). 
	
	; We can assume Curie presence as this wont fire without her	
	Actor Curie = pCurie.GetActorReference()

	; We Prep for Codsworth as he is the most likely additional NPC 
	; early in the game. 
	Actor Codsworth = pCodsworth.GetActorReference()
	if (Codsworth)
		Trace("Codsworth Found")	
		if !(Codsworth.IsInFaction(pCurrentCompanionFaction) && Codsworth.Is3DLoaded() && pc.GetDistance(Codsworth) < 600)
			Trace("Codsworth Not follower or too far away. Ignoring")	
			Codsworth = None
		else
			Trace("Including Codsworth")	
		endif
	else
		Trace("Codsworth Not Found")	
	endif
	
	int Operation    = OBJSynthProductionSequence4ArmOrb.play(Curie)
	Utility.wait(0.5)
	
	; FADE OUT
	Game.FadeOutGame(true, true, 1.0, 1.0, true)
	Game.TurnPlayerRadioOn(false)
	Utility.wait(3)
	
	Furniture NPCWoundedSitNoWait = Game.GetForm(0x001ED774) as Furniture
	ObjectReference SitAnim = Curie.PlaceAtMe(NPCWoundedSitNoWait)
	
	int CreatureOpen = -1
	if forcePositions
		posdata = TraceCircle(MQPlayerSpousePodREF, 250, 180)
		SitAnim.SetPosition(posdata[0],posdata[1],(posdata[2] + 30))
		SitAnim.MoveToNearestNavmeshLocation()
		Utility.wait(0.06)
		CreatureOpen = DRScRaceCreatureOpen.Play(SitAnim)
		pc.TranslateToRef(SitAnim, 500.0)
		Utility.wait(1.0)
		posdata = TraceCircle(MQPlayerSpousePodREF, 120, 180)		
		SitAnim.SetPosition(posdata[0],posdata[1],(posdata[2] + 30))
		Utility.wait(0.06)
		SitAnim.MoveToNearestNavmeshLocation()
		Utility.wait(0.06)
		SitAnim.SetAngle(0.0,0.0, SitAnim.GetAngleZ() + SitAnim.GetHeadingAngle(pc))	
		Utility.wait(0.1)
		posdata = TraceCircle(MQPlayerSpousePodREF, 190, -135) ; InFront Right
		Curie.SetPosition(posdata[0],posdata[1],(posdata[2] + 30))
		if Codsworth
			posdata = TraceCircle(MQPlayerSpousePodREF, 270, -145)  ; InFront Right
			Codsworth.SetPosition(posdata[0],posdata[1],(posdata[2] + 30))
		endif
		Utility.wait(0.06)
		Curie.MoveToNearestNavmeshLocation()
		if Codsworth
			Codsworth.MoveToNearestNavmeshLocation()
		endif
		Utility.wait(0.06)	
		Curie.SetAngle(0.0,0.0, Curie.GetAngleZ() + Curie.GetHeadingAngle(SitAnim))
		if Codsworth
			Codsworth.SetAngle(0.0,0.0, Codsworth.GetAngleZ() + Codsworth.GetHeadingAngle(SitAnim))
		endif
		Utility.wait(0.06)
	else ; Incase someone forces quest to stage 30 with console
		posdata = TraceCircle(pc, 120)
		SitAnim.SetPosition(posdata[0],posdata[1],(posdata[2]))
		Utility.wait(0.06)
		CreatureOpen = DRScRaceCreatureOpen.Play(SitAnim)
		SitAnim.MoveToNearestNavmeshLocation()
		Utility.wait(0.06)
		SitAnim.SetAngle(0.0,0.0, SitAnim.GetAngleZ() + SitAnim.GetHeadingAngle(pc))	
		Utility.wait(0.5)

		posdata = TraceCircle(pc, 140, -55)     ; InFront Right
		Curie.SetPosition(posdata[0],posdata[1],(posdata[2]))
		if Codsworth
			posdata = TraceCircle(pc, 140, -100)     ; InFront Right
			Codsworth.SetPosition(posdata[0],posdata[1],(posdata[2]))
		endif
		Utility.wait(0.06)
		Curie.MoveToNearestNavmeshLocation()
		if Codsworth
			Codsworth.MoveToNearestNavmeshLocation()
		endif
		Utility.wait(0.06)	
		Curie.SetAngle(0.0,0.0, Curie.GetAngleZ() + Curie.GetHeadingAngle(SitAnim))
		if Codsworth
			Codsworth.SetAngle(0.0,0.0, Codsworth.GetAngleZ() + Codsworth.GetHeadingAngle(SitAnim))
		endif
		Utility.wait(0.72)
	endif
	
	int spouseGender = 1
	if MQ102SpouseCorpseMaleREF && MQ102SpouseCorpseMaleREF.IsEnabled()
		spouseGender = 0
		if (MQ102SpouseCorpseMaleREF as Actor)
			if !(MQ102SpouseCorpseMaleREF as Actor).IsInFaction(pCurrentCompanionFaction)
				MQ102SpouseCorpseMaleREF.Disable()
			endif
		else
			MQ102SpouseCorpseMaleREF.Disable()
		endif
	elseif MQ102SpouseCorpseFemaleREF && MQ102SpouseCorpseFemaleREF.IsEnabled()
		spouseGender = 1
		if (MQ102SpouseCorpseFemaleREF as Actor)
			if !(MQ102SpouseCorpseFemaleREF as Actor).IsInFaction(pCurrentCompanionFaction)
				MQ102SpouseCorpseFemaleREF.Disable()
			endif			
		else
			MQ102SpouseCorpseFemaleREF.Disable()
		endif
	elseif (1 == (pc.GetBaseObject() as ActorBase).GetSex())
		; The PLAYER is female, so assume MALE Spouse
		spouseGender = 0
	else
		; If all else fails, assume female spouse...
		spouseGender = 1
	endif
	

	Actor theSpouse
	; Gender : 0 = male, 1 = female, -1 = None
	if (0 == spouseGender)
	
		Actor Nate = pTweakCompanionNate.GetUniqueActor()
		if !Nate
			; We create the spouse on the fly because if we hard code
			; into the game, they dont pick up changes to the ActorBase
			Trace("Creating Nate")		
			Nate = SitAnim.PlaceActorAtMe(pTweakCompanionNate)
		else
			Trace("Nate already exists")	
			Nate.MoveTo(SitAnim)
		endif
		if Nate
			theSpouse = Nate
		else
			Trace("Nate Creation Failure")
		endif
	else
			
		Actor Nora = pTweakCompanionNora.GetUniqueActor()
		if !Nora
			Trace("Creating Nora")		
			Nora = SitAnim.PlaceActorAtMe(pTweakCompanionNora)
			; We create the spouse on the fly because if we hard code
			; into the game, they dont pick up changes to the ActorBase
		else
			Trace("Nora already exists")		
			Nora.MoveTo(SitAnim)
		endif
		if Nora
			theSpouse = Nora
		else
			Trace("Nora Creation Failure")
		endif
	
	endif
	
	if theSpouse
		theSpouse.DisallowCompanion()
		Utility.wait(0.1)
		theSpouse.SetLinkedRef(SitAnim,TweakPoseTarget)
		pSpouse.ForceRefTo(theSpouse)
			
		Topic Breathing = Game.GetForm(0x0007B296) as Topic
		if !Breathing
			Breathing = Game.GetForm(0x0007B297) as Topic
		endif
		Topic ItsWorking = Game.GetForm(0x0016D35C) as Topic
		
		Sound.StopInstance(Operation)
		Operation    = OBJSynthProductionSequence4ArmOrb.play(Curie)
		Utility.wait(3.5)
		int Heartbeat     = UIHealthHeartbeatALP.Play(pc)

		Trace("Applying Temporary Sound settings")
		TweakMUSMemory.Add()
		TweakCSRescue.Push()
		
		Utility.wait(2.35)
		Sound.StopInstance(Operation)
		Operation    = OBJSynthProductionSequence4ArmOrb.play(Curie)		
		Utility.wait(2.8)
		if ItsWorking
			Curie.Say(ItsWorking)
		endIf
		Utility.wait(3.0)
		if (-1 != Operation)
			Sound.StopInstance(Operation)
			Operation = -1
		endif
		int CreatureClose = DRScRaceCreatureClose.Play(SitAnim)
		Utility.wait(0.75)
		; The spouse cough ends the heartbeat loop...
		if Breathing
			theSpouse.Say(Breathing)
		endif
		if (-1 != Heartbeat)
			Sound.StopInstance(Heartbeat)
			Heartbeat = -1
		endif
		if (-1 != CreatureOpen)
			Sound.StopInstance(CreatureOpen)
			CreatureOpen = -1
		endif
		if (-1 != CreatureClose)
			Sound.StopInstance(CreatureClose)
			CreatureClose = -1
		endif
		
		theSpouse.SnapIntoInteraction(SitAnim)
		theSpouse.BlockActivation(true,true)
	endif

	Utility.wait(0.1)
	Game.FadeOutGame(false, true, 2.0, 1.0)
	Utility.wait(1.0)
	ILayer.EnablePlayerControls()
	ILayer.Delete()
	ILayer = None
	
	if (theSpouse)
		theSpouse.BlockActivation(false,false)
		TweakCOMSpouseRescueHelperBootstrap.Start()
	endif
	
EndFunction

Function ExplainPast()

	Trace("ExplainPast()")
	; return quickly so that scene can end...
	Var[] params = new Var[0]
	self.CallFunctionNoWait("ExplainPastHelper", params)
	return
	
EndFunction

Function ExplainPastHelper()
	Trace("ExplainPastHelper()")
	
	Actor pc        = Game.GetPlayer()
	
	bool forcePositions = false
	if (pc.GetDistance(MQPlayerSpousePodREF) < 500)
		forcePositions = true
		ILayer = InputEnableLayer.Create()
		ILayer.DisablePlayerControls(abMovement = true, abFighting = true, abCamSwitch = false, abLooking = false, abSneaking = true, \
			abMenu = true, abActivate = false, abJournalTabs = true, abVATS = true, abFavorites = true)
	endif
	
	Actor theSpouse = pSpouse.GetActorReference()
	if pc.IsTalking()
		Trace("Waiting for PC to stop talking")
		int maxwait = 8
		while (pc.IsTalking() && maxwait > 8)
			Utility.wait(1)
			maxwait -= 1
		endwhile
		if (maxwait == 0)
			Trace("Timed Out")
		else
			Trace("PC is no longer talking")
		endif
		Utility.wait(2.0)
	endif
	if pc.IsInScene()
		Trace("Waiting for PC to exit Scene")
		int maxwait = 5
		while (pc.IsInScene() && maxwait > 0)
			Utility.wait(1)
			maxwait -= 1
		endwhile
		if (maxwait == 0)
			Trace("Timed Out")
		else
			Trace("PC no longer in scene")
		endif		
	endif
	if theSpouse && theSpouse.IsInScene()
		Trace("Waiting for Spouse to exit Scene")
		int maxwait = 5
		while (theSpouse.IsInScene() && maxwait > 0)
			Utility.wait(1)
			maxwait -= 1
		endwhile
		if (maxwait == 0)
			Trace("Timed Out")
		else
			Trace("Spouse no longer in scene")
		endif		
	endif
	if theSpouse && theSpouse.IsTalking()
		Trace("Waiting for Spouse to stop talking")
		int maxwait = 8
		while (theSpouse.IsTalking() && maxwait > 8)
			Utility.wait(1)
			maxwait -= 1
		endwhile
		if (maxwait == 0)
			Trace("Timed Out")
		else
			Trace("Spouse is no longer talking")
		endif		
	endif
	
	ObjectReference sitAnim = None
	if theSpouse
		theSpouse.BlockActivation(true,true)
		sitAnim = theSpouse.GetLinkedRef(TweakPoseTarget)
		theSpouse.SetLinkedRef(None,TweakPoseTarget)
	endif
	
	; Give them time to stand up...
	Utility.Wait(3.75)	
	if sitAnim
		; Prevent them from using it when we turn loitering back on.
		Trace("Removing SitAnim")
		sitAnim.Disable()
		sitAnim.Delete()
	else
		Trace("Could not locate SitAnim")
	endif
	
	; FADE OUT
	Game.FadeOutGame(true, true, 2.0, 2.0, true)
	Utility.wait(5)
	
	; We can assume Curie presence as this wont fire without her
	Actor Curie     = pCurie.GetActorReference()
	Actor Codsworth = pCodsworth.GetActorReference()
	if (Codsworth)
		Trace("Codsworth Found")	
		if !(Codsworth.IsInFaction(pCurrentCompanionFaction) && Codsworth.Is3DLoaded() && pc.GetDistance(Codsworth) < 600)
			Trace("Codsworth Not follower or too far away. Ignoring")	
			Codsworth = None
		else
			Trace("Including Codsworth")	
		endif
	else
		Trace("Codsworth Not Found")	
	endif
	
	float[] posdata
	if forcePositions
		posdata = TraceCircle(MQPlayerSpousePodREF, 120, 180)		
		theSpouse.SetPosition(posdata[0],posdata[1],(posdata[2] + 30))
		Utility.wait(0.06)
		theSpouse.MoveToNearestNavmeshLocation()
		Utility.wait(0.06)
		theSpouse.SetAngle(0.0,0.0, theSpouse.GetAngleZ() + theSpouse.GetHeadingAngle(pc))	
		Utility.wait(0.1)
		posdata = TraceCircle(MQPlayerSpousePodREF, 190, -135) ; InFront Right
		Curie.SetPosition(posdata[0],posdata[1],(posdata[2] + 30))
		if Codsworth
			posdata = TraceCircle(MQPlayerSpousePodREF, 270, -145)  ; InFront Right
			Codsworth.SetPosition(posdata[0],posdata[1],(posdata[2] + 30))
		endif
		Utility.wait(0.06)
		Curie.MoveToNearestNavmeshLocation()
		if Codsworth
			Codsworth.MoveToNearestNavmeshLocation()
		endif
		Utility.wait(0.06)	
		Curie.SetAngle(0.0,0.0, Curie.GetAngleZ() + Curie.GetHeadingAngle(theSpouse))
		if Codsworth
			Codsworth.SetAngle(0.0,0.0, Codsworth.GetAngleZ() + Codsworth.GetHeadingAngle(theSpouse))
		endif
		Utility.wait(0.06)
	else
		posdata = TraceCircle(pc, 120)
		theSpouse.SetPosition(posdata[0],posdata[1],(posdata[2]))
		Utility.wait(0.06)
		theSpouse.MoveToNearestNavmeshLocation()
		Utility.wait(0.06)
		theSpouse.SetAngle(0.0,0.0, theSpouse.GetAngleZ() + theSpouse.GetHeadingAngle(pc))	
		posdata = TraceCircle(pc, 140, -55)     ; InFront Right
		Curie.SetPosition(posdata[0],posdata[1],(posdata[2]))
		if Codsworth
			posdata = TraceCircle(pc, 140, -100)     ; Behind Right
			Codsworth.SetPosition(posdata[0],posdata[1],(posdata[2]))
		endif
		Utility.wait(0.06)
		Curie.MoveToNearestNavmeshLocation()
		if Codsworth
			Codsworth.MoveToNearestNavmeshLocation()
		endif
		Utility.wait(0.06)	
		Curie.SetAngle(0.0,0.0, Curie.GetAngleZ() + Curie.GetHeadingAngle(theSpouse))
		if Codsworth
			Codsworth.SetAngle(0.0,0.0, Codsworth.GetAngleZ() + Codsworth.GetHeadingAngle(theSpouse))
		endif
		Utility.wait(0.06)
	endif
			
	Utility.wait(0.5)
	Game.FadeOutGame(false, true, 2.0, 2.0)
	Utility.wait(1.0)
	
	ILayer.EnablePlayerControls()
	ILayer.Delete()
	ILayer = None
	
	if (pSpouse.GetReference())
		theSpouse.BlockActivation(false,false)
		Trace("TweakCOMSpouseRescueExplainBootstrap.Start()")
		if Codsworth
			; Re-enable Codsworth voice...
			Codsworth.SetOverrideVoiceType(None)
		endif
		TweakCOMSpouseRescueExplainBootstrap.Start()
	else
		Trace("Error : No Spouse. Skipping Scene")
	endif
	
EndFunction

Function ExplainPastFinished()
	Trace("ExplainPastFinished()")

	if (MutedActorRefs)
		int mal = MutedActorRefs.length
		int i = 0
		Actor npc
		while (i < mal)
			npc = MutedActorRefs[i] as Actor
			if npc && npc.IsInFaction(pCurrentCompanionFaction)
				Trace("UnMuting NPC [" + npc + "]")
				npc.SetOverrideVoiceType(None)
			endif
			i += 1
		endwhile
	endif
	
	TweakAllowLoiter.SetValue(PrevAllowedLoiter)
	TweakNoIdle.SetValue(PrevNoIdle)
	TweakCSRescue.Remove()
	
	Actor mrSubtitleOverride = pSubtitleOverride.GetActorReference()
	mrSubtitleOverride.Disable()
	
	;Actor Codsworth = pCodsworth.GetActorReference()
	;if Codsworth
	;	; Re-enable Codsworth voice...
	;	Codsworth.SetOverrideVoiceType(None)
	; endif
	
	; Make Spouse a temporary follower (That you can't control)
	Actor Spouse = pSpouse.GetActorReference()
	if Spouse
		FollowPlayer.ForceRefTo(Spouse)
		; Register for event so we can detect Vault Exit...
		RegisterForRemoteEvent(Spouse,"OnLoad") ; Detect Exit Vault
		AddInventoryEventFilter(pArmor_SpouseWeddingRing)
		RegisterForRemoteEvent(Spouse,"OnItemAdded") ; Detect Wedding Ring as Present
		RegisterForRemoteEvent(Spouse,"OnLocationChange") ; Detect Enter Sanctuary	
	endif
	
	; So when you exit it will be daytime...
	GameHour.SetValueInt(9)
	
	Actor pc = Game.GetPlayer()
	if (pc.GetDistance(MQPlayerSpousePodREF) < 500)
		Trace("Setting up Exit Trigger for Curie Comment")
		QuickstartRespecTrigger.Enable()
		RegisterForRemoteEvent(QuickstartRespecTrigger,"OnTriggerEnter")
	else
		Trace("Starting Curie Comment Now")
		RescueSpouseCurieComment(false)
	endif

EndFunction

Event ObjectReference.OnTriggerEnter(ObjectReference akTrigger, ObjectReference akActorRef)
	if (akActorRef == Game.GetPlayer())
		UnRegisterForRemoteEvent(akTrigger,"OnTriggerEnter")
		QuickstartRespecTrigger.Disable()
		RescueSpouseCurieComment()
	Endif
EndEvent

Function RescueSpouseCurieComment(bool normal=true)
	Trace("RescueSpouseCurieComment()")
	; return quickly so that scene can end...
	Var[] params = new Var[1]
	params[0] = normal
	self.CallFunctionNoWait("RescueSpouseCurieCommentHelper", params)
	return
	
EndFunction

Function RescueSpouseCurieCommentHelper(bool normal=true)
	Trace("RescueSpouseCurieCommentHelper()")
	
	ILayer = InputEnableLayer.Create()
	ILayer.DisablePlayerControls(abMovement = true, abFighting = true, abCamSwitch = false, abLooking = false, abSneaking = true, \
								abMenu = true, abActivate = false, abJournalTabs = true, abVATS = true, abFavorites = true)

	PrevAllowedLoiter = TweakAllowLoiter.GetValue()
	TweakAllowLoiter.SetValue(0.0)
	PrevNoIdle        = TweakNoIdle.GetValue()
	TweakNoIdle.SetValue(1.0)

	Actor pc = Game.GetPlayer()
	Actor Curie = pCurie.GetActorReference()
		
					
	float[] posdata
	if normal ; use TestRespecMarker as anchor
		Trace("normal. Using TestRespecMarker as anchor")
		Game.FadeOutGame(true, true, 1.0, 1.0, true)
		Utility.wait(2.0)
		pc.TranslateToRef(TestRespecMarker, 500.0)
		posdata = TraceCircle(TestRespecMarker, 175, -45)
		if Curie.Is3DLoaded()
			Curie.SetRestrained()
			Curie.SetPosition(posdata[0],posdata[1],posdata[2])
			Curie.SetAngle(0.0,0.0, Curie.GetAngleZ() + Curie.GetHeadingAngle(TestRespecMarker))
		else
			Form InvisibleGeneric01 = Game.GetForm(0x00024571)
			ObjectReference spawnMarker = TestRespecMarker.PlaceAtMe(InvisibleGeneric01)
			spawnMarker.SetPosition(posdata[0],posdata[1],posdata[2])
			spawnMarker.SetAngle(0.0,0.0, spawnMarker.GetAngleZ() + spawnMarker.GetHeadingAngle(TestRespecMarker))
			Utility.wait(0.6)
			Curie.MoveTo(spawnMarker)
			spawnMarker.Disable()
			spawnMarker.Delete()
		endif
		Utility.wait(1.0)
		Curie.SetRestrained(false)
		Curie.SetPosition(posdata[0],posdata[1],posdata[2])
	else ; Use pc as anchor
		Trace("Abnormal. Using pc as anchor")
		float distance = pc.GetDistance(Curie)
		posdata = TraceCircle(pc, 150)
		if Curie.Is3DLoaded()
			Curie.SetPosition(posdata[0],posdata[1],posdata[2])
			Utility.wait(0.6)
			Curie.MoveToNearestNavmeshLocation()
			Utility.wait(0.6)
			Curie.SetAngle(0.0,0.0, Curie.GetAngleZ() + Curie.GetHeadingAngle(pc))				
			Utility.wait(0.6)
		else
			Form InvisibleGeneric01 = Game.GetForm(0x00024571)
			ObjectReference spawnMarker = pc.PlaceAtMe(InvisibleGeneric01)
			spawnMarker.SetPosition(posdata[0],posdata[1],posdata[2])
			Utility.wait(0.6)
			spawnMarker.MoveToNearestNavmeshLocation()
			Utility.wait(0.6)
			spawnMarker.SetAngle(0.0,0.0, spawnMarker.GetAngleZ() + spawnMarker.GetHeadingAngle(pc))				
			Utility.wait(0.6)
			Curie.MoveTo(spawnMarker)
			Utility.wait(1.0)
			spawnMarker.Disable()
			spawnMarker.Delete()
		endif			
	endif

	Actor mrSubtitleOverride = pSubtitleOverride.GetActorReference()
	mrSubtitleOverride.Enable()
	if (pc.GetDistance(mrSubtitleOverride) > 240)
		posdata = TraceCircle(pc, -150)
		mrSubtitleOverride.SetPosition(posdata[0],posdata[1],posdata[2])
		Utility.wait(0.6)
		mrSubtitleOverride.MoveToNearestNavmeshLocation()
		Utility.wait(0.6)			
	endif

	Actor Codsworth = pCodsworth.GetActorReference()
	if (Codsworth)
		Trace("Codsworth Found")	
		if !(Codsworth.IsInFaction(pCurrentCompanionFaction) && Codsworth.Is3DLoaded() && pc.GetDistance(Codsworth) < 600)
			Trace("Codsworth Not follower or too far away. Ignoring")	
			Codsworth = None
		else
			Trace("Including Codsworth")	
		endif
	else
		Trace("Codsworth Not Found")	
	endif
	
	if Codsworth
		; Silence Codseworth
		Codsworth.SetOverrideVoiceType(Curie.GetVoiceType())
	endif

	Game.FadeOutGame(false, true, 1.0, 1.0)
	Utility.wait(1.0)

	ILayer.EnablePlayerControls()
	ILayer.Delete()
	ILayer = None

	TweakCOMSpouseCurieComment.Start()		
	
EndFunction

Function RescueSpouseCurieCommentFinished()

	Trace("RescueSpouseCurieComment()")
	; return quickly so that scene can end...
	Var[] params = new Var[0]
	self.CallFunctionNoWait("RescueSpouseCurieCommentFinishedHelper", params)
	return
	
EndFunction

Function RescueSpouseCurieCommentFinishedHelper()

	Trace("RescueSpouseCurieCommentFinishedHelper()")
	
	Actor Curie = pCurie.GetActorReference()
	Actor pc = Game.GetPlayer()
	Actor Spouse = pSpouse.GetActorReference()
	
	if (1 == (Spouse.GetBaseObject() as ActorBase).GetSex())
		; Spouse is Nora
		pc.AddItem(TweakCOM_HolotapeCurie)
	else
		; Spouse is Nate
		pc.AddItem(TweakCOM_HolotapeCurieM)
	endif
		

	if pc.IsInScene()
		Trace("Waiting for PC to exit Scene")
		int maxwait = 5
		while (pc.IsInScene() && maxwait > 0)
			Utility.wait(1)
			maxwait -= 1
		endwhile
		if (maxwait == 0)
			Trace("Timed Out")
		else
			Trace("PC no longer in scene")
		endif		
	endif
	if Curie && Curie.IsInScene()
		Trace("Waiting for Curie to exit Scene")
		int maxwait = 5
		while (Curie.IsInScene() && maxwait > 0)
			Utility.wait(1)
			maxwait -= 1
		endwhile
		if (maxwait == 0)
			Trace("Timed Out")
		else
			Trace("Curie no longer in scene")
		endif		
	endif
	if Curie && Curie.IsTalking()
		Trace("Waiting for Curie to stop talking")
		int maxwait = 8
		while (Curie.IsTalking() && maxwait > 8)
			Utility.wait(1)
			maxwait -= 1
		endwhile
		if (maxwait == 0)
			Trace("Timed Out")
		else
			Trace("Curie is no longer talking")
		endif		
	endif

	Actor mrSubtitleOverride = pSubtitleOverride.GetActorReference()
	mrSubtitleOverride.Disable()
	
	Actor Codsworth = pCodsworth.GetActorReference()
	if Codsworth
		; Re-enable Codsworth voice...
		Codsworth.SetOverrideVoiceType(None)
	endif
	
	TweakAllowLoiter.SetValue(PrevAllowedLoiter)
	TweakNoIdle.SetValue(PrevNoIdle)
	TweakCurieHandoff.Show()	
		
EndFunction

Function ExitVaultReaction()

	Trace("ExitVaultReaction()")

	Actor theSpouse = pSpouse.GetActorReference()
	if !theSpouse
		Trace("Spouse Alias unfilled. Bailing()")
		return
	endif
	
	ILayer = InputEnableLayer.Create()
	ILayer.DisablePlayerControls(abMovement = true, abFighting = true, abCamSwitch = false, abLooking = false, abSneaking = true, \
								 abMenu = true, abActivate = false, abJournalTabs = true, abVATS = true, abFavorites = true)

	; Prevent Companions from interrupting scene....
	PrevAllowedLoiter = TweakAllowLoiter.GetValue()
	TweakAllowLoiter.SetValue(0.0)
	PrevNoIdle        = TweakNoIdle.GetValue()
	TweakNoIdle.SetValue(1.0)
	theSpouse.SetRestrained(true)
	theSpouse.BlockActivation(true,true)
								 
	Actor pc = Game.GetPlayer()
	Form InvisibleGeneric01 = Game.GetForm(0x00024571)
	ObjectReference spawnMarker = pc.PlaceAtMe(InvisibleGeneric01)
	
	float horizon = 120.0

	; After the pc leaves the vaule, the cameras will not work 
	; until the player moves. It may be related to the fact that the spawnmarker
	; is on an elevator platform. 

	float[] pcposdata = TraceCircle(pc, 25)
	spawnMarker.SetPosition(pcposdata[0],pcposdata[1],pcposdata[2]+3)
	spawnMarker.SetAngle(0.0,0.0, horizon)	
	pc.TranslateToRef(spawnMarker,500.0)	
	Utility.wait(0.5)
	float[] spousedata = TraceCircle(pc, 85)
	theSpouse.SetPosition(spousedata[0],spousedata[1],(spousedata[2]))
	theSpouse.SetAngle(0.0,0.0, horizon)
			
	Utility.wait(0.5)

	TweakMUSMemory.Add()

	; Remove Temporary Follower AI
	FollowPlayer.Clear()
	
	; Technically, the player could dismiss anyone while in the vault. We can only
	; Count on the spouse at this point...
	
	Actor Curie = pCurie.GetActorReference()
	if (Curie)
		Trace("Curie Found")	
		if Curie.IsInFaction(pCurrentCompanionFaction)
			; Wait up to 2.0 seconds for 3d to load
			if (!Curie.Is3DLoaded())
				int maxwait = 10
				while (!Curie.Is3DLoaded() && maxwait > 0)
					maxwait -= 1
				endwhile
			endif
			if !(Curie.Is3DLoaded() && pc.GetDistance(Curie) < 500)
				Trace("Curie out of range")	
				Curie = None
			else
				Trace("Including Curie")	
			endif
		endif
	endif
	Actor Codsworth = pCodsworth.GetActorReference()
	if (Codsworth)
		Trace("Codsworth Found")
		if Codsworth.IsInFaction(pCurrentCompanionFaction)
			; Wait up to 2.0 seconds for 3d to load
			if (!Codsworth.Is3DLoaded())
				int maxwait = 10
				while (!Codsworth.Is3DLoaded() && maxwait > 0)
					maxwait -= 1
				endwhile
			endif
			if !(Codsworth.Is3DLoaded() && pc.GetDistance(Codsworth) < 500)
				Trace("Codsworth out of range")	
				Codsworth = None
			else
				Trace("Including Codsworth")	
			endif
		endif
	endif

	if Curie && Curie.IsInFaction(pCurrentCompanionFaction)
		float[] posdata = TraceCircle(pc, 180, -100)     ;
		Curie.SetPosition(posdata[0],posdata[1],(posdata[2]))
		Curie.SetAngle(0.0,0.0, horizon)
	endif
	if Codsworth && Codsworth.IsInFaction(pCurrentCompanionFaction)
		float[] posdata = TraceCircle(pc, 180, 100)     ;
		Codsworth.SetPosition(posdata[0],posdata[1],(posdata[2]))
		Codsworth.SetAngle(0.0,0.0, horizon)
	endif
	Utility.wait(0.06)
			
	Topic Breathing = Game.GetForm(0x0007B298) as Topic
	if !Breathing
		Breathing = Game.GetForm(0x0007B299) as Topic
	endif

	Trace("Applying Temporary Sound settings")
	TweakCSRescue.Push()	
	Utility.wait(0.1)
	
	theSpouse.Say(Breathing) ; async
	spawnMarker.SetPosition(spousedata[0],spousedata[1],(spousedata[2]))
	spawnMarker.SetAngle(0.0,0.0, horizon)	
	theSpouse.TranslateToRef(spawnMarker,100.0)	
	Utility.wait(3.0)
	
	spawnMarker.Disable()
	spawnMarker.Delete()
	
	ILayer.EnablePlayerControls()
	ILayer.Delete()
	ILayer = None
	theSpouse.SetRestrained(false)
	theSpouse.BlockActivation(false,false)
	
	theSpouse.AllowCompanion(false)
	TweakCOMSpouseExitVault.Start()
EndFunction

Function ExitVaultReactionFinished()
	Trace("ExitVaultReactionFinished()")
	Actor theSpouse = pSpouse.GetActorReference()
	
	UnRegisterForRemoteEvent(theSpouse, "OnLoad")
	
	theSpouse.AllowCompanion(false)
	if IsStageDone(38)
		theSpouse.SetAvailableToBeCompanion()
		theSpouse.AddToFaction(pHasBeenCompanionFaction)
	elseif IsStageDone(39)
		theSpouse.SetValue(pCA_Affinity,5.0)
		theSpouse.SetCompanion()
	endif

	TweakAllowLoiter.SetValue(PrevAllowedLoiter)
	TweakNoIdle.SetValue(PrevNoIdle)
	TweakCSRescue.Remove()

	if !Min02.IsStageDone(100)
		If Min02.IsRunning()
			RegisterForRemoteEvent(Min02, "OnStageSet") 
		else
			RegisterForRemoteEvent(Min02, "OnQuestInit") 
		endif
	endif
	if !MQ206.IsStageDone(400)
		If MQ206.IsRunning()
			RegisterForRemoteEvent(MQ206, "OnStageSet") 
		else
			RegisterForRemoteEvent(MQ206, "OnQuestInit") 
		endif
	endif	
	if !MQ207.IsStageDone(1)
		If MQ207.IsRunning()
			RegisterForRemoteEvent(MQ207, "OnStageSet") 
		else
			RegisterForRemoteEvent(MQ207, "OnQuestInit") 
		endif
	endif
	
EndFunction

Event Quest.OnQuestInit(Quest rQuest)
	Trace("OnQuestInit [" + rQuest + "]")
	if (rQuest == Min02)
		Trace("Registering for Min02 Stage 100")
		UnRegisterForRemoteEvent(Min02, "OnQuestInit")
		RegisterForRemoteEvent(Min02, "OnStageSet")
	endif		
	if (rQuest == MQ206)
		UnRegisterForRemoteEvent(MQ206, "OnQuestInit")
		RegisterForRemoteEvent(MQ206, "OnStageSet")
	endif		
	if (rQuest == MQ207)
		UnRegisterForRemoteEvent(MQ207, "OnQuestInit")
		RegisterForRemoteEvent(MQ207, "OnStageSet")
	endif		
EndEvent

Event Quest.OnStageSet(Quest rQuest, int rStageID, int rItemID)
	Trace("OnStageSet [" + rQuest + "] StageID [" + rStageID + "]")
	if ((rQuest == Min02) && (100 == rStageID))
		Trace("Min02 Stage 100 Detected. Setting GreetAllowed to 1")
		UnRegisterForRemoteEvent(Min02, "OnStageSet")
		; Kick off forcegreet for spouse.
		Actor theSpouse = pSpouse.GetActorReference()
		if !theSpouse
			Trace("Spouse Alias unfilled. Bailing()")
			return
		endif
		if (theSpouse.IsInFaction(pCurrentCompanionFaction) && theSpouse.Is3DLoaded())
			TweakSpouseGreetAllowed.SetValue(1)
			theSpouse.SetValue(pCA_WantsToTalk,1.0)
		endif
	endif
	; BUG: Stage MQ206:400 never fires. Appears to be a bug or 
    ;      oversight. 375 does, but all the faction specific 
	;      scientist leads are owned by different quests. So 
	;      either the spouse says their line when it is 
	;      powered up or we register for 3 stages on 3 quests
	;      to detect when the player says "Okay" to "Are you ready"
	;      conversation... We just change this to 375....
	if ((rQuest == MQ206) && (375 == rStageID))
		UnRegisterForRemoteEvent(MQ206, "OnStageSet")
		; Kick off forcegreet for spouse.
		Actor theSpouse = pSpouse.GetActorReference()
		if !theSpouse
			Trace("Spouse Alias unfilled. Bailing()")
			return
		endif		
		if (theSpouse.IsInFaction(pCurrentCompanionFaction) && theSpouse.Is3DLoaded())
			TweakSpouseGreetAllowed.SetValue(2)
			theSpouse.SetValue(pCA_WantsToTalk,1.0)
		endif
	endif
	if ((rQuest == MQ207) && (1 == rStageID))
		UnRegisterForRemoteEvent(MQ207, "OnStageSet")
		; Kick off forcegreet. This will be active next time 
		Actor theSpouse = pSpouse.GetActorReference()
		if !theSpouse
			Trace("Spouse Alias unfilled. Bailing()")
			return
		endif
		if (theSpouse.IsInFaction(pCurrentCompanionFaction))
			TweakSpouseGreetAllowed.SetValue(3)
			theSpouse.SetValue(pCA_WantsToTalk,1.0)
		endif
	endif	
EndEvent
	
Function FinishSpouseConvo()
	TweakSpouseGreetAllowed.SetValue(0)
	Actor theSpouse = pSpouse.GetActorReference()
	if !theSpouse
		Trace("Spouse Alias unfilled. Bailing()")
		return
	endif
	theSpouse.SetValue(pCA_WantsToTalk,0.0)
EndFunction	
	
Function EnableMS19()
	Trace("EnableMS19()")
	
	; Called by scenes (Stage Fragments) that wish to make use of MS19 audio
	if (1200 == MS19.GetCurrentStageID() && !MS19.IsRunning())
	
		; TODO: If this works, can we reset important stages
		Trace("MS19 Complete. Attempting to Reset")
		MS19.Start()
		Utility.wait(1.0)
		if MS19.IsRunning()
			Trace("MS19 Running")
			Trace("STAGEID : [" + MS19.GetCurrentStageID() + "]")
			MS19.Reset()
			Utility.wait(1.0)
			Trace("STAGEID : [" + MS19.GetCurrentStageID() + "] (After Reset)")
		else
			Trace("Start Failed. Attempting Reset ANYWAY")
			Trace("STAGEID : [" + MS19.GetCurrentStageID() + "]")
			MS19.Reset()
			Utility.wait(1.0)
			Trace("STAGEID : [" + MS19.GetCurrentStageID() + "] (After Reset)")
		endif
	else
		Trace("MS19 is currently running")
	endif

	; ALTERNATIVE WOULD BE TO REGISTER FOR STAGE_CHANGES SO WE CAN INTERCEPT
	; the stage before stop() and reset(). However that would require us to
	; be running before the quest was done...
	
EndFunction

Function ResetAffinityScene()
	Trace("ResetAffinityScene")
	Actor Spouse = pSpouse.GetActorReference()
	if Spouse
		if (0.0 == Spouse.GetValue(pCA_WantsToTalk))
			Spouse.SetValue(pCA_AffinitySceneToPlay, 0)
			Trace("AffinityScene Reset")
		else
			Trace("Skipping AffinityScene Reset. Spouse wants to talk...")
		endif
	else
		Trace("Spouse Not Defined yet")	
	endif
EndFunction

Function SpawnSpouse(bool currentCompanion=true)

	Actor pc = Game.GetPlayer()
	
	int spouseGender = 1
	if MQ102SpouseCorpseMaleREF && MQ102SpouseCorpseMaleREF.IsEnabled()
		spouseGender = 0
		if (MQ102SpouseCorpseMaleREF as Actor)
			if !(MQ102SpouseCorpseMaleREF as Actor).IsInFaction(pCurrentCompanionFaction)
				MQ102SpouseCorpseMaleREF.Disable()
			endif
		else
			MQ102SpouseCorpseMaleREF.Disable()
		endif
	elseif MQ102SpouseCorpseFemaleREF && MQ102SpouseCorpseFemaleREF.IsEnabled()
		spouseGender = 1
		if (MQ102SpouseCorpseFemaleREF as Actor)
			if !(MQ102SpouseCorpseFemaleREF as Actor).IsInFaction(pCurrentCompanionFaction)
				MQ102SpouseCorpseFemaleREF.Disable()
			endif			
		else
			MQ102SpouseCorpseFemaleREF.Disable()
		endif
	elseif (1 == (pc.GetBaseObject() as ActorBase).GetSex())
		; The PLAYER is female, so assume MALE Spouse
		spouseGender = 0
	else
		; If all else fails, assume female spouse...
		spouseGender = 1
	endif
		
	Actor theSpouse
	float[] posdata = TraceCircle(pc, -125)
	Form InvisibleGeneric01 = Game.GetForm(0x00024571)
	ObjectReference spawnMarker = pc.PlaceAtMe(InvisibleGeneric01)
	spawnMarker.SetPosition(posdata[0],posdata[1],posdata[2])
	spawnMarker.MoveToNearestNavmeshLocation()
	Utility.wait(0.1)
	
	; After the pc leaves the vaule, the cameras will not work 
	; until the player moves. It may be related to the fact that the spawnmarker
	; is on an elevator platform. 

	
	; Gender : 0 = male, 1 = female, -1 = None
	if (0 == spouseGender)
	
		Actor Nate = pTweakCompanionNate.GetUniqueActor()
		if !Nate
			; We create the spouse on the fly because if we hard code
			; into the game, they dont pick up changes to the ActorBase
			Trace("Creating Nate")		
			Nate = spawnMarker.PlaceActorAtMe(pTweakCompanionNate)
		else
			Trace("Nate already exists")	
			Nate.MoveTo(spawnMarker)
		endif
		if Nate
			theSpouse = Nate
		else
			Trace("Nate Creation Failure")
		endif
	else
			
		Actor Nora = pTweakCompanionNora.GetUniqueActor()
		if !Nora
			Trace("Creating Nora")		
			Nora = spawnMarker.PlaceActorAtMe(pTweakCompanionNora)
			; We create the spouse on the fly because if we hard code
			; into the game, they dont pick up changes to the ActorBase
		else
			Trace("Nora already exists")		
			Nora.MoveTo(spawnMarker)
		endif
		if Nora
			theSpouse = Nora
		else
			Trace("Nora Creation Failure")
		endif
	
	endif
	
	if theSpouse
		pSpouse.ForceRefTo(theSpouse)
		
		theSpouse.SetValue(pCA_Affinity, 5.0)
		
		if (currentCompanion)
			SetCurrentStageID(39)
			theSpouse.SetCompanion()	
		else
			SetCurrentStageID(38)
			theSpouse.SetAvailableToBeCompanion()
			theSpouse.AddToFaction(pHasBeenCompanionFaction)	
		endIf
	
		if !Min02.IsStageDone(100)
			If Min02.IsRunning()
				RegisterForRemoteEvent(Min02, "OnStageSet") 
			else
				RegisterForRemoteEvent(Min02, "OnQuestInit") 
			endif
		endif
		if !MQ206.IsStageDone(400)
			If MQ206.IsRunning()
				RegisterForRemoteEvent(MQ206, "OnStageSet") 
			else
				RegisterForRemoteEvent(MQ206, "OnQuestInit") 
			endif
		endif	
		if !MQ207.IsStageDone(1)
			If MQ207.IsRunning()
				RegisterForRemoteEvent(MQ207, "OnStageSet") 
			else
				RegisterForRemoteEvent(MQ207, "OnQuestInit") 
			endif
		endif
	endif
	
endFunction

; AngleOffset:
;   90     = Player/Objects left. 
;  -90     = Player/Objects right, 
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
    if (a > 360)
        a = a - 360
    endif 
	return a
EndFunction