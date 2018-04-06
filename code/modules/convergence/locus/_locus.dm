var/const/nonbelievers_present = "nonbelievers_present"

/proc/try_spawn_locus()
	return

var/list/loci = list()

/obj/structure/locus
	name = "energy locus"
	icon = 'icons/obj/locus.dmi'
	desc = "A burgeoning fount of otherworldy energy. Looking directly at it makes your teeth ache."

	maptext_x = 48
	maptext_width = 64
	maptext_y = 32
	pixel_x = -64
	pixel_y = -64

	bound_x = -64
	bound_y = -64
	bound_width = 160
	bound_height = 160

	light_power = 10
	light_range = 5
	light_color = COLOR_CYAN


	var/capture_counter = 0
	var/mob/living/presence/capturing_presence
	var/list/capturing
	var/list/capturing_mobs

/obj/structure/locus/New()
	capturing_mobs = list()
	loci[src] = TRUE
	..()

/obj/structure/locus/initialize()
	START_PROCESSING(SSprocessing, src)
	set_light()
	if(prob(75))
		var/matrix/M = matrix()
		M.Turn(pick(90.180,270))
		transform = M
	. = ..()

/obj/structure/locus/Destroy()
	capturing_mobs.Cut()
	capturing.Cut()
	STOP_PROCESSING(SSprocessing, src)
	loci -= src
	. = ..()

/obj/structure/locus/process()

	// Are we being captured?
	capturing = list()
	for(var/thing in capturing_mobs)
		var/mob/living/capturer = thing
		if(capturer.mind)
			if(godtouched.is_antagonist(capturer.mind))
				capturing[presences.get_presence_from_believer(capturer)] = TRUE
			else
				capturing[nonbelievers_present] = TRUE

	// Sort it out and update maptext.
	if(LAZYLEN(capturing) == 1 && !capturing[nonbelievers_present])

		if(!capturing_presence)
			capturing_presence = capturing[1]

		if(capturing[1] == capturing_presence)
			capture_counter++
			if(capture_counter > 100)
				capture_complete()
		else
			capture_counter -= 5
			if(capture_counter <= 0)
				capturing_presence = null
				capture_counter = 0

		maptext = "<center>[capture_counter]%</center>"

	else if(LAZYLEN(capturing) > 1)
		maptext = "<center>CONTESTED</center>"
	else
		if(capture_counter)
			capture_counter--
			maptext = "<center>[capture_counter]%</center>"
		else
			maptext = "<center>CAPTURE ME</center>"

/obj/structure/locus/ex_act()
	return

/obj/structure/locus/emp_act()
	return

/obj/structure/locus/Crossed(var/atom/movable/crosser)
	if(isliving(crosser)) capturing_mobs[crosser] = TRUE

/obj/structure/locus/Uncrossed(var/atom/movable/crosser)
	capturing_mobs -= crosser

/obj/structure/locus/proc/capture_complete()
	capturing_presence.captured_locus(src)
	qdel(src)
