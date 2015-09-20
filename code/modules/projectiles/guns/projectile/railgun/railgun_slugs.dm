/obj/item/ammo_magazine/railgun
	name = "speedloader (osmium slug)"
	ammo_type = /obj/item/ammo_casing/railgun
	max_ammo = 12
	mag_type = SPEEDLOADER

/obj/item/ammo_magazine/railgun/large
	name = "magazine (osmium slug)"
	max_ammo = 24
	mag_type = MAGAZINE

/obj/item/ammo_magazine/railgun/shell
	name = "magazine (osmium shell)"
	ammo_type = /obj/item/ammo_casing/railgun/shell
	max_ammo = 9

/obj/item/ammo_magazine/railgun/shell/large
	name = "ammunition drum (osmium shell)"
	max_ammo = 40

/obj/item/ammo_casing/railgun
	name = "osmium slug"
	desc = "A railgun slug made of osmium."
	caliber = "railgun slug"
	projectile_type = /obj/item/projectile/bullet/railgun
	matter = list("osmium" = 1500)

/obj/item/ammo_casing/railgun/shell
	name = "osmium shell"
	desc = "A railgun shell made of osmium."
	caliber = "railgun shell"
	projectile_type = /obj/item/projectile/bullet/railgun/shell
	matter = list("osmium" = 7500)

/obj/item/projectile/bullet/railgun
	name = "railgun slug"
	damage= 50
	armor_penetration = 60
	hitscan = 1
	penetrating = 3

/obj/item/projectile/bullet/railgun/shell
	name = "railgun shell"
	armor_penetration = 80
	damage= 70
	penetrating = 5
