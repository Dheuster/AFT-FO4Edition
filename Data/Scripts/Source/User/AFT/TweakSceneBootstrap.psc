Scriptname AFT:TweakSceneBootstrap extends Scene

; =============================================================================
; WHY A BOOTSTRAP?
; 
; PROBLEM : Phase and dialogue conditions are evaluated once, when a scene 
;           is started. There is no way to dynamically enable/disable content
;           once a scene is running. 
;
;           Ideally, we would place conditions in a Scene's OnBegin event 
;           handler script. However, that event runs in parallel with the 
;           scene's construction. So depending on timing, phases sometimes
;           get skipped, even though the enabling global was set to true.
;
; SOLUTION : We create scenes in pairs. Each scene has a bootstrap scene 
;            partner that is basically just a parent container for this
;            script. (No actors or phases) OnBegin() evals the conditions
;            and only kicks off the real scene after all globals are set 
;            and only if no required topics are missing. We enable chaining
;            by providing a failure Scene option (which is normally a fallback
;            Bootstrap).
;
;            Makes it easier to skip scenes that lack support topics and 
;            avoids timing issues and unncessary delays.
;
; DESIGN : The companion has a silent Hello topic that invokes a special 
;          (Non-Generic) RootBootstrap. It is the only hello topic with no 
;          conditions. The RootBootstrap. knows about affinity conditions. 
;          IE: AffSceneA can be spoken if we have reached stage 200 and 
;          currentthreshold is >= value X. It then attempts to kick off the 
;          Affinity BootStrap Scenes (Which uses this script)
;
;          The AffinityScene Bootstraps have required topics and may determine
;          the needed topics aren't present. In that case the Scene failure
;          will point at the HelloBootStrap (Leaving the Quest state alone)
;
;          MOst of the time, there is no affinity scene ready. When that 
;          happens, the RootBootstrap kicks off the HelloBootsrap directly.
;
;                [SilentHello] => RootBootStrap => HelloBootstrap
;                                 | |               ^ ^    
;                                 | |               | |
;                                 | Aff1SceneBoot --| |
;                                 |       |           |
;                                 |    Aff1Scene      |
;                                 |                   |
;                                 --Aff2SceneBoot ----|
;                                         |
;                                      Aff2Scene
;
;          The Hello Bootstrap redirects to 1 of 8 Hellos based on affinity and
;          CurrentFOllower Status. IE: Instead of 1 scene with lots and lots of
;          conditions, we have several scene categories that already encompass
;          the 2 biggest conditions: Following and Affinity:
;
;            TweakSpouseFollowingHelloDisdain
;            TweakSpouseFollowingHelloNeutral
;            TweakSpouseFollowingHelloLike
;            TweakSpouseFollowingHelloLove
;            TweakSpouseNonFollowingHelloDisdain
;            TweakSpouseNonFollowingHelloNeutral
;            TweakSpouseNonFollowingHelloLike
;            TweakSpouseNonFollowingHelloLove
;
;          Unlike the AffinityScenes, Hello scenes will not have any REQUIRED
;          topics. So the scenes will always fire. We use sharedinfo topics to 
;          the max extent possible within Hellos to avoid silent responses.
;
;          This design allows for easy expansion (We dont have a hard-coded 
;          set of script globals) and since we support internal randomization
;          of multiple topics, it minimizes the number of globals needed to
;          support the topic conditions.
;
;          Performance notes : Enter REQUIRED "ALL MODE" topics first, so we can
;          early bail if something is missing.
; =============================================================================

Struct TopicData

  GlobalVariable SceneCondition ; Use in topic and/or on phase.
  { Result of Topic Search will be stored here. 0.0 = failure. Non-Zero means success. When ALL is false (default), the global will be set to the (masked) formid of the loaded topic }

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
  Bool  REQUIRED
  { If a GLOBAL is marked as REQUIRED and fails to load a topic, we will either start the SCENEFAILURE (If specified) or bail and do nothing }

EndStruct

