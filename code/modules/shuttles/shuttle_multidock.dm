//for shuttles that may use a different docking port at each location
/datum/shuttle/ferry/multidock
	var/docking_controller_tag_station
	var/docking_controller_tag_offsite
	var/datum/computer/file/embedded_program/docking/docking_controller_station
	var/datum/computer/file/embedded_program/docking/docking_controller_offsite

/datum/shuttle/ferry/multidock/init_docking_controllers()
	if(docking_controller_tag_station)
		docking_controller_station = locate(docking_controller_tag_station)
		if(!istype(docking_controller_station))
			world << "<span class='danger'>warning: shuttle with docking tag [docking_controller_station] could not find it's controller!</span>"
	if(docking_controller_tag_offsite)
		docking_controller_offsite = locate(docking_controller_tag_offsite)
		if(!istype(docking_controller_offsite))
			world << "<span class='danger'>warning: shuttle with docking tag [docking_controller_offsite] could not find it's controller!</span>"
	if (!location)
		docking_controller = docking_controller_station
	else
		docking_controller = docking_controller_offsite

/datum/shuttle/ferry/multidock/move(var/area/origin,var/area/destination)
	..(origin, destination)
	if (!location)
		docking_controller = docking_controller_station
	else
		docking_controller = docking_controller_offsite

// Alert lights for shuttles, leaving them here for now.
/obj/machinery/light/small/readylight
	light_range = 5
	light_power = 1
	light_color = "#DA0205"
	var/state = 0

/obj/machinery/light/small/readylight/proc/set_state(var/new_state)
	state = new_state
	if(state)
		light_color = "00FF00"
	else
		light_color = initial(light_color)
	update()
