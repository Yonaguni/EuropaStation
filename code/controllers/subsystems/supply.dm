// This should probably just get merged with the supply controller eventually.

/datum/controller/subsystem/supply
	name = "Supply"
	wait = 30 SECONDS
	flags = SS_NO_INIT | SS_NO_TICK_CHECK

/datum/controller/subsystem/supply/fire()
	supply_controller.process()
