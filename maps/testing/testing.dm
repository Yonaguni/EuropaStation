#if !defined(USING_MAP_DATUM)
	#include "testing.dmm"
	#define USING_MAP_DATUM /datum/map/testing

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Testing

#endif
