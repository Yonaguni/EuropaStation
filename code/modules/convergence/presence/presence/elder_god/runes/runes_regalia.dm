/datum/presence_power/rune/athame
	name = "Rune of the Open Hand"
	description = "A rune that creates a ritual athame."
	header_text = "Blood Magic"
	children = list(
		/datum/presence_power/rune/tome,
		/datum/presence_power/rune/aoe/deafen,
		/datum/presence_power/rune/aoe/obscure_runes,
		/datum/presence_power/rune/freedom,
		/datum/presence_power/rune/teleport_item,
		/datum/presence_power/rune/invisible_wall
		)

/datum/presence_power/rune/athame/invoke(var/mob/invoker, var/mob/living/presence/patron, var/atom/target)
	. = ..()
	if(.)
		var/atom/spawned = new patron.presence.rod_path(get_turf(target), patron)
		target.visible_message("<span class='danger'>Shards of crimson light dart across the surface of the rune, and as it crumbles to dust they solidify into \a [spawned],</span>")
		invoker.put_in_hands(spawned)
		return TRUE

/datum/presence_power/rune/tome
	name = "Rune of the Burning Library"
	description = "A rune that creates an arcane tome."
	children = list(/datum/presence_power/rune/robes)

/datum/presence_power/rune/tome/invoke(var/mob/invoker, var/mob/living/presence/patron, var/atom/target)
	. = ..()
	if(.)
		var/atom/spawned = new patron.presence.orb_path(get_turf(target), patron)
		target.visible_message("<span class='danger'>Shards of crimson light dart across the surface of the rune, and as it crumbles to dust they solidify into \a [spawned],</span>")
		invoker.put_in_hands(spawned)
		return TRUE

/datum/presence_power/rune/robes
	name = "Rune of the Scaled Heart"
	description = "A rune that creates armoured, sanctified robes."

/datum/presence_power/rune/robes/invoke(var/mob/invoker, var/mob/living/presence/patron, var/atom/target)
	. = ..()
	if(.)
		var/atom/spawned = new patron.presence.crown_path(get_turf(target), patron)
		target.visible_message("<span class='danger'>Blood-red dust rises from the rune as it crumbles, cloaking \the [invoker] in a crimson shroud that solidifies into \a [spawned].</span>")
		invoker.equip_to_slot_if_possible(spawned, SLOT_OCLOTHING)
		return TRUE
