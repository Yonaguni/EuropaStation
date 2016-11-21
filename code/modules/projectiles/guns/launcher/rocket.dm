/obj/item/gun/launcher/rocket
	name = "rocket launcher"
	desc = "MAGGOT."
	icon_state = "rocket"
	item_state = "rocket"
	w_class = 5
	throw_speed = 2
	throw_range = 10
	force = 5.0
	flags =  CONDUCT
	slot_flags = 0

	fire_sound = 'sound/effects/bang.ogg'

	release_force = 15
	throw_distance = 30
	var/max_rockets = 1
	var/list/rockets = new/list()

/obj/item/gun/launcher/rocket/examine(mob/user)
	if(!..(user, 2))
		return
	user << "\blue [rockets.len] / [max_rockets] rockets."

/obj/item/gun/launcher/rocket/mech
	name = "mounted missile pod"
	max_rockets = 6

/obj/item/gun/launcher/rocket/mech/New()
	..()
	while(rockets.len < max_rockets)
		rockets += new /obj/item/ammo_casing/rocket(src)

/obj/item/gun/launcher/rocket/attackby(obj/item/I as obj, var/mob/user)
	if(istype(I, /obj/item/ammo_casing/rocket))
		if(rockets.len < max_rockets)
			user.drop_item()
			I.loc = src
			rockets += I
			user << "\blue You put the rocket in [src]."
			user << "\blue [rockets.len] / [max_rockets] rockets."
		else
			usr << "\red [src] cannot hold more rockets."

/obj/item/missile
	icon = 'icons/obj/grenade.dmi'
	icon_state = "missile"
	var/primed = null
	throwforce = 15

	throw_impact(atom/hit_atom)
		if(primed)
			explosion(hit_atom, 0, 1, 2, 4)
			qdel(src)
		else
			..()
		return

/obj/item/gun/launcher/rocket/consume_next_projectile()
	if(rockets.len)
		var/obj/item/ammo_casing/rocket/I = rockets[1]
		var/obj/item/missile/M = new (src)
		M.primed = 1
		rockets -= I
		return M
	return null

/obj/item/gun/launcher/rocket/handle_post_fire(atom/movable/user, atom/target)
	if(ismob(user))
		var/mob/M = user
		message_admins("[key_name_admin(M)] fired a rocket from a rocket launcher ([src.name]) at [target].")
		log_game("[key_name_admin(M)] used a rocket launcher ([src.name]) at [target].")
	..()
