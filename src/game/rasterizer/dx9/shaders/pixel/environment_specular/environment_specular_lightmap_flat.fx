#include "alpha_tests.h"

SamplerState TexS0;
Texture2D Texture0;

SamplerState TexS1;
Texture2D Texture1;

SamplerState TexS2;
TextureCube Texture2;

SamplerState TexS3;
TextureCube Texture3;

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
	half4 constants[4];
}

half4 main(PS_INPUT i) : SV_TARGET {
	// texture0: bump map is_specular_mask
	half3 specular_mask = Texture0.Sample(TexS0, i.T0.xy).rgb;
	// texture1: lightmap
	half3 lightmap_color = Texture1.Sample(TexS1, i.T1.xy).rgb;
	// E texture2: vector normalization (eye vector)
	half3 t2 = Texture2.Sample(TexS2, i.T2.xyz).rgb;
	// L texture3: vector normalization (light vector)
	half3 t3 = Texture3.Sample(TexS3, i.T3.xyz).rgb;

	half4 c_specular_brightness = constants[0];
	half4 c_view_perpendicular_color = constants[1];
	half4 c_view_parallel_color = constants[2];
	half4 c_multiplier = constants[3];
	
	half3 N = half3(0, 0, 1);
	half3 E = 2 * t2 - 1;
	half3 L = 2 * t3 - 1;
	
	half NdotE = dot(N, E);
	half3 R = 2 * NdotE * N - E;
	
	half lightmap_brightness = dot(lightmap_color, 0.5);
	half s = saturate(dot(R, L));
	
	half self_shadow = saturate(L.z * 4) * saturate(E.z * 4);
	half3 color = lerp(c_view_parallel_color.rgb, c_view_perpendicular_color.rgb, saturate(NdotE));

	half4 res;
	res.rgb = color * lightmap_brightness * c_multiplier.a * self_shadow * c_specular_brightness.a * pow(s, 8) * 0.5;
	res.a = dot(lightmap_brightness, specular_mask) * c_specular_brightness.a * c_multiplier.a * pow(s, 4) * 3;

	return TestAlphaGreater00(res);
}
