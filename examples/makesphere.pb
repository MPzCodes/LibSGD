
XIncludeFile  "start.pb"

sgd_init()




Procedure sgd_CreateSphere(radius.f, xSegs, ySegs, material)

	mesh = sgd_CreateMesh(0,0)
	
	TWO_PI.f=6.28318530718
  HALF_PI.f= 1.5707963268
	
	Debug "1"
	
	fxSegs.f = 1/xSegs : fySegs.f = 1/ySegs
	
	For i=0 To xSegs-1
		sgd_AddVertex (mesh, 0, radius, 0, 0, 1, 0, (i + 0.5) * 2 * fxSegs, 0)
	Next
	
	For j = 1 To ySegs-1
		pitch.f = HALF_PI - j * 3.141 * fySegs;
		For i = 0 To xSegs
			yaw.f = i * TWO_PI / fxSegs;
			r.f = Cos(pitch);
			y.f = Sin(pitch);
			x.f = Cos(yaw) * r;
			z.f = Sin(yaw) * r;
			sgd_AddVertex (mesh, x * radius, y * radius, z * radius, x, y, z, i * 2 * fxSegs, j * fySegs)
		Next
	Next
	For i = 0 To xSegs-1
		sgd_AddVertex (mesh, 0, -radius, 0, 0, -1, 0, (i + 0.5) * 2 * fxSegs, 1)
	Next
	Debug "1"
	
	surf = sgd_CreateSurface(mesh, material,0);
	
	Debug "1"
	
	
	For i = 0 To xSegs-1
		sgd_AddTriangle (surf, i, i + xSegs, i + xSegs + 1)
	Next
	Debug "1"
	
	For j = 1 To ySegs-2
		For i = 0 To xSegs-1
			v0 = j * (xSegs + 1) + i - 1
			v2 = v0 + xSegs + 2
			sgd_AddTriangle (surf, v0, v2, v0 + 1)
			sgd_AddTriangle (surf, v0, v2 - 1, v2)
		Next
	Next
	For i = 0 To xSegs-1
		v0 = (xSegs + 1) * (ySegs - 1) + i - 1
		sgd_AddTriangle (surf, v0, v0 + xSegs + 1, v0 + 1)
	Next
	Debug "1"
	
	ProcedureReturn mesh
	
EndProcedure

ExamineDesktops()
sgd_CreateWindow (DesktopWidth(0)/2 , DesktopHeight(0)/2 , myAscii("Custom mesh demo"), #WINDOW_FLAGS_CENTERED)

env = sgd_LoadCubeTexture(myAscii("sgd://envmaps/sunnysky-cube.png"), #TEXTURE_FORMAT_ANY, #TEXTURE_FLAGS_DEFAULT)

sgd_SetEnvTexture (env)

skybox = sgd_CreateSkybox(env)
sgd_SetSkyboxRoughness (skybox, 0.3)

light = sgd_CreateDirectionalLight()
sgd_TurnEntity (light,-45,0,0)	; Tilt light down 45 degrees 

material = sgd_LoadPBRMaterial(myAscii("sgd://misc/test-texture.png"))
sgd_SetMaterialFloat (material, myAscii("roughness"), 0.5)

;mesh = sgd_CreateSphere(1,96,48,material)
mesh = sgd_CreateSphereMesh(1,96,48,material)
model=sgd_CreateModel(mesh)
sgd_MoveEntity (model,0,0,3)

While Not sgd_PollEvents()

	If sgd_IsKeyDown(263)
		sgd_TurnEntity (model,0,3,0)
	ElseIf sgd_IsKeyDown(262)
		sgd_TurnEntity (model,0,-3,0)
	EndIf
	
	If sgd_IsKeyDown(264)
		sgd_TurnEntity (model,3,0,0)
	ElseIf sgd_IsKeyDown(265)
		sgd_TurnEntity (model,-3,0,0)
	EndIf
	
	sgd_RenderScene()
	
	sgd_Present()
	
Wend

; IDE Options = PureBasic 6.12 LTS (Windows - x64)
; CursorPosition = 83
; FirstLine = 34
; Folding = -
; EnableAsm
; EnableXP
; DPIAware