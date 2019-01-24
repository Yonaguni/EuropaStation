/obj/item/weapon/storage/pill_bottle/dice	//7d6
	name = "bag of dice"
	desc = "It's a small bag with dice inside."
	icon = 'icons/obj/dice.dmi'
	icon_state = "dicebag"

/obj/item/weapon/storage/pill_bottle/dice/New()
	..()
	for(var/i = 1 to 7)
		new /obj/item/weapon/dice( src )

/obj/item/weapon/storage/pill_bottle/dice_nerd	//DnD dice
	name = "bag of gaming dice"
	desc = "It's a small bag with gaming dice inside."
	icon = 'icons/obj/dice.dmi'
	icon_state = "magicdicebag"

/obj/item/weapon/storage/pill_bottle/dice_nerd/New()
	..()
	new /obj/item/weapon/dice/d4( src )
	new /obj/item/weapon/dice( src )
	new /obj/item/weapon/dice/d8( src )
	new /obj/item/weapon/dice/d10( src )
	new /obj/item/weapon/dice/d12( src )
	new /obj/item/weapon/dice/d20( src )
	new /obj/item/weapon/dice/d100( src )


/obj/item/weapon/storage/box/donut
	icon = 'icons/obj/food.dmi'
	icon_state = "donutbox"
	name = "donut box"
	can_hold = list(/obj/item/weapon/reagent_containers/food/snacks/donut)
	foldable = /obj/item/stack/material/cardboard

	startswith = list(/obj/item/weapon/reagent_containers/food/snacks/donut/normal = 6)

/obj/item/weapon/storage/box/donut/on_update_icon()
	overlays.Cut()
	var/i = 0
	for(var/obj/item/weapon/reagent_containers/food/snacks/donut/D in contents)
		overlays += image('icons/obj/food.dmi', "[i][D.overlay_state]")
		i++

/obj/item/weapon/storage/box/donut/empty
	startswith = null

//misc tobacco nonsense
/obj/item/weapon/storage/cigpaper
	name = "cigarette paper"
	desc = "A ubiquitous brand of cigarette paper, allegedly endorsed by 24th century war hero General Eric Osmundsun for rolling your own cigarettes. Osmundsun died in a freak kayak accident. As it ate him alive during his last campaign. It was pretty freaky."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "cigpaperbook"
	item_state = "cigpacket"
	w_class = ITEM_SIZE_SMALL
	max_w_class = ITEM_SIZE_TINY
	max_storage_space = 10
	throwforce = 2
	slot_flags = SLOT_BELT
	startswith = list(/obj/item/paper/cig = 10)

/obj/item/weapon/storage/cigpaper/filters
	name = "box of cigarette filters"
	desc = "A box of generic cigarette filters for those who rolls their own but prefers others to inhale the fumes. Not endorsed by Late General Osmundsun."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "filterbin"
	startswith = list(/obj/item/paper/cig/filter = 10)

/obj/item/weapon/storage/chewables/candy/gum
	name = "pack of gum"
	desc = "A mixed pack of delicious fruit flavored bubble-gums!"
	icon_state = "gumpack"
	max_storage_space = 8
	startswith = list(/obj/item/clothing/mask/chewable/candy/gum = 8)
	make_exact_fit()

/obj/item/weapon/storage/chewables/candy/medicallollis
	name = "pack of medicinal lolipops"
	desc = "A mixed pack of medicinal flavored lollipops. These have no business being on store shelves."
	icon_state = "lollipack"
	max_storage_space = 20
	startswith = list(/obj/item/clothing/mask/chewable/candy/lolli/meds = 20)
	make_exact_fit()