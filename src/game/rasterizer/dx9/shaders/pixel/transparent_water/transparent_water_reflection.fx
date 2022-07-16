SamplerState TexS0 : register(s1);
Texture2D Texture0 : register(t1);

SamplerState TexS3 : register(s2);
TextureCube Texture3 : register(t2);

struct PS_INPUT {
   float4 Pos : SV_POSITION;
   float4 D0 : COLOR0;
   float4 D1 : COLOR1;
   float4 T0 : TEXCOORD0;
   float4 T1 : TEXCOORD1;
   float4 T2 : TEXCOORD2;
   float4 T3 : TEXCOORD3;
   float4 T4 : TEXCOORD4;
};

cbuffer constants_buffer {
   float4 constants[2];
   //float4 c0 : packoffset(c0); // tint color
   //float4 c1 : packoffset(c1); // _shader_transparent_water_atmospheric_fog_bit ? 1 : 0
}

half4 main(PS_INPUT i) : SV_TARGET
{
   // Inputs
   half2 Tex0 = i.T0;
   half4 Tex1 = i.T1;
   half4 Tex2 = i.T2;
   half4 Tex3 = i.T3;
   half fog = i.T4;

   // Constants
   float4 c0 = constants[0]; // tint color
   float4 c1 = constants[1]; // _shader_transparent_water_atmospheric_fog_bit ? 1 : 0

   half3 t0 = lerp(-128.0/127, 1.0, Texture0.Sample(TexS0, Tex0.xy).rgb); // texture0: bump map

   // normal
   half3 N;
   N.x = dot(Tex1.xyz, t0.rgb);
   N.y = dot(Tex2.xyz, t0.rgb);
   N.z = dot(Tex3.xyz, t0.rgb);

   // eye
   half3 E = half3(Tex1.w, Tex2.w, Tex3.w);

   // reflected vector
   half3 uvw2 = 2 * (dot(N,E) / dot(N,N)) * N - E;

   half4 t3 = Texture3.Sample(TexS3, uvw2.xyz); // texture3: reflection map

   half4 r0 = lerp(pow(t3, 8), t3, c0);

   half4 r0_fogged = (1 - fog)*r0;

   r0 = lerp(r0, r0_fogged, c1.x);
   return r0;
};

