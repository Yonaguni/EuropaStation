/datum/presence_power/manifest/altar/totem
	name = "Raise Totem"
	description = "Imbue power into a follower-sanctified shrine to raise a totem, through which you may speak to your believers."
	children = null

/datum/presence_power/manifest/altar/totem/get_structure_path(var/mob/living/presence/patron)
	return patron.presence.totem_path
