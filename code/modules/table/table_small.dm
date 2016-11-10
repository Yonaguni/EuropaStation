/obj/structure/table/small
	name = "small table"
	desc = "Good to rest your coffee on."
	icon = 'icons/obj/objects.dmi'
	icon_state = "table_small"
	can_plate = 0
	can_reinforce = 0
	flipped = -1

/obj/structure/table/small/New()
	..()
	verbs -= /obj/structure/table/verb/do_flip
	verbs -= /obj/structure/table/proc/do_put

/obj/structure/table/small/update_connections()
	return

/obj/structure/table/small/update_desc()
	return

/obj/structure/table/small/update_icon()
	return

/obj/structure/table/small/cloth
	desc = "It has one of those weird lacy cloth things on it."
	icon_state = "table_small_cloth"