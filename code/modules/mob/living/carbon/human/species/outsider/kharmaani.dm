/datum/species/kharmaani
	name = "Kharmaan alate"
	name_plural = "Kharmaan alates"

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

	language = "Kharmaani Nonvocal"
	default_language = "Kharmaani Nonvocal"
	secondary_langs = list("Kharmaani Vocal", "Skrellian")
	hud_type = /datum/hud_data/kharmaani

	gluttonous = 2
	unarmed_types = list(/datum/unarmed_attack/claws/strong, /datum/unarmed_attack/bite/sharp)
	siemens_coefficient = 0
	num_alternate_languages = 0

	blood_color = "#660066"
	flesh_color = "#009999"

	flags = IS_RESTRICTED | NO_SCAN | NO_SLIP

	inherent_verbs = list(
		/mob/living/carbon/human/proc/leap,
		/mob/living/carbon/human/proc/gut
		)

/datum/species/kharmaani/gyne
	name = "Kharmaan gyne"
	name_plural = "Kharmaan gynes"
	gluttonous = 3
	slowdown = 2
	num_alternate_languages = 1
	rarity_value = 10

	icobase = 'icons/mob/human_races/kharmaani/r_gyne.dmi'
	deform = 'icons/mob/human_races/kharmaani/r_gyne.dmi'
	icon_template = 'icons/mob/human_races/kharmaani/r_gyne.dmi'
	damage_overlays = 'icons/mob/human_races/masks/dam_kharmaani_gyne.dmi'
	damage_mask = 'icons/mob/human_races/masks/dam_mask_kharmaani_gyne.dmi'
	blood_mask = 'icons/mob/human_races/masks/blood_kharmaani_gyne.dmi'

	icon_x_offset = -22

	inherent_verbs = list(
		/mob/living/carbon/human/proc/gut,
		/mob/living/carbon/human/proc/devour_head
		)

/datum/hud_data/kharmaani
	gear = list(
		"o_clothing" =   list("loc" = ui_shoes,     "name" = "Suit",         "slot" = slot_wear_suit, "state" = "suit",   "toggle" = 1),
		"head" =         list("loc" = ui_head,      "name" = "Hat",          "slot" = slot_head,      "state" = "hair",   "toggle" = 1),
		"mask" =         list("loc" = ui_mask,      "name" = "Mask",         "slot" = slot_wear_mask, "state" = "mask",   "toggle" = 1),
		"eyes" =         list("loc" = ui_glasses,   "name" = "Glasses",      "slot" = slot_glasses,   "state" = "glasses","toggle" = 1),
		"back" =         list("loc" = ui_oclothing, "name" = "Back",         "slot" = slot_back,      "state" = "back",   "toggle" = 1),
		"belt" =         list("loc" = ui_l_ear,     "name" = "Belt",         "slot" = slot_belt,      "state" = "belt",   "toggle" = 1)
		)
