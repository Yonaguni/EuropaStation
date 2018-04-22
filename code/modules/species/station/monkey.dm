/datum/species/monkey
	name = "Monkey"
	name_plural = "Monkeys"
	blurb = "Ook."
	bodytype = BODYTYPE_MONKEY

	icobase = 'icons/mob/human_races/r_monkey.dmi'
	deform = 'icons/mob/human_races/r_monkey.dmi'
	damage_overlays = 'icons/mob/human_races/masks/dam_monkey.dmi'
	blood_mask = 'icons/mob/human_races/masks/blood_monkey.dmi'

	force_faction =   /datum/faction/test_subjects
	force_homeworld = /datum/stellar_location/earth

	greater_form = DEFAULT_SPECIES
	mob_size = MOB_SMALL
	has_fine_manipulation = 0
	show_ssd = null
	health_hud_intensity = 1.75
	economic_modifier = 0

	gibbed_anim = "gibbed-m"
	dusted_anim = "dust-m"
	death_message = "lets out a faint chimper as it collapses and stops moving..."
	tail = "chimptail"
	baldness_noun = "fur"

	unarmed_types = list(/datum/unarmed_attack/bite, /datum/unarmed_attack/claws)
	inherent_verbs = list(/mob/living/proc/ventcrawl)
	hud_type = /datum/hud_data/monkey
	meat_type = /obj/item/reagent_containers/food/snacks/meat/monkey

	rarity_value = 0.1
	total_health = 75
	brute_mod = 1.5
	burn_mod = 1.5

	spawn_flags = SPECIES_IS_RESTRICTED

	bump_flag = MONKEY
	swap_flags = MONKEY|SIMPLE_ANIMAL
	push_flags = MONKEY|SIMPLE_ANIMAL

	pass_flags = PASSTABLE
	holder_type = /obj/item/holder
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

/datum/species/monkey/handle_npc(var/mob/living/carbon/human/H)
	if(H.stat != CONSCIOUS)
		return
	if(prob(33) && H.canmove && isturf(H.loc) && !LAZYLEN(H.grabbed_by)) //won't move if being pulled
		step(H, pick(cardinal))
	if(prob(1))
		H.emote(pick("scratch","jump","roll","tail"))

/datum/species/monkey/handle_post_spawn(var/mob/living/carbon/human/H)
	. = ..(H)
	H.real_name = "[lowertext(name)] ([rand(100,999)])"
	H.name = H.real_name
	if(H.mind) H.mind.name = H.real_name
