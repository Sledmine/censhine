#include "model_common.h"

// Technique EnvironmentNoMaskDetailBeforeReflectionBiasedMultiply, Pass P0: ShaderModel
half4 main_T0_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_base_and_detail_map, detail_mask_none, detail_function_biased_multiply, true, false);
}

// Technique EnvironmentNoMaskDetailBeforeReflectionMultiply, Pass P0: ShaderModel
half4 main_T1_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_base_and_detail_map, detail_mask_none, detail_function_multiply, true, false);
}

// Technique EnvironmentNoMaskDetailBeforeReflectionBiasedAdd, Pass P0: ShaderModel
half4 main_T2_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_base_and_detail_map, detail_mask_none, detail_function_biased_add, true,  false);
}

// Technique EnvironmentNoMaskDetailAfterReflectionBiasedMultiply, Pass P0: ShaderModel
half4 main_T3_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_base_and_detail_map, detail_mask_none, detail_function_biased_multiply, false, false);
}

// Technique EnvironmentNoMaskDetailAfterReflectionMultiply, Pass P0: ShaderModel
half4 main_T4_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_base_and_detail_map, detail_mask_none, detail_function_multiply, false, false);
}

// Technique EnvironmentNoMaskDetailAfterReflectionBiasedAdd, Pass P0: ShaderModel
half4 main_T5_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_base_and_detail_map, detail_mask_none, detail_function_biased_add, false, false);
}

// Technique EnvironmentNoMaskDetailBeforeReflectionBiasedMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T6_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_base_and_detail_map, detail_mask_none, detail_function_biased_multiply, true, true);
}

// Technique EnvironmentNoMaskDetailBeforeReflectionMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T7_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_base_and_detail_map, detail_mask_none, detail_function_multiply, true, true);
}

// Technique EnvironmentNoMaskDetailBeforeReflectionBiasedAddComplexFog, Pass P0: ShaderModel
half4 main_T8_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_base_and_detail_map, detail_mask_none, detail_function_biased_add, true, true);
}

// Technique EnvironmentNoMaskDetailAfterReflectionBiasedMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T9_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_base_and_detail_map, detail_mask_none, detail_function_biased_multiply, false, true);
}

// Technique EnvironmentNoMaskDetailAfterReflectionMultiplyComplexFog, Pass P0: ShaderModel
half4 main_T10_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_base_and_detail_map, detail_mask_none, detail_function_multiply, false, true);
}

// Technique EnvironmentNoMaskDetailAfterReflectionBiasedAddComplexFog, Pass P0: ShaderModel
half4 main_T11_P0(PS_INPUT i) : SV_TARGET
{
   return ShaderModel(i, reflection_mask_base_and_detail_map, detail_mask_none, detail_function_biased_add, false, true);
}
