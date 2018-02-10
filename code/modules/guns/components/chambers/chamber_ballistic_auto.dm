/obj/item/gun_component/chamber/ballistic/auto
	icon_state="smg"
	name = "autoloader"
	automatic = 1
	weapon_type = GUN_SMG
	load_method = MAGAZINE
	ammo_indicator_state = "ballistic_smg_loaded"
	recoil_mod = 1
	accuracy_mod = -2
	color = COLOR_GUNMETAL
	design_caliber = /decl/weapon_caliber/pistol_small

/obj/item/gun_component/chamber/ballistic/auto/assault
	icon_state="assault"
	name = "autoloader"
	weapon_type = GUN_ASSAULT
	ammo_indicator_state = "ballistic_assault_loaded"
	auto_eject_sound = 'sound/weapons/smg_empty_alarm.ogg'
	color = null
	design_caliber = /decl/weapon_caliber/rifle_small

/obj/item/gun_component/chamber/ballistic/auto/cannon
	icon_state="cannon"
	weapon_type = GUN_CANNON
	ammo_indicator_state = "ballistic_cannon_loaded"
	color = null
	design_caliber = /decl/weapon_caliber/gyrojet
