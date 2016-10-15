/datum/random_map/automata/asteroids
	descriptor = "asteroids"
	initial_wall_cell = 45
	iterations = 3

	wall_type =  /turf/simulated/mineral
	floor_type = /turf/space

/datum/random_map/automata/asteroids/distant
	descriptor = "distant asteroids"
	initial_wall_cell = 15

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
		/datum/random_map/structure/ruin/alien,
		/datum/random_map/structure/ruin/spacecraft
		)
