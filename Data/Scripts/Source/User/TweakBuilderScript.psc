Scriptname TweakBuilderScript extends ObjectReference

bool bs_ignore = false
bool power_up = true
bool power_up_all = false
bool power_up_gen = true
int	bs_total = 0
int	bs_expected = 0
int	WorkshopID = 0
WorkshopParentScript WorkshopParent
WorkshopScript       WorkshopRef
WorkshopDataScript:WorkshopRatingKeyword[] ratings
WorkshopDataScript:WorkshopActorValue[] resourceAVs
Message ProgressMsg
Message PowerUpMsg
Message NoWorkshopMsg
Message NoNoSettlementMsg
Message DoneMsg
Message RemoveFoodMsg
Keyword PowerConnection
Keyword ItemKeyword
Keyword CanBePowered
ActorValue LightboxCycling
ActorValue LightboxCyclingType
ActorValue ResourceObject
ActorValue TerminalLightBrightness
ActorValue TerminalLightColor
ActorValue PowerGenerated
ActorValue PowerRadiation
ActorValue PowerRequired
bool stillrunning
Actor player
GlobalVariable DisablePrefabSafety
ObjectReference center
float radius

; Custom Content Support
string addonMod
Quest addonQuest
string addonQuestScript
string addonQuestScriptCallback

; Example: tbs.RegisterCustomContent("AwesomeMod.esp")
Function RegisterCustomContent(string NameOfAddonMod)
	addonMod = NameOfAddonMod
EndFunction

Function RegisterCustomCallBack(Quest addon_quest, String addon_quest_script, String addon_quest_script_callback)
	addonQuest = addon_quest
	addonQuestScript = addon_quest_script
	addonQuestScriptCallback = addon_quest_script_callback	
EndFunction

Event OnInit()
	stillrunning = true
	bs_ignore = false
	power_up = true
	power_up_all = false
	bs_total    = 0
	bs_expected = 0
	WorkshopID  = 0
	PowerGenerated = Game.GetForm(0x0000032E) as ActorValue
	PowerRadiation = Game.GetForm(0x0000032F) as ActorValue
	PowerRequired = Game.GetForm(0x00000330) as ActorValue
	CanBePowered = Game.GetForm(0x0003037E) as Keyword
	WorkshopParent = (Game.GetForm(0x0002058E) as Quest) as WorkshopParentScript
	ratings = WorkshopParent.WorkshopRatings
	resourceAVs = WorkshopParent.WorkshopResourceAVs
	PowerConnection = Game.GetForm(0x00054BA4) as Keyword
	ItemKeyword = Game.GetForm(0x00054BA6) as keyword
	ResourceObject = Game.GetForm(0x00129A8C) as ActorValue
	ProgressMsg = (Game.GetFormFromFile(0x0105DB55,"AmazingFollowerTweaks.esp") as Message)
	if ProgressMsg
		NoWorkshopMsg     = Game.GetFormFromFile(0x0105DB54,"AmazingFollowerTweaks.esp") as Message
		NoNoSettlementMsg = Game.GetFormFromFile(0x0105DB56,"AmazingFollowerTweaks.esp") as Message
		DoneMsg           = Game.GetFormFromFile(0x0105DB57,"AmazingFollowerTweaks.esp") as Message
		PowerUpMsg        = Game.GetFormFromFile(0x010645CC,"AmazingFollowerTweaks.esp") as Message
		RemoveFoodMsg     = Game.GetFormFromFile(0x0100D8A0,"AmazingFollowerTweaks.esp") as Message
	else
		ProgressMsg       = Game.GetForm(0x002476C4) as Message ; BoSM01PulserSignalStrengthMessage
		NoWorkshopMsg     = Game.GetForm(0x001D43EA) as Message ; MS02ReactorItemRequiredMessage : "Missing Required Item"
		NoNoSettlementMsg = Game.GetForm(0x001D43EA) as Message ; MS02ReactorItemRequiredMessage : "Missing Required Item"
		DoneMsg           = Game.GetForm(0x0004BE75) as Message ; WorkshopOwnedMessage : "You can now use this workshop."
		PowerUpMsg        = None
		RemoveFoodMsg     = Game.GetForm(0x001D43EA) as Message ; MS02ReactorItemRequiredMessage : "Missing Required Item"
	endif
	LightboxCycling         = Game.GetForm(0x00210B6F) as ActorValue
	LightboxCyclingType     = Game.GetForm(0x00210C75) as ActorValue
	TerminalLightBrightness = Game.GetForm(0x00210C77) as ActorValue
	TerminalLightColor      = Game.GetForm(0x001F57D2) as ActorValue
	DisablePrefabSafety     = Game.GetFormFromFile(0x0101699F,"AmazingFollowerTweaks.esp") as GlobalVariable
	center = None
	radius = 0.0
	addonMod = ""
	addonQuest = None
	addonQuestScript = ""
	addonQuestScriptCallback = ""
