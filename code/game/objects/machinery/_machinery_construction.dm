/obj/machinery/proc/default_deconstruction_crowbar(var/mob/user, var/obj/item/weapon/crowbar/C)
	if(!istype(C))
		return 0
	if(!panel_open)
		return 0
	. = dismantle()

/obj/machinery/proc/default_deconstruction_screwdriver(var/mob/user, var/obj/item/weapon/screwdriver/S)
	if(!istype(S))
		return 0
	playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
	panel_open = !panel_open
	user << "<span class='notice'>You [panel_open ? "open" : "close"] the maintenance hatch of \the [src].</span>"
	update_icon()
	return 1

/obj/machinery/proc/default_part_replacement(var/mob/user, var/obj/item/weapon/storage/part_replacer/R)
	if(!istype(R))
		return 0
	if(!component_parts)
		return 0
	if(panel_open)
		var/obj/item/weapon/circuitboard/CB = locate(/obj/item/weapon/circuitboard) in component_parts
		var/P
		for(var/obj/item/component/A in component_parts)
			for(var/D in CB.req_components)
				var/T = text2path(D)
				if(ispath(A.type, T))
					P = T
					break
			for(var/obj/item/component/B in R.contents)
				if(istype(B, P) && istype(A, P))
					if(B.rating > A.rating)
						R.remove_from_storage(B, src)
						R.handle_item_insertion(A, 1)
						component_parts -= A
						component_parts += B
						B.loc = null
						user << "<span class='notice'>[A.name] replaced with [B.name].</span>"
						break
			update_icon()
			RefreshParts()
	else
		user << "<span class='notice'>Following parts detected in the machine:</span>"
		for(var/var/obj/item/C in component_parts)
			user << "<span class='notice'>    [C.name]</span>"
	return 1

/obj/machinery/proc/dismantle()
	playsound(loc, 'sound/items/Crowbar.ogg', 50, 1)
	var/obj/machinery/constructable_frame/machine_frame/M = new /obj/machinery/constructable_frame/machine_frame(loc)
	M.set_dir(src.dir)
	M.state = 2
	M.icon_state = "box_1"
	for(var/obj/I in component_parts)
		I.loc = loc
	qdel(src)
	return 1