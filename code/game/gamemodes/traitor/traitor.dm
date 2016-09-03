/datum/game_mode/traitor
	name = "traitor"
	round_description = "There is a foreign agent or traitor on the ship. Do not let the traitor succeed!"
	extended_round_description = "Many competing organizations and individuals covet the resources represented by the ship. Being a \
		vessel of sizable population and considerable wealth causes it to often be the target of various attempts at robbery, fraud and \
		other malicious actions."
	config_tag = "traitor"
	required_players = 0
	required_enemies = 1
	antag_tags = list(MODE_TRAITOR)
	antag_scaling_coeff = 5
	end_on_antag_death = 0
	latejoin_antag_tags = list(MODE_TRAITOR)
