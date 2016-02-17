/obj/screen
	plane = GUI_PLANE // Needs to render over the top of darkness.

// PLEASE GOD STOP LAYERING OVER THE DARKNESS.
/obj/item/initialize()
	. = ..()
	spawn(1)
		if(istype(loc, /turf))
			plane = 0
		else
			plane = GUI_PLANE

/obj/item/equipped()
	. = ..()
	spawn(1)
		if(istype(loc, /turf))
			plane = 0
		else
			plane = GUI_PLANE

/obj/item/dropped()
	. = ..()
	spawn(1)
		if(istype(loc, /turf))
			plane = 0
		else
			plane = GUI_PLANE

/obj/item/Move()
	. = ..()
	spawn(1)
		if(istype(loc, /turf))
			plane = 0
		else
			plane = GUI_PLANE

/obj/item/forceMove()
	. = ..()
	spawn(1)
		if(istype(loc, /turf))
			plane = 0
		else
			plane = GUI_PLANE
