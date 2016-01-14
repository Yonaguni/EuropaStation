// Shuttles!
/area/shuttle
	requires_power = 0
	sound_env = SMALL_ENCLOSED
	flags = DENY_APC | IGNORE_ALERTS | DENY_TELEPORT

/area/shuttle/escape
	name = "Evacuation Pod"
	music = "music/escape.ogg"

/area/shuttle/escape/station
	icon_state = "shuttle_end"
	base_turf = /turf/simulated/floor

/area/shuttle/escape/outpost
	icon_state = "shuttle_origin"
	base_turf = /turf/simulated/open

/area/shuttle/escape/transit // the area to pass through for 3 minute transit
	icon_state = "shuttle_transit"
	base_turf = /turf/simulated/open

/area/shuttle/mining
	name = "Mining Elevator"
	music = "music/escape.ogg"

/area/shuttle/mining/station
	icon_state = "shuttle_origin"
	base_turf = /turf/simulated/open

/area/shuttle/mining/outpost
	icon_state = "shuttle_end"
	base_turf = /turf/simulated/floor
