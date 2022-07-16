#define _screen_multitexture_blend_func_add 1
#define _screen_multitexture_blend_func_dot 2
#define _screen_multitexture_blend_func_multiply 3
#define _screen_multitexture_blend_func_multiply2X 4
#define _screen_multitexture_blend_func_subtract 5

// map0_to_1_blend_function
// map1_to_2_blend_function

SamplerState TexS0 : register(s0);
Texture2D Texture0 : register(t0);

SamplerState TexS1 : register(s1);
Texture2D Texture1 : register(t1);

SamplerState TexS2 : register(s2);
Texture2D Texture2 : register(t2);

struct PS_INPUT {
	float4 Pos : SV_POSITION;
	float4 D0 : COLOR0;
	float4 D1 : COLOR1;
	float4 T0 : TEXCOORD0;
	float4 T1 : TEXCOORD1;
	float4 T2 : TEXCOORD2;
};

cbuffer constants_buffer {
	float4 c0 : packoffset(c0); // tint for texture 0
	float4 c1 : packoffset(c1); // tint for texture 1
	float4 c2 : packoffset(c2); // tint for texture 2
	float4 c3 : packoffset(c3); // plasma_fade, not implemented
	float4 c4 : packoffset(c4); // a == 1 -> has map2
	float4 c5 : packoffset(c5);
}


half4 main(PS_INPUT i) : SV_TARGET
{
	half4 v0 = i.D0;
	half2 Tex0 = i.T0;
	half2 Tex1 = i.T1;
	half2 Tex2 = i.T2;

	half4 r0, r1;

	half4 t0 = Texture0.Sample(TexS0, Tex0.xy);
	half4 t1 = Texture1.Sample(TexS1, Tex1.xy);
	half4 t2 = Texture2.Sample(TexS2, Tex2.xy);
	
	t0 = (t0) * (c0);
	t1 = (t1) * (c1);
	t2 = (t2) * (c2);
	r0 = t0 * v0;
	
#if map0_to_1_blend_function == _screen_multitexture_blend_func_add
	r0 = saturate(r0 + t1);
#endif

#if map0_to_1_blend_function == _screen_multitexture_blend_func_dot
	r0.rgb = saturate(dot(r0.rgb, t1.rgb));
	r0.a = r0.a * t1.a;
#endif

#if map0_to_1_blend_function == _screen_multitexture_blend_func_multiply
	r0 = r0 * t1;
#endif

#if map0_to_1_blend_function == _screen_multitexture_blend_func_multiply2X
	r0 = saturate(r0 * t1 * 2);
#endif

#if map0_to_1_blend_function == _screen_multitexture_blend_func_subtract
	r0 = saturate(r0 - t1);
#endif



#if map1_to_2_blend_function == _screen_multitexture_blend_func_add
	r1 = saturate(r0 + t2);
#endif

#if map1_to_2_blend_function == _screen_multitexture_blend_func_dot
	r1.rgb = saturate(dot(r0.rgb, t2.rgb));
	r1.a = r0.a * t2.a;
#endif

#if map1_to_2_blend_function == _screen_multitexture_blend_func_multiply
	r1 = r0 * t2;
#endif

#if map1_to_2_blend_function == _screen_multitexture_blend_func_multiply2X
	r1 = saturate(r0 * t2 * 2);
#endif

#if map1_to_2_blend_function == _screen_multitexture_blend_func_subtract
	r1 = saturate(r0 - t2);
#endif

	// has map2 -> use r1
	r0 = lerp(r0, r1, c4.a);

	return r0;
};
