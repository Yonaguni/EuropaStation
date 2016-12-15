var/datum/map/using_map = new USING_MAP_DATUM
var/list/all_maps = list()
var/list/votable_maps = list()

var/const/MAP_HAS_BRANCH = 1	//Branch system for occupations, togglable
var/const/MAP_HAS_RANK = 2		//Rank system, also togglable

/hook/startup/proc/initialise_map_list()
	for(var/type in typesof(/datum/map) - /datum/map)
		var/datum/map/M
		if(type == using_map.type)
			M = using_map
			M.setup_map()
		else
			M = new type
		if(!M.path)
			world << "<span class=danger>Map '[M]' does not have a defined path, not adding to map list!</span>"
			world.log << "Map '[M]' does not have a defined path, not adding to map list!"
		else
			all_maps[M.path] = M
		if(M.votable)
			votable_maps += M.path

	return 1

/datum/map
	var/name = "Unnamed Map"
	var/full_name = "Unnamed Map"
	proc/setup_map()
	var/path
	var/votable = FALSE

	var/list/station_levels = list() // Z-levels the station exists on
	var/list/admin_levels = list()   // Z-levels for admin functionality (Centcom, shuttle transit, etc)
	var/list/contact_levels = list() // Z-levels that can be contacted from the station, for eg announcements
	var/list/player_levels = list()  // Z-levels a character can typically reach
	var/list/sealed_levels = list()  // Z-levels that don't allow random transit at edge
	var/list/map_levels              // Z-levels available to various consoles, such as the crew monitor. Defaults to station_levels if unset.
	var/list/shallow_levels = list()

	var/default_role = "Crewman"
	var/list/default_job_type = /datum/job/assistant
	var/list/allowed_jobs          //Job datums to use.
	                               //Works a lot better so if we get to a point where three-ish maps are used
	                               //We don't have to C&P ones that are only common between two of them
	                               //That doesn't mean we have to include them with the rest of the jobs though, especially for map specific ones.
	                               //Also including them lets us override already created jobs, letting us keep the datums to a minimum mostly.
	                               //This is probably a lot longer explanation than it needs to be.
	// Unit test vars
	var/list/exempt_areas = list()
	var/const/NO_APC = 1
	var/const/NO_VENT = 2
	var/const/NO_SCRUBBER = 4

	var/shuttle_docked_message
	var/shuttle_leaving_dock
	var/shuttle_called_message
	var/shuttle_recall_message
	var/emergency_shuttle_docked_message
	var/emergency_shuttle_leaving_dock
	var/emergency_shuttle_called_message
	var/emergency_shuttle_recall_message
	var/single_card_authentication = FALSE

	var/datum/trade_destination/stellar_location
	var/specific_location

	var/list/holodeck_programs = list() // map of string ids to /datum/holodeck_program instances
	var/list/holodeck_supported_programs = list() // map of maps - first level maps from list-of-programs string id (e.g. "BarPrograms") to another map
                                                  // this is in order to support multiple holodeck program listings for different holodecks
	                                              // second level maps from program friendly display names ("Picnic Area") to program string ids ("picnicarea")
	                                              // as defined in holodeck_programs
	var/list/holodeck_restricted_programs = list() // as above... but EVIL!

	var/flags = 0
	var/evac_controller_type = /datum/evacuation_controller
	var/overmap_z = 0		//If 0 will generate overmap zlevel on init. Otherwise will populate the zlevel provided.

	var/ambient_exterior_temperature = T20C
	var/ambient_exterior_light = TRUE

	var/test_x = 20
	var/test_y = 20
	var/test_z = 1

/datum/map/New()
	..()
	if(!map_levels)
		map_levels = station_levels.Copy()
	if(!allowed_jobs)
		allowed_jobs = subtypesof(/datum/job)

// Used to apply various post-compile procedural effects to the map.
/datum/map/proc/perform_map_generation()
	return

/datum/map/proc/refresh_mining_turfs()
	return

