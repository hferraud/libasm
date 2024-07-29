#pragma once

#include <stdlib.h>

// MANDATORY PART

extern size_t	ft_strlen(const char *str);
extern char		*ft_strcpy(char *dst, const char *src);
extern int		ft_strcmp(const char *s1, const char *s2);
extern ssize_t	ft_write(int fd, const void *buf, size_t count);
extern ssize_t	ft_read(int fd, const void *buf, size_t count);
extern char		*ft_strdup(const char *s);

// BONUS PART

typedef struct s_list {
	void			*data;
	struct s_list	*next;
}t_list;

extern t_list	*ft_create_elem(void *data);
extern void		ft_list_push_front(t_list **head, void *data);
extern size_t	ft_list_size(t_list *head);
extern void		ft_list_remove_if(t_list **head, void *data, int(*cmp)(), void(*free_fct)(void *));
extern void		ft_list_sort(t_list **head, int (*cmp)());

