Scriptname AFT:TweakMemoryLoungerScript extends Quest

Quest Property pTweakFollower Auto Const
ReferenceAlias Property pPlayerTV Auto Const
ReferenceAlias Property pTransmitter Auto Const
ReferenceAlias Property pSpouseMale Auto Const
ReferenceAlias Property pSpouseFemale Auto Const
ReferenceAlias Property pActiveSpouse Auto Const
ReferenceAlias Property pBabyActivator Auto Const
ReferenceAlias Property pExtVaultElevator Auto Const
ReferenceAlias Property pPlayerHouseRadio Auto Const
ReferenceAlias Property pFallout4VR Auto Const
Keyword Property LinkVehicle Auto Const
Message Property pTweakAmbiguous Auto Const

ObjectReference Property MQ101_NpcCouchPlayerHouseSit01 Auto Const
ObjectReference Property MQ101PlayerCribFurnitureRef  Auto Const
ObjectReference Property NpcBedPlayerHouseLay01_NoActivate Auto Const
ObjectReference Property MQ101SpouseLeanREF Auto Const
ObjectReference Property MQ101RunnersEnableMarker Auto Const
ObjectReference Property ShaunBabyAudioRepeaterActivator Auto Const
ObjectReference Property ShaunIdleSoundMarkerREF Auto Const
ObjectReference Property pMQ101CrowdPanicSoundMarkerREF Auto Const
ObjectReference Property pMQ101AirRaidSirenMarkerREF Auto Const
ObjectReference Property pMQ101ShaunRoomCollisionEnableMArker Auto Const
ObjectReference Property pMQ101ShaunRoomCollisionEnableMArker002 Auto Const
ObjectReference Property pMQ101BabyRoomDoorCollisionREF Auto Const
ObjectReference Property pMQ101VaultTecVanAtHouseREF Auto Const
ObjectReference Property pMQ101VertibirdDREF Auto Const

ActorBase Property MQ101PlayerSpouseFemale Auto Const
ActorBase Property MQ101PlayerSpouseMale Auto Const
Message Property pTweakMemoryRangeWarning Auto Const
ObjectReference Property pAPC01 Auto Const
Static Property Suitcase_Prewar03 Auto Const

Sound Property MUSRadioInstituteElgarNimrod Auto Const
Sound Property MUSRadioInstituteBachSuiteInEMinorBWV996 Auto Const
Sound Property QSTMQ203MemoryDenMemoryEnter Auto Const
SoundCategorySnapShot Property TweakMuteVertibird Auto Const
Spell Property MQ203PlayerInvisibility Auto Const
GlobalVariable Property pTweakUsingMemoryLounger Auto Const

GlobalVariable  Property TimeScale Auto Const
GlobalVariable  Property GameHour  Auto Const
GlobalVariable  Property MQ101Debug  Auto Const

Weather Property CommonwealthSanctuaryClear Auto Const
WorldSpace Property SanctuaryHillsWorld Auto Const

; Race Property VertibirdRace Auto Const
; Keyword Property CharGenSpouseCommentEye Auto Const
; Keyword Property CharGenSpouseCommentHair Auto Const
; Keyword Property CharGenSpouseCommentMouth Auto Const
; Keyword Property CharGenSpouseMirrorWaitTopic Auto Const
; GlobalVariable Property FaceCommentRegion Auto Const

; No Need for music as we can't detect if music volume is turned 
; up or not. (Many people turn it down/off with so many other 
; music options in the game like the PipBoy). So we play scripted
; music directly to the player. (They can stop it by activating 
; the radio).
; MusicType Property TweakMUSMemory Auto Const 

; Private (persisted)

int              Property radioState Auto hidden
; ObjectReference  Property theMemoryLounger Auto hidden
int	             Property currentSongID Auto hidden
InputEnableLayer EnableLayer
ImageSpaceModifier Property MemoryLoungerEnterImod Auto Const

; Private (constants)

int EN_LEN        = 209 const ; seconds
int BS_LEN        = 194 const ; seconds
int TIMER_EN_DONE = 999 const
int TIMER_BS_DONE = 998 const

; Ugly, but the cost of using locked threads to expose this
; as a property was too much. So here we are breaking the
; DRY principle... sigh...

