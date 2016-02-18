/area/Entered(var/mob/M)
	..()
	if(istype(M))
		M.update_env_light()

/mob/proc/update_env_light()

	// Make sure they have moved.
	set waitfor = 0
	sleep(5)

	// Mob has not Login()'d or has no client.
	if(!client || !light_plane)
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
		use_alpha = initial(light_plane.alpha)
		use_color = initial(light_plane.color)

	// No point updating if none of the values are different.
	if((light_plane.alpha == use_alpha) && (light_plane.color == use_color))
		return
	// Yaaaay animate, you piece of crap.
	if((light_plane.alpha != use_alpha) && (light_plane.color != use_color))
		animate(light_plane, time = fade_time, alpha = use_alpha, color = use_color)
	else if(light_plane.alpha != use_alpha)
		animate(light_plane, time = fade_time, alpha = use_alpha)
	else if(light_plane.color != use_color)
		animate(light_plane, time = fade_time, color = use_color)

	return round(fade_time/2)