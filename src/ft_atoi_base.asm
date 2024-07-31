bits 64

global ft_atoi_base

extern ft_strlen

section .data:
	whitespace_charset		db ' \t\v\n\r\f', 0
	invalid_base_charset	db ' \t\v\n\r\f+-', 0

section .text

; rdi		= str
; rsi		= base

; result	= [rsp]
; sign		= [rsp + 8]
; base_len	= [rsp + 16]

ft_atoi_base:
	; prologue
	sub rsp, 20					; room for int, long, size_t, char*
	test rsi, rsi
	jz exit_error				; jump if str == NULL
	test rdi, rdi
	jz exit_error				; jump if base == NULL
	; ft_strlen prologue
	push rdi
	push rsi
	; ft_strlen call
	mov rdi, rsi
	call ft_strlen
	; ft_strlen epilogue 
	pop rsi
	pop rdi
	mov [rsp + 16], rax			; base_len = ft_strlen(base)
	mov rdi, rsi
	mov rsi, rax
	call ft_valid_base

; bool ft_strctn(char *str, char c);

; rdi		= str
; rsi		= c

ft_strctn:
	mov rax, [rdi]
	test rax, rax
	jz ft_strctn_exit_false
	cmp rax, rsi
	je ft_strctn_exit_true
	inc rdi
	jmp ft_strctn
ft_strctn_exit_true:
	mov rax, 1
	ret
ft_strctn_exit_false:
	xor rax, rax
	ret

; bool ft_valid_base(char *base, size_t len);

; rdi		= base
; rsi		= len

; i = [rsp]
; j = [rsp + 4]

ft_valid_base:
	; prologue
	sub rsp, 8
	; tests
	cmp rsi, 1
	jbe ft_valid_base__exit_false	; jump if rsi <= 1
	movzx dword [rsp], 0			; i = 0
ft_valid_base__loop_i:
	mov rax, dword [rsp]			; rax = i
	movzx rax, byte [rdi + rax]		; rax = base[i] zero extended
	test rax, rax
	jz ft_valid_base__exit_true		; jump if base[i] == 0
	; ft_strctn prologue
	push rdi
	push rsi
	; ft_strctn call
	mov rsi, rax
	mov rdi, invalid_base_charset 
	call ft_strctn
	; ft_strctn epilogue
	pop rsi
	pop rdi
	test rax, rax
	jz ft_valid_base__exit_false	; jump if rax == false
	movzx dword [rsp + 4], 0		; j = 0
ft_valid_base__loop_j:
	mov rax, dword [rsp + 4]		; rax = j
	movzx rax, byte [rdi + rax]		; rax = base[j] zero extended
	test rax, rax
	jz ft_valid_base__end_loop_j	; jump if base[j] == 0
	
ft_valid_base__end_loop_j:
	
ft_valid_base__exit_false:
	xor rax, rax
	jmp exit
ft_valid_base__exit_true:
	mov rax, 1
	jmp exit
exit:
	; epilogue
	add rsp, 8
	ret
