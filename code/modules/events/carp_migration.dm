/datum/event/critter_migration
	announceWhen	= 50
	endWhen 		= 900

	var/list/pick_critters = list(/mob/living/simple_animal/hostile/carp)
	var/list/spawned_critters = list()

/datum/event/critter_migration/setup()
	announceWhen = rand(40, 60)
	endWhen = rand(600,1200)

/datum/event/critter_migration/announce()
	var/announcement = ""
	if(severity == EVENT_LEVEL_MAJOR)
		announcement = "Unexpectedly massive migration of local fauna has been observed via satellite near [station_name()]."
	else
		announcement = "Seasonal migration of local fauna has been observed via satellite near [station_name()]."
	command_announcement.Announce(announcement, "Lifesign Alert")

/datum/event/critter_migration/start()
	if(severity == EVENT_LEVEL_MAJOR)
		spawn_critters(rand(20,30))
	else if(severity == EVENT_LEVEL_MODERATE)
		spawn_critters(rand(4, 6)) 			//12 to 30 carp, in small groups
	else
		spawn_critters(rand(1, 3), 1, 2)	//1 to 6 carp, alone or in pairs

/datum/event/critter_migration/proc/spawn_critters(var/num_groups, var/group_size_min=3, var/group_size_max=5)
	var/list/spawn_locations = list()

	for(var/obj/effect/landmark/C in landmarks_list)
		if(C.name == "carpspawn")
			spawn_locations.Add(C.loc)
	spawn_locations = shuffle(spawn_locations)
	num_groups = min(num_groups, spawn_locations.len)
	var/spawn_type = pick(pick_critters)

	var/i = 1
	while (i <= num_groups)
		var/group_size = rand(group_size_min, group_size_max)
		for (var/j = 1, j <= group_size, j++)
			spawned_critters += new spawn_type(spawn_locations[i])
		i++

/datum/event/critter_migration/end()
	for(var/mob/living/C in spawned_critters)
		if(!C.stat)
			var/turf/T = get_turf(C)
			if(istype(T, /turf/space))
				qdel(C)
