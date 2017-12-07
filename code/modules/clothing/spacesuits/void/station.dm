// Station voidsuits
/obj/item/clothing/head/helmet/space/void/industrial
	name = "industrial pressure suit helmet"
	desc = "A scuffed voidsuit helmet with a boosted communication system and reinforced armor plating."
	icon_state = "suit_industrial"
	item_state = "suit_industrial"
	item_state_slots = list(
		slot_l_hand_str = "suit_industrial",
		slot_r_hand_str = "suit_industrial",
		)
	armor = list(melee = 50, bullet = 5, laser = 20,energy = 5, bomb = 55, bio = 100, rad = 20)
	light_overlay = "helmet_light_dual"

/obj/item/clothing/suit/space/void/industrial
	name = "industrial pressure suit"
	desc = "A grimy, decently armored pressure suit with purple blazes and extra insulation."
	item_state = "suit_industrial"
	icon_state = "suit_industrial"
	armor = list(melee = 50, bullet = 5, laser = 20,energy = 5, bomb = 55, bio = 100, rad = 20)
	allowed = list(/obj/item/flashlight,/obj/item/tank,/obj/item/stack/flag,/obj/item/suit_cooling_unit,/obj/item/storage/ore,/obj/item/t_scanner,/obj/item/pickaxe, /obj/item/rcd)

/obj/item/clothing/head/helmet/space/void/armoured
	name = "armoured pressure suit helmet"
	desc = "A comfortable pressure suit helmet with cranial armor and eight-channel surround sound."
	icon_state = "suit_armoured"
	item_state = "suit_armoured"
	item_state_slots = list(
		slot_l_hand_str = "suit_armoured",
		slot_r_hand_str = "suit_armoured",
		)
	armor = list(melee = 60, bullet = 10, laser = 30, energy = 5, bomb = 45, bio = 100, rad = 10)
	siemens_coefficient = 0.7
	light_overlay = "helmet_light_dual"

/obj/item/clothing/suit/space/void/armoured
	name = "armoured pressure suit"
	desc = "A somewhat clumsy pressure suit layered with impact and laser-resistant armor plating. Specially designed to dissipate minor electrical charges."
	item_state = "suit_armoured"
	icon_state = "suit_armoured"
	armor = list(melee = 60, bullet = 10, laser = 30, energy = 5, bomb = 45, bio = 100, rad = 10)
	allowed = list(/obj/item/gun,/obj/item/flashlight,/obj/item/tank,/obj/item/suit_cooling_unit,/obj/item/melee/baton)
	siemens_coefficient = 0.7
