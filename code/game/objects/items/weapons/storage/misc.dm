/obj/item/storage/pill_bottle/dice	//7d6
	name = "bag of dice"
	desc = "It's a small bag with dice inside."
	icon = 'icons/obj/dice.dmi'
	icon_state = "dicebag"

/obj/item/storage/pill_bottle/dice/New()
	..()
	for(var/i = 1 to 7)
		new /obj/item/dice( src )

/obj/item/storage/pill_bottle/dice_nerd	//DnD dice
	name = "bag of gaming dice"
	desc = "It's a small bag with gaming dice inside."
	icon = 'icons/obj/dice.dmi'
	icon_state = "magicdicebag"

/obj/item/storage/pill_bottle/dice_nerd/New()
	..()
	new /obj/item/dice/d4( src )
	new /obj/item/dice( src )
	new /obj/item/dice/d8( src )
	new /obj/item/dice/d10( src )
	new /obj/item/dice/d12( src )
	new /obj/item/dice/d20( src )
	new /obj/item/dice/d100( src )

/*
 * Donut Box
 */

/obj/item/storage/box/donut
	icon = 'icons/obj/food.dmi'
	icon_state = "donutbox"
	name = "donut box"
	can_hold = list(/obj/item/reagent_containers/food/snacks/donut)
	foldable = /obj/item/stack/material/cardboard

	startswith = list(/obj/item/reagent_containers/food/snacks/donut/normal = 6)

/obj/item/storage/box/donut/update_icon()
	overlays.Cut()
	var/i = 0
	for(var/obj/item/reagent_containers/food/snacks/donut/D in contents)
		overlays += image('icons/obj/food.dmi', "[i][D.overlay_state]")
		i++

/obj/item/storage/box/donut/empty
	startswith = null
