/datum/job/government
	title = "Petty Officer"
	job_category = IS_GOVERNMENT
	department_flag = GOVERNMENT
	department = "Government Sector"
	faction = "Station"
	total_positions = 2
	selection_color = "#ccccff"
	spawn_positions = 4
	supervisors = "Jovian naval officials and Sol colonial law"
	access = list()
	alt_titles = list("Sub Pilot", "Peace Officer")
	idtype = /obj/item/weapon/card/id/europa/dogtags
	headsettype = /obj/item/device/radio/headset/headset_sec
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_forensics_lockers,
				access_morgue, access_maint_tunnels, access_all_personal_lockers, access_research, access_engine,
				access_mining, access_medical, access_construction, access_mailsorting, access_RC_announce,
				access_gateway, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_forensics_lockers,
				access_morgue, access_maint_tunnels, access_all_personal_lockers, access_research, access_engine,
				access_mining, access_medical, access_construction, access_mailsorting, access_RC_announce,
				access_gateway, access_external_airlocks)

/datum/job/government/equip(var/mob/living/carbon/human/H)
	if(!H)	return 0
	H.equip_to_slot_or_del(new /obj/item/clothing/under/europa/petty_officer(H), slot_w_uniform)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/device/pda/security(H), slot_belt)
	H.equip_to_slot_or_del(new /obj/item/clothing/gloves/grey(H), slot_gloves)
	H.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses(H), slot_glasses)
	H.equip_to_slot_or_del(new /obj/item/clothing/head/europa/petty_officer(H), slot_head)
	return 1
