/datum/event/solar_storm
	startWhen				= 45
	announceWhen			= 1
	var/const/rad_interval 	= 5  	//Same interval period as radiation storms.
	var/base_solar_gen_rate


/datum/event/solar_storm/setup()
	endWhen = startWhen + rand(30,90) + rand(30,90) //2-6 minute duration

/datum/event/solar_storm/announce()
	using_map.solar_storm_starting_announce()
	adjust_solar_output(1.5)

/datum/event/solar_storm/proc/adjust_solar_output(var/mult = 1)
	if(isnull(base_solar_gen_rate)) base_solar_gen_rate = solar_gen_rate
	solar_gen_rate = mult * base_solar_gen_rate

	vent_min_power = solar_gen_rate * 2
	vent_max_power = solar_gen_rate * 8

/datum/event/solar_storm/start()
	using_map.solar_storm_entered_announce()
	adjust_solar_output(5)

/datum/event/solar_storm/tick()
	if(activeFor % rad_interval == 0)
		radiate()

/datum/event/solar_storm/proc/radiate()
	for(var/mob/living/L in living_mob_list_)
		var/turf/T = get_turf(L)
		if(!T || !(T.z in using_map.player_levels))
			continue

		if(!istype(T.loc,/area/space) && !istype(T,/turf/space))	//Make sure you're in a space area or on a space turf
			continue

		//Todo: Apply some burn damage from the heat of the sun. Until then, enjoy some moderate radiation.
		L.apply_effect((rand(15,30)),IRRADIATE,blocked = L.getarmor(null, "rad"))


/datum/event/solar_storm/end()
	using_map.solar_storm_ending_announce()
	adjust_solar_output()


//For a false alarm scenario.
/datum/event/solar_storm/syndicate/adjust_solar_output()
	return

/datum/event/solar_storm/syndicate/radiate()
	return
