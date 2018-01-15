/datum/presence_power/manifest/altar
	name = "Raise Altar"
	description = "Imbue power into a follower-sanctified shrine to raise an altar, for your believers to use in rites."
	children = list(/datum/presence_power/manifest/altar/totem)
	use_cost = 20

/datum/presence_power/manifest/altar/invoke(var/mob/invoker, var/mob/living/presence/patron, var/atom/target)
	if(!istype(target, /obj/structure/shrine))
		to_chat(invoker, "<span class='warning'>You can only use this power on an unfinished shrine.</span>")
		return FALSE

	var/obj/structure/shrine/donor = target
	if(!donor.sanctified_to || donor.sanctified_to != patron)
		to_chat(invoker, "<span class='warning'>This shrine is sanctified to the wrong master!</span>")
		return FALSE

	if(!donor.unfinished)
		to_chat(invoker, "<span class='warning'>You can only use this power on an unfinished shrine.</span>")
		return FALSE

	. = ..()

	if(.)
		var/atom/spawned = get_structure_path(patron)
		spawned = new spawned(get_turf(target), patron.presence.structure_material, patron)
		spawned.visible_message("<span class='danger'>An eye-twisting light dances around \the [target], then vanishes, leaving [spawned] in its place.</span>")
		qdel(target)
		return TRUE

/datum/presence_power/manifest/altar/proc/get_structure_path(var/mob/living/presence/patron)
	return patron.presence.altar_path
