# RUN: llvm-mc -triple x86_64 --show-encoding %s | FileCheck %s
# RUN: not llvm-mc -triple i386 -show-encoding %s 2>&1 | FileCheck %s --check-prefix=ERROR

# ERROR-COUNT-56: error:
# ERROR-NOT: error:

## mulx

# CHECK: {evex}	mulxl	%ecx, %edx, %r10d
# CHECK: encoding: [0x62,0x72,0x6f,0x08,0xf6,0xd1]
         {evex}	mulxl	%ecx, %edx, %r10d

# CHECK: {evex}	mulxq	%r9, %r15, %r11
# CHECK: encoding: [0x62,0x52,0x87,0x08,0xf6,0xd9]
         {evex}	mulxq	%r9, %r15, %r11

# CHECK: {evex}	mulxl	123(%rax,%rbx,4), %ecx, %edx
# CHECK: encoding: [0x62,0xf2,0x77,0x08,0xf6,0x94,0x98,0x7b,0x00,0x00,0x00]
         {evex}	mulxl	123(%rax,%rbx,4), %ecx, %edx

# CHECK: {evex}	mulxq	123(%rax,%rbx,4), %r9, %r15
# CHECK: encoding: [0x62,0x72,0xb7,0x08,0xf6,0xbc,0x98,0x7b,0x00,0x00,0x00]
         {evex}	mulxq	123(%rax,%rbx,4), %r9, %r15

# CHECK: mulxl	%r18d, %r22d, %r26d
# CHECK: encoding: [0x62,0x6a,0x4f,0x00,0xf6,0xd2]
         mulxl	%r18d, %r22d, %r26d

# CHECK: mulxq	%r19, %r23, %r27
# CHECK: encoding: [0x62,0x6a,0xc7,0x00,0xf6,0xdb]
         mulxq	%r19, %r23, %r27

# CHECK: mulxl	291(%r28,%r29,4), %r18d, %r22d
# CHECK: encoding: [0x62,0x8a,0x6b,0x00,0xf6,0xb4,0xac,0x23,0x01,0x00,0x00]
         mulxl	291(%r28,%r29,4), %r18d, %r22d

# CHECK: mulxq	291(%r28,%r29,4), %r19, %r23
# CHECK: encoding: [0x62,0x8a,0xe3,0x00,0xf6,0xbc,0xac,0x23,0x01,0x00,0x00]
         mulxq	291(%r28,%r29,4), %r19, %r23

## pdep

# CHECK: {evex}	pdepl	%ecx, %edx, %r10d
# CHECK: encoding: [0x62,0x72,0x6f,0x08,0xf5,0xd1]
         {evex}	pdepl	%ecx, %edx, %r10d

# CHECK: {evex}	pdepq	%r9, %r15, %r11
# CHECK: encoding: [0x62,0x52,0x87,0x08,0xf5,0xd9]
         {evex}	pdepq	%r9, %r15, %r11

# CHECK: {evex}	pdepl	123(%rax,%rbx,4), %ecx, %edx
# CHECK: encoding: [0x62,0xf2,0x77,0x08,0xf5,0x54,0x98,0x7b]
         {evex}	pdepl	123(%rax,%rbx,4), %ecx, %edx

# CHECK: {evex}	pdepq	123(%rax,%rbx,4), %r9, %r15
# CHECK: encoding: [0x62,0x72,0xb7,0x08,0xf5,0x7c,0x98,0x7b]
         {evex}	pdepq	123(%rax,%rbx,4), %r9, %r15

# CHECK: pdepl	%r18d, %r22d, %r26d
# CHECK: encoding: [0x62,0x6a,0x4f,0x00,0xf5,0xd2]
         pdepl	%r18d, %r22d, %r26d

# CHECK: pdepq	%r19, %r23, %r27
# CHECK: encoding: [0x62,0x6a,0xc7,0x00,0xf5,0xdb]
         pdepq	%r19, %r23, %r27

# CHECK: pdepl	291(%r28,%r29,4), %r18d, %r22d
# CHECK: encoding: [0x62,0x8a,0x6b,0x00,0xf5,0xb4,0xac,0x23,0x01,0x00,0x00]
         pdepl	291(%r28,%r29,4), %r18d, %r22d

# CHECK: pdepq	291(%r28,%r29,4), %r19, %r23
# CHECK: encoding: [0x62,0x8a,0xe3,0x00,0xf5,0xbc,0xac,0x23,0x01,0x00,0x00]
         pdepq	291(%r28,%r29,4), %r19, %r23

## pext

# CHECK: {evex}	pextl	%ecx, %edx, %r10d
# CHECK: encoding: [0x62,0x72,0x6e,0x08,0xf5,0xd1]
         {evex}	pextl	%ecx, %edx, %r10d

# CHECK: {evex}	pextq	%r9, %r15, %r11
# CHECK: encoding: [0x62,0x52,0x86,0x08,0xf5,0xd9]
         {evex}	pextq	%r9, %r15, %r11

