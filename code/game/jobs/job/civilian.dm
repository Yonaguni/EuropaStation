//Food
/datum/job/chef
	title = "Cook"
	department = "Civilian"
	department_flag = CIV
	faction = "Crew"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Quartermaster"
	selection_color = "#515151"
	access = list(access_hydroponics, access_bar, access_kitchen)
	minimal_access = list(access_kitchen)
	outfit_type = /decl/hierarchy/outfit/job/service/chef

//Cargo
/datum/job/qm
	title = "Quartermaster"
	department = "Civilian"
	department_flag = CIV|CRG
	faction = "Crew"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the ship's Operations Officer"
	selection_color = "#515151"
	economic_modifier = 5
	access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mining, access_mining_station)
	minimal_access = list(access_maint_tunnels, access_mailsorting, access_cargo, access_cargo_bot, access_qm, access_mining, access_mining_station)
	minimal_player_age = 3
	ideal_character_age = 40
	outfit_type = /decl/hierarchy/outfit/job/cargo/qm

/datum/job/janitor
	title = "Sanitation Technician"
	department = "Civilian"
	department_flag = CIV
	faction = "Crew"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Quartermaster"
	selection_color = "#515151"
	access = list(access_janitor, access_maint_tunnels, access_engine, access_research, access_sec_doors, access_medical)
	minimal_access = list(access_janitor, access_maint_tunnels, access_engine, access_research, access_sec_doors, access_medical)
	outfit_type = /decl/hierarchy/outfit/job/service/janitor

/datum/job/cultural_attache
	title = "Alien"
	outfit_type = /decl/hierarchy/outfit/job/cultural_attache
	department = "Civilian"
	department_flag = CIV
	faction = "Crew"
	total_positions = 3
	spawn_positions = 1
	supervisors = "your home government"
	access = list()
	minimal_access = list()
	selection_color = "#633d63"

	alt_titles = list(
		"Resomi Imperial Ringwright" =    /decl/hierarchy/outfit/job/cultural_attache/resomi,
		"Resomi Imperial Citizen" =       /decl/hierarchy/outfit/job/cultural_attache/resomi/civilian,
		"Resomi Imperial Emissary" =      /decl/hierarchy/outfit/job/cultural_attache/resomi/fancy,
		"Skrellian Cultural Attache" =    /decl/hierarchy/outfit/job/cultural_attache/skrell,
		"Skrellian Scientific Dispatch" = /decl/hierarchy/outfit/job/cultural_attache/skrell/science,
		"Skrellian Caste Executive" =     /decl/hierarchy/outfit/job/cultural_attache/skrell/fancy,
		"Advancer Gestalt" =              /decl/hierarchy/outfit/job/cultural_attache/diona,
		"Progenitor Gestalt" =            /decl/hierarchy/outfit/job/cultural_attache/diona,
		"Venerated Gestalt" =             /decl/hierarchy/outfit/job/cultural_attache/diona
		)

	var/list/titles_to_species = list(
		"Resomi Imperial Ringwright" =    "Resomi",
		"Resomi Imperial Citizen" =       "Resomi",
		"Resomi Imperial Emissary" =      "Resomi",
		"Skrellian Scientific Dispatch" = "Skrell",
		"Skrellian Cultural Attache" =    "Skrell",
		"Skrellian Caste Executive" =     "Skrell",
		"Advancer Gestalt" =              "Diona",
		"Progenitor Gestalt" =            "Diona",
		"Venerated Gestalt" =             "Diona"
		)

/datum/job/cultural_attache/handle_misc_notifications(var/mob/living/carbon/human/H)
	H << "You are a visiting <b>[H.species.name]</b>."
	H << "[H.species.blurb]"
	H << "<b>Represent your culture well to these strangers.</b>"

/datum/job/cultural_attache/equip_species(var/mob/living/carbon/human/H, var/alt_title)
	var/use_title = alt_title
	if(!titles_to_species[use_title] || use_title == null)
		use_title = "Skrellian Scientific Dispatch"

	if(H.species.name != titles_to_species[use_title])
		H.set_species(titles_to_species[use_title], 1)
		return 1
	return 0

/datum/job/cultural_attache/equip(var/mob/living/carbon/human/H, var/alt_title)
	. = ..()
	spawn(15)
		H.change_appearance((APPEARANCE_GENDER|APPEARANCE_SKIN|APPEARANCE_ALL_HAIR|APPEARANCE_EYE_COLOR), get_turf(H), H, 1, list(H.species.name), all_species-H.species.name)
