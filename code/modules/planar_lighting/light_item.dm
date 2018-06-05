/obj/screen
	plane = GUI_PLANE // Needs to render over the top of darkness.

/obj/item/Initialize()
	. = ..()
	update_plane()

/obj/item/Move()
	. = ..()
	if(.) update_plane()

/obj/item/forceMove()
	var/lastloc = loc
	. = ..()
	if(loc != lastloc)
		update_plane()

/obj/proc/update_plane()
	return

/obj/item/update_plane()
	if(istype(loc, /turf))
		plane = initial(plane)
	else
		plane = GUI_PLANE

/obj/item/gun/composite/update_plane()
	. = ..()
	for(var/obj/item/I in src)
		if(I.plane != plane)
			I.plane = plane
	update_icon(regenerate = TRUE)

/obj/item/clothing/under/update_plane()
	. = ..()
	for(var/atom/movable/thing in contents)
		thing.plane = plane
