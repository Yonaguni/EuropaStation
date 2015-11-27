// Do not use this object for anything.
/obj/machinery/europa
	layer = 4
	anchored = 1
	density = 1

	var/can_remote_trigger
	var/can_remote_connect
	var/console_interface_only
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

/obj/machinery/europa/proc/find_feed_network()
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

	usr.set_machine(src)
	add_fingerprint(usr)

	if(href_list["select_data_network"])
		select_data_network()

	updateUsrDialog()
	return 1

/obj/machinery/europa/proc/pulsed()
	return

/obj/machinery/europa/proc/select_data_network()
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

/obj/machinery/europa/attack_hand(var/mob/user)

	if(console_interface_only)
		var/mob/living/carbon/human/H = user
		if(!istype(H) || !istype(H.wear_id, /obj/item/device/europa/wrist_computer))
			user << "<span class='warning'>\The [src] can only be activated via terminal.</span>"
			return
	user.set_machine(src)
	interact(user)

/obj/machinery/europa/attackby(var/obj/item/O, var/mob/user)
	if(istype(O, /obj/item/device/multitool))
		select_data_network()
		return 1
	return 0

/obj/machinery/europa/emp_act(severity)
	if(stat & (BROKEN|NOPOWER))
		return
	pulsed()
	..(severity)