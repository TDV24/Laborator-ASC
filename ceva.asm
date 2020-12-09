.data	
	str : .asciz "Sir\n"
.text

.globl _start

_start:
	mov $4, %eax
	mov $1, %ebx
	mov $str, %ecx
	mov $4, %edx
	int $0x80
etexit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80
