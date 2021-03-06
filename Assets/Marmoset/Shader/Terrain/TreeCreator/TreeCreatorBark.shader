Shader "Marmoset/Nature/Tree Creator Bark" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_Shininess ("Shininess", Range (0.01, 1)) = 0.078125
	_MainTex ("Base (RGB) Alpha (A)", 2D) = "white" {}
	_BumpMap ("Normalmap", 2D) = "bump" {}
	_GlossMap ("Gloss (A)", 2D) = "black" {}
	
	_SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
	_SpecInt ("Specular Intensity", Float) = 1.0
	_Fresnel ("Fresnel Falloff", Range(0.0,1.0)) = 1.0
	
	// These are here only to provide default values
	[HideInInspector] _TreeInstanceColor ("TreeInstanceColor", Vector) = (1,1,1,1)
	[HideInInspector] _TreeInstanceScale ("TreeInstanceScale", Vector) = (1,1,1,1)
	[HideInInspector] _SquashAmount ("Squash", Float) = 1
}

//Unoptimized bark shader, used nowhere in the tree system
SubShader { 
	Tags { "RenderType"="TreeBark" }
	LOD 200
		
	CGPROGRAM
	#pragma surface BarkSurf BlinnPhong vertex:BarkVert addshadow nolightmap
	#pragma exclude_renderers flash 
	#pragma glsl
	#pragma glsl_no_auto_normalization
	
	#pragma multi_compile MARMO_TERRAIN_BLEND_OFF MARMO_TERRAIN_BLEND_ON
	#if MARMO_TERRAIN_BLEND_ON			
		#define MARMO_SKY_BLEND
	#endif
	
	#pragma target 3.0

	#define MARMO_SKY_ROTATION
	#define MARMO_NORMALMAP
	#define MARMO_SPECULAR_DIRECT

	#include "../../MarmosetCore.cginc"
	#include "TreeCore.cginc"
	#include "TreeBarkInput.cginc"
	#include "TreeBark.cginc"

	ENDCG
}

Dependency "OptimizedShader" = "Hidden/Marmoset/Nature/Tree Creator Bark Optimized"
FallBack "Diffuse"
}
