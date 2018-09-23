Scriptname AFT:TweakTargetRelayScript extends activemagiceffect
; Magic -> Magic Effect -> TweakTargetRelay -> Script

Quest    Property pTweakPipBoy      Auto Const
SPELL    Property pTweakManageNPC   Auto Const
Potion   Property pTweakActivateAFT	Auto Const

Event OnEffectStart(Actor akTarget, Actor akCaster)
	TweakPipBoyScript pTweakPipBoyScript =  (pTweakPipBoy as TweakPipBoyScript)
	if (pTweakPipBoyScript)
		pTweakPipBoyScript.TerminalTarget = None
		
		float delay = 0.1

		if (Utility.IsInMenuMode())
			delay = 0.8
		endif
		
		; BUG FIX 1.01 :
		; When the PipBoy is already up and one attempts to ShowOnPipBoy(), 
		; it brings up an empty pipboy with no easy way to exit. You have to 
		; to make sure the previous PipBoy has enough time to finish lowering.
		; cleanup. So 0.1 is fine when used as a favorite, but is too fast 
		; when the pipboy is already up (used as a consumable)

		
		Utility.wait(0.01)
		pTweakManageNPC.cast(Game.GetPlayer(), None)
		Utility.wait(delay)
		if (Utility.IsInMenuMode())
			Utility.wait(0.5)
		endif
		
		pTweakPipBoyScript.ActivateAFT()
	else
		Actor pc = Game.GetPlayer()
		if (pc.GetItemCount(pTweakActivateAFT) <= 0)
			pc.AddItem( pTweakActivateAFT,1,true)
		endIf		
	endif
endEvent
	


