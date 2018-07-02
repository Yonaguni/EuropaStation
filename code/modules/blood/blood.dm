/proc/get_blood(datum/reagents/container)
	if(istype(container.my_atom, /mob/living/carbon))
		var/mob/living/carbon/C = container.my_atom
		return C.get_blood(container)
	for(var/rid in container.volumes)
		var/datum/reagent/blood/D = SSchemistry.get_reagent(rid)
		if(istype(D)) return D
	return null
