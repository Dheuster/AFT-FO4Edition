Scriptname AFT:TweakDiagnostics extends Quest Const

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "diagnostics"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, asTextToPrint, aiSeverity)
EndFunction

Function RunDiagnostics(Actor npc = None)
	RunDiagnosticsHelper(npc)
EndFunction

Function RunDiagnosticsHelper(Actor npc = None) debugOnly
	string logName = "diagnostics"
	debug.OpenUserLog(logName)
	
	if npc
	
		debug.TraceUser(logName, "Processing NPC [0x" + tohex(npc.GetActorBase().GetFormID()) + "]\n\n", 0)
		; Scan Factions:
		debug.TraceUser(logName, "FACTIONS:\n", 0)
		
		if npc.IsInFaction(Game.GetFormFromFile(0x01065CA4,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakAllowFriendlyFire\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakAllowFriendlyFire\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x0101AE9A,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakAutoStanceFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakAutoStanceFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01010E6D,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakBoomstickFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakBoomstickFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01010E6E,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakBruiserFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakBruiserFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x0103C8C9,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakCampHomeFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakCampHomeFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01035657,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakCampOutFitFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakCampOutFitFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01035658,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakCityOutFitFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakCityOutFitFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01035656,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakCombatOutFitFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakCombatOutFitFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01010E6F,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakCommandoFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakCommandoFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01041598,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakConvNegToPos\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakConvNegToPos\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01041599,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakConvPosToNeg\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakConvPosToNeg\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x0101BB22,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakCrimeFaction_Ignored\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakCrimeFaction_Ignored\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01010E83,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakEnhancedFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakEnhancedFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01025B22,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakEnterPAFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakEnterPAFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x0101BB23,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakEssentialFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakEssentialFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01000F9B,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakFollowerFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakFollowerFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01010E70,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakGunslingerFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakGunslingerFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01013451,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakHangoutFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakHangoutFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x0101FAAE,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakHomeOutFitFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakHomeOutFitFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01068A47,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakIgnoredFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakIgnoredFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x0101F312,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakManagedOutfitFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakManagedOutfitFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01002E16,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakNamesFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakNamesFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01010E71,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakNinjaFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakNinjaFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01041592,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakNoApprove\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakNoApprove\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01041596,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakNoCommentActivator\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakNoCommentActivator\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01041594,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakNoCommentApprove\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakNoCommentApprove\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01041595,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakNoCommentDisapprove\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakNoCommentDisapprove\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01041593,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakNoCommentGeneral\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakNoCommentGeneral\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x0103FEBC,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakNoDisapprove\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakNoDisapprove\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x0103EF6E,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakNoHomeFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakNoHomeFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x0104FB5C,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakNoIdleChatter\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakNoIdleChatter\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x0103F70B,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakNoCasFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakNoCasFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x0103FEBE,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakNoRelaxFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakNoRelaxFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x0106550A,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakPackMuleFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakPackMuleFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x0103FEBA,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakPAHelmetCombatToggleFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakPAHelmetCombatToggleFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x0101FF8F,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakPosedFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakPosedFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x0101AEC5,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakRangedFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakRangedFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x0106643E,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakReadyWeaponFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakReadyWeaponFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x0100C1FB,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakRotateLockFollowerFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakRotateLockFollowerFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x0105AD9A,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakSkipGoHomeFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakSkipGoHomeFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x01010E72,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakSniperFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakSniperFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x0103658C,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakStandardOutfitFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakStandardOutfitFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x010106DC,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakSwimOutfitFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakSwimOutfitFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x0103FEBD,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakSyncPAFaction\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakSyncPAFaction\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x010124F4,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakTrackKills\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakTrackKills\n", 0)
		endif
		if npc.IsInFaction(Game.GetFormFromFile(0x010124F4,"AmazingFollowerTweaks.esp") as Faction)
			debug.TraceUser(logName, "  [X] TweakTrackKills\n\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakTrackKills\n\n", 0)
		endif
		
		; Scan Keywords:
		debug.TraceUser(logName, "KEYWORDS:\n", 0)
		
		if npc.HasKeyword(Game.GetFormFromFile(0x010502F9,"AmazingFollowerTweaks.esp") as Keyword)
			debug.TraceUser(logName, "  [X] TweakActorTypeManaged\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakActorTypeManaged\n", 0)
		endif
		if npc.HasKeyword(Game.GetFormFromFile(0x0101FF90,"AmazingFollowerTweaks.esp") as Keyword)
			debug.TraceUser(logName, "  [X] TweakPoseTarget\n\n", 0)
		else
			debug.TraceUser(logName, "  [ ] TweakPoseTarget\n\n", 0)
		endif
		
		; Scan ActorValues:
		; Scan Keywords:
		debug.TraceUser(logName, "ACTOR VALUES:\n", 0)

		float ac = npc.GetValue(Game.GetFormFromFile(0x010502F9,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakAvailable [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01003E19,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakInPowerArmor [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0101068B,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakLastHitBy [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0106997B,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakOriginalRace [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01046204,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayNRA1 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01046205,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayNRA2 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01046206,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayNRA3 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01046207,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayNRA4 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0104620B,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayNRB1 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0104620C,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayNRB2 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0104620D,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayNRB3 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0104620E,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayNRB4 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01046212,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayNRC1 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01046213,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayNRC2 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01046214,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayNRC3 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01046215,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayNRC4 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01046219,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayNRD1 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0104621A,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayNRD2 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0104621B,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayNRD3 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0104621C,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayNRD4 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01046201,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayPCA1 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01046202,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayPCA2 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01046203,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayPCA3 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01046208,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayPCB1 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01046209,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayPCB2 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0104620A,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayPCB3 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0104620F,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayPCC1 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01046210,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayPCC2 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01046211,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayPCC3 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01046216,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayPCD1 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01046217,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayPCD2 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01046218,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakSayPCD3 [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01015FC8,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakScale [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0100FCDA,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakTopicAck [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01066BD8,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakTopicAckModID [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0100FCD9,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakTopicCancel [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01066BD9,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakTopicCancelModID [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0100FCD8,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakTopicDismiss [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01066BDA,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakTopicDismissModID [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0100FCD7,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakTopicDistFar [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01066BDB,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakTopicDistFarModID [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0100FCDB,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakTopicDistMed [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01066BDC,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakTopicDistMedModID [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0100FCD6,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakTopicDistNear [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01066BDD,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakTopicDistNearModID [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0100FCD5,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakTopicHello [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01066BDE,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakTopicHelloModID [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0100FCD4,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakTopicStyleAgg [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01066BDF,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakTopicStyleAggModID [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0100FCD3,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakTopicStyleDef [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01066BE0,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakTopicStyleDefModID [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x0100FCD2,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakTopicTrade [" + ac + "]\n", 0)
		ac = npc.GetValue(Game.GetFormFromFile(0x01066BE1,"AmazingFollowerTweaks.esp") as ActorValue)
		debug.TraceUser(logName, "  TweakTopicTradeModID [" + ac + "]\n\n", 0)
	
		; Scene
		debug.TraceUser(logName, "SCENE:\n", 0)
		if None == npc.GetCurrentScene()
			debug.TraceUser(logName, "  [None]\n\n", 0)
		else
			debug.TraceUser(logName, "  [" + npc.GetCurrentScene() + "]\n\n", 0)
		endif

		debug.TraceUser(logName, "LOCATION:\n", 0)
		if None == npc.GetCurrentLocation()
			debug.TraceUser(logName, "  [None]\n\n", 0)
		else
			debug.TraceUser(logName, "  [" + npc.GetCurrentLocation() + "]\n\n", 0)
		endif
		
		; Scan AI
		debug.TraceUser(logName, "AI:\n", 0)
		Package currentAIPackage = npc.GetCurrentPackage()
		int formid = 0
		if currentAIPackage
			formid = currentAIPackage.GetFormID() As int
		endif
		string packinfo = "  Package [0x" + tohex(formid) + "] ["
		
		if currentAIPackage == Game.GetFormFromFile(0x01013452,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakWorkshopActive"
		elseif currentAIPackage == Game.GetFormFromFile(0x0104A6CC,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakWait3Seconds"
		elseif currentAIPackage == Game.GetFormFromFile(0x0101C56C,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakVertibirdOnlyTwo"
		elseif currentAIPackage == Game.GetFormFromFile(0x0101902B,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakVertibirdNoRobot"
		elseif currentAIPackage == Game.GetFormFromFile(0x0103F70A,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakStayHere"
		elseif currentAIPackage == Game.GetFormFromFile(0x01048FF1,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakSpouseSit"
		elseif currentAIPackage == Game.GetFormFromFile(0x01010E7F,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakSniperCombatInterior"
		elseif currentAIPackage == Game.GetFormFromFile(0x01010E78,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakSniperCombatExterior"
		elseif currentAIPackage == Game.GetFormFromFile(0x0100D103,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakSitCouch"
		elseif currentAIPackage == Game.GetFormFromFile(0x01015FC7,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakSculptStandStill"
		elseif currentAIPackage == Game.GetFormFromFile(0x0101FF8E,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakPose"
		elseif currentAIPackage == Game.GetFormFromFile(0x01010E7E,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakNinjaCombatInterior"
		elseif currentAIPackage == Game.GetFormFromFile(0x01010E79,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakNinjaCombatExterior"
		elseif currentAIPackage == Game.GetFormFromFile(0x01013450,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakHangout"
		elseif currentAIPackage == Game.GetFormFromFile(0x01010E7D,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakGunslingerCombatInterior"
		elseif currentAIPackage == Game.GetFormFromFile(0x01010E76,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakGunslingerCombatExterior"
		elseif currentAIPackage == Game.GetFormFromFile(0x0103F708,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakGoHome"
		elseif currentAIPackage == Game.GetFormFromFile(0x0103F709,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakGoCamp"
		elseif currentAIPackage == Game.GetFormFromFile(0x0100D104,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakForceGreetFromCouch"
		elseif currentAIPackage == Game.GetFormFromFile(0x0104FB5F,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakFollowersPowerArmorPackageNoIdle"
		elseif currentAIPackage == Game.GetFormFromFile(0x0104BE28,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakFollowersPackagePowerArmorNoSandbox"
		elseif currentAIPackage == Game.GetFormFromFile(0x0104BE27,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakFollowersDismountVertibird_IgnoreCombat"
		elseif currentAIPackage == Game.GetFormFromFile(0x0104FB5E,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakFollowersNoLoiterPackageNoIdle"
		elseif currentAIPackage == Game.GetFormFromFile(0x01049F29,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakFollowersNoLoiterPackage"
		elseif currentAIPackage == Game.GetFormFromFile(0x01049F27,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakFollowersForcegreetPackage"
		elseif currentAIPackage == Game.GetFormFromFile(0x0104FB5B,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakFollowersCompanionPackageNoIdle"
		elseif currentAIPackage == Game.GetFormFromFile(0x01049F28,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakFollowersCompanionPackage"
		elseif currentAIPackage == Game.GetFormFromFile(0x0104CD7E,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakFacePlayer"
		elseif currentAIPackage == Game.GetFormFromFile(0x01025B23,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakEnterPA"
		elseif currentAIPackage == Game.GetFormFromFile(0x01010E87,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakEnhancedMedCombatInterior"
		elseif currentAIPackage == Game.GetFormFromFile(0x01010E84,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakEnhancedMedCombatExterior"
		elseif currentAIPackage == Game.GetFormFromFile(0x01010E88,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakEnhancedFarCombatInterior"
		elseif currentAIPackage == Game.GetFormFromFile(0x01010E85,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakEnhancedFarCombatExterior"
		elseif currentAIPackage == Game.GetFormFromFile(0x01010E86,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakEnhancedCloseCombatInterior"
		elseif currentAIPackage == Game.GetFormFromFile(0x01010E77,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakEnhancedCloseCombatExterior"
		elseif currentAIPackage == Game.GetFormFromFile(0x01010E88,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakDogCombatPackage"
		elseif currentAIPackage == Game.GetFormFromFile(0x01043BAB,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakCOMSpouseNonFollowerSandbox"
		elseif currentAIPackage == Game.GetFormFromFile(0x01010E7C,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakCommandoCombatInterior"
		elseif currentAIPackage == Game.GetFormFromFile(0x01010E75,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakCommandoCombatExterior"
		elseif currentAIPackage == Game.GetFormFromFile(0x01048841,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakCOMCurieToSpouse"
		elseif currentAIPackage == Game.GetFormFromFile(0x01012A74,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakChoiceStandStill"
		elseif currentAIPackage == Game.GetFormFromFile(0x01010E7B,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakBruiserCombatInterior"
		elseif currentAIPackage == Game.GetFormFromFile(0x01010E74,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakBruiserCombatExterior"
		elseif currentAIPackage == Game.GetFormFromFile(0x01010E7A,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakBoomstickCombatInterior"
		elseif currentAIPackage == Game.GetFormFromFile(0x01010E73,"AmazingFollowerTweaks.esp") as Package
			packinfo += "TweakBoomstickCombatExterior"
		else
			packinfo += "Not Tweak Based"
		endif
		
		packinfo += "]\n\n"
		debug.TraceUser(logName, packinfo, 0)
		
	endif
	
	debug.TraceUser(logName, "SUPPORT QUESTS:\n", 0)	
	debug.TraceUser(logName, "  TweakMonitorPlayer\n", 0)	
	Quest TweakMonitorPlayer   = Game.GetFormFromFile(0x01000F99,"AmazingFollowerTweaks.esp") as Quest
	if TweakMonitorPlayer
		AFT:TweakMonitorPlayerScript pTweakMonitorPlayerScript = TweakMonitorPlayer as AFT:TweakMonitorPlayerScript
		if pTweakMonitorPlayerScript
			debug.TraceUser(logName, "    IsRunning()      : " + pTweakMonitorPlayerScript.IsRunning()             + "\n", 0)
			debug.TraceUser(logName, "    version          : " + pTweakMonitorPlayerScript.version                 + "\n", 0)
			debug.TraceUser(logName, "    IsInDialogue     : " + pTweakMonitorPlayerScript.IsInDialogue            + "\n", 0)
			debug.TraceUser(logName, "    RelayEvent       : " + pTweakMonitorPlayerScript.RelayEvent              + "\n", 0)
			debug.TraceUser(logName, "    Initialized      : " + pTweakMonitorPlayerScript.Initialized             + "\n", 0)
			debug.TraceUser(logName, "    SentFirstLoaded  : " + pTweakMonitorPlayerScript.SentFirstLoaded         + "\n", 0)
		else
			debug.TraceUser(logName, "    Script Casting Error\n", 0)		
		endif	
	else
		debug.TraceUser(logName, "    Resource Loading Error\n", 0)
	endif
	
	debug.TraceUser(logName, "\n", 0)		
	debug.TraceUser(logName, "  TweakPipBoy\n", 0)	
	Quest TweakPipBoy          = Game.GetFormFromFile(0x01002E07,"AmazingFollowerTweaks.esp") as Quest
	if TweakPipBoy
		AFT:TweakPipBoyScript pTweakPipBoyScript = TweakPipBoy as AFT:TweakPipBoyScript
		if pTweakPipBoyScript
			debug.TraceUser(logName, "    IsRunning()             : " + pTweakPipBoyScript.IsRunning()             + "\n", 0)
			debug.TraceUser(logName, "    PlayerIsFirstPerson     : " + pTweakPipBoyScript.PlayerIsFirstPerson     + "\n", 0)
			debug.TraceUser(logName, "    ActivateOnNameSelect    : " + pTweakPipBoyScript.ActivateOnNameSelect    + "\n", 0)
			debug.TraceUser(logName, "    DoOnTerminalClose       : " + pTweakPipBoyScript.DoOnTerminalClose       + "\n", 0)
			debug.TraceUser(logName, "    pSculptLeveledHintShown : " + pTweakPipBoyScript.pSculptLeveledHintShown + "\n", 0)
			debug.TraceUser(logName, "    pRaceInvFixHintShow     : " + pTweakPipBoyScript.pRaceInvFixHintShow     + "\n", 0)
			debug.TraceUser(logName, "    pAppearanceHintShown    : " + pTweakPipBoyScript.pAppearanceHintShown    + "\n", 0)
		else
			debug.TraceUser(logName, "    Script Casting Error\n", 0)		
		endif	
	else
		debug.TraceUser(logName, "    Resource Loading Error\n", 0)
	endif
		
	debug.TraceUser(logName, "\n", 0)		
	debug.TraceUser(logName, "  TweakExpandCamp\n", 0)	
	Quest TweakExpandCamp        = Game.GetFormFromFile(0x01026A8B,"AmazingFollowerTweaks.esp") as Quest
	if TweakExpandCamp
		debug.TraceUser(logName, "    IsRunning()             : " + TweakExpandCamp.IsRunning()             + "\n", 0)
	else
		debug.TraceUser(logName, "    Resource Loading Error\n", 0)
	endif
	
	debug.TraceUser(logName, "\n", 0)		
	debug.TraceUser(logName, "  TweakDismiss\n", 0)	
	Quest TweakDismiss         = Game.GetFormFromFile(0x0103EF6C,"AmazingFollowerTweaks.esp") as Quest
	if TweakDismiss
		AFT:TweakDismissScript pTweakDismissScript = TweakDismiss as AFT:TweakDismissScript
		if pTweakDismissScript
			debug.TraceUser(logName, "    IsRunning()             : " + pTweakDismissScript.IsRunning()             + "\n", 0)
		else
			debug.TraceUser(logName, "    Script Casting Error\n", 0)		
		endif	
	else
		debug.TraceUser(logName, "    Resource Loading Error\n", 0)
	endif
	
	debug.TraceUser(logName, "\n", 0)		
	debug.TraceUser(logName, "  TweakLocator\n", 0)	
	Quest TweakLocator         = Game.GetFormFromFile(0x010383FA,"AmazingFollowerTweaks.esp") as Quest
	if TweakLocator
		debug.TraceUser(logName, "    IsRunning()             : " + TweakLocator.IsRunning()             + "\n", 0)
	else
		debug.TraceUser(logName, "    Resource Loading Error\n", 0)
	endif

	debug.TraceUser(logName, "\n", 0)		
	debug.TraceUser(logName, "  TweakMemoryLounger\n", 0)	
	Quest TweakMemoryLounger   = Game.GetFormFromFile(0x0102F371,"AmazingFollowerTweaks.esp") as Quest
	if TweakMemoryLounger
		AFT:TweakMemoryLoungerScript pTweakMemoryLoungerScript = TweakMemoryLounger as AFT:TweakMemoryLoungerScript
		if pTweakMemoryLoungerScript
			debug.TraceUser(logName, "    IsRunning()             : " + pTweakMemoryLoungerScript.IsRunning()             + "\n", 0)
		else
			debug.TraceUser(logName, "    Script Casting Error\n", 0)		
		endif	
	else
		debug.TraceUser(logName, "    Resource Loading Error\n", 0)
	endif

	debug.TraceUser(logName, "\n", 0)		
	debug.TraceUser(logName, "  TweakNames\n", 0)	
	Quest TweakNames           = Game.GetFormFromFile(0x010035B1,"AmazingFollowerTweaks.esp") as Quest
	if TweakNames
		AFT:TweakNamesScript pTweakNamesScript = TweakNames as AFT:TweakNamesScript
		if pTweakNamesScript
			debug.TraceUser(logName, "    IsRunning()             : " + pTweakNamesScript.IsRunning()             + "\n", 0)
		else
			debug.TraceUser(logName, "    Script Casting Error\n", 0)		
		endif	
	else
		debug.TraceUser(logName, "    Resource Loading Error\n", 0)
	endif
	
	debug.TraceUser(logName, "\n", 0)		
	debug.TraceUser(logName, "  TweakSalvageUFO\n", 0)	
	Quest TweakSalvageUFO      = Game.GetFormFromFile(0x010279BE,"AmazingFollowerTweaks.esp") as Quest
	if TweakSalvageUFO
		debug.TraceUser(logName, "    IsRunning()             : " + TweakSalvageUFO.IsRunning()             + "\n", 0)
	else
		debug.TraceUser(logName, "    Resource Loading Error\n", 0)
	endif
	
	debug.TraceUser(logName, "\n", 0)		
	debug.TraceUser(logName, "  TweakScrapScanMaster\n", 0)	
	Quest TweakScrapScanMaster = Game.GetFormFromFile(0x0100919A,"AmazingFollowerTweaks.esp") as Quest
	if TweakScrapScanMaster
		AFT:TweakScrapScanScript pTweakScrapScanScript = TweakScrapScanMaster as AFT:TweakScrapScanScript
		if pTweakScrapScanScript
			debug.TraceUser(logName, "    IsRunning()             : " + pTweakScrapScanScript.IsRunning()             + "\n", 0)
		else
			debug.TraceUser(logName, "    Script Casting Error\n", 0)		
		endif	
	else
		debug.TraceUser(logName, "    Resource Loading Error\n", 0)
	endif
	
	debug.TraceUser(logName, "\n", 0)
	debug.TraceUser(logName, "  TweakSettlmentLoader\n", 0)	
	Quest TweakSettlmentLoader = Game.GetFormFromFile(0x0105F22F,"AmazingFollowerTweaks.esp") as Quest
	if TweakSettlmentLoader
		TweakRegisterPrefabScript pTweakRegisterPrefabScript = TweakSettlmentLoader as TweakRegisterPrefabScript
		if pTweakRegisterPrefabScript
			debug.TraceUser(logName, "    IsRunning()             : " + pTweakRegisterPrefabScript.IsRunning()             + "\n", 0)
		else
			debug.TraceUser(logName, "    Script Casting Error\n", 0)		
		endif	
	else
		debug.TraceUser(logName, "    Resource Loading Error\n", 0)
	endif

	debug.TraceUser(logName, "\n", 0)
	debug.TraceUser(logName, "  TweakVisualChoice\n", 0)	
	Quest TweakVisualChoice    = Game.GetFormFromFile(0x01012A72,"AmazingFollowerTweaks.esp") as Quest
	if TweakVisualChoice
		AFT:TweakVisualChoiceScript pTweakVisualChoiceScript = TweakVisualChoice as AFT:TweakVisualChoiceScript
		if pTweakVisualChoiceScript
			debug.TraceUser(logName, "    IsRunning()             : " + pTweakVisualChoiceScript.IsRunning()             + "\n", 0)
		else
			debug.TraceUser(logName, "    Script Casting Error\n", 0)		
		endif	
	else
		debug.TraceUser(logName, "    Resource Loading Error\n", 0)
	endif

	debug.TraceUser(logName, "\n", 0)	
	debug.TraceUser(logName, "TWEAKFOLLOWER:\n", 0)
	
	Quest TweakFollower        = Game.GetFormFromFile(0x01000F9A,"AmazingFollowerTweaks.esp") as Quest
	if TweakFollower
		AFT:TweakFollowerScript pTweakFollowerScript = TweakFollower as AFT:TweakFollowerScript
		if pTweakFollowerScript
			debug.TraceUser(logName, "    IsRunning() : " + pTweakFollowerScript.IsRunning() + "\n", 0)
			debug.TraceUser(logName, "    version  : " + pTweakFollowerScript.version + "\n", 0)
			debug.TraceUser(logName, "    pfCount  : " + pTweakFollowerScript.pfCount + "\n", 0)
			debug.TraceUser(logName, "    pCharGenCacheEnabled  : " + pTweakFollowerScript.pCharGenCacheEnabled + "\n", 0)
			debug.TraceUser(logName, "    combatRunningFlag  : " + pTweakFollowerScript.combatRunningFlag + "\n", 0)
			debug.TraceUser(logName, "    instituteSummonMsgOnce  : " + pTweakFollowerScript.instituteSummonMsgOnce + "\n", 0)
			debug.TraceUser(logName, "    Managed Map Size : " + pTweakFollowerScript.pManagedMap.length + "\n", 0)
			int buffsize = pTweakFollowerScript.pFollowerMap.length
			debug.TraceUser(logName, "    Follower Buffer  : " + buffsize + "\n", 0)
			int i = 0
			while i < buffsize
				ReferenceAlias theAlias = pTweakFollowerScript.pFollowerMap[i]
				if theAlias
					Actor theActor = theAlias.GetActorReference()
					if theActor
						debug.TraceUser(logName, "    [" + i + "] Occupied by [0x" + tohex(theActor.GetActorBase().GetFormID()) + "]\n", 0)
					else
						debug.TraceUser(logName, "    [" + i + "] Empty\n", 0)
					endif
				else
					debug.TraceUser(logName, "    [" + i + "] No Ref\n", 0)
				endif	
				i += 1
			endwhile				
		else
			debug.TraceUser(logName, "    Script Casting Error\n", 0)		
		endif	
	else
		debug.TraceUser(logName, "    Resource Loading Error\n", 0)
	endif
	
	debug.TraceUser(logName, "\n", 0)	
	debug.TraceUser(logName, "Followers:\n", 0)	
	Quest Followers        = Game.GetForm(0x000289E4) as Quest
	if Followers
		FollowersScript pFollowersScript = Followers as FollowersScript
		if pFollowersScript
			debug.TraceUser(logName, "    IsRunning() : " + pFollowersScript.IsRunning() + "\n", 0)
			debug.TraceUser(logName, "    State  : " + pFollowersScript.GetState() + "\n", 0)
			debug.TraceUser(logName, "    isPlayerLoitering  : " + pFollowersScript.isPlayerLoitering + "\n", 0)
		else
			debug.TraceUser(logName, "    Script Casting Error\n", 0)		
		endif	
	else
		debug.TraceUser(logName, "    Resource Loading Error\n", 0)
	endif	
	
EndFunction

String Function tohex(int value)
	string ret = ""
	int remainder   = 0
	while (value > 15)
		remainder  = value % 16
		value = ((value / 16) as Int)
		if (remainder < 10)
			ret = remainder + ret
		elseif (10 == remainder)
			ret = "A" + ret
		elseif (11 == remainder)
			ret = "B" + ret
		elseif (12 == remainder)
			ret = "C" + ret
		elseif (13 == remainder)
			ret = "D" + ret
		elseif (14 == remainder)
			ret = "E" + ret
		elseif (15 == remainder)
			ret = "F" + ret
		endif
	endWhile							
	if (value < 10)
		ret = value + ret
	elseif (10 == value)
		ret = "A" + ret
	elseif (11 == value)
		ret = "B" + ret
	elseif (12 == value)
		ret = "C" + ret
	elseif (13 == value)
		ret = "D" + ret
	elseif (14 == value)
		ret = "E" + ret
	elseif (15 == value)
		ret = "F" + ret
	endif
	return ret
endFunction
