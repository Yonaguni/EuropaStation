#if !defined(USING_MAP_DATUM)

	#include "yonaguni_areas.dm"
	#include "yonaguni_unit_testing.dm"
	#include "yonaguni_outfits.dm"
	#include "yonaguni_jobs.dm"
	#include "yonaguni_elevators.dm"
	#include "yonaguni_shuttles.dm"

	#include "yonaguni-1.dmm"
	#include "yonaguni-2.dmm"
	#include "yonaguni-3.dmm"

	#define USING_MAP_DATUM /datum/map/yonaguni

#elif !defined(MAP_OVERRIDE)

#warn A map has already been included, ignoring Yonaguni.

#endif