int pTweakMisc2ID = 10  const

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakMemoryLoungerScript"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

;--------------------------------------------
; Event Handlers
;--------------------------------------------

Event OnQuestInit()
	StartMemory()
EndEvent

Event OnTimer(int akTimer)
	if (akTimer < 6)
		Actor p = Game.GetPlayer()
		Trace("Boundary Monitor Fired... Z:" + p.Z)
		int nextTimer = akTimer
		
		; Y = Top/Bottom X = Left/Right
		if (p.Y < 79000) || (p.Y > 100000) || (p.X < -97000) || (p.X > -65000)		
			pTweakMemoryRangeWarning.Show()
			nextTimer += 1
		else
			nextTimer = 0
		endif		
		if (p.Z < 6400) || (5 == akTimer)
			FinishMemory()
			return
		endif
		if (p.GetWorldSpace() == SanctuaryHillsWorld)
			StartTimer(8,nextTimer)
		endif
		return
	endif
	if (TIMER_EN_DONE == akTimer)
		Trace("Fading into BachSuiteInEMinor")
		currentSongID = MUSRadioInstituteBachSuiteInEMinorBWV996.Play(Game.GetPlayer())
		StartTimer(BS_LEN,TIMER_BS_DONE)
		Sound.SetInstanceVolume(currentSongID, 0.6)
		radioState = 3
		return
	endif
	if (TIMER_BS_DONE == akTimer)
		Trace("Fading into ElgarNimrod")
		currentSongID = MUSRadioInstituteElgarNimrod.Play(Game.GetPlayer())
		StartTimer(EN_LEN,TIMER_EN_DONE)
		Sound.SetInstanceVolume(currentSongID, 0.6)
		radioState = 1	
		return
	endif	
EndEvent

int theComment = 0
	
; Radio Handler:
Event ObjectReference.OnActivate(ObjectReference akActivated, ObjectReference akActivator)
	Trace("OnActivate [" + akActivated + "]")
	ObjectReference theRadio = pPlayerHouseRadio.GetRef()
	if (theRadio == akActivated)
		if (1 == radioState)
			CancelTimer(TIMER_EN_DONE)
			Trace("Stopping ElgarNimrod")
			theRadio.SetRadioOn(false)
			Sound.StopInstance(currentSongID)			
			radioState = 2
		elseif (2 == radioState)
			Trace("Starting BachSuiteInEMinor")
			theRadio.SetRadioOn()
			theRadio.SetRadioVolume(0.0) ; We just use it as a prop...			
			currentSongID = MUSRadioInstituteBachSuiteInEMinorBWV996.Play(Game.GetPlayer())
			StartTimer(BS_LEN,TIMER_BS_DONE)
			Sound.SetInstanceVolume(currentSongID, 0.6)
			radioState = 3
		elseif (3 == radioState)
			CancelTimer(TIMER_BS_DONE)
			Trace("Stopping BachSuiteInEMinor")
			theRadio.SetRadioOn(false)
			Sound.StopInstance(currentSongID)			
			radioState = 4
		elseif (4 == radioState)
			Trace("Starting ElgarNimrod")
			theRadio.SetRadioOn()
			theRadio.SetRadioVolume(0.0) ; We just use it as a prop...
			currentSongID = MUSRadioInstituteElgarNimrod.Play(Game.GetPlayer())
			StartTimer(EN_LEN,TIMER_EN_DONE)
			Sound.SetInstanceVolume(currentSongID, 0.6)
			radioState = 1
		endif
		return
	endif
	ObjectReference theMemoryLounger = pFallout4VR.GetRef()
	if (theMemoryLounger == akActivated)
		UnregisterForRemoteEvent(theMemoryLounger,"OnActivate")
		FinishMemory()
		return
	endif
	; Never could get the activate to work on spouse...
	if (pActiveSpouse.GetRef() == akActivated)
	
		Trace("Activated Spouse. Attempting Compliment")
		Actor aSpeaker = pActiveSpouse.GetActorReference()
		
		Topic available = None		
		theComment += 1
		Trace("Comment [" + theComment + "]")
		if (1 == theComment)
			available  = Game.GetForm(0x000F03E2) as Topic ; "Hmm.. Still pretty early" 
		elseIf (2 == theComment)
			available  = Game.GetForm(0x0019594A) as Topic ; "Looks like the milk got delivered"
		elseIf (3 == theComment)
			available  = Game.GetForm(0x0019594B) as Topic ; "*sigh* Never going to find that dog"
		elseIf (4 == theComment)
			available  = Game.GetForm(0x0019594C) as Topic ; "Wonder what shaun will grow up to be?"
		elseIf (5 == theComment)
			available  = Game.GetForm(0x00195942) as Topic ; "hehe. To think, one day he's gonna learn how to drive."
		elseIf (6 == theComment)
			available  = Game.GetForm(0x00195943) as Topic ; "We really need to get those vacation photos developed"
		elseIf (7 == theComment)
			available  = Game.GetForm(0x000F03E4) as Topic ; "Wish I had more time to read"
		else
			theComment = 0
			available  = Game.GetForm(0x0010279C) as Topic ; "Hmm... more of the same"
		endif

		if (0 == theComment)
			aSpeaker.SetHeadTracking(false)
		else
			aSpeaker.SetHeadTracking(true)
		endif
		
		if available
			Utility.wait(0.3)
			aSpeaker.Say(available)
			Utility.wait(1.0)
			int maxwait = 20
			while (aSpeaker.IsTalking() && maxwait > 0)
				Trace("Waiting for talking to stop...")
				Utility.wait(0.5)
				maxwait -= 1
			endwhile
		endif
		
		return
	endif
