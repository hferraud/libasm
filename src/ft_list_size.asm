bits 64
%include "t_list.asm"
global ft_list_size
extern t_list
extern MALLOC

; ssize_t ft_list_size(t_list *head);

section .text

ft_list_size:
	push rbx				; save rbx
	xor rax, rax			; set rax to 0
loop:
	cmp rdi, 0				; cmp head to NULL
	je exit					; jump if equal
	mov rbx, [rdi + next]	; mov head->next to rbx
	mov rdi, rbx			; head = head->next
	inc rax					; count++
	jmp loop
exit:
	pop rbx					; restore rbx
	ret
