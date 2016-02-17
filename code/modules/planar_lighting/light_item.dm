/obj/screen
	plane = GUI_PLANE // Needs to render over the top of darkness.

/obj/item/Move()
	. = ..()
	sleep(-1)
	if(istype(loc, /turf))
		plane = 0
	else
		plane = GUI_PLANE

/obj/item/forceMove()
	. = ..()
	sleep(-1)
	if(istype(loc, /turf))
		plane = 0
	else
		plane = GUI_PLANE
