///////////////////////////////////////////////////////////////////////
//Under clothing
/obj/item/clothing/under
	icon = 'icons/obj/clothing/obj_under.dmi'
	item_icons = list(
		slot_l_hand_str = 'icons/mob/onmob/items/lefthand_uniforms.dmi',
		slot_r_hand_str = 'icons/mob/onmob/items/righthand_uniforms.dmi',
		slot_w_uniform_str = 'icons/mob/onmob/onmob_under.dmi'
	)
	name = "under"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	permeability_coefficient = 0.90
	slot_flags = SLOT_ICLOTHING
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	w_class = 3
	valid_accessory_slots = list("utility","armband","rank","decor","waist")
	restricted_accessory_slots = list("utility", "armband","rank","waist")

	var/under_type = PARTIAL_UNIFORM_FULL
	var/list/under_parts

/obj/item/clothing/under/get_mob_overlay(mob/user_mob, slot)
	var/image/ret = ..()
	if(item_state_slots && item_state_slots[slot])
		ret.icon_state = item_state_slots[slot]
	else
		ret.icon_state = icon_state
	return ret

/obj/item/clothing/under/attack_hand(var/mob/user)
	if(accessories && accessories.len)
		..()
	if ((ishuman(usr) || issmall(usr)) && src.loc == user)
		return
	..()

/obj/item/clothing/under/Initialize()
	if(!item_state_slots)
		item_state_slots = list()
	item_state_slots[slot_w_uniform_str] = initial(icon_state)
	if(istype(loc, /turf))
		explode()
	else
		update_values()
		update_icon()
	. = ..()

/obj/item/clothing/under/MouseDrop(var/obj/over_object)

	if(!under_parts || !under_parts.len)
		return ..()

	if (ishuman(usr) || issmall(usr))
		if (!(src.loc == usr)) return
		if (( usr.restrained() ) || ( usr.stat )) return
		var/obj/item/removing
		for(var/under_slot in list(PARTIAL_UNIFORM_OVER, PARTIAL_UNIFORM_UPPER, PARTIAL_UNIFORM_LOWER, PARTIAL_UNIFORM_SKIN))
			if(!isnull(under_parts[under_slot]))
				removing = under_parts[under_slot]
				under_parts[under_slot] = null
				under_parts -= under_slot
				if(!under_parts.len) under_parts = null
				break

		if(removing)
			removing.forceMove(get_turf(src))
			removing.add_fingerprint(usr)
			switch(over_object.name)
				if("r_hand")
					usr.put_in_r_hand(removing)
				if("l_hand")
					usr.put_in_l_hand(removing)
			update_icon()
			update_values()
			return
	. = ..()

/obj/item/clothing/under/equipped()
	. = ..()
	update_icon()

/obj/item/clothing/under/verb/rollsuit_wrapper()
	set name = "Roll Down Jumpsuit"
	set category = "Object"
	set src in usr

	if(islist(under_parts))
		var/obj/item/clothing/under/jumpsuit/jumpsuit = under_parts[PARTIAL_UNIFORM_OVER]
		if(istype(jumpsuit))
			jumpsuit.rollsuit(usr)
			update_icon()
			return

	to_chat(usr, "<span class='warning'>You are not wearing a jumpsuit.</span>")

/obj/item/clothing/under/verb/toggle_wrapper()
	set name = "Toggle Jumpsuit Sensors"
	set category = "Object"
	set src in usr

	if(islist(under_parts))
		var/obj/item/clothing/under/jumpsuit/jumpsuit = under_parts[PARTIAL_UNIFORM_OVER]
		if(istype(jumpsuit))
			jumpsuit.set_sensors(usr)
			return
	to_chat(usr, "<span class='warning'>You are not wearing a jumpsuit.</span>")

/obj/item/clothing/under/update_clothing_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_w_uniform()

/obj/item/clothing/under/get_mob_overlay(var/mob/user_mob, var/slot, var/skip_blood)
	if(!under_parts || !under_parts.len || slot == slot_l_hand_str || slot == slot_r_hand_str)
		return ..()

	var/list/overlays_to_add = list()
	for(var/under_slot in GLOB.partial_uniform_layer_order)
		if(under_slot == under_type)
			var/image/I = ..()
			I.overlays.Cut() // we don't want blood or accessories on only one clothing section.
			if(color)
				I.appearance_flags |= RESET_COLOR
				I.color = color
			overlays_to_add += I
		else if(!isnull(under_parts[under_slot]))
			var/obj/item/component = under_parts[under_slot]
			overlays_to_add += component.get_mob_overlay(user_mob, slot, TRUE)

	var/image/ret = image(null)

	if(!skip_blood && ishuman(user_mob))
		var/mob/living/carbon/human/user_human = user_mob
		if(blood_DNA)
			overlays_to_add += overlay_image(user_human.species.blood_mask, blood_overlay_type, blood_color, RESET_COLOR)

	if(accessories.len)
		for(var/obj/item/clothing/accessory/A in accessories)
			overlays_to_add += A.get_mob_overlay(user_mob, slot)

	ret.overlays = overlays_to_add
	return ret

