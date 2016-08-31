/obj/effect/light
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

/obj/effect/light/New(var/newholder)
	holder = newholder
	light_overlay = image(icon = 'icons/planar_lighting/lighting_overlays.dmi', icon_state = holder.light_type)
	light_overlay.blend_mode = BLEND_ADD
	light_overlay.mouse_opacity = 0
	light_overlay.plane = DARK_PLANE
	..(get_turf(holder))

/obj/effect/light/Del()
	return ..()

/obj/effect/light/Destroy()

	moved_event.unregister(holder, src)
	dir_set_event.unregister(holder, src)
	destroyed_event.unregister(holder, src)

	transform = null
	appearance = null
	overlays = null
	light_overlay = null

	if(holder)
		if(holder.light_obj == src)
			holder.light_obj = null
		holder = null
	for(var/thing in affecting_turfs)
		var/turf/T = thing
		T.lumcount = -1
		T.affecting_lights -= src
	affecting_turfs.Cut()
	. = .. ()

/atom/movable/Move()
	. = ..()
	if(light_obj)
		light_obj.follow_holder()

/atom/movable/forceMove()
	. = ..()
	if(light_obj)
		light_obj.follow_holder()

/atom/set_dir()
	. = ..()
	if(light_obj)
		light_obj.follow_holder_dir()

/mob/living/carbon/human/set_dir()
	. = ..()
	for(var/obj/item/I in (contents-(internal_organs+organs)))
		if(!I.simulated || !I.light_obj)
			continue
		I.set_dir(dir)

/mob/living/carbon/human/Move()
	. = ..()
	for(var/obj/item/I in (contents-(internal_organs+organs)))
		if(!I.simulated || !I.light_obj)
			continue
		I.light_obj.follow_holder()

/mob/living/carbon/human/forceMove()
	. = ..()
	for(var/obj/item/I in (contents-(internal_organs+organs)))
		if(!I.simulated || !I.light_obj)
			continue
		I.light_obj.follow_holder()

/obj/effect/light/initialize()
	..()
	if(holder)
		follow_holder_dir()
		follow_holder()

// Applies power value to size (via Scale()) and updates the current rotation (via Turn())
// angle for directional lights. This is only ever called before cast_light() so affected turfs
// are updated elsewhere.
/obj/effect/light/proc/update_transform(var/newrange)
	if(!isnull(newrange) && current_power != newrange)
		current_power = newrange
	var/matrix/M = matrix()
	if(!isnull(point_angle))
		M.Turn(point_angle)
	M.Scale(current_power)
	light_overlay.transform = M

// Orients the light to the holder's (or the holder's holder) current dir.
// Also updates rotation for directional lights when appropriate.
/obj/effect/light/proc/follow_holder_dir()

	if(dir != holder.dir)
		set_dir(holder.dir)

	if(is_directional_light())
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
/obj/effect/light/proc/follow_holder()
	if(holder && holder.loc)
		if(holder.loc.loc && ismob(holder.loc))
			forceMove(holder.loc.loc)
		else
			forceMove(holder.loc)
	cast_light()

/obj/effect/light/proc/is_directional_light()
	return (holder.light_type == LIGHT_DIRECTIONAL)