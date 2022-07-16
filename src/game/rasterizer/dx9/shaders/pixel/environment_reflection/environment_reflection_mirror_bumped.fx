SamplerState TexSampler0;
Texture2D Texture0;

SamplerState TexSampler1;
TextureCube Texture1;

SamplerState TexSampler2;
TextureCube Texture2;

SamplerState TexSampler3;
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
	half4 constants[3];
	//half4 c_eye_forward;
	//half4 c_view_perpendicular_color;
	//half4 c_view_parallel_color;
}

// EnvironmentReflectionMirrorBumped
half4 main(PS_INPUT i) : SV_TARGET
{
	// Inputs
	half4 Diff = i.D0;
	half4 Tex0 = i.T0;
	half4 Tex1 = i.T1;
	half4 Tex2 = i.T2;
	half4 Tex3 = i.T3;

	half4 c_eye_forward = constants[0];
	half4 c_view_perpendicular_color = constants[1];
	half4 c_view_parallel_color = constants[2];


	half4 T0 = Texture0.Sample(TexSampler0, Tex0.xy);
	half4 T1 = Texture1.Sample(TexSampler1, Tex1.xyz);
	half4 T2 = Texture2.Sample(TexSampler2, Tex2.xyz);
	half4 T3 = Texture3.Sample(TexSampler3, Tex3.xy / Tex3.w);
	
	half3 R0;
	half R0a;
	half3 R1;
	half R1a;
	half3 SRCCOLOR;
	half SRCALPHA;
	
	// combiner 0
	R0	= dot(((2*T2)-1),c_eye_forward);
	R1	= T3*T3;

	saturate(R0);
	
	// combiner 1
	R0	= R0*R0;
	R1	= R1*R1;
	
	// combiner 2
	R1	= R1*R1;
	
	// combiner 3
	R0a	= lerp(c_view_parallel_color.a, c_view_perpendicular_color.a, R0.b);
	R0	= lerp(c_view_parallel_color, c_view_perpendicular_color, R0.b);
	
	// combiner 4
	R0	= lerp( R1, T3, R0 );
	
	// final combiner
	SRCCOLOR = R0*R0a;
	SRCALPHA = 1.0;
	
	return half4( SRCCOLOR, SRCALPHA );
}