// Can be overridden/updated to be more interesting later.
/datum/map/proc/do_roundstart_intro()
	set waitfor = 0
	set background = 1

/datum/map/proc/update_locations()
	stellar_location = pick(all_trade_destinations)

/datum/map/proc/get_specific_location()
	return (specific_location ? specific_location : (stellar_location ? stellar_location.name : "Unknown"))

/proc/layer_is_shallow(var/layer)
	return using_map && (layer in using_map.shallow_levels)

/datum/map/proc/handle_captain_join(var/mob/living/carbon/human/captain)
	return

/datum/map/proc/get_exterior_air()
	var/datum/gas_mixture/GM = new
	GM.adjust_multi("oxygen", MOLES_O2STANDARD, "nitrogen", MOLES_N2STANDARD)
	GM.temperature = ambient_exterior_temperature
	return GM

/datum/map/proc/show_map_info(var/user)
	return

/datum/map/proc/check_escaped(var/mob/survivor)
	var/turf/T = get_turf(survivor)
	return (T && (T in using_map.admin_levels)) // Still not great but beats the previous hard coded list of safe escape locations

/datum/map/proc/get_round_completion_text(var/mob/player)
	if(player.stat != DEAD)
		var/turf/playerTurf = get_turf(player)
		if(evacuation_controller.round_over() && evacuation_controller.emergency_evacuation)
			if(isNotAdminLevel(playerTurf.z))
				return "<font color='blue'><b>You managed to survive, but were marooned on [station_name()] as [player.real_name]...</b></font>"
			else
				return "<font color='green'><b>You managed to survive the events on [station_name()] as [player.real_name].</b></font>"
		else if(isAdminLevel(playerTurf.z))
			return "<font color='green'><b>You successfully left the system after events on [station_name()] as [player.real_name].</b></font>"
		else if(issilicon(player))
			return "<font color='green'><b>You remained operational after the events on [station_name()] as [player.real_name].</b></font>"
		else
			return "<font color='blue'><b>You were left behind after the events on [station_name()] as [player.real_name].</b></font>"
	if(isghost(player))
		var/mob/observer/ghost/O = player
		if(!O.started_as_observer)
			return  "<font color='red'><b>You did not survive the events on [station_name()]...</b></font>"
	return "<font color='notice'><b>You kept an eye on the events on [station_name()].</b></font>"

/client/verb/check_map_location()

	set name = "Check Map Location"
	set desc = "Get info on the current map."
	set category = "IC"

	usr << "The current map is: <b>[using_map.full_name]</b>"
	using_map.show_map_info(usr)

// Defined here so I can add it to the admin verbs.
var/map_submerged
/datum/admins/proc/submerge_map()
	set category = "Admin"
	set desc = "Submerge the map in an ocean."
	set name = "Submerge Map"

	if(!check_rights(R_ADMIN))	return

	if(map_submerged)
		usr << "<span class='warning'>The map has already been dropped into an ocean.</span>"
		return

	if(alert("Are you sure you want to drop the map into the ocean?",,"No","Yes") == "No")
		return

	using_map.ambient_exterior_light = (alert("Do you want the ocean to be dark?",,"No","Yes") == "No")
	using_map.ambient_exterior_temperature = ((alert("Do you want the ocean to be freezing?",,"No","Yes") == "Yes") ? 110 : T20C)

	map_submerged = TRUE
	world << "<span class='notice'><b>[usr.key] fumbled and dropped the server into an ocean, please wait for the game to catch up.</b></span>"
	sleep(10)
	for(var/i in using_map.station_levels)
		base_turf_by_z["[i]"] = /turf/simulated/ocean
		new /datum/random_map/noise/seafloor/replace_space(null,1,1,i,255,255)
		sleep(50)

	// This list will be empty if this verb is run post-roundstart. This is
	// used to clean up if it's run before roundstart but after turf init.
	for(var/thing in init_turfs)
		var/turf/T = thing
		T.initialize()
