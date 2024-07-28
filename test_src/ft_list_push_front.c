#include <errno.h>
#include <string.h>

#include "libasm.h"
#include "utest.h"

UTEST(ft_list_push_front, null_list) {
  t_list *list = NULL;
  char *data = strdup("Hello, World!");
  ft_list_push_front(&list, data);
  ASSERT_EQ(list->data, data);
  ASSERT_EQ(list->next, NULL);
  free(data);
  free(list);
}

UTEST(ft_list_push_front, non_null_list) {
  char *data1 = strdup("Hello, World!");
  char *data2 = strdup("Hello, 42!");
  t_list *list = ft_create_elem(data1);
  ft_list_push_front(&list, data2);
  ASSERT_EQ(list->data, data2);
  ASSERT_EQ(list->next->data, data1);
  ASSERT_EQ(list->next->next, NULL);
  free(data1);
  free(data2);
  free(list->next);
  free(list);
}

UTEST(ft_list_push_front, multiple_elems) {
  char *data1 = strdup("Hello, World!");
  char *data2 = strdup("Hello, 42!");
  char *data3 = strdup("Hello, 21!");
  t_list *list = ft_create_elem(data1);
  ft_list_push_front(&list, data2);
  ft_list_push_front(&list, data3);
  ASSERT_EQ(list->data, data3);
  ASSERT_EQ(list->next->data, data2);
  ASSERT_EQ(list->next->next->data, data1);
  ASSERT_EQ(list->next->next->next, NULL);
  free(data1);
  free(data2);
  free(data3);
  free(list->next->next);
  free(list->next);
  free(list);
}

UTEST(ft_list_push_front, null_data) {
  t_list *list = NULL;
  ft_list_push_front(&list, NULL);
  ASSERT_EQ(list->data, NULL);
  ASSERT_EQ(list->next, NULL);
  free(list);
}

UTEST(ft_list_push_front, null_list_null_data) {
  t_list *list = NULL;
  ft_list_push_front(&list, NULL);
  ASSERT_EQ(list->data, NULL);
  ASSERT_EQ(list->next, NULL);
  free(list);
}

UTEST(ft_list_push_front, null_list_pointer) {
  ft_list_push_front(NULL, NULL);
  ASSERT_NE(errno, EFAULT);
}
