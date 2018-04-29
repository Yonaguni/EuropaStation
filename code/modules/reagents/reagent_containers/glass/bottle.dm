//Not to be confused with /obj/item/reagent_containers/food/drinks/bottle
/obj/item/reagent_containers/glass/bottle/ammonia
	name = "ammonia bottle"
	desc = "A small bottle."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-1"

	New()
		..()
		reagents.add_reagent(REAGENT_AMMONIA, 60)
		update_icon()

/obj/item/reagent_containers/glass/bottle/pacid
	name = "Polytrinic Acid Bottle"
	desc = "A small bottle. Contains a small amount of Polytrinic Acid."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-4"
	New()
		..()
		reagents.add_reagent(REAGENT_POLYACID, 60)
		update_icon()

/obj/item/reagent_containers/glass/bottle/capsaicin
	name = "Capsaicin Bottle"
	desc = "A small bottle. Contains hot sauce."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-4"
	New()
		..()
		reagents.add_reagent(REAGENT_CAPSAICIN, 60)
		update_icon()

/obj/item/reagent_containers/glass/bottle/frostoil
	name = "Frost Oil Bottle"
	desc = "A small bottle. Contains cold sauce."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-4"
	New()
		..()
		reagents.add_reagent(REAGENT_FROSTOIL, 60)
		update_icon()
