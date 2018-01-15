/decl/presence_template/eldergod/is_acceptable_sacrifice(var/atom/movable/sacrificing)
	if(isliving(sacrificing))
		var/mob/living/M = sacrificing
		if(!M.mind)
			return "This mindless husk is of no interest to your dread master."
		if(M.stat != DEAD)
			return
	return "Your master hungers only for living blood."

/decl/presence_template/eldergod/perform_sacrifice(var/mob/user, var/atom/target, var/obj/item/convergence/regalia, var/obj/structure/shrine/altar)
	var/mob/living/victim = target
	var/mob/living/presence/presence = altar.sanctified_to
	var/mojo_earned = 10
	user.visible_message("<span class='warning'>\The [user] lifts \the [regalia] high over \the [target].</span>")
	if(do_mob(user, victim, 30))
		user.visible_message("<span class='warning'>\The [user] plunges \the [regalia] into \the [victim]!</span>")
		if(ishuman(victim))
			mojo_earned = 50
			var/mob/living/carbon/human/H = victim
			var/obj/item/organ/external/affecting = H.organs_by_name[BP_CHEST]
			affecting.createwound(CUT, rand(30,50))
			affecting.update_damages()
			var/obj/item/organ/internal/heart/heart = H.internal_organs_by_name[BP_HEART]
			if(istype(heart)) heart.damage = heart.max_damage
			playsound(target.loc, 'sound/weapons/bladeslice.ogg', 50, 1)
		else
			mojo_earned = victim.mob_size
			victim.adjustBruteLoss(rand(30,50))
		sleep(10)
		if(!victim || victim.stat == DEAD) mojo_earned *= 2
		presence.mojo = min(presence.max_mojo, presence.mojo + mojo_earned)
	return TRUE

/decl/presence_template/eldergod/regalia_used_in_hand(var/mob/user, var/obj/item/convergence/regalia)

	if(regalia.regalia_type == REGALIA_ROD)
		var/obj/item/convergence/rod/eldergod/athame = regalia
		if(istype(athame))
			if(athame.charged())
				to_chat(user, "<span class='warning'>\The [regalia] is already coated in blood.</span>")
			else
				var/mob/living/carbon/human/H = user
				if(!istype(H))
					to_chat(user, "<span class='warning'>You cannot make use of this athame.</span>")
					return FALSE
				H.bloody_hands(H, 0)
				regalia.add_blood(H)
				H.drip(rand(1,3))
				H.visible_message("<span class='danger'>\The [H] slits open a palm with \the [regalia], coating the blade with blood.</span>")
			return TRUE

	if(regalia.regalia_type == REGALIA_ORB)
		var/list/dat = list()
		if(LAZYLEN(regalia.sanctified_to.purchased_powers))
			dat += "<table border = 1 width = 100%>"
			for(var/datum/presence_power/rune/rune in regalia.sanctified_to.purchased_powers)
				dat += "<tr><td><b>[rune.name]</b>: [rune.description]</td><td align='right'><a href='?src=\ref[regalia];scribe_user=\ref[user];scribe_sigil=\ref[rune]'>Scribe.</a></td></tr>"
			dat += "</table>"
		else
			dat += "The pages of the tome are curiously blank. Perhaps your dread master has not yet seen fit to grace you with knowledge of runes."

		var/datum/browser/popup = new(user, "culttome", "Available Runes")
		popup.set_content(jointext(dat,""))
		popup.open()

	return FALSE