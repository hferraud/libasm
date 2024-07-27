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

UTEST(ft_create_elem, null_data) {
  t_list *elem = ft_create_elem(NULL);
  ASSERT_EQ(elem->data, NULL);
  ASSERT_EQ(elem->next, NULL);
  free(elem);
}

UTEST(ft_create_elem, non_null_data) {
  char *data = strdup("Hello, World!");
  t_list *elem = ft_create_elem(data);
  ASSERT_EQ(elem->data, data);
  ASSERT_EQ(elem->next, NULL);
  free(data);
  free(elem);
}

UTEST(ft_create_elem, multiple_elems) {
  char *data1 = strdup("Hello, World!");
  char *data2 = strdup("Hello, 42!");
  t_list *elem1 = ft_create_elem(data1);
  t_list *elem2 = ft_create_elem(data2);
  elem1->next = elem2;
  ASSERT_EQ(elem1->data, data1);
  ASSERT_EQ(elem1->next, elem2);
  ASSERT_EQ(elem2->data, data2);
  ASSERT_EQ(elem2->next, NULL);
  free(data1);
  free(data2);
  free(elem1);
  free(elem2);
}
