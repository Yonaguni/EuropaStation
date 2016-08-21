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

/obj/structure/grille/CanPass(var/atom/movable/mover, var/passflag)
	if(istype(mover, /obj/item/projectile))
		return prob(30)
	return ..(mover, PASSGRILLE)

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