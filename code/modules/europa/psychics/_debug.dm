// Leaving this in but inaccessible so that it can be proccalled.
/mob/living/proc/give_all_powers()
	if(!mind)
		return
	for(var/thing in mind.psychic_faculties)
		qdel(mind.psychic_faculties[thing])
	mind.psychic_faculties.Cut()
	for(var/pname in all_psychic_faculties)
		var/datum/psychic_power_assay/assay = new(mind, all_psychic_faculties[pname])
		mind.psychic_faculties[assay.associated_faculty.name] = assay
		assay.set_rank(assay.associated_faculty.powers.len)
