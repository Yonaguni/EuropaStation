/mob
	var/obj/render_plane/master_plane/master_plane
	var/obj/render_plane/dark_plane/dark_plane
	var/obj/render_plane/gui_plane/gui_plane

/mob/Login()
	..()
	master_plane = new(src)
	dark_plane = new(src)
	gui_plane = new(src)
/*	if(client)
		client.screen += master_plane
		client.screen += dark_plane*/
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
			client.screen |= master_plane
			client.screen |= dark_plane
