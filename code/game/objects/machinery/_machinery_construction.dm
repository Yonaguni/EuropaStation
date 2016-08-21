/obj/machinery/proc/default_deconstruction_crowbar(var/mob/user, var/obj/item/crowbar/C)
	if(!istype(C))
		return 0
	if(!panel_open)
		return 0
	. = dismantle()

/obj/machinery/proc/default_deconstruction_screwdriver(var/mob/user, var/obj/item/screwdriver/S)
	if(!istype(S))
		return 0
	playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
	panel_open = !panel_open
	user << "<span class='notice'>You [panel_open ? "open" : "close"] the maintenance hatch of \the [src].</span>"
	update_icon()
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