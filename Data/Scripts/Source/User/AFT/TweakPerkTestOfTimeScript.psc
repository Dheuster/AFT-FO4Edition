Scriptname AFT:TweakPerkTestOfTimeScript extends ActiveMagicEffect

Hardcore:HC_ManagerScript Property HC_Manager Auto Const Mandatory

SPELL Property  SlowTime Auto Const
String Property TestOfTimeSwfName Auto Const  ; Components\VaultBoys\Perks\Trigger_Rush.swf  or PerkClip_d9793.swf
Sound Property  FXExplosionPrydwenCrashShockwave Auto Const Mandatory

ImageSpaceModifier Property FadeInImod Auto Const ; SlowTimeIn
ImageSpaceModifier Property ImodEffect Auto Const
ImageSpaceModifier Property FadeOutImod Auto Const

Event OnEffectStart(Actor akTarget, Actor akCaster)

	if HC_Manager.IsProcessingSleep()
		HC_Manager.trace(self, "OnEffectStart() BAILING OUT because IsProcessingSleep()")
		RETURN
	endif

	game.ShowPerkVaultBoyOnHUD(TestOfTimeSwfName, FXExplosionPrydwenCrashShockwave)
	If SlowTime != None
		SlowTime.Cast(akCaster)
	Endif

	; This effect can stop/start when going into VATS, so make sure to stop the fade in/out imods if they're present
	FadeOutImod.Remove()
	FadeInImod.popto(FadeInImod)
	ImodEffect.ApplyCrossFade(1.0)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	ImodEffect.Remove()
	; PopTo itself to kill previous instances if the effect was stopped/started
	FadeOutImod.popto(FadeOutImod)
EndEvent