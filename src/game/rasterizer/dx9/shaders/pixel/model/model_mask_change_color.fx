#include "model_common.h"

// Technique ChangeColorMaskInverseDetailBeforeReflectionBiasedMultiply, Pass P0: ShaderModel
half4 main_T0_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask, detail_function_biased_multiply, true, false);
}

// Technique ChangeColorMaskInverseDetailBeforeReflectionMultiply, Pass P0: ShaderModel
half4 main_T1_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask, detail_function_multiply, true, false);
}

// Technique ChangeColorMaskInverseDetailBeforeReflectionBiasedAdd, Pass P0: ShaderModel
half4 main_T2_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask, detail_function_biased_add, true, false);
}

// Technique ChangeColorMaskInverseDetailAfterReflectionBiasedMultiply, Pass P0: ShaderModel
half4 main_T3_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask, detail_function_biased_multiply, false, false);
}

// Technique ChangeColorMaskInverseDetailAfterReflectionMultiply, Pass P0: ShaderModel
half4 main_T4_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask, detail_function_multiply, false, false);
}

// Technique ChangeColorMaskInverseDetailAfterReflectionBiasedAdd, Pass P0: ShaderModel
half4 main_T5_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask, detail_function_biased_add, false, false);
}

// Technique ChangeColorMaskDetailBeforeReflectionBiasedMultiply, Pass P0: ShaderModel
half4 main_T6_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask_inverse, detail_function_biased_multiply, true, false);
}

// Technique ChangeColorMaskDetailBeforeReflectionMultiply, Pass P0: ShaderModel
half4 main_T7_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask_inverse, detail_function_multiply, true, false);
}

// Technique ChangeColorMaskDetailBeforeReflectionBiasedAdd, Pass P0: ShaderModel
half4 main_T8_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask_inverse, detail_function_biased_add, true, false);
}

// Technique ChangeColorMaskDetailAfterReflectionBiasedMultiply, Pass P0: ShaderModel
half4 main_T9_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask_inverse, detail_function_biased_multiply, false, false);
}

// Technique ChangeColorMaskDetailAfterReflectionMultiply, Pass P0: ShaderModel
half4 main_T10_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask_inverse, detail_function_multiply, false, false);
}

// Technique ChangeColorMaskDetailAfterReflectionBiasedAdd, Pass P0: ShaderModel
half4 main_T11_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask_inverse, detail_function_biased_add, false, false);
}

// Technique ChangeColorMaskInverseDetailBeforeReflectionBiasedMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T12_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask, detail_function_biased_multiply, true, true);
}

// Technique ChangeColorMaskInverseDetailBeforeReflectionMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T13_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask, detail_function_multiply, true, true);
}

// Technique ChangeColorMaskInverseDetailBeforeReflectionBiasedAddComplexFog, Pass P0: ShaderModel
half4 main_T14_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask, detail_function_biased_add, true, true);
}

// Technique ChangeColorMaskInverseDetailAfterReflectionBiasedMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T15_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask, detail_function_biased_multiply, false, true);
}

// Technique ChangeColorMaskInverseDetailAfterReflectionMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T16_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask, detail_function_multiply, false, true);
}

// Technique ChangeColorMaskInverseDetailAfterReflectionBiasedAddComplexFog, Pass P0: ShaderModel
half4 main_T17_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask, detail_function_biased_add, false, true);
}

// Technique ChangeColorMaskDetailBeforeReflectionBiasedMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T18_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask_inverse, detail_function_biased_multiply, true, true);
}

// Technique ChangeColorMaskDetailBeforeReflectionMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T19_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask_inverse, detail_function_multiply, true, true);
}

// Technique ChangeColorMaskDetailBeforeReflectionBiasedAddComplexFog, Pass P0: ShaderModel
half4 main_T20_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask_inverse, detail_function_biased_add, true, true);
}

// Technique ChangeColorMaskDetailAfterReflectionBiasedMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T21_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask_inverse, detail_function_biased_multiply, false, true);
}

// Technique ChangeColorMaskDetailAfterReflectionMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T22_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask_inverse, detail_function_multiply, false, true);
}

// Technique ChangeColorMaskDetailAfterReflectionBiasedAddComplexFog, Pass P0: ShaderModel
half4 main_T23_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_change_color_mask_inverse, detail_function_biased_add, false, true);
}
