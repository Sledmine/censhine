SamplerState TexS0;
Texture2D Texture0;

SamplerState TexS1;
TextureCube Texture1;

SamplerState TexS2;
TextureCube Texture2;

SamplerState TexS3;
TextureCube Texture3;

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

half4 main(PS_INPUT i) : SV_TARGET
{
	// Inputs
	half2 Tex0 = i.T0;
	half3 Tex1 = i.T1;
	half3 Tex2 = i.T2;
	half3 Tex3 = i.T3;

	half4 c_eye_forward = constants[0];
	half4 c_view_perpendicular_color = constants[1];
	half4 c_view_parallel_color = constants[2];

	half3 t0 = Texture0.Sample(TexS0, Tex0.xy).rgb;

	half3 E1, N1;
	half3 E2, N2;
	
	// non-local viewer eye vector in tangent space
	E1 = 2 * (Texture1.Sample(TexS1, Tex1.xyz).rgb - 0.5); // eye vector_normalization
	N1 = 2 * (t0 - 0.5); // texture0: bump map
	
	// no bump map texture, world space vectors
	E2 = c_eye_forward.xyz; // ws eye
	N2 = 2 * (Texture1.Sample(TexS2, Tex2.xyz).rgb - 0.5); // ws normal vector_normalization
	
	half3 E, N;
	// c_eye_forward.w 1 when bump map NONE
	E = lerp(E1, E2, c_eye_forward.w);
	N = lerp(N1, N2, c_eye_forward.w);
	
	half3 R = Tex3.xyz;
	
	half3 reflection_color = Texture3.Sample(TexS3, R.xyz); // texture3: specular reflection cube map
	half3 specular_color = pow(reflection_color, 8);
	
	half diffuse_reflection = pow(dot(N, E), 2);
	
	half3 specular_mask = 1;

	half attenuation = lerp( c_view_parallel_color.a, c_view_perpendicular_color.a, diffuse_reflection );
	
	half3 tint_color = lerp( c_view_parallel_color, c_view_perpendicular_color, diffuse_reflection );
	
	half3 tinted_reflection = lerp( specular_color, reflection_color, tint_color );

	half3 final_color = tinted_reflection * ( attenuation * specular_mask );

	return half4(final_color, 1.0);
}

