/area/ocean
	name = "Ocean"
	icon_state = "ocean"
	flags = HIDE_DEATH_LOCATION | DENY_APC | IGNORE_ENDGAME | IGNORE_ALERTS | RAD_SHIELDED | DENY_TELEPORT | IGNORE_BLACKOUTS | IS_OCEAN

/area/ocean/New()
	ambience = ambient_tracks.Copy()
	..()

/area/ocean/abyss
	name = "Abyss Floor"
	icon_state = "abyss"
	sound_env = ASTEROID

/area/ocean/surface
	name = "Icy Wastes"
	icon_state = "surface"
