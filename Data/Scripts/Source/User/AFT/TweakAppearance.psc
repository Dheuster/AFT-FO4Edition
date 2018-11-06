Scriptname AFT:TweakAppearance extends ReferenceAlias

Group Injected

	; When it is NOT an idle, the ObjectReference associated 
	; with the POSE is stored in the LinkedRef TweakPoseTarget. 
	Keyword   Property pTweakPoseTarget				Auto Const

	Faction   Property pTweakNamesFaction			Auto Const
	Faction   Property pTweakPosedFaction			Auto Const

	FormList  Property pTweakChildFemaleSetup		Auto Const
	FormList  Property pTweakChildGhoulSetup		Auto Const
	FormList  Property pTweakChildMaleSetup			Auto Const
	FormList  Property pTweakGhoulSetupFemale		Auto Const
	FormList  Property pTweakGhoulSetupMale			Auto Const
	FormList  Property pTweakHumanSetupMale			Auto Const
	FormList  Property pTweakHumanSetupFemale		Auto Const
	FormList  Property pTweakSynthGen1Setup			Auto Const
	FormList  Property pTweakSynthGen2Setup			Auto Const
	
	FormList  Property pTweakHeadParts 				Auto Const
	FormList  Property pTweakEyeChildParts 			Auto Const
	FormList  Property pTweakEyeParts  				Auto Const
	FormList  Property pTweakHairParts				Auto Const
	FormList  Property pTweakBeardParts 			Auto Const
	
	; Hancock, Nick
	FormList  Property pTweakEmptyList				Auto Const

	Formlist  Property pTweakFaceArchtypes			Auto Const
	Formlist  Property pTweakBodyArchtypes			Auto Const
	Furniture Property pTweakFurnExtraction			Auto Const
	Furniture Property pTweakFurnDance				Auto Const

	Keyword   Property pActorTypeChild				Auto Const
	Keyword   Property pActorTypeGhoul				Auto Const
	Keyword   Property pActorTypeHuman				Auto Const
	Keyword   Property pActorTypeSynth				Auto Const
	Idle      Property pInitializeMTGraphInstant	Auto Const
	Idle      Property pForce_Equip_3rdP_Melee		Auto Const

	Race      Property pSynthGen1Race				Auto Const
	Race      Property pHumanRace					Auto Const ;
	Race      Property pGhoulRace					Auto Const ;
	Race      Property pTweakInvisibleRace			Auto Const ;
	Keyword   Property pArmorTypePower				Auto Const


	; Faction Property pCurrentCompanionFaction		Auto Const
	; Idle    Property pSharedCoreSheath			Auto const
	
	; SOME if not most of these could be replaced with hard coded Form IDs:
	HeadPart  Property pFemaleEyesHumanChildBlue	Auto Const
	HeadPart  Property pMaleEyesHumanChildBlue		Auto Const
	HeadPart  Property pEyesGhoulChildBrown			Auto Const

	HeadPart  Property pFemaleEyesGhoulJaundice		Auto Const
	HeadPart  Property pMaleEyesGhoulJaundice		Auto Const
	HeadPart  Property pFemaleEyesHumanBlue			Auto Const
	HeadPart  Property pMaleEyesHumanBlue			Auto Const
	HeadPart  Property pSynthGen2Eyes				Auto Const ; Nick
	HeadPart  Property pGirlHair01					Auto Const
	HeadPart  Property pBoyHair01					Auto Const
	HeadPart  Property pHairFemale23				Auto Const ; Cait

	HeadPart  Property pFemaleEyesHumanGreen		Auto Const ; Cait
	HeadPart  Property pFemaleEyesHumanHazelBlue	Auto Const ; Curie
	HeadPart  Property pFemaleEyesHumanHazelGreen	Auto Const ; Piper
	HeadPart  Property pHairFemale03				Auto Const ; Curie
	HeadPart  Property pHairFemale01				Auto Const ; Piper
	HeadPart  Property pHairMale01					Auto Const

	HeadPart  Property pMaleEyesHumanLightBrown		Auto Const ; Danse
	HeadPart  Property pMaleEyesGhoulDark			Auto Const ; Hancock
	HeadPart  Property pMaleEyesHumanBrown			Auto Const ; Preston
	HeadPart  Property pMaleEyesHumanSteel			Auto Const ; X6-88

	HeadPart  Property pHairMale15					Auto Const ; Danse, MacCready
	HeadPart  Property pHairMale20					Auto Const ; Deacon
	HeadPart  Property pHairMale04					Auto Const ; Preston
	HeadPart  Property pHairMale42					Auto Const ; X6-88

	HeadPart  Property pBeard01						Auto Const ; Deacon, Preston, X6-88
	HeadPart  Property pBeard02						Auto Const ; Danse
	HeadPart  Property pBeard08						Auto Const ; MacCready

EndGroup

Group LocalPersistance

	; Face Traits. Note when you hit Sculpt or Face, everything resets to original values.

	; OriginalHeadId
	; 0: Female Human
	; 1: Female Ghoul
	; 2: Gen1 Synth
	; 3: Gen2/Valentine Synth
	; 4: Female (Human) Child
	; 5: Male Human
	; 6: Male Ghoul
	; 7: Male (Human) Child
	; 8: Ghoul Child

	int     Property OriginalHeadId		Auto

	form    Property OriginalHeadForm	Auto
	int     Property CurrentHeadId		Auto
	form    Property CurrentHeadForm	Auto

	int     Property OriginalHairId		Auto
	form    Property OriginalHairForm	Auto
	int     Property CurrentHairId		Auto
	form    Property CurrentHairForm	Auto

	int     Property OriginalEyesId		Auto
	form    Property OriginalEyesForm	Auto
	int     Property CurrentEyesId		Auto
	form    Property CurrentEyesForm	Auto

	int     Property OriginalBeardId	Auto
	form    Property OriginalBeardForm	Auto
	int     Property CurrentBeardId		Auto
	form    Property CurrentBeardForm	Auto

	; To reset, we just reset the actor withotu messing with the globals...
	int     Property CurrentBodyId		Auto 

	; Mood Support (Deprecated)
	int     Property CurrentMoodId		Auto 
	Keyword Property CurrentMood		Auto

	; Facial Expression (Humanoid only)
	int     Property CurrentFaceArchtypeId	Auto 
	Keyword Property CurrentFaceArchtype	Auto
	Keyword Property OriginalFaceArchtype	Auto

	; Body Posture (Humanoid only)
	int     Property CurrentArchtypeId	Auto 
	Keyword Property CurrentArchtype	Auto
	Keyword Property OriginalArchtype	Auto

	; Pose Support
	int     Property CurrentPoseId		Auto
	form    Property CurrentPose		Auto

	; Keep Offset Support
	float   Property keepoffset			Auto

EndGroup

; Hidden
float  Property pose_x				Auto hidden
float  Property pose_y				Auto hidden
float  Property pose_z				Auto hidden
float  Property pose_angle_x		Auto hidden
float  Property pose_angle_y		Auto hidden
float  Property pose_angle_z		Auto hidden
float  Property pose_replay_delay	Auto hidden
Bool   Property restoreOnNextLoad	Auto hidden
bool   Property AppearanceUnlocked	Auto hidden

; Constants
int    REPLAY_TIMER      = 42    Const
int    MONITOR_LEAVE     = 99    Const
int    MONITOR_PLAYER_XY = 9000  Const

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakAppearance" + self.GetActorRef().GetFactionRank(pTweakNamesFaction)
	; string logName = "TweakAppearance"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

