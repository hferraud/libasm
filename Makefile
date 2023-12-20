NAME		=		libasm.a

TEST		=		test

TEST_BONUS	=		test_bonus

LIB_NAME	=		asm

#######################
#	DIR
#######################

SRC_DIR		=		src/

INC_DIR		=		include/

LIB_DIR		=		lib/

BUILD_DIR	=		.build/

#######################
#	FILES
#######################

ASM_SRC			=		ft_strlen.asm	\
						ft_strcpy.asm	\
						ft_strcmp.asm	\
						ft_write.asm	\
						ft_read.asm		\
						ft_strdup.asm	\

ASM_BONUS_SRC	=		t_list.asm						\
						ft_list_push_front_bonus.asm	\

TEST_SRC		=		test.c

TEST_BONUS_SRC	=		test_bonus.c

ASM_OBJ			=		$(addprefix $(BUILD_DIR), $(ASM_SRC:.asm=.o))
ASM_BONUS_OBJ	=		$(addprefix $(BUILD_DIR), $(ASM_BONUS_SRC:.asm=.o))
TEST_OBJ		=		$(addprefix $(BUILD_DIR), $(TEST_SRC:.c=.o))
TEST_BONUS_OBJ	=		$(addprefix $(BUILD_DIR), $(TEST_BONUS_SRC:.c=.o))

#######################
#	FLAGS
#######################

ASM			=		nasm

ASM_FLAGS	=		-f elf64

C_FLAGS		=		-Wall -Werror -Wextra -fsanitize=address

I_FLAGS		=		-I$(INC_DIR)

ASM_I_FLAGS	=		-i$(SRC_DIR)

L_FLAGS		=		-L$(LIB_DIR) -l$(LIB_NAME) -lc

DEF_FLAGS	=		-DSYS_READ=0x00 -DSYS_WRITE=0x01 -DERRNO=__errno_location -DMALLOC=malloc -DFREE=free

LINK		=		ld

AR			=		ar rcs

#######################
#	RULES
#######################

############
#	GENERAL
############

.PHONY:				all
all:				$(NAME)

.PHONY:				bonus
bonus:				$(NAME) $(ASM_BONUS_OBJ)
					mkdir -p $(LIB_DIR)
					$(AR) $(LIB_DIR)$(NAME) $(ASM_BONUS_OBJ)

.PHONY:				clean
clean:
					$(RM) $(ASM_OBJ) $(TEST_OBJ) $(ASM_BONUS_OBJ) $(TEST_BONUS_OBJ)

.PHONY:				fclean
fclean:				clean
					$(RM) $(LIB_DIR)$(NAME) $(TEST) $(TEST_BONUS)

.PHONY:				re
re:					fclean
					$(MAKE)

.PHONY:				run
run:				$(TEST)
					./$(TEST)

.PHONY:				run_bonus
run_bonus:			$(TEST_BONUS)
					./$(TEST_BONUS)

################
#	EXECUTABLES
################

$(NAME):			$(ASM_OBJ)
					mkdir -p $(LIB_DIR)
					$(AR) $(LIB_DIR)$@ $^

$(TEST):			$(NAME) $(TEST_OBJ)
					$(CC) $(C_FLAGS) $(I_FLAGS) $(TEST_OBJ) $(L_FLAGS) -o $@

$(TEST_BONUS):		bonus $(TEST_BONUS_OBJ)
					$(CC) $(C_FLAGS) $(I_FLAGS) $(TEST_BONUS_OBJ) $(L_FLAGS) -o $@

##################
#	OBJECTS FILES
##################

$(BUILD_DIR)%.o:	$(SRC_DIR)%.asm
					mkdir -p $(shell dirname $@)
					$(ASM) $(ASM_FLAGS) $(ASM_I_FLAGS) $(DEF_FLAGS)  $< -o $@


$(BUILD_DIR)%.o:	$(SRC_DIR)%.c
					mkdir -p $(shell dirname $@)
					$(CC) $(C_FLAGS) $(I_FLAGS) -c $< -o $@
