/datum/map/europa
	name = "Europa"
	full_name = "Yonaguni Facility"
	path = "europa"

	admin_levels = list(3,4)
	station_levels = list(2)
	contact_levels = list(2)
	player_levels = list(1,2)
	shallow_levels = list(1,2)

	default_title = "Civilian"
	default_job = /datum/job/civilian
	use_jobs = list(
		/datum/job/civilian,
		/datum/job/civilian/engineering,
		/datum/job/government,
		/datum/job/head,
		/datum/job/head/marshal,
		/datum/job/head/coordinator,
		/datum/job/industry,
		/datum/job/industry/science
		)
	motd_override = {"<h1>Welcome to Europa, colonist.</h1>
	<i>This server is running the Europa Station 13 modification of <a href="http://baystation12.net/">Baystation 12's</a> SS13 code.</i><br>
	Please check over the rules and get familiar with our roleplaying expectations before you dive in.<br>
	<b>Bugtracker:</b> <a href="https://github.com/Yonaguni/EuropaStation/issues">for posting of bugs and issues.</a>"}

/datum/map/europa/do_roundstart_mapgen()
	if(config.generate_asteroid)
		admin_notice("<span class='warning'>Generating deep caverns...</span>", R_DEBUG)
		new /datum/random_map/large_cave(null,1,1,1,255,255)
	admin_notice("<span class='warning'>Generating ore deposits...</span>", R_DEBUG)
	sleep(-1)
	new /datum/random_map/noise/ore(null, 1, 1, 3, 64, 64)
	admin_notice("<span class='warning'>Generating sea floor...</span>", R_DEBUG)
	sleep(-1)
	new /datum/random_map/noise/seafloor(null,1,1,2,255,255)
	admin_notice("<span class='warning'>Generating tundra...</span>", R_DEBUG)
	sleep(-1)
	new /datum/random_map/noise/tundra(null,1,1,4,255,255)

/obj/effect/landmark/map_data/europa
	name = "europa"
	desc = "The main dome level, the mining abyss level, the transit level and the surface."
	height = 4
