/datum/job/borderworld/merchant
	title = "Merchant"
	job_category = IS_CIVIL
	total_positions = 3
	spawn_positions = 3
	alt_titles = list("Trader", "Banker")
	selection_color = "#ccccff"

/datum/job/borderworld/merchant/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/merchant(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup, slot_shoes)
	return ..(H,1,1,1)

/datum/job/borderworld/merchant/equip_survival(var/mob/living/carbon/human/H)
	return ..()