; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -passes=slp-vectorizer -S -mtriple=x86_64-unknown-linux-gnu < %s | FileCheck %s

define void @test(ptr %p) {
; CHECK-LABEL: define void @test(
; CHECK-SAME: ptr [[P:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[GEP1:%.*]] = getelementptr inbounds i8, ptr [[P]], i64 16
; CHECK-NEXT:    store <2 x i64> zeroinitializer, ptr [[GEP1]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %conv548.2.i.13 = zext i32 0 to i64
  %and551.2.i.13 = and i64 0, %conv548.2.i.13
  %conv548.3.i.13 = zext i32 0 to i64
  %and551.3.i.13 = and i64 0, %conv548.3.i.13
  %0 = trunc i64 %and551.2.i.13 to i32
  %conv54.2.i.14 = and i32 %0, 0
  %conv548.2.i.14 = zext i32 %conv54.2.i.14 to i64
  %and551.2.i.14 = and i64 %and551.2.i.13, %conv548.2.i.14
  %1 = trunc i64 %and551.3.i.13 to i32
  %conv54.3.i.14 = and i32 %1, 0
  %conv548.3.i.14 = zext i32 %conv54.3.i.14 to i64
  %and551.3.i.14 = and i64 %and551.3.i.13, %conv548.3.i.14
  %and551.2.i.15 = and i64 %and551.2.i.14, 0
  %and551.3.i.15 = and i64 %and551.3.i.14, 0
  %and551.2.i.16 = and i64 %and551.2.i.15, 0
  %and551.3.i.16 = and i64 %and551.3.i.15, 0
  %and551.2.i.17 = and i64 %and551.2.i.16, 0
  %and551.3.i.17 = and i64 %and551.3.i.16, 0
  %and551.2.i.18 = and i64 %and551.2.i.17, 0
  %and551.3.i.18 = and i64 %and551.3.i.17, 0
  %and551.2.i.19 = and i64 %and551.2.i.18, 0
  %and551.3.i.19 = and i64 %and551.3.i.18, 0
  %and551.2.i.20 = and i64 %and551.2.i.19, 0
  %and551.3.i.20 = and i64 %and551.3.i.19, 0
  %and551.2.i.21 = and i64 %and551.2.i.20, 0
  %and551.3.i.21 = and i64 %and551.3.i.20, 0
  %gep1 = getelementptr inbounds i8, ptr %p, i64 16
  %gep2 = getelementptr inbounds i8, ptr %p, i64 24
  store i64 %and551.2.i.21, ptr %gep1, align 16
  store i64 %and551.3.i.21, ptr %gep2, align 8
  ret void
}