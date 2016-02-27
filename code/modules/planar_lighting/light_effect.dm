/obj/light
	simulated = 0
	mouse_opacity = 0
	plane = DARK_PLANE
	appearance_flags = KEEP_TOGETHER
	icon = null
	icon_state = ""
	invisibility = SEE_INVISIBLE_NOLIGHTING
	pixel_x = -32
	pixel_y = -32
	glide_size = 32
	blend_mode = BLEND_ADD

	var/image/light_overlay
	var/current_power = 1
	var/atom/movable/holder

/obj/light/New(var/newholder)
	holder = newholder
	light_overlay = image(icon = 'icons/planar_lighting/lighting_overlays.dmi', icon_state = "soft")
	light_overlay.blend_mode = BLEND_ADD
	light_overlay.mouse_opacity = 0
	light_overlay.plane = DARK_PLANE
	..()

/obj/light/Destroy()
	if(holder)
		moved_event.unregister(holder, src)
		dir_set_event.unregister(holder, src)
		destroyed_event.unregister(holder, src)
		if(holder.light_obj == src)
			holder.light_obj = null
		holder = null
	return .. ()

/obj/light/initialize()
	if(!istype(holder, /atom/movable))
		world << "DEBUG: [src] has holder [holder], is [holder.type]."
		qdel(src)
		return
	follow_holder()
	moved_event.register(holder, src, /obj/light/proc/follow_holder)
	dir_set_event.register(holder, src, /obj/light/proc/follow_holder_dir)
	destroyed_event.register(holder, src, /obj/light/proc/destroy_self)

/obj/light/proc/destroy_self()
	qdel(src)

/obj/light/proc/follow_holder_dir()
	if(istype(holder.loc, /mob))
		if(dir != holder.loc.dir) set_dir(holder.loc.dir)
	else
		if(dir != holder.dir) set_dir(holder.dir)

/obj/light/proc/follow_holder()
	if(istype(holder.loc, /mob))
		loc = get_turf(holder)
	else
		loc = holder.loc
	follow_holder_dir()
	update_bleed_masking()

/image/darkmask
	blend_mode = BLEND_SUBTRACT
	mouse_opacity = 0
	plane = DARK_PLANE
	icon = 'icons/planar_lighting/over_dark.dmi'
	appearance_flags = KEEP_TOGETHER

