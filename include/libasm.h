#pragma once

#include <stdlib.h>

// MANDATORY PART

extern size_t	ft_strlen(char *str);
extern char		*ft_strcpy(char *dst, char *src);
extern int		ft_strcmp(char *s1, char *s2);
extern ssize_t	ft_write(int fd, const void *buf, size_t count);
extern ssize_t	ft_read(int fd, const void *buf, size_t count);
extern char		*ft_strdup(const char *s);

// BONUS PART

typedef struct s_list {
	void			*data;
	struct s_list	*next;
}t_list;

extern void		ft_list_push_front(t_list **head, void *data);