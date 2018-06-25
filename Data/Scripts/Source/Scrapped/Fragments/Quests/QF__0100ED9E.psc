;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AFT:Fragments:Quests:QF__0100ED9E Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0000_Item_00
Function Fragment_Stage_0000_Item_00()
;BEGIN CODE
;this may need to change when the real Dogmeat is integrated:
debug.trace(self + "Stage 0, start up")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0010_Item_00
Function Fragment_Stage_0010_Item_00()
;BEGIN CODE
;make MacCreedy a follower and move him to the player
COMMacCready.setStage(80)
while Alias_Companion.GetReference() == None
	debug.trace("Followers Stage 10 waiting for Companion alias to fill")
	utility.wait(1)
endwhile

Alias_Companion.GetReference().MoveTo(Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0020_Item_00
Function Fragment_Stage_0020_Item_00()
;BEGIN AUTOCAST TYPE followersscript
Quest __temp = self as Quest
followersscript kmyQuest = __temp as followersscript
;END AUTOCAST
;BEGIN CODE
;make Cait a follower and move him to the player
kmyquest.SetCompanion(CaitRef as Actor)
while Alias_Companion.GetReference() == None
	debug.trace("Followers Stage 20 waiting for Companion alias to fill")
	utility.wait(1)
endwhile

Alias_Companion.GetReference().MoveTo(Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0030_Item_00
Function Fragment_Stage_0030_Item_00()
;BEGIN AUTOCAST TYPE followersscript
Quest __temp = self as Quest
followersscript kmyQuest = __temp as followersscript
;END AUTOCAST
;BEGIN CODE
;make Preston a follower and move him to the player
kmyquest.SetCompanion(PrestonGarveyRef as Actor)
while Alias_Companion.GetReference() == None
	debug.trace("Followers Stage 30 waiting for Companion alias to fill")
	utility.wait(1)
endwhile

Alias_Companion.GetReference().MoveTo(Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0040_Item_00
Function Fragment_Stage_0040_Item_00()
;BEGIN AUTOCAST TYPE followersscript
Quest __temp = self as Quest
followersscript kmyQuest = __temp as followersscript
;END AUTOCAST
;BEGIN CODE
;make Deacon a follower and move him to the player
kmyquest.SetCompanion(DeaconRef as Actor)
while Alias_Companion.GetReference() == None
	debug.trace("Followers Stage 40 waiting for Companion alias to fill")
	utility.wait(1)
endwhile

Alias_Companion.GetReference().MoveTo(Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0050_Item_00
Function Fragment_Stage_0050_Item_00()
;BEGIN AUTOCAST TYPE followersscript
Quest __temp = self as Quest
followersscript kmyQuest = __temp as followersscript
;END AUTOCAST
;BEGIN CODE
;make Codsworth a follower and move him to the player
kmyquest.SetCompanion(CodsworthRef as Actor)
while Alias_Companion.GetReference() == None
	debug.trace("Followers Stage 50 waiting for Companion alias to fill")
	utility.wait(1)
endwhile

Alias_Companion.GetReference().MoveTo(Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0060_Item_00
Function Fragment_Stage_0060_Item_00()
;BEGIN AUTOCAST TYPE followersscript
Quest __temp = self as Quest
followersscript kmyQuest = __temp as followersscript
;END AUTOCAST
;BEGIN CODE
;make Curie a follower and move her to the player
kmyquest.SetCompanion(CurieRef as Actor)
while Alias_Companion.GetReference() == None
	debug.trace("Followers Stage 60 waiting for Companion alias to fill")
	utility.wait(1)
endwhile

Alias_Companion.GetReference().MoveTo(Game.GetPlayer())

; End the quest she was recruited in
pMS19.Stop()

; Make it so she skips her initial join conversation
pCOMCurie.SetStage(80)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0070_Item_00
Function Fragment_Stage_0070_Item_00()
;BEGIN AUTOCAST TYPE followersscript
Quest __temp = self as Quest
followersscript kmyQuest = __temp as followersscript
;END AUTOCAST
;BEGIN CODE
;make X6 a follower and move him to the player
kmyquest.SetCompanion(CompanionX688Ref as Actor)
while Alias_Companion.GetReference() == None
	debug.trace("Followers Stage 70 waiting for Companion alias to fill")
	utility.wait(1)
endwhile

Alias_Companion.TryToEnable()
Alias_Companion.GetReference().MoveTo(Game.GetPlayer())

; Make it so she skips her initial join conversation
COMX688.SetStage(80)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0080_Item_00
Function Fragment_Stage_0080_Item_00()
;BEGIN AUTOCAST TYPE followersscript
Quest __temp = self as Quest
followersscript kmyQuest = __temp as followersscript
;END AUTOCAST
;BEGIN CODE
;make Danse a follower and move him to the player
kmyquest.SetCompanion(BoSPaladinDanseRef as Actor)
while Alias_Companion.GetReference() == None
	debug.trace("Followers Stage 80 waiting for Companion alias to fill")
	utility.wait(1)
endwhile

Alias_Companion.TryToEnable()
Alias_Companion.GetReference().MoveTo(Game.GetPlayer())

; Make it so he skips his initial join conversation
COMDanse.SetStage(80)
BoS100Fight.SetStage(2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0100_Item_00
Function Fragment_Stage_0100_Item_00()
;BEGIN AUTOCAST TYPE followersscript
Quest __temp = self as Quest
followersscript kmyQuest = __temp as followersscript
;END AUTOCAST
;BEGIN CODE
;DEBUG - test autonomy variables
FollowersScript.SetAutonomy(kmyquest, false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0101_Item_00
Function Fragment_Stage_0101_Item_00()
;BEGIN AUTOCAST TYPE followersscript
Quest __temp = self as Quest
followersscript kmyQuest = __temp as followersscript
;END AUTOCAST
;BEGIN CODE
;DEBUG - test autonomy variables
FollowersScript.SetAutonomy(kmyquest, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_0500_Item_00
Function Fragment_Stage_0500_Item_00()
;BEGIN CODE
Alias_CommandTarget.GetReference().Unlock()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_1000_Item_00
Function Fragment_Stage_1000_Item_00()
;BEGIN AUTOCAST TYPE followersscript
Quest __temp = self as Quest
followersscript kmyQuest = __temp as followersscript
;END AUTOCAST
;BEGIN CODE
;DEBUG STAGE
kmyquest.SetCompanion(TestJPFollowerRef as Actor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_2000_Item_00
Function Fragment_Stage_2000_Item_00()
;BEGIN AUTOCAST TYPE followersscript
Quest __temp = self as Quest
followersscript kmyQuest = __temp as followersscript
;END AUTOCAST
;BEGIN CODE
;sends murder event, see CA_QuestScript
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Stage_2001_Item_00
Function Fragment_Stage_2001_Item_00()
;BEGIN AUTOCAST TYPE followersscript
Quest __temp = self as Quest
followersscript kmyQuest = __temp as followersscript
;END AUTOCAST
;BEGIN CODE
;sends steal event, see CA_QuestScript
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment



ObjectReference Property TestJPFollowerRef Auto Const

ReferenceAlias Property Alias_Companion Auto Const

Quest Property COMMacCready Auto Const

Keyword Property CAE_TestEvent1 Auto Const
Keyword Property CAE_TestEvent2 Auto Const

Keyword Property LocEncRaiders Auto Const

Keyword Property LocSetSchool Auto Const

Location Property TestSALocation Auto Const

Faction Property MoleRatFaction Auto Const

Faction Property RobotFaction Auto Const

ObjectReference Property CaitRef Auto Const

ObjectReference Property PrestonGarveyRef Auto Const

Keyword Property CA_Event_Murder Auto Const

Keyword Property CA_Event_Steal Auto Const

ObjectReference Property DeaconREF Auto Const

ObjectReference Property CodsworthRef Auto Const

ObjectReference Property CurieRef Auto Const

ObjectReference Property CompanionX688Ref Auto Const

Quest Property pMS19 Auto Const

Quest Property pCOMCurie Auto Const
Quest Property COMX688 Auto Const

ObjectReference Property BoSPaladinDanseRef Auto Const

Quest Property COMDanse Auto Const

Quest Property BoS100Fight Auto Const

ReferenceAlias Property Alias_CommandTarget Auto Const