EndEvent

; TV Handlers
Event ObjectReference.OnLoad(ObjectReference akObjectLoading)
	Trace("TV OnLoad")
	ObjectReference theTV = pPlayerTV.GetRef()
	if (akObjectLoading == theTV)
		theTV.playAnimation("com")
		RegisterForAnimationEvent(theTV, "comEnd")
	endif
EndEvent

Event ObjectReference.OnUnLoad(ObjectReference akObjectLoading)
	Trace("TV OnUnLoad")
	ObjectReference theTV = pPlayerTV.GetRef()
	if (akObjectLoading == theTV)
		UnregisterForAnimationEvent(theTV, "comEnd")
	endif
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	Trace("TV OnAnimationEvent [" + asEventName + "]")
	If akSource == pPlayerTV.GetRef() && asEventName == "comEnd"
		pPlayerTV.GetRef().playAnimation("com")
	EndIf
EndEvent
			 
Function StartMemory()
	Trace("StartMemory()")

	Actor player = Game.GetPlayer()
	
	Trace("Disable Controls()")
	EnableLayer = InputEnableLayer.Create()
	EnableLayer.DisablePlayerControls(abMovement = false, abFighting = true, abCamSwitch = true, abLooking = false, abSneaking = true, \
		abMenu = true, abActivate = false, abJournalTabs = true, abVATS = true, abFavorites = true)
	
	Trace("Start Fade Out + FX()")
	MemoryLoungerEnterImod.Apply()
	Game.FadeOutGame(abFadingOut=True, abBlackFade=False, afSecsBeforeFade=0.0, afFadeDuration=3.0, abStayFaded=True)
	QSTMQ203MemoryDenMemoryEnter.Play(Game.GetPlayer())
	Trace("updating GameHour")
	GameHour.SetValueInt(9)

	Utility.Wait(5.0)	
	player.MoveTo( MQ101PlayerCribFurnitureRef )
		
	Trace("Mute Vertibirds with Sound Settings Overlay...")
	TweakMuteVertibird.Push()
		
	; This doesn't work, but it seems to unlock mouse look
	; after teleport...
	player.SetAngle(30,0,player.GetAngleZ())
	
	; Disable MemoryHUDMode so they can see Messages
	Game.SetInsideMemoryHUDMode(false)
			
	Trace("Enabling Baby")
	;enable crib sounds
	ShaunBabyAudioRepeaterActivator.Enable()
	ShaunIdleSoundMarkerREF.Enable()
	pMQ101BabyRoomDoorCollisionREF.Disable()
	pBabyActivator.GetRef().Enable()
	
	Trace("Fixing Weather")
	Weather.ReleaseOverride()
	Utility.wait(0.3)
	CommonwealthSanctuaryClear.ForceActive(true)
	
	; Remember, many users turn their music all the way down.
	; So have radio at the ready for that case...
	
	ObjectReference theRadio = pPlayerHouseRadio.GetRef()
	Trace("Start Radio")
	theRadio.SetRadioOn()
	theRadio.SetRadioVolume(0.0) ; We just use it as a prop...
	currentSongID = MUSRadioInstituteElgarNimrod.Play(Game.GetPlayer())
	StartTimer(EN_LEN,TIMER_EN_DONE)
	Sound.SetInstanceVolume(currentSongID, 0.6)
	radioState = 1
	RegisterForRemoteEvent(theRadio,"OnActivate")
	
	Game.FadeOutGame(abFadingOut=False, abBlackFade=False, afSecsBeforeFade=0.0, afFadeDuration=3.0, abStayFaded=False)
	
	Trace("Turn on TV")
	ObjectReference theTV = pPlayerTV.GetRef()
	theTV.playAnimation("com")
	RegisterForAnimationEvent(theTV, "comEnd")
	RegisterForRemoteEvent(theTV,"OnUnload")
	RegisterForRemoteEvent(theTV,"OnLoad")
	ObjectReference theTVAudio = pTransmitter.GetRef()
	theTVAudio.Enable()
	
	Trace("Create Return Memory Lounger")	
	ForceRemove(NpcBedPlayerHouseLay01_NoActivate)
	Form NPCMemoryLounger01 = Game.GetForm(0x000CA06D)
	ObjectReference theMemoryLounger = MQ101RunnersEnableMarker.PlaceAtMe(NPCMemoryLounger01)
	theMemoryLounger.SetPosition(-80676.781250, 90669.992188, 7852.659180)
	theMemoryLounger.SetAngle(0.0,0.0,140.856110)
	; Rename It
	pFallout4VR.ForceRefTo(theMemoryLounger)
	theMemoryLounger.SetActivateTextOverride(pTweakAmbiguous)
	RegisterForRemoteEvent(theMemoryLounger,"OnActivate")
	
	Trace("Clean Up Town")	
	RemoveUniqueActor(0x000BDDFB,"MQ101MrAble")
	RemoveUniqueActor(0x000BDE07,"MQ101MrDonoghue")
	RemoveUniqueActor(0x0011E794,"MQ101MrRussell")
	RemoveNonUniqActor(player, 0x0011E355,"MQ101MrSmith")
	RemoveUniqueActor(0x0011E78E,"MQ101MrWhitfield")
	RemoveUniqueActor(0x000BDDFD,"MQ101MrsAble")
	RemoveUniqueActor(0x000BDE09,"MQ101MrsDonoghue")
	RemoveUniqueActor(0x0011E78D,"MQ101MrsWhitfield")
	RemoveUniqueActor(0x001E9922,"MQ101FenceNPCM05")
	RemoveUniqueActor(0x001E9921,"MQ101FenceNPCF04")
	RemoveUniqueActor(0x001E991E,"MQ101FenceNPCF03")
	RemoveUniqueActor(0x001E991D,"MQ101FenceNPCM04")
	RemoveUniqueActor(0x001E991A,"MQ101FenceNPCM03")
	RemoveUniqueActor(0x001E9917,"MQ101FenceNPCF02")
	RemoveUniqueActor(0x001E9916,"MQ101FenceNPCM02")
	RemoveUniqueActor(0x001E9913,"MQ101FenceNPCF01")
	RemoveUniqueActor(0x001E990C,"MQ101FenceNPCM01")
	RemoveUniqueActor(0x00198B77,"MQ101NeighborMale03Respawner")
	RemoveUniqueActor(0x00198B76,"MQ101NeighborFemale03Respawner")
	RemoveUniqueActor(0x0011F99A,"MQ101MrsSumner")
	RemoveUniqueActor(0x0011F999,"MQ101MrSumner")
	RemoveUniqueActor(0x0011E357,"MQ101NeighborFemale09")
	RemoveUniqueActor(0x0011E356,"MQ101NeighborFemale08")
	RemoveUniqueActor(0x000DDB99,"MQ101NeighborMale07")
	RemoveUniqueActor(0x000DDB97,"MQ101NeighborFemale07")
	RemoveUniqueActor(0x000D3896,"MQ101NeighborFemale06") ; Not Used in PC Version
	RemoveUniqueActor(0x000D3895,"MQ101NeighborMale06")   ; Not Used in PC Version
	RemoveUniqueActor(0x000D388C,"MQ101NeighborFemale05") ; Not Used in PC Version
	RemoveUniqueActor(0x000D388B,"MQ101NeighborMale05")   ; Not Used in PC Version
	RemoveUniqueActor(0x000D2BDB,"MQ101NeighborFemale02")
	RemoveUniqueActor(0x000D2BDA,"MQ101NeighborMale02")
	RemoveUniqueActor(0x000D2BD7,"MQ101NeighborFemale01")
	RemoveUniqueActor(0x000D2BD6,"MQ101NeighborMale01")
	RemoveUniqueActor(0x000D2BD6,"MQ101NeighborMale01")
	RemoveUniqueActor(0x000C317C,"MQ101RosaSon")
	RemoveUniqueActor(0x000BDE10,"MQ101MrsWashington")
	RemoveUniqueActor(0x000BDE0F,"MQ101MrWashington")
	RemoveUniqueActor(0x000BDE03,"MQ101MrsParker")
	RemoveUniqueActor(0x000BDE01,"MQ101MrParker")
	RemoveUniqueActor(0x000BDDF8,"MQ101Rosa")
	RemoveUniqueActor(0x001974EB,"MQ101UniformSoldier03")
	RemoveUniqueActor(0x000CB1B8,"MQ101ListCheckerSoldier")	
	RemoveNonUniqActor(player, 0x001974E9,"MQ101PowerArmorSoldierWithLaser") ; Need Something Closer...
	RemoveUniqueActor(0x0011D83E,"MQ101UniformSoldierPointer02")
	RemoveUniqueActor(0x0011D83C,"MQ101UniformSoldierPointer01")
	RemoveUniqueActor(0x000D2BE4,"MQ101UniformSoldier02")
	RemoveUniqueActor(0x000CB1A6,"MQ101UniformSoldier01")
	RemoveNonUniqActor(player, 0x000BBF7E,"MQ101PowerArmorSoldierMale")
	RemoveUniqueActor(0x000ABF9E,"MQ101VaultTecRep")
	RemoveNonUniqActor(player, 0x001EC1EE,"Suitcase_Prewar03")
	RemoveUniqueActor(0x0019CD12,"MQ101UniformSoldierPilot", true)
	
	ForceRemove(pAPC01)
	ForceRemove(pMQ101VaultTecVanAtHouseREF)
	ForceRemove(pMQ101VertibirdDREF)
	
	Static PreWarFenceChainLinkGateStatic01 = Game.GetForm(0x0001978F) as Static
	if PreWarFenceChainLinkGateStatic01
		ObjectReference result = Game.FindClosestReferenceOfType(PreWarFenceChainLinkGateStatic01, 91473.2656, 91117.2109, 8792.3672, 30)
		if result			
			Trace("Found PreWarFenceChainLinkGate")
			forceRemove(result)
		endif
	else
		Trace("Cast to PreWarFenceChainLinkGateStatic01 Failed")
	endif
	Static CollisionMarker  = Game.GetForm(0x00000021) as Static
	if (CollisionMarker)
		ObjectReference result = Game.FindClosestReferenceOfType(CollisionMarker, 91444.2813, 91092.5391, 8888.0547, 30)
		if (result)
			Trace("Found CollisionMarker")
			forceRemove(result)
		else
			Trace("Did not find CollisionMarker")
		endif
	else
		Trace("Cast to Collisionmarker Failed")
	endif	
	
	pMQ101CrowdPanicSoundMarkerREF.Disable()
	pMQ101AirRaidSirenMarkerREF.Disable()
	pMQ101ShaunRoomCollisionEnableMArker.Disable()
	pMQ101ShaunRoomCollisionEnableMArker002.Disable()				
	;set the Vault Elevator to be in correct position
	pExtVaultElevator.GetRef().PlayAnimation("Stage5")	
	
	Trace("Resurrect Spouse and place infront of TV")	
	Outfit SpouseOutfit = None
	Actor SpouseREF = None
	if (player.GetActorBase().GetSex() == 0) ; Player was Male, so Spouse is female
		SpouseOutfit = Game.GetForm(0x000EED32) as Outfit ; MQ101PrewarOutfittPlayerSpouseFemale
		SpouseREF = pSpouseFemale.GetActorReference()
		if !SpouseREF
			Trace("Unable to locate Female Spouse. Using Unique")
			SpouseREF = MQ101PlayerSpouseFemale.GetUniqueActor()
		endif		
		if !SpouseREF
			Trace("Female doesn't exist. Trying male")
			SpouseREF = pSpouseMale.GetActorReference()
		endif			
		if !SpouseREF
			Trace("Unable to locate Male Spouse. Using Unique")
			SpouseREF = MQ101PlayerSpouseMale.GetUniqueActor()
		endif
	else ; Female
		SpouseOutfit = Game.GetForm(0x000EE3E6) as Outfit ; MQ101PrewarOutfittPlayerSpouseMale	
		SpouseREF = pSpouseMale.GetActorReference()
		if !SpouseREF
			Trace("Unable to locate Male Spouse. Using Unique")
			SpouseREF = MQ101PlayerSpouseMale.GetUniqueActor()
		endif				
		if !SpouseREF
			Trace("Male doesn't exist. Trying female")
			SpouseREF = pSpouseFemale.GetActorReference()
		endif			
		if !SpouseREF
			Trace("Unable to locate Spouse. Using Unique")
			SpouseREF = MQ101PlayerSpouseFemale.GetUniqueActor()
		endif		
	endif
	if SpouseREF
		RegisterForRemoteEvent(SpouseRef,"OnActivate")
		SpouseREF.Disable()
		SpouseREF.Enable()
		SpouseREF.EnableAI()
		
		; SpouseREF.BlockActivation(false,true)
		SpouseREF.BlockActivation(false)
		
		Utility.wait(0.1)
		
		; Non-Teammates ignore EquipItem commands and revert
		; to outfits whenever they are unloaded.
		
		bool original_tm = SpouseREF.IsPlayerTeammate()
		if !original_tm
			SpouseREF.SetPlayerTeammate()
		endif
		SpouseREF.ChangeAnimFlavor(); Stop holding the baby
		SpouseREF.SetActivateTextOverride(None); Remove "Access Memory" override
		SpouseREF.SetOverrideVoiceType(None)   ; Allow them to talk again...		
		SpouseREF.SetOutfit(SpouseOutfit) ; Revert Outfit to original
		Armor ChargenPlayerClothes = Game.GetForm(0x00174D2F) as Armor
		
        ; IS THIS SAFE? (Not sure if spouse is a copy or not...)
		
		; SpouseREF.RemoveAllItems()
		SpouseREF.UnEquipAll()		
		SpouseREF.MoveTo(MQ101_NpcCouchPlayerHouseSit01,0,120,50)
		Utility.wait(2)
		SpouseREF.EquipItem(CharGenPlayerClothes, absilent=True)
		Utility.wait(0.1)
		SpouseREF.SnapIntoInteraction(MQ101_NpcCouchPlayerHouseSit01)
		pActiveSpouse.ForceRefTo(SpouseREF)
		if !original_tm
			SpouseREF.SetPlayerTeammate(false)
		endif
	else
		Trace("Unable to locate Spouse. Giving Up")
	endif
	
	Trace("Enabling Player. Starting Boundary Monitor")	
	
	MQ101PlayerCribFurnitureRef.Activate(player, true)

	; Load audio lines from MQ101PlayerComments
	LoadMQ101PlayerCommentsAudio()

	StartTimer(8,0)
	
	; Make Sure it is daytime, but dont wait longer than 
	; we need to. IE: If it is between 8:00 AM and 5:00 PM,
	; dont do anything...
	
	; slow clock ; (Dont call PassTime or waitGameTime after this..)
	TimeScale.SetValueInt(1)
