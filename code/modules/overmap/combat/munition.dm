/obj/effect/overmap_munition
	name = "munition"
	icon = 'icons/obj/overmap.dmi'
	icon_state = "munition"
	color = "#6666FF"
	var/obj/effect/overmap/ship/fired_by
	var/fired_at
	var/proj_type

/obj/effect/overmap_munition/Destroy()
	fired_by = null
	walk(src, 0)
	. = ..()

/obj/effect/overmap_munition/New(var/newloc, var/obj/item/projectile/ship_munition/proj)
	..(newloc)
	name = proj.name
	proj_type = proj.type

/obj/effect/overmap_munition/Move()
	. = ..()

	if(.)
		var/list/possible_targets = list()
		for(var/obj/effect/overmap/thing in loc)
			possible_targets += thing
		for(var/obj/effect/overmap_event/thing in loc)
			possible_targets += thing
		for(var/obj/effect/overmap_munition/thing in loc)
			possible_targets += thing
		possible_targets -= src
		if(possible_targets.len)
			var/hit = pick(possible_targets)
			if(istype(hit, /obj/effect/overmap))

				var/min_edge_dist = 1 + TRANSITIONEDGE
				var/max_x_dist = world.maxx - TRANSITIONEDGE
				var/max_y_dist = world.maxy - TRANSITIONEDGE

				var/obj/effect/overmap/ship = hit
				var/turf/target = ship.get_overmap_munition_target(src)
				world << "hitting [target] with [src] ([proj_type])"
				var/turf/arriving_from
				switch(turn(ship.get_fore_dir(), dir2angle(ship.dir)-dir2angle(dir)))

					if(NORTH)
						arriving_from = locate(rand(min_edge_dist, max_x_dist), max_y_dist, target.z)

					if(SOUTH)
						arriving_from = locate(rand(min_edge_dist, max_x_dist), min_edge_dist, target.z)

					if(EAST)
						arriving_from = locate(max_x_dist, rand(min_edge_dist, max_y_dist), target.z)

					if(WEST)
						arriving_from = locate(min_edge_dist, rand(min_edge_dist, max_y_dist), target.z)

					if(NORTHEAST)
						var/tx = max_x_dist
						var/ty = max_y_dist
						if(prob(50))
							ty = rand(round(world.maxy/2), max_y_dist)
						else
							tx = rand(round(world.maxx/2), max_x_dist)
						arriving_from = locate(tx, ty, target.z)

					if(SOUTHEAST)
						var/tx = max_x_dist
						var/ty = min_edge_dist
						if(prob(50))
							ty = rand(min_edge_dist, round(world.maxy/2))
						else
							tx = rand(round(world.maxx/2), max_x_dist)
						arriving_from = locate(tx, ty, target.z)

					if(NORTHWEST)
						var/tx = min_edge_dist
						var/ty = max_y_dist
						if(prob(50))
							ty = rand(round(world.maxy/2), max_y_dist)
						else
							tx = rand(min_edge_dist, round(world.maxx/2))
						arriving_from = locate(tx, ty, target.z)

					if(SOUTHWEST)
						var/tx = min_edge_dist
						var/ty = min_edge_dist
						if(prob(50))
							ty = rand(min_edge_dist, round(world.maxy/2))
						else
							tx = rand(min_edge_dist, round(world.maxx/2))
						arriving_from = locate(tx, ty, target.z)

					else
						world << "???"

				if(arriving_from)
					world << "firing from [arriving_from] ([arriving_from.x], [arriving_from.y]. [arriving_from.z])"
					var/obj/item/projectile/firing = new proj_type(arriving_from)
					firing.launch(target)
				else
					world << "couldn't find target turf"

				qdel(src)

			else if(istype(hit, /obj/effect/overmap_munition))
				qdel(hit)
				qdel(src)

			//else if(istype(hit, /obj/effect/overmap/sector))
			//else if(istype(hit, /obj/effect/overmap_event))
	else
		qdel(src)