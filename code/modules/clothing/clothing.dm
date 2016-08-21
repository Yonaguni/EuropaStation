/obj/item/clothing
	name = "clothing"
	siemens_coefficient = 0.9
	var/flash_protection = FLASH_PROTECTION_NONE	// Sets the item's level of flash protection.
	var/tint = TINT_NONE							// Sets the item's level of visual impairment tint.
	var/list/species_restricted = null 				//Only these species can wear this kit.
	var/gunshot_residue //Used by forensics.

	var/list/accessories = list()
	var/list/valid_accessory_slots
	var/list/restricted_accessory_slots

	/*
		Sprites used when the clothing item is refit. This is done by setting icon_override.
		For best results, if this is set then sprite_sheets should be null and vice versa, but that is by no means necessary.
		Ideally, sprite_sheets_refit should be used for "hard" clothing items that can't change shape very well to fit the wearer (e.g. helmets, hardsuits),
		while sprite_sheets should be used for "flexible" clothing items that do not need to be refitted (e.g. vox wearing jumpsuits).
	*/
	var/list/sprite_sheets_refit = null

//Updates the icons of the mob wearing the clothing item, if any.
/obj/item/clothing/proc/update_clothing_icon()
	return

// Aurora forensics port.
/obj/item/clothing/clean_blood()
	..()
	gunshot_residue = null

//BS12: Species-restricted clothing check.
/obj/item/clothing/mob_can_equip(M as mob, slot)

	//if we can't equip the item anyway, don't bother with species_restricted (cuts down on spam)
	if (!..())
		return 0

	if(species_restricted && istype(M,/mob/living/human))
		var/exclusive = null
		var/wearable = null
		var/mob/living/human/H = M

		if("exclude" in species_restricted)
			exclusive = 1

		if(H.species)
			if(exclusive)
				if(!(H.species.get_bodytype() in species_restricted))
					wearable = 1
			else
				if(H.species.get_bodytype() in species_restricted)
					wearable = 1

			if(!wearable && !(slot in list(slot_l_store, slot_r_store, slot_s_store)))
				H << "<span class='danger'>Your species cannot wear [src].</span>"
				return 0
	return 1

/obj/item/clothing/proc/refit_for_species(var/target_species)
	if(!species_restricted)
		return //this item doesn't use the species_restricted system

	//Set species_restricted list
	switch(target_species)
		if("Human", "Skrell")	//humanoid bodytypes
			species_restricted = list("Human", "Skrell") //skrell/humans can wear each other's suits
		else
			species_restricted = list(target_species)

	//Set icon
	if (sprite_sheets_refit && (target_species in sprite_sheets_refit))
		icon_override = sprite_sheets_refit[target_species]
	else
		icon_override = initial(icon_override)

	if (sprite_sheets_obj && (target_species in sprite_sheets_obj))
		icon = sprite_sheets_obj[target_species]
	else
		icon = initial(icon)
