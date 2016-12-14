#if !defined(USING_MAP_DATUM)

	#include "aeolus-1.dmm"
	#include "aeolus-2.dmm"
	#include "aeolus-3.dmm"
	#include "aeolus-4.dmm"
	#include "aeolus_lift.dm"
	#include "aeolus_areas.dm"
	#include "aeolus_shuttles.dm"
	#include "aeolus_unit_testing.dm"

	#define USING_MAP_DATUM /datum/map/aeolus

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Aeolus

#endif