EndEvent

Function initializeBuilderScript()

EndFunction

Event OnTimer(int aiTimerID)
	if stillrunning
		stillrunning = false
		if (0 != bs_total)
			float pleft  = 100.0 - ((((bs_expected as float)/(bs_total as float)) as float) * 100 as float)
			if (pleft >= 100.0)
				if PowerUpMsg && power_up
					PowerUpMsg.Show()
				else
					ProgressMsg.Show(pleft)
				endif
			else
				ProgressMsg.Show(pleft)
			endif
		endif
		StartTimer(2.5)
	else
		builddone()
	endif
EndEvent

bool Function log(string asTextToPrint, int aiSeverity = 0) debugOnly
	debug.OpenUserLog("TweakBuilderScript") 
	RETURN debug.TraceUser("TweakBuilderScript", asTextToPrint, aiSeverity)
EndFunction

Function init(int lid, int requirenofood = 1)
	bs_ignore = false
	if !WorkshopParent
		bs_ignore = true
		NoWorkshopMsg.Show() ; "Unable to retrive WorkshopParent"
		log("Unable to retrive WorkshopParent")
		return
	endif
	Actor pc = Game.GetPlayer()
	WorkshopRef = WorkshopParent.GetWorkshopFromLocation(pc.GetCurrentLocation())
	if (!WorkshopRef)
		bs_ignore = true
		NoNoSettlementMsg.Show() ; "Not Located in Required Settlement"
		log("Not Located in Settlement")
		return
	endif
	WorkshopID = WorkshopRef.GetWorkshopID()
	int LocationRefID = WorkshopRef.GetCurrentLocation().GetFormID()	
	if lid < 0x01000000
		if LocationRefID != lid
			bs_ignore = true
			NoNoSettlementMsg.Show() ; "Not Located in Required Settlement"
			log("Not Located in Required Settlement")
			return
		endif
	else
		int lidMasked
		; DLC/MOD Settlement Support
		if (lid > 0x80000000)
			lidMasked           = (lid - 0x80000000) % (0x01000000)
		else
			lidMasked           = lid % (0x01000000)
		endif
		int LocationRefIDMasked
		if (LocationRefID > 0x80000000)
			LocationRefIDMasked = (LocationRefID - 0x80000000) % (0x01000000)
		else
			LocationRefIDMasked = LocationRefID % (0x01000000)
		endif
		if LocationRefIDMasked != lidMasked
			bs_ignore = true
			NoNoSettlementMsg.Show() ; "Not Located in Required Settlement"
			log("Not Located in Required Settlement")
			return
		endif
	endif
	
	; Calculate Center and radius
	Quest ScrapScanMaster = Game.GetFormFromFile(0x0100919A,"AmazingFollowerTweaks.esp") as Quest
	if (ScrapScanMaster)
		ScriptObject Scrapper = ScrapScanMaster.CastAs("AFT:TweakScrapScanScript")
		if (Scrapper)
			Var[] lidparam = new Var[1]
			lidparam[0] = lid
			center = Scrapper.CallFunction("getCenter", lidparam) as ObjectReference
			if (center)
				radius = Scrapper.CallFunction("getRadius", lidparam) as float
			else
				log("CallFunction getCenter failed")
			endif
		endIf
	endIf
	
	; Will generally be 0 for walls and 1 for full prefrabs. 
	if 0 != requirenofood
		log("Require no food is True.")
		if (DisablePrefabSafety && 0 == DisablePrefabSafety.GetValueInt())
			ObjectReference[] FoodObjects = WorkshopParent.GetResourceObjects(WorkshopRef, resourceAVs[WorkshopParent.WorkshopRatingFood].resourceValue, 2)
			int foodlen = FoodObjects.length
			if 0 != foodlen
				int foodlennobrahmin = foodlen
				; Exclude Brahmin:
				int f = 0
				while (f < foodlen)
					if (FoodObjects[f].GetBaseObject() as Actor) 
						foodlennobrahmin -= 1
					endif
					f += 1
				endwhile
				log("Food minus Brahmin [" + foodlennobrahmin + "]")			
				if 0 != foodlennobrahmin
					bs_ignore = true
					log("Food Removal Required")
					RemoveFoodMsg.Show() ; "Missing Required Resources"					
					return
				endIf
			endIf
		endIf
	endif
	power_up = true
	power_up_gen = true
	power_up_all = false
