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
	var/outside

/area/New()
	icon_state = ""
	layer = 10
	uid = ++global_uid
	all_areas += src
	..()

/area/proc/initialize()
	..()
	if(flags & IS_OCEAN)
		color = "#66D1FF"
		icon = 'icons/effects/xgm_overlays.dmi'
		icon_state = "ocean"
		layer = GAS_OVERLAY_LAYER+0.1
		alpha = GAS_MAX_ALPHA

/area/proc/get_contents()
	return contents

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
