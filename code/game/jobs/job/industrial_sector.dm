/datum/job/industry
	title = "Employee"
	flag = WORKER
	department_flag = INDUSTRY
	department = "Industrial Sector"
	faction = "Station"
	total_positions = 6
	spawn_positions = 4
	supervisors = "the board of investors and colonial law"
	selection_color = "#ffeeff"
	access = list()
	minimal_access = list()
	alt_titles = list("Factory Worker", "Miner", "Shipping Clerk", "Fabrication Technician")
	idtype = /obj/item/weapon/card/id/europa/corpcard

/datum/job/industry/science
	title = "Scientist"
	flag = SCIENTIST
	total_positions = 5
	spawn_positions = 3
	supervisors = "the funding committee and colonial law"
	alt_titles = list("Xenobiologist","Field Technician")
	idtype = /obj/item/weapon/card/id/europa/lanyard

/datum/job/industry/science/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0
	H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/scientist(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/white(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/toggle/labcoat/science(H), slot_wear_suit)
	return 1