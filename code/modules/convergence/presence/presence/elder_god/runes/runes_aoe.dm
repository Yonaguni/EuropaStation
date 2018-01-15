/datum/presence_power/rune/aoe
	var/target_atom_type = /mob/living/carbon
	var/effect_range = 7

/datum/presence_power/rune/aoe/invoke(var/mob/invoker, var/mob/living/presence/patron, var/atom/target)

	. = ..()
	if(!.)
		return FALSE

	var/list/affected = list()
	for(var/thing in get_targets())
		if(!is_valid_target(thing, patron))
			continue
		apply_effect(thing)
		affected += thing
	if(affected.len)
		on_success(invoker, target, affected, patron)
		return TRUE

/datum/presence_power/rune/aoe/proc/is_valid_target(var/atom/target, var/mob/living/presence/patron)
	return (istype(target, target_atom_type) && !patron.believers[target])

/datum/presence_power/rune/aoe/proc/get_targets(var/atom/target)
	return viewers(effect_range, target)

/datum/presence_power/rune/aoe/proc/apply_effect(var/atom/target)
	return

/datum/presence_power/rune/aoe/proc/on_success(var/mob/invoker, var/atom/target, var/list/affected, var/mob/living/presence/patron)
	admin_attacker_log_many_victims(invoker, affected, "Used a [name].", "Was victim of a [name].", "used a [name]")
