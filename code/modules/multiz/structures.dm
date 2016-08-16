//////////////////////////////
//Contents: Ladders, Stairs.//
//////////////////////////////

/obj/structure/ladder
	name = "ladder"
	desc = "A ladder.  You can climb it up (and down)."
	icon = 'icons/obj/structures/structures.dmi'
	icon_state = "ladderdown"
	density = 0
	opacity = 0
	anchored = 1

	var/obj/structure/ladder/target_up
	var/obj/structure/ladder/target_down

/obj/structure/ladder/update_icon()
	if(target_up && target_down)
		icon_state = "laddermid"
	else if(target_up)
		icon_state = "ladderup"
	else if(target_down)
		icon_state = "ladderdown"
	else
		icon_state = "ladderbroke"

/obj/structure/ladder/initialize()
	..()
	if(!target_down)
		var/turf/T = GetBelow(src)
		if(T)
			target_down = locate(/obj/structure/ladder) in T.contents
			if(target_down)
				target_down.target_up = src
				target_down.update_icon()
	if(!target_up)
		var/turf/T = GetAbove(src)
		if(T)
			target_up = locate(/obj/structure/ladder) in T.contents
			if(target_up)
				target_up.target_down = src
				target_up.update_icon()
	update_icon()

/obj/structure/ladder/Destroy()
	if(target_up && target_up.target_down == src)
		target_up.target_down = null
		target_up.update_icon()
	if(target_down && target_down.target_up == src)
		target_down.target_up = null
		target_down.update_icon()
	return ..()

/obj/structure/ladder/attack_hand(var/mob/M)

	if(!target_up && !target_down)
		M << "<span class='warning'>\The [src] is incomplete and can't be climbed.</span>"
		return

	var/obj/structure/ladder/climb_to
	if(target_up && target_down)
		if(alert("Do you wish to climb up or down?", "Climbing a ladder", "Up", "Down") == "Up")
			climb_to = target_up
		else
			climb_to = target_down
	else if(target_up)
		climb_to = target_up
	else
		climb_to = target_down

	if(!climb_to)
		return

	var/turf/T = get_turf(climb_to)
	if(T && T.density)
		M << "<span class='notice'>\The [T] is blocking \the [src].</span>"
		return

	for(var/atom/movable/A in T)
		if(A.density)
			M << "<span class='notice'>\The [A] is blocking \the [src].</span>"
			return

	var/updown = "[climb_to == target_up ? "up" : "down"]"
	M.visible_message("<span class='notice'>\The [M] climbs [updown] \the [src].</span>")
	M.forceMove(T)

/obj/structure/stairs
	name = "stairs"
	desc = "Stairs leading somewhere.  Not too useful if the gravity goes out."
	icon = 'icons/obj/structures/stairs.dmi'
	density = 0
	opacity = 0
	anchored = 1

/obj/structure/stairs/initialize()
	for(var/turf/turf in locs)
		var/turf/above = GetAbove(turf)
		if(!above)
			warning("Stair created without level above: ([loc.x], [loc.y], [loc.z])")
			return qdel(src)
		if(!istype(above) || !above.open_space)
			above.ChangeTurf(/turf/simulated/open)

/obj/structure/stairs/Uncross(atom/movable/A)
	if(A.dir == dir)
		// This is hackish but whatever.
		var/turf/target = get_step(GetAbove(A), dir)
		var/turf/source = A.loc
		if(target.Enter(A, source))
			A.loc = target
			target.Entered(A, source)
		return 0
	return 1

/obj/structure/stairs/north
	dir = NORTH
	bound_height = 64
	bound_y = -32
	pixel_y = -32

/obj/structure/stairs/south
	dir = SOUTH
	bound_height = 64

/obj/structure/stairs/east
	dir = EAST
	bound_width = 64
	bound_x = -32
	pixel_x = -32

/obj/structure/stairs/west
	dir = WEST
	bound_width = 64