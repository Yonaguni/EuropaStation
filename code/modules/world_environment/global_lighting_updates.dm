/area/Entered(var/mob/M)
	..()
	if(istype(M))
		M.update_env_light()

/mob/proc/update_env_light()

	// Make sure they have moved.
	set waitfor = 0
	sleep(-1)

	// Mob has not Login()'d or has no client.
	if(!client || !dark_plane)
		return 0

	// Get the appropriate data.
	var/use_color
	var/use_alpha
	var/fade_time = 300

	var/turf/T = get_turf(src)
	var/area/A = get_area(src)
	if((T && T.outside) || (A && A.outside))
		use_alpha = exterior_lighting.alpha
		use_color = exterior_lighting.color
	else
		fade_time = 20
		use_alpha = initial(dark_plane.alpha)
		use_color = initial(dark_plane.color)

	// So the roundstart fadeup is quick.
	if(dark_plane.first_state_change)
		fade_time = 5
		dark_plane.first_state_change = 0

	// No point updating if none of the values are different.
	if((dark_plane.alpha == use_alpha) && (dark_plane.color == use_color))
		return
	// Yaaaay animate, you piece of crap. Called infrequently enough that it should be fine.
	if((dark_plane.alpha != use_alpha) && (dark_plane.color != use_color))
		animate(dark_plane, time = fade_time, alpha = use_alpha, color = use_color)
	else if(dark_plane.alpha != use_alpha)
		animate(dark_plane, time = fade_time, alpha = use_alpha)
	else if(dark_plane.color != use_color)
		animate(dark_plane, time = fade_time, color = use_color)

	return round(fade_time/2)