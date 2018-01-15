/decl/presence_template/eldergod
	title = "That Which Sleeps Below"
	archetype = "\improper Great Old One"
	audience = "drowned men and lost divers"
	welcome_message = "But now, the stars have aligned, and the Sleeper stirs beneath the fragile crust of the world..."
	unit_name = "soul"
	sigil_activation_failure_message = "You must bloody your athame before it may be used to activate runes."

	available_powers = list(
		/datum/presence_power/rune/athame,
		/datum/presence_power/manifest/whisper,
		/datum/presence_power/blessing/invest,
		/datum/presence_power/metaphysics/mojo/regen_1
	)

	rod_name = "ritual athame"
	rod_desc = "It's a ritual athame made of some glossy, dark substance."
	rod_icon = "athame"
	rod_path = /obj/item/convergence/rod/eldergod

	crown_name = "dark robes"
	crown_desc = "A set of heavy, saltwater-stained robes."
	crown_icon = "cultrobes"
	crown_path = /obj/item/convergence/crown/eldergod

	orb_name = "tome"
	orb_desc = "It's a water-stained, mildewed book."
	orb_icon = "culttome"
	orb_path = /obj/item/convergence/orb/eldergod