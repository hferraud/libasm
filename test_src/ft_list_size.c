/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_read.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tdameros <tdameros@student.42lyon.fr>      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/04 17:28:00 by tdameros          #+#    #+#             */
/*   Updated: 2024/04/04 17:28:00 by tdameros         ###   ########lyon.fr   */
/*                                                                            */
/* ************************************************************************** */

#include <string.h>

#include "libasm.h"
#include "utest.h"

UTEST(ft_list_size, null_list) {
  t_list *list = NULL;
  ASSERT_EQ(ft_list_size(list), 0);
}

UTEST(ft_list_size, one_elem) {
  char *data = strdup("Hello, World!");
  t_list *list = ft_create_elem(data);
  ASSERT_EQ(ft_list_size(list), 1);
  free(data);
  free(list);
}

UTEST(ft_list_size, multiple_elems) {
  char *data1 = strdup("Hello, World!");
  char *data2 = strdup("Hello, 42!");
  char *data3 = strdup("Hello, 21!");
  t_list *list = ft_create_elem(data1);
  ft_list_push_front(&list, data2);
  ft_list_push_front(&list, data3);
  ASSERT_EQ(ft_list_size(list), 3);
  free(data1);
  free(data2);
  free(data3);
  free(list->next->next);
  free(list->next);
  free(list);
}

UTEST(ft_list_size, multiple_elems_with_null_data) {
  char *data1 = strdup("Hello, World!");
  char *data2 = NULL;
  char *data3 = strdup("Hello, 21!");
  t_list *list = ft_create_elem(data1);
  ft_list_push_front(&list, data2);
  ft_list_push_front(&list, data3);
  ASSERT_EQ(ft_list_size(list), 3);
  free(data1);
  free(data3);
  free(list->next->next);
  free(list->next);
  free(list);
}
