#define FLUID_EVAPORATION_POINT 3          // Depth a fluid begins self-deleting
#define FLUID_DELETING -1                  // Depth a fluid counts as qdel'd
#define FLUID_SHALLOW 200                  // Depth shallow icon is used
#define FLUID_DEEP 800                     // Depth deep icon is used
#define FLUID_MAX_DEPTH FLUID_DEEP*4       // Arbitrary max value for flooding.

// Expects /turf for T.
#define ADD_ACTIVE_FLUID_SOURCE(T)    if(SSfluids) SSfluids.water_sources |= T
#define REMOVE_ACTIVE_FLUID_SOURCE(T) if(SSfluids) SSfluids.water_sources -= T

// Expects /obj/effect/fluid for F.
#define ADD_ACTIVE_FLUID(F)           if(SSfluids) SSfluids.active_fluids |= F
#define REMOVE_ACTIVE_FLUID(F)        if(SSfluids) SSfluids.active_fluids -= F

// Expects /obj/effect/fluid for F, int for amt.
#define LOSE_FLUID(F, amt) \
	F:fluid_amount = max(-1, F:fluid_amount - amt); \
	ADD_ACTIVE_FLUID(F)
#define SET_FLUID_DEPTH(F, amt) \
	F:fluid_amount = min(FLUID_MAX_DEPTH, amt); \
	ADD_ACTIVE_FLUID(F)

// Expects turf for T,
#define UPDATE_FLUID_BLOCKED_DIRS(T) \
	if(isnull(T:fluid_blocked_dirs)) {\
		T:fluid_blocked_dirs = 0; \
		for(var/obj/structure/window/W in T) { \
			if(W.density) T:fluid_blocked_dirs |= W.dir; \
		} \
		for(var/obj/machinery/door/window/D in T) {\
			if(D.density) T:fluid_blocked_dirs |= D.dir; \
		} \
	}

// Expects turf for T, bool for dry_run.
#define FLOOD_TURF_NEIGHBORS(T, dry_run) \
	for(var/spread_dir in cardinal) {\
		UPDATE_FLUID_BLOCKED_DIRS(T); \
		if(T:fluid_blocked_dirs & spread_dir) continue; \
		var/turf/next = get_step(T, spread_dir); \
		if(!istype(next) || next.flooded) continue; \
		UPDATE_FLUID_BLOCKED_DIRS(next); \
		if((next.fluid_blocked_dirs & reverse_dir[spread_dir]) || !next.CanFluidPass(spread_dir)) continue; \
		flooded_a_neighbor = TRUE; \
		var/obj/effect/fluid/F = locate() in next; \
		if(!F && !dry_run) {\
			F = PoolOrNew(/obj/effect/fluid, next); \
			var/datum/gas_mixture/GM = T:return_air(); \
			if(GM) F.temperature = GM.temperature; \
		} \
		if(F) { \
			if(F.fluid_amount >= FLUID_MAX_DEPTH) continue; \
			if(!dry_run) SET_FLUID_DEPTH(F, FLUID_MAX_DEPTH); \
		} \
	} \
	if(!flooded_a_neighbor) REMOVE_ACTIVE_FLUID_SOURCE(T);
