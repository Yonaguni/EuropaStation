// Groovy PDA replacement. Totally not a Pipboy 3000.
/obj/item/device/wrist_computer
	name = "wrist computer"
	desc = "A reliable old Jonson N.D.I.U microcomputer. All the rage with <i>huge nerds</i> back home."
	slot_flags = SLOT_ID
	w_class = 3
	icon_state = "wrist_computer"
	item_state = null

	var/obj/machinery/console/embedded_terminal
	var/loaded_id

/obj/item/device/wrist_computer/New()
	..()
	embedded_terminal = new(src)
	embedded_terminal.name = "terminal ([src.name])"

/obj/item/device/wrist_computer/attack_hand(var/mob/user)
	if(embedded_terminal)
		var/mob/living/human/H = user
		if(istype(H) && H.wear_id == src)
			return embedded_terminal.interact(user)
	return ..()

/obj/item/device/wrist_computer/MouseDrop(var/atom/over)
	var/obj/machinery/E = over
	var/mob/living/human/H = usr
	if(istype(H) && H.wear_id == src)
		if(istype(E))
			usr << "<span class='notice'>You connect \the [src] to \the [over].</span>"
			E.interact(usr)
		else if(over.name in list("r_hand", "l_hand"))
			if(src.loc != H)
				return
			if ((H.restrained()) || (H.incapacitated()))
				return
			if (!H.unEquip(src))
				return
			switch(over.name)
				if("r_hand")
					usr.put_in_r_hand(src)
				if("l_hand")
					usr.put_in_l_hand(src)
			src.add_fingerprint(usr)
		return
	return ..()




