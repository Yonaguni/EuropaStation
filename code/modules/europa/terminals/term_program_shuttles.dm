/datum/console_program/shuttle
	name = "shuttle control module"
	var/datum/shuttle/autodock/shuttle
	var/shuttle_tag

/datum/console_program/shuttle/New(var/obj/machinery/new_owner, var/_shuttle_tag)
	shuttle_tag = _shuttle_tag
	if(shuttle_tag)
		..()
	else
		qdel(src)

/datum/console_program/shuttle/Destroy()
	shuttle = null
	. = ..()

/datum/console_program/shuttle/UpdateContents(var/silent = FALSE)

	shuttle = shuttle_controller.shuttles[shuttle_tag]

	html.Cut()
	html +=  "<pre class='alignCentre'>=== [capitalize(shuttle_tag)] Control System ==="
	html +=  "=========================================================="

	if(!shuttle)
		for(var/i = 1 to 5)
			html += " "
		html += "ERROR ERROR ERROR"
		for(var/i = 1 to 5)
			html += " "
		html += "=========================================================="
		..()
		return

	var/shuttle_state
	switch(shuttle.moving_status)
		if(SHUTTLE_IDLE) shuttle_state = "IDLE"
		if(SHUTTLE_WARMUP) shuttle_state = "SPINNING UP"
		if(SHUTTLE_INTRANSIT) shuttle_state = "ENGAGED"
		else
			shuttle_state = "ERROR"

	var/shuttle_status
	switch(shuttle.process_state)
		if(IDLE_STATE)
			if (shuttle.in_use)
				shuttle_status = "busy."
			else
				shuttle_status = "standing-by at [shuttle.get_location_name()]."
		if(WAIT_LAUNCH, FORCE_LAUNCH)
			shuttle_status = "recieved command and departing shortly."
		if(WAIT_ARRIVE)
			shuttle_status = "proceeding to [shuttle.get_destination_name()]."
		if(WAIT_FINISH)
			shuttle_status = "arriving at destination."

	html +=  " "
	html +=  "Shuttle status: [shuttle_status]"
	html +=  "Main drive: [shuttle_state]"
	html +=  " "
	html += "=========================================================="

	if(shuttle.active_docking_controller)

		var/docking_status = shuttle.active_docking_controller.get_docking_status()
		if(docking_status == "docked")
			docking_status = "DOCKED"
		else if(docking_status == "docking")
			if(shuttle.active_docking_controller.override_enabled)
				docking_status = "DOCKING-MANUAL"
			else
				docking_status = "DOCKING"
		else if(docking_status == "undocking")
			if(shuttle.active_docking_controller.override_enabled)
				docking_status = "UNDOCKING-MANUAL"
			else
				docking_status = "UNDOCKING"
		else if(docking_status == "undocked")
			docking_status = "UNDOCKED"
		else
			docking_status = "ERROR"

		html +=  " "
		html +=  "Docking Status: [docking_status]"
		html +=  " "
		html += "=========================================================="

	if(shuttle.multiple_destinations)
		var/datum/shuttle/autodock/multi/ashuttle = shuttle
		html +=  " "
		if(ashuttle.moving_status == SHUTTLE_IDLE)
			html += "Destination: <a href='?src=\ref[owner];pick=1'>[ashuttle.next_location? ashuttle.next_location.name : "No destination set"]</a>."
		else
			html += "Destination: [ashuttle.next_location ? ashuttle.next_location.name : "No destination set"]."
		html +=  " "
		html += "=========================================================="

	if(shuttle.can_cloak)
		var/datum/shuttle/autodock/multi/antag/ashuttle = shuttle
		html +=  " "
		html += "Cloaking system: <a href='?src=\ref[owner];toggle_cloaked=1'>[ashuttle.cloaked ? "engaged" : "disengaged"].</a>"
		html +=  " "
		html += "=========================================================="

	html +=  " "
	var/showed_option
	if(shuttle.can_launch())
		showed_option = TRUE
		html += "<a href='?src=\ref[owner];move=1'>Launch Vessel</a>"
	if(shuttle.can_cancel())
		showed_option = TRUE
		html += "<a href='?src=\ref[owner];cancel=1'>Cancel Launch</a>"
	if(shuttle.can_force())
		showed_option = TRUE
		html += "<a href='?src=\ref[owner];force=1'>Force Launch</a>"
	if(!showed_option)
		html += "=== Controls Unavailable ==="
	html +=  " "
	html += "==========================================================</pre>"

	..(silent)
