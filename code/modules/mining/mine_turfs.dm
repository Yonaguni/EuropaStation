//TODO: readd mining for ore, take ASPECT_GROUNDBREAKER into account for delays/yields

var/list/mining_overlays = list()

proc/get_mining_overlay(var/overlay_key)
	if(!mining_overlays[overlay_key])
		mining_overlays[overlay_key] = image('icons/turf/flooring/decals.dmi',overlay_key)
	return mining_overlays[overlay_key]

/**********************Mineral deposits**************************/
/turf/unsimulated/mineral
	name = "impassable rock"
	icon = 'icons/turf/walls.dmi'
	icon_state = "rock-dark"
	density = 1
	opacity = 1
	drop_state = "rockwall"
	blend_with_neighbors = 20 // Blend over EVERYTHING.

/turf/simulated/mineral //wall piece
	name = "rock"
	icon = 'icons/turf/walls.dmi'
	icon_state = "rock"
	opacity = 1
	density = 1
	has_resources = 1
	drop_state = "rockwall"
	blend_with_neighbors = 15 // Blend over MOST THINGS.

	var/ore/mineral
	var/sand_dug
	var/mined_ore = 0
	var/last_act = 0
	var/overlay_detail
	var/ignore_mapgen

/turf/simulated/mineral/can_build_cable()
	return !density

/turf/simulated/mineral/is_plating()
	return 1

/turf/simulated/mineral/floor
	name = "sand"
	icon = 'icons/turf/flooring/asteroid.dmi'
	icon_state = "asteroid"
	density = 0
	opacity = 0
	blend_with_neighbors = 4
	accept_lattice = 1
	explosion_resistance = 2

/turf/simulated/mineral/flooded
	color = "#0000FF"

/turf/simulated/mineral/floor/flooded
	color = "#0000FF"
	accept_lattice = 1

/turf/simulated/mineral/ignore_mapgen
	ignore_mapgen = 1
	color = "#00FF00"

/turf/simulated/mineral/floor/ignore_mapgen
	ignore_mapgen = 1
	color = "#00FF00"
	accept_lattice = 1

/turf/simulated/mineral/ignore_mapgen/flooded
	ignore_mapgen = 1
	color = "#00FFFF"

/turf/simulated/mineral/floor/ignore_mapgen/flooded
	ignore_mapgen = 1
	color = "#00FFFF"
	accept_lattice = 1

/*
/turf/simulated/mineral/floor/ignore_mapgen/flooded/initialize()
	if(prob(1) && !(locate(/obj/landmark/animal_spawn) in src)) // This is a placeholder for a proper deer/prey animal spawn setup.
		switch(rand(1,3))
			if(1)
				new /obj/landmark/animal_spawn/carp(src)
			if(2)
				new /obj/landmark/animal_spawn/shark(src)
			if(3)
				new /obj/landmark/animal_spawn/fish(src)
	return ..()
*/

/turf/simulated/mineral/New()
	..()
	color = null

/turf/simulated/mineral/can_build_cable()
	return !density

/turf/simulated/mineral/is_plating()
	return 1

/turf/simulated/mineral/proc/make_floor()
	if(!density && !opacity)
		return
	density = 0
	opacity = 0
	accept_lattice = 1
	explosion_resistance = 2
	update_icon(1)

/turf/simulated/mineral/proc/make_wall()
	if(density && opacity)
		return
	density = 1
	opacity = 1
	accept_lattice = null
	update_icon(1)

/turf/simulated/mineral/initialize()
	if(prob(20))
		overlay_detail = "asteroid[rand(0,9)]"
	update_icon(1)

/turf/simulated/mineral/update_icon(var/update_neighbors)
	overlays.Cut()
	if(density)
		if(mineral)
			name = "[mineral.display_name] deposit"
		else
			name = "rock"
		icon = 'icons/turf/walls.dmi'
		icon_state = "rock"
		blend_with_neighbors = 15
	else
		name = "sand"
		icon = 'icons/turf/flooring/asteroid.dmi'
		icon_state = "asteroid"
		blend_with_neighbors = 4
		if(sand_dug)
			overlays += image('icons/turf/flooring/asteroid.dmi', "dug_overlay")
		for(var/direction in cardinal)
			var/turf/T = get_step(src, direction)
			if(istype(T) && T.open_space)
				overlays += image('icons/turf/flooring/asteroid.dmi', "asteroid_edges", dir = direction)
		if(overlay_detail)
			overlays |= image(icon = 'icons/turf/flooring/decals.dmi', icon_state = overlay_detail)
	..(update_neighbors)