# CHECK: {evex}	pextl	123(%rax,%rbx,4), %ecx, %edx
# CHECK: encoding: [0x62,0xf2,0x76,0x08,0xf5,0x54,0x98,0x7b]
         {evex}	pextl	123(%rax,%rbx,4), %ecx, %edx

# CHECK: {evex}	pextq	123(%rax,%rbx,4), %r9, %r15
# CHECK: encoding: [0x62,0x72,0xb6,0x08,0xf5,0x7c,0x98,0x7b]
         {evex}	pextq	123(%rax,%rbx,4), %r9, %r15

# CHECK: pextl	%r18d, %r22d, %r26d
# CHECK: encoding: [0x62,0x6a,0x4e,0x00,0xf5,0xd2]
         pextl	%r18d, %r22d, %r26d

# CHECK: pextq	%r19, %r23, %r27
# CHECK: encoding: [0x62,0x6a,0xc6,0x00,0xf5,0xdb]
         pextq	%r19, %r23, %r27

# CHECK: pextl	291(%r28,%r29,4), %r18d, %r22d
# CHECK: encoding: [0x62,0x8a,0x6a,0x00,0xf5,0xb4,0xac,0x23,0x01,0x00,0x00]
         pextl	291(%r28,%r29,4), %r18d, %r22d

# CHECK: pextq	291(%r28,%r29,4), %r19, %r23
# CHECK: encoding: [0x62,0x8a,0xe2,0x00,0xf5,0xbc,0xac,0x23,0x01,0x00,0x00]
         pextq	291(%r28,%r29,4), %r19, %r23

## rorx

# CHECK: {evex}	rorxl	$123, %ecx, %edx
# CHECK: encoding: [0x62,0xf3,0x7f,0x08,0xf0,0xd1,0x7b]
         {evex}	rorxl	$123, %ecx, %edx

# CHECK: {evex}	rorxq	$123, %r9, %r15
# CHECK: encoding: [0x62,0x53,0xff,0x08,0xf0,0xf9,0x7b]
         {evex}	rorxq	$123, %r9, %r15

# CHECK: {evex}	rorxl	$123, 123(%rax,%rbx,4), %ecx
# CHECK: encoding: [0x62,0xf3,0x7f,0x08,0xf0,0x8c,0x98,0x7b,0x00,0x00,0x00,0x7b]
         {evex}	rorxl	$123, 123(%rax,%rbx,4), %ecx

# CHECK: {evex}	rorxq	$123, 123(%rax,%rbx,4), %r9
# CHECK: encoding: [0x62,0x73,0xff,0x08,0xf0,0x8c,0x98,0x7b,0x00,0x00,0x00,0x7b]
         {evex}	rorxq	$123, 123(%rax,%rbx,4), %r9

# CHECK: rorxl	$123, %r18d, %r22d
# CHECK: encoding: [0x62,0xeb,0x7f,0x08,0xf0,0xf2,0x7b]
         rorxl	$123, %r18d, %r22d

# CHECK: rorxq	$123, %r19, %r23
# CHECK: encoding: [0x62,0xeb,0xff,0x08,0xf0,0xfb,0x7b]
         rorxq	$123, %r19, %r23

# CHECK: rorxl	$123, 291(%r28,%r29,4), %r18d
# CHECK: encoding: [0x62,0x8b,0x7b,0x08,0xf0,0x94,0xac,0x23,0x01,0x00,0x00,0x7b]
         rorxl	$123, 291(%r28,%r29,4), %r18d

# CHECK: rorxq	$123, 291(%r28,%r29,4), %r19
# CHECK: encoding: [0x62,0x8b,0xfb,0x08,0xf0,0x9c,0xac,0x23,0x01,0x00,0x00,0x7b]
         rorxq	$123, 291(%r28,%r29,4), %r19

## sarx

# CHECK: {evex}	sarxl	%ecx, %edx, %r10d
# CHECK: encoding: [0x62,0x72,0x76,0x08,0xf7,0xd2]
         {evex}	sarxl	%ecx, %edx, %r10d

# CHECK: {evex}	sarxl	%ecx, 123(%rax,%rbx,4), %edx
# CHECK: encoding: [0x62,0xf2,0x76,0x08,0xf7,0x94,0x98,0x7b,0x00,0x00,0x00]
         {evex}	sarxl	%ecx, 123(%rax,%rbx,4), %edx

# CHECK: {evex}	sarxq	%r9, %r15, %r11
# CHECK: encoding: [0x62,0x52,0xb6,0x08,0xf7,0xdf]
         {evex}	sarxq	%r9, %r15, %r11

# CHECK: {evex}	sarxq	%r9, 123(%rax,%rbx,4), %r15
# CHECK: encoding: [0x62,0x72,0xb6,0x08,0xf7,0xbc,0x98,0x7b,0x00,0x00,0x00]
         {evex}	sarxq	%r9, 123(%rax,%rbx,4), %r15

# CHECK: sarxl	%r18d, %r22d, %r26d
# CHECK: encoding: [0x62,0x6a,0x6e,0x00,0xf7,0xd6]
         sarxl	%r18d, %r22d, %r26d

