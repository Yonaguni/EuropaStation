/datum/presence_power/rune/aoe/blind
	name = "Rune of the Shroud"
	description = "A rune that blinds all non-believers in a small area."

/datum/presence_power/rune/aoe/blind/apply_effect(var/atom/target)
	var/mob/living/carbon/C = target
	C.flash_eyes()
	C.eye_blurry += 50
	C.eye_blind += 20
	to_chat(C, "<span class='warning'>You are blinded by a devouring flash of light!</span>")

/datum/presence_power/rune/aoe/blind/on_success(var/mob/invoker, var/atom/target, var/list/affected, var/mob/living/presence/patron)
	..()
	target.visible_message("<span class='danger'>The rune flashes brilliantly, then dissipates into fine dust.</span>")
