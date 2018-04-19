#define UPGRADE_COOLDOWN	40
#define UPGRADE_KILL_TIMER	100

/obj/item/grab
	name = "reinforce grab"
	icon = 'icons/screen/grab.dmi'
	icon_state = "reinforce"
	flags = 0

	var/atom/movable/affecting
	var/mob/living/affecting_mob
	var/mob/living/carbon/human/assailant
	var/mob/living/silicon/robot/assailant_robot
	var/state = GRAB_PASSIVE

	var/allow_upgrade = 1
	var/last_action = 0
	var/last_hit_zone = 0
	var/force_down //determines if the affecting mob will be pinned to the ground

	layer = 21
	abstract = 1
	item_state = "nothing"
	simulated = 0

/obj/item/grab/New(mob/user, mob/victim)
	..()
	loc = user
	assailant = user
	affecting = victim

	if(affecting.anchored || !assailant.Adjacent(victim))
		qdel(src)
		return
	LAZYADD(affecting.grabbed_by, src)
	if(ismob(affecting))
		affecting_mob = affecting

	if(istype(assailant, /mob/living/silicon/robot))
		assailant_robot = assailant

	//check if assailant is grabbed by victim as well
	for (var/obj/item/grab/G in assailant.grabbed_by)
		if(G.assailant == affecting && G.affecting == assailant)
			G.adjust_position()
	adjust_position()

/obj/item/grab/get_storage_cost()
	return DO_NOT_STORE

//Used by throw code to hand over the mob, instead of throwing the grab.
/obj/item/grab/proc/throw_held()
	if(affecting)
		if(affecting_mob)
			if(affecting_mob.buckled)
				return
			if(state >= GRAB_AGGRESSIVE)
				animate(affecting_mob, pixel_x = 0, pixel_y = 0, 4, 1)
				return affecting_mob
		animate(affecting, pixel_x = 0, pixel_y = 0, 4, 1)
		return affecting
	return null

//This makes sure that the grab screen object is displayed in the correct hand.
/obj/item/grab/proc/synch() //why is this needed?
	if(affecting)
		if(assailant_robot)
			screen_loc = ui_inv0
		else if(assailant.r_hand == src)
			screen_loc = ui_rhand
		else
			screen_loc = ui_lhand

/obj/item/grab/process()
	if(QDELING(src)) // GC is trying to delete us, we'll kill our processing so we can cleanly GC
		return PROCESS_KILL

	confirm()
	if(!assailant)
		qdel(src) // Same here, except we're trying to delete ourselves.
		return PROCESS_KILL

	if(!affecting_mob || assailant_robot)
		allow_upgrade = 0 // Unnecessary.
		adjust_position()
		return

	if(state <= GRAB_AGGRESSIVE)
		allow_upgrade = 1
		//disallow upgrading if we're grabbing more than one person
		if((assailant.l_hand && assailant.l_hand != src && istype(assailant.l_hand, /obj/item/grab)))
			var/obj/item/grab/G = assailant.l_hand
			if(G.affecting != affecting)
				allow_upgrade = 0
		if((assailant.r_hand && assailant.r_hand != src && istype(assailant.r_hand, /obj/item/grab)))
			var/obj/item/grab/G = assailant.r_hand
			if(G.affecting != affecting)
				allow_upgrade = 0

		//disallow upgrading past aggressive if we're being grabbed aggressively
		for(var/obj/item/grab/G in affecting.grabbed_by)
			if(G == src) continue
			if(G.state >= GRAB_AGGRESSIVE)
				allow_upgrade = 0

	if(state >= GRAB_AGGRESSIVE)
		affecting_mob.drop_l_hand()
		affecting_mob.drop_r_hand()

		if(iscarbon(affecting))
			handle_eye_mouth_covering(affecting, assailant, assailant.zone_sel.selecting)

		if(force_down)
			if(affecting.loc != assailant.loc || size_difference(affecting, assailant) > 0)
				force_down = 0
			else
				affecting_mob.Weaken(2)

	if(state >= GRAB_NECK)
		affecting_mob.Stun(3)
		if(isliving(affecting))
			var/mob/living/L = affecting
			L.adjustOxyLoss(1)

	if(state >= GRAB_KILL)
		if(iscarbon(affecting))
			var/mob/living/carbon/C = affecting
			C.apply_effect(STUTTER, 5) //It will hamper your voice, being choked and all.
			C.Weaken(5)	//Should keep you down unless you get help.
			C.losebreath = max(C.losebreath + 2, 3)

	adjust_position()

