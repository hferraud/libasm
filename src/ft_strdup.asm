bits 64
extern malloc
extern ft_strlen
extern ft_strcpy

; char *ft_strdup(const char *str);

section .text
	global ft_strdup

ft_strdup:
	push rdi				; save str
	call ft_strlen			; return value stored in rax
	inc rax					; len += 1 for '\0'
	mov rdi, rax			; malloc() size param
	call malloc wrt ..plt	; return value stored in rax
	cmp rax, 0				; cmp return value to NULL
	je _malloc_error		; jmp if equal
	pop rsi					; ft_strcpy() src param
	mov rdi, rax			; ft_strcpy() dst param
	call ft_strcpy			; return value stored in rax

_malloc_error:
	ret