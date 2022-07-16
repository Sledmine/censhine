#include "alpha_tests.h"

SamplerState TexSampler0;
Texture2D Texture0;

SamplerState TexSampler1;
Texture2D Texture1;

SamplerState TexSampler2;
Texture2D Texture2;

SamplerState TexSampler3;
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
	half4 constants[7];
	//half4 c_primary_change_color;
	//half4 c_fog_color_correction_0;
	//half4 c_fog_color_correction_E;
	//half4 c_fog_color_correction_1;
	//half4 c_self_illumination_color;
	//float c_alpha_ref;
	//half4 c_fog_color;
}

static const int reflection_mask_multipurpose_map = 0;
static const int reflection_mask_base_and_detail_map = 1;

static const int detail_mask_none                               = 0;
static const int detail_mask_reflection_mask_inverse            = 1;
static const int detail_mask_reflection_mask                    = 2;
static const int detail_mask_self_illumination_mask_inverse     = 3;
static const int detail_mask_self_illumination_mask             = 4;
static const int detail_mask_change_color_mask_inverse          = 5;
static const int detail_mask_change_color_mask                  = 6;
static const int detail_mask_multipurpose_alpha_mask_inverse    = 7;
static const int detail_mask_multipurpose_alpha_mask            = 8;

static const int detail_function_biased_multiply                = 0;
static const int detail_function_multiply                       = 1;
static const int detail_function_biased_add                     = 2;

half4 ShaderModel(
	PS_INPUT i,
	uniform const int nReflectionMask,
	uniform const int nDetailMask,
	uniform const int nDetailFunction,
	uniform const bool bDetailBeforeReflection,
	uniform const bool bPlanarAtmosphericFog)
{
	half4 Diff = i.D0;
	half4 Spec = i.D1;
	half2 Tex0 = i.T0.xy;
	half2 Tex1 = i.T1.xy;
	half2 Tex2 = i.T2.xy;
	half3 Tex3 = i.T3.xyz;

	half4 c_primary_change_color = constants[0];
	half4 c_fog_color_correction_0 = constants[1];
	half4 c_fog_color_correction_E = constants[2];
	half4 c_fog_color_correction_1 = constants[3];
	half4 c_self_illumination_color = constants[4];
	float c_alpha_ref = constants[5].w;
	half4 c_fog_color = constants[6];
	
	half4 base_map = Texture0.Sample(TexSampler0, Tex0);
	half4 detail_map = Texture1.Sample(TexSampler1, Tex1);
	half4 multipurpose_map = Texture2.Sample(TexSampler2, Tex2);
	half4 reflection_map = Texture3.Sample(TexSampler3, Tex3);

	half3 SRCCOLOR;
	half SRCALPHA;

	// c_self_illumination_color == 0 for reflection_mask_base_and_detail_map
	half3 diffuse_light = saturate(Diff.rgb + multipurpose_map.g * c_self_illumination_color.rgb);

	half specular_reflection_mask;
	if(nReflectionMask==reflection_mask_multipurpose_map)
	{
		// c_self_illumination_color.w -> use xbox channel order
		multipurpose_map.rgba = lerp(multipurpose_map.rgba, multipurpose_map.agrb, c_self_illumination_color.w);
		specular_reflection_mask = multipurpose_map.b;
		SRCALPHA = base_map.a;
	}
	else if(nReflectionMask==reflection_mask_base_and_detail_map)
	{
		// environment shader
		specular_reflection_mask = base_map.a * detail_map.a;
		SRCALPHA = multipurpose_map.a;
	}
	
	specular_reflection_mask *= Spec.a;
	
	half3 color_change = lerp(1, c_primary_change_color.rgb, multipurpose_map.a);

	half detail_mask;
	if(nDetailMask==detail_mask_none)
	{
		detail_mask = 1;
	}
	else if(nDetailMask==detail_mask_reflection_mask_inverse)
	{
		detail_mask = 1 - multipurpose_map.b;
	}
	else if(nDetailMask==detail_mask_reflection_mask)
	{
		detail_mask = multipurpose_map.b;
	}
	else if(nDetailMask==detail_mask_self_illumination_mask_inverse)
	{
		detail_mask = 1 - multipurpose_map.g;
	}
	else if(nDetailMask==detail_mask_self_illumination_mask)
	{
		detail_mask = multipurpose_map.g;
	}
	else if(nDetailMask==detail_mask_change_color_mask_inverse)
	{
		detail_mask = 1 - multipurpose_map.a;
	}
	else if(nDetailMask==detail_mask_change_color_mask)
	{
		detail_mask = multipurpose_map.a;
	}
	else if(nDetailMask==detail_mask_multipurpose_alpha_mask_inverse)
	{
		detail_mask = 1 - multipurpose_map.r;
	}
	else if(nDetailMask==detail_mask_multipurpose_alpha_mask)
	{
		detail_mask = multipurpose_map.r;
	}

	half3 detail_function;
	if(nDetailFunction==detail_function_biased_multiply)
	{
		detail_function = 0.5;
	}
	else if(nDetailFunction==detail_function_multiply)
	{
		detail_function = 1;
	}
	else if(nDetailFunction==detail_function_biased_add)
	{
		detail_function = 0.5;
	}

	half3 detail = lerp(detail_function, detail_map.rgb, detail_mask);

	half3 tinted_reflection	= reflection_map.rgb * Spec.rgb;
	diffuse_light	*= color_change;

	half3 lit_texture_and_reflection;
	if(bDetailBeforeReflection)
	{
		if(detail_function_biased_multiply==nDetailFunction)
		{
			lit_texture_and_reflection	= base_map.rgb * detail * 2;
		}
		else if(detail_function_multiply==nDetailFunction)
		{
			lit_texture_and_reflection	= base_map.rgb * detail;
		}
		else if(detail_function_biased_add==nDetailFunction)
		{
			lit_texture_and_reflection	= base_map.rgb + 2 * detail - 1;
		}

		lit_texture_and_reflection = saturate(lit_texture_and_reflection) * diffuse_light + tinted_reflection * specular_reflection_mask;
	}
	else
	{
		lit_texture_and_reflection = saturate(base_map.rgb * diffuse_light + tinted_reflection * specular_reflection_mask);

		// combiner 7
		if(detail_function_biased_multiply==nDetailFunction)
		{
			lit_texture_and_reflection	= lit_texture_and_reflection * detail * 2;
		}
		else if(detail_function_multiply==nDetailFunction)
		{
			lit_texture_and_reflection	= lit_texture_and_reflection * detail;
		}
		else if(detail_function_biased_add==nDetailFunction)
		{
			lit_texture_and_reflection	= lit_texture_and_reflection + 2 * detail - 1;
		}
	}
	
	lit_texture_and_reflection = saturate(lit_texture_and_reflection);

	if(bPlanarAtmosphericFog)
	{
		half3 fog = saturate(c_fog_color_correction_1.rgb - Diff.a * c_fog_color_correction_E.rgb);
		SRCCOLOR = lerp(lit_texture_and_reflection * c_fog_color_correction_0.a, c_fog_color_correction_0.rgb, Diff.a) + fog;
	}
	else
	{
		half fog = Diff.w;
		SRCCOLOR = lerp(lit_texture_and_reflection, c_fog_color.rgb, fog);
	}

	return TestAlphaGreaterRef( half4( SRCCOLOR, SRCALPHA ), c_alpha_ref );
}