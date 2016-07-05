/datum/job/borderworld/scrapper
	title = "Scrapper"
	job_category = IS_INDUSTRY
	total_positions = 2
	spawn_positions = 2
	alt_titles = list("Salvager","Scav","Archaeologist")
	selection_color = "#ffeeff"

/datum/job/borderworld/scrapper/equip(var/mob/living/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0, var/alt_rank)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/syndicate(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/det_trench(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/workboots(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/utility/full(H), slot_belt)
	H.equip_to_slot_or_del(new /obj/item/weapon/pickaxe/plasmacutter(H), slot_s_store)
	H.equip_to_slot_or_del(new /obj/item/device/wrist_computer(H), slot_wear_id)
	return ..(H,1,1,1)

/datum/job/borderworld/scrapper/equip_survival(var/mob/living/human/H)
	return ..()