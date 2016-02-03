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
