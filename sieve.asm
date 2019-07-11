	.text
	.globl	_SIZE
	.section .rdata,"dr"
	.align 4
_SIZE:
	.long	10000
LC0:
	.ascii "%d\12\0"
LC1:
	.ascii "HELLO\0"	
	
	.text
	.globl	_main
_main:
LFB13:
	.cfi_startproc #canonical frame address
	leal	4(%esp), %ecx # load effective address load esp - 4 into ecx. 
	.cfi_def_cfa 1, 0
	andl	$-16, %esp #stack pointer 
	pushl	-4(%ecx) # push ECX - 4 on the stack. 
	pushl	%ebp # push base pointer on stack.  # stack pointer ⇔ locals of current function ⇔ frame pointer ⇔ return address, parameters for function.
	.cfi_escape 0x10,0x5,0x2,0x75,0
	movl	%esp, %ebp #overwrite base pointer by stack pointer.
	pushl	%ebx # push ebx 
	pushl	%ecx # push ecx 
	.cfi_escape 0xf,0x3,0x75,0x78,0x6
	.cfi_escape 0x10,0x3,0x2,0x75,0x7c
	subl	$48, %esp # subtract 12 ints from the stack pointer.
	call	___main
	movl	%esp, %eax
	movl	%eax, %ebx
	movl	$10000, %eax # eax has loop constant in it. 
	subl	$1, %eax 
	movl	%eax, -24(%ebp)
	movl	$10000, %eax
	leal	0(,%eax,4), %edx
	movl	$16, %eax
	subl	$1, %eax
	addl	%edx, %eax
	movl	$16, %ecx
	movl	$0, %edx
	divl	%ecx
	imull	$16, %eax, %eax
	call	___chkstk_ms
	subl	%eax, %esp
	leal	8(%esp), %eax
	addl	$3, %eax
	shrl	$2, %eax
	sall	$2, %eax
	movl	%eax, -28(%ebp)
	movl	$1, -16(%ebp)
	movl	$2, -12(%ebp)
	movl	-28(%ebp), %eax
	movl	$0, (%eax)
	movl	-28(%ebp), %eax
	movl	$0, 4(%eax)
	movl	$2, -20(%ebp)
	jmp	L2
L3:
	movl	-28(%ebp), %eax
	movl	-20(%ebp), %edx
	movl	$1, (%eax,%edx,4)
	addl	$1, -20(%ebp)
L2:
	movl	$10000, %eax
	cmpl	%eax, -20(%ebp)
	jl	L3
	jmp	L4
L8:
	movl	-28(%ebp), %eax
	movl	-16(%ebp), %edx
	movl	(%eax,%edx,4), %eax
	testl	%eax, %eax
	jne	L5
	jmp	L4
L5:
	movl	-16(%ebp), %eax
	addl	%eax, %eax
	movl	%eax, -12(%ebp)
	jmp	L6
L7:
	movl	-28(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	$0, (%eax,%edx,4)
	movl	-16(%ebp), %eax
	addl	%eax, -12(%ebp)
L6:
	movl	$10000, %eax
	cmpl	%eax, -12(%ebp)
	jl	L7
L4:
	addl	$1, -16(%ebp)
	movl	$10000, %eax
	cmpl	%eax, -16(%ebp)
	jl	L8
	movl	$2, -20(%ebp)
	jmp	L9
L11:
	movl	-28(%ebp), %eax
	movl	-20(%ebp), %edx
	movl	(%eax,%edx,4), %eax
	cmpl	$1, %eax
	jne	L10
	movl	-20(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC0, (%esp)
	call	_printf #Print the number
L10:
	addl	$1, -20(%ebp)
L9:
	movl	$10000, %eax
	cmpl	%eax, -20(%ebp)
	jl	L11
	#movl	$LC1, (%esp)
	#call	_printf
	movl	%ebx, %esp
	movl	$0, %eax
	leal	-8(%ebp), %esp
	popl	%ecx
	.cfi_restore 1
	.cfi_def_cfa 1, 0
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	leal	-4(%ecx), %esp
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
