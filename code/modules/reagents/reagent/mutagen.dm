/datum/reagent/mutagen
	name = "Unstable mutagen"
	id = "mutagen"
	description = "Might cause unpredictable mutations. Keep away from children."
	reagent_state = LIQUID
	color = "#13BC5E"

/datum/reagent/mutagen/affect_touch(var/mob/living/carbon/M, var/alien, var/removed)
	if(prob(33))
		affect_blood(M, alien, removed)

/datum/reagent/mutagen/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	if(prob(67))
		affect_blood(M, alien, removed)

/datum/reagent/mutagen/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)

	if(M.isSynthetic())
		return

	var/mob/living/carbon/human/H = M
	if(istype(H) && (H.species.flags & NO_SCAN))
		return

	if(M.dna)
		if(prob(removed * 0.1)) // Approx. one mutation per 10 injected/20 ingested/30 touching units
			randmuti(M)
			if(prob(98))
				randmutb(M)
			else
				randmutg(M)
			domutcheck(M, null)
			M.UpdateAppearance()
	M.apply_effect(10 * removed, IRRADIATE, 0)