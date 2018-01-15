/datum/game_mode/convergence
	name = "Convergence"
	round_description = "A massive disturbance in the dark continua is leaking into the Real."
	extended_round_description = "Points of weakness and potential in the structure of spacetime will \
		form in the wake of disruptions outside of reality. Cultists and true believers will flock to \
		these points, to use them in the service of their strange gods. The crew must prevent this."
	config_tag = "convergence"
	required_players = 1
	required_enemies = 1
	end_on_antag_death = 1
	antag_tags = list(MODE_PRESENCE, MODE_GODTOUCHED)
	require_all_templates = 1
	var/next_locus = 6000

/datum/game_mode/convergence/process()
	if(world.time >= next_locus)
		try_spawn_locus()
		next_locus = world.time + 3000
