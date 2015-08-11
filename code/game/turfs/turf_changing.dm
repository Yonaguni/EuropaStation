/turf/proc/ReplaceWithLattice()
	src.ChangeTurf(get_base_turf(src.z))
	spawn()
		new /obj/structure/lattice( locate(src.x, src.y, src.z) )

// Removes all signs of lattice on the pos of the turf -Donkieyo
/turf/proc/RemoveLattice()
	var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
	if(L)
		qdel(L)

/turf/proc/ChangeTurf(var/turf/N, var/tell_universe=1, var/force_lighting_update = 0)
	if (!N)
		return

	if(gas_overlay)
		qdel(gas_overlay)
		gas_overlay = null

///// Z-Level Stuff ///// This makes sure that turfs are not changed to space when one side is part of a zone
	if(N == /turf/space)
		var/turf/controller = locate(1, 1, src.z)
		for(var/obj/effect/landmark/zcontroller/c in controller)
			if(c.down)
				var/turf/W = src.ChangeTurf(/turf/simulated/floor/open)
				var/list/temp = list()
				temp += W
				c.add(temp,3,1) // report the new open space to the zcontroller
				return W
///// Z-Level Stuff

	//var/obj/fire/old_fire = fire
	var/old_opacity = opacity
	var/old_dynamic_lighting = dynamic_lighting
	var/list/old_affecting_lights = affecting_lights
	var/old_lighting_overlay = lighting_overlay

	Destroy()

	if(ispath(N, /turf/simulated/floor))
		var/turf/simulated/W = new N( locate(src.x, src.y, src.z) )
		/*
		if(old_fire)
			fire = old_fire
		*/
		if (istype(W,/turf/simulated/floor))
			W.RemoveLattice()

		if(tell_universe)
			universe.OnTurfChange(W)

		for(var/turf/space/S in range(W,1))
			S.update_starlight()

		W.levelupdate()
		if(air_master)
			air_master.add_to_active(W)
		. = W

	else

		var/turf/W = new N( locate(src.x, src.y, src.z) )

		if(tell_universe)
			universe.OnTurfChange(W)

		for(var/turf/space/S in range(W,1))
			S.update_starlight()

		W.levelupdate()
		. =  W

	lighting_overlay = old_lighting_overlay
	affecting_lights = old_affecting_lights
	if((old_opacity != opacity) || (dynamic_lighting != old_dynamic_lighting) || force_lighting_update)
		reconsider_lights()
	if(dynamic_lighting != old_dynamic_lighting)
		if(dynamic_lighting)
			lighting_build_overlays()
		else
			lighting_clear_overlays()