/obj/item/grab/proc/handle_eye_mouth_covering(mob/living/carbon/target, mob/user, var/target_zone)

	if(!affecting_mob || assailant_robot)
		return // Urist McWeirdo covers the closet's mouth!

	var/announce = (target_zone != last_hit_zone) //only display messages when switching between different target zones
	last_hit_zone = target_zone

	switch(target_zone)
		if(BP_MOUTH)
			if(announce)
				user.visible_message("<span class='warning'>\The [user] covers [target]'s mouth!</span>")
			if(target.silent < 3)
				target.silent = 3
		if(BP_EYES)
			if(announce)
				assailant.visible_message("<span class='warning'>[assailant] covers [affecting]'s eyes!</span>")
			if(affecting_mob.eye_blind < 3)
				affecting_mob.eye_blind = 3

/obj/item/grab/attack_self()
	if(!affecting)
		return
	if(state == GRAB_UPGRADING)
		return
	if(!assailant.canClick())
		return

	var/checktime = UPGRADE_COOLDOWN
	if(HAS_ASPECT(assailant, ASPECT_WRESTLER))
		checktime *= 0.75

	if(world.time < (last_action + checktime))
		return

	if(!assailant.canmove || assailant.lying)
		qdel(src)
		return

	last_action = world.time

	if(!affecting_mob || assailant_robot)
		return // Upgrading a grab isn't necessary for pulling something around.

	if(state < GRAB_AGGRESSIVE)
		if(!allow_upgrade)
			return
		if(!ishuman(affecting_mob) || !affecting_mob.lying || size_difference(affecting_mob, assailant) > 0)
			assailant.visible_message("<span class='warning'>[assailant] has grabbed [affecting_mob] aggressively!</span>")
		else
			assailant.visible_message("<span class='warning'>[assailant] pins [affecting_mob] down to the ground!</span>")
			apply_pinning(affecting_mob, assailant)

		state = GRAB_AGGRESSIVE

	else if(state < GRAB_NECK)
		if(istype(affecting_mob, /mob/living/silicon))
			assailant << "<span class='notice'>You squeeze [affecting_mob], but nothing interesting happens.</span>"
			return

		assailant.visible_message("<span class='warning'>[assailant] has reinforced \his grip on [affecting_mob]!</span>")
		state = GRAB_NECK
		assailant.set_dir(get_dir(assailant, affecting_mob))

		admin_attack_log(assailant, affecting, \
		 "Grabbed the neck of [affecting_mob.name] ([affecting_mob.ckey])", \
		 "Has had their neck grabbed by [assailant.name] ([assailant.ckey])", \
		 "[key_name(assailant)] grabbed the neck of [key_name(affecting_mob)]." \
		)
		affecting_mob.Stun(10) //10 ticks of ensured grab

	else if(state < GRAB_UPGRADING)
		assailant.visible_message("<span class='danger'>[assailant] starts to tighten \his grip on [affecting_mob]'s neck!</span>")
		state = GRAB_KILL
		assailant.visible_message("<span class='danger'>[assailant] has tightened \his grip on [affecting_mob]'s neck!</span>")

		admin_attack_log(assailant, affecting, \
		 "Strangled (kill intent) [affecting_mob.name] ([affecting_mob.ckey])", \
		 "Has been strangled (kill intent) by [assailant.name] ([assailant.ckey])", \
		 "[key_name(assailant)] strangled (kill intent) [key_name(affecting_mob)]." \
		)

		affecting_mob.setClickCooldown(10)
		affecting_mob.set_dir(WEST)
		if(iscarbon(affecting_mob))
			var/mob/living/carbon/C = affecting_mob
			C.losebreath += 1
	adjust_position()
