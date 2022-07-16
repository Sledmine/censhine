#include "alpha_tests.h"

SamplerState TexS0;
Texture2D Texture0;

SamplerState TexS1;
TextureCube Texture1_CUBE;
Texture3D Texture1_3D;

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

// Custom Edition only uses "SpotLights" with the name "SpecularLightBumped"
// Pass SpotLights
half4 main_T0_P0(PS_INPUT i) : SV_TARGET
{
	// N texture0: bump map
	half3 t0 = Texture0.Sample(TexS0, i.T0.xy).rgb;
	// texture1: gel
	half3 t1 = Texture1_CUBE.Sample(TexS1, i.T1.xyz).rgb;
	// E texture2: vector normalization (eye vector)
	half3 t2 = Texture2.Sample(TexS2, i.T2.xyz).rgb;
	// L texture3: vector normalization (light vector)
	half3 t3 = Texture3.Sample(TexS3, i.T3.xyz).rgb;

	half4 c_specular_brightness = constants[0];
	half4 c_view_perpendicular_color = constants[1];
	half4 c_view_parallel_color = constants[2];
	half4 c_multiplier = constants[3];

	half3 N = 2 * t0 - 1;
	half3 E = 2 * t2 - 1;
	half3 L = 2 * t3 - 1;

	half NdotE = dot(N, E);
	// reflected light vector
	half3 R = 2 * NdotE * N - E;

	half brightness = c_specular_brightness.a;
	half s = saturate(dot(R, L));
	half self_shadow = saturate(L.z * 8) * saturate(E.z * 8);
	half3 color = lerp(c_view_parallel_color.rgb, c_view_perpendicular_color.rgb, NdotE);
	
	half4 res;
	//s^8, color, gel, self-shadow, brightness
	res.rgb = pow(s, 8) * color * t1 * self_shadow * c_multiplier.z * brightness;
	// apply distance attenuation
	res.rgb *= (1 - i.D1.w);
	// brightness, gel, s^8 (active pixel mask)
	res.a = dot(brightness, t1) * c_multiplier.z * pow(s, 4) * 3;

	return TestAlphaGreater00(saturate(res));
};

// Pass PointLight
half4 main_T0_P1(PS_INPUT i) : SV_TARGET {
	// texture0: specular mask
	half3 t0 = Texture0.Sample(TexS0, i.T0.xy).rgb;
	// texture1: distance attenuation
	half3 t1 = Texture1_3D.Sample(TexS1, i.T1.xyz).rgb;
	// E texture2: vector normalization (eye vector)
	half3 t2 = Texture2.Sample(TexS2, i.T2.xyz).rgb;
	// L texture3: vector normalization (light vector)
	half3 t3 = Texture3.Sample(TexS3, i.T3.xyz).rgb;

	half4 c_specular_brightness = constants[0];
	half4 c_view_perpendicular_color = constants[1];
	half4 c_view_parallel_color = constants[2];
	half4 c_multiplier = constants[3];

	half3 N = 2 * t0 - 1;
	half3 E = 2 * t2 - 1;
	half3 L = 2 * t3 - 1;

	half NdotE = dot(N, E);
	// reflected light vector
	half3 R = 2 * NdotE * N - E;

	half brightness = c_specular_brightness.a;
	half s = saturate(dot(R, L));
	half self_shadow = saturate(L.z * 8) * saturate(E.z * 8);
	half3 color = lerp(c_view_parallel_color.rgb, c_view_perpendicular_color.rgb, NdotE);
	
	half4 res;
	//s^8, color, gel, self-shadow, brightness
	res.rgb = pow(s, 8) * color * t1 * self_shadow * c_multiplier.z * brightness;
	// brightness, gel, s^8 (active pixel mask)
	res.a = dot(brightness, t1) * c_multiplier.z * pow(s, 4) * 3;

	return TestAlphaGreater00(saturate(res));
};
