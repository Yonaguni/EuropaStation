/obj/effect/landmark/map_data/rimworld
	name = "borderworld"
	desc = "The planet surface and the mining level."
	height = 2
	use_title_state = "borderworld"

	default_title = "Vagrant"
	default_job = /datum/job/borderworld
	use_jobs = list(
		/datum/job/borderworld,
		/datum/job/borderworld/farmer,
		/datum/job/borderworld/governor,
		/datum/job/borderworld/hunter,
		/datum/job/borderworld/lawman,
		/datum/job/borderworld/mechanic,
		/datum/job/borderworld/merchant,
		/datum/job/borderworld/miner,
		/datum/job/borderworld/doctor,
		/datum/job/borderworld/scrapper
		)

	shallow_layers = list(1,2)

/obj/effect/landmark/map_data/rimworld/do_roundstart_mapgen()
	if(config.generate_asteroid)
		admin_notice("<span class='warning'>Generating caverns...</span>", R_DEBUG)
		new /datum/random_map/large_cave(null,1,1,1,255,255)
	admin_notice("<span class='warning'>Generating ore deposits...</span>", R_DEBUG)
	sleep(-1)
	new /datum/random_map/noise/ore(null, 1, 1, 1, 64, 64)
