; This test is to ensure that OpExtInst generated by NonSemantic_Shader_DebugInfo_100
; are not mixed up with other OpExtInst instructions.
; The code of the test is a reproducer, because "lgamma" has the same code (35)
; inside OpenCL_std as DebugSource inside NonSemantic_Shader_DebugInfo_100.

; RUN: llc -O0 -mtriple=spirv64-unknown-unknown %s -o - | FileCheck %s
; RUN: %if spirv-tools %{ llc -O0 -mtriple=spirv64-unknown-unknown %s -o - -filetype=obj | spirv-val %}

; RUN: llc -O0 -mtriple=spirv32-unknown-unknown %s -o - | FileCheck %s
; RUN: %if spirv-tools %{ llc -O0 -mtriple=spirv32-unknown-unknown %s -o - -filetype=obj | spirv-val %}

; CHECK: %[[#Ocl:]] = OpExtInstImport "OpenCL.std"
; CHECK: OpName %[[#Fun:]] "__devicelib_lgammaf"
; CHECK: %[[#Fun]] = OpFunction %[[#]] None %[[#]]
; CHECK: OpFunctionParameter
; CHECK: %[[#]] = OpExtInst %[[#]] %[[#Ocl]] lgamma %[[#]]

define weak_odr dso_local spir_kernel void @foo() {
entry:
  %r = tail call spir_func noundef float @lgammaf(float noundef 0x7FF8000000000000)
  ret void
}

define weak dso_local spir_func float @lgammaf(float noundef %x) {
entry:
  %call = tail call spir_func float @__devicelib_lgammaf(float noundef %x)
  ret float %call
}

define weak dso_local spir_func float @__devicelib_lgammaf(float noundef %x) {
entry:
  %call = tail call spir_func noundef float @_Z18__spirv_ocl_lgammaf(float noundef %x)
  ret float %call
}

declare dso_local spir_func noundef float @_Z18__spirv_ocl_lgammaf(float noundef)