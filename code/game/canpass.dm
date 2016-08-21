/atom/proc/CanPass(var/atom/movable/mover, var/passflag)
	if(passflag && istype(mover) && mover.checkpass(passflag))
		return 1
	return !density

/obj/effect/effect/smoke/bad/CanPass(var/atom/movable/mover, var/passflag)
	if(istype(mover, /obj/item/projectile/beam))
		var/obj/item/projectile/beam/B = mover
		B.damage = (B.damage/2)
	return ..(mover, passflag)

/obj/effect/spider/stickyweb/CanPass(var/atom/movable/mover, var/passflag)
	if(istype(mover, /mob/living))
		if(prob(50))
			mover << "<span class='warning'>You get stuck in \the [src] for a moment.</span>"
			return 0
	else if(istype(mover, /obj/item/projectile))
		return prob(30)
	return 1

/obj/item/tape/CanPass(var/atom/movable/mover, var/passflag)
	if(!lifted && ismob(mover))
		var/mob/M = mover
		add_fingerprint(M)
		if (!allowed(M))	//only select few learn art of not crumpling the tape
			M << "<span class='warning'>You are not supposed to go past [src]...</span>"
			if(M.a_intent == I_HELP)
				return 0
			crumple()
	return ..(mover)

/obj/machinery/door/CanPass(var/atom/movable/mover, var/passflag)
	return ..(mover, (opacity ? PASSGLASS : null))

/obj/machinery/door/airlock/CanPass(var/atom/movable/mover, var/passflag)
	if(src.isElectrified())
		if (istype(mover, /obj/item))
			var/obj/item/i = mover
			if (i.matter && (DEFAULT_WALL_MATERIAL in i.matter) && i.matter[DEFAULT_WALL_MATERIAL] > 0)
				var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
				s.set_up(5, 1, src)
				s.start()
	return ..(mover, passflag)

/obj/machinery/door/window/CanPass(var/atom/movable/mover, var/passflag)
	return (density && get_dir(mover.loc, src) == dir) || ..(mover, PASSGLASS)

/obj/structure/barricade/CanPass(var/atom/movable/mover, var/passflag)
	return ..(mover, PASSTABLE)

/obj/structure/aquarium/CanPass(var/atom/movable/mover, var/passflag)
	var/obj/structure/aquarium/A = locate() in mover.loc
	return (A || ..(mover, PASSGLASS))

/obj/structure/coatrack/CanPass(var/atom/movable/mover, var/passflag)
	var/can_hang = 0
	for (var/T in allowed)
		if(istype(mover,T))
			can_hang = 1
	if (can_hang && !coat)
		src.visible_message("[mover] lands on \the [src].")
		coat = mover
		coat.loc = src
		update_icon()
		return 0
	else
		return 1

/obj/structure/grille/CanPass(var/atom/movable/mover, var/passflag)
	if(istype(mover, /obj/item/projectile))
		return prob(30)
	return ..(mover, PASSGRILLE)

/obj/structure/iv_drip/CanPass(var/atom/movable/mover, var/passflag)
	return ..(mover, PASSTABLE)

/obj/structure/plasticflaps/CanPass(var/atom/movable/mover, var/passflag)
	if(istype(mover, /obj))
		var/obj/O = mover
		if(!istype(O, /obj/vehicle) && !O.buckled_mob)
			return 1
	else if(istype(mover, /mob/living))
		var/mob/living/M = mover
		if(!M.lying || !issmall(M))
			for(var/mob_type in mobs_can_pass)
				if(istype(mover, mob_type))
					return 1
		else
			return 1
	return ..(mover, PASSGLASS)

/obj/structure/windoor_assembly/CanPass(var/atom/movable/mover, var/passflag)
	return (density && get_dir(mover.loc, src) == dir) || ..(mover, PASSGLASS)

/obj/structure/window/CanPass(var/atom/movable/mover, var/passflag)
	if(is_full_window())
		return ..(mover, PASSGLASS)
	return ((density && get_dir(mover.loc, src) == dir) || ..(mover, PASSGLASS))

/obj/effect/meteor/CanPass(var/atom/movable/mover, var/passflag)
	return istype(mover, /obj/effect/meteor) ? 1 : ..(mover, passflag)

/mob/dead/CanPass(var/atom/movable/mover, var/passflag)
	return 1

/obj/item/projectile/CanPass(var/atom/movable/mover, var/passflag)
	return 1

/obj/machinery/hydroponics/CanPass(var/atom/movable/mover, var/passflag)
	return ..(mover,PASSTABLE)

/mob/CanPass(var/atom/movable/mover, var/passflag)
	if(ismob(mover))
		var/mob/moving_mob = mover
		if ((other_mobs && moving_mob.other_mobs))
			return 1
	return (!mover.density || !density || lying)

/obj/machinery/disposal/CanPass(var/atom/movable/mover, var/passflag)
	if (istype(mover,/obj/item) && mover.throwing)
		var/obj/item/I = mover
		if(istype(I, /obj/item/projectile))
			return
		if(prob(75))
			I.forceMove(src)
			for(var/mob/M in viewers(src))
				M.show_message("\The [I] lands in \the [src].", 3)
		else
			for(var/mob/M in viewers(src))
				M.show_message("\The [I] bounces off of \the [src]'s rim!", 3)
		return 0
	else
		return ..()

/obj/structure/table/CanPass(var/atom/movable/mover, var/passflag)
	if(istype(mover,/obj/item/projectile))
		return (check_cover(mover,loc))
	if (flipped == 1)
		if (get_dir(loc, mover.loc) == dir)
			return !density
		else
			return 1
	if(locate(/obj/structure/table) in get_turf(mover))
		return 1
	return ..(mover, PASSTABLE)