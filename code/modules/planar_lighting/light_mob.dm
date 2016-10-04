/mob
	var/obj/screen/plane/master/master_plane
	var/obj/screen/plane/dark/dark_plane

/mob/Login()
	..()
	master_plane = new(client)
	dark_plane = new(client)
	update_env_light()

/mob/dead/observer/Login()
	..()
	if (!seedarkness)
		client.screen -= master_plane
		client.screen -= dark_plane

/mob/dead/observer/updateghostsight()
	..()
	if(client)
		if(!seedarkness)
			client.screen -= master_plane
			client.screen -= dark_plane
		else
			client.screen += master_plane
			client.screen += dark_plane
