
; File for libsgd Version 0.18 Dec 2024 

;Use space to toggle sprite view modes.
;
; Version 0.1, customisation to ASCII Code

XIncludeFile  "start.pb"

sgd_init()

ExamineDesktops()
sgd_CreateWindow (DesktopWidth(0)/2 , DesktopHeight(0)/2 , "Sprite Grass", #WINDOW_FLAGS_CENTERED)

env = sgd_LoadCubeTexture("..\assets\envmaps\sunnysky-cube.png",#TEXTURE_FORMAT_ANY,#TEXTURE_FLAGS_DEFAULT)
sgd_SetEnvTexture (env)
skybox = sgd_CreateSkybox(env)

light = sgd_CreateDirectionalLight()
sgd_TurnEntity (light,-45,0,0)	; Tilt light down 45 degrees 

far.f=300

CreatePlayer(0)
sgd_SetCameraFar (camera, far)
sgd_MoveEntity (player,0,1.5,0)

grassImage = sgd_LoadImage("..\assets\misc\grass1.png")
sgd_SetImageRect (grassImage,-0.5,0,0.5,0.5)

n=50000

For i=0 To n

	sprite = sgd_CreateSprite(grassImage)
	
	sgd_TurnEntity(sprite,0,Random(360),0)
	sgd_MoveEntity(sprite,0,0,Random(far))
	
	sc.f=Random(1,0.1)
	sgd_ScaleEntity (sprite,sc,sc,sc)
Next

viewMode = 1 
sgd_SetImageViewMode (grassImage,viewMode)

While Not sgd_PollEvents()
  
  PlayerFly(0.1)
	
	sgd_Clear2D()
	If sgd_IsKeyHit(#KEY_SPACE)
		viewMode = viewMode + 1
		If viewMode=4 : viewMode=1 : EndIf
		sgd_SetImageViewMode (grassImage,viewMode)
	EndIf
	
	sgd_Draw2DText ("Sprite View mode:"+viewMode+" (space to toggle)",0,0)
	
	sgd_RenderScene()
	sgd_Present()
Wend
; IDE Options = PureBasic 6.12 LTS (Windows - x64)
; CursorPosition = 6
; FirstLine = 2
; EnableAsm
; EnableXP
; DPIAware