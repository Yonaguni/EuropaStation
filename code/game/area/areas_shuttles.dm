// Shuttles!

/area/shuttle
	requires_power = 0
	sound_env = SMALL_ENCLOSED
	flags = DENY_APC | IGNORE_ALERTS | DENY_TELEPORT

/area/shuttle/escape
	name = "\improper Emergency Submarine"
	music = "music/escape.ogg"

/area/shuttle/escape/station
	name = "\improper Emergency Submarine Station"
	icon_state = "shuttle2"

/area/shuttle/escape/centcom
	name = "\improper Emergency Submarine Rhadamanthus"
	icon_state = "shuttle"

/area/shuttle/escape/transit // the area to pass through for 3 minute transit
	name = "\improper Emergency Submarine Transit"
	icon_state = "shuttle"

/area/shuttle/mining
	name = "\improper Mining Elevator"
	music = "music/escape.ogg"

/area/shuttle/mining/station
	icon_state = "shuttle2"

/area/shuttle/mining/outpost
	icon_state = "shuttle"
