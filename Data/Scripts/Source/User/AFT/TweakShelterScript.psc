Scriptname AFT:TweakShelterScript extends Quest Conditional

; cqf TweakFollower "AFT:TweakShelterScript.ResetBenches"

Bool Property ShelterSetup Auto Conditional
Bool Property DoorsLocked  Auto Conditional
Bool Property myBeamMeUp   Auto Conditional
Bool Property inSettlement Auto Conditional
GlobalVariable Property pTweakCampDocked Auto Const

; MaterialSwap : CapCharGenTheme01

Perk    Property pImmuneToRadiation Auto Const ;0x000A2775
Keyword Property pLinkPowerArmor    Auto Const
Keyword Property pArmorTypePower    Auto Const
Keyword Property LinkCustom08 		Auto Const
Keyword Property LinkCustom09 		Auto Const

; Camp COntainer Sync
; For upgrade reasons, we only sync on initial creation 
; and (check for/correct sync) on Disable....

Keyword Property WorkshopItemKeyword	Auto Const
Keyword Property WorkshopLinkContainer	Auto Const
Keyword	Property pTweakCampDock			Auto Const

ReferenceAlias  Property pShelterWeapBench     Auto Const
ReferenceAlias  Property pShelterArmorBench    Auto Const
ReferenceAlias  Property pShelterChemBench     Auto Const
ReferenceAlias  Property pShelterCookBench     Auto Const
ReferenceAlias  Property pShelterPowerBench    Auto Const
ReferenceAlias  Property pShelterFridge   	   Auto Const
ReferenceAlias  Property pShelterCenter        Auto Const
WorkshopParentScript Property pWorkshopParent  Auto Const

; Pre-Fab static instances in Game World See CommonWealth, Cell : Wilderness 95,80
ReferenceAlias  Property pShelterStorage       Auto Const
ReferenceAlias  Property pShelterMapMarker     Auto Const
ReferenceAlias  Property pShelterMapTeleport   Auto Const

Quest           Property pTweakExpandCamp      Auto Const

ObjectReference   Property myCenterMarker       Auto hidden
ObjectReference[] Property myFoundation         Auto hidden
ObjectReference[] Property myStairs             Auto hidden

ObjectReference   Property AftCampStorage       Auto hidden

; I originally tried using Get/Set LinkedRefs with keywords, 
; but OMG that was so slow. I think the LinkedRefs have both 
; linear lookup performance and are latent to boot. Using 
; const enums against a local array provides constant, 
; non-latent performance.

ObjectReference[] Property myObjectCache        Auto hidden        
int[]             Property myObjectState        Auto hidden        

Message			Property pTweakScanTerrain       Auto Const
Message			Property pTweakCampTerrainFail   Auto Const
Message			Property pTweakCryoPodHint		 Auto Const
 
; Support med bay:
ActorValue Property LeftAttackCondition auto const
ActorValue Property LeftMobilityCondition auto const
ActorValue Property PerceptionCondition auto const
ActorValue Property RightAttackCondition auto const
ActorValue Property RightMobilityCondition auto const
ActorValue Property EnduranceCondition Auto const
ActorValue Property Rads Auto const
ActorValue Property Health Auto const
SPELL Property CureAddictions Auto Const
Hardcore:HC_ManagerScript Property HC_Manager const auto
Quest 	  Property TweakMemoryLounger Auto Const

int pTweakCampFireLightID     = 0  const
int pTweakCampFireID          = 1  const
int pTweakCampTerminalID      = 2  const
int pTweakCampTerminalStandID = 3  const
int pTweakBed1ID              = 4  const
int pTweakBed2ID              = 5  const
int pTweakSeat1ID             = 6  const
int pTweakSeat2ID             = 7  const
int pTweakMisc1ID             = 8  const 
int pTweakMisc1HelperID       = 9  const ; Lever?

; Ugly, but pTweakMisc2ID is hard coded in Quest TweakMemoryLounger(Script). 
; Update there if this changes...

int pTweakMisc2ID             = 10 const
int pTweakMisc2HelperID       = 11 const ; TweakToilet (When bathroom is option)
int pTweakUFOID               = 12 const
int pTweakUFOLight1ID         = 13 const ; Center
int pTweakUFOLight2ID         = 14 const
int pTweakUFOLight3ID         = 15 const
int pTweakUFOLight4ID         = 16 const
int pTweakUFOLight5ID         = 17 const
int pTweakUFOLight6ID         = 18 const
int pTweakUFOLight7ID         = 19 const

int pTweakModule1ID           = 20 const ; CapsuleMainSunRoof02a
int pTweakModule1ChildID      = 21 const ; CapsuleMain4Way01
int pTweakModule1ChildEnd1ID  = 22 const ; CapsuleExtWallEndFan01
int pTweakModule1ChildEnd2ID  = 23 const ; CapsuleExtWallEndFan01
int pTweakModule1WindowID     = 24 const ; CapsuleExtWallExSmL01a
int pTweakModule1DoorID       = 25 const ; CapsuleExtWallExSmLDoor01
int pTweakFountainID          = 26 const ; Vault_WaterFountain01
int pTweakModule1SwitchID     = 27 const ; 
int pTweakModule1LightAID     = 28 const ; 
int pTweakModule1LightBID     = 29 const ; 
int pTweakModule1LightCID     = 30 const ; 
int pTweakModule1LightDID     = 31 const ; 

int pTweakModule2ID           = 32 const ; CapsuleMainSunRoof02a
int pTweakModule2ChildID      = 33 const ; CapsuleMain4Way01
int pTweakModule2ChildEnd1ID  = 34 const ; CapsuleExtWallEndFan01
int pTweakModule2ChildEnd2ID  = 35 const ; CapsuleExtWallEndFan01
int pTweakModule2WindowID     = 36 const ; CapsuleExtWallExSmL01a
int pTweakModule2DoorID       = 37 const ; CapsuleExtWallExSmLDoor01
int pTweakModule2SwitchID     = 38 const ; 
int pTweakModule2LightAID     = 39 const ; 
int pTweakModule2LightBID     = 40 const ; 
int pTweakModule2LightCID     = 41 const ; 
int pTweakModule2LightDID     = 42 const ; 

int pTweakModule3ID           = 43 const ; CapsuleMainSunRoof02a
int pTweakModule3ChildID      = 44 const ; CapsuleMain4Way01
int pTweakModule3ChildEnd1ID  = 45 const ; CapsuleExtWallEndFan01
int pTweakModule3ChildEnd2ID  = 46 const ; CapsuleExtWallEndFan01
int pTweakModule3WindowID     = 47 const ; CapsuleExtWallExSmL01a
int pTweakModule3DoorID       = 48 const ; CapsuleExtWallExSmLDoor01
int pTweakModule3SwitchID     = 49 const ; 
int pTweakModule3LightAID     = 50 const ; 
int pTweakModule3LightBID     = 51 const ; 
int pTweakModule3LightCID     = 52 const ; 
int pTweakModule3LightDID     = 53 const ; 

int pTweakModule4ID           = 54 const ; CapsuleMainSunRoof02a
int pTweakModule4ChildID      = 55 const ; CapsuleMain4Way01
int pTweakModule4ChildEnd1ID  = 56 const ; CapsuleExtWallEndFan01
int pTweakModule4ChildEnd2ID  = 57 const ; CapsuleExtWallEndFan01
int pTweakModule4WindowID     = 58 const ; CapsuleExtWallExSmL01a
int pTweakModule4DoorID       = 59 const ; CapsuleExtWallExSmLDoor01
int pTweakModule4SwitchID     = 60 const ; 
int pTweakModule4LightAID     = 61 const ; 
int pTweakModule4LightBID     = 62 const ; 
int pTweakModule4LightCID     = 63 const ; 
int pTweakModule4LightDID     = 64 const ; 

int pTweakTurretNorth1ID      = 65 const ; 
int pTweakTurretNorth2ID      = 66 const ; 
int pTweakTurretSouth1ID      = 67 const ; 
int pTweakTurretSouth2ID      = 68 const ; 
int pTweakTurretEast1ID       = 69 const ; 
int pTweakTurretEast2ID       = 70 const ; 
int pTweakTurretWest1ID       = 71 const ; 
int pTweakTurretWest2ID       = 72 const ; 

int pTweakTurretUFONorthID    = 73 const ; 
int pTweakTurretUFOSouthID    = 74 const ; 
int pTweakTurretUFOEastID     = 75 const ; 
int pTweakTurretUFOWestID     = 76 const ; 
int pTweakTurretUFOCannonID   = 77 const ; 

int pTweakNumCached           = 78 const

; UFO Support
Sound 		Property OBJVaultTransformerHumALP Auto Const
Int			Property myUFOSoundID         Auto hidden
Bool        Property pShownTeleportHint   Auto hidden

; Turret Support (Needed Custom Turrets)
ActorBase		Property pTweakTurret1	  		Auto Const


GlobalVariable Property TweakCampModule1Enabled    Auto Const
GlobalVariable Property TweakCampModule1Light  	   Auto Const
GlobalVariable Property TweakCampModule2Enabled    Auto Const
GlobalVariable Property TweakCampModule2Light  	   Auto Const
GlobalVariable Property TweakCampModule3Enabled    Auto Const
GlobalVariable Property TweakCampModule3Light  	   Auto Const
GlobalVariable Property TweakCampModule4Enabled    Auto Const
GlobalVariable Property TweakCampModule4Light  	   Auto Const


GlobalVariable Property pTweakCampUFOEnabled       Auto Const
GlobalVariable Property pTweakCampUFOHieght        Auto Const
GlobalVariable Property pTweakCampUFOSettings      Auto Const

GlobalVariable Property pTweakCampTurretsEnabled   Auto Const
GlobalVariable Property pTweakCampCookEnabled      Auto Const
GlobalVariable Property pTweakCampWeapEnabled      Auto Const
GlobalVariable Property pTweakCampArmorEnabled     Auto Const
GlobalVariable Property pTweakCampChemEnabled      Auto Const
GlobalVariable Property pTweakCampPAStationEnabled Auto Const
GlobalVariable Property pTweakCampBed1Enabled      Auto Const
GlobalVariable Property pTweakCampBed2Enabled      Auto Const
GlobalVariable Property pTweakCampSeatsEnabled     Auto Const
GlobalVariable Property pTweakCampSeats2Enabled    Auto Const
GlobalVariable Property pTweakCampDogHouseEnabled  Auto Const
GlobalVariable Property pTweakCampMisc2Enabled     Auto Const

; GlobalVariable Property pTweakCampUFOBeamUp        Auto Const ; scrap (possibly remove global)
GlobalVariable Property pTweakUsingMemoryLounger Auto Const
GlobalVariable Property pTweakCampIgnorePA		 Auto Const
GlobalVariable Property pTweakCampDoorsLocked     Auto Const

Terminal       Property pTweakCampTerminal         Auto Const

; Camp Rule Enforcement
Message  Property pTweakTeardownSchedule      Auto Const
FormList Property pTweakActorTypes            Auto Const
Terminal Property pTweakVisualFailHostile     Auto Const
Terminal Property pTweakVisualFailInterior    Auto Const
Terminal Property pTweakVisualFailCombat      Auto Const
WorldSpace Property pCommonWealth             Auto Const
Message  Property pTweakCampAvailable         Auto Const
Message  Property pTweakBeamMeUp              Auto Const

; Memory Lounger:
Weather            Property OldWeather Auto Hidden

Activator Property TweakLightSwitch Auto Const
Activator Property TweakLightSwitchB Auto Const
Activator Property TweakLightSwitchC Auto Const
Activator Property TweakLightSwitchD Auto Const
Activator Property TweakWorkshopCampDock Auto Const

TweakDLC03Script Property pTweakDLC03Script Auto Const
TweakDLC04Script Property pTweakDLC04Script Auto Const

Event OnQuestInit()
	inSettlement = false
	pTweakCampDocked.SetValue(0)
	RegisterForPlayerSleep()
	myUFOSoundID = -1
	pShownTeleportHint = False
	DoorsLocked  = False
	myFoundation = new ObjectReference[0]
	myStairs     = new ObjectReference[0]
	myObjectCache = new ObjectReference[pTweakNumCached]
	myObjectState = new int[pTweakNumCached]
EndEvent

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakShelterScript"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Function DockCamp()
	ObjectReference pAFTMapMarker = pShelterMapMarker.GetReference()
	if pAFTMapMarker.Is3DLoaded()
		WorkshopScript workshopRef = pWorkshopParent.GetWorkshopFromLocation(pAFTMapMarker.GetCurrentLocation())
		ObjectReference CampTerminalStand = myObjectCache[pTweakCampTerminalStandID]
		if workshopRef && CampTerminalStand && CampTerminalStand.Is3DLoaded() && workshopRef.Is3DLoaded()		
			ObjectReference cDock = workshopRef.GetLinkedRef(pTweakCampDock)
			if cDock
				Trace("Existing TweakCampDock [" + pTweakCampDock + "] Found. Removing.")
				cDock.Disable()
				cDock.Delete()
				workshopRef.SetLinkedRef(None, pTweakCampDock)
			endif
			ObjectReference newDock = CampTerminalStand.placeatme(TweakWorkshopCampDock,1,true)
			Utility.waitmenumode(0.1)
			workshopRef.SetLinkedRef(newDock, pTweakCampDock)
			pTweakCampDocked.SetValue(1)
		endIf
	endIf
EndFunction

Function UnDockCamp()
	ObjectReference pAFTMapMarker = pShelterMapMarker.GetReference()
	if pAFTMapMarker.Is3DLoaded()
		WorkshopScript workshopRef = pWorkshopParent.GetWorkshopFromLocation(pAFTMapMarker.GetCurrentLocation())
		if workshopRef && workshopRef.Is3DLoaded()		
			ObjectReference cDock = workshopRef.GetLinkedRef(pTweakCampDock)		
			if cDock
				Trace("Existing TweakCampDock [" + pTweakCampDock + "] Found. Removing.")
				cDock.Disable()
				cDock.Delete()
				workshopRef.SetLinkedRef(None, pTweakCampDock)
			endif
		endIf
	endIf
	pTweakCampDocked.SetValue(0)
EndFunction

Function AftReset()

	Trace("============= AftReset() ================")
	if (ShelterSetup)
		TransferToLocalSettlement()
		TearDownCamp()
	endIf
	if (pTweakExpandCamp.GetStage() > 0)
		if (pTweakExpandCamp.IsRunning())
			pTweakExpandCamp.Stop()
		endIf
		pTweakExpandCamp.Reset()
	endif
	
	myUFOSoundID = -1
	pShownTeleportHint = False
	DoorsLocked  = False
	
	myFoundation.Clear()
	myStairs.Clear()
	myObjectCache.Clear()
	myObjectState.Clear()
	
	myObjectCache = new ObjectReference[pTweakNumCached]
	myObjectState = new int[pTweakNumCached]

	TweakCampModule1Enabled.SetValue(0)
	TweakCampModule1Light.SetValue(0)
	TweakCampModule2Enabled.SetValue(0)
	TweakCampModule2Light.SetValue(0)
	TweakCampModule3Enabled.SetValue(0)
	TweakCampModule3Light.SetValue(0)
	TweakCampModule4Enabled.SetValue(0)
	TweakCampModule4Light.SetValue(0)
	pTweakCampUFOEnabled.SetValue(0)
	pTweakCampTurretsEnabled.SetValue(0)
	pTweakCampBed1Enabled.SetValue(0)
	pTweakCampBed2Enabled.SetValue(0)
	pTweakCampSeatsEnabled.SetValue(0)
	pTweakCampSeats2Enabled.SetValue(0)
	pTweakCampDogHouseEnabled.SetValue(0)
	pTweakCampMisc2Enabled.SetValue(0)
	pTweakCampIgnorePA.SetValue(0)
	pTweakCampDoorsLocked.SetValue(0)
	
	ResetBenches()
	
	ObjectReference removeit = pShelterCenter.GetReference()
	pShelterCenter.Clear()
	
	if removeit
		removeit.Disable()
		removeit.Delete()		
	endif

	removeit = pShelterStorage.GetReference()
	pShelterStorage.Clear()
	if removeit
		removeit.Disable()
		removeit.Delete()		
	endif
	
	removeit = pShelterMapMarker.GetReference()
	pShelterMapMarker.Clear()
	if removeit
		removeit.MoveToMyEditorLocation()
	endif

	removeit = pShelterMapTeleport.GetReference()
	pShelterMapTeleport.Clear()
	if removeit
		removeit.MoveToMyEditorLocation()
	endif
	
	UnRegisterForPlayerSleep()
	UnregisterForPlayerTeleport()
EndFunction

Function ResetBenches()

	ObjectReference removeit = None
	removeit = pShelterWeapBench.GetReference()
	pShelterWeapBench.Clear()
	if removeit
		removeit.disable()
		removeit.delete()
	endif
	
	removeit = pShelterArmorBench.GetReference()
	pShelterArmorBench.Clear()
	if removeit
		removeit.disable()
		removeit.delete()
	endif
	
	removeit = pShelterChemBench.GetReference()
	pShelterChemBench.Clear()
	if removeit
		removeit.disable()
		removeit.delete()
	endif
	
	removeit = pShelterCookBench.GetReference()
	pShelterCookBench.Clear()
	if removeit
		removeit.disable()
		removeit.delete()
	endif
	
	removeit = pShelterPowerBench.GetReference()
	pShelterPowerBench.Clear()
	if removeit
		removeit.disable()
		removeit.delete()
	endif
	
	removeit = pShelterFridge.GetReference()
	pShelterFridge.Clear()
	if removeit
		removeit.disable()
		removeit.delete()
	endif
	
	pTweakCampCookEnabled.SetValue(1)
	pTweakCampWeapEnabled.SetValue(0)
	pTweakCampArmorEnabled.SetValue(0)
	pTweakCampChemEnabled.SetValue(0)
	pTweakCampPAStationEnabled.SetValue(0)
		
EndFunction

; I wanted camp to be both simple (realistic) and advanced. In a game that offers workshops where users can build
; skyscrapers, I figured people would be more interested in functionality over asthetic. At a minimum, camp
; offers a portable map marker. An anchor you can plop down anywhere that allows fast access. Setting up camp
; also allows you to quickly teleport your powerarmor (and companion assigned powerarmors) to a single location. 
; Basic camp provides a cooking spit where you can store all the items you want and a matress so you can stay 
; well rested. For realism, that may be all some users are interested in. But other users can optionally 
; complete the Expand Camp quests to enable something more exotic and customized. 

