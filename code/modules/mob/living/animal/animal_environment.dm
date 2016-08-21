/mob/living/animal/handle_environment(var/prev_atmos_suitable = 1)

	var/atom/env = loc
	if(!istype(env))
		return

	var/atmos_suitable = prev_atmos_suitable
	if(atmos_suitable)
		var/env_temp = env.get_temperature()

		if(env_temp > max_temp || env_temp < min_temp)
			atmos_suitable = 0
		else if(handle_drowning())
			atmos_suitable = 0
		else if(!isnull(min_oxygen) && !env.has_gas(REAGENT_ID_OXYGEN, min_oxygen))
			atmos_suitable = 0
		else if(!isnull(max_toxins) && env.has_gas(REAGENT_ID_FUEL, max_toxins))
			atmos_suitable = 0
		else if(!isnull(min_pressure) || !isnull(max_pressure))
			var/env_pressure = env.return_pressure()
			if(env_pressure < min_pressure || env_pressure > max_pressure)
				atmos_suitable = 0

	if(!atmos_suitable)
		adjustBruteLoss(rand(1,3))

	return 1
