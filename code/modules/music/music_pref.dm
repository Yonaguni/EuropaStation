/datum/client_preference/play_lobby_music
	description ="Play lobby music"
	key = "SOUND_LOBBY"

/datum/client_preference/play_lobby_music/toggled(var/mob/preference_mob, var/enabled)
	if(preference_mob.client && lobby_music)
		if(enabled)
			lobby_music.Play(preference_mob.client)
		else
			preference_mob.client << sound(channel = 1)