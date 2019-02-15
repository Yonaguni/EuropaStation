/obj/skybox
	name = "skybox"
	mouse_opacity = 0
	blend_mode = BLEND_MULTIPLY
	layer = SKYBOX_LAYER
	plane = SKYBOX_PLANE
	anchored = 1
	var/mob/owner
	var/image/image
	var/image/stars

/obj/skybox/Initialize()
	. = ..()
	var/mob/M = loc
	SSskybox.skyboxes += src
	owner = M
	loc = null
	color = SSskybox.BGcolor
	image = image('icons/turf/skybox.dmi', src, "background_[SSskybox.BGstate]")
	image.plane = plane
	image.layer = layer
	overlays += image

	if(SSskybox.use_stars)
		stars = image('icons/turf/skybox.dmi', src, SSskybox.star_state)
		stars.plane = plane
		stars.layer = layer
		stars.appearance_flags = RESET_COLOR
		overlays += stars
	DoRotate()
	update()

/obj/skybox/proc/update()
	if(isnull(owner) || isnull(owner.client))
		qdel(src)
	else
		var/turf/T = get_turf(owner.client.eye)
		screen_loc = "CENTER:[-224-(T&&T.x)],CENTER:[-224-(T&&T.y)]"

/obj/skybox/proc/DoRotate()
	var/matrix/rotation = matrix()
	rotation.TurnTo(SSskybox.BGrot)
	appearance = rotation

/obj/skybox/Destroy()
	overlays.Cut()
	if(owner)
		if(owner.skybox == src)
			owner.skybox = null
		owner = null
	image = null
	stars = null
	SSskybox.skyboxes -= src
	return ..()

/mob
	var/obj/skybox/skybox

/mob/Move()
	. = ..()
	if(. && skybox)
		skybox.update()

/mob/forceMove()
	. = ..()
	if(. && skybox)
		skybox.update()

/mob/Login()
	if(!skybox)
		skybox = new(src)
		skybox.owner = src
	client.screen += skybox
	..()

/mob/Destroy()
	if(client)
		client.screen -= skybox
	QDEL_NULL(skybox)
	return ..()