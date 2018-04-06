// Rune of deafness.
/datum/presence_power/rune/aoe/deafen
	name = "Rune of Silence"
	description = "A rune that deafens all non-believers in a small area."
	children = list(/datum/presence_power/rune/aoe/blind, /datum/presence_power/rune/aoe/stun, /datum/presence_power/rune/emp)

/datum/presence_power/rune/aoe/deafen/apply_effect(var/atom/target)
	var/mob/living/carbon/C = target
	C.ear_deaf += 50
	to_chat(C, "<span class='danger'>The world around you suddenly becomes quiet.</span>")

/datum/presence_power/rune/aoe/deafen/on_success(var/mob/invoker, var/atom/target, var/list/affected, var/mob/living/presence/patron)
	..()
	target.visible_message("<span class='danger'>Sound fades to a deadened hush as the rune dissipates into fine dust.</span>")
