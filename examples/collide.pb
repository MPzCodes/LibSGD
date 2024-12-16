
; File for libsgd Version 0.17 Dec 2024 

XIncludeFile  "start.pb"

sgd_init()

#COLLIDER_TYPE_LEVEL=0
#COLLIDER_TYPE_SPHERE=1
#COLLIDER_TYPE_PLAYER=2

ExamineDesktops()
sgd_CreateWindow (DesktopWidth(0)/2 , DesktopHeight(0)/2 , myAscii("Collide Demo"), #WINDOW_FLAGS_RESIZABLE)

sgd_EnableCollisions (#COLLIDER_TYPE_PLAYER,#COLLIDER_TYPE_LEVEL,#COLLISION_RESPONSE_SLIDEXZ)
sgd_EnableCollisions (#COLLIDER_TYPE_PLAYER,#COLLIDER_TYPE_SPHERE,#COLLISION_RESPONSE_SLIDE)

sgd_SetAmbientLightColor (1,0.9,0.8,0.2)

env =  sgd_LoadCubeTexture(myAscii("..\assets\envmaps\sunnysky-cube.png"),#TEXTURE_FORMAT_ANY,#TEXTURE_FLAGS_DEFAULT)
sgd_SetEnvTexture (env)

skybox = sgd_CreateSkybox(env)

light = sgd_CreateDirectionalLight()
sgd_TurnEntity (light,-45,-45,0)

levelMesh = sgd_LoadMesh(myAscii("..\assets\models\ManurewaDuplex.glb"))

sz.f=50
sgd_FitMesh (levelMesh,-sz,-sz,-sz,sz,sz,sz,#True)

levelModel = sgd_CreateModel(levelMesh)
levelCollider = sgd_CreateMeshCollider(levelModel, #COLLIDER_TYPE_LEVEL, 0)

sphereMesh = sgd_CreateSphereMesh(2.5,48,23,sgd_CreatePBRMaterial());
sgd_SetMaterialColor(sgd_GetMaterial(sgd_GetSurface(sphereMesh,0)),myAscii("albedo"),1,0.75,0,1)

sphereModel = sgd_CreateModel(sphereMesh)
sgd_MoveEntity (sphereModel,0,-6,36)
sphereCollider = sgd_CreateMeshCollider(sphereModel, #COLLIDER_TYPE_SPHERE, 0)

CreatePlayer(0)
sgd_SetEntityPosition (player,-8,0,36)
sgd_SetEntityRotation (player,0,-145.5,0)
sgd_MoveEntity( camera,0,0.8,0)

;Skinny dude!
playerCollider = sgd_CreateEllipsoidCollider(player, #COLLIDER_TYPE_PLAYER, 0.2, 1.8)

gravity.f=-9.81/60.0/60.0
vel.f=0
jumping=#False

While sgd_PollEvents()<>1

	sp.f=3.2
	If sgd_IsKeyDown(#KEY_LEFT_SHIFT) : sp=5.6 : EndIf
	
	If sgd_IsKeyHit(#KEY_F11)
		If sgd_GetWindowState()<>4
			sgd_SetWindowState (4)
		Else
			sgd_SetWindowState (2)
		EndIf
	EndIf
	
	PlayerWalk(sp/60.0)
	
	py.f = sgd_GetEntityY(player)
	
	If sgd_IsKeyHit(#KEY_SPACE)
		vel = vel + 0.1
		jumping=True
	EndIf
		
	vel = vel + gravity
	sgd_MoveEntity(player, 0, vel, 0)
	
	sgd_UpdateColliders()
	
	vel = sgd_GetEntityY(player) - py
	
	If jumping
	  If vel<=0 : jumping = False : EndIf
	Else
		If vel>0 : vel=0 : EndIf
	EndIf
	
	sgd_Clear2D()
	sgd_Set2DTextColor (0,0,0,1)
	
	sgd_Draw2DText (myAscii("Player position: "+sgd_GetEntityX(player)+", "+sgd_GetEntityY(player)+", "+sgd_GetEntityZ(player)),0,0)
	sgd_Draw2DText (myAscii("Player rotation: "+sgd_GetEntityRX(player)+", "+sgd_GetEntityRY(player)+", "+sgd_GetEntityRZ(player)),0,16)

	For i=0 To sgd_GetCollisionCount(playerCollider)-1
		sgd_Draw2DText (myAscii("Collision "+i+" Type:"+sgd_GetColliderType(sgd_GetCollisionCollider(playerCollider,i))),0,i*48+32)
		sgd_Draw2DText (myAscii("Collision "+i+" Point : "+sgd_GetCollisionX(playerCollider,i)+", "+sgd_GetCollisionY(playerCollider,i)+", "+sgd_GetCollisionZ(playerCollider,i)),0,i*48+48)
		sgd_Draw2DText (myAscii("Collision "+i+" Normal: "+sgd_GetCollisionNX(playerCollider,i)+", "+sgd_GetCollisionNY(playerCollider,i)+", "+sgd_GetCollisionNZ(playerCollider,i)),0,i*48+64)
	Next
	
	sgd_RenderScene()
	sgd_Present()
	
Wend
; IDE Options = PureBasic 6.20 Beta 1 (Windows - x64)
; CursorPosition = 19
; EnableAsm
; EnableXP
; DPIAware