Scriptname CIS_EnterNewLocationTrigger extends ObjectReference Const

keyword Property CIS_ENL_Keyword const auto
{Keyword for the topic to say
filter for "CIS_ENL"
}

Event OnTriggerEnter(ObjectReference akActionRef) 

	Actor actorRef = akActionRef as Actor

	if actorRef && actorRef.IsInFaction(Game.GetCommonProperties().CurrentCompanionFaction)

		GlobalVariable TweakCommentSynch = Game.GetFormFromFile(0x010424D5,"AmazingFollowerTweaks.esp") as GlobalVariable

		; Early Bails...
		if (!TweakCommentSynch)
			actorRef.SayCustom(CIS_ENL_Keyword)
			return
		endif
		if (1.0 != TweakCommentSynch.GetValue())
			actorRef.SayCustom(CIS_ENL_Keyword)
			return
		endif
		
		; DogMeat Special Case
		if !actorRef.HasKeyword(Game.GetForm(0x00013794) as Keyword) ; ActorTypeNPC
		
			; Non-humanoid. Dont block... (Dogmeat is the only non-humanoid companion)
			; that might receive CIS events...
			
			actorRef.SayCustom(CIS_ENL_Keyword)
			return
		endif
		
		; TweakCommentSynch Support :
		
		; The following 4 factions are added to the Companion referenceAlias on the Followers Quest:
		;
		;    AO_Type_Comment_1024
		;    AO_Type_Comment_512
		;    AO_Type_Comment_256
		;    AO_Type_Comment_128
		;
		;  RotateCompanion() in Followers:TweakDFScript rotates the Companion reference (pointer) 
		;  through the 5 humanoid companion slots. Along the way it adds/removes these keywords
		;  when TweakCommentSynch is true. This prevents everyone from speaking up at once for
		;  Attraction Object Comment events. We can use the same Faction based solution here.
		;  We dont need to check all four keywords. Just need to check for one.
		;
		;  I BELIEVE this faction lookup and check is cheaper than resolving the QUEST, casting to 
		;  a script and then grabbing the Companion ReferenceAlias propery, getting its contents 
		;  and comparing it to the actorRef.
		
		if actorRef.HasKeyword(Game.GetForm(0x00181063) as Keyword) ; AO_Type_Comment_1024

			actorRef.SayCustom(CIS_ENL_Keyword)
			
		; elseif actorRef.HasKeyword(Game.GetForm(0x0002B7A4) as Keyword) ; AO_Type_Comment_512
		; 	actorRef.SayCustom(CIS_ENL_Keyword)
		; elseif actorRef.HasKeyword(Game.GetForm(0x0017553F) as Keyword) ; AO_Type_Comment_256
		; 	actorRef.SayCustom(CIS_ENL_Keyword)
		; elseif actorRef.HasKeyword(Game.GetForm(0x0017553F) as Keyword) ; AO_Type_Comment_128
		;	 actorRef.SayCustom(CIS_ENL_Keyword)
		
		endif
				
	endif


EndEvent