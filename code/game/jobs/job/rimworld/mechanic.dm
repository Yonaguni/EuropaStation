/datum/job/borderworld/mechanic
	title = "Mechanic"
	job_category = IS_INDUSTRY
	total_positions = 3
	spawn_positions = 3
	alt_titles = list("Engineer", "Builder")
	selection_color = "#ffeeff"

/datum/job/borderworld/mechanic/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	H.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses(H), slot_glasses)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/mechanic(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/workboots(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/utility/full(H), slot_belt)
	H.equip_to_slot_or_del(new /obj/item/device/wrist_computer(H), slot_wear_id)
	return ..(H,1,1,1)

/datum/job/borderworld/mechanic/equip_survival(var/mob/living/carbon/human/H)
	return ..()