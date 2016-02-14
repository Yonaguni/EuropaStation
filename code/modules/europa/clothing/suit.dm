/obj/item/clothing/suit/europa
	name = "Europan coat"
	desc = "An undersea colonist coat."
	icon = 'icons/obj/europa/clothing/suit.dmi'
	item_state_slots = null
	sprite_sheets = null
	species_restricted = null
	item_icons = list(
		slot_wear_suit_str = 'icons/mob/europa/worn_suit.dmi',
		slot_l_hand_str = 'icons/mob/europa/lefthand_suit.dmi',
		slot_r_hand_str = 'icons/mob/europa/righthand_suit.dmi'
		)

/obj/item/clothing/suit/space/europa
	name = "Europan suit"
	desc = "An undersea colonist suit."
	icon = 'icons/obj/europa/clothing/suit.dmi'
	item_state_slots = null
	sprite_sheets = null
	species_restricted = null
	item_icons = list(
		slot_wear_suit_str = 'icons/mob/europa/worn_suit.dmi',
		slot_l_hand_str = 'icons/mob/europa/lefthand_suit.dmi',
		slot_r_hand_str = 'icons/mob/europa/righthand_suit.dmi'
		)

/obj/item/clothing/suit/space/europa/diving
	name = "diving suit"
	desc = "A light diving suit suitable for shallow excursions."
	icon_state = "diving_light"

/obj/item/clothing/suit/space/europa/diving/medium
	name = "reinforced diving suit"
	desc = "A reinforced diving suit suitable for excursions of brief duration."
	icon_state = "diving_medium"

/obj/item/clothing/suit/space/europa/diving/heavy
	name = "armoured diving suit"
	desc = "A heavy, armoured diving suit suitable for extended excursions."
	icon_state = "diving_heavy"

/obj/item/weapon/rig/industrial/deepsea
	name = "deepsea suit control module"
	suit_type = "deepsea hardsuit"
	desc = "A huge, bulky deepsea rig used for mining operations at extreme sea depths."
	icon_state = "deepsea_rig"
	offline_vision_restriction = 0

	helm_type = /obj/item/clothing/head/helmet/space/rig/industrial

/*
 * Rimworld.
 */

/obj/item/clothing/suit/europa/hunter
	name = "hunter's coat"
	desc = "Rugged and hard-wearing."
	icon_state = "hunter_coat"

/obj/item/clothing/suit/europa/lawman
	name = "lawman's jacket"
	desc = "You feeling lucky?"
	icon_state = "brown_jacket"

/obj/item/clothing/suit/europa/armour/soft
	name = "soft vest"
	desc = "A soft armoured vest."
	icon_state = "soft_armour"
	armor = list(melee = 25, bullet = 15, laser = 0, energy = 0, bomb = 5, bio = 0, rad = 0)

/obj/item/clothing/suit/europa/armour/medium
	name = "ballistic kevlar vest"
	desc = "A studry kevlar vest"
	icon_state = "medium_armour"
	armor = list(melee = 5, bullet = 55, laser = 0, energy = 0, bomb = 10, bio = 0, rad = 0)

/obj/item/clothing/suit/europa/armour/heavy
	name = "hard steel vest"
	desc = "A heavy steel vest"
	icon_state = "heavy_armour"
	slowdown = 1
	armor = list(melee = 50, bullet = 65, laser = 5, energy = 5, bomb = 10, bio = 0, rad = 0)

/obj/item/clothing/suit/europa/armour/makeshift
	name = "makeshirt armour"
	desc = "A poorly put together armour vest."
	icon_state = "improvised_armour"
	armor = list(melee = 10, bullet = 5, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)