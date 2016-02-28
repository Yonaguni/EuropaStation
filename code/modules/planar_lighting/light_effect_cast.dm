#define BASE_PIXEL_OFFSET 224
#define BASE_TURF_OFFSET 2
#define WIDE_SHADOW_THRESHOLD 500
#define OFFSET_MULTIPLIER_SIZE 32
#define CORNER_OFFSET_MULTIPLIER_SIZE 16

// Casts shadows from occluding objects for a given light. This is essentially just a big
// chunky 'mask everything we can't see' proc which also casts rotated shadows from occluding
// turf corners. See light_turf.dm for how corners are calculated.

/obj/light/proc/cast_light()

	// Clear overlays, blank slate.
	overlays.Cut()
	if(!isturf(loc))
		return

	// Readd core lighting overlay.
	overlays += light_overlay

	var/turf/origin = get_turf(src)
	if(!istype(origin))
		return

	// We're using dview in a context it wasn't written for so gotta hardcode this.
	dview_mob.loc = origin
	dview_mob.see_invisible = 0

	// Get a list of turfs that are visible according to BYOND. It will be worth rewriting this
	// somewhere down the track so that angles other than multiples of 45 degrees will occlude
	// properly, at the moment if you move 2 up 1 across from a wall, it won't block light at all.
	var/list/visible_turfs = list()
	for(var/turf/T in view(current_power, dview_mob))
		visible_turfs += T

	// As above, hardcode.
	dview_mob.loc = null

	// Work out which turfs we cannot see from this point.
	var/list/concealed_turfs = list()
	for(var/turf/T in (range(current_power, origin) - visible_turfs))
		concealed_turfs += T

	// Check if this is a turf we want to use in corner masking checks. Apply masking if needed.
	var/n_x = 2*origin.x
	var/n_y = 2*origin.y

	// Now the fun part. Check over visible turfs and apply lighting appropriately.
	var/list/walls = list()
	for(var/thing in visible_turfs)
		var/turf/check = thing

		if(!check.check_blocks_light())
			continue

		walls += check // Used later for bleed masking.
		check.affecting_lights |= src // This turf should be aware we're lighting it up.
		affecting_turfs += check // We should keep track of the turfs we're lighting up.

		var/edgecount = 0
		var/edgedirs = 0
		for(var/edgedir in cardinal)
			var/turf/cardinal_neighbour = get_step(check, edgedir)
			if(istype(cardinal_neighbour) && !cardinal_neighbour.check_blocks_light() && (cardinal_neighbour in visible_turfs))
				edgecount++
				edgedirs |= edgedir

		if(edgecount < 2 || !edgedirs)
			continue

		if(!(check in affecting_turfs))
			affecting_turfs += check
			check.lum_count += current_power
			check.lum_color = light_overlay.color //todo, proper blending
			check.update_light_edges()

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
			overlays += light_over_cache[cache_key]

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
			overlays += light_over_cache[cache_key]

	// Update turfs we are no longer lighting.
	for(var/thing in affecting_turfs)
		if(!(thing in visible_turfs))
			affecting_turfs -= thing
			var/turf/T = thing
			T.lum_count -= current_power
			T.affecting_lights -= src
			T.update_light_edges()
			if(lighting_controller)
				lighting_controller.mark_for_update(T)

	// Mask off stuff that we 100% cannot see, plus walls to prevent light bleed.
	// Walls handle their own edge lighting seperately, see light_turf.dm.
	for(var/thing in (concealed_turfs|walls))
		var/turf/check = thing
		var/use_x = (check.x-origin.x+BASE_TURF_OFFSET) * OFFSET_MULTIPLIER_SIZE
		var/use_y = (check.y-origin.y+BASE_TURF_OFFSET) * OFFSET_MULTIPLIER_SIZE
		var/cache_key = "conceal-[use_x]-[use_y]"
		if(!light_over_cache[cache_key])
			var/image/darkmask/I = new
			I.pixel_x = use_x
			I.pixel_y = use_y
			light_over_cache[cache_key] = I
		overlays += light_over_cache[cache_key]

	return

#undef BASE_PIXEL_OFFSET
#undef BASE_TURF_OFFSET
#undef WIDE_SHADOW_THRESHOLD
#undef OFFSET_MULTIPLIER_SIZE
#undef CORNER_OFFSET_MULTIPLIER_SIZE