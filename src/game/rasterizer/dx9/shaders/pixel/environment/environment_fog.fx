#include "alpha_tests.h"

SamplerState TexS0;
Texture2D Texture0;

SamplerState TexS1;
Texture2D Texture1;

struct PS_INPUT {
	float4 Pos : SV_POSITION;
	float4 D0 : COLOR0;
	float4 D1 : COLOR1;
	float4 T0 : TEXCOORD0;
	float4 T1 : TEXCOORD1;
};

cbuffer constants_buffer {
	float4 constants[4];
}

half4 main(PS_INPUT i) : SV_TARGET
{
	// Inputs
	half2 Tex0 = i.T0;
	half2 Tex1 = i.T1;

	half4 r0, r1, r2, r3, r4, r5, r6;

	// Constants
	//rgb = global_window_parameters.fog.atmospheric_maximum_density
	//a = fog_blend_factor * global_window_parameters.fog.atmospheric_maximum_density
	float4 c0 = constants[0];
	// rgb = global_window_parameters.fog.planar_maximum_density
	// a = planar_eye_density * global_window_parameters.fog.planar_maximum_density
	float4 c1 = constants[1];
	// rgb = global_window_parameters.fog.atmospheric_color	
	// a = fog_blend_factor		
	float4 c2 = constants[2];
	// rgb = global_window_parameters.fog.planar_color	
	// a = 1.0f - fog_blend_factor
	float4 c3 = constants[3];
	
	half4 atmospheric_fog_density = Texture0.Sample(TexS0, Tex0.xy);
	half atmospheric_factor = (c0.b * atmospheric_fog_density.a);
	float3 atmospheric_color = saturate(c2.rgb * atmospheric_factor); // fog_atmospheric_color * atmospheric_factor
	half atmospheric_blend = saturate(c2.a * atmospheric_factor); // blend * atmospheric_factor
	
	half4 planar_fog_density = Texture1.Sample(TexS1, Tex1.xy);
	half planar_factor = (c1.b * planar_fog_density.a) + (c1.a * planar_fog_density.b);
	float3 planar_color = saturate(c3.rgb * planar_factor); // fog_planar_color * planar_factor
	half planar_blend = saturate(c3.a * planar_factor); // (1 - blend) * planar_color
	
	half3 final_color = atmospheric_color * (1 - planar_blend) + planar_color * (1 - atmospheric_blend);
	half final_alpha = 1.0f - saturate((1 - atmospheric_factor) * (1 - planar_factor));
	r0 = half4(final_color, final_alpha);

	return TestAlphaGreater00(r0);
};