EndFunction

; Skipping Powerup is safer than powering up, but also means a lot more work for 
; Users as they will have to run all the lines...
Function skip_powerup()
	power_up = false
endFunction

; A Middle groud : Only power up objects that cast to Light
Function powerup_all()
	power_up_all = true
endFunction

Function skip_powerup_generators()
	power_up_gen = false
endFunction

Function clearsettlement(int lid)
	if bs_ignore
		return
	endif
	if WorkshopParent
		Actor pc = Game.GetPlayer()
		WorkshopRef = WorkshopParent.GetWorkshopFromLocation(pc.GetCurrentLocation())
		if (WorkshopRef)
			int locid = WorkshopRef.GetCurrentLocation().GetFormID()

			int locidMasked
			if (locid > 0x80000000)
				locidMasked = (locid - 0x80000000) % (0x01000000)
			else
				locidMasked = locid % (0x01000000)
			endif
			
			int lidMasked
			; DLC/MOD Settlement Support
			if (lid > 0x80000000)
				lidMasked           = (lid - 0x80000000) % (0x01000000)
			else
				lidMasked           = lid % (0x01000000)
			endif
						
			if lidMasked == locidMasked
				Quest ScrapScanMaster = Game.GetFormFromFile(0x0100919A,"AmazingFollowerTweaks.esp") as Quest
				if (ScrapScanMaster)
					ScriptObject Scrapper = ScrapScanMaster.CastAs("AFT:TweakScrapScanScript")
					if (Scrapper)
						Var[] params = new Var[0]
						; Scrap All will not return until it is finished...
						; So... not a good idea to call from terminal. 
						log("clearsettlement: Calling TweakScrapScanScript.ScrapAll()")
						Scrapper.CallFunction("ScrapAll", params)
					else
						log("clearsettlement: Cast to AFT:TweakScrapScanScript failed")
					endif
				else
					log("clearsettlement: Cast to Quest TweakScrapScanMaster Failed")
				endif			
			else
				NoNoSettlementMsg.Show() ; "Not Located in Required Settlement"
				log("clearsettlement: Not Located in Required Settlement")				
			endif
		else
			NoNoSettlementMsg.Show() ; "Not Located in Required Settlement"
			log("clearsettlement: Not Located in Settlement")
		endif
	endif
EndFunction

Function buildstart(int expecthint = 0)
	if bs_ignore
		return
	endif
	bs_expected = expecthint
	bs_total    = bs_expected
	player = Game.GetPlayer()
	stillrunning = true
	ProgressMsg.Show(0.0)		
	StartTimer(2.5)
EndFunction

Function rbuild(int base, float posx, float posy, float posz, float anglex, float angley, float anglez, float scale = 1.0, int extra = -1)
	Var[] params = new Var[9]
	params[0] = base
	params[1] = posx
	params[2] = posy
	params[3] = posz
	params[4] = anglex
	params[5] = angley
	params[6] = anglez
	params[7] = scale
	params[8] = extra
	self.CallFunctionNoWait("build", params)
EndFunction

