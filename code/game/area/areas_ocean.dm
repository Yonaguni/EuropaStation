/area/ocean
	name = "Ocean"
	icon_state = "ocean"
	requires_power = 1
	always_unpowered = 1
	power_light = 0
	power_equip = 0
	power_environ = 0
	flags = HIDE_DEATH_LOCATION | DENY_APC | IGNORE_ENDGAME | IGNORE_ALERTS | RAD_SHIELDED | DENY_TELEPORT | IGNORE_BLACKOUTS | IS_OCEAN

/area/initialize()
	..()
	if(flags & IS_OCEAN)
		color = "#66D1FF"
		icon = 'icons/effects/xgm_overlays.dmi'
		icon_state = "ocean"
		layer = GAS_OVERLAY_LAYER+0.1
		alpha = GAS_MAX_ALPHA

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

/area/ocean/abyss
	name = "Abyss Floor"
	icon_state = "abyss"
	sound_env = ASTEROID

/area/ocean/surface
	name = "Icy Wastes"
	icon_state = "surface"
