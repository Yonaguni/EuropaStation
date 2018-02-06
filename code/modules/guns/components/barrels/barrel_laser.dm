/obj/item/gun_component/barrel/laser
	projectile_type = GUN_TYPE_LASER
	name = "projector"
	design_caliber = /decl/weapon_caliber/laser
	weight_mod = 1
	recoil_mod = 0
	accuracy_mod = 1

/obj/item/gun_component/barrel/laser/get_projectile_type()
	return design_caliber.projectile_type

/obj/item/gun_component/barrel/laser/rifle
	icon_state="las_rifle"
	weapon_type = GUN_RIFLE
	design_caliber = /decl/weapon_caliber/laser/precision
	accepts_accessories = 1
	accuracy_mod = 4

/obj/item/gun_component/barrel/laser/cannon
	icon_state="las_cannon"
	weapon_type = /decl/weapon_caliber/laser/heavy
	design_caliber = /decl/weapon_caliber/laser/heavy
