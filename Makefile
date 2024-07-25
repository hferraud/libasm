#******************** VARIABLES ********************#

#---------- NAMES ----------#

NAME		=		libasm.a
TEST		=		test
TEST_BONUS	=		test_bonus
LIB_NAME	=		asm

#---------- SOURCES ----------#

ASM_SRC			=		ft_strlen.asm	\
						ft_strcpy.asm	\
						ft_strcmp.asm	\
						ft_write.asm	\
						ft_read.asm		\
						ft_strdup.asm	\

ASM_BONUS_SRC	=		t_list.asm						\
						ft_list_push_front_bonus.asm	\
						ft_list_size.asm	\

TEST_SRC		=		test.c

TEST_BONUS_SRC	=		test_bonus.c

#---------- DIRECTORIES ----------#

SRC_DIR		=		src/
INC_DIR		=		include/
LIB_DIR		=		lib/
BUILD_DIR	=		.build/

#---------- BUILD ----------#

ASM_OBJ			=		$(addprefix $(BUILD_DIR), $(ASM_SRC:.asm=.o))
ASM_BONUS_OBJ	=		$(addprefix $(BUILD_DIR), $(ASM_BONUS_SRC:.asm=.o))
TEST_OBJ		=		$(addprefix $(BUILD_DIR), $(TEST_SRC:.c=.o))
TEST_BONUS_OBJ	=		$(addprefix $(BUILD_DIR), $(TEST_BONUS_SRC:.c=.o))

#---------- COMPILATION ----------#

ASM			=		nasm
ASM_FLAGS	=		-f elf64

C_FLAGS		=		-Wall -Werror -Wextra -g3

I_FLAGS		=		-I$(INC_DIR)
I_ASM_FLAGS	=		-i$(SRC_DIR)

L_FLAGS		=		-L$(LIB_DIR) -l$(LIB_NAME) -lc

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

.PHONY:				run_bonus
run_bonus:			$(TEST_BONUS)
					./$(TEST_BONUS)

#---------- EXECUTABLES ----------#

$(NAME):			$(ASM_OBJ)
					$(MKDIR) $(LIB_DIR)
					$(AR) $(AR_FLAGS) $(LIB_DIR)$@ $^

.PHONY:				bonus
bonus:				$(ASM_BONUS_OBJ)
					$(MKDIR) $(LIB_DIR)
					$(AR) $(AR_FLAGS) $(LIB_DIR)$(NAME) $(ASM_BONUS_OBJ)

$(TEST):			$(NAME) $(TEST_OBJ)
					$(CC) $(C_FLAGS) $(I_FLAGS) $(TEST_OBJ) $(L_FLAGS) -o $@

$(TEST_BONUS):		bonus $(TEST_BONUS_OBJ)
					$(CC) $(C_FLAGS) $(I_FLAGS) $(TEST_BONUS_OBJ) $(L_FLAGS) -o $@

#---------- OBJECTS FILES----------#

$(BUILD_DIR)%.o:	$(SRC_DIR)%.asm
					$(MKDIR) $(shell dirname $@)
					$(ASM) $(ASM_FLAGS) $(I_ASM_FLAGS) $< -o $@

$(BUILD_DIR)%.o:	$(SRC_DIR)%.c
					$(MKDIR) $(shell dirname $@)
					$(CC) $(C_FLAGS) $(I_FLAGS) -c $< -o $@

