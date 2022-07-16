export SHADER_PATH='./src/game/rasterizer/dx9/shaders'
export SHADER_COMPILE_CMD="luajit src/lua/compileCEShaders.lua $SHADER_PATH/pixel"

################################################################################
## Compile the pixel shaders
################################################################################

# General shaders
#$SHADER_COMPILE_CMD/general/active_camouflage_draw.fx --shader3
$SHADER_COMPILE_CMD/general/widget_sprite.fx
$SHADER_COMPILE_CMD/general/shadow_convolve.fx

# Transparent water
$SHADER_COMPILE_CMD/transparent_water/transparent_water_opacity.fx
$SHADER_COMPILE_CMD/transparent_water/transparent_water_reflection.fx
$SHADER_COMPILE_CMD/transparent_water/transparent_water_bumpmap_convolution.fx

# Transparent glass
#$SHADER_COMPILE_CMD/transparent_glass/transparent_glass_diffuse.fx
#$SHADER_COMPILE_CMD/transparent_glass/transparent_glass_tint.fx
$SHADER_COMPILE_CMD/transparent_glass/transparent_glass_reflection_bumped.fx
#$SHADER_COMPILE_CMD/transparent_glass/transparent_glass_reflection_flat.fx
#$SHADER_COMPILE_CMD/transparent_glass/transparent_glass_reflection_mirror.fx

# Transparent plasma
$SHADER_COMPILE_CMD/transparent_plasma/transparent_plasma.fx

# Models
$SHADER_COMPILE_CMD/model/model_environment.fx
#$SHADER_COMPILE_CMD/model/model_mask_change_color.fx
#$SHADER_COMPILE_CMD/model/model_mask_multipurpose.fx
#$SHADER_COMPILE_CMD/model/model_mask_none.fx
#$SHADER_COMPILE_CMD/model/model_mask_reflection.fx
#$SHADER_COMPILE_CMD/model/model_mask_self_illumination.fx

# Environment fog
$SHADER_COMPILE_CMD/environment/environment_fog.fx

# Environment reflection
$SHADER_COMPILE_CMD/environment_reflection/environment_reflection_bumped.fx
$SHADER_COMPILE_CMD/environment_reflection/environment_reflection_flat.fx
$SHADER_COMPILE_CMD/environment_reflection/environment_reflection_flat_specular.fx
$SHADER_COMPILE_CMD/environment_reflection/environment_reflection_lightmap_mask.fx
#$SHADER_COMPILE_CMD/environment_reflection/environment_reflection_mirror_bumped.fx --disable
$SHADER_COMPILE_CMD/environment_reflection/environment_reflection_radiosity.fx

# Environment lightmap
$SHADER_COMPILE_CMD/environment_lightmap/environment_lightmap_normal.fx
$SHADER_COMPILE_CMD/environment_lightmap/environment_lightmap_no_illumination.fx --compatible
$SHADER_COMPILE_CMD/environment_lightmap/environment_lightmap_no_illumination_no_lightmap.fx
$SHADER_COMPILE_CMD/environment_lightmap/environment_lightmap_no_lightmap.fx

# Environment diffuse
$SHADER_COMPILE_CMD/environment/environment_diffuse_lights.fx

# Enviroment specular
$SHADER_COMPILE_CMD/environment_specular/environment_specular_light_bumped.fx
$SHADER_COMPILE_CMD/environment_specular/environment_specular_light_flat.fx
$SHADER_COMPILE_CMD/environment_specular/environment_specular_lightmap_bumped.fx
$SHADER_COMPILE_CMD/environment_specular/environment_specular_lightmap_flat.fx

# Environment texture
## Blended
#$SHADER_COMPILE_CMD/environment_texture_blended_biased_add_biased_add.fx --disable
#$SHADER_COMPILE_CMD/environment_texture_blended_biased_add_biased_multiply.fx --disable
#$SHADER_COMPILE_CMD/environment_texture_blended_biased_add_multiply.fx --disable
#$SHADER_COMPILE_CMD/environment_texture_blended_biased_multiply_biased_add.fx --disable
#$SHADER_COMPILE_CMD/environment_texture_blended_biased_multiply_biased_multiply.fx --disable
#$SHADER_COMPILE_CMD/environment_texture_blended_biased_multiply_multiply.fx --disable
#$SHADER_COMPILE_CMD/environment_texture_blended_multiply_biased_add.fx --disable
#$SHADER_COMPILE_CMD/environment_texture_blended_multiply_biased_multiply.fx --disable
#$SHADER_COMPILE_CMD/environment_texture_blended_multiply_multiply.fx --disable

