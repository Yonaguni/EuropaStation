/obj/item/gun_component/accessory/body/scope
	name = "scope"
	icon_state = "scope"
	weight_mod = 2
	fire_rate_mod = 1
	accuracy_mod = 3

/obj/item/gun_component/accessory/body/scope/apply_mod(var/obj/item/gun/composite/gun)
	..()
	gun.verbs |= /obj/item/gun/composite/proc/scope