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

/obj/item/gun/composite/update_plane()
	var/lastplane = plane
	. = ..()
	var/f_update_icon
	for(var/obj/item/I in src)
		if(I.plane != plane)
			f_update_icon = 1
			I.plane = plane
	if(f_update_icon || plane != lastplane)
		update_icon()
