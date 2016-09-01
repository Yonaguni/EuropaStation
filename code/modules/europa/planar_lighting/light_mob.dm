/mob
	var/image/master_plane/master_plane
	var/image/dark_plane/dark_plane

/mob/Login()
	..()
	if(!dark_plane)   dark_plane = new(loc=src)
	if(!master_plane) master_plane = new(loc=src)
	if(client)
		client.images |= dark_plane
		client.images |= master_plane

/mob/observer/ghost/Login()
	..()
	if(client)
		if(seedarkness)
			client.images |= dark_plane
			client.images |= master_plane
		else
			client.images -= dark_plane
			client.images -= master_plane
