var/global_light_brightness = 6
var/global_light_colour = "#FFFFFF"

/turf/var/outside

/turf/initialize()
	if(!blocks_air && !density)
		var/area/A = get_area(src)
		if(A.outside)
			outside = 1
			sleep(-1)
			update_world_lights()
	return ..()


/turf/proc/update_world_lights()
	for(var/turf/T in range(src, 1))
		if(T.outside)
			continue
		set_light(global_light_brightness, l_color = global_light_colour)
		return

/*
/proc/update_global_lights(var/new_brightness, var/new_colour, var/world_message)
	if(!isnull(new_brightness))
		global_light_brightness = new_brightness
	if(!isnull(new_colour))
		global_light_colour = new_colour
	if(!isnull(world_message))
		world << "<span class='notice'>[world_message]</span>"
		sleep(5) // Make sure the above message goes through.
	for(var/turf/T in turfs)
		var/area/A = get_area(T)
		if(T.outside || (!(T.blocks_air || T.density) && A.outside))
			T.update_world_lights()

/mob/verb/set_global_light()
	set name = "Set Global Light Data"
	var/choice = input("Specify a value for world light brightness (cancel for current).", "Set Global Light", global_light_brightness) as num|null
	var/colour = input("Specify a value for world light colour (cancel for current).", "Set Global Light", global_light_colour) as color|null
	var/world_msg = input("Specify a message for the world.", "Set Global Light") as text|null
	update_global_lights(choice, colour, world_msg)
*/