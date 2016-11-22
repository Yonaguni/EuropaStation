/datum/map/europa
	name = "Europa"
	full_name = "Yonaguni Facility"
	path = "europa"

	admin_levels = list(1)
	station_levels = list(1)
	contact_levels = list(1)
	player_levels = list(1)
	shallow_levels = list(1)

	test_x = 70
	test_y = 70
	test_z = 1

	ambient_exterior_temperature = 110 // -160 degrees celcius (surface temperature of Europa)
	ambient_exterior_light = FALSE

	/*
	motd_override = {"<h1>Welcome to Europa, colonist.</h1>
	<i>This server is running the Europa Station 13 modification of <a href="http://baystation12.net/">Baystation 12's</a> SS13 code.</i><br>
	Please check over the rules and get familiar with our roleplaying expectations before you dive in.<br>
	<b>Bugtracker:</b> <a href="https://github.com/Yonaguni/EuropaStation/issues">for posting of bugs and issues.</a>"}
	*/

/datum/map/europa/perform_map_generation()

	admin_notice("<span class='warning'>Generating sea floor...</span>", R_DEBUG)
	sleep(-1)
	new /datum/random_map/noise/seafloor(null,1,1,1,255,255)

/datum/map/europa/get_exterior_air()
	var/datum/gas_mixture/GM = new
	GM.adjust_multi("water", 10000)               // High pressure!
	GM.temperature = ambient_exterior_temperature // Cold as fuck!
	return GM

/*
/obj/effect/landmark/map_data/europa
	name = "europa"
	desc = "The main dome level, the mining abyss level, the transit level and the surface."
	height = 4
*/
