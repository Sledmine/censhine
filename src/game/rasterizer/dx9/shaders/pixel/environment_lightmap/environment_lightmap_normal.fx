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
   //half4 c_material_color;
   //half4 c_plasma_animation;
   //half4 c_primary_color;
   //half4 c_secondary_color;
   //half4 c_plasma_on_color;
   //half4 c_plasma_off_color;
   //float c_alpha_ref;
}

// LightmapNormal
half4 main(PS_INPUT i) : SV_TARGET
{
   // Inputs
   half4 Diff = i.D0;
   half2 Tex0 = i.T0;
   half2 Tex1 = i.T1;
   half2 Tex2 = i.T2;
   half3 Tex3 = i.T3;

   half4 c_material_color = constants[0];
   half4 c_plasma_animation = constants[1];
   half4 c_primary_color = constants[2];
   half4 c_secondary_color = constants[3];
   half4 c_plasma_on_color = constants[4];
   half4 c_plasma_off_color = constants[5];
   float c_alpha_ref = constants[6].w;


   float4 bump_color = Texture0.Sample(TexSampler0, Tex0.xy);
	// self_illumination_color
	// r primary_mask
	// g secondary_mask
	// b plasma_mask
   float4 self_illumination_color = Texture1.Sample(TexSampler1, Tex1.xy);
   float4 lightmap_color = Texture2.Sample(TexSampler2, Tex2.xy);
   float4 normal_color = Texture3.Sample(TexSampler3, Tex3.xyz);

	////////////////////////////////////////////////////////////
	// calculate plasma
	////////////////////////////////////////////////////////////
   float plasma_intermed_1 = c_plasma_animation + 0.5 - max(0, self_illumination_color.a);
   float plasma_intermed_2 = self_illumination_color.a + 0.5 - max(0, c_plasma_animation);

   float plasma = (plasma_intermed_1 < 0.5f) ? plasma_intermed_1 : plasma_intermed_2;
   plasma = saturate(plasma * plasma * 4);                           // (plasma ^ 2) * 4
   plasma = plasma * plasma;                                         // 16 * plasma ^ 4
   plasma = plasma < 0.5f ? 0 : pow(2 * plasma - 1, 2);   // plasma ^ 8
   
	////////////////////////////////////////////////////////////
	// calculate bump attenuation
	////////////////////////////////////////////////////////////
   float bump_attenuation = saturate(dot(normalize(2*bump_color.rgb-1), normalize(2*normal_color.rgb-1)));
   float bump_attenuation_with_accuracy = lerp(1, bump_attenuation, Diff.a);
   
	////////////////////////////////////////////////////////////
	// calculate primary and secondary glow
	////////////////////////////////////////////////////////////
   float3 primary_and_secondary_glow = saturate(c_primary_color.rgb * self_illumination_color.r + c_secondary_color.rgb * self_illumination_color.g);

   float3 plasma_color = saturate(c_plasma_on_color * plasma + c_plasma_off_color);

   float3 plasma_primary_and_secondary = saturate(plasma_color * self_illumination_color.b + primary_and_secondary_glow);

   half4 final_color = half4(bump_attenuation_with_accuracy * c_material_color.rgb * lightmap_color.rgb + plasma_primary_and_secondary, bump_color.a);
   return TestAlphaGreaterRef( final_color, c_alpha_ref );
}
