/mob
	var/obj/screen/plane/master/master_plane
	var/obj/screen/plane/dark/dark_plane

/mob/Login()
	. = ..()
	dark_plane = new(client)
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
