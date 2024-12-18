
; File for libsgd Version 0.18 Dec 2024 

XIncludeFile  "start.pb"

sgd_init()

ExamineDesktops()
sgd_CreateWindow (DesktopWidth(0)/2 , DesktopHeight(0)/2 , myAscii("La Tour Eiffel!"), #WINDOW_FLAGS_CENTERED)

;Create fog
fog = sgd_CreateFogEffect()
sgd_SetFogEffectColor (fog,0.3,0.6,1,1)
sgd_SetFogEffectPower (fog,2)

light = sgd_CreateDirectionalLight()
sgd_SetLightShadowsEnabled (light,#True)
sgd_SetEntityRotation (light,-30,0,0)

env =  sgd_LoadCubeTexture(myAscii("..\assets\envmaps\sunnysky-cube.png"),#TEXTURE_FORMAT_ANY,#TEXTURE_FLAGS_DEFAULT)
sgd_SetEnvTexture (env)

sgd_SetClearColor (0.3,0.6,1,1)

; Actual height of eiffel tower, fact fans!
sz.f=330

sgd_SetConfigVar (myAscii("csm.clipRange"),myAscii(StrF (sz*2)))
sgd_UpdateShadowMappingConfig()

groundMaterial = sgd_LoadPBRMaterial(myAscii("..\assets\misc\grass1K.jpg"))
sgd_SetMaterialFloat (groundMaterial,myAscii("roughness"),1)

groundMesh = sgd_CreateBoxMesh(-sz,0,-sz,sz,0,sz,groundMaterial)
sgd_TransformTexCoords (groundMesh,sz,sz,0,0)
ground = sgd_CreateModel(groundMesh)
sgd_CreateMeshCollider(ground, 0, 0)

towerMesh = sgd_LoadMesh(myAscii("..\assets\models\eiffel_tower.glb"))
sgd_SetMeshShadowsEnabled (towerMesh,#True)
sgd_FitMesh(towerMesh,-sz/2,0,-sz/2,sz/2,sz,sz/2,#True)
tower = sgd_CreateModel(towerMesh)
sgd_CreateMeshCollider(tower, 0, 0)

createPlayer(0)
sgd_MoveEntity( player,0,1,0)
sgd_CreateSphereCollider(player, 1, 1);

sgd_EnableCollisions (1,0,2)

While (sgd_PollEvents() And 1)<>1

	PlayerFly(0.25)
	
	sgd_RotateEntity (light,0,0.025,0)
	
	sgd_UpdateColliders()
	
	sgd_Clear2D()
	;Draw2DText "FPS:"+GetFPS(),0,0
	sgd_Draw2DText (myAscii("FPS:"+StrF(sgd_GetFPS(),1)),0,0)
	sgd_RenderScene()
	
	sgd_Present()
Wend
; IDE Options = PureBasic 6.20 Beta 1 (Windows - x64)
; CursorPosition = 1
; EnableAsm
; EnableXP
; DPIAware