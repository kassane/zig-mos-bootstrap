// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 4
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +v \
// RUN:   -target-feature +zvfbfmin \
// RUN:   -target-feature +zvfbfwma -disable-O0-optnone \
// RUN:   -emit-llvm %s -o - | opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local target("riscv.vector.tuple", <vscale x 2 x i8>, 5) @test_vluxseg5ei16_v_bf16mf4x5(
// CHECK-RV64-SAME: ptr noundef [[RS1:%.*]], <vscale x 1 x i16> [[RS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call target("riscv.vector.tuple", <vscale x 2 x i8>, 5) @llvm.riscv.vluxseg5.triscv.vector.tuple_nxv2i8_5t.nxv1i16.i64(target("riscv.vector.tuple", <vscale x 2 x i8>, 5) poison, ptr [[RS1]], <vscale x 1 x i16> [[RS2]], i64 [[VL]], i64 0)
// CHECK-RV64-NEXT:    ret target("riscv.vector.tuple", <vscale x 2 x i8>, 5) [[TMP0]]
//
vbfloat16mf4x5_t test_vluxseg5ei16_v_bf16mf4x5(const __bf16 *rs1,
                                               vuint16mf4_t rs2, size_t vl) {
  return __riscv_vluxseg5ei16(rs1, rs2, vl);
}

// CHECK-RV64-LABEL: define dso_local target("riscv.vector.tuple", <vscale x 4 x i8>, 5) @test_vluxseg5ei16_v_bf16mf2x5(
// CHECK-RV64-SAME: ptr noundef [[RS1:%.*]], <vscale x 2 x i16> [[RS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call target("riscv.vector.tuple", <vscale x 4 x i8>, 5) @llvm.riscv.vluxseg5.triscv.vector.tuple_nxv4i8_5t.nxv2i16.i64(target("riscv.vector.tuple", <vscale x 4 x i8>, 5) poison, ptr [[RS1]], <vscale x 2 x i16> [[RS2]], i64 [[VL]], i64 0)
// CHECK-RV64-NEXT:    ret target("riscv.vector.tuple", <vscale x 4 x i8>, 5) [[TMP0]]
//
vbfloat16mf2x5_t test_vluxseg5ei16_v_bf16mf2x5(const __bf16 *rs1,
                                               vuint16mf2_t rs2, size_t vl) {
  return __riscv_vluxseg5ei16(rs1, rs2, vl);
}

// CHECK-RV64-LABEL: define dso_local target("riscv.vector.tuple", <vscale x 8 x i8>, 5) @test_vluxseg5ei16_v_bf16m1x5(
// CHECK-RV64-SAME: ptr noundef [[RS1:%.*]], <vscale x 4 x i16> [[RS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call target("riscv.vector.tuple", <vscale x 8 x i8>, 5) @llvm.riscv.vluxseg5.triscv.vector.tuple_nxv8i8_5t.nxv4i16.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 5) poison, ptr [[RS1]], <vscale x 4 x i16> [[RS2]], i64 [[VL]], i64 0)
// CHECK-RV64-NEXT:    ret target("riscv.vector.tuple", <vscale x 8 x i8>, 5) [[TMP0]]
//
vbfloat16m1x5_t test_vluxseg5ei16_v_bf16m1x5(const __bf16 *rs1, vuint16m1_t rs2,
                                             size_t vl) {
  return __riscv_vluxseg5ei16(rs1, rs2, vl);
}

// CHECK-RV64-LABEL: define dso_local target("riscv.vector.tuple", <vscale x 2 x i8>, 5) @test_vluxseg5ei16_v_bf16mf4x5_m(
// CHECK-RV64-SAME: <vscale x 1 x i1> [[VM:%.*]], ptr noundef [[RS1:%.*]], <vscale x 1 x i16> [[RS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call target("riscv.vector.tuple", <vscale x 2 x i8>, 5) @llvm.riscv.vluxseg5.mask.triscv.vector.tuple_nxv2i8_5t.nxv1i16.nxv1i1.i64(target("riscv.vector.tuple", <vscale x 2 x i8>, 5) poison, ptr [[RS1]], <vscale x 1 x i16> [[RS2]], <vscale x 1 x i1> [[VM]], i64 [[VL]], i64 3, i64 0)
// CHECK-RV64-NEXT:    ret target("riscv.vector.tuple", <vscale x 2 x i8>, 5) [[TMP0]]
//
vbfloat16mf4x5_t test_vluxseg5ei16_v_bf16mf4x5_m(vbool64_t vm,
                                                 const __bf16 *rs1,
                                                 vuint16mf4_t rs2, size_t vl) {
  return __riscv_vluxseg5ei16(vm, rs1, rs2, vl);
}

// CHECK-RV64-LABEL: define dso_local target("riscv.vector.tuple", <vscale x 4 x i8>, 5) @test_vluxseg5ei16_v_bf16mf2x5_m(
// CHECK-RV64-SAME: <vscale x 2 x i1> [[VM:%.*]], ptr noundef [[RS1:%.*]], <vscale x 2 x i16> [[RS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call target("riscv.vector.tuple", <vscale x 4 x i8>, 5) @llvm.riscv.vluxseg5.mask.triscv.vector.tuple_nxv4i8_5t.nxv2i16.nxv2i1.i64(target("riscv.vector.tuple", <vscale x 4 x i8>, 5) poison, ptr [[RS1]], <vscale x 2 x i16> [[RS2]], <vscale x 2 x i1> [[VM]], i64 [[VL]], i64 3, i64 0)
// CHECK-RV64-NEXT:    ret target("riscv.vector.tuple", <vscale x 4 x i8>, 5) [[TMP0]]
//
vbfloat16mf2x5_t test_vluxseg5ei16_v_bf16mf2x5_m(vbool32_t vm,
                                                 const __bf16 *rs1,
                                                 vuint16mf2_t rs2, size_t vl) {
  return __riscv_vluxseg5ei16(vm, rs1, rs2, vl);
}

// CHECK-RV64-LABEL: define dso_local target("riscv.vector.tuple", <vscale x 8 x i8>, 5) @test_vluxseg5ei16_v_bf16m1x5_m(
// CHECK-RV64-SAME: <vscale x 4 x i1> [[VM:%.*]], ptr noundef [[RS1:%.*]], <vscale x 4 x i16> [[RS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call target("riscv.vector.tuple", <vscale x 8 x i8>, 5) @llvm.riscv.vluxseg5.mask.triscv.vector.tuple_nxv8i8_5t.nxv4i16.nxv4i1.i64(target("riscv.vector.tuple", <vscale x 8 x i8>, 5) poison, ptr [[RS1]], <vscale x 4 x i16> [[RS2]], <vscale x 4 x i1> [[VM]], i64 [[VL]], i64 3, i64 0)
// CHECK-RV64-NEXT:    ret target("riscv.vector.tuple", <vscale x 8 x i8>, 5) [[TMP0]]
//
vbfloat16m1x5_t test_vluxseg5ei16_v_bf16m1x5_m(vbool16_t vm, const __bf16 *rs1,
                                               vuint16m1_t rs2, size_t vl) {
  return __riscv_vluxseg5ei16(vm, rs1, rs2, vl);
}