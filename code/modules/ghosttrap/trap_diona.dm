// Doona pods and walking mushrooms.
/datum/ghosttrap/plant
	object = "living plant"
	ban_checks = list("Dionaea")
	minutes_since_death = 5
	pref_check = BE_PLANT
	ghost_trap_message = "They are occupying a living plant now."
	ghost_trap_role = "Plant"

/datum/ghosttrap/plant/welcome_candidate(var/mob/target)
	target << "<span class='alium'><B>You awaken slowly, stirring into sluggish motion as the air caresses you.</B></span>"
	// This is a hack, replace with some kind of species blurb proc.
	if(istype(target,/mob/living/carbon/alien/diona))
		target << "<B>You are \a [target], one of a race of drifting interstellar plantlike creatures that sometimes share their seeds with human traders.</B>"
		target << "<B>Too much darkness will send you into shock and starve you, but light will help you heal.</B>"