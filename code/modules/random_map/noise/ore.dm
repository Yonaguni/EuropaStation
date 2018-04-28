/datum/random_map/noise/ore
	descriptor = "ore distribution map"
	var/deep_val =     0.8
	var/rare_val =     0.4
	var/rare_ore =     20
	var/uncommon_ore = 40
	var/common_ore =   80

/datum/random_map/noise/ore/New()
	rare_val = cell_range * rare_val
	deep_val = cell_range * deep_val
	..()

/datum/random_map/noise/ore/apply_to_map()

	. = ..()

	var/list/rare_turfs =     list()
	var/list/uncommon_turfs = list()
	var/list/common_turfs =   list()

	for(var/x = origin_x to limit_x)
		for(var/y = origin_y to limit_y)
			var/turf/simulated/mineral/T = locate(x, y, origin_z)
			if(!istype(T) || !T.density)
				continue
			var/tmp_cell
			TRANSLATE_AND_VERIFY_COORD(x, y)
			if(tmp_cell >= deep_val)
				rare_turfs[T] = TRUE
			else if(tmp_cell >= rare_val)
				uncommon_turfs[T] = TRUE
			else
				common_turfs[T] = TRUE

	while(rare_turfs.len && rare_ore)
		var/turf/simulated/mineral/rock = pick_n_take(rare_turfs)
		rock.mineral = pick(MATERIAL_DIAMOND,MATERIAL_PLATINUM)
		rare_ore--

	while(uncommon_turfs.len && uncommon_ore)
		var/turf/simulated/mineral/rock = pick_n_take(uncommon_turfs)
		rock.mineral = pick(MATERIAL_URANIUM,MATERIAL_SILVER,MATERIAL_GOLD)
		uncommon_ore--

	while(common_turfs.len && common_ore)
		var/turf/simulated/mineral/rock = pick_n_take(common_turfs)
		rock.mineral = pick(MATERIAL_PLASTIC, MATERIAL_IRON)
		common_ore--