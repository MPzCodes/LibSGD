﻿
; Libname: sgd_dynamic.lib
; created: 2024/12/15  15:51
; translated MPz Version for Version 0.18 alpha
;
; V 0.01


 Macro SGD_String
    s
 EndMacro
 
 Macro SGD_Texture
    s
 EndMacro
  
 Macro SGD_Real
   d ; Double or float
  ;f
 EndMacro
 
 Macro  SGD_Key
   i
 EndMacro
 
 Procedure.s myAscii(string1$)
 ; Umwandlung Text in ASCII Code
 Static myString.s
 myString.s = Space(256)
 PokeS (@myString.s, string1$, -1, #PB_Ascii)
  
 ProcedureReturn myString
EndProcedure

;Import "libsgd.lib"
Import "sgd_dynamic.lib"
  
  
  ;-! @defgroup SystemTypes SystemTypes
  ; ! @{

  ;-! Events returned by sgd_PollEvents.
  Enumeration SGD_EventMask
    #SGD_EVENT_MASK_CLOSE_CLICKED =  $01 ;//!< Window close clicked.
	  #SGD_EVENT_MASK_SIZE_CHANGED  =  $02 ;//!< Window size changed.
	  #SGD_EVENT_MASK_LOST_FOCUS    =  $04 ;//!< Window lost focus.
	  #SGD_EVENT_MASK_GOT_FOCUS     =  $08 ;//!< Window got focus.
	  #SGD_EVENT_MASK_SUSPENDED     =  $10 ;//!< App suspended.
	  #SGD_EVENT_MASK_RESUMED       =  $20 ;//!< App resumed.
  EndEnumeration 

  ;-! @defgroup System System
  ; ! Start up libsgd.
  sgd_Init() As "sgd_Init";
  ; ! Get current Runtime LibSGD version.
  ; ! Returns the value of SGD_VERSION Macro at the time the Runtime was built.
  sgd_GetVersion_x() As "sgd_GetVersion";
  ; ! Shut down libsgd.
  sgd_Terminate() As "sgd_Terminate";

  ; ! Set Global configuration variable.
  ; ! Config var name           | Default | Description
  ; !---------------------------|---------|------------
  ; ! log.logfilePath           |         | Logfile path, defaults To "~/.sgd/log.txt".
  ; ! log.logfileEnabled        | "1"     | Enables logging To logfile.
  ; ! log.stdoutEnabled         | "1"     | Enables logging To stdout.
  ; ! gltf.loggingEnabled       | "0"     | Enables logging by the gltf loader.
  ; ! dawn.backendType          |         | Backend For Dawn To use, one of: "D3D12", "D3D11", "Vulkan", "Metal". Defaults To
  ; ! "D3D12" on 64 bit Windows, "D3D11" on 32 bit Windows, "Vulkan" on 64 bit Linux And "Metal" on 64 bit MacOS.
  ; ! render.vsyncEnabled       | "1"     | Hack that fixes https://issues.chromium.org/issues/42241496#comment3
  ; ! render.shadowPassEnabled  | "1"     | Enables shadow rendering.
  ; ! render.opaquePassEnabled  | "1"     | Enables opaque rendering.
  ; ! render.blendPassEnabled   | "1"     | Enables blended rendering.
  ; ! render.effectPassEnabled  | "1"     | Enables effects rendering.
  sgd_SetConfigVar_x(name.SGD_String , value.SGD_String ) As "sgd_SetConfigVar";
  ; ! Set Global configuration variable. The returned value is valid Until the Next CALL To sgd_GetConfigVar.
  sgd_GetConfigVar_x(name.SGD_String ) As "sgd_GetConfigVar";
  ; ! Set error handler callback.
  ;SGD_API void SGD_DECL sgd_SetErrorHandler(void(SGD_DECL* handler)(SGD_String error, void* context), void* context); Weis nicht wie man das übersetzen soll
  ; ! Generate Runtime error.
  sgd_Error(error.SGD_String ) As "sgd_Error";
  ; ! Generate modal alert dialog.
  sgd_Alert(message.SGD_String ) As "sgd_Alert";
  ; ! Write line of text To log.
  sgd_Log_x(line.SGD_String ) As "sgd_Log";
  ; ! Return width of desktop IN pixels.
  sgd_GetDesktopWidth() As "sgd_GetDesktopWidth";
  ; ! Return height of desktop IN pixels.
  sgd_GetDesktopHeight() As "sgd_GetDesktopHeight";
  ; ! Poll system For events, returns a bit mask of event types that occured.
  ; ! The returned Return value should be bitwise 'and'ed With one of the @ref SGD_EventMask
  ; ! values To determine whether a particular event occured Or Not.
  sgd_PollEvents() As "sgd_PollEvents";
  ; ! Release an object handle.
  ; ! Will cause the object referenced by the handle To become available For destruction,
  ; ! And will also invalidate the handle.
  ; ! An object will Not be destroyed While it is still being used by another object, eg:
  ; ! a model's mesh will not be destroyed while it is still being used by a Model.
  ; ! It is an error To use an invalidated handle, so once a handle is released be careful
  ; ! Not To use it again.
  sgd_ReleaseHandle(handle.i) As "sgd_ReleaseHandle";
  ; ! Release all object handles.
  sgd_ReleaseAllHandles() As "sgd_ReleaseAllHandles";
  ; ! @cond Debug memory state.
  sgd_DebugMemory() As "sgd_DebugMemory";
  
  ; ! @defgroup WindowTypes WindowTypes
  ; ! Window states.
  Enumeration SGD_WindowState
	  #SGD_WINDOW_STATE_CLOSED    ; = 0,	//!< Window is closed
	  #SGD_WINDOW_STATE_MINIMIZED ; = 1, //!< Window is minimized
	  #SGD_WINDOW_STATE_NORMAL    ; = 2,	//!< Window is normal
	  #SGD_WINDOW_STATE_MAXIMIZED ; = 3, //!< Window is maximized
	  #SGD_WINDOW_STATE_FULLSCREEN; = 4 //!< Window is fullscreen
  EndEnumeration 
  
  ; ! Window flags.
  Enumeration SGD_WindowFlags 
	  #SGD_WINDOW_FLAGS_NONE      ; = 0x00, //!< No special flags.
	  #SGD_WINDOW_FLAGS_FULLSCREEN; = 0x01, //!< Create fullscreen window.
	  #SGD_WINDOW_FLAGS_RESIZABLE ; = 0x02,	//!< Create resizable window.
	  #SGD_WINDOW_FLAGS_CENTERED  = $04   ;	//!< Create window centered on desktop.
  EndEnumeration 
  ; ! @}
  ;-! @defgroup Window Window
  ; ! Create a new window. See @ref SGD_WindowFlags for possible values for `flags`.
  sgd_CreateWindow_x(width.i, height.i, title.SGD_String, flags.i) As "sgd_CreateWindow"
  ; ! Destroy window.
  sgd_DestroyWindow() As "sgd_DestroyWindow"
  ; ! Set window position.
  sgd_SetWindowPosition(x.i, y.i) As "sgd_SetWindowPosition";
  ; ! Set window position.
  sgd_GetWindowX() As "sgd_GetWindowX"
  ; ! Get window x. 
  sgd_GetWindowY() As "sgd_GetWindowY"
  ; ! Get window y.
  sgd_SetWindowSize(width.i, heigh.i) As "sgd_SetWindowSize"
  ; ! Get window width.
  sgd_GetWindowWidth() As "sgd_GetWindowWidth"
  ; ! Get window height.
  sgd_GetWindowHeight() As "sgd_GetWindowHeight"
  ; ! Set window title.
  sgd_SetWindowTitle_x( title.SGD_String) As "sgd_SetWindowTitle"
  ; ! Get window title. The returned string will be valid until the next call to sgd_GetWindowTitle().
  sgd_GetWindowTitle() As "sgd_GetWindowTitle"
  ; ! Set fullscreen mode.
  sgd_SetFullscreenMode(width.i,height.i,hertz.i) As "sgd_SetFullscreenMode"
  ; ! Set window state.
  sgd_SetWindowState(state.i) As "sgd_SetWindowState"
  ; ! Get window state. See sgd_SetWindowState.
  sgd_GetWindowState() As "sgd_GetWindowState"
  
  ; ! @defgroup InputTypes InputTypes
  ; ! @{

  ; ! Mouse cursor modes.
  Enumeration SGD_MouseCursorMode 
    #SGD_MOUSE_CURSOR_MODE_NORMAL = 1
    #SGD_MOUSE_CURSOR_MODE_HIDDEN 
    #SGD_MOUSE_CURSOR_MODE_DISABLED 
    #SGD_MOUSE_CURSOR_MODE_CAPTURED 
  EndEnumeration
  ; ! @}
  
   ;-! @defgroup Input Input
   ; ! True If key is currently held down.
   sgd_IsKeyDown(key.SGD_Key) As "sgd_IsKeyDown"
   ; ! True If key was pressed down last frame.
   sgd_IsKeyHit(key.SGD_Key) As "sgd_IsKeyHit"
   ; ! Get Next unicode character from keyboard input queue.
   sgd_GetChar() As "sgd_GetChar"
   ; ! Clear keyboard input queue.
   sgd_FlushChars() As "sgd_FlushChars"
   ; ! Mouse X position IN window coordinates.
   sgd_GetMouseX.f() As "sgd_GetMouseX"
   ; ! Mouse Y position IN window coordinates.
   sgd_GetMouseY.f() As "sgd_GetMouseY"
   ; ! Mouse Z (scrollwheel) position.
   sgd_GetMouseZ.f() As "sgd_GetMouseZ"
   ; ! Mouse X velocity.
   sgd_GetMouseVX.f() As "sgd_GetMouseVX"
   ; ! Mouse Y velocity.
   sgd_GetMouseVY.f() As "sgd_GetMouseVY"
   ; ! Mouse Z (scrollwheel) velocity.
   sgd_GetMouseVZ.f() As "sgd_GetMouseVZ"
   ; ! Set Mouse Z (scrollwheel) position.
   sgd_SetMouseZ(z.f) As "sgd_SetMouseZ"
   ; ! Set mouse cursor mode.
   sgd_SetMouseCursorMode(cursorMode.i) As "sgd_SetMouseCursorMode"
   ; ! True If mouse button is curently held down.
   sgd_IsMouseButtonDown(button.i) As "sgd_IsMouseButtonDown"
   ; ! True If mouse button was pressed down last frame.
   sgd_IsMouseButtonHit(button.i) As "sgd_IsMouseButtonHit"   
   ; ! True If gamepad is currently connected.
   sgd_IsGamepadConnected(gamepad.i) As "sgd_IsGamepadConnected"
   ; ! True If gamepad button currently held down.
   sgd_IsGamepadButtonDown(gamepad.i, button.i) As "sgd_IsGamepadButtonDown"
   ; ! True If gamepad button was pressed down last frame.
   sgd_IsGamepadButtonHit(gamepad.i, button.i) As "sgd_IsGamepadButtonHit"
   ; ! Value IN the range -1 To 1 representing joystick axis position.
   sgd_GetGamepadAxis.f(gamepad.i,axis.i) As "sgd_GetGamepadAxis"
   
   ; ! @defgroup TextureTypes TextureTypes
   ; ! @{
   ; ! Texture handle type.
   ; ! Texture types.
  Enumeration SGD_TextureType 
	  #SGD_TEXTURE_TYPE_2D = 1
	  #SGD_TEXTURE_TYPE_CUBE 
	  #SGD_TEXTURE_TYPE_ARRAY
	EndEnumeration
	
	; ! Texture formats.
  ; !
  ; ! The 8 bit unsigned, normalized formats are converted To values IN the range 0.0..1.0 IN shader code.
  ; !
  ; ! The 8 bit signed, normalized formats are converted To values IN the range -1.0..+1.0 IN shader code. 
  ; !
  ; ! All formats except For SGD_TEXTURE_FORMAT_SRGBA8 represent values IN 'linear color space'.
  ; !
  ; ! SGD_TEXTURE_FORMAT_ANY can be used With loading functions To let SGD pick a suitable texture format
  ; ! depending on the content of the Data being loaded.
	
	Enumeration SGD_TextureFormat 
	  #SGD_TEXTURE_FORMAT_ANY     ;= 0, //!< Let SGD loaders choose format.
	  #SGD_TEXTURE_FORMAT_R8      ;= 1,	   //!< 8 bit unsigned normalized red.
	  #SGD_TEXTURE_FORMAT_RG8     ;= 2,	   //!< 8 bit unsigned normalized red, green.
	  #SGD_TEXTURE_FORMAT_RGBA8   ;= 3,  //!< 8 bit unsigned normalized red, green, blue, alpha.
    #SGD_TEXTURE_FORMAT_SRGBA8  ;= 4, //!< 8 bit unsigned normalized red, green, blue, alpha. Non-linear
  	#SGD_TEXTURE_FORMAT_R8S     ;= 5,	   //!< 8 bit signed normalized red.
	  #SGD_TEXTURE_FORMAT_RG8S    ;= 6,   //!< 8 bit signed normalized red, green.
	  #SGD_TEXTURE_FORMAT_RGBA8S  ;= 7, //!< 8 bit signed normalized red, green, blue, alpha.
	  #SGD_TEXTURE_FORMAT_R16F    ;= 8,	 //!< 16 bit floating point red only.
	  #SGD_TEXTURE_FORMAT_RG16F   ;= 9,	 //!< 16 bit floating point red only.
	  #SGD_TEXTURE_FORMAT_RGBA16F ;= 10, //!< 16 bit floating point red only.
  EndEnumeration;

  ; ! Texture flags
  ; !
  ; ! By Default, texture coordinates wrap at the edges of textures.
  ; !
  ; ! Textures are always linear filtered when minimized.
  Enumeration SGD_TextureFlags 
	  #SGD_TEXTURE_FLAGS_NONE    ;= 0x0,  //!< No texture flags.
	  #SGD_TEXTURE_FLAGS_CLAMP_U ;= 0x01 , //!< Clamp texture U coordinates.
	  #SGD_TEXTURE_FLAGS_CLAMP_V ;= 0x02 , //!< Clamp texture V coordinates.
	  #SGD_TEXTURE_FLAGS_CLAMP_W = $04  ;, //!< Clamp texture W coordinates.
	  #SGD_TEXTURE_FLAGS_FILTER  = $08  ;,  //!< Perform bilinear filtering on texels that cover more than screen pixel.
	  #SGD_TEXTURE_FLAGS_MIPMAP  = $10  ;,  //!< Create And perform mipmapping.
	  #SGD_TEXTURE_FLAGS_DEFAULT = $18  ;, //!< Combination of SGD_TEXTURE_FLAGS_FILTER And SGD_TEXTURE_FLAGS_MIPMAP
	  #SGD_TEXTURE_FLAGS_IMAGE   = $01f ;, //!< Combination of SGD_TEXTURE_FLAGS_FILTER, SGD_TEXTURE_FLAGS_MIPMAP And all clamp flags.
  EndEnumeration
  ; ! @}
  
  ;-! @defgroup Texture Texture
   ; ! Load a new 2D texture. See also @ref SGD_TextureFlags.
   ; ! @param path is the file path of the texture To load.
   ; ! @param format is a SGD_TextureFormat constant.
   ; ! @param flags is a valid combination of SGD_TextureFlags values.
   sgd_Load2DTexture_x( path.SGD_String, format.i, flags.i) As "sgd_Load2DTexture"
   ; ! Load a new cube texture. See also @ref SGD_TextureFlags.
   sgd_LoadCubeTexture_x(path.SGD_String, format.i, flags.i) As "sgd_LoadCubeTexture"
   ; ! Load a new Array texture. See also @ref SGD_TextureFlags.
   sgd_LoadArrayTexture_x(path.SGD_String, format.i, flags.i) As "sgd_LoadArrayTexture"
   ; ! Create a new 2D texture. See also @ref SGD_TextureFlags.
   sgd_Create2DTexture(width.i, height.i, format.i, flags.i) As "sgd_Create2DTexture"
   ; ! Create a new cube texture. See also @ref SGD_TextureFlags.
   sgd_CreateCubeTexture(size.i, format.i, flags.i) As "sgd_CreateCubeTexture"
   ; ! Create a new Array texture. See also @ref SGD_TextureFlags.
   sgd_CreateArrayTexture(width.i, height.i, depth.i, format.i, flags.i) As "sgd_CreateArrayTexture"
   ; ! Get texture type.
   sgd_GetTextureType(texture.i) As "sgd_GetTextureType"
   ; ! Get width of texture.
   sgd_GetTextureWidth(texture.i) As "sgd_GetTextureWidth"
   ; ! Get height of texture.
   sgd_GetTextureHeight(texture.i) As "sgd_GetTextureHeight"
   ; ! Get Depth of texture.
   sgd_GetTextureDepth(texture.i) As "sgd_GetTextureDepth"
   ; ! Get texture format.
   sgd_GetTextureFormat(texture.i) As "sgd_GetTextureFormat"
   ; ! Get texture flags.
   sgd_GetTextureFlags(texture.i) As "sgd_GetTextureFlags"
   ; ! Set texture texel.
   sgd_SetTexelSRGBA(x.i,y.i, rgba.i) As "sgd_SetTexelSRGBA"
   ; ! Get texture texel
   sgd_GetTexelSRGBA( texture.i, x.i, y.i) As "sgd_GetTexelSRGBA"
   
   ; ! @defgroup MaterialTypes MaterialTypes
   ; ! @{

   ; ! Material handle type.
   ; typedef SGD_Handle SGD_Material;
   ; ! Material blend modes, For use With @ref sgd_SetMaterialBlendMode.
   Enumeration SGD_BlendMode
     #SGD_BLEND_MODE_OPAQUE = 1
	   #SGD_BLEND_MODE_ALPHA_MASK 
	   #SGD_BLEND_MODE_ALPHA_BLEND 
   EndEnumeration

   ; ! Material depth comparison functions, For use With @ref sgd_SetMaterialDepthFunc.
   Enumeration SGD_DepthFunc 
	   #SGD_DEPTH_FUNC_NEVER = 1
	   #SGD_DEPTH_FUNC_LESS 
	   #SGD_DEPTH_FUNC_EQUAL 
	   #SGD_DEPTH_FUNC_LESS_EQUAL 
	   #SGD_DEPTH_FUNC_GREATER 
	   #SGD_DEPTH_FUNC_NOT_EQUAL 
	   #SGD_DEPTH_FUNC_GREATER_EQUAL 
	   #SGD_DEPTH_FUNC_ALWAYS 
   EndEnumeration

   ; ! Material cull modes, For use With @ref sgd_SetMaterialCullMode.
   Enumeration SGD_CullMode
	   #SGD_CULL_MODE_NONE = 1
	   #SGD_CULL_MODE_FRONT 
	   #SGD_CULL_MODE_BACK 
   EndEnumeration
   ; ! @}

   ;-! @defgroup Material Material
  
   ; ! Load a new material from an '.sgd' material file.
   sgd_LoadMaterial_x(path.SGD_String) As "sgd_LoadMaterial"
   ; ! Create a new PBR material.
   sgd_CreatePBRMaterial() As "sgd_CreatePBRMaterial"
   ; ! Load a new PBR material.
   sgd_LoadPBRMaterial_x(path.SGD_String) As "sgd_LoadPBRMaterial"
   ; ! Create a new emissive material.
   sgd_CreateEmissiveMaterial() As "sgd_CreateEmissiveMaterial"
   ; ! Load a new emissive material from an image file.
   sgd_LoadEmissiveMaterial_x(path.SGD_String) As "sgd_LoadEmissiveMaterial"
   ; ! Set material blend mode.
   sgd_SetMaterialBlendMode(material.i, blendMode.i) As "sgd_SetMaterialBlendMode"
   ; ! Set material depth comparison function.
   sgd_SetMaterialDepthFunc(material.i, depthFun.i) As "sgd_SetMaterialDepthFunc"
   ; ! Set material cull mode.
   sgd_SetMaterialCullMode(material.i, cullMode.i) As "sgd_SetMaterialCullMode"
   ; ! Set material texture property.
   sgd_SetMaterialTexture_x(material.i,  parameter.SGD_String, texture.i) As "sgd_SetMaterialTexture"
   ; ! @}

   ; ! Set material color property.
   ; ! The color components should be IN non-linear color space, And should Not be premultiplied by alpha.
   sgd_SetMaterialColor_x(material.i, property.SGD_String , red.f, green.f, blue.f,alpha.f) As "sgd_SetMaterialColor"
   ; ! Set material vec4f property.
   sgd_SetMaterialVec4f_x(material.i, property.SGD_String , x.f,  y.f, z.f, w.f) As "sgd_SetMaterialVec4f"
   ; ! Set material vec3f property.
   sgd_SetMaterialVec3f_x(material.i, property.SGD_String , x.f,  y.f, z.f) As "sgd_SetMaterialVec3f"
   ; ! Set material vec2f property.
   sgd_SetMaterialVec2f_x(material.i, property.SGD_String , x.f,  y.f) As "sgd_SetMaterialVec2f"
   ; ! Set material float property.
   sgd_SetMaterialFloat_x(material.i, property.SGD_String , value.f) As "sgd_SetMaterialFloat"
   ; ! @}
    
   ;-! @defgroup Mesh Mesh
   
   ; ! Mesh flags.
   Enumeration SGD_MeshFlags 
	   #SGD_MESH_FLAGS_NONE             ;= 0,	 //!< No special mesh flags.
	   #SGD_MESH_FLAGS_TANGENTS_ENABLED ; = 1, //!< Mesh contains materials With normal maps.
	   #SGD_MESH_FLAGS_BLENDED_SURFACES ;= 2, //!< Mesh contains materials that use alphaBlend blend mode.
   EndEnumeration

   ; ! Load a new mesh.
   sgd_LoadMesh_x(path.SGD_String) As "sgd_LoadMesh"
   ; ! Copy mesh.
   sgd_CopyMesh(mesh.i) As "sgd_CopyMesh"
   ; ! Create a new box mesh.
   sgd_CreateBoxMesh(minX.f, minY.f, minZ.f, maxX.f, maxY.f, maxZ.f,material.i) As "sgd_CreateBoxMesh";
    ; ! Create a new sphere mesh.
    sgd_CreateSphereMesh(radius.f, xSegs.i, ySegs.i, material.i) As "sgd_CreateSphereMesh";
    ; ! Create a new cylinder mesh.
    sgd_CreateCylinderMesh(height.f, radius.f, segs.i, material.i) As "sgd_CreateCylinderMesh";
    ; ! Create a new cone mesh.
    sgd_CreateConeMesh(height.f, radius.f,segs.i, material.i) As "sgd_CreateConeMesh";
    ; ! Create a new torus mesh.
    sgd_CreateTorusMesh(outerRadius.f, innerRadius.f,outerSegs.i, innerSegs.i,material.i) As "sgd_CreateTorusMesh";
    ; ! Set mesh shadow casting enabled, defaults To true.
    sgd_SetMeshShadowsEnabled(mesh.i, enabled.i) As "sgd_SetMeshShadowsEnabled";
    ; ! Get mesh shadow casting enabled.
    sgd_IsMeshShadowsEnabled( mesh.i) As "sgd_IsMeshShadowsEnabled";
    ; ! Update mesh normals.
    sgd_UpdateMeshNormals(mesh.i) As "sgd_UpdateMeshNormals" 
    ; ! Update mesh tangets. Mesh must have SGD_MESH_TANGENTS_ENABLED flag.
    sgd_UpdateMeshTangents(mesh.i) As "sgd_UpdateMeshTangents";
    ; ! Fit mesh To a bounding box.
    sgd_FitMesh(mesh.i, minX.f, minY.f, minZ.f, maxX.f, maxY.f, maxZ.f,uniform.i) As "sgd_FitMesh";
    ; ! Transform mesh by translation, rotation, scale.
    sgd_TransformMesh(mesh.i, tx.f, ty.f, tz.f, rx.f, ry.f, rz.f, sx.f,sy.f, sz.f) As "sgd_TransformMesh";
    ; ! Transform mesh texture coordinates.
    sgd_TransformTexCoords(mesh.i, scaleX.f, scaleY.f, offsetX.f, offsetY.f) As "sgd_TransformTexCoords";
    ; ! Flip mesh.
    sgd_FlipMesh(mesh.i) As "sgd_FlipMesh";
    ; ! Get mesh bounding box min x coordinate.
    sgd_GetMeshBoundsMinX.f(mesh.i) As "sgd_GetMeshBoundsMinX";
    ; ! Get mesh bounding box min y coordinate.
    sgd_GetMeshBoundsMinY.f(mesh.i) As "sgd_GetMeshBoundsMinY";
    ; ! Get mesh bounding box min z coordinate.
    sgd_GetMeshBoundsMinZ.f(mesh.i);
    ; ! Get mesh bounding box max x coordinate.
    sgd_GetMeshBoundsMaxX.f(mesh.i) As "sgd_GetMeshBoundsMaxX";
    ; ! Get mesh bounding box max y coordinate.
    sgd_GetMeshBoundsMaxY.f(mesh.i) As "sgd_GetMeshBoundsMaxY";
    ; ! Get mesh bounding box max z coordinate.
    sgd_GetMeshBoundsMaxZ.f(mesh.i) As "sgd_GetMeshBoundsMaxZ";
    ; ! Create a new custom mesh. See also @ref SGD_MeshFlags.
    sgd_CreateMesh(vertexCount.i, flags.i) As "sgd_CreateMesh";
    ; ! ADD uninitialized vertices To a mesh, returning index of the first new vertex.
    sgd_ResizeVertices(mesh.i, count.i) As "sgd_ResizeVertices";
    ; ! Get number of vertices IN mesh.
    sgd_GetVertexCount(mesh.i) As "sgd_GetVertexCount";
    ; ! ADD a vertex To a mesh, returning index of new vertex.
    sgd_AddVertex(mesh.i, x.f, y.f, z.f, nx.f, ny.f, nz.f, s.f, t.f) As "sgd_AddVertex";
    ; ! Set vertex.
    sgd_SetVertex(mesh.i, vertex.i, x.f, y.f, z.f, nx.f, ny.f, nz.f, s.f, t.f) As "sgd_SetVertex";
    ; ! Set vertex position.
    sgd_SetVertexPosition(mesh.i, vertex.i, x.f, y.f, z.f) As "sgd_SetVertexPosition";
    ; ! Set vertex normal.
    sgd_SetVertexNormal(mesh.i, vertex.i, nx.f, ny.f, nz.f) As "sgd_SetVertexNormal";
    ; ! Set vertex tangent.
    sgd_SetVertexTangent(mesh.i, vertex.i, tx.f, ty.f, tz.f, tw.f) As "sgd_SetVertexTangent";
    ; ! Set vertex color.
    sgd_SetVertexColor(mesh.i, vertex.i, r.f, g.f, b.f, a.f) As "sgd_SetVertexColor";
    ; ! Set vertex texture coordinate 0.
    sgd_SetVertexTexCoord0(mesh.i, vertex.i, u0.f, v0.f) As "sgd_SetVertexTexCoord0";
    ; ! Get vertex position x coordinate.
    sgd_GetVertexX.f(mesh.i, vertex.i)As "sgd_GetVertexX";
    ; ! Get vertex position y coordinate.
    sgd_GetVertexY.f(mesh.i, vertex.i)As "sgd_GetVertexY";
    ; ! Get vertex position z coordinate.
    sgd_GetVertexZ.f(mesh.i, vertex.i)As "sgd_GetVertexZ";
    ; ! Get vertex normal x component.
    sgd_GetVertexNX.f(mesh.i, vertex.i)As "sgd_GetVertexNX";
    ; ! Get vertex normal y component.
    sgd_GetVertexNY.f(mesh.i, vertex.i)As "sgd_GetVertexNY";
    ; ! Get vertex normal z component.
    sgd_GetVertexNZ.f(mesh.i, vertex.i)As "sgd_GetVertexNZ";
    ; ! Get vertex tangent x component.
    sgd_GetVertexTX.f(mesh.i, vertex.i)As "sgd_GetVertexTX";
    ; ! Get vertex tangent y component.
    sgd_GetVertexTY.f(mesh.i, vertex.i)As "sgd_GetVertexTY";
    ; ! Get vertex tangent z component.
    sgd_GetVertexTZ.f(mesh.i, vertex.i)As "sgd_GetVertexTZ";
    ; ! Get vertex tangent w component.
    sgd_GetVertexTW.f(mesh.i, vertex.i)As "sgd_GetVertexTW";
    ; ! Get vertex color red component.
    sgd_GetVertexRed.f(mesh.i, vertex.i)As "sgd_GetVertexRed";
    ; ! Get vertex color green component.
    sgd_GetVertexGreen.f(mesh.i, vertex.i)As "sgd_GetVertexGreen";
    ; ! Get vertex color blue component.
    sgd_GetVertexBlue.f(mesh.i, vertex.i)As "sgd_GetVertexBlue";
    ; ! Get vertex color alpha component.
    sgd_GetVertexAlpha.f(mesh.i, vertex.i)As "sgd_GetVertexAlpha";
    ; ! Get vertex texture coordinate 0 u component.
    sgd_GetVertexU0(mesh.i, vertex.i)As "sgd_GetVertexU0";
    ; ! Get vertex tangent coorindate 1 y component.
    sgd_GetVertexV0.f(mesh.i, vertex.i)As "sgd_GetVertexV0";
    ; ! Create a new Surface And ADD it To mesh.
    sgd_CreateSurface(mesh.i, material.i, triangleCount.i)As "sgd_CreateSurface";
    ; ! Get mesh surface count.
    sgd_GetSurfaceCount(mesh.i)As "sgd_GetSurfaceCount";
    ; ! Get mesh surface.
    sgd_GetSurface(mesh.i, surface.i)As "sgd_GetSurface";
    ; ! Get surface material.
    sgd_GetMaterial(surface.i)As "sgd_GetMaterial";
    ; ! ADD empty triangles To surface, returning index of first new triangle.
    sgd_ResizeTriangles(surface.i, count.i)As "sgd_ResizeTriangles";
    ; ! Get number of triangles IN surface.
    sgd_GetTriangleCount(surface.i)As "sgd_GetTriangleCount";
    ; ! ADD triangle To surface, returning index of new triangle.
    sgd_AddTriangle(surface.i, v0.i, v1.i, v2.i)As "sgd_AddTriangle";
    ; ! Update existing triangle vertices IN surface.
    sgd_SetTriangle(surface.i,triangle.i, v0.i, v1.i, v2.i)As "sgd_SetTriangle";
    ; ! Get mesh vertex index of a triangle corner. Vertex must be 0, 1 Or 2.
    sgd_GetTriangleVertex(surface.i, triangle.i, vertex.i) As "sgd_GetTriangleVertex";
    
    ;-! @defgroup Font Font
    ; ! Load a new font.
    sgd_LoadFont_x(path.SGD_String, height.f) As "sgd_LoadFont";
    ; ! Get width of text.
    sgd_GetTextWidth_x.f(font.i, text.SGD_String) As "sgd_GetTextWidth";
    ; ! get height of font.
    sgd_GetFontHeight.f(font.i) As "sgd_GetFontHeight";

    ;-! @defgroup Image Image
    ; ! Load an image For use With 3D sprites Or Draw2DImage.
    sgd_LoadImage_x(path.SGD_String) As "sgd_LoadImage";
    ; ! Load an Array image For use With 3D sprites Or Draw2DImage.
    sgd_LoadArrayImage_x(path.SGD_String , frameCount.i, framesX.i, framesY.i, frameSpacing.i) As "sgd_LoadArrayImage";
    ; ! Create an image With an existing texture.
    sgd_CreateImage(texture.i ) As "sgd_CreateImage";
    
    ; ! Image view modes.
    Enumeration SGD_ImageViewMode 
	    #SGD_IMAGE_VIEW_MODE_FIXED = 1
	    #SGD_IMAGE_VIEW_MODE_FREE 
	    #SGD_IMAGE_VIEW_MODE_UPRIGHT 
    EndEnumeration

    ; ! Set view mode For use With 3D sprites.
    sgd_SetImageViewMode(image.i, viewMode.i) As "sgd_SetImageViewMode";
    ; ! Set image blend mode.
    sgd_SetImageBlendMode(image.i, blendMode.i) As "sgd_SetImageBlendMode";
    ; ! Set rect For use With 3D sprites.
    sgd_SetImageRect(image.i, minX.f, minY.f, maxX.f, maxY.f) As "sgd_SetImageRect";
    ; ! Get texture used To create image.
    sgd_GetImageTexture(image.i) As "sgd_GetImageTexture";
        
    ;-! @defgroup Overlay Overlay
    ; ! Set current fill color For drawing shapes.
    sgd_Set2DFillColor(red.f, green.f, blue.f, alpha.f) As "sgd_Set2DFillColor";
    ; ! Set current fill material For drawing shapes.
    sgd_Set2DFillMaterial(material.i) As "sgd_Set2DFillMaterial";
    ; ! SetCurrent file enabled flag For drawing shapes.
    sgd_Set2DFillEnabled(enabled.i) As "sgd_Set2DFillEnabled";
    ; ! Set current outline color For drawing shapes.
    sgd_Set2DOutlineColor(red.f, green.f, blue.f, alpha.f) As "sgd_Set2DOutlineColor";
    ; ! Set current outline width, defaults To 3.
    sgd_Set2DOutlineWidth(width.f) As "sgd_Set2DOutlineWidth";
    ; ! SetCurrent outline enabled flag For drawing shapes.
    sgd_Set2DOutlineEnabled(enabled.i) As "sgd_Set2DOutlineEnabled";
    ; ! Set current line width, defaults To 3.
    sgd_Set2DLineWidth(width.f) As "sgd_Set2DLineWidth";
    ; ! Set current point size, defaults To 3.
    sgd_Set2DPointSize(size.f) As "sgd_Set2DPointSize";
    ; ! Set current font.
    sgd_Set2DFont(font.f) As "sgd_Set2DFont";
    ; ! Set current text color.
    sgd_Set2DTextColor(red.f, green.f, blue.f, alpha.f) As "sgd_Set2DTextColor";
    ; ! Get width of 2d text IN the current 2D font.
    sgd_Get2DTextWidth_x.f(text.SGD_String) As "sgd_Get2DTextWidth";
    ; ! Get height of current 2d font.
    sgd_Get2DFontHeight() As "sgd_Get2DFontHeight";
    ; ! Clear the current 2d overlay.
    sgd_Clear2D() As "sgd_Clear2D";
    ; ! PUSH current draw List To layer stack, effectively 'freezing' it As a background layer Until popped.
    sgd_Push2DLayer() As "sgd_Push2DLayer";
    ; ! POP layer stack.
    sgd_Pop2DLayer() As "sgd_Pop2DLayer";
    ; ! Draw point using current fill And outline colors.
    sgd_Draw2DPoint(x0.f, y0.f) As "sgd_Draw2DPoint";
    ; ! Draw line using current fill And outline colors.
    sgd_Draw2DLine(x0.f, y0.f, x1.f, y1.f) As "sgd_Draw2DLine";
    ; ! Draw rect using current fill And outline colors.
    sgd_Draw2DRect(minX.f, minY.f, maxX.f, maxY.f) As "sgd_Draw2DRect";
    ; ! Draw image using current fill color.
    sgd_Draw2DImage(image.i, x.f, y.f, frame.f) As "sgd_Draw2DImage";
    ; ! Draw oval using current fill And outline colors.
    sgd_Draw2DOval(minX.f, minY.f, maxX.f, maxY.f) As "sgd_Draw2DOval";
    ; ! Draw text using current text color.
    sgd_Draw2DText_x(text.SGD_String, x.f, y.f) As "sgd_Draw2DText";
    
    ;-! @defgroup Scene Scene
    ; ! Destroy all active entities.
    sgd_ClearScene() As "sgd_ClearScene";
    ; ! Reset scene To Default state.
    ; ! Destroys all active entities IN the scene.
    ; ! If the release all handles argument is true, sgd_ReleaseAllHandles is also called, allowing
    sgd_ResetScene(releaseAllHandles.i) As "sgd_ResetScene";
    ; ! Experimental JSON loader!
    sgd_LoadScene_x( path.SGD_String) As "sgd_LoadScene";
    ; ! Experimental JSON saver!
    sgd_SaveScene_x( path.SGD_String) As "sgd_SaveScene";
    ; ! Set scene ambient light color.
    sgd_SetAmbientLightColor(red.f,green.f, blue.f, alpha.f) As "sgd_SetAmbientLightColor";
    ; ! Set scene clear color.
    sgd_SetClearColor(red.f, green.f, blue.f, alpha.f) As "sgd_SetClearColor";
    ; ! Set scene clear depth.
    sgd_SetClearDepth(depth.f) As "sgd_SetClearDepth";
    ; ! Set scene environment texture.
    sgd_SetEnvTexture( texture.i) As "sgd_SetEnvTexture";
    
    ; ! Update scene shadow mapping config from config vars.
    ; ! This function will update shadow mapping config variables from the current config vars, see sgd_SetConfigVar.
    ; !
    ; ! Config Var         | Type  | Default                | Description
    ; ! -------------------|-------|------------------------|------------
    ; ! csm.textureSize    | INT   | "2048"                 | Texture size of each of the 4 cascading shadow Map textures.
    ; ! csm.maxLights      | INT   | "4"                    | Max directional light shadow casters.
    ; ! csm.clipRange      | float | "330.0"                | Max offscreen distance To render shadow casters.
    ; ! csm.depthBias      | float | "0.0001"               | Depth bias For cascading shadow maps.
    ; ! csm.SplitDistances | Vec4f | "15,60,250,1000"       | Cascading shadow Map split distances from the eye.
    ; ! psm.textureSize    | INT   | "1024"                 | Texture size of point light cube shadow textures.
    ; ! psm.maxLights      | INT   | "32"                   | Max point light shadow casters.
    ; ! psm.clipNear       | float | "0.25"                 | Near clipping plane For point light shadow maps.
    ; ! psm.depthBias      | float | "0.0001"               | Depth bias value For p[oint light shadow maps.
    ; ! ssm.textureSize    | INT   | "1024"                 | Texture size of each spot light 2D shadow Map.
    ; ! ssm.maxLights      | INT   | "16"                   | Max spot light shadow casters.
    ; ! ssm.clipNear       | float | "0.25"                 | Max distance To render shadow casters.
    ; ! ssm.depthBias      | float | "0.0001"               | Depth bias value To prevent shadow acne.
    sgd_UpdateShadowMappingConfig() As "sgd_UpdateShadowMappingConfig";
    ; ! Render scene.
    sgd_RenderScene() As "sgd_RenderScene";
    ; ! Present.
    sgd_Present() As "sgd_Present";
    ; ! Return frames per second.
    sgd_GetFPS.f() As "sgd_GetFPS";
    ; ! Return renders per second.
    sgd_GetRPS.f() As "sgd_GetRPS";
    
    ;-! @defgroup Entity Entity
    ; ! Set entity enabled state. An entity is only enabled IN the scene If both it And all its ancestors are enabled.
    sgd_SetEntityEnabled(entity.i, enabled.i) As "sgd_SetEntityEnabled";
    ; ! Get entity enabled state.
    sgd_IsEntityEnabled(entity.i) As "sgd_IsEntityEnabled";
    ; ! Set entity visible state. An entity is only visible IN the scene If both it And all its ancestors are visible.
    sgd_SetEntityVisible(entity.i, visible.i) As "sgd_SetEntityVisible";
    ; ! Get entity visible state.
    sgd_IsEntityVisible(entity.i) As "sgd_IsEntityVisible";
    ; ! Destroy entity And children recursively.
    sgd_DestroyEntity(entity.i) As "sgd_DestroyEntity";
    ; ! Reset entity collision state.
    sgd_ResetEntity(entity.i) As "sgd_ResetEntity";
    ; ! Copy entity And children recursively.
    sgd_CopyEntity(entity.i) As "sgd_CopyEntity";
    ; ! Set entity name
    sgd_SetEntityName_x(entity.i, name.SGD_String) As "sgd_SetEntityName";
    ; ! Get entity name. The returned string will remain valid Until the Next CALL To sgd_GetEntityName.
    sgd_GetEntityName_x(entity.i) As "sgd_GetEntityName";
    ; ! Set entity's parent.
    sgd_SetEntityParent(entity.i, parent.i) As "sgd_SetEntityParent";
    ; ! Get entity's parent.
    sgd_GetEntityParent(entity.i) As "sgd_GetEntityParent";
    ; ! Get entity number of children
    sgd_GetEntityChildCount(entity.i) As "sgd_GetEntityChildCount";
    ; ! Get entity child by index. childIndex must be >= 0 And < sgd_GetEntityChildCount(entity)
    sgd_GetEntityChild(entity.i, childIndex.i) As "sgd_GetEntityChild";
    ; ! Recursively search For an entity by name. If parent is 0, the entire scene is searched.
    sgd_FindEntityChild_x(entity.i, childName.SGD_String) As "sgd_FindEntityChild";
    ; ! Set entity's world space position.
    sgd_SetEntityPosition(entity.i, tx.SGD_Real, ty.SGD_Real, tz.SGD_Real ) As "sgd_SetEntityPosition";
    ; ! Set entity's world space rotation.
    sgd_SetEntityRotation(entity.i, rx.SGD_Real, ry.SGD_Real, rz.SGD_Real) As "sgd_SetEntityRotation";
    ; ! Set entity world space scale.
    sgd_SetEntityScale(entity.i, sx.SGD_Real, sy.SGD_Real, sz.SGD_Real) As "sgd_SetEntityScale";
    ; ! Translate entity IN world space.
    sgd_TranslateEntity(entity.i, tx.SGD_Real, ty.SGD_Real, tz.SGD_Real) As "sgd_TranslateEntity";
    ; ! Rotate entity IN world space.
    sgd_RotateEntity(entity.i, rx.SGD_Real, ry.SGD_Real, rz.SGD_Real) As "sgd_RotateEntity";
    ; ! Scale entity IN world space.
    sgd_ScaleEntity(entity.i, sx.SGD_Real, sy.SGD_Real, sz.SGD_Real) As "sgd_ScaleEntity";
    ; ! Move entity relative To it's current orientation.
    sgd_MoveEntity(entity.i, tx.SGD_Real,ty.SGD_Real, tz.SGD_Real) As "sgd_MoveEntity";
    ; ! Turn entity relative To it's current orientation.
    sgd_TurnEntity(entity.i, rx.SGD_Real, ry.SGD_Real, rz.SGD_Real) As "sgd_TurnEntity";
    ; ! Get the X component of entity's world space position.
    sgd_GetEntityX.SGD_Real(entity.i) As "sgd_GetEntityX";
    ; ! Get the Y component of entity's world space position.
    sgd_GetEntityY.SGD_Real(entity.i) As "sgd_GetEntityY";
    ; ! Get the Z component of entity's world space position.
    sgd_GetEntityZ.SGD_Real(entity.i) As "sgd_GetEntityZ";
    ; ! Get the X rotation component (ie: 'pitch') of entity's world space orientation.
    sgd_GetEntityRX.SGD_Real(entity.i) As "sgd_GetEntityRX";
    ; ! Get the Y rotation component (ie: 'yaw') of entity's world space orientation.
    sgd_GetEntityRY.SGD_Real(entity.i) As "sgd_GetEntityRY";
    ; ! Get the Z rotation component (ie: 'roll') of entity's world space orientation.
    sgd_GetEntityRZ.SGD_Real(entity.i) As "sgd_GetEntityRZ";
    ; ! Get the X component of entity's world space scale factor.
    sgd_GetEntitySX.SGD_Real(entity.i) As "sgd_GetEntitySX";
    ; ! Get the Y component of entity's world space scale factor.
    sgd_GetEntitySY.SGD_Real(entity.i) As "sgd_GetEntitySY";
    ; ! Get the Z component of entity's world space scale factor.
    sgd_GetEntitySZ.SGD_Real(entity.i) As "sgd_GetEntitySZ";
    ; ! Get the X component of entity's world space basis matrix right vector.
    sgd_GetEntityIX.SGD_Real(entity.i) As "sgd_GetEntityIX";
    ; ! Get the Y component of entity's world space basis matrix right vector.
    sgd_GetEntityIY.SGD_Real(entity.i) As "sgd_GetEntityIY";
    ; ! Get the Z component of entity's world space basis matrix right vector.
    sgd_GetEntityIZ.SGD_Real(entity.i) As "sgd_GetEntityIZ";
    ; ! Get the X component of entity's world space basis matrix up vector.
    sgd_GetEntityJX.SGD_Real(entity.i) As "sgd_GetEntityJX";
    ; ! Get the Y component of entity's world space basis matrix up vector.
    sgd_GetEntityJY.SGD_Real(entity.i) As "sgd_GetEntityJY";
    ; ! Get the Z component of entity's world space basis matrix up vector.
    sgd_GetEntityJZ.SGD_Real(entity.i) As "sgd_GetEntityJZ";
    ; ! Get the X component of entity's world space basis matrix forward vector.
    sgd_GetEntityKX.SGD_Real(entity.i) As "sgd_GetEntityKX";
    ; ! Get the Y component of entity's world space basis matrix forward vector.
    sgd_GetEntityKY.SGD_Real(entity.i) As "sgd_GetEntityKY";
    ; ! Get the Z component of entity's world space basis matrix forward vector.
    sgd_GetEntityKZ.SGD_Real(entity.i) As "sgd_GetEntityKZ";
    ; ! Aim entity at entity.
    sgd_AimEntityAtEntity(entity.i, target.i, roll.f) As "sgd_AimEntityAtEntity";
    ; ! Aim entity at point IN world space.
    sgd_AimEntityAtPoint(entity.i, x.SGD_Real, y.SGD_Real, z.SGD_Real, roll.f) As "sgd_AimEntityAtPoint";
    ; ! Transform 3d point from one entity coordinate space To another.
    sgd_TransformPoint(x.SGD_Real, y.SGD_Real, z.SGD_Real, srcEntity.i, dstEntity.i) As "sgd_TransformPoint";
    ; ! Transform 3d vector from one entity coordinate space To another.
    sgd_TransformVector(x.SGD_Real, y.SGD_Real, z.SGD_Real, srcEntity.i, dstEntity.i) As "sgd_TransformVector";
    ; ! Transform 3d normal from one entity coordinate space To another.
    sgd_TransformNormal(x.SGD_Real,y.SGD_Real, z.SGD_Real, srcEntity.i, dstEntity.i) As "sgd_TransformNormal";
    ; ! X component of most recent sgd_TransformPoint result.
    sgd_GetTransformedX.SGD_Real() As "sgd_GetTransformedX";
    ; ! Y component of most recent sgd_TransformPoint result.
    sgd_GetTransformedY.SGD_Real() As "sgd_GetTransformedY";
    ; ! Z component of most recent sgd_TransformPoint result.
    sgd_GetTransformedZ.SGD_Real() As "sgd_GetTransformedZ";
    
    ; ! @defgroup CameraTypes CameraTypes
    ; ! Camera handle type.
    ;typedef SGD_Entity SGD_Camera;
    Enumeration SGD_CameraType 
	    #SGD_CAMERA_TYPE_PERSPECTIVE = 1
	    #SGD_CAMERA_TYPE_ORTHOGRAPHIC 
	  EndEnumeration 
	    ; ! @}
    
    ;-! @defgroup Camera Camera
    ; ! Create a new perspective camera.
    sgd_CreatePerspectiveCamera() As "sgd_CreatePerspectiveCamera";
    ; ! Create a new orthographic camera.
    sgd_CreateOrthographicCamera() As "sgd_CreateOrthographicCamera";
    ; ! Get camera type.
    sgd_GetCameraType(camera.i) As "sgd_GetCameraType";
    ; ! Set camera vertical field of view IN degrees. Defaults To 90.
    sgd_SetCameraFOV(camera.i, fovY.f) As "sgd_SetCameraFOV";
    ; ! Set camera near clipping plane. Defaults To 0.1.
    sgd_SetCameraNear(camera.i, near.f) As "sgd_SetCameraNear";
    ; ! Set camera far clipping plane. Defaults To 1000.
    sgd_SetCameraFar(camera.i, far.f) As "sgd_SetCameraFar";
    ; ! Project 3d point IN world space To window coordinates.
    sgd_CameraProject(camera.f, x.SGD_Real, y.SGD_Real, z.SGD_Real) As "sgd_CameraProject";
    ; ! X coordinate of projected point IN window coordinates.
    sgd_GetProjectedX.f() As "sgd_GetProjectedX";
    ; ! Y coordinate of projected point IN window coordinates.
    sgd_GetProjectedY.f() As "sgd_GetProjectedY";
    ; ! Unproject 3d point IN wndow coordinates To world coordinates.
    sgd_CameraUnproject(camera.i, windowX.f, windowY.f, viewZ.f) As "sgd_CameraUnproject";
    ; ! X coordinate of projected point IN window coordinates.
    sgd_GetUnprojectedX.SGD_Real() As "sgd_GetUnprojectedX";
    ; ! Y coordinate of projected point IN window coordinates.
    sgd_GetUnprojectedY.SGD_Real() As "sgd_GetUnprojectedY";
    ; ! Z coordinate of projected point IN window coordinates.
    sgd_GetUnprojectedZ.SGD_Real() As "sgd_GetUnprojectedZ";
    
    ; ! @defgroup LightTypes LightTypes
    ; ! Light handle type.
    ;typedef SGD_Entity SGD_Light;
    ; ! Light type.
    Enumeration SGD_LightType 
      #SGD_LIGHT_TYPE_DIRECTIONAL = 1
	    #SGD_LIGHT_TYPE_POINT
	    #SGD_LIGHT_TYPE_SPOT 
    EndEnumeration
    ; ! @}
    
    ;-! @defgroup Light Light
    ; ! Create a new directional light.
    ; ! A maximum of 4 directional lights are supported by the renderer. If you create more than that, the 4 With the highest
    ; ! priority will be used. See @ref sgd_SetLightPriority.
    sgd_CreateDirectionalLight() As "sgd_CreateDirectionalLight";
    ; ! Create a new point light.
    ; ! A maximum of 32 point lights are supported by the renderer. If you create more than that, the 32 With the highest priority
    ; ! will be used. See @ref sgd_SetLightPriority. If there are more than 32 With the highest priority, the 32 nearest the camera
    ; ! will be used.
    sgd_CreatePointLight() As "sgd_CreatePointLight";
    ; ! Create a new spot light.
    ; ! A maximum of 16 spot lights are supported by the renderer. If you create more than that, the 16 With the highest priority
    ; ! will be used. See @ref sgd_SetLightPriority. If there are more than 16 With the highest priority, the 16 nearest the camera
    ; ! will be used.
    sgd_CreateSpotLight() As "sgd_CreateSpotLight";
    ; ! Get Light type.
    sgd_GetLightType(light.i) As "sgd_GetLightType";
    ; ! Set light shadow mapping enabled, defaults To false.
    sgd_SetLightShadowsEnabled(light.i, enabled.i) As "sgd_SetLightShadowsEnabled";
    ; ! Get light shadow mapping enabled.
    sgd_IsLightShadowsEnabled(light.i) As "sgd_IsLightShadowsEnabled";
    ; ! Set light priority, defaults To 0.
    sgd_SetLightPriority(light.i, priority.i) As "sgd_SetLightPriority";
    ; ! Get light priority.
    sgd_GetLightPriority(light.i) As "sgd_GetLightPriority";
    ; ! Set light color.
    sgd_SetLightColor(light.i, red.f, green.f, blue.f, alpha.f) As "sgd_SetLightColor";
    ; ! Set point/spot light range.
    sgd_SetLightRange(light.i, range.f) As "sgd_SetLightRange";
    ; ! Set point/spot light falloff.
    sgd_SetLightFalloff(light.i, falloff.f) As "sgd_SetLightFalloff";
    ; ! Set spot light inner cone angle IN degrees.
    sgd_SetLightInnerConeAngle(light.i, angle.f) As "sgd_SetLightInnerConeAngle";
    ; ! Set spot light outer cone angle IN degrees.
    sgd_SetLightOuterConeAngle(light.i, angle.f) As "sgd_SetLightOuterConeAngle";
    
    ; ! @defgroup ModelTypes ModelTypes
    ; ! Model handle type.
    ; typedef SGD_Entity SGD_Model;
    ; ! Animation modes.
    Enumeration SGD_AnimationMode 
	    #SGD_ANIMATION_MODE_ONE_SHOT = 1
	    #SGD_ANIMATION_MODE_LOOP 
	    #SGD_ANIMATION_MODE_PING_PONG 
    EndEnumeration
    ; ! @}
    
    ;-! @defgroup Model Model
    ; ! Load a model.
    sgd_LoadModel_x(path.SGD_String ) As "sgd_LoadModel";
    ; ! Load a boned model.
    sgd_LoadBonedModel_x(path.SGD_String , skinned.i) As "sgd_LoadBonedModel";
    ; ! Create a new model.
    sgd_CreateModel(mesh.i) As "sgd_CreateModel";
    ; ! Set model mesh.
    sgd_SetModelMesh(model.i, mesh.i) As "sgd_SetModelMesh";
    ; ! Get model mesh.
    sgd_GetModelMesh(model.i) As "sgd_GetModelMesh";
    ; ! Set model color.
    sgd_SetModelColor(model.i, red.f, green.f, blue.f, alpha.f) As "sgd_SetModelColor";
    ; ! Animate a model.
    sgd_AnimateModel(model.i, animation.i, time.f, animationMode.i,weight.f) As "sgd_AnimateModel";
    
    ;-! @defgroup Skybox Skybox
    ; ! Load a skybox.
    sgd_LoadSkybox_x(path.SGD_String, roughness.f) As "sgd_LoadSkybox";
    ; ! Create a new skybox.
    sgd_CreateSkybox(texture.i) As "sgd_CreateSkybox";
    ; ! Set skybox texture.
    sgd_SetSkyboxTexture(skybox.i, texture.i) As "sgd_SetSkyboxTexture";
    ; ! Set skybox roughness IN the range 0 To 1.
    sgd_SetSkyboxRoughness(skybox.i, roughness.f) As "sgd_SetSkyboxRoughness";
    
    ;-! @defgroup Plane Plane
    ; ! Create a new Plane entity.
    sgd_CreatePlane(material.i) As "sgd_CreatePlane";
    ; ! Set plane material.
    sgd_SetPlaneMaterial(plane.i, material.i) As "sgd_SetPlaneMaterial";
    ; ! Get plane material.
    sgd_GetPlaneMaterial(plane.i) As "sgd_GetPlaneMaterial";

    ;-! @defgroup Terrain Terrain
    ; ! Create a new terrain.
    sgd_CreateTerrain() As "sgd_CreateTerrain";
    ; ! Set terrain size.
    sgd_SetTerrainSize(terrain.i, size.i) As "sgd_SetTerrainSize";
    ; ! Set terrain level-of-details.
    sgd_SetTerrainLODs(terrain.i, Loods.i) As "sgd_SetTerrainLODs";
    ; ! Set terrain material.
    sgd_SetTerrainMaterial(terrain.i,material.i) As "sgd_SetTerrainMaterial";
    ; ! Set terrain material size.
    sgd_SetTerrainMaterialSize(terrain.i, materialSize.i) As "sgd_SetTerrainMaterialSize";
    ; ! Set terrain height texture.
    sgd_SetTerrainHeightTexture(terrain.i, texture.i) As "sgd_SetTerrainHeightTexture";
    ; ! Set terrain normal texture.
    sgd_SetTerrainNormalTexture(terrain.i, texture.i) As "sgd_SetTerrainNormalTexture";
    ; ! Set terrain Debug mode.
    sgd_SetTerrainDebugMode(terrain.i, debugMode.i) As "sgd_SetTerrainDebugMode";
    ; ! Get terrain height at world x/z coordinates.
    sgd_GetTerrainHeight.SGD_Real(terrain.i,  x.SGD_Real, z.SGD_Real ) As "sgd_GetTerrainHeight"

    ;-! @defgroup Sprite Sprite
    ; ! Create a new sprite.
    sgd_CreateSprite(image.i) As "sgd_CreateSprite";
    ; ! Set sprite material.
    sgd_SetSpriteImage(sprite.i, image.i) As "sgd_SetSpriteImage";
    ; ! Set sprite color.
    sgd_SetSpriteColor(sprite.i, red.f, green.f, blue.f, alpha.f) As "sgd_SetSpriteColor";
    ; ! Set sprite animation frame.
    sgd_SetSpriteFrame(sprite.i, frame.f) As "sgd_SetSpriteFrame";
    
    ; ! @defgroup CollisionTypes CollisionTypes
    ; ! Collider handle type.
    ;typedef SGD_Handle SGD_Collider;
    ; ! Collision responses
    Enumeration SGD_CollisionResponse
	     #SGD_COLLISION_RESPONSE_NONE 
	     #SGD_COLLISION_RESPONSE_STOP 
	     #SGD_COLLISION_RESPONSE_SLIDE 
	     #SGD_COLLISION_RESPONSE_SLIDEXZ 
    EndEnumeration
    ; ! @}
    
    ;-! @defgroup Collision Collision
    ; ! Create a new sphere collider And attach it To entity.
    sgd_CreateSphereCollider(entity.i, colliderType.i, radius.f) As "sgd_CreateSphereCollider";
    ; ! Create a new ellipsoid collider And attach it To entity.
    sgd_CreateEllipsoidCollider(entity.i, colliderType.i, radius.f, height.f) As "sgd_CreateEllipsoidCollider";
    ; ! Create a new mesh collider And attach it To entity.
    ; ! If mesh is 0, entity must a Model entity, And is used To provide the collision mesh.
    sgd_CreateMeshCollider(entity.i, colliderType.i, mesh.i) As "sgd_CreateMeshCollider";
    ; ! Create a new terrain collider And attach it To entity.
    ; ! The entity must be a terrain entity.
    sgd_CreateTerrainCollider(terrain.i, colliderType.i) As "sgd_CreateTerrainCollider";
    ; ! Create a new plane collider And attach it To entity.
    sgd_CreatePlaneCollider(entity.i, colliderType.i) As "sgd_CreatePlaneCollider";
    ; ! Return entity a collider is attached To.
    sgd_GetColliderEntity(collider.i) As "sgd_GetColliderEntity";
    ; ! Get collider type.
    sgd_GetColliderType(collider.i) As "sgd_GetColliderType";
    ; ! Set sphere Or ellipsoid collider radius.
    sgd_SetColliderRadius(collider.i, radius.f) As "sgd_SetColliderRadius";
    ; ! Set ellipsoid collider height.
    sgd_SetColliderHeight(collider.i, height.f) As "sgd_SetColliderHeight";
    ; ! Enable collisons between 2 collider types.
    sgd_EnableCollisions(srcColliderType.i, dstColliderType.i, response.i) As "sgd_EnableCollisions";
    ; ! Update enabled colliders.
    sgd_UpdateColliders() As "sgd_UpdateColliders";
    ; ! Get collisions generated by sgd_UpdateColliders For moving collider.
    sgd_GetCollisionCount(collider.i) As "sgd_GetCollisionCount";
    ; ! Get the collider a collision was With.
    sgd_GetCollisionCollider(collider.i, index.i) As "sgd_GetCollisionCollider";
    ; ! Get collision X coordinate.
    sgd_GetCollisionX.SGD_Real(collider.i, index.i) As "sgd_GetCollisionX";
    ; ! Get collision Y coordinate.
    sgd_GetCollisionY.SGD_Real(collider.i, index.i) As "sgd_GetCollisionY";
    ; ! Get collision Z coordinate.
    sgd_GetCollisionZ.SGD_Real(collider.i, index.i) As "sgd_GetCollisionZ";
    ; ! Get collision normal X component.
    sgd_GetCollisionNX.SGD_Real(collider.i, index.i) As "sgd_GetCollisionNX";
    ; ! Get collision normal Y component.
    sgd_GetCollisionNY.SGD_Real(collider.i, index.i) As "sgd_GetCollisionNY";
    ; ! Get collision normal Z component.
    sgd_GetCollisionNZ.SGD_Real(collider.i, index.i) As "sgd_GetCollisionNZ";

    ;-! @defgroup Picking Picking
    ; ! Pick first collider along ray passing from camera eye through window coordinates.
    ; ! Note that the colliderMask parameter is a 'bitmask' value, where each '1' bit IN the value's binary representation
    ; ! repesents a collider type you want To be included IN the pick, allowing you To pick more than 1 collider type IN a single
    ; ! pick.
    ; ! For example, If you want the pick To include collider types 0 And 3, you would set bits 0 And 3 IN the colliderMask,
    ; ! resuling IN a value of 2^0 | 2^3 == 9.
    ; ! If you want the pick To include *all* collider types, use a colliderMask of -1, a bitmask value With all bits set.
    sgd_CameraPick(camera.i, windowX.f, windowY.f, colliderMask.i) As "sgd_CameraPick";
    ; ! Pick first collider along line.
    ; ! Please see @ref sgd_CameraPick For more information about the colliderMask parameter.
    sgd_LinePick(x0.SGD_Real ,y0.SGD_Real , z0.SGD_Real , x1.SGD_Real , y1.SGD_Real , z1.SGD_Real ,radius.SGD_Real, colliderMask.i) As "sgd_LinePick";
    ; ! X coordinate of pick contact point IN world space.
    sgd_GetPickedX.SGD_Real() As "sgd_GetPickedX";
    ; ! Y coordinate of pick contact point IN world space.
    sgd_GetPickedY.SGD_Real() As "sgd_GetPickedY";
    ; ! Z coordinate of pick contact point IN world space.
    sgd_GetPickedZ.SGD_Real() As "sgd_GetPickedZ";
    ; ! X compnent of pick contact normal IN world space.
    sgd_GetPickedNX.SGD_Real() As "sgd_GetPickedNX";
    ; ! Y component of pick contact normal IN world space.
    sgd_GetPickedNY.SGD_Real() As "sgd_GetPickedNY";
    ; ! Z component of pick contact normal IN world space.
    sgd_GetPickedNZ.SGD_Real() As "sgd_GetPickedNZ";

    ;-! @defgroup RenderEffect RenderEffect
    ; ! Create a new bloom effect And ADD it To the scene.
    sgd_CreateBloomEffect() As "sgd_CreateBloomEffect";
    ; ! Set bloom render effect radius, should be IN the range 1 To 31 inclusive, defaults To 2.
    sgd_SetBloomEffectRadius(effect.i, radius.i) As "sgd_SetBloomEffectRadius";
    ; ! Get bloom render effect radius.
    sgd_GetBloomEffectRadius(effect.i) As "sgd_GetBloomEffectRadius";
    ; ! Create a new blur render effect And ADD it To the scene.
    sgd_CreateBlurEffect() As "sgd_CreateBlurEffect";
    ; ! Set blur render effect radius, should be IN the range 1 To 31 inclusive, defaults To 2.
    sgd_SetBlurEffectRadius(effect.i, radius.i) As "sgd_SetBlurEffectRadius";
    ; ! Get blur render effect radius.
    sgd_GetBlurEffectRadius(effect.i) As "sgd_GetBlurEffectRadius";
    ; ! Create a new fog render effect And ADD it To the scene.
    sgd_CreateFogEffect() As "sgd_CreateFogEffect";
    ; ! Set fog render effect color. Defaults To .8, .9, 1, 1
    sgd_SetFogEffectColor(effect.i, red.f, green.f, blue.f, alpha.f) As "sgd_SetFogEffectColor";
    ; ! Set fog render effect range. Defaults To .1, 1000
    sgd_SetFogEffectRange(effect.i, near.f, far.f) As "sgd_SetFogEffectRange";
    ; ! Set fog render effect power. Defaults To 2.
    sgd_SetFogEffectPower(effect.i, power.f) As "sgd_SetFogEffectPower";
    ; ! Create a new monocolor render effect And ADD it To the scene.
    sgd_CreateMonocolorEffect() As "sgd_CreateMonocolorEffect";
    ; ! Set monocolor render effect color, defaults To 1,1,1,1.
    sgd_SetMonocolorEffectColor(effect.i, red.f, green.f, blue.f, alpha.f) As "sgd_SetMonocolorEffectColor";
    ; ! Set render effect enabled.
    sgd_SetRenderEffectEnabled(effect.i, enabled.i) As "sgd_SetRenderEffectEnabled";
    ; ! Is render effect enabled.
    sgd_IsRenderEffectEnabled(effect.i) As "sgd_IsRenderEffectEnabled";

    ;-! @defgroup Audio Audio
    ; ! Load a new sound.
    sgd_LoadSound_x(path.SGD_String ) As "sgd_LoadSound";
    ; ! Play a sound, returning an audio stream..
    sgd_PlaySound(sound.i) As "sgd_PlaySound";
    ; ! Cue a sound. The returned audio stream must be unpaused before it will start.
    sgd_CueSound(sound.i) As "sgd_CueSound";
    ; ! Set audio volume.
    sgd_SetAudioVolume(audio.i, volume.f) As "sgd_SetAudioVolume";
    ; ! Set audio pan.
    sgd_SetAudioPan(audio.i, pan,f) As "sgd_SetAudioPan";
    ; ! Set audio pitch scale.
    sgd_SetAudioPitchScale(audio.i, scale.f) As "sgd_SetAudioPitchScale";
    ; ! Set audio looping flag.
    sgd_SetAudioLooping(audio.i, looping.i) As "sgd_SetAudioLooping";
    ; ! Set audio paused flag.
    sgd_SetAudioPaused(audio.i, paused.i) As "sgd_SetAudioPaused";
    ; ! Get audio valid flag. Audio is valid If it is playing Or paused.
    sgd_IsAudioValid(audio.i) As "sgd_IsAudioValid";
    ; ! Stop audio.
    sgd_StopAudio(audio.i) As "sgd_StopAudio" ;
    ; ! Set 3D audio config. All paremters Default To 1.
    sgd_Set3DAudioConfig(rolloffScale.f, dopplerScale.f, distanceScale.f) As "sgd_Set3DAudioConfig";
    ; ! Create 3D audio listener attached To entity. Only one audio listener is currently supported.
    sgd_Create3DAudioListener(entity.i) As "sgd_Create3DAudioListener";
    ; ! Play 3D sound at entity position And velocity.
    sgd_Play3DSound(sound.i, entity.i) As "3D";
    ; ! Update 3D audio. Must be called To update 3D rolloff And doppler effects.
    sgd_Update3DAudio() As "sgd_Update3DAudio";

    ;sgd_ImGui_ImplSGD_Init() As "sgd_ImGui_ImplSGD_Init"                      ; intern? 
    ;sgd_ImGui_ImplSGD_NewFrame() As "sgd_ImGui_ImplSGD_NewFrame"              ; intern?
    ;sgd_ImGui_ImplSGD_RenderDrawData() As "sgd_ImGui_ImplSGD_RenderDrawData"  ; intern?
    ;sgd_ImGui_ImplSGD_Shutdown() As "sgd_ImGui_ImplSGD_Shutdown"              ; intern?
    
  
  EndImport
  
  ; Comandconvert ASCII To Unicode for Purebasic Translation
  ;- System System translation
  Procedure.s sgd_GetVersion()
    ProcedureReturn PeekS(sgd_GetVersion_x(),-1 ,#PB_Ascii)
  EndProcedure
    
  Procedure.s sgd_GetConfigVar(name.SGD_String)
    ProcedureReturn PeekS(sgd_GetConfigVar_x(myAscii(name.SGD_String)),-1,#PB_Ascii)
  EndProcedure
    
  Procedure sgd_SetConfigVar(name.SGD_String , value.SGD_String )
    ProcedureReturn sgd_setConfigVar_x(myAscii(name.SGD_String),myAscii(value.SGD_String))
  EndProcedure
  
  Procedure sgd_Log(line.SGD_String )
    ProcedureReturn sgd_Log_x(myAscii(line.SGD_String) ) 
  EndProcedure
  
  ;- Window translation
  Procedure sgd_CreateWindow (width.i, height.i, title.SGD_String, flags.i) 
    ProcedureReturn sgd_CreateWindow_x (width.i, height.i,  myAscii(title.SGD_String), flags.i) 
  EndProcedure
  
  Procedure sgd_SetWindowTitle (title.SGD_String) 
    ProcedureReturn sgd_SetWindowTitle_x(myAscii(title.SGD_String)) 
  EndProcedure
  
  ;- texture translation
  Procedure sgd_Load2DTexture(path.SGD_String, format.i, flags.i)
    ProcedureReturn sgd_Load2DTexture_x(myAscii(path.SGD_String), format.i, flags.i)
  EndProcedure
  
  Procedure sgd_LoadCubeTexture(path.SGD_String, format.i, flags.i)
    ProcedureReturn sgd_LoadCubeTexture_x(myAscii(path.SGD_String), format.i, flags.i)
  EndProcedure
  
  Procedure sgd_LoadArrayTexture(path.SGD_String, format.i, flags.i)
   ProcedureReturn sgd_LoadArrayTexture_x(myAscii(path.SGD_String), format.i, flags.i)
  EndProcedure
    
  ;- Material translation
  Procedure sgd_LoadMaterial(path.SGD_String) 
    ProcedureReturn sgd_LoadMaterial_x(myAscii(path.SGD_String))
  EndProcedure
    
  Procedure sgd_LoadPBRMaterial(path.SGD_String) 
    ProcedureReturn sgd_LoadPBRMaterial_x (myAscii(path.SGD_String)) 
  EndProcedure
  
  Procedure sgd_LoadEmissiveMaterial(path.SGD_String) 
    ProcedureReturn sgd_LoadEmissiveMaterial_x(myAscii(path.SGD_String))
  EndProcedure
  
  Procedure sgd_SetMaterialTexture(material.i,  parameter.SGD_String, texture.i) 
    ProcedureReturn sgd_SetMaterialTexture_x(material.i,  myAscii(parameter.SGD_String), texture.i) 
  EndProcedure
  
  Procedure sgd_SetMaterialColor(material.i, property.SGD_String , red.f, green.f, blue.f,alpha.f) 
    ProcedureReturn sgd_SetMaterialColor_x (material.i, myAscii(property.SGD_String ), red.f, green.f, blue.f,alpha.f) 
  EndProcedure
  
  Procedure sgd_SetMaterialVec4f(material.i, property.SGD_String , x.f,  y.f, z.f, w.f)
    ProcedureReturn sgd_SetMaterialVec4f_x(material.i, myAscii(property.SGD_String) , x.f,  y.f, z.f, w.f)
  EndProcedure
  
  Procedure sgd_SetMaterialVec3f(material.i, property.SGD_String , x.f,  y.f, z.f)
    ProcedureReturn sgd_SetMaterialVec3f_x(material.i, myAscii(property.SGD_String) , x.f,  y.f, z.f)
  EndProcedure
  
  Procedure sgd_SetMaterialVec2f(material.i, property.SGD_String , x.f,  y.f) 
    ProcedureReturn sgd_SetMaterialVec2f_x(material.i, myAscii(property.SGD_String) , x.f,  y.f) 
  EndProcedure
  
  Procedure sgd_SetMaterialFloat(material.i, property.SGD_String , value.f)
    ProcedureReturn sgd_SetMaterialFloat_x(material.i, myAscii(property.SGD_String ), value.f)
  EndProcedure  
    
  ;- Mesh translation
   Procedure sgd_LoadMesh(path.SGD_String) 
     ProcedureReturn sgd_LoadMesh_x(myAscii(path.SGD_String)) 
   EndProcedure
   
  ;- font translation 
   Procedure sgd_LoadFont(path.SGD_String, height.f)
     ProcedureReturn sgd_LoadFont_x(myAscii(path.SGD_String), height.f)
   EndProcedure
   
   Procedure.f sgd_GetTextWidth (font.i, text.SGD_String)
     ProcedureReturn sgd_GetTextWidth_x(font.i, myAscii(text.SGD_String))
   EndProcedure
   
   ;- Image translation
   Procedure sgd_LoadImage(path.SGD_String) 
      ProcedureReturn sgd_LoadImage_x(myAscii(path.SGD_String)) 
   EndProcedure
   
   Procedure sgd_LoadArrayImage(path.SGD_String , frameCount.i, framesX.i, framesY.i, frameSpacing.i)
      ProcedureReturn sgd_LoadArrayImage_x(myAscii(path.SGD_String) , frameCount.i, framesX.i, framesY.i, frameSpacing.i)
   EndProcedure
   
   ;- Overlay translation
    Procedure.f sgd_Get2DTextWidth(text.SGD_String)
        ProcedureReturn sgd_Get2DTextWidth_x(myAscii(text.SGD_String))
    EndProcedure
    
    Procedure sgd_Draw2DText(text.SGD_String, x.f, y.f)
        ProcedureReturn sgd_Draw2DText_x(myAscii(text.SGD_String), x.f, y.f)
    EndProcedure
    
   ;- Scene translation
   Procedure sgd_LoadScene( path.SGD_String)
      ProcedureReturn sgd_LoadScene_x(myAscii(path.SGD_String)) 
   EndProcedure
   
   Procedure sgd_SaveScene( path.SGD_String) 
      ProcedureReturn sgd_SaveScene_x(myAscii (path.SGD_String)) 
   EndProcedure
    
    ;- Entity translation
    Procedure sgd_SetEntityName(entity.i, name.SGD_String)
      ProcedureReturn sgd_SetEntityName_x(entity.i, myAscii(name.SGD_String))
    EndProcedure
    
    Procedure.s sgd_GetEntityName(entity.i)
        ProcedureReturn PeekS(sgd_GetEntityName_x(entity.i),-1,#PB_Ascii )
    EndProcedure
    
    Procedure sgd_FindEntityChild(entity.i, childName.SGD_String) 
        ProcedureReturn sgd_FindEntityChild_x(entity.i, myAscii(childName.SGD_String)) 
    EndProcedure
    
   ;- Model translation
    Procedure sgd_LoadModel(path.SGD_String )
       ProcedureReturn sgd_LoadModel_x(myAscii(path.SGD_String ))
    EndProcedure
     
    Procedure sgd_LoadBonedModel(path.SGD_String , skinned.i)
       ProcedureReturn sgd_LoadBonedModel_x(myAscii(path.SGD_String) , skinned.i)
     EndProcedure
     
    ;- Skybox translation
    Procedure sgd_LoadSkybox(path.SGD_String, roughness.f) 
       ProcedureReturn sgd_LoadSkybox_x(myAscii(path.SGD_String), roughness.f) 
    EndProcedure
    
    ;- Audio  translation
    Procedure sgd_LoadSound(path.SGD_String ) 
        ProcedureReturn sgd_LoadSound_x(myAscii(path.SGD_String) ) 
    EndProcedure
    
    
    
    
    
    
    
    
    
    
    
   
; IDE Options = PureBasic 6.12 LTS (Windows - x64)
; CursorPosition = 1149
; FirstLine = 1104
; Folding = -------
; Markers = 997
; EnableAsm
; EnableXP
; DPIAware