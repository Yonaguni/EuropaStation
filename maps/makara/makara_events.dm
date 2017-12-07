/datum/map/makara/meteors_detected_announcement(var/event_severity = EVENT_LEVEL_MUNDANE)
	switch(event_severity)
		if(EVENT_LEVEL_MUNDANE)
			command_announcement.Announce("Minor volcanic eruption detected ahead of the [station_name()]. All personnel are advised to prepare for incidental debris.", "Seismic Monitoring Array")
		if(EVENT_LEVEL_MODERATE)
			command_announcement.Announce("Serious volcanic activity detected ahead of the [station_name()]. All personnel are advised to locate oxygen supplies and prepare for debris impact", "Seismic Monitoring Array")
		if(EVENT_LEVEL_MAJOR)
			command_announcement.Announce("Alert. Catastrophic volcanic activity detected ahead of the [station_name()]. All personnel, prepare for severe ejecta impacts.", "Seismic Monitoring Array")

/datum/map/makara/meteors_ending_announcement(var/event_severity = EVENT_LEVEL_MUNDANE)
	switch(event_severity)
		if(EVENT_LEVEL_MAJOR)
			command_announcement.Announce("[station_name()] has cleared the debris storm.", "[station_name()] Sensor Array")
		else
			command_announcement.Announce("[station_name()] has cleared the debris shower.", "[station_name()] Sensor Array")

/datum/map/makara/dust_detected_announcement(var/event_severity = EVENT_LEVEL_MUNDANE)
	command_announcement.Announce("Heavy shower of high-velocity particulate detected ahead of the [station_name()]. Please secure or avoid unshielded windows.", "Radar Array")

/datum/map/makara/dust_ended_announcement(var/event_severity = EVENT_LEVEL_MUNDANE)
	command_announcement.Announce("The [station_name()] has cleared the debris shower.", "Radar Array")

/datum/map/makara/ion_storm_announcement()
	command_announcement.Announce("Massive levels of electrical interference detected ahead of [station_name()]. Please monitor all electronic equipment for malfunctions.", "Anomaly Alert")

/datum/map/makara/electrical_storm_starting_announce(var/event_severity = EVENT_LEVEL_MUNDANE)
	switch(event_severity)
		if(EVENT_LEVEL_MUNDANE)
			command_announcement.Announce("Minor electrical interference detected ahead of the [station_name()]. Please watch out for possible electrical discharges.", "Electrical Interference Alert")
		else
			command_announcement.Announce("Massive levels of electrical interference detected ahead of the [station_name()]. Please secure sensitive electrical equipment.", "Electrical Interference Alert")

/datum/map/makara/electrical_storm_ending_announce()
	command_announcement.Announce("The [station_name()] has cleared the electrical interference. Please repair any electrical overloads.", "Electrical Interference Alert")

/datum/map/makara/radiation_storm_starting_announce()
	command_announcement.Announce("High levels of radioactive particulate detected ahead of the [station_name()]. Please evacuate into one of the shielded maintenance tunnels.", "Radiation Plume")

/datum/map/makara/radiation_storm_entered_announce()
	command_announcement.Announce("The [station_name()] has entered the radiation plume. Please remain in a sheltered area until the vessel has left the plume.", "Radiation Plume")

/datum/map/makara/radiation_storm_ending_announce()
	command_announcement.Announce("The [station_name()] has exited the radiation plume. Please report to medical personnel if you experience any unusual symptoms. Maintenance will lose all access again shortly.", "Radiation Plume")

/datum/map/makara/solar_storm_starting_announce()
	command_announcement.Announce("A major geothermal plume has been detected ahead of the [station_name()]. Please halt all exterior activites immediately and return to the interior of the vessel.", "Geothermal Plume")

/datum/map/makara/solar_storm_entered_announce()
	command_announcement.Announce("The [station_name()] has entered the thermal plume. Please refrain from external activities and remain inside until it has passed.", "Geothermal Plume")

/datum/map/makara/solar_storm_ending_announce()
	command_announcement.Announce("The [station_name()] has exited the thermal plume. It is now safe to resume exterior activities. Please report to medbay if you experience any unusual symptoms. ", "Geothermal Plume")

/datum/map/makara/get_minor_critter(var/hostile)
	if(hostile)
		return /mob/living/simple_animal/hostile/aquatic/shark
	else
		return pick(typesof(/mob/living/simple_animal/aquatic/fish)+/mob/living/simple_animal/hostile/retaliate/aquatic/carp)

/datum/map/makara/get_major_critter(var/hostile)
	return /mob/living/simple_animal/hostile/aquatic/shark/huge