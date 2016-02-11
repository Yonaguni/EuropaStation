var/list/mob/living/forced_ambiance_list = new

/area
	var/music                          // Ambient music to play in this area.
	var/list/ambience = list(          // Set of random ambient sounds to pick from occasionally in this area.
		'sound/ambience/ambigen1.ogg',
		'sound/ambience/ambigen3.ogg',
		'sound/ambience/ambigen4.ogg',
		'sound/ambience/ambigen5.ogg',
		'sound/ambience/ambigen6.ogg',
		'sound/ambience/ambigen7.ogg',
		'sound/ambience/ambigen8.ogg',
		'sound/ambience/ambigen9.ogg',
		'sound/ambience/ambigen10.ogg',
		'sound/ambience/ambigen11.ogg',
		'sound/ambience/ambigen12.ogg',
		'sound/ambience/ambigen14.ogg'
		)
	var/list/forced_ambience = null
	var/sound_env = STANDARD_STATION

/area/proc/play_ambience(var/mob/living/L)
	// Ambience goes down here -- make sure to list each area seperately for ease of adding things in later, thanks! Note: areas adjacent to each other should have the same sounds to prevent cutoff when possible.- LastyScratch
	if(!(L && L.client && (L.client.prefs.toggles & SOUND_AMBIENCE)))	return

	// If we previously were in an area with force-played ambiance, stop it.
	if(L in forced_ambiance_list)
		L << sound(null, channel = 1)
		forced_ambiance_list -= L

	if(!L.client.ambience_playing)
		L.client.ambience_playing = 1
		L << sound('sound/ambience/desert_wind_short.ogg', repeat = 1, wait = 0, volume = 25, channel = 2)

	if(forced_ambience)
		if(forced_ambience.len)
			forced_ambiance_list |= L
			L << sound(pick(forced_ambience), repeat = 1, wait = 0, volume = 25, channel = 1)
		else
			L << sound(null, channel = 1)
	else if(src.ambience.len && prob(35))
		if((world.time >= L.client.played + 600))
			var/sound = pick(ambience)
			L << sound(sound, repeat = 0, wait = 0, volume = 25, channel = 1)
			L.client.played = world.time