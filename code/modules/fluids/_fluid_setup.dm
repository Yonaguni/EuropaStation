var/list/fluid_dirs = list(NORTH, SOUTH, EAST, WEST, DOWN)
/turf/var/flooded
var/datum/gas_mixture/fluid/global_ocean

/proc/get_global_ocean()
	if(!global_ocean)
		global_ocean = new/datum/gas_mixture      // Make our freezing water.
		global_ocean.temperature = 250            // -24C
		global_ocean.adjust_gas("water", 3000, 1) // Should be higher, but oh well.
		global_ocean.volume = CELL_VOLUME
	return global_ocean
