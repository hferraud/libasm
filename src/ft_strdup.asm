bits 64
extern malloc
extern ft_strlen
extern ft_strcpy

section .text
	global ft_strdup

ft_strdup:
	push rdi
	call ft_strlen
	inc rax
	mov rdi, rax
	call malloc wrt ..plt
	cmp rax, 0
	je _malloc_error
	pop rsi
	mov rdi, rax
	call ft_strcpy

_malloc_error:
	ret