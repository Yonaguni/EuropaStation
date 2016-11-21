/obj/item/card/id/corpcard
/obj/item/card/id/lanyard
/obj/item/card/id/dogtags

/datum/map/europa
	default_role = "Civilian"
	default_job_type = /datum/job/civilian
	allowed_jobs = list(
		/datum/job/civilian,
		/datum/job/civilian/engineering,
		/datum/job/government,
		/datum/job/head,
		/datum/job/head/marshal,
		/datum/job/head/coordinator,
		/datum/job/industry,
		/datum/job/industry/science
		)

// Landmarks follow.
/obj/effect/landmark/start/civilian
	name = "Civilian"

/obj/effect/landmark/start/civil_engineer
	name = "Civil Engineer"

/obj/effect/landmark/start/petty_officer
	name = "Petty Officer"

/obj/effect/landmark/start/colony_liaison
	name = "Colony Liaison"

/obj/effect/landmark/start/marshal
	name = "Marshal"

/obj/effect/landmark/start/cco
	name = "Corporate Contact Officer"

/obj/effect/landmark/start/employee
	name = "Employee"

/obj/effect/landmark/start/scientist
	name = "Scientist"

// Jobs follow.
/datum/job/civilian
	title = "Civilian"
	supervisors = "the Colony Liaison"
	total_positions = -1
	spawn_positions = -1
	outfit_type = /decl/hierarchy/outfit/job/europa

/decl/hierarchy/outfit/job/europa
	name = OUTFIT_JOB_NAME("Civilian")
	var/list/all_uniforms = list(
		/obj/item/clothing/under/soviet,
		/obj/item/clothing/under/redcoat,
		/obj/item/clothing/under/serviceoveralls,
		/obj/item/clothing/under/captain_fly,
		/obj/item/clothing/under/det
		)
	var/list/all_shoes = list(
		/obj/item/clothing/shoes/jackboots,
		/obj/item/clothing/shoes/workboots,
		/obj/item/clothing/shoes/brown,
		/obj/item/clothing/shoes/laceup
		)
	var/list/all_hats = list(
		/obj/item/clothing/head/ushanka,
		/obj/item/clothing/head/bandana,
		/obj/item/clothing/head/cowboy_hat,
		/obj/item/clothing/head/cowboy_hat/wide,
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

/decl/hierarchy/outfit/job/europa/pre_equip(mob/living/carbon/human/H)
	if(!uniform)
		uniform = pick(all_uniforms)
	if(!shoes)
		shoes = pick(all_shoes)
	if(!head && prob(50))
		head = pick(all_hats)
	if(!suit && prob(50))
		suit = pick(all_suits)
	. = ..()

/decl/hierarchy/outfit/job/europa/post_equip(mob/living/carbon/human/H)
	. = ..()
	uniform = initial(uniform)
	shoes = initial(shoes)
	head = initial(head)
	suit = initial(suit)

/datum/job/industry
	title = "Employee"
	total_positions = 6
	spawn_positions = 4
	supervisors = "the board of investors and colonial law"
	selection_color = "#ffeeff"
	alt_titles = list("Factory Worker", "Miner", "Shipping Clerk", "Fabrication Technician")
	access = list(access_tox, access_genetics, access_morgue,
			      access_tox_storage, access_teleporter, access_sec_doors,
			      access_research, access_robotics, access_xenobiology, access_ai_upload, access_tech_storage,
			      access_RC_announce, access_tcomsat, access_gateway, access_xenoarch, access_maint_tunnels,
			      access_mailsorting, access_cargo, access_cargo_bot, access_mining, access_mining_station)
	minimal_access = list(access_tox, access_genetics, access_morgue,
			      access_tox_storage, access_teleporter, access_sec_doors,
			      access_research, access_robotics, access_xenobiology, access_ai_upload, access_tech_storage,
			      access_RC_announce, access_tcomsat, access_gateway, access_xenoarch, access_maint_tunnels,
			      access_mailsorting, access_cargo, access_cargo_bot, access_mining, access_mining_station)
	outfit_type = /decl/hierarchy/outfit/job/europa/industry

/decl/hierarchy/outfit/job/europa/industry
	name = OUTFIT_JOB_NAME("Employee")
	id_type = /obj/item/card/id/corpcard

/datum/job/industry/science
	title = "Scientist"
	total_positions = 5
	spawn_positions = 3
	supervisors = "the funding committee and colonial law"
	alt_titles = list("Xenobiologist","Field Technician")
	outfit_type = /decl/hierarchy/outfit/job/europa/scientist

/decl/hierarchy/outfit/job/europa/scientist
	name = OUTFIT_JOB_NAME("Scientist")
	id_type = /obj/item/card/id/lanyard
	pda_type = /obj/item/radio/headset/pda/science
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/science

/datum/job/head
	title = "Colony Liaison"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Jovian authorities"
	req_admin_notify = 1
	minimal_access = list()
	selection_color = "#dddddd"
	access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
            access_heads, access_construction, access_sec_doors, access_medical, access_medical_equip, access_morgue,
			access_genetics, access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_psychiatrist)
	minimal_access = list(access_engine, access_engine_equip, access_tech_storage, access_maint_tunnels,
            access_teleporter, access_external_airlocks, access_atmospherics, access_emergency_storage, access_eva,
            access_heads, access_construction, access_sec_doors, access_medical, access_medical_equip, access_morgue,
			access_genetics, access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_psychiatrist)
	outfit_type = /decl/hierarchy/outfit/job/europa/liaison

