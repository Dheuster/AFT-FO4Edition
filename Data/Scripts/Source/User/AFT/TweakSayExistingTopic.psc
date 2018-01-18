Scriptname AFT:TweakSayExistingTopic extends TopicInfo

; We can use the topics/keywords to string together a long line
; or as backup sinec many topics are undependable. You can also
; do both. Sequential Topics marked as OnlyIfPreviousFailed will
; all be skipped once one is successful (Until you hit another)
; topic with OnlyIfPreviousFailed set to false. 

Struct TopicData

	Int				TopicFormID				= 0
	{ FormID of Topic as INT }
	float			ForceStopCutOff         = 0.0
	{ Play the ForceStopTopic after this much time }
	Int			    ForceStopTopic          = 0
	{ A silent topic the NPC can speak that will stop the the current topic mid-sentence. Typically, an NPC Dialoge in a throw-away scene with SOUND set to XXXPlaceholderSilenceSD and VoiceType set to None (Thus no conditions to prevent any NPC from using the topic) }
	Bool			OnlyIfPreviousFailed	= False
	{ Only play Topic if the previous Topic failed to play }
	Actor			ForceSpeaker
	{ Conditions on Topic require this speaker }
	Actor			ForceTargetActor
	{ Conditions on Topic require this target actor }
	ObjectReference	ForceTargetObject
	{ Conditions on Topic require this target object }
	Idle			SpeakerIdle

EndStruct

Group Setup

	TopicData[]	Property TopicConditions		Auto Const
	{ Configure Topics to attempt to say here }
	Bool Property CenterCameraOnTarget	= False Auto Const
	Bool Property ForceTarget	        = False Auto Const
	Bool Property StopCameraWhenDone    = False Auto Const
	Bool Property FadeInWhenStart       = False Auto Const
	Bool Property FadeOutWhenDone       = False Auto Const
	
EndGroup

Group Optional
	Bool		Property StartTrade			= False Auto Const
	{ Should we open the TRADE menu once the NPC finished talking? }
	String      Property MODFILE      = ""   Auto Const
	{ The name of your mods esp. Only Fill this out if you use a topic defined in your mod. IE: A Topic value greater than 16777215}
	LookAheadData[] Property LOOKAHEAD       Auto Const
	{ Configure Globals and their TOPIC conditions here. NOTE : FOR THIS TO WORK, THE SCENE MUST RESTART VIA A STARTSCENE ACTION OR TOPIC STARTSCENE OPTION. ALSO ENSURE PHASE HAS A 2 SEC DELAY }
	String      Property LOGPREFIX    = ""   Auto Const
EndGroup


bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakSayExistingTopic"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, LOGPREFIX + asTextToPrint, aiSeverity)
EndFunction