; One time operations (typically time consuming)
Function initialize()

	Trace("initialize()")
	
	Actor npc = self.GetActorRef()
	
	; The IDs and Forms below are pulled from the Tweak<area>Parts Formlists
	; that the TweakChangeAppearance Script manages (attached to Quest TweakFollower)
	
	CurrentBodyId    = -1
	
	OriginalHeadId   = -1
	OriginalHeadForm = None
	OriginalEyesId   = -1
	OriginalEyesForm = None
	OriginalHairId   = -1
	OriginalHairForm = None
	OriginalBeardId   = -1
	OriginalBeardForm = None
	restoreOnNextLoad = false

	; HeadIDs (pTweakHeadParts)
	;0: Human Female
	;1: Ghoul Female
	;2: Synth Gen 1
	;3: Synth Gen 2
	;4: Child Female
	;5: Child Ghoul
	;6: Child Male
	;7: Human Male
	;8: Ghoul Male	
	
	if npc.HasKeyword(pActorTypeChild)
	
		; Eyes Based on TweakEyesChildParts Index...
		
		if (1 == npc.GetActorBase().GetSex()) ; Female
			Trace("Female Child Detected")
			OriginalHeadId   = 4
			OriginalHeadForm = pTweakChildFemaleSetup
			OriginalEyesId   = 0
			OriginalEyesForm = pFemaleEyesHumanChildBlue
			OriginalHairId   = 37
			OriginalHairForm = pGirlHair01
			OriginalBeardId  = 0
			OriginalBeardForm = pTweakEmptyList
		else ; Male/Other
			Trace("Male/Other Child Detected")
			OriginalHeadId   = 6
			OriginalHeadForm = pTweakChildMaleSetup
			OriginalEyesId   = 9
			OriginalEyesForm = pMaleEyesHumanChildBlue
			OriginalHairId   = 39
			OriginalHairForm = pBoyHair01
			OriginalBeardId  = 0
			OriginalBeardForm = pTweakEmptyList
		endif
		if npc.HasKeyword(pActorTypeGhoul)
			Trace("Ghoul Child Detected")
			OriginalHeadId   = 5
			OriginalHeadForm = pTweakChildGhoulSetup
			OriginalEyesId   = 5
			OriginalEyesForm = pEyesGhoulChildBrown
			OriginalHairId   = 36
			OriginalHairForm = pTweakEmptyList
			OriginalBeardId  = 0
			OriginalBeardForm = pTweakEmptyList
		endif
		
	elseif npc.HasKeyword(pActorTypeGhoul)

		if (1 == npc.GetActorBase().GetSex()) ; Female
			Trace("Adult Female Ghoul Detected")
			OriginalHeadId   = 1
			OriginalHeadForm = pTweakGhoulSetupFemale
			OriginalEyesId   = 21
			OriginalEyesForm = pFemaleEyesGhoulJaundice
			OriginalHairId   = 21
			OriginalHairForm = pHairFemale23
			OriginalBeardId  = 0
			OriginalBeardForm = pTweakEmptyList
		else ; Male/Other
			Trace("Adult Male Ghoul Detected")
			OriginalHeadId   = 8
			OriginalHeadForm = pTweakGhoulSetupMale
			OriginalEyesId   = 49
			OriginalEyesForm = pMaleEyesGhoulJaundice
			OriginalHairId   = 41
			OriginalHairForm = pHairMale01
			OriginalBeardId  = 0
			OriginalBeardForm = pTweakEmptyList
		endif
		
	elseif npc.HasKeyword(pActorTypeHuman)
		int actual_gender = npc.GetActorBase().GetSex()
		if (1 == actual_gender) ; Female
			Trace("Adult Female Human Detected (" + actual_gender + ")")
			OriginalHeadId   = 0
			OriginalHeadForm = pTweakHumanSetupFemale
			OriginalEyesId   = 1
			OriginalEyesForm = pFemaleEyesHumanBlue
			OriginalHairId   = 21
			OriginalHairForm = pHairFemale23
			OriginalBeardId  = 0
			OriginalBeardForm = pTweakEmptyList			
		else ; Male/Other
			Trace("Adult Male Human Detected (" + actual_gender + ")")
			OriginalHeadId   = 7
			OriginalHeadForm = pTweakHumanSetupMale
			OriginalEyesId   = 29
			OriginalEyesForm = pMaleEyesHumanBlue
			OriginalHairId   = 41
			OriginalHairForm = pHairMale01
			OriginalBeardId  = 0
			OriginalBeardForm = pTweakEmptyList
		endif
	
	elseif npc.HasKeyword(pActorTypeSynth)
		ActorBase ab = npc.GetActorBase()
		if (ab.GetRace() == pSynthGen1Race)
			Trace("Gen1 Synth Detected")
			OriginalHeadId   = 2
			OriginalHeadForm = pTweakSynthGen1Setup
			OriginalEyesId   = 53
			OriginalEyesForm = pSynthGen2Eyes
			OriginalHairId   = 36
			OriginalHairForm = pTweakEmptyList
			OriginalBeardId  = 0
			OriginalBeardForm = pTweakEmptyList
		else
			Trace("Gen2 Synth/Other Synth Detected")
			OriginalHeadId   = 3
			OriginalHeadForm = pTweakSynthGen2Setup
			OriginalEyesId   = 53
			OriginalEyesForm = pSynthGen2Eyes
			OriginalHairId   = 36
			OriginalHairForm = pTweakEmptyList
			OriginalBeardId  = 0
			OriginalBeardForm = pTweakEmptyList
		endif
	endif

	CurrentFaceArchtypeId = -1
	CurrentArchtypeId     = -1
	
	OriginalArchtype     = None ; Gen 2 Synth
	OriginalFaceArchtype = None ; Gen 2 Synth
	
	; Override Defaults for some well known NPCS:
	; int nameid = npc.GetFactionRank(pTweakNamesFaction)
	ActorBase base = npc.GetActorBase()
	if (base == Game.GetForm(0x00079249) as ActorBase)     ; 1 ---=== Cait ===---
		Trace("Cait Detected. Overriding Eyes")
		OriginalEyesId   = 1
		OriginalEyesForm = pFemaleEyesHumanGreen
		OriginalArchtype     = Game.GetForm(0x00022E49) as Keyword  ; AnimArchetypeConfident
		OriginalFaceArchtype = Game.GetForm(0x000C866C) as Keyword  ; AnimFaceArchetypeConfident
	elseif (base == Game.GetForm(0x00027686) as ActorBase) ; 3 ---=== Curie ===---
		Trace("Curie Detected. Overriding Eyes and Hair")
		OriginalEyesId   = 10
		OriginalEyesForm = pFemaleEyesHumanHazelBlue
		OriginalHairId   = 2
		OriginalHairForm = pHairFemale03
		OriginalArchtype     = Game.GetForm(0x0006B508) as Keyword  ; AnimArchetypePlayer
		OriginalFaceArchtype = Game.GetForm(0x000D755D) as Keyword  ; AnimFaceArchetypeNeutral
	elseif (base == Game.GetForm(0x00027683) as ActorBase) ; 4 ---=== Danse ===---
		Trace("Danse Detected. Overriding Eyes, Hair and Beard")
		OriginalEyesId   = 40
		OriginalEyesForm = pMaleEyesHumanLightBrown
		OriginalHairId   = 55
		OriginalHairForm = pHairMale15
		OriginalBeardId  = 2
		OriginalBeardForm = pBeard02
		OriginalArchtype     = Game.GetForm(0x00022E49) as Keyword  ; AnimArchetypeConfident
		OriginalFaceArchtype = Game.GetForm(0x000C866C) as Keyword  ; AnimFaceArchetypeConfident
	elseif (base == Game.GetForm(0x00045AC9) as ActorBase) ; 5 ---=== Deacon ===---
		Trace("Deacon Detected. Overriding Hair and Beard")
		OriginalHairId   = 60
		OriginalHairForm = pHairMale20
		OriginalBeardId  = 1
		OriginalBeardForm = pBeard01
		OriginalArchtype     = Game.GetForm(0x0003D290) as Keyword  ; AnimArchetypeFriendly
		OriginalFaceArchtype = Game.GetForm(0x000C866F) as Keyword  ; AnimFaceArchetypeFriendly
	elseif (base == Game.GetForm(0x00022613) as ActorBase) ; 7 ---=== Hancock ===---	
		Trace("Hanckock Detected. Overriding Eyes and Hair")
		OriginalEyesId   = 48
		OriginalEyesForm = pMaleEyesGhoulDark
		OriginalHairId   = 36
		OriginalHairForm = pTweakEmptyList
		OriginalArchtype     = Game.GetForm(0x0003D290) as Keyword  ; AnimArchetypeFriendly
		OriginalFaceArchtype = Game.GetForm(0x000C866F) as Keyword  ; AnimFaceArchetypeFriendly
	elseif (base == Game.GetForm(0x0002740E) as ActorBase) ; 8 ---=== MacCready ===---	
		Trace("MacCready Detected. Overriding Hair and Beard")
		OriginalHairId   = 55
		OriginalHairForm = pHairMale15
		OriginalBeardId  = 8
		OriginalBeardForm = pBeard08
		OriginalArchtype     = Game.GetForm(0x00022E49) as Keyword  ; AnimArchetypeConfident
		OriginalFaceArchtype = Game.GetForm(0x000C866F) as Keyword  ; AnimFaceArchetypeFriendly
	elseif (base == Game.GetForm(0x00002F24) as ActorBase) ; 9 ---=== Nick Valentine ===---
		Trace("Nick Detected. Overriding Head and Eyes")
		OriginalHeadId   = 7
		OriginalHeadForm = pTweakHumanSetupMale
		OriginalEyesId   = 54
		OriginalEyesForm = pSynthGen2Eyes
	elseif (base == Game.GetForm(0x00002F1E) as ActorBase) ; 10 ---=== Piper ===---	
		Trace("Piper Detected. Overriding Eyes and Hair")
		OriginalEyesId   = 11
		OriginalEyesForm = pFemaleEyesHumanHazelGreen
		OriginalHairId   = 0
		OriginalHairForm = pHairFemale01
		CurrentMood      = Game.GetForm(0x00198BC6) as Keyword ; Piper specific
		OriginalArchtype     = Game.GetForm(0x00022E49) as Keyword  ; AnimArchetypeConfident
		OriginalFaceArchtype = Game.GetForm(0x000C866C) as Keyword  ; AnimFaceArchetypeConfident		
	elseif (base == Game.GetForm(0x00019FD9) as ActorBase) ; 11 ---=== Preston ===---
		Trace("Preston Detected. Overriding Eyes, Hair and Beard")
		OriginalEyesId   = 32
		OriginalEyesForm = pMaleEyesHumanBrown
		OriginalHairId   = 44
		OriginalHairForm = pHairMale04
		OriginalBeardId  = 1
		OriginalBeardForm = pBeard01
		CurrentMood      = Game.GetForm(0x00198BC9) as Keyword ; Preston specific
		OriginalArchtype     = Game.GetForm(0x00022E49) as Keyword  ; AnimArchetypeConfident
		OriginalFaceArchtype = Game.GetForm(0x00198BC9) as Keyword  ; AnimFaceArchetypePreston
	elseif (base == Game.GetForm(0x000BBEE6) as ActorBase) ; 13 ---=== X6-88 ===---	
		Trace("X6-88 Detected. Overriding Eyes, Hair and Beard")
		OriginalEyesId   = 42
		OriginalEyesForm = pMaleEyesHumanSteel
		OriginalHairId   = 82
		OriginalHairForm = pHairMale42
		OriginalBeardId  = 1
		OriginalBeardForm = pBeard01
		OriginalArchtype     = Game.GetForm(0x00022E49) as Keyword  ; AnimArchetypeConfident
		OriginalFaceArchtype = Game.GetForm(0x00198BC9) as Keyword  ; AnimFaceArchetypePreston
	else
			
		int numArchtypes = pTweakBodyArchtypes.GetSize()
		int i = 0
		while (i < numArchtypes && None == OriginalArchtype)
			Keyword k = pTweakBodyArchtypes.GetAt(i) as Keyword
			if npc.HasKeyword(k)
				Trace("Discovered (Body) Archtype [" + k + "]")
				OriginalArchtype = k
			endif
			i += 1
		endwhile

		int numFaceArchtypes = pTweakFaceArchtypes.GetSize()
		i = 0
		while (i < numFaceArchtypes && None == OriginalFaceArchtype)
			Keyword k = pTweakFaceArchtypes.GetAt(i) as Keyword
			if npc.HasKeyword(k)
				Trace("Discovered FaceArchtype [" + k + "]")
				OriginalFaceArchtype = k
			endif
			i += 1
		endwhile
		
	endif
	
	CurrentPoseId     = -1
	CurrentPose       = None
	pose_x            = 0.0
	pose_y            = 0.0
    pose_z            = 0.0
    pose_angle_x      = 0.0
    pose_angle_y      = 0.0
    pose_angle_z      = 0.0
    pose_replay_delay = 0
	keepoffset        = 0.0
	RestoreOriginalValues()
	AppearanceUnlocked = false
	; EventFollowingPlayer()
	
