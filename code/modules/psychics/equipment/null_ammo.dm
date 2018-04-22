/obj/item/projectile/bullet/nullglass
	name = "nullglass bullet"
	damage = 40
	remains_type = /obj/item/material/shard/nullglass

/obj/item/projectile/bullet/nullglass/disrupts_psionics()
	return TRUE

/obj/item/ammo_casing/nullglass
	caliber = /decl/weapon_caliber/pistol_357
	special_projectile_type = /obj/item/projectile/bullet/nullglass

/obj/item/ammo_magazine/speedloader/nullglass
	ammo_type = /obj/item/ammo_casing/nullglass
