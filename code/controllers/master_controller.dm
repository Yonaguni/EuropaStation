//simplified MC that is designed to fail when procs 'break'. When it fails it's just replaced with a new one.
//It ensures master_controller.process() is never doubled up by killing the MC (hence terminating any of its sleeping procs)
//WIP, needs lots of work still

var/global/datum/controller/game_controller/master_controller //Set in world.New()

var/global/controller_iteration = 0
var/global/last_tick_duration = 0

var/global/air_processing_killed = 0
var/global/pipe_processing_killed = 0

datum/controller/game_controller
	var/list/shuttle_list	                    // For debugging and VV

datum/controller/game_controller/New()
	//There can be only one master_controller. Out with the old and in with the new.
	if(master_controller != src)
		log_debug("Rebuilding Master Controller")
		if(istype(master_controller))
			qdel(master_controller)
		master_controller = src

	if(!job_master)
		job_master = new /datum/controller/occupations()
		job_master.SetupOccupations()
		job_master.LoadJobs("config/jobs.txt")
		admin_notice("<span class='danger'>Job setup complete</span>", R_DEBUG)

	if(!syndicate_code_phrase)		syndicate_code_phrase	= generate_code_phrase()
	if(!syndicate_code_response)	syndicate_code_response	= generate_code_phrase()

datum/controller/game_controller/proc/setup()
	world.tick_lag = config.Ticklag
	setup_objects()
	setup_genetics()
	//setup_xenoarch()
	transfer_controller = new

datum/controller/game_controller/proc/setup_objects()

	world << "<span class='notice'><b>Setting up the game world.</b></span>"

	admin_notice("<span class='danger'>Initializing.</span>", R_DEBUG)
	var/otod = world.timeofday
	sleep(-1)
	if(config.generate_asteroid)
		admin_notice("<span class='warning'>Generating mining level...</span>", R_DEBUG)
		sleep(-1)
		// These values determine the specific area that the map is applied to.
		new /datum/random_map/automata/cave_system(null,1,1,3,255,255)
	admin_notice("<span class='warning'>Generating sea floor...</span>", R_DEBUG)
	sleep(-1)
	new /datum/random_map/noise/seafloor(null,1,1,1,255,255)
	admin_notice("<span class='warning'>Generating ore deposits...</span>", R_DEBUG)
	sleep(-1)

	world << "<span class='notice'>Map geometry generated in [round((world.timeofday-otod)/10)] second(s).</span>"

	new /datum/random_map/noise/ore(null, 1, 1, 3, 64, 64)
	admin_notice("<span class='warning'>Initializing objects...</span>", R_DEBUG)
	sleep(-1)
	for(var/object in all_movable_atoms) // Somehow this is faster than both var/thing
		var/atom/movable/AM = object     // in world and var/atom/movable thing in all_movable_atoms.
		AM.initialize()
	admin_notice("<span class='warning'>Initializing areas...</span>", R_DEBUG)
	sleep(-1)
	for(var/area in all_areas)
		var/area/A = area
		A.initialize()
	admin_notice("<span class='warning'>Initializing ocean overlays...</span>", R_DEBUG)
	sleep(-1)
	for(var/ocean in ocean_turfs)
		var/turf/unsimulated/ocean/O = ocean
		O.initialize()
	admin_notice("<span class='warning'>Initializing nonstandard turf atmospherics...</span>", R_DEBUG)
	sleep(-1)
	for(var/F in nonstandard_atmos_turfs)
		air_master.add_to_active(F)

	admin_notice("<span class='warning'>Initializing pipe networks...</span>", R_DEBUG)
	sleep(-1)
	for(var/obj/machinery/atmospherics/machine in machines)
		machine.build_network()

	admin_notice("<span class='warning'>Initializing atmos machinery...</span>", R_DEBUG)
	sleep(-1)
	for(var/obj/machinery/atmospherics/unary/U in machines)
		if(istype(U, /obj/machinery/atmospherics/unary/vent_pump))
			var/obj/machinery/atmospherics/unary/vent_pump/T = U
			T.broadcast_status()
		else if(istype(U, /obj/machinery/atmospherics/unary/vent_scrubber))
			var/obj/machinery/atmospherics/unary/vent_scrubber/T = U
			T.broadcast_status()

	admin_notice("<span class='warning'>Setting up antagonists...</span>", R_DEBUG)
	populate_antag_type_list()
	admin_notice("<span class='warning'>Setting up spawn points...</span>", R_DEBUG)
	populate_spawn_points()
	sleep(-1)
	admin_notice("<span class='danger'>Done.</span>", R_DEBUG)
	world << "<span class='notice'>World created in [round((world.timeofday-otod)/10)] second(s).</span>"
	sleep(-1)