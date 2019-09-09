# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lglover <lglover@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/11/26 09:56:17 by lglover           #+#    #+#              #
#    Updated: 2019/08/26 15:11:47 by lglover          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC = gcc
CFLAGS = -Wall -Wextra -Werror -O3

NAME = wolf3d
INCLUDES = 	-I ./libft/includes \
			-I ./includes \
			-I ./sdl/SDL2.framework/Versions/A/Headers \
			-I ./sdl/SDL2_ttf.framework/Versions/A/Headers \
			-I ./sdl/SDL2_mixer.framework/Versions/A/Headers

SRC_PATH = sources
SRC_LIST = animation_system.c animations.c choose_obsticle.c color.c door.c draw_weapons.c \
draw.c errors.c hud_system.c hud_ui.c init_animations.c init_rays.c init.c keyboard.c load_files.c \
load_walls.c loading.c main.c map_init.c map_type.c map_validation.c map.c mouse.c movement.c \
objects_draw.c objects.c player.c raycasting.c render.c utils.c weapons.c

SRC = $(addprefix $(SRC_PATH)/, $(SRC_LIST))

OBJ_LIST = $(SRC_LIST:.c=.o)
OBJ_PATH = obj
OBJ = $(addprefix $(OBJ_PATH)/, $(OBJ_LIST))

LIBFT_PATH = libft
LIBFT = -L $(LIBFT_PATH) -lft

LIBS = 	-lm \
		-F ./sdl -framework SDL2 \
		-F ./sdl -framework SDL2_ttf \
		-F ./sdl -framework SDL2_mixer

YELLOW = \033[1;33m
PURPLE = \033[0;35m
NC = \033[0m

.PHONY: all

all: make_libft intro make_obj $(NAME)
	@echo "$(PURPLE)MAKE $(NAME) Done!$(NC)"

intro:
	@echo "\n$(PURPLE)MAKE $(NAME) Start!$(NC)"

$(NAME): $(OBJ)
	@$(CC) $(CFLAGS) $(INCLUDES) $(LIBS) $(OBJ) -o $(NAME) $(LIBFT)

$(OBJ_PATH)/%.o: $(SRC_PATH)/%.c
	@echo "$(YELLOW)$(NAME): $(notdir $<)$(NC)"
	@$(CC) $(CFLAGS) $(INCLUDES) -o $@ -c $<

make_obj :
	@mkdir -p obj

make_libft :
	@make -C ./libft/

clean :
	@echo "$(YELLOW)Objects Deleted.$(NC)"
	@/bin/rm -rf $(OBJ_PATH)

fclean :	clean
	@echo "$(YELLOW)$(NAME) Deleted.$(NC)"
	@/bin/rm -f $(NAME)

re :	fclean all

rc :
	make -C $(LIBFT_PATH) fclean && make fclean && make


