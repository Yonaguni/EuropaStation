/decl/hierarchy/outfit/job
	name = "Standard Gear"
	hierarchy_type = /decl/hierarchy/outfit/job

	uniform = /obj/item/clothing/under/lower/pants/beige/navy_uniform
	back = /obj/item/storage/backpack
	shoes = /obj/item/clothing/shoes/black

	id_slot = slot_l_hand
	id_type = /obj/item/card/id/civilian
	pda_slot = slot_wear_id
	pda_type = /obj/item/radio/headset/pda

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

/decl/hierarchy/outfit/job/crewman
	name = OUTFIT_JOB_NAME("Crewman")

	var/list/all_uniforms = list(
		/obj/item/clothing/under/lower/jeans/blue_collar,
		)

	var/list/all_shoes = list(
		/obj/item/clothing/shoes/jackboots,
		/obj/item/clothing/shoes/workboots,
		/obj/item/clothing/shoes/brown,
		/obj/item/clothing/shoes/laceup
		)
	var/list/all_hats = list(
		/obj/item/clothing/head/bandana,
		/obj/item/clothing/head/cowboy_hat,
		/obj/item/clothing/head/cowboy_hat/black
		)
	var/list/all_suits = list(
		/obj/item/clothing/suit/storage/toggle/bomber,
		/obj/item/clothing/suit/storage/leather_jacket,
		/obj/item/clothing/suit/storage/toggle/brown_jacket,
		/obj/item/clothing/suit/storage/toggle/hoodie,
		/obj/item/clothing/suit/storage/toggle/hoodie/black,
		/obj/item/clothing/suit/poncho
		)

	uniform = null
	shoes = null
	head = null
	suit = null

/decl/hierarchy/outfit/job/crewman/pre_equip(mob/living/carbon/human/H)
	if(!uniform)
		uniform = pick(all_uniforms)
	if(!shoes)
		shoes = pick(all_shoes)
	if(!head && prob(50))
		head = pick(all_hats)
	if(!suit && prob(50))
		suit = pick(all_suits)
	. = ..()

/decl/hierarchy/outfit/job/crewman/post_equip(mob/living/carbon/human/H)
	. = ..()
	uniform = initial(uniform)
	shoes = initial(shoes)
	head = initial(head)
	suit = initial(suit)