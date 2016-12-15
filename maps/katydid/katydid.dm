#if !defined(USING_MAP_DATUM)

	#include "katydid-1.dmm"
	#include "katydid-2.dmm"
	#include "katydid-3.dmm"
	#include "katydid-4.dmm"
	#include "katydid_jobs.dm"
	#include "katydid_shuttles.dm"
	#include "katydid_unit_testing.dm"
	#include "katydid_verbs.dm"

	#define USING_MAP_DATUM /datum/map/katydid

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Katydid

#endif
