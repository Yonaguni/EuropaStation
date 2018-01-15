/datum/presence_power/rune/aoe/reveal_runes
	name = "Rune of Revelation"
	description = "A rune that reveals previously concealed runes in an area around itself."
	target_atom_type = /obj/effect/decal/cleanable/sigil

/datum/presence_power/rune/aoe/reveal_runes/apply_effect(var/atom/target)
	target.invisibility = initial(target.invisibility)
	target.alpha = initial(target.alpha)

/datum/presence_power/rune/aoe/reveal_runes/on_success(var/mob/invoker, var/atom/target, var/list/affected, var/mob/living/presence/patron)
	..()
	target.visible_message("<span class='danger'>The rune crumbles to dust, reveaing the surrounding sigil[LAZYLEN(affected) == 1 ? "" : "s"].</span>")
