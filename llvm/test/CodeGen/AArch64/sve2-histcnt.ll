; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc -mtriple=aarch64 -verify-machineinstrs < %s -o - | FileCheck %s

define void @histogram_i64(<vscale x 2 x ptr> %buckets, i64 %inc, <vscale x 2 x i1> %mask) #0 {
; CHECK-LABEL: histogram_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    histcnt z1.d, p0/z, z0.d, z0.d
; CHECK-NEXT:    mov z3.d, x0
; CHECK-NEXT:    ld1d { z2.d }, p0/z, [z0.d]
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    mad z1.d, p1/m, z3.d, z2.d
; CHECK-NEXT:    st1d { z1.d }, p0, [z0.d]
; CHECK-NEXT:    ret
  call void @llvm.experimental.vector.histogram.add.nxv2p0.i64(<vscale x 2 x ptr> %buckets, i64 %inc, <vscale x 2 x i1> %mask)
  ret void
}

;; FIXME: We maybe need some dagcombines here? We're multiplying the output of the histcnt
;;        by 1, so we should be able to remove that and directly add the histcnt to the
;;        current bucket data.
define void @histogram_i32_literal(ptr %base, <vscale x 4 x i32> %indices, <vscale x 4 x i1> %mask) #0 {
; CHECK-LABEL: histogram_i32_literal:
; CHECK:       // %bb.0:
; CHECK-NEXT:    histcnt z1.s, p0/z, z0.s, z0.s
; CHECK-NEXT:    mov z3.s, #1 // =0x1
; CHECK-NEXT:    ld1w { z2.s }, p0/z, [x0, z0.s, sxtw #2]
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    mad z1.s, p1/m, z3.s, z2.s
; CHECK-NEXT:    st1w { z1.s }, p0, [x0, z0.s, sxtw #2]
; CHECK-NEXT:    ret

  %buckets = getelementptr i32, ptr %base, <vscale x 4 x i32> %indices
  call void @llvm.experimental.vector.histogram.add.nxv4p0.i32(<vscale x 4 x ptr> %buckets, i32 1, <vscale x 4 x i1> %mask)
  ret void
}

define void @histogram_i32_literal_noscale(ptr %base, <vscale x 4 x i32> %indices, <vscale x 4 x i1> %mask) #0 {
; CHECK-LABEL: histogram_i32_literal_noscale:
; CHECK:       // %bb.0:
; CHECK-NEXT:    histcnt z1.s, p0/z, z0.s, z0.s
; CHECK-NEXT:    mov z3.s, #1 // =0x1
; CHECK-NEXT:    ld1w { z2.s }, p0/z, [x0, z0.s, sxtw]
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    mad z1.s, p1/m, z3.s, z2.s
; CHECK-NEXT:    st1w { z1.s }, p0, [x0, z0.s, sxtw]
; CHECK-NEXT:    ret

  %buckets = getelementptr i8, ptr %base, <vscale x 4 x i32> %indices
  call void @llvm.experimental.vector.histogram.add.nxv4p0.i32(<vscale x 4 x ptr> %buckets, i32 1, <vscale x 4 x i1> %mask)
  ret void
}

