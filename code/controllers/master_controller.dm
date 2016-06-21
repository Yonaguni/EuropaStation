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
		admin_notice("<span class='danger'>Job setup complete</span>", R_DEBUG)

	if(!syndicate_code_phrase)		syndicate_code_phrase	= generate_code_phrase()
	if(!syndicate_code_response)	syndicate_code_response	= generate_code_phrase()

datum/controller/game_controller/proc/setup()
	world.tick_lag = config.Ticklag
	setup_objects()
	setup_genetics()

datum/controller/game_controller/proc/setup_objects()

	world << "<span class='notice'><b>Setting up the game world.</b></span>"

	admin_notice("<span class='danger'>Initializing.</span>", R_DEBUG)
	var/otod = world.timeofday
	world << "<span class='notice'>Generating map geometry...</span>"
	world_map.do_roundstart_mapgen()
	sleep(-1)
	world << "<span class='notice'>Map geometry generated in [round((world.timeofday-otod)/10)] second(s).</span>"

	admin_notice("<span class='warning'>Initializing objects...</span>", R_DEBUG)
	sleep(-1)
	for(var/object in all_movable_atoms) // Somehow this is faster than both var/thing
		var/atom/movable/AM = object     // in world and var/atom/movable thing in all_movable_atoms.
		AM.initialize()
	admin_notice("<span class='warning'>Initializing turfs...</span>", R_DEBUG)
	sleep(-1)
	for(var/turf in init_turfs)
		var/turf/T = turf
		T.initialize()
	init_turfs.Cut()
	admin_notice("<span class='warning'>Initializing areas...</span>", R_DEBUG)
	sleep(-1)
	for(var/area in all_areas)
		var/area/A = area
		A.initialize()
	admin_notice("<span class='warning'>Setting up antagonists...</span>", R_DEBUG)
	sleep(-1)
	populate_antag_type_list()
	admin_notice("<span class='warning'>Setting up spawn points...</span>", R_DEBUG)
	sleep(-1)
	populate_spawn_points()
	admin_notice("<span class='warning'>Setting up aspects...</span>", R_DEBUG)
	sleep(-1)
	populate_aspects()
	sleep(-1)
	admin_notice("<span class='danger'>Done.</span>", R_DEBUG)
	world << "<span class='notice'>\The [world_map.name] was created in [round((world.timeofday-otod)/10)] second(s).</span>"
	sleep(-1)