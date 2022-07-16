SamplerState TexS0; 
Texture3D Texture0;

SamplerState TexS1; 
Texture3D Texture1;

struct PS_INPUT {
	float4 Pos : SV_POSITION;
	float4 D0 : COLOR0;
	float4 D1 : COLOR1;
	float4 T0 : TEXCOORD0;
	float4 T1 : TEXCOORD1;
};

half4 main(PS_INPUT i) : SV_TARGET
{
	half4 Diff = i.D0;
	half3 Tex0 = i.T0;
	half3 Tex1 = i.T1;

	half4 t0 = Texture0.Sample(TexS0, Tex0.xyz); // texture0: 3d noise
	half4 t1 = Texture1.Sample(TexS1, Tex1.xyz); // texture1: 3d noise

	
	float plasma_intermed_1 = saturate(t0.b + 0.5 - t1.b);
	float plasma_intermed_2 = saturate(t1.a + 0.5 - t0.a);
	
	float plasma = (plasma_intermed_1 < 0.5) ? plasma_intermed_1 : plasma_intermed_2;
	// raw plasma
	plasma = saturate(plasma * plasma * 4);
	
	// attenuated plasma
	float attenuated_plasma = (plasma < 0.5) ? 0 : pow(2 * plasma - 1, 2);
	
	float3 plasma_color = saturate(plasma * Diff.rgb + attenuated_plasma * 0.5);
	plasma_color *= pow(plasma, 2);
	
	half4 final_color;
	final_color.rgb = plasma_color;
	final_color.a = Diff.a; // premultiply 1-fog and brightness, Spec.a * Diff.a multiplied in vertex shader
	return final_color;
};

