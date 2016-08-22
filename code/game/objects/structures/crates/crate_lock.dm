/obj/structure/crate/proc/toggle_lock(var/mob/user)
	if(opened)
		if(user) user << "<span class='notice'>Close \the [src] first.</span>"
		return
	locked = !locked
	update_icon()

/obj/structure/crate/emp_act(severity)
	for(var/obj/O in src)
		O.emp_act(severity)

	if(can_lock)
		if(!opened)
			if(prob(50/severity))
				if(!locked)
					locked = 1
				else
					playsound(src.loc, 'sound/effects/sparks4.ogg', 75, 1)
					locked = 0
				update_icon()
			if(prob(20/severity))
				if(!locked)
					open()
				else
					src.req_access = list()
					src.req_access += pick(get_all_station_access())
	..()