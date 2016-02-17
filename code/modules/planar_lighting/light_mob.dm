/mob
	var/image/master_plane/master_plane
	var/image/darkness_plane/darkness

/mob/Login()
	..()
	master_plane = new(loc=src)
	darkness = new(loc=src)
	src << master_plane
	src << darkness
	if(client)
		client.images += master_plane
		client.images += darkness
