#include "libasm.h"
#include <stdio.h>

int main(void) {
	/**
	 * FT_LIST_PUSH_FRONT
	 */
	printf("\nTESTING FT_LIST_PUSH_FRONT:\n\n");
	{
		t_list	*head;
		t_list	*tmp;
		int 	data1;
		int 	data2;
		int 	data3;

		head = NULL;
		data1 = 1;
		data2 = 2;
		data3 = 3;
		ft_list_push_front(&head, &data1);
		ft_list_push_front(&head, &data2);
		ft_list_push_front(&head, &data3);
		while (head) {
			printf("Elem: %d\n", *((int *)(head->data)));
			tmp = head->next;
			free(head);
			head = tmp;
		}
	}
}
