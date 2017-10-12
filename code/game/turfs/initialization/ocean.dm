/proc/apply_water_damage(var/turf/simulated/T)
	var/bordering_water
	for(var/checkdir in cardinal)
		var/turf/checking = get_step(T, checkdir)
		if(istype(checking) && checking.is_flooded())
			bordering_water = TRUE
			break
	if(!bordering_water)
		return
	if(T.density && prob(55) && !(locate(/obj/effect/cleanable/decay) in T))
		new /obj/effect/cleanable/decay/rust(T)
	for(var/turf/simulated/floor/neighbor in trange(2,T))
		if(!neighbor.density && !neighbor.is_flooded() && prob(15) && !(locate(/obj/effect/cleanable/decay) in neighbor))
			new /obj/effect/cleanable/decay/moss(neighbor)

/datum/area_initializer/ocean/initialize(var/turf/simulated/T)
	if(!T.is_flooded())
		apply_water_damage(T)

/datum/area_initializer/maintenance/ocean/initialize(var/turf/simulated/T)
	..(T)
	if(!T.is_flooded())
		apply_water_damage(T)
