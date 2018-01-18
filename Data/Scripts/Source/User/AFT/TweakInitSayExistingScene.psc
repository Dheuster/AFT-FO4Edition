Scriptname AFT:TweakInitSayExistingScene extends Scene

Group Name
String Property SceneName = "" Auto Const
EndGroup

Group PlayerComment1
	int	Property TopicToggle0 Auto Const
	int	Property TopicToggle1 Auto Const
	int	Property TopicToggle2 Auto Const
EndGroup

Group NPCResponse1
	int	Property TopicToggle3 Auto Const
	int	Property TopicToggle4 Auto Const
	int	Property TopicToggle5 Auto Const
	int	Property TopicToggle6 Auto Const
EndGroup

Group PlayerComment2
	int	Property TopicToggle7 Auto Const
	int	Property TopicToggle8 Auto Const
	int	Property TopicToggle9 Auto Const
EndGroup

Group NPCResponse2
	int	Property TopicToggle10 Auto Const
	int	Property TopicToggle11 Auto Const
	int	Property TopicToggle12 Auto Const
	int	Property TopicToggle13 Auto Const
EndGroup

Group PlayerComment3
	int	Property TopicToggle14 Auto Const
	int	Property TopicToggle15 Auto Const
	int	Property TopicToggle16 Auto Const
EndGroup

Group NPCResponse3
	int	Property TopicToggle17 Auto Const
	int	Property TopicToggle18 Auto Const
	int	Property TopicToggle19 Auto Const
	int	Property TopicToggle20 Auto Const
EndGroup

Group PlayerComment4
	int	Property TopicToggle21 Auto Const
	int	Property TopicToggle22 Auto Const
	int	Property TopicToggle23 Auto Const
EndGroup

Group NPCResponse4
	int	Property TopicToggle24 Auto Const
	int	Property TopicToggle25 Auto Const
	int	Property TopicToggle26 Auto Const
	int	Property TopicToggle27 Auto Const
EndGroup

Group Support_GLOBALS

	GlobalVariable	Property TweakToggle0  Auto Const
	GlobalVariable	Property TweakToggle1  Auto Const
	GlobalVariable	Property TweakToggle2  Auto Const
	
	GlobalVariable	Property TweakToggle3  Auto Const
	GlobalVariable	Property TweakToggle4  Auto Const
	GlobalVariable	Property TweakToggle5  Auto Const
	GlobalVariable	Property TweakToggle6  Auto Const
	
	GlobalVariable	Property TweakToggle7  Auto Const
	GlobalVariable	Property TweakToggle8  Auto Const
	GlobalVariable	Property TweakToggle9  Auto Const
	
	GlobalVariable	Property TweakToggle10  Auto Const
	GlobalVariable	Property TweakToggle11  Auto Const
	GlobalVariable	Property TweakToggle12  Auto Const
	GlobalVariable	Property TweakToggle13  Auto Const
	
	GlobalVariable	Property TweakToggle14  Auto Const
	GlobalVariable	Property TweakToggle15 Auto Const
	GlobalVariable	Property TweakToggle16  Auto Const
	
	GlobalVariable	Property TweakToggle17  Auto Const
	GlobalVariable	Property TweakToggle18  Auto Const
	GlobalVariable	Property TweakToggle19  Auto Const
	GlobalVariable	Property TweakToggle20  Auto Const
	
	GlobalVariable	Property TweakToggle21  Auto Const
	GlobalVariable	Property TweakToggle22  Auto Const
	GlobalVariable	Property TweakToggle23  Auto Const
	
	GlobalVariable	Property TweakToggle24  Auto Const
	GlobalVariable	Property TweakToggle25  Auto Const
	GlobalVariable	Property TweakToggle26  Auto Const
	GlobalVariable	Property TweakToggle27  Auto Const

EndGroup

bool Function Trace(string asTextToPrint, int aiSeverity = 0) debugOnly
	string logName = "TweakInitSayExistingScene"
	debug.OpenUserLog(logName)
	RETURN debug.TraceUser(logName, SceneName + ": " + asTextToPrint, aiSeverity)
EndFunction

