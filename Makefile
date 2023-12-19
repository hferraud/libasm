NAME		=		libasm.a

TEST		=		test

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

C_SRC			=		main.c

ASM_OBJ			=		$(addprefix $(BUILD_DIR), $(ASM_SRC:.asm=.o))

C_OBJ			=		$(addprefix $(BUILD_DIR), $(C_SRC:.c=.o))

#######################
#	FLAGS
#######################

ASM			=		nasm

ASM_FLAGS	=		-f elf64

C_FLAGS		=		-Wall -Werror -Wextra

I_FLAGS		=		-I$(INC_DIR)

L_FLAGS		=		-L$(LIB_DIR) -l$(LIB_NAME) -lc

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

.PHONY:				clean
clean:
					$(RM) $(C_OBJ) $(ASM_OBJ)

.PHONY:				fclean
fclean:				clean
					$(RM) $(LIB_DIR)$(NAME) $(TEST)

.PHONY:				re
re:					fclean
					$(MAKE)

.PHONY:				run
run:				$(TEST)
					./$(TEST)

################
#	EXECUTABLES
################

$(NAME):			$(ASM_OBJ)
					mkdir -p $(LIB_DIR)
					$(AR) $(LIB_DIR)$@ $^

$(TEST):			$(NAME) $(C_OBJ)
					$(CC) $(C_FLAGS) $(I_FLAGS) $(C_OBJ) $(L_FLAGS) -o $@

##################
#	OBJECTS FILES
##################

$(BUILD_DIR)%.o:	$(SRC_DIR)%.asm
					mkdir -p $(shell dirname $@)
					$(ASM) $(ASM_FLAGS) $< -o $@


$(BUILD_DIR)%.o:	$(SRC_DIR)%.c
					mkdir -p $(shell dirname $@)
					$(CC) $(C_FLAGS) $(I_FLAGS) -c $< -o $@
