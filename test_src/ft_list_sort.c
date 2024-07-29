#include <errno.h>
#include <string.h>

#include "libasm.h"
#include "utest.h"

UTEST(ft_list_sort, valid_list) {
	t_list	*next;
	t_list	*head;
	char	*data;
  	t_list	*list = NULL;

  	data = strdup("2");
  	ft_list_push_front(&list, data);
  	data = strdup("3");
  	ft_list_push_front(&list, data);
  	data = strdup("1");
  	ft_list_push_front(&list, data);
	head = list;
	// while (list) {
	// 	printf("Elem: %s\n", (char*)list->data);
	// 	list = list->next;
	// }
	list = head;
  	ft_list_sort(&list, strcmp);
	while (list) {
		printf("Elem: %s\n", (char*)list->data);
		list = list->next;
	}
	list = head;
  	while (list->next) {
		next = list->next;
		ASSERT_LT(strcmp(list->data, next->data), 0);
  		free(list->data);
  		free(list);
		list = next;
  	}
  	free(list->data);
  	free(list);
}

