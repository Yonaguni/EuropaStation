#define BASE_PIXEL_OFFSET 224
#define BASE_TURF_OFFSET 2
#define WIDE_SHADOW_THRESHOLD 80
#define OFFSET_MULTIPLIER_SIZE 32
#define CORNER_OFFSET_MULTIPLIER_SIZE 16

// Casts shadows from occluding objects for a given light. This is essentially just a big
// chunky 'mask everything we can't see' proc which also casts rotated shadows from occluding
// turf corners. See light_turf.dm for how corners are calculated.

/obj/light/proc/cast_light()
	//we dont cast shadows from lights with less than 2 range
	if(light_range < 2)
		return

	//loop through the turfs in range of the light, from closest to furthest
	//starting with the turfs closest to the source, until the second to last "ring" of turfs
	for(var/cur_loop = 1 to light_range - 1)
		//run through the current "ring" row by row, starting at the bottom
		for(var/test_y = -cur_loop to cur_loop)
			//if we are at the top or bottom of the "ring"
			if(abs(test_y) == cur_loop)
				//go through each turf from left to right
				for(var/test_x = -cur_loop to cur_loop)
					var/turf/T = locate(x + test_x, y + test_y, z)
					if(T.density)
						CastShadow(T)
			//otherwise we are going up the sides of the "ring" and only do the leftmost and rightmost turfs
			else
				var/turf/T = locate(x - cur_loop, y + test_y, z)
				if(T.density)
					CastShadow(T)

				T = locate(x + cur_loop, y + test_y, z)
				if(T.density)
					CastShadow(T)

/obj/light/proc/CastShadow(var/turf/target_turf)
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

	//TODO: rewrite this:
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

	//and add it to the lights overlays
	overlays += I
