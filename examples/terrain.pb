XIncludeFile  "start.pb"

sgd_init()

ExamineDesktops()
sgd_CreateWindow (DesktopWidth(0)/2 , DesktopHeight(0)/2 , myAscii("Canyon!"), #WINDOW_FLAGS_CENTERED)

sgd_SetEnvTexture (sgd_LoadCubeTexture(myAscii("sgd://envmaps/sunnysky-cube.png"),#TEXTURE_FORMAT_ANY,#TEXTURE_FLAGS_DEFAULT))


sgd_SetAmbientLightColor (1,0.9,0.8,0.1)

light = sgd_CreateDirectionalLight()
sgd_SetEntityRotation (light,-45,-45,0)

fog = sgd_CreateFogEffect()
sgd_SetClearColor (0.5,0.8,1,1)
sgd_SetFogEffectColor (fog,0.5,0.8,1,1)
sgd_SetFogEffectRange (fog,0.2,2000)
sgd_SetFogEffectPower (fog,2.5)

heightTexture = sgd_Load2DTexture(myAscii("sgd://terrains/canyon/height.exr"), #TEXTURE_FORMAT_ANY, #TEXTURE_FLAGS_DEFAULT)
normalTexture = sgd_Load2DTexture(myAscii("sgd://terrains/canyon/normal.png"), #TEXTURE_FORMAT_RGBA8, #TEXTURE_FLAGS_DEFAULT)
albedoTexture = sgd_Load2DTexture(myAscii("sgd://terrains/canyon/albedo.png"), #TEXTURE_FORMAT_ANY, #TEXTURE_FLAGS_DEFAULT)

;Local heightTexture = Load2DTexture("~/Desktop/rocky/height.exr", TEXTURE_FORMAT_ANY, TEXTURE_FLAGS_IMAGE)
;Local normalTexture = Load2DTexture("~/Desktop/rocky/normal.png", TEXTURE_FORMAT_RGBA8, TEXTURE_FLAGS_IMAGE)
;Local albedoTexture = Load2DTexture("~/Desktop/rocky/albedo.png", TEXTURE_FORMAT_ANY, TEXTURE_FLAGS_IMAGE)

material=sgd_CreatePBRMaterial()
sgd_SetMaterialTexture (material,myAscii("albedo"),albedoTexture)

terrain = sgd_CreateTerrain()
sgd_SetEntityScale (terrain,1,512,1)
sgd_SetTerrainSize (terrain,4096)
sgd_SetTerrainLODs (terrain,5)
sgd_SetTerrainMaterialSize (terrain,4096)
sgd_SetTerrainHeightTexture (terrain,heightTexture)
sgd_SetTerrainNormalTexture (terrain,normalTexture)
sgd_SetTerrainMaterial (terrain,material)

createPlayer(0)
sgd_MoveEntity (player,0,512,-1024)

sgd_SetCameraNear (camera,0.2)
sgd_SetCameraFar (camera,2000)

De_bug=0

While (sgd_PollEvents() And 1)<>1

;	PlayerFly2(.75,1.25,.25)
	PlayerFly2(0.25,0.5,0.125)
	
	If sgd_IsKeyHit(#KEY_SPACE)
		De_bug=1-De_bug
		sgd_SetTerrainDebugMode (terrain,De_bug)
	EndIf
	
	sgd_Clear2D()
	sgd_Draw2DText (myAscii("Camera: "+sgd_GetEntityX(camera)+","+sgd_GetEntityY(camera)+","+sgd_GetEntityZ(camera)),0,0)
	sgd_Draw2DText (myAscii("Debug (space to toggle): "+De_bug),0,16)
	sgd_Draw2DText (myAscii("FPS:"+StrF(sgd_GetFPS(),1)),0,32)
	;sgd_Draw2DText "FPS: "+GetFPS(),0,32
	
	sgd_RenderScene()
	
	sgd_Present()
Wend
; IDE Options = PureBasic 6.12 LTS (Windows - x64)
; CursorPosition = 60
; FirstLine = 11
; EnableAsm
; EnableXP
; DPIAware