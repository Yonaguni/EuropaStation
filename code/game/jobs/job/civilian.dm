/obj/effect/landmark/start/citizen
	name = "Citizen"

/datum/job/civilian
	title = "Colonist"
	total_positions = -1
	spawn_positions = -1
	supervisors = "colonial authorities"
	selection_color = "#dddddd"
	idtype = /obj/item/weapon/card/id
	alt_titles = list("Citizen", "Visitor", "Doctor", "Janitor", "Gardener")
	access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
            access_construction, access_sec_doors, access_medical, access_medical_equip, access_morgue,
			access_genetics, access_chemistry, access_virology, access_surgery, access_RC_announce,access_psychiatrist)
	minimal_access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
            access_construction, access_sec_doors, access_medical, access_medical_equip, access_morgue,
			access_genetics, access_chemistry, access_virology, access_surgery, access_RC_announce,access_psychiatrist)

/datum/job/civilian/equip(var/mob/living/carbon/human/H, skip_suit = 0, skip_hat = 0, skip_shoes = 0)
	if(!H) return
	switch(H.mind.role_alt_title)
		if("Doctor")
			..(H, skip_suit = 1)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/toggle/labcoat(H), slot_wear_suit)
		if("Janitor")
			..(H, skip_suit = 1, skip_hat = 1, skip_shoes = 1)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/galoshes(H),slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/soft/purple(H),slot_head)
		if("Gardener")
			..(H, skip_suit = 1)
			H.equip_to_slot_or_del(new /obj/item/clothing/gloves/botanic_leather(H), slot_gloves)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/apron(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/device/analyzer/plant_analyzer(H), slot_s_store)
		else
			..(H, skip_suit, skip_hat, skip_shoes)
	return 1

/datum/job/civilian/equip_survival(var/mob/living/carbon/human/H)
	if(!H) return
	if(H.mind.role_alt_title == "Visitor")
		return
	..()