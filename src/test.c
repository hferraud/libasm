#include "libasm.h"
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>

#define CLEAR "\e[1;1H\e[2J"

int main(void) {
	printf(CLEAR);

	/**
	 * FT_STRLEN
	 */
	 printf("\nTESTING FT_STRLEN:\n\n");
	{
		printf("len: %zu\n", ft_strlen("salut les potes"));
	}

	/**
	 * FT_STRCPY
	 */
	printf("\nTESTING FT_STRCPY:\n\n");
	{
		char	*dst;
		char	*src;
		char	*ret;

		dst = strdup("this is a string");
		src = strdup("a string");

		printf("dst: %s\n", dst);
		printf("src: %s\n", src);
		ret = ft_strcpy(dst, src);
		printf("dst: %s\n", dst);
		printf("src: %s\n", src);
		printf("ret: %s\n", ret);

		free(dst);
		free(src);
	}

	/**
	 * FT_STRCMP
	 */
	printf("\nTESTING FT_STRCPY:\n\n");
	{
		char	*s1;
		char	*s2;
		char	*s3;
		char	*s4;
		int 	res;

		s1 = strdup("this is a string");
		s2 = strdup("this is not a string");
		s3 = strdup("this is not a strIng");
		s4 = strdup("this is a thing");

		printf("Comparing:\n\t%s\n\t%s\n", s1, s2);
		res = ft_strcmp(s1, s2);
		printf("Result: %d\n", res);
		printf("Comparing:\n\t%s\n\t%s\n", s2, s3);
		res = ft_strcmp(s2, s3);
		printf("Result: %d\n", res);
		printf("Comparing:\n\t%s\n\t%s\n", s1, s4);
		res = ft_strcmp(s1, s4);
		printf("Result: %d\n", res);
		printf("Comparing:\n\t%s\n\t%s\n", s1, s1);
		res = ft_strcmp(s1, s1);
		printf("Result: %d\n", res);

		free(s1);
		free(s2);
		free(s3);
		free(s4);
	}

	/**
	 * FT_WRITE
	 */
	printf("\nTESTING FT_WRITE:\n\n");
	{
		char*	str;
		int		ret;

		str = strdup("This is a test\n");

		printf("SUCCESS:\n\n");
		printf("STD FUNCTION:\n");
		ret = write(STDIN_FILENO, str, ft_strlen(str));
		printf("Return: %d\nErrno: %d\n", ret, errno);
		errno = 0;
		printf("FT FUNCTION:\n");
		ret = ft_write(STDIN_FILENO, str, ft_strlen(str));
		printf("Return: %d\nErrno: %d\n", ret, errno);
		errno = 0;
		printf("\nERROR:\n\n");
		printf("STD FUNCTION:\n");
		ret = write(-1, str, ft_strlen(str));
		printf("Return: %d\nErrno: %d\n", ret, errno);
		errno = 0;
		printf("FT FUNCTION:\n");
		ret = ft_write(-1, str, ft_strlen(str));
		printf("Return: %d\nErrno: %d\n", ret, errno);
		errno = 0;
		free(str);
	}

	/**
	 * FT_WRITE
	 */
	printf("\nTESTING FT_WRITE:\n\n");
	{
		char*	str;
		int		ret;

		str = strdup("This is a test\n");

		printf("SUCCESS:\n\n");

		printf("STD FUNCTION:\n");
		ret = write(STDIN_FILENO, str, ft_strlen(str));
		printf("Return: %d\nErrno: %d\n", ret, errno);
		errno = 0;

		printf("FT FUNCTION:\n");
		ret = ft_write(STDIN_FILENO, str, ft_strlen(str));
		printf("Return: %d\nErrno: %d\n", ret, errno);
		errno = 0;

		printf("\nERROR:\n\n");

		printf("STD FUNCTION:\n");
		ret = write(-1, str, ft_strlen(str));
		printf("Return: %d\nErrno: %d\n", ret, errno);
		errno = 0;

		printf("FT FUNCTION:\n");
		ret = ft_write(-1, str, ft_strlen(str));
		printf("Return: %d\nErrno: %d\n", ret, errno);
		errno = 0;

		free(str);
	}

	/**
	 * FT_READ
	 */
	printf("\nTESTING FT_READ:\n\n");
	{
		int		fd1;
		int		fd2;
		ssize_t	ret;
		char*	buf;

		fd1 = open("src/ft_strcmp.asm", O_RDONLY);
		if (fd1 == -1) {
			perror("");
			exit(1);
		}
		fd2 = open("src/ft_strcmp.asm", O_RDONLY);
		if (fd2 == -1) {
			perror("");
			exit(1);
		}
		buf = malloc(10 * sizeof(char));
		if (buf == NULL) {
			perror("");
			exit(1);
		}

		printf("SUCCESS:\n\n");

		printf("STD FUNCTION:\n");
		do {
			ret = read(fd1, buf, 9);
			buf[ret] = 0;
			ft_write(STDOUT_FILENO, buf, ret);
		} while (ret > 0);
		printf("Return: %ld\nErrno: %d\n", ret, errno);
		errno = 0;

		printf("FT FUNCTION:\n");
		do {
			ret = ft_read(fd2, buf, 10);
			ft_write(STDOUT_FILENO, buf, ret);
		} while (ret > 0);
		printf("Return: %ld\nErrno: %d\n", ret, errno);
		errno = 0;

		printf("\nERROR:\n\n");

		printf("STD FUNCTION:\n");
		ret = read(-1, buf, 10);
		printf("Return: %ld\nErrno: %d\n", ret, errno);
		errno = 0;
		printf("FT FUNCTION:\n");
		ret = ft_read(-1, buf, 10);
		printf("Return: %ld\nErrno: %d\n", ret, errno);
		errno = 0;

		free(buf);
		close(fd1);
		close(fd2);
	}

	/**
	 * FT_READ
	 */
	printf("\nTESTING FT_STRDUP:\n\n");
	{
		char	*s1;
		char	*s2;

		s1 = ft_strdup("this is a string");
		s2 = ft_strdup("a string");

		printf("%s\n", s1);
		printf("%s\n", s2);

		free(s1);
		free(s2);
	}
}
