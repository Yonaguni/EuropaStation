/obj/item/pack/spaceball
	name = "\improper Spaceball booster pack"
	desc = "Officially licensed to take your money."
	icon_state = "card_pack_spaceball"

/obj/item/pack/spaceball/New()
	var/datum/playingcard/P
	var/i
	for(i=0;i<5;i++)
		P = new()
		if(prob(1))
			P.name = "Spaceball Jones, [game_year] Brickburn Galaxy Trekers"
			P.desc = "An autographed Spaceball Jones card!"
			P.card_icon = "spaceball_jones"
		else
			var/language_type = pick(/datum/language/common,/datum/language/cephlapoda,/datum/language/corvid)
			var/datum/language/L = new language_type()
			var/team = pick("Jupiter Slingshots", "Ganymede Slammers", "Sol Trekkers","Mars Rovers","Terran Terrors")
			P.name = "[L.get_random_name(pick(MALE,FEMALE))], [game_year - rand(0,50)] [team]"
			P.card_icon = "spaceball_standard"
			P.desc = "A Spaceball playing card."
		P.back_icon = "card_back_spaceball"

		cards += P