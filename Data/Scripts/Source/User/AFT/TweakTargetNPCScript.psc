Scriptname AFT:TweakTargetNPCScript extends activemagiceffect
; Magic -> Magic Effect -> TweakTargetNPC -> Script

Quest Property pTweakPipBoy Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	AFT:TweakPipBoyScript pTweakPipBoyScript = (pTweakPipBoy as AFT:TweakPipBoyScript)
	if (pTweakPipBoyScript && akTarget)
		pTweakPipBoyScript.TerminalTarget = akTarget
	endif
endEvent
