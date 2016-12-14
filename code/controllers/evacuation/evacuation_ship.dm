/datum/evacuation_controller/ship
	name = "aeolus evacuation controller"
	var/dump_z = 4

/datum/evacuation_controller/ship/launch_evacuation()
	. = ..()
	for(var/thing in block(locate(1,1,1),locate(world.maxx,world.maxy,1)))
		var/turf/space/T = thing
		if(!istype(T))
			continue
		T.icon_state = "speedspace_ns_[rand(1,15)]"
		T.fling_away = dump_z
		var/area/space/A = get_area(T)
		if(!istype(A))
			continue
		for(var/atom/movable/AM in T.contents)
			if(deleted(AM) || !AM.simulated || isghost(AM))
				continue
			AM.forceMove(locate(AM.x, AM.y, dump_z))
