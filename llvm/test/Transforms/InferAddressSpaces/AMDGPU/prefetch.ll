; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -passes=infer-address-spaces %s | FileCheck %s

define void @prefetch_shared_to_flat(ptr addrspace(3) %group.ptr) {
; CHECK-LABEL: define void @prefetch_shared_to_flat(
; CHECK-SAME: ptr addrspace(3) [[GROUP_PTR:%.*]]) {
; CHECK-NEXT:    tail call void @llvm.prefetch.p3(ptr addrspace(3) [[GROUP_PTR]], i32 0, i32 0, i32 1)
; CHECK-NEXT:    ret void
;
  %cast = addrspacecast ptr addrspace(3) %group.ptr to ptr
  tail call void @llvm.prefetch.p0(ptr %cast, i32 0, i32 0, i32 1)
  ret void
}

define void @prefetch_global_to_flat(ptr addrspace(1) %global.ptr) {
; CHECK-LABEL: define void @prefetch_global_to_flat(
; CHECK-SAME: ptr addrspace(1) [[GLOBAL_PTR:%.*]]) {
; CHECK-NEXT:    tail call void @llvm.prefetch.p1(ptr addrspace(1) [[GLOBAL_PTR]], i32 0, i32 0, i32 1)
; CHECK-NEXT:    ret void
;
  %cast = addrspacecast ptr addrspace(1) %global.ptr to ptr
  tail call void @llvm.prefetch.p0(ptr addrspace(0) %cast, i32 0, i32 0, i32 1)
  ret void
}

define void @prefetch_constant_to_flat(ptr addrspace(4) %const.ptr) {
; CHECK-LABEL: define void @prefetch_constant_to_flat(
; CHECK-SAME: ptr addrspace(4) [[CONST_PTR:%.*]]) {
; CHECK-NEXT:    tail call void @llvm.prefetch.p4(ptr addrspace(4) [[CONST_PTR]], i32 0, i32 0, i32 1)
; CHECK-NEXT:    ret void
;
  %cast = addrspacecast ptr addrspace(4) %const.ptr to ptr
  tail call void @llvm.prefetch.p0(ptr %cast, i32 0, i32 0, i32 1)
  ret void
}

define void @prefetch_flat_to_shared(ptr %flat.ptr) {
; CHECK-LABEL: define void @prefetch_flat_to_shared(
; CHECK-SAME: ptr [[FLAT_PTR:%.*]]) {
; CHECK-NEXT:    [[CAST:%.*]] = addrspacecast ptr [[FLAT_PTR]] to ptr addrspace(3)
; CHECK-NEXT:    tail call void @llvm.prefetch.p3(ptr addrspace(3) [[CAST]], i32 0, i32 0, i32 1)
; CHECK-NEXT:    ret void
;
  %cast = addrspacecast ptr %flat.ptr to ptr addrspace(3)
  tail call void @llvm.prefetch.p3(ptr addrspace(3) %cast, i32 0, i32 0, i32 1)
  ret void
}

define void @prefetch_flat_to_global(ptr %flat.ptr) {
; CHECK-LABEL: define void @prefetch_flat_to_global(
; CHECK-SAME: ptr [[FLAT_PTR:%.*]]) {
; CHECK-NEXT:    [[CAST:%.*]] = addrspacecast ptr [[FLAT_PTR]] to ptr addrspace(1)
; CHECK-NEXT:    tail call void @llvm.prefetch.p1(ptr addrspace(1) [[CAST]], i32 0, i32 0, i32 1)
; CHECK-NEXT:    ret void
;
  %cast = addrspacecast ptr %flat.ptr to ptr addrspace(1)
  tail call void @llvm.prefetch.p1(ptr addrspace(1) %cast, i32 0, i32 0, i32 1)
  ret void
}