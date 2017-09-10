#define WALL_AO_ALPHA 100

// This converts a regular dir into a icon_smoothing dir (which can represent all dirs in a single bitfield)
// Index is dir, the order of these matters.
// Ported to Europa, thanks Lohikar.
var/list/ao_cache = list()
var/list/dir2bdir = list(
	N_NORTH,     // NORTH
	N_SOUTH,     // SOUTH
	0,           // not a dir
	N_EAST,	     // EAST
	N_NORTHEAST, // NORTHEAST
	N_SOUTHEAST, // SOUTHEAST
	0,           // not a dir
	N_WEST,      // WEST
	N_NORTHWEST, // NORTHWEST
	N_SOUTHWEST  // SOUTHWEST
)

/turf
	var/permit_ao
	var/tmp/list/ao_overlays // Current ambient occlusion overlays. Tracked so we can reverse them without dropping all priority overlays.
	var/tmp/ao_neighbors = 0

/turf/proc/regenerate_ao()
	for (var/thing in trange(1, src))
		var/turf/T = thing
		if (T.permit_ao)
			T.update_ao()

/turf/update_icon(var/update_neighbors, var/list/previously_added = list())
	. = ..()
	if(permit_ao)
		update_ao()

/turf/proc/calculate_ao_neighbours()
	var/turf/T
	for (var/tdir in alldirs)
		T = get_step(src, tdir)
		if(T && T.density && T.opacity)
			ao_neighbors &= ~dir2bdir[tdir]
		else
			ao_neighbors |= dir2bdir[tdir]

/turf/proc/update_ao()

	if (ao_overlays)
		overlays -= ao_overlays
		ao_overlays.Cut()

	calculate_ao_neighbours()

	if(!density && !opacity)
		for(var/i = 1 to 4)
			var/cdir = cornerdirs[i]
			var/corner = 0

			if (ao_neighbors & dir2bdir[cdir])
				corner |= 2
			if (ao_neighbors & dir2bdir[turn(cdir, 45)])
				corner |= 1
			if (ao_neighbors & dir2bdir[turn(cdir, -45)])
				corner |= 4

			if (corner != 7)	// 7 is the 'no shadows' state, no reason to add overlays for it.
				var/cache_key = "[corner]-[i]"
				var/image/I = ao_cache[cache_key]
				if (!I)
					I = image('icons/turf/flooring/shadows.dmi', "[corner]", dir = 1 << (i-1))
					I.alpha = WALL_AO_ALPHA
					ao_cache[cache_key] = I

				LAZYADD(ao_overlays, I)

	UNSETEMPTY(ao_overlays)
	if (ao_overlays)
		overlays += ao_overlays

#undef WALL_AO_ALPHA