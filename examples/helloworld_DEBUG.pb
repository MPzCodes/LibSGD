
; File for libsgd Version 0.18 Dec 2024 
;
; Version 0.1, customisation to ASCII Code
; you find a log.txt file here:


IncludePath("..\lib\")

XIncludeFile "keycodes.pb"
XIncludeFile "sgd.pb"
XIncludeFile "sgd_dynamic.pbi"

sgd_SetConfigVar("log.logfilePath","log.txt")
sgd_SetConfigVar("log.logfileEnabled","1")
sgd_Log("This is my lofile of the helloworld_DEBUG_file")

sgd_init()
sgd_CreateWindow(640, 480, "Hallo Welt!" , 0)
sgd_SetClearColor (1, 0.5, 0, 1)

While (sgd_PollEvents() And 1)=0
	If sgd_IsKeyHit(#KEY_ESCAPE) : Break : EndIf
	sgd_RenderScene()
	sgd_Present()
Wend
; IDE Options = PureBasic 6.20 (Windows - x64)
; CursorPosition = 4
; EnableAsm
; EnableXP
; DPIAware