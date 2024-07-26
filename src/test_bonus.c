#include "libasm.h"
#include <stdio.h>
#include <string.h>

int main(void) {
	printf("\nTESTING FT_LIST_REMOVE_IF:\n\n");
	{
		t_list	*head;
		t_list	*tmp;
		char 	*data1;
		char 	*data2;
		char 	*data3;
		char 	*data;

		head = NULL;
		data1 = strdup("yo");
		data2 = strdup("oy");
		data3 = strdup("yoy");
		ft_list_push_front(&head, data1);
		ft_list_push_front(&head, data2);
		ft_list_push_front(&head, data3);
		data = strdup("oy");
		ft_list_remove_if(&head, data, *strcmp, *free);
		tmp = NULL;
		ft_list_remove_if(&tmp, data, *strcmp, *free);
		free(data);
		while (head) {
			printf("Elem: %s\n", (char *)(head->data));
			tmp = head->next;
			free(head->data);
			free(head);
			head = tmp;
		}
	}
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
	printf("\nTESTING FT_LIST_SIZE:\n\n");
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
		printf("Size: %zu\n", ft_list_size(head));
		printf("Size: %zu\n", ft_list_size(NULL));
		while (head) {
			tmp = head->next;
			free(head);
			head = tmp;
		}
	}
}