Event OnBegin(ObjectReference akSpeakerRef, bool abHasBeenSaid)
	Actor akSpeaker = akSpeakerRef as Actor

	Trace("OnBegin Speaker [" + akSpeaker + "] HasBeenSaid [" + abHasBeenSaid + "]")
	
	if CenterCameraOnTarget
		if akSpeakerRef.GetCurrentScene() != None
			Game.StartDialogueCameraOrCenterOnTarget(akSpeakerRef)
			Utility.wait(0.1)
			if akSpeaker && ForceTarget
				Game.SetCameraTarget(akSpeakerRef as Actor)
			endif
		else
			Trace("  CenterCameraOnTarget : TRUE - FAILURE - Reference is not in a scene")
		endif
	else
		Trace("  CenterCameraOnTarget : FALSE  [" + akSpeakerRef + "]")
	endif
	
	if FadeInWhenStart
		Trace("FadeInWhenStart is TRUE")
		Game.FadeOutGame(false, true, 2.0, 1.0)
		Utility.wait(1.0)
	endif
	
	Actor           akSpeakerCondition
	ObjectReference akTargetCondition
	Bool			PrevSuccess = false
	Bool			CurrSuccess = true
	TopicData		td 
	Topic			theTopic
	int totalconditions = TopicConditions.length
	int i = 0
		
	if 0 != LookAhead.Length
		Trace(" LookAhead : START")
		ProcessLookAhead()
		Trace(" LookAhead : FINISH")
	endif
	
	while (i < totalconditions)
		Trace("--")
		td = TopicConditions[i]
		
		if (td.OnlyIfPreviousFailed && PrevSuccess)
			Trace("OnlyIfPreviousFailed and PrevSuccess are TRUE (Skipping topic)")
			CurrSuccess = false
			PrevSuccess = true
		else
			Trace(" OnlyIfPreviousFailed or PrevSuccess is FALSE")
			if td.ForceSpeaker
				Trace(" ForceSpeaker : [" + td.ForceSpeaker + "]")		
				akSpeakerCondition = td.ForceSpeaker
			else 
				akSpeakerCondition = akSpeakerRef as Actor
				Trace(" USING DEFAULT SPEAKER : [" + akSpeakerCondition + "]")		
			endif
		
			akTargetCondition = None
			if td.ForceTargetActor
				Trace(" ForceTargetActor : [" + td.ForceTargetActor + "]")		
				akTargetCondition = td.ForceTargetActor as ObjectReference
			elseif td.ForceTargetObject
				Trace(" ForceTargetObject : [" + td.ForceTargetObject + "]")		
				akTargetCondition = td.ForceTargetObject
			else
				Trace(" USING DEFAULT TARGET : NONE")		
			endif
		
			CurrSuccess = False
						
			if (0.0 != td.TopicFormID)
				Trace(" TopicFormID : [" + td.TopicFormID + "]")
				if (td.TopicFormID > 0x00FFFFFF)
					theTopic = Game.GetFormFromFile(td.TopicFormID,MODFILE) as Topic
				else
					theTopic = Game.GetForm(td.TopicFormID) as Topic
				endif
				
				if theTopic
					Trace("  Topic[" + i + "] Lookup: SUCCESS")
					Topic stopTopic = None
					if (0.0 != td.ForceStopCutOff)
						Trace("  ForceStopCutOff[" + td.ForceStopCutOff + "]")
						if (td.ForceStopTopic > 0x00FFFFFF)
							stopTopic = Game.GetFormFromFile(td.ForceStopTopic,MODFILE) as Topic
						else
							stopTopic = Game.GetForm(td.ForceStopTopic) as Topic
						endif
						Trace("  ForceStopTopic[" + td.ForceStopTopic + "] (" + stopTopic + ")")
					endif
					akSpeakerRef.Say(theTopic, akSpeakerCondition, false, akTargetCondition)
					if td.SpeakerIdle
						akSpeaker.PlayIdle(td.SpeakerIdle)
					endif
					CurrSuccess = true
					if stopTopic					
						Utility.wait(td.ForceStopCutOff)
						akSpeakerRef.Say(stopTopic, akSpeakerCondition, false, akTargetCondition)
					endif
				else
					Trace("  Topic[" + i + "] Lookup: FAILURE")
				endif
			elseif (0.0 != td.ForceStopCutOff)
				Trace("  ForceStopCutOff[" + td.ForceStopCutOff + "]")
				Topic stopTopic = None
				if (td.ForceStopTopic > 0x00FFFFFF)
					stopTopic = Game.GetFormFromFile(td.ForceStopTopic,MODFILE) as Topic
				else
					stopTopic = Game.GetForm(td.ForceStopTopic) as Topic
				endif
				if stopTopic					
					CurrSuccess = true
					Utility.wait(td.ForceStopCutOff)
					akSpeakerRef.Say(stopTopic, akSpeakerCondition, false, akTargetCondition)
				endif
			endif
			
			if CurrSuccess
				Utility.wait(1.0)
				if akSpeakerCondition.IsTalking()
					Trace(" Begin Waiting: [" + td.TopicFormID + "]")
					int maxwait = 15
					while (akSpeakerCondition.IsTalking() && maxwait > 0)
						Trace("  Waiting [" + td.TopicFormID + "]")
						Utility.wait(0.5)
						maxwait -= 1
					endwhile
					Trace(" Finished Waiting [" + td.TopicFormID + "]")
				else
					Trace(" Not Talking.")
				endif
			endif
			PrevSuccess = CurrSuccess
		endif
		i += 1
	endWhile
	
	if FadeOutWhenDone
		Trace("FadeOutWhenDone is TRUE")

		; FADE OUT
		Game.FadeOutGame(true, true, 2.0, 2.0, true)
		Utility.wait(2)
	endif
	
EndEvent

