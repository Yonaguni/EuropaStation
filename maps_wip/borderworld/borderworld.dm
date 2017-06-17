#if !defined(USING_MAP_DATUM)

	#include "borderworld-1.dmm"
	#include "borderworld-2.dmm"
	#include "borderworld_jobs.dm"
	#include "borderworld_areas.dm"
	#include "borderworld_unit_testing.dm"

	#define USING_MAP_DATUM /datum/map/borderworld

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Borderworld.

#endif