/obj/item/grab/proc/reset_position()
	if(!affecting_mob || !affecting_mob.buckled)
		animate(affecting, pixel_x = 0, pixel_y = 0, 4, 1, LINEAR_EASING)

//Updating pixelshift, position and direction
//Gets called on process, when the grab gets upgraded or the assailant moves
/obj/item/grab/proc/adjust_position()

	update_icon()
	if(affecting_mob && affecting_mob.buckled)
		return
	if(!assailant)
		return
	if(affecting_mob && affecting_mob.lying && state != GRAB_KILL)
		animate(affecting, pixel_x = 0, pixel_y = 0, 5, 1, LINEAR_EASING)
		if(force_down)
			affecting.set_dir(SOUTH) //face up
		return
	var/shift = 0
	var/adir = get_dir(assailant, affecting)
	switch(state)
		if(GRAB_PASSIVE)
			shift = 10
			assailant.set_dir(get_dir(assailant, affecting))
		if(GRAB_AGGRESSIVE)
			shift = 12
		if(GRAB_NECK, GRAB_UPGRADING)
			shift = -10
			adir = assailant.dir
			affecting.set_dir(assailant.dir)
			affecting.loc = assailant.loc
		if(GRAB_KILL)
			shift = 0
			adir = 1
			affecting.set_dir(SOUTH) //face up
			affecting.loc = assailant.loc

	switch(adir)
		if(NORTH)
			animate(affecting, pixel_x = 0, pixel_y =-shift, 5, 1, LINEAR_EASING)
		if(SOUTH)
			animate(affecting, pixel_x = 0, pixel_y = shift, 5, 1, LINEAR_EASING)
		if(WEST)
			animate(affecting, pixel_x = shift, pixel_y = 0, 5, 1, LINEAR_EASING)
		if(EAST)
			animate(affecting, pixel_x =-shift, pixel_y = 0, 5, 1, LINEAR_EASING)

/obj/item/grab/update_icon()
	cut_overlays()
	switch(state)
		if(GRAB_AGGRESSIVE)
			name = "reinforce grab"
			icon_state = "grabbed1"
			add_overlay("reinforce1")
		if(GRAB_KILL)
			name = "kill"
			add_overlay("kill")
		if(GRAB_NECK)
			icon_state = "grabbed+1"
			name = "kill"
			add_overlay("kill")
		if(GRAB_UPGRADING)
			add_overlay("kill1")
	if(!allow_upgrade)
		add_overlay("!reinforce")

//This is used to make sure the victim hasn't managed to yackety sax away before using the grab.
/obj/item/grab/proc/confirm()
	if(!assailant || !affecting)
		qdel(src)
		return 0

	if(affecting)
		if(!isturf(assailant.loc) || ( !isturf(affecting.loc) || assailant.loc != affecting.loc && get_dist(assailant, affecting) > 1) )
			qdel(src)
			return 0

	return 1