Event OnEnd(ObjectReference akSpeakerRef, bool abHasBeenSaid)

	Trace("OnEnd Speaker [" + (akSpeakerRef as Actor) + "] HasBeenSaid [" + abHasBeenSaid + "]")
	TopicData td = TopicConditions[0]

	Actor akSpeakerCondition = akSpeakerRef as Actor
	if akSpeakerCondition
		Trace("  OnEnd : Talking [" + td.TopicFormID + "]")
		int maxwait = 20
		while (akSpeakerCondition.IsTalking() && maxwait > 0)
			Trace("  OnEnd : Waiting [" + td.TopicFormID + "]")
			Utility.wait(0.5)
			maxwait -= 1
		endwhile
		Trace("  OnEnd : Finished Waiting [" + td.TopicFormID + "]")		
	endif
	
	if StopCameraWhenDone
		if akSpeakerRef.GetCurrentScene() != None
			Game.StopDialogueCamera()
			if ForceTarget && akSpeakerCondition
				Game.SetCameraTarget(None)
			endif
		else
			Trace("  StopCameraWhenDone : TRUE - FAILURE - Reference is not in a scene")
		endif
	else
		Trace("  StopCameraWhenDone : FALSE  [" + akSpeakerRef + "]")
	endif
	

	if StartTrade
		if utility.IsInMenuMode() == false
			; wait for info to actually finish
			utility.wait(0.2)
			If akSpeakerRef == Game.GetPlayer()
				(akSpeakerRef as Actor).GetDialogueTarget().OpenInventory(true)
			Else
				(akSpeakerRef as Actor).OpenInventory(true)
			EndIf
		EndIf
	endif
	
endEvent

