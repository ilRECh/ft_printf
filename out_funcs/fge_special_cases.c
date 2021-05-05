#include "out_funcs.h"

static void	put_flag_symbol(uint8_t const minus_sign,
							   int *total, t_specifier *specifier)
{
	char	c;

	c = '+' * ((specifier->flags & PLUS_FLAG) != 0) * (minus_sign == 0)
		+ ' ' * ((specifier->flags & SPACE_FLAG) != 0
				 && !(specifier->flags & PLUS_FLAG)) * (minus_sign == 0)
		+ '-' * (minus_sign != 0);
	if (c)
	{
		write(1, &c, 1);
		*total += 1;
	}
}

static void	ft_putstr(const char *s, int32_t *total, t_specifier *specifier,
					  uint8_t sign)
{
	specifier->precision = 3;
	if (specifier->width > specifier->precision && (sign == 1
		|| (specifier->flags & SPACE_FLAG) || (specifier->flags & PLUS_FLAG)))
		specifier->width--;
	if (!(specifier->flags & MINUS_FLAG)
		&& specifier->width > specifier->precision)
		fill_with(' ', specifier->width - specifier->precision);
	put_flag_symbol(sign, total, specifier);
	write(1, s, 3);
	if ((specifier->flags & MINUS_FLAG)
		&& specifier->width > specifier->precision)
		fill_with(' ', specifier->width - specifier->precision);
	*total += specifier->width * (specifier->width > specifier->precision)
			+ specifier->precision * (specifier->width <= specifier->precision);
}

uint8_t	fge_special_cases(double const *nbr,
						  int32_t *total, t_specifier *specifier)
{
	t_double	union_nbr;

	union_nbr.value = *nbr;
	if (union_nbr.f_bits.exponent == 0b11111111111
		&& union_nbr.f_bits.mantissa == 0)
		ft_putstr("inf", total, specifier, union_nbr.f_bits.sign);
	else if (union_nbr.f_bits.exponent == 0b11111111111
		&& union_nbr.f_bits.mantissa == ((uint64_t)1 << 51))
		ft_putstr("nan", total, specifier, union_nbr.f_bits.sign);
	else
		return (0);
	return (1);
}