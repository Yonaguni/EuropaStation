/obj/structure/torpedo // Physical ammo.
	name = "torpedo"
	icon_state = "torpedo"
	icon  ='icons/obj/ship_misc.dmi'
	density = 1
	anchored = 0
	var/payload_type = /obj/item/projectile/ship_munition/torpedo

/obj/item/projectile/ship_munition/torpedo
	name = "torpedo"
	icon_state = "torpedo_moving"
	icon  ='icons/obj/ship_misc.dmi'
	fire_sound = 'sound/effects/torpedo.ogg'
	penetrating = 50
	damage = 200

/obj/item/projectile/ship_munition/torpedo/on_hit(var/atom/target, var/blocked = 0)
	explosion(get_turf(target), 3, 4, 5)