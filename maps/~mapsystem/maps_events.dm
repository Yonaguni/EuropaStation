/datum/map/proc/meteors_detected_announcement(var/event_severity = EVENT_LEVEL_MUNDANE)
	switch(event_severity)
		if(EVENT_LEVEL_MAJOR)
			command_announcement.Announce("Alert. [station_name()] has entered a catastrophic meteor storm. All hands, brace for impact.", "[station_name()] Sensor Array")
		else
			command_announcement.Announce("[station_name()] has entered a meteorite shower. Please check exterior hull for damage.", "[station_name()] Sensor Array")

/datum/map/proc/meteors_ending_announcement(var/event_severity = EVENT_LEVEL_MUNDANE)
	switch(event_severity)
		if(EVENT_LEVEL_MAJOR)
			command_announcement.Announce("[station_name()] has cleared the meteor storm.", "[station_name()] Sensor Array")
		else
			command_announcement.Announce("[station_name()] has cleared the meteor shower", "[station_name()] Sensor Array")

/datum/map/proc/dust_detected_announcement(var/event_severity = EVENT_LEVEL_MUNDANE)
	command_announcement.Announce("[station_name()] is now passing through a belt of space dust.", "Dust Alert")

/datum/map/proc/dust_ended_announcement(var/event_severity = EVENT_LEVEL_MUNDANE)
	command_announcement.Announce("[station_name()] has now passed through the belt of space dust.", "Dust Notice")

/datum/map/proc/level_seven_announcement()
	command_announcement.Announce("Confirmed outbreak of level 7 biohazard aboard [station_name()]. All personnel must contain the outbreak.", "Biohazard Alert", new_sound = 'sound/AI/outbreak7.ogg')

/datum/map/proc/ion_storm_announcement()
	command_announcement.Announce("It has come to our attention that [station_name()] passed through an ion storm.  Please monitor all electronic equipment for malfunctions.", "Anomaly Alert")

/datum/map/proc/electrical_storm_starting_announce(var/event_severity = EVENT_LEVEL_MUNDANE)
	switch(event_severity)
		if(EVENT_LEVEL_MUNDANE)
			command_announcement.Announce("A minor electrical storm has been detected near [station_name()]. Please watch out for possible electrical discharges.", "Electrical Storm Alert")
		if(EVENT_LEVEL_MODERATE)
			command_announcement.Announce("[station_name()] is about to pass through an electrical storm. Please secure sensitive electrical equipment until the storm passes.", "Electrical Storm Alert")
		if(EVENT_LEVEL_MAJOR)
			command_announcement.Announce("Alert. A strong electrical storm has been detected in proximity of [station_name()]. It is recommended to immediately secure sensitive electrical equipment until the storm passes.", "Electrical Storm Alert")

/datum/map/proc/electrical_storm_ending_announce()
	command_announcement.Announce("[station_name()] has cleared the electrical storm. Please repair any electrical overloads.", "Electrical Storm Alert")

/datum/map/proc/radiation_storm_starting_announce()
	command_announcement.Announce("High levels of radiation detected near [station_name()]. Please evacuate into one of the shielded maintenance tunnels.", "Anomaly Alert", new_sound = 'sound/AI/radiation.ogg')

/datum/map/proc/radiation_storm_entered_announce()
	command_announcement.Announce("[station_name()] has entered the radiation belt. Please remain in a sheltered area until we have passed the radiation belt.", "Anomaly Alert")

/datum/map/proc/radiation_storm_ending_announce()
	command_announcement.Announce("[station_name()] has passed the radiation belt. Please report to medbay if you experience any unusual symptoms. Maintenance will lose all access again shortly.", "Anomaly Alert")

/datum/map/proc/solar_storm_starting_announce()
	command_announcement.Announce("A solar storm has been detected approaching [station_name()]. Please halt all EVA activites immediately and return to the interior of [station_name()].", "Anomaly Alert", new_sound = 'sound/AI/radiation.ogg')

/datum/map/proc/solar_storm_entered_announce()
	command_announcement.Announce("The solar storm has reached [station_name()]. Please refain from EVA and remain inside until it has passed.", "Anomaly Alert")

/datum/map/proc/solar_storm_ending_announce()
	command_announcement.Announce("The solar storm has passed [station_name()]. It is now safe to resume EVA activities. Please report to medbay if you experience any unusual symptoms. ", "Anomaly Alert")

/datum/map/proc/get_minor_critter(var/hostile)
	return /mob/living/simple_animal/hostile/carp

/datum/map/proc/get_major_critter(var/hostile)
	return /mob/living/simple_animal/hostile/carp/pike