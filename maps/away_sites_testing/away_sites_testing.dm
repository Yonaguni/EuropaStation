#if !defined(using_map_DATUM)
	#include "away_sites_testing_lobby.dm"
	#include "away_sites_testing_unit_testing.dm"
	#include "blank.dmm"
	#include "../away/empty.dmm"
	#define using_map_DATUM /datum/map/away_sites_testing
#elif !defined(MAP_OVERRIDE)
	#warn A map has already been included, ignoring Away Sites Testing
#endif
