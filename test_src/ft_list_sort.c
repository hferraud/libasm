#include <errno.h>
#include <string.h>

#include "libasm.h"
#include "utest.h"

UTEST(ft_list_sort, valid_list) {
	t_list	*next;
	char	*data;
  	t_list	*list = NULL;

  	data = strdup("2");
  	ft_list_push_front(&list, data);
  	data = strdup("3");
  	ft_list_push_front(&list, data);
  	data = strdup("1");
  	ft_list_push_front(&list, data);
  	ft_list_sort(&list, strcmp);
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

UTEST(ft_list_sort, valid_single_elem) {
	t_list	*list = NULL;
	char	*data = strdup("test");

	ft_list_push_front(&list, data);
	ft_list_sort(&list, strcmp);
	ASSERT_NE(list, NULL);
	ASSERT_STREQ(list->data, "test");
	ASSERT_EQ(list->next, NULL);
	ASSERT_EQ(errno, 0);
	free(data);
	free(list);
}


UTEST(ft_list_sort, valid_double_elem) {
	t_list	*list = NULL;
	t_list	*next;
	char	*data1 = strdup("test1");
	char	*data2 = strdup("test2");

	ft_list_push_front(&list, data1);
	ft_list_push_front(&list, data2);
	ft_list_sort(&list, strcmp);
	ASSERT_EQ(errno, 0);
	ASSERT_NE(list, NULL);
	ASSERT_STREQ(list->data, data1);
	next = list->next;
	free(list);
	list = next;
	ASSERT_NE(list, NULL);
	ASSERT_STREQ(list->data, data2);
	ASSERT_EQ(list->next, NULL);
	free(list);
	free(data1);
	free(data2);
}

UTEST(ft_list_sort, null_list) {
	t_list	*list = NULL;

	ft_list_sort(&list, strcmp);
	ASSERT_EQ(list, NULL);
	ASSERT_EQ(errno, 0);
}

UTEST(ft_list_sort, null_cmp) {
	t_list	*list = NULL;
	char	*data = strdup("test");

	ft_list_push_front(&list, data);
	ft_list_sort(&list, NULL);
	ASSERT_NE(list, NULL);
	ASSERT_STREQ(list->data, "test");
	ASSERT_EQ(errno, 0);
	free(data);
	free(list);
}

int my_strcmp(const void *s1, const void *s2) {
	if (s1 == NULL || s2 == NULL) {
		return 1;
	}
	return strcmp(s1, s2);
}

UTEST(ft_list_sort, null_data) {
	t_list	*list = NULL;
	t_list	*next;

	ft_list_push_front(&list, NULL);
	ft_list_push_front(&list, NULL);
	ft_list_push_front(&list, NULL);
	ft_list_sort(&list, my_strcmp);
	ASSERT_NE(list, NULL);
	ASSERT_EQ(errno, 0);
	while (list) {
		next = list->next;
		ASSERT_EQ(list->data, NULL);
		free(list);
		list = next;
	}
}

