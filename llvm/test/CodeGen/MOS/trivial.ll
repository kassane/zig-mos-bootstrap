; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -O0 --filetype=asm < %s | FileCheck %s
target triple = "mos"

define i16 @main() {
; CHECK-LABEL: main:
; CHECK:       ; %bb.0:
; CHECK-NEXT:    ldx #0
; CHECK-NEXT:    txa
; CHECK-NEXT:    rts
  ret i16 0
}
