/turf/var/flooded // Whether or not this turf is absolutely flooded ie. a water source.

// We share overlays for all fluid turfs to sync icon animation.
var/list/fluid_images = list()
/proc/get_fluid_icon(var/img_state)
	if(!fluid_images[img_state])
		fluid_images[img_state] = image('icons/effects/liquids.dmi',img_state)
	return fluid_images[img_state]

#define FLUID_EVAPORATION_POINT 10         // Depth a fluid begins self-deleting
#define FLUID_DELETING -1                  // Depth a fluid counts as qdel'd
#define FLUID_SHALLOW 15                   // Depth shallow icon is used
#define FLUID_DEEP 80                      // Depth deep icon is used
#define FLUID_MAX_ALPHA 180
#define FLUID_MAX_DEPTH 100

/mob/verb/spawn_fluid()

	set name = "Spawn Water"
	set desc = "Flood the turf you are standing on."
	set category = "Debug"

	var/turf/T = get_turf(src)
	if(!istype(T)) return
	var/obj/effect/fluid/F = locate() in T
	if(!F) F = new(T)
	F.set_depth(FLUID_MAX_DEPTH)
