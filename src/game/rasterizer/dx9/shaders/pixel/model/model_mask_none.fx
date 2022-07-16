#include "model_common.h"

// Technique NoMaskDetailBeforeReflectionBiasedMultiply, Pass P0: ShaderModel
half4 main_T0_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_none, detail_function_biased_multiply, true, false);
}

// Technique NoMaskDetailBeforeReflectionMultiply, Pass P0: ShaderModel
half4 main_T1_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_none, detail_function_multiply, true, false);
}

// Technique NoMaskDetailBeforeReflectionBiasedAdd, Pass P0: ShaderModel
half4 main_T2_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_none, detail_function_biased_add, true, false);
}

// Technique NoMaskDetailAfterReflectionBiasedMultiply, Pass P0: ShaderModel
half4 main_T3_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_none, detail_function_biased_multiply, false, false);
}

// Technique NoMaskDetailAfterReflectionMultiply, Pass P0: ShaderModel
half4 main_T4_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_none, detail_function_multiply, false, false);
}

// Technique NoMaskDetailAfterReflectionBiasedAdd, Pass P0: ShaderModel
half4 main_T5_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_none, detail_function_biased_add, false, false);
}

// Technique NoMaskDetailBeforeReflectionBiasedMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T6_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_none, detail_function_biased_multiply, true, true);
}

// Technique NoMaskDetailBeforeReflectionMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T7_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_none, detail_function_multiply, true, true);
}

// Technique NoMaskDetailBeforeReflectionBiasedAddComplexFog, Pass P0: ShaderModel
half4 main_T8_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_none, detail_function_biased_add, true, true);
}

// Technique NoMaskDetailAfterReflectionBiasedMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T9_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_none, detail_function_biased_multiply, false, true);
}

// Technique NoMaskDetailAfterReflectionMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T10_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_none, detail_function_multiply, false, true);
}

// Technique NoMaskDetailAfterReflectionBiasedAddComplexFog, Pass P0: ShaderModel
half4 main_T11_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_multipurpose_map, detail_mask_none, detail_function_biased_add, false, true);
}

