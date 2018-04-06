/datum/random_map/automata/asteroids
	descriptor = "asteroids"
	initial_wall_cell = 45
	iterations = 3

	wall_type =  /turf/simulated/mineral
	floor_type = /turf/space

	var/ore_divisor = 20
	var/mineral_sparse =  /turf/simulated/mineral //random
	var/mineral_rich = /turf/simulated/mineral //random/high_chance
	var/list/ore_turfs = list()

/datum/random_map/automata/asteroids/get_map_char(var/value)
	switch(value)
		if(DOOR_CHAR)
			return "x"
		if(EMPTY_CHAR)
			return "X"
	return ..(value)

/datum/random_map/automata/asteroids/get_appropriate_path(var/value)
	switch(value)
		if(DOOR_CHAR)
			return mineral_sparse
		if(EMPTY_CHAR)
			return mineral_rich
		if(FLOOR_CHAR)
			return floor_type
		if(WALL_CHAR)
			return wall_type

/datum/random_map/automata/asteroids/get_map_char(var/value)
	switch(value)
		if(DOOR_CHAR)
			return "x"
		if(EMPTY_CHAR)
			return "X"
	return ..(value)

/datum/random_map/automata/asteroids/cleanup()
	var/ore_count = round(map.len/ore_divisor)
	while((ore_count>0) && (ore_turfs.len>0))
		var/check_cell = pick(ore_turfs)
		ore_turfs -= check_cell
		if(prob(75))
			map[check_cell] = DOOR_CHAR  // Mineral block
		else
			map[check_cell] = EMPTY_CHAR // Rare mineral block.
		ore_count--
	return 1

/datum/random_map/automata/asteroids/distant
	descriptor = "distant asteroids"
	initial_wall_cell = 15
	ore_divisor = 5

/datum/random_map/automata/asteroids/superheated
	descriptor = "sunblasted asteroids"

/datum/random_map/automata/asteroids/debris
	descriptor = "debris field"

	var/list/ruin_maps = list()
	var/list/ruin_types = list(
		/datum/random_map/structure/ruin/habitat,
		/datum/random_map/structure/ruin/industrial,
		/datum/random_map/structure/ruin/science,
		/datum/random_map/structure/ruin/spacecraft
		)

	var/min_ruins = 4
	var/max_ruins = 8
	var/min_ruin_size = 15
	var/max_ruin_size = 35

/datum/random_map/automata/asteroids/debris/generate_map()
	var/ruins = rand(min_ruins, max_ruins)
	for(var/i = 1 to ruins)
		var/ruin_type = pick(ruin_types)
		var/start_x = rand(origin_x + max_ruin_size, limit_x - max_ruin_size)
		var/start_y = rand(origin_y + max_ruin_size, limit_y - max_ruin_size)
		ruin_maps += new ruin_type(null, start_x, start_y, origin_z, rand(min_ruin_size, max_ruin_size), rand(min_ruin_size, max_ruin_size), 1, 1)
	return ..()

/datum/random_map/automata/asteroids/debris/apply_to_map()
	. = ..()
	for(var/datum/random_map/rmap in ruin_maps)
		rmap.apply_to_map()

/datum/random_map/automata/asteroids/debris/strange
	descriptor = "strange debris field"
	ruin_types = list(
		/datum/random_map/structure/ruin/monolith,
		/datum/random_map/structure/ruin/spacecraft
		)
