// Included predominantly for compilation reasons.
/mob
	//thou shall always be able to see the Geometer of Blood
	var/image/narsimage = null
	var/image/narglow = null

/mob/proc/cultify()
	return

/mob/dead/cultify()
	if(icon_state != "ghost-narsie")
		icon = 'icons/mob/mob.dmi'
		icon_state = "ghost-narsie"
		overlays = 0
		invisibility = 0
		src << "<span class='sinister'>Even as a non-corporal being, you can feel Nar-Sie's presence altering you. You are now visible to everyone.</span>"

/mob/living/cultify()
	dust()

/mob/proc/see_narsie(var/obj/singularity/narsie/large/N, var/dir)
	if(N.chained)
		if(narsimage)
			qdel(narsimage)
			qdel(narglow)
		return
	if((N.z == src.z)&&(get_dist(N,src) <= (N.consume_range+10)) && !(N in view(src)))
		if(!narsimage) //Create narsimage
			narsimage = image('icons/obj/narsie.dmi',src.loc,"narsie",9,1)
			narsimage.mouse_opacity = 0
		if(!narglow) //Create narglow
			narglow = image('icons/obj/narsie.dmi',narsimage.loc,"glow-narsie",12,1)
			narglow.mouse_opacity = 0
		//Else if no dir is given, simply send them the image of narsie
		var/new_x = 32 * (N.x - src.x) + N.pixel_x
		var/new_y = 32 * (N.y - src.y) + N.pixel_y
		narsimage.pixel_x = new_x
		narsimage.pixel_y = new_y
		narglow.pixel_x = new_x
		narglow.pixel_y = new_y
		narsimage.loc = src.loc
		narglow.loc = src.loc
		//Display the new narsimage to the player
		src << narsimage
		src << narglow
	else
		if(narsimage)
			qdel(narsimage)
			qdel(narglow)


/obj/proc/cultify()
	qdel(src)

/obj/effect/decal/cleanable/blood/cultify()
	return

/obj/item/remains/cultify()
	return

/obj/effect/overlay/cultify()
	return

/obj/item/stack/material/wood/cultify()
	return

/obj/item/weapon/material/sword/cultify()
	new /obj/item/weapon/melee/cultblade(loc)
	..()

/obj/item/weapon/storage/backpack/cultify()
	new /obj/item/weapon/storage/backpack/cultpack(loc)
	..()

/obj/item/weapon/storage/backpack/cultpack/cultify()
	return

/obj/machinery/atmospherics/cultify()
	if(src.invisibility != INVISIBILITY_MAXIMUM)
		src.invisibility = INVISIBILITY_MAXIMUM
		density = 0

/obj/machinery/door/airlock/external/cultify()
	new /obj/structure/simple_door/wood(loc)
	..()

/obj/machinery/door/cultify()
	if(invisibility != INVISIBILITY_MAXIMUM)
		invisibility = INVISIBILITY_MAXIMUM
		density = 0
		anim(target = src, a_icon = 'icons/effects/effects.dmi', a_icon_state = "breakdoor", sleeptime = 10)
		qdel(src)

/obj/machinery/door/firedoor/cultify()
	qdel(src)

/obj/machinery/mech_sensor/cultify()
	qdel(src)

/obj/machinery/power/apc/cultify()
	if(src.invisibility != INVISIBILITY_MAXIMUM)
		src.invisibility = INVISIBILITY_MAXIMUM

/obj/structure/bed/chair/cultify()
	var/obj/structure/bed/chair/wood/wings/I = new(loc)
	I.dir = dir
	..()

/obj/structure/bed/chair/wood/cultify()
	return

/obj/structure/bookcase/cultify()
	return

/obj/structure/grille/cultify()
	new /obj/structure/grille/cult(get_turf(src))
	..()

/obj/structure/grille/cult/cultify()
	return

/obj/structure/simple_door/cultify()
	new /obj/structure/simple_door/wood(loc)
	..()

/obj/structure/simple_door/wood/cultify()
	return

/obj/singularity/cultify()
	var/dist = max((current_size - 2), 1)
	explosion(get_turf(src), dist, dist * 2, dist * 4)
	qdel(src)

/obj/structure/shuttle/engine/propulsion/cultify()
	var/turf/T = get_turf(src)
	if(T)
		T.ChangeTurf(/turf/simulated/wall/cult)
	..()

/obj/structure/table/cultify()
	// Make it a wood-reinforced wooden table.
	// There are cult materials available, but it'd make the table non-deconstructable with how holotables work.
	// Could possibly use a new material var for holographic-ness?
	material = get_material_by_name("wood")
	reinforced = get_material_by_name("wood")
	update_desc()
	update_connections(1)
	update_icon()
	update_material()

/turf/proc/cultify()
	ChangeTurf(/turf/space)
	return

/turf/simulated/floor/cultify()
	//todo: flooring datum cultify check
	cultify_floor()

/turf/simulated/shuttle/floor/cultify()
	cultify_floor()

/turf/simulated/shuttle/floor4/cultify()
	cultify_floor()

/turf/simulated/shuttle/wall/cultify()
	cultify_wall()

/turf/simulated/wall/cultify()
	cultify_wall()

/turf/simulated/wall/cult/cultify()
	return

/turf/unsimulated/wall/cult/cultify()
	return

/turf/unsimulated/beach/cultify()
	return

/turf/unsimulated/floor/cultify()
	cultify_floor()

/turf/unsimulated/wall/cultify()
	cultify_wall()

/turf/proc/cultify_floor()
	if((icon_state != "cult")&&(icon_state != "cult-narsie"))
		name = "engraved floor"
		icon_state = "cult"

/turf/proc/cultify_wall()
	ChangeTurf(/turf/unsimulated/wall/cult)
