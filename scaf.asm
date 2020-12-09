.data
	n: .space 4
	format: .asciz "%d"
.text

.global main

main:
	pushl $n
	push $format
	call scanf
	pop %ebx
	pop %ebx
	jmp etexit

etexit:	
	pushl n
	push $format
	call printf
	pop %ebx
	pop %ebx
	
	pushl $0
	call fflush
	pop %ebx
	
	mov $1, %eax
	xor %ebx, %ebx
	int $0x80
	
