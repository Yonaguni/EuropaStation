/area/rimworld
	name = "planetary surface"
	icon_state = "surface"
	requires_power = 1
	always_unpowered = 0
	lighting_use_dynamic = 1
	power_light = 1
	power_equip = 1
	power_environ = 1
	flags = HIDE_DEATH_LOCATION | DENY_APC | IGNORE_ENDGAME | IGNORE_ALERTS | RAD_SHIELDED | DENY_TELEPORT | IGNORE_BLACKOUTS | IS_OCEAN

/area/rimworld/atmosalert()
	return

/area/rimworld/fire_alert()
	return

/area/rimworld/fire_reset()
	return

/area/rimworld/readyalert()
	return

/area/rimworld/partyalert()
	return
