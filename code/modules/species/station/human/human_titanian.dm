/datum/species/human/titanian
	name = SPECIES_TITANIAN
	name_plural = "Titanians"
	blurb = "Of all human strains, the Titanian genotype is probably the most wildly divergent from \
	baseline humanity. Conceived alongside the dolphin and octopode uplift projects, the Titanians \
	are adapted for amphibious life on the flooded ocean moon of Titan, but are equally comfortable in \
	a range of aquatic environments. Their genotype features thick blue-grey skin with a layer of dense \
	blubber for warmth, as well as neck gills that allow them to breathe easily underwater. Titanians are \
	largely shunned in the inner system but maintain a thriving multicultural population on their ocean moon."
	economic_modifier = 0.8
	associated_faction = FACTION_FIRST_WAVE
	icobase = 'icons/mob/human_races/r_titanian.dmi'

	oxy_mod =           0.5
	toxins_mod =        1.15
	radiation_mod =     1.15
	body_temperature =  302
	slowdown =          1

	has_organ = list(
		BP_HEART =    /obj/item/organ/internal/heart,
		BP_LUNGS =    /obj/item/organ/internal/lungs/aquatic,
		BP_LIVER =    /obj/item/organ/internal/liver,
		BP_KIDNEYS =  /obj/item/organ/internal/kidneys,
		BP_BRAIN =    /obj/item/organ/internal/brain,
		BP_APPENDIX = /obj/item/organ/internal/appendix,
		BP_EYES =     /obj/item/organ/internal/eyes,
		BP_STOMACH =  /obj/item/organ/internal/stomach
		)

/datum/species/human/titanian/get_slowdown(var/mob/living/carbon/human/H)
	return (H && H.loc && H.loc.is_flooded() ? -1 : slowdown)