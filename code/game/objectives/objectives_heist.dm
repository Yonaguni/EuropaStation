
// Heist objectives.
datum/objective/heist
	proc/choose_target()
		return

datum/objective/heist/kidnap
	choose_target()
		var/list/roles = list("Chief of Engineering","Scientist","Roboticist","Civil Engineer")
		var/list/possible_targets = list()
		var/list/priority_targets = list()

		for(var/datum/mind/possible_target in ticker.minds)
			if(possible_target != owner && ishuman(possible_target.current) && (possible_target.current.stat != 2) && (!possible_target.special_role))
				possible_targets += possible_target
				for(var/role in roles)
					if(possible_target.assigned_role == role)
						priority_targets += possible_target
						continue

		if(priority_targets.len > 0)
			target = pick(priority_targets)
		else if(possible_targets.len > 0)
			target = pick(possible_targets)

		if(target && target.current)
			explanation_text = "We can get a good price for [target.current.real_name], the [target.assigned_role]. Take them alive."
		else
			explanation_text = "Free Objective"
		return target

	check_completion()
		if(target && target.current)
			if (target.current.stat == 2)
				return 0 // They're dead. Fail.
			//if (!target.current.restrained())
			//	return 0 // They're loose. Close but no cigar.

			if(get_heist_area())
				var/area/A = locate(get_heist_area())
				for(var/mob/living/carbon/human/M in A)
					if(target.current == M)
						return 1 //They're restrained on the shuttle. Success.
		else
			return 0

/datum/objective/heist/loot

	choose_target()
		var/loot = "an object"
		switch(rand(1,5))
			if(1)
				target = /obj/structure/particle_accelerator
				target_amount = 6
				loot = "a complete particle accelerator"
			if(2)
				target = /obj/machinery/the_singularitygen
				target_amount = 1
				loot = "a gravitational generator"
			if(3)
				target = /obj/machinery/power/emitter
				target_amount = 4
				loot = "four emitters"
			if(4)
				target = /obj/machinery/nuclearbomb
				target_amount = 1
				loot = "a nuclear bomb"
			if(5)
				target = /obj/item/gun
				target_amount = 6
				loot = "six guns"

		explanation_text = "It's a buyer's market out here. Steal [loot] for resale."

	check_completion()

		var/total_amount = 0

		if(get_heist_area())
			for(var/obj/O in locate(get_heist_area()))
				if(istype(O,target)) total_amount++
				for(var/obj/I in O.contents)
					if(istype(I,target)) total_amount++
				if(total_amount >= target_amount) return 1

		for(var/datum/mind/raider in raiders.current_antagonists)
			if(raider.current)
				for(var/obj/O in raider.current.get_contents())
					if(istype(O,target)) total_amount++
					if(total_amount >= target_amount) return 1

		return 0

datum/objective/heist/salvage

	choose_target()
		switch(rand(1,8))
			if(1)
				target = DEFAULT_WALL_MATERIAL
				target_amount = 300
			if(2)
				target = "glass"
				target_amount = 200
			if(3)
				target = "plasteel"
				target_amount = 100
			if(5)
				target = "silver"
				target_amount = 50
			if(6)
				target = "gold"
				target_amount = 20
			if(7)
				target = "uranium"
				target_amount = 20
			if(8)
				target = "diamond"
				target_amount = 20

		explanation_text = "Ransack [station_name()] and escape with [target_amount] [target]."

	check_completion()

		var/total_amount = 0

		if(get_heist_area())
			for(var/obj/item/O in locate(get_heist_area()))

				var/obj/item/stack/material/S
				if(istype(O,/obj/item/stack/material))
					if(O.name == target)
						S = O
						total_amount += S.get_amount()
				for(var/obj/I in O.contents)
					if(istype(I,/obj/item/stack/material))
						if(I.name == target)
							S = I
							total_amount += S.get_amount()

		for(var/datum/mind/raider in raiders.current_antagonists)
			if(raider.current)
				for(var/obj/item/O in raider.current.get_contents())
					if(istype(O,/obj/item/stack/material))
						if(O.name == target)
							var/obj/item/stack/material/S = O
							total_amount += S.get_amount()

		if(total_amount >= target_amount) return 1
		return 0


/datum/objective/heist/preserve_crew
	explanation_text = "Do not leave anyone behind, alive or dead."

	check_completion()
		if(raiders && raiders.is_raider_crew_safe()) return 1
		return 0
