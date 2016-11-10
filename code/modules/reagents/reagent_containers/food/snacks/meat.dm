/obj/item/weapon/reagent_containers/food/snacks/meat
	name = "meat"
	desc = "A slab of meat."
	icon_state = "meat"
	health = 180
	filling_color = "#FF1C1C"
	center_of_mass = "x=16;y=14"
	var/source_mob

	New()
		..()
		reagents.add_reagent("protein", 9)
		src.bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/meat/initialize()
	..()
	if(source_mob) set_source_mob(source_mob)

/obj/item/weapon/reagent_containers/food/snacks/meat/proc/set_source_mob(var/new_source_mob)
	source_mob = new_source_mob
	if(source_mob)
		name = "[source_mob] [initial(name)]"
	else
		name = "[initial(name)]"
	return

/obj/item/weapon/reagent_containers/food/snacks/meat/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W,/obj/item/weapon/material/knife))
		new /obj/item/weapon/reagent_containers/food/snacks/rawcutlet(src)
		new /obj/item/weapon/reagent_containers/food/snacks/rawcutlet(src)
		new /obj/item/weapon/reagent_containers/food/snacks/rawcutlet(src)
		user << "You cut the meat into thin strips."
		qdel(src)
	else
		..()

/obj/item/weapon/reagent_containers/food/snacks/meat/syntiflesh
	name = "synthetic meat"
	desc = "A synthetic slab of flesh."

// Seperate definitions because some food likes to know if it's human.
// TODO: rewrite kitchen code to check a var on the meat item so we can remove
// all these sybtypes.
/obj/item/weapon/reagent_containers/food/snacks/meat/human
/obj/item/weapon/reagent_containers/food/snacks/meat/monkey
	//same as plain meat

/obj/item/weapon/reagent_containers/food/snacks/meat/corgi
	name = "Corgi meat"
	desc = "Tastes like... well, you know."


/obj/item/weapon/reagent_containers/food/snacks/meat/bearmeat
	name = "bear meat"
	desc = "A very manly slab of meat."
	icon_state = "bearmeat"
	filling_color = "#DB0000"
	center_of_mass = "x=16;y=10"

	New()
		..()
		reagents.add_reagent("protein", 12)
		reagents.add_reagent("jumpstart", 5)
		src.bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/meat/xenomeat
	name = "meat"
	desc = "A slab of green meat. Smells like acid."
	icon_state = "xenomeat"
	filling_color = "#43DE18"
	center_of_mass = "x=16;y=10"

	New()
		..()
		reagents.add_reagent("protein", 6)
		reagents.add_reagent("pacid",6)
		src.bitesize = 6