Group Setup
  TopicData[] Property CONFIG              Auto Const
  { Configure Globals and their TOPIC conditions here }
  
  Scene       Property SCENESUCCESS        Auto Const mandatory
  { What scene should we start on sucess (Can only fail if one of the globals is marked REQUIRED) }
  Scene       Property SCENEFAILURE = None Auto Const
  { What scene should we start on failure. Leave empty if none of the globals are marked REQUIRED }
  String      Property MODFILE      = ""   Auto Const
  { The name of your mods esp. Only Fill this out if you use a topic defined in your mod. IE: A Topic value greater than 16777215}
  String      Property LOGPREFIX    = ""   Auto Const
EndGroup

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
 string logName = "TweakSceneBootstrap"
 debug.OpenUserLog(logName)
 RETURN debug.TraceUser(logName, LOGPREFIX + asTextToPrint, aiSeverity)
EndFunction

Event OnBegin()

  Trace("OnBegin()")

  if !SCENESUCCESS
    Trace("  BAILING : No SCENESUCCESS Defined")
    return
  endif

  int numelements = CONFIG.length

  Bool  success
  Topic check
  int   numtopics
  int   ti
  int e = 0

  while (e < numelements)
    TopicData data = CONFIG[e]
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
	                                          Data.SceneCondition.SetValue(data.TOPIC9 % 0x01000000)
	                                          success = true
	                                        endif
	                                      endif
	                                    else
	                                      Trace("  TOPIC8 [" + data.TOPIC8 + "] : TRUE")
	                                      Data.SceneCondition.SetValue(data.TOPIC8 % 0x01000000)
	                                      success = true
	                                    endif
	                                  endif
	                                else
	                                  Trace("  TOPIC7 [" + data.TOPIC7 + "] : TRUE")
	                                  Data.SceneCondition.SetValue(data.TOPIC7 % 0x01000000)
	                                  success = true
	                                endif
	                              endif
	                            else
	                              Trace("  TOPIC6 [" + data.TOPIC6 + "] : TRUE")
	                              Data.SceneCondition.SetValue(data.TOPIC6 % 0x01000000)
	                              success = true
	                            endif
	                          endif
	                        else
	                          Trace("  TOPIC5 [" + data.TOPIC5 + "] : TRUE")
	                          Data.SceneCondition.SetValue(data.TOPIC5 % 0x01000000)
	                          success = true
	                        endif
	                      endif
	                    else
	                      Trace("  TOPIC4 [" + data.TOPIC4 + "] : TRUE")
	                      Data.SceneCondition.SetValue(data.TOPIC4 % 0x01000000)
	                      success = true
	                    endif
	                  endif
	                else
	                  Trace("  TOPIC3 [" + data.TOPIC3 + "] : TRUE")
	                  Data.SceneCondition.SetValue(data.TOPIC3 % 0x01000000)
	                  success = true
	                endif
	              endif
	            else
	              Trace("  TOPIC2 [" + data.TOPIC2 + "] : TRUE")
	              Data.SceneCondition.SetValue(data.TOPIC2 % 0x01000000)
	              success = true
	            endif
	          endif
	        else
	          Trace("  TOPIC1 [" + data.TOPIC1 + "] : TRUE")
	          Data.SceneCondition.SetValue(data.TOPIC1 % 0x01000000)
	          success = true
	        endif
	      endif
	    else
	      Trace("  TOPIC0 [" + data.TOPIC0 + "] : TRUE")
	      Data.SceneCondition.SetValue(data.TOPIC0 % 0x01000000)
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
        Data.SceneCondition.SetValue(passed[r] % 0x01000000)
      else
        success = False
      endif
	  
	endif ; ANY MODE : RANDOM"
	    
    if (!success)
      Trace("  FAILURE [0.0]")
      if (Data.REQUIRED)
        if SCENEFAILURE
          Trace("  SCENEFAILURE.Start()")
          SCENEFAILURE.Start()
        else
          Trace("  BAILING : No SCENEFAILURE Defined")
        endif
        return
      endif
      Data.SceneCondition.SetValue(0.0)
    else
      Trace("  SUCCESS [" + Data.SceneCondition.GetValue() + "]")
    endif

    e += 1
  endwhile

  ; If there were any FAILED REQUIRED fields, it would have 
  ; broken in the loop. If we get here, it is safe to start
  ; the scene...

  Trace("  SCENESUCCESS.Start()")
  SCENESUCCESS.Start()
 
EndEvent