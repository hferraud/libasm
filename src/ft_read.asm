bits 64
extern __errno_location

section .text
	global ft_read

ft_read:
	mov rax, 0
	syscall
	test rax, rax
	js error_handler
	ret
error_handler:
	neg rax
	push rax
	call __errno_location wrt ..plt
	pop rbx
	mov [rax], rbx
	mov rax, -1
	ret