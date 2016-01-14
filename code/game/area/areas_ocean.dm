/area/ocean
	name = "Ocean"
	icon_state = "space"
	requires_power = 1
	always_unpowered = 1
	lighting_use_dynamic = 1
	power_light = 0
	power_equip = 0
	power_environ = 0
	flags = HIDE_DEATH_LOCATION | DENY_APC | IGNORE_ENDGAME | IGNORE_ALERTS | RAD_SHIELDED | DENY_TELEPORT | IGNORE_BLACKOUTS

/area/ocean/New()
	ambience = ambient_tracks.Copy()
	..()

area/ocean/atmosalert()
	return

/area/ocean/fire_alert()
	return

/area/ocean/fire_reset()
	return

/area/ocean/readyalert()
	return

/area/ocean/partyalert()
	return