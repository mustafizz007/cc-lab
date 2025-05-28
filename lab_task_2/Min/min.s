	.file	"min.c"
	.intel_syntax noprefix
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC0:
	.ascii "Enter three numbers: \0"
LC1:
	.ascii "%d %d %d\0"
LC2:
	.ascii "Minimum: %d\12\0"
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
	mov	DWORD PTR [esp], OFFSET FLAT:LC0
	call	_printf
	lea	eax, [esp+16]
	mov	DWORD PTR [esp+12], eax
	lea	eax, [esp+20]
	mov	DWORD PTR [esp+8], eax
	lea	eax, [esp+24]
	mov	DWORD PTR [esp+4], eax
	mov	DWORD PTR [esp], OFFSET FLAT:LC1
	call	_scanf
	mov	eax, DWORD PTR [esp+24]
	mov	DWORD PTR [esp+28], eax
	mov	eax, DWORD PTR [esp+20]
	cmp	eax, DWORD PTR [esp+28]
	jge	L2
	mov	eax, DWORD PTR [esp+20]
	mov	DWORD PTR [esp+28], eax
L2:
	mov	eax, DWORD PTR [esp+16]
	cmp	eax, DWORD PTR [esp+28]
	jge	L3
	mov	eax, DWORD PTR [esp+16]
	mov	DWORD PTR [esp+28], eax
L3:
	mov	eax, DWORD PTR [esp+28]
	mov	DWORD PTR [esp+4], eax
	mov	DWORD PTR [esp], OFFSET FLAT:LC2
	call	_printf
	mov	eax, 0
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE10:
	.ident	"GCC: (MinGW.org GCC-6.3.0-1) 6.3.0"
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_scanf;	.scl	2;	.type	32;	.endef
