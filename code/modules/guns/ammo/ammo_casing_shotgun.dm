/obj/item/ammo_casing/shotgun
	name = "shotgun cartridge"
	caliber = /decl/weapon_caliber/shotgun
	icon_state = "shotgun"
	matter = list("steel" = 100, "plastic" = 20)

/obj/item/ammo_casing/shotgun/beanbag
	icon_state = "gshell"
	special_projectile_type = /obj/item/projectile/bullet/shotgun/beanbag
	matter = list("steel" = 10, "plastic" = 100)

/obj/item/ammo_casing/shotgun/pellet
	icon_state = "rshell"
	special_projectile_type = /obj/item/projectile/bullet/pellet/shotgun
	matter = list("steel" = 50, "plastic" = 50)
