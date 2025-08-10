	.file	"palindrome.c"
	.intel_syntax noprefix
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC0:
	.ascii "Enter a string: \0"
LC1:
	.ascii "%s\0"
LC2:
	.ascii "Palindrome\0"
LC3:
	.ascii "Not a palindrome\0"
	.text
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB13:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	and	esp, -16
	add	esp, -128
	call	___main
	mov	DWORD PTR [esp+120], 1
	mov	DWORD PTR [esp], OFFSET FLAT:LC0
	call	_printf
	lea	eax, [esp+16]
	mov	DWORD PTR [esp+4], eax
	mov	DWORD PTR [esp], OFFSET FLAT:LC1
	call	_scanf
	lea	eax, [esp+16]
	mov	DWORD PTR [esp], eax
	call	_strlen
	mov	DWORD PTR [esp+116], eax
	mov	DWORD PTR [esp+124], 0
	jmp	L2
L5:
	lea	edx, [esp+16]
	mov	eax, DWORD PTR [esp+124]
	add	eax, edx
	movzx	edx, BYTE PTR [eax]
	mov	eax, DWORD PTR [esp+116]
	sub	eax, DWORD PTR [esp+124]
	sub	eax, 1
	movzx	eax, BYTE PTR [esp+16+eax]
	cmp	dl, al
	je	L3
	mov	DWORD PTR [esp+120], 0
	jmp	L4
L3:
	add	DWORD PTR [esp+124], 1
L2:
	mov	eax, DWORD PTR [esp+116]
	mov	edx, eax
	shr	edx, 31
	add	eax, edx
	sar	eax
	cmp	eax, DWORD PTR [esp+124]
	jg	L5
L4:
	cmp	DWORD PTR [esp+120], 0
	je	L6
	mov	DWORD PTR [esp], OFFSET FLAT:LC2
	call	_puts
	jmp	L7
L6:
	mov	DWORD PTR [esp], OFFSET FLAT:LC3
	call	_puts
L7:
	mov	eax, 0
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE13:
	.ident	"GCC: (MinGW.org GCC-6.3.0-1) 6.3.0"
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_scanf;	.scl	2;	.type	32;	.endef
	.def	_strlen;	.scl	2;	.type	32;	.endef
	.def	_puts;	.scl	2;	.type	32;	.endef
