/datum/music_track
	var/song_file
	var/name
	var/author
	var/url
	var/license
	var/license_url

/datum/music_track/proc/Play(var/client/listener)
	if(song_file && listener && listener.is_preference_enabled(/datum/client_preference/play_lobby_music))
		listener.playing_lobby_music = sound(song_file, repeat = 1, channel = 1, volume = 85)
		listener << listener.playing_lobby_music
		to_chat(listener, "<span class='notice'><b>Now playing:</b> <span class='alert'><a href='[url]'>[name]</a></span> by <span class='alert'><b>[author]</b></span> ([license ? "<a href='[license_url]'>[license]</a>": "no license supplied"])</span>")
