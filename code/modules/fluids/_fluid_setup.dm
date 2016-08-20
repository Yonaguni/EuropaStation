/turf/var/flooded // Whether or not this turf is absolutely flooded ie. a water source.

// We share overlays for all fluid turfs to sync icon animation.
var/list/fluid_images = list()
/proc/get_fluid_icon(var/img_state)
	if(!fluid_images[img_state])
		fluid_images[img_state] = image('icons/effects/liquids.dmi',img_state)
	return fluid_images[img_state]

#define FLUID_EVAPORATION_POINT 3          // Depth a fluid begins self-deleting
#define FLUID_DELETING -1                  // Depth a fluid counts as qdel'd
#define FLUID_SHALLOW 200                  // Depth shallow icon is used
#define FLUID_DEEP 800                     // Depth deep icon is used
#define FLUID_MAX_ALPHA 180
#define FLUID_MAX_DEPTH 1000
#define FLUID_OCEAN_DEPTH 600