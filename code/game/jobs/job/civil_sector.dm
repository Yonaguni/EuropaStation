/datum/job/civilian
	title = "Citizen"
	flag = CITIZEN
	department = "Civil Sector"
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = -1
	spawn_positions = -1
	supervisors = "colonial authorities"
	selection_color = "#dddddd"
	access = list()
	minimal_access = list()
	alt_titles = list("Colonist", "Visitor", "Doctor", "Janitor", "Gardener")
	access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
            access_construction, access_sec_doors, access_medical, access_medical_equip, access_morgue,
			access_genetics, access_chemistry, access_virology, access_surgery, access_RC_announce,access_psychiatrist)

/datum/job/civilian/equip(var/mob/living/carbon/human/H)
	if(!H) return
	switch(H.mind.role_alt_title)
		if("Doctor")
			..(H, skip_suit = 1)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/toggle/labcoat(H), slot_wear_suit)
		if("Janitor")
			..(H, skip_shoes = 1, skip_suit = 1, skip_hat = 1)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/galoshes(H),slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/soft/purple(H),slot_head)
		else
			..(H)
	return 1

/datum/job/civilian/engineering
	title = "Civil Engineer"
	flag = ENGINEER
	alt_titles = list("Emergency Services","Electrician")