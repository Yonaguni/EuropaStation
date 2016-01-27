/atom/proc/water_act(var/depth)
	return

/mob/living/water_act(var/depth)
	..()
	if(on_fire)
		visible_message("<span class='danger'>A cloud of steam rises up as the water hits \the [src]!</span>")
		ExtinguishMob()
	if(fire_stacks > 0)
		adjust_fire_stacks(-round(depth/2))

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

/obj/effect/decal/cleanable/water_act()
	..()
	qdel(src)

/obj/machinery/water_act()
	..()
	if(stat & NOPOWER)
		return //don't explode if the machine isn't powered
	if(waterproof > 0)
		if(prob(2))
			ex_act(3.0)
	else if(waterproof < 0)
		ex_act(3.0)
	else
		return

/obj/item/weapon/flame/water_act()
	if(!waterproof && lit)
		die()
	return ..()

/obj/item/clothing/mask/smokable/water_act()
	if(lit)
		die(1)
	return ..()