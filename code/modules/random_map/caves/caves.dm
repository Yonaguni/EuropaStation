// Sort of a stopgap to stand in until the automata generator
// can be massively improved (to avoid 90s+ world start times).

/datum/cave_digger
	var/x
	var/y

/datum/cave_digger/New(var/new_x, var/new_y)
	x = new_x
	y = new_y

/datum/random_map/large_cave
	descriptor = "large cave"
	initial_wall_cell = 100

	var/digger_count = 10
	var/digger_target_percentile = 0.5
	var/smoothing_iterations = 5

/datum/random_map/large_cave/generate_map()

	// Get our target values.
	var/current_floors = 0
	var/target_amount = round(map.len * digger_target_percentile)

	// Create our diggers.
	var/list/diggers = list()
	for(var/i = 1 to digger_count)
		var/datum/cave_digger/D = new (rand(2,limit_x-1),rand(2,limit_y-1))
		diggers += D

	while(current_floors < target_amount)
		CHECK_SLEEP_MAP
		for(var/datum/cave_digger/digger in diggers)
			CHECK_SLEEP_MAP

			// Get a list of valid (walled) directions.
			var/list/can_move_dirs = list()
			var/current_cell = 0
			if(digger.x+1 < (limit_x-1))
				current_cell = GET_MAP_CELL(digger.x+1,digger.y)
				if(current_cell && map[current_cell] == WALL_CHAR)
					can_move_dirs += EAST
			if(digger.x-1 > 2)
				current_cell = GET_MAP_CELL(digger.x-1,digger.y)
				if(current_cell && map[current_cell] == WALL_CHAR)
					can_move_dirs += WEST
			if(digger.y+1 < (limit_y-1))
				current_cell = GET_MAP_CELL(digger.x,digger.y+1)
				if(current_cell && map[current_cell] == WALL_CHAR)
					can_move_dirs += NORTH
			if(digger.y-1 > 2)
				current_cell = GET_MAP_CELL(digger.x,digger.y-1)
				if(current_cell && map[current_cell] == WALL_CHAR)
					can_move_dirs += SOUTH

			// No walls? Wander randomly.
			if(!can_move_dirs.len)
				digger.x = rand(2,limit_x-1)
				digger.y = rand(2,limit_y-1)
				continue

			// Where are we moving?
			var/move_x = 0
			var/move_y = 0

			switch(pick(can_move_dirs))
				if(NORTH) move_y++
				if(SOUTH) move_y--
				if(EAST)  move_x++
				if(WEST)  move_x--
				else      continue

			// Find our next cell and dig it out.
			current_cell = GET_MAP_CELL(digger.x+move_x,digger.y+move_y)
			if(current_cell)
				digger.x += move_x
				digger.y += move_y
				if(map[current_cell] != FLOOR_CHAR)
					current_floors++
					map[current_cell] = FLOOR_CHAR

/datum/random_map/large_cave/cleanup()
	for(var/i = 1 to smoothing_iterations)
		var/changed
		for(var/x = 1 to limit_x)
			for(var/y = 1 to limit_y)
				var/current_cell = GET_MAP_CELL(x,y)
				if(!current_cell || map[current_cell] == FLOOR_CHAR)
					continue
				// Count the number of neighbors we have on the cardinals.
				var/count = 0
				current_cell = GET_MAP_CELL(x+1,y)
				if(current_cell && map[current_cell] == WALL_CHAR) count++
				current_cell = GET_MAP_CELL(x-1,y)
				if(current_cell && map[current_cell] == WALL_CHAR) count++
				current_cell = GET_MAP_CELL(x,y+1)
				if(current_cell && map[current_cell] == WALL_CHAR) count++
				current_cell = GET_MAP_CELL(x,y-1)
				if(current_cell && map[current_cell] == WALL_CHAR) count++
				if(count <= 1)
					changed = 1
					map[GET_MAP_CELL(x,y)] = FLOOR_CHAR
				else if(count > 3)
					changed = 1
					map[GET_MAP_CELL(x,y)] = WALL_CHAR

		if(!changed)
			break

/datum/random_map/large_cave/check_map_sanity()
	return 1

/datum/random_map/large_cave/get_appropriate_path(var/value)
	return

/datum/random_map/large_cave/apply_to_turf(var/x,var/y)
	var/current_cell = GET_MAP_CELL(x,y)
	if(!current_cell)
		return 0
	var/turf/simulated/mineral/T = locate((origin_x-1)+x,(origin_y-1)+y,origin_z)
	if(istype(T) && !T.ignore_mapgen)
		if(map[current_cell] == FLOOR_CHAR)
			T.make_floor()
		else
			T.make_wall()
		get_additional_spawns(map[current_cell],T,get_spawn_dir(x, y))
	return T