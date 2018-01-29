/datum/event/radiation_storm
	var/const/enterBelt		= 30
	var/const/radIntervall 	= 5	// Enough time between enter/leave belt for 10 hits, as per original implementation
	var/const/leaveBelt		= 80
	var/const/revokeAccess	= 135
	startWhen				= 2
	announceWhen			= 1
	endWhen					= revokeAccess
	var/postStartTicks 		= 0

/datum/event/radiation_storm/announce()
	using_map.radiation_storm_starting_announce()

/datum/event/radiation_storm/start()
	make_maint_all_access()

/datum/event/radiation_storm/tick()
	if(activeFor == enterBelt)
		using_map.radiation_storm_entered_announce()
		radiate()

	if(activeFor >= enterBelt && activeFor <= leaveBelt)
		postStartTicks++

	if(postStartTicks == radIntervall)
		postStartTicks = 0
		radiate()

	else if(activeFor == leaveBelt)
		using_map.radiation_storm_ending_announce()

/datum/event/radiation_storm/proc/radiate()
	for(var/mob/living/carbon/C in living_mob_list_)
		var/area/A = get_area(C)
		if(!A)
			continue
		if(!(A.z in using_map.station_levels))
			continue
		if(A.flags & RAD_SHIELDED)
			continue

		if(istype(C,/mob/living/carbon/human))
			var/mob/living/carbon/human/H = C
			H.apply_effect((rand(15,35)),IRRADIATE,blocked = H.getarmor(null, "rad"))
			if(prob(5))
				H.apply_effect((rand(40,70)),IRRADIATE,blocked = H.getarmor(null, "rad"))

/datum/event/radiation_storm/end()
	revoke_maint_all_access()

/datum/event/radiation_storm/syndicate/radiate()
	return
