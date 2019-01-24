/datum/random_map/noise/seafloor
	descriptor = "seafloor (roundstart)"
	smoothing_iterations = 3
	target_turf_type = /turf/simulated/ocean

/datum/random_map/noise/seafloor/abyss
	descriptor = "abyss floor (roundstart)"

/datum/random_map/noise/seafloor/replace_space
	descriptor = "seafloor (replace space)"
	target_turf_type = /turf/space

/datum/random_map/noise/seafloor/replace_space/get_appropriate_path(var/value)
	return /turf/simulated/ocean

/datum/random_map/noise/seafloor/get_appropriate_path(var/value)
	return

/datum/random_map/noise/seafloor/get_additional_spawns(var/value, var/turf/T)
	var/val = min(9,max(0,round((value/cell_range)*10)))
	if(isnull(val)) val = 0
	switch(val)
		if(3,4)
			if(prob(60))
				new /obj/structure/flora/seaweed(T)
		if(5)
			if(prob(70))
				new /obj/structure/flora/seaweed(T)
			else if(prob(60))
				new /obj/structure/flora/seaweed/large(T)
			else if(prob(10))
				new /obj/structure/flora/seaweed/glow(T)
		if(6)
			if(prob(60))
				new /obj/structure/flora/seaweed(T)
			else if(prob(30))
				new /obj/structure/flora/seaweed/large(T)
			else if (prob(5))
				new /obj/structure/flora/seaweed/glow(T)
		if(7,9)
			if(prob(85))
				new /obj/structure/flora/seaweed/large(T)
			else if(prob(1))
				new /obj/structure/flora/seaweed/glow(T)

	var/turf/simulated/ocean/O = T
	if(istype(O))
		switch(val)
			if(6)
				O.icon_state = "mud_light"
				//O.blend_with_neighbors = 2
			if(7 to 9)
				O.icon_state = "mud_dark"
				//O.blend_with_neighbors = 3

/datum/random_map/noise/seafloor/abyss
	target_turf_type = /turf/simulated/ocean/abyss

/datum/random_map/noise/seafloor/abyss/get_additional_spawns(var/value, var/turf/T)
	var/val = min(9,max(0,round((value/cell_range)*10)))
	if(isnull(val)) val = 0
	switch(val)
		if(5)
			if(prob(30))
				new /obj/structure/flora/seaweed(T)
			else if(prob(20))
				new /obj/structure/flora/seaweed/large(T)
		if(6)
			if(prob(10))
				new /obj/structure/flora/seaweed(T)
			else if(prob(5))
				new /obj/structure/flora/seaweed/large(T)
		if(7,9)
			if(prob(5))
				new /obj/structure/flora/seaweed/large(T)