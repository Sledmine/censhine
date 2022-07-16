SamplerState TexS0;
TextureCube Texture0;

SamplerState TexS2;
Texture2D Texture2;

struct PS_INPUT {
	float4 Pos : SV_POSITION;
	float4 D0 : COLOR0;
	float4 D1 : COLOR1;
	float4 T0 : TEXCOORD0;
	float4 T1 : TEXCOORD1;
	float4 T2 : TEXCOORD2;
};

cbuffer constants_buffer {
	float4 constants[2];
	//float4 c_effect_intensity;
	//float4 c_split_screen_offset_and_scale;
}

// Pass TintEdgeDensity
half4 main_T0_P0(PS_INPUT i) : SV_TARGET
{
	// Inputs
	half3 Tex0 = i.T0;
	half3 Tex1 = i.T1;
	half3 Tex2 = i.T2;

	float4 c_effect_intensity = constants[0];
	float4 c_split_screen_offset_and_scale = constants[1];

	half distance_scale = i.D0.a;
	half3 tint_color = i.D0.rgb;

	half4 r0;

	half4 t0 = Texture0.Sample(TexS0, Tex0.xyz);
	half3 t0v = lerp(-128.0/127, 1.0, t0.rgb);

	half2 uv_offset = half2(dot(t0v.xy, Tex1.xy), dot(t0v.xy, Tex2.xy));

	// convert current pixel pos to uv
	half2 uv1;
	uv1.x = uv_offset.x * c_split_screen_offset_and_scale.y + (i.Pos.x - 0.5) * Tex1.z;
	uv1.y = uv_offset.y * c_split_screen_offset_and_scale.w + (i.Pos.y - 0.5) * Tex2.z;

	// clamp to current split viewport
	uv1.x = clamp(uv1.x, c_split_screen_offset_and_scale.x, c_split_screen_offset_and_scale.x + c_split_screen_offset_and_scale.y - Tex1.z);
	uv1.y = clamp(uv1.y, c_split_screen_offset_and_scale.z, c_split_screen_offset_and_scale.z + c_split_screen_offset_and_scale.w - Tex2.z);

	half4 t2 = Texture2.Sample(TexS2, saturate(uv1.xy)); 

	r0.rgb = lerp(1, tint_color, t0.a);
	r0.rgb = lerp(1, r0.rgb, distance_scale) * t2;
	r0.a = c_effect_intensity.a;

	return r0;
};

// Pass NoEdgeTint
half4 main_T0_P1(PS_INPUT i) : SV_TARGET
{
	// Inputs
	half3 Tex0 = i.T0;
	half3 Tex1 = i.T1;
	half3 Tex2 = i.T2;

	float4 c_effect_intensity = constants[0];
	float4 c_split_screen_offset_and_scale = constants[1];

	half distance_scale = i.D0.a;
	half3 tint_color = i.D0.rgb;

	half4 r0;

	half4 t0 = Texture0.Sample(TexS0, Tex0.xyz);
	half3 t0v = lerp(-128.0/127, 1.0, t0.rgb);

	half2 uv_offset = half2(dot(t0v.xy, Tex1.xy), dot(t0v.xy, Tex2.xy));

	// convert current pixel pos to uv
	half2 uv1;
	uv1.x = uv_offset.x * c_split_screen_offset_and_scale.y + (i.Pos.x - 0.5) * Tex1.z;
	uv1.y = uv_offset.y * c_split_screen_offset_and_scale.w + (i.Pos.y - 0.5) * Tex2.z;

	// clamp to current split viewport
	uv1.x = clamp(uv1.x, c_split_screen_offset_and_scale.x, c_split_screen_offset_and_scale.x + c_split_screen_offset_and_scale.y - Tex1.z);
	uv1.y = clamp(uv1.y, c_split_screen_offset_and_scale.z, c_split_screen_offset_and_scale.z + c_split_screen_offset_and_scale.w - Tex2.z);

	half4 t2 = Texture2.Sample(TexS2, saturate(uv1.xy)); 

	r0.rgb = lerp(1, tint_color, distance_scale) * t2;
	r0.a = c_effect_intensity.a;

	return r0;
};

