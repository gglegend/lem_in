# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nalexand <nalexand@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/05/29 16:28:19 by nalexand          #+#    #+#              #
#    Updated: 2019/07/21 20:22:04 by nalexand         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

LEM = lem-in
VIS = visu-hex

COM_LIB = common.a
LEM_LIB = lem-in.a
VIS_LIB = visu-hex.a
LIBFT = libft/libft.a
FTPRINTF = libft/ft_printf/libftprintf.a

MLX_LIB = -L /usr/local/lib/ -lmlx
MLX_HEAD = -I /usr/local/include
FRAMEWORK = -framework OpenGL -framework AppKit

C_FLAGS = -g
HEADER = -I includes -I libft/includes -I libft/ft_printf/includes

SRC_DIR = src/
OBJ_DIR = obj/
COM_DIR = common/
LEM_DIR = lem-in/
VIS_DIR = visu-hex/

COM_SRC = 	parce_map.c \
			get_ants.c \
			get_sharp.c \
			get_room.c \
			get_door.c \
			find_room.c \
			debug.c
LEM_SRC =	lem_in.c \
			lem_in_clear_exit.c
VIS_SRC =	visu_hex.c \
			visu_hex_clear_exit.c \
			visualisation_init.c \
			key_handle.c \
			render.c

COM_OBJ = $(addprefix $(OBJ_DIR), $(patsubst %.c, %.o, $(COM_SRC)))
LEM_OBJ = $(addprefix $(OBJ_DIR), $(patsubst %.c, %.o, $(LEM_SRC)))
VIS_OBJ = $(addprefix $(OBJ_DIR), $(patsubst %.c, %.o, $(VIS_SRC)))

all: $(LEM) $(VIS)

$(LEM): $(LIBFT) $(FTPRINTF) $(COM_LIB) $(LEM_LIB)
	gcc $(C_FLAGS) -o $@ $(COM_LIB) $(LEM_LIB) $(LIBFT) $(FTPRINTF)
$(VIS): $(LIBFT) $(FTPRINTF) $(COM_LIB) $(VIS_LIB)
	gcc $(C_FLAGS) -o $@ $(COM_LIB) $(VIS_LIB) $(LIBFT) $(FTPRINTF) $(MLX_LIB) $(MLX_HEAD) $(FRAMEWORK)

$(LIBFT):
	make -C libft/
$(FTPRINTF):
	make -C libft/ft_printf/

$(COM_LIB): $(COM_OBJ) 
	@ar rc $@ $^
$(LEM_LIB): $(LEM_OBJ) 
	@ar rc $@ $^
$(VIS_LIB): $(VIS_OBJ) 
	@ar rc $@ $^

$(OBJ_DIR)%.o: $(SRC_DIR)$(COM_DIR)%.c
	@mkdir -p $(OBJ_DIR)
	gcc $(C_FLAGS) -c $< -o $@ $(HEADER)
$(OBJ_DIR)%.o: $(SRC_DIR)$(LEM_DIR)%.c
	@mkdir -p $(OBJ_DIR)
	gcc $(C_FLAGS) -c $< -o $@ $(HEADER)
$(OBJ_DIR)%.o: $(SRC_DIR)$(VIS_DIR)%.c
	@mkdir -p $(OBJ_DIR)
	gcc $(C_FLAGS) -c $< -o $@ $(HEADER)

clean:
	rm -f $(COM_LIB)
	rm -f $(LEM_LIB)
	rm -f $(VIS_LIB)
	rm -rf $(OBJ_DIR)

fclean: clean
	rm -f $(LEM)
	rm -f $(VIS)
	rm -rf *.dSYM
fclean_all: fclean
	make -C libft/ fclean
	make -C libft/ft_printf fclean
re: fclean all
re_all: re
	make -C libft/ re
	make -C libft/ft_printf re	
relib:
	make -C libft/ re
	make -C libft/ft_printf re
