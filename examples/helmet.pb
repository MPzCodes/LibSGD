
; File for libsgd Version 0.17 Dec 2024 

XIncludeFile "start.pb"

Titel.s = "Helmet!"
Pfad.s = "..\assets\envmaps\sunnysky-cube.png"

sgd_init()

ExamineDesktops()
sgd_CreateWindow (DesktopWidth(0)/2 , DesktopHeight(0)/2 , myAscii(Titel), #WINDOW_FLAGS_CENTERED)

env = sgd_LoadCubeTexture(myAscii(Pfad),#TEXTURE_FORMAT_ANY,#TEXTURE_FLAGS_DEFAULT)

sgd_SetEnvTexture(env)

skybox = sgd_CreateSkybox(env)
sgd_SetSkyboxRoughness (skybox, 0.3)

light = sgd_CreateDirectionalLight()
sgd_TurnEntity (light,-45,0,0	) ; Tilt light down 45 degrees 

material = sgd_LoadPBRMaterial(myAscii("..\assets\materials\Tiles019_1K-JPG"))
mesh = sgd_CreateBoxMesh(-10,-3,-10,10,-2,10,material)
sgd_TransformTexCoords (mesh,3,3,0,0)
ground = sgd_CreateModel(mesh)

mesh = sgd_LoadMesh(myAscii("..\assets\models\helmet.glb"))
model=sgd_CreateModel(mesh)
sgd_MoveEntity (model,0,0,3)

While Not sgd_PollEvents()

	If sgd_IsKeyDown(263)
		sgd_TurnEntity (model,0,3,0)
	ElseIf sgd_IsKeyDown(262)
		sgd_TurnEntity (model,0,-3,0)
	EndIf
	
	If sgd_IsKeyDown(264)
		sgd_TurnEntity (model,3,0,0)
	ElseIf sgd_IsKeyDown(265)
		sgd_TurnEntity (model,-3,0,0)
	EndIf
	
	sgd_RenderScene()
	
	sgd_Present()
	
Wend
; IDE Options = PureBasic 6.20 Beta 1 (Windows - x64)
; CursorPosition = 28
; EnableAsm
; EnableXP
; DPIAware