
XIncludeFile  "start.pb"

sgd_init()



; sequence# | frames |	description 
; ---------	 ------   -----------
; 0				 72 	 	death
; 1 			 60 		idle	
; 2     		 27 	   jump
; 3 			 17			run_fast
; 4				 21 		run_left
; 5 			 21			run_right
; 6 			 23 		run_slow
; 7 			 36 		standard_walk
; 8 			 32 		walk
; 9 			 32 		walk_left
; 10 		    29			walk_right				 	  			

;time0.f,time0Step.f ;base animation
;seq1,time1 #,time1Step #	;blend target
;blend #, blendStep #
useBlend=1

seq0 = 1	;initially idle
time0Step.f = 0.02

ExamineDesktops()
sgd_CreateWindow (DesktopWidth(0)/2 , DesktopHeight(0)/2 , myAscii("Animation Blender"), #WINDOW_FLAGS_CENTERED)

camera = sgd_CreatePerspectiveCamera()
sgd_MoveEntity (camera,0,1,-3)

light = sgd_CreateDirectionalLight()
sgd_TurnEntity (light,-35,0,0)

model = sgd_LoadBonedModel (myAscii("sgd://models/base_male_animated.glb"),#True)

While Not (sgd_PollEvents() And #EVENT_MASK_CLOSE_CLICKED)

	If sgd_IsKeyHit(#KEY_SPACE) : useBlend = 1 - useBlend : EndIf
	
	;Select new anim
	nseq=1
	If sgd_IsKeyDown(#KEY_LEFT_SHIFT)
		;Run
		If sgd_IsKeyDown(#KEY_UP)
			nseq=6
		ElseIf sgd_IsKeyDown(#KEY_LEFT)
			nseq=5
		ElseIf sgd_IsKeyDown(#KEY_RIGHT)
			nseq=4
		EndIf
	Else
		;Walk
		If sgd_IsKeyDown(#KEY_UP)
			nseq=8
		ElseIf sgd_IsKeyDown(#KEY_LEFT)
			nseq=10
		ElseIf sgd_IsKeyDown(#KEY_RIGHT)
			nseq=9
		EndIf
	EndIf
	
	;Change to new anim
	If blendStep.f = 0 And seq0 <> nseq
		If useBlend
			time0Step = 0
			seq1 = nseq
			time1.f = 0
			time1Step.f = 0.02
			blendStep = 0.1
		Else
			seq0 = nseq
			time0.f = 0
			time0Step = 0.02
		EndIf
	EndIf
	
	;Update blend state
	blend.f = blend + blendStep
	If blend >= 1
		seq0 = seq1
		time0  = time1
		time0Step = time1Step
		time1 = 0
		time1Step = 0
		blend = 0
		blendStep = 0
	EndIf
	
	;Set base animation
	time0 = time0 + time0Step
	sgd_AnimateModel (model,seq0,time0,2,1)
	
	If blend>0 
		;Appy blend
		time1 = time1 + time1Step
		sgd_AnimateModel (model,seq1,time1,2,blend)
	EndIf
	
	sgd_Clear2D()
	sgd_Draw2DText (myAscii("Arrow keys/Shift to run. Using blend:"+useBlend+" (space to toggle)"),0,0)
	
	sgd_RenderScene()
	
	sgd_Present()
Wend 
; IDE Options = PureBasic 6.12 LTS (Windows - x64)
; CursorPosition = 73
; FirstLine = 52
; EnableAsm
; EnableXP
; DPIAware