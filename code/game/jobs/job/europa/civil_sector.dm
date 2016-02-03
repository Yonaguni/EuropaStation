/datum/job/civilian/engineering
	title = "Civil Engineer"
	alt_titles = list("Emergency Services","Electrician")

/datum/job/civilian/engineering/equip(var/mob/living/carbon/human/H)
	if(!H) return
	switch(H.mind.role_alt_title)
		if("Civil Engineer")
			..(H, skip_hat = 1)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/hardhat(H), slot_head)
			H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/utility/engineer(H), slot_belt)
			if(H.backbag == 1)
				H.equip_to_slot_or_del(new /obj/item/weapon/storage/box/divingsuit(H), slot_l_hand)
			else
				H.equip_to_backpack_or_del(new /obj/item/weapon/storage/box/divingsuit(H))
		if("Emergency Services")
			..(H, skip_hat = 1)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/hardhat/red(H), slot_head)
			H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/utility/emergency(H), slot_belt)
			if(H.backbag == 1)
				H.equip_to_slot_or_del(new /obj/item/weapon/pickaxe/plasmacutter(H), slot_r_hand)
				H.equip_to_slot_or_del(new /obj/item/weapon/storage/box/divingsuit(H), slot_l_hand)
			else
				H.equip_to_backpack_or_del(new /obj/item/weapon/pickaxe/plasmacutter(H))
				H.equip_to_backpack_or_del(new /obj/item/weapon/storage/box/divingsuit(H))
		if("Electrician")
			..(H)
			H.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow(H), slot_gloves)
			H.equip_to_slot_or_del(new /obj/item/weapon/storage/belt/utility/electrician(H), slot_belt)
			if(H.backbag == 1)
				H.equip_to_slot_or_del(new /obj/item/weapon/storage/box/lights/mixed(H), slot_r_hand)
			else
				H.equip_to_backpack_or_del(new /obj/item/weapon/storage/box/lights/mixed(H))
		else
			..(H)
	return 1
