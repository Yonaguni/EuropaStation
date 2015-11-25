// Do not use this object for anything.
/obj/machinery/europa
	layer = 4
	anchored = 1
	density = 1

	var/can_remote_trigger
	var/can_remote_connect
	var/connect_to_datanet = 1
	var/connect_to_feednet = 0
	var/is_data_console = 0
	var/datum/conduit_network/data_cable/data_network
	var/datum/conduit_network/matter_feed/feed_network

/obj/machinery/europa/initialize()
	..()
	if(connect_to_datanet)
		find_data_network()
	if(connect_to_feednet)
		find_data_network()

/obj/machinery/europa/fabricator/proc/find_feed_network()
	if(feed_network)
		return
	var/turf/T = get_turf(src)
	for(var/obj/structure/conduit/matter/MF in T.contents)
		if(!MF.network) MF.build_network()
		feed_network = MF.network
		break

/obj/machinery/europa/proc/find_data_network()
	if(data_network)
		return
	var/turf/T = get_turf(src)
	for(var/obj/structure/conduit/data/D in T.contents)
		if(!D.network) D.build_network()
		data_network = D.network
		if(is_data_console)
			data_network.connected_consoles |= src
		else
			data_network.connected_machines |= src
		break

// This is temporary, probably doesn't properly cover expoits, pls fix, future me.
/obj/machinery/europa/Topic(href, href_list)
	if(istype(usr, /mob/living/silicon))
		return 0
	else if(usr.Adjacent(src))
		return 0
	else if(data_network)
		for(var/obj/machinery/europa/console/C in data_network.connected_consoles)
			if(usr.Adjacent(C) && C.on)
				return 0
	return 1

/obj/machinery/europa/proc/pulsed()
	return