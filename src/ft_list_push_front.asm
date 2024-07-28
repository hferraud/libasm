bits 64

%include "t_list.asm"

global ft_list_push_front

extern t_list
extern ft_create_elem

; void ft_list_push_front(t_list **head, void *data);

section .text

ft_list_push_front:
	ret
	test rdi, rdi
	jz exit 				; exit if head is NULL
	; ft_create_elem prologue
	push rdi
	push rsi
	; call ft_create_elem
	mov rdi, rsi			; set data parameter
	call ft_create_elem
	; ft_create_elem epilogue
	pop rsi
	pop rdi
	test rax, rax
	jz exit					; exit if malloc returned NULL
	mov rsi, [rdi]
	mov [rax + next], rsi	; elem->next = *head
	mov [rdi], rax			; set *head to new elem
	ret
exit:
	ret
