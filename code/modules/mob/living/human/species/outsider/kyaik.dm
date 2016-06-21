/datum/species/kyaik
	name = "Kyaik"
	name_plural = "Kyaik"
	icobase = 'icons/mob/human_races/r_kyaik.dmi'
	deform = 'icons/mob/human_races/r_kyaik.dmi'
	blurb = "A race of snakelike sapients from somewhere beyond Sol. Not particularly friendly, but often willing to trade goods and services with colonists on the rim."

	tail_stance = 1
	tail_length = 2

	total_health = 200
	blood_volume = 700
	mob_size = MOB_LARGE
	gluttonous = 3
	vision_flags = SEE_SELF | SEE_MOBS
	rarity_value = 8
	slowdown = -1 // Compensating for a total inability to wear shoes.

	cold_level_1 = 280
	cold_level_2 = 220
	cold_level_3 = 130
	heat_level_1 = 420
	heat_level_2 = 480
	heat_level_3 = 1100
	heat_discomfort_level = 295
	heat_discomfort_strings = list(
		"You feel soothingly warm.",
		"You feel the heat sink into your bones.",
		"You feel warm enough to take a nap."
		)
	cold_discomfort_level = 292
	cold_discomfort_strings = list(
		"You feel chilly.",
		"You feel sluggish and cold.",
		"Your scales bristle against the cold."
		)
	// End lizard copypaste.

	hud_type = /datum/hud_data/snake
	unarmed_types = list(
		/datum/unarmed_attack/bite/sharp,
		/datum/unarmed_attack/claws
		)

	num_alternate_languages = 2
	secondary_langs = list()
	name_language = null

	spawn_flags = CAN_JOIN | IS_WHITELISTED
	appearance_flags = HAS_HAIR_COLOR | HAS_SKIN_COLOR | HAS_EYE_COLOR

	inherent_verbs = list(
		/mob/living/human/proc/coil_up
		)

	/*
	flesh_color = "#8CD7A3"
	blood_color = "#1D2CBF"
	base_color = "#006666"
	reagent_tag = IS_SKRELL
	*/

	has_limbs = list(
		BP_TORSO =  list("path" = /obj/item/organ/external/chest/snake),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin/snake),
		BP_HEAD =   list("path" = /obj/item/organ/external/head/snake),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right)
		)

/datum/species/kyaik
	autohiss_basic_map = list(
			"s" = list("ssss", "sssss", "ssssss"),
			"c" = list("cksss", "ckssss", "cksssss"),
			"k" = list("ksss", "kssss", "ksssss"),
			"x" = list("ksss", "kssss", "ksssss")
		)