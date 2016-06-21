var/list/global/geothermal_cache = list()

/obj/machinery/geothermal_gen
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

/obj/machinery/geothermal_gen/Destroy()
	destroyed = 1
	if(vent) vent.covered = 0
	update_neighbors()
	..()

/obj/machinery/geothermal_gen/initialize()
	..()
	vent = locate() in get_turf(src)
	if(vent) vent.covered = 1
	connect_to_network()
	update_neighbors(1)

/obj/machinery/geothermal_gen/proc/update_neighbors(var/propagate_update)
	neighbors = list()
	for(var/checkdir in list(NORTH, SOUTH, EAST, WEST))
		var/obj/machinery/geothermal_gen/G = locate() in get_step(src, checkdir)
		if(G && !G.destroyed)
			neighbors |= checkdir
			if(propagate_update)
				G.update_neighbors()
	// Base + two neighbors covers all available vent tiles and produces 100% avail. power.
	efficiency = min(1,(neighbors.len * 0.3) + 0.4)
	update_icon()

/obj/machinery/geothermal_gen/update_icon()
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
			var/produced_alpha = min(255,max(0,round((last_produced / vent.vent_max_power)*255)))
			cache_key = "geothermal-glow-[produced_alpha]-[src.dir]"
			if(!geothermal_cache[cache_key])
				var/image/I = image(icon_state = "geothermal-glow", dir = src.dir)
				I.alpha = produced_alpha
				geothermal_cache[cache_key] = I
			overlays |= geothermal_cache[cache_key]

/obj/machinery/geothermal_gen/process()
	last_produced = 0
	if(!(stat & BROKEN))
		if(vent)
			last_produced = (rand(vent.vent_min_power, vent.vent_max_power) * efficiency)
			add_power(last_produced)
	update_icon() //todo optimize