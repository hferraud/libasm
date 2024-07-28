bits 64

%include "t_list.asm"

global ft_create_elem

extern malloc
extern t_list

; t_list *ft_create_elem(void *data);

section .text

ft_create_elem:
	push rdi				; save data
	mov rdi, 0x10			; size = 2 * 8 bytes = 16
	call malloc wrt ..plt
	pop rdi					; restore data
	test rax, rax			; set ZF if rax == 0
	jz exit					; jmp if malloc returned NULL
	mov [rax + data], rdi	; elem->data = data
	mov qword [rax + next], 0	; elem->next = NULL
exit:
	ret
