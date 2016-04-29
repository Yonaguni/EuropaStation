/obj/landmark/livestock
	name = "dummy livestock spawner"
	var/livestock_type
	var/spawn_prob = 100
	var/min_spawn_amt = 1
	var/max_spawn_amt = 1

/obj/landmark/livestock/initialize()
	if(livestock_type)
		var/turf/T = get_turf(src)
		if(istype(T) && prob(spawn_prob))
			var/amt = rand(min_spawn_amt, max_spawn_amt)
			for(var/i = 1;i<=amt;i++)
				new livestock_type(T)
	qdel(src)

/obj/landmark/livestock/deer
	name = "deer spawner"
	livestock_type = /mob/living/simple_animal/deer
