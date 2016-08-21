/datum/job/industry
	title = "Employee"
	job_category = IS_INDUSTRY
	total_positions = 6
	spawn_positions = 4
	supervisors = "the board of investors and colonial law"
	selection_color = "#ffeeff"
	alt_titles = list("Factory Worker", "Miner", "Shipping Clerk", "Fabrication Technician")
	idtype = /obj/item/card/id
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

/datum/job/industry/science
	title = "Scientist"
	total_positions = 5
	spawn_positions = 3
	supervisors = "the funding committee and colonial law"
	alt_titles = list("Xenobiologist","Field Technician")
	idtype = /obj/item/card/id
