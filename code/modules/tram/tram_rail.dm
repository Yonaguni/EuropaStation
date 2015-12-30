/obj/tram/rail
	name = "tram rail"
	desc = "A guiding rail for trams"
	icon = 'icons/obj/tram/tram_rail.dmi'
	icon_state = "rail"
	var/godir = null
	var/stop_duration = null
	layer = TURF_LAYER + 0.1

/obj/effect/tramrail
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"

	var/_godir
	var/_stop_duration

/obj/effect/tramrail/New()
	..()
	spawn(1)
		var/obj/tram/rail/TR = locate(/obj/tram/rail) in loc
		if(TR)
			TR.godir = _godir
			TR.stop_duration = _stop_duration
		qdel(src)
