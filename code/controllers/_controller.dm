/datum/controller
	var/name
	// The object used for the clickable stat() button.
	var/obj/effect/statclick/statclick

/datum/controller/New()
	..()
	if(name)
		controllers_by_name[name] = src
		controller_feedback_by_name[name] = "D[capitalize(name)]"

/datum/controller/proc/Initialize()

//cleanup actions
/datum/controller/proc/Shutdown()

/datum/controller/proc/Recover()

/datum/controller/proc/stat_entry()
