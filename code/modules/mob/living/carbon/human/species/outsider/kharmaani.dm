/datum/species/kharmaani
	name = "Mantid Alate"
	name_plural = "Mantid Alates"
	blurb = "When human scientists finally arrived on Europa, they hoped, at best, to find single-celled life, or traces of past life. They \
	were largely not expecting to have expeditions lost amid reports of highly advanced, astonishingly violent mantid-cephlapodean sentients."

	icobase = 'icons/mob/human_races/kharmaani/r_alate.dmi'
	deform = 'icons/mob/human_races/kharmaani/r_alate.dmi'
	damage_overlays = 'icons/mob/human_races/masks/dam_kharmaani_alate.dmi'
	damage_mask = 'icons/mob/human_races/masks/dam_mask_kharmaani_alate.dmi'
	blood_mask = 'icons/mob/human_races/masks/blood_kharmaani_alate.dmi'

	has_limbs = list(
		BP_CHEST =  list("path" = /obj/item/organ/external/chest),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin),
		BP_HEAD =   list("path" = /obj/item/organ/external/head/no_eyes),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right)
		)

	slowdown = -1
	rarity_value = 3

	language = "Mantid Nonvocal"
	default_language = "Mantid Nonvocal"
	secondary_langs = list("Worldnet", "Mantid Vocal")
	hud_type = /datum/hud_data/kharmaani

	gluttonous = 2
	unarmed_types = list(/datum/unarmed_attack/claws/strong, /datum/unarmed_attack/bite/sharp)
	siemens_coefficient = 0
	num_alternate_languages = 1

	blood_color = "#660066"
	flesh_color = "#009999"

	flags = NO_SCAN | NO_SLIP
	spawn_flags = SPECIES_IS_RESTRICTED

	inherent_verbs = list(
		/mob/living/carbon/human/proc/leap,
		/mob/living/carbon/human/proc/gut
		)

/datum/species/kharmaani/gyne
	name = "Mantid Gyne"
	name_plural = "Mantid Gynes"
	gluttonous = 3
	slowdown = 2
	num_alternate_languages = 2
	rarity_value = 10

	icobase = 'icons/mob/human_races/kharmaani/r_gyne.dmi'
	deform = 'icons/mob/human_races/kharmaani/r_gyne.dmi'
	icon_template = 'icons/mob/human_races/kharmaani/r_gyne.dmi'
	damage_overlays = 'icons/mob/human_races/masks/dam_kharmaani_gyne.dmi'
	damage_mask = 'icons/mob/human_races/masks/dam_mask_kharmaani_gyne.dmi'
	blood_mask = 'icons/mob/human_races/masks/blood_kharmaani_gyne.dmi'

	overlay_x_offset = 22
	overlay_y_offset = 10

	icon_y_offset = -12
	icon_x_offset = -22

	inherent_verbs = list(
		/mob/living/carbon/human/proc/gut,
		/mob/living/carbon/human/proc/devour_head
		)

//todo
/datum/hud_data/kharmaani
	gear = list(
		"i_clothing" =   list("loc" = ui_iclothing, "name" = "Uniform",      "slot" = slot_w_uniform, "state" = "center", "toggle" = 1),
		"o_clothing" =   list("loc" = ui_oclothing, "name" = "Suit",         "slot" = slot_wear_suit, "state" = "suit",   "toggle" = 1),
		"mask" =         list("loc" = ui_mask,      "name" = "Mask",         "slot" = slot_wear_mask, "state" = "mask",   "toggle" = 1),
		"gloves" =       list("loc" = ui_gloves,    "name" = "Gloves",       "slot" = slot_gloves,    "state" = "gloves", "toggle" = 1),
		"eyes" =         list("loc" = ui_glasses,   "name" = "Glasses",      "slot" = slot_glasses,   "state" = "glasses","toggle" = 1),
		"l_ear" =        list("loc" = ui_l_ear,     "name" = "Left Ear",     "slot" = slot_l_ear,     "state" = "ears",   "toggle" = 1),
		"r_ear" =        list("loc" = ui_r_ear,     "name" = "Right Ear",    "slot" = slot_r_ear,     "state" = "ears",   "toggle" = 1),
		"head" =         list("loc" = ui_head,      "name" = "Hat",          "slot" = slot_head,      "state" = "hair",   "toggle" = 1),
		"shoes" =        list("loc" = ui_shoes,     "name" = "Shoes",        "slot" = slot_shoes,     "state" = "shoes",  "toggle" = 1),
		"suit storage" = list("loc" = ui_sstore1,   "name" = "Suit Storage", "slot" = slot_s_store,   "state" = "suitstore"),
		"back" =         list("loc" = ui_back,      "name" = "Back",         "slot" = slot_back,      "state" = "back"),
		"id" =           list("loc" = ui_id,        "name" = "ID",           "slot" = slot_wear_id,   "state" = "id"),
		"storage1" =     list("loc" = ui_storage1,  "name" = "Left Pocket",  "slot" = slot_l_store,   "state" = "pocket"),
		"storage2" =     list("loc" = ui_storage2,  "name" = "Right Pocket", "slot" = slot_r_store,   "state" = "pocket"),
		"belt" =         list("loc" = ui_belt,      "name" = "Belt",         "slot" = slot_belt,      "state" = "belt")
		)
