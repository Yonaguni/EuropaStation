/obj/item/rig/kharmaani
	name = "drone rig"
	desc = "An integrated cybernetic drone control system and docking rig."
	icon_state = "kexosuit"
	suit_type = "support exosuit"
	armor = list(melee = 80, bullet = 80, laser = 75, energy = 50, bomb = 90, bio = 100, rad = 100)
	online_slowdown = 0
	offline_slowdown = 1

	chest_type = /obj/item/clothing/suit/space/rig/kharmaani
	helm_type = /obj/item/clothing/head/helmet/space/rig/kharmaani
	boot_type = /obj/item/clothing/shoes/magboots/rig/kharmaani
	glove_type = /obj/item/clothing/gloves/rig/kharmaani

	icon_override = 'icons/mob/species/kharmaani/gyne_back.dmi'
	var/kharmaani_caste = "Mantid Gyne"

	sprite_sheets = list(
		"Mantid Gyne" = 'icons/mob/species/kharmaani/gyne_back.dmi',
		"Mantid Alate" = 'icons/mob/species/kharmaani/alate_back.dmi'
		)

/obj/item/rig/kharmaani/alate
	icon_override = 'icons/mob/species/kharmaani/alate_back.dmi'
	kharmaani_caste = "Mantid Alate"

/obj/item/rig/kharmaani/equipped
	initial_modules = list(
		/obj/item/rig_module/vision/thermal,
		/obj/item/rig_module/ai_container,
		/obj/item/rig_module/power_sink,
		/obj/item/rig_module/electrowarfare_suite,
		/obj/item/rig_module/chem_dispenser/combat,
		/obj/item/rig_module/energy_blade,
		/obj/item/rig_module/device/plasmacutter,
		/obj/item/rig_module/maneuvering_jets
		)

/obj/item/rig/kharmaani/alate/equipped
	initial_modules = list(
		/obj/item/rig_module/vision/thermal,
		/obj/item/rig_module/ai_container,
		/obj/item/rig_module/power_sink,
		/obj/item/rig_module/electrowarfare_suite,
		/obj/item/rig_module/chem_dispenser/combat,
		/obj/item/rig_module/energy_blade,
		/obj/item/rig_module/device/plasmacutter,
		/obj/item/rig_module/stealth_field,
		/obj/item/rig_module/maneuvering_jets
		)

/obj/item/rig/kharmaani/mob_can_equip(var/mob/M, var/slot)
	. = ..()
	if(. && slot == slot_back)
		var/mob/living/carbon/human/H = M
		if(!istype(H) || H.species.get_bodytype(H) != kharmaani_caste)
			H << "<span class='danger'>Your species cannot wear \the [src].</span>"
			. = 0

/obj/item/clothing/head/helmet/space/rig/kharmaani
	light_color = "#00FFFF"
	desc = "More like a torpedo casing than a helmet."
	species_restricted = list("Mantid Gyne", "Mantid Alate")
	sprite_sheets = list(
		"Mantid Gyne" = 'icons/mob/species/kharmaani/gyne_head.dmi',
		"Mantid Alate" = 'icons/mob/species/kharmaani/alate_head.dmi'
		)

/obj/item/clothing/suit/space/rig/kharmaani
	desc = "It's closer to a mech than a suit."
	species_restricted = list("Mantid Gyne", "Mantid Alate")
	sprite_sheets = list(
		"Mantid Gyne" = 'icons/mob/species/kharmaani/gyne_suit.dmi',
		"Mantid Alate" = 'icons/mob/species/kharmaani/alate_suit.dmi'
		)

/obj/item/clothing/shoes/magboots/rig/kharmaani
	desc = "It's like a highly advanced forklift."
	species_restricted = list("Mantid Gyne", "Mantid Alate")
	sprite_sheets = list(
		"Mantid Gyne" = 'icons/mob/species/kharmaani/gyne_shoes.dmi',
		"Mantid Alate" = 'icons/mob/species/kharmaani/alate_shoes.dmi'
		)

/obj/item/clothing/gloves/rig/kharmaani
	desc = "They look like a cross between a can opener and a Swiss army knife the size of a shoebox."
	species_restricted = list("Mantid Gyne", "Mantid Alate")
	sprite_sheets = list(
		"Mantid Gyne" = 'icons/mob/species/kharmaani/gyne_gloves.dmi',
		"Mantid Alate" = 'icons/mob/species/kharmaani/alate_gloves.dmi'
		)

// There has to be a better way to handle this.
/obj/item/rig/get_mob_overlay(var/mob/user_mob, var/slot)
	var/image/ret = ..()
	if(ishuman(user_mob))
		var/mob/living/carbon/human/H = user_mob
		if(H.species.get_bodytype(H) == "Mantid Gyne")
			ret.pixel_x = 0
			ret.pixel_y = 0
	. = ret

/obj/item/clothing/head/helmet/space/rig/kharmaani/get_mob_overlay(var/mob/user_mob, var/slot)
	var/image/ret = ..()
	if(ishuman(user_mob))
		var/mob/living/carbon/human/H = user_mob
		if(H.species.get_bodytype(H) == "Mantid Gyne")
			ret.pixel_x = 0
			ret.pixel_y = 0
	. = ret

/obj/item/clothing/suit/space/rig/kharmaani/get_mob_overlay(var/mob/user_mob, var/slot)
	var/image/ret = ..()
	if(ishuman(user_mob))
		var/mob/living/carbon/human/H = user_mob
		if(H.species.get_bodytype(H) == "Mantid Gyne")
			ret.pixel_x = 0
			ret.pixel_y = 0
	. = ret

/obj/item/clothing/shoes/magboots/rig/kharmaani/get_mob_overlay(var/mob/user_mob, var/slot)
	var/image/ret = ..()
	if(ishuman(user_mob))
		var/mob/living/carbon/human/H = user_mob
		if(H.species.get_bodytype(H) == "Mantid Gyne")
			ret.pixel_x = 0
			ret.pixel_y = 0
	. = ret

/obj/item/clothing/gloves/rig/kharmaani/get_mob_overlay(var/mob/user_mob, var/slot)
	var/image/ret = ..()
	if(ishuman(user_mob))
		var/mob/living/carbon/human/H = user_mob
		if(H.species.get_bodytype(H) == "Mantid Gyne")
			ret.pixel_x = 0
			ret.pixel_y = 0
	. = ret
