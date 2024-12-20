
; File for libsgd Version 0.18 Dec 2024 

XIncludeFile  "start.pb"

Declare.i LoadScene()

sgd_init()


Global camera
Global model

ExamineDesktops()
sgd_CreateWindow (DesktopWidth(0)/2 , DesktopHeight(0)/2 , myAscii("Cesium Man"), #WINDOW_FLAGS_CENTERED)

LoadScene()

;Cheesy sepia-tone render effect!
monocolor = sgd_CreateMonocolorEffect()
sgd_SetMonocolorEffectColor (monocolor, 1,1,0.75,1)

atime.f=0
While Not (sgd_PollEvents() And #EVENT_MASK_CLOSE_CLICKED)
	If sgd_IsKeyDown(263)
		sgd_TurnEntity (model,0,3,0)
	ElseIf sgd_IsKeyDown(262)
		sgd_TurnEntity (model,0,-3,0)
	EndIf
	
	If sgd_IsKeyDown(264)
		sgd_MoveEntity (model,0,0,0.03)
	ElseIf sgd_IsKeyDown(265)
		sgd_MoveEntity (model,0,0,-0.03)
	EndIf

	atime = atime + 0.03
	sgd_AnimateModel (model,0,atime,2,1)
	
	sgd_RenderScene()
	sgd_Present()
Wend

Procedure LoadScene()

	env = sgd_LoadCubeTexture(myAscii("..\assets\envmaps\sunnysky-cube.png"), #TEXTURE_FORMAT_ANY, #TEXTURE_FLAGS_DEFAULT)
	sgd_SetEnvTexture (env)

	skybox = sgd_CreateSkybox(env)
	sgd_SetSkyboxRoughness (skybox,0.3)

	light = sgd_CreateDirectionalLight()
	sgd_SetLightShadowsEnabled (light, #True)
	sgd_TurnEntity (light,-30,0,0	); Tilt light down 30 degrees 

	camera = sgd_CreatePerspectiveCamera()
	sgd_MoveEntity (camera,0,1,-5)
	
	material = sgd_LoadPBRMaterial(myAscii("..\assets\materials\PavingStones065_1K-JPG")) ; Loaderror... search error
	mesh = sgd_CreateBoxMesh(-10, -1, -10, 10, 0, 10, material)
	sgd_TransformTexCoords (mesh, 4,4,0,0)
	ground = sgd_CreateModel(mesh)
	
	model = sgd_LoadBonedModel(myAscii("..\assets\models\cesiumman.glb"), #True)
	sgd_SetMeshShadowsEnabled (sgd_GetModelMesh(model),#True)

EndProcedure
; IDE Options = PureBasic 6.20 Beta 1 (Windows - x64)
; CursorPosition = 58
; FirstLine = 10
; Folding = -
; EnableAsm
; EnableXP
; DPIAware
