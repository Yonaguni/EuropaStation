/datum/random_map/noise/seafloor
	descriptor = "Europan seafloor (roundstart)"
	smoothing_iterations = 3
	target_turf_type = /turf/unsimulated/ocean

/datum/random_map/noise/seafloor/get_appropriate_path(var/value)
	return

/datum/random_map/noise/seafloor/get_additional_spawns(var/value, var/turf/T)
	var/val = min(9,max(0,round((value/cell_range)*10)))
	if(isnull(val)) val = 0
	switch(val)
		if(3,4)
			if(prob(60))
				new /obj/structure/seaweed(T)
		if(5)
			if(prob(60))
				new /obj/structure/seaweed(T)
			else if(prob(30))
				new /obj/structure/seaweed/large(T)
			else
				new /obj/structure/seaweed/glow(T)
		if(6)
			if(prob(60))
				new /obj/structure/seaweed/glow(T)
			else if(prob(30))
				new /obj/structure/seaweed(T)
			else
				new /obj/structure/seaweed/large(T)
		if(7,9)
			if(prob(70))
				new /obj/structure/seaweed/large(T)
			else
				new /obj/structure/seaweed/glow(T)
			if(prob(1))
				new /mob/living/simple_animal/hostile/retaliate/europa_shark(T)

	var/turf/unsimulated/ocean/O = T
	if(istype(O))
		switch(val)
			if(6)
				O.icon_state = "mud_light"
				O.blend_with_neighbors = 2
			if(7 to 9)
				O.icon_state = "mud_dark"
				O.blend_with_neighbors = 3
