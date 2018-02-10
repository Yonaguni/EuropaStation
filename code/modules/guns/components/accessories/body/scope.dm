/obj/item/gun_component/accessory/body/scope
	name = "scope"
	icon_state = "scope"
	weight_mod = 2
	fire_rate_mod = 1
	accuracy_mod = 3
	has_alt_interaction = TRUE

/obj/item/gun_component/accessory/body/scope/apply_mod(var/obj/item/gun/composite/gun)
	..()
	gun.verbs |= /obj/item/gun/composite/proc/scope

/obj/item/gun_component/accessory/body/scope/removed_from(var/obj/item/gun, var/mob/user)
	. = ..()
	gun.verbs -= /obj/item/gun/composite/proc/scope

/obj/item/gun_component/accessory/body/scope/do_user_alt_interaction(var/mob/user)
	holder.scope(user)
	return 1
