#if !defined(USING_MAP_DATUM)

	#include "makara_areas.dm"
	#include "makara_unit_testing.dm"
	#include "makara_outfits.dm"
	#include "makara_jobs.dm"
	#include "makara_elevators.dm"
	#include "makara_shuttles.dm"
	#include "makara_events.dm"

	#include "makara-1.dmm"
	#include "makara-2.dmm"
	#include "makara-3.dmm"

	#define USING_MAP_DATUM /datum/map/makara

#elif !defined(MAP_OVERRIDE)

#warn A map has already been included, ignoring Makara.

#endif

/world
	area = /area/europa/ocean
	turf = /turf/simulated/ocean/open

/obj/effect/overmap/ship/makara
	name = "SSV Makara"
	desc = "A science vessel."