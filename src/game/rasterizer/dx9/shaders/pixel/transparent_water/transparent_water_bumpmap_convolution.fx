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

cbuffer constants_buffer {
	float4 constants[4];
	//float4 c0 : packoffset(c0);
	//float4 c1 : packoffset(c1);
	//float4 c2 : packoffset(c2);
	//float4 c3 : packoffset(c3);
}

half4 main(PS_INPUT i) : SV_TARGET
{
	// Inputs
	half2 Tex0 = i.T0;
	half2 Tex1 = i.T1;
	half2 Tex2 = i.T2;
	half2 Tex3 = i.T3;

	float4 c0 = constants[0];
	float4 c1 = constants[1];
	float4 c2 = constants[2];
	float4 c3 = constants[3];

	half4 r0, r1;

	half4 t0 = 2 * Texture0.Sample(TexS0, Tex0.xy) - 1;
	half4 t1 = 2 * Texture1.Sample(TexS1, Tex1.xy) - 1;
	half4 t2 = 2 * Texture2.Sample(TexS2, Tex2.xy) - 1;
	half4 t3 = 2 * Texture3.Sample(TexS3, Tex3.xy) - 1;

	r0 = lerp(t0, t1, c0.a);
	r1 = lerp(t2, t3, c1.a);
	r0 = (lerp(r0, r1, c2.a) + 1) * 0.5;

	r0 = lerp(r0, c3, c3.a);


	return r0;
};

