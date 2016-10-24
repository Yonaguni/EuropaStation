#define BASE_PIXEL_OFFSET 224
#define BASE_TURF_OFFSET 2
#define WIDE_SHADOW_THRESHOLD 80
#define OFFSET_MULTIPLIER_SIZE 32
#define CORNER_OFFSET_MULTIPLIER_SIZE 16

// Casts shadows from occluding objects for a given light. This is essentially just a big
// chunky 'mask everything we can't see' proc which also casts rotated shadows from occluding
// turf corners. See light_turf.dm for how corners are calculated.

/obj/effect/light/proc/cast_light()
	overlays = list()

	if(!isturf(loc))
		for(var/turf/T in affecting_turfs)
			T.lumcount = -1
			T.affecting_lights -= src
		affecting_turfs.Cut()
		return

	switch(light_range)
		if(1)
			icon = 'icons/planar_lighting/light_range_1.dmi'
		if(2)
			icon = 'icons/planar_lighting/light_range_2.dmi'
		if(3)
			icon = 'icons/planar_lighting/light_range_3.dmi'
		if(4)
			icon = 'icons/planar_lighting/light_range_4.dmi'
		if(5)
			icon = 'icons/planar_lighting/light_range_5.dmi'
		else
			qdel(src)
			return

	icon_state = "white"
	pixel_x = pixel_y = -(world.icon_size * light_range)

	var/image/base_image = image(icon)
	base_image.icon_state = "overlay"
	base_image.layer = 4
	overlays += base_image

	//no shadows
	if(light_range < 2)
		return

	var/list/visible_turfs = list()

	for(var/turf/T in view(light_range, src))
		visible_turfs += T

	for(var/turf/T in visible_turfs)
		if(CheckOcclusion(T))
			CastShadow(T)



/obj/effect/light/proc/CastShadow(var/turf/target_turf)
	//get the x and y offsets for how far the target turf is from the light
	var/x_offset = target_turf.x - x
	var/y_offset = target_turf.y - y

	//due to only having one set of shadow templates, we need to rotate and flip them for up to 8 different directions
	//first check is to see if we will need to "rotate" the shadow template
	var/xy_swap = 0
	if(abs(x_offset) > abs(y_offset))
		xy_swap = 1

	var/image/I = image(icon)

	//due to the way the offsets are named, we can just swap the x and y offsets to "rotate" the icon state
	if(xy_swap)
		I.icon_state = "[abs(y_offset)]_[abs(x_offset)]"
	else
		I.icon_state = "[abs(x_offset)]_[abs(y_offset)]"

	var/matrix/M = matrix()

	//TODO: rewrite this comment:
	//using scale to flip the shadow template if needed
	//horizontal (x) flip is easy, we just check if the offset is negative
	//vertical (y) flip is a little harder, if the shadow will be rotated we need to flip if the offset is positive,
	// but if it wont be rotated then we just check if its negative to flip (like the x flip)
	var/x_flip
	var/y_flip
	if(xy_swap)
		x_flip = y_offset > 0 ? -1 : 1
		y_flip = x_offset < 0 ? -1 : 1
	else
		x_flip = x_offset < 0 ? -1 : 1
		y_flip = y_offset < 0 ? -1 : 1

	M.Scale(x_flip, y_flip)

	//here we do the actual rotate if needed
	if(xy_swap)
		M.Turn(90)

	//apply the transform matrix
	I.transform = M
	I.layer = 2

	//and add it to the lights overlays
	overlays += I


	var/targ_dir = get_dir(target_turf, src)

	var/blocking_dirs = 0
	for(var/d in cardinal)
		var/turf/T = get_step(target_turf, d)
		if(CheckOcclusion(T))//.opacity)
			blocking_dirs |= d

	I = image('icons/planar_lighting/wall_lighting.dmi')
	I.icon_state = "[blocking_dirs]-[targ_dir]"
	I.pixel_x = (world.icon_size * light_range) + (x_offset * world.icon_size)
	I.pixel_y = (world.icon_size * light_range) + (y_offset * world.icon_size)
	I.layer = 3

	overlays += I

/obj/effect/light/proc/CheckOcclusion(var/turf/T)
	if(!istype(T))
		return 0

	if(T.opacity)
		return 1

	for(var/obj/machinery/door/D in T)
		if(D.opacity)
			return 1

	return 0

#undef BASE_PIXEL_OFFSET
#undef BASE_TURF_OFFSET
#undef WIDE_SHADOW_THRESHOLD
#undef OFFSET_MULTIPLIER_SIZE
#undef CORNER_OFFSET_MULTIPLIER_SIZE
