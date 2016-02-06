/datum/job/borderworld/doctor
	title = "Doctor"
	job_category = IS_CIVIL
	total_positions = 1
	spawn_positions = 1
	alt_titles = list("Sawbones","Medic","Surgeon")
	supervisors = "the Hippocratic Oath"
	selection_color = "#ffeeff"

/datum/job/borderworld/doctor/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/europa/fatigues(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/toggle/labcoat(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/fancy/cigarettes(H), slot_l_store)
	H.equip_to_slot_or_del(new /obj/item/weapon/flame/lighter/zippo(H), slot_r_store)
	return ..(H, 1, 1)

/datum/job/borderworld/doctor/equip_survival(var/mob/living/carbon/human/H)
	return ..()