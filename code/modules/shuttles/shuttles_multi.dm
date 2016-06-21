//This is a holder for things like the Skipjack and Nuke shuttle.
/datum/shuttle/multi_shuttle

	var/cloaked = 1
	var/at_origin = 1
	var/returned_home = 0
	var/move_time = 240
	var/cooldown = 20
	var/last_move = 0	//the time at which we last moved

	var/announcer
	var/arrival_message
	var/departure_message

	var/area/interim
	var/area/last_departed
	var/start_location
	var/last_location
	var/list/destinations
	var/list/destination_dock_controller_tags = list() //optional, in case the shuttle has multiple docking ports like the ERT shuttle (even though that isn't a multi_shuttle)
	var/list/destination_dock_controllers = list()
	var/list/destination_dock_targets = list()
	var/area/origin
	var/return_warning = 0

/datum/shuttle/multi_shuttle/New()
	..()

/datum/shuttle/multi_shuttle/init_docking_controllers()
	..()
	for(var/destination in destinations)
		var/controller_tag = destination_dock_controller_tags[destination]
		if(!controller_tag)
			destination_dock_controllers[destination] = docking_controller
		else
			var/datum/computer/file/embedded_program/docking/C = locate(controller_tag)

			if(!istype(C))
				world << "<span class='danger'>warning: shuttle with docking tag [controller_tag] could not find it's controller!</span>"
			else
				destination_dock_controllers[destination] = C

	//might as well set this up here.
	if(origin) last_departed = origin
	last_location = start_location

/datum/shuttle/multi_shuttle/current_dock_target()
	return destination_dock_targets[last_location]

/datum/shuttle/multi_shuttle/move(var/area/origin, var/area/destination)
	..()
	last_move = world.time
	if (destination == src.origin)
		returned_home = 1
	docking_controller = destination_dock_controllers[last_location]

/datum/shuttle/multi_shuttle/proc/announce_departure()

	if(cloaked || isnull(departure_message))
		return

	command_announcement.Announce(departure_message,(announcer ? announcer : "[boss_name]"))

/datum/shuttle/multi_shuttle/proc/announce_arrival()

	if(cloaked || isnull(arrival_message))
		return

	command_announcement.Announce(arrival_message,(announcer ? announcer : "[boss_name]"))
