// Leaving this in but inaccessible so that it can be proccalled.
/mob/living/proc/give_all_powers()
	for(var/thing in psychic_faculties)
		qdel(psychic_faculties[thing])
	psychic_faculties.Cut()
	for(var/pname in all_psychic_faculties)
		var/datum/psychic_power_assay/assay = new(src, all_psychic_faculties[pname])
		psychic_faculties[assay.associated_faculty.name] = assay
		assay.set_rank(assay.associated_faculty.powers.len)