/obj/item/clothing/under/attackby(var/obj/item/thing, var/mob/user)
	if(under_type == PARTIAL_UNIFORM_FULL || istype(thing, /obj/item/clothing/under))
		var/obj/item/clothing/under/under = thing
		if(under.under_type != PARTIAL_UNIFORM_FULL)
			var/mob/living/carbon/human/H = user
			if(istype(H) && H.w_uniform == src)
				if(under.under_type == under_type)
					to_chat(user, SPAN_WARNING("You cannot wear \the [under] with \the [src], no matter how fashionable it is."))
					return
				if(!islist(under_parts))
					under_parts = list()
				if(!isnull(under_parts[under.under_type]))
					to_chat(user, SPAN_WARNING("You cannot wear \the [under] with \the [under_parts[under.under_type]], no matter how fashionable it is."))
					return
				user.drop_from_inventory(thing)
				thing.forceMove(src)
				under_parts[under.under_type] = thing
				update_icon()
				update_values()
				return
	. = ..()

/obj/item/clothing/under/examine(var/mob/user)
	. = ..(user)
	if(under_parts)
		to_chat(user, "The outfit consists of: ")
		for(var/thing in under_parts)
			var/obj/item/clothes = under_parts[thing]
			to_chat(user, "\icon[clothes] \A [clothes]. [clothes.desc]")

/obj/item/clothing/under/proc/update_values()

	name = initial(name)
	desc = initial(desc)
	body_parts_covered = initial(body_parts_covered)

	var/list/under_names = list(name)
	if(islist(under_parts))
		for(var/under_slot in GLOB.partial_uniform_layer_order)
			var/obj/item/clothing/thing = under_parts[under_slot]
			if(istype(thing))
				under_names += thing.name
				body_parts_covered |= thing.body_parts_covered
		name = english_list(under_names)
		desc = null

	if(islist(under_parts) && istype(under_parts[PARTIAL_UNIFORM_OVER], /obj/item/clothing/under/jumpsuit))
		verbs |= /obj/item/clothing/under/verb/toggle_wrapper
		verbs |= /obj/item/clothing/under/verb/rollsuit_wrapper
	else
		verbs -= /obj/item/clothing/under/verb/toggle_wrapper
		verbs -= /obj/item/clothing/under/verb/rollsuit_wrapper

/obj/item/clothing/under/Destroy()
	if(islist(under_parts))
		for(var/thing in under_parts)
			if(under_parts[thing])
				qdel(under_parts[thing])
		under_parts.Cut()
	. = ..()

/obj/item/clothing/under/equipped()
	. = ..()
	var/mob/living/carbon/human/M = loc
	if(!istype(M) || M.w_uniform != src)
		explode()

/obj/item/clothing/under/dropped()
	. = ..()
	explode()

/obj/item/clothing/under/proc/explode()
	if(islist(under_parts))
		for(var/under_slot in under_parts)
			var/obj/item/thing = under_parts[under_slot]
			thing.forceMove(get_turf(src))
		under_parts.Cut()
		under_parts = null
	update_icon()
	update_values()

/obj/item/clothing/under/on_update_icon()
	overlays.Cut()
	if(islist(under_parts))
		pixel_x = 0
		pixel_y = 0
		pixel_z = 0
		var/list/overlays_to_add = list()
		for(var/under_slot in GLOB.partial_uniform_layer_order)
			var/obj/item/thing = under_parts[under_slot]
			if(istype(thing))
				thing.update_icon()
				var/image/I = image(null)
				I.appearance = thing
				I.layer = layer
				I.plane = plane
				I.pixel_x = 0
				I.pixel_y = 0
				I.pixel_z = 0
				I.transform = null
				I.appearance_flags |= RESET_COLOR
				overlays_to_add += I
		overlays = overlays_to_add
	update_clothing_icon()

/obj/item/clothing/under/proc/set_sensors(var/mob/user)
	var/obj/item/clothing/under/clothes = locate() in get_clothing_with_sensors()
	if(clothes)
		return clothes.set_sensors(user)
	return FALSE

/obj/item/clothing/under/proc/has_sensors_somewhere()
	var/obj/item/clothing/under/clothes = locate() in get_clothing_with_sensors()
	if(clothes)
		return clothes.has_sensors_somewhere()
	return -1

/obj/item/clothing/under/proc/get_clothing_with_sensors()
	. = list()
	for(var/thing in under_parts)
		var/obj/item/clothing/under/clothes = under_parts[thing]
		if(clothes.has_sensors_somewhere() != -1)
			. |= clothes
