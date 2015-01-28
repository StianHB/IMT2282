	.section	__TEXT,__text,regular,pure_instructions
	.globl	_writeloop
	.align	4, 0x90
_writeloop:                             ## @writeloop
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp2:
	.cfi_def_cfa_offset 16
Ltmp3:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp4:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	$0, -16(%rbp)
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	cmpl	$30, _g_ant(%rip)
	jge	LBB0_5
## BB#2:                                ##   in Loop: Header=BB0_1 Depth=1
	movabsq	$100000, %rax           ## imm = 0x186A0
	movq	-16(%rbp), %rcx
	addq	$1, %rcx
	movq	%rcx, -16(%rbp)
	movq	%rax, -24(%rbp)         ## 8-byte Spill
	movq	%rcx, %rax
	cqto
	movq	-24(%rbp), %rcx         ## 8-byte Reload
	idivq	%rcx
	cmpq	$0, %rdx
	jne	LBB0_4
## BB#3:                                ##   in Loop: Header=BB0_1 Depth=1
	leaq	L_.str(%rip), %rdi
	movq	-8(%rbp), %rsi
	movl	_g_ant(%rip), %eax
	addl	$1, %eax
	movl	%eax, _g_ant(%rip)
	movl	%eax, %edx
	movb	$0, %al
	callq	_printf
	movl	%eax, -28(%rbp)         ## 4-byte Spill
LBB0_4:                                 ##   in Loop: Header=BB0_1 Depth=1
	jmp	LBB0_1
LBB0_5:
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_main
	.align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp7:
	.cfi_def_cfa_offset 16
Ltmp8:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp9:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	callq	_fork
	movl	%eax, -8(%rbp)
	cmpl	$0, -8(%rbp)
	jne	LBB1_2
## BB#1:
	leaq	L_.str1(%rip), %rdi
	callq	_writeloop
	movl	$0, %edi
	callq	_exit
LBB1_2:
	leaq	L_.str2(%rip), %rdi
	callq	_writeloop
	movabsq	$0, %rsi
	movl	$0, %edx
	movl	-8(%rbp), %edi
	callq	_waitpid
	movl	$0, %edx
	movl	%eax, -12(%rbp)         ## 4-byte Spill
	movl	%edx, %eax
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_g_ant                  ## @g_ant
.zerofill __DATA,__common,_g_ant,4,2
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"%s: %d\n"

L_.str1:                                ## @.str1
	.asciz	"Child"

L_.str2:                                ## @.str2
	.asciz	"Parent"


.subsections_via_symbols
