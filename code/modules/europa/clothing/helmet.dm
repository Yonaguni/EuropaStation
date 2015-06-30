/obj/item/clothing/head/europa
	name = "Europan hat"
	desc = "An undersea colonist hat."
	icon = 'icons/obj/europa/clothing/helmet.dmi'
	item_state_slots = null
	sprite_sheets = null
	species_restricted = null
	item_icons = list(
		slot_head_str = 'icons/mob/europa/worn_helmet.dmi',
		slot_l_hand_str = 'icons/mob/europa/lefthand_helmet.dmi',
		slot_r_hand_str = 'icons/mob/europa/righthand_helmet.dmi'
		)

/obj/item/clothing/head/europa/diving
	name = "diving helmet"
	desc = "A light diving helmet suitable for shallow excursions."
	icon_state = "diving_light"
	light_overlay = "hardhat_light"

/obj/item/clothing/head/europa/diving/medium
	name = "reinforced diving helmet"
	desc = "A reinforced diving helmet suitable for excursions of brief duration."
	icon_state = "diving_medium"
	light_overlay = "helmet_light"

/obj/item/clothing/head/europa/diving/heavy
	name = "armoured diving helmet"
	desc = "A heavy, armoured diving helmet suitable for extended excursions."
	icon_state = "diving_heavy"
	light_overlay = "helmet_light_dual"