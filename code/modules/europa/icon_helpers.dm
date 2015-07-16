#define CORNER_NONE 0
#define CORNER_EASTWEST 1
#define CORNER_DIAGONAL 2
#define CORNER_NORTHSOUTH 4

// Similar to dirs_to_corner_states() in code/modules/tables.dm, but returns an *ordered* list, requiring (in order), dir=NORTH, SOUTH, EAST, WEST
// Note that this means this proc can be used as:

//	var/list/corner_states = dirs_to_unified_corner_states(directions)
//	for(var/index = 1 to 4)
//		var/image/I = image(icon, icon_state = corner_states[index], dir = 1 << (index - 1))
//		[...]


/proc/dirs_to_unified_corner_states(list/dirs)
	if(!istype(dirs)) return

	var/NE = CORNER_NONE
	var/NW = CORNER_NONE
	var/SE = CORNER_NONE
	var/SW = CORNER_NONE

	if(NORTH in dirs)
		NE |= CORNER_NORTHSOUTH
		NW |= CORNER_NORTHSOUTH
	if(SOUTH in dirs)
		SW |= CORNER_NORTHSOUTH
		SE |= CORNER_NORTHSOUTH
	if(EAST in dirs)
		SE |= CORNER_EASTWEST
		NE |= CORNER_EASTWEST
	if(WEST in dirs)
		NW |= CORNER_EASTWEST
		SW |= CORNER_EASTWEST
	if(NORTHWEST in dirs)
		NW |= CORNER_DIAGONAL
	if(NORTHEAST in dirs)
		NE |= CORNER_DIAGONAL
	if(SOUTHEAST in dirs)
		SE |= CORNER_DIAGONAL
	if(SOUTHWEST in dirs)
		SW |= CORNER_DIAGONAL

	return list("[NE]", "[NW]", "[SE]", "[SW]")

#undef CORNER_NONE
#undef CORNER_EASTWEST
#undef CORNER_DIAGONAL
#undef CORNER_NORTHSOUTH
