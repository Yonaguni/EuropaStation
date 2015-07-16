/mob/living/proc/can_drown()
	return 1

/mob/living/bot/can_drown()
	return 0

/mob/living/simple_animal/construct/can_drown()
	return 0

/mob/living/simple_animal/borer/can_drown()
	return 0

/mob/living/carbon/can_drown()
	var/obj/item/organ/gills/G = locate() in internal_organs
	if(!G || G.is_broken())
		return 1
	return 0

/mob/living/proc/handle_drowning()
	if(!can_drown())
		return 0
	var/turf/T = get_turf(src)
	if(!istype(T))
		return
	if(!T.is_flooded(lying))
		return 0
	if(prob(5))
		src << "<span class='danger'>You choke and splutter as you inhale water!</span>"
	return 1 // Presumably chemical smoke can't be breathed while you're underwater.

/datum/admins/proc/spawn_gas() //todo
	set category = "Debug"
	set desc = "Spawn an amount of a particular kind of gas."
	set name = "Spawn Fluid"

	if(!check_rights(R_SPAWN)) return
	var/fluid_amt = input("Enter volume:") as num|null
	if(fluid_amt && isnum(fluid_amt))
		var/turf/simulated/T = get_turf(usr)
		if(!istype(T))
			usr << "<span class='danger'>Gas can only be spawned on simulated turfs.</span>"
			return
	/*
		var/obj/effect/fluid/F = locate() in T
		if(!F) F = PoolOrNew(/obj/effect/fluid, T)
		F.set_depth(fluid_amt)
	*/
		log_admin("[key_name(usr)] spawned [fluid_amt] units of gas at ([usr.x],[usr.y],[usr.z])")
	return

/atom/proc/water_act(var/depth, var/flowdir)
	return

/obj/item/water_act(var/depth, var/flowdir)
	if(!isnull(flowdir))
		if(anchored || depth <= w_class*10)
			return
		step_towards(src, get_step(get_turf(src),flowdir))

/mob/living/water_act(var/depth, var/flowdir)
	if(on_fire)
		visible_message("<span class='danger'>A cloud of steam rises up as the water hits \the [src]!</span>")
		ExtinguishMob()
	if(fire_stacks > 0)
		adjust_fire_stacks(-round(depth/2))
	if(anchored || buckled)
		return
	if(!isnull(flowdir))
		if(depth >= 30)
			var/flow_msg = "pushed away"
			if(!lying && depth >= 70 && prob(depth))
				Weaken(rand(2,4))
				flow_msg = "knocked down"
			src << "<span class='danger'>You are [flow_msg] by the rush of water!</span>"
			step_towards(src, get_step(get_turf(src),flowdir))

/mob/living/carbon/human/water_act(var/depth, var/flowdir)
	species.water_act(src, depth)
	if(!((species.flags & NO_SLIP) || (shoes && (shoes.flags & NOSLIP))))
		..(depth, flowdir)

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

/obj/effect/decal/cleanable/water_act()
	qdel(src)

obj/machinery/water_act()
	if(stat & NOPOWER)
		return //don't explode if the machine isn't powered
	if(waterproof > 0)
		if(prob(2))
			ex_act(3.0)
	else if(waterproof < 0)
		ex_act(3.0)

	else
		return

var/image/ocean_overlay_img

/obj/effect/gas_overlay/ocean
	alpha = GAS_MAX_ALPHA
	color = "#66D1FF"

/proc/get_ocean_overlay()
	if(!ocean_overlay_img)
		ocean_overlay_img = image('icons/effects/xgm_overlays.dmi', "ocean")
		ocean_overlay_img.layer = FLY_LAYER
	return ocean_overlay_img

/obj/effect/gas_overlay/ocean/New()
	..()
	overlays |= get_ocean_overlay()