Function build(int base, float posx, float posy, float posz, float anglex, float angley, float anglez, float scale = 1.0, int extra = -1)
	if bs_ignore
		return
	endif
	stillrunning = true
	log("build [" + base + "] (" + posx + "," + posy + "," + posz + ") (" + anglex + "," + angley + "," + anglez + ") " + "s[" + scale + "] extra[" + extra + "]")
	ObjectReference spawnMarker = player.PlaceAtMe(Game.GetForm(0x00024571))
    spawnMarker.SetPosition(posx,posy,posz)
	spawnMarker.SetAngle(anglex,angley,anglez)
	Utility.wait(0.05)
	stillrunning = true	
    ObjectReference ret
	if (base > 0)
		ret = spawnMarker.PlaceAtMe(Game.GetForm(base),1,true)		
	elseif (base > -0x05000000)
		if (base < -0x03FFFFFF)
			; -0x04??????			
			Form lookup = Game.GetFormFromFile(((-1 * base) - 0x04000000), "DLCNukaWorld.esm")
			if !lookup
				log("Lookup Failure for [" + base + " abs(+ 0x04000000)]")
				bs_expected -= 1
				spawnMarker.Disable()
				spawnMarker.Delete()
				return
			endif
			ret = spawnMarker.PlaceAtMe(lookup,1,true)
		elseif (base < -0x02FFFFFF)
			; -0x03??????
			Form lookup = Game.GetFormFromFile(((-1 * base) - 0x03000000), "DLCCoast.esm")
			if !lookup
				log("Lookup Failure for [" + base + " abs(+ 0x03000000)]")
				bs_expected -= 1
				spawnMarker.Disable()
				spawnMarker.Delete()
				return
			endif
			ret = spawnMarker.PlaceAtMe(lookup,1,true)
		elseif (base > -0x02000000)
			; -0x01??????
			Form lookup = Game.GetFormFromFile(((-1 * base) - 0x01000000), "DLCRobot.esm")
			if !lookup
				log("Lookup Failure for [" + base + " abs(+ 0x01000000)]")
				bs_expected -= 1
				spawnMarker.Disable()
				spawnMarker.Delete()
				return
			endif
			ret = spawnMarker.PlaceAtMe(lookup,1,true)
		else
			; -0x02??????
			log("DLC object Unsupported: [" + base + " abs(+ 0x02000000)]")
			bs_expected -= 1
			spawnMarker.Disable()
			spawnMarker.Delete()
			return
		endif			
	elseif (base < -0x06FFFFFF && (addonMod != ""))
		; Custom Items provided by Prefab Addon Mod : -0x07??????
		Form lookup = Game.GetFormFromFile(((-1 * base) - 0x07000000), addonMod)
		if !lookup
			log("Lookup Failure for [" + base + " abs(+ 0x07000000)]")
			bs_expected -= 1
			spawnMarker.Disable()
			spawnMarker.Delete()
			return
		endif
		ret = spawnMarker.PlaceAtMe(lookup,1,true)
		if (addonQuest)
			ret.WaitFor3DLoad()
			ScriptObject AddonHandler = addonQuest.CastAs(addonQuestScript)
			if AddonHandler
				Var[] params = new Var[3]
				params[0] = WorkshopRef
				params[1] = base
				params[2] = ret
				AddonHandler.CallFunctionNoWait(addonQuestScriptCallback, params)
			endif
		endIf		
	endif
	ret.WaitFor3DLoad()
	stillrunning = true
	; ret.SetPosition(posx,posy,posz)
	; ret.SetAngle(anglex,angley,anglez)
	if (1.0 != scale)
		ret.SetScale(scale)
	endif
	if (ret.HasKeyword(PowerConnection) || ret.HasKeyword(CanBePowered))
		if (ret.GetValue(PowerGenerated) == 0.0 )
			; ret.AddKeyword(WorkshopStartPoweredOn)
			if (ret.GetValue(PowerRequired) > 0.0 )
				
				ret.ModValue(PowerRequired, (-1.0 * (ret.GetValue(PowerRequired))))					
				ret.SetValue(PowerGenerated, 0.01)
				ret.SetValue(ResourceObject, 1.0)
				
			elseif (ret.HasKeyword(CanBePowered))
				ret.SetValue(PowerGenerated, 0.01)
			elseif (ret.GetValue(PowerRadiation) == 0.0)
				ret.AddKeyword(CanBePowered)
			endif
			if (ret as Actor)
				(ret as Actor).SetUnconscious(false)
			endif
			
			if (2054572 == base) ; LightBox
				if (extra > -1)
					int values = extra
					ret.SetValue(LightboxCycling, (values % 2))
					values = ((values / 2) as Int)
					ret.SetValue(LightboxCyclingType, (values % 4))
					values = ((values / 4) as Int)
					ret.SetValue(TerminalLightBrightness, (values % 4))
					values = ((values / 4) as Int)
					ret.SetValue(TerminalLightColor, (values % 8))
				endif
			endif
		endIf
	else
		ret.Disable() ; Fuzzy Texture Bug Fix...
		ret.Enable()
		Utility.wait(0.03)
		stillrunning = true
	endif
	WorkshopObjectScript wow = ret as WorkShopObjectScript
	if wow
		wow.workshopID = workshopid
		wow.HandleCreation(false)
		WorkshopParent.ApplyResourceDamage(wow, ratings[WorkshopParent.WorkshopRatingFood].resourceValue, 0)
		WorkshopParent.ApplyResourceDamage(wow, ratings[WorkshopParent.WorkshopRatingWater].resourceValue,0)
		WorkshopParent.ApplyResourceDamage(wow, ratings[WorkshopParent.WorkshopRatingSafety].resourceValue,0)
		WorkshopParent.ApplyResourceDamage(wow, ratings[WorkshopParent.WorkshopRatingPower].resourceValue,0)
		WorkshopParent.AssignObjectToWorkshop(wow, WorkshopRef, true)
		wow.HandleWorkshopReset()
		stillrunning = true	
	endif					
	if (!ret.GetLinkedRef(ItemKeyword))
		ret.SetLinkedRef(WorkshopRef, ItemKeyword)
	endif
	bs_expected -= 1
	spawnMarker.Disable()
	spawnMarker.Delete()	
