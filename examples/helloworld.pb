
; File for libsgd Version 0.17 Dec 2024 

XIncludeFile "start.pb"

sgd_init()
sgd_CreateWindow(640, 480, myAscii("Hallo Welt!") , 0)
sgd_SetClearColor (1, 0.5, 0, 1)

While (sgd_PollEvents() And 1)=0
	If sgd_IsKeyHit(#KEY_ESCAPE) : Break : EndIf
	sgd_RenderScene()
	sgd_Present()
Wend
; IDE Options = PureBasic 6.20 Beta 1 (Windows - x64)
; CursorPosition = 1
; EnableAsm
; EnableXP
; DPIAware