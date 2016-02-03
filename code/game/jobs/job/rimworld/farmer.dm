/datum/job/borderworld/farmer
	title = "Farmer"
	job_category = IS_CIVIL
	total_positions = 3
	spawn_positions = 3

/datum/job/borderworld/farmer/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sandal(H),slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/europa/farmer(H),slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses(H),slot_glasses)
	return ..(H,1,1,1)

/datum/job/borderworld/farmer/equip_survival(var/mob/living/carbon/human/H)
	return ..()