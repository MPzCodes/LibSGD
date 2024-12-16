
; File for libsgd Version 0.17 Dec 2024 

XIncludeFile  "start.pb"

sgd_init()

ExamineDesktops()
sgd_CreateWindow (DesktopWidth(0)/2 , DesktopHeight(0)/2 , myAscii("Blend test"), #WINDOW_FLAGS_CENTERED)


sgd_SetAmbientLightColor (1,1,1,0.2)

env =  sgd_LoadCubeTexture(myAscii("..\assets\envmaps\stormy-cube.jpg"), #TEXTURE_FORMAT_ANY, #TEXTURE_FLAGS_DEFAULT)
sgd_SetEnvTexture (env)
sgd_CreateSkybox (env)

light = sgd_CreateDirectionalLight()
sgd_SetEntityRotation (light,-45,-45,0)

mesh = sgd_LoadMesh(myAscii("..\assets\models\blendtest.glb"))
sgd_FitMesh (mesh,-0.5,-0.5,-0.5,0.5,0.5,0.5,#True)

cells = 5
spc.f= 2
halfsz.f = cells*spc/2

Structure Model
	entity.i
EndStructure 

NewList ModelList.Model()

For x = 0 To cells-1
	For y=0 To cells-1
	  For z=0 To cells-1
	    AddElement(ModelList())
	    ModelList()\entity = sgd_CreateModel(mesh)
			sgd_MoveEntity (ModelList()\entity,x*spc-halfsz, y*spc-halfsz,z*spc-halfsz)
		Next
	Next
Next

CreatePlayer(0)
sgd_MoveEntity (player,0,0,-halfsz)

While Not (sgd_PollEvents() And #EVENT_MASK_CLOSE_CLICKED)

	RandomSeed (1234)
	
  ForEach ModelList()
		sgd_TurnEntity (ModelList()\entity,(Random(14,0)-7)/10,(Random(6,0)-3)/10,0)
	Next
	
	PlayerFly(0.125)
	
	sgd_RenderScene()
	sgd_Present()

Wend
; IDE Options = PureBasic 6.20 Beta 1 (Windows - x64)
; CursorPosition = 20
; EnableAsm
; EnableXP
; DPIAware