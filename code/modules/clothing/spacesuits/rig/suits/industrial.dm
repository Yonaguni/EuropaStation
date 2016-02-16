/obj/item/clothing/head/helmet/space/rig/industrial
	camera_networks = list(NETWORK_MINE)

/obj/item/weapon/rig/industrial
	name = "industrial suit control module"
	suit_type = "industrial hardsuit"
	desc = "A heavy, powerful rig used by construction crews and mining corporations."
	icon_state = "engineering_rig"
	armor = list(melee = 60, bullet = 50, laser = 30,energy = 15, bomb = 30, bio = 100, rad = 50)
	slowdown = 3
	offline_slowdown = 10
	offline_vision_restriction = 2
	emp_protection = -20

	helm_type = /obj/item/clothing/head/helmet/space/rig/industrial

	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/device/suit_cooling_unit,/obj/item/weapon/storage/bag/ore,/obj/item/device/t_scanner,/obj/item/weapon/pickaxe, /obj/item/weapon/rcd)

	req_access = list()
	req_one_access = list()

/obj/item/weapon/rig/industrial/equipped

	initial_modules = list(
		/obj/item/rig_module/device/plasmacutter,
		/obj/item/rig_module/device/drill,
		/obj/item/rig_module/device/orescanner,
		/obj/item/rig_module/vision/meson
		)

/obj/item/weapon/rig/industrial/deepsea
	name = "deepsea suit control module"
	suit_type = "deepsea hardsuit"
	desc = "A huge, bulky deepsea rig used for mining operations at extreme sea depths."
	icon_state = "deepsea_rig"
	offline_vision_restriction = 0
