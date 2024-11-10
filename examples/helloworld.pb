
XIncludeFile "start.pb"

sgd_init()
sgd_CreateWindow(640, 480, myAscii("Hallo Welt!") , 0)
sgd_SetClearColor (1, 0.5, 0, 1)

While (sgd_PollEvents() And 1)=0
	If sgd_IsKeyHit(#KEY_ESCAPE) : Break : EndIf
	sgd_RenderScene()
	sgd_Present()
Wend
; IDE Options = PureBasic 6.12 LTS (Windows - x64)
; CursorPosition = 3
; EnableAsm
; EnableXP
; DPIAware