Event OnBegin()
	Trace("OnBegin()")
	ProcessLookAhead()
EndEvent

; Typical Dialogue Flow
; 
;    NPC Line Opening Comment 4    NA (Too late, This is where this script runs...)
;      Player Choice A1            PCA1
;      Player Choice A2            PCA2
;      Player Choice A3            PCA3
;         NPC Reaction A1          NRA1
;         NPC Reaction A2          NRA2
;         NPC Reaction A3          NRA3
;         NPC Reaction A3          NRA4
;      Player Choice B1            PCB1
;      Player Choice B2            PCB2
;      Player Choice B3            PCB3
;         NPC Reaction B1          NRB1
;         NPC Reaction B2          NRB2
;         NPC Reaction B3          NRB3
;         NPC Reaction B3          NRB4
;      Player Choice C1            PCC1
;      Player Choice C2            PCC2
;      Player Choice C3            PCC3
;         NPC Reaction C1          NRC1
;         NPC Reaction C2          NRC2
;         NPC Reaction C3          NRC3
;         NPC Reaction B3          NRC4
;      Player Choice D1            PCD1
;      Player Choice D2            PCD2
;      Player Choice D3            PCD3
;         NPC Reaction D1          NRD1
;         NPC Reaction D2          NRD2
;         NPC Reaction D3          NRD3
;         NPC Reaction B3          NRD4

