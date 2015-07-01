#define OCEAN_SPREAD_DEPTH 1000
#define OCEAN_OVERLAY_LAYER 4.9

var/list/ocean_overlay_cache

/turf/unsimulated/ocean
	name = "seafloor"
	desc = "Silty."
	density = 0
	opacity = 0
	var/sleeping = 0
	icon = 'icons/turf/seafloor.dmi'
	icon_state = "seafloor"
	var/isolated
	var/datum/gas_mixture/water
	var/detail_decal

/turf/unsimulated/ocean/New()
	..()
	water = new/datum/gas_mixture   // Make our 'air', freezing water.
	water.temperature = 250         // -24C
	water.adjust_gas("water", 1500) // Should be higher.
	water.volume = 1500
	processing_turfs |= src
	if(prob(20))
		detail_decal = "asteroid[rand(0,9)]"
	update_icon()

/turf/unsimulated/ocean/proc/update_icon()
	overlays.Cut()
	if(detail_decal) overlays |= get_mining_overlay(detail_decal)
	if(!ocean_overlay_cache) ocean_overlay_cache = list()
	if(!ocean_overlay_cache["ocean"])
		var/image/ocean_overlay = image('icons/effects/liquid.dmi', "ocean")
		ocean_overlay.color = "#66D1FF"
		ocean_overlay.alpha = FLUID_MAX_ALPHA
		ocean_overlay.layer = OCEAN_OVERLAY_LAYER
		ocean_overlay_cache["ocean"] = ocean_overlay
	overlays |= ocean_overlay_cache["ocean"]
	for(var/step_dir in cardinal)
		var/turf/simulated/T = get_step(src,step_dir)
		if(istype(T) && can_spread_into(T))
			var/obj/effect/fluid/F = locate(/obj/effect/fluid) in T
			if(!F || F.depth > FLUID_OCEAN_DEPTH)
				continue
			var/flow_key = "ocean_edge_[step_dir]"
			if(!ocean_overlay_cache[flow_key])
				var/image/I = image('icons/effects/liquid.dmi', flow_key)
				I.alpha = FLUID_MAX_ALPHA
				I.layer = OCEAN_OVERLAY_LAYER
				ocean_overlay_cache[flow_key] = I
			overlays |= ocean_overlay_cache[flow_key]

/turf/unsimulated/ocean/Destroy()
	processing_turfs -= src
	..()

/turf/unsimulated/ocean/proc/can_spread_into(var/turf/simulated/target)
	if (!target || target.density || !Adjacent(target))
		return 0
	for(var/obj/O in target.contents)
		if(!O.CanAtmosPass(src))
			return 0
	return 1

/turf/unsimulated/ocean/proc/refresh()
	sleeping = 0
	processing_turfs |= src

/turf/unsimulated/ocean/process()
	sleeping = 1
	if(!isolated)
		var/list/blocked_dirs = list()
		for(var/obj/structure/window/W in src)
			blocked_dirs |= W.dir
		for(var/obj/machinery/door/window/D in src)
			blocked_dirs |= D.dir
		for(var/turf/simulated/T in range(1,src))
			if(!can_spread_into(T) || (get_dir(src,T) in blocked_dirs))
				continue
			var/obj/effect/fluid/F = locate(/obj/effect/fluid) in T
			if(!F)
				F = PoolOrNew(/obj/effect/fluid, T)
				new_fluids |= F
			F.set_depth(OCEAN_SPREAD_DEPTH)
			sleeping = 0
	if(sleeping)
		processing_turfs -= src
	spawn(1) update_icon()

/turf/unsimulated/ocean/is_ocean()
	return 1

/turf/unsimulated/ocean/return_air()
	return water

#undef OCEAN_SPREAD_DEPTH
#undef OCEAN_OVERLAY_LAYER