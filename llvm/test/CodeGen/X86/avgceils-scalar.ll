; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-- | FileCheck %s --check-prefixes=X86
; RUN: llc < %s -mtriple=x86_64-- | FileCheck %s --check-prefixes=X64

;
; fixed avg(x,y) = sub(or(x,y),ashr(xor(x,y),1))
;
; ext avg(x,y) = trunc(ashr(add(sext(x),sext(y),1),1))
;

define i8 @test_fixed_i8(i8 %a0, i8 %a1) nounwind {
; X86-LABEL: test_fixed_i8:
; X86:       # %bb.0:
; X86-NEXT:    movsbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movsbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    leal 1(%ecx,%eax), %eax
; X86-NEXT:    shrl %eax
; X86-NEXT:    # kill: def $al killed $al killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: test_fixed_i8:
; X64:       # %bb.0:
; X64-NEXT:    movsbl %sil, %eax
; X64-NEXT:    movsbl %dil, %ecx
; X64-NEXT:    leal 1(%rcx,%rax), %eax
; X64-NEXT:    shrl %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
  %or = or i8 %a0, %a1
  %xor = xor i8 %a0, %a1
  %shift = ashr i8 %xor, 1
  %res = sub i8 %or, %shift
  ret i8 %res
}

define i8 @test_ext_i8(i8 %a0, i8 %a1) nounwind {
; X86-LABEL: test_ext_i8:
; X86:       # %bb.0:
; X86-NEXT:    movsbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movsbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    leal 1(%ecx,%eax), %eax
; X86-NEXT:    shrl %eax
; X86-NEXT:    # kill: def $al killed $al killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: test_ext_i8:
; X64:       # %bb.0:
; X64-NEXT:    movsbl %sil, %eax
; X64-NEXT:    movsbl %dil, %ecx
; X64-NEXT:    leal 1(%rcx,%rax), %eax
; X64-NEXT:    shrl %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
  %x0 = sext i8 %a0 to i16
  %x1 = sext i8 %a1 to i16
  %sum = add i16 %x0, %x1
  %sum1 = add i16 %sum, 1
  %shift = ashr i16 %sum1, 1
  %res = trunc i16 %shift to i8
  ret i8 %res
}

define i16 @test_fixed_i16(i16 %a0, i16 %a1) nounwind {
; X86-LABEL: test_fixed_i16:
; X86:       # %bb.0:
; X86-NEXT:    movswl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movswl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    leal 1(%ecx,%eax), %eax
; X86-NEXT:    shrl %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: test_fixed_i16:
; X64:       # %bb.0:
; X64-NEXT:    movswl %si, %eax
; X64-NEXT:    movswl %di, %ecx
; X64-NEXT:    leal 1(%rcx,%rax), %eax
; X64-NEXT:    shrl %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
  %or = or i16 %a0, %a1
  %xor = xor i16 %a0, %a1
  %shift = ashr i16 %xor, 1
  %res = sub i16 %or, %shift
  ret i16 %res
}

define i16 @test_ext_i16(i16 %a0, i16 %a1) nounwind {
; X86-LABEL: test_ext_i16:
; X86:       # %bb.0:
; X86-NEXT:    movswl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movswl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    leal 1(%ecx,%eax), %eax
; X86-NEXT:    shrl %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: test_ext_i16:
; X64:       # %bb.0:
; X64-NEXT:    movswl %si, %eax
; X64-NEXT:    movswl %di, %ecx
; X64-NEXT:    leal 1(%rcx,%rax), %eax
; X64-NEXT:    shrl %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
  %x0 = sext i16 %a0 to i32
  %x1 = sext i16 %a1 to i32
  %sum = add i32 %x0, %x1
  %sum1 = add i32 %sum, 1
  %shift = ashr i32 %sum1, 1
  %res = trunc i32 %shift to i16
  ret i16 %res
}

