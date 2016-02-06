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

	// Give them their rifle!
	if(!H.l_hand)
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/composite/premade/rifle/preloaded(H), slot_l_hand)
	else if(!H.r_hand)
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/composite/premade/rifle/preloaded(H), slot_r_hand)
	else if(!H.back)
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/composite/premade/rifle/preloaded(H), slot_back)
	else
		new /obj/item/weapon/gun/composite/premade/rifle(get_turf(H))

	// Give them a couple of spare rounds.
	if(!H.l_store) H.equip_to_slot_or_del(new /obj/item/ammo_casing/rifle_small(H), slot_l_store)
	if(!H.r_store) H.equip_to_slot_or_del(new /obj/item/ammo_casing/rifle_small(H), slot_r_store)

	return ..(H, 1,1,1)

/datum/job/borderworld/hunter/equip_survival(var/mob/living/carbon/human/H)
	return ..()