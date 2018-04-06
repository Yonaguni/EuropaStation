/datum/presence_power/rune/aoe/bloodboil
	name = "Rune of Boiling Purity"
	description = "A rune that boils the very blood of all non-believers in a small area. Requires three or more believers around the rune."
	var/list/cultists = list()

/datum/presence_power/rune/aoe/bloodboil/invoke(var/mob/invoker, var/mob/living/presence/patron, var/atom/target)
	cultists.Cut()
	for(var/mob/living/carbon/C in orange(1,target))
		if(patron.believers[C] && C.stat == CONSCIOUS)
			cultists += C
	if(cultists.len < 3)
		to_chat(invoker, "<span class='warning'>There are not enough participants around the rune to complete the rite.</span>")
		return FALSE
	. = ..()

/datum/presence_power/rune/aoe/bloodboil/is_valid_target(var/atom/target, var/mob/living/presence/patron)
	. = ..()
	if(.)
		var/mob/living/carbon/C = target
		if(!C.should_have_organ(BP_HEART))
			return FALSE

/datum/presence_power/rune/aoe/bloodboil/apply_effect(var/atom/target)
	var/mob/living/carbon/C = target
	C.take_overall_damage(51,51)
	if(prob(5))
		spawn(5)
			C.gib()
	to_chat(C, "<span class='danger'>Your very blood boils within your veins!</span>")

/datum/presence_power/rune/aoe/bloodboil/on_success(var/mob/invoker, var/atom/target, var/list/affected, var/mob/living/presence/patron)
	..()
	for(var/obj/effect/decal/cleanable/sigil/rune in view(target))
		if(prob(10))
			explosion(get_turf(rune), -1, 0, 1, 5)

	for(var/thing in cultists)
		var/mob/living/carbon/C = thing
		if(C.stat == CONSCIOUS)
			to_chat(C, "<span class='danger'>Your flesh twists in esctatic agony as your dread master's will is made real!</span>")
			C.take_overall_damage(15, 0)
	target.visible_message("<span class='danger'>The rune screams, shuddering like a living thing, then fades to dust.</span>")