EndFunction

Function EventOnGameLoad()
	Trace("EventOnGameLoad")
	restoreOnNextLoad = false
	Actor npc = self.GetActorReference()
	race currentRace = npc.GetRace()
	Race pSuperMutantRace = Game.GetForm(0x0001A009) as Race
	Race pSynthGen2Race   = Game.GetForm(0x0010BD65) as Race
	
	if !((currentRace == pHumanRace) || (currentRace == pGhoulRace) || (currentRace == pSuperMutantRace) || (currentRace == pSynthGen2Race))
		Trace("NPC is not a HumanSubgraph Based race. No need to fix appearance.")
		return
	endif
	; If it is a leveled Actor (IE: Curie), we can bail
	if (npc.GetLeveledActorBase() != npc.GetActorBase())
		Trace("NPC is leveled Actor. No need to fix appearance.")
		return
	endif
	TweakSettings pTweakSettings = (self as ReferenceAlias) as TweakSettings
	if !pTweakSettings
		Trace("Cast to TweakSettings Failed. Bailing")
		return
	endif	
	if (currentRace == pTweakSettings.originalRace)
		Trace("NPC race is original race. No need to fix appearance.")
		return
	endif
	
		
	; Restore/Reload the NPCs appearance. Note that to do this, 
	; we need 3D Loaded. If 3D is not loaded, then we raise a flag
	; so that next time OnLoad gets called, it knows to restore 
	; their appearance. 
	
	restoreOnNextLoad = true
	if (npc.Is3DLoaded())
		RestoreCustomRaceAppearance()
	endif
EndFunction

Function RestoreCustomRaceAppearance()

	restoreOnNextLoad = false
	Actor npc = self.GetActorRef()
	Race ORace    = npc.GetRace()
	npc.SetRace(pTweakInvisibleRace)
	
	int maxwait = 6
	while (npc.GetRace() != pTweakInvisibleRace && maxwait > 0)
		Trace("Waiting for Race Change")
		Utility.waitmenumode(0.2)
		maxwait -= 1
	endwhile
	Trace("Complete. Attempting to Change Race to Back to Original")
	npc.SetRace(ORace)
	maxwait = 6
	while (npc.GetRace() != ORace && maxwait > 0)
		Trace("Waiting for Race Change Back")
		Utility.waitmenumode(0.2)
		maxwait -= 1
	endwhile
	
EndFunction

