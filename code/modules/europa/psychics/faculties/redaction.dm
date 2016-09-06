/decl/psychic_faculty/redaction
	name = PSYCHIC_REDACTION
	colour = "#ff3300"
	powers = list(
		/decl/psychic_power/latent,
		/decl/psychic_power/skinsight,
		/decl/psychic_power/mend,
		/decl/psychic_power/cleanse,
		/decl/psychic_power/revive
		)

/decl/psychic_power/skinsight
	name = "Skinsight"
	description = "See the damage beneath."
	target_self = 1
	target_melee = 1
	target_mob_only = 1

/decl/psychic_power/mend
	name = "Mend"
	description = "Mend broken bones and ruptured organs."
	target_self = 1
	target_melee = 1
	target_mob_only = 1

/decl/psychic_power/cleanse
	name = "Cleanse"
	description = "Purge the body of toxins and radiation."
	target_self = 1
	target_melee = 1
	target_mob_only = 1

/decl/psychic_power/revive
	name = "Revive"
	description = "Back from the gates of death."
	target_melee = 1
	target_mob_only = 1