Function ProcessLookAhead()
	Trace("ProcessLookAhead")

	Topic check
	if TopicToggle0
		check = Game.GetForm(TopicToggle0) as Topic
		if check
			Trace("   TopicToggle0 : True")
			TweakToggle0.SetValue(1.0)
		else
			Trace("   TopicToggle0 : False")
			TweakToggle0.SetValue(0.0)
		endif
		if TopicToggle1
			check = Game.GetForm(TopicToggle1) as Topic
			if check
				Trace("   TopicToggle1 : True")
				TweakToggle1.SetValue(1.0)
			else
				Trace("   TopicToggle1 : False")
				TweakToggle1.SetValue(0.0)
			endif
			if TopicToggle2
				check = Game.GetForm(TopicToggle2) as Topic
				if check
					Trace("   TopicToggle2 : True")
					TweakToggle2.SetValue(1.0)
				else
					Trace("   TopicToggle2 : False")
					TweakToggle2.SetValue(0.0)
				endif
			else
				Trace("   TopicToggle2 : False")
				TweakToggle2.SetValue(0.0)
			endif
		else
			Trace("   TopicToggle1 : False")
			Trace("   TopicToggle2 : False")
			TweakToggle1.SetValue(0.0)
			TweakToggle2.SetValue(0.0)
		endif
	else
		Trace("   TopicToggle0 : False")
		Trace("   TopicToggle1 : False")
		Trace("   TopicToggle2 : False")
		TweakToggle0.SetValue(0.0)
		TweakToggle1.SetValue(0.0)
		TweakToggle2.SetValue(0.0)
	endif
	
	if TopicToggle3
		check = Game.GetForm(TopicToggle3) as Topic
		if check
			Trace("   TopicToggle3 : True")
			TweakToggle3.SetValue(1.0)
		else
			Trace("   TopicToggle3 : False")
			TweakToggle3.SetValue(0.0)
		endif
		if TopicToggle4
			check = Game.GetForm(TopicToggle4) as Topic
			if check
				Trace("   TopicToggle4 : True")
				TweakToggle4.SetValue(1.0)
			else
				Trace("   TopicToggle4 : False")
				TweakToggle4.SetValue(0.0)
			endif
			if TopicToggle5
				check = Game.GetForm(TopicToggle5) as Topic
				if check
					Trace("   TopicToggle5 : True")
					TweakToggle5.SetValue(1.0)
				else
					Trace("   TopicToggle5 : False")
					TweakToggle5.SetValue(0.0)
				endif
				if TopicToggle6
					check = Game.GetForm(TopicToggle6) as Topic
					if check
						Trace("   TopicToggle6 : True")
						TweakToggle6.SetValue(1.0)
					else
						Trace("   TopicToggle6 : False")
						TweakToggle6.SetValue(0.0)
					endif
				else
					Trace("   TopicToggle6 : False")
					TweakToggle6.SetValue(0.0)
				endif
			else
				Trace("   TopicToggle5 : False")
				Trace("   TopicToggle6 : False")
				TweakToggle5.SetValue(0.0)
				TweakToggle6.SetValue(0.0)
			endif
		else
			Trace("   TopicToggle4 : False")
			Trace("   TopicToggle5 : False")
			Trace("   TopicToggle6 : False")
			TweakToggle6.SetValue(0.0)
			TweakToggle6.SetValue(0.0)
			TweakToggle6.SetValue(0.0)
		endif
	else
		Trace("   TopicToggle3 : False")
		Trace("   TopicToggle4 : False")
		Trace("   TopicToggle5 : False")
		Trace("   TopicToggle6 : False")
		TweakToggle3.SetValue(0.0)
		TweakToggle4.SetValue(0.0)
		TweakToggle5.SetValue(0.0)
		TweakToggle6.SetValue(0.0)
	endif		
	
	; 7 - 9
	if TopicToggle7
		check = Game.GetForm(TopicToggle7) as Topic
		if check
			Trace("   TopicToggle7 : True")
			TweakToggle7.SetValue(1.0)
		else
			Trace("   TopicToggle7 : False")
			TweakToggle7.SetValue(0.0)
		endif
		if TopicToggle8
			check = Game.GetForm(TopicToggle8) as Topic
			if check
				Trace("   TopicToggle8 : True")
				TweakToggle8.SetValue(1.0)
			else
				Trace("   TopicToggle8 : False")
				TweakToggle8.SetValue(0.0)
			endif
			if TopicToggle9
				check = Game.GetForm(TopicToggle9) as Topic
				if check
					Trace("   TopicToggle9 : True")
					TweakToggle9.SetValue(1.0)
				else
					Trace("   TopicToggle9 : False")
					TweakToggle9.SetValue(0.0)
				endif
			else
				Trace("   TopicToggle9 : False")
				TweakToggle9.SetValue(0.0)
			endif
		else
			Trace("   TopicToggle8 : False")
			Trace("   TopicToggle9 : False")
			TweakToggle8.SetValue(0.0)
			TweakToggle9.SetValue(0.0)
		endif
	else
		Trace("   TopicToggle7 : False")
		Trace("   TopicToggle8 : False")
		Trace("   TopicToggle9 : False")
		TweakToggle7.SetValue(0.0)
		TweakToggle8.SetValue(0.0)
		TweakToggle9.SetValue(0.0)
	endif


	; 10 - 13
	if TopicToggle10
		check = Game.GetForm(TopicToggle10) as Topic
		if check
			Trace("   TopicToggle10 : True")
			TweakToggle10.SetValue(1.0)
		else
			Trace("   TopicToggle10 : False")
			TweakToggle10.SetValue(0.0)
		endif
		if TopicToggle11
			check = Game.GetForm(TopicToggle11) as Topic
			if check
				Trace("   TopicToggle11 : True")
				TweakToggle11.SetValue(1.0)
			else
				Trace("   TopicToggle11 : False")
				TweakToggle11.SetValue(0.0)
			endif
			if TopicToggle12
				check = Game.GetForm(TopicToggle12) as Topic
				if check
					Trace("   TopicToggle12 : True")
					TweakToggle12.SetValue(1.0)
				else
					Trace("   TopicToggle12 : False")
					TweakToggle12.SetValue(0.0)
				endif
				if TopicToggle13
					check = Game.GetForm(TopicToggle13) as Topic
					if check
						Trace("   TopicToggle13 : True")
						TweakToggle13.SetValue(1.0)
					else
						Trace("   TopicToggle13 : False")
						TweakToggle13.SetValue(0.0)
					endif
				else
					Trace("   TopicToggle13 : False")
					TweakToggle13.SetValue(0.0)
				endif
			else
				Trace("   TopicToggle12 : False")
				Trace("   TopicToggle13 : False")
				TweakToggle12.SetValue(0.0)
				TweakToggle13.SetValue(0.0)
			endif
		else
			Trace("   TopicToggle11 : False")
			Trace("   TopicToggle12 : False")
			Trace("   TopicToggle13 : False")
			TweakToggle13.SetValue(0.0)
			TweakToggle13.SetValue(0.0)
			TweakToggle13.SetValue(0.0)
		endif
	else
		Trace("   TopicToggle10 : False")
		Trace("   TopicToggle11 : False")
		Trace("   TopicToggle12 : False")
		Trace("   TopicToggle13 : False")
		TweakToggle10.SetValue(0.0)
		TweakToggle11.SetValue(0.0)
		TweakToggle12.SetValue(0.0)
		TweakToggle13.SetValue(0.0)
	endif
	
	;14 - 16
	if TopicToggle14
		check = Game.GetForm(TopicToggle14) as Topic
		if check
			Trace("   TopicToggle14 : True")
			TweakToggle14.SetValue(1.0)
		else
			Trace("   TopicToggle14 : False")
			TweakToggle14.SetValue(0.0)
		endif
		if TopicToggle15
			check = Game.GetForm(TopicToggle15) as Topic
			if check
				Trace("   TopicToggle15 : True")
				TweakToggle15.SetValue(1.0)
			else
				Trace("   TopicToggle15 : False")
				TweakToggle15.SetValue(0.0)
			endif
			if TopicToggle16
				check = Game.GetForm(TopicToggle16) as Topic
				if check
					Trace("   TopicToggle16 : True")
					TweakToggle16.SetValue(1.0)
				else
					Trace("   TopicToggle16 : False")
					TweakToggle16.SetValue(0.0)
				endif
			else
				Trace("   TopicToggle16 : False")
				TweakToggle16.SetValue(0.0)
			endif
		else
			Trace("   TopicToggle15 : False")
			Trace("   TopicToggle16 : False")
			TweakToggle15.SetValue(0.0)
			TweakToggle16.SetValue(0.0)
		endif
	else
		Trace("   TopicToggle14 : False")
		Trace("   TopicToggle15 : False")
		Trace("   TopicToggle16 : False")
		TweakToggle14.SetValue(0.0)
		TweakToggle15.SetValue(0.0)
		TweakToggle16.SetValue(0.0)
	endif
	
	; 17 - 20
	if TopicToggle17
		check = Game.GetForm(TopicToggle17) as Topic
		if check
			Trace("   TopicToggle17 : True")
			TweakToggle17.SetValue(1.0)
		else
			Trace("   TopicToggle17 : False")
			TweakToggle17.SetValue(0.0)
		endif
		if TopicToggle18
			check = Game.GetForm(TopicToggle18) as Topic
			if check
				Trace("   TopicToggle18 : True")
				TweakToggle18.SetValue(1.0)
			else
				Trace("   TopicToggle18 : False")
				TweakToggle18.SetValue(0.0)
			endif
			if TopicToggle19
				check = Game.GetForm(TopicToggle19) as Topic
				if check
					Trace("   TopicToggle19 : True")
					TweakToggle19.SetValue(1.0)
				else
					Trace("   TopicToggle19 : False")
					TweakToggle19.SetValue(0.0)
				endif
				if TopicToggle20
					check = Game.GetForm(TopicToggle20) as Topic
					if check
						Trace("   TopicToggle20 : True")
						TweakToggle20.SetValue(1.0)
					else
						Trace("   TopicToggle20 : False")
						TweakToggle20.SetValue(0.0)
					endif
				else
					Trace("   TopicToggle20 : False")
					TweakToggle20.SetValue(0.0)
				endif
			else
				Trace("   TopicToggle19 : False")
				Trace("   TopicToggle20 : False")
				TweakToggle19.SetValue(0.0)
				TweakToggle20.SetValue(0.0)
			endif
		else
			Trace("   TopicToggle18 : False")
			Trace("   TopicToggle19 : False")
			Trace("   TopicToggle20 : False")
			TweakToggle20.SetValue(0.0)
			TweakToggle20.SetValue(0.0)
			TweakToggle20.SetValue(0.0)
		endif
	else
		Trace("   TopicToggle17 : False")
		Trace("   TopicToggle18 : False")
		Trace("   TopicToggle19 : False")
		Trace("   TopicToggle20 : False")
		TweakToggle17.SetValue(0.0)
		TweakToggle18.SetValue(0.0)
		TweakToggle19.SetValue(0.0)
		TweakToggle20.SetValue(0.0)
	endif		
	
	; 21 - 23
	if TopicToggle21
		check = Game.GetForm(TopicToggle21) as Topic
		if check
			Trace("   TopicToggle21 : True")
			TweakToggle21.SetValue(1.0)
		else
			Trace("   TopicToggle21 : False")
			TweakToggle21.SetValue(0.0)
		endif
		if TopicToggle22
			check = Game.GetForm(TopicToggle22) as Topic
			if check
				Trace("   TopicToggle22 : True")
				TweakToggle22.SetValue(1.0)
			else
				Trace("   TopicToggle22 : False")
				TweakToggle22.SetValue(0.0)
			endif
			if TopicToggle23
				check = Game.GetForm(TopicToggle23) as Topic
				if check
					Trace("   TopicToggle23 : True")
					TweakToggle23.SetValue(1.0)
				else
					Trace("   TopicToggle23 : False")
					TweakToggle23.SetValue(0.0)
				endif
			else
				Trace("   TopicToggle23 : False")
				TweakToggle23.SetValue(0.0)
			endif
		else
			Trace("   TopicToggle22 : False")
			Trace("   TopicToggle23 : False")
			TweakToggle22.SetValue(0.0)
			TweakToggle23.SetValue(0.0)
		endif
	else
		Trace("   TopicToggle21 : False")
		Trace("   TopicToggle22 : False")
		Trace("   TopicToggle23 : False")
		TweakToggle21.SetValue(0.0)
		TweakToggle22.SetValue(0.0)
		TweakToggle23.SetValue(0.0)
	endif

	if TopicToggle24
		check = Game.GetForm(TopicToggle24) as Topic
		if check
			Trace("   TopicToggle24 : True")
			TweakToggle24.SetValue(1.0)
		else
			Trace("   TopicToggle24 : False")
			TweakToggle24.SetValue(0.0)
		endif
		if TopicToggle25
			check = Game.GetForm(TopicToggle25) as Topic
			if check
				Trace("   TopicToggle25 : True")
				TweakToggle25.SetValue(1.0)
			else
				Trace("   TopicToggle25 : False")
				TweakToggle25.SetValue(0.0)
			endif
			if TopicToggle26
				check = Game.GetForm(TopicToggle26) as Topic
				if check
					Trace("   TopicToggle26 : True")
					TweakToggle26.SetValue(1.0)
				else
					Trace("   TopicToggle26 : False")
					TweakToggle26.SetValue(0.0)
				endif
				if TopicToggle27
					check = Game.GetForm(TopicToggle27) as Topic
					if check
						Trace("   TopicToggle27 : True")
						TweakToggle27.SetValue(1.0)
					else
						Trace("   TopicToggle27 : False")
						TweakToggle27.SetValue(0.0)
					endif
				else
					Trace("   TopicToggle27 : False")
					TweakToggle27.SetValue(0.0)
				endif
			else
				Trace("   TopicToggle26 : False")
				Trace("   TopicToggle27 : False")
				TweakToggle26.SetValue(0.0)
				TweakToggle27.SetValue(0.0)
			endif
		else
			Trace("   TopicToggle25 : False")
			Trace("   TopicToggle26 : False")
			Trace("   TopicToggle27 : False")
			TweakToggle27.SetValue(0.0)
			TweakToggle27.SetValue(0.0)
			TweakToggle27.SetValue(0.0)
		endif
	else
		Trace("   TopicToggle24 : False")
		Trace("   TopicToggle25 : False")
		Trace("   TopicToggle26 : False")
		Trace("   TopicToggle27 : False")
		TweakToggle24.SetValue(0.0)
		TweakToggle25.SetValue(0.0)
		TweakToggle26.SetValue(0.0)
		TweakToggle27.SetValue(0.0)
	endif
	
EndFunction






