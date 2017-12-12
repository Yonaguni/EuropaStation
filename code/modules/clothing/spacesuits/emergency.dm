//Orange emergency space suit
/obj/item/clothing/head/helmet/space/emergency
	name = "emergency suit helmet"
	icon_state = "emergency"
	item_state = "emergency"
	desc = "A simple helmet with a built-in light. Smells like mothballs."
	flash_protection = FLASH_PROTECTION_NONE

/obj/item/clothing/suit/space/emergency
	name = "emergency softsuit"
	icon_state = "emergency"
	item_state = "emergency"
	desc = "A thin, ungainly softsuit colored in blazing orange for rescuers to easily locate. It looks pretty fragile."

/obj/item/clothing/suit/space/emergency/New()
	..()
	slowdown_per_slot[slot_wear_suit] = 4
