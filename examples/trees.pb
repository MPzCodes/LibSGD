
; File for libsgd Version 0.18 Dec 2024 
;
; Version 0.1, customisation to ASCII Code

XIncludeFile  "start.pb"
	
sgd_init()

ExamineDesktops()
sgd_CreateWindow (DesktopWidth(0)/2 , DesktopHeight(0)/2 , "Some nice trees", #WINDOW_FLAGS_CENTERED)

light = sgd_CreateDirectionalLight()
sgd_RotateEntity (light,-45,0,0)

env =  sgd_LoadCubeTexture("..\assets\envmaps\sunnysky-cube.png",#TEXTURE_FORMAT_ANY,#TEXTURE_FLAGS_DEFAULT)
sgd_SetEnvTexture ( env )

skybox = sgd_CreateSkybox(env)

sz.f=200
groundMaterial = sgd_LoadPBRMaterial("..\assets\misc\brownish-grass.jpg")
groundMesh = sgd_CreateBoxMesh(-sz,-1,-sz,sz,0,sz,groundMaterial)
sgd_TransformTexCoords (groundMesh,sz,sz,0,0)
ground = sgd_CreateModel(groundMesh)

Dim treeMeshes(3)
treeMeshes(0) = sgd_LoadMesh("..\assets\models\tree1.glb")
treeMeshes(1) = sgd_LoadMesh("..\assets\models\palm_tree1.glb")
treeMeshes(2) = sgd_LoadMesh("..\assets\models\birch_tree1.glb")

n=10000
For i=1 To n
	treeModel = sgd_CreateModel(treeMeshes(Random(2,0)))
	sgd_MoveEntity (treeModel,Random(2*sz,0)-sz,0,Random(2*sz,0)-sz)
Next

createPlayer(0)
sgd_MoveEntity (player,0,10,0)

While sgd_PollEvents()<>1
	PlayerFly(0.125)
	sgd_RenderScene()
	sgd_Clear2D()
	sgd_Draw2DText ("FPS:"+StrF(sgd_GetFPS(),1),0,0)
	sgd_Draw2DText ("RPS:"+StrF(sgd_GetRPS(),1),0,16)
	sgd_Present()
Wend
; IDE Options = PureBasic 6.12 LTS (Windows - x64)
; CursorPosition = 45
; EnableAsm
; EnableXP
; DPIAware
; Compiler = PureBasic 6.12 LTS (Windows - x64)