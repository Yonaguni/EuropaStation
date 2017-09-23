/datum/evacuation_controller/pods
	name = "escape pod controller"

/datum/evacuation_controller/pods/finish_preparing_evac()
	. = ..()
	// Arm the escape pods.
	if (emergency_evacuation)
		for (var/datum/shuttle/autodock/ferry/escape_pod/pod in escape_pods)
			if (pod.arming_controller)
				pod.arming_controller.arm()

/datum/evacuation_controller/pods/launch_evacuation()

	state = EVAC_IN_TRANSIT

	// Abondon Ship
	for (var/datum/shuttle/autodock/ferry/escape_pod/pod in escape_pods) // Launch the pods!
		if (!pod.arming_controller || pod.arming_controller.armed)
			pod.move_time = evac_transit_delay
			pod.launch(src)

	if(emergency_evacuation)
		priority_announcement.Announce(format_evac_message(using_map.emergency_shuttle_leaving_dock, raw_eta = get_eta()))
	else
		priority_announcement.Announce(format_evac_message(using_map.shuttle_leaving_dock, raw_eta = get_eta()))

