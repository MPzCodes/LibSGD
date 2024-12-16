
; File for libsgd Version 0.17 Dec 2024 

IncludePath("..\lib\")

XIncludeFile "keycodes.pb"
XIncludeFile "sgd.pb"

XIncludeFile "sgd_dynamic.pbi"

Procedure.s myAscii(string1$)
 ; Umwandlung Text in ASCII Code
 Static myString.s
 myString.s = Space(256)
 PokeS (@myString.s, string1$, -1, #PB_Ascii)
  
 ProcedureReturn myString
EndProcedure

Global player
Global player_rvx.f,player_rvy.f
Global player_vx.f,player_vy,player_vz.f

Global camera
Global camera_rx.f,camera_ry.f

Procedure CreatePlayer(mesh)

	player = sgd_CreateModel(mesh)
	
	camera = sgd_CreatePerspectiveCamera()
	sgd_SetEntityParent (camera,player)
	
EndProcedure

Procedure PlayerWalk(speed.f)

	If sgd_IsKeyDown(#KEY_LEFT)
		player_rvy = player_rvy + (1.5-player_rvy) * 0.3
	ElseIf sgd_IsKeyDown(#KEY_RIGHT)
		player_rvy = player_rvy + (-1.5-player_rvy) * 0.3
	Else
		player_rvy = player_rvy * 0.9
	EndIf
	sgd_RotateEntity (player,0,player_rvy,0)

	If sgd_IsKeyDown(#KEY_DOWN)
		camera_rx = camera_rx + (-45-camera_rx) * 0.025
	ElseIf sgd_IsKeyDown(KEY_UP)
		camera_rx = camera_rx + (45-camera_rx) * 0.025
	Else 
		camera_rx = camera_rx * 0.9
	EndIf
	sgd_SetEntityRotation (camera,camera_rx,0,0)
	
	If sgd_IsKeyDown(#KEY_W)
		player_vz = player_vz + (speed-player_vz) * 0.3
	ElseIf sgd_IsKeyDown(#KEY_S)
		player_vz = player_vz + (-speed-player_vz) * 0.3
	Else
		player_vz = player_vz * 0.9
	EndIf
	
	If sgd_IsKeyDown(#KEY_A)
		player_vx = player_vx + (-speed-player_vx) * 0.3
	ElseIf sgd_IsKeyDown(#KEY_D)
		player_vx = player_vx + (speed-player_vx) * 0.3
	Else
		player_vx = player_vx * 0.9
	EndIf
	
	sgd_MoveEntity (player,player_vx,0,player_vz)
	
EndProcedure

Procedure PlayerFly(speed.f)

	If sgd_IsKeyDown(#KEY_LEFT)
		player_rvy = player_rvy + (1.25-player_rvy) * 0.2
	ElseIf sgd_IsKeyDown(#KEY_RIGHT)
		player_rvy = player_rvy + (-1.25-player_rvy) * 0.2
	Else
		player_rvy = player_rvy * 0.9
	EndIf
	sgd_RotateEntity (player,0,player_rvy,0)
	sgd_SetEntityRotation (camera,0,0,player_rvy*-12)
	
	If sgd_IsKeyDown(#KEY_UP)
		player_rvx = player_rvx + (-1.25-player_rvx) * 0.2
	ElseIf sgd_IsKeyDown(#KEY_DOWN)
		player_rvx = player_rvx + (1.25-player_rvx) * 0.2
	Else 
		player_rvx = player_rvx * 0.9
	EndIf
	sgd_TurnEntity (player,player_rvx,0,0)

	If sgd_IsKeyDown(#KEY_W)
		player_vz = player_vz + (speed-player_vz) * 0.3
	ElseIf sgd_IsKeyDown(#KEY_S)
		player_vz = player_vz + (-speed-player_vz) * 0.3
	Else
		player_vz = player_vz * 0.9
	EndIf
	sgd_MoveEntity ( player,0,0,player_vz)

	If sgd_IsKeyDown(#KEY_A)
		player_vx = player_vx + (-speed-player_vx) * 0.3
	ElseIf sgd_IsKeyDown(#KEY_D)
		player_vx = player_vx + (speed-player_vx) * 0.3
	Else
		player_vx = player_vx * 0.9
	EndIf
	sgd_MoveEntity (player,player_vx,0,0)

EndProcedure

Procedure PlayerFly2(speed.f,maxSpeed.f,minSpeed.f)

	If sgd_IsKeyDown(#KEY_LEFT)
		player_rvy = player_rvy + (1.5-player_rvy) * 0.3
	ElseIf sgd_IsKeyDown(#KEY_RIGHT)
		player_rvy = player_rvy + (-1.5-player_rvy) * 0.3
	Else
		player_rvy = player_rvy * 0.9
	EndIf
	sgd_RotateEntity (player,0,player_rvy,0)
	sgd_SetEntityRotation (camera,0,0,player_rvy*-15)
	
	If sgd_IsKeyDown(#KEY_UP)
		player_rvx = player_rvx + (-1.5-player_rvx) * 0.3
	ElseIf sgd_IsKeyDown(#KEY_DOWN)
		player_rvx = player_rvx + (1.5-player_rvx) * 0.3
	Else 
		player_rvx = player_rvx * 0.9
	EndIf
	sgd_TurnEntity (player,player_rvx,0,0)

	If sgd_IsKeyDown(#KEY_W)
		player_vz = player_vz + (maxSpeed-player_vz) * 0.3
	ElseIf sgd_IsKeyDown(#KEY_S)
		player_vz = player_vz + (minSpeed-player_vz) * 0.3
	Else
		player_vz = player_vz + (speed-player_vz) * 0.3
	EndIf
	sgd_MoveEntity (player,0,0,player_vz)

	If sgd_IsKeyDown(#KEY_A)
		player_vx = player_vx + (-speed-player_vx) * 0.3
	ElseIf sgd_IsKeyDown(#KEY_D)
		player_vx = player_vx + (speed-player_vx) * 0.3
	Else
		player_vx = player_vx * 0.9
	EndIf
	sgd_MoveEntity (player,player_vx,0,0)

EndProcedure
; IDE Options = PureBasic 6.20 Beta 1 (Windows - x64)
; CursorPosition = 26
; Folding = -
; EnableAsm
; EnableXP
; DPIAware