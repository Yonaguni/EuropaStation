/obj/item/clothing/suit
	icon = 'icons/obj/clothing/obj_suit.dmi'
	name = "suit"
	var/fire_resist = T0C+100
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	allowed = list(/obj/item/weapon/tank/emergency)
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	slot_flags = SLOT_OCLOTHING
	blood_overlay_type = "suit"
	siemens_coefficient = 0.9
	w_class = ITEM_SIZE_NORMAL

	sprite_sheets = list(
		SPECIES_VOX = 'icons/mob/species/vox/onmob_suit_vox.dmi',
		SPECIES_UNATHI = 'icons/mob/species/unathi/generated/onmob_suit_unathi.dmi',
		SPECIES_NABBER = 'icons/mob/species/nabber/onmob_suit_gas.dmi',
		)

/obj/item/clothing/suit/update_clothing_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_wear_suit()

/obj/item/clothing/suit/get_mob_overlay(mob/user_mob, slot)
	var/image/ret = ..()
	if(item_state_slots && item_state_slots[slot])
		ret.icon_state = item_state_slots[slot]
	else
		ret.icon_state = icon_state
	return ret

/obj/item/clothing/suit/proc/get_collar()
	var/icon/C = new('icons/mob/collar.dmi')
	if(icon_state in C.IconStates())
		var/image/I = image(C, icon_state)
		I.color = color
		return I