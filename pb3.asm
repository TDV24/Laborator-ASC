.data
	x: .long 27
	nr: .space 4
	nrd: .space 4
	inv: .space 4
	format: .asciz "%d\n"
.text

.global main

pal:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, nr
	movl %eax, nrd
	movl $0, inv
	
	while:
		movl nrd, %eax
		cmp $0, %eax
		je verif
		
		movl $0, %edx
		movl inv, %eax
		movl $10, %ebx
		mull %ebx
		movl %eax, inv
		
		movl $0, %edx
		movl nrd, %eax
		movl $10, %ebx
		divl %ebx
		
		addl %edx, inv
		movl %eax, nrd
		jmp while
	
	verif:
		movl nr, %eax
		movl inv, %ecx
		cmp %ecx, %eax
		je af1
		jne af0
	
	af1:
		movl $1, %eax
		jmp final
	af0:
		movl $0, %eax
		jmp final
	final:
		popl %ebp
		ret
		

main:
	pushl x
	call pal
	popl %ebx
	
	pushl %eax
	pushl $format
	call printf
	popl %ebx
	popl %ebx
	
	pushl $0
	call fflush
	popl %ebx

exit:
	movl $1, %eax
	xor %ebx, %ebx
	int $0x80	
