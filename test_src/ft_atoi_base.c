#include <errno.h>
#include <string.h>

#include "libasm.h"
#include "utest.h"
#include "stdbool.h"

bool ft_strctn(char *str, char c) {
	while (*str) {
		if (*str == c) {
			return true;
		}
		str++;
	}
	return false;
}

bool ft_valid_base(char *base, size_t len) {
	char*	charset = " \t\v\n\r\f+-";
	size_t	i;
	size_t	j;

	if (len <= 1) {
		return false;
	}
	i = 0;
	while (base[i]) {
		if (ft_strctn(charset, base[i])) {
			return false;
		}
		j = 0;
		while (base[j]) {
			if (j != i && base[j] == base[i]) {
				return false;
			}
			j++;
		}
		i++;
	}
	return true;
}

int ft_base_val(char *base, char c) {
	int ret = 0;

	while (*base) {
		if (*base == c) {
			return ret;
		}
		ret++;
		base++;
	}
	return ret;
}

int ft_atoi_base(char *str, char *base) {
	int		sign = 1;
	long	result = 0;
	size_t	base_len;
	char*	charset = " \t\v\n\r\f";

	if (str == NULL || base == NULL) {
		return 0;
	}
 	base_len = ft_strlen(base);
	if (!ft_valid_base(base, base_len)) {
		return 0;
	}
	while (ft_strctn(charset, *str)) {
		str++;
	}
	while (*str == '-' || *str == '+') {
		if (*str == '-') {
			sign *= -1;
		}
		str++;
	}
	while (ft_strctn(base, *str)) {
		result *= base_len;
		result += ft_base_val(base, *str);
		str++;
	}
	return result * sign;
}

UTEST(ft_atoi_base, valid) {
	char	*base_hex = strdup("0123456789abcdef");
	char	*base_dec = strdup("0123456789");
	char	*base_bin = strdup("01");

	ASSERT_EQ(ft_atoi_base("ffff", base_hex), 0xffff);
	ASSERT_EQ(ft_atoi_base("2147483647", base_dec), 2147483647);
	ASSERT_EQ(ft_atoi_base("-2147483648", base_dec), -2147483648);
	ASSERT_EQ(ft_atoi_base("00101010", base_bin), 0b00101010);
	ASSERT_EQ(ft_atoi_base(" \t\v\n\f\r-+--+--+-", base_dec), 0);
	ASSERT_EQ(ft_atoi_base(" \t\v\n\f\r-+--+--+-1", base_dec), 1);
	ASSERT_EQ(ft_atoi_base(" \t\v\n\f\r-+--+--+-+-1", base_dec), -1);
	ASSERT_EQ(ft_atoi_base(" \t\v\n-\f\r1", base_dec), 0);
	ASSERT_EQ(ft_atoi_base("-+-- --+-1", base_dec), 0);
	free(base_hex);
	free(base_dec);
	free(base_bin);
}


UTEST(ft_atoi_base, null_str) {
	char	*base_dec = strdup("0123456789");

	ASSERT_EQ(ft_atoi_base(NULL, base_dec), 0);
  	ASSERT_EQ(errno, 0);
	free(base_dec);
}

UTEST(ft_atoi_base, null_base) {
	ASSERT_EQ(ft_atoi_base("test", NULL), 0);
  	ASSERT_EQ(errno, 0);
}

UTEST(ft_atoi_base, null_params) {
	ASSERT_EQ(ft_atoi_base(NULL, NULL), 0);
  	ASSERT_EQ(errno, 0);
}

UTEST(ft_atoi_base, invalid_base) {
	ASSERT_EQ(ft_atoi_base("123", ""), 0);
	ASSERT_EQ(ft_atoi_base("123", "0"), 0);
	ASSERT_EQ(ft_atoi_base("123", "00"), 0);
	ASSERT_EQ(ft_atoi_base("123", "01234567899"), 0);
	ASSERT_EQ(ft_atoi_base("123", "00123456789"), 0);
	ASSERT_EQ(ft_atoi_base("123", "01234567890"), 0);
	ASSERT_EQ(ft_atoi_base("123", "90123456789"), 0);
	ASSERT_EQ(ft_atoi_base("123", "01234563789"), 0);
	ASSERT_EQ(ft_atoi_base("123", "+0123456789"), 0);
	ASSERT_EQ(ft_atoi_base("123", "0123456789-"), 0);
	ASSERT_EQ(ft_atoi_base("123", "0123456789+"), 0);
	ASSERT_EQ(ft_atoi_base("123", "-0123456789"), 0);
}

