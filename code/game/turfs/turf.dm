var/list/turf_edge_cache = list()

/turf
	icon = 'icons/turf/floors.dmi'
	level = 1
	var/holy = 0

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
	var/dynamic_lighting = 1    // Does the turf use dynamic lighting?
	var/list/decals
	var/liquid = -1
	var/accept_lattice
	var/blend_with_neighbors = 0

/turf/New()

	..()

	var/area/A = get_area(src)
	if(istype(A) && (A.flags & IS_OCEAN))
		flooded = 1

	turfs |= src
	for(var/atom/movable/AM as mob|obj in src)
		spawn(0)
			src.Entered(AM)
			return
	if(dynamic_lighting)
		luminosity = 0
	else
		luminosity = 1

/turf/attackby(var/obj/item/C as obj, var/mob/user)
	if(accept_lattice)
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

/turf/proc/initialize()
	var/game_started = (ticker && ticker.current_state == GAME_STATE_PLAYING)
	if(game_started && fluid_master)
		fluid_update()
	update_icon(game_started)
	return

/turf/proc/update_icon(var/update_neighbors = 0, var/list/previously_added = list())
	var/list/overlays_to_add = previously_added
	if(blend_with_neighbors)
		for(var/checkdir in cardinal)
			var/turf/T = get_step(src, checkdir)
			if(istype(T) && T.blend_with_neighbors && blend_with_neighbors < T.blend_with_neighbors && icon_state != T.icon_state)
				var/cache_key = "[T.icon_state]-[checkdir]"
				if(!turf_edge_cache[cache_key])
					turf_edge_cache[cache_key] = image(icon = 'icons/turf/blending_overlays.dmi', icon_state = "[T.icon_state]-edge", dir = checkdir)
				overlays_to_add += turf_edge_cache[cache_key]
	var/area/A = get_area(src)
	if(flooded && (!istype(A) || !(A.flags & IS_OCEAN)))
		overlays_to_add += ocean_overlay_img

	overlays = overlays_to_add

	if(update_neighbors)
		for(var/check_dir in alldirs)
			var/turf/T = get_step(src, check_dir)
			if(istype(T))
				T.update_icon()

/turf/Destroy()
	turfs -= src
	processing_turfs -= src
	var/turf/self = src
	spawn(1)
		for(var/checkdir in cardinal)
			var/turf/T = get_step(self, checkdir)
			T.update_icon()
	return ..()

/turf/ex_act(severity)
	return 0

/turf/proc/is_space()
	return 0

/turf/proc/is_intact()
	return 0

/turf/attack_hand(mob/user)
	if(!(user.canmove) || user.restrained() || !(user.pulling))
		return 0
	if(user.pulling.anchored || !isturf(user.pulling.loc))
		return 0
	if(user.pulling.loc != user.loc && get_dist(user, user.pulling) > 1)
		return 0
	if(ismob(user.pulling))
		var/mob/M = user.pulling
		var/atom/movable/t = M.pulling
		M.stop_pulling()
		step(user.pulling, get_dir(user.pulling.loc, src))
		M.start_pulling(t)
	else
		step(user.pulling, get_dir(user.pulling.loc, src))
	return 1

/turf/Enter(atom/movable/mover as mob|obj, atom/forget as mob|obj|turf|area)
	..()
	if (!mover || !isturf(mover.loc))
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

var/const/proxloopsanity = 100
/turf/Entered(atom/atom as mob|obj)

	if(!istype(atom, /atom/movable))
		return

	var/atom/movable/A = atom

	if(ismob(A))
		var/mob/M = A
		if(!M.lastarea)
			M.lastarea = get_area(M.loc)
		if(!M.lastarea.has_gravity)
			inertial_drift(M)
			M.make_floating(0)

	var/objects = 0
	if(A && (A.flags & PROXMOVE))
		for(var/atom/movable/thing in range(1))
			if(objects > proxloopsanity) break
			objects++
			if(A == thing)
				continue
			spawn(0)
				if(A && thing)
					A.HasProximity(thing, 1)
					if(thing.flags & PROXMOVE)
						thing.HasProximity(A, 1)
	return

/*
/turf/Exited(var/atom/movable/obj)
	. = ..()
	if(obj && (obj.flags & PROXMOVE))
		var/objs = 0
		for(var/atom/movable/thing in range(1))
			if(objs > proxloopsanity)
				break
			objs++
			if(obj == thing)
				continue
			spawn(0)
				if(obj && thing)
					obj.HasProximity(thing, 1)
					if(thing.flags & PROXMOVE)
						thing.HasProximity(obj, 1)
*/

/turf/proc/adjacent_fire_act(turf/simulated/floor/source, temperature, volume)
	return

/turf/proc/is_plating()
	return 0

/turf/proc/inertial_drift(atom/movable/A as mob|obj)
	if(!(A.last_move))	return
	if((istype(A, /mob/) && src.x > 2 && src.x < (world.maxx - 1) && src.y > 2 && src.y < (world.maxy-1)))
		var/mob/M = A
		if(M.Process_Spacemove(1))
			M.inertia_dir  = 0
			return
		spawn(5)
			if((M && !(M.anchored) && !(M.pulledby) && (M.loc == src)))
				if(M.inertia_dir)
					step(M, M.inertia_dir)
					return
				M.inertia_dir = M.last_move
				step(M, M.inertia_dir)
	return

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

/turf/proc/process()
	return PROCESS_KILL

/turf/proc/contains_dense_objects()
	if(density)
		return 1
	for(var/atom/A in src)
		if(A.density && !(A.flags & ON_BORDER))
			return 1
	return 0

//expects an atom containing the reagents used to clean the turf
/turf/proc/clean(atom/source, mob/user)
	if(source.reagents.has_reagent(REAGENT_ID_WATER, 1) || source.reagents.has_reagent(REAGENT_ID_CLEANER, 1))
		clean_blood()
		if(istype(src, /turf/simulated))
			var/turf/simulated/T = src
			T.dirt = 0
		for(var/obj/effect/O in src)
			if(istype(O,/obj/effect/decal/cleanable))
				qdel(O)
	else
		user << "<span class='warning'>\The [source] is too dry to wash that.</span>"
	source.reagents.trans_to_turf(src, 1, 10)	//10 is the multiplier for the reaction effect. probably needed to wet the floor properly.

/atom/proc/is_flooded(var/lying_mob)
	var/turf/T = get_turf(src)
	return T.is_flooded(lying_mob)

/turf/is_flooded(var/lying_mob)
	if(flooded)
		return 1
	var/depth = get_fluid_depth()
	if(depth && depth > (lying_mob ? 30 : 70))
		return 1
	return 0

/turf/proc/get_fluid_depth()
	return flooded ? 1200 : 0

/turf/simulated/get_fluid_depth()
	if(flooded)
		return 1200
	if(liquid == -1)
		var/datum/gas_mixture/fluid/LM = return_fluids()
		if(LM) liquid = LM.total_moles //todo
	return liquid

/turf/proc/update_blood_overlays()
	return