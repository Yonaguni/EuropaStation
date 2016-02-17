/mob
	var/image/master_plane/master_plane
	var/image/light_plane/light_plane

/mob/Login()
	..()
	master_plane = new(loc=src)
	light_plane =  new(loc=src)
	if(client)
		client.images += master_plane
		client.images += light_plane

/* TODO PLANAR LIGHTING
/mob/living/carbon/human/Login()
	..()
	light_plane.alpha = species.darksight_alpha
*/