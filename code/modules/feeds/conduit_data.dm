/obj/structure/conduit/data
	name = "data cable"
	desc = "A length of cabling for networked devices."
	icon_state = "data_cable_single"
	icon = 'icons/obj/structures/conduits/data_conduit.dmi'
	feed_type = "data_cable"
	feed_icon = "data_cable"
	feed_layer = 1
	network_type = /datum/conduit_network/data_cable
	color = "#000077"

	deconstruct_tool = /obj/item/weapon/wirecutters
	deconstruct_path = /obj/item/stack/conduit/data
	deconstruct_time = 0
	deconstruct_verb = "cut"
	deconstruct_adj = "cutting"
	deconstruct_sound = 'sound/items/Wirecutter.ogg'

/obj/structure/conduit/data/initialize()
	..()
	if(!network)
		return
	var/datum/conduit_network/data_cable/feed_network = network
	var/turf/T = get_turf(src)
	for(var/obj/machinery/M in T.contents)
		if(M.connect_to_datanet)
			if(M.is_data_console)
				feed_network.connected_consoles |= M
			else
				feed_network.connected_machines |= M
