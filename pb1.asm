.data
	x: .long 25
	nr: .space 4
	nr1: .space 4
	putere: .space 4
	format: .asciz "%d\n"
	
.text

.global main

fct:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, nr
	movl $0, putere
	movl $1, %eax
	
	while:
		movl nr, %ecx
		cmp %eax, %ecx
		jbe afis
		
		movl $2, %ebx
		mull %ebx
		
		incl putere
		jmp while
	
	afis:
		pushl putere
		pushl $format
		call printf
		popl %ebx
		popl %ebx
		
		pushl $0
		call fflush
		popl %ebx
	
	popl %ebp
	ret
	 
main:
	pushl x
	call fct
	popl %ebx
	
exit:
	movl $1, %eax
	xor %ebx, %ebx
	int $0x80
	
