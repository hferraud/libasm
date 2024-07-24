bits 64
global ft_strcpy

section .text

; char *ft_strcpy(char *dst, char *src);

ft_strcpy:
	mov rax, rdi		; set return value to dst
loop:
	mov bl, [rsi]		; mov *src to rbx lower 8-bit bl
	cmp bl, 0			; cmp *src to '\0'
	je end_loop			; jmp if equal
	mov byte [rdi], bl	; *dst = *src
	inc rsi				; src++
	inc rdi				; dst++
	jmp loop
end_loop:
	mov byte [rdi], 0	; *dst = '\0'
	ret