define i32 @test_fixed_i32(i32 %a0, i32 %a1) nounwind {
; X86-LABEL: test_fixed_i32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %edx, %eax
; X86-NEXT:    orl %ecx, %eax
; X86-NEXT:    xorl %ecx, %edx
; X86-NEXT:    sarl %edx
; X86-NEXT:    subl %edx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: test_fixed_i32:
; X64:       # %bb.0:
; X64-NEXT:    movslq %esi, %rax
; X64-NEXT:    movslq %edi, %rcx
; X64-NEXT:    leaq 1(%rcx,%rax), %rax
; X64-NEXT:    shrq %rax
; X64-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-NEXT:    retq
  %or = or i32 %a0, %a1
  %xor = xor i32 %a1, %a0
  %shift = ashr i32 %xor, 1
  %res = sub i32 %or, %shift
  ret i32 %res
}

define i32 @test_ext_i32(i32 %a0, i32 %a1) nounwind {
; X86-LABEL: test_ext_i32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %edx, %eax
; X86-NEXT:    orl %ecx, %eax
; X86-NEXT:    xorl %ecx, %edx
; X86-NEXT:    sarl %edx
; X86-NEXT:    subl %edx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: test_ext_i32:
; X64:       # %bb.0:
; X64-NEXT:    movslq %esi, %rax
; X64-NEXT:    movslq %edi, %rcx
; X64-NEXT:    leaq 1(%rcx,%rax), %rax
; X64-NEXT:    shrq %rax
; X64-NEXT:    # kill: def $eax killed $eax killed $rax
; X64-NEXT:    retq
  %x0 = sext i32 %a0 to i64
  %x1 = sext i32 %a1 to i64
  %sum = add i64 %x0, %x1
  %sum1 = add i64 %sum, 1
  %shift = ashr i64 %sum1, 1
  %res = trunc i64 %shift to i32
  ret i32 %res
}

define i64 @test_fixed_i64(i64 %a0, i64 %a1) nounwind {
; X86-LABEL: test_fixed_i64:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %eax, %edi
; X86-NEXT:    xorl %ecx, %edi
; X86-NEXT:    movl %edx, %ebx
; X86-NEXT:    xorl %esi, %ebx
; X86-NEXT:    shrdl $1, %ebx, %edi
; X86-NEXT:    orl %esi, %edx
; X86-NEXT:    sarl %ebx
; X86-NEXT:    orl %ecx, %eax
; X86-NEXT:    subl %edi, %eax
; X86-NEXT:    sbbl %ebx, %edx
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    retl
;
; X64-LABEL: test_fixed_i64:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    orq %rsi, %rax
; X64-NEXT:    xorq %rsi, %rdi
; X64-NEXT:    sarq %rdi
; X64-NEXT:    subq %rdi, %rax
; X64-NEXT:    retq
  %or = or i64 %a0, %a1
  %xor = xor i64 %a1, %a0
  %shift = ashr i64 %xor, 1
  %res = sub i64 %or, %shift
  ret i64 %res
}

define i64 @test_ext_i64(i64 %a0, i64 %a1) nounwind {
; X86-LABEL: test_ext_i64:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %eax, %edi
; X86-NEXT:    xorl %ecx, %edi
; X86-NEXT:    movl %edx, %ebx
; X86-NEXT:    xorl %esi, %ebx
; X86-NEXT:    shrdl $1, %ebx, %edi
; X86-NEXT:    orl %esi, %edx
; X86-NEXT:    sarl %ebx
; X86-NEXT:    orl %ecx, %eax
; X86-NEXT:    subl %edi, %eax
; X86-NEXT:    sbbl %ebx, %edx
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    retl
;
; X64-LABEL: test_ext_i64:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    orq %rsi, %rax
; X64-NEXT:    xorq %rsi, %rdi
; X64-NEXT:    sarq %rdi
; X64-NEXT:    subq %rdi, %rax
; X64-NEXT:    retq
  %x0 = sext i64 %a0 to i128
  %x1 = sext i64 %a1 to i128
  %sum = add i128 %x0, %x1
  %sum1 = add i128 %sum, 1
  %shift = ashr i128 %sum1, 1
  %res = trunc i128 %shift to i64
  ret i64 %res
}