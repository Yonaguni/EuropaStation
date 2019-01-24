#if !defined(using_map_DATUM)
	#include "cassini_areas.dm"
	#include "cassini-1.dmm"
	#define using_map_DATUM /datum/map/cassini
#elif !defined(MAP_OVERRIDE)
	#warn A map has already been included, ignoring Cassini
#endif
