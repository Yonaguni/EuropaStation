// Updates whatever openspace components may be mimicing us. On turfs this queues an openturf update on the above openturf, on movables this updates their bound movable (if present). Meaningless on any type other than `/turf` or `/atom/movable` (incl. children).
/atom/proc/update_above()
	return

/turf/update_icon()
	. = ..()
	if (istype(above))
		update_above()

/atom/movable/update_icon()
	. = ..()
	UPDATE_OO_IF_PRESENT
