/var/datum/controller/subsystem/air/SSair

/datum/controller/subsystem/air
	name = "Air"
	wait = 2 SECONDS
	flags = SS_NO_TICK_CHECK

/datum/controller/subsystem/air/New()
	NEW_SS_GLOBAL(SSair)

/datum/controller/subsystem/air/Initialize()
	if (!air_master)
		air_master = new
		air_master.Setup()

	..()

/datum/controller/subsystem/air/fire()
	if (!air_master.Tick())	// Runtimed.
		air_master.failed_ticks++

		if(air_master.failed_ticks > 5)
			world << "<SPAN CLASS='danger'>RUNTIMES IN ATMOS TICKER.  Killing air simulation!</SPAN>"
			world.log << "### ZAS SHUTDOWN"

			message_admins("ZASALERT: Shutting down! status: [air_master.tick_progress]")
			log_admin("ZASALERT: Shutting down! status: [air_master.tick_progress]")

			disable()
			air_master.failed_ticks = 0
