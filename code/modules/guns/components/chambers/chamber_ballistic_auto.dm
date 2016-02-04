/obj/item/gun_component/chamber/ballistic/smg
	name = "autoloader"
	automatic = 1
	weapon_type = GUN_SMG
	load_method = MAGAZINE|SPEEDLOADER
	max_shots = 22
	ammo_indicator_state = "ballistic_smg_loaded"
	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0,    move_delay=null, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, move_delay=5,    burst_accuracy=list(0,-1,-1),       dispersion=list(0.0, 0.6, 1.0))
		)

/obj/item/gun_component/chamber/ballistic/assault
	name = "autoloader"
	automatic = 1
	weapon_type = GUN_ASSAULT
	load_method = MAGAZINE
	max_shots = 22
	ammo_indicator_state = "ballistic_assault_loaded"
	auto_eject_sound = 'sound/weapons/smg_empty_alarm.ogg'
	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0,    move_delay=null, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, move_delay=5,    burst_accuracy=list(0,-1,-1), dispersion=list(0.0, 0.6, 1.0))
		)

/obj/item/gun_component/chamber/ballistic/autocannon
	weapon_type = GUN_CANNON
	automatic = 1
	max_shots = 20
	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0,    move_delay=null, burst_accuracy=null, dispersion=null),
		list(mode_name="3-round bursts", burst=3, fire_delay=null, move_delay=5,    burst_accuracy=list(0,-1,-1),       dispersion=list(0.0, 0.6, 1.0))
		)