Function ProcessLookAhead()

	Trace("  ProcessLookAhead()")

  int numelements = LOOKAHEAD.length

  Bool  success
  Topic check
  int   numtopics
  int   ti
  int e = 0

  while (e < numelements)
    LookAheadData data = LOOKAHEAD[e]
    Trace(Data.SceneCondition)
    if (data.ALL)
      Trace("  ALL MODE")

      ; We can bail as soon as there is a failure...
      success = true   
	  if data.Topic0
	    if (Game.GetForm(data.Topic0) as Topic || (data.Topic0 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic0,MODFILE)))
	      Trace("  TOPIC0 [" + data.TOPIC0 + "] : TRUE")
	      if data.Topic1
	        if (Game.GetForm(data.Topic1) as Topic || (data.Topic1 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic1,MODFILE)))
	          Trace("  TOPIC1 [" + data.TOPIC1 + "] : TRUE")
	          if data.Topic2
	            if (Game.GetForm(data.Topic2) as Topic || (data.Topic2 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic2,MODFILE)))
	              Trace("  TOPIC2 [" + data.TOPIC2 + "] : TRUE")
	              if data.Topic3
	                if (Game.GetForm(data.Topic3) as Topic || (data.Topic3 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic3,MODFILE)))
	                  Trace("  TOPIC3 [" + data.TOPIC3 + "] : TRUE")
	                  if data.Topic4
	                    if (Game.GetForm(data.Topic4) as Topic || (data.Topic4 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic4,MODFILE)))
	                      Trace("  TOPIC4 [" + data.TOPIC4 + "] : TRUE")
		                  if data.Topic5
                            if (Game.GetForm(data.Topic5) as Topic || (data.Topic5 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic5,MODFILE)))
	                          Trace("  TOPIC5 [" + data.TOPIC5 + "] : TRUE")
		                      if data.Topic6
                                if (Game.GetForm(data.Topic6) as Topic || (data.Topic6 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic6,MODFILE)))
	                              Trace("  TOPIC6 [" + data.TOPIC6 + "] : TRUE")
		                          if data.Topic7
                                    if (Game.GetForm(data.Topic7) as Topic || (data.Topic7 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic7,MODFILE)))
	                                  Trace("  TOPIC7 [" + data.TOPIC7 + "] : TRUE")
		                              if data.Topic8
                                        if (Game.GetForm(data.Topic8) as Topic || (data.Topic8 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic8,MODFILE)))
	                                      Trace("  TOPIC8 [" + data.TOPIC8 + "] : TRUE")
		                                  if data.Topic9
                                            if (Game.GetForm(data.Topic9) as Topic || (data.Topic9 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic9,MODFILE)))
	                                          Trace("  TOPIC9 [" + data.TOPIC9 + "] : TRUE")
											else
	                                          Trace("  TOPIC9 [" + data.TOPIC9 + "] : FALSE")
	                                          success = false
	                                        endif
	                                      endif
	                                    else
	                                      Trace("  TOPIC8 [" + data.TOPIC8 + "] : FALSE")
	                                      success = false
	                                    endif
	                                  endif
	                                else
	                                  Trace("  TOPIC7 [" + data.TOPIC7 + "] : FALSE")
	                                  success = false
	                                endif
	                              endif
	                            else
	                              Trace("  TOPIC6 [" + data.TOPIC6 + "] : FALSE")
	                              success = false
	                            endif
	                          endif
	                        else
	                          Trace("  TOPIC5 [" + data.TOPIC5 + "] : FALSE")
	                          success = false
	                        endif
	                      endif
	                    else
	                      Trace("  TOPIC4 [" + data.TOPIC4 + "] : FALSE")
	                      success = false
	                    endif
	                  endif
	                else
	                  Trace("  TOPIC3 [" + data.TOPIC3 + "] : FALSE")
	                  success = false
	                endif
	              endif
	            else
	              Trace("  TOPIC2 [" + data.TOPIC2 + "] : FALSE")
	              success = false
	            endif
	          endif
	        else
	          Trace("  TOPIC1 [" + data.TOPIC1 + "] : FALSE")
	          success = false
	        endif
	      endif
	    else
	      Trace("  TOPIC0 [" + data.TOPIC0 + "] : FALSE")
	      success = false
	    endif
	  endif

      if success
        Data.SceneCondition.SetValue(1.0)
      endif

    elseif (!data.RANDOM)
      Trace("  ANY MODE : FIRST HIT")

      ; We can bail as soon as we find a hit
	  
      success = false   
	  if data.Topic0
	    if !(Game.GetForm(data.Topic0) as Topic || (data.Topic0 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic0,MODFILE)))
	      Trace("  TOPIC0 [" + data.TOPIC0 + "] : FALSE")
	      if data.Topic1
	        if !(Game.GetForm(data.Topic1) as Topic || (data.Topic1 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic1,MODFILE)))
	          Trace("  TOPIC1 [" + data.TOPIC1 + "] : FALSE")
	          if data.Topic2
	            if !(Game.GetForm(data.Topic2) as Topic || (data.Topic2 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic2,MODFILE)))
	              Trace("  TOPIC2 [" + data.TOPIC2 + "] : FALSE")
	              if data.Topic3
	                if !(Game.GetForm(data.Topic3) as Topic || (data.Topic3 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic3,MODFILE)))
	                  Trace("  TOPIC3 [" + data.TOPIC3 + "] : FALSE")
	                  if data.Topic4
	                    if !(Game.GetForm(data.Topic4) as Topic || (data.Topic4 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic4,MODFILE)))
	                      Trace("  TOPIC4 [" + data.TOPIC4 + "] : FALSE")
		                  if data.Topic5
                            if !(Game.GetForm(data.Topic5) as Topic || (data.Topic5 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic5,MODFILE)))
	                          Trace("  TOPIC5 [" + data.TOPIC5 + "] : FALSE")
		                      if data.Topic6
                                if !(Game.GetForm(data.Topic6) as Topic || (data.Topic6 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic6,MODFILE)))
	                              Trace("  TOPIC6 [" + data.TOPIC6 + "] : FALSE")
		                          if data.Topic7
                                    if !(Game.GetForm(data.Topic7) as Topic || (data.Topic7 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic7,MODFILE)))
	                                  Trace("  TOPIC7 [" + data.TOPIC7 + "] : FALSE")
		                              if data.Topic8
                                        if !(Game.GetForm(data.Topic8) as Topic || (data.Topic8 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic8,MODFILE)))
	                                      Trace("  TOPIC8 [" + data.TOPIC8 + "] : FALSE")
		                                  if data.Topic9
                                            if !(Game.GetForm(data.Topic9) as Topic || (data.Topic9 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic9,MODFILE)))
	                                          Trace("  TOPIC9 [" + data.TOPIC9 + "] : FALSE")
											else
	                                          Trace("  TOPIC9 [" + data.TOPIC9 + "] : TRUE")
	                                          Data.SceneCondition.SetValue(data.TOPIC9)
	                                          success = true
	                                        endif
	                                      endif
	                                    else
	                                      Trace("  TOPIC8 [" + data.TOPIC8 + "] : TRUE")
	                                      Data.SceneCondition.SetValue(data.TOPIC8)
	                                      success = true
	                                    endif
	                                  endif
	                                else
	                                  Trace("  TOPIC7 [" + data.TOPIC7 + "] : TRUE")
	                                  Data.SceneCondition.SetValue(data.TOPIC7)
	                                  success = true
	                                endif
	                              endif
	                            else
	                              Trace("  TOPIC6 [" + data.TOPIC6 + "] : TRUE")
	                              Data.SceneCondition.SetValue(data.TOPIC6)
	                              success = true
	                            endif
	                          endif
	                        else
	                          Trace("  TOPIC5 [" + data.TOPIC5 + "] : TRUE")
	                          Data.SceneCondition.SetValue(data.TOPIC5)
	                          success = true
	                        endif
	                      endif
	                    else
	                      Trace("  TOPIC4 [" + data.TOPIC4 + "] : TRUE")
	                      Data.SceneCondition.SetValue(data.TOPIC4)
	                      success = true
	                    endif
	                  endif
	                else
	                  Trace("  TOPIC3 [" + data.TOPIC3 + "] : TRUE")
	                  Data.SceneCondition.SetValue(data.TOPIC3)
	                  success = true
	                endif
	              endif
	            else
	              Trace("  TOPIC2 [" + data.TOPIC2 + "] : TRUE")
	              Data.SceneCondition.SetValue(data.TOPIC2)
	              success = true
	            endif
	          endif
	        else
	          Trace("  TOPIC1 [" + data.TOPIC1 + "] : TRUE")
	          Data.SceneCondition.SetValue(data.TOPIC1)
	          success = true
	        endif
	      endif
	    else
	      Trace("  TOPIC0 [" + data.TOPIC0 + "] : TRUE")
	      Data.SceneCondition.SetValue(data.TOPIC0)
	      success = true
	    endif
	  endif
	  	  
    else 
      Trace("  ANY MODE : RANDOM")
      
      ; No early bail
      int[] passed = new int[0]
	  if data.Topic0
	    if (Game.GetForm(data.Topic0) as Topic || (data.Topic0 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic0,MODFILE)))
	      passed.Add(data.TOPIC0)
	      Trace("  TOPIC0 [" + data.TOPIC0 + "] : TRUE")
	    else
	      Trace("  TOPIC0 [" + data.TOPIC0 + "] : FALSE")
	    endif
	    if data.Topic1
	      if (Game.GetForm(data.Topic1) as Topic || (data.Topic1 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic1,MODFILE)))
	        passed.Add(data.TOPIC1)
	        Trace("  TOPIC1 [" + data.TOPIC1 + "] : TRUE")
	      else
	        Trace("  TOPIC1 [" + data.TOPIC1 + "] : FALSE")
	      endif
	      if data.Topic2
	        if (Game.GetForm(data.Topic2) as Topic || (data.Topic2 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic2,MODFILE)))
	          passed.Add(data.TOPIC2)
	          Trace("  TOPIC2 [" + data.TOPIC2 + "] : TRUE")
	        else
	          Trace("  TOPIC2 [" + data.TOPIC2 + "] : FALSE")
	        endif
	        if data.Topic3
	          if (Game.GetForm(data.Topic3) as Topic || (data.Topic3 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic3,MODFILE)))
	            passed.Add(data.TOPIC3)
	            Trace("  TOPIC3 [" + data.TOPIC3 + "] : TRUE")
	          else
	            Trace("  TOPIC3 [" + data.TOPIC3 + "] : FALSE")
	          endif
	          if data.Topic4
	            if (Game.GetForm(data.Topic4) as Topic || (data.Topic4 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic4,MODFILE)))
	              passed.Add(data.TOPIC4)
	              Trace("  TOPIC4 [" + data.TOPIC4 + "] : TRUE")
	            else
	              Trace("  TOPIC4 [" + data.TOPIC4 + "] : FALSE")
	            endif
	            if data.Topic5
	              if (Game.GetForm(data.Topic5) as Topic || (data.Topic5 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic5,MODFILE)))
	                passed.Add(data.TOPIC5)
	                Trace("  TOPIC5 [" + data.TOPIC5 + "] : TRUE")
	              else
	                Trace("  TOPIC5 [" + data.TOPIC5 + "] : FALSE")
	              endif
	              if data.Topic6
	                if (Game.GetForm(data.Topic6) as Topic || (data.Topic6 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic6,MODFILE)))
	                  passed.Add(data.TOPIC6)
	                  Trace("  TOPIC6 [" + data.TOPIC6 + "] : TRUE")
	                else
	                  Trace("  TOPIC6 [" + data.TOPIC6 + "] : FALSE")
	                endif
	                if data.Topic7
	                  if (Game.GetForm(data.Topic7) as Topic || (data.Topic7 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic7,MODFILE)))
	                    passed.Add(data.TOPIC7)
	                    Trace("  TOPIC7 [" + data.TOPIC7 + "] : TRUE")
	                  else
	                    Trace("  TOPIC7 [" + data.TOPIC7 + "] : FALSE")
	                  endif
	                  if data.Topic8
	                    if (Game.GetForm(data.Topic8) as Topic || (data.Topic8 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic8,MODFILE)))
	                      passed.Add(data.TOPIC8)
	                      Trace("  TOPIC8 [" + data.TOPIC8 + "] : TRUE")
	                    else
	                      Trace("  TOPIC8 [" + data.TOPIC8 + "] : FALSE")
	                    endif
	                    if data.Topic9
	                      if (Game.GetForm(data.Topic9) as Topic || (data.Topic9 > 0x00FFFFFF && Game.GetFormFromFile(data.Topic9,MODFILE)))
	                        passed.Add(data.TOPIC9)
	                        Trace("  TOPIC9 [" + data.TOPIC9 + "] : TRUE")
	                      else
	                        Trace("  TOPIC9 [" + data.TOPIC9 + "] : FALSE")
	                      endif
	                    endif ; TOPIC9
	                  endif ; TOPIC8
	                endif ; TOPIC7
	              endif ; TOPIC6
	            endif ; TOPIC5
	          endif ; TOPIC4
	        endif ; TOPIC3
	      endif ; TOPIC2
	    endif ; TOPIC1
	  endif ; TOPIC0
	  
      if passed.length > 0
        success = True
        int r = (Utility.RandomInt(1, passed.length) - 1)
        Data.SceneCondition.SetValue(passed[r])
      else
        success = False
      endif
	  
	endif ; ANY MODE : RANDOM"
	    
    if (!success)
      Trace("  FAILURE [0.0]")
      Data.SceneCondition.SetValue(0.0)
    else
      Trace("  SUCCESS [" + Data.SceneCondition.GetValue() + "]")
    endif

    e += 1
  endwhile
	
