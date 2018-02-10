/obj/item/projectile/energy
	name = "energy"
	icon_state = "spark"
	damage = 0
	damage_type = BURN
	check_armour = "energy"

/obj/item/projectile/energy/neurotoxin
	name = "neuro"
	icon_state = "neurotoxin"
	damage = 5
	damage_type = TOX
	weaken = 5

/obj/item/projectile/energy/ion
	name = "ion bolt"
	icon_state = "ion"
	damage = 0
	damage_type = BURN
	nodamage = 1
	check_armour = "energy"

/obj/item/projectile/energy/ion/on_hit(var/atom/target, var/blocked = 0)
	empulse(target, 1, 1)
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