float player_keepoffset_last_x
float player_keepoffset_last_y
float player_keepoffset_last_anglez
float player_keepoffset_heading_offset

; NOTE : This only gets relayed to current followers...
Function EventPlayerWeaponDraw()
	Trace("EventPlayerWeaponDraw()")
	Actor npc = self.GetActorReference()
	if npc.IsInFaction(pTweakPosedFaction)
		Trace("[" + npc + "] in TweakPosedFaction, stopping pose")
		Scene posechooser = npc.GetCurrentScene()
		if (posechooser && posechooser.IsPlaying())
			Trace("Stopping Scene [" + posechooser + "]")
			posechooser.Stop()
		endif
		StopPosing(true)
	endif
EndFunction

; This is used by the POSE system to move posed NPCs around when
; they are grabbed...
Function KeepOffsetFromPlayer(float offset = -1.0)

	Actor pc  = Game.GetPlayer()
	Actor npc =  self.GetActorRef()	
	if (offset < 0.0)
		keepoffset = pc.GetDistance(npc)
	else
		keepoffset = offset
	endif
			
	player_keepoffset_last_x      = pc.GetPositionX()
	player_keepoffset_last_y      = pc.GetPositionY()
	player_keepoffset_last_anglez = pc.GetAngleZ()	
	
	; Heading is how far the npc would have to rotate to face the PC. 
	; We dont want that to happen, but we want the RELATIVE HEADING
	; to remain the same. If I am facing the NPC head on and turn 90, I want
	; them to still be facing me. If I am facing their back and turn 45
	; I want to still see their back...
		
	player_keepoffset_heading_offset = (pc.GetAngleZ() - npc.GetAngleZ())

	; EnforceKeepOffset()
	StartTimer(0.5,MONITOR_PLAYER_XY)
	
EndFunction

Function ClearKeepPlayerOffset()
	Actor npc = self.GetActorRef()
	if (npc.IsInFaction(pTweakPosedFaction))
		pose_x = npc.GetPositionX()
		pose_y = npc.GetPositionY()
		pose_z = npc.GetPositionZ()		
		pose_angle_x = npc.GetAngleX()
		pose_angle_y = npc.GetAngleY()
		pose_angle_z = npc.GetAngleZ()		
		Trace("ClearPlayerOffset. Snapshot : X[" + pose_x + "]Y[" + pose_y + "]Z[" + pose_z + " aX[" + pose_angle_x + "]aY[" + pose_angle_y + "aZ[" + pose_angle_z + "]")
	endif
	keepoffset = 0.0
EndFunction



Function RestoreOriginalValues()
	Trace("RestoreOriginalValues")
	CurrentHeadId       = OriginalHeadId
    CurrentHeadForm     = OriginalHeadForm
	CurrentEyesId       = OriginalEyesId
    CurrentEyesForm     = OriginalEyesForm
	CurrentHairId       = OriginalHairId
    CurrentHairForm     = OriginalHairForm
	CurrentBeardId      = OriginalBeardId
	CurrentBeardForm    = OriginalBeardForm
	; CurrentFaceArchtype = OriginalFaceArchtype
	; CurrentArchtype     = OriginalArchtype
	Trace("CurrentHeadId: " + CurrentHeadId)
	Trace("CurrentEyesId: " + CurrentEyesId)
EndFunction

Function EventFollowingPlayer(bool firstTime = False)
	
	Trace("EventFollowingPlayer()")

	Actor npc = self.GetActorRef()
	if (npc.isUnconscious())
		npc.SetUnconscious(FALSE)
	endif
	
	if (npc.IsInFaction(pTweakPosedFaction))
		Trace("Follower Posed. Ending Pose")
		StopPosing(true)
	endif
	
endFunction

Function EventFollowerWait()
	Trace("EventFollowerWait()")				

	; Scenario : Player poses follower then tells them to stay...
	;            Decision was made that CurrentFollowers should always stop pose when the
	;            player gets too far away because of the issues with teleporting to the
	;            player with a summon from another location when the NPC is posed.
	
EndFunction

Function EventWaitToFollow()
	Trace("EventWaitToFollow()")				

	Actor npc = self.GetActorRef()
	if (npc.isUnconscious())
		npc.SetUnconscious(FALSE)
	endif
	
	if (npc.IsInFaction(pTweakPosedFaction))
		Trace("Stopping Pose")
		; Stop any current animation
		StopPosing(true)
	else
		Trace("Not Posed")
	endif
EndFunction

; When they stop following the PC
Function EventNotFollowingPlayer()
	Trace("EventNotFollowingPlayer() (dismissed)")				
	Actor npc = self.GetActorRef()
	UnregisterForAnimationEvent(Game.GetPlayer(), "weaponDraw")
	if (!npc.IsInFaction(pTweakPosedFaction))
		npc.PlayIdle(pInitializeMTGraphInstant)	
		; npc.PlayAnimation( "IdleForceDefaultState")
	endif
	CancelTimer(MONITOR_LEAVE)	
endFunction

Function UnManage()
	Actor npc = self.GetActorRef()
	
	if (npc.isUnconscious())
		npc.SetUnconscious(FALSE)
	endif
	
	if (npc.IsInFaction(pTweakPosedFaction))
		Trace("Stopping Pose")
		; Stop any current animation
		StopPosing(true)
	else
		Trace("Not Posed")
		npc.PlayIdle(pInitializeMTGraphInstant)	
	endif
	
	if AppearanceUnlocked
	
		; TODO: We dont currently restore new bodies. Curie is the 
		; only NPC with that capability, so I think it is fine. May 
		; want to revisit if we expand support for new bodies in the 
		; future. 
		
		if (CurrentHeadId != OriginalHeadId)
			ChangePart(pTweakHeadParts, CurrentHeadId, true)
			ChangePart(pTweakHeadParts, OriginalHeadId)
		endif
	
		if (CurrentEyesId != OriginalEyesId)
			if (4 ==OriginalHeadId || 5 == OriginalHeadId || 6 == OriginalHeadId)
				; Child Eyes
				ChangePart(pTweakEyeChildParts, CurrentEyesId, true)
				ChangePart(pTweakEyeChildParts, OriginalEyesId)
			else
				ChangePart(pTweakEyeParts, CurrentEyesId, true)
				ChangePart(pTweakEyeParts, OriginalEyesId)
			endif
		endif

		if (CurrentHairId != OriginalHairId)
			ChangePart(pTweakHairParts, CurrentHairId, true)
			ChangePart(pTweakHairParts, OriginalHairId)			
		endif
	
		if (CurrentBeardId != OriginalBeardId)
			ChangePart(pTweakBeardParts, CurrentBeardId, true)
			ChangePart(pTweakBeardParts, OriginalBeardId)
		endif

		npc.ChangeAnimFaceArchetype(None)
		npc.ChangeAnimArchetype(None)
	endif
		
	UnregisterForAnimationEvent(Game.GetPlayer(), "weaponDraw")
	CancelTimer(MONITOR_LEAVE)	

EndFunction

Function ChangePart(Formlist source, int index, bool removeit=false)
	Actor npc       = self.GetActorRef()
	Form theForm    = source.GetAt(index)
	FormList pieces = theForm as FormList
	
	if pieces
		int numpieces = pieces.GetSize()
		int i = 0
		while (i != numpieces)
			HeadPart pp = pieces.GetAt(i) as HeadPart	
			if (pp)
				npc.ChangeHeadPart(apHeadPart=pp, abRemovePart=removeit, abRemoveExtraParts=removeit)
			endif
			i += 1
		endWhile
		return
	endif
		
	HeadPart hp = theForm as HeadPart		
	if (hp)
		npc.ChangeHeadPart(apHeadPart=hp, abRemovePart=removeit, abRemoveExtraParts=removeit)
	endif	
EndFunction

