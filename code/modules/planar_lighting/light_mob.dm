/mob
	var/image/master_plane/master_plane
	var/image/dark_plane/dark_plane

/mob/Login()
	..()
	master_plane = new(loc=src)
	dark_plane =   new(loc=src)
	if(client)
		client.images += master_plane
		client.images += dark_plane
	update_env_light()

/mob/dead/observer/Login()
	..()
	if (!seedarkness)
		client.images -= master_plane
		client.images -= dark_plane
