// Ground Control to Major Tom, this song is cool, what's going on?
var/datum/music_track/lobby_music
var/list/all_lobby_music = list()

/proc/get_lobby_music(var/music_path)
	if(!all_lobby_music[music_path])
		all_lobby_music[music_path] = new music_path
	return all_lobby_music[music_path]

/client/proc/playtitlemusic()
	if(!lobby_music)
		lobby_music = pick(using_map.lobby_music_choices)
		if(ispath(lobby_music))
			lobby_music = get_lobby_music(lobby_music)
	if(istype(lobby_music))
		lobby_music.Play(src)

/client/proc/end_lobby_music()
	set waitfor = 0
	set background = 1

	while(playing_lobby_music)
		if(playing_lobby_music.volume > 0)
			playing_lobby_music.volume = max(0, playing_lobby_music.volume - 5)
			playing_lobby_music.status = SOUND_UPDATE
			src << playing_lobby_music
			sleep(1)
			continue
		src << sound(channel = 1)
		playing_lobby_music = null

/client
	var/sound/playing_lobby_music
