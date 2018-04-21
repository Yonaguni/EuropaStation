/decl/psipower/redaction
	faculty = PSI_REDACTION
	admin_log = FALSE

/decl/psipower/redaction/proc/check_dead(var/mob/living/target)
	if(!istype(target))
		return FALSE
	if(target.stat == DEAD || (target.status_flags & FAKEDEATH))
		return TRUE
	return FALSE

/decl/psipower/redaction/invoke(var/mob/living/user, var/mob/living/target)
	if(check_dead(target))
		return FALSE
	. = ..()

/decl/psipower/redaction/skinsight
	name =            "Skinsight"
	cost =            3
	cooldown =        30
	use_grab =        TRUE
	min_rank =        PSI_RANK_OPERANT
	use_description = "Grab a patient, target the chest, then switch to help intent and use the grab on them to perform a check for wounds and damage."

/decl/psipower/redaction/skinsight/invoke(var/mob/living/user, var/mob/living/target)
	if(user.zone_sel.selecting != BP_CHEST)
		return FALSE
	. = ..()
	if(.)
		health_scan_mob(target, user, "\The [user] rests a hand on \the [target].", ignore_clumsiness = TRUE)
		return TRUE

/decl/psipower/redaction/mend
	name =            "Mend"
	cost =            7
	cooldown =        50
	use_melee =       TRUE
	min_rank =        PSI_RANK_MASTER
	use_description = "Target a patient while on help intent at melee range to mend internal bleeding and broken bones."

/decl/psipower/redaction/mend/invoke(var/mob/living/user, var/mob/living/carbon/human/target)
	if(!istype(user) || !istype(target))
		return FALSE
	. = ..()
	if(.)
		var/obj/item/organ/external/E = target.get_organ(user.zone_sel.selecting)

		if(!E || E.is_stump())
			to_chat(user, "<span class='warning'>They are missing that limb.</span>")
			return TRUE

		if(E.robotic >= ORGAN_ROBOT)
			to_chat(user, "<span class='warning'>That limb is prosthetic.</span>")
			return TRUE

		user.visible_message("<span class='notice'><i>\The [user] rests a hand on \the [target]'s [E.name]...</i></span>")
		to_chat(target, "<span class='notice'>A healing warmth suffuses you.</span>")

		for(var/datum/wound/W in E.wounds)
			if(W.internal)
				to_chat(user, "<span class='notice'>You painstakingly mend the torn veins in \the [E], stemming the internal bleeding.</span>")
				E.wounds -= W
				E.update_damages()
				return TRUE
			if(W.bleeding() && W.wound_damage() <= W.bleed_threshold)
				to_chat(user, "<span class='notice'>You knit together severed veins and broken flesh, stemming the bleeding.</span>")
				W.bleed_timer = 0
				E.status &= ~ORGAN_BLEEDING
				return TRUE

		if(E.status & ORGAN_BROKEN)
			to_chat(user, "<span class='notice'>You coax shattered bones to come together and fuse, mending the break.</span>")
			E.status &= ~ORGAN_BROKEN
			E.stage = 0
			return TRUE

		for(var/obj/item/organ/internal/I in E.internal_organs)
			if(I.robotic < ORGAN_ROBOT && I.damage > 0)
				to_chat(user, "<span class='notice'>You encourage the damaged tissue of \the [I] to repair itself.</span>")
				I.damage = max(0, I.damage - rand(3,5))
				return TRUE

		to_chat(user, "<span class='notice'>You can find nothing within \the [target]'s [E.name] to mend.</span>")
		return FALSE

/decl/psipower/redaction/cleanse
	name =            "Cleanse"
	cost =            9
	cooldown =        60
	use_melee =       TRUE
	min_rank =        PSI_RANK_GRANDMASTER
	use_description = "Target a patient while on help intent at melee range to cleanse radiation and genetic damage from a patient."

/decl/psipower/redaction/cleanse/invoke(var/mob/living/user, var/mob/living/carbon/human/target)
	if(!istype(user) || !istype(target))
		return FALSE
	. = ..()
	if(.)
		// No messages, as Mend procs them even if it fails to heal anything, and Cleanse is always checked after Mend.
		var/removing = rand(20,25)
		if(target.radiation)
			to_chat(user, "<span class='notice'>You repair some of the radiation-damaged tissue within \the [target]...</span>")
			if(target.radiation > removing)
				target.radiation -= removing
			else
				target.radiation = 0
			return TRUE
		if(target.getCloneLoss())
			to_chat(user, "<span class='notice'>You stitch together some of the mangled DNA within \the [target]...</span>")
			if(target.getCloneLoss() >= removing)
				target.adjustCloneLoss(-removing)
			else
				target.adjustCloneLoss(-(target.getCloneLoss()))
			return TRUE
		if(target.getToxLoss())
			to_chat(user, "<span class='notice'>You purge some of the toxins infusing \the [target]...</span>")
			if(target.getToxLoss() >= removing)
				target.adjustToxLoss(-removing)
			else
				target.adjustToxLoss(-(target.getToxLoss()))
			return TRUE
		to_chat(user, "<span class='warning'>You can find no genetic, radiation or toxin damage to heal within \the [target].</span>")
		return FALSE

/decl/psipower/revive
	name =            "Revive"
	cost =            25
	cooldown =        80
	use_grab =        TRUE
	min_rank =        PSI_RANK_PARAMOUNT
	faculty =         PSI_REDACTION
	use_description = "Obtain a grab on a dead target, target the head, then select help intent and use the grab against them to attempt to bring them back to life. The process is lengthy and failure is punished harshly."
	admin_log = FALSE

/decl/psipower/revive/invoke(var/mob/living/user, var/mob/living/target)
	if(!isliving(target) || !istype(target) || user.zone_sel.selecting != BP_HEAD)
		return FALSE
	. = ..()
	if(.)
		if(target.stat != DEAD && !(target.status_flags & FAKEDEATH))
			to_chat(user, "<span class='warning'>This person is aleady alive!</span>")
			return TRUE

		if((world.time - target.timeofdeath) > 6000)
			to_chat(user, "<span class='warning'>\The [target] has been dead for too long to revive.</span>")
			return TRUE

		user.visible_message("<span class='notice'><i>\The [user] splays out their hands over \the [target]'s body...</i></span>")
		if(!do_after(user, 30, target, 0, 1))
			user.psi.backblast(rand(10,25))
			return TRUE

		for(var/mob/observer/G in dead_mob_list_)
			if(G.mind && G.mind.current == target && G.client)
				G << "<span class='notice'>Your body has been revived, <b>Re-Enter Corpse</b> to return to it.</span>"
				break
		to_chat(target, "<span class='notice'>Life floods back into your body!</span>")
		target.visible_message("<span class='notice'>\The [target] shudders violently!</span>")
		target.adjustOxyLoss(-rand(15,20))
		target.basic_revival()
		return TRUE
