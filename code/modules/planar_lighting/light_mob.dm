/mob
	var/obj/master_plane/master_plane
	var/obj/dark_plane/dark_plane

/mob/Login()
	..()
	master_plane = new
	dark_plane = new
	if(client)
		client.screen += master_plane
		client.screen += dark_plane
	update_env_light()

/mob/dead/observer/Login()
	..()
	if (!seedarkness)
		client.screen -= master_plane
		client.screen -= dark_plane