/decl/hierarchy/outfit/job/europa/liaison
	name = OUTFIT_JOB_NAME("Colony Liaison")
	pda_type = /obj/item/radio/headset/pda

/datum/job/head/marshal
	title = "Marshal"
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_forensics_lockers,
			access_morgue, access_maint_tunnels, access_all_personal_lockers, access_research, access_engine,
			access_mining, access_medical, access_construction, access_mailsorting, access_heads, access_hos,
			access_RC_announce, access_keycard_auth, access_gateway, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_forensics_lockers,
			access_morgue, access_maint_tunnels, access_all_personal_lockers, access_research, access_engine,
			access_mining, access_medical, access_construction, access_mailsorting, access_heads, access_hos,
			access_RC_announce, access_keycard_auth, access_gateway, access_external_airlocks)
	outfit_type = /decl/hierarchy/outfit/job/europa/marshal

/decl/hierarchy/outfit/job/europa/marshal
	name = OUTFIT_JOB_NAME("Marshal")
	uniform = /obj/item/clothing/under/petty_officer/marshal
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/color/gray
	glasses = /obj/item/clothing/glasses/sunglasses
	head = /obj/item/clothing/head/petty_officer/marshal
	id_type = /obj/item/card/id/dogtags
	pda_type = /obj/item/radio/headset/pda/security

/datum/job/head/coordinator
	title = "Corporate Contact Officer"
	selection_color = "#ffeeff"
	supervisors = "the Board of Directors"
	access = list(access_rd, access_heads, access_tox, access_genetics, access_morgue,
			            access_tox_storage, access_teleporter, access_sec_doors, access_mining, access_mining_station,
			            access_research, access_robotics, access_xenobiology, access_ai_upload, access_tech_storage,
			            access_RC_announce, access_keycard_auth, access_tcomsat, access_gateway, access_xenoarch,
						access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm)
	minimal_access = list(access_rd, access_heads, access_tox, access_genetics, access_morgue,
			            access_tox_storage, access_teleporter, access_sec_doors, access_mining, access_mining_station,
			            access_research, access_robotics, access_xenobiology, access_ai_upload, access_tech_storage,
			            access_RC_announce, access_keycard_auth, access_tcomsat, access_gateway, access_xenoarch,
						access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm)
	outfit_type = /decl/hierarchy/outfit/job/europa/cco

/decl/hierarchy/outfit/job/europa/cco
	name = OUTFIT_JOB_NAME("Corporate Contact Officer")
	uniform = /obj/item/clothing/under/rank/internalaffairs
	suit = /obj/item/clothing/suit/storage/toggle/internalaffairs
	shoes = /obj/item/clothing/shoes/brown
	glasses = /obj/item/clothing/glasses/sunglasses/big
	l_hand = /obj/item/storage/briefcase
	id_type = /obj/item/card/id/lanyard
	pda_type = /obj/item/radio/headset/pda/science

/datum/job/civilian/engineering
	title = "Civil Engineer"
	alt_titles = list(
		"Emergency Services" = /decl/hierarchy/outfit/job/europa/ses,
		"Electrician" = /decl/hierarchy/outfit/job/europa/electrician
		)
	outfit_type = /decl/hierarchy/outfit/job/europa/engineer

/decl/hierarchy/outfit/job/europa/engineer
	name = OUTFIT_JOB_NAME("Civil Engineer")
	head = /obj/item/clothing/head/hardhat
	belt = /obj/item/storage/belt/utility
	pda_type = /obj/item/radio/headset/pda/engineering

/decl/hierarchy/outfit/job/europa/ses
	name = OUTFIT_JOB_NAME("Emergency Services")
	head = /obj/item/clothing/head/hardhat/red
	belt = /obj/item/storage/belt/utility
	pda_type = /obj/item/radio/headset/pda/engineering

/decl/hierarchy/outfit/job/europa/electrician
	name = OUTFIT_JOB_NAME("Electrician")
	gloves = /obj/item/clothing/gloves/insulated
	belt = /obj/item/storage/belt/utility
	pda_type = /obj/item/radio/headset/pda/engineering

/datum/job/government
	title = "Petty Officer"
	total_positions = 2
	selection_color = "#ccccff"
	spawn_positions = 4
	supervisors = "Jovian naval officials and colonial law"
	access = list()
	alt_titles = list("Sub Pilot", "Peace Officer")
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_forensics_lockers,
				access_morgue, access_maint_tunnels, access_all_personal_lockers, access_research, access_engine,
				access_mining, access_medical, access_construction, access_mailsorting, access_RC_announce,
				access_gateway, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_armory, access_forensics_lockers,
				access_morgue, access_maint_tunnels, access_all_personal_lockers, access_research, access_engine,
				access_mining, access_medical, access_construction, access_mailsorting, access_RC_announce,
				access_gateway, access_external_airlocks)
	outfit_type = /decl/hierarchy/outfit/job/europa/officer

/decl/hierarchy/outfit/job/europa/officer
	name = OUTFIT_JOB_NAME("Petty Officer")
	head = /obj/item/clothing/head/petty_officer
	glasses = /obj/item/clothing/glasses/sunglasses
	uniform = /obj/item/clothing/under/petty_officer
	shoes = /obj/item/clothing/shoes/jackboots
	backpack = /obj/item/storage/backpack/captain
	gloves = /obj/item/clothing/gloves/color/gray
	id_type = /obj/item/card/id/dogtags
	pda_type = /obj/item/radio/headset/pda/security
