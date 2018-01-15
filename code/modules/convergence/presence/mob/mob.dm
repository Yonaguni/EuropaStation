/mob/living/presence
	name = "coalescing presence"
	density = 0
	simulated = 0
	invisibility = INVISIBILITY_MAXIMUM
	icon = 'icons/mob/presences.dmi'
	icon_state = "generic"

	var/manifested
	var/datum/presence_power/selected_power
	var/list/believers = list()
	var/list/purchased_powers = list()
	var/list/totems
	var/list/altars
	var/decl/presence_template/presence
	var/mojo = 0
	var/mojo_regen = 1
	var/min_mojo = 10
	var/max_mojo = 100
	var/next_invocation_message = 0

/mob/living/presence/New()
	..()
	mojo = min_mojo
	loc = null

/mob/living/presence/Login()
	..()
	spawn
		if(name == initial(name)) set_presence_name()

/mob/living/presence/Life()
	if(presence ** stat != DEAD)
		var/has_living_believer
		for(var/thing in believers)
			var/mob/M = thing
			if(M.stat != DEAD)
				has_living_believer = TRUE
				break
		if(!has_living_believer)
			death()
		else if(mojo < min_mojo)
			mojo = min(mojo + mojo_regen, min_mojo)

/mob/living/presence/death()
	to_chat(world, "<span class = 'notice'><b>[presence.death_message]</b></span>")
	. = ..()

/mob/living/presence/proc/welcome_believer(var/mob/new_believer)
	if(!believers[new_believer])
		to_chat(src, "<span class='notice'><b>Your flock swells with a new believer, \the [new_believer].</b></span>")
		to_chat(new_believer, "<span class='danger'><b>You are bound, body and soul, to the whims of \the [src], [presence.title].</b> Serve and obey your otherworldly master.</span>")
		believers[new_believer] = TRUE

/mob/living/presence/Topic(href, href_list)

	if(..()) return TRUE

	if(stat) return FALSE

	if(href_list["refresh_power_page"])
		list_powers()
		return TRUE

	if(href_list["purchase"])
		var/datum/presence_power/power = locate(href_list["purchase"])
		if(istype(power))
			if(power.purchase_cost <= mojo)
				mojo -= power.purchase_cost
				purchased_powers[power] = TRUE
				power.purchased(src)
			list_powers()
			return TRUE

	if(href_list["clear_selected_power"])
		selected_power = null
		to_chat(src, "<span class='notice'>You are no longer selecting a specific power.</span>")
		return TRUE

	if(href_list["select_power"])
		selected_power = locate(href_list["select_power"])
		if(!(selected_power in purchased_powers))
			selected_power = null
		else
			to_chat(src, "<span class='notice'>You have selected <b>[selected_power.name]</b> as your active power.</span>")
		return TRUE

	if(href_list["jump_to_believer"])
		var/mob/M = locate(href_list["jump_to_believer"])
		if(!istype(M) && M.loc)
			forceMove(M.loc)
			return TRUE

/mob/living/presence/UnarmedAttack(var/atom/A, var/proximity)
	if(stat) return
	if(presence) presence.do_melee_manifested_interaction(src, A)
	try_interact(A)

/mob/living/presence/RangedAttack(var/atom/A, var/proximity)
	if(stat) return
	if(manifested)
		if(presence) presence.do_ranged_manifested_interaction(src, A)
	try_interact(A)

/mob/living/presence/proc/try_interact(var/atom/A)
	if(selected_power)
		selected_power.invoke(src, src, A)
	else
		A.examine(src)

/mob/living/presence/proc/captured_locus(var/obj/structure/locus/locus)
	return

/mob/living/presence/emote()
	if(manifested)
		return ..()

/mob/living/presence/say(var/message, var/datum/language/speaking = null, var/verb="says", var/alt_name="")
	if(manifested)
		return ..()
	if(client && (client.prefs.muted & MUTE_IC))
		to_chat(src, "<span class='warning'>You cannot speak in IC (Muted).</span>")
		return
	if(stat)
		if(stat == DEAD)
			return say_dead(message)
		return

	for(var/thing in clients)
		var/client/C = thing
		if(isghost(C.mob) && C.mob.is_preference_enabled(/datum/client_preference/ghost_ears))
			to_chat(C.mob, "<b>\The [src]</b> whispers through its totems, \"[message]\".")

	for(var/thing in totems)
		var/atom/A = thing
		for(var/mob/living/M in view(7, A))
			if(M.mind && godtouched.is_antagonist(M.mind, src))
				to_chat(M, "\icon[A] <b>\The [A]</b> whispers into your mind, \"[message]\".")
