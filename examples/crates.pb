
; File for libsgd Version 0.18 Dec 2024 

XIncludeFile  "start.pb"

sgd_init()

ExamineDesktops()
sgd_CreateWindow (DesktopWidth(0)/2 , DesktopHeight(0)/2 , myAscii("Crates"), #WINDOW_FLAGS_CENTERED)

env = sgd_LoadCubeTexture(myAscii("..\assets\envmaps\sunnysky-cube.png"), #TEXTURE_FORMAT_ANY, #TEXTURE_FLAGS_DEFAULT)
sgd_SetEnvTexture (env)

skybox = sgd_CreateSkybox(env)
sgd_SetSkyboxRoughness (skybox, 0.3)

CreatePlayer(0)
sgd_MoveEntity (player,0,15,-25)

light = sgd_CreateDirectionalLight()
sgd_SetLightShadowsEnabled (light,#True)
sgd_TurnEntity (light,-90,0,0)

sz.f=32
groundMaterial = sgd_LoadPBRMaterial(myAscii("..\assets\misc\brownish-grass.jpg"))
groundMesh = sgd_CreateBoxMesh(-sz, -1, -sz, sz, 0, sz, groundMaterial)
sgd_TransformTexCoords (groundMesh, sz, sz, 0,0)
groundModel = sgd_CreateModel(groundMesh)

crateMesh = sgd_LoadMesh(myAscii("..\assets\models\sci-fi_crate.glb"))
sgd_SetMeshShadowsEnabled (crateMesh,#True)
sgd_FitMesh (CrateMesh,-0.4,-0.4,-0.4,0.4,0.4,0.4,#True)
For x=-20 To 20
	For z=-20 To 20
		crateModel = sgd_CreateModel(crateMesh)
		sgd_MoveEntity (crateModel,x*1.25,30-Sqr(x*x+z*z),z*1.25)
	Next
Next

While (sgd_PollEvents() And 1)<>1

	PlayerFly(0.1)

	sgd_RenderScene()
	sgd_Present()
Wend
; IDE Options = PureBasic 6.20 Beta 1 (Windows - x64)
; CursorPosition = 1
; EnableAsm
; EnableXP
; DPIAware