; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -mattr +avx < %s | FileCheck %s

; The C source used as a base for generating this test:.

; unsigned test(float f)
; {
;    unsigned i;
;    // Copies f into the output operand i
;    asm volatile ("" : "=r" (i) : "0" (f));
;    return i;
; }


define i32 @test_int_float(float %f) {
; CHECK-LABEL: test_int_float:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmovd %xmm0, %eax
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    retq
entry:
  %asm_call = call i32 asm sideeffect "", "=r,0,~{dirflag},~{fpsr},~{flags}"(float %f)
  ret i32 %asm_call
}

define i32 @test_int_ptr(ptr %f) {
; CHECK-LABEL: test_int_ptr:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq %rdi, %rax
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    # kill: def $eax killed $eax killed $rax
; CHECK-NEXT:    retq
entry:
  %asm_call = call i32 asm sideeffect "", "=r,0,~{dirflag},~{fpsr},~{flags}"(ptr %f)
  ret i32 %asm_call
}

define i64 @test_int_vec(<4 x i16> %v) {
; CHECK-LABEL: test_int_vec:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    vmovq %xmm0, %rax
; CHECK-NEXT:    retq
entry:
  %asm_call = call i64 asm sideeffect "", "=v,0,~{dirflag},~{fpsr},~{flags}"(<4 x i16> %v)
  ret i64 %asm_call
}

define <4 x i32> @test_int_vec_float_vec(<4 x float> %f) {
; CHECK-LABEL: test_int_vec_float_vec:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    #APP
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    retq
entry:
  %asm_call = call <4 x i32> asm sideeffect "", "=v,0,~{dirflag},~{fpsr},~{flags}"(<4 x float> %f)
  ret <4 x i32> %asm_call
}