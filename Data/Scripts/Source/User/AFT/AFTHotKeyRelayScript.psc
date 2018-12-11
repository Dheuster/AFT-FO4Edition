Scriptname AFT:AFTHotKeyRelayScript extends activemagiceffect

Quest    Property pTweakPipBoy      Auto Const
Int		 Property pHotKey			Auto
Potion   Property pReplacement		Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	TweakPipBoyScript pTweakPipBoyScript =  (pTweakPipBoy as TweakPipBoyScript)
	if (pTweakPipBoyScript)
		Actor pc = Game.GetPlayer()
		if (pc.GetItemCount(pReplacement) <= 0)
			pc.AddItem( pReplacement,1,true)
		endIf	
		pTweakPipBoyScript.ExeAFTMenuCommand(pHotKey)
	else
		Actor pc = Game.GetPlayer()
		if (pc.GetItemCount(pReplacement) <= 0)
			pc.AddItem( pReplacement,1,true)
		endIf	
	endif
endEvent
	



