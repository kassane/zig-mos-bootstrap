// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --function-signature
 // REQUIRES: amdgpu-registered-target
 // RUN: %clang_cc1 -triple amdgcn-unknown-unknown -target-cpu verde -emit-llvm -o - %s | FileCheck %s

typedef struct AA_ty {
  int x;
  __amdgpu_buffer_rsrc_t r;
} AA;

AA getAA(void *p);
__amdgpu_buffer_rsrc_t getBufferImpl(void *p);
void consumeBuffer(__amdgpu_buffer_rsrc_t);

// CHECK-LABEL: define {{[^@]+}}@getBuffer
// CHECK-SAME: (ptr addrspace(5) noundef [[P:%.*]]) local_unnamed_addr #[[ATTR0:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[CALL:%.*]] = tail call ptr addrspace(8) @getBufferImpl(ptr addrspace(5) noundef [[P]]) #[[ATTR2:[0-9]+]]
// CHECK-NEXT:    ret ptr addrspace(8) [[CALL]]
//
__amdgpu_buffer_rsrc_t getBuffer(void *p) {
  return getBufferImpl(p);
}

// CHECK-LABEL: define {{[^@]+}}@consumeBufferPtr
// CHECK-SAME: (ptr addrspace(5) noundef readonly [[P:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TOBOOL_NOT:%.*]] = icmp eq ptr addrspace(5) [[P]], addrspacecast (ptr null to ptr addrspace(5))
// CHECK-NEXT:    br i1 [[TOBOOL_NOT]], label [[IF_END:%.*]], label [[IF_THEN:%.*]]
// CHECK:       if.then:
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr addrspace(8), ptr addrspace(5) [[P]], align 16, !tbaa [[TBAA4:![0-9]+]]
// CHECK-NEXT:    tail call void @consumeBuffer(ptr addrspace(8) [[TMP0]]) #[[ATTR2]]
// CHECK-NEXT:    br label [[IF_END]]
// CHECK:       if.end:
// CHECK-NEXT:    ret void
//
void consumeBufferPtr(__amdgpu_buffer_rsrc_t *p) {
  if (p)
    consumeBuffer(*p);
}

// CHECK-LABEL: define {{[^@]+}}@test
// CHECK-SAME: (ptr addrspace(5) noundef readonly [[A:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr addrspace(5) [[A]], align 16, !tbaa [[TBAA8:![0-9]+]]
// CHECK-NEXT:    [[TOBOOL_NOT:%.*]] = icmp eq i32 [[TMP0]], 0
// CHECK-NEXT:    [[TOBOOL_NOT_I:%.*]] = icmp eq ptr addrspace(5) [[A]], addrspacecast (ptr null to ptr addrspace(5))
// CHECK-NEXT:    [[OR_COND:%.*]] = or i1 [[TOBOOL_NOT_I]], [[TOBOOL_NOT]]
// CHECK-NEXT:    br i1 [[OR_COND]], label [[IF_END:%.*]], label [[IF_THEN_I:%.*]]
// CHECK:       if.then.i:
// CHECK-NEXT:    [[R:%.*]] = getelementptr inbounds nuw i8, ptr addrspace(5) [[A]], i32 16
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr addrspace(8), ptr addrspace(5) [[R]], align 16, !tbaa [[TBAA4]]
// CHECK-NEXT:    tail call void @consumeBuffer(ptr addrspace(8) [[TMP1]]) #[[ATTR2]]
// CHECK-NEXT:    br label [[IF_END]]
// CHECK:       if.end:
// CHECK-NEXT:    ret void
//
void test(AA *a) {
  if (a->x)
    consumeBufferPtr(&(a->r));
}

// CHECK-LABEL: define {{[^@]+}}@bar
// CHECK-SAME: (ptr addrspace(5) noundef [[P:%.*]]) local_unnamed_addr #[[ATTR0]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[CALL:%.*]] = tail call [[STRUCT_AA_TY:%.*]] @[[GETAA:[a-zA-Z0-9_$\"\\.-]*[a-zA-Z_$\"\\.-][a-zA-Z0-9_$\"\\.-]*]](ptr addrspace(5) noundef [[P]]) #[[ATTR2]]
// CHECK-NEXT:    [[TMP0:%.*]] = extractvalue [[STRUCT_AA_TY]] [[CALL]], 0
// CHECK-NEXT:    [[CALL_I:%.*]] = tail call ptr addrspace(8) @getBufferImpl(ptr addrspace(5) noundef [[P]]) #[[ATTR2]]
// CHECK-NEXT:    [[TOBOOL_NOT_I:%.*]] = icmp eq i32 [[TMP0]], 0
// CHECK-NEXT:    br i1 [[TOBOOL_NOT_I]], label [[TEST_EXIT:%.*]], label [[IF_THEN_I_I:%.*]]
// CHECK:       if.then.i.i:
// CHECK-NEXT:    tail call void @consumeBuffer(ptr addrspace(8) [[CALL_I]]) #[[ATTR2]]
// CHECK-NEXT:    br label [[TEST_EXIT]]
// CHECK:       test.exit:
// CHECK-NEXT:    [[DOTFCA_1_INSERT:%.*]] = insertvalue [[STRUCT_AA_TY]] [[CALL]], ptr addrspace(8) [[CALL_I]], 1
// CHECK-NEXT:    ret [[STRUCT_AA_TY]] [[DOTFCA_1_INSERT]]
//
AA bar(void *p) {
  AA a = getAA(p);
  a.r = getBuffer(p);
  test(&a);
  return a;
}