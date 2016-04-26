/obj/item/projectile/animate
	name = "bolt of animation"
	icon_state = "ice_1"
	damage = 0
	damage_type = BURN
	nodamage = 1
	check_armour = "energy"

/obj/item/projectile/animate/Bump(var/atom/change)
	if((istype(change, /obj/item) || istype(change, /obj/structure)) && !is_type_in_list(change, protected_objects))
		var/obj/O = change
		var/mob/living/animal/mimic/copy/C = new (get_turf(O))
		C.copy_object(O, firer)
	..()