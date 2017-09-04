/datum/event/dust
	startWhen	= 10
	endWhen		= 30

/datum/event/dust/announce()
	using_map.dust_detected_announcement(severity)

/datum/event/dust/start()
	dust_swarm(get_severity())

/datum/event/dust/end()
	using_map.dust_ended_announcement(severity)

/datum/event/dust/proc/get_severity()
	switch(severity)
		if(EVENT_LEVEL_MUNDANE)
			return "weak"
		if(EVENT_LEVEL_MODERATE)
			return prob(80) ? "norm" : "strong"
		if(EVENT_LEVEL_MAJOR)
			return "super"
	return "weak"
