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
	overlays += below.lighting_overlay

	color = "#878787" // Will break paint, don't care for now. Makes the turf look dark/low.

	// Grabbing all objects will cause directional issues.
	/*
	var/obj/structure/stairs/S = locate() in below.contents
	if(S)
		overlays += S

	*/

	// All of the following options cause odd overlay issues.
	//alpha = 120
	//pixel_x = 3  // Doesn't work, leave commented for now.
	//pixel_y = -8 // As above.
	//plane = -50  //BYOND 509.* only.

	luminosity = old_lum

	need_appearance_update = 0

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