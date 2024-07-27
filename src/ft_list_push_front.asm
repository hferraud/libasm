bits 64

%include "t_list.asm"

global ft_list_push_front

extern t_list
extern malloc

; void ft_list_push_front(t_list **head, void *data);

section .text

ft_list_push_front:
	push rdi				; save head
	push rsi				; save data
	mov rdi, 0x10			; malloc() size param ; 2 * 8 bytes = 16
	call malloc	wrt ..plt	; return value stored in rax
	cmp rax, 0				; cmp rax to NULL
	je malloc_error 		; jmp if equal
	pop rsi					; restore data
	pop rdi					; restore head
	mov [rax + data], rsi	; set data
	mov r10, [rdi]			; set next
	mov [rax + next], r10
	mov [rdi], rax			; set *head to new elem
	ret
malloc_error:
	ret
