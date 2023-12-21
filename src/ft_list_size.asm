bits 64
%include "t_list.asm"
extern t_list
extern MALLOC

; ssize_t ft_list_size(t_list *head);

section .text
	global ft_list_size

ft_list_size:
	xor rax, rax			; set rax to 0
loop:
	cmp rdi, 0				; cmp head to NULL
	je exit					; jump if equal
	mov rbx, [rdi + next]	; mov head->next to rbx
	mov rdi, rbx			; head = head->next
	inc rax					; count++
	jmp loop
exit:
	ret
