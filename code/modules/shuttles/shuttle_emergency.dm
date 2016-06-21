/datum/shuttle/ferry/emergency
	//pass

/datum/shuttle/ferry/emergency/arrived()
	emergency_shuttle.shuttle_arrived()

/datum/shuttle/ferry/emergency/long_jump(var/area/departing, var/area/destination, var/area/interim, var/travel_time, var/direction)
	//world << "shuttle/ferry/emergency/long_jump: departing=[departing], destination=[destination], interim=[interim], travel_time=[travel_time]"
	if (!location)
		travel_time = SHUTTLE_TRANSIT_DURATION_RETURN
	else
		travel_time = SHUTTLE_TRANSIT_DURATION

	//update move_time and launch_time so we get correct ETAs
	move_time = travel_time
	emergency_shuttle.launch_time = world.time

	..()

/datum/shuttle/ferry/emergency/move(var/area/origin,var/area/destination)
	..(origin, destination)

	if (origin == area_station)	//leaving the station
		emergency_shuttle.departed = 1
		priority_announcement.Announce("Evacuation pod ejection complete. Estimate [round(emergency_shuttle.estimate_arrival_time()/60,1)] minutes until leaving atmosphere and pickup by the Jovian navy.")

/datum/shuttle/ferry/emergency/launch(var/user)
	if (!can_launch(user)) return

	if(usr)
		log_admin("[key_name(usr)] has assumed manual control and activated launch sequence")
		message_admins("[key_name_admin(usr)] has assumed manual control and activated launch sequence")

	..(user)

/datum/shuttle/ferry/emergency/force_launch(var/user)
	if (!can_force(user)) return

	if(usr)
		log_admin("[key_name(usr)] has overridden the shuttle autopilot and forced immediate launch")
		message_admins("[key_name_admin(usr)] has overridden the shuttle autopilot and forced immediate launch")

	..(user)

/datum/shuttle/ferry/emergency/cancel_launch(var/user)
	if (!can_cancel(user)) return

	if(usr)
		log_admin("[key_name(usr)] has overridden the shuttle autopilot and cancelled launch sequence")
		message_admins("[key_name_admin(usr)] has overridden the shuttle autopilot and cancelled launch sequence")

	..(user)
