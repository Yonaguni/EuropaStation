// If you add a more comprehensive system, just untick this file.
var/z_levels = 0

// If the height is more than 1, we mark all contained levels as connected.
/obj/effect/landmark/map_data/New()
	..()

	for(var/i = (z - height) to (z - 2))
		global.z_levels |= (1 << i)

/obj/effect/landmark/map_data/Initialize()
	..()
	return INITIALIZE_HINT_QDEL

/proc/HasAbove(var/z)
	return HAS_ABOVE(z)

/proc/HasBelow(var/z)
	return HAS_BELOW(z)

// Thankfully, no bitwise magic is needed here.
/proc/GetAbove(var/atom/atom)
	var/turf/turf = get_turf(atom)
	if(!turf)
		return null
	return GET_ABOVE(atom)

/proc/GetBelow(var/atom/atom)
	var/turf/turf = get_turf(atom)
	if(!turf)
		return null
	return GET_BELOW(atom)

/proc/GetConnectedZlevels(z)
	. = list(z)
	for(var/level = z, HasBelow(level), level--)
		. |= level-1
	for(var/level = z, HasAbove(level), level++)
		. |= level+1

/proc/AreConnectedZLevels(var/zA, var/zB)
	return zA == zB || (zB in GetConnectedZlevels(zA))

/proc/get_zstep(ref, dir)
	if(dir == UP)
		. = GetAbove(ref)
	else if (dir == DOWN)
		. = GetBelow(ref)
	else
		. = get_step(ref, dir)