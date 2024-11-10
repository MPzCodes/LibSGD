
XIncludeFile  "start.pb"

#NUM_BLOCKS = 25000
#WORLD_SIZE = 100

Structure Block
	model.i
	xr.f
	yr.f
EndStructure

Global NewList Block.Block()

Structure Bullet
	entity.i
	timeout.i
	vz.f
EndStructure

Global NewList Bullet.Bullet()

Global bulletImage
Global slimeball

Declare.i CreateScene()
Declare.i UpdateBullets()
Declare.i UpdateBlocks()
Declare.i CreateGround()
Declare.i CreateBlocks()
	
sgd_init()

ExamineDesktops()
sgd_CreateWindow (DesktopWidth(0)/2 , DesktopHeight(0)/2 , myAscii("25000 Blocks"), #WINDOW_FLAGS_CENTERED)

CreateScene()

While Not (sgd_PollEvents() And #EVENT_MASK_CLOSE_CLICKED)

	If sgd_IsKeyHit(#KEY_ESCAPE)
		CreateScene()
	EndIf
	
	PlayerFly(0.25)
	
	UpdateBullets()
	
	UpdateBlocks()
	
	sgd_Clear2D()
	sgd_Draw2DText (myAscii("FPS:"+StrF(sgd_GetFPS(),1)),0,0)
	sgd_RenderScene()
	
	sgd_Present()
Wend

Procedure CreateScene() 
  
  Static env, skybox, light
  
  ClearList(Bullet()) 
  ClearList(Block()) 

	sgd_ResetScene (#True)
	
	env =  sgd_LoadCubeTexture(myAscii("sgd://envmaps/stormy-cube.jpg"), #TEXTURE_FORMAT_ANY, #TEXTURE_FLAGS_DEFAULT)
	sgd_SetEnvTexture (env)
	
	skybox = sgd_CreateSkybox(env)
	
	bulletImage = sgd_LoadImage(myAscii("sgd://misc/light.png"))

	light = sgd_CreateDirectionalLight()
	sgd_SetLightColor (light,1,1,1,0.2)
	sgd_TurnEntity (light,-60,0,0)
	
	CreatePlayer(0)
	sgd_MoveEntity (player,0,50,-100)

	sgd_SetEntityName (player,myAscii("Player"))
	
	;DebugLog player
	;DebugLog FindEntityChild(0,myAscii("Player"))
	
	light = sgd_CreateSpotLight()
	sgd_SetEntityParent (light,player)
	sgd_SetLightColor (light,1,1,1,1)
	sgd_SetLightRange (light,50)
	
	slimeball=sgd_LoadSound(myAscii("sgd://audio/slimeball.wav"))
	
	CreateGround()

	CreateBlocks()
	
EndProcedure

Procedure UpdateBlocks()
  
  ForEach block()
		sgd_TurnEntity (block()\model,block()\xr,block()\yr,0)
	Next 
	
EndProcedure

Procedure UpdateBullets() 
  Static r.f, g.f ,b.f,light
  
	If sgd_IsKeyHit(#KEY_SPACE)
		r.f=Random(1) : g.f = Random(1) : b.f=Random(1)
		
		;Fake some NEON baby!
		Select(Random(3))
		  Case 1 
		    r=1
		  Case 2 
		    g=1
		  Case 3 
		    b=1
		EndSelect
		    
 	  AddElement(Bullet())
       
		;Local bullet:Bullet = New Bullet
		
		bullet()\entity = sgd_CreateSprite(bulletImage)
		sgd_SetSpriteColor (bullet()\entity,r,g,b,1)
		
		sgd_SetEntityParent (bullet()\entity,player)
		sgd_SetEntityParent (bullet()\entity,0)
		
		bullet()\timeout = 180
		bullet()\vz = player_vz + 0.75
		If bullet()\vz < 0.75 : bullet()\vz=0.75 : EndIf
 		light=sgd_CreatePointLight()
		sgd_SetLightShadowsEnabled (light,#True)
		sgd_SetEntityParent (light,bullet()\entity)
		sgd_SetLightColor (light,r,g,b,2)
		sgd_SetLightRange (light,50)
		
		sgd_PlaySound (slimeball)
	EndIf

	ForEach Bullet()
		bullet()\timeout = bullet()\timeout - 1
		If bullet()\timeout = 0
			sgd_DestroyEntity (bullet()\entity)
			DeleteElement (bullet())
		Else
			sgd_MoveEntity (bullet()\entity,0,0,bullet()\vz)
		EndIf
	Next

EndProcedure

Procedure CreateGround()
Static material,mesh,model
	material = sgd_LoadPBRMaterial(myAscii("sgd://materials/Gravel023_1K-JPG"))

	mesh = sgd_CreateBoxMesh(-#WORLD_SIZE * 2,-1,-#WORLD_SIZE*2,#WORLD_SIZE*2,0,#WORLD_SIZE*2,material)
	sgd_TransformTexCoords (mesh,100,100,0,0)

	model = sgd_CreateModel(mesh)
	
EndProcedure

Procedure CreateBlocks()
  Static material , mesh
	material = sgd_LoadPBRMaterial(myAscii("sgd://materials/Fabric048_1K-JPG"))
	mesh = sgd_CreateBoxMesh(-1,-1,-1,1,1,1,material)
	sgd_SetMeshShadowsEnabled (mesh,#True)
	
	For i = 1 To #NUM_BLOCKS
	  AddElement (Block())
	  block()\model = sgd_CreateModel(mesh)
		sgd_SetModelColor (block()\model, Random(1), Random(1), Random(1), 1)
		sgd_SetEntityPosition (block()\model, Random(2*#WORLD_SIZE,0)-#WORLD_SIZE, Random(#WORLD_SIZE,1), Random(2*#WORLD_SIZE,0)-#WORLD_SIZE)
		;sgd_SetEntityPosition (block()\model, Random(#WORLD_SIZE,-#WORLD_SIZE), Random(#WORLD_SIZE,1), Random(#WORLD_SIZE,-#WORLD_SIZE))
		sgd_TurnEntity (block()\model, Random(360), Random(360), 0)
		block()\xr = Random(3)
		block()\yr = Random(3)
	Next
	
EndProcedure
; IDE Options = PureBasic 6.12 LTS (Windows - x64)
; CursorPosition = 51
; FirstLine = 28
; Folding = -
; EnableAsm
; EnableXP
; DPIAware