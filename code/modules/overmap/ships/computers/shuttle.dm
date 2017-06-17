//Shuttle controller computer for shuttles going between sectors
/obj/machinery/computer/shuttle_control/explore
	name = "general shuttle control console"

/obj/machinery/computer/shuttle_control/explore/handle_topic_href(var/datum/shuttle/autodock/overmap/shuttle, var/list/href_list)

	// Handle this here after checking for valid Topic() call.
	var/pick_dest = href_list["pick"]
	href_list["pick"] = null
	href_list -= "pick"

	if(..())
		return 1

	if(pick_dest)
		var/list/possible_d = shuttle.get_possible_destinations()
		var/D
		if(possible_d.len)
			D = input("Choose shuttle destination", "Shuttle Destination") as null|anything in possible_d
		else
			to_chat(usr,"<span class='warning'>No valid landing sites in range.</span>")
		possible_d = shuttle.get_possible_destinations()
		if(CanInteract(usr, default_state) && (D in possible_d))
			shuttle.set_destination(possible_d[D])
