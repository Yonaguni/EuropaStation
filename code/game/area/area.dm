/area
	name = "Unknown"
	icon = 'icons/areas/areas.dmi'
	icon_state = "unknown"
	level = null
	layer = 10
	luminosity = 0
	mouse_opacity = 0

	var/uid                            // Unique identifier for this area instance.
	var/global/global_uid = 0          // Global area UID reference.
	var/turf/base_turf                 // Area base turf type, overrides the base z turf

/area/New()
	icon_state = ""
	layer = 10
	uid = ++global_uid
	all_areas += src

	if(!requires_power)
		power_light = 0
		power_equip = 0
		power_environ = 0

	if(lighting_use_dynamic)
		luminosity = 0
	else
		luminosity = 1

	..()

/area/proc/initialize()
	if(!requires_power || !apc)
		power_light = 0
		power_equip = 0
		power_environ = 0
	power_change()		// all machines set to current power level, also updates lighting icon

/area/proc/get_contents()
	return contents

/area/proc/get_cameras()
	var/list/cameras = list()
	for (var/obj/machinery/camera/C in src)
		cameras += C
	return cameras

/area/proc/updateicon()
	//If it doesn't require power, can still activate this proc.
	if ((fire || eject || party) && (!requires_power||power_environ) && !(flags & IGNORE_ALERTS))
		if(fire && !eject && !party)
			icon_state = "blue"
		/*else if(atmosalm && !fire && !eject && !party)
			icon_state = "bluenew"*/
		else if(!fire && eject && !party)
			icon_state = "red"
		else if(party && !fire && !eject)
			icon_state = "party"
		else
			icon_state = "blue-red"
	else
	//	new lighting behaviour with obj lights
		icon_state = null

/area/Entered(A)
	if(!istype(A,/mob/living))	return

	var/mob/living/L = A
	if(!L.ckey)	return

	if(!L.lastarea)
		L.lastarea = get_area(L.loc)
	var/area/newarea = get_area(L.loc)
	var/area/oldarea = L.lastarea
	if((oldarea.has_gravity == 0) && (newarea.has_gravity == 1) && (L.m_intent == "run")) // Being ready when you change areas gives you a chance to avoid falling all together.
		thunk(L)
		L.update_floating( L.Check_Dense_Object() )

	L.lastarea = newarea
	play_ambience(L)
