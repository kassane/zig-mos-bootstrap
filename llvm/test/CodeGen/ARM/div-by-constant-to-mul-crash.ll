; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -mtriple=armv7--linux-gnueabihf -mattr=+neon | FileCheck %s

; This test case used to crash due to the div by K -> mul expansion in TargetLowering.

define <8 x i32> @f1(<8 x i32> %arg) {
; CHECK-LABEL: f1:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r4, r5, r6, r7, r11, lr}
; CHECK-NEXT:    push {r4, r5, r6, r7, r11, lr}
; CHECK-NEXT:    vmov r0, r2, d2
; CHECK-NEXT:    movw r4, #60681
; CHECK-NEXT:    vmov lr, r1, d0
; CHECK-NEXT:    movt r4, #46117
; CHECK-NEXT:    vmov r12, r3, d3
; CHECK-NEXT:    smmul r5, r0, r4
; CHECK-NEXT:    smmul r7, r2, r4
; CHECK-NEXT:    smmul r6, r1, r4
; CHECK-NEXT:    asr r2, r5, #4
; CHECK-NEXT:    smmul r1, r3, r4
; CHECK-NEXT:    add r2, r2, r5, lsr #31
; CHECK-NEXT:    vmov r3, r5, d1
; CHECK-NEXT:    smmul r0, lr, r4
; CHECK-NEXT:    vmov.32 d2[0], r2
; CHECK-NEXT:    smmul r5, r5, r4
; CHECK-NEXT:    smmul r3, r3, r4
; CHECK-NEXT:    smmul r4, r12, r4
; CHECK-NEXT:    asr r2, r4, #4
; CHECK-NEXT:    add r2, r2, r4, lsr #31
; CHECK-NEXT:    asr r4, r3, #4
; CHECK-NEXT:    vmov.32 d3[0], r2
; CHECK-NEXT:    add r2, r4, r3, lsr #31
; CHECK-NEXT:    asr r3, r0, #4
; CHECK-NEXT:    add r0, r3, r0, lsr #31
; CHECK-NEXT:    vmov.32 d1[0], r2
; CHECK-NEXT:    asr r2, r5, #4
; CHECK-NEXT:    vmov.32 d0[0], r0
; CHECK-NEXT:    add r0, r2, r5, lsr #31
; CHECK-NEXT:    asr r2, r6, #4
; CHECK-NEXT:    vmov.32 d1[1], r0
; CHECK-NEXT:    add r0, r2, r6, lsr #31
; CHECK-NEXT:    asr r2, r1, #4
; CHECK-NEXT:    vmov.32 d0[1], r0
; CHECK-NEXT:    add r0, r2, r1, lsr #31
; CHECK-NEXT:    asr r1, r7, #4
; CHECK-NEXT:    vmov.32 d3[1], r0
; CHECK-NEXT:    add r0, r1, r7, lsr #31
; CHECK-NEXT:    vmov.32 d2[1], r0
; CHECK-NEXT:    pop {r4, r5, r6, r7, r11, pc}
  %v = sdiv <8 x i32> %arg, <i32 -54, i32 -54, i32 -54, i32 -54, i32 -54, i32 -54, i32 -54, i32 -54>
  ret <8 x i32> %v
}