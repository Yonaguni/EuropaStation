/datum/event/meteor_wave
	startWhen		= 5
	endWhen 		= 7
	var/next_meteor = 6
	var/waves = 1

/datum/event/meteor_wave/setup()
	waves = severity * rand(1,3)

/datum/event/meteor_wave/announce()
	switch(severity)
		if(EVENT_LEVEL_MAJOR)
			command_announcement.Announce("Large volumes of debris have been detected on a collision course with [station_name()].", "Debris Field Alert")
		else
			command_announcement.Announce("The facility is now in a debris field.", "Meteor Alert")

//meteor showers are lighter and more common,
/datum/event/meteor_wave/tick()
	if(waves && activeFor >= next_meteor)
		spawn() spawn_meteors(severity * rand(1,2), get_meteors())
		next_meteor += rand(15, 30) / severity
		waves--
		endWhen = (waves ? next_meteor + 1 : activeFor + 15)

/datum/event/meteor_wave/end()
	command_announcement.Announce("The debris field has cleared the facility.", "Meteor Alert")

/datum/event/meteor_wave/proc/get_meteors()
	switch(severity)
		if(EVENT_LEVEL_MAJOR)
			return meteors_catastrophic
		if(EVENT_LEVEL_MODERATE)
			return meteors_threatening
		else
			return meteors_normal
