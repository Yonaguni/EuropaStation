var/datum/controller/subsystem/environment/SSenvironment

/datum/controller/subsystem/environment
	name = "Environment"
	priority = SS_PRIORITY_ENVIRONMENT
	wait = 60 SECONDS

	var/sky_colour
	var/sky_lightness
	var/sky_state
	var/sky_blurb

	var/last_time_period_update = 0
	var/current_time_period =     0
	var/per_time_period =         30 MINUTES
	var/list/time_periods = list(
		list("after midnight",   "#131862", 20,  "The sky is still and dark, just after midnight."),
		list("approaching dawn", "#2e4482", 20,  "The distant horizon begins to lighten as the night ends."),
		list("dawn",             "#a0497e", 80,  "The tines of the rising sun spill over the sky as dawn breaks."),
		list("early morning",    "#87cefa", 160, "The brightening sky warms the earth with the light of the early morning."),
		list("morning",          "#FFFFFF", 180, "It is now morning."),
		list("midday",           "#FFFFFF", 180, "It is now midday."),
		list("afternoon",        "#FFFFFF", 200, "The day winds on, and the sun begins descending the afternoon sky."),
		list("late afternoon",   "#FFFFFF", 180, "The sun sinks towards the horizon as late afternoon arrives."),
		list("sunset",           "#fd5e53", 160, "The sun begins to dip behind the horizon as it sets."),
		list("twilight",         "#8a496b", 80,  "Twilight falls, cloaking the world in blue-grey shadow."),
		list("night",            "#131862", 40,  "Darkness falls as true night arrives."),
		list("midnight",         "#131862", 20,  "It is the stroke of midnight.")
	)

/datum/controller/subsystem/environment/New()
	NEW_SS_GLOBAL(SSenvironment)

/datum/controller/subsystem/environment/Initialize()
	. = ..()
	current_time_period = rand(1,time_periods.len)
	last_time_period_update = world.time

/datum/controller/subsystem/environment/Recover()
	current_time_period = SSenvironment.current_time_period

/datum/controller/subsystem/environment/fire(resumed = FALSE)
	if(using_map.apply_environmental_lighting && world.time - last_time_period_update >= per_time_period)
		increment_time_period()
	//if(using_map.has_weather)
	//	todo

/datum/controller/subsystem/environment/proc/increment_time_period()
	current_time_period++
	if(current_time_period > time_periods.len) current_time_period = 1
	last_time_period_update = world.time
	var/list/timeofday = time_periods[current_time_period]
	sky_state =     timeofday[1]
	sky_colour =    timeofday[2]
	sky_lightness = timeofday[3]
	sky_blurb =     timeofday[4]
	for(var/client/C in clients)
		C.refresh_environment_lighting()

/mob/Login()
	. = ..()
	if(client && SSenvironment && SSenvironment.init_state == SS_INITSTATE_DONE && using_map && using_map.apply_environmental_lighting)
		client.refresh_environment_lighting(FALSE)

/client/proc/refresh_environment_lighting(var/do_animate = TRUE)
	if(mob && mob.loc && mob.dark_plane)
		if(do_animate)
			animate(mob.dark_plane, alpha = SSenvironment.sky_lightness, color = SSenvironment.sky_colour, time = 1 MINUTE)
		else
			mob.dark_plane.alpha = SSenvironment.sky_lightness
			mob.dark_plane.color = SSenvironment.sky_colour
		to_chat(mob, "<span class='notice'><b>[SSenvironment.sky_blurb]</b></span>")
