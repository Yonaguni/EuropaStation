/obj/structure/grille/fence
	name = "fence"
	icon = 'icons/obj/europa/structures/fence.dmi'
	icon_state = "fence"
	density = 0
	anchored = 1

/obj/structure/grille/attackby(var/obj/item/thing, var/mob/user)
	if(istype(thing, /obj/item/weapon/screwdriver))
		return
	return ..()

/obj/structure/grille/fence/gate
	name = "fence gate"
	icon_state = "fence gate"
	density = 0
