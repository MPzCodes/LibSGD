
; File for libsgd Version 0.18 Dec 2024 

; This Demo can create a Sphere from a lib and a sphere selfmade. 
; You can use it to create you own meshs 
; V0.1

XIncludeFile  "start.pb"

sgd_init()

; Test sgd_CreateSphere is a little buggy, i doesnt find the probblem...

Procedure sgd_CreateSphere(radius.f, xSegs, ySegs, material)
  
	mesh = sgd_CreateMesh(0,1)
	
  If 1 =0
	   ; create a Plane if you want
     vv0 = sgd_AddVertex (mesh , -1,-1,0,0,0,-1,0,1 )
     vv1 = sgd_AddVertex (mesh , 1,-1,0,0,0,-1,1,1 )
     vv2 = sgd_AddVertex (mesh , -1, 1,0,0,0,-1,0,0)
     vv3 = sgd_AddVertex (mesh , 1, 1,0,0,0,-1,1,0)
     surf2 = sgd_CreateSurface(mesh, material,0) 
     tri1 = sgd_AddTriangle (surf2,vv1,vv2,vv0) 
     tri2 = sgd_AddTriangle (surf2,vv3,vv2,vv1)
     sgd_UpdateMeshTangents(mesh)
	  ProcedureReturn mesh
	
	EndIf
	
	fxSegs.f = 1/xSegs : fySegs.f = 1/ySegs
	
	For i=0 To xSegs-1
		sgd_AddVertex (mesh, 0, radius, 0, 0, 1, 0, (i + 0.5) * 2 * fxSegs, 0)
	Next

	For j = 1 To ySegs-1
	  pitch.f = Radian(90 - j * fySegs * 180) ;
	  For i = 0 To xSegs
			yaw.f = Radian(i * fxSegs * 360)
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
	
	surf = sgd_CreateSurface(mesh, material,0);
	
	For i = 0 To xSegs-1
		sgd_AddTriangle (surf, i, i + xSegs, i + xSegs + 1)
	Next
	
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
	
	sgd_UpdateMeshTangents(mesh)

	ProcedureReturn mesh
	
EndProcedure

ExamineDesktops()
sgd_CreateWindow (DesktopWidth(0)/2 , DesktopHeight(0)/2 , myAscii("Custom mesh demo"), #WINDOW_FLAGS_CENTERED)

env = sgd_LoadCubeTexture(myAscii("..\assets\envmaps\sunnysky-cube.png"), #TEXTURE_FORMAT_ANY, #TEXTURE_FLAGS_DEFAULT)

sgd_SetEnvTexture (env)

skybox = sgd_CreateSkybox(env)
sgd_SetSkyboxRoughness (skybox, 0.3)

light = sgd_CreateDirectionalLight()
sgd_TurnEntity (light,-45,0,0)	; Tilt light down 45 degrees 

material = sgd_LoadPBRMaterial(myAscii("..\assets\misc\test-texture.png"))
;material = sgd_LoadMaterial(myAscii("..\assets\materials\Bricks076C_1K-JPG\"))


sgd_SetMaterialFloat (material, myAscii("roughness"), 0.5)

mesh1 = sgd_CreateSphere(1,96,48,material)  ; function repared
mesh2 = sgd_CreateSphereMesh(1,96,48,material)


model1=sgd_CreateModel(mesh1)
model2=sgd_CreateModel(mesh2)
sgd_MoveEntity (model1,0,1,3)
sgd_MoveEntity (model2,0,-1,3)

While Not sgd_PollEvents()

	If sgd_IsKeyDown(263)
		sgd_TurnEntity (model1,0,3,0)
		sgd_TurnEntity (model2,0,3,0)
	ElseIf sgd_IsKeyDown(262)
		sgd_TurnEntity (model1,0,-3,0)
		sgd_TurnEntity (model2,0,-3,0)
	EndIf
	
	If sgd_IsKeyDown(264)
		sgd_TurnEntity (model1,3,0,0)
		sgd_TurnEntity (model2,3,0,0)
	ElseIf sgd_IsKeyDown(265)
		sgd_TurnEntity (model1,-3,0,0)
		sgd_TurnEntity (model2,-3,0,0)
	EndIf
	
	sgd_RenderScene()
	
	sgd_Present()
	
Wend

; IDE Options = PureBasic 6.20 Beta 2 (Windows - x64)
; CursorPosition = 7
; Folding = -
; EnableAsm
; EnableXP
; DPIAware