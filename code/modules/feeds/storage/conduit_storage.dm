//Sheet storage.
/obj/structure/europa/conduit_storage

	name = "matter storage bin"
	desc = "It's a large matter storage system."
	icon = 'icons/obj/europa/structures/conduits/matter_bins.dmi'
	icon_state = "matter_storage"
	layer = 4
	anchored = 4
	density = 1

	var/list/stored_material =  list("steel" = 5000, "glass" = 5000)
	var/list/storage_capacity = list("steel" = 10000, "glass" = 10000)
	var/datum/conduit_network/matter_feed/feed_network

/obj/structure/europa/conduit_storage/examine()
	..()
	if(Adjacent(usr))
		if(feed_network)
			usr << "It is connected to [feed_network.name]."
		if(stored_material.len)
			usr << "It contains the following materials:"
			for(var/material in stored_material)
				usr << "[capitalize(material)]: [stored_material[material]]"
		if(reagents && reagents.total_volume > 0)
			usr << "It contains the following reagents:"
			if(reagents && reagents.reagent_list.len)
				for(var/datum/reagent/R in reagents.reagent_list)
					usr << "[R.volume] units of [R.name]"

/obj/structure/europa/conduit_storage/initialize()
	..()

	// Set up liquid storage if needed.
	if(storage_capacity["reagents"])
		flags |= OPENCONTAINER
		flags |= NOREACT
		create_reagents(storage_capacity["reagents"])

	// Hook it into the matter feed.
	var/turf/T = get_turf(src)
	for(var/obj/structure/conduit/matter/MF in T.contents)
		if(!MF.network) MF.build_network()
		feed_network = MF.network
		feed_network.connected_storage |= src
		feed_network.need_material_update = 1
		feed_network.need_reagent_update = 1
		break

/obj/structure/europa/conduit_storage/Destroy()
	if(feed_network)
		feed_network.connected_storage -= src
		feed_network.need_material_update = 1
		feed_network.need_reagent_update = 1
	return ..()

/obj/structure/europa/conduit_storage/attackby(var/obj/item/O, var/mob/user)

	//Resources are being loaded.
	var/obj/item/eating = O
	if(!istype(eating))
		user << "<span class='warning'>\The [eating] cannot be accepted.</span>"
		return

	// Check all this here as well as when the actual transfer is called in afterattack() so we can update the feed network vars.
	if(src.is_open_container() && O.is_open_container() && O.reagents && src.reagents && src.reagents.get_free_space() && O.reagents.total_volume)
		feed_network.need_reagent_update = 1
		return 0

	var/has_acceptable_matter = 0
	if(eating.matter)
		for(var/material in eating.matter)
			if(isnull(stored_material[material]) || isnull(storage_capacity[material]))
				continue
			has_acceptable_matter = 1
			break
	if(!has_acceptable_matter)
		user << "<span class='warning'>\The [eating] cannot be accepted.</span>"
		return

	var/filltype = 0       // Used to determine message.
	var/total_used = 0     // Amount of material used.
	var/mass_per_sheet = 0 // Amount of material constituting one sheet.
	var/obj/item/stack/stack = eating

	if(istype(stack))
		for(var/material in eating.matter)
			if(isnull(stored_material[material]) || isnull(storage_capacity[material]))
				continue
			if(stored_material[material] >= storage_capacity[material])
				continue
			var/total_material = stack.matter[material] * stack.get_amount()
			if(stored_material[material] + total_material > storage_capacity[material])
				total_material = storage_capacity[material] - stored_material[material]
				filltype = 1
			else
				filltype = 2
			stored_material[material] += total_material
			total_used += total_material
			mass_per_sheet += eating.matter[material]
	else
		return ..()
	if(!filltype)
		user << "<span class='warning'>\The [src] is full. Please remove material in order to insert more.</span>"
		return
	else if(filltype == 1)
		user << "<span class='notice'>You fill \the [src] to capacity with \the [eating].</span>"
	else
		user << "<span class='notice'>You fill \the [src] with \the [eating].</span>"
	stack.use(max(1, round(total_used/mass_per_sheet))) // Always use at least 1 to prevent infinite materials.
	if(feed_network)
		feed_network.need_material_update = 1

/obj/structure/europa/conduit_storage/tank
	name = "reagent tank"
	desc = "A tank for the storing of reagents."
	icon_state = "liquid_storage"
	stored_material = list()
	storage_capacity = list("reagents" = 250)