Function EditHeadParts()
	Trace("EditHeadParts Called")
	Actor npc = self.GetActorRef()
	TweakChangeAppearance pTweakChangeAppearance = GetOwningQuest() as TweakChangeAppearance
	if !pTweakChangeAppearance
		Trace("EditHeadParts : Cast TweakChangeAppearance failed.")				
		return
	endif	
	if !AppearanceUnlocked
		AppearanceUnlocked = pTweakChangeAppearance.UnlockAppearance(npc)
	endif
	if AppearanceUnlocked
		pTweakChangeAppearance.HeadParts(self)
		return
	endif
	Trace("Failed to Unlock Appearance")
EndFunction

Function EditHairParts()
	Trace("EditHairParts Called")
	Actor npc = self.GetActorRef()
	TweakChangeAppearance pTweakChangeAppearance = GetOwningQuest() as TweakChangeAppearance
	if !pTweakChangeAppearance
		Trace("EditHairParts : Cast TweakChangeAppearance failed.")				
		return
	endif
	if !AppearanceUnlocked
		AppearanceUnlocked = pTweakChangeAppearance.UnlockAppearance(npc)
	endif
	if AppearanceUnlocked
		pTweakChangeAppearance.HairParts(self)
		return
	endif
	Trace("Failed to Unlock Appearance")
EndFunction

Function EditBeardParts()
	Trace("EditBeardParts Called")
	Actor npc = self.GetActorRef()	
	TweakChangeAppearance pTweakChangeAppearance = GetOwningQuest() as TweakChangeAppearance
	if !pTweakChangeAppearance
		Trace("EditBeardParts : Cast TweakChangeAppearance failed.")				
		return
	endif
	if !AppearanceUnlocked
		AppearanceUnlocked = pTweakChangeAppearance.UnlockAppearance(npc)
	endif
	if AppearanceUnlocked
		pTweakChangeAppearance.BeardParts(self)
		return
	endif
	Trace("Failed to Unlock Appearance")
EndFunction

Function EditEyeParts()
	Trace("EditEyeParts Called")
	Actor npc = self.GetActorRef()	
	TweakChangeAppearance pTweakChangeAppearance = GetOwningQuest() as TweakChangeAppearance
	if !pTweakChangeAppearance
		Trace("EditEyeParts : Cast TweakChangeAppearance failed.")				
		return
	endif
	if !AppearanceUnlocked
		AppearanceUnlocked = pTweakChangeAppearance.UnlockAppearance(npc)
	endif
	if AppearanceUnlocked
		pTweakChangeAppearance.EyeParts(self)
		return
	endif
	Trace("Failed to Unlock Appearance")
EndFunction

Function Sculpt(int uiMenu=1)
	Trace("Sculpt Called")
	Actor npc = self.GetActorRef()	
	TweakChangeAppearance pTweakChangeAppearance = (GetOwningQuest() as TweakChangeAppearance)	
	if !pTweakChangeAppearance
		Trace("Sculpt : Quest cast TweakChangeAppearance failed.")				
		return
	endif
	if !AppearanceUnlocked
		AppearanceUnlocked = pTweakChangeAppearance.UnlockAppearance(npc)
	endif
	if !AppearanceUnlocked
		Trace("Failed to Unlock Appearance")
	endif
	
	; Sculpt lets them change the hair, eyes and beard. So there is no point
	; pretending we know what the values are. Reset to original...
	
	CurrentEyesId    = OriginalEyesId
	CurrentEyesForm  = OriginalEyesForm
	CurrentHairId    = OriginalHairId
	CurrentHairForm  = OriginalHairForm
	CurrentBeardId   = OriginalBeardId
	CurrentBeardForm = OriginalBeardForm
	
	pTweakChangeAppearance.sculpt(self, uiMenu)
EndFunction

Function NewBody()

	; This only works on CONFIGURED LeveledActors. Config is handled by 
	; the FormLists: TweakNewBodyActors and TweakNewBodyData. TweakNewBodyActors is a fast
	; lookup to quickly determine what actors support NewBody functionality. TweakNewBodyData 
	; Contains the full records. Each entry of TweakNewBodyData is a formlist with the following 
	; structure:
	;
	; index 0    : ActorBase of Actor with Template poiting to LeveledActor that inherits Traits
	; index 1    : Root LeveledActor Template that index 0 uses for options. Each entry should be another Leveled Actor
	; index 2..N : GlobalVariables which will be set to 100 to prevent the original Leveled Actors from being chosen during Reset operations.	
	; index N..K : ActorBases of NPCs to offer as options. Note: Each option should have the same VoiceType as the original Actor
	; 	
	; Explanation : When a leveled actor is reset(), the game picks the best match from
	;   the Leveled Actor list. A LeveledActor list can have child LeveledActors and each of the
	;   children can be linked to a Global Variable to control the probability they will NOT be
	;   chosen in the parent list. So if 4/5 LeveledActor entries are pointing at globals that
    ;	indicate not to choose them, when reset is called, the 5th entry will be chosen. In this 
	;   case, the Root list doesn't have a 5th entry. Rather AFT manages the "only option" with 
	;   Add/Remove operations, allowing the user to browse and choose from the various actor options. 
	
	TweakChangeAppearance pTweakChangeAppearance = GetOwningQuest() as TweakChangeAppearance
	if !pTweakChangeAppearance
		Trace("NewBody : Cast TweakChangeAppearance failed.")				
		return
	endif
	
	pTweakChangeAppearance.NewBody(self)
EndFunction

Function ChangeExpression()

	TweakChangeAppearance pTweakChangeAppearance = GetOwningQuest() as TweakChangeAppearance
	if !pTweakChangeAppearance
		Trace("ChangeExpression : Cast TweakChangeAppearance failed.")				
		return
	endif
	
	pTweakChangeAppearance.ChangeExpression(self)
	
EndFunction

Function MovePosed()
	TweakChangeAppearance pTweakChangeAppearance = GetOwningQuest() as TweakChangeAppearance
	if !pTweakChangeAppearance
		Trace("MovePosed : Cast TweakChangeAppearance failed.")				
		return
	endif
	
	pTweakChangeAppearance.MovePosed(self)
	
EndFunction

Function ChangePosture()

	TweakChangeAppearance pTweakChangeAppearance = GetOwningQuest() as TweakChangeAppearance
	if !pTweakChangeAppearance
		Trace("ChangePosture : Cast TweakChangeAppearance failed.")				
		return
	endif
	
	pTweakChangeAppearance.ChangePosture(self)
	
EndFunction

; ================================================================
; POSE Support
; ================================================================

Function PoseFollower(int startingPose = -1)

	Trace("PoseFollower() Called")
	TweakChangeAppearance pTweakChangeAppearance = GetOwningQuest() as TweakChangeAppearance
	if !pTweakChangeAppearance
		Trace("PoseFollower : Cast TweakChangeAppearance failed.")				
		return
	endif
		
	; I dont know why, but StartTimer WILL NOT WORK from this context.
	; However it will work if we call a quest level script and it is
	; called from a callback... (Sigh) Hense PoseInit below...

	Actor pc = Game.GetPlayer()	
	Actor npc = self.GetActorRef()

	Faction pCurrentCompanionFaction = Game.GetForm(0x00023C01) as Faction
	if (!pCurrentCompanionFaction)
		Trace("pCurrentCompanionFaction casting error")				
	endif

	if (npc.GetFactionRank(pCurrentCompanionFaction) > -1)
	
		Trace("Calling StartTimer(4, [" + MONITOR_LEAVE + "])")
		StartTimer(4.0,MONITOR_LEAVE)
		
		; Bool succ = RegisterForAnimationEvent(pc, "weaponDraw")
		; if !succ
			; int i = 8
			; while (i > 0 && !succ)
				; Utility.wait(0.25)
				; succ = RegisterForAnimationEvent(pc, "weaponDraw")
				; i -= 1
			; EndWhile
		; EndIf

		; if succ
			; Trace("Registered for AnimationEvent weaponDraw() on Player()")
		; else
			; Trace("Unable to register for AnimationEvent weaponDraw() on Player()")
		; endif
				
	else
		Trace("npc is not in CurrentCompanionFaction. Monitor Skipped...")
	endif	
		
	pTweakChangeAppearance.Pose(self, startingPose)

