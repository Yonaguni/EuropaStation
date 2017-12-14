/obj/screen
	plane = GUI_PLANE // Needs to render over the top of darkness.

/obj/item/New()
	. = ..()
	update_plane()

/obj/item/initialize()
	. = ..()
	update_plane()

/obj/item/Move()
	. = ..()
	update_plane()

/obj/item/forceMove()
	. = ..()
	update_plane()

/obj/proc/update_plane()
	return

/obj/item/update_plane()
	if(istype(loc, /turf))
		plane = initial(plane)
	else
		plane = GUI_PLANE

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

/obj/item/clothing/under/update_plane()
	. = ..()
	for(var/atom/movable/thing in contents)
		thing.plane = plane
	update_icon()