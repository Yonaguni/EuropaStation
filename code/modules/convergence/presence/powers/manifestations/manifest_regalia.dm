/datum/presence_power/manifest/tome
	name = "Manifest Tome"
	description = "Tear a hole through the veil to grant a follower a new tome"
	children = list(/datum/presence_power/manifest/athame)
	use_cost = 20

/datum/presence_power/manifest/tome/invoke(var/mob/invoker, var/mob/living/presence/patron, var/atom/target)
	. = ..()
	if(.)
		var/atom/spawned = new patron.presence.orb_path(get_turf(target), patron)
		target.visible_message("<span class='danger'>A bloody, eye-twisting light flares and dances for a moment, leaving \a [spawned] in its wake.</span>")
		return TRUE

/datum/presence_power/manifest/athame
	name = "Manifest Athame"
	description = "Tear a hole through the veil to grant a follower a new athame."
	use_cost = 30

/datum/presence_power/manifest/athame/invoke(var/mob/invoker, var/mob/living/presence/patron, var/atom/target)
	. = ..()
	if(.)
		var/atom/spawned = new patron.presence.rod_path(get_turf(target), patron)
		target.visible_message("<span class='danger'>A bloody, eye-twisting light flares and dances for a moment, leaving \a [spawned] in its wake.</span>")
		return TRUE
