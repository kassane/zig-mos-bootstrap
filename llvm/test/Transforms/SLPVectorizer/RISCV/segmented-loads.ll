; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mtriple=riscv64-unknown-linux -mattr=+v -passes=slp-vectorizer -S | FileCheck %s

@src = common global [8 x double] zeroinitializer, align 64
@dst = common global [4 x double] zeroinitializer, align 64

define void @test() {
; CHECK-LABEL: @test(
; CHECK-NEXT:    [[TMP1:%.*]] = call <4 x double> @llvm.experimental.vp.strided.load.v4f64.p0.i64(ptr align 8 @src, i64 16, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, i32 4)
; CHECK-NEXT:    [[TMP2:%.*]] = call <4 x double> @llvm.experimental.vp.strided.load.v4f64.p0.i64(ptr align 8 getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 1), i64 16, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, i32 4)
; CHECK-NEXT:    [[TMP3:%.*]] = fsub fast <4 x double> [[TMP1]], [[TMP2]]
; CHECK-NEXT:    store <4 x double> [[TMP3]], ptr @dst, align 8
; CHECK-NEXT:    ret void
;
  %a0 = load double, ptr @src, align 8
  %a1 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 1), align 8
  %a2 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 2), align 8
  %a3 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 3), align 8
  %a4 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 4), align 8
  %a5 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 5), align 8
  %a6 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 6), align 8
  %a7 = load double, ptr getelementptr inbounds ([8 x double], ptr @src, i32 0, i64 7), align 8
  %res1 = fsub fast double %a0, %a1
  %res2 = fsub fast double %a2, %a3
  %res3 = fsub fast double %a4, %a5
  %res4 = fsub fast double %a6, %a7
  store double %res1, ptr @dst, align 8
  store double %res2, ptr getelementptr inbounds ([8 x double], ptr @dst, i32 0, i64 1), align 8
  store double %res3, ptr getelementptr inbounds ([8 x double], ptr @dst, i32 0, i64 2), align 8
  store double %res4, ptr getelementptr inbounds ([8 x double], ptr @dst, i32 0, i64 3), align 8
  ret void
}