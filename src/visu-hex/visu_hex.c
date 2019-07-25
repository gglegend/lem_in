/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   visu_hex.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nalexand <nalexand@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/07/21 18:35:53 by nalexand          #+#    #+#             */
/*   Updated: 2019/07/25 21:26:02 by nalexand         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "lem_in.h"

static void	get_min_max(t_all *all)
{
	t_list	*tmp;

	tmp = all->rooms;
	all->mlx.min_x = ((t_room *)tmp->content)->x;
	all->mlx.min_y = ((t_room *)tmp->content)->y;
	all->mlx.max_x = ((t_room *)tmp->content)->x;
	all->mlx.max_y = ((t_room *)tmp->content)->y;
	while (tmp)
	{
		if (((t_room *)tmp->content)->x < all->mlx.min_x)
			all->mlx.min_x = ((t_room *)tmp->content)->x;
		if (((t_room *)tmp->content)->x > all->mlx.max_x)
			all->mlx.max_x = ((t_room *)tmp->content)->x;
		if (((t_room *)tmp->content)->y < all->mlx.min_y)
			all->mlx.min_y = ((t_room *)tmp->content)->y;
		if (((t_room *)tmp->content)->y > all->mlx.max_y)
			all->mlx.max_y = ((t_room *)tmp->content)->y;
		tmp = tmp->next;
	}
}

static void	normalize_by_min(t_all *all)
{
	t_list	*tmp;

	tmp = all->rooms;
	all->mlx.size_x_sum = 0;
	all->mlx.size_y_sum = 0;
	while (tmp)
	{
		((t_room *)tmp->content)->x -= all->mlx.min_x;
		((t_room *)tmp->content)->y -= all->mlx.min_y;
		all->mlx.size_x_sum += ((t_room *)tmp->content)->x;
		all->mlx.size_y_sum += ((t_room *)tmp->content)->y;	
		tmp = tmp->next;
	}
}

static void	normalize_coordinates(t_all *all)
{
	get_min_max(all);
	normalize_by_min(all);
}

int		main(void)
{
	t_all	*all;

	if (!(all = (t_all *)ft_memalloc(sizeof(t_all))))
		exit(EXIT_FAILURE);
	all->prog = VISU_HEX;
	all->exit = &visu_hex_clear_exit;
	visualisation_init(all);
	parce_map(all);
	normalize_coordinates(all);
	all->mlx.map_size = all->mlx.width / 4 / 4;
	all->mlx.map_position_x = 0;
	all->mlx.map_position_y = 0;
	all->mlx.radius = 50;
	all->mlx.pixel_size = 7;
	render(all);
	mlx_loop(all->mlx.ptr);
	return (0);
}
