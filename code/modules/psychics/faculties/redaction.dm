/proc/do_redactive_living_check(var/mob/living/user, var/atom/target)
	if(!isliving(target) || isrobot(target))
		user << "You cannot use this power on unliving matter."
		return FALSE
	var/mob/living/M = target
	if(M.isSynthetic())
		user << "You cannot use this power on unliving matter."
		return FALSE
	return TRUE

/decl/psychic_faculty/redaction
	name = PSYCHIC_REDACTION
	colour = "#ff3300"
	powers = list(
		/datum/psychic_power/latent,
		/datum/psychic_power/skinsight,
		/datum/psychic_power/mend,
		/datum/psychic_power/cleanse,
		/datum/psychic_power/revive
		)

/datum/psychic_power/skinsight
	name = "Skinsight"
	description = "See the damage beneath."
	target_self = 1
	target_melee = 1
	target_mob_only = 1
	time_cost = 30
	melee_power_cost = 3

/datum/psychic_power/skinsight/do_proximity(var/mob/living/user, var/atom/target)
	if(do_redactive_living_check(user, target) && ..())
		health_scan_mob(target, user, "\The [user] rests a hand on \the [target].", ignore_clumsiness = TRUE)
		return TRUE
	return FALSE

/datum/psychic_power/mend
	name = "Mend"
	description = "Mend broken bones and ruptured organs."
	target_self = 1
	target_melee = 1
	target_mob_only = 1
	time_cost = 100
	melee_power_cost = 10

/datum/psychic_power/mend/do_proximity(var/mob/living/user, var/atom/target)
	if(do_redactive_living_check(user, target))
		if(!ishuman(target))
			user << "<span class='warning'>\The [target]'s body is not complex enough to require healing of this kind.</span>"
			return

		var/mob/living/carbon/human/H = target
		var/obj/item/organ/external/E = H.get_organ(user.zone_sel.selecting)

		if(!E || E.is_stump())
			user << "<span class='warning'>They are missing that limb.</span>"
			return

		if(E.robotic >= ORGAN_ROBOT)
			user << "<span class='warning'>That limb is prosthetic.</span>"
			return

		if(..())

			user.visible_message("<span class='notice'><i>\The [user] rests a hand on \the [target]'s [E.name]...</i></span>")
			target << "<span class='notice'>A healing warmth suffuses you.</span>"

			for(var/datum/wound/W in E.wounds)
				if(W.internal)
					user << "<span class='notice'>You painstakingly mend the torn veins in \the [E], stemming the internal bleeding.</span>"
					E.wounds -= W
					E.update_damages()
					return TRUE
				if(W.bleeding() && W.wound_damage() <= W.bleed_threshold)
					user << "<span class='notice'>You knit together severed veins and broken flesh, stemming the bleeding.</span>"
					W.bleed_timer = 0
					E.status &= ~ORGAN_BLEEDING
					return TRUE

			if(E.status & ORGAN_BROKEN)
				user << "<span class='notice'>You coax shattered bones to come together and fuse, mending the break.</span>"
				E.status &= ~ORGAN_BROKEN
				E.stage = 0
				return TRUE

			for(var/obj/item/organ/internal/I in E.internal_organs)
				if(I.robotic < ORGAN_ROBOT && I.damage > 0)
					user << "<span class='notice'>You encourage the damaged tissue of \the [I] to repair itself.</span>"
					I.damage = max(0, I.damage - rand(3,5))
					return

			user << "<span class='notice'>You can find nothing within \the [target]'s [E.name] to mend.</span>"
			return TRUE

	return FALSE

/datum/psychic_power/cleanse
	name = "Cleanse"
	description = "Purge the body of toxins and radiation."
	target_self = 1
	target_melee = 1
	target_mob_only = 1
	time_cost = 50
	melee_power_cost = 10

/datum/psychic_power/cleanse/do_proximity(var/mob/living/user, var/atom/target)
	if(do_redactive_living_check(user, target) && ..())

		user.visible_message("<span class='notice'><i>\The [user] rests a hand on \the [target]...</i></span>")
		target << "<span class='notice'>A healing warmth suffuses you.</span>"

		var/removing = rand(20,25)
		var/mob/living/M = target

		if(M.radiation)
			user << "<span class='notice'>You repair some of the radiation-damaged tissue within \the [target]...</span>"
			if(M.radiation > removing)
				M.radiation -= removing
			else
				M.radiation = 0
			return

		if(removing && M.getCloneLoss())
			user << "<span class='notice'>You stitch together some of the mangled DNA within \the [target]...</span>"
			if(M.getCloneLoss() >= removing)
				M.adjustCloneLoss(-removing)
			else
				M.adjustCloneLoss(-(M.getCloneLoss()))
			return

		if(removing && M.getToxLoss())
			user << "<span class='notice'>You purge some of the toxins infusing \the [target]...</span>"
			if(M.getToxLoss() >= removing)
				M.adjustToxLoss(-removing)
			else
				M.adjustToxLoss(-(M.getToxLoss()))
			return

		user << "<span class='warning'>You can find no genetic, radiation or toxin damage to heal within \the [target].</span>"
		return TRUE
	return FALSE

/datum/psychic_power/revive
	name = "Revive"
	description = "Back from the gates of death."
	target_melee = 1
	target_mob_only = 1
	time_cost = 150
	melee_power_cost = 25

/datum/psychic_power/revive/do_proximity(var/mob/living/user, var/atom/target)
	if(do_redactive_living_check(user, target))
		var/mob/living/M = target
		if(M.stat != DEAD && !(M.status_flags & FAKEDEATH))
			user << "<span class='warning'>\The [target] is still alive!</span>"
			return

		if((world.time - M.timeofdeath) > 6000)
			user << "<span class='warning'>\The [target] has been dead for too long to revive.</span>"
			return

		if(..())
			user.visible_message("<span class='notice'><i>\The [user] splays out their hands over \the [target]'s body...</i></span>")
			if(!do_after(user, 30, target, 0, 1))
				user.backblast(rand(10,25))
				return

			for(var/mob/observer/G in dead_mob_list_)
				if(G.mind && G.mind.current == target && G.client)
					G << "<span class='notice'>Your body has been revived, <b>Re-Enter Corpse</b> to return to it.</span>"
					break

			M << "<span class='notice'>Life floods back into your body!</span>"
			M.visible_message("<span class='notice'>\The [target] shudders violently!</span>")
			if(M.status_flags & FAKEDEATH)
				M.changeling_revive()
			else
				M.adjustOxyLoss(-rand(15,20))
				M.basic_revival()
			return TRUE
	return FALSE
