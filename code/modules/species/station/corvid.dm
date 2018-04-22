/datum/species/corvid
	name = SPECIES_CORVID
	bodytype = BODYTYPE_CORVID
	name_plural = "Corvidae"
	blurb = "Corvid uplifts were among the first sophonts produced by human science to aid in colonizing Mars. These days they \
	are more commonly found pursuing their own careers and goals on the fringes of human space or around their adopted homeworld \
	of Hyperion. Corvid naming conventions are a chosen name followed by the species of the person, followed by the location they were hatched."

	meat_type = /obj/item/reagent_containers/food/snacks/meat/fish/chicken
	min_age = 12
	max_age = 45
	health_hud_intensity = 3
	economic_modifier = 0.5
	baldness_noun = "feathers"

	associated_faction = FACTION_NONHUMAN_BLOC

	base_color = "#000616"
	base_hair_color = "#000a28"
	has_default_hair = "Corvid Plumage"

	tail = "corvidtail"
	tail_hair = "feathers"
	reagent_tag = IS_CORVID

	icobase = 'icons/mob/human_races/r_corvid.dmi'
	deform = 'icons/mob/human_races/r_corvid.dmi'
	damage_overlays = 'icons/mob/human_races/masks/dam_corvid.dmi'
	blood_mask = 'icons/mob/human_races/masks/blood_corvid.dmi'

	total_health = 80
	brute_mod = 1.35
	burn_mod =  1.35
	mob_size = MOB_SMALL
	holder_type = /obj/item/holder/human
	gluttonous = GLUT_TINY
	blood_volume = 320
	hunger_factor = 0.1

	spawn_flags = SPECIES_CAN_JOIN
	appearance_flags = HAS_HAIR_COLOR | HAS_SKIN_COLOR | HAS_EYE_COLOR
	bump_flag = MONKEY
	swap_flags = MONKEY|SIMPLE_ANIMAL
	push_flags = MONKEY|SIMPLE_ANIMAL

	heat_discomfort_strings = list(
		"Your feathers prickle in the heat.",
		"You feel uncomfortably warm.",
		)

	has_limbs = list(
		BP_CHEST =  list("path" = /obj/item/organ/external/chest),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin),
		BP_HEAD =   list("path" = /obj/item/organ/external/head/corvid),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand/corvid),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right/corvid),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot/corvid),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right/corvid)
		)

	has_organ = list(
		BP_HEART =    /obj/item/organ/internal/heart,
		BP_LUNGS =    /obj/item/organ/internal/lungs,
		BP_LIVER =    /obj/item/organ/internal/liver,
		BP_KIDNEYS =  /obj/item/organ/internal/kidneys,
		BP_BRAIN =    /obj/item/organ/internal/brain,
		BP_EYES =     /obj/item/organ/internal/eyes
		)

	unarmed_types = list(
		/datum/unarmed_attack/bite/sharp,
		/datum/unarmed_attack/claws,
		/datum/unarmed_attack/stomp/weak
		)
