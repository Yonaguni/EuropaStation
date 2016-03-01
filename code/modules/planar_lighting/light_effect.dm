var/list/light_over_cache = list()

/obj/light
	simulated = 0
	mouse_opacity = 0
	plane = DARK_PLANE
	layer = 20 // Over EVERYTHING.
	appearance_flags = KEEP_TOGETHER
	icon = null
	invisibility = SEE_INVISIBLE_NOLIGHTING
	pixel_x = -64
	pixel_y = -64
	glide_size = 32
	blend_mode = BLEND_ADD

	var/image/light_overlay
	var/current_power = 1
	var/atom/movable/holder
	var/point_angle
	var/list/affecting_turfs = list()

/obj/light/New(var/newholder)
	holder = newholder
	light_overlay = image(icon = 'icons/planar_lighting/lighting_overlays.dmi', icon_state = holder.light_type)
	light_overlay.blend_mode = BLEND_ADD
	light_overlay.mouse_opacity = 0
	light_overlay.plane = DARK_PLANE
	..(get_turf(holder))

/obj/light/Destroy()
	if(holder)
		moved_event.unregister(holder, src)
		dir_set_event.unregister(holder, src)
		destroyed_event.unregister(holder, src)
		if(holder.light_obj == src)
			holder.light_obj = null
		holder = null
	for(var/thing in affecting_turfs)
		var/turf/T = thing
		T.lumcount = -1
		T.affecting_lights -= src
	affecting_turfs.Cut()
	return .. ()

/obj/light/initialize()
	..()
	follow_holder_dir()
	follow_holder()
	moved_event.register(holder, src, /obj/light/proc/follow_holder)
	dir_set_event.register(holder, src, /obj/light/proc/follow_holder_dir)
	destroyed_event.register(holder, src, /obj/light/proc/destroy_self)

// Would be nice if we didn't need a qdel() wrapper for the event system.
/obj/light/proc/destroy_self()
	qdel(src)

// Applies power value to size (via Scale()) and updates the current rotation (via Turn())
// angle for directional lights. This is only ever called before cast_light() so affected turfs
// are updated elsewhere.
/obj/light/proc/update_transform(var/newrange)
	if(!isnull(newrange) && current_power != newrange)
		// Update affected turfs based on new size.
		current_power = newrange

	var/matrix/M = matrix()
	if(!isnull(point_angle))
		M.Turn(point_angle)
	M.Scale(current_power)
	light_overlay.transform = M

// Orients the light to the holder's (or the holder's holder) current dir.
// Also updates rotation for directional lights when appropriate.
/obj/light/proc/follow_holder_dir()
	if(istype(holder.loc, /mob) && holder.dir != holder.loc.dir)
		holder.set_dir(holder.loc.dir)
	if(dir != holder.dir)
		set_dir(holder.dir)

	if(light_overlay.icon_state == LIGHT_DIRECTIONAL)
		var/last_angle = point_angle
		switch(dir)
			if(NORTH)     point_angle = 90
			if(SOUTH)     point_angle = -90
			if(EAST)      point_angle = -180
			if(WEST)      point_angle = 0
			if(NORTHEAST) point_angle = 135
			if(NORTHWEST) point_angle = 45
			if(SOUTHEAST) point_angle = -135
			if(SOUTHWEST) point_angle = -45
			else          point_angle = null
		if(last_angle != point_angle)
			update_transform()
			cast_light()


// Moves the light overlay to the holder's turf and updates bleeding values accordingly.
/obj/light/proc/follow_holder()
	forceMove(get_turf(holder))
	cast_light()
