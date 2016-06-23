// While this is not a port of TheWelp's work for Bay, thanks are owed to him
// for reminding me to make a start on a proper dungeon generator and showing
// that it's feasible in BYOND. ~Z

// Small holder for large region origin points, used for drawing passages.
/datum/tmp_node
	var/nx
	var/ny

/datum/tmp_node_group
	var/datum/tmp_node/fnode
	var/datum/tmp_node/lnode

/datum/tmp_node/New(var/_x, var/_y)
	nx = _x
	ny = _y

// Holder for the small segmented areas of the map.
/datum/tmp_room
	var/global/gident = 0
	var/ident
	var/ox
	var/oy
	var/lx
	var/ly

/datum/tmp_room/New(var/_ox, var/_oy, var/_lx, var/_ly, var/minroomvar=0, var/maxroomvar=1)
	gident++
	ident = gident
	var/xvariance = Floor(rand(minroomvar, maxroomvar)/2)
	var/yvariance = Floor(rand(minroomvar, maxroomvar)/2)
	ox = _ox+xvariance
	oy = _oy+yvariance
	lx = _lx-xvariance
	ly = _ly-yvariance

/datum/tmp_room/proc/generate_on(var/list/map, var/limit_x, var/limit_y)
	for(var/tx = ox to lx)
		for(var/ty = oy to ly)
			var/curcell = GET_MAP_CELL(tx,ty)
			map[curcell] = FLOOR_CHAR

/datum/random_map/structure
	descriptor = "structure"
	floor_type = /turf/simulated/floor/tiled

	// Various behavioral stuff.
	var/skip_room_prob = 35
	var/draw_walls = 1

	// Generator limits.
	var/min_split_x
	var/min_split_y
	var/min_room_x = 12
	var/min_room_y = 12
	var/min_room_size_variance = 5
	var/max_room_size_variance = 10

	// Holder/tracker lists for generating the map geometry.
	var/list/rooms = list()
	var/list/node_groups = list()

/datum/random_map/structure/overlay
	descriptor = "structure (no walls)"
	draw_walls = 0

/datum/random_map/structure/New()
	min_split_x = (min_room_x*2)+1
	min_split_y = (min_room_y*2)+1
	. = ..()
	return

/datum/random_map/structure/seed_map()
	for(var/x = 1 to limit_x)
		for(var/y = 1 to limit_y)
			var/current_cell = GET_MAP_CELL(x,y)
			map[current_cell] = EMPTY_CHAR

/datum/random_map/structure/generate_map()
	recursive_split_map(1,1,limit_x,limit_y)

	// Draw the rooms.
	for(var/datum/tmp_room/room in rooms)
		if(!prob(skip_room_prob))
			room.generate_on(map, limit_x, limit_y)

	// Connect the nodes with passages.
	for(var/datum/tmp_node_group/node_group in node_groups)

		var/use_x = node_group.fnode.nx
		var/use_y = node_group.fnode.ny

		var/wide_hallway = prob(25)
		while((use_x != node_group.lnode.nx) || (use_y != node_group.lnode.ny))

			if(wide_hallway)
				for(var/tx = use_x to use_x+1)
					for(var/ty = use_y to use_y+1)
						var/curcell = GET_MAP_CELL(tx, ty)
						if(curcell && map[curcell] == EMPTY_CHAR)
							map[curcell] = FLOOR_CHAR
			else
				var/curcell = GET_MAP_CELL(use_x, use_y)
				if(curcell && map[curcell] == EMPTY_CHAR)
					map[curcell] = FLOOR_CHAR

			if(use_x < node_group.lnode.nx)
				use_x++
			else if(use_x > node_group.lnode.nx)
				use_x--
			else if(use_y < node_group.lnode.ny)
				use_y++
			else if(use_y > node_group.lnode.ny)
				use_y--

	// Wall off the generated structures.
	if(draw_walls)
		for(var/tx = 1 to limit_x)
			for(var/ty = 1 to limit_y)
				var/curcell = GET_MAP_CELL(tx,ty)
				if(curcell && map[curcell] == FLOOR_CHAR)
					for(var/nx=tx-1 to tx+1)
						for(var/ny=ty-1 to ty+1)
							var/ncell = GET_MAP_CELL(nx,ny)
							if(ncell && map[ncell] == EMPTY_CHAR)
								map[ncell] = WALL_CHAR
	return 1

/datum/random_map/structure/check_map_sanity()
	return 1

/datum/random_map/structure/proc/recursive_split_map(var/xone, var/yone, var/xtwo, var/ytwo)
	var/can_split_x = ((xtwo-xone) >= min_split_x)
	var/can_split_y = ((ytwo-yone) >= min_split_x)
	var/datum/tmp_node/node = new(xone + Floor((xtwo-xone)/2), yone + Floor((ytwo-yone)/2))
	if(!can_split_x && !can_split_y)
		rooms += new /datum/tmp_room(xone, yone, xtwo, ytwo, min_room_size_variance, max_room_size_variance)
	else
		if(can_split_x && can_split_y)
			if(prob(50))
				can_split_x = 0
			else
				can_split_y = 0
		var/datum/tmp_node_group/nodes = new()
		if(can_split_x)
			var/splitpoint = rand(xone+min_room_x,xtwo-min_room_x)
			nodes.fnode = recursive_split_map(xone,yone,splitpoint,ytwo)
			nodes.lnode = recursive_split_map(splitpoint,yone,xtwo,ytwo)
		else
			var/splitpoint = rand(yone+min_room_y,ytwo-min_room_y)
			nodes.fnode = recursive_split_map(xone,yone,xtwo,splitpoint)
			nodes.lnode = recursive_split_map(xone,splitpoint,xtwo,ytwo)
		node_groups += nodes
	return node
