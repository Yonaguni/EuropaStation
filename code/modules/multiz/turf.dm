/turf/var/drop_state = "metalwall"
/turf/var/open_space

/turf/simulated/open
	name = "open space"
	icon = 'icons/turf/seafloor.dmi'
	icon_state = "openspace"
	layer = 1.9
	density = 0
	pathweight = 100000 //Seriously, don't try and path over this one numbnuts
	accept_lattice = 1
	drop_state = null
	open_space = 1
	blend_with_neighbors = -10 // Will accept overlays but shouldn't generate its own.

	var/turf/below
	var/need_appearance_update

/turf/simulated/open/ex_act()
	return

/turf/simulated/open/initialize()
	..()
	below = GetBelow(src)
	ASSERT(HasBelow(z))
	if(below) queue_open_turf_update(src)

/turf/simulated/open/flooded
	name = "abyss"
	drop_state = "rockwall"
	flooded = 1

/mob/var/fall_counter = 0

/atom/movable/proc/is_sinking()
	return 1

/mob/is_sinking()
	return 0

/turf/simulated/open/Entered(var/atom/movable/mover)

	..()

	// only fall down in defined areas (read: areas with artificial gravitiy)
	if(!istype(below)) //make sure that there is actually something below
		below = GetBelow(src)
		if(!below)
			return

	if(!mover.is_sinking() && (flooded || below.flooded)) // Swimmers can just go right across flooded turfs.
		return // TODO: swimming.

	// No gravity in space, apparently.
	var/area/area = get_area(src)
	if(!area.has_gravity)
		return

	// Prevent pipes from falling into the void... if there is a pipe to support it.
	if(mover.anchored || istype(mover, /obj/item/pipe) && \
		(locate(/obj/structure/disposalpipe/up) in below) || \
		 locate(/obj/machinery/atmospherics/pipe/zpipe/up in below))
		return

	// See if something prevents us from falling. Long drops don't care.
	if(locate(/obj/structure/ladder) in src)
		return

	var/soft = 0
	if(flooded || below.flooded)
		soft = 1
	else if(layer_is_shallow(z))
		if(below.density)
			return
		for(var/atom/A in below)
			if(A.density)
				if(!istype(A, /obj/structure/window))
					return
				else
					var/obj/structure/window/W = A
					if(W.is_fulltile())
						return
			// Dont break here, since we still need to be sure that it isnt blocked
			if(istype(A, /obj/structure/stairs))
				soft = 1

	// We've made sure we can move, now.
	mover.forceMove(below)

	if(!soft)
		//todo - loop over below.contents, call handle_falling_collision() on objects
		if(!istype(mover, /mob/living))
			if(below.open_space)
				mover.visible_message("<span class='warning'>\The [mover] falls into view from above!</span>", "<span class='warning'>You hear a whoosh of displaced air.</span>")
			else
				mover.visible_message("<span class='warning'>\The [mover] falls from above and slams into \the [below]!</span>", "<span class='warning'>You hear something slam into the ground.</span>")
		else
			var/mob/living/M = mover
			M.fall_counter += (layer_is_shallow(z) ? 1 : 10)
			if(below.open_space)
				below.visible_message("<span class='warning'>\The [mover] falls from above and plummets through \the [below]!</span>", "<span class='warning'>You hear a soft whoosh[M.stat ? "" : " and some screaming"].</span>")
			else
				M.visible_message("<span class='danger'>\The [mover] falls from above and slams into \the [below]!</span>", "<span class='danger'>You collide with \the [below]!</span>", "<span class='warning'>You hear a soft whoosh and a crunch.</span>")
				// Handle people getting hurt, it's funny!
				M.adjustBruteLoss(M.fall_counter * rand(15,30))
				M.fall_counter = 0
				M.Weaken(M.fall_counter * rand(2,3))
				M.updatehealth()

// override to make sure nothing is hidden
/turf/simulated/open/levelupdate()
	for(var/obj/O in src)
		O.hide(0)

/turf/simulated/open/attack_hand(var/mob/user)
	if(below && below.flooded)
		var/mob/living/carbon/human/H = user
		if(!istype(H))
			return ..()
		H << "<span class='notice'>You start washing your hands.</span>"
		if(!do_after(H, 40) || !Adjacent(H))
			return
		H.clean_blood()
		H.update_inv_gloves()
		H.visible_message("<span class='notice'>\The [user] washes their hands in \the [src].</span>")
		return
	return ..()

/turf/simulated/open/attackby(var/obj/item/O, var/mob/user)
	if(below && below.flooded)
		var/obj/item/weapon/reagent_containers/RG = O
		if(istype(RG) && RG.is_open_container())
			RG.reagents.add_reagent(REAGENT_ID_WATER, min(RG.volume - RG.reagents.total_volume, RG.amount_per_transfer_from_this))
			user.visible_message("<span class='notice'>\The [user] fills \the [RG] from \the [src].</span>")
			playsound(src, 'sound/effects/slosh.ogg', 25, 1)
			return 1
		if(istype(O, /obj/item/weapon/mop))
			O.reagents.add_reagent(REAGENT_ID_WATER, 5)
			user << "<span class='notice'>You wet \the [O] in \the [src].</span>"
			playsound(src, 'sound/effects/slosh.ogg', 25, 1)
			return
		user << "<span class='notice'>You start washing \the [O].</span>"
		if(!do_after(user, 40) || !Adjacent(user))
			return
		if(user.get_active_hand() != O)
			return
		O.clean_blood()
		user.visible_message("<span class='notice'>\The [user] washes \the [O] in \the [src].</span>")
		return
	return ..()