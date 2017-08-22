//simplified MC that is designed to fail when procs 'break'. When it fails it's just replaced with a new one.
//It ensures master_controller.process() is never doubled up by killing the MC (hence terminating any of its sleeping procs)
//WIP, needs lots of work still

var/global/datum/controller/game_controller/master_controller //Set in world.New()

var/global/controller_iteration = 0
var/global/last_tick_duration = 0

var/global/air_processing_killed = 0
var/global/pipe_processing_killed = 0

var/global/initialization_stage = 0

datum/controller/game_controller
	name = "Master Controller"
	var/list/shuttle_list	                    // For debugging and VV
	var/init_immediately = FALSE

datum/controller/game_controller/New()
	//There can be only one master_controller. Out with the old and in with the new.
	if(master_controller != src)
		log_debug("Rebuilding Master Controller")
		if(istype(master_controller))
			qdel(master_controller)
		master_controller = src

	if(!job_master)
		job_master = new /datum/controller/occupations()
		job_master.SetupOccupations(setup_titles=1)
		job_master.LoadJobs("config/jobs.txt")
		admin_notice("<span class='danger'>Job setup complete</span>", R_DEBUG)

	if(!syndicate_code_phrase)		syndicate_code_phrase	= generate_code_phrase()
	if(!syndicate_code_response)	syndicate_code_response	= generate_code_phrase()

datum/controller/game_controller/proc/setup()

	world.tick_lag = config.Ticklag

	admin_notice("<span class='danger'>Initializing...</span>", R_DEBUG)
	var/start_time = world.timeofday

	spawn(20)
		createRandomZlevel()

	setup_objects()
	setupgenetics()

	transfer_controller = new

	admin_notice("<span class='danger'>Initialization completed in [round(0.1*(world.timeofday-start_time),0.1)] second\s.</span>", R_DEBUG)
	initialization_stage |= INITIALIZATION_COMPLETE

#ifdef UNIT_TEST
#define CHECK_SLEEP_MASTER // For unit tests we don't care about a smooth lobby screen experience. We care about speed.
#else
#define CHECK_SLEEP_MASTER if(!(initialization_stage & INITIALIZATION_NOW) && ++initialized_objects > 500) { initialized_objects=0;sleep(world.tick_lag); }
#endif

datum/controller/game_controller/proc/setup_objects()
#ifndef UNIT_TEST
	var/initialized_objects = 0
#endif

	// Do these first since character setup will rely on them
	// Set up antagonists.
	populate_antag_type_list()

	//Set up spawn points.
	populate_spawn_points()

	admin_notice("<span class='danger'>Initializing [init_turfs.len] turf\s.</span>", R_DEBUG)
	for(var/thing in init_turfs)
		if(!deleted(thing))
			thing:initialize()
			CHECK_SLEEP_MASTER
	init_turfs.Cut()

	admin_notice("<span class='danger'>Initializing [shuttle_landmarks.len] shuttle landmark\s.</span>", R_DEBUG)
	for(var/thing in shuttle_landmarks)
		if(!deleted(thing))
			thing:initialize()
	shuttle_landmarks.Cut()

	admin_notice("<span class='danger'>Initializing [turbolifts.len] turbolift\s.</span>", R_DEBUG)
	for(var/thing in turbolifts)
		if(!deleted(thing))
			thing:initialize()
			CHECK_SLEEP_MASTER

	admin_notice("<span class='danger'>Initializing [init_atoms.len] movable atom\s.</span>", R_DEBUG)
	while(init_atoms.len) // Use a while loop so that in the event of new atoms being spawned, we will keep initializing them.
		var/atom/movable/object = init_atoms[1]
		if(!deleted(object))
			object.initialize()
		init_atoms -= object
		CHECK_SLEEP_MASTER
	init_atoms.Cut()

	if(using_map.use_overmap)
		admin_notice("<span class='danger'>Initializing overmap events.</span>")
		overmap_event_handler.create_events(using_map.overmap_z, using_map.overmap_size, using_map.overmap_event_areas)
		CHECK_SLEEP_MASTER

	admin_notice("<span class='danger'>Building pipe networks</span>", R_DEBUG)
	var/count = 0
	for(var/obj/machinery/atmospherics/machine in machines)
		machine.build_network()
		count++
		CHECK_SLEEP_MASTER
	admin_notice("<span class='danger'>Built [count] pipe network\s</span>", R_DEBUG)

	admin_notice("<span class='danger'>Initializing [all_areas.len] area\s.</span>", R_DEBUG)
	for(var/thing in all_areas)
		thing:initialize()
		CHECK_SLEEP_MASTER

	count = 0
	admin_notice("<span class='danger'>Updating atmospherics machinery broadcasting.</span>", R_DEBUG)
	for(var/obj/machinery/atmospherics/unary/U in machines)
		if(istype(U, /obj/machinery/atmospherics/unary/vent_pump))
			var/obj/machinery/atmospherics/unary/vent_pump/T = U
			T.broadcast_status()
			count++
		else if(istype(U, /obj/machinery/atmospherics/unary/vent_scrubber))
			var/obj/machinery/atmospherics/unary/vent_scrubber/T = U
			T.broadcast_status()
			count++
		CHECK_SLEEP_MASTER
	admin_notice("<span class='danger'>Updated [count] atmos broadcast\s</span>", R_DEBUG)

	count = 0
	admin_notice("<span class='danger'>Casting lights.</span>", R_DEBUG)
	for(var/thing in init_lights)
		if(!deleted(thing))
			thing:cast_light()
			count++
		CHECK_SLEEP_MASTER
	init_lights.Cut()
	admin_notice("<span class='danger'>Cast [count] light\s</span>", R_DEBUG)

#undef CHECK_SLEEP_MASTER
