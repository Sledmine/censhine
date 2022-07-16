#include "alpha_tests.h"

SamplerState TexS0;
Texture2D Texture0;

SamplerState TexS1;
TextureCube Texture1;

SamplerState TexS2;
Texture3D Texture2;

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
	float4 constants[2];
}

half4 main(PS_INPUT i) : SV_TARGET {
	// Inputs
	half2 Tex0 = i.T0;
	half3 Tex1 = i.T1;
	half3 Tex2 = i.T2;
	half3 Tex3 = i.T3;

	float4 c0 = constants[0];
	float4 c1 = constants[1];

	half4 r0, r1, r2, r3, r4, r5, r6;

	half4 c7 = half4(1.0,1.0,1.0,1.0);

	half4 t0 = Texture0.Sample(TexS0, Tex0.xy);
	// gel
	half4 t1 = Texture1.Sample(TexS1, Tex1.xyz);
	// distance attenuation
	half4 t2 = Texture2.Sample(TexS2, Tex2.xyz);
	half4 t3 = Texture3.Sample(TexS3, Tex3.xyz);

	r0.rgb = saturate((t1.rgb) * (t2)); // gel color and spherical attenuation
	r0.a = (2 * (t3.b-0.5) + 2 * (t3.b-0.5)) * 4; // self shadow mask
	r1 = saturate(dot(2 * (t0-0.5).rgb, 2 * (t3-0.5).rgb)); // bump attenuation
	r0 = saturate((r1) * (r0)); // light with gel, distance and bump
	r0 = saturate((r0.a) * (r0)); // light with self shadow
	r0 = saturate((r0) * (c0)); // light with color
	r1 = saturate(dot(r0.rgb, c0.rgb)); // active pixel mask
	r0.rgb = saturate((c1.rgb) * (r0)); // final light
	r0.a = saturate(r1.b); // active pixel mask

	return TestAlphaGreater00(r0);
};

