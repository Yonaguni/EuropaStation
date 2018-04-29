var/list/turf_edge_cache = list()

/turf
	icon = 'icons/turf/floors.dmi'
	level = 1
	var/holy = 0

	// Initial air contents (in moles)
	var/oxygen = 0
	var/carbon_dioxide = 0
	var/nitrogen = 0
	var/phoron = 0

	//Properties for airtight tiles (/wall)
	var/thermal_conductivity = 0.05
	var/heat_capacity = 1

	//Properties for both
	var/temperature = T20C      // Initial turf temperature.
	var/blocks_air = 0          // Does this turf contain air/let air through?

	// General properties.
	var/icon_old = null
	var/pathweight = 1          // How much does it cost to pathfind over this turf?
	var/blessed = 0             // Has the turf been blessed?

	var/accept_lattice
	var/blend_with_neighbors = 0
	var/outside

	var/list/decals

	var/obj/effect/flood/flood_object

// Parent code is duplicated in here instead of ..() for performance reasons.
/turf/Initialize(mapload)
	if(initialized)
		crash_with("Warning: [src]([type]) initialized multiple times!")
	initialized = TRUE

	if (mapload && (blend_with_neighbors || flooded || outside))
		queue_icon_update(TRUE)
	else if (update_icon_on_init)
		queue_icon_update()

	for (var/atom/movable/AM in src)
		src.Entered(AM)

	turfs += src

	if (mapload && permit_ao)
		queue_ao()

/turf/update_icon(update_neighbors = FALSE)
	var/list/ovr
	if(blend_with_neighbors)
		for(var/checkdir in cardinal)
			var/turf/T = get_step(src, checkdir)
			if(istype(T) && T.blend_with_neighbors && blend_with_neighbors < T.blend_with_neighbors && icon_state != T.icon_state)
				var/cache_key = "[T.icon_state]-[checkdir]"
				if(!turf_edge_cache[cache_key])
					turf_edge_cache[cache_key] = image(icon = 'icons/turf/blending_overlays.dmi', icon_state = "[T.icon_state]-edge", dir = checkdir)
				LAZYADD(ovr, turf_edge_cache[cache_key])

	if(is_flooded(absolute = 1))
		if (!flood_object)
			flood_object = new(src)
	else if (flood_object)
		QDEL_NULL(flood_object)

	if(config.starlight && using_map.ambient_exterior_light && outside)
		LAZYADD(ovr, get_exterior_light_overlay())

	add_overlay(ovr)

	if(update_neighbors)
		for(var/check_dir in alldirs)
			var/turf/T = get_step(src, check_dir)
			if(isturf(T))
				T.queue_icon_update()

/turf/attackby(var/obj/item/C, var/mob/user)

	if(istype(C, /obj/item/grab) && C.loc != src)
		var/obj/item/grab/G = C
		step_towards(G.affecting, src)
		return

	if(C.iscoil() && can_build_cable(user))
		var/obj/item/stack/cable_coil/coil = C
		coil.turf_place(src, user)
		return

	if(!accept_lattice)
		return

	if(istype(C, /obj/item/stack/rods))
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L) return
		var/obj/item/stack/rods/R = C
		if (R.use(1))
			user << "<span class='notice'>Constructing support lattice ...</span>"
			playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
			new /obj/structure/lattice(src)
		return

	if(istype(C, /obj/item/stack/tile/floor))
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			var/obj/item/stack/tile/floor/S = C
			if (S.get_amount() < 1) return
			qdel(L)
			playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
			S.use(1)
			ChangeTurf(/turf/simulated/floor)
		else
			user << "<span class='warning'>The plating is going to need some support.</span>"
		return

	. = ..()

/turf/Destroy()
	turfs -= src
	remove_cleanables()
	return ..()

/turf/ex_act(severity)
	return 0

/turf/proc/is_solid_structure()
	return 1

/turf/Enter(var/atom/movable/mover, atom/forget as mob|obj|turf|area)

	..()

	if (!mover || !isturf(mover.loc) || isobserver(mover))
		return 1

	//First, check objects to block exit that are not on the border
	for(var/obj/obstacle in mover.loc)
		if(!(obstacle.flags & ON_BORDER) && (mover != obstacle) && (forget != obstacle))
			if(!obstacle.CheckExit(mover, src))
				mover.Bump(obstacle, 1)
				return 0

	//Now, check objects to block exit that are on the border
	for(var/obj/border_obstacle in mover.loc)
		if((border_obstacle.flags & ON_BORDER) && (mover != border_obstacle) && (forget != border_obstacle))
			if(!border_obstacle.CheckExit(mover, src))
				mover.Bump(border_obstacle, 1)
				return 0

	//Next, check objects to block entry that are on the border
	for(var/obj/border_obstacle in src)
		if(border_obstacle.flags & ON_BORDER)
			if(!border_obstacle.CanPass(mover, mover.loc, 1, 0) && (forget != border_obstacle))
				mover.Bump(border_obstacle, 1)
				return 0

	//Then, check the turf itself
	if (!src.CanPass(mover, src))
		mover.Bump(src, 1)
		return 0

	//Finally, check objects/mobs to block entry that are not on the border
	for(var/atom/movable/obstacle in src)
		if(!(obstacle.flags & ON_BORDER))
			if(!obstacle.CanPass(mover, mover.loc, 1, 0) && (forget != obstacle))
				mover.Bump(obstacle, 1)
				return 0
	return 1 //Nothing found to block so return success!

