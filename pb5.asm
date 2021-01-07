.data
	x: .long 6
	n: .space 4
	a: .space 4
	b: .space 4
	c: .space 4
	index: .space 4
	format: .asciz "%d\n"

.text

.global main

fib: 
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, n
	
	cmp $0, %eax
	je af0
	
	cmp $1, %eax
	je af1
	jne af
	
	af0:
		pushl $0
		pushl $format
		call printf
		popl %ebx
		popl %ebx
		
		pushl $0
		call fflush
		popl %ebx
		
		jmp final1
	
	af1:
		pushl $1
		pushl $format
		call printf
		popl %ebx
		popl %ebx
		
		pushl $0
		call fflush
		popl %ebx
		
		jmp final1
		
	af:
		movl $0, a
		movl $1, b
		movl $1, index
		movl n, %eax
		
	while:
		movl index, %ecx
		cmp %ecx, %eax
		je final
		
		movl a, %edx
		addl b, %edx
		movl %edx, c
		movl b, %ebx
		movl %ebx, a
		movl c, %ebx
		movl %ebx, b
		
		incl index
		jmp while
	
	final:
		pushl c
		pushl $format
		call printf
		popl %ebx
		popl %ebx
		jmp final1
		
	final1:
		popl %ebp
		ret
		
			

main:
	pushl x
	call fib
	popl %ebx

exit:
	movl $1, %eax
	xor %ebx, %ebx
	int $0x80
