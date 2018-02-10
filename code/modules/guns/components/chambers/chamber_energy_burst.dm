/obj/item/gun_component/chamber/laser/burst
	icon_state="las_shotgun"
	name = "prismatic focusing lens"
	weapon_type = GUN_SHOTGUN
	ammo_indicator_state = "laser_shotgun_loaded"
	initial_charge = 7000
	max_shots = 8
	fire_delay = 10
	design_caliber = /decl/weapon_caliber/laser/burst

/obj/item/gun_component/chamber/laser/assault
	icon_state="las_assault"
	name = "multiphase lens"
	weapon_type = GUN_ASSAULT
	initial_charge = 12000
	max_shots = 30
	fire_delay = 2
	ammo_indicator_state = "laser_assault_loaded"
	self_recharge_time = 4
	design_caliber = /decl/weapon_caliber/laser
