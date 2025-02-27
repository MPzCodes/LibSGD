
; File for libsgd Version 0.17 Dec 2024 
;
; Version 0.1, customisation to ASCII Code

XIncludeFile  "start.pb"

sgd_init()

ExamineDesktops()
sgd_CreateWindow (DesktopWidth(0)/2 , DesktopHeight(0)/2 , "Some nice trees", #WINDOW_FLAGS_CENTERED)

light = sgd_CreateDirectionalLight()
sgd_RotateEntity (light,-45,0,0)

env =  sgd_LoadCubeTexture("..\assets\envmaps\sunnysky-cube.png",#TEXTURE_FORMAT_ANY,#TEXTURE_FLAGS_DEFAULT)
sgd_SetEnvTexture( env)

skybox = sgd_CreateSkybox(env)

groundMaterial = sgd_LoadPBRMaterial("..\assets\misc\brownish-grass.jpg")
groundPlane = sgd_CreatePlane(groundMaterial)

sz.f=200

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
sgd_SetEntityName (player,"Player")
sgd_SetEntityName (camera,"Camera")

;Save scene to desktop!
sgd_SaveScene ("~/Desktop/test-scene.json")


; The purpose of the programme is to delete the Scene with sgd_ResetScene and then load it again with sgd_LoadScene. I am looking for a solution MPz...

;- here it crashes, problem will solved
;Destroy scene
; sgd_ResetScene (#True) 

;Load scene from desktop!
; sgd_LoadScene ("~/Desktop/test-scene2.json")
;- end of here

;createPlayer(0)
;MoveEntity player,0,10,0
player=sgd_FindEntityChild(0,"Player")
camera=sgd_FindEntityChild(0,"Camera")

While sgd_PollEvents()<>1
	PlayerFly(0.05)
	sgd_RenderScene()
	sgd_Clear2D()
	;Draw2DText "FPS:"+GetFPS(),0,0
	sgd_Draw2DText ("FPS:"+StrF(sgd_GetFPS(),1),0,0)
	sgd_Present()
Wend
; IDE Options = PureBasic 6.20 Beta 1 (Windows - x64)
; CursorPosition = 4
; EnableAsm
; EnableXP
; DPIAware
; IDE Options = PureBasic 6.20 (Windows - x64)
; CursorPosition = 7
; EnableAsm
; EnableXP
; DPIAware