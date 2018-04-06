/datum/presence_power/rune/aoe/stun
	name = "Rune of Glory"
	description = "A rune that stuns all non-believers in a small area with a vision of divinity."
	target_atom_type = /mob/living

/datum/presence_power/rune/aoe/stun/apply_effect(var/atom/target)
	var/mob/living/C = target
	C.flash_eyes()
	C.silent += 15
	C.Weaken(5)
	C.Stun(3)
	to_chat(C, "<span class='danger'>You are stunned by a burst of unholy light!</span>")

/datum/presence_power/rune/aoe/stun/on_success(var/mob/invoker, var/atom/target, var/list/affected, var/mob/living/presence/patron)
	..()
	target.visible_message("<span class='danger'>The rune flares brightly before crumbling to dust.</span>")
