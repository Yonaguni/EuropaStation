/datum/job/borderworld/governor
	title = "Governor"
	job_category = IS_GOVERNMENT
	total_positions = 1
	spawn_positions = 1
	selection_color = "#ccccff"

/datum/job/borderworld/governor/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(H),slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/governor(H),slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/fez(H),slot_head)
	return ..(H,1,1,1)

/datum/job/borderworld/governor/equip_survival(var/mob/living/carbon/human/H)
	return ..()
