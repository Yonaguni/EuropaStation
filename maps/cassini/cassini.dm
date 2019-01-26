#if !defined(using_map_DATUM)
	#include "cassini_areas.dm"
	#include "jobs/_jobs.dm"
	#include "jobs/_job_clothing.dm"
	#include "jobs/_jobs_ids.dm"
	#include "jobs/_job_outfits.dm"
	#include "jobs/admin.dm"
	#include "jobs/colonist.dm"
	#include "jobs/medical.dm"
	#include "jobs/police.dm"
	#include "jobs/utilities.dm"
	#include "cassini-1.dmm"
	#define using_map_DATUM /datum/map/cassini
#elif !defined(MAP_OVERRIDE)
	#warn A map has already been included, ignoring Cassini
#endif
