/obj/landmark/animal_spawn
	name = "dummy animal spawner"
	var/animal_type
	var/spawn_prob = 100
	var/min_spawn_amt = 1
	var/max_spawn_amt = 1

/obj/landmark/animal_spawn/initialize()
	if(animal_type)
		var/turf/T = get_turf(src)
		if(istype(T) && prob(spawn_prob))
			var/amt = rand(min_spawn_amt, max_spawn_amt)
			for(var/i = 1;i<=amt;i++)
				new animal_type(T)
	qdel(src)

/obj/landmark/animal_spawn/deer
	name = "deer spawner"
	animal_type = /mob/living/animal/deer

/obj/landmark/animal_spawn/carp
	name = "carp spawner"
	animal_type = /mob/living/animal/aquatic/carp
	min_spawn_amt = 2
	max_spawn_amt = 3

/obj/landmark/animal_spawn/shark
	name = "shark spawner"
	animal_type = /mob/living/animal/aquatic/shark

/obj/landmark/animal_spawn/fish
	name = "fish spawner"
	animal_type = /mob/living/animal/aquatic/random
	min_spawn_amt = 4
	max_spawn_amt = 6