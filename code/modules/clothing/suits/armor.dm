
/obj/item/clothing/suit/armor
	icon_state = "kvest"
	item_state = "armor"
	allowed = list(/obj/item/weapon/gun/energy,/obj/item/device/radio,/obj/item/weapon/reagent_containers/spray/pepper,/obj/item/weapon/gun/projectile,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/weapon/gun/magnetic)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	item_flags = ITEM_FLAG_THICKMATERIAL
	cold_protection = UPPER_TORSO|LOWER_TORSO
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = UPPER_TORSO|LOWER_TORSO
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.6

/obj/item/clothing/suit/armor/vest
	name = "armored vest"
	desc = "An armor vest made of synthetic fibers."
	armor = list(melee = 25, bullet = 30, laser = 30, energy = 10, bomb = 25, bio = 0, rad = 0)
	valid_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA)