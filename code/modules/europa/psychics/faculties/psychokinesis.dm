/decl/psychic_faculty/psychokinesis
	name = PSYCHIC_PSYCHOKINESIS
	colour = "#ff9900"
	powers = list(
		/datum/psychic_power/latent,
		/datum/psychic_power/rend,
		/datum/psychic_power/tinker,
		/datum/psychic_power/telekinesis,
		/datum/psychic_power/sunder
		)

/datum/psychic_power/rend
	name = "Rend"
	description = "Your bare hands, cloaked in power, are enough to tear through metal."
	target_self = 1
	item_path = /obj/item/psychic_power/kinesis/lesser

/datum/psychic_power/tinker
	name = "Tinker"
	description = "You no longer require tools to modify or alter machinery."
	target_melee = 1
	item_path = /obj/item/psychic_power/kinesis/tinker

/datum/psychic_power/telekinesis
	name = "Telekinesis"
	description = "Manipulate objects at a distance."
	passive = 1
	passive_cost = 3

/datum/psychic_power/telekinesis/tick(var/mob/living/user)
	. = ..()
	user.mutations |= TK

/datum/psychic_power/telekinesis/cancelled(var/mob/living/user, var/obj/item/psychic_power/caller)
	. = ..()
	user.mutations -= TK

/datum/psychic_power/sunder
	name = "Sunder"
	description = "Rip through walls and doors like butter."
	item_path = /obj/item/psychic_power/kinesis/paramount
