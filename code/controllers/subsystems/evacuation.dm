/datum/controller/subsystem/evacuation
	name = "Evacuation"
	wait = 2 SECONDS
	flags = SS_NO_TICK_CHECK

/datum/controller/subsystem/evacuation/Initialize()
	if(!evacuation_controller)
		evacuation_controller = new using_map.evac_controller_type ()
		evacuation_controller.set_up()
	..()

/datum/controller/subsystem/evacuation/fire()
	evacuation_controller.process()