/obj/light/proc/update_bleed_masking()
	// Clear overlays, blank slate.
	overlays.Cut()
	if(!isturf(loc))
		return
	overlays += light_overlay
	var/effective_range = ceil(current_power*0.75)+2 // Value that the overlay is scaled by. //+2 seems needed in practice.
	if(effective_range <= 1)
		return
	var/turf/origin = get_turf(src)
	if(!istype(origin))
		return
	// We're using dview in a context it wasn't written for so gotta hardcode this.
	dview_mob.loc = origin
	dview_mob.see_invisible = 0
	var/list/visible_turfs = view(effective_range, dview_mob)
	dview_mob.loc = null
	// Get our general operating ranges.
	var/list/concealed_turfs = (range(effective_range, origin) - visible_turfs)
	// Mask off stuff that we 100% cannot see.
	for(var/turf/check in concealed_turfs)
		var/image/darkmask/I = new
		I.pixel_x = ((check.x-origin.x)+1) * 32
		I.pixel_y = ((check.y-origin.y)+1) * 32
		overlays += I

	// Check if this is a turf we want to use in corner masking checks. Apply masking if needed.
	var/n_x = 2*origin.x
	var/n_y = 2*origin.y

	var/list/walls = list()

	for(var/turf/check in visible_turfs)

		if(!check.check_blocks_light())
			continue

		walls += check

		var/has_dark_neighbor
		for(var/checkdir in alldirs)
			var/turf/neighbour = get_step(check, checkdir)
			if(istype(neighbour) && (neighbour in concealed_turfs))
				has_dark_neighbor = 1
				break

		if(!has_dark_neighbor)
			continue

		var/edgecount = 0
		var/edgedirs = 0
		for(var/secondcheckdir in cardinal)
			var/turf/cardinal_neighbour = get_step(check, secondcheckdir)
			if(istype(cardinal_neighbour) && !cardinal_neighbour.check_blocks_light() && (cardinal_neighbour in visible_turfs))
				edgecount++
				edgedirs |= secondcheckdir

		if(edgecount < 2 || !edgedirs)
			continue

		var/c_x = 2*check.x
		var/c_y = 2*check.y

		var/angle_one_x_offset = 0
		var/angle_one_y_offset = 0
		var/angle_two_x_offset = 0
		var/angle_two_y_offset = 0

		var/simple_angle = -(round(Atan2(n_x - c_x, n_y - c_y)))
		if(abs(simple_angle) == 180) // Source is west.
			if(edgedirs & NORTH)
				angle_one_x_offset = -1
				angle_one_y_offset =  1
			if(edgedirs & SOUTH)
				angle_two_x_offset = -1
				angle_two_y_offset = -1
		else if(simple_angle == 90)  // Source is south.
			if(edgedirs & WEST)
				angle_one_x_offset = -1
				angle_one_y_offset = -1
			if(edgedirs & EAST)
				angle_two_x_offset =  1
				angle_two_y_offset = -1
		else if(simple_angle == 0)   // Source is east.
			if(edgedirs & SOUTH)
				angle_one_x_offset =  1
				angle_one_y_offset = -1
			if(edgedirs & NORTH)
				angle_two_x_offset =  1
				angle_two_y_offset =  1
		else if(simple_angle == -90) // Source is north.
			if(edgedirs & EAST)
				angle_one_x_offset =  1
				angle_one_y_offset =  1
			if(edgedirs & WEST)
				angle_two_x_offset = -1
				angle_two_y_offset =  1
		else
			switch(simple_angle)
				if(-179 to -89)      // Source is northwest.
					if(edgedirs & EAST)
						angle_one_x_offset =   1
						angle_one_y_offset =   1
					if(edgedirs & SOUTH)
						angle_two_x_offset =  -1
						angle_two_y_offset =  -1
				if(-90 to -1)         // Source is northeast.
					if(edgedirs & SOUTH)
						angle_one_x_offset =   1
						angle_one_y_offset =  -1
					if(edgedirs & WEST)
						angle_two_x_offset =  -1
						angle_two_y_offset =   1
				if(0 to 89)          // Source is southeast.
					if(edgedirs & WEST)
						angle_one_x_offset =  -1
						angle_one_y_offset =  -1
					if(edgedirs & NORTH)
						angle_two_x_offset =   1
						angle_two_y_offset =   1
				if(90 to 179)        // Source is southwest.
					if(edgedirs & NORTH)
						angle_one_x_offset =  -1
						angle_one_y_offset =   1
					if(edgedirs & EAST)
						angle_two_x_offset =   1
						angle_two_y_offset =  -1

		var/image/darkmask/I
		var/matrix/M
		var/base_x = ((((check.x-origin.x)+1)*32)-224)
		var/base_y = ((((check.y-origin.y)+1)*32)-224)

		var/angle_one = (angle_one_x_offset ? -(round(Atan2(n_x-(c_x+angle_one_x_offset),n_y-(c_y+angle_one_y_offset)))) : 0)
		var/angle_two = (angle_two_x_offset ? -(round(Atan2(n_x-(c_x+angle_two_x_offset),n_y-(c_y+angle_two_y_offset)))) : 0)

		var/overlay_width
		if(!angle_one_x_offset || !angle_two_x_offset || (abs(angle_one - angle_two) >= 85))
			overlay_width = 1

		if(angle_one)
			I = new
			I.icon = 'icons/planar_lighting/masking_overlays.dmi'
			I.icon_state = (overlay_width ? "upwide" : "up")
			I.pixel_x = base_x+(angle_one_x_offset*16)
			I.pixel_y = base_y+(angle_one_y_offset*16)
			M = matrix()
			M.Turn(angle_one)
			I.transform = M
			overlays |= I

		if(angle_two)
			I = new
			I.icon = 'icons/planar_lighting/masking_overlays.dmi'
			I.icon_state = (overlay_width ? "downwide" : "down")
			I.pixel_x = base_x+(angle_two_x_offset*16)
			I.pixel_y = base_y+(angle_two_y_offset*16)
			M = matrix()
			M.Turn(angle_two)
			I.transform = M
			overlays |= I

	// Mask out the walls/opaque turfs so general light doesn't show up for people on the other side.
	for(var/turf/check in walls)
		var/image/darkmask/I = new
		I.pixel_x = ((check.x-origin.x)+1) * 32
		I.pixel_y = ((check.y-origin.y)+1) * 32
		overlays += I
	return