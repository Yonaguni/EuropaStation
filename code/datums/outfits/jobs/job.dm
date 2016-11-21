/decl/hierarchy/outfit/job
	name = "Standard Gear"
	hierarchy_type = /decl/hierarchy/outfit/job

	uniform = /obj/item/clothing/under/aeolus/crewman
	back = /obj/item/storage/backpack
	shoes = /obj/item/clothing/shoes/black

	id_slot = slot_l_hand
	id_type = /obj/item/card/id/civilian
	pda_slot = slot_wear_id
	pda_type = /obj/item/device/radio/headset/pda

	var/backpack = /obj/item/storage/backpack
	var/satchel_one  = /obj/item/storage/backpack/satchel_norm
	var/satchel_two  = /obj/item/storage/backpack/satchel

/decl/hierarchy/outfit/job/pre_equip(mob/living/carbon/human/H)
	..()
	switch(H.backbag)
		if(2) back = satchel_one
		if(3) back = satchel_two
		if(4) back = backpack
		else back = null

/decl/hierarchy/outfit/job/equip_id(mob/living/carbon/human/H)
	var/obj/item/card/id/C = ..()
	if(C && H.mind && H.mind.initial_account)
		C.associated_account_number = H.mind.initial_account.account_number
	return C
