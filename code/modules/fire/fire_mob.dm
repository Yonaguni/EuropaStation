/mob/living/adjust_fire_stacks(var/add_fire_stacks=0) //Adjusting the amount of fire_stacks we have on person
    . = ..()
    fire_stacks = Clamp(fire_stacks + add_fire_stacks, FIRE_MIN_STACKS, FIRE_MAX_STACKS)

/mob/living/handle_fire()
	. = ..()
	if(fire_stacks < 0)
		fire_stacks = min(0, ++fire_stacks) //If we've doused ourselves in water to avoid fire, dry off slowly

	if(!on_fire)
		return 1
	else if(fire_stacks <= 0)
		extinguish() //Fire's been put out.
		return 1

	var/datum/gas_mixture/G = loc.return_air() // Check if we're standing in an oxygenless environment
	if(G.gas[REAGENT_ID_OXYGEN] < 1)
		extinguish() //If there's no oxygen in the tile we're on, put out the fire
		return 1

	ignite_location()

//Finds the effective temperature that the mob is burning at.
/mob/living/fire_burn_temperature()
	. = ..()
	if (fire_stacks <= 0)
		return 0

	//Scale quadratically so that single digit numbers of fire stacks don't burn ridiculously hot.
	//lower limit of 700 K, same as matches and roughly the temperature of a cool flame.
	return max(2.25*round(FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE*(fire_stacks/FIRE_MAX_FIRESUIT_STACKS)**2), 700)