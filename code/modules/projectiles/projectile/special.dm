/obj/item/projectile/ion
	name = "ion bolt"
	icon_state = "ion"
	damage = 0
	damage_type = BURN
	nodamage = 1
	check_armour = "energy"

/obj/item/projectile/ion/on_hit(var/atom/target, var/blocked = 0)
	empulse(target, 1, 1)
	return 1

/obj/item/projectile/bullet/gyro
	name ="explosive bolt"
	icon_state= "bolter"
	damage = 50
	check_armour = "bullet"
	sharp = 1
	edge = 1

	on_hit(var/atom/target, var/blocked = 0)
		explosion(target, -1, 0, 2)
		return 1

// Not strictly a bullet, not strictly a laser...
/obj/item/projectile/bullet/pellet/laser
	name = "laser"
	icon_state = "laser"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	damage = 16
	damage_type = BURN
	check_armour = "laser"
	eyeblur = 4
	hitscan = 1
	invisibility = 101
	muzzle_type = /obj/effect/projectile/laser/muzzle
	tracer_type = /obj/effect/projectile/laser/tracer
	impact_type = /obj/effect/projectile/laser/impact