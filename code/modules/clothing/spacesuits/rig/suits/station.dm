/obj/item/rig/industrial
	name = "industrial suit control module"
	suit_type = "industrial hardsuit"
	desc = "A heavy, powerful rig used by construction crews and mining corporations."
	icon_state = "engineering_rig"
	armor = list(melee = 60, bullet = 50, laser = 30,energy = 15, bomb = 30, bio = 100, rad = 50)
	online_slowdown = 3
	offline_slowdown = 10
	vision_restriction = TINT_HEAVY
	offline_vision_restriction = TINT_BLIND
	emp_protection = -20

	chest_type = /obj/item/clothing/suit/space/rig/industrial
	helm_type = /obj/item/clothing/head/helmet/space/rig/industrial
	boot_type = /obj/item/clothing/shoes/magboots/rig/industrial
	glove_type = /obj/item/clothing/gloves/rig/industrial

	allowed = list(/obj/item/flashlight,/obj/item/tank,/obj/item/suit_cooling_unit,/obj/item/stack/flag,/obj/item/storage/ore,/obj/item/t_scanner,/obj/item/pickaxe, /obj/item/rcd)

	req_access = list()
	req_one_access = list()

/obj/item/clothing/head/helmet/space/rig/industrial
	camera_networks = list(NETWORK_EXPEDITION)
	species_restricted = list(BODYTYPE_HUMAN)

/obj/item/clothing/suit/space/rig/industrial
	species_restricted = list(BODYTYPE_HUMAN)

/obj/item/clothing/shoes/magboots/rig/industrial
	species_restricted = list(BODYTYPE_HUMAN)

/obj/item/clothing/gloves/rig/industrial
	species_restricted = list(BODYTYPE_HUMAN)

/obj/item/rig/industrial/equipped

	initial_modules = list(
		/obj/item/rig_module/device/plasmacutter,
		/obj/item/rig_module/maneuvering_jets,
		/obj/item/rig_module/vision/meson
		)

/obj/item/rig/eva
	name = "\improper EVA suit control module"
	suit_type = "EVA hardsuit"
	desc = "A light rig for repairs and maintenance to the outside of habitats and vessels."
	icon_state = "science_rig"
	armor = list(melee = 30, bullet = 10, laser = 20,energy = 25, bomb = 20, bio = 100, rad = 100)
	online_slowdown = 0
	offline_slowdown = 1
	offline_vision_restriction = TINT_HEAVY

	chest_type = /obj/item/clothing/suit/space/rig/eva
	helm_type = /obj/item/clothing/head/helmet/space/rig/eva
	boot_type = /obj/item/clothing/shoes/magboots/rig/eva
	glove_type = /obj/item/clothing/gloves/rig/eva

	allowed = list(/obj/item/flashlight,/obj/item/tank,/obj/item/suit_cooling_unit,/obj/item/storage/toolbox,/obj/item/storage/briefcase/inflatable,/obj/item/t_scanner,/obj/item/rcd)

	req_access = list()
	req_one_access = list()

/obj/item/clothing/head/helmet/space/rig/eva
	light_overlay = "helmet_light_dual"
	camera_networks = list(NETWORK_ENGINEERING)
	species_restricted = list(BODYTYPE_HUMAN)

/obj/item/clothing/suit/space/rig/eva
	species_restricted = list(BODYTYPE_HUMAN)

/obj/item/clothing/shoes/magboots/rig/eva
	species_restricted = list(BODYTYPE_HUMAN)

/obj/item/clothing/gloves/rig/eva
	species_restricted = list(BODYTYPE_HUMAN)

/obj/item/rig/eva/equipped
	initial_modules = list(
		/obj/item/rig_module/device/plasmacutter,
		/obj/item/rig_module/maneuvering_jets,
		/obj/item/rig_module/vision/meson
		)
