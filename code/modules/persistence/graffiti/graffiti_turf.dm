/turf/proc/can_engrave()
	return FALSE

/turf/proc/try_graffiti(var/mob/vandal, var/obj/item/tool)

	if(!tool.sharp || !can_engrave())
		return FALSE

	var/too_much_graffiti = 0
	for(var/obj/effect/decal/writing/W in src)
		too_much_graffiti++
	if(too_much_graffiti >= 5)
		to_chat(vandal, "<span class='warning'>There's too much graffiti here to add more.</span>")
		return FALSE

	var/message = sanitize(input("Enter a message to engrave.", "Graffiti") as null|text, trim = TRUE)
	if(!message)
		return FALSE

	if(!vandal || vandal.incapacitated() || !Adjacent(vandal) || !tool.loc == vandal)
		return FALSE

	vandal.visible_message("<span class='warning'>\The [vandal] begins carving something into \the [src].</span>")

	if(!do_after(vandal, max(20, length(message)), src))
		return FALSE

	vandal.visible_message("<span class='notice'>\The [vandal] carves some graffiti into \the [src].</span>")
	var/obj/effect/decal/writing/graffiti = new(src)
	graffiti.message = message
	graffiti.author = vandal.ckey

	if(lowertext(message) == "elbereth")
		to_chat(vandal, "<span class='notice'>You feel much safer.</span>")

	return TRUE

/turf/simulated/wall/can_engrave()
	return (material && material.hardness >= 10 && material.hardness <= 100)

/turf/simulated/floor/can_engrave()
	return (!flooring || flooring.can_engrave)

/turf/simulated/floor/natural/can_engrave()
	return FALSE

/turf/simulated/floor/water/can_engrave()
	return FALSE

/turf/simulated/wall/attackby(var/obj/item/thing, var/mob/user)
	if(!construction_stage && try_graffiti(user, thing))
		return
	. = ..()

/turf/simulated/floor/attackby(var/obj/item/thing, var/mob/user)

	if(thing.isscrewdriver() && flooring && (flooring.flags & TURF_REMOVE_SCREWDRIVER))
		return ..()

	// Place graffiti.
	if(try_graffiti(user, thing))
		return

	// Clear graffiti.
	if(thing.iswelder())
		var/obj/item/weldingtool/welder = thing
		if(welder.isOn())
			var/obj/effect/decal/writing/W = locate() in src
			if(W && welder.remove_fuel(0,user) && do_after(user, 5, src))
				if(W)
					playsound(src.loc, 'sound/items/Welder2.ogg', 50, 1)
					user.visible_message("<span class='notice'>\The [user] clears away some graffiti.</span>")
					qdel(W)
					return
	. = ..()

/turf/simulated/floor/make_plating(var/place_product, var/defer_icon_update)
	. = ..()
	for(var/obj/effect/decal/writing/W in src)
		qdel(W)

/turf/simulated/floor/set_flooring(var/decl/flooring/newflooring)
	. = ..()
	for(var/obj/effect/decal/writing/W in src)
		qdel(W)
