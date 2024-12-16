
; File for libsgd Version 0.17 Dec 2024 

XIncludeFile  "start.pb"

sgd_init()

ExamineDesktops()
sgd_CreateWindow (DesktopWidth(0)/2 , DesktopHeight(0)/2 , myAscii("Hello World"), #WINDOW_FLAGS_CENTERED)

env = sgd_LoadCubeTexture(myAscii("..\assets\envmaps\sunnysky-cube.png"),#TEXTURE_FORMAT_ANY,#TEXTURE_FLAGS_DEFAULT)

sgd_SetEnvTexture (env)

skybox = sgd_CreateSkybox(env)
sgd_SetSkyboxRoughness (skybox, 0.3)

sgd_Clear2D()

sgd_Draw2DText (myAscii("Hello World!"),0,0)

; Draw some lines
;Set2DLineWidth 5


For i=1 To 100
	sgd_Set2DFillColor (Random(1),Random(1),Random(1),1)
	sgd_Draw2DLine (Random(1920), Random(1080), Random(1920), Random(1080))
Next

sgd_Set2DOutlineEnabled (#True)

; Draw some outlined rects
For i=1 To 100
	w=Random(64,32)
	h=Random(64,32)
	x=Random(1920-w)
	y=Random(1080-h)
	sgd_Set2DFillColor (Random(1),Random(1),Random(1),1)
	sgd_Draw2DRect (x, y, x+w, y+h)
Next

sgd_Set2DOutlineColor (0,255,0,1)

; Draw some ovals
For i=1 To 100
	w=Random(64,32)
	h=Random(62,32)
	x=Random(1920-w)
	y=Random(1080-h)
	sgd_Set2DFillColor (Random(1),Random(1),Random(1),1)
	sgd_Draw2DOval (x, y, x+w, y+h)
Next

While (sgd_PollEvents() And 1) = 0
	
	sgd_RenderScene()
	
	sgd_Present()

Wend
; IDE Options = PureBasic 6.20 Beta 1 (Windows - x64)
; CursorPosition = 10
; EnableAsm
; EnableXP
; DPIAware