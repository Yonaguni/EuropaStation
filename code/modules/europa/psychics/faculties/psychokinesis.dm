/decl/psychic_faculty/psychokinesis
	name = PSYCHIC_PSYCHOKINESIS
	colour = "#ff9900"
	powers = list(
		/decl/psychic_power/latent,
		/decl/psychic_power/warp,
		/decl/psychic_power/tinker,
		/decl/psychic_power/telekinesis,
		/decl/psychic_power/rend
		)

/decl/psychic_power/warp
	name = "Warp"
	description = "Wrap your hands in a cloak of psychokinetic energy to enhance unarmed damage and handcuff escaping."
	target_self = 1

/decl/psychic_power/tinker
	name = "Tinker"
	description = "You no longer require tools to modify or alter machinery."
	target_melee = 1

/decl/psychic_power/telekinesis
	name = "Telekinesis"
	description = "Manipulate objects at a distance."
	target_ranged = 1

/decl/psychic_power/rend
	name = "Rend"
	description = "Rip through walls and doors like butter."
	target_melee = 1
