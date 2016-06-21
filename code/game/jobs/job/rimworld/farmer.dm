/datum/job/borderworld/farmer
	title = "Farmer"
	job_category = IS_CIVIL
	total_positions = 3
	spawn_positions = 3

/datum/job/borderworld/farmer/equip(var/mob/living/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sandal(H),slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/farmer(H),slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses(H),slot_glasses)
	H.equip_to_slot_or_del(new /obj/item/weapon/shovel(H), slot_belt)
	//H.equip_to_slot_or_del(new /obj/item/weapon/reagent_containers/food/snacks/grown/wheat(H), slot_mask) // needs an onmob sprite.
	return ..(H,1,1,1)

/datum/job/borderworld/farmer/equip_survival(var/mob/living/human/H)
	return ..()