EndFunction

; LOOKAHEAD : Is similar to our SceneBootstrap (See TweakSceneBootstrap for 
; documenation), however it does not support the concept of failure or 
; success like the Bootstrap does. LOOKAHEAD simply checks topics and
; sets globals.
;
; NOTE : Scenes use snapshots of global values when they start. So 
; changing global values post-start will have no effect on the scene.
; (Stage changes seem to be honored however). 
;
; You must restart the scene and fast foward to a phase for the globals
; to have an impact. This means you either need to configure the
; topic to start a scene and go to a phase (See Topic GUI), or you
; can inject a Start Scene action that affectively reloads the 
; scene and fast forwars to the phase after the Start Scene action.
;
; You can use stages if the changes are a one-way (only increasing values) 
; change. 

Struct LookAheadData

  GlobalVariable SceneCondition ; Use in topic and/or on phase.
  { Result of Topic Search will be stored here. 0.0 = failure. Non-Zero means success. When ALL is false (default), the global will be set to the formid of the loaded topic }

  ; Structs dont support ARRAYS, but we can work around that with
  ; a hard coded number of items...  (Introduces a max, but oh well)
  
  Int   Topic0
  { Topic[0] : Fill out topics from top to bottom. Leave topics empty if unused. }
  Int   Topic1
  { Topic[1] }
  Int   Topic2
  { Topic[2] }
  Int   Topic3
  { Topic[3] }
  Int   Topic4
  { Topic[4] }
  Int   Topic5
  { Topic[5] }
  Int   Topic6
  { Topic[6] }
  Int   Topic7
  { Topic[7] }
  Int   Topic8
  { Topic[8] }
  Int   Topic9
  { Topic[9] }
  
  Bool  ALL
  { When true, the result will be 1.0 or 0.0 indicating if all topics are found. When false, result will be formid of loaded topic or 0.0 if none were found}
  Bool  RANDOM	
  { When ALL is false, we normally return the first loaded Topic Found. Checking Random causes us to randomaly pick one of the loaded topics. Random is ignored when ALL is true }

EndStruct
