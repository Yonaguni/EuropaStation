/obj/item/modular_computer/pda
	name = "\improper PDA"
	desc = "A very compact computer, designed to keep its user always connected."
	icon = 'icons/obj/modular_pda.dmi'
	icon_state = "pda"
	icon_state_unpowered = "pda"
	hardware_flag = PROGRAM_PDA
	max_hardware_size = 1
	w_class = ITEM_SIZE_SMALL
	light_strength = 2
	slot_flags = SLOT_ID | SLOT_BELT
	stores_pen = TRUE
	stored_pen = /obj/item/weapon/pen
	receives_updates = FALSE

/obj/item/modular_computer/pda/Initialize()
	. = ..()
	var/mob/M = loc
	if(istype(M))
		enable_computer()

/obj/item/modular_computer/pda/AltClick(var/mob/user)
	if(!CanPhysicallyInteract(user))
		return
	if(card_slot && istype(card_slot.stored_card))
		eject_id()
	else
		..()

// PDA box
/obj/item/weapon/storage/box/PDAs
	name = "box of spare PDAs"
	desc = "A box of spare PDA microcomputers."
	icon = 'icons/obj/pda.dmi'
	icon_state = "pdabox"

/obj/item/weapon/storage/box/PDAs/Initialize()
	. = ..()
	new /obj/item/modular_computer/pda(src)
	new /obj/item/modular_computer/pda(src)
	new /obj/item/modular_computer/pda(src)
	new /obj/item/modular_computer/pda(src)
	new /obj/item/modular_computer/pda(src)

/obj/item/modular_computer/pda/wrist
	name = "wrist computer"
	desc = "A wrist-mounted modular personal computer. Very stylish."
	icon = 'icons/obj/wristcomp.dmi'
	icon_state = "wc_base"
	color = COLOR_GUNMETAL
	item_state_slots = list(slot_wear_id_str = "wc_base")
	light_color = LIGHT_COLOR_GREEN
	var/stripe_color

/obj/item/modular_computer/pda/wrist/attack_hand(var/mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.wear_id == src)
			attack_self(user)
			return
	. = ..()

/obj/item/modular_computer/pda/wrist/MouseDrop(var/obj/over_object)
	if(!usr.incapacitated() && loc == usr && over_object && ishuman(usr) && usr.unEquip(src))
		if(over_object.name == "r_hand")
			usr.put_in_r_hand(src)
		else if(over_object.name == "l_hand")
			usr.put_in_l_hand(src)
		else
			return
		add_fingerprint(usr)

/obj/item/modular_computer/pda/wrist/get_mob_overlay(var/mob/user_mob, var/slot)
	var/image/ret = ..()
	if(slot == slot_wear_id_str)
		if(enabled)
			var/image/I = image(icon = ret.icon, icon_state = "wc_screen")
			I.appearance_flags |= RESET_COLOR
			I.color = (bsod || updating) ? "#0000ff" : "#00ff00"
			ret.add_overlay(I)
		else
			ret.add_overlay(image(icon = ret.icon, icon_state = "wc_screen_off"))
		if(stripe_color)
			var/image/I = image(icon = ret.icon, icon_state = "wc_stripe")
			I.appearance_flags |= RESET_COLOR
			I.color = stripe_color
			add_overlay(I)
	return ret

/obj/item/modular_computer/pda/wrist/on_update_icon()
	cut_overlays()
	if(enabled)
		set_light(light_strength)
		var/image/I = image(icon = icon, icon_state = "wc_screen")
		I.appearance_flags |= RESET_COLOR
		I.color = (bsod || updating) ? "#0000ff" : "#00ff00"
		add_overlay(I)
	else
		set_light(0)
		var/image/I = image(icon = icon, icon_state = "wc_screen_off")
		add_overlay(I)
	if(stripe_color)
		var/image/I = image(icon = icon, icon_state = "wc_stripe")
		I.appearance_flags |= RESET_COLOR
		I.color = stripe_color
		add_overlay(I)

	var/mob/living/carbon/human/H = loc
	if(istype(H) && H.wear_id == src)
		H.update_inv_wear_id()
