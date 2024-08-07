bits 64
global ft_write
extern __errno_location

; ssize_t ft_write(int fd, const void *buf, size_t count);

section .text

ft_write:
	mov rax, 1						; write() syscall number
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
