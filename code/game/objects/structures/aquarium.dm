var/list/fishtank_cache = list()

#define AQUARIUM_MOB_SHIFT 5 // Number of pixels mobs get shifted upwards. Mostly so feet don't poke out of the bottom.

/obj/effect/aquarium_overlay
	name = ""
	mouse_opacity = 0
	var/obj/structure/aquarium/AQ
	New(loc, aquarium)
		..(loc)
		AQ = aquarium
		verbs.Cut()
	Destroy()
		AQ.AO = null
		AQ = null
		..()

/obj/structure/aquarium
	name = "fishtank"
	icon_state = "preview"
	icon = 'icons/obj/europa/structures/fishtanks.dmi'
	anchored = 1
	density = 1
	var/health = 50
	var/deleting
	var/fill_type = REAGENT_ID_WATER
	var/fill_amt = 300
	climbable = 1
	flags = ON_BORDER

	var/obj/effect/aquarium_overlay/AO // I don't like this, but there's no other way to get a mouse-transparent overlay :(

/obj/structure/aquarium/return_air()
	var/datum/gas_mixture/GM
	for(var/datum/reagent/A in reagents.reagent_list)
		if(!isnull(gas_data.flags[A.id]))
			if(!GM) GM = new
			GM.adjust_gas(A.id, A.volume)
	return GM ? GM : ..()

/obj/structure/aquarium/New()
	..()
	initial_fill()
	AO = new(loc, src)
	update_icon(1)

/obj/structure/aquarium/Destroy()
	qdel(AO)
	. = loc
	loc = null
	for(var/obj/structure/aquarium/A in orange(1, .))
		A.update_icon()
	loc = .
	return ..()

/obj/structure/aquarium/proc/initial_fill()
	create_reagents(fill_amt)
	reagents.add_reagent(fill_type, fill_amt)

/obj/structure/aquarium/attack_hand(var/mob/user)
	visible_message("<span class='notice'>\The [user] taps on \the [src].</span>")

/obj/structure/aquarium/attackby(var/obj/item/W, var/mob/user)
	if(W.force >= 5)
		health -= W.force
		visible_message("<span class='danger'>\The [user] strikes \the [src] with \the [W]!</span>")
		playsound(get_turf(src), 'sound/effects/Glasshit.ogg', 75, 1)
		check_health()
	else
		visible_message("<span class='notice'>\The [user] taps \the [src] harmlessly with \the [W].</span>")
	return

/obj/structure/aquarium/proc/check_health()
	//Todo damage overlays.
	if(health <= 0)
		shatter()

/obj/structure/aquarium/proc/shatter(var/silent)
	//Todo leave wreckage based on remaining health.
	deleting = 1
	var/turf/T = get_turf(src)
	playsound(T, "shatter", 70, 1)
	PoolOrNew(/obj/item/weapon/material/shard, T)
	if(!silent)
		if(contents.len || reagents.total_volume)
			visible_message("<span class='danger'>\The [src] shatters, spilling its contents everywhere!</span>")
		else
			visible_message("<span class='danger'>\The [src] shatters!</span>")
	dump_contents()
	for(var/obj/structure/aquarium/A in orange(1, src))
		if(!A.deleting)
			A.shatter(1)
	qdel(src)

/obj/structure/aquarium/proc/dump_contents()
	var/datum/gas_mixture/environment = loc.return_air()
	if(!istype(environment))
		return
	for(var/atom/movable/AM in contents)
		if(!AM.simulated)
			continue
		AM.loc = get_turf(src)
	for(var/datum/reagent/A in reagents.reagent_list)
		if(!isnull(gas_data.flags[A.id]))
			environment.adjust_gas(A.id, A.volume)

