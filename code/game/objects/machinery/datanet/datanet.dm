// Do not use this object for anything.
/obj/machinery/datanet
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
	var/list/build_components = list()
	var/dismantle_sound = 'sound/items/Crowbar.ogg'

/obj/machinery/datanet/New(var/newloc, var/skip_components)
	..(newloc)
	if(!skip_components)
		component_parts = list()
		for(var/component in build_components)
			component_parts += new component(src)

/obj/machinery/datanet/RefreshParts()
	return

// Casing is handled by the component list for these machines.
/obj/machinery/datanet/dismantle()
	var/turf/T = get_turf(src)
	if(T)
		playsound(T, dismantle_sound, 50, 1)
		for(var/obj/I in component_parts)
			I.loc = T
	qdel(src)
	return 1

/obj/machinery/datanet/initialize()
	..()
	if(connect_to_datanet)
		find_data_network()
	if(connect_to_feednet)
		find_data_network()
	RefreshParts()

/obj/machinery/datanet/proc/find_feed_network()
	if(feed_network)
		return
	var/turf/T = get_turf(src)
	for(var/obj/structure/conduit/matter/MF in T.contents)
		if(!MF.network) MF.build_network()
		feed_network = MF.network
		break

/obj/machinery/datanet/proc/find_data_network()
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
/obj/machinery/datanet/Topic(href, href_list)
	if(usr.Adjacent(src))
		return 0
	else if(data_network)
		for(var/obj/machinery/datanet/console/C in data_network.connected_consoles)
			if(usr.Adjacent(C) && C.on)
				return 0

	usr.set_machine(src)
	add_fingerprint(usr)

	if(href_list["select_data_network"])
		select_data_network()

	updateUsrDialog()
	return 1

/obj/machinery/datanet/proc/pulsed()
	return

/obj/machinery/datanet/proc/select_data_network()
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

/obj/machinery/datanet/attack_hand(var/mob/user)
	if(console_interface_only)
		var/mob/living/human/H = user
		if(!istype(H) || !istype(H.wear_id, /obj/item/device/wrist_computer))
			user << "<span class='warning'>\The [src] can only be activated via terminal.</span>"
			return
	user.set_machine(src)
	interact(user)

/obj/machinery/datanet/attackby(var/obj/item/O, var/mob/user)
	if(istype(O, /obj/item/device/multitool))
		select_data_network()
		return 1
	else if(default_deconstruction_screwdriver(user, O))
		updateUsrDialog()
		return 1
	else if(default_deconstruction_crowbar(user, O))
		return 1
	else if(default_part_replacement(user, O))
		return 1
	else
		return 0

/obj/machinery/datanet/emp_act(severity)
	if(stat & (BROKEN|NOPOWER))
		return
	pulsed()
	..(severity)
