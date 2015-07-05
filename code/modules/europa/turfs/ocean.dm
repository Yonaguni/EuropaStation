#define OCEAN_SPREAD_DEPTH 500

/turf/unsimulated/ocean
	name = "seafloor"
	desc = "Silty."
	density = 0
	opacity = 0
	var/sleeping = 0
	icon = 'icons/turf/seafloor.dmi'
	icon_state = "seafloor"
	var/datum/gas_mixture/water
	var/detail_decal

/turf/unsimulated/ocean/New()
	..()
	water = new/datum/gas_mixture   // Make our 'air', freezing water.
	water.temperature = 250         // -24C
	water.adjust_gas("water", 1500, 1) // Should be higher.
	water.volume = 1500
	PoolOrNew(/obj/effect/gas_overlay/ocean,src)
	processing_turfs |= src
	if(prob(20))
		detail_decal = "asteroid[rand(0,9)]"
	spawn(5)
		update_icon()
	processing_turfs -= src

/turf/unsimulated/ocean/proc/update_icon()
	overlays.Cut()
	if(detail_decal)
		overlays |= get_mining_overlay(detail_decal)

/turf/unsimulated/ocean/Destroy()
	for(var/obj/effect/gas_overlay/ocean/O in src)
		qdel(O)
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
	if(ticker && ticker.current_state == GAME_STATE_PLAYING)
		sleeping = 0
		processing_turfs |= src

/turf/unsimulated/ocean/process()
	sleeping = 1
	var/list/blocked_dirs = list()
	for(var/obj/structure/window/W in src)
		blocked_dirs |= W.dir
	for(var/obj/machinery/door/window/D in src)
		blocked_dirs |= D.dir
	for(var/turf/simulated/T in range(1,src))
		if(!can_spread_into(T) || (get_dir(src,T) in blocked_dirs))
			continue
		var/datum/gas_mixture/GM = T.return_air()
		if(GM)
			GM.adjust_gas("water", 1500, 1)
			GM.temperature = water.temperature //todo make this a proper temperature share instead of arbitrary/magical.
		sleeping = 0
	if(sleeping)
		processing_turfs -= src

/turf/unsimulated/ocean/is_ocean()
	return 1

/turf/unsimulated/ocean/return_air()
	return water

#undef OCEAN_SPREAD_DEPTH