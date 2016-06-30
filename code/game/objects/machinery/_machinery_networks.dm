/obj/machinery
	var/interact_offline = 0 // Can the machine be interacted with while de-powered.
	var/can_remote_trigger
	var/can_remote_connect
	var/console_interface_only
	var/connect_to_datanet = 1
	var/connect_to_powernet = 1
	var/connect_to_feednet = 0
	var/is_data_console = 0

	var/datum/conduit_network/power_net/power_network
	var/datum/conduit_network/data_cable/data_network
	var/datum/conduit_network/matter_feed/feed_network

/obj/machinery/initialize()
	..()
	if(connect_to_datanet)
		find_data_network()
	if(connect_to_feednet)
		find_data_network()
	if(connect_to_powernet)
		find_power_network()

/obj/machinery/proc/find_power_network()
	if(feed_network)
		return
	var/turf/T = get_turf(src)
	for(var/obj/structure/conduit/power/PN in T.contents)
		if(!PN.network) PN.build_network()
		power_network = PN.network
		break

/obj/machinery/proc/find_feed_network()
	if(feed_network)
		return
	var/turf/T = get_turf(src)
	for(var/obj/structure/conduit/matter/MF in T.contents)
		if(!MF.network) MF.build_network()
		feed_network = MF.network
		break

/obj/machinery/proc/find_data_network()
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

/obj/machinery/proc/pulsed()
	return

/obj/machinery/proc/select_data_network()
	var/list/data_networks = list()
	var/turf/T = get_turf(src)
	for(var/obj/structure/conduit/data/D in T.contents)
		if(!D.network) D.build_network()
		data_networks[D.network.name] = D.network
	if(data_networks.len)
		var/choice = input("Which data network do you wish to connect to?") as null|anything in data_networks
		if(choice)
			if(data_network)
				data_network.connected_machines -= src
			data_network = data_networks[choice]

// This is temporary, probably doesn't properly cover expoits, pls fix, future me.
/obj/machinery/Topic(href, href_list)
	if(usr.Adjacent(src))
		return 0
	else if(data_network)
		for(var/obj/machinery/console/C in data_network.connected_consoles)
			if(usr.Adjacent(C) && C.on)
				return 0

	usr.set_machine(src)
	add_fingerprint(usr)

	if(href_list["select_data_network"])
		select_data_network()

	updateUsrDialog()
	return 1
