/obj/item/clothing/head/helmet/space/europa
	name = "spaceproof europan hat"
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
		
/obj/item/clothing/head/europa
	name = "europan hat"
	desc = "An undersea colonist hat. You shouldn't see this."
	icon = 'icons/obj/europa/clothing/helmet.dmi'
	item_state_slots = null
	sprite_sheets = null
	species_restricted = null
	item_icons = list(
		slot_head_str = 'icons/mob/europa/worn_helmet.dmi',
		slot_l_hand_str = 'icons/mob/europa/lefthand_helmet.dmi',
		slot_r_hand_str = 'icons/mob/europa/righthand_helmet.dmi'
		)

/obj/item/clothing/head/helmet/space/europa/diving
	name = "diving helmet"
	desc = "A light diving helmet suitable for shallow excursions."
	icon_state = "diving_light"
	light_overlay = "hardhat_light"
	flags_inv = HIDEMASK | HIDEEARS | HIDEEYES | BLOCKHAIR

/obj/item/clothing/head/helmet/space/europa/diving/medium
	name = "reinforced diving helmet"
	desc = "A reinforced diving helmet suitable for excursions of brief duration."
	icon_state = "diving_medium"
	light_overlay = "helmet_light"

/obj/item/clothing/head/helmet/space/europa/diving/heavy
	name = "armoured diving helmet"
	desc = "A heavy, armoured diving helmet suitable for extended excursions."
	icon_state = "diving_heavy"
	light_overlay = "helmet_light_dual"

//Government

/obj/item/clothing/head/europa/petty_officer/marshal
	name = "marshal's cap"
	desc = "A soft grey camo cap with a golden insignia for a government marshal."
	icon_state = "marshal_cap"

/obj/item/clothing/head/europa/petty_officer/
	name = "petty officer's cap"
	desc = "A soft grey camo cap for government petty pfficers."
	icon_state = "petty_officer_cap"

/obj/item/clothing/head/europa/petty_officer/parade
	name = "petty officer's parade cap"
	desc = "A sturdy grey hat fit for formal occasions."
	icon_state = "petty_officer_parade_cap"

/obj/item/clothing/head/europa/petty_officer/parade/marshal
	name = "marshal's parade hat"
	desc = "A decorated formal hat that announces your official presence."
	icon_state = "marshal_parade_cap"