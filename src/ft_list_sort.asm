bits 64

%include "t_list.asm"

global ft_list_sort

extern t_list

; void ft_list_sort(t_list **head, int (*cmp)()) {
; 	t_list	*i;
; 	t_list	*j;
; 	t_list	*min;
; 	if (head == NULL || cmp == NULL) {
; 		return;
; 	}
; 	i = *head;
; 	while (i->next) {
; 		j = i->next;
; 		min = i;
; 		while (j) {
; 			if (cmp(min->data, j->data) > 0) {
; 				min = j;
; 			}
; 			j = j->next;
; 		}
; 		swap(i, min);
; 		i = i->next;
; 	}
; }
; 
; rdi	= head
; rsi	= cmp

; i		= [rsp]
; j		= [rsp + 8]
; min	= [rsp + 16]

section .text

ft_list_sort:
	; prologue
	sub rsp, 24				; room for 3 ptr
	; tests
	test rdi, rdi
	jz exit					; jump if head is NULL
	test rdx, rdx
	jz exit					; jump if cmp is NULL
	mov rax, [rdi]
	mov [rsp], rax			; i = *head
loop_i:
	mov rax, [rsp]
	mov rax, [rax + next]
	test rax, rax
	jz exit					; jump if i->next is NULL
	mov rax, [rsp]
	mov rax, [rax + next] 
	mov [rsp + 8], rax		; j = i->next
	mov rax, [rsp]
	mov [rsp + 16], rax		; min = i 
loop_j:
	mov rax, [rsp + 8]
	test rax, rax
	jz end_loop_j			; jump if j is NULL
	; cmp proloque
	push rdi
	push rsi
	; cmp call
	mov rax, rsi
	mov rdi, [rsp + 16 + 16]
	mov rdi, [rdi + data]	; rdi = min->data
	mov rsi, [rsp + 8 + 16]
	mov rsi, [rsi + data]	; rsi = j->data
	call rax
	; cmp epilogue
	pop rsi
	pop rdi
	cmp rax, 0
	jbe iterate_loop_j		; jump if rax is non positive
	mov rax, [rsp + 8]
	mov [rsp + 16], rax		; min = j
iterate_loop_j:
	mov rax, [rsp + 8]
	mov rax, [rax + next]
	mov [rsp + 8], rax		; j = j->next
	jmp loop_j
end_loop_j:
	; swap prologue
	push rdi
	push rsi
	; swap call
	mov rdi, [rsp + 16]
	mov rsi, [rsp + 16 + 16]
	call swap
	; swap epilogue
	pop rsi
	pop rdi
	mov rax, [rsp]
	mov rax, [rax + next]
	mov [rsp], rax			; i = i->next
	jmp loop_i
exit:
	add rsp, 24				; free stack
	ret

; void swap(t_list *lhs, t_list *rhs) {
; 	void *tmp;
; 
; 	tmp = lhs->data;
; 	lhs->data = rhs->data;
; 	rhs->data = tmp;
; }

; rdi	= lhs
; rsi	= rhs

; tmp	= [rsp]
	
swap:
	sub rsp, 8				; prologue
	mov rax, [rdi + data]
	mov [rsp], rax			; tmp = lhs->data
	mov rax, [rsi + data]
	mov [rdi + data], rax	; lhs->data = rhs->data 
	mov rax, [rsp]
	mov [rsi + data], rax	; rhs->data = tmp
	add rsp, 8				; epilogue
	ret

