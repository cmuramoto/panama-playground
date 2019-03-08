	.file	"compressor.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC8:
	.string	"Storing Scalar ([1-5]b)"
.LC9:
	.string	"{%d}"
.LC10:
	.string	"]"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB11:
	.text
.LHOTB11:
	.p2align 4,,15
	.type	compress.constprop.1, @function
compress.constprop.1:
.LFB4665:
	.cfi_startproc
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-32, %rsp
	pushq	-8(%r10)
	pushq	%rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	movq	%rdi, %r14
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	pushq	%rbx
	movq	%rsi, %r13
	addq	$-128, %rsp
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	movl	$4, -116(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	jmp	.L17
	.p2align 4,,10
	.p2align 3
.L26:
	vpxor	%xmm1, %xmm1, %xmm1
	addq	$32, %r14
	addq	$8, %r13
	vpackusdw	%ymm1, %ymm0, %ymm0
	vpxor	%xmm1, %xmm1, %xmm1
	vpackuswb	%ymm1, %ymm0, %ymm0
	vmovdqa	.LC1(%rip), %ymm1
	vpermd	%ymm0, %ymm1, %ymm0
	vmovq	%xmm0, -8(%r13)
.L3:
	subl	$1, -116(%rbp)
	je	.L25
.L17:
	vmovdqu	(%r14), %ymm0
	vpcmpgtd	.LC0(%rip), %ymm0, %ymm1
	vpmovmskb	%ymm1, %eax
	testl	%eax, %eax
	je	.L26
	vpcmpgtd	.LC2(%rip), %ymm0, %ymm1
	vpmovmskb	%ymm1, %eax
	testl	%eax, %eax
	je	.L27
	vpcmpgtd	.LC6(%rip), %ymm0, %ymm1
	vpmovmskb	%ymm1, %eax
	testl	%eax, %eax
	jne	.L5
	movl	(%r14), %eax
	movl	%eax, %edx
	orl	$-128, %edx
	movb	%dl, 0(%r13)
	movl	%eax, %edx
	shrl	$14, %eax
	shrl	$7, %edx
	movb	%al, 2(%r13)
	orl	$-128, %edx
	movb	%dl, 1(%r13)
	movl	4(%r14), %eax
	movl	%eax, %edx
	orl	$-128, %edx
	movb	%dl, 3(%r13)
	movl	%eax, %edx
	shrl	$14, %eax
	shrl	$7, %edx
	movb	%al, 5(%r13)
	orl	$-128, %edx
	movb	%dl, 4(%r13)
	movl	8(%r14), %eax
	movl	%eax, %edx
	orl	$-128, %edx
	movb	%dl, 6(%r13)
	movl	%eax, %edx
	shrl	$14, %eax
	shrl	$7, %edx
	movb	%al, 8(%r13)
	orl	$-128, %edx
	movb	%dl, 7(%r13)
	movl	12(%r14), %eax
	movl	%eax, %edx
	orl	$-128, %edx
	movb	%dl, 9(%r13)
	movl	%eax, %edx
	shrl	$14, %eax
	shrl	$7, %edx
	movb	%al, 11(%r13)
	orl	$-128, %edx
	movb	%dl, 10(%r13)
	movl	16(%r14), %eax
	movl	%eax, %edx
	orl	$-128, %edx
	movb	%dl, 12(%r13)
	movl	%eax, %edx
	shrl	$14, %eax
	shrl	$7, %edx
	movb	%al, 14(%r13)
	orl	$-128, %edx
	movb	%dl, 13(%r13)
	movl	20(%r14), %eax
	movl	%eax, %edx
	orl	$-128, %edx
	movb	%dl, 15(%r13)
	movl	%eax, %edx
	shrl	$14, %eax
	shrl	$7, %edx
	movb	%al, 17(%r13)
	orl	$-128, %edx
	movb	%dl, 16(%r13)
	movl	24(%r14), %eax
	movl	%eax, %edx
	orl	$-128, %edx
	movb	%dl, 18(%r13)
	movl	%eax, %edx
	shrl	$14, %eax
	shrl	$7, %edx
	movb	%al, 20(%r13)
	orl	$-128, %edx
	movb	%dl, 19(%r13)
	movl	28(%r14), %eax
	movl	%eax, %edx
	orl	$-128, %edx
	movb	%dl, 21(%r13)
	movl	%eax, %edx
	shrl	$14, %eax
	shrl	$7, %edx
	movb	%al, 23(%r13)
	orl	$-128, %edx
	addq	$24, %r13
	movb	%dl, -2(%r13)
	addq	$32, %r14
	subl	$1, -116(%rbp)
	jne	.L17
	.p2align 4,,10
	.p2align 3
.L25:
	movq	-56(%rbp), %rcx
	xorq	%fs:40, %rcx
	jne	.L28
	vzeroupper
	subq	$-128, %rsp
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L5:
	.cfi_restore_state
	vpcmpgtd	.LC7(%rip), %ymm0, %ymm1
	vpmovmskb	%ymm1, %eax
	testl	%eax, %eax
	jne	.L6
	vpsrld	$7, %ymm0, %ymm3
	vpand	.LC4(%rip), %ymm0, %ymm2
	vpsrld	$14, %ymm0, %ymm5
	vmovdqa	.LC5(%rip), %ymm1
	vpsrld	$21, %ymm0, %ymm4
	addq	$32, %r13
	vpand	.LC3(%rip), %ymm3, %ymm3
	addq	$32, %r14
	vpand	.LC3(%rip), %ymm5, %ymm5
	vpand	.LC3(%rip), %ymm4, %ymm4
	vpor	%ymm1, %ymm3, %ymm3
	vpor	%ymm1, %ymm2, %ymm1
	vpslld	$16, %ymm5, %ymm5
	vpsllw	$8, %ymm3, %ymm3
	vpslld	$24, %ymm4, %ymm4
	vpor	%ymm3, %ymm1, %ymm1
	vpor	%ymm5, %ymm1, %ymm0
	vpor	%ymm4, %ymm0, %ymm0
	vmovdqu	%ymm0, -32(%r13)
	jmp	.L3
	.p2align 4,,10
	.p2align 3
.L27:
	vpsrld	$7, %ymm0, %ymm1
	vpand	.LC4(%rip), %ymm0, %ymm0
	addq	$32, %r14
	addq	$16, %r13
	vpand	.LC3(%rip), %ymm1, %ymm1
	vpor	.LC5(%rip), %ymm0, %ymm0
	vpsllw	$8, %ymm1, %ymm1
	vpor	%ymm1, %ymm0, %ymm0
	vpxor	%xmm1, %xmm1, %xmm1
	vpackusdw	%ymm1, %ymm0, %ymm0
	vpermq	$248, %ymm0, %ymm0
	vmovups	%xmm0, -16(%r13)
	jmp	.L3
	.p2align 4,,10
	.p2align 3
.L6:
	movl	$.LC8, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	vmovdqa	%ymm0, -176(%rbp)
	vzeroupper
	call	__printf_chk
	vmovdqa	-176(%rbp), %ymm0
	movl	$91, %edi
	vmovdqa	%ymm0, -112(%rbp)
	vzeroupper
	movl	$1, %r12d
	call	putchar
	leaq	-112(%rbp), %rbx
	xorl	%r15d, %r15d
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L9:
	movzbl	(%rbx), %edx
	xorl	%eax, %eax
	movl	$.LC9, %esi
	movl	$1, %edi
	call	__printf_chk
	cmpl	$32, %r12d
	je	.L29
.L10:
	addl	$1, %r15d
	addl	$1, %r12d
	addq	$1, %rbx
.L7:
	testl	%r15d, %r15d
	je	.L8
	testb	$3, %r15b
	jne	.L9
	movl	$59, %edi
	call	putchar
	jmp	.L9
	.p2align 4,,10
	.p2align 3
.L29:
	movl	$.LC10, %edi
	call	puts
	leaq	32(%r14), %rdi
	movq	%r13, %rcx
	movq	%r14, %rdx
	jmp	.L16
	.p2align 4,,10
	.p2align 3
.L30:
	movb	%al, (%rcx)
	addq	$1, %rcx
.L12:
	cmpq	%rdx, %rdi
	je	.L3
.L16:
	addq	$4, %rdx
	movl	-4(%rdx), %eax
	movl	%eax, %esi
	shrl	$7, %esi
	testl	%esi, %esi
	je	.L30
	movl	%eax, %r8d
	shrl	$14, %r8d
	testl	%r8d, %r8d
	jne	.L13
	orl	$-128, %eax
	movb	%sil, 1(%rcx)
	addq	$2, %rcx
	movb	%al, -2(%rcx)
	jmp	.L12
	.p2align 4,,10
	.p2align 3
.L13:
	movl	%eax, %r9d
	shrl	$21, %r9d
	testl	%r9d, %r9d
	jne	.L14
	orl	$-128, %eax
	movb	%r8b, 2(%rcx)
	addq	$3, %rcx
	movb	%al, -3(%rcx)
	movl	%esi, %eax
	orl	$-128, %eax
	movb	%al, -2(%rcx)
	jmp	.L12
	.p2align 4,,10
	.p2align 3
.L14:
	movl	%eax, %r10d
	orl	$-128, %eax
	movb	%al, (%rcx)
	movl	%esi, %eax
	shrl	$28, %r10d
	orl	$-128, %eax
	movb	%al, 1(%rcx)
	movl	%r8d, %eax
	orl	$-128, %eax
	testl	%r10d, %r10d
	movb	%al, 2(%rcx)
	jne	.L15
	movb	%r9b, 3(%rcx)
	addq	$4, %rcx
	jmp	.L12
	.p2align 4,,10
	.p2align 3
.L15:
	orl	$-128, %r9d
	movb	%r10b, 4(%rcx)
	addq	$5, %rcx
	movb	%r9b, -2(%rcx)
	jmp	.L12
	.p2align 4,,10
	.p2align 3
.L8:
	movzbl	(%rbx), %edx
	movl	$.LC9, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
	jmp	.L10
.L28:
	vzeroupper
	call	__stack_chk_fail
	.cfi_endproc
.LFE4665:
	.size	compress.constprop.1, .-compress.constprop.1
	.section	.text.unlikely
.LCOLDE11:
	.text
.LHOTE11:
	.section	.rodata.str1.1
.LC12:
	.string	"optimal_frame"
	.section	.text.unlikely
.LCOLDB19:
	.text
.LHOTB19:
	.p2align 4,,15
	.type	decompress.constprop.0, @function
decompress.constprop.0:
.LFB4666:
	.cfi_startproc
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-32, %rsp
	pushq	-8(%r10)
	pushq	%rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x60,0x6
	.cfi_escape 0x10,0xe,0x2,0x76,0x78
	.cfi_escape 0x10,0xd,0x2,0x76,0x70
	.cfi_escape 0x10,0xc,0x2,0x76,0x68
	movq	%rsi, %r12
	pushq	%rbx
	movl	$160, %r13d
	.cfi_escape 0x10,0x3,0x2,0x76,0x58
	movq	%rdi, %rbx
	movl	$32, %r14d
	subq	$40, %rsp
	vmovdqa	.LC15(%rip), %ymm2
	jmp	.L49
	.p2align 4,,10
	.p2align 3
.L36:
	testl	%eax, %eax
	je	.L73
	movzbl	%ah, %edx
	testl	%edx, %edx
	jne	.L40
	shrl	$16, %eax
	testb	%al, %al
	jne	.L41
	vmovdqa	.LC15(%rip), %ymm6
	vpxor	%xmm3, %xmm3, %xmm3
	addq	$96, %r12
	addq	$24, %rbx
	subl	$24, %r14d
	vpermd	%ymm0, %ymm6, %ymm1
	subl	$24, %r13d
	vpunpcklbw	%ymm3, %ymm1, %ymm1
	vpunpcklbw	%ymm3, %ymm1, %ymm1
	vmovdqu	%ymm1, -96(%r12)
	vmovdqa	.LC16(%rip), %ymm1
	vpermd	%ymm0, %ymm1, %ymm1
	vpunpcklbw	%ymm3, %ymm1, %ymm1
	vpunpcklbw	%ymm3, %ymm1, %ymm1
	vmovdqu	%ymm1, -64(%r12)
	vmovdqa	.LC17(%rip), %ymm1
	vpermd	%ymm0, %ymm1, %ymm0
	vpunpcklbw	%ymm3, %ymm0, %ymm0
	vpunpcklbw	%ymm3, %ymm0, %ymm0
	vmovdqu	%ymm0, -32(%r12)
	.p2align 4,,10
	.p2align 3
.L33:
	cmpl	$31, %r13d
	jle	.L39
	cmpl	$7, %r14d
	jle	.L39
.L49:
	vmovdqu	(%rbx), %ymm0
	vpmovmskb	%ymm0, %eax
	cmpl	$2004318071, %eax
	je	.L74
	movl	%eax, %edx
	andl	$7190235, %edx
	cmpl	$7190235, %edx
	je	.L75
	movl	%eax, %edx
	andl	$21845, %edx
	cmpl	$21845, %edx
	je	.L76
	testb	%al, %al
	je	.L36
	movslq	%r13d, %r8
	movq	%r12, %rdx
	movq	%rbx, %rax
	jmp	.L37
	.p2align 4,,10
	.p2align 3
.L79:
	addq	$1, %rax
.L43:
	addq	$4, %rdx
	movl	%ecx, -4(%rdx)
	movq	%rax, %rcx
	subq	%rbx, %rcx
	cmpq	%r8, %rcx
	jge	.L77
	movq	%rdx, %rcx
	subq	%r12, %rcx
	cmpq	$31, %rcx
	jg	.L78
.L37:
	movzbl	(%rax), %esi
	movl	%esi, %ecx
	andl	$127, %ecx
	andl	$128, %esi
	je	.L79
	movzbl	1(%rax), %edi
	movl	%edi, %esi
	andl	$127, %esi
	sall	$7, %esi
	orl	%esi, %ecx
	andl	$128, %edi
	jne	.L44
	addq	$2, %rax
	jmp	.L43
	.p2align 4,,10
	.p2align 3
.L44:
	movzbl	2(%rax), %edi
	movl	%edi, %esi
	andl	$127, %esi
	sall	$14, %esi
	orl	%esi, %ecx
	andl	$128, %edi
	jne	.L45
	addq	$3, %rax
	jmp	.L43
	.p2align 4,,10
	.p2align 3
.L45:
	movzbl	3(%rax), %edi
	movl	%edi, %esi
	andl	$127, %esi
	sall	$21, %esi
	orl	%esi, %ecx
	andl	$128, %edi
	jne	.L46
	addq	$4, %rax
	jmp	.L43
	.p2align 4,,10
	.p2align 3
.L74:
	vmovdqa	.LC4(%rip), %ymm1
	vpsrld	$16, %ymm0, %ymm3
	vpsrld	$24, %ymm0, %ymm5
	vpsrld	$8, %ymm0, %ymm4
	subl	$8, %r14d
	addq	$32, %r12
	vpand	%ymm1, %ymm3, %ymm3
	subl	$32, %r13d
	addq	$32, %rbx
	vpand	%ymm1, %ymm5, %ymm5
	vpand	%ymm1, %ymm4, %ymm4
	vpslld	$14, %ymm3, %ymm3
	vpand	%ymm1, %ymm0, %ymm1
	vpslld	$21, %ymm5, %ymm5
	vpor	%ymm5, %ymm3, %ymm0
	vpslld	$7, %ymm4, %ymm4
	vpor	%ymm0, %ymm1, %ymm0
	vpor	%ymm4, %ymm0, %ymm0
	vmovdqu	%ymm0, -32(%r12)
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L73:
	vmovdqa	.LC15(%rip), %ymm2
	vpxor	%xmm1, %xmm1, %xmm1
	subq	$-128, %r12
	addq	$32, %rbx
	subl	$32, %r13d
	vpermd	%ymm0, %ymm2, %ymm2
	subl	$32, %r14d
	vpunpcklbw	%ymm1, %ymm2, %ymm2
	vpunpcklbw	%ymm1, %ymm2, %ymm2
	vmovdqu	%ymm2, -128(%r12)
	vmovdqa	.LC16(%rip), %ymm2
	vpermd	%ymm0, %ymm2, %ymm2
	vpunpcklbw	%ymm1, %ymm2, %ymm2
	vpunpcklbw	%ymm1, %ymm2, %ymm2
	vmovdqu	%ymm2, -96(%r12)
	vmovdqa	.LC17(%rip), %ymm2
	vpermd	%ymm0, %ymm2, %ymm2
	vpunpcklbw	%ymm1, %ymm2, %ymm2
	vpunpcklbw	%ymm1, %ymm2, %ymm2
	vmovdqu	%ymm2, -64(%r12)
	vmovdqa	.LC18(%rip), %ymm2
	vpermd	%ymm0, %ymm2, %ymm0
	vpunpcklbw	%ymm1, %ymm0, %ymm0
	vpunpcklbw	%ymm1, %ymm0, %ymm0
	vmovdqu	%ymm0, -32(%r12)
.L39:
	testl	%r13d, %r13d
	jle	.L71
	testl	%r14d, %r14d
	jle	.L71
	movq	%rbx, %rsi
	movslq	%r13d, %r13
	movq	%r12, %rdi
	movslq	%r14d, %r14
	jmp	.L59
	.p2align 4,,10
	.p2align 3
.L80:
	addq	$1, %rbx
.L54:
	addq	$4, %r12
	movl	%eax, -4(%r12)
	movq	%rbx, %rax
	subq	%rsi, %rax
	cmpq	%r13, %rax
	jge	.L71
	movq	%r12, %rax
	subq	%rdi, %rax
	sarq	$2, %rax
	cmpq	%r14, %rax
	jge	.L71
.L59:
	movzbl	(%rbx), %edx
	movl	%edx, %eax
	andl	$127, %eax
	andl	$128, %edx
	je	.L80
	movzbl	1(%rbx), %ecx
	movl	%ecx, %edx
	andl	$127, %edx
	sall	$7, %edx
	orl	%edx, %eax
	andl	$128, %ecx
	jne	.L55
	addq	$2, %rbx
	jmp	.L54
	.p2align 4,,10
	.p2align 3
.L71:
	vzeroupper
	addq	$40, %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L46:
	.cfi_restore_state
	movsbl	4(%rax), %esi
	addq	$5, %rax
	sall	$28, %esi
	orl	%esi, %ecx
	jmp	.L43
	.p2align 4,,10
	.p2align 3
.L75:
	movl	$.LC12, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	vmovdqa	%ymm2, -80(%rbp)
	vzeroupper
	call	__printf_chk
	movzbl	(%rbx), %eax
	movzbl	2(%rbx), %edx
	movl	%eax, %ecx
	movzbl	1(%rbx), %eax
	andl	$127, %edx
	andl	$127, %ecx
	sall	$14, %edx
	andl	$127, %eax
	sall	$7, %eax
	orl	%edx, %eax
	orl	%ecx, %eax
	movl	%eax, (%r12)
	movzbl	3(%rbx), %eax
	movzbl	5(%rbx), %edx
	movl	%eax, %ecx
	movzbl	4(%rbx), %eax
	andl	$127, %edx
	andl	$127, %ecx
	sall	$14, %edx
	andl	$127, %eax
	sall	$7, %eax
	orl	%edx, %eax
	orl	%ecx, %eax
	movl	%eax, 4(%r12)
	movzbl	6(%rbx), %eax
	movzbl	8(%rbx), %edx
	movl	%eax, %ecx
	movzbl	7(%rbx), %eax
	andl	$127, %edx
	andl	$127, %ecx
	sall	$14, %edx
	andl	$127, %eax
	sall	$7, %eax
	orl	%edx, %eax
	orl	%ecx, %eax
	movl	%eax, 8(%r12)
	movzbl	9(%rbx), %eax
	movzbl	11(%rbx), %edx
	movl	%eax, %ecx
	movzbl	10(%rbx), %eax
	andl	$127, %edx
	andl	$127, %ecx
	sall	$14, %edx
	andl	$127, %eax
	sall	$7, %eax
	orl	%edx, %eax
	orl	%ecx, %eax
	movl	%eax, 12(%r12)
	movzbl	12(%rbx), %eax
	movzbl	14(%rbx), %edx
	movl	%eax, %ecx
	movzbl	13(%rbx), %eax
	andl	$127, %ecx
	andl	$127, %eax
	sall	$7, %eax
	andl	$127, %edx
	subl	$24, %r13d
	sall	$14, %edx
	subl	$8, %r14d
	addq	$32, %r12
	orl	%edx, %eax
	addq	$24, %rbx
	orl	%ecx, %eax
	movl	%eax, -16(%r12)
	movzbl	-9(%rbx), %eax
	movzbl	-7(%rbx), %edx
	movl	%eax, %ecx
	movzbl	-8(%rbx), %eax
	andl	$127, %edx
	andl	$127, %ecx
	sall	$14, %edx
	andl	$127, %eax
	sall	$7, %eax
	orl	%edx, %eax
	orl	%ecx, %eax
	movl	%eax, -12(%r12)
	movzbl	-6(%rbx), %eax
	movzbl	-4(%rbx), %edx
	movl	%eax, %ecx
	movzbl	-5(%rbx), %eax
	andl	$127, %edx
	andl	$127, %ecx
	sall	$14, %edx
	andl	$127, %eax
	sall	$7, %eax
	orl	%edx, %eax
	orl	%ecx, %eax
	movl	%eax, -8(%r12)
	movzbl	-3(%rbx), %eax
	movzbl	-1(%rbx), %edx
	movl	%eax, %ecx
	movzbl	-2(%rbx), %eax
	andl	$127, %edx
	andl	$127, %ecx
	sall	$14, %edx
	andl	$127, %eax
	sall	$7, %eax
	orl	%edx, %eax
	orl	%ecx, %eax
	movl	%eax, -4(%r12)
	vmovdqa	-80(%rbp), %ymm2
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L41:
	vmovdqa	.LC15(%rip), %ymm7
	vpxor	%xmm3, %xmm3, %xmm3
	vmovdqa	.LC16(%rip), %ymm6
	addq	$64, %r12
	addq	$16, %rbx
	vpermd	%ymm0, %ymm7, %ymm1
	subl	$16, %r13d
	vpermd	%ymm0, %ymm6, %ymm0
	subl	$16, %r14d
	vpunpcklbw	%ymm3, %ymm1, %ymm1
	vpunpcklbw	%ymm3, %ymm0, %ymm0
	vpunpcklbw	%ymm3, %ymm1, %ymm1
	vpunpcklbw	%ymm3, %ymm0, %ymm0
	vmovdqu	%ymm1, -64(%r12)
	vmovdqu	%ymm0, -32(%r12)
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L76:
	vmovdqa	.LC13(%rip), %ymm3
	vpsrlw	$8, %ymm0, %ymm1
	shrl	$16, %eax
	andl	$21845, %eax
	leaq	16(%rbx), %rdx
	leal	-16(%r13), %esi
	vpand	%ymm3, %ymm1, %ymm1
	cmpl	$21845, %eax
	vpand	%ymm3, %ymm0, %ymm0
	leaq	32(%r12), %rcx
	vpxor	%xmm3, %xmm3, %xmm3
	leal	-8(%r14), %edi
	vpsllw	$7, %ymm1, %ymm1
	vpor	%ymm1, %ymm0, %ymm0
	vpunpcklwd	%ymm3, %ymm0, %ymm1
	vpunpckhwd	%ymm3, %ymm0, %ymm0
	vmovdqa	.LC14(%rip), %ymm3
	vmovdqa	%ymm1, %ymm5
	vpermd	%ymm0, %ymm3, %ymm4
	vpblendd	$240, %ymm4, %ymm1, %ymm1
	vmovdqu	%ymm1, (%r12)
	je	.L81
	movl	%edi, %r14d
	movl	%esi, %r13d
	movq	%rcx, %r12
	movq	%rdx, %rbx
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L40:
	vpxor	%xmm1, %xmm1, %xmm1
	addq	$32, %r12
	vpermd	%ymm0, %ymm2, %ymm0
	addq	$8, %rbx
	subl	$8, %r13d
	subl	$8, %r14d
	vpunpcklbw	%ymm1, %ymm0, %ymm0
	vpunpcklbw	%ymm1, %ymm0, %ymm0
	vmovdqu	%ymm0, -32(%r12)
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L77:
	subq	%r12, %rdx
	sarq	$2, %rdx
	movl	%edx, %esi
	movslq	%edx, %rax
.L48:
	addq	%rax, %rbx
	subl	%esi, %r13d
	subl	$8, %r14d
	addq	$32, %r12
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L78:
	sarq	$2, %rcx
	movl	%ecx, %esi
	movslq	%ecx, %rax
	jmp	.L48
	.p2align 4,,10
	.p2align 3
.L55:
	movzbl	2(%rbx), %ecx
	movl	%ecx, %edx
	andl	$127, %edx
	sall	$14, %edx
	orl	%edx, %eax
	andl	$128, %ecx
	jne	.L56
	addq	$3, %rbx
	jmp	.L54
	.p2align 4,,10
	.p2align 3
.L56:
	movzbl	3(%rbx), %ecx
	movl	%ecx, %edx
	andl	$127, %edx
	sall	$21, %edx
	orl	%edx, %eax
	andl	$128, %ecx
	jne	.L57
	addq	$4, %rbx
	jmp	.L54
	.p2align 4,,10
	.p2align 3
.L57:
	movsbl	4(%rbx), %edx
	addq	$5, %rbx
	sall	$28, %edx
	orl	%edx, %eax
	jmp	.L54
.L81:
	vpermd	%ymm5, %ymm3, %ymm3
	addq	$32, %rbx
	subl	$32, %r13d
	addq	$64, %r12
	subl	$16, %r14d
	vpblendd	$240, %ymm0, %ymm3, %ymm0
	vmovdqu	%ymm0, -32(%r12)
	jmp	.L33
	.cfi_endproc
.LFE4666:
	.size	decompress.constprop.0, .-decompress.constprop.0
	.section	.text.unlikely
.LCOLDE19:
	.text
.LHOTE19:
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC25:
	.string	"{N:%d, V_C:%f, S_C:%f, V_D:%f, S_D:%f, C_R:%f, D_R:%f} \n"
	.section	.text.unlikely
.LCOLDB26:
	.text
.LHOTB26:
	.p2align 4,,15
	.type	benchByCategory, @function
benchByCategory:
.LFB4658:
	.cfi_startproc
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-32, %rsp
	pushq	-8(%r10)
	pushq	%rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	pushq	%rbx
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	movl	%esi, %ebx
	subq	$480, %rsp
	movl	%edi, -504(%rbp)
	vpbroadcastd	-504(%rbp), %ymm0
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	vpaddd	.LC20(%rip), %ymm0, %ymm1
	vmovdqa	%ymm1, -496(%rbp)
	vpaddd	.LC21(%rip), %ymm0, %ymm1
	vmovdqa	%ymm1, -464(%rbp)
	vpaddd	.LC22(%rip), %ymm0, %ymm1
	vpaddd	.LC23(%rip), %ymm0, %ymm0
	vmovdqa	%ymm1, -432(%rbp)
	vmovdqa	%ymm0, -400(%rbp)
	vzeroupper
	call	clock
	testl	%ebx, %ebx
	movq	%rax, %r14
	jle	.L83
	leaq	-224(%rbp), %r13
	xorl	%r12d, %r12d
	.p2align 4,,10
	.p2align 3
.L84:
	leaq	-496(%rbp), %rdi
	movq	%r13, %rsi
	addl	$1, %r12d
	call	compress.constprop.1
	cmpl	%r12d, %ebx
	jne	.L84
	call	clock
	vxorpd	%xmm0, %xmm0, %xmm0
	subq	%r14, %rax
	vmovsd	.LC24(%rip), %xmm5
	leaq	-352(%rbp), %r14
	xorl	%r12d, %r12d
	vcvtsi2sdq	%rax, %xmm0, %xmm0
	vdivsd	%xmm5, %xmm0, %xmm4
	vmovsd	%xmm5, -504(%rbp)
	vmovsd	%xmm4, -512(%rbp)
	call	clock
	movq	%rax, %r15
	.p2align 4,,10
	.p2align 3
.L86:
	movq	%r14, %rsi
	movq	%r13, %rdi
	addl	$1, %r12d
	call	decompress.constprop.0
	cmpl	%r12d, %ebx
	jne	.L86
	call	clock
	vxorpd	%xmm0, %xmm0, %xmm0
	subq	%r15, %rax
	vcvtsi2sdq	%rax, %xmm0, %xmm0
	vdivsd	-504(%rbp), %xmm0, %xmm2
	vmovsd	%xmm2, -520(%rbp)
	call	clock
	movq	%rax, %r12
	leaq	-496(%rbp), %rax
	xorl	%r8d, %r8d
	leaq	128(%rax), %rdi
	.p2align 4,,10
	.p2align 3
.L94:
	movq	%r13, %rcx
	leaq	-496(%rbp), %rdx
	jmp	.L93
	.p2align 4,,10
	.p2align 3
.L122:
	movb	%al, (%rcx)
	addq	$1, %rcx
.L89:
	cmpq	%rdi, %rdx
	je	.L121
.L93:
	addq	$4, %rdx
	movl	-4(%rdx), %eax
	movl	%eax, %esi
	shrl	$7, %esi
	testl	%esi, %esi
	je	.L122
	movl	%eax, %r9d
	shrl	$14, %r9d
	testl	%r9d, %r9d
	jne	.L90
	orl	$-128, %eax
	movb	%sil, 1(%rcx)
	addq	$2, %rcx
	movb	%al, -2(%rcx)
	cmpq	%rdi, %rdx
	jne	.L93
.L121:
	addl	$1, %r8d
	cmpl	%r8d, %ebx
	jg	.L94
	call	clock
	vxorpd	%xmm0, %xmm0, %xmm0
	subq	%r12, %rax
	vcvtsi2sdq	%rax, %xmm0, %xmm0
	vdivsd	-504(%rbp), %xmm0, %xmm4
	vmovsd	%xmm4, -528(%rbp)
	call	clock
	xorl	%r8d, %r8d
	movq	%rax, %r12
	.p2align 4,,10
	.p2align 3
.L104:
	movq	%r14, %rdx
	movq	%r13, %rax
	jmp	.L102
	.p2align 4,,10
	.p2align 3
.L123:
	addq	$1, %rax
.L97:
	addq	$4, %rdx
	movl	%ecx, -4(%rdx)
	movq	%rax, %rcx
	subq	%r13, %rcx
	cmpq	$159, %rcx
	jg	.L101
	movq	%rdx, %rcx
	subq	%r14, %rcx
	cmpq	$127, %rcx
	jg	.L101
.L102:
	movzbl	(%rax), %esi
	movl	%esi, %ecx
	andl	$127, %ecx
	andl	$128, %esi
	je	.L123
	movzbl	1(%rax), %edi
	movl	%edi, %esi
	andl	$127, %esi
	sall	$7, %esi
	orl	%esi, %ecx
	andl	$128, %edi
	jne	.L98
	addq	$2, %rax
	jmp	.L97
	.p2align 4,,10
	.p2align 3
.L90:
	movl	%eax, %r10d
	shrl	$21, %r10d
	testl	%r10d, %r10d
	jne	.L91
	orl	$-128, %eax
	orl	$-128, %esi
	movb	%r9b, 2(%rcx)
	movb	%al, (%rcx)
	movb	%sil, 1(%rcx)
	addq	$3, %rcx
	jmp	.L89
	.p2align 4,,10
	.p2align 3
.L91:
	movl	%eax, %r11d
	orl	$-128, %esi
	orl	$-128, %eax
	shrl	$28, %r11d
	orl	$-128, %r9d
	movb	%al, (%rcx)
	testl	%r11d, %r11d
	movb	%sil, 1(%rcx)
	movb	%r9b, 2(%rcx)
	jne	.L92
	movb	%r10b, 3(%rcx)
	addq	$4, %rcx
	jmp	.L89
	.p2align 4,,10
	.p2align 3
.L98:
	movzbl	2(%rax), %edi
	movl	%edi, %esi
	andl	$127, %esi
	sall	$14, %esi
	orl	%esi, %ecx
	andl	$128, %edi
	jne	.L99
	addq	$3, %rax
	jmp	.L97
	.p2align 4,,10
	.p2align 3
.L99:
	movzbl	3(%rax), %edi
	movl	%edi, %esi
	andl	$127, %esi
	sall	$21, %esi
	orl	%esi, %ecx
	andl	$128, %edi
	jne	.L100
	addq	$4, %rax
	jmp	.L97
	.p2align 4,,10
	.p2align 3
.L101:
	addl	$1, %r8d
	cmpl	%r8d, %ebx
	jg	.L104
.L103:
	call	clock
	vxorpd	%xmm3, %xmm3, %xmm3
	subq	%r12, %rax
	vmovsd	-528(%rbp), %xmm7
	movl	%ebx, %edx
	vmovsd	-520(%rbp), %xmm2
	movl	$.LC25, %esi
	vcvtsi2sdq	%rax, %xmm3, %xmm3
	vdivsd	-504(%rbp), %xmm3, %xmm3
	vmovapd	%xmm7, %xmm1
	movl	$1, %edi
	movl	$6, %eax
	vmovsd	-512(%rbp), %xmm0
	vdivsd	%xmm0, %xmm7, %xmm4
	vdivsd	%xmm2, %xmm3, %xmm5
	call	__printf_chk
	movq	-56(%rbp), %rax
	xorq	%fs:40, %rax
	jne	.L124
	addq	$480, %rsp
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L100:
	.cfi_restore_state
	movsbl	4(%rax), %esi
	addq	$5, %rax
	sall	$28, %esi
	orl	%esi, %ecx
	jmp	.L97
	.p2align 4,,10
	.p2align 3
.L92:
	orl	$-128, %r10d
	movb	%r11b, 4(%rcx)
	addq	$5, %rcx
	movb	%r10b, -2(%rcx)
	jmp	.L89
.L83:
	call	clock
	vxorpd	%xmm0, %xmm0, %xmm0
	subq	%r14, %rax
	vmovsd	.LC24(%rip), %xmm2
	vcvtsi2sdq	%rax, %xmm0, %xmm0
	vdivsd	%xmm2, %xmm0, %xmm6
	vmovsd	%xmm2, -504(%rbp)
	vmovsd	%xmm6, -512(%rbp)
	call	clock
	movq	%rax, %r12
	call	clock
	vxorpd	%xmm0, %xmm0, %xmm0
	subq	%r12, %rax
	vcvtsi2sdq	%rax, %xmm0, %xmm0
	vdivsd	-504(%rbp), %xmm0, %xmm3
	vmovsd	%xmm3, -520(%rbp)
	call	clock
	movq	%rax, %r12
	call	clock
	vxorpd	%xmm0, %xmm0, %xmm0
	subq	%r12, %rax
	vcvtsi2sdq	%rax, %xmm0, %xmm0
	vdivsd	-504(%rbp), %xmm0, %xmm6
	vmovsd	%xmm6, -528(%rbp)
	call	clock
	movq	%rax, %r12
	jmp	.L103
.L124:
	call	__stack_chk_fail
	.cfi_endproc
.LFE4658:
	.size	benchByCategory, .-benchByCategory
	.section	.text.unlikely
.LCOLDE26:
	.text
.LHOTE26:
	.section	.rodata.str1.1
.LC27:
	.string	"---------------"
	.section	.rodata.str1.8
	.align 8
.LC28:
	.string	"[V]Aborting. src[%d]=%d != rec[%d]=%d (diff=%d)\n"
	.align 8
.LC29:
	.string	"[V]Decompress [%d,%d) success!\n"
	.align 8
.LC30:
	.string	"[S]Aborting. src[%d]=%d != rec[%d]=%d (diff=%d)\n"
	.align 8
.LC31:
	.string	"[S]Decompress [%d,%d) success!\n"
	.section	.text.unlikely
.LCOLDB32:
	.text
.LHOTB32:
	.p2align 4,,15
	.type	testIdenticalCategoryByteSeq, @function
testIdenticalCategoryByteSeq:
.LFB4653:
	.cfi_startproc
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-32, %rsp
	pushq	-8(%r10)
	pushq	%rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x60,0x6
	.cfi_escape 0x10,0xe,0x2,0x76,0x78
	.cfi_escape 0x10,0xd,0x2,0x76,0x70
	.cfi_escape 0x10,0xc,0x2,0x76,0x68
	leaq	-224(%rbp), %r13
	pushq	%rbx
	movl	%edi, %r12d
	movq	%r13, %rsi
	subq	$488, %rsp
	.cfi_escape 0x10,0x3,0x2,0x76,0x58
	movl	%edi, -500(%rbp)
	leaq	-496(%rbp), %rdi
	vpbroadcastd	-500(%rbp), %ymm0
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	vpaddd	.LC20(%rip), %ymm0, %ymm1
	vmovdqa	%ymm1, -496(%rbp)
	vpaddd	.LC21(%rip), %ymm0, %ymm1
	vmovdqa	%ymm1, -464(%rbp)
	vpaddd	.LC22(%rip), %ymm0, %ymm1
	vpaddd	.LC23(%rip), %ymm0, %ymm0
	vmovdqa	%ymm1, -432(%rbp)
	vmovdqa	%ymm0, -400(%rbp)
	vzeroupper
	leaq	-352(%rbp), %rbx
	call	compress.constprop.1
	movl	$.LC27, %edi
	call	puts
	movq	%rbx, %rsi
	movq	%r13, %rdi
	call	decompress.constprop.0
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L127:
	movl	-496(%rbp,%rdx,4), %ecx
	movl	(%rbx,%rdx,4), %r9d
	cmpl	%r9d, %ecx
	jne	.L145
	addq	$1, %rdx
	cmpq	$32, %rdx
	jne	.L127
	leal	32(%r12), %r14d
	movl	%r12d, %edx
	movl	$1, %edi
	movl	$.LC29, %esi
	xorl	%eax, %eax
	movl	%r14d, %ecx
	call	__printf_chk
	xorl	%eax, %eax
	movl	$16, %ecx
	movq	%rbx, %rdi
	rep stosq
	movq	%rbx, %rdx
	movq	%r13, %rax
	jmp	.L134
	.p2align 4,,10
	.p2align 3
.L146:
	addq	$1, %rax
.L129:
	addq	$4, %rdx
	movl	%ecx, -4(%rdx)
	movq	%rax, %rcx
	subq	%r13, %rcx
	cmpq	$159, %rcx
	jg	.L138
	movq	%rdx, %rcx
	subq	%rbx, %rcx
	cmpq	$127, %rcx
	jg	.L138
.L134:
	movzbl	(%rax), %esi
	movl	%esi, %ecx
	andl	$127, %ecx
	andl	$128, %esi
	je	.L146
	movzbl	1(%rax), %edi
	movl	%edi, %esi
	andl	$127, %esi
	sall	$7, %esi
	orl	%esi, %ecx
	andl	$128, %edi
	jne	.L130
	addq	$2, %rax
	jmp	.L129
	.p2align 4,,10
	.p2align 3
.L130:
	movzbl	2(%rax), %edi
	movl	%edi, %esi
	andl	$127, %esi
	sall	$14, %esi
	orl	%esi, %ecx
	andl	$128, %edi
	jne	.L131
	addq	$3, %rax
	jmp	.L129
	.p2align 4,,10
	.p2align 3
.L131:
	movzbl	3(%rax), %edi
	movl	%edi, %esi
	andl	$127, %esi
	sall	$21, %esi
	orl	%esi, %ecx
	andl	$128, %edi
	jne	.L132
	addq	$4, %rax
	jmp	.L129
	.p2align 4,,10
	.p2align 3
.L138:
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L136:
	movl	-496(%rbp,%rdx,4), %ecx
	movl	(%rbx,%rdx,4), %r9d
	cmpl	%r9d, %ecx
	jne	.L147
	addq	$1, %rdx
	cmpq	$32, %rdx
	jne	.L136
	xorl	%eax, %eax
	movl	%r14d, %ecx
	movl	%r12d, %edx
	movl	$.LC31, %esi
	movl	$1, %edi
	call	__printf_chk
	movq	-56(%rbp), %rax
	xorq	%fs:40, %rax
	jne	.L148
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
.L132:
	.cfi_restore_state
	movsbl	4(%rax), %esi
	addq	$5, %rax
	sall	$28, %esi
	orl	%esi, %ecx
	jmp	.L129
.L145:
	movl	%ecx, %eax
	pushq	%rsi
	movl	%edx, %r8d
	subl	%r9d, %eax
	movl	$.LC28, %esi
	pushq	%rax
.L144:
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
	movl	$1, %edi
	call	exit
.L147:
	pushq	%rax
	movl	%ecx, %eax
	movl	%edx, %r8d
	subl	%r9d, %eax
	movl	$.LC30, %esi
	pushq	%rax
	jmp	.L144
.L148:
	call	__stack_chk_fail
	.cfi_endproc
.LFE4653:
	.size	testIdenticalCategoryByteSeq, .-testIdenticalCategoryByteSeq
	.section	.text.unlikely
.LCOLDE32:
	.text
.LHOTE32:
	.section	.rodata.str1.1
.LC33:
	.string	"[%d,%d)-4x1 byte seq\n"
.LC34:
	.string	"---------"
.LC35:
	.string	"[%d,%d)-2x2 byte seq\n"
.LC36:
	.string	"[%d,%d)-1x3 byte seq\n"
.LC37:
	.string	"[%d,%d)-1x4 byte seq\n"
	.section	.text.unlikely
.LCOLDB38:
	.section	.text.startup,"ax",@progbits
.LHOTB38:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB4660:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	xorl	%edi, %edi
	movl	$4, %ebp
	movl	$100000, %ebx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	testIdenticalCategoryByteSeq
	movl	$128, %edi
	call	testIdenticalCategoryByteSeq
	movl	$16384, %edi
	call	testIdenticalCategoryByteSeq
	movl	$2097152, %edi
	call	testIdenticalCategoryByteSeq
	movl	$32, %ecx
	xorl	%edx, %edx
	movl	$.LC33, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
.L150:
	movl	%ebx, %esi
	xorl	%edi, %edi
	leal	(%rbx,%rbx,4), %ebx
	call	benchByCategory
	movl	$.LC34, %edi
	addl	%ebx, %ebx
	call	puts
	subl	$1, %ebp
	jne	.L150
	movl	$32, %ecx
	xorl	%edx, %edx
	movl	$.LC35, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	movl	$4, %ebp
	movl	$100000, %ebx
	call	__printf_chk
.L151:
	movl	%ebx, %esi
	movl	$128, %edi
	leal	(%rbx,%rbx,4), %ebx
	call	benchByCategory
	movl	$.LC34, %edi
	addl	%ebx, %ebx
	call	puts
	subl	$1, %ebp
	jne	.L151
	movl	$2097184, %ecx
	movl	$2097152, %edx
	movl	$.LC36, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	movl	$4, %ebp
	movl	$100000, %ebx
	call	__printf_chk
.L152:
	movl	%ebx, %esi
	movl	$16384, %edi
	leal	(%rbx,%rbx,4), %ebx
	call	benchByCategory
	movl	$.LC34, %edi
	addl	%ebx, %ebx
	call	puts
	subl	$1, %ebp
	jne	.L152
	movl	$2097184, %ecx
	movl	$2097152, %edx
	movl	$.LC37, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	movl	$4, %ebp
	movl	$100000, %ebx
	call	__printf_chk
.L153:
	movl	%ebx, %esi
	movl	$2097152, %edi
	leal	(%rbx,%rbx,4), %ebx
	call	benchByCategory
	movl	$.LC34, %edi
	addl	%ebx, %ebx
	call	puts
	subl	$1, %ebp
	jne	.L153
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE4660:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE38:
	.section	.text.startup
.LHOTE38:
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC0:
	.long	128
	.long	128
	.long	128
	.long	128
	.long	128
	.long	128
	.long	128
	.long	128
	.align 32
.LC1:
	.long	0
	.long	4
	.long	1
	.long	1
	.long	1
	.long	1
	.long	1
	.long	1
	.align 32
.LC2:
	.long	16384
	.long	16384
	.long	16384
	.long	16384
	.long	16384
	.long	16384
	.long	16384
	.long	16384
	.align 32
.LC3:
	.quad	1095216660735
	.quad	1095216660735
	.quad	1095216660735
	.quad	1095216660735
	.align 32
.LC4:
	.quad	545460846719
	.quad	545460846719
	.quad	545460846719
	.quad	545460846719
	.align 32
.LC5:
	.quad	549755814016
	.quad	549755814016
	.quad	549755814016
	.quad	549755814016
	.align 32
.LC6:
	.long	2097152
	.long	2097152
	.long	2097152
	.long	2097152
	.long	2097152
	.long	2097152
	.long	2097152
	.long	2097152
	.align 32
.LC7:
	.long	268435456
	.long	268435456
	.long	268435456
	.long	268435456
	.long	268435456
	.long	268435456
	.long	268435456
	.long	268435456
	.align 32
.LC13:
	.quad	35747867511423103
	.quad	35747867511423103
	.quad	35747867511423103
	.quad	35747867511423103
	.align 32
.LC14:
	.long	4
	.long	5
	.long	6
	.long	7
	.long	0
	.long	1
	.long	2
	.long	3
	.align 32
.LC15:
	.long	0
	.long	0
	.long	0
	.long	0
	.long	1
	.long	0
	.long	0
	.long	0
	.align 32
.LC16:
	.long	2
	.long	0
	.long	0
	.long	0
	.long	3
	.long	0
	.long	0
	.long	0
	.align 32
.LC17:
	.long	4
	.long	0
	.long	0
	.long	0
	.long	5
	.long	0
	.long	0
	.long	0
	.align 32
.LC18:
	.long	6
	.long	0
	.long	0
	.long	0
	.long	7
	.long	0
	.long	0
	.long	0
	.align 32
.LC20:
	.long	0
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6
	.long	7
	.align 32
.LC21:
	.long	8
	.long	9
	.long	10
	.long	11
	.long	12
	.long	13
	.long	14
	.long	15
	.align 32
.LC22:
	.long	16
	.long	17
	.long	18
	.long	19
	.long	20
	.long	21
	.long	22
	.long	23
	.align 32
.LC23:
	.long	24
	.long	25
	.long	26
	.long	27
	.long	28
	.long	29
	.long	30
	.long	31
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC24:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
