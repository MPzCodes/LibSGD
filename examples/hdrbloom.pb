
; File for libsgd Version 0.18 Dec 2024 
;
; Version 0.1, customisation to ASCII Code

XIncludeFile  "start.pb"

; Note: This demo is *broken* since the overlay pass was changed to execute *after* the render effect pass!
; Fix coming once I work out how...

; Visit https://openexr.com/en/latest/ for more exr info and samples.

sgd_init()

ExamineDesktops()
sgd_CreateWindow (DesktopWidth(0)/2 , DesktopHeight(0)/2 , "Picture", #WINDOW_FLAGS_CENTERED)

mat = sgd_LoadEmissiveMaterial("..\assets\misc\StillLife.exr")
sgd_SetMaterialBlendMode (mat, #BLEND_MODE_ALPHA_BLEND)

sgd_Set2DFillMaterial (mat)

bloom = sgd_CreateBloomEffect()

While (sgd_PollEvents() And 1) <> 1
	
	If sgd_IsKeyHit(#KEY_SPACE)
		sgd_SetRenderEffectEnabled (bloom, ~sgd_IsRenderEffectEnabled(bloom)+2)
	EndIf
	
	If sgd_IsKeyHit(#KEY_UP) 
		If sgd_GetBloomEffectRadius(bloom) < 31
			sgd_SetBloomEffectRadius(bloom, sgd_GetBloomEffectRadius(bloom)+1)
		EndIf
	ElseIf sgd_IsKeyHit(#KEY_DOWN)
		If sgd_GetBloomEffectRadius(bloom) > 2
			sgd_SetBloomEffectRadius(bloom, sgd_GetBloomEffectRadius(bloom)-1)
		EndIf
	EndIf
	
	sgd_Clear2D()
	
	sgd_Draw2DRect (0,0,sgd_GetWindowWidth(),sgd_GetWindowHeight())
	sgd_Draw2DText ("Bloom enabled (space): " + sgd_IsRenderEffectEnabled(bloom),0,0)
	sgd_Draw2DText ("Bloom Radius (up/down): " + sgd_GetBloomEffectRadius(bloom),0,16)
	
	sgd_RenderScene()
	
	sgd_Present()
Wend

; IDE Options = PureBasic 6.12 LTS (Windows - x64)
; CursorPosition = 44
; EnableAsm
; EnableXP
; DPIAware