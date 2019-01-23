/obj/item/clothing/suit/storage/toggle/labcoat
	name = "labcoat"
	desc = "A suit that protects against minor chemical spills."
	icon_state = "labcoat_open"
	icon_open = "labcoat_open"
	icon_closed = "labcoat"
	blood_overlay_type = "coat"
	body_parts_covered = UPPER_TORSO|ARMS
	allowed = list(/obj/item/device/analyzer,/obj/item/stack/medical,/obj/item/weapon/reagent_containers/dropper,/obj/item/weapon/reagent_containers/syringe,/obj/item/weapon/reagent_containers/hypospray,/obj/item/device/healthanalyzer,/obj/item/device/flashlight/pen,/obj/item/weapon/reagent_containers/glass/bottle,/obj/item/weapon/reagent_containers/glass/beaker,/obj/item/weapon/reagent_containers/pill,/obj/item/weapon/storage/pill_bottle,/obj/item/weapon/paper)
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 50, rad = 0)
	valid_accessory_slots = list(ACCESSORY_SLOT_ARMBAND)
	restricted_accessory_slots = list(ACCESSORY_SLOT_ARMBAND)
