bits 64

section .text
	global ft_strcpy

ft_strcpy:
	mov rax, rdi
loop:
	mov bl, [rsi]
	cmp bl, 0
	je end_loop
	mov byte [rdi], bl
	inc rsi
	inc rdi
	jmp loop
end_loop:
	mov byte [rdi], 0
	ret
