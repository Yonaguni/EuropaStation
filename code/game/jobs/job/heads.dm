/datum/job/head
	title = "Colony Liaison"
	flag = LIAISON
	department_flag = CIVILIAN
	total_positions = 1
	spawn_positions = 1
	supervisors = "Jovian authorities"
	department = "Civil Sector"
	faction = "Station"
	head_position = 1
	req_admin_notify = 1
	access = list()
	minimal_access = list()
	selection_color = "#dddddd"

/datum/job/head/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0
	..(H) // Same as all the nobodies.
	//TODO: Access cards, documentation, any other specialist gear.

/datum/job/head/marshal
	title = "Marshal"
	flag = MARSHAL
	department_flag = GOVERNMENT
	department = "Government Sector"
	selection_color = "#ccccff"
	idtype = /obj/item/weapon/card/id/europa/dogtags
	headsettype = /obj/item/device/radio/headset/headset_sec

/datum/job/head/marshal/equip(var/mob/living/carbon/human/H)
	//TODO: Proper Marshal uniform.
	if(!H)	return 0
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/petty_officer(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/device/pda/security(H), slot_belt)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/grey(H), slot_gloves)
	H.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses(H), slot_glasses)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/petty_officer(H), slot_head)
	return 1

/datum/job/head/coordinator
	flag = CCO
	department_flag = INDUSTRY
	title = "Corporate Contact Officer"
	supervisors = "your corporate overseers"
	selection_color = "#ffeeff"
	department = "Industrial Sector"
	idtype = /obj/item/weapon/card/id/europa/lanyard

/datum/job/head/coordinator/equip(var/mob/living/carbon/human/H)
	if(!H) return 0
	//TODO: keycard, headset, weapon.
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/internalaffairs(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/toggle/internalaffairs(H), slot_wear_suit)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/brown(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big(H), slot_glasses)
	H.equip_to_slot_or_del(new /obj/item/weapon/storage/briefcase(H), slot_l_hand)
	return 1
