/datum/random_map/automata/underwater_caves
	descriptor =        "underwater caves"
	target_turf_type =  /turf/unsimulated/mask
	wall_type =         /turf/simulated/mineral/flooded
	floor_type =        /turf/simulated/ocean/abyss
	iterations = 4

// Sharks are placeholders for better, more interesting mobs.
/datum/random_map/automata/underwater_caves/apply_to_map()

	. = ..()

	// Work out where we can place shit.
	var/list/clear_turfs = list()
	for (var/x = origin_x to limit_x)
		for (var/y = origin_y to limit_y)
			var/turf/T = locate(x, y, origin_z)
			if(T && istype(T, floor_type))
				clear_turfs += T

	if(clear_turfs.len)

		// Place phat loot.
		for(var/i = 1 to rand(100, 150))
			if(!clear_turfs.len) break
			var/turf/T = pick_n_take(clear_turfs)
			var/scrap_type = pick(/obj/structure/scrap, /obj/structure/scrap/vehicle, /obj/structure/scrap/ore)
			new scrap_type(T)
		for(var/i = 1 to rand(25, 40))
			if(!clear_turfs.len) break
			var/turf/T = pick_n_take(clear_turfs)
			switch(rand(1,10))
				if(1 to 6)
					new /obj/structure/scrap/large(T)
				if(7 to 9)
					new /obj/structure/scrap/large/fancy(T)
				if(10)
					new /obj/structure/scrap/large/anomalous(T)

		// Place SHARK WEEK.
		var/shark_week = rand(10,20)
		while(shark_week && clear_turfs.len)
			var/turf/T = pick_n_take(clear_turfs)
			if(T && !length(T.contents))
				if(shark_week != 1)
					new /mob/living/simple_animal/hostile/aquatic/shark(T)
				else
					new /mob/living/simple_animal/hostile/aquatic/shark/huge(T)
				shark_week--