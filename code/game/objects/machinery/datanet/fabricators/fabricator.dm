/obj/machinery/datanet/fabricator
	name = "tool fabricator"
	desc = "It produces simple tools."
	icon = 'icons/obj/europa/machines/fabricators.dmi'
	icon_state = "autolathe"
	dir = SOUTH
	anchored = 1
	use_power = 1
	idle_power_usage = 10
	active_power_usage = 2000
	waterproof = -1
	connect_to_feednet = 1
	can_remote_connect = 1

	var/show_category = "All"

	var/hacked = 0
	var/disabled = 0
	var/shocked = 0
	var/busy = 0

	var/mat_efficiency = 1
	var/build_time = 50

	var/fabricator_type = FABRICATOR_BASIC
	var/datum/wires/fabricator/wires = null
	var/list/machine_recipes = list()
	var/output_dir = 0
	var/list/build_queue = list()

	// Image cache for overlays.
	var/image/panel_image
	var/image/load_image

	var/list/display_materials = list("steel", "glass", "plastic")
	var/list/display_reagents = list()

/obj/machinery/datanet/fabricator/New()

	..()
	wires = new(src)
	//Create parts for lathe.
	component_parts = list()
	component_parts += new /obj/item/weapon/circuitboard/autolathe(src)
	component_parts += new /obj/item/component/matter_bin(src)
	component_parts += new /obj/item/component/matter_bin(src)
	component_parts += new /obj/item/component/matter_bin(src)
	component_parts += new /obj/item/component/manipulator(src)
	component_parts += new /obj/item/component/console_screen(src)
	RefreshParts()
	output_dir = dir

/obj/machinery/datanet/fabricator/Destroy()
	qdel(wires)
	wires = null
	return ..()

/obj/machinery/datanet/fabricator/proc/update_recipe_list()
	if(!fabricator_recipes)
		populate_fabricator_recipes()
	var/datum/fabricator_design_list/FDL = fabricator_recipes[fabricator_type]
	if(FDL)
		machine_recipes = FDL.recipes
	if(!machine_recipes) //No supplied recipes, let's avoid a runtime.
		machine_recipes = list()

