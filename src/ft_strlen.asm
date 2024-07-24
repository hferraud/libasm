bits 64
global ft_strlen

section .text

; size_t ft_strlen(char *str);

ft_strlen:
	xor rax, rax		; set count to 0
loop:
	cmp byte [rdi], 0	; cmp *str to '\0'
	je end_loop			; jmp if equal
	inc rdi				; str++
	inc rax				; count++
	jmp loop
end_loop:
	ret
