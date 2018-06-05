// QUALITY COPYPASTA
/turf/unsimulated/wall/supermatter
	name = "oblivion"
	desc = "THE END IS right now actually."

	icon = 'icons/turf/space.dmi'
	icon_state = "bluespace"

	//luminosity = 5
	//l_color="#0066FF"
	layer = LIGHTING_LAYER+1

	var/next_check=0
	var/list/avail_dirs = list(NORTH,SOUTH,EAST,WEST)

/turf/unsimulated/wall/supermatter/Initialize()
	. = ..()
	START_PROCESSING(SSprocessing, src)
	next_check = world.time+5 SECONDS

/turf/unsimulated/wall/supermatter/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/turf/unsimulated/wall/supermatter/process()
	// Only check infrequently.
	if(next_check>world.time) return

	// No more available directions? Shut down process().
	if(avail_dirs.len==0)
		STOP_PROCESSING(SSprocessing, src)
		return 1

	// We're checking, reset the timer.
	next_check = world.time+5 SECONDS

	// Choose a direction.
	var/pdir = pick(avail_dirs)
	avail_dirs -= pdir
	var/turf/T=get_step(src,pdir)

	// EXPAND
	if(!istype(T,type))
		// Do pretty fadeout animation for 1s.
		new /obj/effect/overlay/bluespacify(T)
		spawn(10)
			// Nom.
			for(var/atom/movable/A in T)
				Consume(A)
			T.ChangeTurf(type)

/turf/unsimulated/wall/supermatter/attack_generic(var/mob/user)
	if(istype(user))
		return attack_hand(user)

/turf/unsimulated/wall/supermatter/attack_robot(var/mob/user)
	if(Adjacent(user))
		return attack_hand(user)
	else
		user << "<span class = \"warning\">What the fuck are you doing?</span>"
	return

// /vg/: Don't let ghosts fuck with this.
/turf/unsimulated/wall/supermatter/attack_ghost(var/mob/user)
	user.examinate(src)

/turf/unsimulated/wall/supermatter/attack_ai(var/mob/user)
	return user.examinate(src)

/turf/unsimulated/wall/supermatter/attack_hand(var/mob/user)
	user.visible_message("<span class=\"warning\">\The [user] reaches out and touches \the [src]... And then blinks out of existance.</span>",\
		"<span class=\"danger\">You reach out and touch \the [src]. Everything immediately goes quiet. Your last thought is \"That was not a wise decision.\"</span>",\
		"<span class=\"warning\">You hear an unearthly noise.</span>")

	playsound(src, 'sound/effects/supermatter.ogg', 50, 1)

	Consume(user)

/turf/unsimulated/wall/supermatter/attackby(var/obj/item/W, var/mob/living/user)
	user.visible_message("<span class=\"warning\">\The [user] touches \a [W] to \the [src] as a silence fills the room...</span>",\
		"<span class=\"danger\">You touch \the [W] to \the [src] when everything suddenly goes silent.\"</span>\n<span class=\"notice\">\The [W] flashes into dust as you flinch away from \the [src].</span>",\
		"<span class=\"warning\">Everything suddenly goes silent.</span>")

	playsound(src, 'sound/effects/supermatter.ogg', 50, 1)

	user.drop_from_inventory(W)
	Consume(W)

/turf/unsimulated/wall/supermatter/Bumped(atom/AM as mob|obj)
	if(istype(AM, /mob/living))
		AM.visible_message("<span class=\"warning\">\The [AM] slams into \the [src] inducing a resonance... \his body starts to glow and catch flame before flashing into ash.</span>",\
		"<span class=\"danger\">You slam into \the [src] as your ears are filled with unearthly ringing. Your last thought is \"Oh, fuck.\"</span>",\
		"<span class=\"warning\">You hear an unearthly noise as a wave of heat washes over you.</span>")
	else
		AM.visible_message("<span class=\"warning\">\The [AM] smacks into \the [src] and rapidly flashes to ash.</span>",\
		"<span class=\"warning\">You hear a loud crack as you are washed with a wave of heat.</span>")

	playsound(src, 'sound/effects/supermatter.ogg', 50, 1)

	Consume(AM)

/turf/unsimulated/wall/supermatter/proc/Consume(var/atom/A)
	if(isobserver(A))
		return
	if(!A.simulated)
		return
	qdel(A)
