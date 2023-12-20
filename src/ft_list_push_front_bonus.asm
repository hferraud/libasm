bits 64
%include "t_list.asm"
extern t_list
extern MALLOC

; void ft_list_push_front(t_list **head, void *data);

section .text
	global ft_list_push_front

ft_list_push_front:
	push rdi				; save head
	push rsi				; save data
	mov rdi, 0x10			; malloc() size param ; 2 * 8 bytes = 16
	call MALLOC wrt ..plt	; return value stored in rax
	cmp rax, 0				; cmp rax to NULL
	je malloc_error 		; jmp if equal
	pop rbx					; restore data in rbx
	mov [rax + data], rbx	; set data field
	pop rbx					; restore head in rbx
	mov rcx, [rbx]			; dereference **head in rcx
	mov [rax + next], rcx	; set next field
	mov [rbx], rax			; set *head to new elem
malloc_error:
	ret
