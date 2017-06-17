/datum/controller
	var/name

/datum/controller/New()
	..()
	if(name)
		controllers_by_name[name] = src
		controller_feedback_by_name[name] = "D[capitalize(name)]"