Function MakeCamp(bool refresh = false, bool beamup = false)
	Trace("MakeCamp() Refresh[" + refresh + "]")
	
	; Create a snapshot of the player location with the "pc" object. That way
	; if the player moves, it wont affect the layout...
 
	Actor player = Game.GetPlayer()
	
	float playeraz = player.GetAngleZ()
	float playerx  = player.X	
	float playery  = player.Y	
	float playerz  = player.Z

	Trace("Original Player [" + playerx + "," + playery + "," + playerz + "] : [" + playeraz + "]")
	
	ObjectReference pAFTMarkerHeading = pShelterMapTeleport.GetReference()
	if (refresh)
		playeraz = pAFTMarkerHeading.GetAngleZ()
		playerx  = pAFTMarkerHeading.GetPositionX()	
		playery  = pAFTMarkerHeading.GetPositionY()	
		playerz  = pAFTMarkerHeading.GetPositionZ()
	endif
	Form InvisibleGeneric01 = Game.GetForm(0x00024571)
	ObjectReference spawnMarker = player.PlaceAtMe(InvisibleGeneric01)
	if (!spawnMarker)
		Trace("Error, Unable to create Spawn Marker")
		return
	endif
	
	spawnMarker.SetPosition(playerx,playery,playerz)
	spawnMarker.SetAngle(0.0,0.0, playeraz)
	
	ObjectReference pccopy = spawnMarker.PlaceAtMe(InvisibleGeneric01)
	if (!pccopy)
		Trace("Error, Unable to create pccopy")
		return
	endif
	pccopy.SetPosition(playerx,playery,playerz)
	pccopy.SetAngle(0.0,0.0, playeraz)
		
	float[] posdata
  
	; Note, when TweakExpandCamp transitions from phase 20 to 30 (purchase foundation),
	; that quest calls TearDownCamp. So we dont need to worry about scenarios where
	; the player is in camp and suddenly we have a foundation to deal with. We will 
	; never have to build a foundation when refresh is true...
 
	myCenterMarker = pShelterCenter.GetReference()
	bool hasFoundation = pTweakExpandCamp.GetStage() > 20
	bool teleport = false
 
	if (!refresh)
 
		if player.IsInCombat()
			pTweakVisualFailCombat.ShowOnPipBoy()
			pccopy.delete()
			spawnMarker.delete()
			return
		endif
		
		if (player.IsInInterior())
			Trace("Location Considered Interior")
			pTweakVisualFailInterior.ShowOnPipBoy()
			pccopy.delete()
			spawnMarker.delete()
			return
		endif
		
		if (player.GetWorldSpace() != pCommonWealth)
			Trace("Location Exterior but not CommonWealth")
			bool allowBuild = false
			Location currentLocation = player.GetCurrentLocation()
			if currentLocation
				int currentLocID = GetPluginID(currentLocation.GetFormID())				
				if pTweakDLC03Script.Installed
					Trace("Testing [" + currentLocID + "] == [" + pTweakDLC03Script.resourceID + "]?")			
					if currentLocID == pTweakDLC03Script.resourceID
						allowBuild = true
					endIf
				endIf
				if !allowBuild && pTweakDLC04Script.Installed
					Trace("Testing [" + currentLocID + "] == [" + pTweakDLC04Script.resourceID + "]?")			
					if currentLocID == pTweakDLC04Script.resourceID
						allowBuild = true
					endIf				
				endif	
			else
				Trace("Current Location returning None")			
			endif
			if !allowBuild
				pTweakVisualFailInterior.ShowOnPipBoy()
				pccopy.delete()
				spawnMarker.delete()
				return			
			endif						
		endIf
		
		if IsHostileNearby()
			pTweakVisualFailHostile.ShowOnPipBoy()
			pccopy.delete()
			spawnMarker.delete()			
			return
		endif
		
  		Trace("Requesting Player Exit Armor")
  		player.SwitchToPowerArmor(None)
		int maxwait = 6
		while (0 != player.GetSitState() && maxwait > 0)
			Utility.wait(1.0)
			maxwait -= 1
		endwhile	
		
		if (myCenterMarker)
			myCenterMarker.MoveToIfUnLoaded(pccopy)
		else
			myCenterMarker = pccopy.PlaceAtMe(InvisibleGeneric01)
			if (myCenterMarker)
				Trace("Created myCenterMarker...")
				pShelterCenter.ForceRefTo(myCenterMarker)
			else
				Trace("Failure : Creating Center Marker...")
			endif
		endif
  
		if (myCenterMarker)
			posdata = TraceCircle(pccopy,256)
			myCenterMarker.SetPosition(posdata[0],posdata[1],posdata[2])
			myCenterMarker.SetAngle(0.0,0.0, myCenterMarker.GetAngleZ() + myCenterMarker.GetHeadingAngle(pccopy))
		else
			Trace("Failure : Unable to create myCenterMarker")
			pccopy.delete()
			spawnMarker.delete()			
			return
		endif	

		; Are we in a settlement?
		WorkshopScript workshopRef = pWorkshopParent.GetWorkshopFromLocation(pccopy.GetCurrentLocation())
		if workshopRef
			Trace("Current Location is Workshop")
			inSettlement = true
			
			; Has the player set a Camp Dock?
			ObjectReference cDock = workshopRef.GetLinkedRef(pTweakCampDock)
			if cDock
				Trace("TweakCampDock [" + pTweakCampDock + "] Found")
			
				if cDock.Is3DLoaded()
					pTweakCampDocked.SetValue(1)
					; Adjust Camp Build Location
					Trace("TweakCampDock 3D is Loaded. Updating SpawnMarker, myCenterMarker and pccopy")
					spawnMarker.SetPosition(cDock.GetPositionX(), cDock.GetPositionY(),cDock.GetPositionZ() + 133)
					spawnMarker.SetAngle(0.0,0.0, cDock.GetAngleZ() - 130)
					Utility.wait(0.1)
					posdata = TraceCircle(spawnMarker,368,145)
					myCenterMarker.SetPosition(posdata[0],posdata[1],posdata[2])
					myCenterMarker.SetAngle(0.0,0.0, spawnMarker.GetAngleZ())
					posdata = TraceCircle(myCenterMarker,256)
					playerx  = posdata[0]
					playery  = posdata[1]
					playerz  = posdata[2]
					pccopy.SetPosition(playerx,playery,playerz)
					pccopy.SetAngle(0.0,0.0, pccopy.GetAngleZ() + pccopy.GetHeadingAngle(myCenterMarker))
					playeraz = pccopy.GetAngleZ()
					Trace("New Player [" + playerx + "," + playery + "," + playerz + "] : [" + playeraz + "]")					
				else
					Trace("TweakCampDock 3D Not loaded. Skipping")
				endif				
			else
				Trace("TweakCampDock [" + pTweakCampDock + "] Not Found")
			endif
			
		else
			Trace("Current Location does NOT have Workshop")
			inSettlement = false
		endif

		
		; ----------------------------------
		; ----------------------------------
		; Foundation
		; ----------------------------------
	
		if (hasFoundation)
		
			; Foundation includes things that can't be disabled. 
			
			pTweakScanTerrain.Show()
   
			; Camp consists of a 1024x1024 grid. We spawn havok reactive objects at 
			; the corners to test terrain high and figure out how to proceed. 
   
			; |---|---|---|---|
			; |   |   |   |   |
			; |---|---|---|---|  * = pShelterCenter/myCenterMarker
			; |   |   |   |   |  P = Player (256 South of center)
			; |---|---*---|---|
			; |   |   ^   |   |
			; |---|---P---|---|
			; |   |   |   |   |
			; |---|---|---|---|   
			;
			; Each Box : 
			; Width    = 256     Center to Corner : SQRT(512^2 + 512^2) = 724.08
			; Length   = 256     Angle = ArcTan(512/512) = 45
			; Height   = 215
   
  
			MiscObject BobbyPin = Game.GetForm(0x0000000A) as MiscObject  
			ObjectReference ne_test = myCenterMarker.PlaceAtMe(BobbyPin)
			ObjectReference se_test = myCenterMarker.PlaceAtMe(BobbyPin)
			ObjectReference nw_test = myCenterMarker.PlaceAtMe(BobbyPin)
			ObjectReference sw_test = myCenterMarker.PlaceAtMe(BobbyPin)

			posdata = TraceCircle(myCenterMarker, 724.08, 135.0)   ; Top Right
			spawnMarker.SetPosition(posdata[0],posdata[1],posdata[2])
			ne_test.SetPosition(spawnMarker.GetPositionX(),spawnMarker.GetPositionY(),spawnMarker.GetPositionZ() + 200)
			float ne_z = ne_test.GetPositionZ()
			Trace("ne_z [" + ne_z + "]")
  
			posdata = TraceCircle(myCenterMarker, 724.08, 45.0)   ; Bottom Right
			spawnMarker.SetPosition(posdata[0],posdata[1],posdata[2])
			se_test.SetPosition(spawnMarker.GetPositionX(),spawnMarker.GetPositionY(),spawnMarker.GetPositionZ() + 200)
			float se_z = se_test.GetPositionZ()
			Trace("se_z [" + se_z + "]")
   
			posdata = TraceCircle(myCenterMarker, 724.08, -135.0)    ; Top Left
			spawnMarker.SetPosition(posdata[0],posdata[1],posdata[2])
			nw_test.SetPosition(spawnMarker.GetPositionX(),spawnMarker.GetPositionY(),spawnMarker.GetPositionZ() + 200)
			float nw_z = nw_test.GetPositionZ()
			Trace("nw_z [" + nw_z + "]")

			posdata = TraceCircle(myCenterMarker, 724.08, -45.0)   ; Bottom Left
			spawnMarker.SetPosition(posdata[0],posdata[1],posdata[2])
			sw_test.SetPosition(spawnMarker.GetPositionX(),spawnMarker.GetPositionY(),spawnMarker.GetPositionZ() + 200)
			float sw_z = sw_test.GetPositionZ()
			Trace("sw_z [" + sw_z + "]")
   
			maxwait = 11
			bool keepwaiting = true   
			while (keepwaiting && maxwait > 0)
				Utility.wait(1.0)
				if (0 == (maxwait % 3))
					pTweakScanTerrain.Show()
				endif
				keepwaiting = false
				if (ne_z - ne_test.GetPositionZ() > 20)
					ne_z = ne_test.GetPositionZ()
					Trace("ne_test changed [" + ne_z + "]")
					keepwaiting = true
				endif
				if (se_z - se_test.GetPositionZ() > 20)
					se_z = se_test.GetPositionZ()
					Trace("se_test changed [" + se_z + "]")
					keepwaiting = true
				endif
				if (nw_z - nw_test.GetPositionZ() > 20)
					nw_z = nw_test.GetPositionZ()
					Trace("nw_test changed [" + nw_z + "]")
					keepwaiting = true
				endif
				if (sw_z - sw_test.GetPositionZ() > 20)
					sw_z = sw_test.GetPositionZ()
					Trace("sw_test changed [" + sw_z + "]")
					keepwaiting = true
				endif
				maxwait -= 1
			endWhile
   
			ne_test.Delete()   
			se_test.Delete()
			nw_test.Delete()
			sw_test.Delete()
      
			if (0 == maxwait)
				Trace("Search timed out (10 sec). Aborting")
				pTweakCampTerrainFail.show()
				pccopy.Delete()
				spawnMarker.Delete()
				return
			endif
   
			float highest = Math.Max(ne_z,se_z) 
			highest = Math.Max(highest,nw_z) 
			highest = Math.Max(highest,sw_z) 
			float lowest  = Math.Min(ne_z,se_z)
			lowest  = Math.Min(lowest,nw_z)
			lowest  = Math.Min(lowest,sw_z)
   
			Trace("Highest [" + highest + "]")
			Trace("Lowest  [" + lowest +  "]")
      
			float diff = highest - lowest
			If (diff > 2580)
				Trace("Diff Between Highest and Lowest Point is greater than 12 stories. Aborting...")
				pTweakCampTerrainFail.show()
				pccopy.Delete()
				spawnMarker.Delete()
				return
			endif
     
			if playerz > highest
				highest = playerz
			elseif (highest > playerz)
				Trace("Highest Above Player. Adjusting pccopy and myCenterMarker")
				playerz = highest
				; SetPosition causes Angle to reset...
				pccopy.SetPosition(playerx, playery, playerz)
				pccopy.SetAngle(0.0,0.0, playeraz)
				Utility.wait(0.1)
				posdata = TraceCircle(pccopy,256)
				myCenterMarker.SetPosition(posdata[0],posdata[1],posdata[2])
				myCenterMarker.SetAngle(0.0,0.0, pccopy.GetAngleZ() - 180)
				; pAftCampStorage.SetPosition(posdata[0],posdata[1],(posdata[2] - 100))
				; pAftCampStorage.SetAngle(0.0,0.0, pccopy.GetAngleZ() - 180)
				if Game.GetPlayer().GetDistance(myCenterMarker) < 500
					teleport = true
				endif
			endif

			if (myFoundation.length != 0)
				Trace("Removing Previous Foundation")
				int d = 0
				int flen = myFoundation.length
				while (d < flen)
					myFoundation[d].disable()
					myFoundation[d].delete()
					d += 1
				endWhile
				myFoundation.Clear()
			endIf
   
			; Build the 16x16 foundation first:
   
			; |---|---|---|---|
			; |nw |s11|s12| ne|
			; |---|---|---|---|  * = pShelterCenter/myCenterMarker
			; |s7 | s8|s9 |s10|  P = Player (256 south of pShelterCenter)
			; |---|---*---|---|  sw = Start Here....
			; |s3 | s4^s5 | s6|  *->sw distance : 543.06
			; |---|---P---|---|  *->sw angle    : -45 (Center is facing player) 
			; |sw | s1|s2 | se|
			; |---|---|---|---|   
   
			form ShackFoundation02 = Game.GetForm(0x0022C663) ; workshop_ShackMidFloor01Foundation02
			form ShackFloor01 = Game.GetForm(0x000E0B88)      ; workshop_ShackMidFloor01   
			
			Trace("Creating Foundation")   
			ObjectReference sw = CreateFoundation(myCenterMarker, ShackFoundation02,  543.06, -45.0, playeraz, playerz, spawnMarker)
			myfoundation.Add(sw)
			ObjectReference s1 = CreateFoundation(sw, ShackFloor01,     256.0, -90.0, playeraz, playerz, spawnMarker)
			myfoundation.Add(s1)
			ObjectReference s2 = CreateFoundation(sw, ShackFloor01,     512.0, -90.0, playeraz, playerz, spawnMarker)
			myfoundation.Add(s2)   
			ObjectReference se = CreateFoundation(sw, ShackFoundation02,768.0, -90.0, playeraz, playerz, spawnMarker)
			myfoundation.Add(se)
			ObjectReference s3 = CreateFoundation(sw, ShackFloor01,     256.0,   0.0, playeraz, playerz, spawnMarker)
			myfoundation.Add(s3) 
			ObjectReference s4 = CreateFoundation(s3, ShackFloor01,     256.0, -90.0, playeraz, playerz, spawnMarker)
			myfoundation.Add(s4)
			ObjectReference s5 = CreateFoundation(s3, ShackFloor01,     512.0, -90.0, playeraz, playerz, spawnMarker)
			myfoundation.Add(s5)
			ObjectReference s6 = CreateFoundation(se, ShackFloor01,     256.0,   0.0, playeraz, playerz, spawnMarker)
			myfoundation.Add(s6)
			ObjectReference s7 = CreateFoundation(sw, ShackFloor01,     512.0,   0.0, playeraz, playerz, spawnMarker)
			myfoundation.Add(s7)
			ObjectReference s8 = CreateFoundation(s7, ShackFloor01,     256.0, -90.0, playeraz, playerz, spawnMarker)
			myfoundation.Add(s8)
			ObjectReference s9 = CreateFoundation(s7, ShackFloor01,     512.0, -90.0, playeraz, playerz, spawnMarker)
			myfoundation.Add(s9)
			ObjectReference s10= CreateFoundation(se, ShackFloor01,     512.0,   0.0, playeraz, playerz, spawnMarker)
			myfoundation.Add(s10)
			ObjectReference nw = CreateFoundation(sw, ShackFoundation02,768.0,   0.0, playeraz, playerz, spawnMarker)
			myfoundation.Add(nw)
			ObjectReference s11= CreateFoundation(nw, ShackFloor01,     256.0, -90.0, playeraz, playerz, spawnMarker)
			myfoundation.Add(s11)
			ObjectReference s12= CreateFoundation(nw, ShackFloor01,     512.0, -90.0, playeraz, playerz, spawnMarker)
			myfoundation.Add(s12)   
			ObjectReference ne = CreateFoundation(se, ShackFoundation02,768.0,   0.0, playeraz, playerz, spawnMarker)
			myfoundation.Add(ne)

			;======================================
			; Player Armor
			;======================================

			if 0 == pTweakCampIgnorePA.GetValue() && !player.WornHasKeyword(pArmorTypePower)
				; LinkedRef Managed by TweakMonitorPlayer Quest....
				ObjectReference pa = player.GetLinkedRef(pLinkPowerArmor)
				if (pa && myCenterMarker)
					if (pa.GetLinkedRef(pLinkPowerArmor) == player)
						posdata = TraceCircle(myCenterMarker, 384, -82)
						spawnMarker.SetPosition(posdata[0],posdata[1],posdata[2])
						if (!hasFoundation)
							spawnMarker.MoveToNearestNavmeshLocation()
						endif
						spawnMarker.SetAngle(0.0,0.0, myCenterMarker.GetAngleZ() - 90)
						if (!pa.Is3DLoaded())
							pa.MoveTo(spawnMarker)
							pa.Disable()
							pa.Enable()
							Utility.wait(0.1)
						elseif !DistanceWithin(pa, spawnMarker, 10) ; Did it move?
							pa.SetPosition(spawnMarker.GetPositionX(), spawnMarker.GetPositionY(), spawnMarker.GetPositionZ())
							pa.SetAngle(0.0,0.0, spawnMarker.GetAngleZ())
							pa.Disable()
							pa.Enable()
							Utility.wait(0.1)
						endif
					endif
				endif
			endif

			if (teleport)
				player.TranslateToRef(pccopy, 500.0)
			endif
			
			; Now extend down for each corner as necessary:
			Trace("Extending Foundation Down")
   
			CreateFoundationLeg(sw.GetPositionX(), sw.GetPositionY(), playeraz, playerz, sw_z, spawnMarker)
			CreateFoundationLeg(se.GetPositionX(), se.GetPositionY(), playeraz, playerz, se_z, spawnMarker)
			CreateFoundationLeg(nw.GetPositionX(), nw.GetPositionY(), playeraz, playerz, nw_z, spawnMarker)
			CreateFoundationLeg(ne.GetPositionX(), ne.GetPositionY(), playeraz, playerz, ne_z, spawnMarker)

			; ----------------------------------
			; Create Stairs
			; ----------------------------------
			
			if (myStairs.length != 0)
				Trace("Removing Previous Stairs")
				int d = 0
				int flen = myStairs.length
				while (d < flen)
					myStairs[d].disable()
					myStairs[d].delete()
					d += 1
				endWhile
				myStairs.Clear()
			endIf

			float north_z = Math.Min(ne_z,nw_z)
			float east_z  = Math.Min(ne_z,se_z)
			float south_z = Math.Min(se_z,sw_z)
			float west_z  = Math.Min(sw_z,nw_z)
			
			;            North
			;       256 256 256 256
			;      |---|---|+--|---|
			;      |   |   |   |   |256
			;      |---|---|---|---|       * = pShelterCenter/myCenterMarker
			;      |   |   |   |   |256    P = Player (256 South of center)
			; West |---|---*---|---| East  + Stairs (94 from center)
			;      |   |   ^   |   |256
			;      |---|---P---|---|
			;      |   |   |   |   |256
			;      |---|---|---|---| 
			;            south
						
			if ((playerz - north_z) < 222)
				if (playerz - north_z > 30)
					Static ShackStairs01 = Game.GetForm(0x00075804) as Static
			
					posdata = TraceCircle(myCenterMarker,520.56, 169.60) ; 523.27, 168.09
					spawnMarker.SetPosition(posdata[0],posdata[1],posdata[2] - 215)
					spawnMarker.SetAngle(0.0,0.0,myCenterMarker.GetAngleZ() + 90)
				
					ObjectReference theStairs = spawnMarker.PlaceAtMe(ShackStairs01)
					theStairs.SetAngle(0.0,0.0,myCenterMarker.GetAngleZ() + 90)
					myStairs.Add(theStairs)
				endif
			else
				Trace("myCenterMarker.GetAngleZ() = [" + myCenterMarker.GetAngleZ() + "]")
				CreateStairwell(myCenterMarker, 681.375, 147.71, myCenterMarker.GetAngleZ(), north_z, spawnMarker)								
			endif

			if ((playerz - east_z) < 222)
				if (playerz - east_z > 30)
					Static ShackStairs01 = Game.GetForm(0x00075804) as Static
					
					posdata = TraceCircle(myCenterMarker,520.56, 79.6)
					spawnMarker.SetPosition(posdata[0],posdata[1],posdata[2] - 215)
					spawnMarker.SetAngle(0.0,0.0,myCenterMarker.GetAngleZ() - 180)
										
					ObjectReference theStairs = spawnMarker.PlaceAtMe(ShackStairs01)
					theStairs.SetAngle(0.0,0.0,spawnMarker.GetAngleZ())
					myStairs.Add(theStairs)
				endif
			else
				Trace("myCenterMarker.GetAngleZ() = [" + myCenterMarker.GetAngleZ() + "]")
				CreateStairwell(myCenterMarker, 681.375, 57.71, myCenterMarker.GetAngleZ() + 90, east_z, spawnMarker)								
			endif
			
			if ((playerz - south_z) < 222)
				if (playerz - south_z > 30)
					Static ShackStairs01 = Game.GetForm(0x00075804) as Static
					
					posdata = TraceCircle(myCenterMarker,520.56, -10.4)
					spawnMarker.SetPosition(posdata[0],posdata[1],posdata[2] - 215)
					spawnMarker.SetAngle(0.0,0.0,myCenterMarker.GetAngleZ() - 90)
					
					ObjectReference theStairs = spawnMarker.PlaceAtMe(ShackStairs01)
					theStairs.SetAngle(0.0,0.0,myCenterMarker.GetAngleZ() - 90)
					myStairs.Add(theStairs)
				endif				
			else
				Trace("myCenterMarker.GetAngleZ() = [" + myCenterMarker.GetAngleZ() + "]")
				CreateStairwell(myCenterMarker, 681.375, -32.29, myCenterMarker.GetAngleZ() + 180, south_z, spawnMarker)								
			endif

			if ((playerz - west_z) < 222)
				if (playerz - west_z > 30)
					Static ShackStairs01 = Game.GetForm(0x00075804) as Static
					
					posdata = TraceCircle(myCenterMarker,520.56, -100.4)
					spawnMarker.SetPosition(posdata[0],posdata[1],posdata[2] - 215)
					spawnMarker.SetAngle(0.0,0.0,myCenterMarker.GetAngleZ())
					
					ObjectReference theStairs = spawnMarker.PlaceAtMe(ShackStairs01)
					theStairs.SetAngle(0.0,0.0,spawnMarker.GetAngleZ())
					myStairs.Add(theStairs)
				endif				
			else
				Trace("myCenterMarker.GetAngleZ() = [" + myCenterMarker.GetAngleZ() + "]")
				CreateStairwell(myCenterMarker, 681.375, -122.29, myCenterMarker.GetAngleZ() - 90, west_z, spawnMarker)								
			endif
			
			; ----------------------------------
			; Create Camp Terminal
			; ----------------------------------

			Static DCKitMetalIBeam01 = Game.GetForm(0x000C570C) as Static
			CreateDecoration(myCenterMarker, pTweakCampTerminalStandID, DCKitMetalIBeam01, 368, -35, -133, 130, spawnMarker, true)
			CreateDecoration(myCenterMarker, pTweakCampTerminalID,      pTweakCampTerminal,368, -37,    0, 130, spawnMarker, true)
			
		endif ; if (pTweakExpandCamp.GetStage() > 20)
    
		posdata = TraceCircle(pccopy,256)
		myCenterMarker.SetPosition(posdata[0],posdata[1],posdata[2])
		Utility.wait(0.1)
		myCenterMarker.SetAngle(0.0,0.0, pccopy.GetAngleZ() - 180)
	
		Trace("Moving AFTMapMarker to spawnMarker")
		ObjectReference pAFTMapMarker     = pShelterMapMarker.GetReference()
		pAFTMapMarker.MoveTo(pccopy)   
		pAFTMarkerHeading.MoveTo(pccopy)   
		if pAFTMapMarker.IsDisabled()
			Trace("Enabling pAFTMapMarker to spawnMarker")
			pAFTMapMarker.Enable()
		endIf
		Trace("Moving AFTMarkerHeading to spawnMarker")
		if pAFTMarkerHeading.IsDisabled()
			pAFTMarkerHeading.Enable()
		endif
				
	
	endif ; if (!refresh)  
   
	if (!myCenterMarker)
		Trace("Error, Unable to create Center Marker")
		spawnMarker.delete()
		pccopy.delete()
		; TearDownShelter()
		TearDownCamp()
		return
	endif
	
	Trace("Ensuring AftCampStorage is Loaded (Otherwise RemoveAll commands will delete)")
	ObjectReference pAftCampStorage     = pShelterStorage.GetReference()
	pAftCampStorage.MoveToIfUnLoaded(myCenterMarker)
	if pAftCampStorage.IsDisabled()
		Trace("Enabling pAFTMapMarker to spawnMarker")
		pAftCampStorage.Enable()
	endIf
	
    ; -------------------------------------
    ; UFO
    ; -------------------------------------
			
    int ufoGlobal = pTweakCampUFOEnabled.GetValueInt()
	Trace("ufoGlobal [" + ufoGlobal + "]")
	ObjectReference theUFO = myObjectCache[pTweakUFOID]
	if (0 != ufoGlobal)
		if (1 == ufoGlobal)
			if (myObjectState[pTweakUFOID] > 1)
				myObjectState[pTweakUFOID] = 1
				if (theUFO)
					Trace("Deleting UFO Decorations")
					DeleteDecoration(pTweakUFOID)
					DeleteDecorationRange(pTweakUFOLight1ID, pTweakUFOLight7ID)				
					if (-1 != myUFOSoundID)
						Sound.StopInstance(myUFOSoundID)
						myUFOSoundID = -1
					endif
					UnregisterForDistanceEvents(player, myCenterMarker)
					if (player.hasPerk(pImmuneToRadiation))
						player.RemovePerk(pImmuneToRadiation)
					endif
				endIf
			endIf
			
		else ; 2 == ufoGlobal
		
			int previousState = myObjectState[pTweakUFOID]
			if (ufoGlobal != previousState)
				myObjectState[pTweakUFOID] = ufoGlobal
			endif
			
			float ufo_height = pTweakCampUFOHieght.GetValue()
			spawnMarker.SetPosition(myCenterMarker.GetPositionX(),myCenterMarker.GetPositionY(),myCenterMarker.GetPositionZ() + ufo_height)
			spawnMarker.SetAngle(0.0,0.0, myCenterMarker.GetAngleZ())
				
			if !(refresh && theUFO && DistanceWithin(theUFO,spawnMarker,30))
				if (theUFO)
				
					; We normally delete everything when we teardown camp, but I 
					; may decide to simply disable at a later date if we want
					; faster performance...
					
					theUFO.MoveToIfUnloaded(spawnMarker)
				else
					Static UFO_01 = Game.GetForm(0x00156BE2) as Static
					Trace("Creating ufo [" + ufoGlobal + "] height [" + ufo_height + "]")			
					theUFO = CreateDecoration(myCenterMarker, pTweakUFOID, UFO_01, 0.0, 0.0, ufo_height, myCenterMarker.GetAngleZ(), spawnMarker, true)
												
				endif
				if (theUFO) ; width = 884
					Trace("UFO created/found. Enforcing Position")			
					theUFO.SetPosition(spawnMarker.GetPositionX(),spawnMarker.GetPositionY(), spawnMarker.GetPositionZ())
					theUFO.SetAngle(0.0,0.0, spawnMarker.GetAngleZ())
					;; Note : disable also stops the sound...
					if (-1 != myUFOSoundID)
						Sound.StopInstance(myUFOSoundID)
						myUFOSoundID = -1
					endif
					theUFO.Disable() ; Fix Texture Blur bug					
					theUFO.Enable()
					Utility.Wait(0.1)
					
					; wait for 3D to load before continuing. (Or sound will fail)					
					int maxwait = 25
					while (!theUFO.Is3DLoaded() && maxwait > 0)
						Utility.wait(0.2)
						maxwait -= 1
					endwhile
					
					myUFOSoundID = OBJVaultTransformerHumALP.Play(theUFO)
				endIf
			endIf
			
			spawnMarker.SetPosition(theUFO.GetPositionX(),theUFO.GetPositionY(),theUFO.GetPositionZ() - 150)
			spawnMarker.SetAngle(0.0,0.0, theUFO.GetAngleZ())
			ObjectReference theCenterLight = myObjectCache[pTweakUFOLight1ID]
			int ufoLightSettings = pTweakCampUFOSettings.GetValueInt()
			
			if !(refresh && theCenterLight && DistanceWithin(theCenterLight,spawnMarker,30) && myObjectState[pTweakUFOLight1ID] == ufoLightSettings)
				int prevlightsettings = myObjectState[pTweakUFOLight1ID]
				if (ufoLightSettings != prevlightsettings)
					myObjectState[pTweakUFOLight1ID] = ufoLightSettings
				endIf
				
				; We dont have to delete the lights because the CreateDecoration below does it for us...
				
				Light theColor = None      
				if (0 == ufoLightSettings)
					theColor = Game.GetForm(0x00023473) as Light ; Purple
				elseif (1 == ufoLightSettings)
					theColor = Game.GetForm(0x00001003) as Light ; Blue
				elseif (2 == ufoLightSettings)
					theColor = Game.GetForm(0x0020A253) as Light ; Green
				elseif (3 == ufoLightSettings)
					theColor = Game.GetForm(0x001179A6) as Light ; Red
				elseif (4 == ufoLightSettings)
					theColor = Game.GetForm(0x00023476) as Light ; Yellow
				elseif (5 == ufoLightSettings)
					theColor = Game.GetForm(0x000039B0) as Light ; Orange
				elseif (6 == ufoLightSettings)
					theColor = Game.GetForm(0x00035BAB) as Light ; Aqua
				endif
				if theColor
					Trace("Creating ufo lights (one color : [" + ufoLightSettings + "])")
					CreateDecoration(theUFO, pTweakUFOLight1ID, theColor, 0.0,   0.0,   -150, 0.0, spawnMarker)
					CreateDecoration(theUFO, pTweakUFOLight2ID, theColor, 300.0, 0.0,   -120, 0.0, spawnMarker)
					CreateDecoration(theUFO, pTweakUFOLight3ID, theColor, 300.0, 60.0,  -120, 0.0, spawnMarker)
					CreateDecoration(theUFO, pTweakUFOLight4ID, theColor, 300.0, 120.0, -120, 0.0, spawnMarker)
					CreateDecoration(theUFO, pTweakUFOLight5ID, theColor, 300.0, 180.0, -120, 0.0, spawnMarker)
					CreateDecoration(theUFO, pTweakUFOLight6ID, theColor, 300.0, 240.0, -120, 0.0, spawnMarker)
					CreateDecoration(theUFO, pTweakUFOLight7ID, theColor, 300.0, 300.0, -120, 0.0, spawnMarker)
				else
					Trace("Creating ufo lights (using all colors)")
					CreateDecoration(theUFO, pTweakUFOLight1ID, Game.GetForm(0x00001003), 0.0,   0.0,   -150, 0.0, spawnMarker)
					CreateDecoration(theUFO, pTweakUFOLight2ID, Game.GetForm(0x00023473), 300.0, 0.0,   -120, 0.0, spawnMarker)
					CreateDecoration(theUFO, pTweakUFOLight3ID, Game.GetForm(0x000039B0), 300.0, 60.0,  -120, 0.0, spawnMarker)
					CreateDecoration(theUFO, pTweakUFOLight4ID, Game.GetForm(0x00035BAB), 300.0, 120.0, -120, 0.0, spawnMarker)
					CreateDecoration(theUFO, pTweakUFOLight5ID, Game.GetForm(0x00023476), 300.0, 180.0, -120, 0.0, spawnMarker)
					CreateDecoration(theUFO, pTweakUFOLight6ID, Game.GetForm(0x001179A6), 300.0, 240.0, -120, 0.0, spawnMarker)
					CreateDecoration(theUFO, pTweakUFOLight7ID, Game.GetForm(0x0020A253), 300.0, 300.0, -120, 0.0, spawnMarker)
				endif
			endif			
			RegisterForDistanceLessThanEvent(player,myCenterMarker, 724)			
		endif
	endif
	   
    ; -------------------------------------
    ; Cooking Bench
    ; -------------------------------------
	; FEVHoundSittingMarker = 00127595
	; DogmeatLay01 = 0005E9C6
	; GorillaSitMarker = 00134DB4
	; NPCStandDrinkCoffee = 001A6AFC
	
	; |---|---|-D-|---|
	; | # |   |   |   |
	; |---|---|---|---|  * = pShelterCenter/myCenterMarker
	; D   |   |   |   |  P = Player (256 South of center)
	; |---|---*---|---|  T = Terminal
	; |   |   ^   |   D  D = Door
	; |---|---P---|---|
	; |   |T      |   |
	; |---|-D-|---|---|   
	
	
    int cookChoice = pTweakCampCookEnabled.GetValueInt()
    if (0 != cookChoice)
		if (1 == cookChoice)
			Trace("Cooking Pot currently disabled [" + cookChoice + "]") 
			EnsureCookBenchDisabled()
		elseif (2 == cookChoice)
			Furniture WorkbenchCookingPot   = Game.GetForm(0x0010C3B6) as Furniture
			MovableStatic pFXFireSmall01    = Game.GetForm(0x001DA027) as MovableStatic
			Light defaultLightFire01Flicker = Game.GetForm(0x0008ADF9) as Light
			ObjectReference theCookBench    = CreateBench(myCenterMarker, pShelterCookBench, WorkbenchCookingPot, 60, 90, 0, 135, spawnMarker, true, !hasFoundation )
			CreateDecoration(theCookBench, pTweakCampFireID, pFXFireSmall01,       60,    0,     15,       0,  spawnMarker, true)
			CreateDecoration(theCookBench, pTweakCampFireLightID, defaultLightFire01Flicker, 60, 0, 20,    0,  spawnMarker, true)
		elseif (3 == cookChoice)
			Furniture WorkbenchCookingStove = Game.GetForm(0x001865B9) as Furniture
			ObjectReference theCookBench    = CreateBench(myCenterMarker, pShelterCookBench, WorkbenchCookingStove, 575, -136.2, 0, 180, spawnMarker, true)
			DeleteDecoration(pTweakCampFireID)
			DeleteDecoration(pTweakCampFireLightID)
		endIf
	endIf
  
    if (!refresh)
        MoveFollowers(myCenterMarker, spawnMarker, !hasFoundation)    
    endif ; if (!refresh)
	
	; We store the previous locked state in the first door's slot:
	int doorsLockedGlobal = pTweakCampDoorsLocked.GetValueInt()
	if myObjectState[pTweakModule1DoorID] != doorsLockedGlobal
		ToggleDoorLocks()
		myObjectState[pTweakModule1DoorID] = doorsLockedGlobal
	endif
	
    ; -------------------------------------
    ; Module 1
    ; -------------------------------------
	; NOTE: The ObjectState shadow array protects against multithread issues
	; if multiple threads come barrelling through at the same time. (reliance
	; on local values means no latent functions to cause if condition failure)
	
    int module1Global = TweakCampModule1Enabled.GetValueInt()
	if (0 != module1Global)
		ObjectReference theModule = myObjectCache[pTweakModule1ID]
		if (1 == module1Global)
			if (myObjectState[pTweakModule1ID] > 1)
				myObjectState[pTweakModule1ID] = 1
				if (theModule)
					DeleteDecorationRange(pTweakModule1ID,pTweakModule1LightDID)
				endIf
			endIf
		else

			if (myObjectState[pTweakModule1ID] != module1Global || !theModule)
		
				; int previousState = myObjectState[pTweakModule1ID]
				myObjectState[pTweakModule1ID] = module1Global	
						
				if (2 == module1Global)
					Trace("Creating Module1 [" + module1Global + "]")
					Static CapsuleMainSunRoof02a     = Game.GetForm(0x0010796D) as Static	; Length [512.000000] Width [256.000000] height [301.000000]	
					Static CapsuleExtWallEndFan01    = Game.GetForm(0x000203D3) as Static 
					Static CapsuleMain4Way01         = Game.GetForm(0x000203E3) as Static ; [256.000000] Width [256.000000] height [283.000000]
					Static CapsuleExtWallExSmL01a    = Game.GetForm(0x0010796A) as Static 
					Door   CapsuleExtWallExSmLDoor01 = Game.GetForm(0x0001346C) as Door 
					Activator Vault_WaterFountain01  = Game.GetForm(0x000B1CFE) as Activator
					
					; |---|---|-D-|---|
					; |   |   |   |   |
					; |---|---|---|---|  * = pShelterCenter/myCenterMarker
					; D   |   |   |   |  P = Player (256 South of center)
					; |---|---*---|---|  T = Terminal
					; |   |   ^   |   D  D = Door
					; |---|---P---|---|
					; |###|T######|   |
					; |---|-D-|---|---|   
			
					ObjectReference Module1 = CreateDecoration(myCenterMarker, pTweakModule1ID,      CapsuleMainSunRoof02a, 384, 0, -60, 90, spawnMarker, true)
					CreateDecoration(Module1, pTweakModule1WindowID, CapsuleExtWallExSmL01a,    0, 0, 0, 0, spawnMarker, true)
					CreateDecoration(Module1, pTweakModule1DoorID,   CapsuleExtWallExSmLDoor01, 0, 0, 0, 0, spawnMarker, true)			
					ObjectReference Module1Child = CreateDecoration(Module1, pTweakModule1ChildID, CapsuleMain4Way01, 384, 0, 0, -90, spawnMarker, true)
					CreateDecoration(Module1, pTweakModule1ChildEnd1ID, CapsuleExtWallEndFan01, 256, 0, 0, 0, spawnMarker, true)
					CreateDecoration(Module1Child, pTweakModule1ChildEnd2ID, CapsuleExtWallEndFan01, 128, -180, 0, 0, spawnMarker, true)
					ObjectReference theSwitch = CreateDecoration(myCenterMarker, pTweakModule1SwitchID, TweakLightSwitch, 522.2, -18, 100, 0, spawnMarker, true)

					; CreateDecoration(ObjectReference, int id, Form base, float pivotDist, float pivotAngle, float ZOffset, float AZOffset, ObjectReference spawnMarker, bool fixTexture = false, bool fixNavmesh = false)

					CreateDecoration(myCenterMarker, pTweakFountainID, Vault_WaterFountain01, 370.5, 37, 0, -130, spawnMarker, true)
					; CreateDecoration(myCenterMarker, pTweakFountainID, Vault_WaterFountain01, 522.2, -18, 100, 0, spawnMarker, true)					
					
				endIf
				
			endif
			
			; A little confusing : We store the switch INSTANCE in myObjectCache[pTweakModule1SwitchID]
			; however the switch shares its state with module1Global. So we instead us the switch STATE for the
			; lights (since they can't be individually selected). We have light IDs for the object cache, but
			; we dont use their states...
			
			int module1LightGlobal = TweakCampModule1Light.GetValueInt()
			ObjectReference theLightA = myObjectCache[pTweakModule1LightAID]
			if (myObjectState[pTweakModule1SwitchID] != module1LightGlobal || !theLightA)
			
				int prevlightsettings = myObjectState[pTweakModule1SwitchID]
				if (module1LightGlobal != prevlightsettings)
					myObjectState[pTweakModule1SwitchID] = module1LightGlobal
				endIf
				
				form theColor = None 
				if (0 == module1LightGlobal) ; Off
					theColor = Game.GetForm(0x00024571); Nothing...
				elseif (1 == module1LightGlobal) ; White...
					theColor = Game.GetForm(0x0005C416); White
				elseif (2 == module1LightGlobal)
					theColor = None ; Multi
				elseif (3 == module1LightGlobal)
					theColor = Game.GetForm(0x00001003); Blue
				elseif (4 == module1LightGlobal)
					theColor = Game.GetForm(0x0020A253); Green
				elseif (5 == module1LightGlobal)
					theColor = Game.GetForm(0x001179A6); Red
				elseif (6 == module1LightGlobal)
					theColor = Game.GetForm(0x00023476); Yellow
				elseif (7 == module1LightGlobal)
					theColor = Game.GetForm(0x000039B0); Orange
				elseif (8 == module1LightGlobal)
					theColor = Game.GetForm(0x00035BAB); Aqua
				elseif (9 == module1LightGlobal)
					theColor = Game.GetForm(0x00023473); Purple
				endif
				if theColor
					Trace("Creating lights (one color : [" + module1LightGlobal + "])")
					CreateDecoration(myCenterMarker, pTweakModule1LightAID, theColor, 404.8,  18.43, 150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule1LightBID, theColor, 404.8, -18.43, 150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule1LightCID, theColor, 543.0, -45.0,  150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule1LightDID, theColor, 200.0, -45.0,  150, 0.0, spawnMarker)
				else
					Trace("Creating lights (using RGBY)")
					CreateDecoration(myCenterMarker, pTweakModule1LightAID, Game.GetForm(0x0020A253), 404.8,  18.43, 150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule1LightBID, Game.GetForm(0x000039B0), 404.8, -18.43, 150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule1LightCID, Game.GetForm(0x00001003), 543.0, -45.0,  150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule1LightDID, Game.GetForm(0x00023476), 200.0, -45.0,  150, 0.0, spawnMarker)
				endif
			endif
			
			; Doors locked is a global. If a module was not constructed when the global was set, 
			; the individual doors state may not match. So we need checks. 
			ObjectReference odoor1 = myObjectCache[pTweakModule1DoorID]
			if odoor1 && odoor1.Is3DLoaded()
				if 1 == doorsLockedGlobal && odoor1.GetLockLevel() != 253
					LockDoor(odoor1)	
				elseif 0 == doorsLockedGlobal && odoor1.GetLockLevel() != 0
					UnlockDoor(odoor1)
				endif
			endif
			
		endIf
	endif
		 
    ; -------------------------------------
    ; Module 2
    ; -------------------------------------

    int module2Global = TweakCampModule2Enabled.GetValueInt()
	if (0 != module2Global)
		ObjectReference theModule = myObjectCache[pTweakModule2ID]
		if (1 == module2Global)
			if (myObjectState[pTweakModule2ID] > 1)
				myObjectState[pTweakModule2ID] = 1
				if (theModule)
					DeleteDecorationRange(pTweakModule2ID,pTweakModule2LightCID)
				endIf
			endIf
		else

			if (myObjectState[pTweakModule2ID] != module2Global || !theModule)
		
				; int previousState = myObjectState[pTweakModule2ID]
				myObjectState[pTweakModule2ID] = module2Global	
			
				; No Need, CreateDecoration performs Delete automatically....
				; if (theModule)
				;	Trace("Deleting Stale Object (State changed)")
				;	DeleteDecorationRange(pTweakModule2ID,pTweakModule2LightCID)
				; endIf

				if (2 == module2Global)
					Trace("Creating Module2 [" + module2Global + "]")
					Static CapsuleMainSunRoof02a     = Game.GetForm(0x0010796D) as Static	; Length [512.000000] Width [256.000000] height [301.000000]	
					Static CapsuleExtWallEndFan01    = Game.GetForm(0x000203D3) as Static 
					Static CapsuleMain4Way01         = Game.GetForm(0x000203E3) as Static ; [256.000000] Width [256.000000] height [283.000000]
					Static CapsuleExtWallExSmL01a    = Game.GetForm(0x0010796A) as Static 
					Door   CapsuleExtWallExSmLDoor01 = Game.GetForm(0x0001346C) as Door 

					; |---|---|-D-|---|
					; |   |#######|###|
					; |---|---|---|---|  * = pShelterCenter/myCenterMarker
					; D   |   |   |   |  P = Player (256 South of center)
					; |---|---*---|---|  T = Terminal
					; |   |   ^   |   D  D = Door
					; |---|---P---|---|
					; |   |T  |   |   |
					; |---|-D-|---|---|   
			
					ObjectReference Module2 = CreateDecoration(myCenterMarker, pTweakModule2ID,      CapsuleMainSunRoof02a, 384, -180, -60, -90, spawnMarker, true)
					CreateDecoration(Module2, pTweakModule2WindowID, CapsuleExtWallExSmL01a,    0, 0, 0, 0, spawnMarker, true)
					CreateDecoration(Module2, pTweakModule2DoorID,   CapsuleExtWallExSmLDoor01, 0, 0, 0, 0, spawnMarker, true)			
					ObjectReference Module2Child = CreateDecoration(Module2, pTweakModule2ChildID, CapsuleMain4Way01, 384, 0, 0, -90, spawnMarker, true)
					CreateDecoration(Module2, pTweakModule2ChildEnd1ID, CapsuleExtWallEndFan01, 256, 0, 0, 0, spawnMarker, true)
					CreateDecoration(Module2Child, pTweakModule2ChildEnd2ID, CapsuleExtWallEndFan01, 128, -180, 0, 0, spawnMarker, true)
					ObjectReference theSwitch = CreateDecoration(myCenterMarker, pTweakModule2SwitchID, TweakLightSwitchB, 522.2, 162, 100, 180, spawnMarker, true)
				endIf
			endIf
		
			; A little confusing : We store the switch INSTANCE in myObjectCache[pTweakModule2SwitchID]
			; however the switch shares its state with module1Global. So we instead us the switch STATE for the
			; lights (since they can't be individually selected). We have light IDs for the object cache, but
			; we dont use their states...
			
			int module2LightGlobal = TweakCampModule2Light.GetValueInt()
			ObjectReference theLightB = myObjectCache[pTweakModule2LightAID]
			if (myObjectState[pTweakModule2SwitchID] != module2LightGlobal || !theLightB)
			
				int prevlightsettings = myObjectState[pTweakModule2SwitchID]
				if (module2LightGlobal != prevlightsettings)
					myObjectState[pTweakModule2SwitchID] = module2LightGlobal
				endIf
				
				form theColor = None 
				if (0 == module2LightGlobal) ; Off
					theColor = Game.GetForm(0x00024571); Nothing...
				elseif (1 == module2LightGlobal) ; White...
					theColor = Game.GetForm(0x0005C416); White
				elseif (2 == module2LightGlobal)				
					theColor = None; Multi
				elseif (3 == module2LightGlobal)
					theColor = Game.GetForm(0x00001003); Blue
				elseif (4 == module2LightGlobal)
					theColor = Game.GetForm(0x0020A253); Green
				elseif (5 == module2LightGlobal)
					theColor = Game.GetForm(0x001179A6); Red
				elseif (6 == module2LightGlobal)
					theColor = Game.GetForm(0x00023476); Yellow
				elseif (7 == module2LightGlobal)
					theColor = Game.GetForm(0x000039B0); Orange
				elseif (8 == module2LightGlobal)
					theColor = Game.GetForm(0x00035BAB); Aqua
				elseif (9 == module2LightGlobal)
					theColor = Game.GetForm(0x00023473); Purple
				endif
				if theColor
					Trace("Creating lights (one color : [" + module2LightGlobal + "])")
					CreateDecoration(myCenterMarker, pTweakModule2LightAID, theColor, 404.8, -162.43, 150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule2LightBID, theColor, 404.8,  162.43, 150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule2LightCID, theColor, 543.0,  135.0,  150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule2LightDID, theColor, 200.0,  135.0,  150, 0.0, spawnMarker)
				else
					Trace("Creating lights (using RGBY)")				
					CreateDecoration(myCenterMarker, pTweakModule2LightAID, Game.GetForm(0x0020A253), 404.8, -162.43, 150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule2LightBID, Game.GetForm(0x000039B0), 404.8,  162.43, 150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule2LightCID, Game.GetForm(0x00001003), 543.0,  135.0,  150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule2LightDID, Game.GetForm(0x00023476), 200.0,  135.0,  150, 0.0, spawnMarker)
				endif
			endif

			; Doors locked is a global. If a module was not constructed when the global was set, 
			; the individual doors state may not match. So we need checks. 
			ObjectReference odoor2 = myObjectCache[pTweakModule2DoorID]
			if odoor2 && odoor2.Is3DLoaded()
				if 1 == doorsLockedGlobal && odoor2.GetLockLevel() != 253
					LockDoor(odoor2)	
				elseif 0 == doorsLockedGlobal && odoor2.GetLockLevel() != 0
					UnlockDoor(odoor2)
				endif
			endif

			
		endIf 
	endif
	
    ; -------------------------------------
    ; Module 3
    ; -------------------------------------

    int module3Global = TweakCampModule3Enabled.GetValueInt()
	if (0 != module3Global)
		ObjectReference theModule = myObjectCache[pTweakModule3ID]
		if (1 == module3Global)
			if (myObjectState[pTweakModule3ID] > 1)
				myObjectState[pTweakModule3ID] = 1
				if (theModule)
					DeleteDecorationRange(pTweakModule3ID,pTweakModule3LightCID)
				endIf
			endIf
		else
		
			if (myObjectState[pTweakModule3ID] != module3Global || !theModule)
				
				; int previousState = myObjectState[pTweakModule3ID]
				myObjectState[pTweakModule3ID] = module3Global	
			
				; No Need, CreateDecoration performs Delete automatically....
				; if (theModule)
				;	Trace("Deleting Stale Object (State changed)")
				;	DeleteDecorationRange(pTweakModule3ID,pTweakModule3LightCID)
				; endIf

				if (2 == module3Global)
					Trace("Creating Module3 [" + module3Global + "]")
					Static CapsuleMainSunRoof02a     = Game.GetForm(0x0010796D) as Static	; Length [512.000000] Width [256.000000] height [301.000000]	
					Static CapsuleExtWallEndFan01    = Game.GetForm(0x000203D3) as Static 
					Static CapsuleMain4Way01         = Game.GetForm(0x000203E3) as Static ; [256.000000] Width [256.000000] height [283.000000]
					Static CapsuleExtWallExSmL01a    = Game.GetForm(0x0010796A) as Static 
					Door   CapsuleExtWallExSmLDoor01 = Game.GetForm(0x0001346C) as Door 

					; |---|---|-D-|---|
					; |   |   |   |   |
					; |---|---|---|---|  * = pShelterCenter/myCenterMarker
					; D   |   |   |###|  P = Player (256 South of center)
					; |---|---*---|###|  T = Terminal
					; |   |   ^   |###D  D = Door
					; |---|---P---|---|
					; |   |T  |   |###|
					; |---|-D-|---|---|   
			
					ObjectReference Module3 = CreateDecoration(myCenterMarker, pTweakModule3ID,      CapsuleMainSunRoof02a, 384, 90, -60, 0, spawnMarker, true)
					CreateDecoration(Module3, pTweakModule3WindowID, CapsuleExtWallExSmL01a,    0, 0, 0, 0, spawnMarker, true)
					CreateDecoration(Module3, pTweakModule3DoorID,   CapsuleExtWallExSmLDoor01, 0, 0, 0, 0, spawnMarker, true)			
					ObjectReference Module3Child = CreateDecoration(Module3, pTweakModule3ChildID, CapsuleMain4Way01, 384, 0, 0, -90, spawnMarker, true)
					CreateDecoration(Module3, pTweakModule3ChildEnd1ID, CapsuleExtWallEndFan01, 256, 0, 0, 0, spawnMarker, true)
					CreateDecoration(Module3Child, pTweakModule3ChildEnd2ID, CapsuleExtWallEndFan01, 128, -180, 0, 0, spawnMarker, true)
					ObjectReference theSwitch = CreateDecoration(myCenterMarker, pTweakModule3SwitchID, TweakLightSwitchC, 522.2, 72, 100, -90, spawnMarker, true) ; 522.2
				endif
			endIf
			
			; A little confusing : We store the switch INSTANCE in myObjectCache[pTweakModule3SwitchID]
			; however the switch shares its state with module1Global. So we instead us the switch STATE for the
			; lights (since they can't be individually selected). We have light IDs for the object cache, but
			; we dont use their states...
			
			int module3LightGlobal = TweakCampModule3Light.GetValueInt()
			ObjectReference theLightC = myObjectCache[pTweakModule3LightAID]
			if (myObjectState[pTweakModule3SwitchID] != module3LightGlobal || !theLightC)
			
				int prevlightsettings = myObjectState[pTweakModule3SwitchID]
				if (module3LightGlobal != prevlightsettings)
					myObjectState[pTweakModule3SwitchID] = module3LightGlobal
				endIf
				
				form theColor = None 
				if (0 == module3LightGlobal) ; Off
					theColor = Game.GetForm(0x00024571); Nothing...
				elseif (1 == module3LightGlobal) ; White...
					theColor = Game.GetForm(0x0005C416); White
				elseif (2 == module3LightGlobal)				
					theColor = None; Multi
				elseif (3 == module3LightGlobal)
					theColor = Game.GetForm(0x00001003); Blue
				elseif (4 == module3LightGlobal)
					theColor = Game.GetForm(0x0020A253); Green
				elseif (5 == module3LightGlobal)
					theColor = Game.GetForm(0x001179A6); Red
				elseif (6 == module3LightGlobal)
					theColor = Game.GetForm(0x00023476); Yellow
				elseif (7 == module3LightGlobal)
					theColor = Game.GetForm(0x000039B0); Orange
				elseif (8 == module3LightGlobal)
					theColor = Game.GetForm(0x00035BAB); Aqua
				elseif (9 == module3LightGlobal)
					theColor = Game.GetForm(0x00023473); Purple
				endif
				if theColor
					Trace("Creating lights (one color : [" + module3LightGlobal + "])")
					CreateDecoration(myCenterMarker, pTweakModule3LightAID, theColor, 404.8,  108.43, 150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule3LightBID, theColor, 404.8,   72.43, 150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule3LightCID, theColor, 543.0,   45.0,  150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule3LightDID, theColor, 200.0,   45.0,  150, 0.0, spawnMarker)
				else
					Trace("Creating lights (using RGBY)")
					CreateDecoration(myCenterMarker, pTweakModule3LightAID, Game.GetForm(0x0020A253), 404.8,  108.43, 150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule3LightBID, Game.GetForm(0x000039B0), 404.8,   72.43, 150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule3LightCID, Game.GetForm(0x00001003), 543.0,   45.0,  150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule3LightDID, Game.GetForm(0x00023476), 200.0,   45.0,  150, 0.0, spawnMarker)
				endif
			endif
			
			; Doors locked is a global. If a module was not constructed when the global was set, 
			; the individual doors state may not match. So we need checks. 
			ObjectReference odoor3 = myObjectCache[pTweakModule3DoorID]
			if odoor3 && odoor3.Is3DLoaded()
				if 1 == doorsLockedGlobal && odoor3.GetLockLevel() != 253
					LockDoor(odoor3)	
				elseif 0 == doorsLockedGlobal && odoor3.GetLockLevel() != 0
					UnlockDoor(odoor3)
				endif
			endif
			
		endIf
	endIf
	
    ; -------------------------------------
    ; Module 4
    ; -------------------------------------
	
    int module4Global = TweakCampModule4Enabled.GetValueInt()
	if (0 != module4Global)
		ObjectReference theModule = myObjectCache[pTweakModule4ID]
		if (1 == module4Global)
			if (myObjectState[pTweakModule4ID] > 1)
				myObjectState[pTweakModule4ID] = 1
				if (theModule)
					DeleteDecorationRange(pTweakModule4ID,pTweakModule4LightCID)
				endIf
			endIf
		else
		
			if (myObjectState[pTweakModule4ID] != module4Global || !theModule)
					
				; int previousState = myObjectState[pTweakModule4ID]
				myObjectState[pTweakModule4ID] = module4Global	
			
				; No Need, CreateDecoration performs Delete automatically....
				; if (theModule)
				;	Trace("Deleting Stale Object (State changed)")
				;	DeleteDecorationRange(pTweakModule4ID,pTweakModule4LightCID)
				; endIf

				if (2 == module4Global)	
					Trace("Creating Module4 [" + module4Global + "]")
				
					Static CapsuleMainSunRoof02a     = Game.GetForm(0x0010796D) as Static	; Length [512.000000] Width [256.000000] height [301.000000]	
					Static CapsuleExtWallEndFan01    = Game.GetForm(0x000203D3) as Static 
					Static CapsuleMain4Way01         = Game.GetForm(0x000203E3) as Static ; [256.000000] Width [256.000000] height [283.000000]
					Static CapsuleExtWallExSmL01a    = Game.GetForm(0x0010796A) as Static 
					Door   CapsuleExtWallExSmLDoor01 = Game.GetForm(0x0001346C) as Door 

					; |---|---|-D-|---|
					; |###|   |   |   |
					; |---|---|---|---|  * = pShelterCenter/myCenterMarker
					; D###|   |   |   |  P = Player (256 South of center)
					; |###|---*---|---|  T = Terminal
					; |###|   ^   |   D  D = Door
					; |---|---P---|---|
					; |   |T  |   |   |
					; |---|-D-|---|---|   
			
					ObjectReference Module4 = CreateDecoration(myCenterMarker, pTweakModule4ID,      CapsuleMainSunRoof02a, 384, -90, -60, -180, spawnMarker, true)
					CreateDecoration(Module4, pTweakModule4WindowID, CapsuleExtWallExSmL01a,    0, 0, 0, 0, spawnMarker, true)
					CreateDecoration(Module4, pTweakModule4DoorID,   CapsuleExtWallExSmLDoor01, 0, 0, 0, 0, spawnMarker, true)			
					ObjectReference Module4Child = CreateDecoration(Module4, pTweakModule4ChildID, CapsuleMain4Way01, 384, 0, 0, -90, spawnMarker, true)
					CreateDecoration(Module4, pTweakModule4ChildEnd1ID, CapsuleExtWallEndFan01, 256, 0, 0, 0, spawnMarker, true)
					CreateDecoration(Module4Child, pTweakModule4ChildEnd2ID, CapsuleExtWallEndFan01, 128, -180, 0, 0, spawnMarker, true)
					ObjectReference theSwitch = CreateDecoration(myCenterMarker, pTweakModule4SwitchID, TweakLightSwitchD, 522.2, -108, 100, 90, spawnMarker, true) ; 522.2
				endif
			endIf
			
			; A little confusing : We store the switch INSTANCE in myObjectCache[pTweakModule4SwitchID]
			; however the switch shares its state with module1Global. So we instead us the switch STATE for the
			; lights (since they can't be individually selected). We have light IDs for the object cache, but
			; we dont use their states...
			
			int module4LightGlobal = TweakCampModule4Light.GetValueInt()
			ObjectReference theLightD = myObjectCache[pTweakModule4LightAID]
			if (myObjectState[pTweakModule4SwitchID] != module4LightGlobal || !theLightD)
			
				int prevlightsettings = myObjectState[pTweakModule4SwitchID]
				if (module4LightGlobal != prevlightsettings)
					myObjectState[pTweakModule4SwitchID] = module4LightGlobal
				endIf
				
				form theColor = None 
				if (0 == module4LightGlobal) ; Off
					theColor = Game.GetForm(0x00024571); Nothing...
				elseif (1 == module4LightGlobal) ; White...
					theColor = Game.GetForm(0x0005C416); White
				elseif (2 == module4LightGlobal)				
					theColor = None; Multi
				elseif (3 == module4LightGlobal)
					theColor = Game.GetForm(0x00001003); Blue
				elseif (4 == module4LightGlobal)
					theColor = Game.GetForm(0x0020A253); Green
				elseif (5 == module4LightGlobal)
					theColor = Game.GetForm(0x001179A6); Red
				elseif (6 == module4LightGlobal)
					theColor = Game.GetForm(0x00023476); Yellow
				elseif (7 == module4LightGlobal)
					theColor = Game.GetForm(0x000039B0); Orange
				elseif (8 == module4LightGlobal)
					theColor = Game.GetForm(0x00035BAB); Aqua
				elseif (9 == module4LightGlobal)
					theColor = Game.GetForm(0x00023473); Purple
				endif
				if theColor
					Trace("Creating lights (one color : [" + module4LightGlobal + "])")
					CreateDecoration(myCenterMarker, pTweakModule4LightAID, theColor, 404.8,  -72.43, 150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule4LightBID, theColor, 404.8, -108.43, 150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule4LightCID, theColor, 543.0, -135.0,  150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule4LightDID, theColor, 200.0, -135.0,  150, 0.0, spawnMarker)
				else
					Trace("Creating lights (using RGBY)")					
					CreateDecoration(myCenterMarker, pTweakModule4LightAID, Game.GetForm(0x0020A253), 404.8,  -72.43, 150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule4LightBID, Game.GetForm(0x000039B0), 404.8, -108.43, 150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule4LightCID, Game.GetForm(0x00001003), 543.0, -135.0,  150, 0.0, spawnMarker)
					CreateDecoration(myCenterMarker, pTweakModule4LightDID, Game.GetForm(0x00023476), 200.0, -135.0,  150, 0.0, spawnMarker)
				endif
			endif

			; Doors locked is a global. If a module was not constructed when the global was set, 
			; the individual doors state may not match. So we need checks. 
			ObjectReference odoor4 = myObjectCache[pTweakModule4DoorID]
			if odoor4 && odoor4.Is3DLoaded()
				if 1 == doorsLockedGlobal && odoor4.GetLockLevel() != 253
					LockDoor(odoor4)	
				elseif 0 == doorsLockedGlobal && odoor4.GetLockLevel() != 0
					UnlockDoor(odoor4)
				endif
			endif
			
		endif
	endIf 
	
	; -------------------------------------
    ; Chemical Bench
    ; -------------------------------------
	; DogmeatSniff = 0016567B
	
	; |---|---|-D-|---|
	; |###|   |   |   |
	; |---|---|---|---|  * = pShelterCenter/myCenterMarker
	; D   |   |   |   |  P = Player (256 South of center)
	; |---|---*---|---|  T = Terminal
	; |   |   ^   |   D  D = Door
	; |---|---P---|---|
	; |   |T  |   |   |
	; |---|-D-|---|---|   
	
    int chemChoice = pTweakCampChemEnabled.GetValueInt()
    if (0 != chemChoice)
		ObjectReference theChemBench = pShelterChemBench.GetReference()
		if (1 == chemChoice && theChemBench && theChemBench.IsEnabled())
			EnsureChemBenchDisabled()
		elseif (2 == chemChoice)
			Trace("Ensuring Chemical Bench [" + chemChoice + "]")
			Furniture WorkbenchChemistryB = Game.GetForm(0x001487C1) as Furniture
			CreateBench(myCenterMarker, pShelterChemBench, WorkbenchChemistryB, 542, -130, 0, 90, spawnMarker, true)
		endIf
	endIf
	
	; -------------------------------------
    ; Weapon Bench
    ; -------------------------------------

	; |---|---|-D-|---|
	; |   |   |   |   |
	; |---|---|---|--#|  * = pShelterCenter/myCenterMarker
	; D   |   |   |  #|  P = Player (256 South of center)
	; |---|---*---|---|  T = Terminal
	; |   |   ^   |   D  D = Door
	; |---|---P---|---|
	; |   |T  |   |   |
	; |---|-D-|---|---|   
	
    int weapChoice = pTweakCampWeapEnabled.GetValueInt()
    if (0 != weapChoice)
		ObjectReference theWeapBench = pShelterWeapBench.GetReference()
		if (1 == weapChoice && theWeapBench && theWeapBench.IsEnabled())
			EnsureWeapBenchDisabled()
		elseif (2 == weapChoice)
			Trace("Ensuring Weapon Bench [" + weapChoice + "]")
			Furniture workbenchWeaponsB = Game.GetForm(0x0017E787) as Furniture
			CreateBench(myCenterMarker, pShelterWeapBench, workbenchWeaponsB, 405, 103, 0, -90, spawnMarker, true)			
		endIf
	endIf

	; -------------------------------------
    ; Armor Bench
    ; -------------------------------------

	; |---|---|-D-|---|
	; |   |   |   |   |
	; |---|---|---|---|  * = pShelterCenter/myCenterMarker
	; D   |   |   |   |  P = Player (256 South of center)
	; |---|---*---|---|  T = Terminal
	; |   |   ^   |   D  D = Door
	; |---|---P---|---|
	; |   |T  |###|   |
	; |---|-D-|---|---|   
	
    int armorChoice = pTweakCampArmorEnabled.GetValueInt()
    if (0 != armorChoice)
		ObjectReference theArmorBench = pShelterArmorBench.GetReference()
		if (1 == armorChoice && theArmorBench && theArmorBench.IsEnabled())
			EnsureArmorBenchDisabled()
		elseif (2 == armorChoice)
			Trace("Ensuring Armor Bench [" + armorChoice + "]")
			Furniture WorkbenchArmorA = Game.GetForm(0x0012EA9B) as Furniture
			CreateBench(myCenterMarker, pShelterArmorBench, WorkbenchArmorA, 440, 13, 0, 0, spawnMarker, true)

		endIf
	endIf
	
	;======================================
	; Power Armor
	;======================================	
	; NPCStandWrenchVertical = 000D96CD (Probably not since it may not be there...)
	; |---|---|-D-|---|
	; |   |   |   |   |
	; |---|---|---|---|  * = pShelterCenter/myCenterMarker
	; D   |   |   |   |  P = Player (256 South of center)
	; |-#-|---*---|---|  T = Terminal
	; | # |   ^   |   D  D = Door
	; |---|---P---|---|
	; |   |T  |   |   |
	; |---|-D-|---|---|   
	
	
    int paChoice = pTweakCampPAStationEnabled.GetValueInt()
    if (0 != paChoice)
		ObjectReference thePowerBench = pShelterPowerBench.GetReference()
		if (1 == paChoice && thePowerBench && thePowerBench.IsEnabled())
			EnsurePowerBenchDisabled()			
		elseif (2 == paChoice)
			Trace("Ensuring Power Armor Bench [" + paChoice + "]")
			Furniture WorkbenchPowerArmorSmall = Game.GetForm(0x0013BD08) as Furniture
			CreateBench(myCenterMarker, pShelterPowerBench, WorkbenchPowerArmorSmall, 384, -82, 0, -90, spawnMarker, true)			
		endIf
	endIf
	
	; -------------------------------------
    ; Bed 1
    ; -------------------------------------
	; |---|---|-D-|---|
	; |   |   |   |   |
	; |---|---|---|---|  * = pShelterCenter/myCenterMarker
	; D   |   |   |   |  P = Player (256 South of center)
	; |---|---*---|---|  T = Terminal
	; |   |   ^   |   D  D = Door
	; |---|---P---|---|
	; |###|T  |   |   |
	; |---|-D-|---|---|   

	
    int bed1Global = pTweakCampBed1Enabled.GetValueInt()
	if (0 != bed1Global)
		ObjectReference theBed = myObjectCache[pTweakBed1ID]
		if (1 == bed1Global)
		
			if (myObjectState[pTweakBed1ID] > 1)
				myObjectState[pTweakBed1ID] = 1
				if (theBed)
					DeleteDecoration(pTweakBed1ID)
				endIf
			endIf
			
		elseif (myObjectState[pTweakBed1ID] != bed1Global || !theBed)
		
			; int previousState = myObjectState[pTweakBed1ID]
			myObjectState[pTweakBed1ID] = bed1Global	
			
			; No Need, CreateDecoration performs Delete automatically....
			; if (theBed)
			;	Trace("Deleting Stale Object (State changed)")
			;	DeleteDecoration(pTweakBed1ID)
			; endIf
			
			if (2 == bed1Global) ; Floor Mattress
				Trace("Creating bed1 [" + bed1Global + "]")
				Form NpcBedGroundSleep01 = Game.GetForm(0x0002FBF9)
				if (!hasFoundation)
					CreateDecoration(myCenterMarker, pTweakBed1ID, NpcBedGroundSleep01, 100, -60, 0.0, 135.0, spawnMarker, true, true )
				else
					CreateDecoration(myCenterMarker, pTweakBed1ID, NpcBedGroundSleep01, 553.77, -43.9, 0.0, 0, spawnMarker, true)
				endif
			elseif (3 == bed1Global) ; Bunk
				Trace("Creating bed1 [" + bed1Global + "]")
				Form NpcBedVaultBunkLay01 = Game.GetForm(0x000AB568)
				CreateDecoration(myCenterMarker, pTweakBed1ID, NpcBedVaultBunkLay01, 578, -48, 0.0, 0, spawnMarker, true)
			elseif (4 == bed1Global) ; Single
				Trace("Creating bed1 [" + bed1Global + "]")
				Form NpcBedVaultLay02 = Game.GetForm(0x0004329F)
				CreateDecoration(myCenterMarker, pTweakBed1ID, NpcBedVaultLay02, 578, -48, 0.0, 0, spawnMarker, true)
			elseif (5 == bed1Global) ; Dbl: Hi-tech
				Trace("Creating bed1 [" + bed1Global + "]")
				; Form NPCBedInstituteMedBaySleep01 = Game.GetForm(0x000B0A71)
				; CreateDecoration(myCenterMarker, pTweakBed1ID, NPCBedInstituteMedBaySleep01, 578, -48, 0.0, -180, spawnMarker, true)
				Form NPCBedInstituteMountedSleepDbl01 = Game.GetForm(0x000550D3)
				CreateDecoration(myCenterMarker, pTweakBed1ID, NPCBedInstituteMountedSleepDbl01, 560, -46, 0.0, -180, spawnMarker, true)
			elseif (6 == bed1Global) ; Dbl: Pre-war
				Trace("Creating bed1 [" + bed1Global + "]")
				Form NpcBedPlayerHouseLay01 = Game.GetForm(0x00054835)
				CreateDecoration(myCenterMarker, pTweakBed1ID, NpcBedPlayerHouseLay01, 550, -44.26, 0.0, 0, spawnMarker, true)
			endif
		endif
	endif

	; -------------------------------------
    ; Bed 2
    ; -------------------------------------
	; |---|---|-D-|---|
	; |   |   |   |###|
	; |---|---|---|---|  * = pShelterCenter/myCenterMarker
	; D   |   |   |   |  P = Player (256 South of center)
	; |---|---*---|---|  T = Terminal
	; |   |   ^   |   D  D = Door
	; |---|---P---|---|
	; |   |T  |   |   |
	; |---|-D-|---|---|   

	; DogmeatLay01 = 0005E9C6
	; FEVHoundLayingMarker = 00127594
	; FEVHoundSleepingMarker
	
    int bed2Global = pTweakCampBed2Enabled.GetValueInt()
	if (0 != bed2Global)
		ObjectReference theBed = myObjectCache[pTweakBed2ID]
		if (1 == bed2Global)
		
			if (myObjectState[pTweakBed2ID] > 1)
				myObjectState[pTweakBed2ID] = 1
				if (theBed)
					DeleteDecoration(pTweakBed2ID)
				endIf
			endIf
			
		elseif (myObjectState[pTweakBed2ID] != bed2Global || !theBed)
		
			; int previousState = myObjectState[pTweakBed2ID]
			myObjectState[pTweakBed2ID] = bed2Global	
			
			; CreateDecoration performs Delete automatically....
			if (2 == bed2Global) ; Floor Mattress
				Trace("Creating bed2 [" + bed2Global + "]")
				Form NpcBedGroundSleep01 = Game.GetForm(0x0002FBF9)
				CreateDecoration(myCenterMarker, pTweakBed2ID, NpcBedGroundSleep01, 553.77, 133.9, 0.0, -90, spawnMarker, true)
			elseif (3 == bed2Global) ; Bunk
				Trace("Creating bed2 [" + bed2Global + "]")
				Form NpcBedVaultBunkLay01 = Game.GetForm(0x000AB568)
				CreateDecoration(myCenterMarker, pTweakBed2ID, NpcBedVaultBunkLay01, 578, 138, 0.0, -90, spawnMarker, true)
			elseif (4 == bed2Global) ; Single
				Trace("Creating bed2 [" + bed2Global + "]")
				Form NpcBedVaultLay02 = Game.GetForm(0x0004329F)
				CreateDecoration(myCenterMarker, pTweakBed2ID, NpcBedVaultLay02, 578, 138, 0.0, -90, spawnMarker, true)
			elseif (5 == bed2Global) ; Med Bay
				Trace("Creating bed2 [" + bed2Global + "]")
				; Form NPCBedInstituteMountedSleepDbl01 = Game.GetForm(0x000550D3)
				Form NPCBedInstituteMedBaySleep01 = Game.GetForm(0x000B0A71)
				CreateDecoration(myCenterMarker, pTweakBed2ID, NPCBedInstituteMedBaySleep01, 578, 138, 0.0, 90, spawnMarker, true)
			elseif (6 == bed2Global) ; Dbl: Pre-war
				Trace("Creating bed2 [" + bed2Global + "]")
				Form NpcBedPlayerHouseLay01 = Game.GetForm(0x00054835)
				CreateDecoration(myCenterMarker, pTweakBed2ID, NpcBedPlayerHouseLay01, 550, 134.26, 0.0, -90, spawnMarker, true)
			endif
		endif
	endif	

	; -------------------------------------
    ; Seat 1
    ; -------------------------------------
	; |---|---|-D-|---|
	; |   |   |   |   |
	; |---|---|---|---|  * = pShelterCenter/myCenterMarker
	; D   |   |  #|   |  P = Player (256 South of center)
	; |---|---*--#|---|  T = Terminal
	; |   |   ^  #|   D  D = Door
	; |---|---P---|---|
	; |   |T  |   |   |
	; |---|-D-|---|---|   

    int seat1Global = pTweakCampSeatsEnabled.GetValueInt()
	if (0 != seat1Global)
		ObjectReference theSeat = myObjectCache[pTweakSeat1ID]
		Trace("Seat 1 [" + seat1Global + "] [" + theSeat + "]")
		if (1 == seat1Global)
		
			if (myObjectState[pTweakSeat1ID] > 1)
				myObjectState[pTweakSeat1ID] = 1
				if (theSeat)
					DeleteDecoration(pTweakSeat1ID)
				endIf
			endIf
			
		elseif (myObjectState[pTweakSeat1ID] != seat1Global || !theSeat)
		
			; int previousState = myObjectState[pTweakSeat1ID]
			myObjectState[pTweakSeat1ID] = seat1Global	
			
			; CreateDecoration performs Delete automatically....
			if (2 == seat1Global) ; Wood Bench
				Trace("Creating seat 1 [" + seat1Global + "]")
				Form NpcBenchFederalistSit01 = Game.GetForm(0x0001F484)
				CreateDecoration(myCenterMarker, pTweakSeat1ID, NpcBenchFederalistSit01, 200, 90, 0.0, 90, spawnMarker, true)
			elseif (3 == seat1Global) ; Basic
				Trace("Creating seat 1 [" + seat1Global + "]")
				Form NpcCouchModernDomesticCleanSit01 = Game.GetForm(0x000FDC8B)
				CreateDecoration(myCenterMarker, pTweakSeat1ID, NpcCouchModernDomesticCleanSit01, 200, 90, 0.0, 90, spawnMarker, true)
			elseif (4 == seat1Global) ; Vault 111
				Trace("Creating seat 1 [" + seat1Global + "]")
				Form NpcBenchVaultSit01 = Game.GetForm(0x000B30BC)
				CreateDecoration(myCenterMarker, pTweakSeat1ID, NpcBenchVaultSit01, 200, 90, 0.0, 90, spawnMarker, true)
			elseif (5 == seat1Global) ; Hi-tech
				Trace("Creating seat 1 [" + seat1Global + "]")
				Form NpcCouchInstituteSit02 = Game.GetForm(0x00120451)
				CreateDecoration(myCenterMarker, pTweakSeat1ID, NpcCouchInstituteSit02, 200, 90, 0.0, 90, spawnMarker, true)
			elseif (6 == seat1Global) ; Pre-war
				Trace("Creating seat 1 [" + seat1Global + "]")
				Form NpcCouchPlayerHouseSit01 = Game.GetForm(0x0004D1D8)
				CreateDecoration(myCenterMarker, pTweakSeat1ID, NpcCouchPlayerHouseSit01, 200, 90, 0.0, 90, spawnMarker, true)
			elseif (7 == seat1Global) ; Luxury
				Trace("Creating seat 1 [" + seat1Global + "]")
				Form MQ202IrmaSit01 = Game.GetForm(0x00108F58)
				CreateDecoration(myCenterMarker, pTweakSeat1ID, MQ202IrmaSit01, 200, 90, 0.0, 90, spawnMarker, true)
			endif
		endif
	endif
	
	; -------------------------------------
    ; Seat 2
    ; -------------------------------------
	; |---|---|-D-|---|
	; |   |   |   |   |
	; |---|---|---|---|  * = pShelterCenter/myCenterMarker
	; D   |#  |   |   |  P = Player (256 South of center)
	; |---|#--*---|---|  T = Terminal
	; |   |#  ^   |   D  D = Door
	; |---|---P---|---|
	; |   |T  |   |   |
	; |---|-D-|---|---|   

    int seat2Global = pTweakCampSeats2Enabled.GetValueInt()
	if (0 != seat2Global)
		ObjectReference theSeat = myObjectCache[pTweakSeat2ID]
		Trace("Seat 1 [" + seat2Global + "] [" + theSeat + "]")
		if (1 == seat2Global)
		
			if (myObjectState[pTweakSeat2ID] > 1)
				myObjectState[pTweakSeat2ID] = 1
				if (theSeat)
					DeleteDecoration(pTweakSeat2ID)
				endIf
			endIf
			
		elseif (myObjectState[pTweakSeat2ID] != seat2Global || !theSeat)
		
			; int previousState = myObjectState[pTweakSeat2ID]
			myObjectState[pTweakSeat2ID] = seat2Global	
			
			; CreateDecoration performs Delete automatically....
			if (2 == seat2Global) ; Wood Bench
				Trace("Creating seat 2 [" + seat2Global + "]")
				Form NpcBenchFederalistSit01 = Game.GetForm(0x0001F484)
				CreateDecoration(myCenterMarker, pTweakSeat2ID, NpcBenchFederalistSit01, 180, -90, 0.0, -90, spawnMarker, true)
			elseif (3 == seat2Global) ; Basic
				Trace("Creating seat 2 [" + seat2Global + "]")
				Form NpcCouchModernDomesticCleanSit01 = Game.GetForm(0x000FDC8B)
				CreateDecoration(myCenterMarker, pTweakSeat2ID, NpcCouchModernDomesticCleanSit01, 180, -90, 0.0, -90, spawnMarker, true)
			elseif (4 == seat2Global) ; Vault 111
				Trace("Creating seat 2 [" + seat2Global + "]")
				Form NpcBenchVaultSit01 = Game.GetForm(0x000B30BC)
				CreateDecoration(myCenterMarker, pTweakSeat2ID, NpcBenchVaultSit01, 180, -90, 0.0, -90, spawnMarker, true)
			elseif (5 == seat2Global) ; Hi-tech
				Trace("Creating seat 2 [" + seat2Global + "]")
				Form NpcCouchInstituteSit02 = Game.GetForm(0x00120451)
				CreateDecoration(myCenterMarker, pTweakSeat2ID, NpcCouchInstituteSit02, 180, -90, 0.0, -90, spawnMarker, true)
			elseif (6 == seat2Global) ; Pre-war
				Trace("Creating seat 2 [" + seat2Global + "]")
				Form NpcCouchPlayerHouseSit01 = Game.GetForm(0x0004D1D8)
				CreateDecoration(myCenterMarker, pTweakSeat2ID, NpcCouchPlayerHouseSit01, 180, -90, 0.0, -90, spawnMarker, true)
			elseif (7 == seat2Global) ; Luxury
				Trace("Creating seat 2 [" + seat2Global + "]")
				Form MQ202IrmaSit01 = Game.GetForm(0x00108F58)
				CreateDecoration(myCenterMarker, pTweakSeat2ID, MQ202IrmaSit01, 180, -90, 0.0, -90, spawnMarker, true)
			endif
		endif
	endif

	; -------------------------------------
    ; Misc 1
    ; -------------------------------------
	; |---|---|-D-|---|
	; |   | ###   |   |
	; |---|---|---|---|  * = pShelterCenter/myCenterMarker
	; D   |   |   |   |  P = Player (256 South of center)
	; |---|---*---|---|  T = Terminal
	; |   |   ^   |   D  D = Door
	; |---|---P---|---|
	; |   |T  |   |   |
	; |---|-D-|---|---|   

    int misc1Global = pTweakCampDogHouseEnabled.GetValueInt()
	if (0 != misc1Global)
		ObjectReference theMisc = myObjectCache[pTweakMisc1ID]
		ObjectReference thePod  = pShelterFridge.GetReference()

		int previousState = myObjectState[pTweakMisc1ID]
		Trace("theMisc 1 [" + misc1Global + "] [" + theMisc + "]")
		if (1 == misc1Global)
		
			if (myObjectState[pTweakMisc1ID] > 1)
				myObjectState[pTweakMisc1ID] = 1
				
				if (thePod && thePod.IsEnabled())
					thePod.Disable()
					UnregisterForRemoteEvent(myObjectCache[pTweakMisc1ID],"OnActivate")
				endif
				
				if (theMisc)
					ObjectReference theChild1 = theMisc.GetLinkedRef(LinkCustom08)
					if (theChild1)
						theMisc.SetLinkedRef(None,LinkCustom08)
						theChild1.Disable()
						theChild1.Delete()
						theChild1 = None
					endif
					ObjectReference theChild2 = theMisc.GetLinkedRef(LinkCustom09)
					if (theChild2)
						theMisc.SetLinkedRef(None,LinkCustom09)
						theChild2.Disable()
						theChild2.Delete()
						theChild2 = None
					endif
					DeleteDecoration(pTweakMisc1ID)
				endIf
			endIf
			
			
		elseif (myObjectState[pTweakMisc1ID] != misc1Global || !theMisc)
		
			if (theMisc)
				ObjectReference theChild1 = theMisc.GetLinkedRef(LinkCustom08)
				if (theChild1)
					theMisc.SetLinkedRef(None,LinkCustom08)
					theChild1.Disable()
					theChild1.Delete()
					theChild1 = None
				endif
				ObjectReference theChild2 = theMisc.GetLinkedRef(LinkCustom09)
				if (theChild2)
					theMisc.SetLinkedRef(None,LinkCustom09)
					theChild2.Disable()
					theChild2.Delete()
					theChild2 = None
				endif
			endif

			if (3 == previousState)
				UnregisterForRemoteEvent(myObjectCache[pTweakMisc1ID],"OnActivate")
				if (thePod && thePod.IsEnabled())
					thePod.Disable()
				endif
			endif

			myObjectState[pTweakMisc1ID] = misc1Global	
						
			; CreateDecoration performs Delete automatically....
			if (2 == misc1Global) ; Dog House
				Trace("Creating misc 1 [" + misc1Global + "]")
				Form Dogmeat_Doghouse = Game.GetForm(0x001C244E)
				CreateDecoration(myCenterMarker, pTweakMisc1ID, Dogmeat_Doghouse, 410, -170, 0.0, -180, spawnMarker, true)				
			elseif (3 == misc1Global) ; CryoPod
				; Fridge is a special case and a bit of a pain since it needs to be persisted..
				Form TweakCryoFridge = Game.GetFormFromFile(0x0102DCA3,"AmazingFollowerTweaks.esp")
				thePod = CreateBench(myCenterMarker, pShelterFridge, TweakCryoFridge, 390, -170, 0, -180, spawnMarker, true, linkToStorage=false)
				thePod.SetScale(0.75)
				Form TweakCryoLever = Game.GetFormFromFile(0x0102DCA5,"AmazingFollowerTweaks.esp")
				ObjectReference thePodLever = CreateDecoration(myCenterMarker, pTweakMisc1ID, TweakCryoLever, 412, -167.43, -25, -180, spawnMarker, true)
				thePodLever.SetScale(0.75)
				RegisterForRemoteEvent(thePodLever,"OnActivate")				
			elseif (6 == misc1Global) ; Bar
				Trace("Creating misc 1 [" + misc1Global + "]")
				; TweakFurnBar spawns/manages 2 child Objects under the linkedref LinkCustom08 and LinkCustom09
				Form TweakFurnBar = Game.GetFormFromFile(0x0102CD6F,"AmazingFollowerTweaks.esp")				
				ObjectReference theBar = CreateDecoration(myCenterMarker, pTweakMisc1ID, TweakFurnBar, 360, -164.5, 0.0, -180, spawnMarker, true)
			; elseif (7 == misc1Global) ; NPCNukaMachine or Trophy stand...
				; Trace("Creating misc 1 [" + misc1Global + "]")
				; Form NPCNukaMachine = Game.GetForm(0x0018DFDC)
				; CreateDecoration(myCenterMarker, pTweakMisc1ID, NPCNukaMachine, 405, -167, 0.0, -180, spawnMarker, true)
			endif
			
			
		endif
	endif
	
	; -------------------------------------
    ; Misc 2
    ; -------------------------------------
	; |---|---|-D-|---|
	; |   |   |   |   |
	; |---|---|---|---|  * = pShelterCenter/myCenterMarker
	; D   |   |   |   |  P = Player (256 South of center)
	; |---|---*---|---|  T = Terminal
	; |   |   ^   |   D  D = Door
	; |---|---P---|---|
	; |   |T  |   |###|
	; |---|-D-|---|---|   

    int misc2Global = pTweakCampMisc2Enabled.GetValueInt()
	if (0 != misc2Global)
		ObjectReference theMisc = myObjectCache[pTweakMisc2ID]
		Trace("theMisc 2 [" + misc2Global + "] [" + theMisc + "]")
		int previousState = myObjectState[pTweakMisc2ID]		
		if (1 == misc2Global)
		
			if (4 == previousState)	; Memory Lounger
				UnregisterForRemoteEvent(myObjectCache[pTweakMisc2ID],"OnActivate")				
			endif
		
			if (myObjectState[pTweakMisc2ID] > 1)
				myObjectState[pTweakMisc2ID] = 1
				if (theMisc)
					ObjectReference theChild1 = theMisc.GetLinkedRef(LinkCustom08)
					if (theChild1)
						theMisc.SetLinkedRef(None,LinkCustom08)
						theChild1.Disable()
						theChild1.Delete()
						theChild1 = None
					endif
					ObjectReference theChild2 = theMisc.GetLinkedRef(LinkCustom09)
					if (theChild2)
						theMisc.SetLinkedRef(None,LinkCustom09)
						theChild2.Disable()
						theChild2.Delete()
						theChild2 = None
					endif									
					DeleteDecoration(pTweakMisc2ID)
				endIf
			endIf

			if (5 == previousState) ; Bathroom
				; Remove the Helper
				DeleteDecoration(pTweakMisc2HelperID)
			endif
			
		elseif (myObjectState[pTweakMisc2ID] != misc2Global || !theMisc)
		
			if (theMisc)
				ObjectReference theChild1 = theMisc.GetLinkedRef(LinkCustom08)
				if (theChild1)
					theMisc.SetLinkedRef(None,LinkCustom08)
					theChild1.Disable()
					theChild1.Delete()
					theChild1 = None
				endif
				ObjectReference theChild2 = theMisc.GetLinkedRef(LinkCustom09)
				if (theChild2)
					theMisc.SetLinkedRef(None,LinkCustom09)
					theChild2.Disable()
					theChild2.Delete()
					theChild2 = None
				endif
			endif
		
			myObjectState[pTweakMisc2ID] = misc2Global
			
			Trace("previousState = [" + previousState + "]")
			if (4 == previousState)	; Memory Lounger
				UnregisterForRemoteEvent(myObjectCache[pTweakMisc2ID],"OnActivate")				
			endif			
			if (5 == previousState)
				; Remove the Helper
				Trace("Removing Helper...")
				DeleteDecoration(pTweakMisc2HelperID)
			endif
			
			; CreateDecoration performs Delete automatically....
			if (2 == misc2Global) ; Dog House
				Trace("Creating misc 2 [" + misc2Global + "]")
				Form Dogmeat_Doghouse = Game.GetForm(0x001C244E)
				CreateDecoration(myCenterMarker, pTweakMisc2ID, Dogmeat_Doghouse, 552, 45, 0.0, -90, spawnMarker, true)
			elseif (4 == misc2Global) ; Memory Lounder
				Trace("Creating misc 2 [" + misc2Global + "]")
				Form NPCMemoryLounger01 = Game.GetForm(0x000CA06D)
				ObjectReference theMemoryLounger = CreateDecoration(myCenterMarker, pTweakMisc2ID, NPCMemoryLounger01, 503, 40, 0.0, 90, spawnMarker, true)
				RegisterForRemoteEvent(theMemoryLounger,"OnActivate")
			elseif (5 == misc2Global) ; Bathroom
				Trace("Creating misc 2 [" + misc2Global + "]")
				; TweakFurnShower spawns/manages 2 child Objects under the linkedref LinkCustom08 and LinkCustom09				
				Form TweakFurnShower = Game.GetFormFromFile(0x0102AF07,"AmazingFollowerTweaks.esp")
				CreateDecoration(myCenterMarker, pTweakMisc2ID, TweakFurnShower, 578, 50, 0.0, 90, spawnMarker, true)				
				Form TweakFurnToilet = Game.GetFormFromFile(0x0102C5D3,"AmazingFollowerTweaks.esp")
				CreateDecoration(myCenterMarker, pTweakMisc2HelperID, TweakFurnToilet, 575, 38, 0.0, 0, spawnMarker, true)
			; elseif (7 == misc2Global) ; NPCNukaMachine or Trophy stand...
				; Trace("Creating misc 2 [" + misc2Global + "]")
				; Form NPCNukaMachine = Game.GetForm(0x0018DFDC)
				; CreateDecoration(myCenterMarker, pTweakMisc2ID, NPCNukaMachine, 578, 48, 0.0, 90, spawnMarker, true)
			endif
		endif
	endif
	
	; -------------------------------------
    ; Turrets
    ; -------------------------------------
	
    int turretsGlobal =  pTweakCampTurretsEnabled.GetValueInt()
	if (0 != turretsGlobal)
		ObjectReference theNorthTurret1 = myObjectCache[pTweakSeat2ID]
		Trace("Seat 1 [" + turretsGlobal + "] [" + theNorthTurret1 + "]")
		if (1 == turretsGlobal)
		
			if (myObjectState[pTweakTurretNorth1ID] > 1)
				myObjectState[pTweakTurretNorth1ID] = 1
				DeleteDecorationRange(pTweakTurretNorth1ID,pTweakTurretWest2ID)
			endIf
			
		elseif (myObjectState[pTweakTurretNorth1ID] != turretsGlobal || !theNorthTurret1)
			
			; int previousState = myObjectState[pTweakSeat2ID]
			myObjectState[pTweakTurretNorth1ID] = turretsGlobal	
			
			form theTurret
			; CreateDecoration performs Delete automatically....
			if (2 == turretsGlobal) ; Mark I
				Trace("Using Mark I") ; < Level 7
				theTurret = Game.GetFormFromFile(0x01025B3A,"AmazingFollowerTweaks.esp")
				; theTurret = Game.GetForm(0x00111320)
			elseif (3 == turretsGlobal) ; Mark III
				Trace("Using Mark II") ; < Level 17
				theTurret = Game.GetFormFromFile(0x010337E2,"AmazingFollowerTweaks.esp")
			elseif (4 == turretsGlobal) ; Mark V 
				Trace("Using Mark III") ; < Level 29
				theTurret = Game.GetFormFromFile(0x010337E3,"AmazingFollowerTweaks.esp")
			elseif (5 == turretsGlobal) ; Mark VII
				Trace("Using Mark IV")  ; < Level 41
				theTurret = Game.GetFormFromFile(0x010337E4,"AmazingFollowerTweaks.esp")
			endif
			
			; -------------------------------------
			; |---T---|---T---|
			; |   |   |   |   |
			; T---|---|---|---T  * = pShelterCenter/myCenterMarker
			; |   |   |   |   |  P = Player (256 South of center)
			; |---|---v---|---|  T = Terminal
			; |   |   |   |   |  D = Door
			; T---|---|---|---T
			; |   |   |   |###|
			; |---T---|---T---|   
			
			CreateDecoration(myCenterMarker, pTweakTurretSouth1ID, theTurret, 551.07,  -27.68, 0.0, 0, spawnMarker, true)
			CreateDecoration(myCenterMarker, pTweakTurretSouth2ID, theTurret, 551.07,   27.68, 0.0, 0, spawnMarker, true)
			CreateDecoration(myCenterMarker, pTweakTurretNorth1ID, theTurret, 551.07, -152.32, 0.0, 180, spawnMarker, true)
			CreateDecoration(myCenterMarker, pTweakTurretNorth2ID, theTurret, 551.07,  152.32, 0.0, 180, spawnMarker, true)
			CreateDecoration(myCenterMarker, pTweakTurretEast1ID,  theTurret, 551.07,  117.68, 0.0, -90, spawnMarker, true)
			CreateDecoration(myCenterMarker, pTweakTurretEast2ID,  theTurret, 551.07,   62.32, 0.0, -90, spawnMarker, true)
			CreateDecoration(myCenterMarker, pTweakTurretWest1ID,  theTurret, 551.07, -117.68, 0.0, 90, spawnMarker, true)
			CreateDecoration(myCenterMarker, pTweakTurretWest2ID,  theTurret, 551.07,  -62.32, 0.0, 90, spawnMarker, true)
			
		endif
	endif	
	
	ShelterSetup=True
	
	pccopy.delete()
	spawnMarker.delete()
	pccopy = None
	spawnMarker = None

	if (theUFO && beamup)
		; pTweakCampUFOBeamUp.SetValue(1.0)
		BeamMeUp()
	endif
	
	Trace("MakeCamp Finished")
 
EndFunction

Event OnPlayerSleepStart(float afSleepStartTime, float afDesiredSleepEndTime, ObjectReference akBed)
	if ((pTweakBed2ID == 5) && (akBed == myObjectCache[pTweakBed2ID]))
		Debug.Notification("Med Bay : Heal All")
		HealAll(Game.GetPlayer())
	endif
EndEvent

; CryoFridge and Light Switch Support
Event ObjectReference.OnActivate(ObjectReference akSender, ObjectReference akActionRef)
	Actor player = Game.GetPlayer()
	if (akActionRef != player)
		return
	endif
	if (akSender == myObjectCache[pTweakModule1SwitchID])
		float currentValue = TweakCampModule1Light.GetValueInt()
		currentValue += 1.0
		if (currentValue > 9)
			currentValue = 0
		endif
		TweakCampModule1Light.SetValue(currentValue)
		MakeCamp(true)
		return
	endif
	if (akSender == myObjectCache[pTweakModule2SwitchID])
		float currentValue = TweakCampModule2Light.GetValueInt()
		currentValue += 1.0
		if (currentValue > 9)
			currentValue = 0
		endif
		TweakCampModule2Light.SetValue(currentValue)
		MakeCamp(true)
		return
	endif
	if (akSender == myObjectCache[pTweakModule3SwitchID])
		float currentValue = TweakCampModule3Light.GetValueInt()
		currentValue += 1.0
		if (currentValue > 9)
			currentValue = 0
		endif
		TweakCampModule3Light.SetValue(currentValue)
		MakeCamp(true)
		return
	endif
	if (akSender == myObjectCache[pTweakModule4SwitchID])
		float currentValue = TweakCampModule4Light.GetValueInt()
		currentValue += 1.0
		if (currentValue > 9)
			currentValue = 0
		endif
		TweakCampModule4Light.SetValue(currentValue)
		MakeCamp(true)
		return
	endif
	if (akSender == myObjectCache[pTweakMisc1ID])
		ObjectReference thePod = pShelterFridge.GetReference()
		if thePod
			
			Potion pNukaColaQuantum_cold = Game.GetForm(0x00178B25) as Potion
			Potion pNukaColaCherry_cold  = Game.GetForm(0x00178B24) as Potion
			Potion pNukaCola_cold        = Game.GetForm(0x00178B23) as Potion
			
			int ncq_count = thePod.GetItemCount(pNukaColaQuantum_cold)
			int ncc_count = thePod.GetItemCount(pNukaColaCherry_cold)
			int nc_count  = thePod.GetItemCount(pNukaCola_cold)
			Utility.wait(2.5)

			if ((ncq_count + ncc_count + nc_count) > 0)
				int total_cells = 0
				Sound DRSVault111CryopodClose = Game.GetForm(0x000264CC) as Sound
				DRSVault111CryopodClose.Play(thePod)
				if (ncq_count > 0)
					thePod.RemoveItem(pNukaColaQuantum_cold,ncq_count,true)
					total_cells += (ncq_count * 10)
				endif
				Utility.wait(2.0)
				if (ncc_count > 0)
					thePod.RemoveItem(pNukaColaCherry_cold,ncc_count,true)
					total_cells += (ncc_count * 7)
				endif
				Utility.wait(2.0)
				if (nc_count > 0)
					thePod.RemoveItem(pNukaCola_cold,nc_count,true)
					total_cells += (nc_count * 3)
				endif
				Utility.wait(2.0)				
				Ammo  AmmoCryoCell = Game.GetForm(0x0018ABE2) as Ammo
				thePod.AddItem(AmmoCryoCell,total_cells,true)				
			else
				pTweakCryoPodHint.Show()
			endif
		endif
		return
	endIf
	if (akSender == myObjectCache[pTweakMisc2ID])
		if (0 == pTweakUsingMemoryLounger.GetValue())
			ObjectReference theMemoryLounger = myObjectCache[pTweakMisc2ID]
			; This will probably come into play if they rescue the spouse (V1.2)
			pTweakUsingMemoryLounger.SetValue(1.0) 
			theMemoryLounger.BlockActivation(True, True)
			Game.SetInsideMemoryHUDMode(true)

			UnregisterForRemoteEvent(akSender, "OnActivate")
			UnregisterForDistanceEvents(player, myCenterMarker)
			RegisterForDistanceGreaterThanEvent(player, theMemoryLounger, 1000)	
			
			; if (!player.HasPerk(pImmuneToRadiation))
			; 	player.AddPerk(pImmuneToRadiation)
			; endif
			Utility.wait(5.0) ; Give Player time to sit...
			
			OldWeather = Weather.GetCurrentWeather()	
			Game.TurnPlayerRadioOn(false)

			Trace("Start Memory")
			TweakMemoryLounger.Start()			
		endif		
		return
	endif		
EndEvent

ObjectReference Function CreateFoundation(ObjectReference parentObj, form base, float dist, float angle, float AZOverride, float ZOverride, ObjectReference spawnMarker)
	Trace("CreateFoundation [" + parentObj + "][" + base + "][" + dist + "][" + angle + "][" + AZOverride + "][" + ZOverride + "][" + spawnMarker + "]")
    float[] posdata = TraceCircle(parentObj,dist,angle)
    spawnMarker.SetPosition(posdata[0],posdata[1],ZOverride)
    spawnMarker.SetAngle(0.0,0.0,AZOverride)
    ObjectReference ret = spawnMarker.PlaceAtMe(base)
    ret.SetAngle(0.0,0.0,AZOverride)
    ret.Disable() ; Fix Texture Blur bug     
    ret.Enable()
    Utility.wait(0.1)
    return ret
endFunction

Function CreateStairwell(ObjectReference parentObj, float dist, float angle, float azoverride, float end_z, ObjectReference spawnMarker)

	float start_z = parentObj.Z
    int block_height = ((((start_z - end_z) as Int) / 221) as Int) + 2
    if (block_height > 12)
        block_height = 12
    endif
	Trace("CreateStairwell start_z = [" + start_z + "] azoverride = [" + azoverride + "] end_z = [" + end_z + "] block_height = [" + block_height + "]")

	Static ShackBalconyStairs01 = Game.GetForm(0x000EC531) as Static
	
	; cascading steps...
	;
	;           <----
	;           ---->
	; |---|---|---|---|
	; |   |   |   |   |
	; |---|---|---|---|  * = pShelterCenter/myCenterMarker
	; |   |   |   |   |  P = Player (256 South of center)
	; |---|---*---|---|  North = dist 681.375, angle 147.71
	; |   |   ^   |   |  
	; |---|---P---|---|  
	; |   |   |   |   |  
	; |---|---|---|---|   

    ; Stairs : Length : 256.000000
	;          Width  : 168.000000
	;          Height : 223.000000

				
	float[] posdata = TraceCircle(parentObj, dist, angle) ; TraceCircle : postive = counter clockwise
	float s1x  = posdata[0]
	float s1y  = posdata[1]
	float s1az = azoverride - 180
	spawnMarker.SetPosition(posdata[0],posdata[1],posdata[2])	
	spawnMarker.SetAngle(0.0,0.0, s1az)
	Utility.wait(0.1)
	posdata = TraceCircle(spawnMarker,128) ; TraceCircle : postive = counter clockwise
	spawnMarker.SetPosition(posdata[0],posdata[1],posdata[2])	
	spawnMarker.SetAngle(0.0,0.0, s1az)
	posdata = TraceCircle(spawnMarker,256,90) ; TraceCircle : postive = counter clockwise	
	float s2x  = posdata[0]
	float s2y  = posdata[1]
	float s2az = azoverride
	ObjectReference theBlock
		
    int y       = 1
	int flipbit = 1
    while (y < block_height)
		if (flipbit > 0)
			spawnMarker.SetPosition(s1x,s1y,(start_z - (221 * y)))
			spawnMarker.SetAngle(0.0,0.0,s1az)
			theBlock = spawnMarker.PlaceAtMe(ShackBalconyStairs01)
			Utility.wait(0.1)
			theBlock.SetAngle(0.0,0.0,s1az)
			myStairs.Add(theBlock)			
		else
			spawnMarker.SetPosition(s2x,s2y,(start_z - (221 * y)))
			spawnMarker.SetAngle(0.0,0.0,s2az)
			theBlock = spawnMarker.PlaceAtMe(ShackBalconyStairs01)
			Utility.wait(0.1)
			theBlock.SetAngle(0.0,0.0,s2az)
			myStairs.Add(theBlock)					
		endif
		flipbit = flipbit * -1
        y += 1
    endwhile
EndFunction
	
Function CreateFoundationLeg(float posx, float posy, float AZOverride, float start_z, float end_z, ObjectReference spawnMarker)
    int block_height = ((((start_z - end_z) as Int) / 221) as Int) + 1
    if (block_height < 2)
      return
    endif
    if (block_height > 12)
        block_height = 12
    endif
    form ShackFoundation02 = Game.GetForm(0x0022C663) ; workshop_ShackMidFloor01Foundation02
    int y = 1
    while (y < block_height)
        spawnMarker.SetPosition(posx,posy,(start_z - (221 * y)))
        spawnMarker.SetAngle(0.0,0.0,AZOverride)
        ObjectReference theBlock = spawnMarker.PlaceAtMe(ShackFoundation02)
        Utility.wait(0.1)
        theBlock.SetAngle(0.0,0.0,AZOverride)
        myfoundation.Add(theBlock)
        y += 1
    endwhile
EndFunction

ObjectReference Function CreateDecoration(ObjectReference parentObj, int id, Form base, float pivotDist, float pivotAngle, float ZOffset, float AZOffset, ObjectReference spawnMarker, bool fixTexture = false, bool fixNavmesh = false)
	Trace("CreateDecoration [" + parentObj + "][" + id + "][" + base + "][" + pivotDist + "][" + pivotAngle + "][" + ZOffset + "][" + AZOffset + "][" + spawnMarker + "][" + fixTexture + "][" + fixNavmesh + "]")

    if !parentObj
        return None
    endif

    ObjectReference theDecoration = myObjectCache[id]
    if (theDecoration && theDecoration.GetBaseObject() != base)
        myObjectCache[id] = None
        theDecoration.Disable()
        theDecoration.Delete()
        theDecoration = None
    endif

    float[] posdata = TraceCircle(parentObj, pivotDist, pivotAngle)
    spawnMarker.SetPosition(posdata[0],posdata[1],posdata[2] + ZOffset)
    if (fixNavmesh)
        spawnMarker.MoveToNearestNavmeshLocation()
    endif
    spawnMarker.SetAngle(0.0,0.0, parentObj.GetAngleZ() + AZOffset)
	Utility.wait(0.1)

    if (!theDecoration) ; Do we need to create it?
        theDecoration = spawnMarker.PlaceAtMe(base)
        if (theDecoration)
            myObjectCache[id] = theDecoration
            theDecoration.SetPosition(spawnMarker.GetPositionX(), spawnMarker.GetPositionY(), spawnMarker.GetPositionZ())
            theDecoration.SetAngle(0.0,0.0, spawnMarker.GetAngleZ())
            if (fixTexture)
              theDecoration.Disable()
              theDecoration.Enable()
              Utility.wait(0.1)
            endif
            return theDecoration
        endif
    elseif !DistanceWithin(theDecoration, spawnMarker, 10) ; Did it move?
        theDecoration.SetPosition(spawnMarker.GetPositionX(), spawnMarker.GetPositionY(), spawnMarker.GetPositionZ())
        theDecoration.SetAngle(0.0,0.0, spawnMarker.GetAngleZ())
        if (fixTexture)
            theDecoration.Disable()
            theDecoration.Enable()
            Utility.wait(0.1)
        endif
    endif

    return theDecoration
    
EndFunction

Function DeleteDecoration(int id, bool fade=False)

    ObjectReference theDecoration = myObjectCache[id]
    if (theDecoration)
        myObjectCache[id] = None
        theDecoration.Disable(fade)
        theDecoration.Delete()
        theDecoration = None
    endif
    
EndFunction

Function DeleteDecorationRange(int startid, int endid, bool fade=False)

	int i = startid
	int rangelen = endid + 1
	while (i < rangelen)
		ObjectReference theDecoration = myObjectCache[i]
		if (theDecoration)
			myObjectCache[i] = None
			theDecoration.Disable(fade)
			theDecoration.Delete()
			theDecoration = None
		endif
		i += 1
	endwhile
    
EndFunction

; Benches persist between setup/teardown (Unlike other Camp elements), so we need to use 
; ReferenceAliases instead of LinkedRefs and a MoveTo command incase the worldspace has changed.
ObjectReference Function CreateBench(ObjectReference parentObj, ReferenceAlias benchRef, Form base,  float pivotDist, float pivotAngle, float ZOffset, float AZOffset, ObjectReference spawnMarker, bool fixTexture = false, bool fixNavmesh = false, bool linkToStorage=true)
	Trace("CreateBench [" + parentObj + "][" + base + "][" + pivotDist + "][" + pivotAngle + "][" + ZOffset + "][" + AZOffset + "][" + spawnMarker + "][" + fixTexture + "][" + fixNavmesh + "]")
	
    if !parentObj
        return None
    endif

    float[] posdata = TraceCircle(parentObj, pivotDist, pivotAngle)
    spawnMarker.SetPosition(posdata[0],posdata[1],posdata[2] + ZOffset)
	
    if (fixNavmesh)
        spawnMarker.MoveToNearestNavmeshLocation()
    endif
	
	spawnMarker.SetAngle(0.0,0.0, parentObj.GetAngleZ() + AZOffset)
	
	ObjectReference theBench=benchRef.GetReference()
	if (theBench)
		if (theBench.GetBaseObject() != base)
			ObjectReference newBench = spawnMarker.PlaceAtMe(base) ; Bench
			Utility.wait(0.1)
			if (newBench)
				; theBench.RemoveAllItems(newBench,true)
				; Utility.wait(0.2)
				benchRef.Clear()
				theBench.Disable()
				theBench.Delete()
				theBench = None
			
				newBench.SetPosition(spawnMarker.GetPositionX(), spawnMarker.GetPositionY(), spawnMarker.GetPositionZ())
				newBench.SetAngle(0.0,0.0, spawnMarker.GetAngleZ())
				newBench.Disable()
				newBench.Enable()
				benchRef.ForceRefTo(newBench)
				
				return newBench		
			endif
        endif			
		if (DistanceWithin(theBench,spawnMarker,30))
			if (theBench.IsDisabled())
				theBench.Enable(true)
			endif
			return theBench
		endif
		if (!theBench.Is3DLoaded())
			theBench.MoveTo(spawnMarker)
		else
			theBench.SetPosition(spawnMarker.GetPositionX(), spawnMarker.GetPositionY(), spawnMarker.GetPositionZ())
			theBench.SetAngle(0.0,0.0, spawnMarker.GetAngleZ())
		endif
		theBench.Disable()
		theBench.Enable()
		return theBench		
	endif
	
    theBench = spawnMarker.PlaceAtMe(base) ; Bench
    if (!theBench)
		return None
	endif
		
	Trace("Bench Created at SpawnMarker")
	theBench.SetPosition(spawnMarker.GetPositionX(), spawnMarker.GetPositionY(), spawnMarker.GetPositionZ())
	theBench.SetAngle(0.0,0.0, spawnMarker.GetAngleZ())
	theBench.Disable()
	if linkToStorage
		theBench.SetLinkedRef(pShelterStorage.GetReference(),WorkshopItemKeyword)
		theBench.SetLinkedRef(pShelterStorage.GetReference(),WorkshopLinkContainer)	
	endif
	theBench.Enable()
	
	benchRef.ForceRefTo(theBench)
	Utility.wait(0.1)
	return theBench		
endFunction
	
Function EnsureCookBenchDisabled()

	; NOTE: Make sure pShelterStorage.GetReference() is Loaded before
	; call or items will be deleted!

    ObjectReference theCookBench = pShelterCookBench.GetReference()
    if (theCookBench && theCookBench.IsEnabled())
        ObjectReference CampFire = myObjectCache[pTweakCampFireID]
        if CampFire
			myObjectCache[pTweakCampFireID] = None
            CampFire.Disable(true)
            CampFire.Delete()
            CampFire=None
        else
            Trace("No CampFire")
        endif
        ObjectReference CampLight = myObjectCache[pTweakCampFireLightID]
        if CampLight
            myObjectCache[pTweakCampFireLightID] = None
            CampLight.Disable(true)
            CampLight.Delete()
            CampLight=None
        else
            Trace("No CampLight")
        endif
		if None == theCookBench.GetLinkedRef(WorkshopLinkContainer)
			theCookBench.RemoveAllItems(pShelterStorage.GetReference())
			Utility.wait(0.2)
			theCookBench.Disable(true)
			theCookBench.SetLinkedRef(pShelterStorage.GetReference(), WorkshopItemKeyword)
			theCookBench.SetLinkedRef(pShelterStorage.GetReference(), WorkshopLinkContainer)
		else
			theCookBench.Disable(true)
		endif		
    endif
EndFunction

Function EnsureChemBenchDisabled()

	Trace("EnsureChemBenchDisabled")

	; NOTE: Make sure pShelterStorage.GetReference() is Loaded before
	; call or items will be deleted!
	
	ObjectReference theChemBench = pShelterChemBench.GetReference()
	if theChemBench && theChemBench.IsEnabled()
		if None == theChemBench.GetLinkedRef(WorkshopLinkContainer)
			
			; Upgrade Scenario for 1.09: They had an enabled workbench, do we didn't 
			; link until the next teardown...
			
			theChemBench.RemoveAllItems(pShelterStorage.GetReference())
			Utility.wait(0.2)
			theChemBench.Disable()
			theChemBench.SetLinkedRef(pShelterStorage.GetReference(), WorkshopItemKeyword)
			theChemBench.SetLinkedRef(pShelterStorage.GetReference(), WorkshopLinkContainer)
		else
			theChemBench.Disable(true)
		endif
	endif
	
EndFunction

Function EnsureWeapBenchDisabled()

	Trace("EnsureWeapBenchDisabled")

	; NOTE: Make sure pShelterStorage.GetReference() is Loaded before
	; call or items will be deleted!
	
	ObjectReference theWeapBench = pShelterWeapBench.GetReference()	
	if theWeapBench && theWeapBench.IsEnabled()
		if None == theWeapBench.GetLinkedRef(WorkshopLinkContainer)
			
			; Upgrade Scenario for 1.09: They had an enabled workbench, do we didn't 
			; link until the next teardown...
			
			theWeapBench.RemoveAllItems(pShelterStorage.GetReference())
			Utility.wait(0.2)
			theWeapBench.Disable()
			theWeapBench.SetLinkedRef(pShelterStorage.GetReference(), WorkshopItemKeyword)
			theWeapBench.SetLinkedRef(pShelterStorage.GetReference(), WorkshopLinkContainer)
		else
			theWeapBench.Disable(true)
		endif
	endif
	
EndFunction

Function EnsureArmorBenchDisabled()

	Trace("EnsureArmorBenchDisabled")

	; NOTE: Make sure pShelterStorage.GetReference() is Loaded before
	; call or items will be deleted!
	
	ObjectReference theArmorBench = pShelterArmorBench.GetReference()
	if theArmorBench && theArmorBench.IsEnabled()
		if None == theArmorBench.GetLinkedRef(WorkshopLinkContainer)
			
			; Upgrade Scenario for 1.09: They had an enabled workbench, do we didn't 
			; link until the next teardown...
			
			theArmorBench.RemoveAllItems(pShelterStorage.GetReference())
			Utility.wait(0.2)
			theArmorBench.Disable()
			theArmorBench.SetLinkedRef(pShelterStorage.GetReference(), WorkshopItemKeyword)
			theArmorBench.SetLinkedRef(pShelterStorage.GetReference(), WorkshopLinkContainer)
		else
			theArmorBench.Disable(true)
		endif
	endif
	
EndFunction

Function EnsurePowerBenchDisabled()

	Trace("EnsurePowerBenchDisabled")

	; NOTE: Make sure pShelterStorage.GetReference() is Loaded before
	; call or items will be deleted!
	
	ObjectReference thePowerBench = pShelterPowerBench.GetReference()
	if thePowerBench && thePowerBench.IsEnabled()
		if None == thePowerBench.GetLinkedRef(WorkshopLinkContainer)
			
			; Upgrade Scenario for 1.09: They had an enabled workbench, do we didn't 
			; link until the next teardown...
			ObjectReference storage = pShelterStorage.GetReference()
			Trace("Upgrade Detected. Removing Items to Storage [" + storage + "]")			
			
			Trace("PowerBench Item Count Before [" + thePowerBench.GetItemCount() + "]")			
			Trace("Storage Item Count Before [" + storage.GetItemCount() + "]")		
			
			thePowerBench.RemoveAllItems(storage)
			Utility.wait(0.2)
			
			Trace("PowerBench Item Count After [" + thePowerBench.GetItemCount() + "]")			
			Trace("Storage Item Count After [" + storage.GetItemCount() + "]")		
			

			Trace("Setting Linked Refs WorkshopItemKeyword [" + WorkshopItemKeyword + "] and WorkshopLinkContainer [" + WorkshopLinkContainer + "]")		
			thePowerBench.SetLinkedRef(storage, WorkshopItemKeyword)
			thePowerBench.SetLinkedRef(storage, WorkshopLinkContainer)
			
			Trace("Disabling PowerBench")		
			thePowerBench.Disable()
		else
			thePowerBench.Disable(true)
		endif
	endif
	
EndFunction

Function MoveFollowers(ObjectReference parentObj, ObjectReference spawnMarker, bool fixNavmesh = false)
    Trace("MoveFollowers Called. fixNavmesh [" + fixNavmesh + "]") 
    AFT:TweakFollowerScript pTweakFollowerScript = (self as Quest) as AFT:TweakFollowerScript
    if (pTweakFollowerScript)
	
        ReferenceAlias[] followers = pTweakFollowerScript.GetAllTweakFollowers()		
		ReferenceAlias[] followersWithPA = new ReferenceAlias[0]
		ReferenceAlias[] followersNoPA   = new ReferenceAlias[0]
				
        int followerLen = followers.length
        int i = 0
        while (i < followerLen)		
			if followers[i].GetActorReference().WornHasKeyword(pArmorTypePower)
				followersWithPA.Add(followers[i])
			else
				AFT:TweakInventoryControl pTweakInventoryControl = (followers[i] as AFT:TweakInventoryControl)   
				if (pTweakInventoryControl && pTweakInventoryControl.GetAssignedPA())
					followersWithPA.Add(followers[i])
				else
					followersNoPA.Add(followers[i])
				endif
			endif
			i += 1
		endwhile

		bool slot0Available=true
		bool slot1Available=true ; Best for PA Equipped Follower 
		bool slot2Available=true ; Best for PA Equipped Follower
		bool slot3Available=true ; Best for PA Equipped Follower
		bool slot4Available=true ; Best for PA Equipped Follower
		bool slot5Available=true
		
		int followersWithPALen   = followersWithPA.length
		int followersNoPALen     = followersNoPA.length

		if (followersWithPALen > 0)
			slot1Available = false
			MoveFollowerHelper( followersWithPA[0], parentObj, spawnMarker, 135, 350, fixNavmesh)
		endIf
		if (followersWithPALen > 1)
			slot2Available = false
			MoveFollowerHelper( followersWithPA[1], parentObj, spawnMarker, -135, 350, fixNavmesh)
		endIf
		if (followersWithPALen > 2)
			slot3Available = false
			MoveFollowerHelper( followersWithPA[2], parentObj, spawnMarker, 45, 350, fixNavmesh)
		endIf
		if (followerLen > 3)
			slot4Available = false
			MoveFollowerHelper( followers[3], parentObj, spawnMarker, -45, 350, fixNavmesh)
		endIf
		if (followersWithPALen > 4)
			slot0Available = false
			MoveFollowerHelper( followersWithPA[4], parentObj, spawnMarker, -180, 240, fixNavmesh)
		endIf
		
		int followersNoPACurrent = 0
		if (slot0Available && followersNoPACurrent < followersNoPALen)
			MoveFollowerHelper( followersNoPA[followersNoPACurrent], parentObj, spawnMarker, -180, 240, fixNavmesh)
			followersNoPACurrent += 1
		endIf
		if (slot1Available && followersNoPACurrent < followersNoPALen)
			MoveFollowerHelper( followersNoPA[followersNoPACurrent], parentObj, spawnMarker, 135, 350, fixNavmesh)
			followersNoPACurrent += 1
		endIf
		if (slot2Available && followersNoPACurrent < followersNoPALen)
			MoveFollowerHelper( followersNoPA[followersNoPACurrent], parentObj, spawnMarker, -135, 350, fixNavmesh)
			followersNoPACurrent += 1
		endIf
		if (slot3Available && followersNoPACurrent < followersNoPALen)
			MoveFollowerHelper( followersNoPA[followersNoPACurrent], parentObj, spawnMarker, 45, 350, fixNavmesh)
			followersNoPACurrent += 1
		endIf
		if (slot4Available && followersNoPACurrent < followersNoPALen)
			MoveFollowerHelper( followersNoPA[followersNoPACurrent], parentObj, spawnMarker, -45, 350, fixNavmesh)
			followersNoPACurrent += 1
		endIf
		if (slot5Available && followersNoPACurrent < followersNoPALen)
			MoveFollowerHelper( followersNoPA[followersNoPACurrent], parentObj, spawnMarker, 90, 240, fixNavmesh)
		endIf
				
    else
        Trace("pTweakFollowerScript cast Failure") 
    endif
endFunction

Function MoveFollowerHelper(ReferenceAlias ref, ObjectReference parentObj, ObjectReference spawnMarker, float angleoffset, float distance, bool fixNavmesh)

    Trace("MoveFollowerHelper() angleoffset [" + angleoffset + "] distance [" + distance + "] fixNavmesh [" + fixNavmesh + "]") 
    Trace("parentObj [" + parentObj + "] [" + parentObj.GetPositionX() + "][" + parentObj.GetPositionY() + "][" + parentObj.GetPositionZ() + "] AZ [" + parentObj.GetAngleZ() + "]") 

 
    float[] pa_posdata  = TraceCircle(parentObj,distance,angleoffset)
    float[] npc_posdata = TraceCircle(parentObj,170,angleoffset)
    Actor npc = ref.GetActorReference()
    ObjectReference thePA = None
    float headingZ = 0.0
 
    AFT:TweakInventoryControl pTweakInventoryControl = (ref as AFT:TweakInventoryControl)   
    if (npc.WornHasKeyword(pArmorTypePower))
        Trace("NPC [" + npc + "] is wearing PowerArmor") 
        spawnMarker.SetPosition(pa_posdata[0],pa_posdata[1],pa_posdata[2])
        spawnMarker.SetAngle(0.0,0.0,spawnMarker.GetAngleZ() + spawnMarker.GetHeadingAngle(parentObj) - 180)
        if fixNavmesh
            spawnMarker.MoveToNearestNavmeshLocation()
        endif 
        npc.MoveTo(spawnMarker)
        Utility.wait(0.1)
        if (pTweakInventoryControl)
            Trace("Calling TweakInventoryControl.ExitPA()")  
            pTweakInventoryControl.ExitPA()
            thePA = pTweakInventoryControl.GetAssignedPA()
        else
            Trace("TweakInventoryControl cast failure. Attempting recovery")  
            npc.SwitchToPowerArmor(None)
            int maxwait = 6
            while (npc.GetSitState() != 0 && maxwait > 0)
                Utility.wait(1.0)
                maxwait -= 1
            endwhile
            thePA = npc.GetLinkedRef(pLinkPowerArmor)
        endif  
    elseif (pTweakInventoryControl)
        thePA = pTweakInventoryControl.GetAssignedPA()
    else
        Trace("TweakInventoryControl cast failure. PA not detected")
    endif
 
    Trace("NPC not wearing armor...")

    spawnMarker.SetPosition(npc_posdata[0],npc_posdata[1],npc_posdata[2])
    spawnMarker.SetAngle(0.0,0.0,spawnMarker.GetAngleZ() + spawnMarker.GetHeadingAngle(parentObj))
    if fixNavmesh
        spawnMarker.MoveToNearestNavmeshLocation()
    endif 
    npc.MoveTo(spawnMarker)
  
    if (thePA)
        spawnMarker.SetPosition(pa_posdata[0],pa_posdata[1],pa_posdata[2])
        spawnMarker.SetAngle(0.0,0.0,spawnMarker.GetAngleZ() + spawnMarker.GetHeadingAngle(parentObj) - 180)
        if fixNavmesh
            spawnMarker.MoveToNearestNavmeshLocation()
        endif
        thePA.MoveTo(spawnMarker)
    endif
 
EndFunction

Event OnDistanceGreaterThan(ObjectReference player, ObjectReference building, float afDistance)
	UnregisterForDistanceEvents(player, building)
	Actor pc = Game.GetPlayer()
	if (building == myCenterMarker)
		Debug.Notification("Protection Lost")	
		pc.RemovePerk(pImmuneToRadiation)
		ObjectReference theUFO = myObjectCache[pTweakUFOID]
		if (theUFO && theUFO.IsEnabled())
			RegisterForDistanceLessThanEvent(player, myCenterMarker, 724)	
		endif
		return
	endif
	ObjectReference theLounger = myObjectCache[pTweakMisc2ID]
	if (theLounger && theLounger == building)
		Trace("Player Left for Memory. Starting Return Event Monitor")
		RegisterForDistanceLessThanEvent(player, theLounger, 1000)
	endif
EndEvent

Event OnDistanceLessThan(ObjectReference player, ObjectReference building, float afDistance)
	UnregisterForDistanceEvents(player, building)
	Actor pc = Game.GetPlayer()
	if (building == myCenterMarker)
		Debug.Notification("Protected from Radiation")
		pc.AddPerk(pImmuneToRadiation)
		ObjectReference theUFO = myObjectCache[pTweakUFOID]
		if (theUFO && theUFO.IsEnabled())
			RegisterForDistanceGreaterThanEvent(player, myCenterMarker, 724)
		endif
		return
	endif
	ObjectReference theLounger = myObjectCache[pTweakMisc2ID]
	if (theLounger && theLounger == building)
		Trace("Player Returned from Memory.")
		if (pTweakCampUFOEnabled.GetValueInt() > 1)
			RegisterForDistanceLessThanEvent(player,myCenterMarker, 724)
		endif		
		pc.SnapIntoInteraction(theLounger)
		Game.FadeOutGame(abFadingOut=False, abBlackFade=False, afSecsBeforeFade=0.0, afFadeDuration=3.0, abStayFaded=False)
		
		Utility.wait(1.0)
		theLounger.BlockActivation(false,false)
		theLounger.Activate(Game.GetPlayer(), True)
		Utility.wait(1.0)
		pTweakUsingMemoryLounger.SetValue(0.0)
		if OldWeather
			OldWeather.ForceActive(false)
			OldWeather = None
		endif		
		; Re-Enable Memory Activation
		RegisterForRemoteEvent(theLounger,"OnActivate")
	endif
EndEvent

Event OnTimerGameTime(int aiTimerID)
	; TearDownShelter(false)
	TearDownCamp(false)
	pTweakCampAvailable.Show()
EndEvent

Function ToggleDoorLocks()

	ObjectReference odoor1 = myObjectCache[pTweakModule1DoorID]
	ObjectReference odoor2 = myObjectCache[pTweakModule2DoorID]
	ObjectReference odoor3 = myObjectCache[pTweakModule3DoorID]
	ObjectReference odoor4 = myObjectCache[pTweakModule4DoorID]
	
	int locked = 0
	if odoor1 && odoor1.Is3DLoaded() && odoor1.GetLockLevel() == 253
		locked += 1
	endIf
	if odoor2 && odoor2.Is3DLoaded() && odoor2.GetLockLevel() == 253
		locked += 1
	endIf
	if odoor3 && odoor3.Is3DLoaded() && odoor3.GetLockLevel() == 253
		locked += 1
	endIf
	if odoor4 && odoor4.Is3DLoaded() && odoor4.GetLockLevel() == 253
		locked += 1
	endIf

	; If ANY are locked, unlock:
	if locked != 0
		DoorsLocked = false
		UnlockDoor(odoor1)
		UnlockDoor(odoor2)
		UnlockDoor(odoor3)
		UnlockDoor(odoor4)
		return
	endIf
	
	DoorsLocked = true
	if odoor1 && odoor1.Is3DLoaded()
		odoor1.SetOpen(false)
	endIf
	if odoor2 && odoor2.Is3DLoaded()
		odoor2.SetOpen(false)
	endIf
	if odoor3 && odoor3.Is3DLoaded()
		odoor3.SetOpen(false)
	endIf
	if odoor4 && odoor4.Is3DLoaded()
		odoor4.SetOpen(false)
	endIf		
	LockDoor(odoor1)
	LockDoor(odoor2)
	LockDoor(odoor3)
	LockDoor(odoor4)
	
EndFunction

Function UnlockDoor(ObjectReference theDoor)
	if !theDoor
		return
	endif
	if !theDoor.Is3DLoaded()
		return
	endif
	theDoor.Lock(false)
	theDoor.SetLockLevel(0)					
	theDoor.SetOpen()
EndFunction

Function LockDoor(ObjectReference theDoor)
	if !theDoor
		return
	endif
	if !theDoor.Is3DLoaded()
		return
	endif
	if theDoor.GetOpenState() == 3
		Trace("Already Closed.... Applying Terminal Lock")
		theDoor.SetLockLevel(253) ;  Terminal Only
		theDoor.Lock(true)
	elseif theDoor.GetOpenState() != 0 ; object can't be opened or closed
		; Wait for it to finish
		int maxwait = 5
		while (maxwait > 0 && (theDoor.GetOpenState() == 2 || theDoor.GetOpenState() == 4))
			Utility.wait(1.0)
			maxwait -= 1
		endwhile
		if theDoor.GetOpenState() == 1 ; open
			theDoor.SetOpen(false)
			maxwait = 5
			while (maxwait > 0 && theDoor.GetOpenState() == 4)
				Utility.wait(1.0)
				maxwait -= 1
			endwhile						
		endif
		if theDoor.GetOpenState() == 3 ; closed
			theDoor.SetLockLevel(253) ;  Terminal Only
			theDoor.Lock(true)
		else
			Trace("Close took more than 5 seconds. Bailing")
		endif
	else
		Trace("Door can not be opened or closed")
	endif
EndFunction


; For the most part we tear down camp in reverse with a few exceptions. 
; - We remove the terminal first to prevent bugs with users activating
;   terminal right before we disable/delete it.
; - We deal with Power Armors last as they aren't removed, but simply 
;   teleported to a safe/accessible nearby location. (As long as the
;   foundation is standing, we can't do that). 

Function TearDownCamp(bool remote=false)
	Trace("TearDownCamp()")
	if (remote)	
		StartTimerGameTime(24.0)
		pTweakTeardownSchedule.Show()
		return
	endif
	
	; I hate this reachback, but there is no elegantway to 
	; do this...
    AFT:TweakFollowerScript pTweakFollowerScript = (self as Quest) as AFT:TweakFollowerScript
    if (pTweakFollowerScript)
		pTweakFollowerScript.ReleaseCampPosed()
	endif
	
	CancelTimerGameTime(0)
	Actor player = Game.GetPlayer()
	
	; ----------------------------------
	; Remove Camp Terminal
	; ----------------------------------

	ObjectReference CampTerminal = myObjectCache[pTweakCampTerminalID]
	if CampTerminal
		DeleteDecoration(pTweakCampTerminalID)
	else
		Trace("No CampTerminal")
	endif
	
	ObjectReference CampTerminalStand = myObjectCache[pTweakCampTerminalStandID]
	if CampTerminalStand
		DeleteDecoration(pTweakCampTerminalStandID)
	else
		Trace("No CampTerminalStand")
	endif
		
	; ----------------------------------
	; Remove Turrets
	; ----------------------------------

	if (myObjectState[pTweakTurretNorth1ID] > 1)
		DeleteDecorationRange(pTweakTurretNorth1ID,pTweakTurretWest2ID)
	else
		Trace("Turrets not enabled")
	endif
	
	; ----------------------------------
	; Remove Misc2
	; ----------------------------------

	ObjectReference theMisc2 = myObjectCache[pTweakMisc2ID]
	if theMisc2
		int objectState = myObjectState[pTweakMisc2ID]
		if objectState > 1
			if (4 == objectState)	; Memory Lounger
				UnregisterForRemoteEvent(myObjectCache[pTweakMisc2ID],"OnActivate")				
			endif		
			ObjectReference theChild1 = theMisc2.GetLinkedRef(LinkCustom08)
			if (theChild1)
				theMisc2.SetLinkedRef(None,LinkCustom08)
				theChild1.Disable()
				theChild1.Delete()
				theChild1 = None
			endif
			ObjectReference theChild2 = theMisc2.GetLinkedRef(LinkCustom09)
			if (theChild2)
				theMisc2.SetLinkedRef(None,LinkCustom09)
				theChild2.Disable()
				theChild2.Delete()
				theChild2 = None
			endif									
			DeleteDecoration(pTweakMisc2ID)
			if (5 ==objectState)
				; Remove the Helper
				DeleteDecoration(pTweakMisc2HelperID)
			endif
		else
			Trace("Misc2 not enabled")
		endif
	else
		Trace("No Misc2")
	endif

	; ----------------------------------
	; Remove Misc1
	; ----------------------------------

	ObjectReference thePod  = pShelterFridge.GetReference()
	if (thePod && thePod.IsEnabled())
		thePod.Disable()
		UnregisterForRemoteEvent(myObjectCache[pTweakMisc1ID],"OnActivate")
	else
		Trace("No CryoFridge or it is already disabled.")
	endif
	
	ObjectReference theMisc1 = myObjectCache[pTweakMisc1ID]
	if (theMisc1 && theMisc1.IsEnabled() && (myObjectState[pTweakMisc1ID] > 1))
		ObjectReference theChild1 = theMisc1.GetLinkedRef(LinkCustom08)
		if (theChild1)
			theMisc1.SetLinkedRef(None,LinkCustom08)
			theChild1.Disable()
			theChild1.Delete()
			theChild1 = None
		endif
		ObjectReference theChild2 = theMisc1.GetLinkedRef(LinkCustom09)
		if (theChild2)
			theMisc1.SetLinkedRef(None,LinkCustom09)
			theChild2.Disable()
			theChild2.Delete()
			theChild2 = None
		endif
		DeleteDecoration(pTweakMisc1ID)
	else
		Trace("No Misc1 or it is already disabled.")
	endIf

	; ----------------------------------
	; Remove Seat 2
	; ----------------------------------
	ObjectReference theSeat2 = myObjectCache[pTweakSeat2ID]
	if (theSeat2 && myObjectState[pTweakSeat2ID] > 1)
		DeleteDecoration(pTweakSeat2ID)
	else
		Trace("No Seat2")
	endif
	
	; ----------------------------------
	; Remove Seat 1
	; ----------------------------------
	ObjectReference theSeat1 = myObjectCache[pTweakSeat1ID]
	if (theSeat1 && myObjectState[pTweakSeat1ID] > 1)
		DeleteDecoration(pTweakSeat1ID)
	else
		Trace("No Seat1")
	endif

	; ----------------------------------
	; Remove Bed 2
	; ----------------------------------	
	ObjectReference Bed2 = myObjectCache[pTweakBed2ID]
	if (Bed2 && myObjectState[pTweakBed2ID] > 1)
		DeleteDecoration(pTweakBed2ID)
	else
		Trace("No Bed 2")
	endif

	; ----------------------------------
	; Remove Bed 1
	; ----------------------------------
	ObjectReference Bed1 = myObjectCache[pTweakBed1ID]
	if (Bed1 && myObjectState[pTweakBed1ID] > 1)
		DeleteDecoration(pTweakBed1ID)
	else
		Trace("No Bed 1")
	endif

	; ----------------------------------
	; Remove Power Armor Bench
	; ----------------------------------
	EnsurePowerBenchDisabled()

	; ----------------------------------
	; Remove Armor Bench
	; ----------------------------------
	EnsureArmorBenchDisabled()

	; ----------------------------------
	; Remove Weapon Bench
	; ----------------------------------
	EnsureWeapBenchDisabled()
		
	; ----------------------------------
	; Remove Chemical Bench
	; ----------------------------------
	EnsureChemBenchDisabled()

	; ----------------------------------
	; Remove Modules
	; ----------------------------------
	ObjectReference theModule4 = myObjectCache[pTweakModule4ID]
	if (theModule4 && theModule4.IsEnabled())
		DeleteDecorationRange(pTweakModule4ID,pTweakModule4LightDID,true)			
	else
		Trace("No Module4 or it is already disabled")
	endif

	ObjectReference theModule3 = myObjectCache[pTweakModule3ID]
	if (theModule3 && theModule3.IsEnabled())
		DeleteDecorationRange(pTweakModule3ID,pTweakModule3LightDID,true)
	else
		Trace("No Module3 or it is already disabled")
	endif

	ObjectReference theModule2 = myObjectCache[pTweakModule2ID]
	if (theModule2 && theModule2.IsEnabled())
		DeleteDecorationRange(pTweakModule2ID,pTweakModule2LightDID,true)
	else
		Trace("No Module2 or it is already disabled")
	endif

	ObjectReference theModule1 = myObjectCache[pTweakModule1ID]
	if (theModule1 && theModule1.IsEnabled())
		DeleteDecorationRange(pTweakModule1ID,pTweakModule1LightDID,true)
	else
		Trace("No Module1 or it is already disabled")
	endif

	; ----------------------------------
	; Remove Cooking Bench
	; ----------------------------------
	EnsureCookBenchDisabled()
	
	; ----------------------------------
	; Remove UFO
	; ----------------------------------
	ObjectReference theUFO = myObjectCache[pTweakUFOID]
	if theUFO && theUFO.IsEnabled()
		DeleteDecorationRange(pTweakUFOLight1ID, pTweakUFOLight7ID)
		DeleteDecoration(pTweakUFOID, true)
		if (-1 != myUFOSoundID)
			Sound.StopInstance(myUFOSoundID)
			myUFOSoundID = -1
		endif
		UnregisterForDistanceEvents(player, myCenterMarker)
		if (player.hasPerk(pImmuneToRadiation))
			player.RemovePerk(pImmuneToRadiation)
		endif
	else
		Trace("No UFO or it is already disabled")
	endif

	; ----------------------------------
	; Remove Stairs
	; ----------------------------------
	if (myStairs.length != 0)
		Trace("Stairs has : [" + myStairs.length + "] pieces. Deleting")
		int d = 0
		int flen = myStairs.length
		while (d < flen)
			myStairs[d].disable()
			myStairs[d].delete()
			d += 1
		endWhile
		myStairs.Clear()
	else
		Trace("Stairs has : [" + myStairs.length + "] pieces. Delete not necessary")
	endif

	; ----------------------------------
	; Remove Foundation
	; ----------------------------------
	
	if (myFoundation.length != 0)
		Trace("Foundation has : [" + myFoundation.length + "] pieces. Deleting")
		int d = 0
		int flen = myFoundation.length
		while (d < flen)
			myFoundation[d].disable()
			myFoundation[d].delete()
			d += 1
		endWhile
		myFoundation.Clear()
	else
		Trace("Foundation has : [" + myFoundation.length + "] pieces. Delete not necessary")
	endif
	
	; ----------------------------------
	; Remove Map Marker
	; ----------------------------------
			
	ObjectReference pAFTMapMarker     = pShelterMapMarker.GetReference()	
	if pAFTMapMarker.IsEnabled()
		Trace("Disabling AFTMapMarker")
		pAFTMapMarker.Disable()
	endIf
	
	ObjectReference pAFTMarkerHeading = pShelterMapTeleport.GetReference()
	if pAFTMarkerHeading.IsEnabled()
		Trace("Disabling AFTMarkerHeading")
		pAFTMarkerHeading.Disable()
	endif

	if (myCenterMarker)
		Trace("Unregistering Distance Events")
		UnregisterForDistanceEvents(player, myCenterMarker)
	else
		Trace("No myCenterMarker")
	endif

	; ----------------------------------
	; Move PowerArmors to accessible location
	; ----------------------------------
	
	ObjectReference pa = player.GetLinkedRef(pLinkPowerArmor)
	if (pa && pa.GetLinkedRef(pLinkPowerArmor) == player)
		pa.MoveToNearestNavmeshLocation()
		pa.Disable()
		pa.Enable()
		Utility.wait(0.1)
	else
		Trace("No Armor assigned to player (found)")
	endif
	
    if (pTweakFollowerScript)
        ReferenceAlias[] followers = pTweakFollowerScript.GetAllTweakFollowers()		
        int followerLen = followers.length
        int i = 0
        while (i < followerLen)
			Actor npc = followers[i].GetActorReference()
			if !npc.WornHasKeyword(pArmorTypePower)
				pa = npc.GetLinkedRef(pLinkPowerArmor)
				if (pa && pa.GetLinkedRef(pLinkPowerArmor) == npc)
					pa.MoveToNearestNavmeshLocation()
					pa.Disable()
					pa.Enable()
					Utility.wait(0.1)
				else
					Trace("Follower [" + i + "] No assigned PowerArmor")
				endif
			else
				Trace("Follower [" + i + "] Already in PowerArmor")				
			endif
			i += 1
		endwhile
	endif
	
	pTweakCampDocked.SetValue(0)
	inSettlement = false
	ShelterSetup = false
	DoorsLocked  = false
	Trace("Teardown Complete")
	
EndFunction

Function TransferToLocalSettlement()

	ObjectReference center = pShelterCenter.GetReference()
	WorkshopScript workshopRef = pWorkshopParent.GetWorkshopFromLocation(center.GetCurrentLocation())
	if !workshopRef
		Trace("Not in settlement!")
		inSettlement = false
		return
	endif
	
	if (!workshopRef.Is3DLoaded() || !center.Is3DLoaded())
		Trace("Container 3D not loaded. Operation not available.")
		return
	endif
	
	ObjectReference fridge     = pShelterFridge.GetReference()
	ObjectReference storage    = pShelterStorage.GetReference()

	ObjectReference weapBench  = pShelterWeapBench.GetReference()
	ObjectReference armorBench = pShelterArmorBench.GetReference()
	ObjectReference chemBench  = pShelterChemBench.GetReference()
	ObjectReference cookBench  = pShelterCookBench.GetReference()
	ObjectReference powerBench = pShelterPowerBench.GetReference()
			
	if weapBench && None == weapBench.GetLinkedRef(WorkshopLinkContainer) && weapBench.IsEnabled()
		weapBench.RemoveAllItems(workshopRef)
		Utility.waitmenumode(0.1)
		weapBench.SetLinkedRef(storage, WorkshopItemKeyword)
		weapBench.SetLinkedRef(storage, WorkshopLinkContainer)
	endif
	if armorBench && None == armorBench.GetLinkedRef(WorkshopLinkContainer) && armorBench.IsEnabled()
		armorBench.RemoveAllItems(workshopRef)
		Utility.waitmenumode(0.1)
		armorBench.SetLinkedRef(storage, WorkshopItemKeyword)
		armorBench.SetLinkedRef(storage, WorkshopLinkContainer)
	endif
	if chemBench && None == chemBench.GetLinkedRef(WorkshopLinkContainer) && chemBench.IsEnabled()
		chemBench.RemoveAllItems(workshopRef)
		Utility.waitmenumode(0.1)
		chemBench.SetLinkedRef(storage, WorkshopItemKeyword)
		chemBench.SetLinkedRef(storage, WorkshopLinkContainer)
	endif
	if cookBench && None == cookBench.GetLinkedRef(WorkshopLinkContainer) && cookBench.IsEnabled()
		cookBench.RemoveAllItems(workshopRef)
		Utility.waitmenumode(0.1)
		cookBench.SetLinkedRef(storage, WorkshopItemKeyword)
		cookBench.SetLinkedRef(storage, WorkshopLinkContainer)
	endif
	if powerBench && None == powerBench.GetLinkedRef(WorkshopLinkContainer) && powerBench.IsEnabled()
		powerBench.RemoveAllItems(workshopRef)
		Utility.waitmenumode(0.1)
		powerBench.SetLinkedRef(storage, WorkshopItemKeyword)
		powerBench.SetLinkedRef(storage, WorkshopLinkContainer)
	endif
	
	myCenterMarker = pShelterCenter.GetReference()
	if (myCenterMarker)
		storage.MoveToIfUnLoaded(myCenterMarker)
		if storage.IsDisabled()
			Trace("Enabling pAFTMapMarker to spawnMarker")
			storage.Enable()
		endIf
		storage.RemoveAllItems(workshopRef)
	endif
	
	if fridge && fridge.IsEnabled()
		fridge.RemoveAllItems(workshopRef)
	endif
	

EndFunction

Function TransferToCamp()

	ObjectReference center = pShelterCenter.GetReference()
	WorkshopScript workshopRef = pWorkshopParent.GetWorkshopFromLocation(center.GetCurrentLocation())
	if !workshopRef
		Trace("Not in settlement!")
		inSettlement = false
		return
	endif
	
	ObjectReference storage    = pShelterStorage.GetReference()
	myCenterMarker = pShelterCenter.GetReference()
	
	if (myCenterMarker)
		storage.MoveToIfUnLoaded(myCenterMarker)
		if storage.IsDisabled()
			Trace("Enabling pAFTMapMarker to spawnMarker")
			storage.Enable()
			Utility.waitmenumode(0.1)
		endIf
		workshopRef.RemoveAllItems(storage)
	endif

EndFunction


; AngleOffset:
;  -90     = Player's/Objects's left. 
;   90     = Players's/Object's right, 
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

; AngleOffset:
;  -90     = Players left. 
;   90     = Players right, 
; 180/-180 = behind player
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

Function BeamMeUp()
	Trace("BeamMeUp")
	ObjectReference theUFO = myObjectCache[pTweakUFOID]
	if (theUFO)
		Actor pc = Game.GetPlayer()
		; pc.SetPosition(theUFO.GetPositionX(), theUFO.GetPositionY(), theUFO.GetPositionZ() + 300)
		Spell TeleportPlayerInSpell   = Game.GetForm(0x001E5601) as Spell
		Spell TeleportPlayerOutSpell  = Game.GetForm(0x001F1022) as Spell
		
		pc.AddSpell(TeleportPlayerOutSpell, false)
		utility.wait(5)
		pc.MoveTO(theUFO,0.0,0.0,300.0)	
		pc.AddSpell(TeleportPlayerInSpell, false)
		
		RegisterForPlayerTeleport() 
		Utility.wait(5.0)
		
		if !pShownTeleportHint
			pTweakBeamMeUp.Show()
			pShownTeleportHint = true
		endif
					
	endIf
	
EndFunction

Event OnPlayerTeleport()
	UnregisterForPlayerTeleport()
	Spell TeleportPlayerInSpell   = Game.GetForm(0x001E5601) as Spell
	Actor pc = Game.GetPlayer()
	
	pc.AddSpell(TeleportPlayerInSpell, false)
	
	AFT:TweakFollowerScript pTweakFollowerScript = ((self as Quest) as AFT:TweakFollowerScript)
	if (pTweakFollowerScript)
		Trace("Teleporting Followers")
		ReferenceAlias[] followers = pTweakFollowerScript.GetAllTweakFollowers(true, False)		
		int follower_len = followers.length
		if (0 != follower_len)
			int i = 0
			while (i < follower_len)
				; NOTE: Disable/Enable NPC such as CURIE causes them to reset...
				followers[i].GetActorReference().EnableAI(false)
				i += 1
			endwhile
			Utility.Wait(5.0)
			i = 0
			Spell TeleportInSpell   = Game.GetForm(0x00062BDC) as Spell
			float[] posdata
			int angleoffset = 60
			while (i < follower_len)
				Actor npc = followers[i].GetActorReference()
				posdata = TraceCircle(myCenterMarker,170,angleoffset)
				npc.SetPosition(posdata[0],posdata[1],posdata[2])
				npc.EnableAI(true)
				npc.AddSpell(TeleportInSpell)
				angleoffset += 60
				i += 1
			endwhile
		endif
	endif
	
EndEvent

Function v109Upgrade()

	Trace("v109Upgrade")

	; While the quest marks the pShelterStorage ReferenceAlias as being a specific
	; value, it wasn't added until 1.09. Aliases are filled when quests start, so
	; the alias will be empty (NONE) if the user is not starting a new game or 
	; loading the mod for the first time. So we have to inject the reference and
	; test fill it here....
	pShelterStorage.ForceRefIfEmpty(AftCampStorage)
	
EndFunction

Function v112Upgrade()

	Trace("v112Upgrade")

	if 77 == myObjectCache.length
	
		Trace("Backing up Original State")
		ObjectReference[] transferCache = new ObjectReference[77]
		int[] transferState = new int[77]
		
		int i = 0
		while (i < 77)
			transferCache[i] = myObjectCache[i]
			transferState[i] = myObjectState[i]
			i += 1
		endwhile
		
		Trace("Resetting State")
		myObjectCache.Clear()
		myObjectState.Clear()

		myObjectCache = new ObjectReference[78]
		myObjectState = new int[78]
		
		Trace("Transfering New State")
		i = 0
		while (i < 26)
			myObjectCache[i] = transferCache[i]
			myObjectState[i] = transferState[i]
			i += 1
		endwhile
		
		myObjectCache[26] = None
		myObjectState[26] = 0

		i = 27
		int j = 26
		while (i < 78)
			myObjectCache[i] = transferCache[j]
			myObjectState[i] = transferState[j]
			i += 1
			j += 1
		endwhile
		
		transferCache.Clear()
		transferState.Clear()
		
		Trace("Complete")
		
	endif
	
EndFunction


; Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	; UnRegisterForAnimationEvent(akSource, asEventName)
	; if (akSource == Game.GetPlayer())
		; if (asEventName == "weaponSheathe")
		
			; Actor pc = Game.GetPlayer()
			; Spell TeleportPlayerInSpell   = Game.GetForm(0x001E5601) as Spell
			; Spell TeleportPlayerOutSpell  = Game.GetForm(0x001F1022) as Spell
		
			; pc.AddSpell(TeleportPlayerOutSpell)
			; utility.wait(5)
			; pc.MoveTO(myShackSmall)	
			; pc.AddSpell(TeleportPlayerInSpell)
			
		; endif
	; endIf
; endEvent

Function HealAll(Actor myPatient)
	int RadsToHeal = (mypatient.GetValue(Rads) as int)
	mypatient.RestoreValue(Rads, RadsToHeal)
	myPatient.RestoreValue(Health, 9999)
	myPatient.RestoreValue(LeftAttackCondition, 9999)
	myPatient.RestoreValue(LeftMobilityCondition, 9999)
	myPatient.RestoreValue(PerceptionCondition, 9999)
	myPatient.RestoreValue(RightAttackCondition, 9999)
	myPatient.RestoreValue(RightMobilityCondition, 99999)
	myPatient.RestoreValue(EnduranceCondition, 9999)

	;for new survival - curing diseases
	if myPatient == Game.GetPlayer()
		HC_Manager.ClearDisease()
	endif
	
	CureAddictions.Cast(myPatient, myPatient)
	
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

bool Function IsHostileNearby()

	ObjectReference[] nearby
	Actor npc
	int nsize
	int j
	
	Actor pc     = Game.GetPlayer()
	ObjectReference opc = pc as ObjectReference
	
	int numTypes = pTweakActorTypes.GetSize()
	int i        = 0
	
	while (i < numTypes)
		nearby = pc.FindAllReferencesWithKeyword(pTweakActorTypes.GetAt(i), 1500.0)
		if (0 != nearby.length)
			nsize = nearby.length
			j = 0
			while j < nsize
				npc =  nearby[j] as Actor
				if npc && npc.Is3DLoaded() && !npc.IsDead() && npc.IsHostileToActor(pc) && nearby[j].HasDirectLOS(opc)
					Trace("Hostile actor [" + npc + "] within 1500 of player and has direct LOS")
					return true
				endif
				j += 1
			endWhile				
		endif
		i += 1
	EndWhile
	
	return false
	
endFunction

Int Function GetPluginID(int formid)
	int fullid = formid
	if fullid > 0x80000000
		fullid -= 0x80000000
	endif
	int lastsix = fullid % 0x01000000
	return (((formid - lastsix)/0x01000000) as Int)
EndFunction 