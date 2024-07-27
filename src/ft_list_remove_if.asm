bits 64

%include "t_list.asm"

global ft_list_remove_if

extern t_list
extern free

;void ft_list_remove_if(t_list **head, void *data, int(*cmp)(), void(*free_fct)(void *)) {
;	t_list	*iterator;
;	t_list	*prev;
;
;	iterator = *head;
;	prev = NULL;
;	while (iterator) {
;		if (cmp(iterator->data, data) == 0) {
;			if (prev != NULL) {
;				prev->next = iterator->next;
;			} else {
;				*head = iterator->next;
;			}
;			if (free_fct) {
;				free_fct(iterator->data);
;			}
;			free(iterator);
;			iterator = prev ? prev->next : *head;
;		} else {
;			prev = iterator;
;			iterator = iterator->next;
;		}
;	}
;}

section .text

; rdi = head
; rsi = data
; rdx = cmp
; rcx = free_fct

; iterator	= [rsp]
; prev		= [rsp + 8]

ft_list_remove_if:
	; prologue
	push rbx				; save rbx
	sub rsp, 16				; room for local variables
	mov rax, [rdi]			; move *head in rax
	mov [rsp], rax		; iterator = *head
	mov qword [rsp + 8], 0	; prev = NULL
loop:
	mov rax, [rsp]		; rax = iterator
	test rax, rax			; set ZF to 1 if rax == 0
	jz exit					; jump if ZF == 1
	; save callee-owned registers
	push rdi
	push rsi
	push rdx
	push rcx
	; call cmp
	mov rax, [rsp + 32]
	mov rdi, [rax + data]	; set first argument
	call rdx
	; restore callee-owned registers
	pop rcx
	pop rdx
	pop rsi
	pop rdi
	; use cmp function argument
	test rax, rax			; set ZF to 1 if rax == 0
	jnz cmp_fct_nz		; jump if ZF == 0
	cmp qword [rsp + 8], 0	; cmp prev to NULL
	je prev_null			; jmp if equal
prev_not_null:
	mov rax, [rsp]		; rax = iterator
	mov rax, [rax + next]	; rax = iterator->next
	mov rbx, [rsp + 8]		; rbx = prev
	mov [rbx + next], rax	; prev->next = iterator->next
	jmp free_data
prev_null:
	mov rax, [rsp]		; rax = iterator
	mov rax, [rax + next]	; rax = iterator->next
	mov [rdi], rax			; *head = iterator->next
free_data:
	cmp qword [rcx], 0		; cmp free_fct to NULL
	je free_elem			; jmp if equal
	; save callee-owned registers
	push rdi
	push rsi
	push rdx
	push rcx
	; call free_fct
	mov rdi, [rsp + 32]		; rdi = iterator
	mov rdi, [rdi + data]	; rdi = iterator->data
	call rcx
free_elem:
	; call free
	mov rdi, [rsp + 32]		; rdi = iterator
	call free wrt ..plt
	; restore callee-owned registers
	pop rcx
	pop rdx
	pop rsi
	pop rdi
iterate_loop:
	mov rax, [rsp + 8]		; rax = prev
	test rax, rax			; set ZF to 1 if rax == 0
	jz head_of_list			; jump if ZF == 1
	mov rax, [rax + next]	; rax = prev->next
	mov [rsp], rax		; iterator = prev->next
	jmp loop
head_of_list:
	mov rax, [rdi]			; rax = *head
	mov [rsp], rax		; iterator = *head
	jmp loop

cmp_fct_nz:
	mov rax, [rsp]		; rax = iterator
	mov [rsp + 8], rax		; prev = iterator
	mov rax, [rax + next]	; rax = iterator->next
	mov [rsp], rax		; iterator = iterator->next
	jmp loop
exit:
	; epilogue
	add rsp, 16
	pop rbx
	ret