## Normal
$SHADER_COMPILE_CMD/environment_texture/normal/environment_texture_normal_biased_add_biased_add.fx
$SHADER_COMPILE_CMD/environment_texture/normal/environment_texture_normal_biased_add_biased_multiply.fx
$SHADER_COMPILE_CMD/environment_texture/normal/environment_texture_normal_biased_add_multiply.fx
$SHADER_COMPILE_CMD/environment_texture/normal/environment_texture_normal_biased_multiply_biased_add.fx
$SHADER_COMPILE_CMD/environment_texture/normal/environment_texture_normal_biased_multiply_biased_multiply.fx
$SHADER_COMPILE_CMD/environment_texture/normal/environment_texture_normal_biased_multiply_multiply.fx
$SHADER_COMPILE_CMD/environment_texture/normal/environment_texture_normal_multiply_biased_add.fx
$SHADER_COMPILE_CMD/environment_texture/normal/environment_texture_normal_multiply_multiply.fx

## Specular
#$SHADER_COMPILE_CMD/environment_texture_specular_mask_biased_add_biased_multiply.fx --disable
#$SHADER_COMPILE_CMD/environment_texture_specular_mask_biased_add_multiply.fx --disable
#$SHADER_COMPILE_CMD/environment_texture_specular_mask_biased_multiply_biased_add.fx --disable
#$SHADER_COMPILE_CMD/environment_texture_specular_mask_biased_multiply_biased_multiply.fx --disable
#$SHADER_COMPILE_CMD/environment_texture_specular_mask_biased_multiply_multiply.fx --disable
#$SHADER_COMPILE_CMD/environment_texture_specular_mask_multiply_biased_add.fx --disable
#$SHADER_COMPILE_CMD/environment_texture_specular_mask_multiply_biased_multiply.fx --disable
#$SHADER_COMPILE_CMD/environment_texture_specular_mask_multiply_multiply.fx --disable

