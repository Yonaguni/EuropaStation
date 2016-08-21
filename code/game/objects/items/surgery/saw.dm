/*
 * Circular Saw
 */
/obj/item/circular_saw
	name = "circular saw"
	desc = "For heavy duty cutting."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "saw3"
	hitsound = 'sound/weapons/circsawhit.ogg'
	flags = CONDUCT
	force = 15.0
	w_class = 3
	throwforce = 9.0
	throw_speed = 3
	throw_range = 5
	matter = list(DEFAULT_WALL_MATERIAL = 20000,"glass" = 10000)
	attack_verb = list("attacked", "slashed", "sawed", "cut")
	sharp = 1
	edge = 1

