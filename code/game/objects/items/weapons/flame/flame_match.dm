///////////
//MATCHES//
///////////
/obj/item/flame/match
	name = "match"
	desc = "A simple match stick, used for lighting fine smokables."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "match_unlit"
	slot_flags = SLOT_EARS
	trash = /obj/effect/decal/cleanable/burned_match

/obj/item/flame/match/update_icon()
	if(lit)
		icon_state = "match_lit"
	else
		icon_state = "match_unlit"

/obj/item/flame/match/dropped(var/mob/user)
	. = ..()
	if(lit) extinguish()

/obj/effect/decal/cleanable/burned_match
	name = "burned match"
	desc = "A match. This one has seen better days."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "match_burnt"
	item_state = "cigoff"

/obj/item/storage/box/matches
	name = "matchbox"
	desc = "A small box of 'Space-Proof' premium matches."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "matchbox"
	item_state = "zippo"
	w_class = 1
	slot_flags = SLOT_BELT
	can_hold = list(/obj/item/flame/match)
	startswith = list(/obj/item/flame/match = 10)

/obj/item/storage/box/matches/attackby(var/obj/item/flame/match/W, var/mob/user)
	if(istype(W))
		W.light()
		return
	..()