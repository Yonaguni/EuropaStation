/datum/job/borderworld/miner
	title = "Miner"
	job_category = IS_INDUSTRY
	total_positions = 2
	spawn_positions = 2
	alt_titles = list("Prospector", "Surveyor")
	selection_color = "#ffeeff"

/datum/job/borderworld/miner/equip(var/mob/living/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/miner(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/hardhat/orange(H), slot_head)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/workboots(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/weapon/pickaxe(H), slot_l_hand)
	H.equip_to_slot_or_del(new /obj/item/device/flashlight/lantern(H), slot_l_store)
	H.equip_to_slot_or_del(new /obj/item/weapon/shovel(H), slot_belt)
	return ..(H,1,1,1)

/datum/job/borderworld/miner/equip_survival(var/mob/living/human/H)
	return ..()