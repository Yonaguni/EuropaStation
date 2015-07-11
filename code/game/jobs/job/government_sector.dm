/datum/job/government
	title = "Petty Officer"
	flag = OFFICER
	department_flag = GOVERNMENT
	department = "Government Sector"
	faction = "Station"
	total_positions = 2
	selection_color = "#ccccff"
	spawn_positions = 4
	supervisors = "Jovian naval officials and Sol colonial law"
	access = list()
	alt_titles = list("Sub Pilot", "Peace Officer")


/datum/job/government/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0
	H.equip_to_slot_or_del(new /obj/item/device/radio/headset/headset_sec(H), slot_l_ear)
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/petty_officer(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/black(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/device/pda/security(H), slot_belt)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/grey(H), slot_gloves)
	H.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses(H), slot_glasses)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/petty_officer(H), slot_head)
	return 1