endFunction

Function StartPose(int posId, Form pose, float replay_delay = 0.0)

	if (pose != CurrentPose)
		StopPosing()
		CurrentPoseId     = posId
		CurrentPose       = pose
		pose_replay_delay = replay_delay
	endif
	
	; TweakPoseFaction rank AI impacts:
	;
	; 1 = Wait + HeadTurn
	; 2 = Wait
	; 3 = Use/Sit LinkedRef object TweakPoseTarget
	; 4 = Use IdleMarker object TweakPoseTarget

	Actor npc = self.GetActorRef()	
	Furniture fpose = CurrentPose As Furniture
	Idle      ipose = CurrentPose As Idle	
	IdleMarker      mpose = CurrentPose As IdleMarker
	
	if (fpose)
			
	    ; Confirm Correct Marker exists. Create if it doesn't...
		ObjectReference marker = npc.GetLinkedRef(pTweakPoseTarget)
		if (!marker)
			marker = npc.PlaceAtMe(fpose)
			npc.SetLinkedRef(marker, pTweakPoseTarget)
			int fposeid = fpose.GetFormID()
			if (fposeid == 0x001E618A || fposeid == 0x000DF458 || fposeid == 0x00108F58)
				Trace("Waiting for Chair to spawn...")
				Utility.wait(2.5)
			endif			
		endif
		
		if !npc.IsInFaction(pTweakPosedFaction)
			npc.SetMotionType(npc.Motion_Keyframed)
			npc.SetFactionRank(pTweakPosedFaction,3)
			npc.EvaluatePackage()
		elseif (3 != npc.GetFactionRank(pTweakPosedFaction))
			npc.SetFactionRank(pTweakPosedFaction,3)
			npc.EvaluatePackage()
		endif
		
		npc.SnapIntoInteraction(marker)
		npc.SetRestrained(true)
		
		if (fpose.GetFormId() == 0x001E618A || fpose == pTweakFurnExtraction) ; ExtractorChair01
			Utility.wait(1.0)
			if !npc.PlayIdle(Game.GetForm(0x00209389) as Idle) ; IdleExtractionChair
				Trace("PlayIdle Failure")
			endif
		elseif (fpose == pTweakFurnDance)
			Utility.wait(1.0)
			if !npc.PlayIdle(Game.GetForm(0x001A8B8E) as Idle) ; Magnolia05
				Trace("PlayIdle Failure")
			endif		
		endif
		
	elseif (ipose)
		
		if !npc.IsInFaction(pTweakPosedFaction)
			npc.SetMotionType(npc.Motion_Keyframed)
			; 1 = Wait + HeadTurn
			; 2 = Wait
			; 3 = Use/Sit LinkedRef object TweakPoseTarget
			; 4 = Use IdleMarker object TweakPoseTarget
			npc.SetFactionRank(pTweakPosedFaction,2)
			npc.EvaluatePackage()
		elseif (2 != npc.GetFactionRank(pTweakPosedFaction))
			npc.SetRestrained(false)
			npc.SetFactionRank(pTweakPosedFaction,2)
			npc.EvaluatePackage()
		endif
				
		if !npc.PlayIdle(ipose)
			Trace("PlayIdle Failure")
		endif
			
	elseif (mpose)
	
		ObjectReference marker = npc.GetLinkedRef(pTweakPoseTarget)
		if (marker)
			if (marker.GetBaseObject() != mpose)
				StopPosing()
				marker = None
			endif
		endif
		if (!marker)
			marker = npc.PlaceAtMe(mpose)
			npc.SetLinkedRef(marker, pTweakPoseTarget)
		endif
		
		if !npc.IsInFaction(pTweakPosedFaction)
			npc.SetMotionType(npc.Motion_Keyframed)
			; 1 = Wait + HeadTurn
			; 2 = Wait
			; 3 = Use/Sit LinkedRef object TweakPoseTarget
			; 4 = Use IdleMarker object TweakPoseTarget
			npc.SetFactionRank(pTweakPosedFaction,4)
			npc.EvaluatePackage()
		elseif (4 != npc.GetFactionRank(pTweakPosedFaction))
			npc.SetRestrained(false)
			npc.SetFactionRank(pTweakPosedFaction,4)
			npc.EvaluatePackage()
		endif
		
	else
		Trace("Casting Error for Pose [" + pose + "]")
		return
	endif
	
	pose_x = npc.GetPositionX()
	pose_y = npc.GetPositionY()
	pose_z = npc.GetPositionZ()
	pose_angle_x = npc.GetAngleX()
	pose_angle_y = npc.GetAngleY()
	pose_angle_z = npc.GetAngleZ()

	if (pose_replay_delay > 0)
		StartTimer(pose_replay_delay, REPLAY_TIMER)
	endif
	
endFunction

Function PlayCurrentPose()
	Actor     npc = self.GetActorRef()
	
	if (keepoffset == 0.0)
	
		; The games positioning system is very accurate ( 6 decimal places) which is bad when combined with Havok.
		; Havok tends to move things slightly after they are placed, especially along the Z axis. So moments after 
		; using SetPosition, things almost never have the same Z values. To add to the problem, When an NPC is 
		; unloaded and reloaded, the MotionType resets. So even if we set them to not use havok, they will start
		; using it again when we leave the area and come back. So the code below has leniencies built in. For 
		; comparisons, everything is cast to int to factor out the precision from the conditions. In addition, Z 
		; is allowed up to wonder up to 10 in any direction (zdiff) 
		
		int current_x = npc.GetPositionX() as Int
		int current_y = npc.GetPositionY() as Int
		int pose_xi   = pose_x as Int
		int pose_yi   = pose_y as Int
		int zdiff     = (npc.GetPositionZ() as Int) - (pose_z as Int)
		zdiff         = (zdiff * zdiff) ; Eliminate negative case
				
		if (current_x != pose_xi || current_y != pose_yi || zdiff > 100)
			Trace("Position out of sync Current X[" + current_x + "]Y[" + current_y + "]Z[" + (npc.GetPositionZ() as Int) +"] != POSE X[" + pose_xi + "]Y[" + pose_yi + "]Z[" + (pose_z as Int) + "]")
			; Note : SetPosition will always reset the angles...
			npc.SetPosition(pose_x, pose_y, pose_z)
		endif

		; The angles are generally not affected
		current_x = npc.GetAngleX() as Int
		current_y = npc.GetAngleY() as Int
		int current_z = npc.GetAngleZ() as Int
		pose_xi   = pose_angle_x as Int
		pose_yi   = pose_angle_y as Int
		int pose_zi   = pose_angle_z as Int		
			
		if (current_x != pose_xi || current_y != pose_yi || current_z != pose_zi)
			Trace("Angle out of sync Current aX[" + current_x + "]aY[" + current_y + "]aZ[" + current_z +"] != POSE aX[" + pose_xi + "]aY[" + pose_yi + "]aZ[" + pose_zi + "]")
			; SetAngle doesn't seem to work for anything other than the Z axis.
			TranslatePosedTo(pose_x, pose_y, pose_z, pose_angle_x, pose_angle_y, pose_angle_z, 150.0, 200.0)
		endif
		
	endif
	
	Furniture fpose = CurrentPose As Furniture
	if (fpose)	
	    ; Confirm Correct Marker exists. Create if it doesn't...
		ObjectReference marker = npc.GetLinkedRef(pTweakPoseTarget)
		if (!marker)
			marker = npc.PlaceAtMe(fpose)
			npc.SetLinkedRef(marker, pTweakPoseTarget)
		endif
		if (npc.GetSitState() < 3)
			npc.SnapIntoInteraction(marker)
		endif

		if (fpose.GetFormId() == 0x001E618A || fpose == pTweakFurnExtraction) ; ExtractorChair01		
			if !npc.PlayIdle(Game.GetForm(0x00209389) as Idle) ; IdleExtractionChair
				Trace("PlayIdle Failure")
			endif		
		elseif (fpose == pTweakFurnDance)
			if !npc.PlayIdle(Game.GetForm(0x001A8B8E) as Idle) ; Magnolia05
				Trace("PlayIdle Failure")
			endif		
		endif
		if (pose_replay_delay > 0)
			StartTimer(pose_replay_delay, REPLAY_TIMER)
		endif
		return
	endif
	
	Idle ipose = CurrentPose As Idle
	if (ipose)
		if !npc.PlayIdle(ipose)
			Trace("PlayIdle Failure")
		endif
		if (pose_replay_delay > 0)
			StartTimer(pose_replay_delay, REPLAY_TIMER)
		endif
		return
	endif
	
	; I believe IdleMarkers are always looping...
	IdleMarker mpose = CurrentPose As IdleMarker
	if (mpose)
		ObjectReference marker = npc.GetLinkedRef(pTweakPoseTarget)
		if (!marker)
			marker = npc.PlaceAtMe(fpose)
			npc.SetLinkedRef(marker, pTweakPoseTarget)
		endif
		; TODO : SHould we confirm faction rank in TweakPose is 4?
		npc.EvaluatePackage()
		return
	endif
