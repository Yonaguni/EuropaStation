//these are probably broken

/obj/machinery/floodlight
	name = "emergency floodlight"
	icon = 'icons/obj/machines/floodlight.dmi'
	icon_state = "flood00"
	density = 1

	light_range = 5
	light_power = 10

	var/obj/item/cell/cell = null
	var/use = 200 // 200W light
	var/unlocked = 0
	var/open = 0

/obj/machinery/floodlight/New()
	cell = new/obj/item/cell/crap(src)
	..()

/obj/machinery/floodlight/update_icon()
	overlays.Cut()
	icon_state = "flood[open ? "o" : ""][open && cell ? "b" : ""]0[light_obj ? 1 : 0]"

/obj/machinery/floodlight/process()
	if(!light_obj)
		return

	if(!cell || (cell.charge < (use * CELLRATE)))
		turn_off(1)
		return

	cell.use(use*CELLRATE)


// Returns 0 on failure and 1 on success
/obj/machinery/floodlight/proc/turn_on(var/loud = 0)

	if(light_obj)
		return 0

	if(!cell)
		return 0

	if(cell.charge < (use * CELLRATE))
		return 0

	set_light()
	update_icon()

	if(loud)
		visible_message("\The [src] turns on.")

	return 1

/obj/machinery/floodlight/proc/turn_off(var/loud = 0)
	kill_light()
	update_icon()
	if(loud)
		visible_message("\The [src] shuts down.")

/obj/machinery/floodlight/attack_ai(var/mob/user)
	if(istype(user, /mob/living/silicon/robot) && Adjacent(user))
		return attack_hand(user)

	if(light_obj)
		turn_off(1)
	else
		turn_on(1)

/obj/machinery/floodlight/attack_hand(var/mob/user)
	if(open && cell)
		if(ishuman(user))
			if(!user.get_active_hand())
				user.put_in_hands(cell)
				cell.loc = user.loc
		else
			cell.forceMove(loc)

		cell.add_fingerprint(user)
		cell.update_icon()
		cell = null

		kill_light()
		user << "You remove the power cell"
		update_icon()
		return

	if(light_obj)
		turn_off(1)
	else
		turn_on(1)

	update_icon()


/obj/machinery/floodlight/attackby(var/obj/item/W, var/mob/user)
	if (W.isscrewdriver())
		if (!open)
			if(unlocked)
				unlocked = 0
				user << "You screw the battery panel in place."
			else
				unlocked = 1
				user << "You unscrew the battery panel."

	if (W.iscrowbar())
		if(unlocked)
			if(open)
				open = 0
				overlays = null
				user << "You crowbar the battery panel in place."
			else
				if(unlocked)
					open = 1
					user << "You remove the battery panel."

	if (istype(W, /obj/item/cell))
		if(open)
			if(cell)
				user << "There is a power cell already installed."
			else
				user.drop_item()
				W.loc = src
				cell = W
				user << "You insert the power cell."
	update_icon()