/*
	if(!isturf(loc))
		overlays = null
		return

	//Prevent appearance churn by adding all overlays at onces
	var/list/overlays_to_add = list()

	// Readd core lighting overlay.
	overlays_to_add += light_overlay

	var/turf/origin = get_turf(src)
	if(!istype(origin))
		overlays = null
		return

	// We're using dview in a context it wasn't written for so gotta hardcode this.
	dview_mob.loc = origin
	dview_mob.see_invisible = 0

	// Get a list of turfs that are visible according to BYOND. It will be worth rewriting this
	// somewhere down the track so that angles other than multiples of 45 degrees will occlude
	// properly, at the moment if you move 2 up 1 across from a wall, it won't block light at all.
	var/effective_power = current_power+1 // This seems to be needed for good shadow casting effects at low power.
	var/list/visible_turfs = list()
	for(var/turf/T in view(effective_power, dview_mob))
		visible_turfs += T

	// As above, hardcode.
	dview_mob.loc = null

	// Work out which turfs we cannot see from this point.
	var/list/concealed_turfs = list()
	for(var/turf/T in (trange(effective_power, origin) - visible_turfs))
		concealed_turfs += T

	/*
	// Check if this is a turf we want to use in corner masking checks. Apply masking if needed.
	var/n_x = 2*origin.x
	var/n_y = 2*origin.y
	*/

	// Now the fun part. Check over visible turfs and apply lighting appropriately.
	var/list/walls = list()
	for(var/thing in visible_turfs)
		var/turf/check = thing

		if(!(check in affecting_turfs))
			affecting_turfs += check
			check.lumcount = -1
			check.affecting_lights += src

		if(!check.check_blocks_light())
			continue

		walls += check // Used later for bleed masking.

		/*
		DISABLED DUE TO PERFORMANCE AND VISUAL
		   PROBLEMS, UNCOMMENT WHEN FIXED.

		var/edgedirs = 0
		if(check.check_has_corners())
			for(var/edgedir in cardinal)
				var/turf/cardinal_neighbour = get_step(check, edgedir)
				if(istype(cardinal_neighbour) && !cardinal_neighbour.check_blocks_light() && (cardinal_neighbour in visible_turfs))
					edgedirs |= edgedir
		if(!edgedirs)
			continue

		var/c_x = 2*check.x
		var/c_y = 2*check.y

		var/cast_angle = -(Atan2(n_x - c_x, n_y - c_y))
		var/list/offsets = check.get_corner_offsets(cast_angle, edgedirs)

		var/matrix/M
		var/base_x = (((check.x-origin.x+BASE_TURF_OFFSET)*OFFSET_MULTIPLIER_SIZE)-BASE_PIXEL_OFFSET)
		var/base_y = (((check.y-origin.y+BASE_TURF_OFFSET)*OFFSET_MULTIPLIER_SIZE)-BASE_PIXEL_OFFSET)

		var/corner_one = (offsets[1] ? -(Atan2(n_x-(c_x+offsets[1]),n_y-(c_y+offsets[2]))) : 0)
		var/corner_two = (offsets[3] ? -(Atan2(n_x-(c_x+offsets[3]),n_y-(c_y+offsets[4]))) : 0)

		var/overlay_width
		if(!offsets[1] || !offsets[3] || (abs(corner_one - corner_two) >= WIDE_SHADOW_THRESHOLD))
			overlay_width = 1

		if(corner_one)
			var/use_x = base_x+(offsets[1]*CORNER_OFFSET_MULTIPLIER_SIZE)
			var/use_y = base_y+(offsets[2]*CORNER_OFFSET_MULTIPLIER_SIZE)
			var/cache_key = "firstcorner-[use_x]-[use_y]-[overlay_width]-[corner_one]"
			if(!light_over_cache[cache_key])
				var/image/darkmask/I = new
				I.icon = 'icons/planar_lighting/masking_overlays.dmi'
				I.icon_state = (overlay_width ? "upwide" : "up")
				I.pixel_x = use_x
				I.pixel_y = use_y
				M = matrix()
				M.Turn(corner_one)
				I.transform = M
				light_over_cache[cache_key] = I
			overlays_to_add += light_over_cache[cache_key]

		if(corner_two)
			var/use_x = base_x+(offsets[3]*CORNER_OFFSET_MULTIPLIER_SIZE)
			var/use_y = base_y+(offsets[4]*CORNER_OFFSET_MULTIPLIER_SIZE)
			var/cache_key = "secondcorner-[use_x]-[use_y]-[overlay_width]-[corner_two]"
			if(!light_over_cache[cache_key])
				var/image/darkmask/I = new
				I.icon = 'icons/planar_lighting/masking_overlays.dmi'
				I.icon_state = (overlay_width ? "downwide" : "down")
				I.pixel_x = use_x
				I.pixel_y = use_y
				M = matrix()
				M.Turn(corner_two)
				I.transform = M
				light_over_cache[cache_key] = I
			overlays_to_add += light_over_cache[cache_key]
		*/

	// Update turfs we are no longer lighting.
	for(var/thing in (affecting_turfs-visible_turfs))
		affecting_turfs -= thing
		var/turf/T = thing
		T.lumcount = -1
		T.affecting_lights -= src

	//TO(re)DO: iterate over 'walls' and apply an edge lighting overlay based on direction of source.
	// The client lag seems to be coming from elsewhere than the number of blocking overlays (maybe).

	// Mask off stuff that we 100% cannot see.
	for(var/thing in concealed_turfs)
		var/turf/check = thing
		var/use_x = (check.x-origin.x+BASE_TURF_OFFSET) * OFFSET_MULTIPLIER_SIZE
		var/use_y = (check.y-origin.y+BASE_TURF_OFFSET) * OFFSET_MULTIPLIER_SIZE
		var/cache_key = "conceal-[use_x]-[use_y]"
		if(!light_over_cache[cache_key])
			var/image/darkmask/I = new
			I.pixel_x = use_x
			I.pixel_y = use_y
			light_over_cache[cache_key] = I
		overlays_to_add += light_over_cache[cache_key]

	overlays = overlays_to_add
*/
#undef BASE_PIXEL_OFFSET
#undef BASE_TURF_OFFSET
#undef WIDE_SHADOW_THRESHOLD
#undef OFFSET_MULTIPLIER_SIZE
#undef CORNER_OFFSET_MULTIPLIER_SIZE