EndFunction

Function StopPosing(bool abRemoveFromFaction = false)
	Trace("StopPosing(" + abRemoveFromFaction + ") Called")

	Actor npc = self.GetActorRef()
	if (npc.IsInFaction(pTweakPosedFaction))
		CurrentPoseId = -1
		CurrentPose = None
		CancelTimer(REPLAY_TIMER)
	
		if (abRemoveFromFaction)
			npc.RemoveFromFaction(pTweakPosedFaction)
			npc.EvaluatePackage()
			CancelTimer(MONITOR_LEAVE)
		elseif (npc.GetFactionRank(pTweakPosedFaction) > 2)
			npc.SetFactionRank(pTweakPosedFaction, 2)
			npc.EvaluatePackage()
		endif	
	endif
	
	npc.SetPosition(npc.GetPositionX(),npc.GetPositionY(),npc.GetPositionZ())
	npc.SetAngle(0.0,0.0,npc.GetAngleZ())
	npc.SetMotionType(npc.Motion_Dynamic)

	ObjectReference marker = npc.GetLinkedRef(pTweakPoseTarget)
	npc.PlayIdle( pInitializeMTGraphInstant )
	if (marker)
		npc.SetLinkedRef(None, pTweakPoseTarget)
		npc.SetRestrained(false)
		marker.delete()
	endif
		
EndFunction

int translationstatus

Function TranslatePosedTo(float x, float y, float z, float ax, float ay, float az, float speed, float rotationSpeed)

	Trace("TranslatePosedTo")

	; Has to take into account the various pose scenarios and the keepoffsetfromplayer capability.
	; Poses can be Idles (The NPC is the object) or they can be pushed by furniture or IdleMarkers ObjectReferences,
	; in which case both the NPC and the object need to move in tandem. 
	
	; NOTES: Actors use LOCAL angles for X and Y. So no matter what direction an actor is facing, 
    ;        AngleX() will cause them to tip forward. 
    ;        Furniture uses GLOBAL angles for X and Y. If the furniture happens to be facing South (AngleZ == 0)
	;        then AngleX will cause it to tip forward, but if it is facing East, AngleX will cause it to tip to
	;        the right. To make furniture tip forward, you have to compute the right proportions of X and Y based
	;        on where the furniture is facing (AngleZ).
		
	Actor npc              = self.GetActorReference()
	bool isIdleMarker      = (CurrentPose is IdleMarker)
	Furniture fpose        = CurrentPose As Furniture	
	bool isFurniture       = (CurrentPose is Furniture)
	
	ObjectReference marker = None
	if (isIdleMarker || fpose)	
		float current_ax       = npc.GetAngleX()
		float current_ay       = npc.GetAngleY()
		float current_az       = npc.GetAngleZ()
		float fax = ax
		float fay = ay
		
		marker = npc.GetLinkedRef(pTweakPoseTarget)
		
		if ((ax != 0.0 || ay != 0.0) && (fpose.GetFormId() == 0x001E618A || fpose.GetFormId() == 0x000DF458))
			;; Use int precision to prevent over-processing
			bool angle_changed = ((ax as int) != (current_ax as int))
			bool heading_changed = ((az as int) != (current_az as int))
			if (angle_changed || heading_changed)
				if (heading_changed)
					if (0.0 == current_az || 90.0 == current_az || 180.0 == current_az || 270.0 == current_az)
						if az < current_az
							current_az -= 90
						else
							current_az += 90
						endif
						current_az = Enforce360Bounds(current_az)
					endif
				endif				
				; ax comes from NPC, not furniture. So no need
				; to diff/adjust value. Just negate as is...
				if ((current_az < 45 || current_az > 315))
					Debug.Notification("45 > az > 315 : 0")
					az = 0
					float compatible =  az + 90
					float saz = Math.sin(compatible)
					float caz = Math.cos(compatible)
					fax = saz * ax
					fay = caz * ax 
				elseif (current_az > 135 && current_az < 225)
					Debug.Notification("135 > az > 225 : 180")
					az = 180
					float compatible =  az + 90
					float saz = Math.sin(compatible)
					float caz = Math.cos(compatible)
					fax = saz * ax
					fay = caz * ax 
				elseif (current_az >= 225 && current_az <= 315)
					Debug.Notification("225 > az > 315 : 270")
					az = 270
					float compatible =  az + 90
					float saz = Math.sin(compatible)
					float caz = Math.cos(compatible)
					fax = saz * ax
					fay = caz * ax 
				elseif (current_az >= 45 && current_az <= 135)
					Debug.Notification("45 > az > 135 : 90")
					az = 90
					float compatible =  az + 90
					float saz = Math.sin(compatible)
					float caz = Math.cos(compatible)
					fax = saz * ax
					fay = caz * ax 
				endif
				
				; if (current_ax != 0.0)
					; if ((current_az_a > 45 && current_az_a < 135) || (current_az_a > 225 && current_az_a < 315))
						; ac = Math.ceiling(current_ax / Math.cos(current_az_a))
						; Trace("ac = current_ax / cos(current_az) = [" + ac + "]")
					; else
						; There is danger of div by 0 here...
						; ac = Math.ceiling(current_ay / Math.sin(current_az_a))
						; Trace("ac = current_ay / sin(current_az) = [" + ac + "]")
					; endif
					; ac += Math.ceiling(ax - current_ax)
					; Trace("ac += (ax - current_ax) = [" + ac + "]")
				; else
					; ac = Math.ceiling(ax)
					; Trace("ac = ax = [" + ac + "]")
				; endif
				
				; Add update/change to original...
				; Fix AX and AY....

				;; ax, ay comes from NPC, not furniture. So it already 
				;; represents what is expected from the NPC (all anglex)
				;; az facing needs to be reversed to get the right sin values... 
				; float gamemapcompatible = az + 90
				; fax = ax * Math.sin(az)
				; fay = ax * Math.cos(az)
				
			endif
		endif
			
		if marker
			marker.TranslateTo(x, y, z, fax, fay, az, speed, rotationSpeed)
		endif
	endif

	translationstatus      = 0
	RegisterForRemoteEvent(npc, "OnTranslationComplete")
	RegisterForRemoteEvent(npc, "OnTranslationFailed")	
	npc.TranslateTo(x, y, z, ax, ay, az , speed, rotationSpeed)
	int maxwait = 20
	while (0 == translationstatus && maxwait > 0)
		maxwait -= 1
		Utility.wait(0.5)
	endwhile

	; if (isFurniture && marker)
		; npc.SnapIntoInteraction(marker)
	; endif
	
	pose_x = x
	pose_y = y
	pose_z = z
	pose_angle_x = ax
    pose_angle_y = ay
	pose_angle_z = az
	
	if (keepoffset != 0.0)
		player_keepoffset_heading_offset = Game.GetPlayer().GetAngleZ() - npc.GetAngleZ()		
	endif
	
