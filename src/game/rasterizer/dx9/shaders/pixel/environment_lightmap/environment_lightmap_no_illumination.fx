#include "alpha_tests.h"

SamplerState TexSampler0 : register(s0);

SamplerState TexSampler2 : register(s2);

SamplerState TexSampler3 : register(s3);

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
	float4 constants[2];
	//half4 c_material_color;
	//float c_alpha_ref;
}

half4 main(PS_INPUT i) : SV_TARGET
{
	// Inputs
	half4 Diff = i.D0;
	half2 Tex0 = i.T0;
	half2 Tex2 = i.T2;
	half3 Tex3 = i.T3;

	half4 c_material_color = constants[0];
	float c_alpha_ref = constants[1].w;

	half4 bump_color = tex2D(TexSampler0, Tex0.xy);
	half3 lightmap_color = tex2D(TexSampler2, Tex2.xy);
	half4 normal_color = texCUBE(TexSampler3, Tex3.xyz);

	////////////////////////////////////////////////////////////
	// calculate bump attenuation
	////////////////////////////////////////////////////////////
	half baked_attenuation = dot(normalize(2*normal_color.rgb-1), half3(0.0f, 0.0f, 1.0f));
	half bump_attenuation = dot((2*bump_color.rgb)-1, (2*normal_color.rgb)-1);
	bump_attenuation = 1 + bump_attenuation - baked_attenuation;
	bump_attenuation = lerp(1, bump_attenuation, Diff.a);

	////////////////////////////////////////////////////////////
	// combine output
	////////////////////////////////////////////////////////////
	half3 final_color = lightmap_color;
	final_color *= bump_attenuation;
	final_color *= c_material_color;

	
	return TestAlphaGreaterRef( half4( final_color, bump_color.a), c_alpha_ref );
};

