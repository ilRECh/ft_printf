NAME			= libftprintf.a

RM				= rm -rf
GCC				= gcc
AR				= ar -crs
FLAGS			= -Wall -Wextra -Werror -c
INCLUDES 		= -I $(HDRS_DIR)

HDRS_LIST		= libft.h\
			  parser.h\
			  ft_stdio.h\
			  out_funcs.h
HDRS_DIR		= ./includes/
HDRS			= $(addprefix $(HDRS_DIR), $(HDRS_LIST))

LIBFT_LIST	=	ft_strchr.c\
				ft_atoi.c\
				ft_isdigit.c\
				ft_isspace.c\
				ft_strlen.c\
				fill_with.c\
				count_symbs.c\
				ft_putnbr_base.c\
				ft_abs.c
LIBFT_DIR		= ./libft/
LIBFT			= $(addprefix $(LIBFT_DIR), $(LIBFT_LIST))

SRCS_LIST	= 	ft_printf.c
SRCS_DIR		= ./
SRCS			= $(addprefix $(SRCS_DIR), $(SRCS_LIST))

OUT_LIST	=	str_print.c\
				char_print.c\
				pointer_print.c\
				digit_print.c\
				u_digit_print.c\
				hex_print.c\
				out_funcs.c
OUT_DIR			= ./out_funcs/
OUT				= $(addprefix $(OUT_DIR), $(OUT_LIST))

PRSR_LIST	=	ft_vprintf.c\
				specifier_parse.c\
				flags_parse.c\
				width_parse.c\
				precision_parse.c\
				size_parse.c

PRSR_DIR		= ./parser/
PRSR			= $(addprefix $(PRSR_DIR), $(PRSR_LIST))

OBJS			= $(OUT:.c=.o) $(PRSR:.c=.o) $(LIBFT:.c=.o) $(SRCS:.c=.o)

# COLORS
GREEN = \033[0;32m
RED = \033[0;31m
RESET = \033[0m

$(NAME): $(OBJS)
	@$(AR) $(NAME) $(OBJS)
	@echo "\n$(NAME): $(GREEN)object files were created$(RESET)"
	@echo "$(NAME): $(GREEN)$(NAME) was created$(RESET)"

all: $(NAME)

bonus: all

%.o : %.c $(HDRS)
	@$(GCC) $(FLAGS) $(INCLUDES) $< -o $@
	@echo "$(GREEN).$(RESET)\c"

clean:
	@$(RM) $(OBJS)
	@echo "$(NAME): $(RED)object files were deleted$(RESET)"

fclean: clean
	@$(RM) $(NAME) $(OBJS_DIR)
	@echo "$(NAME): $(RED)$(NAME) was deleted$(RESET)"

re: fclean all

.PHONY:	
			all clean fclean re 
