/mob/proc/do_maneuvering_check(var/dir)
	return 0

/mob/dead/do_maneuvering_check(var/dir)
	return 1

/mob/verb/moveup()
	set name = "Move Upwards"
	set category = "IC"

	var/turf/above = GetAbove(src)
	if(!istype(above))
		usr << "<span class='notice'>There is nothing of interest in that direction.</span>"
		return

	if(!do_maneuvering_check(UP))
		return

	if(!istype(src, /mob/dead))
		if(!istype(above, /turf/space) && !istype(above, /turf/simulated/open))
			usr << "<span class='warning'>You bump against the roof.</span>"
			return
		for(var/atom/A in above)
			if(A.density)
				usr << "<span class='warning'>You cannot move that way; \the [A] blocks you.</span>"
				return

	usr.Move(above)
	return 1

/mob/verb/movedown()
	set name = "Move Downwards"
	set category = "IC"

	if(!do_maneuvering_check(DOWN))
		return

	var/turf/below = GetBelow(src)
	if(!istype(below))
		usr << "<span class='notice'>There is nothing of interest in that direction.</span>"
		return

	if(!istype(src, /mob/dead))
		if(!istype(loc, /turf/simulated/open))
			usr << "<span class='warning'>You are prevented from moving downwards by \the [loc].</span>"
			return
		if(below.density)
			usr << "<span class='warning'>You are prevented from moving downwards by \the [below].</span>"
			return
		for(var/atom/A in below)
			if(A.density)
				usr << "<span class='warning'>You cannot move that way; \the [A] blocks you.</span>"
				return

	usr.Move(below)
	return 1
