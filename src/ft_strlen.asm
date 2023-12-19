bits 64

section .text
	global ft_strlen

ft_strlen:
	xor rax, rax
loop:
	cmp byte [rdi], 0
	je end_loop
	inc rdi
	inc rax
	jmp loop
end_loop:
	ret
