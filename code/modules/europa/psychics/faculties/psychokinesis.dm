/decl/psychic_faculty/psychokinesis
	name = PSYCHIC_PSYCHOKINESIS
	colour = "#ff9900"
	powers = list(
		/decl/psychic_power/latent,
		/decl/psychic_power/rend,
		/decl/psychic_power/tinker,
		/decl/psychic_power/telekinesis,
		/decl/psychic_power/sunder
		)

/decl/psychic_power/rend
	name = "Rend"
	description = "Your bare hands, cloaked in power, are enough to tear through metal."
	target_self = 1
	item_path = /obj/item/psychic_power/kinesis/lesser

/decl/psychic_power/tinker
	name = "Tinker"
	description = "You no longer require tools to modify or alter machinery."
	target_melee = 1
	item_path = /obj/item/psychic_power/kinesis/tinker

/decl/psychic_power/telekinesis
	name = "Telekinesis"
	description = "Manipulate objects at a distance."
	passive = 1
	passive_cost = 3

/decl/psychic_power/telekinesis/tick(var/mob/living/user)
	. = ..()
	user.mutations |= TK

/decl/psychic_power/telekinesis/cancelled(var/mob/living/user, var/obj/item/psychic_power/caller)
	. = ..()
	user.mutations -= TK

/decl/psychic_power/sunder
	name = "Sunder"
	description = "Rip through walls and doors like butter."
	item_path = /obj/item/psychic_power/kinesis/paramount
