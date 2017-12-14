#define FOOTSTEPS_HARD   "hard"
#define FOOTSTEPS_WOOD   "wood"
#define FOOTSTEPS_WATER  "water"
#define FOOTSTEPS_SAND   "sand"
#define FOOTSTEPS_SNOW   "snow"
#define FOOTSTEPS_GRASS  "grass"
#define FOOTSTEPS_DIRT   "dirt"
#define FOOTSTEPS_CARPET "carpet"

#define WALK_SOUND_DELAY 8
#define RUN_SOUND_DELAY 4

// Sound selection proc.
/proc/get_general_footstep_sound(var/footstep_type = FOOTSTEPS_HARD)
	switch(footstep_type)
		if(FOOTSTEPS_WOOD)
			return pick( \
				'sound/effects/footsteps/wood/wood_step1.ogg', \
				'sound/effects/footsteps/wood/wood_step2.ogg', \
				'sound/effects/footsteps/wood/wood_step3.ogg', \
				'sound/effects/footsteps/wood/wood_step4.ogg', \
				'sound/effects/footsteps/wood/wood_step5.ogg', \
				'sound/effects/footsteps/wood/wood_step6.ogg', \
				'sound/effects/footsteps/wood/wood_step7.ogg', \
				'sound/effects/footsteps/wood/wood_step8.ogg'  \
			)
		if(FOOTSTEPS_WATER)
			return pick( \
				'sound/effects/footsteps/water/slosh1.ogg', \
				'sound/effects/footsteps/water/slosh2.ogg', \
				'sound/effects/footsteps/water/slosh3.ogg', \
				'sound/effects/footsteps/water/slosh4.ogg'  \
			)
		if(FOOTSTEPS_SAND)
			return pick( \
				'sound/effects/footsteps/sand/sand_step1.ogg', \
				'sound/effects/footsteps/sand/sand_step2.ogg', \
				'sound/effects/footsteps/sand/sand_step3.ogg', \
				'sound/effects/footsteps/sand/sand_step4.ogg', \
				'sound/effects/footsteps/sand/sand_step5.ogg', \
				'sound/effects/footsteps/sand/sand_step6.ogg', \
				'sound/effects/footsteps/sand/sand_step7.ogg', \
				'sound/effects/footsteps/sand/sand_step8.ogg'  \
			)
		if(FOOTSTEPS_SNOW)
			return pick( \
				'sound/effects/footsteps/snow/snowstep1.ogg', \
				'sound/effects/footsteps/snow/snowstep2.ogg', \
				'sound/effects/footsteps/snow/snowstep3.ogg', \
				'sound/effects/footsteps/snow/snowstep4.ogg'  \
			)
		if(FOOTSTEPS_GRASS)
			return pick( \
				'sound/effects/footsteps/grass/grass1.ogg', \
				'sound/effects/footsteps/grass/grass2.ogg', \
				'sound/effects/footsteps/grass/grass3.ogg', \
				'sound/effects/footsteps/grass/grass4.ogg'  \
			)
		if(FOOTSTEPS_DIRT)
			return pick( \
				'sound/effects/footsteps/dirt/dirt1.ogg', \
				'sound/effects/footsteps/dirt/dirt2.ogg', \
				'sound/effects/footsteps/dirt/dirt3.ogg', \
				'sound/effects/footsteps/dirt/dirt4.ogg'  \
			)
		if(FOOTSTEPS_CARPET)
			return pick( \
				'sound/effects/footsteps/carpet/carpet_step1.ogg', \
				'sound/effects/footsteps/carpet/carpet_step2.ogg', \
				'sound/effects/footsteps/carpet/carpet_step3.ogg', \
				'sound/effects/footsteps/carpet/carpet_step4.ogg', \
				'sound/effects/footsteps/carpet/carpet_step5.ogg', \
				'sound/effects/footsteps/carpet/carpet_step6.ogg', \
				'sound/effects/footsteps/carpet/carpet_step7.ogg', \
				'sound/effects/footsteps/carpet/carpet_step8.ogg'  \
			)
		else
			return pick( \
				'sound/effects/footsteps/hard/tile1.ogg', \
				'sound/effects/footsteps/hard/tile2.ogg', \
				'sound/effects/footsteps/hard/tile3.ogg', \
				'sound/effects/footsteps/hard/tile4.ogg'  \
			)

// Turf code.
/turf/var/footstep_type = FOOTSTEPS_HARD

