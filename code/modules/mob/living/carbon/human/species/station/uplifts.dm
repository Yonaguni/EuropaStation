/datum/species/octopus
	name = "Octopus"
	name_plural = "Octopodes"
	blurb = "Octopus uplifts have been a relatively common sight in aquatic environments since the early days of \
	Sol expansion. The are renowned as excellent engineers, bartenders, and massage therapists."

	meat_type = /obj/item/reagent_containers/food/snacks/meat/fish/octopus

	slowdown = 2
	rarity_value = 2
	gluttonous = GLUT_SMALLER
	unarmed_types = list(/datum/unarmed_attack/punch/tentacle, /datum/unarmed_attack/bite)

	// They don't live too long.
	min_age = 10
	max_age = 45

	num_alternate_languages = 2
	secondary_langs = list(LANGUAGE_CEPHLAPODA)
	name_language = null

	icobase = 'icons/mob/human_races/r_octopus.dmi'
	deform = 'icons/mob/human_races/r_octopus.dmi'
	icon_template = 'icons/mob/human_races/r_octopus.dmi'

	damage_overlays = 'icons/mob/human_races/masks/dam_octopus.dmi'
	damage_mask = 'icons/mob/human_races/masks/dam_mask_octopus.dmi'
	blood_mask = 'icons/mob/human_races/masks/blood_octopus.dmi'

	overlay_x_offset = 8
	icon_x_offset = -8

	blood_color = "#68a6dd"
	flesh_color = "#dd7b68"

	flags = NO_SCAN | NO_SLIP
	spawn_flags = SPECIES_CAN_JOIN
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

	var/list/camo_last_move_by_mob = list()
	var/list/camo_last_alpha_by_mob = list()
	var/const/camo_delay = 10 SECONDS
	var/const/camo_alpha_step = 10
	var/const/camo_min_alpha = 35

/datum/species/octopus/can_prone()
	return 0

/datum/species/octopus/proc/update_mob_alpha(var/mob/living/carbon/human/H, var/newval = 255)
	if(camo_last_alpha_by_mob[H] == newval)
		return
	camo_last_alpha_by_mob[H] = newval
	var/need_update
	for(var/thing in H.organs)
		var/obj/item/organ/external/limb = thing
		if(limb.species == src && limb.render_alpha != newval)
			limb.render_alpha = newval
			need_update = 1
	if(need_update)
		H.update_body()

/datum/species/octopus/handle_post_spawn(var/mob/living/carbon/H)
	. = ..()
	camo_last_alpha_by_mob[H] = 255
	camo_last_move_by_mob[H] = world.time

/datum/species/octopus/get_slowdown(var/mob/living/carbon/human/H)
	return (H && H.loc && H.loc.is_flooded() ? -1 : slowdown)

/datum/species/octopus/handle_post_move(var/mob/living/carbon/human/H)
	camo_last_move_by_mob[H] = world.time
	update_mob_alpha(H, min(camo_last_alpha_by_mob[H] + camo_min_alpha, 255))

/datum/species/octopus/handle_environment_special(var/mob/living/carbon/human/H)
	var/last_alpha = camo_last_alpha_by_mob[H]
	if(world.time >= camo_last_move_by_mob[H]+camo_delay && last_alpha > camo_min_alpha)
		update_mob_alpha(H, max(camo_min_alpha, last_alpha-camo_alpha_step))

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
	of Hyperion. Corvid naming conventions are a chosen name followed by the species of the person, followed by the location they were hatched."

	meat_type = /obj/item/reagent_containers/food/snacks/meat/fish/chicken
	num_alternate_languages = 2
	secondary_langs = list(LANGUAGE_CORVID)
	name_language = LANGUAGE_CORVID
	min_age = 12
	max_age = 45
	health_hud_intensity = 3

	base_color = "#000616"
	base_hair_color = "#000a28"
	has_default_hair = "Neo-Corvid Plumage"

	tail = "corvidtail"
	tail_hair = "feathers"
	reagent_tag = IS_CORVID

	icobase = 'icons/mob/human_races/r_corvid.dmi'
	deform = 'icons/mob/human_races/r_corvid.dmi'
	damage_overlays = 'icons/mob/human_races/masks/dam_corvid.dmi'
	damage_mask = 'icons/mob/human_races/masks/dam_mask_corvid.dmi'
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
	swap_flags = MONKEY|SLIME|SIMPLE_ANIMAL
	push_flags = MONKEY|SLIME|SIMPLE_ANIMAL|ALIEN

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
