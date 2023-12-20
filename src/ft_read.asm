bits 64
extern __errno_location

; ssize_t ft_read(int fd, const void *buf, size_t count);

section .text
	global ft_read

ft_read:
	mov rax, 0						; read syscall number
	syscall							; return value stored in rax
	test rax, rax					; set SF to 1 if rax < 0
	js error_handler				; jump if SF == 1
	ret
error_handler:
	neg rax							; error code
	push rax						; save rax
	call __errno_location wrt ..plt ; errno address returned in rax
	pop rbx							; pop error code in rbx
	mov [rax], rbx					; set errno to error code
	mov rax, -1						; set return value to -1
	ret