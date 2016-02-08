
//Not to be confused with /obj/item/weapon/reagent_containers/food/drinks/bottle

/obj/item/weapon/reagent_containers/glass/bottle
	name = "bottle"
	desc = "A small bottle."
	icon = 'icons/obj/chemical.dmi'
	icon_state = null
	item_state = "atoxinbottle"
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,25,30,60)
	flags = 0
	volume = 60

	on_reagent_change()
		update_icon()

	pickup(mob/user)
		..()
		update_icon()

	dropped(mob/user)
		..()
		update_icon()

	attack_hand()
		..()
		update_icon()

	New()
		..()
		if(!icon_state)
			icon_state = "bottle-[rand(1,4)]"

	update_icon()
		overlays.Cut()

		if(reagents.total_volume && (icon_state == "bottle-1" || icon_state == "bottle-2" || icon_state == "bottle-3" || icon_state == "bottle-4"))
			var/image/filling = image('icons/obj/reagentfillings.dmi', src, "[icon_state]10")

			var/percent = round((reagents.total_volume / volume) * 100)
			switch(percent)
				if(0 to 9)		filling.icon_state = "[icon_state]--10"
				if(10 to 24) 	filling.icon_state = "[icon_state]-10"
				if(25 to 49)	filling.icon_state = "[icon_state]-25"
				if(50 to 74)	filling.icon_state = "[icon_state]-50"
				if(75 to 79)	filling.icon_state = "[icon_state]-75"
				if(80 to 90)	filling.icon_state = "[icon_state]-80"
				if(91 to INFINITY)	filling.icon_state = "[icon_state]-100"

			filling.color = reagents.get_color()
			overlays += filling

		if (!is_open_container())
			var/image/lid = image(icon, src, "lid_bottle")
			overlays += lid

/obj/item/weapon/reagent_containers/glass/bottle/adrenaline
	name = "adrenaline bottle"
	desc = "A small bottle. Contains adrenaline - used to stabilize patients."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-4"

/obj/item/weapon/reagent_containers/glass/bottle/adrenaline/initialize()
	..()
	reagents.add_reagent("adrenaline", 60)
	update_icon()

/obj/item/weapon/reagent_containers/glass/bottle/toxin
	name = "toxin bottle"
	desc = "A small bottle of toxins. Do not drink, it is poisonous."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-3"

/obj/item/weapon/reagent_containers/glass/bottle/toxin/initialize()
	..()
	reagents.add_reagent("toxin", 60)
	update_icon()

/obj/item/weapon/reagent_containers/glass/bottle/cyanide
	name = "cyanide bottle"
	desc = "A small bottle of cyanide. Bitter almonds?"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-3"

/obj/item/weapon/reagent_containers/glass/bottle/cyanide/initialize()
	..()
	reagents.add_reagent("cyanide", 30) //volume changed to match chloral
	update_icon()

/obj/item/weapon/reagent_containers/glass/bottle/stoxin
	name = "soporific bottle"
	desc = "A small bottle of soporific. Just the fumes make you sleepy."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-3"

/obj/item/weapon/reagent_containers/glass/bottle/stoxin/initialize()
	..()
	reagents.add_reagent("stoxin", 60)
	update_icon()

/obj/item/weapon/reagent_containers/glass/bottle/chloralhydrate
	name = "Chloral Hydrate Bottle"
	desc = "A small bottle of Choral Hydrate. Mickey's Favorite!"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-3"

/obj/item/weapon/reagent_containers/glass/bottle/chloralhydrate/initialize()
	..()
	reagents.add_reagent("chloralhydrate", 30)		//Intentionally low since it is so strong. Still enough to knock someone out.
	update_icon()

/obj/item/weapon/reagent_containers/glass/bottle/antitoxin
	name = "antitoxin bottle"
	desc = "A small bottle of antitoxin. Counters poisons, and repairs damage. A wonder drug."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-4"

/obj/item/weapon/reagent_containers/glass/bottle/antitoxin/initialize()
	..()
	reagents.add_reagent("anti_toxin", 60)
	update_icon()

/obj/item/weapon/reagent_containers/glass/bottle/mutagen
	name = "unstable mutagen bottle"
	desc = "A small bottle of unstable mutagen. Randomly changes the DNA structure of whoever comes in contact."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-1"

/obj/item/weapon/reagent_containers/glass/bottle/mutagen/initialize()
	..()
	reagents.add_reagent("mutagen", 60)
	update_icon()

/obj/item/weapon/reagent_containers/glass/bottle/ammonia
	name = "ammonia bottle"
	desc = "A small bottle."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-1"

/obj/item/weapon/reagent_containers/glass/bottle/ammonia/initialize()
	..()
	reagents.add_reagent("ammonia", 60)
	update_icon()

/obj/item/weapon/reagent_containers/glass/bottle/diethylamine
	name = "diethylamine bottle"
	desc = "A small bottle."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-4"

/obj/item/weapon/reagent_containers/glass/bottle/diethylamine/initialize()
	..()
	reagents.add_reagent("diethylamine", 60)
	update_icon()

/obj/item/weapon/reagent_containers/glass/bottle/pacid
	name = "Polytrinic Acid Bottle"
	desc = "A small bottle. Contains a small amount of Polytrinic Acid"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-4"

/obj/item/weapon/reagent_containers/glass/bottle/pacid/initialize()
	..()
	reagents.add_reagent("pacid", 60)
	update_icon()

/obj/item/weapon/reagent_containers/glass/bottle/capsaicin
	name = "Capsaicin Bottle"
	desc = "A small bottle. Contains hot sauce."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle-4"

/obj/item/weapon/reagent_containers/glass/bottle/capsaicin/initialize()
	..()
	reagents.add_reagent("capsaicin", 60)
	update_icon()
