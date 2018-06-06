// Predefines.
/obj/item/ammo_casing/gyrojet
	name = "microrocket"
	caliber = /decl/weapon_caliber/gyrojet
	icon_state = "gyro"
	spent_icon = "gyro-spent"
	matter = list(MATERIAL_STEEL = 500)
	var/detonation_range_dev =  -1
	var/detonation_range_heavy = 0
	var/detonation_range_light = 2
	var/detonation_range_flash = 3

/obj/item/ammo_casing/gyrojet/rocket
	name = "explosive charge"
	icon_state = "rocket"
	spent_icon = "rocket-spent"
	matter = list(MATERIAL_STEEL = 1000)
	caliber = /decl/weapon_caliber/rocket
	detonation_range_dev =   1
	detonation_range_heavy = 2
	detonation_range_light = 4
	detonation_range_flash = 5

/obj/item/ammo_casing/gyrojet/ex_act()
	if(projectile) projectile.ex_act()
	..()

/obj/item/ammo_casing/gyrojet/New()
	..()
	var/obj/item/projectile/bullet/gyro/G = projectile
	if(istype(G))
		G.detonation_range_dev =   detonation_range_dev
		G.detonation_range_heavy = detonation_range_heavy
		G.detonation_range_light = detonation_range_light
		G.detonation_range_flash = detonation_range_flash