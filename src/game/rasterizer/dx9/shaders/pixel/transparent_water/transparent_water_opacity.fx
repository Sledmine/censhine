SamplerState TexS0;
Texture2D Texture0;

SamplerState TexS1;
TextureCube Texture1;


struct PS_INPUT {
   float4 Pos : SV_POSITION;
   float4 D0 : COLOR0;
   float4 D1 : COLOR1;
   float4 T0 : TEXCOORD0;
   float4 T1 : TEXCOORD1;
   float4 T2 : TEXCOORD2;
};

cbuffer constants_buffer {
   half4 constants[3];
   //half4 c_eye_forward;
   //float4 c_perpendicular_tint_color;
   //float4 c_parallel_tint_color;
   //float4 c2;
}

// AlphaModulatesReflection
half4 main_T0_P0(PS_INPUT i) : SV_TARGET
{
   // Inputs
   half2 Tex0 = i.T0;
   half3 Tex1 = i.T1;

   half4 r0 = 0;

   float4 c_perpendicular_tint_color = constants[0];
   float4 c_parallel_tint_color = constants[1];

   half4 t0 = Texture0.Sample(TexS0, Tex0.xy); // texture0: base map
   half4 t1 = Texture1.Sample(TexS1, Tex1.xyz); // texture1: eye vector normalization cube map

   r0.a = lerp(c_parallel_tint_color.a, c_perpendicular_tint_color.a, t1.b);
   r0.a = r0.a * t0.a;
	
   return r0;
};

// ColorModulatesBackground
half4 main_T0_P1(PS_INPUT i) : SV_TARGET
{
   half fog = i.T2;

   // TODO Find what this value is for
   float4 c2 = constants[2];

   half4 t0 = Texture0.Sample(TexS0, i.T0.xy); // texture0: base map

   half4 r0_fogged = lerp(t0, 1, fog);
   half4 r0 = lerp(t0, r0_fogged, c2.x);
   return r0;
};
