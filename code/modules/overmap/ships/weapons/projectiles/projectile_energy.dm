/obj/item/projectile/ship_munition/energy
	name = "maser burst"
	icon_state = "emitter"
	fire_sound = 'sound/weapons/emitter.ogg'
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	damage_type = BURN
	check_armour = "laser"
	hitscan = 1
	damage = 500 // pew
	penetrating = 10
	kill_count = 256
	invisibility = 101

	muzzle_type = /obj/effect/projectile/emitter/muzzle
	tracer_type = /obj/effect/projectile/emitter/tracer
	impact_type = /obj/effect/projectile/emitter/impact