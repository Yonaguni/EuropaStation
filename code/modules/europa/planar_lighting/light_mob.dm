/mob
	var/obj/screen/plane/master/master_plane
	var/obj/screen/plane/dark/dark_plane

/mob/Login()
	. = ..()
	if(!dark_plane)
		dark_plane = new(client)
	if(!master_plane)
		master_plane = new(client)

/mob/observer/ghost/Login()
	. = ..()
	if(client)
		if(seedarkness)
			client.screen |= dark_plane
			client.screen |= master_plane
		else
			client.screen -= dark_plane
			client.screen -= master_plane
