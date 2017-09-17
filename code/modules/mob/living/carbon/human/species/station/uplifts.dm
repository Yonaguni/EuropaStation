/datum/species/octopus
	name = "Octopus"
	name_plural = "Octopodes"
	blurb = "Octopus uplifts have been a relatively common sight in aquatic environments since the early days of \
	Sol expansion. The are renowned as excellent engineers, bartenders, and massage therapists."

	slowdown = 2
	rarity_value = 2
	gluttonous = GLUT_SMALLER
	unarmed_types = list(/datum/unarmed_attack/punch/tentacle, /datum/unarmed_attack/bite)

	// They don't live too long.
	min_age = 10
	max_age = 45

	num_alternate_languages = 2
	secondary_langs = list(LANGUAGE_SKRELLIAN)
	name_language = null

	icobase = 'icons/mob/human_races/r_octopus.dmi'
	deform = 'icons/mob/human_races/r_octopus.dmi'
	icon_template = 'icons/mob/human_races/r_octopus.dmi'

	/* todo
	icon_template = 'icons/mob/human_races/r_octopus.dmi'
	damage_overlays = 'icons/mob/human_races/masks/dam_octopus.dmi'
	damage_mask = 'icons/mob/human_races/masks/dam_mask_octopus.dmi'
	blood_mask = 'icons/mob/human_races/masks/blood_octopus.dmi'
	*/

	overlay_x_offset = 8
	icon_x_offset = -8

	blood_color = "#68a6dd"
	flesh_color = "#dd7b68"

	flags = NO_SCAN | NO_SLIP
	spawn_flags = SPECIES_IS_WHITELISTED | SPECIES_CAN_JOIN
	appearance_flags = HAS_SKIN_COLOR | HAS_EYE_COLOR

	has_organ = list(
		BP_HEART =    /obj/item/organ/internal/heart/octopus,
		BP_LUNGS =    /obj/item/organ/internal/lungs/octopus,
		BP_LIVER =    /obj/item/organ/internal/liver,
		BP_KIDNEYS =  /obj/item/organ/internal/kidneys,
		BP_BRAIN =    /obj/item/organ/internal/brain,
		BP_EYES =     /obj/item/organ/internal/eyes,
		)

	has_limbs = list(
		BP_CHEST =  list("path" = /obj/item/organ/external/chest/unbreakable/octopus),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin/unbreakable/octopus),
		BP_HEAD =   list("path" = /obj/item/organ/external/head/unbreakable/octopus),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm/unbreakable/octopus),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right/unbreakable/octopus),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg/unbreakable/octopus),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right/unbreakable/octopus),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand/unbreakable/octopus),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right/unbreakable/octopus),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot/unbreakable/octopus),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right/unbreakable/octopus)
		)

	hud_type = /datum/hud_data/octopus

/datum/species/octopus/can_prone()
	return 0

/datum/species/octopus/get_slowdown(var/atom/loc)
	return (loc.is_flooded() ? -1 : slowdown)

//todo
/datum/hud_data/octopus
	gear = list(
		"i_clothing" =   list("loc" = ui_iclothing, "name" = "Uniform",      "slot" = slot_w_uniform, "state" = "center", "toggle" = 1),
		"o_clothing" =   list("loc" = ui_mask,      "name" = "Suit",         "slot" = slot_wear_suit, "state" = "suit",   "toggle" = 1),
		"eyes" =         list("loc" = ui_glasses,   "name" = "Glasses",      "slot" = slot_glasses,   "state" = "glasses","toggle" = 1),
		"head" =         list("loc" = ui_head,      "name" = "Hat",          "slot" = slot_head,      "state" = "hair",   "toggle" = 1),
		"suit storage" = list("loc" = ui_sstore1,   "name" = "Suit Storage", "slot" = slot_s_store,   "state" = "suitstore"),
		"back" =         list("loc" = ui_back,      "name" = "Back",         "slot" = slot_back,      "state" = "back"),
		"id" =           list("loc" = ui_id,        "name" = "ID",           "slot" = slot_wear_id,   "state" = "id"),
		"storage1" =     list("loc" = ui_storage1,  "name" = "Left Pocket",  "slot" = slot_l_store,   "state" = "pocket"),
		"storage2" =     list("loc" = ui_storage2,  "name" = "Right Pocket", "slot" = slot_r_store,   "state" = "pocket"),
		"belt" =         list("loc" = ui_belt,      "name" = "Belt",         "slot" = slot_belt,      "state" = "belt")
		)

/datum/species/corvid
	name = "Neo-Corvid"
	name_plural = "Neo-Corvidae"
	blurb = "Corvid uplifts were among the first sophonts produced by human science to aid in colonizing Mars. These days they \
	are more commonly found pursuing their own careers and goals on the fringes of human space or around their adopted homeworld \
	of Hyperion."

	num_alternate_languages = 2
	secondary_langs = list(LANGUAGE_RESOMI)
	name_language = LANGUAGE_RESOMI
	min_age = 12
	max_age = 45
	health_hud_intensity = 3

	base_color = "#000616"
	base_hair_color = "#000a28"
	has_default_hair = "Neo-Corvid Plumage"

	tail = "resomitail"
	tail_hair = "feathers"
	reagent_tag = IS_RESOMI

	icobase = 'icons/mob/human_races/r_resomi.dmi'
	deform = 'icons/mob/human_races/r_resomi.dmi'
	damage_overlays = 'icons/mob/human_races/masks/dam_resomi.dmi'
	damage_mask = 'icons/mob/human_races/masks/dam_mask_resomi.dmi'
	blood_mask = 'icons/mob/human_races/masks/blood_resomi.dmi'

	slowdown = -1
	total_health = 50
	brute_mod = 1.35
	burn_mod =  1.35
	mob_size = MOB_SMALL
	holder_type = /obj/item/holder/human
	gluttonous = GLUT_TINY
	blood_volume = 280
	hunger_factor = 0.2

	spawn_flags = SPECIES_IS_WHITELISTED | SPECIES_CAN_JOIN
	appearance_flags = HAS_HAIR_COLOR | HAS_SKIN_COLOR | HAS_EYE_COLOR
	bump_flag = MONKEY
	swap_flags = MONKEY|SLIME|SIMPLE_ANIMAL
	push_flags = MONKEY|SLIME|SIMPLE_ANIMAL|ALIEN

	heat_discomfort_strings = list(
		"Your feathers prickle in the heat.",
		"You feel uncomfortably warm.",
		)

	has_limbs = list(
		BP_CHEST =  list("path" = /obj/item/organ/external/chest),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin),
		BP_HEAD =   list("path" = /obj/item/organ/external/head/resomi),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand/resomi),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right/resomi),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot/resomi),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right/resomi)
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
