/datum/map/borderworld
	name = "Borderworld"
	full_name = "the Borderworld"
	path = "borderworld"

	station_levels = list(1)
	contact_levels = list(1,2)
	player_levels = list(1,2)
	shallow_levels = list(1,2)

	title_state = "borderworld"
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

	motd_override = {"<h1>Welcome to the borderworlds, stranger.</h1>
	<i>This server is running the Europa Station 13 modification of <a href="http://baystation12.net/">Baystation 12's</a> SS13 code.</i><br>
	Please check over the rules and get familiar with our roleplaying expectations before you mosey over.<br>
	<b>Bugtracker:</b> <a href="https://github.com/Yonaguni/EuropaStation/issues">for posting of bugs and issues.</a>"}

/datum/map/borderworld/do_roundstart_mapgen()
	if(config.generate_asteroid)
		admin_notice("<span class='warning'>Generating caverns...</span>", R_DEBUG)
		new /datum/random_map/large_cave(null,1,1,1,255,255)
	admin_notice("<span class='warning'>Generating ore deposits...</span>", R_DEBUG)
	sleep(-1)
	new /datum/random_map/noise/ore(null, 1, 1, 1, 64, 64)

/obj/effect/landmark/map_data/borderworld
	name = "borderworld"
	desc = "The planet surface and the mining level."
	height = 2
