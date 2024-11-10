XIncludeFile  "start.pb"

sgd_init()

ExamineDesktops()
sgd_CreateWindow (DesktopWidth(0)/2 , DesktopHeight(0)/2 , myAscii("Some nice trees"), #WINDOW_FLAGS_CENTERED)

light = sgd_CreateDirectionalLight()
sgd_RotateEntity (light,-45,0,0)

env =  sgd_LoadCubeTexture(myAscii("sgd://envmaps/sunnysky-cube.png"),#TEXTURE_FORMAT_ANY,#TEXTURE_FLAGS_DEFAULT)
sgd_SetEnvTexture( env)

skybox = sgd_CreateSkybox(env)

groundMaterial = sgd_LoadPBRMaterial(myAscii("sgd://misc/brownish-grass.jpg"))
groundPlane = sgd_CreatePlane(groundMaterial)

sz.f=200

Dim treeMeshes(3)
treeMeshes(0) = sgd_LoadMesh(myAscii("sgd://models/tree1.glb"))
treeMeshes(1) = sgd_LoadMesh(myAscii("sgd://models/palm_tree1.glb"))
treeMeshes(2) = sgd_LoadMesh(myAscii("sgd://models/birch_tree1.glb"))

n=10000
For i=1 To n
	treeModel = sgd_CreateModel(treeMeshes(Random(2,0)))
	sgd_MoveEntity (treeModel,Random(2*sz,0)-sz,0,Random(2*sz,0)-sz)
Next


createPlayer(0)
sgd_MoveEntity (player,0,10,0)
sgd_SetEntityName (player,myAscii("Player"))
sgd_SetEntityName (camera,myAscii("Camera"))

;Save scene to desktop!
;- sgd_SaveScene (myAscii("~/Desktop/test-scene.json"))
sgd_SaveScene (myAscii("c:\not_installed\1\test-scene.json"))

;Destroy scene
;- sgd_ResetScene (#True)
sgd_ResetScene (#True)

;Load scene from desktop!
;- sgd_LoadScene (myAscii("~/Desktop/test-scene.json"))
sgd_LoadScene (myAscii("c:\not_installed\1\test-scene.json"))

;createPlayer(0)
;MoveEntity player,0,10,0
player=sgd_FindEntityChild(0,myAscii("Player"))
camera=sgd_FindEntityChild(0,myAscii("Camera"))

While sgd_PollEvents()<>1
	PlayerFly(0.05)
	sgd_RenderScene()
	sgd_Clear2D()
	;Draw2DText "FPS:"+GetFPS(),0,0
	sgd_Draw2DText (myAscii("FPS:"+StrF(sgd_GetFPS(),1)),0,0)
	sgd_Present()
Wend
; IDE Options = PureBasic 6.12 LTS (Windows - x64)
; CursorPosition = 47
; FirstLine = 1
; EnableAsm
; EnableXP
; DPIAware