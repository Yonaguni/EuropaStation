/datum/map/yonaguni/meteors_detected_announcement(var/event_severity = EVENT_LEVEL_MUNDANE)
	switch(event_severity)
		if(EVENT_LEVEL_MUNDANE)
			command_announcement.Announce("Long-range sensors report a minor volcanic eruption nearby. All personnel are advised to prepare for incidental debris.", "Seismic Monitoring Array")
		if(EVENT_LEVEL_MODERATE)
			command_announcement.Announce("Long-range sensors report a serious volcanic upheaval nearby. All personnel are advised to locate oxygen supplies and prepare for debris impact", "Seismic Monitoring Array")
		if(EVENT_LEVEL_MAJOR)
			command_announcement.Announce("Alert. Catastrophic volcanic eruption chain detected by long-range scanners. Severe debris storm inbound. All personnel, prepare for impact.", "Seismic Monitoring Array")

/datum/map/yonaguni/meteors_ending_announcement(var/event_severity = EVENT_LEVEL_MUNDANE)
	switch(event_severity)
		if(EVENT_LEVEL_MAJOR)
			command_announcement.Announce("[station_name()] has cleared the debris storm.", "[station_name()] Sensor Array")
		else
			command_announcement.Announce("[station_name()] has cleared the debris shower", "[station_name()] Sensor Array")

/datum/map/yonaguni/dust_detected_announcement(var/event_severity = EVENT_LEVEL_MUNDANE)
	command_announcement.Announce("Heavy shower of high-velocity particulate detected en route to [station_name()]. Please secure or avoid unshielded windows.", "Radar Array")

/datum/map/yonaguni/dust_ended_announcement(var/event_severity = EVENT_LEVEL_MUNDANE)
	command_announcement.Announce("The debris shower has cleared [station_name()].", "Radar Array")

/datum/map/yonaguni/ion_storm_announcement()
	command_announcement.Announce("Massive levels of electrical interference detected exterior to [station_name()]. Please monitor all electronic equipment for malfunctions.", "Anomaly Alert")

/datum/map/yonaguni/electrical_storm_starting_announce(var/event_severity = EVENT_LEVEL_MUNDANE)
	switch(event_severity)
		if(EVENT_LEVEL_MUNDANE)
			command_announcement.Announce("Minor electrical interference has been detected within [station_name()]. Please watch out for possible electrical discharges.", "Electrical Interference Alert")
		else
			command_announcement.Announce("Long-range instrumentation reports a massive incoming surge of electrical interference within [station_name()] is about to pass through an electrical storm. Please secure sensitive electrical equipment.", "Electrical Interference Alert")

/datum/map/yonaguni/electrical_storm_ending_announce()
	command_announcement.Announce("[station_name()] is no longer experiencing electrical interference. Please repair any electrical overloads.", "Electrical Interference Alert")

/datum/map/yonaguni/radiation_storm_starting_announce()
	command_announcement.Announce("High levels of radioactive particulate detected beneath [station_name()]. Please evacuate into one of the shielded maintenance tunnels.", "Radiation Plume")

/datum/map/yonaguni/radiation_storm_entered_announce()
	command_announcement.Announce("[station_name()] is now within the radiation plume. Please remain in a sheltered area until the radioactive material has passed.", "Radiation Plume")

/datum/map/yonaguni/radiation_storm_ending_announce()
	command_announcement.Announce("The radiation plume has passed [station_name()]. Please report to medical personnel if you experience any unusual symptoms. Maintenance will lose all access again shortly.", "Radiation Plume")

/datum/map/yonaguni/solar_storm_starting_announce()
	command_announcement.Announce("A major geothermal plume has been detected below [station_name()]. Please halt all exterior activites immediately and return to the interior of [station_name()].", "Geothermal Plume")

/datum/map/yonaguni/solar_storm_entered_announce()
	command_announcement.Announce("The geothermal plume has enveloped [station_name()]. Please refrain from external activities and remain inside until it has passed.", "Geothermal Plume")

/datum/map/yonaguni/solar_storm_ending_announce()
	command_announcement.Announce("The geothermal plume has passed [station_name()]. It is now safe to resume exterior activities. Please report to medbay if you experience any unusual symptoms. ", "Geothermal Plume")
