	.file	"prime.c"
	.intel_syntax noprefix
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC0:
	.ascii "Enter a number: \0"
LC1:
	.ascii "%d\0"
LC2:
	.ascii "Not a prime\0"
LC3:
	.ascii "Prime\0"
	.text
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB10:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	and	esp, -16
	sub	esp, 32
	call	___main
	mov	DWORD PTR [esp+24], 0
	mov	DWORD PTR [esp], OFFSET FLAT:LC0
	call	_printf
	lea	eax, [esp+20]
	mov	DWORD PTR [esp+4], eax
	mov	DWORD PTR [esp], OFFSET FLAT:LC1
	call	_scanf
	mov	eax, DWORD PTR [esp+20]
	cmp	eax, 1
	jg	L2
	mov	DWORD PTR [esp], OFFSET FLAT:LC2
	call	_puts
	mov	eax, 0
	jmp	L10
L2:
	mov	DWORD PTR [esp+28], 2
	jmp	L4
L7:
	mov	eax, DWORD PTR [esp+20]
	cdq
	idiv	DWORD PTR [esp+28]
	mov	eax, edx
	test	eax, eax
	jne	L5
	mov	DWORD PTR [esp+24], 1
	jmp	L6
L5:
	add	DWORD PTR [esp+28], 1
L4:
	mov	eax, DWORD PTR [esp+28]
	imul	eax, DWORD PTR [esp+28]
	mov	edx, eax
	mov	eax, DWORD PTR [esp+20]
	cmp	edx, eax
	jle	L7
L6:
	cmp	DWORD PTR [esp+24], 0
	je	L8
	mov	DWORD PTR [esp], OFFSET FLAT:LC2
	call	_puts
	jmp	L9
L8:
	mov	DWORD PTR [esp], OFFSET FLAT:LC3
	call	_puts
L9:
	mov	eax, 0
L10:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE10:
	.ident	"GCC: (MinGW.org GCC-6.3.0-1) 6.3.0"
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_scanf;	.scl	2;	.type	32;	.endef
	.def	_puts;	.scl	2;	.type	32;	.endef
