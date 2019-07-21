/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   visu_hex.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nalexand <nalexand@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/07/21 18:35:53 by nalexand          #+#    #+#             */
/*   Updated: 2019/07/21 20:29:25 by nalexand         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "lem_in.h"

int		main(void)
{
	t_all	all;

	bzero(&all, sizeof(t_all));
	all.prog = VISU_HEX;
	all.exit = &visu_hex_clear_exit;
	visualisation_init(&all);
	render(&all);
	parce_map(&all);
	mlx_loop(&all.mlx.ptr);
	return (0);
}