EndFunction

Quest Property MQ101PlayerComments Auto Const

Function LoadMQ101PlayerCommentsAudio()

	Trace("LoadMQ101PlayerCommentsAudio()")
	Trace("  STAGEID : [" + MQ101PlayerComments.GetCurrentStageID() + "]")

    ; How does this work?
	; If a quest is running, then the associated audio is normally available.
	; If a quest is not running, but ran in the past, you can call Reset on it, 
	; and that will load its audio. 
	;
	; Normally you need to track if you have ever reset the quest so that 
	; you dont accidently start a quest that has never ran. However in this
	; case, the MOD functionality isn't available until after the prologue, 
	; so we can assume it has already ran. 
	; 
	; Note, this audio loading trick is not always safe, particularly
	; with MAIN QUESTS (MQ prefix). For example, other quests may check 
	; that the quest you reset is beyond a certain stage. The Prologue 
	; however is special in that there are not potential ordering issues, 
	; so other game scripts dont check this particular quest. This is 
	; also only useful for accessing audio that was available in the 
	; past. This trick isn't useful for accessing late game audio. 
	
	; Called by scenes (Stage Fragments) that wish to make use of MQ101PlayerComments audio
	if (!MQ101PlayerComments.IsRunning())
		if (1000 == MQ101PlayerComments.GetCurrentStageID())
			Trace("  Calling Start to unlock reset")
			; This shouldn't start it, but it will unlock it so that reset can work.
			MQ101PlayerComments.Start()
			Utility.wait(1.0)
			if MQ101PlayerComments.IsRunning()
				Trace("  UNEXPECTED : MQ101PlayerComments Running. Stopping.")
				MQ101PlayerComments.Stop() 
			endif			
		endif
		Trace("  Attempting Reset to load audio")
		MQ101PlayerComments.Reset()
		Utility.wait(1.0)
		Trace("  STAGEID AFER : [" + MQ101PlayerComments.GetCurrentStageID() + "]")
	else
		Trace("MQ101PlayerComments is currently running")
	endif
	
