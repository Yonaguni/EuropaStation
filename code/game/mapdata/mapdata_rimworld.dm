/obj/effect/landmark/map_data/rimworld
	name = "borderworld"
	desc = "The planet surface and the mining level."
	height = 2

	default_title = "Vagrant"
	default_job = /datum/job/civilian/vagrant
	use_jobs = list(
		/datum/job/civilian,
		/datum/job/civilian/vagrant,
		/datum/job/civilian/farmer,
		/datum/job/civilian/governor,
		/datum/job/civilian/hunter,
		/datum/job/civilian/lawman,
		/datum/job/civilian/mechanic,
		/datum/job/civilian/merchant,
		/datum/job/civilian/miner,
		/datum/job/civilian/sawbones,
		/datum/job/civilian/scrapper
		)

/obj/effect/landmark/map_data/rimworld/do_roundstart_mapgen()
	if(config.generate_asteroid)
		admin_notice("<span class='warning'>Generating caverns...</span>", R_DEBUG)
		new /datum/random_map/large_cave(null,1,1,1,255,255)
	admin_notice("<span class='warning'>Generating ore deposits...</span>", R_DEBUG)
	sleep(-1)
	new /datum/random_map/noise/ore(null, 1, 1, 1, 64, 64)
