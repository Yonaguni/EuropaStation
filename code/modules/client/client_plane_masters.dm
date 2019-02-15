/obj/screen/plane
	name = ""
	icon = 'icons/effects/plane_master.dmi'
	icon_state = "square"
	color = list(null,null,null,"#0000","#000f")  // Completely black.
	screen_loc = "CENTER"
	layer = 1
	blend_mode = BLEND_ADD
	appearance_flags = PLANE_MASTER | RESET_TRANSFORM | RESET_COLOR | RESET_ALPHA | KEEP_TOGETHER

/obj/screen/plane/New(var/client/C)
	..()
	if(istype(C)) 
		C.screen += src
	verbs.Cut()

/obj/screen/plane/viewport
	plane = DEFAULT_PLANE

/obj/screen/plane/darkness
	plane = LIGHTING_PLANE

/client
	var/list/plane_masters

/client/New()
	..()
	plane_masters = list(
		new /obj/screen/plane/darkness(src),
		new /obj/screen/plane/viewport(src)
	)

/client/Del()
	screen -= plane_masters
	for(var/thing in plane_masters)
		qdel(thing)
	plane_masters.Cut()
	. = ..()

/mob/Login()
	. = ..()
	if(client)
		client.screen |= client.plane_masters
