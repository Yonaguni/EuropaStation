/datum/ai_mob/animal/herd/chicken
	name = "chicken"

/datum/ai_mob/animal/herd/deer
	name = "deer"

/datum/ai_mob/animal/hostile/goat
	name = "goat"
	speak = list("EHEHEHEHEH","Eh?")
	idle_emotes = list("shakes its head", "stamps a foot", "glares around")
	speak_chance = 1
	panicked = -1 // Goats are fearless.
	prey_types = list()

/datum/ai_mob/animal/hostile/goat/handle_target()
	if(kill_target && enraged && prob(1))
		attached.visible_message("<span class='notice'>\The [attached] calms down.</span>")
		set_kill_target()
		enraged = 0
		prey_types = initial(prey_types)
	else if(!kill_target && !enraged && prob(1))
		prey_types = list(/mob/living)
		enraged = 1
		attached.visible_message("<span class='warning'>\The [attached] gets an evil-looking gleam in their eye.</span>")
	. = ..()