/obj/structure/aquarium/update_icon(propagate = 0)
	var/list/connect_dirs = list()
	for(var/obj/structure/aquarium/A in orange(1, src))
		connect_dirs |= get_dir(src, A)
	var/list/c_states = dirs_to_unified_corner_states(connect_dirs)
	var/image/I

	icon_state = ""
	overlays.Cut()
	AO.overlays.Cut()
	var/cache_key

	for(var/i = 1 to 4)
		cache_key = "[c_states[i]]-[i]"
		if(!fishtank_cache[cache_key])
			I = image(icon, icon_state =   c_states[i],     dir = 1 << (i-1))
			fishtank_cache[cache_key] = I
		overlays += fishtank_cache[cache_key]

		cache_key = "[c_states[i]]b-[i]"
		if(!fishtank_cache[cache_key])
			I = image(icon, icon_state = "[c_states[i]]b",  dir = 1 << (i-1))
			I.layer = FLY_LAYER - 0.2
			fishtank_cache[cache_key] = I
		AO.overlays += fishtank_cache[cache_key]

		cache_key = "[c_states[i]]w-[i]"
		if(!fishtank_cache[cache_key])
			I = image(icon, icon_state = "[c_states[i]]w",  dir = 1 << (i-1))
			I.layer = FLY_LAYER - 0.1
			fishtank_cache[cache_key] = I
		AO.overlays += fishtank_cache[cache_key]

		cache_key = "[c_states[i]]f-[i]"
		if(!fishtank_cache[cache_key])
			I = image(icon, icon_state = "[c_states[i]]f",  dir = 1 << (i-1))
			I.layer = FLY_LAYER
			fishtank_cache[cache_key] = I
		AO.overlays += fishtank_cache[cache_key]

		cache_key = "[c_states[i]]z-[i]"
		if(!fishtank_cache[cache_key])
			I = image(icon, icon_state = "[c_states[i]]z", dir = 1 << (i-1))
			I.layer = FLY_LAYER + 0.1
			fishtank_cache[cache_key] = I
		AO.overlays += fishtank_cache[cache_key]

	// Update overlays with contents.
	for(var/atom/movable/AM in contents)
		if(!AM.simulated)
			continue
		overlays += AM

	if(propagate)
		for(var/obj/structure/aquarium/A in orange(1, src))
			A.update_icon()

/obj/structure/aquarium/can_climb(var/mob/living/user, post_climb_check=0)
	if (!can_touch(user) || !climbable || (!post_climb_check && (user in climbers)))
		return 0

	if (!Adjacent(user))
		user << "<span class='danger'>You can't climb there, the way is blocked.</span>"
		return 0

	var/obj/occupied = turf_is_crowded()
	if(occupied)
		user << "<span class='danger'>There's \a [occupied] in the way.</span>"
		return 0
	return 1

/obj/structure/aquarium/do_climb(var/mob/living/user)
	if (!can_climb(user))
		return

	usr.visible_message("<span class='warning'>\The [user] starts climbing into \the [src]!</span>")

	if(!do_after(user,50))
		return

	if (!can_climb(user))
		return

	usr.forceMove(src.loc)

	if (get_turf(user) == get_turf(src))
		animate(usr, pixel_y = usr.pixel_y + AQUARIUM_MOB_SHIFT, time = 10)
		usr.visible_message("<span class='warning'>\The [user] climbs into \the [src]!</span>")

/obj/structure/aquarium/verb/climb_out()
	set name = "Climb out"
	set desc = "Climbs out of a fishtank."
	set category = "Object"
	set src in oview(0) // Same turf.

	if(!isliving(usr))
		return

	var/list/valid_turfs = list()

	for(var/turf/T in orange(1))
		if(Adjacent(T) && !(locate(/obj/structure/aquarium) in T))
			valid_turfs |= T

	if(valid_turfs.len)
		do_climb_out(usr, pick(valid_turfs))
	else
		usr << "<span class='warning'>There's nowhere to climb out to!</span>"

/mob/living/MouseDrop(atom/over)
	if(usr == src && isturf(over))
		var/turf/T = over
		var/obj/structure/aquarium/A = locate() in usr.loc
		if(A && A.Adjacent(usr) && A.Adjacent(T))
			A.do_climb_out(usr, T)
			return
	return ..()

/obj/structure/aquarium/proc/do_climb_out(mob/living/user, turf/target)
	if(get_turf(user) != get_turf(src))
		return
	if(!Adjacent(target))
		return

	usr.visible_message("<span class='warning'>\The [user] starts climbing out of \the [src]!</span>")

	if(!do_after(user,50))
		return

	if (!Adjacent(target))
		return

	usr.forceMove(target)
	animate(usr, pixel_y = usr.pixel_y - AQUARIUM_MOB_SHIFT, time = 10)
	usr.visible_message("<span class='warning'>\The [user] climbs out of \the [src]!</span>")

/obj/structure/aquarium/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(istype(mover) && mover.checkpass(PASSGLASS))
		return 1
	if(target == loc)
		var/obj/structure/aquarium/A = locate() in mover.loc
		return !!A
	else
		var/obj/structure/aquarium/A = locate() in target
		return !!A

/obj/structure/aquarium/CheckExit(atom/movable/O as mob|obj, target as turf)
	if(istype(O) && O.checkpass(PASSGLASS))
		return 1
	var/obj/structure/aquarium/A = locate() in target
	return !!A

/obj/structure/aquarium/CanAtmosPass(turf/T)
	return !!(locate(/obj/structure/aquarium) in T)
