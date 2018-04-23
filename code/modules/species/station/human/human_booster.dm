/datum/species/human/booster
	name = SPECIES_BOOSTER
	name_plural = "Boosters"
	blurb = "The self-proclaimed 'boosters' are a loosely affiliated group of bio-tinkers, \
	engineers and radical phiolosophers dedicated to expanding the definition of what it means \
	to be human. The inner system frowns on their excessive recklessness, and most booster habitats \
	are found in the outer system or beyond - some even linger in the Oort cloud itself.<br><br>The \
	shared Booster genotype is extremely unstable and liable for rapid, apparently random change, \
	but is certainly both unique and remarkable in its ability to cope with the extremes that the \
	Universe can throw at it."
	associated_faction = FACTION_OUTER_SYSTEM
	economic_modifier = 0.8
	slowdown = -1

/datum/species/human/booster/New()
	..()
	brute_mod =     rand(0.75,1.25)
	burn_mod =      rand(0.75,1.25)
	oxy_mod =       rand(0.75,1.25)
	toxins_mod =    rand(0.75,1.25)
	radiation_mod = rand(0.75,1.25)
	flash_mod =     rand(0.75,1.25)