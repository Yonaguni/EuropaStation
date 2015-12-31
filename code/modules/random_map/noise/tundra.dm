/datum/random_map/noise/tundra
	descriptor = "tundra"
	smoothing_iterations = 1
	target_turf_type = /turf/simulated/floor/snow

/datum/random_map/noise/tundra/get_appropriate_path(var/value)
	var/val = min(9,max(0,round((value/cell_range)*10)))
	if(isnull(val)) val = 0
	switch(val)
		if(0 to 5)
			return /turf/simulated/floor/snow/ice
		else
			return /turf/simulated/floor/snow

/datum/random_map/noise/tundra/get_additional_spawns(var/value, var/turf/T)
	var/val = min(9,max(0,round((value/cell_range)*10)))
	if(isnull(val)) val = 0
	switch(val)
		if(6)
			if(prob(60))
				var/grass_path = pick(typesof(/obj/structure/flora/grass)-/obj/structure/flora/grass)
				new grass_path(T)
		if(7)
			if(prob(60))
				new /obj/structure/flora/bush(T)
			else if(prob(30))
				new /obj/structure/flora/tree/pine(T)
			else if(prob(20))
				new /obj/structure/flora/tree/dead(T)
		if(8)
			if(prob(50))
				new /obj/structure/flora/tree/pine(T)
			else if(prob(30))
				new /obj/structure/flora/tree/dead(T)
			else
				new /obj/structure/flora/bush(T)
		if(9)
			new /obj/structure/flora/tree/pine(T)
