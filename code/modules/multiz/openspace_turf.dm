/turf/var/open_space

/proc/isopenturf(var/atom/A)
	var/turf/T = get_turf(A)
	return (istype(T) && T.open_space)

/turf/simulated/open
	name = "open space"
	icon = 'icons/turf/seafloor.dmi'
	icon_state = "openspace"
	layer = LAYER_SPACE_BACKGROUND
	density = 0
	pathweight = 100000 //Seriously, don't try and path over this one numbnuts
	accept_lattice = 1
	open_space = 1
	blend_with_neighbors = -10 // Will accept overlays but shouldn't generate its own.

	var/tmp/atom/movable/openspace/multiplier/shadower
	var/tmp/turf/below
	var/tmp/updating = FALSE								// If this turf is queued for openturf update.
	var/tmp/depth
	var/no_mutate = FALSE	// If TRUE, SSopenturf will not modify the appearance of this turf.

/turf/simulated/open/Destroy()
	SSopenturf.openspace_turfs -= src
	SSopenturf.queued_turfs -= src
	QDEL_NULL(shadower)

	if (below)
		below.above = null
		below = null

	. = ..()

/turf/simulated/open/Initialize()
	. = ..()
	icon_state = "" // Clear out the debug icon.
	SSopenturf.openspace_turfs += src
	shadower = new(src)
	if (no_mutate && layer == LAYER_SPACE_BACKGROUND)
		// If the layer is default and we're a no_mutate turf, force it to default so the icon works properly.
		layer = TURF_LAYER
	update()

/turf/simulated/open/is_solid_structure()
	return locate(/obj/structure/lattice) in src

/turf/simulated/open/proc/update()
	below = GetBelow(src)
	// Edge case for when an open turf is above space on the lowest level.
	if(below)
		below.above = src
	levelupdate()
	update_icon()

/turf/simulated/open/levelupdate()
	for(var/obj/O in src)
		O.hide(0)

/turf/simulated/open/update_icon()
	if(!updating && below)
		updating = TRUE
		SSopenturf.queued_turfs += src

	if (above)	// Even if we're already updating, the turf above us might not be.
		// Cascade updates until we hit the top openturf.
		above.update_icon()

/turf/simulated/open/ex_act()
	return

/turf/simulated/open/flooded
	name = "abyss"

/mob/var/fall_counter = 0

/atom/movable/proc/is_sinking()
	return simulated

/mob/is_sinking()
	return 0

/turf/simulated/open/Entered(var/atom/movable/mover)

	..()

	if(mover.throwing || !mover.simulated)
		return ..()

	// only fall down in defined areas (read: areas with artificial gravitiy)
	if(!istype(below)) //make sure that there is actually something below
		below = GetBelow(src)
		if(!below)
			return ..()

	if(!mover.is_sinking() && (is_flooded(absolute=1) || below.is_flooded(absolute=1))) // Swimmers can just go right across flooded turfs.
		return ..() // TODO: swimming.

	// No gravity in space, apparently.
	var/area/area = get_area(src)
	if(!area.has_gravity)
		return ..()

	// See if something prevents us from falling. Long drops don't care.
	if(locate(/obj/structure/ladder) in src)
		return ..()

	if(locate(/obj/structure/lattice) in src)
		return ..()

	var/soft = 0
	if(is_flooded(1) || below.is_flooded(1))
		soft = 1
	else if(layer_is_shallow(z))
		if(below.density)
			return ..()
		for(var/atom/A in below)
			if(A.density)
				if(!istype(A, /obj/structure/window))
					return ..()
				else
					var/obj/structure/window/W = A
					if(W.is_fulltile())
						return ..()
			// Dont break here, since we still need to be sure that it isnt blocked
			if(istype(A, /obj/structure/stairs))
				soft = 1

	// We've made sure we can move, now.
	mover.forceMove(below)
	if(below.is_flooded(1))
		visible_message("<span class='notice'>\The [mover] vanishes with a splash!</span>")

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
	return ..()

// override to make sure nothing is hidden
/turf/simulated/open/levelupdate()
	for(var/obj/O in src)
		O.hide(0)

/turf/simulated/open/attack_hand(var/mob/user)
	if(below && below.is_flooded())
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
	if(!O.iscoil() && below && below.is_flooded())
		var/obj/item/reagent_containers/RG = O
		if(istype(RG) && RG.is_open_container())
			RG.reagents.add_reagent(REAGENT_ID_WATER, min(RG.volume - RG.reagents.total_volume, RG.amount_per_transfer_from_this))
			user.visible_message("<span class='notice'>\The [user] fills \the [RG] from \the [src].</span>")
			playsound(src, 'sound/effects/slosh.ogg', 25, 1)
			return 1
		user << "<span class='notice'>You start washing \the [O].</span>"
		if(!do_after(user, 40) || !Adjacent(user))
			return
		if(user.get_active_hand() != O)
			return
		O.clean_blood()
		user.visible_message("<span class='notice'>\The [user] washes \the [O] in \the [src].</span>")
		return
	return ..()
