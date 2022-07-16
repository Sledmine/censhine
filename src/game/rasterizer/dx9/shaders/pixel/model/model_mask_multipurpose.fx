#include "model_common.h"

// Technique MultipurposeMaskInverseDetailBeforeReflectionBiasedMultiply, Pass P0: ShaderModel
half4 main_T0_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask, detail_function_biased_multiply, true, false);
}

// Technique MultipurposeMaskInverseDetailBeforeReflectionMultiply, Pass P0: ShaderModel
half4 main_T1_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask, detail_function_multiply, true, false);
}

// Technique MultipurposeMaskInverseDetailBeforeReflectionBiasedAdd, Pass P0: ShaderModel
half4 main_T2_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask, detail_function_biased_add, true, false);
}

// Technique MultipurposeMaskInverseDetailAfterReflectionBiasedMultiply, Pass P0: ShaderModel
half4 main_T3_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask, detail_function_biased_multiply, false, false);
}

// Technique MultipurposeMaskInverseDetailAfterReflectionMultiply, Pass P0: ShaderModel
half4 main_T4_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask, detail_function_multiply, false, false);
}

// Technique MultipurposeMaskInverseDetailAfterReflectionBiasedAdd, Pass P0: ShaderModel
half4 main_T5_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask, detail_function_biased_add, false, false);
}

// Technique MultipurposeMaskDetailBeforeReflectionBiasedMultiply, Pass P0: ShaderModel
half4 main_T6_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask_inverse, detail_function_biased_multiply, true, false);
}

// Technique MultipurposeMaskDetailBeforeReflectionMultiply, Pass P0: ShaderModel
half4 main_T7_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask_inverse, detail_function_multiply, true, false);
}

// Technique MultipurposeMaskDetailBeforeReflectionBiasedAdd, Pass P0: ShaderModel
half4 main_T8_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask_inverse, detail_function_biased_add, true, false);
}

// Technique MultipurposeMaskDetailAfterReflectionBiasedMultiply, Pass P0: ShaderModel
half4 main_T9_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask_inverse, detail_function_biased_multiply, false, false);
}

// Technique MultipurposeMaskDetailAfterReflectionMultiply, Pass P0: ShaderModel
half4 main_T10_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask_inverse, detail_function_multiply, false, false);
}

// Technique MultipurposeMaskDetailAfterReflectionBiasedAdd, Pass P0: ShaderModel
half4 main_T11_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask_inverse, detail_function_biased_add, false, false);
}

// Technique MultipurposeMaskInverseDetailBeforeReflectionBiasedMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T12_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask, detail_function_biased_multiply, true, true);
}

// Technique MultipurposeMaskInverseDetailBeforeReflectionMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T13_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask, detail_function_multiply, true, true);
}

// Technique MultipurposeMaskInverseDetailBeforeReflectionBiasedAddComplexFog, Pass P0: ShaderModel
half4 main_T14_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask, detail_function_biased_add, true, true);
}

// Technique MultipurposeMaskInverseDetailAfterReflectionBiasedMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T15_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask, detail_function_biased_multiply, false, true);
}

// Technique MultipurposeMaskInverseDetailAfterReflectionMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T16_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask, detail_function_multiply, false, true);
}

// Technique MultipurposeMaskInverseDetailAfterReflectionBiasedAddComplexFog, Pass P0: ShaderModel
half4 main_T17_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask, detail_function_biased_add, false, true);
}

// Technique MultipurposeMaskDetailBeforeReflectionBiasedMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T18_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask_inverse, detail_function_biased_multiply, true, true);
}

// Technique MultipurposeMaskDetailBeforeReflectionMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T19_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask_inverse, detail_function_multiply, true, true);
}

// Technique MultipurposeMaskDetailBeforeReflectionBiasedAddComplexFog, Pass P0: ShaderModel
half4 main_T20_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask_inverse, detail_function_biased_add, true, true);
}

// Technique MultipurposeMaskDetailAfterReflectionBiasedMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T21_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask_inverse, detail_function_biased_multiply, false, true);
}

// Technique MultipurposeMaskDetailAfterReflectionMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T22_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask_inverse, detail_function_multiply, false, true);
}

// Technique MultipurposeMaskDetailAfterReflectionBiasedAddComplexFog, Pass P0: ShaderModel
half4 main_T23_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_multipurpose_alpha_mask_inverse, detail_function_biased_add, false, true);
}
