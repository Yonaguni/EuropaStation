/obj/structure/underwater_vent
	name = "vent"
	desc = "A geothermal vent."
	icon = 'icons/obj/machines/geothermal.dmi'
	icon_state = "vent_segment"
	density = 0
	opacity = 0
	anchored = 1
	layer = TURF_LAYER + 0.1

	var/next_vent_time = 0
	var/covered
	var/vent_min_power = 5000
	var/vent_max_power = 22000
	var/destroyed
	var/datum/effect/effect/system/steam_spread/steam

/obj/structure/underwater_vent/New()
	..()
	update_icon(1)
	processing_objects |= src
	steam = new(name)
	steam.attach(get_turf(src))
	steam.set_up(3, 0, get_turf(src))

/obj/structure/underwater_vent/Destroy()
	destroyed = 1
	update_icon(1)
	processing_objects -= src
	var/turf/T = loc
	if(istype(T) && T.contents.len)
		for(var/obj/machinery/geothermal_gen/G in T.contents)
			if(G.vent == src)
				G.vent = null
	return ..()

/obj/structure/underwater_vent/process()
	if(covered || world.time < next_vent_time)
		return
	next_vent_time = world.time + rand(200,500)
	steam.start()

/obj/structure/underwater_vent/ex_act()
	return

/obj/structure/underwater_vent/update_icon(var/update_neighbors)

	var/turf/origin = get_turf(src)
	if(!istype(origin))
		return
	var/list/neighbors = list()
	for(var/checkdir in list(NORTH, SOUTH, EAST, WEST))
		var/turf/T = get_step(origin, checkdir)
		if(istype(T))
			var/obj/structure/underwater_vent/V = locate() in T.contents
			if(!V || V.destroyed)
				continue
			neighbors |= checkdir
			if(update_neighbors)
				V.update_icon()

	if(!neighbors.len)
		icon_state = "vent_single"
	else if(neighbors.len == 1)
		dir = neighbors[1]
		icon_state = "vent_terminus"
	else if(neighbors.len == 2)
		var/has_north = (NORTH in neighbors)
		var/has_south = (SOUTH in neighbors)
		var/has_east =  (EAST in neighbors)
		var/has_west =  (WEST in neighbors)
		icon_state = "vent_segment"

		if(has_north && has_south)
			dir = pick(NORTH, SOUTH)
		else if(has_east && has_west)
			dir = pick(EAST, WEST)
		else if(has_east)
			if(has_north)
				dir = NORTHEAST
			else if(has_south)
				dir = SOUTHEAST
		else if(has_west)
			if(has_north)
				dir = NORTHWEST
			else if(has_south)
				dir = SOUTHWEST
	else
		icon_state = "vent_full"
