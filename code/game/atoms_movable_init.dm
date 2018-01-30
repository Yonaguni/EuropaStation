/atom/movable
	var/auto_init = 0

/atom/movable/New()
	..()
	if(auto_init)
		if(ticker && ticker.current_state == GAME_STATE_PLAYING)
			initialize()
		else
			init_atoms += src
