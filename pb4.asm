.data
	x: .long 144
	format1: .asciz "%d "
	format2: .asciz "%d\n"
	aux: .space 4
	numar: .space 4
.text

.global main

div:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	movl %eax, aux
	movl $1, numar
	
	while: 
		movl aux, %eax
		movl numar, %ecx
		cmp %eax, %ecx
		je final
		
		movl $0, %edx
		divl %ecx
		cmp $0, %edx
		je afis
		jne cont
		
		afis:
			pushl numar
			pushl $format1
			call printf
			popl %ebx
			popl %ebx
			
			pushl $0
			call fflush
			popl %ebx
			
		cont:
			incl numar
			jmp while
	
	final:
		pushl numar
		pushl $format2
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
	call div
	popl %ebx
exit:
	movl $1, %eax
	xor %ebx, %ebx
	int $0x80
