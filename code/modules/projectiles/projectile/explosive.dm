/obj/item/projectile/bullet/gyro
	name ="explosive bolt"
	icon_state= "bolter"
	damage = 30
	check_armour = "bullet"
	sharp = 1
	edge = 1
	var/detonation_range_dev =   -1
	var/detonation_range_heavy = -1
	var/detonation_range_light = -1
	var/detonation_range_flash = -1

/obj/item/projectile/bullet/gyro/New()
	..()

/obj/item/projectile/bullet/gyro/on_hit(var/atom/target, var/blocked = 0)
	explosion(get_turf(src), detonation_range_dev, detonation_range_heavy, detonation_range_light, detonation_range_flash)
	return 1

/obj/item/projectile/bullet/gyro/rocket
	name = "rocket"
	icon_state = "rocket"
	damage = 200
