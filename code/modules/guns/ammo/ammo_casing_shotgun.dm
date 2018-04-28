/obj/item/ammo_casing/shotgun
	name = "shotgun cartridge"
	caliber = /decl/weapon_caliber/shotgun
	icon_state = "shotgun"
	matter = list(MATERIAL_STEEL = 100, MATERIAL_PLASTIC = 20)

/obj/item/ammo_casing/shotgun/beanbag
	icon_state = "gshell"
	special_projectile_type = /obj/item/projectile/bullet/shotgun/beanbag
	matter = list(MATERIAL_STEEL = 10, MATERIAL_PLASTIC = 100)

/obj/item/ammo_casing/shotgun/pellet
	icon_state = "rshell"
	special_projectile_type = /obj/item/projectile/bullet/pellet/shotgun
	matter = list(MATERIAL_STEEL = 50, MATERIAL_PLASTIC = 50)
