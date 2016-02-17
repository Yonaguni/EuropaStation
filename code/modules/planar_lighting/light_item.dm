/obj/screen
	plane = GUI_PLANE // Needs to render over the top of darkness.

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
