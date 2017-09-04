// The actual shuttle controller should get merged with this eventually.

/datum/controller/subsystem/shuttle
	name = "Shuttles"
	wait = 2 SECONDS

/datum/controller/subsystem/shuttle/Initialize()
	if (!shuttle_controller)
		shuttle_controller = new
	
	..()

/datum/controller/subsystem/shuttle/fire()
	shuttle_controller.process()