/obj/item/grab/attack(mob/M, mob/living/user)

	if(!affecting)
		return

	// Relying on BYOND proc ordering isn't working, so go go ugly workaround.
	if(ishuman(user) && affecting == M)
		var/mob/living/carbon/human/H = user
		if(H.check_psi_grab(src))
			return
	// End workaround

	var/checktime = 20
	if(HAS_ASPECT(assailant, ASPECT_WRESTLER))
		checktime *= 0.75
	if(world.time < (last_action + checktime))
		return

	last_action = world.time
	reset_kill_state() //using special grab moves will interrupt choking them

	//clicking on the victim while grabbing them
	if(M == affecting)
		if(ishuman(affecting))
			var/mob/living/carbon/human/H = affecting
			var/hit_zone = assailant.zone_sel.selecting
			do_interaction_animation()
			switch(assailant.a_intent)
				if(I_HELP)
					if(force_down)
						assailant << "<span class='warning'>You are no longer pinning [affecting] to the ground.</span>"
						force_down = 0
						return
					if(state >= GRAB_AGGRESSIVE)
						H.apply_pressure(assailant, hit_zone)
					else
						inspect_organ(affecting, assailant, hit_zone)

				if(I_GRAB)
					jointlock(affecting, assailant, hit_zone)

				if(I_HURT)
					if(hit_zone == BP_EYES)
						attack_eye(affecting, assailant)
					else if(hit_zone == BP_HEAD)
						headbutt(affecting, assailant)
					else
						dislocate(affecting, assailant, hit_zone)

				if(I_DISARM)
					pin_down(affecting, assailant)

	//clicking on yourself while grabbing them
	if(M == assailant && state >= GRAB_AGGRESSIVE)
		if(assailant.devour(affecting))
			qdel(src)

/obj/item/grab/dropped()
	..()
	loc = null
	if(!QDELING(src))
		qdel(src)

/obj/item/grab/proc/reset_kill_state()
	if(state == GRAB_KILL)
		assailant.visible_message("<span class='warning'>[assailant] lost \his tight grip on [affecting]'s neck!</span>")
		state = GRAB_NECK

/obj/item/grab/proc/handle_resist()

	if(!affecting)
		var/mob/M = loc
		if(istype(M))
			M.drop_from_inventory(src)
			return

	if(!affecting_mob)
		return // A crate is not going to resist.

	var/grab_name = "grip"
	var/break_strength = 1
	var/list/break_chance_table = list(100)

	switch(state)
		if(GRAB_PASSIVE)
			//Being knocked down makes it harder to break a grab, so it is easier to cuff someone who is down without forcing them into unconsciousness.
			//use same chance_table as aggressive but give +2 for not-weakened so that corvid grabs don't become auto-success for weakened either, that's lame
			if(!affecting_mob.incapacitated(INCAPACITATION_KNOCKDOWN))
				break_strength += 2
			break_chance_table = list(15, 60, 100)

		if(GRAB_AGGRESSIVE)
			//Being knocked down makes it harder to break a grab, so it is easier to cuff someone who is down without forcing them into unconsciousness.
			if(!affecting_mob.incapacitated(INCAPACITATION_KNOCKDOWN))
				break_strength++
			break_chance_table = list(15, 60, 100)

		if(GRAB_NECK)
			grab_name = "headlock"
			//If the you move when grabbing someone then it's easier for them to break free. Same if the affected mob is immune to stun.
			if(world.time - assailant.l_move_time < 30 || !affecting_mob.stunned)
				break_strength++
			break_chance_table = list(3, 18, 45, 100)

	//It's easier to break out of a grab by a smaller mob
	break_strength += max(size_difference(affecting_mob, assailant), 0)

	var/break_chance = break_chance_table[Clamp(break_strength, 1, break_chance_table.len)]
	if(prob(break_chance))
		if(grab_name)
			affecting_mob.visible_message("<span class='warning'>\The [affecting_mob] has broken free of [assailant]'s [grab_name]!</span>")
		qdel(src)

//returns the number of size categories between affecting_mob and assailant, rounded. Positive means A is larger than B
/obj/item/grab/proc/size_difference(mob/A, mob/B)
	return mob_size_difference(A.mob_size, B.mob_size)

/obj/item/grab/Destroy()
	affecting_mob = null
	if(assailant_robot)
		if(assailant_robot.current_grab == src)
			assailant_robot.current_grab = null
		assailant_robot = null
	if(affecting)
		reset_position()
		LAZYREMOVE(affecting.grabbed_by, src)
		affecting = null
	if(assailant)
		assailant = null
	. = ..()

/obj/item/grab/proc/do_interaction_animation()
	set waitfor = 0
	var/reset_to = icon_state
	icon_state = initial(icon_state)
	sleep(1)
	icon_state = reset_to
