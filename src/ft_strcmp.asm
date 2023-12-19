bits 64

section .text
	global ft_strcmp

ft_strcmp:
	xor rax, rax
	xor rbx, rbx
loop:
	mov al, [rdi]
	mov bl, [rsi]
	cmp al, 0
	je end_loop
	cmp al, bl
	jne end_loop
	inc rdi
	inc rsi
	jmp loop
end_loop:
	sub rax, rbx
	ret
