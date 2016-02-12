
/obj/item/weapon/reagent_containers/glass/bottle/robot
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,25,30,50,100)
	flags = OPENCONTAINER
	volume = 60
	var/reagent = ""


/obj/item/weapon/reagent_containers/glass/bottle/robot/adrenaline
	name = "internal adrenaline bottle"
	desc = "A small bottle. Contains adrenaline - used to stabilize patients."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-4"
	reagent = REAGENT_ID_ADRENALINE

	New()
		..()
		reagents.add_reagent(REAGENT_ID_ADRENALINE, 60)
		update_icon()


/obj/item/weapon/reagent_containers/glass/bottle/robot/antitoxin
	name = "internal anti-toxin bottle"
	desc = "A small bottle of Anti-toxins. Counters poisons, and repairs damage, a wonder drug."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-4"
	reagent = REAGENT_ID_ANTITOX

	New()
		..()
		reagents.add_reagent(REAGENT_ID_ANTITOX, 60)
		update_icon()

