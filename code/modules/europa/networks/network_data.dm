/datum/conduit_network/data_cable
	name = "data network"
	var/list/connected_machines = list()
	var/list/connected_consoles = list()
	var/list/connected_sensors = list()

/datum/conduit_network/data_cable/Destroy()
	connected_machines.Cut()
	connected_consoles.Cut()
	connected_sensors.Cut()
	return ..()

/datum/conduit_network/data_cable/merge(var/datum/conduit_network/data_cable/merging)
	if(istype(merging))
		connected_machines |= merging.connected_machines
		merging.connected_machines.Cut()
		connected_consoles |= merging.connected_consoles
		merging.connected_consoles.Cut()
		connected_sensors |= merging.connected_sensors
		merging.connected_sensors.Cut()
	..()

/datum/conduit_network/data_cable/add_conduit(var/obj/structure/conduit/new_feed)
	..()
	var/turf/T = get_turf(new_feed)
	if(!T || !T.contents.len)
		return
	for(var/obj/machinery/europa/M in T.contents)
		if(M.data_network)
			continue
		if(M.connect_to_datanet)
			if(M.is_data_console)
				connected_consoles |= M
			else
				connected_machines |= M
	for(var/obj/structure/europa/sensor/S in T.contents)
		connected_sensors |= S

/datum/conduit_network/data_cable/proc/pulse()
	for(var/obj/machinery/europa/M in connected_machines)
		M.pulsed()