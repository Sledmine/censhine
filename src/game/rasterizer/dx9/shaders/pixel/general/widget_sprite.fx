Texture2D Texture0;
SamplerState TexS0;

struct PS_INPUT {
   float4 Pos : SV_POSITION;
   float4 D0 : COLOR0;
   float4 D1 : COLOR1;
   float4 T0 : TEXCOORD0;
};

half4 main(PS_INPUT i) : SV_TARGET
{
   // Inputs
   half4 firstColor = i.D0;
   half4 secondColor = i.D1;
   half2 Tex0 = i.T0;

   half4 r0, r1, r2, r3, r4, r5, r6;

   half4 spriteTexture = Texture0.Sample(TexS0, Tex0.xy);

   r0 = (spriteTexture) * (spriteTexture);
   r1 = (r0) * (r0);
   spriteTexture = (firstColor) * (spriteTexture);
   r0 = (r0) * (r1);
   r1 = (1-firstColor) * (secondColor.a);
   r0.rgb = (r0.rgb) * (secondColor.rgb) + spriteTexture;
   r0.a = spriteTexture.a;
   return r0;
};
