//This magic dehumidifier is a portable water-to-nothing machine, although it does need a charged cell to work.
//See drain.dm!
/obj/machinery/dehumidifier
	use_power = POWER_USE_OFF
	anchored = 0
	density = 1
	icon = 'icons/obj/atmos.dmi'
	icon_state = "dhum-off"
	name = "emergency dehumidifier"
	desc = "A portable dehumidifier with emergency high-volume pump to help keep you dry when it's getting damp... just very slowly."
	var/obj/item/weapon/cell/cell = /obj/item/weapon/cell/high
	var/on = 0
	var/drainage = 1
	var/last_gurgle = 0
	atom_flags = ATOM_FLAG_CLIMBABLE
	clicksound = "switch"

/obj/machinery/dehumidifier/Initialize()
	if(ispath(cell))
		cell = new cell(src)
	. = ..()
	update_icon()

/obj/machinery/dehumidifier/on_update_icon(var/rebuild_overlay = 0)
	if(!on)
		icon_state = "dhum-off"
	else
		icon_state = "dhum-on"

	if(rebuild_overlay)
		cut_overlays()
		if(panel_open)
			add_overlay("dhum-open")

/obj/machinery/dehumidifier/examine(mob/user)
	. = ..(user)
	if (!.)
		return

	to_chat(user, "The dehumidifier is [on ? "on" : "off"] and the hatch is [panel_open ? "open" : "closed"].")
	if(panel_open)
		to_chat(user, "The power cell is [cell ? "installed" : "missing"].")
	else
		to_chat(user, "The charge meter reads [cell ? round(cell.percent(),1) : 0]%")

/obj/machinery/dehumidifier/emp_act(severity)
	if(cell)
		cell.emp_act(severity)
	..(severity)

/obj/machinery/dehumidifier/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/cell))
		if(panel_open)
			if(cell)
				to_chat(user, "There is already a power cell inside.")
				return
			else
				// insert cell
				if(!user.unEquip(I, src))
					return
				cell = I
				user.visible_message(SPAN_NOTICE("[user] inserts a power cell into [src]"), SPAN_NOTICE("You insert the power cell into [src]."))
				power_change()
		else
			to_chat(user, "The hatch must be open to insert a power cell.")
			return
	else if(isScrewdriver(I))
		panel_open = !panel_open
		user.visible_message(SPAN_NOTICE("[user] [panel_open ? "opens" : "closes"] the hatch on [src]."), SPAN_NOTICE("You [panel_open ? "open" : "close"] the hatch on [src]."))
		update_icon(1)
	else
		..()

/obj/machinery/dehumidifier/attack_hand(mob/user)
	interact(user)

/obj/machinery/dehumidifier/interact(var/mob/user)
	if(!CanPhysicallyInteract(user))
		return

	if(panel_open)
		if(cell)
			cell.dropInto(loc)
			user.put_in_hands(cell)
			user.visible_message(SPAN_NOTICE("[user] pops [cell] out of [src]."))
			cell = null
		else
			to_chat(user, SPAN_WARNING("[src] has no cell installed."))
	else

		if(!cell || !cell.charge)
			to_chat(user, SPAN_WARNING("You try to switch [src] on, but nothing happens."))
			return

		on = !on
		user.visible_message(SPAN_NOTICE("[user] switches [src] [on ? "on" : "off"]."))
		update_icon()

/obj/machinery/dehumidifier/Process()
	if(!on)
		return

	if(cell && cell.charge)
		var/turf/T = get_turf(src)
		if(!istype(T)) return
		var/fluid_here = T.get_fluid_depth()
		if(fluid_here <= 0)
			cell.use(drainage*1000*CELLRATE)
			return

		T.remove_fluid(ceil(fluid_here*drainage))
		cell.use(drainage*5000*CELLRATE)
		T.show_bubbles()
		if(world.time > last_gurgle + 80)
			last_gurgle = world.time
			playsound(T, pick(SSfluids.gurgles), 50, 1)

	else
		on = 0
		power_change()
		update_icon()

/obj/machinery/dehumidifier/Destroy()
	QDEL_NULL(cell)
	. = ..()