EndFunction

; Gets called after an inactivity timeout of 2.5 seconds...
Function builddone()
	if bs_ignore
		return
	endif
	log("builddone()")
	Actor pc = Game.GetPlayer()
	if power_up
		log("power_up true")
		ObjectReference pucenter
		float puradius
		bool clearCenter = false
		
		if center
			pucenter = center
			puradius = radius
			clearCenter = true
		else
			Keyword WorkshopLinkCenter = Game.GetForm(0x00038C0B) as Keyword
			pucenter = WorkshopRef.GetLinkedRef(WorkshopLinkCenter)
			if !pucenter
				pucenter = WorkshopRef as ObjectReference
			endif
			puradius = 8000
		endif
		
		ObjectReference[] results
		ObjectReference result
		int results_len
		int r = 0
		int formid
		
		FormList TweakPowerUpTargets = Game.GetFormFromFile(0x01019F61,"AmazingFollowerTweaks.esp") as FormList

		if (None == TweakPowerUpTargets || power_up_all)
		
			log("power_up_all phase 1 : Searching for 'PowerConnection'")
		
			results = pucenter.FindAllReferencesWithKeyword(PowerConnection, puradius)
			results_len = results.length
			
			log("found [" + results_len + "] items")
			r = 0

			while (r < results_len)
			
				result = results[r]
				formid = result.GetBaseObject().GetFormID()
				
				if formid == 0x00239530 || formid == 0x0011E2C5 || formid == 0x00058837 || formid == 0x00030386
					if power_up_gen
						log("PoweringUp Generator [" + r + "] [" + result.GetBaseObject() + "] [" + formid + "]")				
						result.PlayAnimation("Reset")
						Utility.wait(0.01)
						result.PlayAnimation("Powered")			
						Utility.wait(0.01)
						result.Disable()
						result.Enable()
						Utility.wait(0.03)						
					endif
				elseif formid == 0x00138BF6
					log("PoweringUp Pylon [" + r + "] [" + result.GetBaseObject() + "] [" + formid + "]")				
					result.PlayAnimation("Reset")
					Utility.wait(0.01)
					result.PlayAnimation("Powered")			
					Utility.wait(0.01)
					result.Disable()
					result.Enable()
					Utility.wait(0.03)						
				elseif formid == 0x0017A62B
					log("Handle Castle Radio")
					; Castle Radio Transmitter. Skip for now...
					if (result.GetValue(PowerGenerated) == 0.0 )
						if (result.GetValue(PowerRequired) > 0.0 )
							result.ModValue(PowerRequired, (-1.0 * (result.GetValue(PowerRequired))))					
							result.SetValue(PowerGenerated, 0.01)
							result.SetValue(ResourceObject, 1.0)						
						endif
					endIf
				else
					log("PoweringUp [" + formid + "]")
					result.PlayAnimation("Reset")
					result.PlayAnimation("Powered")			
					result.Disable()
					result.Enable()
					
					; Handle Colored Lights
					if (2054572 == 	formid)
						WorkshopLightBoxScript wlb = result as WorkshopLightBoxScript
						if (wlb)
							wlb.SetColor((result.GetValue(TerminalLightColor) as int), (result.GetValue(TerminalLightBrightness) as int))
						endif
					endif
				endif				
				r += 1
			endWhile
		
			log("phase 2 : Searching for 'CanBePowered'")
			results = pucenter.FindAllReferencesWithKeyword(CanBePowered, puradius)
			results_len = results.length
			
			log("found [" + results_len + "] items")
			r = 0
			while (r < results_len)
				result = results[r]		
				if !(result.HasKeyword(PowerConnection))
					formid = result.GetBaseObject().GetFormID()
					if formid == 0x00138BF6
						; Pylon. Skip for now...
						log("PoweringUp Pylon [" + r + "] [" + result.GetBaseObject() + "] [" + formid + "]")				
						result.PlayAnimation("Reset")
						Utility.wait(0.01)
						result.PlayAnimation("Powered")			
						Utility.wait(0.01)
						result.Disable()
						result.Enable()
						Utility.wait(0.03)						
					elseif formid == 0x0017A62B
						log("Handle Castle Radio")
						; Castle Radio Transmitter. Skip for now...
						if (result.GetValue(PowerGenerated) == 0.0 )
							if (result.GetValue(PowerRequired) > 0.0 )
								result.ModValue(PowerRequired, (-1.0 * (result.GetValue(PowerRequired))))					
								result.SetValue(PowerGenerated, 0.01)
								result.SetValue(ResourceObject, 1.0)						
							endif
						endIf
						log("Handle Castle Complete")
					else
						log("PoweringUp [" + r + "] [" + result.GetBaseObject() + "] [" + formid + "]")				
						result.PlayAnimation("Reset")
						result.PlayAnimation("Powered")			
						result.Disable()
						result.Enable()
					endif
				endif
				r += 1
			endWhile
			
		else
		
			results = pucenter.FindAllReferencesOfType(TweakPowerUpTargets, puradius)	
			results_len = results.length
			log("found [" + results_len + "] items")
			
			; Method gets optimized out when building Release....
			diagnostics(results, pucenter)
						
			r = 0
			while (r < results_len)
			
				result = results[r]
				formid = result.GetBaseObject().GetFormID()
				
				if formid == 0x00239530 || formid == 0x0011E2C5 || formid == 0x00058837 || formid == 0x00030386
					if power_up_gen
						log("PoweringUp Generator [" + r + "] [" + result.GetBaseObject() + "] [" + formid + "]")				
						result.PlayAnimation("Reset")
						Utility.wait(0.01)
						result.PlayAnimation("Powered")			
						Utility.wait(0.01)
						result.Disable()
						result.Enable()
						Utility.wait(0.03)						
					endif
				elseif formid == 0x00138BF6
					log("PoweringUp Pylon [" + r + "] [" + result.GetBaseObject() + "] [" + formid + "]")				
					result.PlayAnimation("Reset")
					Utility.wait(0.01)
					result.PlayAnimation("Powered")			
					Utility.wait(0.01)
					result.Disable()
					result.Enable()
					Utility.wait(0.03)						
				elseif formid == 0x0017A62B
					log("Handle Castle Radio")
					if (result.GetValue(PowerGenerated) == 0.0 )
						if (result.GetValue(PowerRequired) > 0.0 )
							result.ModValue(PowerRequired, (-1.0 * (result.GetValue(PowerRequired))))					
							result.SetValue(PowerGenerated, 0.01)
							result.SetValue(ResourceObject, 1.0)						
						endif
					endIf
				else
					log("PoweringUp [" + r + "] [" + result.GetBaseObject() + "] [" + formid + "]")				
					result.PlayAnimation("Reset")
					result.PlayAnimation("Powered")			
					result.Disable()
					result.Enable()
					
					; Handle Colored Lights
					if (2054572 == 	formid)
						WorkshopLightBoxScript wlb = result as WorkshopLightBoxScript
						if (wlb)
							wlb.SetColor((result.GetValue(TerminalLightColor) as int), (result.GetValue(TerminalLightBrightness) as int))
						endif
					endif						
				endif
			
				r += 1
			endWhile
		endIf
		log("power_up complete")
		if clearCenter
			center = None
			radius = 0.0
		endif
	else
		log("power_up false")
	endif
	
	log("Updating Resources")
	WorkshopParent.SetResourceData(ratings[WorkshopParent.WorkshopRatingDamageFood].resourceValue, WorkshopRef, 0)
	WorkshopParent.SetResourceData(ratings[WorkshopParent.WorkshopRatingDamageWater].resourceValue, WorkshopRef, 0)
	WorkshopParent.SetResourceData(ratings[WorkshopParent.WorkshopRatingDamageSafety].resourceValue, WorkshopRef, 0)
	WorkshopParent.SetResourceData(ratings[WorkshopParent.WorkshopRatingDamagePower].resourceValue, WorkshopRef, 0)
	WorkshopParent.TryToAssignBeds(WorkshopRef)
	WorkshopParent.TryToAssignResourceType(WorkshopRef, ratings[WorkshopParent.WorkshopRatingFood].resourceValue)
	WorkshopParent.TryToAssignResourceType(WorkshopRef, ratings[WorkshopParent.WorkshopRatingSafety].resourceValue)
	WorkshopRef.RecalculateWorkshopResources()
	bs_expected = 0
	
	log("Adding Items for Workshop_co_RadioBeacon")
	; Add Items for Workshop_co_RadioBeacon
	WorkshopRef.AddItem(Game.GetForm(0x000AEC5E),3,true)
	WorkshopRef.AddItem(Game.GetForm(0x0006907B),2,true)
	WorkshopRef.AddItem(Game.GetForm(0x0006907C),10,true)
	WorkshopRef.AddItem(Game.GetForm(0x0006907D),2,true)
	WorkshopRef.AddItem(Game.GetForm(0x00106D98),1,true)
	WorkshopRef.AddItem(Game.GetForm(0x000731A4),10,true)
	; spawnMarker.Disable()
	; spawnMarker.Delete()	
	DoneMsg.Show()			
