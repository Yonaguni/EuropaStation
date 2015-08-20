#define OCEAN_SPREAD_DEPTH 500

var/image/ocean_overlay_img
/proc/get_ocean_overlay()
	if(!ocean_overlay_img)
		ocean_overlay_img = image('icons/effects/xgm_overlays.dmi', "ocean")
		ocean_overlay_img.layer = GAS_OVERLAY_LAYER+0.1 //So it renders over other gas mixes (hypothetically)
		ocean_overlay_img.alpha = GAS_MAX_ALPHA
	return ocean_overlay_img

/turf/unsimulated/fake_ocean
	name = "seafloor"
	desc = "Silty."
	density = 0
	opacity = 0
	blocks_air = 1
	icon = 'icons/turf/seafloor.dmi'
	icon_state = "seafloor"

/turf/unsimulated/fake_ocean/New()
	..()
	if(prob(20)) overlays |= get_mining_overlay("asteroid[rand(0,9)]")
	overlays |= get_ocean_overlay()

/turf/unsimulated/ocean
	name = "seafloor"
	desc = "Silty."
	density = 0
	opacity = 0
	blocks_air = 1
	var/sleeping = 0
	icon = 'icons/turf/seafloor.dmi'
	icon_state = "seafloor"
	var/datum/gas_mixture/water
	var/detail_decal = 1

/turf/unsimulated/ocean/abyss_open
	name = "abyss"
	desc = "You're pretty sure it's staring into you."
	density = 1
	icon_state = "abyss"
	detail_decal = 0

/turf/unsimulated/ocean/plating
	name = "plating"
	desc = "The naked hull."
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "plating"
	detail_decal = 0

/turf/unsimulated/ocean/abyss
	name = "sand"
	desc = "Uncomfortably gritty."
	icon = 'icons/turf/flooring/asteroid.dmi'
	icon_state = "asteroid"

/turf/unsimulated/ocean/abyss/plating
	name = "stone floor"
	desc = "Waterlogged and decrepit."
	icon_state = "asteroidfloor"
	detail_decal = 0

/turf/unsimulated/ocean/New()
	..()
	if(ticker && ticker.current_state == GAME_STATE_PLAYING)
		initialize()
	else
		// See startup hook do_ocean_initialisation()
		processing_turfs -= src

/turf/unsimulated/ocean/proc/initialize()
	update_icon()

/turf/unsimulated/ocean/update_icon()
	overlays.Cut()
	..()
	if(detail_decal && prob(20))
		overlays |= get_mining_overlay("asteroid[rand(0,9)]")
	overlays |= get_ocean_overlay()

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
	for(var/step_dir in cardinal)
		var/turf/simulated/T = get_step(src, step_dir)
		if(!istype(T) || !can_spread_into(T) || (get_dir(src,T) in blocked_dirs))
			continue
		var/datum/gas_mixture/GM = T.return_air()
		if(GM && GM.gas["water"] < 1500)
			GM.adjust_gas("water", 1500, 1)
			if(air_master) air_master.add_to_active(T)
		sleeping = 0
	if(sleeping)
		processing_turfs -= src

/turf/unsimulated/ocean/is_flooded()
	return 1

/turf/unsimulated/ocean/return_air()
	if(!water)
		water = new/datum/gas_mixture      // Make our 'air', freezing water.
		water.temperature = 250            // -24C
		water.adjust_gas("water", 1500, 1) // Should be higher.
		water.volume = CELL_VOLUME
	return water

/turf/unsimulated/ocean/attackby(obj/item/C as obj, mob/user as mob)

	if (istype(C, /obj/item/stack/rods))
		if(!locate(/obj/structure/lattice, src))
			var/obj/item/stack/rods/R = C
			if (R.use(1))
				user << "<span class='notice'>Constructing support lattice ...</span>"
				playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
				new /obj/structure/lattice(src)
		else
			user << "<span class='warning'>There's already a lattice here!</span>"
		return

	if (istype(C, /obj/item/stack/tile/floor))
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			var/obj/item/stack/tile/floor/S = C
			if(S.use(1))
				qdel(L)
				playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
				ChangeTurf(/turf/simulated/floor/flooded)
			else
				user << "<span class='warning'>You don't have enough tiles!</span>"
		else
			user << "<span class='warning'>The plating is going to need some support.</span>"
		return

	return ..()

#undef OCEAN_SPREAD_DEPTH
