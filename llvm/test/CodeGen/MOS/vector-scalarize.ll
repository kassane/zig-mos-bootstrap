; RUN: llc -mtriple=mos -verify-machineinstrs -o /dev/null %s
; Vector operations reach the backend even though MOS has no vector
; registers: SROA invents vector types for aggregates, and instcombine (in
; particular during LTO) then forms vector operations over them. Every such
; operation must legalize by scalarization. This test passes if llc does not
; report "unable to legalize".

target datalayout = "e-p:16:8:8-p1:8:8-i16:8:8-i32:8:8-i64:8:8-f32:8:8-f64:8:8-a:8:8-Fi8-n8"
target triple = "mos"

define void @load_store(ptr %p, ptr %q) {
  %v = load volatile <5 x i16>, ptr %p
  store volatile <5 x i16> %v, ptr %q
  ret void
}

define void @store_constant(ptr %p) {
  store <5 x i16> <i16 1, i16 2, i16 3, i16 4, i16 5>, ptr %p
  ret void
}

define i16 @extract_const(ptr %p) {
  %v = load <5 x i16>, ptr %p
  %e = extractelement <5 x i16> %v, i64 1
  ret i16 %e
}

define i16 @extract_var(ptr %p, i16 %i) {
  %v = load <4 x i16>, ptr %p
  %e = extractelement <4 x i16> %v, i16 %i
  ret i16 %e
}

define void @insert_const(ptr %p, i16 %x) {
  %v = load <4 x i16>, ptr %p
  %v2 = insertelement <4 x i16> %v, i16 %x, i64 1
  store <4 x i16> %v2, ptr %p
  ret void
}

define void @insert_var_undef(ptr %p, i16 %x, i16 %i) {
  %v = insertelement <4 x i16> undef, i16 %x, i16 %i
  store <4 x i16> %v, ptr %p
  ret void
}

define void @phi(i1 %c, ptr %p, ptr %q, ptr %r) {
entry:
  br i1 %c, label %a, label %b
a:
  %va = load <4 x i16>, ptr %p
  br label %join
b:
  %vb = load <4 x i16>, ptr %q
  br label %join
join:
  %v = phi <4 x i16> [ %va, %a ], [ %vb, %b ]
  store <4 x i16> %v, ptr %r
  ret void
}

define void @select(i1 %c, ptr %p, ptr %q, ptr %r) {
  %va = load <4 x i16>, ptr %p
  %vb = load <4 x i16>, ptr %q
  %v = select i1 %c, <4 x i16> %va, <4 x i16> %vb
  store <4 x i16> %v, ptr %r
  ret void
}

define void @shuffle(ptr %p, ptr %q, ptr %r) {
  %va = load <4 x i16>, ptr %p
  %vb = load <4 x i16>, ptr %q
  %v = shufflevector <4 x i16> %va, <4 x i16> %vb, <4 x i32> <i32 0, i32 5, i32 2, i32 7>
  store <4 x i16> %v, ptr %r
  ret void
}

define i16 @bitcast_scalar_to_vector(i64 %x) {
  %v = bitcast i64 %x to <4 x i16>
  %e = extractelement <4 x i16> %v, i64 2
  ret i16 %e
}

define i64 @bitcast_vector_to_scalar(ptr %p) {
  %v = load <4 x i16>, ptr %p
  %x = bitcast <4 x i16> %v to i64
  ret i64 %x
}

define void @add(ptr %p, ptr %q, ptr %r) {
  %va = load <4 x i16>, ptr %p
  %vb = load <4 x i16>, ptr %q
  %v = add <4 x i16> %va, %vb
  store <4 x i16> %v, ptr %r
  ret void
}

define void @mul(ptr %p, ptr %q, ptr %r) {
  %va = load <4 x i16>, ptr %p
  %vb = load <4 x i16>, ptr %q
  %v = mul <4 x i16> %va, %vb
  store <4 x i16> %v, ptr %r
  ret void
}

define void @shl(ptr %p, ptr %r) {
  %v = load <4 x i16>, ptr %p
  %t = shl <4 x i16> %v, <i16 1, i16 1, i16 1, i16 1>
  store <4 x i16> %t, ptr %r
  ret void
}

define void @icmp_zext(ptr %p, ptr %q, ptr %r) {
  %va = load <4 x i16>, ptr %p
  %vb = load <4 x i16>, ptr %q
  %c = icmp eq <4 x i16> %va, %vb
  %z = zext <4 x i1> %c to <4 x i16>
  store <4 x i16> %z, ptr %r
  ret void
}

define void @trunc(ptr %p, ptr %r) {
  %v = load <4 x i16>, ptr %p
  %t = trunc <4 x i16> %v to <4 x i8>
  store <4 x i8> %t, ptr %r
  ret void
}

define void @freeze(ptr %p, ptr %r) {
  %v = load <4 x i16>, ptr %p
  %fr = freeze <4 x i16> %v
  store <4 x i16> %fr, ptr %r
  ret void
}
