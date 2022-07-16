#include "model_common.h"

// Technique ReflectionMaskInverseDetailBeforeReflectionBiasedMultiply, Pass P0: ShaderModel
half4 main_T0_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask, detail_function_biased_multiply, true, false);
}

// Technique ReflectionMaskInverseDetailBeforeReflectionMultiply, Pass P0: ShaderModel
half4 main_T1_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask, detail_function_multiply, true, false);
}

// Technique ReflectionMaskInverseDetailBeforeReflectionBiasedAdd, Pass P0: ShaderModel
half4 main_T2_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask, detail_function_biased_add, true, false);
}

// Technique ReflectionMaskInverseDetailAfterReflectionBiasedMultiply, Pass P0: ShaderModel
half4 main_T3_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask, detail_function_biased_multiply, false, false);
}

// Technique ReflectionMaskInverseDetailAfterReflectionMultiply, Pass P0: ShaderModel
half4 main_T4_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask, detail_function_multiply, false, false);
}

// Technique ReflectionMaskInverseDetailAfterReflectionBiasedAdd, Pass P0: ShaderModel
half4 main_T5_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask, detail_function_biased_add, false, false);
}

// Technique ReflectionMaskDetailBeforeReflectionBiasedMultiply, Pass P0: ShaderModel
half4 main_T6_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask_inverse, detail_function_biased_multiply, true, false);
}

// Technique ReflectionMaskDetailBeforeReflectionMultiply, Pass P0: ShaderModel
half4 main_T7_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask_inverse, detail_function_multiply, true, false);
}

// Technique ReflectionMaskDetailBeforeReflectionBiasedAdd, Pass P0: ShaderModel
half4 main_T8_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask_inverse, detail_function_biased_add, true, false);
}

// Technique ReflectionMaskDetailAfterReflectionBiasedMultiply, Pass P0: ShaderModel
half4 main_T9_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask_inverse, detail_function_biased_multiply, false, false);
}

// Technique ReflectionMaskDetailAfterReflectionMultiply, Pass P0: ShaderModel
half4 main_T10_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask_inverse, detail_function_multiply, false, false);
}

// Technique ReflectionMaskDetailAfterReflectionBiasedAdd, Pass P0: ShaderModel
half4 main_T11_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask_inverse, detail_function_biased_add, false, false);
}

// Technique ReflectionMaskInverseDetailBeforeReflectionBiasedMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T12_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask, detail_function_biased_multiply, true, true);
}

// Technique ReflectionMaskInverseDetailBeforeReflectionMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T13_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask, detail_function_multiply, true, true);
}

// Technique ReflectionMaskInverseDetailBeforeReflectionBiasedAddComplexFog, Pass P0: ShaderModel
half4 main_T14_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask, detail_function_biased_add, true, true);
}

// Technique ReflectionMaskInverseDetailAfterReflectionBiasedMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T15_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask, detail_function_biased_multiply, false, true);
}

// Technique ReflectionMaskInverseDetailAfterReflectionMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T16_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask, detail_function_multiply, false, true);
}

// Technique ReflectionMaskInverseDetailAfterReflectionBiasedAddComplexFog, Pass P0: ShaderModel
half4 main_T17_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask, detail_function_biased_add, false, true);
}

// Technique ReflectionMaskDetailBeforeReflectionBiasedMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T18_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask_inverse, detail_function_biased_multiply, true, true);
}

// Technique ReflectionMaskDetailBeforeReflectionMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T19_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask_inverse, detail_function_multiply, true, true);
}

// Technique ReflectionMaskDetailBeforeReflectionBiasedAddComplexFog, Pass P0: ShaderModel
half4 main_T20_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask_inverse, detail_function_biased_add, true, true);
}

// Technique ReflectionMaskDetailAfterReflectionBiasedMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T21_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask_inverse, detail_function_biased_multiply, false, true);
}

// Technique ReflectionMaskDetailAfterReflectionMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T22_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask_inverse, detail_function_multiply, false, true);
}

// Technique ReflectionMaskDetailAfterReflectionBiasedAddComplexFog, Pass P0: ShaderModel
half4 main_T23_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_reflection_mask_inverse, detail_function_biased_add, false, true);
}

