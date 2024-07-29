#include <errno.h>
#include <string.h>

#include "libasm.h"
#include "utest.h"

void swap(t_list *lhs, t_list *rhs);

void ft_list_sort(t_list **head, int (*cmp)()) {
	t_list	*i;
	t_list	*j;
	t_list	*min;
	if (head == NULL || cmp == NULL) {
		return;
	}
	i = *head;
	while (i->next) {
		j = i->next;
		min = i;
		while (j) {
			if (cmp(min->data, j->data) > 0) {
				min = j;
			}
			j = j->next;
		}
		swap(i, min);
		i = i->next;
	}
}

void swap(t_list *lhs, t_list *rhs) {
	void *tmp;

	tmp = lhs->data;
	lhs->data = rhs->data;
	rhs->data = tmp;
}

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
  	ft_list_sort(&list, strcmp);
	head = list;
	head = list;
  	while (list->next) {
		ASSERT_LT(strcmp(list->data, list->next->data), 0);
		list = list->next;
  	}
	ASSERT_EQ(0, 0);
	list = head;
	while (list) {
		next = list->next;
  		free(list->data);
  		free(list);
		list = next;
	}
}

