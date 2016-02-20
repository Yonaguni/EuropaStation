/obj/screen
	plane = GUI_PLANE // Needs to render over the top of darkness.

/obj/item/New()
	. = ..()
	update_plane()

/obj/item/Move()
	. = ..()
	update_plane()

/obj/item/forceMove()
	. = ..()
	update_plane()

/obj/item/proc/update_plane()
	if(istype(loc, /turf))
		plane = MASTER_PLANE
	else
		plane = GUI_PLANE
	return

/obj/item/weapon/gun/composite/update_plane()
	..()
	for(var/obj/item/I in src)
		I.plane = plane
	for(var/image/I in overlays)
		I.plane = plane
