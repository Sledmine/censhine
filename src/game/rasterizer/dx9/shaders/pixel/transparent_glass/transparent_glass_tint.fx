#include "alpha_tests.h"

SamplerState TexS0;
Texture2D Texture0;

struct PS_INPUT {
   float4 Pos : SV_POSITION;
   float4 D0 : COLOR0;
   float4 D1 : COLOR1;
   float4 T0 : TEXCOORD0;
};

cbuffer constants_buffer {
   float4 c_tint_and_intensity;
}

float4 main(PS_INPUT i) : SV_TARGET
{
   // INPUTS
   float2 Tex0 = i.T0;
   float4 d0 = i.D0;

   float4 t0 = Texture0.Sample(TexS0, Tex0.xy);
   
   // Combiner 0
   float3 r0 = t0.rgb * c_tint_and_intensity.rgb;
   d0.a *= c_tint_and_intensity.a;

   // Final combiner
   float4 final_out;
   final_out.rgb = d0.a * r0.rgb + (1.f - d0.a); // fog
   final_out.a = d0.a;

   return TestAlphaGreater00(final_out);
};

