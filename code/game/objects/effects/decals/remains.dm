/obj/item/remains
	name = "remains"
	gender = PLURAL
	icon = 'icons/effects/remains.dmi'
	icon_state = "remains"
	anchored = 0

/obj/item/remains/human
	desc = "They look like human remains. They have a strange aura about them."

/obj/item/remains/mouse
	desc = "They look like the remains of a small rodent."
	icon_state = "mouse"

/obj/item/remains/attack_hand(mob/user as mob)
	user << "<span class='notice'>[src] sinks together into a pile of ash.</span>"
	var/turf/simulated/floor/F = get_turf(src)
	if (istype(F))
		new /obj/effect/decal/cleanable/ash(F)
	qdel(src)

/obj/item/remains/robot/attack_hand(mob/user as mob)
	return
