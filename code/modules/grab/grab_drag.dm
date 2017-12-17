/atom/movable/proc/can_be_dragged_by(var/mob/user)
	return (simulated && !anchored)

/obj/can_be_dragged_by(var/mob/user)
	return (..() && user.can_pull_size >= w_class)

/mob/can_be_dragged_by(var/mob/user)
	. = ..()
	if(.)
		switch(user.can_pull_mobs)
			if(MOB_PULL_NONE)
				return FALSE
			if(MOB_PULL_SMALLER)
				return user.mob_size > mob_size
			if(MOB_PULL_SAME)
				return user.mob_size >= mob_size
			if(MOB_PULL_LARGER)
				return TRUE