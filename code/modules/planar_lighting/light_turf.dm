/turf/var/blocks_light = -1              // Whether or not this turf occludes light based on turf opacity and contents. See check_blocks_lights().
/turf/var/list/affecting_lights = list() // Non-assoc list of all lighting overlays applied to this turf.
/turf/var/lum_edges = 0                  // Bitfield, number of edges exposed to light, set in light_effect_cast.dm.
/turf/var/lum_count = 0                  // Value, cumulative power of lights effecting turf, set in light_effect_cast.dm.
/turf/var/lum_color = "#FFFFFF"

/turf/initialize()
	..()
	if(lighting_controller)
		lighting_controller.mark_for_update(src)

// Forces a rebuild of all affecting lights. Very costly. I don't see much of
// a use for this yet but it'd be nice to have for admin proc calling at runtime.
/turf/proc/update_affecting_lights()
	affecting_lights.Cut()
	dview_mob.loc = src
	dview_mob.see_invisible = 0
	for(var/obj/light/L in view(world.view, dview_mob))
		var/light_dist = get_dist(src, get_turf(L))
		if(L.current_power >= light_dist)
			affecting_lights += L
	dview_mob.loc = null

/turf/proc/update_light_edges()
	lum_edges = 0
	for(var/thing in affecting_lights)
		var/obj/light/L = thing
		lum_edges |= get_dir(get_turf(L), src)

// Redraws the edge lighting overlays for this turf and offsets them appropriately.
// TODO: a method other than update_icon() for clearing lighting overlays from turf overlay lists.
/turf/proc/update_light_overlays()

	// Floor don't have lit edges!
	if(!check_blocks_light())
		return

	for(var/checkdir in cardinal)

		// We don't have light from this dir. Go home.
		if(!(lum_edges & checkdir))
			continue

		// Make sure this is a turf edge we should be lighting up.
		var/turf/T = get_step(src, checkdir)
		if(!istype(T) || T.check_blocks_light())
			continue

		// Cache/apply edge lighting.
		var/cache_key = "gradient-[lum_color]-[lum_count]-[checkdir]"
		if(!light_over_cache[cache_key])
			var/image/darkmask/I = new
			I.icon_state = "gradient[checkdir]"
			I.blend_mode = BLEND_ADD
			I.color = lum_color
			I.alpha = min(200,max(5,lum_count * 5))

			// We're actually overlaying this edge onto the neighboring turf so that people
			// on the opposite side won't see the lighting; pixel offset accordingly.
			switch(checkdir)
				if(NORTH)
					I.pixel_y = -32
				if(SOUTH)
					I.pixel_y = 32
				if(EAST)
					I.pixel_x = -32
				if(WEST)
					I.pixel_x = 32

			// Cache it!
			light_over_cache[cache_key] = I

		// This will call overlays.Cut() safely.
		// May be worth doing a less brute-force approach.
		T.update_icon()
		T.overlays += light_over_cache[cache_key]

// Flags the turf to recalc blocks_light next clal since opacity has changed.
/turf/set_opacity()
	var/old_opacity = opacity
	. = ..()
	if(opacity != old_opacity) blocks_light = -1

// Checks if the turf contains an occluding object or is itself an occluding object.
/turf/proc/check_blocks_light()
	if(blocks_light == -1)
		blocks_light = 0
		if(opacity)
			blocks_light = 1
		else
			for(var/atom/movable/AM in contents)
				if(AM.opacity)
					blocks_light = 1
					break
	return blocks_light

// Returns a list of occluding corners based on the angle of the light to the turf
// as well as the available edges of clear space around the turf. Calculated and
// called in light_effect_cast.dm.

// Should theoretically be possible to override this down the track to generate
// directional shadow casting points for non-full-turf objects or structures.

/turf/proc/get_corner_offsets(var/check_angle, var/check_dirs)
	var/list/offsets = list(0,0,0,0)
	if(abs(check_angle) == 180) // Source is west.
		if(check_dirs & NORTH)
			offsets[1] = -1
			offsets[2] =  1
		if(check_dirs & SOUTH)
			offsets[3] = -1
			offsets[4] = -1
	else if(check_angle == 90)  // Source is south.
		if(check_dirs & WEST)
			offsets[1] = -1
			offsets[2] = -1
		if(check_dirs & EAST)
			offsets[3] =  1
			offsets[4] = -1
	else if(check_angle == 0)   // Source is east.
		if(check_dirs & SOUTH)
			offsets[1] =  1
			offsets[2] = -1
		if(check_dirs & NORTH)
			offsets[3] =  1
			offsets[4] =  1
	else if(check_angle == -90) // Source is north.
		if(check_dirs & EAST)
			offsets[1] =  1
			offsets[2] =  1
		if(check_dirs & WEST)
			offsets[3] = -1
			offsets[4] =  1
	else
		switch(check_angle)
			if(-179 to -89)      // Source is northwest.
				if(check_dirs & EAST)
					offsets[1] =   1
					offsets[2] =   1
				if(check_dirs & SOUTH)
					offsets[3] =  -1
					offsets[4] =  -1
			if(-90 to -1)         // Source is northeast.
				if(check_dirs & SOUTH)
					offsets[1] =   1
					offsets[2] =  -1
				if(check_dirs & WEST)
					offsets[3] =  -1
					offsets[4] =   1
			if(0 to 89)          // Source is southeast.
				if(check_dirs & WEST)
					offsets[1] =  -1
					offsets[2] =  -1
				if(check_dirs & NORTH)
					offsets[3] =   1
					offsets[4] =   1
			if(90 to 179)        // Source is southwest.
				if(check_dirs & NORTH)
					offsets[1] =  -1
					offsets[2] =   1
				if(check_dirs & EAST)
					offsets[3] =   1
					offsets[4] =  -1
	return offsets