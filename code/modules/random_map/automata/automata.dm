/datum/random_map/automata
	descriptor = "generic caves"
	initial_wall_cell = 55
	var/iterations = 0               // Number of times to apply the automata rule.
	var/cell_live_value = WALL_CHAR  // Cell is alive if it has this value.
	var/cell_dead_value = FLOOR_CHAR // As above for death.
	var/cell_threshold = 5           // Cell becomes alive with this many live neighbors.

/datum/random_map/automata/get_additional_spawns(var/value, var/turf/T)
	return

// Automata-specific procs and processing.
/datum/random_map/automata/generate_map()
	for(var/i=1 to iterations)
		var/list/next_map[limit_x*limit_y]
		for(var/x = 1 to limit_x)
			for(var/y = 1 to limit_y)
				var/current_cell = GET_MAP_CELL(x,y)
				next_map[current_cell] = map[current_cell]
				var/count = 0

				// Every attempt to place this in a proc or a list has resulted in
				// the generator being totally bricked and useless. Fuck it. We're
				// hardcoding this shit. Feel free to rewrite and PR a fix. ~ Z
				var/tmp_cell = GET_MAP_CELL(x,y)
				if(tmp_cell && ((map[tmp_cell] == cell_live_value) && (map[tmp_cell] != cell_dead_value))) count++
				tmp_cell = GET_MAP_CELL(x+1,y+1)
				if(tmp_cell && ((map[tmp_cell] == cell_live_value) && (map[tmp_cell] != cell_dead_value))) count++
				tmp_cell = GET_MAP_CELL(x-1,y-1)
				if(tmp_cell && ((map[tmp_cell] == cell_live_value) && (map[tmp_cell] != cell_dead_value))) count++
				tmp_cell = GET_MAP_CELL(x+1,y-1)
				if(tmp_cell && ((map[tmp_cell] == cell_live_value) && (map[tmp_cell] != cell_dead_value))) count++
				tmp_cell = GET_MAP_CELL(x-1,y+1)
				if(tmp_cell && ((map[tmp_cell] == cell_live_value) && (map[tmp_cell] != cell_dead_value))) count++
				tmp_cell = GET_MAP_CELL(x-1,y)
				if(tmp_cell && ((map[tmp_cell] == cell_live_value) && (map[tmp_cell] != cell_dead_value))) count++
				tmp_cell = GET_MAP_CELL(x,y-1)
				if(tmp_cell && ((map[tmp_cell] == cell_live_value) && (map[tmp_cell] != cell_dead_value))) count++
				tmp_cell = GET_MAP_CELL(x+1,y)
				if(tmp_cell && ((map[tmp_cell] == cell_live_value) && (map[tmp_cell] != cell_dead_value))) count++
				tmp_cell = GET_MAP_CELL(x,y+1)
				if(tmp_cell && ((map[tmp_cell] == cell_live_value) && (map[tmp_cell] != cell_dead_value))) count++

				if(count >= cell_threshold)
					next_map[current_cell] = cell_live_value
				else
					next_map[current_cell] = cell_dead_value

		map = next_map
