#include "alpha_tests.h"

SamplerState TexSampler0 : register(s1);
Texture2D Texture0 : register(t1);

SamplerState TexSampler3 : register(s2);
TextureCube Texture3 : register(t2);

struct PS_INPUT {
	float4 Pos : SV_POSITION;
	float4 D0 : COLOR0;
	float4 D1 : COLOR1;
	float4 T0 : TEXCOORD0;
	float4 T1 : TEXCOORD1;
	float4 T2 : TEXCOORD2;
	float4 T3 : TEXCOORD3;
};

cbuffer constants_buffer {
	half4 constants[2];
	//half4 c_material_color;
	//float c_alpha_ref; // !!! MANUAL EDIT
}

// LightmapNoIlluminationNoLightmap
half4 main(PS_INPUT i) : SV_TARGET
{
	// Inputs
	half4 Diff = i.D0;
	half2 Tex0 = i.T0;
	half2 Tex1 = i.T1;
	half2 Tex2 = i.T2;
	half3 Tex3 = i.T3;

	half4 c_material_color = constants[0];
	float c_alpha_ref = constants[1].w;

	half4 bump_color = Texture0.Sample(TexSampler0, Tex0.xy);
	half4 normal_color = Texture3.Sample(TexSampler3, Tex3.xyz);

	////////////////////////////////////////////////////////////
	// Calculate bump attenuation
	////////////////////////////////////////////////////////////
	half bump_attenuation = dot((2 * bump_color) - 1, (2 * normal_color) - 1);
	bump_attenuation = (bump_attenuation * Diff.a) + 1-Diff.a;
	
	half3 lightmap_color = c_material_color + ( bump_attenuation * c_material_color );
	
	half4 final_color = half4( lightmap_color, bump_color.a );
	
	return TestAlphaGreaterRef( final_color, c_alpha_ref );
}

