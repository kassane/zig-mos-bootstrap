; RUN: llvm-mc -assemble --print-imm-hex --show-encoding -triple mos -motorola-integers --mcpu=mosspc700 < %s | FileCheck %s

 	nop                         ; CHECK: encoding: [0x00]
 	bpl $ea                     ; CHECK: encoding: [0x10,0xea]
 	clrp                        ; CHECK: encoding: [0x20]
 	bmi $ea                     ; CHECK: encoding: [0x30,0xea]
 	setp                        ; CHECK: encoding: [0x40]
 	bvc $ea                     ; CHECK: encoding: [0x50,0xea]
 	clrc                        ; CHECK: encoding: [0x60]
 	bvs $ea                     ; CHECK: encoding: [0x70,0xea]
 	setc                        ; CHECK: encoding: [0x80]
 	bcc $ea                     ; CHECK: encoding: [0x90,0xea]
 	ei                          ; CHECK: encoding: [0xa0]
 	bcs $ea                     ; CHECK: encoding: [0xb0,0xea]
 	di                          ; CHECK: encoding: [0xc0]
 	bne $ea                     ; CHECK: encoding: [0xd0,0xea]
 	clrv                        ; CHECK: encoding: [0xe0]
 	beq $ea                     ; CHECK: encoding: [0xf0,0xea]
	tcall 0                     ; CHECK: encoding: [0x01]
	tcall 1                     ; CHECK: encoding: [0x11]
	tcall 2                     ; CHECK: encoding: [0x21]
	tcall 3                     ; CHECK: encoding: [0x31]
	tcall 4                     ; CHECK: encoding: [0x41]
	tcall 5                     ; CHECK: encoding: [0x51]
	tcall 6                     ; CHECK: encoding: [0x61]
	tcall 7                     ; CHECK: encoding: [0x71]
	tcall 8                     ; CHECK: encoding: [0x81]
	tcall 9                     ; CHECK: encoding: [0x91]
	tcall 10                    ; CHECK: encoding: [0xa1]
	tcall 11                    ; CHECK: encoding: [0xb1]
	tcall 12                    ; CHECK: encoding: [0xc1]
	tcall 13                    ; CHECK: encoding: [0xd1]
	tcall 14                    ; CHECK: encoding: [0xe1]
	tcall 15                    ; CHECK: encoding: [0xf1]
	set1 $ea.0                  ; CHECK: encoding: [0x02,0xea]
	clr1 $ea.0                  ; CHECK: encoding: [0x12,0xea]
	set1 $ea.1                  ; CHECK: encoding: [0x22,0xea]
	clr1 $ea.1                  ; CHECK: encoding: [0x32,0xea]
	set1 $ea.2                  ; CHECK: encoding: [0x42,0xea]
	clr1 $ea.2                  ; CHECK: encoding: [0x52,0xea]
	set1 $ea.3                  ; CHECK: encoding: [0x62,0xea]
	clr1 $ea.3                  ; CHECK: encoding: [0x72,0xea]
	set1 $ea.4                  ; CHECK: encoding: [0x82,0xea]
	clr1 $ea.4                  ; CHECK: encoding: [0x92,0xea]
	set1 $ea.5                  ; CHECK: encoding: [0xa2,0xea]
	clr1 $ea.5                  ; CHECK: encoding: [0xb2,0xea]
	set1 $ea.6                  ; CHECK: encoding: [0xc2,0xea]
	clr1 $ea.6                  ; CHECK: encoding: [0xd2,0xea]
	set1 $ea.7                  ; CHECK: encoding: [0xe2,0xea]
	clr1 $ea.7                  ; CHECK: encoding: [0xf2,0xea]
	bbs $ea.0, $ea              ; CHECK: encoding: [0x03,0xea,0xea]
	bbc $ea.0, $ea              ; CHECK: encoding: [0x13,0xea,0xea]
	bbs $ea.1, $ea              ; CHECK: encoding: [0x23,0xea,0xea]
	bbc $ea.1, $ea              ; CHECK: encoding: [0x33,0xea,0xea]
	bbs $ea.2, $ea              ; CHECK: encoding: [0x43,0xea,0xea]
	bbc $ea.2, $ea              ; CHECK: encoding: [0x53,0xea,0xea]
	bbs $ea.3, $ea              ; CHECK: encoding: [0x63,0xea,0xea]
	bbc $ea.3, $ea              ; CHECK: encoding: [0x73,0xea,0xea]
	bbs $ea.4, $ea              ; CHECK: encoding: [0x83,0xea,0xea]
	bbc $ea.4, $ea              ; CHECK: encoding: [0x93,0xea,0xea]
	bbs $ea.5, $ea              ; CHECK: encoding: [0xa3,0xea,0xea]
	bbc $ea.5, $ea              ; CHECK: encoding: [0xb3,0xea,0xea]
	bbs $ea.6, $ea              ; CHECK: encoding: [0xc3,0xea,0xea]
	bbc $ea.6, $ea              ; CHECK: encoding: [0xd3,0xea,0xea]
	bbs $ea.7, $ea              ; CHECK: encoding: [0xe3,0xea,0xea]
	bbc $ea.7, $ea              ; CHECK: encoding: [0xf3,0xea,0xea]
	or a, $ea                   ; CHECK: encoding: [0x04,0xea]
	or a, $ea+x                 ; CHECK: encoding: [0x14,0xea]
	and a, $ea                  ; CHECK: encoding: [0x24,0xea]
	and a, $ea+x                ; CHECK: encoding: [0x34,0xea]
	eor a, $ea                  ; CHECK: encoding: [0x44,0xea]
	eor a, $ea+x                ; CHECK: encoding: [0x54,0xea]
	cmp a, $ea                  ; CHECK: encoding: [0x64,0xea]
	cmp a, $ea+x                ; CHECK: encoding: [0x74,0xea]
	adc a, $ea                  ; CHECK: encoding: [0x84,0xea]
	adc a, $ea+x                ; CHECK: encoding: [0x94,0xea]
	sbc a, $ea                  ; CHECK: encoding: [0xa4,0xea]
	sbc a, $ea+x                ; CHECK: encoding: [0xb4,0xea]
	mov $ea, a                  ; CHECK: encoding: [0xc4,0xea]
	mov $ea+x, a                ; CHECK: encoding: [0xd4,0xea]
	mov a, $ea                  ; CHECK: encoding: [0xe4,0xea]
	mov a, $ea+x                ; CHECK: encoding: [0xf4,0xea]
	or a, $eaea                 ; CHECK: encoding: [0x05,0xea,0xea]
	or a, $eaea+x               ; CHECK: encoding: [0x15,0xea,0xea]
	and a, $eaea                ; CHECK: encoding: [0x25,0xea,0xea]
	and a, $eaea+x              ; CHECK: encoding: [0x35,0xea,0xea]
	eor a, $eaea                ; CHECK: encoding: [0x45,0xea,0xea]
	eor a, $eaea+x              ; CHECK: encoding: [0x55,0xea,0xea]
	cmp a, $eaea                ; CHECK: encoding: [0x65,0xea,0xea]
	cmp a, $eaea+x              ; CHECK: encoding: [0x75,0xea,0xea]
	adc a, $eaea                ; CHECK: encoding: [0x85,0xea,0xea]
	adc a, $eaea+x              ; CHECK: encoding: [0x95,0xea,0xea]
	sbc a, $eaea                ; CHECK: encoding: [0xa5,0xea,0xea]
	sbc a, $eaea+x              ; CHECK: encoding: [0xb5,0xea,0xea]
	mov $eaea, a                ; CHECK: encoding: [0xc5,0xea,0xea]
	mov $eaea+x, a              ; CHECK: encoding: [0xd5,0xea,0xea]
	mov a, $eaea                ; CHECK: encoding: [0xe5,0xea,0xea]
	mov a, $eaea+x              ; CHECK: encoding: [0xf5,0xea,0xea]
	or a, (x)                   ; CHECK: encoding: [0x06]
	or a, $eaea+y               ; CHECK: encoding: [0x16,0xea,0xea]
	and a, (x)                  ; CHECK: encoding: [0x26]
	and a, $eaea+y              ; CHECK: encoding: [0x36,0xea,0xea]
	eor a, (x)                  ; CHECK: encoding: [0x46]
	eor a, $eaea+y              ; CHECK: encoding: [0x56,0xea,0xea]
	cmp a, (x)                  ; CHECK: encoding: [0x66]
	cmp a, $eaea+y              ; CHECK: encoding: [0x76,0xea,0xea]
	adc a, (x)                  ; CHECK: encoding: [0x86]
	adc a, $eaea+y              ; CHECK: encoding: [0x96,0xea,0xea]
	sbc a, (x)                  ; CHECK: encoding: [0xa6]
	sbc a, $eaea+y              ; CHECK: encoding: [0xb6,0xea,0xea]
	mov (x), a                  ; CHECK: encoding: [0xc6]
	mov $eaea+y, a              ; CHECK: encoding: [0xd6,0xea,0xea]
	mov a, (x)                  ; CHECK: encoding: [0xe6]
	mov a, $eaea+y              ; CHECK: encoding: [0xf6,0xea,0xea]
	or a, [$ea+x]               ; CHECK: encoding: [0x07,0xea]
	or a, [$ea]+y               ; CHECK: encoding: [0x17,0xea]
	and a, [$ea+x]              ; CHECK: encoding: [0x27,0xea]
	and a, [$ea]+y              ; CHECK: encoding: [0x37,0xea]
	eor a, [$ea+x]              ; CHECK: encoding: [0x47,0xea]
	eor a, [$ea]+y              ; CHECK: encoding: [0x57,0xea]
	cmp a, [$ea+x]              ; CHECK: encoding: [0x67,0xea]
	cmp a, [$ea]+y              ; CHECK: encoding: [0x77,0xea]
	adc a, [$ea+x]              ; CHECK: encoding: [0x87,0xea]
	adc a, [$ea]+y              ; CHECK: encoding: [0x97,0xea]
	sbc a, [$ea+x]              ; CHECK: encoding: [0xa7,0xea]
	sbc a, [$ea]+y              ; CHECK: encoding: [0xb7,0xea]
	mov [$ea+x], a              ; CHECK: encoding: [0xc7,0xea]
	mov [$ea]+y, a              ; CHECK: encoding: [0xd7,0xea]
	mov a, [$ea+x]              ; CHECK: encoding: [0xe7,0xea]
	mov a, [$ea]+y              ; CHECK: encoding: [0xf7,0xea]
	or a, #$ea                  ; CHECK: encoding: [0x08,0xea]
	or $ea, #$ea                ; CHECK: encoding: [0x18,0xea,0xea]
	and a, #$ea                 ; CHECK: encoding: [0x28,0xea]
	and $ea, #$ea               ; CHECK: encoding: [0x38,0xea,0xea]
	eor a, #$ea                 ; CHECK: encoding: [0x48,0xea]
	eor $ea, #$ea               ; CHECK: encoding: [0x58,0xea,0xea]
	cmp a, #$ea                 ; CHECK: encoding: [0x68,0xea]
	cmp $ea, #$ea               ; CHECK: encoding: [0x78,0xea,0xea]
	adc a, #$ea                 ; CHECK: encoding: [0x88,0xea]
	adc $ea, #$ea               ; CHECK: encoding: [0x98,0xea,0xea]
	sbc a, #$ea                 ; CHECK: encoding: [0xa8,0xea]
	sbc $ea, #$ea               ; CHECK: encoding: [0xb8,0xea,0xea]
	cmp x, #$ea                 ; CHECK: encoding: [0xc8,0xea]
	mov $ea, x                  ; CHECK: encoding: [0xd8,0xea]
	mov a, #$ea                 ; CHECK: encoding: [0xe8,0xea]
	mov x, $ea                  ; CHECK: encoding: [0xf8,0xea]
	or $ea, $ea                 ; CHECK: encoding: [0x09,0xea,0xea]
	or (x), (y)                 ; CHECK: encoding: [0x19]
	and $ea, $ea                ; CHECK: encoding: [0x29,0xea,0xea]
	and (x), (y)                ; CHECK: encoding: [0x39]
	eor $ea, $ea                ; CHECK: encoding: [0x49,0xea,0xea]
	eor (x), (y)                ; CHECK: encoding: [0x59]
	cmp $ea, $ea                ; CHECK: encoding: [0x69,0xea,0xea]
	cmp (x), (y)                ; CHECK: encoding: [0x79]
	adc $ea, $ea                ; CHECK: encoding: [0x89,0xea,0xea]
	adc (x), (y)                ; CHECK: encoding: [0x99]
	sbc $ea, $ea                ; CHECK: encoding: [0xa9,0xea,0xea]
	sbc (x), (y)                ; CHECK: encoding: [0xb9]
	mov $eaea, x                ; CHECK: encoding: [0xc9,0xea,0xea]
	mov $ea+y, x                ; CHECK: encoding: [0xd9,0xea]
	mov x, $eaea                ; CHECK: encoding: [0xe9,0xea,0xea]
	mov x, $ea+y                ; CHECK: encoding: [0xf9,0xea]
	or1 c, $0aea.7              ; CHECK: encoding: [0x0a,0xea,0xea]
	decw $ea                    ; CHECK: encoding: [0x1a,0xea]
	or1 c, /$0aea.7             ; CHECK: encoding: [0x2a,0xea,0xea]
	incw $ea                    ; CHECK: encoding: [0x3a,0xea]
	and1 c, $0aea.7             ; CHECK: encoding: [0x4a,0xea,0xea]
	cmpw ya, $ea                ; CHECK: encoding: [0x5a,0xea]
	and1 c, /$0aea.7            ; CHECK: encoding: [0x6a,0xea,0xea]
	addw ya, $ea                ; CHECK: encoding: [0x7a,0xea]
	eor1 c, $0aea.7             ; CHECK: encoding: [0x8a,0xea,0xea]
	subw ya, $ea                ; CHECK: encoding: [0x9a,0xea]
	mov1 c, $0aea.7             ; CHECK: encoding: [0xaa,0xea,0xea]
	movw ya, $ea                ; CHECK: encoding: [0xba,0xea]
	mov1 $0aea.7, c             ; CHECK: encoding: [0xca,0xea,0xea]
	movw $ea, ya                ; CHECK: encoding: [0xda,0xea]
	not1 $0aea.7                ; CHECK: encoding: [0xea,0xea,0xea]
	mov $ea, $ea                ; CHECK: encoding: [0xfa,0xea,0xea]
	asl $ea                     ; CHECK: encoding: [0x0b,0xea]
	asl $ea+x                   ; CHECK: encoding: [0x1b,0xea]
	rol $ea                     ; CHECK: encoding: [0x2b,0xea]
	rol $ea+x                   ; CHECK: encoding: [0x3b,0xea]
	lsr $ea                     ; CHECK: encoding: [0x4b,0xea]
	lsr $ea+x                   ; CHECK: encoding: [0x5b,0xea]
	ror $ea                     ; CHECK: encoding: [0x6b,0xea]
	ror $ea+x                   ; CHECK: encoding: [0x7b,0xea]
	dec $ea                     ; CHECK: encoding: [0x8b,0xea]
	dec $ea+x                   ; CHECK: encoding: [0x9b,0xea]
	inc $ea                     ; CHECK: encoding: [0xab,0xea]
	inc $ea+x                   ; CHECK: encoding: [0xbb,0xea]
	mov $ea, y                  ; CHECK: encoding: [0xcb,0xea]
	mov $ea+x, y                ; CHECK: encoding: [0xdb,0xea]
	mov y, $ea                  ; CHECK: encoding: [0xeb,0xea]
	mov y, $ea+x                ; CHECK: encoding: [0xfb,0xea]
	asl $eaea                   ; CHECK: encoding: [0x0c,0xea,0xea]
	asl a                       ; CHECK: encoding: [0x1c]
	rol $eaea                   ; CHECK: encoding: [0x2c,0xea,0xea]
	rol a                       ; CHECK: encoding: [0x3c]
	lsr $eaea                   ; CHECK: encoding: [0x4c,0xea,0xea]
	lsr a                       ; CHECK: encoding: [0x5c]
	ror $eaea                   ; CHECK: encoding: [0x6c,0xea,0xea]
	ror a                       ; CHECK: encoding: [0x7c]
	dec $eaea                   ; CHECK: encoding: [0x8c,0xea,0xea]
	dec a                       ; CHECK: encoding: [0x9c]
	inc $eaea                   ; CHECK: encoding: [0xac,0xea,0xea]
	inc a                       ; CHECK: encoding: [0xbc]
	mov $eaea, y                ; CHECK: encoding: [0xcc,0xea,0xea]
	dec y                       ; CHECK: encoding: [0xdc]
	mov y, $eaea                ; CHECK: encoding: [0xec,0xea,0xea]
	inc y                       ; CHECK: encoding: [0xfc]
	push psw                    ; CHECK: encoding: [0x0d]
	dec x                       ; CHECK: encoding: [0x1d]
	push a                      ; CHECK: encoding: [0x2d]
	inc x                       ; CHECK: encoding: [0x3d]
	push x                      ; CHECK: encoding: [0x4d]
	mov x, a                    ; CHECK: encoding: [0x5d]
	push y                      ; CHECK: encoding: [0x6d]
	mov a, x                    ; CHECK: encoding: [0x7d]
	mov y, #$ea                 ; CHECK: encoding: [0x8d,0xea]
	mov x, sp                   ; CHECK: encoding: [0x9d]
	cmp y, #$ea                 ; CHECK: encoding: [0xad,0xea]
	mov sp, x                   ; CHECK: encoding: [0xbd]
	mov x, #$ea                 ; CHECK: encoding: [0xcd,0xea]
	mov a, y                    ; CHECK: encoding: [0xdd]
	notc                        ; CHECK: encoding: [0xed]
	mov y, a                    ; CHECK: encoding: [0xfd]
	tset1 $eaea                 ; CHECK: encoding: [0x0e,0xea,0xea]
	cmp x, $eaea                ; CHECK: encoding: [0x1e,0xea,0xea]
	cbne $ea, $ea               ; CHECK: encoding: [0x2e,0xea,0xea]
	cmp x, $ea                  ; CHECK: encoding: [0x3e,0xea]
	tclr1 $eaea                 ; CHECK: encoding: [0x4e,0xea,0xea]
	cmp y, $eaea                ; CHECK: encoding: [0x5e,0xea,0xea]
	dbnz $ea, $ea               ; CHECK: encoding: [0x6e,0xea,0xea]
	cmp y, $ea                  ; CHECK: encoding: [0x7e,0xea]
	pop psw                     ; CHECK: encoding: [0x8e]
	div ya, x                   ; CHECK: encoding: [0x9e]
	pop a                       ; CHECK: encoding: [0xae]
	das a                       ; CHECK: encoding: [0xbe]
	pop x                       ; CHECK: encoding: [0xce]
	cbne $ea+x, $ea             ; CHECK: encoding: [0xde,0xea,0xea]
	pop y                       ; CHECK: encoding: [0xee]
	dbnz y, $ea                 ; CHECK: encoding: [0xfe,0xea]
	brk                         ; CHECK: encoding: [0x0f]
	jmp [$eaea+x]               ; CHECK: encoding: [0x1f,0xea,0xea]
	bra $ea                     ; CHECK: encoding: [0x2f,0xea]
	call $eaea                  ; CHECK: encoding: [0x3f,0xea,0xea]
	pcall $ea                   ; CHECK: encoding: [0x4f,0xea]
	jmp $eaea                   ; CHECK: encoding: [0x5f,0xea,0xea]
	ret                         ; CHECK: encoding: [0x6f]
	reti                        ; CHECK: encoding: [0x7f]
	mov $ea, #$ea               ; CHECK: encoding: [0x8f,0xea,0xea]
	xcn a                       ; CHECK: encoding: [0x9f]
	mov (x)+, a                 ; CHECK: encoding: [0xaf]
	mov a, (x)+                 ; CHECK: encoding: [0xbf]
	mul ya                      ; CHECK: encoding: [0xcf]
	daa a                       ; CHECK: encoding: [0xdf]
	sleep                       ; CHECK: encoding: [0xef]
	stop                        ; CHECK: encoding: [0xff]
