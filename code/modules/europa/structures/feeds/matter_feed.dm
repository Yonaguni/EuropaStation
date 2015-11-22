/obj/item/stack/conduit/matter
	name = "matter feed bundle"
	build_type = "matter_feed"
	build_path = /obj/structure/conduit/matter

/obj/structure/conduit/matter
	name = "matter feed"
	desc = "A reinforced pipeline for transporting materials."
	feed_type = "matter_feed"
	network_type = /datum/conduit_network/matter_feed

/datum/conduit_network/matter_feed
	name = "matter feed network"
	var/list/compiled_resources = list()
	var/list/connected_storage = list()
	var/need_material_update

/datum/conduit_network/matter_feed/proc/get_resources()
	if(need_material_update)
		compile_resources()
	return compiled_resources

/datum/conduit_network/matter_feed/proc/compile_resources()
	compiled_resources = list()
	for(var/obj/structure/conduit_storage/CS in connected_storage)
		for(var/material in CS.stored_material)
			if(CS.stored_material[material])
				if(compiled_resources[material])
					compiled_resources[material] += CS.stored_material[material]
				else
					compiled_resources[material] = CS.stored_material[material]
	need_material_update = 0

/datum/conduit_network/matter_feed/proc/remove_resources(var/list/resources)
	for(var/material in resources)
		for(var/obj/structure/conduit_storage/CS in connected_storage)
			var/cs_amt = CS.stored_material[material]
			if(cs_amt)
				if(cs_amt >= resources[material])
					CS.stored_material[material] -= resources[material]
					resources[material] = 0
				else
					resources[material] -= CS.stored_material[material]
					CS.stored_material[material] = 0
			if(!resources[material] || resources[material] <= 0)
				break
	need_material_update = 1

/datum/conduit_network/matter_feed/Destroy()
	connected_storage.Cut()
	return ..()

/datum/conduit_network/matter_feed/merge(var/datum/conduit_network/matter_feed/merging)
	if(istype(merging))
		connected_storage |= merging.connected_storage
		merging.connected_storage.Cut()
	..()

/obj/structure/conduit/matter/initialize()
	..()
	if(!network)
		return
	var/datum/conduit_network/matter_feed/feed_network = network
	var/turf/T = get_turf(src)
	for(var/obj/structure/conduit_storage/S in T.contents)
		feed_network.connected_storage |= S
