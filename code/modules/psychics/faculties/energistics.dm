/decl/psipower/energistics
	faculty = PSI_ENERGISTICS

/decl/psipower/energistics/disrupt
	name =            "Disrupt"
	cost =            10
	cooldown =        100
	use_melee =       TRUE
	min_rank =        PSI_RANK_MASTER
	use_description = "Target the head, eyes or mouth while on harm intent to use a melee attack that causes a localized electromagnetic pulse."

/decl/psipower/energistics/disrupt/invoke(var/mob/living/user, var/mob/living/target)
	if(user.zone_sel.selecting != BP_HEAD && user.zone_sel.selecting != BP_EYES && user.zone_sel.selecting != BP_MOUTH)
		return FALSE
	if(istype(target, /turf))
		return FALSE
	. = ..()
	if(.)
		user.visible_message("<span class='danger'>\The [user] releases a gout of crackling static and arcing lightning over \the [target]!</span>")
		target.emp_act(pick( prob(1);1, prob(5);2, prob(8);3 ))
		return TRUE

/decl/psipower/energistics/electrocute
	name =            "Electrocute"
	cost =            15
	cooldown =        25
	use_melee =       TRUE
	min_rank =        PSI_RANK_GRANDMASTER
	use_description = "Target the chest or groin while on harm intent to use a melee attack that electrocutes a victim."

/decl/psipower/energistics/electrocute/invoke(var/mob/living/user, var/mob/living/target)
	if(user.zone_sel.selecting != BP_CHEST && user.zone_sel.selecting != BP_GROIN)
		return FALSE
	if(istype(target, /turf))
		return FALSE
	. = ..()
	if(.)
		user.visible_message("<span class='danger'>\The [user] sends a jolt of electricity arcing into \the [target]!</span>")
		if(istype(target))
			target.electrocute_act(rand(15,45), user, 1, user.zone_sel.selecting)
			return TRUE
		var/obj/item/cell/charging_cell = target
		if(istype(charging_cell, /obj/machinery/power/apc))
			var/obj/machinery/power/apc/apc = charging_cell
			charging_cell = apc.cell
		else if(istype(charging_cell, /mob/living/silicon/robot))
			var/mob/living/silicon/robot/robot = charging_cell
			charging_cell = robot.cell
		if(istype(charging_cell))
			charging_cell.give(rand(15,45))
		return TRUE

/decl/psipower/energistics/zorch
	name =             "Zorch"
	cost =             20
	cooldown =         20
	use_ranged =       TRUE
	min_rank =         PSI_RANK_MASTER
	use_description = "Use this ranged laser attack while on harm intent. Your mastery of Energistics will determine how powerful the laser is. Be wary of overuse, and try not to fry your own brain."

/decl/psipower/energistics/zorch/invoke(var/mob/living/user, var/mob/living/target)
	. = ..()
	if(.)
		user.visible_message("<span class='danger'>\The [user]'s eyes flare with light!</span>")

		var/user_rank = user.psi.get_rank(faculty)
		var/obj/item/projectile/pew

		switch(user_rank)
			if(PSI_RANK_PARAMOUNT)
				pew = new /obj/item/projectile/beam/heavylaser(get_turf(user))
				pew.name = "gigawatt mental laser"
			if(PSI_RANK_GRANDMASTER)
				pew = new /obj/item/projectile/beam/midlaser(get_turf(user))
				pew.name = "megawatt mental laser"
			if(PSI_RANK_MASTER)
				pew = new /obj/item/projectile/beam/stun(get_turf(user))
				pew.name = "mental laser"

		if(istype(pew))
			playsound(pew.loc, pew.fire_sound, 25, 1)
			pew.original = target
			pew.current = target
			pew.starting = get_turf(user)
			pew.shot_from = user
			pew.yo = target.y - user.y
			pew.xo = target.x - user.x
			pew.launch(target)
			return TRUE

/decl/psipower/energistics/spark
	name =            "Spark"
	cost =            1
	cooldown =        1
	use_melee =       TRUE
	min_rank =        PSI_RANK_OPERANT
	use_description = "Target a non-living target in melee range to cause some sparks to appear. Very pretty."

/decl/psipower/energistics/spark/invoke(var/mob/living/user, var/mob/living/target)
	if(isnull(target) || istype(target)) return FALSE
	. = ..()
	if(.)
		var/datum/effect/system/spark_spread/sparks = new /datum/effect/system/spark_spread()
		sparks.set_up(3, 0, get_turf(target))
		sparks.start()
		return TRUE
