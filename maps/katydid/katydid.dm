#if !defined(USING_MAP_DATUM)

	#include "katydid_areas.dm"
	#include "katydid_outfits.dm"
	#include "katydid_jobs.dm"
	#include "katydid_shuttles.dm"
	#include "katydid_unit_testing.dm"
	#include "katydid_verbs.dm"

	#include "katydid-1.dmm"
	#include "katydid-2.dmm"
	#include "katydid-3.dmm"
	#include "katydid-4.dmm"

	#define USING_MAP_DATUM /datum/map/katydid

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Katydid

#endif

/world
	area = /area/space

/obj/effect/overmap/ship/katydid
	name = "ICV Katydid"
	desc = "A cargo vessel."

/obj/effect/overmap/ship/navy
	name = "SCV Donald Bradman"
	desc = "A naval combat vessel."
