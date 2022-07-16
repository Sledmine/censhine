// HAS_SECOND_COLOR_MAP
// ZSPRITE
// NONLINEAR_TINT
// _shader_framebuffer_blend_function_alpha_blend
// _shader_framebuffer_blend_function_multiply
// _shader_framebuffer_blend_function_double_multiply
// _shader_framebuffer_blend_function_add
// _shader_framebuffer_blend_function_alpha_multiply_add

SamplerState TexS0 : register(s0);
Texture2D Texture0 : register(t0);

#if defined(HAS_SECOND_COLOR_MAP) || defined(ZSPRITE)
#define HAS_SECOND_TEXTURE
#endif

#ifdef HAS_SECOND_TEXTURE
SamplerState TexS1 : register(s1);
Texture2D Texture1 : register(t1);
#endif

struct PS_INPUT {
   float4 Pos : SV_POSITION;
   float4 D0 : COLOR0;
   float4 D1 : COLOR1;
   float4 T0 : TEXCOORD0;
#ifdef HAS_SECOND_TEXTURE
   float4 T1 : TEXCOORD1;
#endif
#ifdef ZSPRITE
   float4 T2 : TEXCOORD2;
   float4 T3 : TEXCOORD3;
#endif
};

void main(
	PS_INPUT i, 
	out float4 oColor : SV_TARGET
#ifdef ZSPRITE
	,out float oDepth : SV_DEPTH
#endif
	)
{
	half4 d0 = i.D0; // d0.a premultiplied by d1.a in vsh

	half4 t0 = Texture0.Sample(TexS0, i.T0.xy);
	half4 r0;
	r0.a = t0.a;

#ifdef NONLINEAR_TINT
	r0.rgb = lerp(pow(t0.rgb, 4), t0.rgb, d0.rgb);
#else
	r0.rgb = t0.rgb * d0.rgb;
#endif

#if defined(HAS_SECOND_COLOR_MAP)
	i.T1.xy /= i.T1.w;
#endif

#ifdef HAS_SECOND_TEXTURE
	half4 t1 = Texture1.Sample(TexS1, i.T1.xy);
#endif

// apply secondary color map
#ifdef HAS_SECOND_COLOR_MAP
	r0.a *= t1.a;
	r0.rgb *= t1.rgb;
#endif

// apply framebuffer_blend_function
#ifdef _shader_framebuffer_blend_function_alpha_blend
	r0.a *= d0.a;
#endif

#ifdef _shader_framebuffer_blend_function_multiply
	//|| _shader_framebuffer_blend_function_min
	r0.rgb = lerp(1, r0.rgb, d0.a);
#endif

#ifdef _shader_framebuffer_blend_function_double_multiply
	r0.rgb = lerp(0.5, r0.rgb, d0.a);
#endif

#ifdef _shader_framebuffer_blend_function_add
	// || _shader_framebuffer_blend_function_reverse_subtract || _shader_framebuffer_blend_function_max
	r0.rgb *= d0.a;
#endif

#ifdef _shader_framebuffer_blend_function_alpha_multiply_add
	r0 *= d0.a;
#endif

   oColor = r0;

#ifdef ZSPRITE
   // g channel has z offset
   float2 texValues;
   texValues.x = t1.g;
   texValues.y = 1;

   half z = dot(i.T2.yz, texValues);
   half w = dot(i.T3.yz, texValues);
   oDepth = z/w;
#endif
};

