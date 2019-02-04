/obj/item/clothing
	name = "clothing"
	siemens_coefficient = 0.9
	item_state = null
	
	var/flash_protection = FLASH_PROTECTION_NONE	// Sets the item's level of flash protection.
	var/tint = TINT_NONE							// Sets the item's level of visual impairment tint.
	var/list/species_restricted

	var/list/accessories = list()
	var/list/valid_accessory_slots
	var/list/restricted_accessory_slots
	var/list/starting_accessories
	var/blood_overlay_type = "uniformblood"
	var/visible_name = "Unknown"
	var/ironed_state = WRINKLES_DEFAULT
	var/smell_state = SMELL_DEFAULT

	var/move_trail = /obj/effect/decal/cleanable/blood/tracks/footprints // if this item covers the feet, the footprints it should leave

// Updates the icons of the mob wearing the clothing item, if any.
/obj/item/clothing/proc/update_clothing_icon()
	return

// Updates the vision of the mob wearing the clothing item, if any
/obj/item/clothing/proc/update_vision()
	if(isliving(src.loc))
		var/mob/living/L = src.loc
		L.handle_vision()

// Checked when equipped, returns true when the wearing mob's vision should be updated
/obj/item/clothing/proc/needs_vision_update()
	return flash_protection || tint

/obj/item/clothing/get_mob_overlay(mob/user_mob, slot)
	var/image/ret = ..()

	if(slot == slot_l_hand_str || slot == slot_r_hand_str)
		return ret

	if(ishuman(user_mob))
		var/mob/living/carbon/human/user_human = user_mob
		if(blood_DNA && user_human.species.blood_mask)
			var/image/bloodsies = overlay_image(user_human.species.blood_mask, blood_overlay_type, blood_color, RESET_COLOR)
			bloodsies.appearance_flags |= NO_CLIENT_COLOR
			ret.overlays	+= bloodsies

	if(accessories.len)
		for(var/obj/item/clothing/accessory/A in accessories)
			ret.overlays |= A.get_mob_overlay(user_mob, slot)
	return ret

/obj/item/clothing/proc/change_smell(smell = SMELL_DEFAULT)
	smell_state = smell

/obj/item/clothing/proc/get_fibers()
	. = "material from \a [name]"
	var/list/acc = list()
	for(var/obj/item/clothing/accessory/A in accessories)
		if(prob(40) && A.get_fibers())
			acc += A.get_fibers()
	if(acc.len)
		. += " with traces of [english_list(acc)]"

/obj/item/clothing/proc/leave_evidence(mob/source)
	add_fingerprint(source)
	if(prob(10))
		ironed_state = WRINKLES_WRINKLY

/obj/item/clothing/New()
	..()
	if(starting_accessories)
		for(var/T in starting_accessories)
			var/obj/item/clothing/accessory/tie = new T(src)
			src.attach_accessory(null, tie)

//BS12: Species-restricted clothing check.
/obj/item/clothing/mob_can_equip(M as mob, slot, disable_warning = 0)

	//if we can't equip the item anyway, don't bother with species_restricted (cuts down on spam)
	if (!..())
		return 0

	if(species_restricted && istype(M,/mob/living/carbon/human))
		var/exclusive = null
		var/wearable = null
		var/mob/living/carbon/human/H = M

		if("exclude" in species_restricted)
			exclusive = 1

		if(H.species)
			if(exclusive)
				if(!(H.species.get_bodytype(H) in species_restricted))
					wearable = 1
			else
				if(H.species.get_bodytype(H) in species_restricted)
					wearable = 1

			if(!wearable && !(slot in list(slot_l_store, slot_r_store, slot_s_store)))
				if(!disable_warning)
					to_chat(H, "<span class='danger'>Your species cannot wear [src].</span>")
				return 0
	return 1

/obj/item/clothing/equipped(var/mob/user)
	if(needs_vision_update())
		update_vision()
	return ..()

/obj/item/clothing/proc/refit_for_species(var/target_species)
	if(!species_restricted)
		return //this item doesn't use the species_restricted system

	//Set species_restricted list
	species_restricted = list(target_species)

	if (sprite_sheets_obj && (target_species in sprite_sheets_obj))
		icon = sprite_sheets_obj[target_species]
	else
		icon = initial(icon)

