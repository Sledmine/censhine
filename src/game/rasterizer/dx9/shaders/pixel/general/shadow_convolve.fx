SamplerState TexS0;
Texture2D Texture0;

SamplerState TexS1;
Texture2D Texture1;

SamplerState TexS2;
Texture2D Texture2;

SamplerState TexS3;
Texture2D Texture3;

struct PS_INPUT {
   float4 Pos : SV_POSITION;
   float4 D0 : COLOR0;
   float4 D1 : COLOR1;
   float4 T0 : TEXCOORD0;
   float4 T1 : TEXCOORD1;
   float4 T2 : TEXCOORD2;
   float4 T3 : TEXCOORD3;
};

half4 main_T0_P0(PS_INPUT i) : SV_TARGET
{
   // Inputs
   half2 Tex0 = i.T0;
   half2 Tex1 = i.T1;
   half2 Tex2 = i.T2;
   half2 Tex3 = i.T3;

   half4 r0, r1, r2, r3, r4, r5, r6;

   half4 c7 = half4(0.5,0.5,0.5,0.5);

   half4 t0 = Texture0.Sample(TexS0, Tex0.xy);
   half4 t1 = Texture1.Sample(TexS1, Tex1.xy);
   half4 t2 = Texture2.Sample(TexS2, Tex2.xy);
   half4 t3 = Texture3.Sample(TexS3, Tex3.xy);

   r0.rgb = (t2.rgb) * (c7);
   r0.a = (t0.b) * (c7);
   r0.rgb = ((t3.rgb) * (c7.rgb) + r0) / 2;
   r0.a = ((t1.b) * (c7.a) + r0.a) / 2;
   r0 = r0 + r0.a;
   return r0;
};

half4 main_T0_P1(PS_INPUT i) : SV_TARGET
{
   // Inputs
   half4 clr = i.D0;

   return clr;
};
