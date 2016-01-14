var/image/open_space_overlay = image('icons/turf/space.dmi', "openspace")
var/list/open_space_cache = list()

/turf/simulated/open/proc/update_appearance()

	if(!need_appearance_update)
		return
	if(!istype(below))
		below = GetBelow(src)
	if(!below)
		return

	name = initial(name)
	desc = initial(desc)
	var/old_lum = luminosity
	overlays.Cut()
	appearance = below.appearance
	luminosity = old_lum
	overlays += open_space_overlay
	need_appearance_update = 0

	var/neighbor_dirs = 0
	for(var/check_dir in cardinal)
		var/turf/T = get_step(src, check_dir)
		if(!istype(T, /turf/simulated/open))
			neighbor_dirs |= check_dir

	/*
	// This does not currently work, sadly.
	var/corner_dirs = 0
	for(var/check_dir in cornerdirs)
		var/turf/T = get_step(src, check_dir)
		if(!istype(T, /turf/simulated/open))
			corner_dirs |= check_dir

	if((corner_dirs & NORTHEAST) && !(neighbor_dirs & (NORTH|EAST)))
		if(!open_space_cache["[NORTHEAST]"])
			open_space_cache["[NORTHEAST]"] = image(icon= 'icons/turf/space.dmi', icon_state = "openspace_edges", dir = NORTHEAST)
		overlays += open_space_cache["[NORTHEAST]"]

	if((corner_dirs & SOUTHEAST) && !(neighbor_dirs & (SOUTH|EAST)))
		if(!open_space_cache["[SOUTHEAST]"])
			open_space_cache["[SOUTHEAST]"] = image(icon= 'icons/turf/space.dmi', icon_state = "openspace_edges", dir = SOUTHEAST)
		overlays += open_space_cache["[SOUTHEAST]"]

	if((corner_dirs & NORTHWEST) && !(neighbor_dirs & NORTH|WEST)))
		if(!open_space_cache["[NORTHWEST]"])
			open_space_cache["[NORTHWEST]"] = image(icon= 'icons/turf/space.dmi', icon_state = "openspace_edges", dir = NORTHWEST)
		overlays += open_space_cache["[NORTHWEST]"]

	if((corner_dirs & SOUTHWEST) && !((neighbor_dirs & SOUTH|WEST)))
		if(!open_space_cache["[SOUTHWEST]"])
			open_space_cache["[SOUTHWEST]"] = image(icon= 'icons/turf/space.dmi', icon_state = "openspace_edges", dir = SOUTHWEST)
		overlays += open_space_cache["[SOUTHWEST]"]
	*/

	for(var/tempdir in cardinal)
		if(neighbor_dirs & tempdir)
			if(!open_space_cache["[tempdir]"])
				open_space_cache["[tempdir]"] = image(icon= 'icons/turf/space.dmi', icon_state = "openspace_edges", dir = tempdir)
			overlays += open_space_cache["[tempdir]"]

/turf/initialize()
	..()
	refresh_above()

/turf/proc/refresh_above()
	var/turf/simulated/open/open_space = GetAbove(src)
	if(istype(open_space))
		if(!open_space.need_appearance_update)
			open_space.need_appearance_update = 1
			queue_open_turf_update(open_space)

/turf/simulated/open/refresh_above()
	..()
	if(!need_appearance_update)
		need_appearance_update = 1
		queue_open_turf_update(src)

/turf/Entered(atom/movable/obj)
	. = ..()
	refresh_above()

/turf/Exited(atom/movable/obj)
	. = ..()
	refresh_above()

/atom/movable/lighting_overlay/update_overlay()
	if(..())
		var/turf/T = loc // Checked in ..()
		T.refresh_above()