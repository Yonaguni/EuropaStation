/obj/item/weapon/rig/light/internalaffairs
	name = "augmented tie"
	suit_type = "augmented suit"
	desc = "Prepare for paperwork."
	icon_state = "internalaffairs_rig"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	online_slowdown = 0
	offline_slowdown = 0
	offline_vision_restriction = 0

	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/device/suit_cooling_unit,/obj/item/weapon/storage/briefcase, /obj/item/weapon/storage/secure/briefcase)

	req_access = list(access_lawyer)

	glove_type = null
	helm_type = null
	boot_type = null

	hides_uniform = 0

/obj/item/weapon/rig/light/internalaffairs/equipped
	initial_modules = list(
		/obj/item/rig_module/ai_container,
		/obj/item/rig_module/device/flash,
		/obj/item/rig_module/device/paperdispenser,
		/obj/item/rig_module/device/pen,
		/obj/item/rig_module/device/stamp,
		/obj/item/rig_module/cooling_unit
		)

	glove_type = null
	helm_type = null
	boot_type = null

/obj/item/weapon/rig/industrial
	name = "industrial suit control module"
	suit_type = "industrial hardsuit"
	desc = "A heavy, powerful rig used by construction crews and mining corporations."
	icon_state = "engineering_rig"
	armor = list(melee = 60, bullet = 50, laser = 50,energy = 15, bomb = 30, bio = 100, rad = 50)
	online_slowdown = 3
	offline_slowdown = 10
	vision_restriction = TINT_HEAVY
	offline_vision_restriction = TINT_BLIND
	emp_protection = -20

	chest_type = /obj/item/clothing/suit/space/rig/industrial
	helm_type = /obj/item/clothing/head/helmet/space/rig/industrial
	boot_type = /obj/item/clothing/shoes/magboots/rig/industrial
	glove_type = /obj/item/clothing/gloves/rig/industrial

	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/device/suit_cooling_unit,/obj/item/stack/flag,/obj/item/weapon/storage/ore,/obj/item/device/t_scanner,/obj/item/weapon/pickaxe, /obj/item/weapon/rcd)

/obj/item/clothing/head/helmet/space/rig/industrial
	camera = /obj/machinery/camera/network/mining
	species_restricted = list(SPECIES_HUMAN,SPECIES_SKRELL,SPECIES_UNATHI)

/obj/item/clothing/suit/space/rig/industrial
	species_restricted = list(SPECIES_HUMAN,SPECIES_SKRELL,SPECIES_UNATHI)

/obj/item/clothing/shoes/magboots/rig/industrial
	species_restricted = list(SPECIES_HUMAN,SPECIES_SKRELL,SPECIES_UNATHI)

/obj/item/clothing/gloves/rig/industrial
	species_restricted = list(SPECIES_HUMAN,SPECIES_SKRELL,SPECIES_UNATHI)
	siemens_coefficient = 0

/obj/item/weapon/rig/industrial/equipped

	initial_modules = list(
		/obj/item/rig_module/mounted/plasmacutter,
		/obj/item/rig_module/device/drill,
		/obj/item/rig_module/device/orescanner,
		/obj/item/rig_module/device/rcd,
		/obj/item/rig_module/vision/meson,
		/obj/item/rig_module/cooling_unit
		)
