
; File for libsgd Version 0.18 Dec 2024 

XIncludeFile  "start.pb"

sgd_init()

ExamineDesktops()
sgd_CreateWindow (DesktopWidth(0)/2 , DesktopHeight(0)/2 , "La Tour Eiffel!", #WINDOW_FLAGS_CENTERED)

;Local light = CreateDirectionalLight()
;SetLightShadowMappingEnabled light,True
;SetEntityRotation light,-30,0,0

sgd_SetAmbientLightColor (0.01, 0.01, 0.05, 1.0)

pivot = sgd_CreateModel (0)
Dim rgb_light (3)
For LooPs = 0 To 2
	rgb_light(LooPs) = sgd_CreatePointLight()
	sgd_SetLightShadowsEnabled (rgb_light (LooPs),#True)
	sgd_SetLightRange (rgb_light (LooPs), 150)
	sgd_TurnEntity (rgb_light (LooPs), 0, LooPs * 120, 0)
	sgd_MoveEntity (rgb_light (LooPs), 0, LooPs * 100, 100 + LooPs * 10)
	sgd_SetEntityParent (rgb_light (LooPs), pivot)
Next

sgd_SetLightColor (rgb_light (0), 255, 0, 0, 1)
sgd_SetLightColor (rgb_light (1), 0, 255, 0, 1)
sgd_SetLightColor (rgb_light (2), 0, 0, 255, 1)

env =  sgd_LoadCubeTexture("..\assets\envmaps\nightsky-cube.png",#TEXTURE_FORMAT_ANY,#TEXTURE_FLAGS_DEFAULT)
sgd_SetEnvTexture (env)

skybox = sgd_CreateSkybox(env)

sz.f=1000
groundMaterial = sgd_LoadPBRMaterial("..\assets\misc\brownish-grass.jpg")
groundMesh = sgd_CreateBoxMesh(-sz/2,-1,-sz/2,sz/2,0,sz/2,groundMaterial)
sgd_TransformTexCoords (groundMesh,sz,sz,0,0)
ground = sgd_CreateModel(groundMesh)
sgd_CreateMeshCollider(ground, 0, 0)

sz=330
towerMesh = sgd_LoadMesh("..\assets\models\eiffel_tower.glb")
sgd_SetMeshShadowsEnabled (towerMesh,#True)
sgd_FitMesh(towerMesh,-sz/2,0,-sz/2,sz/2,sz,sz/2,#True)
tower = sgd_CreateModel(towerMesh)
sgd_CreateMeshCollider(tower, 0, 0)

createPlayer(0)
sgd_MoveEntity (player,0,1,0)
sgd_CreateSphereCollider(player, 1, 1);

sgd_EnableCollisions (1,0,2)

While (sgd_PollEvents() And 1)<>1

	PlayerFly(0.25)
	
	sgd_TurnEntity (pivot, 0, 0.5, 0)
;	RotateEntity light,0,.025,0
	
	sgd_UpdateColliders()
	
	sgd_RenderScene()
	
	sgd_Clear2D()
	;Draw2DText "FPS:"+GetFPS(),0,0
	sgd_Draw2DText ("FPS:"+StrF(sgd_GetFPS(),1),0,0)
	sgd_Present()
Wend
; IDE Options = PureBasic 6.12 LTS (Windows - x64)
; CursorPosition = 69
; FirstLine = 14
; EnableAsm
; EnableXP
; DPIAware