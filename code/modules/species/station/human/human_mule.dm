/datum/species/human/mule
	name = SPECIES_MULE
	name_plural = "Mules"
	blurb = "There are a huge number of 'uncurated' genetic lines in Sol, many of which fall under the \
	general header of baseline humanity. One particular genotype, though, is remarkable for both being \
	deeply feral, in the sense that it still has many of the inherited diseases and weaknesses that plagued \
	pre-exodus humanity, and for a strange affinity for psionic operancy. The Mules, as they are called, are \
	physically diminutive and unimposing, with scrawny, often deformed bodies but inhumanly powerful minds."
	associated_faction = FACTION_OUTER_SYSTEM
	economic_modifier = 0.8

	brute_mod =     1.15
	burn_mod =      1.15
	oxy_mod =       1.15
	toxins_mod =    1.15
	radiation_mod = 1.15
	flash_mod =     1.15

/datum/species/human/mule/handle_post_spawn(var/mob/living/carbon/human/H)

	if(!H.psi)
		H.psi = new(H)
		var/list/faculties = list("[PSI_COERCION]", "[PSI_REDACTION]", "[PSI_ENERGISTICS]", "[PSI_PSYCHOKINESIS]")
		for(var/i = 1 to rand(2,3))
			H.set_psi_rank(pick_n_take(faculties), 1)
	H.psi.max_stamina = 70

	var/obj/item/organ/external/E = pick(H.organs)
	if(E.robotic < ORGAN_ROBOT) E.mutate()
