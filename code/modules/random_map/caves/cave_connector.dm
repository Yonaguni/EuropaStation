// Midpoint displacement algorithm based on a lightning generator.
// DOES NOT WORK CURRENTLY.
/proc/build_cave_tunnel(var/ox, var/oy, var/tx, var/ty, var/tz, var/displacement = 50, var/detail_level = 15, var/base_thickness = 2, var/rand_thickness = 3)

	// If we have hit this point the recursion has ended; draw the line segment.
	if(displacement < detail_level)
		var/turf/origin = locate(ox, oy, tz)
		var/turf/target = locate(ox, oy, tz)
		var/turf/current = origin
		if(!istype(origin) || !istype(target))
			return
		while(current != target)
			for(var/turf/simulated/mineral/M in orange(current, base_thickness + rand(rand_thickness)))
				M.make_floor()
			current = get_step(current,target)
		return

	// Continue recursively breaking the line into segments.
	var/midx = round((tx+ox)/2) + (displacement * rand(-0.5,0.5))
	var/midy = round((ty+oy)/2) + (displacement * rand(-0.5,0.5))
	build_cave_tunnel(ox,oy,midx,midy,round(displacement/2))
	build_cave_tunnel(tx,ty,midx,midy,round(displacement/2))