var/list/times_of_day = list(
	list("name" = "day",     "alpha" = 255, "color" = "#FFFFFF"),
	list("name" = "sunset",  "alpha" = 135, "color" = "#FF9900"),
	list("name" = "night",   "alpha" = 20,  "color" = "#FFFFFF"),
	list("name" = "sunrise", "alpha" = 135,  "color" = "#9999FF"),
	)

var/datum/world_light/exterior_lighting = new()

/datum/world_light
	var/index = 0
	var/alpha = 255
	var/color = "#FFFFFF"

/datum/world_light/New()
	..()
	update_tod()

/datum/world_light/proc/update_tod()
	index++
	if(index > times_of_day.len)
		index = 1
	var/list/edata = times_of_day[index]
	// Grab data before updating mobs.
	alpha = edata["alpha"]
	color = edata["color"]
	// Update mobs!
	for(var/mob/M in mob_list)
		if(!M.client)
			continue
		var/turf/T = get_turf(M)
		if(!T.outside)
			var/area/A = get_area(T)
			if(!A.outside)
				continue
		var/fadetime = M.update_env_light()
		if(fadetime)
			sleep(fadetime)
			M << "<span class='notice'><b>It is now [edata["name"]].</b></span>"

/mob/verb/force_world_time_advance()
	exterior_lighting.update_tod()