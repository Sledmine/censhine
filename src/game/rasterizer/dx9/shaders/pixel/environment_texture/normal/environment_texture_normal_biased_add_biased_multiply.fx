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

half4 main(PS_INPUT i) : SV_TARGET
{
	half2 Tex0 = i.T0;
	half2 Tex1 = i.T1;
	half2 Tex2 = i.T2;
	half2 Tex3 = i.T3;

	half4 r0;

	half4 t0 = Texture0.Sample(TexS0, Tex0.xy); // texture0: base map
	half4 t1 = Texture1.Sample(TexS1, Tex1.xy); // texture1: primary detail map
	half4 t2 = Texture2.Sample(TexS2, Tex2.xy); // texture2: secondary detail map
	half4 t3 = Texture3.Sample(TexS3, Tex3.xy); // texture3: micro detail map
	
	// environment type = normal
	r0.rgb = lerp(t2, t1, t2.a);   // detail map
	r0.a = lerp(t2.a, t1.a, t2.a); // detail specular mask
	r0.a *= t0.a;

	// detail map function
	r0.rgb = saturate(t0.rgb + 2 * r0 - 1); // biased add

	r0.a *= t3.a;
			
	// micro detail map function
	r0.rgb = saturate(t3.rgb * r0.rgb); // multiply
	
	return r0;
};
