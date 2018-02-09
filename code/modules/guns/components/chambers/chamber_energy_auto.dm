/obj/item/gun_component/chamber/laser/smg
	icon_state="las_smg"
	name = "multiphase lens"
	weapon_type = GUN_SMG
	initial_charge = 10000
	max_shots = 20
	fire_delay = 1
	ammo_indicator_state = "laser_smg_loaded"
	firemodes = list(
		list(mode_name="stun",                  caliber = /decl/weapon_caliber/laser/shock, requires_two_hands = 0),
		list(mode_name="stun 3-round bursts",   caliber = /decl/weapon_caliber/laser/shock, burst=3, requires_two_hands = 0, fire_delay = null, move_delay = 4, burst_accuracy=list(0,-1,-1), dispersion=list(0.0, 0.6, 1.0)),
		list(mode_name="lethal",                caliber = /decl/weapon_caliber/laser, requires_two_hands = 0),
		list(mode_name="lethal 3-round bursts", caliber = /decl/weapon_caliber/laser, requires_two_hands = 0, burst=3, fire_delay = null, move_delay = 4, burst_accuracy=list(0,-1,-1), dispersion=list(0.0, 0.6, 1.0)),
		)
	design_caliber = /decl/weapon_caliber/laser/xray
