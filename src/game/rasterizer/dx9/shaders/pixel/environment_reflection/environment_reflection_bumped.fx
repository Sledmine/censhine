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
};

cbuffer constants_buffer {
	half4 constants[3];
	//half4 c_eye_forward;
	//half4 c_view_perpendicular_color;
	//half4 c_view_parallel_color;
}

void CalculateEyeDirAndNormal(half2 Tex0, half4 Tex1, half4 Tex2, half4 Tex3, out half3 E, out half3 N)
{
	E = normalize(half3(Tex1.w, Tex2.w, Tex3.w));
	half3 bump_color = 2 * Texture0.Sample(TexS0, Tex0.xy) - 1;
	N = normalize(half3(dot(Tex1, bump_color), dot(Tex2, bump_color), dot(Tex3, bump_color)));
}

half4 main(PS_INPUT i) : SV_TARGET
{
	// Inputs

	// Bump map
	half2 Tex0 = i.T0;
	half4 Tex1 = i.T1;
	half4 Tex2 = i.T2;
	// Specular reflection cube map
	half4 Tex3 = i.T3;

	// Constants
	half4 c_eye_forward = constants[0];
	half4 c_view_perpendicular_color = constants[1];
	half4 c_view_parallel_color = constants[2];

	half3 E, N;
	CalculateEyeDirAndNormal(Tex0, Tex1, Tex2, Tex3, E, N);
	half3 R = normalize(2*dot(N, E)*N - E);

	half3 reflection_color = Texture3.Sample(TexS3, R.xyz);
	half3 specular_color = pow(reflection_color, 8);

	half diffuse_reflection = pow(dot(N, E), 2);

	half attenuation = lerp( c_view_parallel_color.a, c_view_perpendicular_color.a, diffuse_reflection );
	half3 tint_color = lerp( c_view_parallel_color, c_view_perpendicular_color, diffuse_reflection );

	half3 tinted_reflection = lerp( specular_color, reflection_color, tint_color );

	half3 final_color = tinted_reflection * attenuation;

	return half4(final_color, 1.0);
};

