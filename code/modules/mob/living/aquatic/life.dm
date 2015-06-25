/mob/living/aquatic/Life()
	if(!..() || stat > 0)
		return

	handle_behavior()

/mob/living/aquatic/handle_breathing()

	if(!required_gas) return 1

	var/suffocating = 1

	var/turf/T = loc
	if(istype(T) && T.is_ocean())
		suffocating = 0

	if(suffocating)
		var/datum/gas_mixture/G = loc.return_air()
		if(G && G.gas[required_gas] > gas_amount)
			suffocating = 0

	if(suffocating).
		SetStunned(3)
		adjustOxyLoss(rand(5,10))

	updatehealth()
	update_icon()

/mob/living/aquatic/updatehealth()
	..()
	if(health <= 0 && stat != DEAD)
		death()

/mob/living/aquatic/death(gibbed, death_msg)
	if(!gibbed && icon_dead) icon_state = icon_dead
	if(!death_msg) death_msg = "expires pitifully..."
	return ..(gibbed,death_msg)