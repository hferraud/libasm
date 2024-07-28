/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_remove_if.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tdameros <tdameros@student.42lyon.fr>      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/04 17:28:00 by tdameros          #+#    #+#             */
/*   Updated: 2024/07/28 17:51:15 by hferraud         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <string.h>

#include "libasm.h"
#include "utest.h"

UTEST(ft_list_remove_if, null_list_ptr) {
  t_list **list_ptr = NULL;
  ft_list_remove_if(list_ptr, "Hello, World!", strcmp, free);
  ASSERT_EQ(list_ptr, NULL);
  ASSERT_EQ(errno, 0);
}

UTEST(ft_list_remove_if, null_list) {
  t_list *list = NULL;
  ft_list_remove_if(&list, "Hello, World!", strcmp, free);
  ASSERT_EQ(list, NULL);
  ASSERT_EQ(errno, 0);
}

static int my_strcmp(const void *s1, const void *s2) {
  if (s1 == NULL || s2 == NULL) {
    return 1;
  }
  return strcmp(s1, s2);
}

UTEST(ft_list_remove_if, null_data_ref) {
  t_list *list = NULL;
  char *data = strdup("Hello, World!");
  ft_list_push_front(&list, data);
  ft_list_remove_if(&list, NULL, my_strcmp, free);
  ASSERT_NE(list, NULL);
  ASSERT_NE(list->data, NULL);
  ASSERT_EQ(list->next, NULL);
  free(list);
  free(data);
  ASSERT_EQ(errno, 0);
}

UTEST(ft_list_remove_if, null_cmp) {
  t_list *list = ft_create_elem(NULL);
  ft_list_remove_if(&list, "Hello, World!", NULL, free);
  ASSERT_EQ(list->data, NULL);
  ASSERT_EQ(list->next, NULL);
  free(list);
  ASSERT_EQ(errno, 0);
}

UTEST(ft_list_remove_if, null_free_fct) {
  t_list *list = NULL;
  char *data = strdup("Hello, World!");
  ft_list_push_front(&list, data);
  ft_list_remove_if(&list, "Hello!", strcmp, NULL);
  ASSERT_NE(list, NULL);
  ASSERT_NE(list->data, NULL);
  ASSERT_EQ(list->next, NULL);
  free(list);
  free(data);
  ASSERT_EQ(errno, 0);
}

UTEST(ft_list_remove_if, null_free_fct_with_remove) {
  t_list *list = NULL;
  char *data = strdup("Hello, World!");
  ft_list_push_front(&list, data);
  ft_list_remove_if(&list, "Hello, World!", strcmp, NULL);
  ASSERT_EQ(list, NULL);
  free(data);
  ASSERT_EQ(errno, 0);
}

UTEST(ft_list_remove_if, single_node) {
  char *data = strdup("42");
  t_list *list = ft_create_elem(data);
  ft_list_remove_if(&list, "Hello, World!", strcmp, free);
  ASSERT_STREQ(list->data, "42");
  ASSERT_EQ(list->next, NULL);
  free(data);
  free(list);
  ASSERT_EQ(errno, 0);
}

UTEST(ft_list_remove_if, single_node_remove) {
  char *data = strdup("Hello, World!");
  t_list *list = ft_create_elem(data);
  ft_list_remove_if(&list, "Hello, World!", strcmp, free);
  ASSERT_EQ(list, NULL);
  ASSERT_EQ(errno, 0);
}

UTEST(ft_list_remove_if, multiple_nodes) {
  char *data1 = strdup("Hello, World!");
  char *data2 = strdup("Hello, 42!");
  char *data3 = strdup("Hello, 21!");
  t_list *list = NULL;
  ft_list_push_front(&list, data1);
  ft_list_push_front(&list, data2);
  ft_list_push_front(&list, data3);
  ft_list_remove_if(&list, "Hello, 42!", strcmp, free);
  ASSERT_STREQ(list->data, "Hello, 21!");
  ASSERT_STREQ(list->next->data, "Hello, World!");
  ASSERT_EQ(list->next->next, NULL);
  free(data1);
  free(data3);
  free(list->next);
  free(list);
  ASSERT_EQ(errno, 0);
}

UTEST(ft_list_remove_if, full_remove_with_multiple_nodes) {
  char *data1 = strdup("Hello, World!");
  char *data2 = strdup("Hello, World!");
  char *data3 = strdup("Hello, World!");
  t_list *list = NULL;
  ft_list_push_front(&list, data1);
  ft_list_push_front(&list, data2);
  ft_list_push_front(&list, data3);
  ft_list_remove_if(&list, "Hello, World!", strcmp, free);
  ASSERT_EQ(list, NULL);
  ASSERT_EQ(errno, 0);
}
