/obj/item/weapon/storage/pill_bottle/dice
	name = "pack of dice"
	desc = "It's a small container with dice inside."

	New()
		..()
		new /obj/item/weapon/dice( src )
		new /obj/item/weapon/dice/d20( src )

/*
 * Donut Box
 */

/obj/item/weapon/storage/box/donut
	icon = 'icons/obj/kitchen/packaging/donuts.dmi'
	icon_state = "donutbox"
	name = "donut box"
	var/startswith = 6
	can_hold = list()
	foldable = /obj/item/stack/material/cardboard
