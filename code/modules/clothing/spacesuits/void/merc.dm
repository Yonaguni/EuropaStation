//Syndicate rig
/obj/item/clothing/head/helmet/space/void/merc
	name = "blood-red pressure suit helmet"
	desc = "An advanced helmet designed for work in active combat."
	item_state = "suit_merc"
	icon_state = "suit_merc"
	armor = list(melee = 60, bullet = 50, laser = 30,energy = 15, bomb = 35, bio = 100, rad = 60)
	siemens_coefficient = 0.3
	species_restricted = list(BODYTYPE_HUMAN)
	camera_networks = list(NETWORK_MERCENARY)
	light_overlay = "helmet_light_green" //todo: species-specific light overlays

/obj/item/clothing/suit/space/void/merc
	name = "blood-red pressure suit"
	desc = "An advanced suit that protects against injuries during active combat."
	item_state = "suit_merc"
	icon_state = "suit_merc"
	w_class = 4 //normally voidsuits are bulky but the merc voidsuit is 'advanced' or something
	armor = list(melee = 60, bullet = 50, laser = 30, energy = 15, bomb = 35, bio = 100, rad = 60)
	allowed = list(/obj/item/flashlight,/obj/item/tank,/obj/item/suit_cooling_unit,/obj/item/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/melee/baton,/obj/item/melee/energy/sword,/obj/item/handcuffs)
	siemens_coefficient = 0.3
	species_restricted = list(BODYTYPE_HUMAN)

/obj/item/clothing/suit/space/void/merc/New()
	..()
	slowdown_per_slot[slot_wear_suit] = 1
