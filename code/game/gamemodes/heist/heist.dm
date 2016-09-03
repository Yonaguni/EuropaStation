/*
HEIST ROUNDTYPE
*/

/datum/game_mode/heist
	name = "Heist"
	config_tag = "heist"
	required_players = 15
	required_enemies = 4
	round_description = "An unidentified bluespace signature has slipped past the perimeter defences and is approaching the ship!"
	extended_round_description = "Many competing organizations and individuals covet the resources represented by the ship. Being a \
		vessel of sizable population and considerable wealth causes it to often be the target of various attempts at robbery, fraud and \
		other malicious actions."
	end_on_antag_death = 1
	antag_tags = list(MODE_RAIDER)

/datum/game_mode/heist/check_finished()
	var/datum/shuttle/multi_shuttle/skipjack = shuttle_controller.shuttles["Skipjack"]
	if (skipjack && skipjack.returned_home)
		return 1
	return ..()