# CHECK: sarxl	%r18d, 291(%r28,%r29,4), %r22d
# CHECK: encoding: [0x62,0x8a,0x6a,0x00,0xf7,0xb4,0xac,0x23,0x01,0x00,0x00]
         sarxl	%r18d, 291(%r28,%r29,4), %r22d

# CHECK: sarxq	%r19, %r23, %r27
# CHECK: encoding: [0x62,0x6a,0xe6,0x00,0xf7,0xdf]
         sarxq	%r19, %r23, %r27

# CHECK: sarxq	%r19, 291(%r28,%r29,4), %r23
# CHECK: encoding: [0x62,0x8a,0xe2,0x00,0xf7,0xbc,0xac,0x23,0x01,0x00,0x00]
         sarxq	%r19, 291(%r28,%r29,4), %r23

## shlx

# CHECK: {evex}	shlxl	%ecx, %edx, %r10d
# CHECK: encoding: [0x62,0x72,0x75,0x08,0xf7,0xd2]
         {evex}	shlxl	%ecx, %edx, %r10d

# CHECK: {evex}	shlxl	%ecx, 123(%rax,%rbx,4), %edx
# CHECK: encoding: [0x62,0xf2,0x75,0x08,0xf7,0x94,0x98,0x7b,0x00,0x00,0x00]
         {evex}	shlxl	%ecx, 123(%rax,%rbx,4), %edx

# CHECK: {evex}	shlxq	%r9, %r15, %r11
# CHECK: encoding: [0x62,0x52,0xb5,0x08,0xf7,0xdf]
         {evex}	shlxq	%r9, %r15, %r11

# CHECK: {evex}	shlxq	%r9, 123(%rax,%rbx,4), %r15
# CHECK: encoding: [0x62,0x72,0xb5,0x08,0xf7,0xbc,0x98,0x7b,0x00,0x00,0x00]
         {evex}	shlxq	%r9, 123(%rax,%rbx,4), %r15

# CHECK: shlxl	%r18d, %r22d, %r26d
# CHECK: encoding: [0x62,0x6a,0x6d,0x00,0xf7,0xd6]
         shlxl	%r18d, %r22d, %r26d

# CHECK: shlxl	%r18d, 291(%r28,%r29,4), %r22d
# CHECK: encoding: [0x62,0x8a,0x69,0x00,0xf7,0xb4,0xac,0x23,0x01,0x00,0x00]
         shlxl	%r18d, 291(%r28,%r29,4), %r22d

# CHECK: shlxq	%r19, %r23, %r27
# CHECK: encoding: [0x62,0x6a,0xe5,0x00,0xf7,0xdf]
         shlxq	%r19, %r23, %r27

# CHECK: shlxq	%r19, 291(%r28,%r29,4), %r23
# CHECK: encoding: [0x62,0x8a,0xe1,0x00,0xf7,0xbc,0xac,0x23,0x01,0x00,0x00]
         shlxq	%r19, 291(%r28,%r29,4), %r23

## shrx

# CHECK: {evex}	shrxl	%ecx, %edx, %r10d
# CHECK: encoding: [0x62,0x72,0x77,0x08,0xf7,0xd2]
         {evex}	shrxl	%ecx, %edx, %r10d

# CHECK: {evex}	shrxl	%ecx, 123(%rax,%rbx,4), %edx
# CHECK: encoding: [0x62,0xf2,0x77,0x08,0xf7,0x94,0x98,0x7b,0x00,0x00,0x00]
         {evex}	shrxl	%ecx, 123(%rax,%rbx,4), %edx

# CHECK: {evex}	shrxq	%r9, %r15, %r11
# CHECK: encoding: [0x62,0x52,0xb7,0x08,0xf7,0xdf]
         {evex}	shrxq	%r9, %r15, %r11

# CHECK: {evex}	shrxq	%r9, 123(%rax,%rbx,4), %r15
# CHECK: encoding: [0x62,0x72,0xb7,0x08,0xf7,0xbc,0x98,0x7b,0x00,0x00,0x00]
         {evex}	shrxq	%r9, 123(%rax,%rbx,4), %r15

# CHECK: shrxl	%r18d, %r22d, %r26d
# CHECK: encoding: [0x62,0x6a,0x6f,0x00,0xf7,0xd6]
         shrxl	%r18d, %r22d, %r26d

# CHECK: shrxl	%r18d, 291(%r28,%r29,4), %r22d
# CHECK: encoding: [0x62,0x8a,0x6b,0x00,0xf7,0xb4,0xac,0x23,0x01,0x00,0x00]
         shrxl	%r18d, 291(%r28,%r29,4), %r22d

# CHECK: shrxq	%r19, %r23, %r27
# CHECK: encoding: [0x62,0x6a,0xe7,0x00,0xf7,0xdf]
         shrxq	%r19, %r23, %r27

# CHECK: shrxq	%r19, 291(%r28,%r29,4), %r23
# CHECK: encoding: [0x62,0x8a,0xe3,0x00,0xf7,0xbc,0xac,0x23,0x01,0x00,0x00]
         shrxq	%r19, 291(%r28,%r29,4), %r23