/obj/item/clothing/head/helmet/refit_for_species(var/target_species)
	if(!species_restricted)
		return //this item doesn't use the species_restricted system

	//Set species_restricted list
	species_restricted = list(target_species)

	if (sprite_sheets_obj && (target_species in sprite_sheets_obj))
		icon = sprite_sheets_obj[target_species]
	else
		icon = initial(icon)

/obj/item/clothing/get_examine_line()
	. = ..()
	var/list/ties = list()
	for(var/obj/item/clothing/accessory/accessory in accessories)
		if(accessory.high_visibility)
			ties += "\a [accessory.get_examine_line()]"
	if(ties.len)
		.+= " with [english_list(ties)] attached"
	if(accessories.len > ties.len)
		.+= ". <a href='?src=\ref[src];list_ungabunga=1'>\[See accessories\]</a>"

/obj/item/clothing/CanUseTopic(var/user)
	if(user in view(get_turf(src)))
		return STATUS_INTERACTIVE

/obj/item/clothing/OnTopic(var/user, var/list/href_list, var/datum/topic_state/state)
	if(href_list["list_ungabunga"])
		if(accessories.len)
			var/list/ties = list()
			for(var/accessory in accessories)
				ties += "\icon[accessory] \a [accessory]"
			to_chat(user, "Attached to \the [src] are [english_list(ties)].")
		return TOPIC_HANDLED

// Clothing armour values.
/obj/item/clothing
	var/global/list/armour_to_descriptive_term = list(
		"melee" = "blunt force",
		"bullet" = "ballistics",
		"laser" = "lasers",
		"energy" = "energy",
		"bomb" = "explosions",
		"bio" = "biohazards",
		"rad" = "radiation"
		)

/obj/item/clothing/examine(var/mob/user)
	. = ..()
	if(. && user)
		var/list/armor_strings = list()
		for(var/armor_type in armour_to_descriptive_term)
			if(armor[armor_type])
				switch(armor[armor_type])
					if(1 to 20)
						armor_strings += "It barely protects against [armour_to_descriptive_term[armor_type]]."
					if(21 to 30)
						armor_strings += "It provides a very small defense against [armour_to_descriptive_term[armor_type]]."
					if(31 to 40)
						armor_strings += "It offers a small amount of protection against [armour_to_descriptive_term[armor_type]]."
					if(41 to 50)
						armor_strings += "It offers a moderate defense against [armour_to_descriptive_term[armor_type]]."
					if(51 to 60)
						armor_strings += "It provides a strong defense against [armour_to_descriptive_term[armor_type]]."
					if(61 to 70)
						armor_strings += "It is very strong against [armour_to_descriptive_term[armor_type]]."
					if(71 to 80)
						armor_strings += "This gives a very robust defense against [armour_to_descriptive_term[armor_type]]."
					if(81 to 99)
						armor_strings += "Wearing this would make you nigh-invulerable against [armour_to_descriptive_term[armor_type]]."
					if(100)
						armor_strings += "You would be immune to [armour_to_descriptive_term[armor_type]] if you wore this."

		if(item_flags & ITEM_FLAG_AIRTIGHT)
			armor_strings += "It is airtight."

		if(item_flags & ITEM_FLAG_STOPPRESSUREDAMAGE)
			armor_strings += "Wearing this will protect you from the vacuum of space."

		if(item_flags & ITEM_FLAG_THICKMATERIAL)
			armor_strings += "The material is exceptionally thick."

		if(max_heat_protection_temperature >= FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE)
			armor_strings += "You could probably safely skydive into the Sun wearing this."
		else if(max_heat_protection_temperature >= SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE)
			armor_strings += "It provides good protection against fire and heat."

		if(!isnull(min_cold_protection_temperature) && min_cold_protection_temperature <= SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE)
			armor_strings += "It provides very good protection against very cold temperatures."

		var/list/covers = list()
		var/list/slots = list()
		for(var/name in string_part_flags)
			if(body_parts_covered & string_part_flags[name])
				covers += name
		for(var/name in string_slot_flags)
			if(slot_flags & string_slot_flags[name])
				slots += name

		if(covers.len)
			armor_strings += "It covers the [english_list(covers)]."

		if(slots.len)
			armor_strings += "It can be worn on your [english_list(slots)]."

		to_chat(user, jointext(armor_strings, "<br>"))