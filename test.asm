.data
	n: .long 6
	formatd: .asciz "%d"
	formats: .asciz "%s"
	msg: .asciz "host index "
	psv: .asciz "; "
.text

.global main

main:
	push $msg
	pushl $formats
	call printf
	popl %ebx
	
	pushl $0
	call fflush
	popl %ebx
	
	pushl n
	pushl $formatd
	call printf
	popl %ebx
	popl %ebx
	
	pushl $0
	call fflush
	popl %ebx
	
	push $psv
	pushl $formats
	call printf
	popl %ebx
	
	pushl $0
	call fflush
	popl %ebx
		
	mov $1, %eax
	mov $0, %ebx
	int $0x80
