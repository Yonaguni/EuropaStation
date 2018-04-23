/datum/species/human/nonborn
	name = SPECIES_NONBORN
	name_plural = "Nonborns"
	blurb = "With cloning a mastered art in the 2200s, cheap mass production of bodies is a very real \
	and ethically grey industry. Colonies struck by disaster will often end up placing large orders with \
	Pandoran corporations for clones to replace their workforce rather than investing in expensive AI \
	drones.<br><br>Cloned humans are generally called 'nonborns' as a result of the AI-run wombs that \
	produce them, and tend to be pale, with no appendix and fewer inherited genetic disabilities. This \
	comes at the cost of a weakened immune system and metabolism. Many nonborns resent the soulless \
	nature of their 'production' and end up finding work as spacers and labourers in isolated parts of \
	the system."
	economic_modifier = 0.5
	icobase = 'icons/mob/human_races/r_vatgrown.dmi'

	brute_mod =     1.15
	toxins_mod =    1.15
	flash_mod =     0.8
	radiation_mod = 0.8

	has_organ = list(
		BP_HEART =    /obj/item/organ/internal/heart,
		BP_LUNGS =    /obj/item/organ/internal/lungs,
		BP_LIVER =    /obj/item/organ/internal/liver,
		BP_KIDNEYS =  /obj/item/organ/internal/kidneys,
		BP_BRAIN =    /obj/item/organ/internal/brain,
		BP_EYES =     /obj/item/organ/internal/eyes
		)
