/atom/movable/var/waterproof

/obj/machinery/atmospherics
	waterproof = TRUE

/obj/machinery/door
	waterproof = TRUE

/obj/machinery/embedded_controller
	waterproof = TRUE

/obj/machinery/airlock_sensor
	waterproof = TRUE

/obj/machinery/conveyor
	waterproof = TRUE

/obj/machinery/conveyor_switch
	waterproof = TRUE

/mob/living/water_act(var/depth)
	..()
	wash_mob(src)
	for(var/thing in get_equipped_items(TRUE))
		if(isnull(thing)) continue
		var/atom/movable/A = thing
		if(A.simulated && !A.waterproof)
			A.water_act(depth)

/mob/living/carbon/human/water_act(var/depth)
	species.water_act(src, depth)
	..(depth)

/datum/species/proc/water_act(var/mob/living/carbon/human/H, var/depth)
	return

/datum/species/skrell/water_act(var/mob/living/carbon/human/H, var/depth)
	..()
	if(depth >= 40)
		if(H.traumatic_shock)
			H.traumatic_shock -= 25 // Slightly more than being drunk because it fires less often (10 ticks as opposed to 4)
		if(H.getBruteLoss() || H.getFireLoss())
			H.adjustBruteLoss(-(rand(1,3)))
			H.adjustFireLoss(-(rand(1,3)))
		if(prob(5)) // Might be too spammy.
			H << "<span class='notice'>The water ripples gently over your skin in a soothing balm.</span>"

/obj/effect/decal/cleanable/water_act(var/depth)
	..()
	qdel(src)

// This is really pretty crap and should be overridden for specific machines.
/obj/machinery/water_act(var/depth)
	..()
	if(!(stat & (NOPOWER|BROKEN)) && !waterproof && (depth > FLUID_DEEP))
		ex_act(3)

/obj/item/flame/water_act(var/depth)
	..()
	if(!waterproof && lit)
		if((istype(loc, /mob) && depth >= FLUID_SHALLOW) || \
		 (istype(loc, /turf) && depth >= 3) || \
		 depth >= FLUID_OVER_MOB_HEAD)
			extinguish()
