/mob
	var/obj/screen/master_plane/master_plane
	var/obj/screen/dark_plane/dark_plane

/mob/Login()
	..()
	if(!dark_plane)   dark_plane = new()
	if(!master_plane) master_plane = new()
	if(client)
		client.screen |= dark_plane
		client.screen |= master_plane

/mob/observer/ghost/Login()
	..()
	if(client)
		if(seedarkness)
			client.screen |= dark_plane
			client.screen |= master_plane
		else
			client.screen -= dark_plane
			client.screen -= master_plane
