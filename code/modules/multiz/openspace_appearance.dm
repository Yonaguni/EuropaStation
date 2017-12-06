/*

== Openspace ==

This file contains the openspace movable types, including interactrion code and openspace helpers.
Most openspace appearance code is in code/controllers/subsystems/openturf.dm.
*/


// Updates whatever openspace components may be mimicing us. On turfs this queues an openturf update on the above openturf, on movables this updates their bound movable (if present). Meaningless on any type other than `/turf` or `/atom/movable` (incl. children).
/atom/proc/update_above()
	return

/turf
	// Reference to any open turf that might be above us to speed up atom Entered() updates.
	var/tmp/turf/simulated/open/above
	var/tmp/atom/movable/openspace/turf_overlay/bound_overlay

/turf/Entered(atom/movable/thing, atom/oldLoc)
	. = ..()
	if (above && !thing.no_z_overlay && !thing.bound_overlay && !isopenturf(oldLoc))
		above.update_icon()

/turf/Destroy()
	above = null
	if (bound_overlay)
		QDEL_NULL(bound_overlay)
	return ..()

/turf/update_above()
	if (istype(above))
		above.update_icon()

/atom/movable
	var/tmp/atom/movable/openspace/overlay/bound_overlay	// The overlay that is directly mirroring us that we proxy movement to.
	var/no_z_overlay	// If TRUE, this atom will not be drawn on open turfs.

/atom/movable/Destroy()
	. = ..()
	if (bound_overlay)
		QDEL_NULL(bound_overlay)

/atom/movable/forceMove(atom/dest)
	. = ..(dest)
	if (bound_overlay)
		// The overlay will handle cleaning itself up on non-openspace turfs.
		if (isturf(dest))
			bound_overlay.forceMove(get_step(src, UP))
			bound_overlay.set_dir(dir)
		else	// Not a turf, so we need to destroy immediately instead of waiting for the destruction timer to proc.
			qdel(bound_overlay)

/atom/movable/set_dir(ndir)
	. = ..()
	if (. && bound_overlay)
		bound_overlay.set_dir(dir)

/atom/movable/update_above()
	if (!bound_overlay)
		return

	if (isopenturf(bound_overlay.loc))
		if (!bound_overlay.queued)
			SSopenturf.queued_overlays += bound_overlay
			bound_overlay.queued = TRUE
	else
		qdel(bound_overlay)

// Grabs a list of every openspace object that's directly or indirectly mimicing this object. Returns an empty list if none found.
/atom/movable/proc/get_above_oo()
	. = list()
	var/atom/movable/curr = src
	while (curr.bound_overlay)
		. += curr.bound_overlay
		curr = curr.bound_overlay

// -- Openspace movables --

/atom/movable/openspace
	name = ""
	simulated = FALSE
	anchored = TRUE
	mouse_opacity = FALSE

// No blowing up abstract objects.
/atom/movable/openspace/ex_act(ex_sev)
	return

/atom/movable/openspace/singularity_act()
	return

/atom/movable/openspace/singularity_pull()
	return

/atom/movable/openspace/singuloCanEat()
	return

// Object used to hold a mimiced atom's appearance.
/atom/movable/openspace/overlay
	plane = OPENTURF_MAX_PLANE
	var/atom/movable/associated_atom
	var/depth
	var/queued = FALSE
	var/destruction_timer

/atom/movable/openspace/overlay/New(var/newloc)
	..(newloc)
	SSopenturf.openspace_overlays += src

/atom/movable/openspace/overlay/Destroy()
	SSopenturf.openspace_overlays -= src

	if (associated_atom)
		associated_atom.bound_overlay = null
		associated_atom = null

	if (destruction_timer)
		deltimer(destruction_timer)

	return ..()

/atom/movable/openspace/overlay/attackby(obj/item/W, mob/user)
	to_chat(user, "<span class = 'notice'>\The [src] is too far away.</span>")

/atom/movable/openspace/overlay/attack_hand(mob/user as mob)
	to_chat(user, "<span class = 'notice'>You cannot reach \the [src] from here.</span>")

/atom/movable/openspace/overlay/attack_generic(mob/user as mob)
	to_chat(user, "<span class = 'notice'>You cannot reach \the [src] from here.</span>")

/atom/movable/openspace/overlay/examine(mob/examiner)
	associated_atom.examine(examiner)

/atom/movable/openspace/overlay/forceMove(atom/dest)
	. = ..()
	if (isopenturf(dest))
		if (destruction_timer)
			deltimer(destruction_timer)
			destruction_timer = null
	else if (!destruction_timer)
		destruction_timer = addtimer(CALLBACK(GLOBAL_PROC, /proc/qdel, src), 10 SECONDS, TIMER_STOPPABLE)

// Called when the turf we're on is deleted/changed.
/atom/movable/openspace/overlay/proc/owning_turf_changed()
	if (!destruction_timer)
		destruction_timer = addtimer(CALLBACK(GLOBAL_PROC, /proc/qdel, src), 10 SECONDS, TIMER_STOPPABLE)

// This one's a little different because it's mimicing a turf.
/atom/movable/openspace/turf_overlay
	plane = OPENTURF_MAX_PLANE

/atom/movable/openspace/turf_overlay/attackby(obj/item/W, mob/user)
	loc.attackby(W, user)

/atom/movable/openspace/turf_overlay/attack_hand(mob/user as mob)
	loc.attack_hand(user)

/atom/movable/openspace/turf_overlay/attack_generic(mob/user as mob)
	loc.attack_generic(user)

/atom/movable/openspace/turf_overlay/examine(mob/examiner)
	loc.examine(examiner)