#$SHADER_COMPILE_CMD/effect_multitexture_nonlinear_tint.fx --disable
#$SHADER_COMPILE_CMD/effect_multitexture_nonlinear_tint_add.fx --disable
#$SHADER_COMPILE_CMD/effect_multitexture_nonlinear_tint_alpha_blend.fx --disable
#$SHADER_COMPILE_CMD/effect_multitexture_nonlinear_tint_double_multiply.fx --disable
#$SHADER_COMPILE_CMD/effect_multitexture_nonlinear_tint_multiply.fx --disable
#$SHADER_COMPILE_CMD/effect_multitexture_nonlinear_tint_multiply_add.fx --disable
#$SHADER_COMPILE_CMD/effect_multitexture_normal_tint.fx --disable
#$SHADER_COMPILE_CMD/effect_multitexture_normal_tint_add.fx --disable
#$SHADER_COMPILE_CMD/effect_multitexture_normal_tint_alpha_blend.fx --disable
#$SHADER_COMPILE_CMD/effect_multitexture_normal_tint_double_multiply.fx --disable
#$SHADER_COMPILE_CMD/effect_multitexture_normal_tint_multiply.fx --disable
#$SHADER_COMPILE_CMD/effect_multitexture_normal_tint_multiply_add.fx --disable
#$SHADER_COMPILE_CMD/effect_nonlinear_tint.fx --disable
#$SHADER_COMPILE_CMD/effect_nonlinear_tint_add.fx --disable
#$SHADER_COMPILE_CMD/effect_nonlinear_tint_alpha_blend.fx --disable
#$SHADER_COMPILE_CMD/effect_nonlinear_tint_double_multiply.fx --disable
#$SHADER_COMPILE_CMD/effect_nonlinear_tint_multiply.fx --disable
#$SHADER_COMPILE_CMD/effect_nonlinear_tint_multiply_add.fx --disable
#$SHADER_COMPILE_CMD/effect_normal_tint.fx --disable
#$SHADER_COMPILE_CMD/effect_normal_tint_add.fx --disable
#$SHADER_COMPILE_CMD/effect_normal_tint_alpha_blend.fx --disable
#$SHADER_COMPILE_CMD/effect_normal_tint_double_multiply.fx --disable
#$SHADER_COMPILE_CMD/effect_normal_tint_multiply.fx --disable
#$SHADER_COMPILE_CMD/effect_normal_tint_multiply_add.fx --disable
#environment_diffuse_lights.fx
#environment_fog
#environment_lightmap_no_illumination
#environment_lightmap_no_illumination_no_lightmap
#environment_lightmap_no_lightmap
#environment_lightmap_normal
#environment_reflection_bumped
#environment_reflection_flat
#environment_reflection_flat_specular
#environment_reflection_lightmap_mask
#environment_reflection_mirror_bumped
#environment_reflection_mirror_flat
#environment_reflection_mirror_flat_specular
#environment_reflection_radiosity
#environment_shadow
#environment_specular_light_bumped
#environment_specular_light_flat
#environment_specular_lightmap_bumped
#environment_specular_lightmap_flat
#environment_texture_blended_biased_add_biased_add
#environment_texture_blended_biased_add_biased_multiply
#environment_texture_blended_biased_add_multiply
#environment_texture_blended_biased_multiply_biased_add
#environment_texture_blended_biased_multiply_biased_multiply
#environment_texture_blended_biased_multiply_multiply
#environment_texture_blended_multiply_biased_add
#environment_texture_blended_multiply_biased_multiply
#environment_texture_blended_multiply_multiply
#environment_texture_normal_biased_add_biased_add
#environment_texture_normal_biased_add_biased_multiply
#environment_texture_normal_biased_add_multiply
#environment_texture_normal_biased_multiply_biased_add
#environment_texture_normal_biased_multiply_biased_multiply
#environment_texture_normal_biased_multiply_multiply
#environment_texture_normal_multiply_biased_add
#environment_texture_normal_multiply_biased_multiply
#environment_texture_normal_multiply_multiply
#environment_texture_specular_mask_biased_add_biased_add
#environment_texture_specular_mask_biased_add_biased_multiply
#environment_texture_specular_mask_biased_add_multiply
#environment_texture_specular_mask_biased_multiply_biased_add
#environment_texture_specular_mask_biased_multiply_biased_multiply
#environment_texture_specular_mask_biased_multiply_multiply
#environment_texture_specular_mask_multiply_biased_add
#environment_texture_specular_mask_multiply_biased_multiply
#environment_texture_specular_mask_multiply_multiply
#model_environment
#model_mask_change_color
#model_mask_multipurpose
#model_mask_none
#model_mask_reflection
#model_mask_self_illumination
#screen_effect
#screen_effect_non_video
#screen_effect_non_video_convolution_mask
#screen_effect_non_video_convolution_none
#screen_effect_non_video_no_convolution_mask
#screen_effect_video
#screen_flash
#screen_meter
#screen_multitexture_add_add
#screen_multitexture_add_dot
#screen_multitexture_add_multiply
#screen_multitexture_add_multiply2x
#screen_multitexture_add_subtract
#screen_multitexture_dot_add
#screen_multitexture_dot_dot
#screen_multitexture_dot_multiply
#screen_multitexture_dot_multiply2x
#screen_multitexture_dot_subtract
#screen_multitexture_multiply2x_add
#screen_multitexture_multiply2x_dot
#screen_multitexture_multiply2x_multiply
#screen_multitexture_multiply2x_multiply2x
#screen_multitexture_multiply2x_subtract
#screen_multitexture_multiply_add
#screen_multitexture_multiply_dot
#screen_multitexture_multiply_multiply
#screen_multitexture_multiply_multiply2x
#screen_multitexture_multiply_subtract
#screen_multitexture_subtract_add
#screen_multitexture_subtract_dot
#screen_multitexture_subtract_multiply
#screen_multitexture_subtract_multiply2x
#screen_multitexture_subtract_subtract
#screen_normal
#shadow_convolve
#sun_glow_convolve
#sun_glow_draw
#transparent_generic
#transparent_glass_diffuse
#transparent_glass_reflection_bumped
#transparent_glass_reflection_flat
#transparent_glass_reflection_mirror
#transparent_glass_tint
#transparent_meter
#transparent_plasma
#transparent_water_bumpmap_convolution
#transparent_water_opacity
#transparent_water_reflection
#widget_sprite

################################################################################
## Build shaders
################################################################################

luajit src/lua/buildCEShaders.lua build/EffectCollection_ps_2_0 --encrypt
#luajit src/lua/buildCEShaders.lua build/EffectCollection_ps_3_0 --encrypt
luajit src/lua/buildCEShaders.lua build/vsh --vertex