/turf/Enter(var/atom/movable/mover)
	. = ..()
	if(.)
		var/mob/walker = mover
		if(istype(walker) && world.time >= walker.next_footstep)
			walker.next_footstep = world.time + (walker.m_intent == "run" ? RUN_SOUND_DELAY : WALK_SOUND_DELAY)
			playsound(src, walker.get_footstep_sound(check_fluid_depth(10) ? FOOTSTEPS_WATER : footstep_type), walker.get_walking_volume(), 1)

// Mob code.
/mob/var/next_footstep = 0

/mob/proc/get_walking_volume()
	return (m_intent == "run" ? 40 : 30)

/mob/proc/get_footstep_sound(var/turf_type)
	return

/mob/living/get_footstep_sound(var/turf_type)
	return get_general_footstep_sound(turf_type)

/mob/living/carbon/human/get_walking_volume()
	. = ..()
	if(!shoes)
		. *= 0.5

/mob/living/carbon/human/get_footstep_sound(var/turf_type)
	var/step_sound = species.get_footstep_sound(src, turf_type)
	return step_sound ? step_sound : ..()

// Species code.
/datum/species/proc/get_footstep_sound(var/mob/living/carbon/human/H, var/turf_type)
	var/obj/item/clothing/shoes/shoes = H.shoes
	if(shoes)
		return shoes.get_footstep_sound(turf_type)

/datum/species/octopus/get_footstep_sound(var/mob/living/carbon/human/H, var/turf_type)
	if(turf_type != FOOTSTEPS_WATER)
		return pick( \
			'sound/effects/footsteps/octopus/slither1.ogg', \
			'sound/effects/footsteps/octopus/slither2.ogg', \
			'sound/effects/footsteps/octopus/slither3.ogg', \
			'sound/effects/footsteps/octopus/slither4.ogg', \
			'sound/effects/footsteps/octopus/slither5.ogg', \
			'sound/effects/footsteps/octopus/slither6.ogg', \
			'sound/effects/footsteps/octopus/slither7.ogg', \
			'sound/effects/footsteps/octopus/slither8.ogg'  \
			)

// Object code.
/obj/item/clothing/proc/get_footstep_sound(var/turf_type)
	return

/obj/item/clothing/shoes/jackboots/get_footstep_sound(var/turf_type)
	if(turf_type != FOOTSTEPS_WATER)
		return pick( \
			'sound/effects/footsteps/armor/gear1.ogg', \
			'sound/effects/footsteps/armor/gear2.ogg', \
			'sound/effects/footsteps/armor/gear3.ogg', \
			'sound/effects/footsteps/armor/gear4.ogg'  \
		)

/obj/item/clothing/mask/plunger/get_footstep_sound(var/turf_type)
	if(turf_type != FOOTSTEPS_WATER)
		return 'sound/effects/plunger.ogg'

// Flooring code.
/decl/flooring/var/footstep_type = FOOTSTEPS_HARD

// Turf and flooding subtypes.
/turf/simulated/floor/natural/sand/footstep_type =  FOOTSTEPS_SAND
/turf/simulated/ocean/footstep_type =               FOOTSTEPS_SAND
/decl/flooring/asteroid/footstep_type =             FOOTSTEPS_SAND
/turf/simulated/mineral/footstep_type =             FOOTSTEPS_SAND
/turf/simulated/floor/water/footstep_type =         FOOTSTEPS_WATER
/turf/simulated/ocean/moving/footstep_type =        FOOTSTEPS_WATER
/turf/simulated/floor/natural/footstep_type =       FOOTSTEPS_DIRT
/turf/simulated/floor/natural/grass/footstep_type = FOOTSTEPS_GRASS
/decl/flooring/grass/footstep_type =                FOOTSTEPS_GRASS
/decl/flooring/wood/footstep_type =                 FOOTSTEPS_WOOD
/decl/flooring/carpet/footstep_type =               FOOTSTEPS_CARPET

// End.
#undef FOOTSTEPS_HARD
#undef FOOTSTEPS_WOOD
#undef FOOTSTEPS_WATER
#undef FOOTSTEPS_SAND
#undef FOOTSTEPS_SNOW
#undef FOOTSTEPS_GRASS
#undef FOOTSTEPS_DIRT
#undef FOOTSTEPS_CARPET
#undef WALK_SOUND_DELAY
#undef RUN_SOUND_DELAY