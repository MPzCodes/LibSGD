
XIncludeFile  "start.pb"

sgd_init()

ExamineDesktops()
sgd_CreateWindow (DesktopWidth(0)/2 , DesktopHeight(0)/2 , myAscii("Primitives"), #WINDOW_FLAGS_CENTERED)

env = sgd_LoadCubeTexture(myAscii("sgd://envmaps/sunnysky-cube.png"),#TEXTURE_FORMAT_ANY,#TEXTURE_FLAGS_DEFAULT)
sgd_SetEnvTexture (env)

skybox = sgd_CreateSkybox(env)
sgd_SetSkyboxRoughness (skybox, 0.3)

sgd_SetConfigVar (myAscii("psm.textureSize"), myAscii(Str(4096)))
sgd_SetConfigVar (myAscii("psm.maxLights"), myAscii(Str(6)))
sgd_UpdateShadowMappingConfig()

light0 = sgd_CreatePointLight()
sgd_SetEntityPosition (light0,0,5,-2.5)
sgd_SetLightRange (light0, 10)
sgd_SetLightShadowsEnabled (light0,#True)

groundMaterial = sgd_CreatePBRMaterial()
SGD_SetMaterialColor (groundMaterial,myAscii("albedo"),1,0.75,0,1)
;SGD_SetMaterialColor (groundMaterial,"albedo",1,0.75,0,1)

groundMesh = sgd_CreateBoxMesh(-5,-0.1,-5,5,0,5,groundMaterial)
sgd_SetMeshShadowsEnabled (groundMesh, #True)

groundModel = sgd_CreateModel(groundMesh)

material = sgd_LoadPBRMaterial(myAscii("sgd://materials/Fabric050_1K-JPG"))

r.f = 0.5
y.f = 1.5

CreatePlayer(0)
sgd_MoveEntity (player,0,y,-5)

mesh0 = sgd_CreateSphereMesh(r, 96, 48, material)
sgd_SetMeshShadowsEnabled (mesh0, #True)
model0 = sgd_CreateModel(mesh0)
sgd_MoveEntity (model0, -2.5, y, 0)

r2.f=r*0.7071
mesh1 = sgd_CreateBoxMesh(-r2, -r2, -r2, r2, r2, r2, material)
sgd_SetMeshShadowsEnabled (mesh1, #True)
model1 = sgd_CreateModel(mesh1)
sgd_MoveEntity (model1, -1.25, y, 0)

mesh2 = sgd_CreateCylinderMesh(r * 2, r / 2, 96, material)
sgd_SetMeshShadowsEnabled (mesh2, #True)
model2 = sgd_CreateModel(mesh2)
sgd_MoveEntity (model2, 0, y, 0)

mesh3 = sgd_CreateConeMesh(r * 2, r / 2, 96, material)
sgd_SetMeshShadowsEnabled (mesh3, #True)
model3 = sgd_CreateModel(mesh3)
sgd_MoveEntity (model3, 1.25, y, 0)

mesh4 = sgd_CreateTorusMesh(r * 0.75, r * 0.25, 96, 48, material)
sgd_SetMeshShadowsEnabled (mesh4, #True)
model4 = sgd_CreateModel(mesh4)
sgd_MoveEntity (model4, 2.5, y, 0)

collider0=sgd_CreateMeshCollider(model0,0,0)
collider1=sgd_CreateMeshCollider(model1,0,0)
collider2=sgd_CreateMeshCollider(model2,0,0)
collider3=sgd_CreateMeshCollider(model3,0,0)
collider4=sgd_CreateMeshCollider(model4,0,0)

sgd_Set2DTextColor (0,0,0,1)

cursorMesh = sgd_CreateSphereMesh(0.01, 32,16,sgd_CreatePBRMaterial())
cursor= sgd_CreateModel(cursorMesh)
sgd_SetModelColor (cursor, 0, 1, 0, 1)

While (sgd_PollEvents() And 1) <> 1

	sgd_TurnEntity (model0, 0.3, 0.4, 0.5)
	sgd_TurnEntity (model1, 0.3, 0.4, 0.5)
	sgd_TurnEntity (model2, 0.3, 0.4, 0.5)
	sgd_TurnEntity (model3, 0.3, 0.4, 0.5)
	sgd_TurnEntity (model4, 0.3, 0.4, 0.5) 
	
	If sgd_IsKeyHit(49) : sgd_SetEntityVisible (model0, ~sgd_IsEntityVisible(model0)+2) : EndIf
	If sgd_IsKeyHit(50) : sgd_SetEntityVisible (model1, ~sgd_IsEntityVisible(model1)+2) : EndIf
	If sgd_IsKeyHit(51) : sgd_SetEntityVisible (model2, ~sgd_IsEntityVisible(model2)+2) : EndIf
	If sgd_IsKeyHit(52) : sgd_SetEntityVisible (model3, ~sgd_IsEntityVisible(model3)+2) : EndIf
	If sgd_IsKeyHit(53) : sgd_SetEntityVisible (model4, ~sgd_IsEntityVisible(model4)+2) : EndIf
	
	PlayerFly(0.05)
	
	collider = sgd_CameraPick(camera,sgd_GetMouseX(),sgd_GetMouseY(),1)
	
	sgd_Clear2D()
	sgd_Draw2DText (myAscii("Picked collider:" + collider),0,0)
	
	sgd_CameraUnproject (camera, sgd_GetMouseX(), sgd_GetMouseY(), 1)
	sgd_SetEntityPosition (cursor, sgd_GetUnprojectedX(), sgd_GetUnprojectedY(), sgd_GetUnprojectedZ())
	
	sgd_RenderScene()
	sgd_Present()
Wend
; IDE Options = PureBasic 6.12 LTS (Windows - x64)
; CursorPosition = 86
; FirstLine = 47
; EnableAsm
; EnableXP
; DPIAware