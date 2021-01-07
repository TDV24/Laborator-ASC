.data
	x: .long 10
	format: .asciz "%d\n"
	cont: .space 4
.text

.global main
 
 biti:
 	pushl %ebp
 	movl %esp, %ebp
 	movl 8(%ebp), %eax
 	movl $0, cont
 	
 	while:
 		cmp $0, %eax
 		je afis
 		
 		movl $0, %edx
 		movl $2, %ebx
 		divl %ebx
 		
 		cmp $1, %edx
 		je creste
 		jne continuare
 		
 		creste:
 			incl cont
 			jmp continuare
 		continuare:
 			jmp while
 	
 	afis:
 		pushl cont
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
 	call biti
 	popl %ebx
 
 exit:
 	movl $1, %eax
 	xor %ebx, %ebx
 	int $0x80
