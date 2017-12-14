/atom/proc/CanFluidPass(var/coming_from)
	return 1

/turf/var/fluid_can_pass
/turf/CanFluidPass(var/coming_from)
	if(density)
		return 0
	if(isnull(fluid_can_pass))
		fluid_can_pass = 1
		for(var/atom/movable/AM in src)
			if(AM.simulated && !AM.CanFluidPass(coming_from))
				fluid_can_pass = 0
				break
	return fluid_can_pass

/obj/structure/inflatable/CanFluidPass(var/coming_from)
	return !density

/obj/structure/window/CanFluidPass(var/coming_from)
	return (!is_full_window() && coming_from != dir)

/obj/machinery/door/CanFluidPass(var/coming_from)
	return !density

/obj/machinery/door/window/CanFluidPass(var/coming_from)
	return ((dir in cardinal) && coming_from != dir)

/atom/movable/proc/is_fluid_pushable(var/amt)
	return simulated && !anchored

/obj/is_fluid_pushable(var/amt)
	return ..() && w_class <= round(amt/20)

/mob/is_fluid_pushable(var/amt)

	if(!lying && Check_Shoegrip())
		return FALSE

	. = ..()

	if(!lying && (amt >= mob_size*2) && slip_chance(amt/100))
		to_chat(src, "<span class='danger'>You are pushed down by the flood!</span>")
		Weaken(1)
		return TRUE

	return ..() && amt >= (lying ? mob_size : mob_size*2)