EndFunction

Function diagnostics(ObjectReference[] results, ObjectReference p_center) debugOnly
	int r = 0
	while (r < results.length)
		log("Item [" + r + "] = [" + results[r].GetBaseObject() + "] [" + results[r].GetBaseObject().GetFormID() + "] d[" + p_center.GetDistance(results[r]) + "] 3D[" + results[r].Is3DLoaded() + "]")
		r += 1
	endWhile
EndFunction


; To Use:
;
; > player.APS TweakBuilderScript
; > player.cf "TweakBuilderScript.replicate" ff######  100 -90
;
; AngleOffset:
;    0     = Object's front
;  -90     = Object's left 
;   90     = Object's right 
; 180/-180 = Object's back
Function replicate(ObjectReference n, Float p_radius = 500.0, Float angleOffset = 0.0)
    log("replicate(" + n.GetBaseObject().GetFormID() + "," + p_radius + "," + angleOffset + ")")
    log("  height : [" + n.GetHeight() + "] width : [" + n.GetWidth() + "] length : [" + n.GetLength() + "]")	
    ObjectReference replica = n.placeatme(n.GetBaseObject(),1,true)
	Utility.wait(0.05)
	replica.WaitFor3DLoad()
	float azimuth = ConvertToSinCosCompatibleAngle(n.GetAngleZ(), angleOffset)
	Float xoffset = p_radius * Math.cos(azimuth)
	Float yoffset = p_radius * Math.sin(azimuth)
	replica.SetPosition(n.GetPositionX() + xoffset, n.GetPositionY() + yoffset, n.GetPositionZ())
	replica.Disable() ; Fuzzy Texture Bug Fix...
	replica.Enable()
endFunction

Float Function ConvertToSinCosCompatibleAngle(Float original, Float angleOffset = 0.0)
	; See TweakFollowerScript for explanation	
	return Enforce360Bounds(450 - original + angleOffset)
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
