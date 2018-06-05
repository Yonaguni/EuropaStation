// This subsystem loads later in the init process. Not last, but after most major things are done.

/datum/controller/subsystem/misc_late
	name = "Late Miscellaneous Init"
	init_order = SS_INIT_MISC
	flags = SS_NO_FIRE | SS_NO_DISPLAY

/datum/controller/subsystem/misc_late/Initialize()
	transfer_controller = new

	if(using_map.use_overmap)
		admin_notice("<span class='danger'>Initializing overmap events.</span>")
		overmap_event_handler.create_events(using_map.overmap_z, using_map.overmap_size, using_map.overmap_event_areas)
		CHECK_TICK

	admin_notice("<span class='danger'>Building pipe networks</span>", R_DEBUG)
	var/count = 0
	for(var/obj/machinery/atmospherics/machine in machines)
		machine.build_network()
		count++
		CHECK_TICK
	admin_notice("<span class='danger'>Built [count] pipe network\s</span>", R_DEBUG)

	count = 0
	admin_notice("<span class='danger'>Updating atmospherics machinery broadcasting.</span>", R_DEBUG)
	for(var/obj/machinery/atmospherics/unary/U in machines)
		if(istype(U, /obj/machinery/atmospherics/unary/vent_pump))
			var/obj/machinery/atmospherics/unary/vent_pump/T = U
			T.broadcast_status()
			count++
		else if(istype(U, /obj/machinery/atmospherics/unary/vent_scrubber))
			var/obj/machinery/atmospherics/unary/vent_scrubber/T = U
			T.broadcast_status()
			count++
		CHECK_TICK
	admin_notice("<span class='danger'>Updated [count] atmos broadcast\s</span>", R_DEBUG)

	count = 0
	admin_notice("<span class='danger'>Casting lights.</span>", R_DEBUG)
	for(var/thing in init_lights)
		var/datum/D = thing
		if(!QDELETED(D))
			D:cast_light(force_cast = 1)
			count++
		CHECK_TICK
	init_lights.Cut()
	lights_initialized = TRUE
	admin_notice("<span class='danger'>Cast [count] light\s</span>", R_DEBUG)

	..()
