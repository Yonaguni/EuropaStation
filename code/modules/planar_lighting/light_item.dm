/obj/item/equipped(var/mob/user, var/slot)
	. = ..(user, slot)
	if(istype(loc, /turf))
		plane = initial(plane)
	else
		plane = GUI_PLANE

/obj/item/dropped(var/mob/user)
	. = ..(user)
	if(istype(loc, /turf))
		plane = initial(plane)
	else
		plane = GUI_PLANE
