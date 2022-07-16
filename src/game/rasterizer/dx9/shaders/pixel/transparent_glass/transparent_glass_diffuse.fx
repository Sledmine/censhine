#include "alpha_tests.h"

SamplerState TexS0;
Texture2D Texture0;

SamplerState TexS1;
Texture2D Texture1;

SamplerState TexS2;
Texture2D Texture2;

struct PS_INPUT {
	float4 Pos : SV_POSITION;
	float4 D0 : COLOR0;
	float4 D1 : COLOR1;
	float4 T0 : TEXCOORD0;
	float4 T1 : TEXCOORD1;
	float4 T2 : TEXCOORD2;
};

// t2 - black
half4 main_T0_P0(PS_INPUT i) : SV_TARGET
{
	// INPUTS
	half4 v0 = i.D0;
	half2 Tex0 = i.T0;
	half2 Tex1 = i.T1;

	half4 r0;
		
	half4 t0 = Texture0.Sample(TexS0, Tex0.xy); // texture0: diffuse map
	half4 t1 = Texture1.Sample(TexS1, Tex1.xy); // texture1: diffuse detail map
	
	// combiner 0
	r0 = t0 * t1;
	r0.rgb = saturate(r0.rgb * 2);
	
	// combiner 1, 2
	r0 = r0 * v0;
		
	// final combiner is pass-thru
	return TestAlphaGreater00(r0);
};

// t2 - lightmap
half4 main_T0_P1(PS_INPUT i) : SV_TARGET
{
	// INPUTS
	half4 v0 = i.D0;
	half2 Tex0 = i.T0;
	half2 Tex1 = i.T1;
	half2 Tex2 = i.T2;

	half4 r0, r1;
	
	half4 t0 = Texture0.Sample(TexS0, Tex0.xy); // texture0: diffuse map
	half4 t1 = Texture1.Sample(TexS1, Tex1.xy); // texture1: diffuse detail map
	half4 t2 = Texture2.Sample(TexS2, Tex2.xy); // texture2: lightmap
	
	// combiner 0
	r0 = t0 * t1;
	r0.rgb = saturate(r0.rgb * 2);

	// combiner 1
	r0.a = r0.a * v0.a;
	r1.rgb = saturate(t2.rgb + v0.rgb);

	// combiner 2
	r0.rgb = r0.rgb * r1.rgb;

	// final combiner is pass-thru
	return TestAlphaGreater00(r0);
};
