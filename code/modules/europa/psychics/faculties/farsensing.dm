/decl/psychic_faculty/farsense
	name = PSYCHIC_FARSENSE
	colour = "#cc3399"
	powers = list(
		/decl/psychic_power/latent,
		/decl/psychic_power/xray,
		/decl/psychic_power/lifescent,
		/decl/psychic_power/track,
		/decl/psychic_power/apotheosis
		)

/decl/psychic_power/xray
	name = "Exovision"
	description = "See through walls."
	passive = 1
	passive_cost = 3

/decl/psychic_power/xray/tick(var/mob/living/user)
	user.sight |= SEE_TURFS

/decl/psychic_power/lifescent
	name = "Lifescent"
	description = "Taste the lives around you."
	passive = 1
	passive_cost = 3

/decl/psychic_power/lifescent/tick(var/mob/living/user)
	if(user)
		user.sight |= SEE_MOBS

/decl/psychic_power/track
	name = "Track"
	description = "Remotely view a linked mind."
	target_ranged = 1
	target_mob_only = 1

/decl/psychic_power/apotheosis
	name = "Apotheosis"
	description = "Escape the boundaries of your flesh."
	target_self = 1
