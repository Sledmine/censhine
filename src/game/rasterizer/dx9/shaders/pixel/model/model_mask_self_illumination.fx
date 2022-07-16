#include "model_common.h"

// Technique SelfIlluminationMaskInverseDetailBeforeReflectionBiasedMultiply, Pass P0: ShaderModel
half4 main_T0_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask, detail_function_biased_multiply, true, false);
}

// Technique SelfIlluminationMaskInverseDetailBeforeReflectionMultiply, Pass P0: ShaderModel
half4 main_T1_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask, detail_function_multiply, true, false);
}

// Technique SelfIlluminationMaskInverseDetailBeforeReflectionBiasedAdd, Pass P0: ShaderModel
half4 main_T2_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask, detail_function_biased_add, true, false);
}

// Technique SelfIlluminationMaskInverseDetailAfterReflectionBiasedMultiply, Pass P0: ShaderModel
half4 main_T3_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask, detail_function_biased_multiply, false, false);
}

// Technique SelfIlluminationMaskInverseDetailAfterReflectionMultiply, Pass P0: ShaderModel
half4 main_T4_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask, detail_function_multiply, false, false);
}

// Technique SelfIlluminationMaskInverseDetailAfterReflectionBiasedAdd, Pass P0: ShaderModel
half4 main_T5_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask, detail_function_biased_add, false, false);
}

// Technique SelfIlluminationMaskDetailBeforeReflectionBiasedMultiply, Pass P0: ShaderModel
half4 main_T6_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask_inverse, detail_function_biased_multiply, true, false);
}

// Technique SelfIlluminationMaskDetailBeforeReflectionMultiply, Pass P0: ShaderModel
half4 main_T7_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask_inverse, detail_function_multiply, true, false);
}

// Technique SelfIlluminationMaskDetailBeforeReflectionBiasedAdd, Pass P0: ShaderModel
half4 main_T8_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask_inverse, detail_function_biased_add, true, false);
}

// Technique SelfIlluminationMaskDetailAfterReflectionBiasedMultiply, Pass P0: ShaderModel
half4 main_T9_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask_inverse, detail_function_biased_multiply, false, false);
}

// Technique SelfIlluminationMaskDetailAfterReflectionMultiply, Pass P0: ShaderModel
half4 main_T10_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask_inverse, detail_function_multiply, false, false);
}

// Technique SelfIlluminationMaskDetailAfterReflectionBiasedAdd, Pass P0: ShaderModel
half4 main_T11_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask_inverse, detail_function_biased_add, false, false);
}

// Technique SelfIlluminationMaskInverseDetailBeforeReflectionBiasedMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T12_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask, detail_function_biased_multiply, true, true);
}

// Technique SelfIlluminationMaskInverseDetailBeforeReflectionMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T13_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask, detail_function_multiply, true, true);
}

// Technique SelfIlluminationMaskInverseDetailBeforeReflectionBiasedAddComplexFog, Pass P0: ShaderModel
half4 main_T14_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask, detail_function_biased_add, true, true);
}

// Technique SelfIlluminationMaskInverseDetailAfterReflectionBiasedMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T15_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask, detail_function_biased_multiply, false, true);
}

// Technique SelfIlluminationMaskInverseDetailAfterReflectionMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T16_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask, detail_function_multiply, false, true);
}

// Technique SelfIlluminationMaskInverseDetailAfterReflectionBiasedAddComplexFog, Pass P0: ShaderModel
half4 main_T17_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask, detail_function_biased_add, false, true);
}

// Technique SelfIlluminationMaskDetailBeforeReflectionBiasedMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T18_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask_inverse, detail_function_biased_multiply, true, true);
}

// Technique SelfIlluminationMaskDetailBeforeReflectionMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T19_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask_inverse, detail_function_multiply, true, true);
}

// Technique SelfIlluminationMaskDetailBeforeReflectionBiasedAddComplexFog, Pass P0: ShaderModel
half4 main_T20_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask_inverse, detail_function_biased_add, true, true);
}

// Technique SelfIlluminationMaskDetailAfterReflectionBiasedMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T21_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask_inverse, detail_function_biased_multiply, false, true);
}

// Technique SelfIlluminationMaskDetailAfterReflectionMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T22_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask_inverse, detail_function_multiply, false, true);
}

// Technique SelfIlluminationMaskDetailAfterReflectionBiasedAddComplexFog, Pass P0: ShaderModel
half4 main_T23_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_self_illumination_mask_inverse, detail_function_biased_add, false, true);
}