// TODO: BETTER DAMN INTERFACE
/obj/machinery/datanet/fabricator/interact(mob/user as mob)

	update_recipe_list()

	if(..() || (disabled && !panel_open))
		user << "<span class='warning'>\The [src] is disabled!</span>"
		return

	if(shocked)
		shock(user, 50)

	if(!feed_network)
		find_feed_network()
	if(!data_network)
		find_data_network()

	var/list/stored_material = list()
	var/list/stored_reagents = list()
	if(feed_network)
		stored_material = feed_network.get_resources()
		stored_reagents = feed_network.get_reagents()

	var/dat = "<center><h1>[capitalize(name)] control panel</h1><hr/>"

	if(!disabled)
		dat += "<table width = '100%'>"
		var/material_top = "<tr>"
		var/material_bottom = "<tr>"

		if(display_materials && display_materials.len)
			for(var/material in display_materials)
				material_top += "<td width = '25%' align = center><b>[material]</b></td>"
				material_bottom += "<td width = '25%' align = center>[stored_material[material] ? stored_material[material] : 0]</td>"
		if(display_reagents && display_reagents.len)
			for(var/reagent in display_reagents)
				material_top += "<td width = '25%' align = center><b>[reagent]</b></td>"
				material_bottom += "<td width = '25%' align = center>[stored_reagents[reagent] ? stored_reagents[reagent] : 0]</td>"

		dat += "[material_top]</tr>[material_bottom]</tr></table><hr><br>"

		dat += "<h3>Configuration</h3>"
		dat += "\[<a href='?src=\ref[src];change_output_dir=1'>set output direction</a>\]<br>"
		if(feed_network)
			dat += "\[<a href='?src=\ref[src];select_feed_network=1'>taking from [feed_network.name]</a>\]<br>"
		else
			dat += "CANNOT LOCATE FEED NETWORK.<br>"
		if(data_network)
			dat += "\[<a href='?src=\ref[src];select_data_network=1'>connected to [data_network.name]</a>\]<br>"
		else
			dat += "CANNOT LOCATE DATA NETWORK.<br>"

		dat += "<h2>Build Queue</h2><table width = '100%'>"
		if(build_queue.len)
			var/index = 1
			for(var/datum/fabricator_queue_entry/FQE in build_queue)
				dat += "<tr><td>[FQE.design.name] x [FQE.multiplier] \[<a href='?src=\ref[src];remove_from_queue=[index]'>remove</a>\]</td></tr>"
				index++
		else
			dat += "<tr><td>Nothing.</td></tr>"
		dat += "</table><hr>"


		dat += "<h2>Designs</h2><h3>Showing: <a href='?src=\ref[src];change_category=1'>[show_category]</a>.</h3></center><table width = '100%'>"

		var/index = 0
		if(machine_recipes && machine_recipes.len)
			for(var/decl/fabricator_design/R in machine_recipes)
				index++
				if(R.hidden && !hacked || (show_category != "All" && show_category != R.category))
					continue
				var/can_make = 1
				var/material_string = ""
				var/multiplier_string = ""
				var/max_sheets
				var/comma
				if((!R.resources || !R.resources.len) && (!R.reagents || !R.reagents.len))
					material_string = "No resources required.</td>"
				else

					//Make sure it's buildable and list requires resources.
					if(R.resources)
						for(var/material in R.resources)
							if(!isnull(stored_material[material]))
								var/sheets = round(stored_material[material]/max(1,round(R.resources[material]*mat_efficiency)))
								if(isnull(max_sheets) || max_sheets > sheets)
									max_sheets = sheets
							if(isnull(stored_material[material]) || (stored_material[material] < round(R.resources[material]*mat_efficiency)))
								can_make = 0
							if(!comma)
								comma = 1
							else
								material_string += ", "
							material_string += "[round(R.resources[material] * mat_efficiency)] [material]"
					if(R.reagents)
						for(var/reagent in R.reagents)
							if(!isnull(stored_reagents[reagent]))
								var/sheets = round(stored_reagents[reagent]/max(1,round(R.reagents[reagent]*mat_efficiency)))
								if(isnull(max_sheets) || max_sheets > sheets)
									max_sheets = sheets
							if(isnull(stored_reagents[reagent]) || stored_reagents[reagent] < round(R.reagents[reagent]*mat_efficiency))
								can_make = 0
							if(!comma)
								comma = 1
							else
								material_string += ", "
							material_string += "[round(R.reagents[reagent] * mat_efficiency)] [reagent]"

					material_string += ".<br></td>"
					//Build list of multipliers for sheets.
					if(R.is_stack)
						max_sheets = min(max_sheets, R.stack_max)
						if(max_sheets && max_sheets > 0)
							multiplier_string  += "<br>"
							for(var/i = 5;i<max_sheets;i*=2) //5,10,20,40...
								multiplier_string  += "<a href='?src=\ref[src];make=[index];multiplier=[i]'>\[x[i]\]</a>"
							multiplier_string += "<a href='?src=\ref[src];make=[index];multiplier=[max_sheets]'>\[x[max_sheets]\]</a>"

				dat += "<tr><td width = 180>[R.hidden ? "<font color = 'red'>*</font>" : ""]<b>[can_make ? "<a href='?src=\ref[src];make=[index];multiplier=1'>" : ""][R.name][can_make ? "</a>" : ""]</b>[R.hidden ? "<font color = 'red'>*</font>" : ""][multiplier_string]</td><td align = right>[material_string]</tr>"
		else
			dat += "<tr><td>No valid recipes loaded.</tr></td>"

		dat += "</table><hr>"
	//Hacking.
	if(panel_open)
		dat += "<h2>Maintenance Panel</h2>"
		dat += wires.GetInteractWindow()
		dat += "<hr>"

	user << browse(dat, "window=[fabricator_type]")
	onclose(user, "autolathe")

/obj/machinery/datanet/fabricator/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(busy)
		user << "<span class='warning'>\The [src] is busy. Please wait for completion of previous operation.</span>"
		return
	if(..())
		return
	if(stat)
		return
	if(panel_open && istype(O, /obj/item/weapon/wirecutters))
		attack_hand(user)
		return
	return

/obj/machinery/datanet/fabricator/examine()
	..()
	if(Adjacent(usr) && feed_network)
		usr << "It is connected to [feed_network.name]."

