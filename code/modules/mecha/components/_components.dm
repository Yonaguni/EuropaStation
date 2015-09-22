/obj/item/mech_component
	icon = 'icons/mecha/mech_parts.dmi'
	w_class = 5
	pixel_x = -8
	gender = PLURAL

	var/brute_damage = 0
	var/burn_damage = 0
	var/max_damage = 60
	var/damage_state = 1
	var/list/has_hardpoints = list()

/obj/item/mech_component/New()
	..()
	set_dir(SOUTH)

/obj/item/mech_component/set_dir()
	..(SOUTH)

/obj/item/mech_component/proc/prebuild()
	return

/obj/item/mech_component/proc/install_component(var/obj/item/thing, var/mob/user)
	user.unEquip(thing)
	thing.forceMove(src)
	user.visible_message("<span class='notice'>\The [user] installs \the [thing] in \the [src].</span>")

/obj/item/mech_component/proc/update_health()
	var/total = brute_damage + burn_damage
	if(total > max_damage) total = max_damage
	damage_state = min(max(round((total/max_damage)*4),1),4)

/obj/item/mech_component/proc/ready_to_install()
	return 1

/obj/item/mech_component/attackby(var/obj/item/thing, var/mob/user)
	if(istype(thing, /obj/item/weapon/screwdriver))
		if(contents.len)
			var/obj/item/removed = pick(contents)
			user.visible_message("<span class='notice'>\The [user] removes \the [removed] from \the [src].</span>")
			user.put_in_hands(removed)
		else
			user << "<span class='warning'>There is nothing to remove.</span>"
		return
	return ..()