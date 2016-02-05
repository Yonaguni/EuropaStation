/datum/conduit_network/matter_feed
	name = "matter feed network"
	var/list/compiled_resources = list()
	var/list/compiled_reagents = list()
	var/list/connected_storage = list()
	var/need_material_update
	var/need_reagent_update

/datum/conduit_network/matter_feed/proc/get_resources()
	if(need_material_update)
		compile_resources()
	return compiled_resources

/datum/conduit_network/matter_feed/proc/get_reagents()
	if(need_reagent_update)
		compile_reagents()
	return compiled_reagents

/datum/conduit_network/matter_feed/proc/compile_resources()
	compiled_resources = list()
	for(var/obj/structure/europa/conduit_storage/CS in connected_storage)
		for(var/material in CS.stored_material)
			if(CS.stored_material[material])
				if(compiled_resources[material])
					compiled_resources[material] += CS.stored_material[material]
				else
					compiled_resources[material] = CS.stored_material[material]
	need_material_update = 0

/datum/conduit_network/matter_feed/proc/compile_reagents()
	compiled_reagents = list()
	for(var/obj/structure/europa/conduit_storage/CS in connected_storage)
		if(CS.reagents)
			for(var/datum/reagent/R in CS.reagents.reagent_list)
				if(compiled_reagents[R.id])
					compiled_reagents[R.id] += R.volume
				else
					compiled_reagents[R.id] = R.volume
	need_reagent_update = 0

/datum/conduit_network/matter_feed/proc/remove_resources(var/list/resources)
	resources = resources.Copy() // Make sure we aren't killing the resource list of a recipe.
	for(var/material in resources)
		for(var/obj/structure/europa/conduit_storage/CS in connected_storage)
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

/datum/conduit_network/matter_feed/proc/remove_reagents(var/list/rem_reagents)
	rem_reagents = rem_reagents.Copy()
	for(var/reagent_id in rem_reagents)
		for(var/obj/structure/europa/conduit_storage/CS in connected_storage)
			if(!CS.reagents || !CS.reagents.total_volume)
				continue
			var/r_amt = CS.reagents.get_reagent_amount(reagent_id)
			if(r_amt && r_amt > 0)
				if(r_amt >= rem_reagents[reagent_id])
					CS.reagents.remove_reagent(reagent_id, rem_reagents[reagent_id])
					rem_reagents[reagent_id] = 0
				else
					rem_reagents[reagent_id] -= r_amt
					CS.reagents.remove_reagent(reagent_id, r_amt)
			if(!rem_reagents[reagent_id])
				break
	need_reagent_update = 1

/datum/conduit_network/matter_feed/Destroy()
	connected_storage.Cut()
	return ..()

/datum/conduit_network/matter_feed/merge(var/datum/conduit_network/matter_feed/merging)
	if(istype(merging))
		connected_storage |= merging.connected_storage
		merging.connected_storage.Cut()
	..()

/datum/conduit_network/matter_feed/add_conduit(var/obj/structure/conduit/new_feed)
	..()
	var/turf/T = get_turf(new_feed)
	if(!T || !T.contents.len)
		return
	for(var/obj/machinery/datanet/M in T.contents)
		if(M.feed_network)
			continue
		if(M.connect_to_feednet)
			M.feed_network = src
	for(var/obj/structure/europa/conduit_storage/CS in T.contents)
		connected_storage |= CS
		need_material_update = 1
		need_reagent_update = 1