EndFunction

Function FinishMemory()
	Trace("FinishMemory()")	

	Trace(" - Fixing TimeScale (So Waits are safe to use again)")
	TimeScale.SetValueInt(20)
	
	CancelTimer(0)
	CancelTimer(1)
	CancelTimer(2)
	CancelTimer(3)
	CancelTimer(4)
	CancelTimer(5)
	CancelTimer(TIMER_EN_DONE)
	CancelTimer(TIMER_BS_DONE)
	
	TweakShelterScript pTweakShelterScript = (pTweakFollower AS TweakShelterScript)
	if (!pTweakShelterScript)
		; What if someone uninstalls mod while in Sanctuary?
		Trace("TODO: Implement backup if ShelterScript is not available")
		return
	endif
	
	Actor player = Game.GetPlayer()
	if (!EnableLayer)
		Trace("EnableLayer doesn't Exist. Creating new...")	
		EnableLayer = InputEnableLayer.Create()
	endif
	Trace("Disabling Player Controls")	
	EnableLayer.DisablePlayerControls(abMovement = false, abFighting = true, abCamSwitch = true, abLooking = false, abSneaking = true, \
		abMenu = true, abActivate = false, abJournalTabs = true, abVATS = true, abFavorites = true)
	Utility.wait(5.0)
	
	Trace("Kick Fade Out + FX()")	
	MemoryLoungerEnterImod.Apply()
	Game.FadeOutGame(abFadingOut=True, abBlackFade=False, afSecsBeforeFade=0.0, afFadeDuration=3.0, abStayFaded=True)
	Utility.Wait(5.0)

	Trace("Cleaning Up Memory:")
	Trace(" - Turn the Radio Off")	
	Sound.StopInstance(currentSongID)			
	
	Trace(" - Turn the TV Off")	
	ObjectReference theTV = pPlayerTV.GetRef()
	if (theTV)
		UnregisterForAnimationEvent(theTV, "comEnd")
		UnregisterForRemoteEvent(theTV,"OnUnload")
		UnregisterForRemoteEvent(theTV,"OnLoad")
	endif
	ObjectReference theTVAudio = pTransmitter.GetRef()
	if (theTVAudio)
		theTVAudio.Disable()
	endif
			
	ObjectReference AftCampChair = pTweakShelterScript.myObjectCache[pTweakMisc2ID]
	if !AftCampChair
		Trace("No Chair Found. Using Camp Travel map Marker")	
		ObjectReference AftCamp = pTweakShelterScript.pShelterMapMarker.GetReference()
		if !AftCamp
			; TODO: Need backup incase they save in Sanctuary and disable AFT...
			Trace("Well Shit... Looks like we are stuck....")
			return
		endif
			
		TweakMuteVertibird.Remove()
		player.MoveTo(AftCamp)
				
		Weather.ReleaseOverride()
		Utility.wait(3.0)			
	else
	
		Trace("Chair Found")	

		Trace("Removing Sound Effects Overlay")	
		TweakMuteVertibird.Remove()
		
		Trace("Moving Player back to Chair")			
		player.MoveTo(AftCampChair)
		
		; player.SnapIntoInteraction(AftCampChair)
		; close cover
		; AftCampChair.PlayAnimation("g_idleSitInstant")

		Trace("Fixing Weather (changing back incase they were in the glowing sea)")

		Weather.ReleaseOverride()
		Utility.wait(3.0)
	endif
		
	Trace("Cleanup Aliases and Temp Variables")
	ObjectReference SpouseREF = pActiveSpouse.GetRef()
	if SpouseREF
		Trace("Found SpouseRef. Cleaning up...")
		UnregisterForRemoteEvent(SpouseRef,"OnActivate")
		; SpouseREF.BlockActivation()
	endif
	ObjectReference theRadio = pPlayerHouseRadio.GetRef()
	UnregisterForRemoteEvent(theRadio,"OnActivate")	

	ObjectReference theMemoryLounger = pFallout4VR.GetRef()
	pFallout4VR.Clear()
	theMemoryLounger.SetActivateTextOverride(None)
	theMemoryLounger.Disable()
	theMemoryLounger.Delete()
	theMemoryLounger = None
	pActiveSpouse.Clear()
	EnableLayer.Delete()
	EnableLayer = None
	(self as Quest).Stop()
	