define void @histogram_i32_promote(ptr %base, <vscale x 2 x i64> %indices, <vscale x 2 x i1> %mask, i32 %inc) #0 {
; CHECK-LABEL: histogram_i32_promote:
; CHECK:       // %bb.0:
; CHECK-NEXT:    histcnt z1.d, p0/z, z0.d, z0.d
; CHECK-NEXT:    // kill: def $w1 killed $w1 def $x1
; CHECK-NEXT:    mov z3.d, x1
; CHECK-NEXT:    ld1w { z2.d }, p0/z, [x0, z0.d, lsl #2]
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    mad z1.d, p1/m, z3.d, z2.d
; CHECK-NEXT:    st1w { z1.d }, p0, [x0, z0.d, lsl #2]
; CHECK-NEXT:    ret
  %buckets = getelementptr i32, ptr %base, <vscale x 2 x i64> %indices
  call void @llvm.experimental.vector.histogram.add.nxv2p0.i32(<vscale x 2 x ptr> %buckets, i32 %inc, <vscale x 2 x i1> %mask)
  ret void
}

define void @histogram_i16(ptr %base, <vscale x 4 x i32> %indices, <vscale x 4 x i1> %mask, i16 %inc) #0 {
; CHECK-LABEL: histogram_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    histcnt z1.s, p0/z, z0.s, z0.s
; CHECK-NEXT:    mov z3.s, w1
; CHECK-NEXT:    ld1h { z2.s }, p0/z, [x0, z0.s, sxtw #1]
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    mad z1.s, p1/m, z3.s, z2.s
; CHECK-NEXT:    st1h { z1.s }, p0, [x0, z0.s, sxtw #1]
; CHECK-NEXT:    ret
  %buckets = getelementptr i16, ptr %base, <vscale x 4 x i32> %indices
  call void @llvm.experimental.vector.histogram.add.nxv4p0.i16(<vscale x 4 x ptr> %buckets, i16 %inc, <vscale x 4 x i1> %mask)
  ret void
}

define void @histogram_i8(ptr %base, <vscale x 4 x i32> %indices, <vscale x 4 x i1> %mask, i8 %inc) #0 {
; CHECK-LABEL: histogram_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    histcnt z1.s, p0/z, z0.s, z0.s
; CHECK-NEXT:    mov z3.s, w1
; CHECK-NEXT:    ld1b { z2.s }, p0/z, [x0, z0.s, sxtw]
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    mad z1.s, p1/m, z3.s, z2.s
; CHECK-NEXT:    st1b { z1.s }, p0, [x0, z0.s, sxtw]
; CHECK-NEXT:    ret
  %buckets = getelementptr i8, ptr %base, <vscale x 4 x i32> %indices
  call void @llvm.experimental.vector.histogram.add.nxv4p0.i8(<vscale x 4 x ptr> %buckets, i8 %inc, <vscale x 4 x i1> %mask)
  ret void
}

define void @histogram_i16_2_lane(ptr %base, <vscale x 2 x i64> %indices, <vscale x 2 x i1> %mask, i16 %inc) #0 {
; CHECK-LABEL: histogram_i16_2_lane:
; CHECK:       // %bb.0:
; CHECK-NEXT:    histcnt z1.d, p0/z, z0.d, z0.d
; CHECK-NEXT:    // kill: def $w1 killed $w1 def $x1
; CHECK-NEXT:    mov z3.d, x1
; CHECK-NEXT:    ld1h { z2.d }, p0/z, [x0, z0.d, lsl #1]
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    mad z1.d, p1/m, z3.d, z2.d
; CHECK-NEXT:    st1h { z1.d }, p0, [x0, z0.d, lsl #1]
; CHECK-NEXT:    ret
  %buckets = getelementptr i16, ptr %base, <vscale x 2 x i64> %indices
  call void @llvm.experimental.vector.histogram.add.nxv2p0.i16(<vscale x 2 x ptr> %buckets, i16 %inc, <vscale x 2 x i1> %mask)
  ret void
}

define void @histogram_i8_2_lane(ptr %base, <vscale x 2 x i64> %indices, <vscale x 2 x i1> %mask, i8 %inc) #0 {
; CHECK-LABEL: histogram_i8_2_lane:
; CHECK:       // %bb.0:
; CHECK-NEXT:    histcnt z1.d, p0/z, z0.d, z0.d
; CHECK-NEXT:    // kill: def $w1 killed $w1 def $x1
; CHECK-NEXT:    mov z3.d, x1
; CHECK-NEXT:    ld1b { z2.d }, p0/z, [x0, z0.d]
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    mad z1.d, p1/m, z3.d, z2.d
; CHECK-NEXT:    st1b { z1.d }, p0, [x0, z0.d]
; CHECK-NEXT:    ret
  %buckets = getelementptr i8, ptr %base, <vscale x 2 x i64> %indices
  call void @llvm.experimental.vector.histogram.add.nxv2p0.i8(<vscale x 2 x ptr> %buckets, i8 %inc, <vscale x 2 x i1> %mask)
  ret void
}

define void @histogram_i16_literal_1(ptr %base, <vscale x 4 x i32> %indices, <vscale x 4 x i1> %mask) #0 {
; CHECK-LABEL: histogram_i16_literal_1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    histcnt z1.s, p0/z, z0.s, z0.s
; CHECK-NEXT:    mov z3.s, #1 // =0x1
; CHECK-NEXT:    ld1h { z2.s }, p0/z, [x0, z0.s, sxtw #1]
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    mad z1.s, p1/m, z3.s, z2.s
; CHECK-NEXT:    st1h { z1.s }, p0, [x0, z0.s, sxtw #1]
; CHECK-NEXT:    ret
  %buckets = getelementptr i16, ptr %base, <vscale x 4 x i32> %indices
  call void @llvm.experimental.vector.histogram.add.nxv4p0.i16(<vscale x 4 x ptr> %buckets, i16 1, <vscale x 4 x i1> %mask)
  ret void
}

define void @histogram_i16_literal_2(ptr %base, <vscale x 4 x i32> %indices, <vscale x 4 x i1> %mask) #0 {
; CHECK-LABEL: histogram_i16_literal_2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    histcnt z1.s, p0/z, z0.s, z0.s
; CHECK-NEXT:    mov z3.s, #2 // =0x2
; CHECK-NEXT:    ld1h { z2.s }, p0/z, [x0, z0.s, sxtw #1]
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    mad z1.s, p1/m, z3.s, z2.s
; CHECK-NEXT:    st1h { z1.s }, p0, [x0, z0.s, sxtw #1]
; CHECK-NEXT:    ret
  %buckets = getelementptr i16, ptr %base, <vscale x 4 x i32> %indices
  call void @llvm.experimental.vector.histogram.add.nxv4p0.i16(<vscale x 4 x ptr> %buckets, i16 2, <vscale x 4 x i1> %mask)
  ret void
}

define void @histogram_i16_literal_3(ptr %base, <vscale x 4 x i32> %indices, <vscale x 4 x i1> %mask) #0 {
; CHECK-LABEL: histogram_i16_literal_3:
; CHECK:       // %bb.0:
; CHECK-NEXT:    histcnt z1.s, p0/z, z0.s, z0.s
; CHECK-NEXT:    mov z3.s, #3 // =0x3
; CHECK-NEXT:    ld1h { z2.s }, p0/z, [x0, z0.s, sxtw #1]
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    mad z1.s, p1/m, z3.s, z2.s
; CHECK-NEXT:    st1h { z1.s }, p0, [x0, z0.s, sxtw #1]
; CHECK-NEXT:    ret
  %buckets = getelementptr i16, ptr %base, <vscale x 4 x i32> %indices
  call void @llvm.experimental.vector.histogram.add.nxv4p0.i16(<vscale x 4 x ptr> %buckets, i16 3, <vscale x 4 x i1> %mask)
  ret void
}

define void @histogram_i64_4_lane(<vscale x 4 x ptr> %buckets, i64 %inc, <vscale x 4 x i1> %mask) #0 {
; CHECK-LABEL: histogram_i64_4_lane:
; CHECK:       // %bb.0:
; CHECK-NEXT:    punpklo p1.h, p0.b
; CHECK-NEXT:    mov z4.d, x0
; CHECK-NEXT:    ptrue p2.d
; CHECK-NEXT:    histcnt z2.d, p1/z, z0.d, z0.d
; CHECK-NEXT:    ld1d { z3.d }, p1/z, [z0.d]
; CHECK-NEXT:    punpkhi p0.h, p0.b
; CHECK-NEXT:    mad z2.d, p2/m, z4.d, z3.d
; CHECK-NEXT:    st1d { z2.d }, p1, [z0.d]
; CHECK-NEXT:    histcnt z0.d, p0/z, z1.d, z1.d
; CHECK-NEXT:    ld1d { z2.d }, p0/z, [z1.d]
; CHECK-NEXT:    mad z0.d, p2/m, z4.d, z2.d
; CHECK-NEXT:    st1d { z0.d }, p0, [z1.d]
; CHECK-NEXT:    ret
  call void @llvm.experimental.vector.histogram.add.nxv4p0.i64(<vscale x 4 x ptr> %buckets, i64 %inc, <vscale x 4 x i1> %mask)
  ret void
}

define void @histogram_i64_8_lane(<vscale x 8 x ptr> %buckets, i64 %inc, <vscale x 8 x i1> %mask) #0 {
; CHECK-LABEL: histogram_i64_8_lane:
; CHECK:       // %bb.0:
; CHECK-NEXT:    punpklo p2.h, p0.b
; CHECK-NEXT:    mov z6.d, x0
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    punpklo p3.h, p2.b
; CHECK-NEXT:    punpkhi p2.h, p2.b
; CHECK-NEXT:    histcnt z4.d, p3/z, z0.d, z0.d
; CHECK-NEXT:    ld1d { z5.d }, p3/z, [z0.d]
; CHECK-NEXT:    punpkhi p0.h, p0.b
; CHECK-NEXT:    mad z4.d, p1/m, z6.d, z5.d
; CHECK-NEXT:    st1d { z4.d }, p3, [z0.d]
; CHECK-NEXT:    histcnt z0.d, p2/z, z1.d, z1.d
; CHECK-NEXT:    ld1d { z4.d }, p2/z, [z1.d]
; CHECK-NEXT:    mad z0.d, p1/m, z6.d, z4.d
; CHECK-NEXT:    st1d { z0.d }, p2, [z1.d]
; CHECK-NEXT:    punpklo p2.h, p0.b
; CHECK-NEXT:    punpkhi p0.h, p0.b
; CHECK-NEXT:    histcnt z0.d, p2/z, z2.d, z2.d
; CHECK-NEXT:    ld1d { z1.d }, p2/z, [z2.d]
; CHECK-NEXT:    mad z0.d, p1/m, z6.d, z1.d
; CHECK-NEXT:    st1d { z0.d }, p2, [z2.d]
; CHECK-NEXT:    histcnt z0.d, p0/z, z3.d, z3.d
; CHECK-NEXT:    ld1d { z1.d }, p0/z, [z3.d]
; CHECK-NEXT:    mad z0.d, p1/m, z6.d, z1.d
; CHECK-NEXT:    st1d { z0.d }, p0, [z3.d]
; CHECK-NEXT:    ret
  call void @llvm.experimental.vector.histogram.add.nxv8p0.i64(<vscale x 8 x ptr> %buckets, i64 %inc, <vscale x 8 x i1> %mask)
  ret void
}

define void @histogram_i32_8_lane(ptr %base, <vscale x 8 x i32> %indices, i32 %inc, <vscale x 8 x i1> %mask) #0 {
; CHECK-LABEL: histogram_i32_8_lane:
; CHECK:       // %bb.0:
; CHECK-NEXT:    punpklo p1.h, p0.b
; CHECK-NEXT:    mov z4.s, w1
; CHECK-NEXT:    ptrue p2.s
; CHECK-NEXT:    histcnt z2.s, p1/z, z0.s, z0.s
; CHECK-NEXT:    ld1w { z3.s }, p1/z, [x0, z0.s, sxtw #2]
; CHECK-NEXT:    punpkhi p0.h, p0.b
; CHECK-NEXT:    mad z2.s, p2/m, z4.s, z3.s
; CHECK-NEXT:    st1w { z2.s }, p1, [x0, z0.s, sxtw #2]
; CHECK-NEXT:    histcnt z0.s, p0/z, z1.s, z1.s
; CHECK-NEXT:    ld1w { z2.s }, p0/z, [x0, z1.s, sxtw #2]
; CHECK-NEXT:    mad z0.s, p2/m, z4.s, z2.s
; CHECK-NEXT:    st1w { z0.s }, p0, [x0, z1.s, sxtw #2]
; CHECK-NEXT:    ret
  %buckets = getelementptr i32, ptr %base, <vscale x 8 x i32> %indices
  call void @llvm.experimental.vector.histogram.add.nxv8p0.i32(<vscale x 8 x ptr> %buckets, i32 %inc, <vscale x 8 x i1> %mask)
  ret void
}

define void @histogram_i16_8_lane(ptr %base, <vscale x 8 x i32> %indices, i16 %inc, <vscale x 8 x i1> %mask) #0 {
; CHECK-LABEL: histogram_i16_8_lane:
; CHECK:       // %bb.0:
; CHECK-NEXT:    punpklo p1.h, p0.b
; CHECK-NEXT:    mov z4.s, w1
; CHECK-NEXT:    ptrue p2.s
; CHECK-NEXT:    histcnt z2.s, p1/z, z0.s, z0.s
; CHECK-NEXT:    ld1h { z3.s }, p1/z, [x0, z0.s, sxtw #1]
; CHECK-NEXT:    punpkhi p0.h, p0.b
; CHECK-NEXT:    mad z2.s, p2/m, z4.s, z3.s
; CHECK-NEXT:    st1h { z2.s }, p1, [x0, z0.s, sxtw #1]
; CHECK-NEXT:    histcnt z0.s, p0/z, z1.s, z1.s
; CHECK-NEXT:    ld1h { z2.s }, p0/z, [x0, z1.s, sxtw #1]
; CHECK-NEXT:    mad z0.s, p2/m, z4.s, z2.s
; CHECK-NEXT:    st1h { z0.s }, p0, [x0, z1.s, sxtw #1]
; CHECK-NEXT:    ret
  %buckets = getelementptr i16, ptr %base, <vscale x 8 x i32> %indices
  call void @llvm.experimental.vector.histogram.add.nxv8p0.i16(<vscale x 8 x ptr> %buckets, i16 %inc, <vscale x 8 x i1> %mask)
  ret void
}


attributes #0 = { "target-features"="+sve2" vscale_range(1, 16) }