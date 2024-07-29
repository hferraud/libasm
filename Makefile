#******************** VARIABLES ********************#

#---------- NAMES ----------#

NAME		=		libasm.a
TEST		=		test
LIB_NAME	=		asm

#---------- SOURCES ----------#

ASM_SRC			=		ft_strlen.asm			\
						ft_strcpy.asm			\
						ft_strcmp.asm			\
						ft_write.asm			\
						ft_read.asm				\
						ft_strdup.asm			\
						t_list.asm				\
						ft_create_elem.asm		\
						ft_list_push_front.asm	\
						ft_list_size.asm		\
						ft_list_remove_if.asm	\

TEST_SRC		=		main.c					\
						ft_strlen.c				\
						ft_strcpy.c				\
						ft_strcmp.c				\
						ft_write.c				\
						ft_read.c				\
						ft_strdup.c				\
						ft_list_push_front.c	\
						ft_list_size.c			\
						ft_list_remove_if.c		\
						ft_list_sort.c			\
						

TEST_BONUS_SRC	=		test_bonus.c

#---------- DIRECTORIES ----------#

SRC_DIR		=		src/
INC_DIR		=		include/
LIB_DIR		=		lib/
TEST_DIR	=		test_src/
BUILD_DIR	=		.build/

#---------- BUILD ----------#

ASM_PATH		=		$(addprefix $(SRC_DIR), $(ASM_SRC))
TEST_PATH		=		$(addprefix $(TEST_DIR), $(TEST_SRC))
ASM_OBJ			=		$(addprefix $(BUILD_DIR), $(ASM_PATH:.asm=.o))
TEST_OBJ		=		$(addprefix $(BUILD_DIR), $(TEST_PATH:.c=.o))

#---------- COMPILATION ----------#

ASM			=		nasm
ASM_FLAGS	=		-f elf64

C_FLAGS		=		-Wall -Werror -Wextra -g3

I_FLAGS		=		-I$(INC_DIR)
I_ASM_FLAGS	=		-i$(SRC_DIR)

L_FLAGS		=		-L$(LIB_DIR) -l$(LIB_NAME)

DEP_FLAGS	=		-MMD -MP

AR_FLAGS	=		rcs

#---------- COMMANDS ----------#

RM			=		rm -rf
MKDIR		=		mkdir -p

#******************** RULES ********************#

#---------- GENERAL ----------#

.PHONY:				all
all:				$(NAME)

.PHONY:				clean
clean:
					$(RM) $(BUILD_DIR)

.PHONY:				fclean
fclean:				clean
					$(RM) $(NAME) $(TEST) $(TEST_BONUS)

.PHONY:				re
re:					fclean
					$(MAKE)

#---------- RUN ----------#

.PHONY:				run
run:				$(TEST)
					./$(TEST)

.PHONY:				leak
leak:				$(TEST)
					valgrind --leak-check=full ./$(TEST)

#---------- EXECUTABLES ----------#

$(NAME):			$(ASM_OBJ)
					$(MKDIR) $(LIB_DIR)
					$(AR) $(AR_FLAGS) $(LIB_DIR)$@ $^

$(TEST):			$(NAME) $(TEST_OBJ)
					$(CC) $(C_FLAGS) $(I_FLAGS) $(TEST_OBJ) $(L_FLAGS) -o $@

#---------- OBJECTS FILES----------#

$(BUILD_DIR)%.o:	%.asm
					$(MKDIR) $(shell dirname $@)
					$(ASM) $(ASM_FLAGS) $(I_ASM_FLAGS) $< -o $@

$(BUILD_DIR)%.o:	%.c
					$(MKDIR) $(shell dirname $@)
					$(CC) $(C_FLAGS) $(I_FLAGS) -c $< -o $@

