/datum/presence_power/rune/aoe/obscure_runes
	name = "Rune of Concealment"
	description = "A rune that conceals runes in an area around itself."
	target_atom_type = /obj/effect/decal/cleanable/sigil
	children = list(/datum/presence_power/rune/aoe/reveal_runes)

/datum/presence_power/rune/aoe/obscure_runes/apply_effect(var/atom/target)
	target.invisibility = INVISIBILITY_OBSERVER
	target.alpha = 100

/datum/presence_power/rune/aoe/obscure_runes/on_success(var/mob/invoker, var/atom/target, var/list/affected, var/mob/living/presence/patron)
	..()
	target.visible_message("<span class='danger'>The rune crumbles to dust, obscuring the surrounding sigil[LAZYLEN(affected) == 1 ? "" : "s"]</span>")