EndFunction

;--------------------------------------
; Sanctuary Cleanup Utilities
;--------------------------------------

Function RemoveNonUniqActor(ObjectReference player, int formid, string name="")
	if ("" == name)
		name = "" + formid + ""
	endif
	ObjectReference[] results
	Form theBase = Game.GetForm(formid)
	ActorBase theActorBase = theBase as ActorBase
	if !theBase
		Trace("[" + name + "] (" + formid + ") is not an ActorBase (Using anyway)")		
	endif
	results = player.FindAllReferencesOfType(theBase, 10000)
	int resultLen = results.length
	if (resultLen > 0)
		int i = 0
		ObjectReference theObj = None
		Actor tryActor         = None
		while (i < resultLen)
			theObj = results[i]
			tryActor = theObj as Actor
			ForceRemove(theObj)
			i += 1
		endWhile
	else
		Trace("ActorBase for [" + name + "] (" + formid + ") Not found within 8000 units")
	endif
EndFunction

Function RemoveUniqueActor(int formid, string name="", bool includeVehicle = false)
	if ("" == name)
		name = "" + formid + ""
	endif
	ActorBase theBase = Game.GetForm(formid) as ActorBase
	if !theBase
		Trace("ActorBase cast failure for [" + name + "] (" + formid + ")")
		return
	endif
	if !theBase.IsUnique()
		Trace("ActorBase for [" + name + "] is Not Unique!!")
		return
	endif
	Actor theActor = theBase.GetUniqueActor()
	if !theActor
		Trace("Unable to retrieve [" + name + "] (" + formid + ") Using ActorBase")
		return
	endif
	
	if (includeVehicle)
		ObjectReference theVehicle = theActor.GetLinkedRef(LinkVehicle)
		ForceRemove(theActor)
		if (theVehicle)
			ForceRemove(theVehicle)
		else
			Trace("No LinkVehicle Found")
		endif
	else
		ForceRemove(theActor)
	endif	
EndFunction

Function ForceRemove(ObjectReference obj)
	if (obj)
		; Disable/Delete often fail on statics, however, we can 
		; still move them out of sight...
		obj.SetPosition(0,0,10)
		obj.Disable()
		obj.Delete()
	endif
EndFunction

