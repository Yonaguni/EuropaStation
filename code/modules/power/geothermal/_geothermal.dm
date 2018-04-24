var/list/geothermal_cache = list()
var/vent_min_power = solar_gen_rate * 2
var/vent_max_power = solar_gen_rate * 8

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
	var/destroyed
	var/datum/effect/system/smoke_spread/steam

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
	..()

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

/obj/machinery/power/geothermal
	name = "geothermal turbine"
	desc = "A hulking mass of pipes and metal used to produce power from underwater vents."
	icon = 'icons/obj/machines/geothermal.dmi'
	icon_state = "geothermal-base"
	density = 1
	opacity = 1
	anchored = 1

	// Power vars.
	use_power = 0
	idle_power_usage = 0
	active_power_usage = 0

	// Ref for power generation.
	var/obj/structure/underwater_vent/vent
	var/last_produced = 0
	var/list/neighbors = list()
	var/efficiency = 0
	var/destroyed

/obj/machinery/power/geothermal/attackby(var/obj/item/W, mob/user)

	if(W.iscoil())
		var/turf/T = get_turf(src)
		if(T && T.is_plating())
			var/from_dir = get_dir(src, user)
			for(var/obj/structure/cable/LC in T)
				if((LC.d1 == from_dir && LC.d2 == 0) || ( LC.d2 == from_dir && LC.d1 == 0))
					return
			var/obj/item/stack/cable_coil/coil = W
			coil.turf_place(T, user)
	. = ..()

/obj/machinery/power/geothermal/Destroy()
	destroyed = 1
	if(vent) vent.covered = 0
	update_neighbors()
	..()

/obj/machinery/power/geothermal/initialize()
	..()
	vent = locate() in get_turf(src)
	if(vent) vent.covered = 1
	if(powernet)
		connect_to_network()
	update_neighbors(1)

/obj/machinery/power/geothermal/proc/update_neighbors(var/propagate_update)
	neighbors = list()
	for(var/checkdir in list(NORTH, SOUTH, EAST, WEST))
		var/obj/machinery/power/geothermal/G = locate() in get_step(src, checkdir)
		if(G && !G.destroyed)
			neighbors |= checkdir
			if(propagate_update)
				G.update_neighbors()
	// Base + two neighbors covers all available vent tiles and produces 100% avail. power.
	efficiency = min(1,(neighbors.len * 0.3) + 0.4)
	update_icon()

/obj/machinery/power/geothermal/update_icon()
	overlays.Cut()
	var/cache_key = ""
	for(var/checkdir in neighbors)
		cache_key = "geothermal-connector-[checkdir]"
		if(!geothermal_cache[cache_key])
			geothermal_cache[cache_key] = image(icon_state = "geothermal-connector", dir = checkdir)
		overlays |= geothermal_cache[cache_key]
		if(last_produced)
			cache_key = "geothermal-connector-glow-[checkdir]"
			if(!geothermal_cache[cache_key])
				geothermal_cache[cache_key] = image(icon_state = "geothermal-connector-glow", dir = checkdir)
			overlays |= geothermal_cache[cache_key]
	if(stat & BROKEN)
		return
	if(vent)
		cache_key = "geothermal-turbine-[src.dir]"
		if(!geothermal_cache[cache_key])
			geothermal_cache[cache_key] = image(icon_state = "geothermal-turbine", dir = src.dir)
		overlays |= geothermal_cache[cache_key]
		if(last_produced)
			var/produced_alpha = min(255,max(0,round((last_produced / vent_max_power)*255)))
			cache_key = "geothermal-glow-[produced_alpha]-[src.dir]"
			if(!geothermal_cache[cache_key])
				var/image/I = image(icon_state = "geothermal-glow", dir = src.dir)
				I.alpha = produced_alpha
				geothermal_cache[cache_key] = I
			overlays |= geothermal_cache[cache_key]

/obj/machinery/power/geothermal/process()
	last_produced = 0
	if(!(stat & BROKEN))
		if(vent && powernet)
			last_produced = (rand(vent_min_power, vent_max_power) * efficiency)
			add_avail(last_produced)
	update_icon()
