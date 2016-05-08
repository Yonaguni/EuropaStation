/mob/proc/do_maneuvering_check(var/dir)
	if(dir == UP)
		return GetAbove(src)
	else if(dir == DOWN)
		return GetBelow(src)
	else
		src << "You cannot move in that direction from here."
	return

// TODO: edge checks for diagonal up-down movement.
// TODO: offload these checks to the same place that Move() does it to cut down on boilerplate.

/mob/living/do_maneuvering_check(var/dir)

	if(stat || restrained() || incapacitated())
		return

	var/turf/target = ..()
	var/turf/origin = loc

	// We're in a locker or something.
	if(!istype(origin))
		target = null
	// Nothing to move to.
	else if(!istype(target))
		target = null
	else if(dir == DOWN)

		// Can we move through the floor?
		if(origin.open_space)
			for(var/atom/movable/A in target)
				if(A.density)
					target = null
					break
		else
			// Look for an adjacent turf to climb down through.
			target = null
			for(var/turf/T in orange(1,origin))

				if(!T.open_space)
					continue

				var/blocked
				for(var/atom/movable/A in T)
					if(A.density)
						blocked = 1
						break

				if(blocked)
					continue

				target = GetBelow(T)
				if(target)
					for(var/atom/movable/A in target)
						if(A.density)
							target = null
							break
					if(target)
						break

	else if(dir == UP)
		// Can we move through the roof?
		if(target.open_space && layer_is_shallow(target.z)) // Can't climb up enormous cliffs.
			// If we're swimming, we can tread water.
			if(origin.flooded)
				for(var/atom/movable/A in target)
					if(A.density)
						target = null
						break
			else
				// If we're not swimming, we can't just hover in midair.
				// Look for a ledge to climb onto. Check for obstacles.
				var/turf/temp = target
				target = null
				for(var/turf/T in orange(1,temp))
					if(T.open_space && !T.flooded)
						continue
					var/cannot_move
					for(var/atom/movable/A in T)
						if(A.density)
							cannot_move = 1
							break
					if(!cannot_move)
						target = T
						break

	// Send the result back.
	if(!target)
		src << "You cannot [origin.flooded ? "swim" : "climb"] in that direction from here."
		return

	src << "You [(origin.flooded || target.flooded) ? "swim" : "climb"] to \the [target]."
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
