/datum/job/borderworld/hunter
	title = "Hunter"
	job_category = IS_CIVIL
	total_positions = 2
	spawn_positions = 2
	alt_titles = list("Forager")

/datum/job/borderworld/hunter/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/sl_suit(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/europa/hunter(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/weapon/material/hatchet/tacknife/hunting(H), slot_belt)
	// Needs to spawn with a rifle.
	return ..(H, 1,1,1)

/datum/job/borderworld/hunter/equip_survival(var/mob/living/carbon/human/H)
	return ..()