var/const/enterloopsanity = 100
/turf/Entered(atom/atom as mob|obj)

	. = ..()

	if(!istype(atom, /atom/movable))
		return

	var/atom/movable/A = atom

	if(ismob(A))
		var/mob/M = A
		if(!M.check_solid_ground())
			inertial_drift(M)
			//we'll end up checking solid ground again but we still need to check the other things.
			//Ususally most people aren't in space anyways so hopefully this is acceptable.
			M.update_floating()
		else
			M.inertia_dir = 0
			M.make_floating(0) //we know we're not on solid ground so skip the checks to save a bit of processing

	var/objects = 0
	if(A && (A.flags & PROXMOVE))
		for(var/atom/movable/thing in range(1))
			if(objects > enterloopsanity) break
			objects++
			spawn(0)
				if(A)
					A.HasProximity(thing, 1)
					if ((thing && A) && (thing.flags & PROXMOVE))
						thing.HasProximity(A, 1)
	return

/turf/proc/adjacent_fire_act(turf/simulated/floor/source, temperature, volume)
	return

/turf/proc/is_plating()
	return open_space

/turf/proc/inertial_drift(atom/movable/A)
	if(!(A.last_move))	return
	if((istype(A, /mob/) && src.x > 2 && src.x < (world.maxx - 1) && src.y > 2 && src.y < (world.maxy-1)))
		var/mob/M = A
		if(M.Allow_Spacemove(1)) //if this mob can control their own movement in space then they shouldn't be drifting
			M.inertia_dir  = 0
			return
		addtimer(CALLBACK(src, .proc/check_inertial_drift, M), 5)
	return

/turf/proc/check_inertial_drift(var/mob/M)
	if(!M || LAZYLEN(M.grabbed_by) || M.anchored || M.loc != src)
		return
	if(!M.inertia_dir)
		M.inertia_dir = M.last_move
	step(M, M.inertia_dir)

/turf/proc/levelupdate()
	for(var/obj/O in src)
		O.hide(O.hides_under_flooring() && !is_plating())

/turf/proc/AdjacentTurfs()
	var/L[] = new()
	for(var/turf/simulated/t in oview(src,1))
		if(!t.density)
			if(!LinkBlocked(src, t) && !TurfBlockedNonWindow(t))
				L.Add(t)
	return L

/turf/proc/CardinalTurfs()
	var/L[] = new()
	for(var/turf/simulated/T in AdjacentTurfs())
		if(T.x == src.x || T.y == src.y)
			L.Add(T)
	return L

/turf/proc/Distance(turf/t)
	if(get_dist(src,t) == 1)
		var/cost = (src.x - t.x) * (src.x - t.x) + (src.y - t.y) * (src.y - t.y)
		cost *= (pathweight+t.pathweight)/2
		return cost
	else
		return get_dist(src,t)

/turf/proc/AdjacentTurfsSpace()
	var/L[] = new()
	for(var/turf/t in oview(src,1))
		if(!t.density)
			if(!LinkBlocked(src, t) && !TurfBlockedNonWindow(t))
				L.Add(t)
	return L

/turf/process()
	return PROCESS_KILL

/turf/proc/contains_dense_objects()
	if(density)
		return 1
	for(var/atom/A in src)
		if(A.density && !(A.flags & ON_BORDER))
			return 1
	return 0

//expects an atom containing the reagents used to clean the turf
/turf/proc/clean(atom/source, mob/user = null)
	if(source.reagents.has_reagent("water", 1) || source.reagents.has_reagent("cleaner", 1))
		clean_blood()
		remove_cleanables()
	else
		user << "<span class='warning'>\The [source] is too dry to wash that.</span>"
	source.reagents.trans_to_turf(src, 1, 10)	//10 is the multiplier for the reaction effect. probably needed to wet the floor properly.

/turf/proc/remove_cleanables()
	for(var/obj/effect/O in src)
		if(istype(O,/obj/effect/decal/cleanable) || istype(O,/obj/effect/overlay))
			qdel(O)

/turf/proc/update_blood_overlays()
	return

/turf/proc/can_build_cable(var/mob/user)
	return open_space
