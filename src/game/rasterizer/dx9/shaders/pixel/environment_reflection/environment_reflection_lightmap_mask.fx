SamplerState TexS0;
Texture2D Texture0;

struct PS_INPUT {
	float4 Pos : SV_POSITION;
	float4 D0 : COLOR0;
	float4 D1 : COLOR1;
	float4 T0 : TEXCOORD0;
};

cbuffer constants_buffer {
	float4 c1 : register(c1);
}

half4 main(PS_INPUT i) : SV_TARGET
{
	// Inputs
	half2 Tex0 = i.T0;

	half4 r0;

	half4 c0 = half4(0.5019607843137254f,0.6901960784313725f,0.3137254901960784f,0.0);
	// c1 - lightmap brightness

	half4 t0 = Texture0.Sample(TexS0, Tex0.xy); // lightmap

	r0 = saturate(dot(t0.rgb, c0.rgb));
	r0.a = (1-r0.b) * (c1.a) + r0.b;
	return r0;
};

