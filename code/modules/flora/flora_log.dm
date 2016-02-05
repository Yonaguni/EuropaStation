/obj/item/log
	name = "wood log"
	desc = "It's great for a snack, and fits on your back!"
	slot_flags = SLOT_BACK
	icon = 'icons/obj/objects.dmi'
	icon_state = "logs"
	w_class = 5

/obj/item/log/attackby(var/obj/item/thing, var/mob/user)
	if(istype(thing,/obj/item/weapon/material/hatchet))
		user.show_message("<span class='notice'>You make planks out of \the [src]!</span>", 1)
		new /obj/item/stack/material/wood(get_turf(src), rand(2,5))
		var/mob/M = loc
		if(istype(M))
			M.unEquip(src)
		qdel(src)
		return
	return ..()