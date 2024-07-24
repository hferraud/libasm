bits 64
global ft_strcmp

section .text

; int ft_strcmp(char *s1, char *s2);

ft_strcmp:
	xor rax, rax	; set rax to 0
	xor rbx, rbx	; set rbx to 0
loop:
	mov al, [rdi]	; mov *s1 to lower 8-bit rax
	mov bl, [rsi]	; mov *s2 to lower 8-bit rbx
	cmp al, 0		; cmp *s1 to '\0'
	je end_loop		; jmp if equal
	cmp al, bl		; cmp *s1 to *s2
	jne end_loop	; jmp if not equal
	inc rdi			; s1++
	inc rsi			; s2++
	jmp loop
end_loop:
	sub rax, rbx	; sub *s2 to *s1
	ret
