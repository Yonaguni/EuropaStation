/mob/proc/do_maneuvering_check(var/dir)
	if(dir == UP)
		return GetAbove(src)
	else if(dir == DOWN)
		return GetBelow(src)
	else
		src << "You cannot move in that direction from here."
	return

/mob/living/do_maneuvering_check(var/dir)

	var/failed
	var/turf/target = ..()
	var/turf/origin = loc

	// We're in a locker or something.
	if(!istype(origin))
		failed = 1
	// Nothing to move to.
	else if(!istype(target) || target.density)
		failed = 1
	else if(dir == DOWN)

		// Can't move through the floor.
		if(!origin.open_space)
			failed = 1
		else
			// Can't move through obstacles.
			for(var/atom/movable/A in target)
				if(A.density)
					failed = 1
					break
	else if(dir == UP)
		// Can't move through the roof.
		if(!target.open_space || !layer_is_shallow(target.z)) // Can't climb up enormous cliffs.
			failed = 1
		else
			var/turf/climbing_to
			// If we're swimming, we can tread water.
			if(origin.flooded)
				for(var/atom/movable/A in climbing_to)
					if(A.density)
						failed = 1
						break
			else
				// If we're not swimming, we can't just hover in midair.
				// Look for a ledge to climb onto. Check for obstacles.
				for(var/turf/T in orange(1,target))
					var/cannot_move
					for(var/atom/movable/A in T)
						if(A.density)
							cannot_move = 1
							break
					if(!cannot_move)
						climbing_to = T
						break
				if(istype(climbing_to))
					src << "You climb to \the [climbing_to]."
					target = climbing_to
				else
					failed = 1

	// Send the result back.
	if(failed)
		src << "You cannot move in that direction from here."
		return
	return target

/mob/verb/moveup()
	set name = "Move Upwards"
	set category = "IC"
	var/turf/T = do_maneuvering_check(UP)
	if(istype(T)) usr.forceMove(T)

/mob/verb/movedown()
	set name = "Move Downwards"
	set category = "IC"
	var/turf/T = do_maneuvering_check(DOWN)
	if(istype(T)) usr.forceMove(T)