/obj/machinery/datanet/fabricator/Topic(href, href_list)

	if(..())
		return

	usr.set_machine(src)
	add_fingerprint(usr)

	if(href_list["remove_from_queue"])
		var/index = text2num(href_list["remove_from_queue"])
		if(index > 0 && index <= build_queue.len)
			var/datum/fabricator_queue_entry/FQE = build_queue[index]
			build_queue -= FQE

	if(href_list["change_category"])

		var/choice = input("Which category do you wish to display?") as null|anything in fabricator_categories+"All"
		if(choice)
			show_category = choice

	if(href_list["change_output_dir"])

		var/list/output_dirs = list()
		output_dirs["none"] =      0
		output_dirs["north"] =     NORTH
		output_dirs["northeast"] = NORTHEAST
		output_dirs["east"] =      EAST
		output_dirs["southeast"] = SOUTHEAST
		output_dirs["south"] =     SOUTH
		output_dirs["southwest"] = SOUTHWEST
		output_dirs["west"] =      WEST
		output_dirs["northwest"] = NORTHWEST

		var/choice = input("Which direction would you like to output items to?") as null|anything in output_dirs
		if(choice)
			output_dir = output_dirs[choice]

	if(href_list["select_feed_network"])
		var/list/feed_networks = list()
		var/turf/T = get_turf(src)
		for(var/obj/structure/conduit/matter/MF in T.contents)
			if(!MF.network) MF.build_network()
			feed_networks[MF.network.name] = MF.network
		if(feed_networks.len)
			var/choice = input("Which feed network do you wish to take matter from?") as null|anything in feed_networks
			if(choice)
				feed_network = feed_networks[choice]

	if(href_list["make"] && machine_recipes && machine_recipes.len)
		if(build_queue.len < MAX_FAB_QUEUE)
			build_queue += new /datum/fabricator_queue_entry(machine_recipes[text2num(href_list["make"])], text2num(href_list["multiplier"]))
			check_queue()

	updateUsrDialog()

/obj/machinery/datanet/fabricator/proc/check_queue()
	if(busy || build_queue.len == 0)
		return
	var/datum/fabricator_queue_entry/build_item = build_queue[1]
	build_queue -= build_item
	build_item(build_item.design, build_item.multiplier)
	del(build_item)

/obj/machinery/datanet/fabricator/proc/build_item(var/decl/fabricator_design/making, var/multiplier = 1, var/mob/user)

	//Exploit detection, not sure if necessary after rewrite.
	if(!making || multiplier < 0 || multiplier > 100)
		return

	var/list/stored_material = feed_network.get_resources()
	var/list/stored_reagents = feed_network.get_reagents()

	var/can_make = 1
	for(var/material in making.resources)
		if(isnull(stored_material[material]) || (stored_material[material] < round(making.resources[material] * mat_efficiency) * multiplier))
			can_make = 0
			break
	if(can_make)
		for(var/reagent in making.reagents)
			if(isnull(stored_reagents[reagent]) || (stored_reagents[reagent] < round(making.reagents[reagent] * mat_efficiency) * multiplier))
				can_make = 0
				break

	busy = 1
	update_use_power(2)

	if(can_make)

		if(making.resources && making.resources.len)
			feed_network.remove_resources(making.resources)
		if(making.reagents && making.reagents.len)
			feed_network.remove_reagents(making.reagents)

		icon_state = "[initial(icon_state)]_on"
		sleep(build_time)
		icon_state = initial(icon_state)
		busy = 0
		update_use_power(1)

		//Sanity check.
		if(!making || !src) return

		//Create the desired item.
		var/obj/item/I = new making.path(loc)
		if(multiplier > 1 && istype(I, /obj/item/stack))
			var/obj/item/stack/S = I
			S.amount = multiplier

		// Spit the item out onto a conveyor or w/e.
		if(output_dir)
			spawn(3)
				if(I.loc == src.loc)
					step(I, output_dir)
	else
		sleep(10)
		busy = 0
		update_use_power(1)

	check_queue()
	updateUsrDialog()

/obj/machinery/datanet/fabricator/update_icon()
	if(!panel_image)
		panel_image = image(icon, "[initial(icon_state)]_panel")
		panel_image.layer = layer+0.1
	if(panel_open)
		overlays |= panel_image
	else
		overlays -= panel_image

//Updates overall lathe storage size.
/obj/machinery/datanet/fabricator/RefreshParts()
	..()
	var/mb_rating = 0
	var/man_rating = 0
	for(var/obj/item/component/matter_bin/MB in component_parts)
		mb_rating += MB.rating
	for(var/obj/item/component/manipulator/M in component_parts)
		man_rating += M.rating
	build_time = 50 / man_rating
	mat_efficiency = 1.1 - man_rating * 0.1// Normally, price is 1.25 the amount of material, so this shouldn't go higher than 0.8. Maximum rating of parts is 3
	mat_efficiency = max(0.1,min(mat_efficiency, 0.8))