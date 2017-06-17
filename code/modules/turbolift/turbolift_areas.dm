// Used for creating the exchange areas.
/area/turbolift
	name = "Turbolift"
	forced_ambience = list('sound/music/elevatormusic.ogg')
	base_turf = /turf/simulated/open
	requires_power = 0
	sound_env = SMALL_ENCLOSED

	var/lift_announce_str = "Ding!"
	var/arrival_sound = 'sound/machines/ding.ogg'
