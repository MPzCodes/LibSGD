
; File for libsgd Version 0.18 Dec 2024 
;
; Version 0.1, customisation to ASCII Code

;-Please start the serialize.pb file before you  start thi sprogram. You need the "~/Desktop/test-scene.json" file

XIncludeFile  "start.pb"

sgd_init()

ExamineDesktops()
sgd_CreateWindow (DesktopWidth(0)/2 , DesktopHeight(0)/2 , "Some nice trees", #WINDOW_FLAGS_CENTERED)

;Load scene from desktop!
 sgd_LoadScene ("~/Desktop/test-scene.json")
;- end of here

createPlayer(0)
sgd_MoveEntity (player,0,10,0)
player=sgd_FindEntityChild(0,"Player")
camera=sgd_FindEntityChild(0,"Camera")

While sgd_PollEvents()<>1
	PlayerFly(0.05)
	sgd_RenderScene()
	sgd_Clear2D()
	;Draw2DText "FPS:"+GetFPS(),0,0
	sgd_Draw2DText ("FPS:"+StrF(sgd_GetFPS(),1),0,0)
	sgd_Present()
Wend
; IDE Options = PureBasic 6.20 Beta 1 (Windows - x64)
; CursorPosition = 4
; EnableAsm
; EnableXP
; DPIAware
; IDE Options = PureBasic 6.20 (Windows - x64)
; CursorPosition = 1
; EnableAsm
; EnableXP
; DPIAware