EndFunction

Event ObjectReference.OnTranslationComplete(ObjectReference akObject)
	Trace("OnTranslationComplete()")
	UnregisterForRemoteEvent(akObject, "OnTranslationComplete")
	if (0 == translationstatus)
		translationstatus = 1
	endif
EndEvent

Event ObjectReference.OnTranslationFailed(ObjectReference akObject)
	Trace("OnTranslationFailed()")
	if (0 == translationstatus)
		translationstatus = 2
	endif
EndEvent

Event OnUnload()
	Trace("OnUnLoad()")
	CancelTimer(REPLAY_TIMER)
EndEvent

Event OnLoad()
	Actor npc = self.GetActorRef()
	Trace("OnLoad()")
	
	if restoreOnNextLoad
		RestoreCustomRaceAppearance();
	endif
	
	if (CurrentPoseId > -1)
		if (npc.IsInFaction(pTweakPosedFaction))
			npc.SetMotionType(npc.Motion_Keyframed)
			PlayCurrentPose()
		else
			Trace("NPC has CurrentPoseId but is not in TweakPosedFaction. Ending Pose")
			StopPosing(true)
		endif
	endif
EndEvent

Event OnTimer(int aiTimerID)

	Trace("OnTimer. aiTimerID = [" + aiTimerID + "]")
	
	if (MONITOR_LEAVE == aiTimerID)
		Trace("MONITOR_LEAVE")
		if (!DistanceWithin(Game.GetPlayer(),self.GetReference(),500))
			Trace("Outside Range. Stopping Pose")
			StopPosing(true)
			return
		endif
		Trace("Still within range")		
		StartTimer(4 , MONITOR_LEAVE)
	endif
	
	if (MONITOR_PLAYER_XY == aiTimerID)
	
		if (keepoffset == 0.0)
			; Timers do not auto-renew
			return
		endif
		
		Actor pc  = Game.GetPlayer()
		
		if (pc.X != player_keepoffset_last_x || pc.Y != player_keepoffset_last_y)
			EnforceKeepOffset()			
		else
			float current_angle_z = pc.GetAngleZ()
			; We have a 80 degree leniency window...
			if (player_keepoffset_last_anglez > 40 && player_keepoffset_last_anglez < 320)
				if ((current_angle_z > (player_keepoffset_last_anglez + 40)) || \
					(current_angle_z < (player_keepoffset_last_anglez - 40)))
					EnforceKeepOffset()
				endif
			elseif (player_keepoffset_last_anglez > 319)
				if ((current_angle_z < (player_keepoffset_last_anglez - 40)) && \
					(current_angle_z > (player_keepoffset_last_anglez - 320)))
					EnforceKeepOffset()
				endif
			else ; playerr_keepoffset_last_anglez < 41
				if ((current_angle_z > (player_keepoffset_last_anglez + 40)) && \
					(current_angle_z < (player_keepoffset_last_anglez + 319)))
					EnforceKeepOffset()
				endif
			endif		
		endif
		StartTimer(0.5,MONITOR_PLAYER_XY)
		return
	endif
	
	if (REPLAY_TIMER == aiTimerID)
		Trace("REPLAY_TIMER")
		PlayCurrentPose() ; PlayCurrentPose restarts timer
		return
	endif
	
EndEvent

; We register for Player WeaponDraw when the NPC is Posed IF they are 
; in the CurrentCompanionFaction....

; Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	; Trace("OnAnimationEvent for [" + akSource + "] : [" + asEventName + "]")
	; UnregisterForAnimationEvent(akSource, asEventName)
	; Actor pc = Game.GetPlayer()
	; if (akSource == pc && "weaponDraw" == asEventName)	
		; Actor npc = self.GetActorRef()
		; if !self.GetActorRef().IsDead()
			; TweakChangeAppearance pTweakChangeAppearance = GetOwningQuest() as TweakChangeAppearance
			; if pTweakChangeAppearance
				; if pTweakChangeAppearance.GetState() != "None"
					; pTweakChangeAppearance.OnChoiceEnd()
				; else
					; StopPosing(true)
				; endif
			; endif
		; endif
	; endif
; endEvent

Event OnAnimationEventUnregistered(ObjectReference akSource, string asEventName)
	Trace("OnAnimationEventUnregistered for [" + akSource + "] : [" + asEventName + "]")
EndEvent

Function EnforceKeepOffset()
	Actor pc = Game.GetPlayer()
	Actor npc = self.GetActorRef()
		
	float[] posdata = TraceCircle(pc, keepoffset)
	
	; float zOffset = Statue.GetHeadingAngle(Game.GetPlayer())
	; Statue.SetAngle(Statue.GetAngleX(), Statue.GetAngleY(), Statue.GetAngleZ() + zOffset)
	
	Trace("pc.GetAngleZ()  = [" + pc.GetAngleZ() + "]")
	Trace("npc.GetAngleZ() = [" + npc.GetAngleZ() + "]")
	Trace("npc.GetHeadingAngle(pc) = [" + npc.GetHeadingAngle(pc) + "]")
	Trace("pc.GetHeadingAngle(npc) = [" + pc.GetHeadingAngle(npc) + "]")
	Trace("EnforceKeepOffset. original heading = [" + player_keepoffset_heading_offset + "]")

	; TranslatePosedTo will re-register the distance-events.
	TranslatePosedTo(posdata[0], posdata[1], npc.GetPositionZ(), npc.GetAngleX(), npc.GetAngleY(), \
	                 Enforce360Bounds(pc.GetAngleZ() - player_keepoffset_heading_offset), \
					 150.0, 200.0)

	Trace("EnforceKeepOffset. new heading = [" + player_keepoffset_heading_offset + "]")
					 
	player_keepoffset_last_x      = pc.X
	player_keepoffset_last_y      = pc.Y
	player_keepoffset_last_anglez = pc.GetAngleZ()
		
EndFunction

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

Float Function ConvertToSinCosCompatibleAngle(Float original, Float angleOffset = 0.0)

	; See TweakFollowerScript for explanation	
	return Enforce360Bounds(450 - original + angleOffset)
	
EndFunction

; SQUARE ROOT is expensive. Most people dont actually want to KNOW the distance. They
; simply want equality or range checks, which you can do without the square root...
Bool Function DistanceWithin(ObjectReference a, ObjectReference b, float radius)
	float total  = 0
	float factor = a.GetPositionX() - b.GetPositionX()
	total += (factor * factor)
	factor = a.GetPositionY() - b.GetPositionY()
	total += (factor * factor)
	factor = a.GetPositionZ() - b.GetPositionZ()
	total += (factor * factor)
	return ((radius * radius) > total)
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

Event OnReset()
	Trace("TweakAppearance OnReset() detected. (Probably should apply appearance settings)")
EndEvent